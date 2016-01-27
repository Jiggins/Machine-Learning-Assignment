module Types.Marker where

data Rank = Rank { id :: String
                 , rank :: Int
                 } deriving (Eq, Show)
