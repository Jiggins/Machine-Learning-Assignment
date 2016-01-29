module Types.Marker where

import Data.Function

data Rank = Rank { rankId :: String
                 , rank :: Int
                 } deriving (Eq, Show)

instance Ord Rank where
  compare = compare `on` rank

data Rating = Rating { raterId :: String
                     , rateeId :: String
                     , score   :: Double
                     } deriving (Eq, Show)
