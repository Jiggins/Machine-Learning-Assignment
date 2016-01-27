{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}

module Parser.RatingsMatrixParser
  ( rankings
  , ratings
  ) where

import Types.Marker

import Text.Parsec
import Text.Parsec.Char
import Text.Parsec.String

import Text.ParserCombinators.Parsec.Number

rankings :: IO (Either ParseError [Rank])
ratings  :: IO (Either ParseError [Rating])

rankings = parseFromFile (many ranking) "data/rating-ranks"
ratings  = parseFromFile (many rating)  "data/sparse-rating-matrix"

ranking :: Parsec String st Rank
ranking = Rank
  <$> identity <* spaces
  <*> nat      <* spaces

rating :: Floating a => Parsec String st Rating
rating = Rating
  <$> identity       <* spaces
  <*> identity       <* spaces
  <*> floating2 True <* spaces

identity :: Parsec String st String
identity = many alphaNum
