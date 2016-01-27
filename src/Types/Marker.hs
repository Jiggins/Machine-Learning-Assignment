module Types.Marker where

data Rank = Rank { id :: String
                 , rank :: Int
                 } deriving (Eq, Show)

data Rating = Rating { rater :: String
                     , ratee :: String
                     , score :: Double
                     } deriving (Eq, Show)
