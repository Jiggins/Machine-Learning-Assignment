module Matrix.MatrixBuilder (buildMatrix) where 

import Types.Marker
import Types.MatrixEntry

import Data.Map.Strict (Map (..))
import qualified Data.Map.Strict as Map

buildRankMap :: [Rank] -> Map.Map String Int
buildRankMap = foldr (\(Rank id rank) -> Map.insert id rank) Map.empty

buildRatingsMap :: [Rating] -> Map String [(String, Double)]
buildRatingsMap = foldr insertRatings Map.empty
  where insertRatings (Rating rater ratee score) = Map.insertWith (++) rater [(ratee, score)]

mergeMaps :: Map String Int -> Map String [(String, Double)] -> Map String MatrixEntry
mergeMaps ranks = Map.mapWithKey (\k -> MatrixEntry k (Map.lookup k ranks))

buildMatrix :: [Rank] -> [Rating] -> Map String MatrixEntry
buildMatrix ranks = mergeMaps (buildRankMap ranks) . buildRatingsMap
