{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}

module Parser.RatingsMatrixParser
  ( rankings
  , ratings
  ) where

import System.IO

import Types.Marker

import Text.Parsec
import Text.Parsec.Char
import Text.Parsec.String

import Text.ParserCombinators.Parsec.Number

rankings = parseFromFile (many ranking) "data/rating-ranks"
ratings  = parseFromFile (many rating)  "data/sparse-rating-matrix"

ranking :: Parsec String st Rank
ranking = Rank <$> identity <* spaces <*> nat <* spaces

rating :: Floating a => Parsec String st (String, String, a)
rating = (\a b c -> (a,b,c))
  <$> identity       <* spaces
  <*> identity       <* spaces
  <*> floating2 True <* spaces

identity :: Parsec String st String
identity = many alphaNum
