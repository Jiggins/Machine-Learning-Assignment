module Main where

import Matrix.MatrixBuilder
import Parser.RatingsMatrixParser
import Types.Marker
import Types.MatrixEntry

import System.Exit

-- | Runs the parser, the program exits if a
runParse :: Show a => IO (Either a b) -> IO b
runParse parser = parser >>= \p -> case p of
  Right a -> return a
  Left a -> die (show a)

main = do
  rankings <- runParse rankings
  ratings <- runParse ratings
  print $ buildMatrix rankings ratings
