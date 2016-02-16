module Main where

import Idris.Core.TT
import Idris.AbsSyntax
import Idris.ElabDecls
import Idris.REPL

import IRTS.Compiler
import IRTS.CodegenNix

import System.Environment
import System.Exit

import Paths_idris_nix

data Opts = Opts { inputs :: [FilePath],
                   output :: FilePath }

showUsage = do putStrLn "Usage: idris-nix <ibc-files> [-o <output-file>]"
               exitSuccess

getOpts :: IO Opts
getOpts = do xs <- getArgs
             return $ process (Opts [] "a.out") xs
  where
    process opts ("-o":o:xs) = process (opts { output = o }) xs
    process opts (x:xs) = process (opts { inputs = x:inputs opts }) xs
    process opts [] = opts

cgMain :: Opts -> Idris ()
cgMain opts = do
  elabPrims
  loadInputs (inputs opts) Nothing
  mainProg <- elabMain
  ir <- compile (Via "nix") (output opts) (Just mainProg)
  runIO $ codegenNix ir

main :: IO ()
main = do opts <- getOpts
          if null (inputs opts)
             then showUsage
             else runMain (cgMain opts)


