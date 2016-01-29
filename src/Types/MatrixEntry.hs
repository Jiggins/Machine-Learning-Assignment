module Types.MatrixEntry where

data MatrixEntry = MatrixEntry { identity :: String
                               , rank     :: Maybe Int
                               , scores   :: [(String, Double)]
                               } deriving (Eq, Show)
