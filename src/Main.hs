module Main where

import Matrix.MatrixBuilder
import Parser.RatingsMatrixParser
import Types.Marker
import Types.MatrixEntry

import Nmeric.LinearAlgebra
import System.Exit

-- | Runs the parser, the program exits if a
runParse :: Show a => IO (Either a b) -> IO b
runParse parser = parser >>= \p -> case p of
  Right a -> return a
  Left a -> die (show a)

getMap = do
  rankings <- runParse rankings
  ratings  <- runParse ratings
  return $ buildMap rankings ratings

main = do
  rankings <- runParse rankings
  ratings  <- runParse ratings
  map      <- buildMap rankings ratings
  matrix   <- buildMatrix ratings map
  print $ matrix
