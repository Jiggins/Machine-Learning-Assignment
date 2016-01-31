module Matrix.MatrixBuilder (buildMap, buildMatrix) where

import Types.Marker
import Types.MatrixEntry

import Data.Map.Strict (Map (..), (!))
import qualified Data.Map.Strict as Map

import Data.Set (Set)
import qualified Data.Set as Set

import Numeric.LinearAlgebra hiding ((!))

buildMap :: [Rank] -> [Rating] -> Map String MatrixEntry
buildMap ranks = mergeMaps (buildRankMap ranks) . buildRatingsMap

buildRankMap :: [Rank] -> Map String Int
buildRankMap = foldr (\(Rank id rank) -> Map.insert id rank) Map.empty

buildRatingsMap :: [Rating] -> Map String [(String, Double)]
buildRatingsMap = foldr insertRatings Map.empty
  where insertRatings (Rating rater ratee score) = Map.insertWith (++) rater [(ratee, score)]

mergeMaps :: Map String Int -> Map String [(String, Double)] -> Map String MatrixEntry
mergeMaps ranks = Map.mapWithKey (\k -> MatrixEntry k (Map.lookup k ranks))

rateeKeyMap, raterKeyMap :: [Rating] -> Map String Int
rateeKeyMap = buildKeyMap rateeId
raterKeyMap = buildKeyMap raterId

buildKeyMap :: (Enum v, Num v, Ord k) => (a -> k) -> [a] -> Map k v
buildKeyMap f = Map.fromList . flip zip [0..] . Set.toList . keySet f
  where keySet f = foldr Set.insert Set.empty . map f

buildMatrix :: [Rating] -> Map String MatrixEntry -> Matrix Double
buildMatrix rs = assoc (height,width) 0 . assocList rs
  where height = 36
        width  = 37

assocList :: [Rating] -> Map String MatrixEntry -> [((Int, Int), Double)]
assocList ratings = concatMap (map swap . f . (\(a,b) -> (raterKeys ! a, scores b))) . Map.toList
  where rateeKeys = rateeKeyMap ratings
        raterKeys = raterKeyMap ratings
        swap (a,(b,c)) = ((a, rateeKeys ! b), c)
        f (a,b) = map (\x -> (a,x)) b
        fstMap f (a,b) = (f a, b)
