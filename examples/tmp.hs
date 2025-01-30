
komplexeFunktion x = a x
    where
        a b = 5 + b

-- let {assigment} in {expression}

komplexeFunktion' :: Num a => a -> a
komplexeFunktion' x = 5 +
    let
        a b = 5 + b
        c = 2
    in a x + c


dot :: Num a  => [a] -> [a] -> a
dot xs ys = foldr mulAndSum 0 inputs
    where
        inputs = zip xs ys
        mulAndSum (x, y) a = x * y + a


dot' :: Num a  => [a] -> [a] -> a
dot' xs ys =
    let
        inputs = zip xs ys
        mulAndSum (x, y) a = x * y + a
    in foldr mulAndSum 0 inputs





data BinTree a =
    Node a (BinTree a) (BinTree a)
    | Leaf a
    | Empty
    deriving (Show, Eq)


bsp1 :: BinTree Integer
bsp1 = Node 6 (Node 3 Empty (Leaf 5)) (Node 7 Empty (Leaf 2))



foldTree :: (a -> b -> b -> b) -> (a -> b) -> b -> BinTree a -> b
foldTree fNode fLeaf fEmpty = fold
    where
        fold (Node a l r) = fNode a (fold l) (fold r)
        fold (Leaf a) = fLeaf a
        fold Empty = fEmpty



countLeaves :: BinTree a -> Int
countLeaves (Node a l r) = countLeaves l + countLeaves r
countLeaves (Leaf a) = 1
countLeaves Empty = 0


countLeaves' :: BinTree a -> Int
countLeaves' = foldTree (\_ l r -> l + r) (const 1) 0


removeLeafs :: BinTree a -> BinTree a
removeLeafs = foldTree Node (\_ -> Empty) Empty 


sumTree :: Num a => BinTree a -> a 
sumTree = foldTree (\a l r -> l + r + a) id 0

