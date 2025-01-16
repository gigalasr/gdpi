-- let {assignments} in expression 
easy =
    let fn y = y*2
        y = 10
    in fn 2 + y

-- where

dot :: Num a => [a] -> [a] -> a
dot xs ws = foldr (\(x, w) a -> x * w + a) 0 inputs
    where
        inputs = zip xs ws

dot' :: Num a => [a] -> [a] -> a
dot' xs ws =
    let inputs = zip xs ws
    in foldr (\(x, w) a -> x * w + a) 0 inputs


-- unterschied zwischen let und where
-- let ist eine expression und überall erlaubt wo eine expression stehen darf 
-- expression ist etwas, was zu einem Wert evaluiert


-- Abstraktere Folds
-- Komplexere Datenstrukturen und Folds 
data BinTree a = Node a (BinTree a) (BinTree a)
    | Leaf a
    | Empty
    deriving (Eq, Show)


bsp1 = Node 6 (Node 3 Empty (Leaf 5)) (Node 7 Empty (Leaf 2))

foldTree :: (a -> b -> b -> b) -> (a -> b) -> b -> BinTree a -> b
foldTree fNode fLeaf fEmpty = fold
    where
        fold (Node a l r) = fNode a (fold l) (fold r)
        fold (Leaf a) = fLeaf a
        fold Empty = fEmpty


countLeaves' :: BinTree a -> Int
countLeaves' (Node _ l r) = countLeaves' l + countLeaves' r
countLeaves' (Leaf _) = 1
countLeaves' Empty = 0


countLeaves :: BinTree a -> Int
countLeaves = foldTree (\_ x y -> x + y) (const 1) 0


removeLeafs :: BinTree a -> BinTree a
removeLeafs = foldTree Node (const Empty) Empty


sumTree :: Num a => BinTree a -> a
sumTree = foldTree (\x l r -> x + l + r) id 0

leafify :: Eq a => BinTree a -> BinTree a
leafify = foldTree
    (\x l r -> case (l,r) of
        (Empty, Empty) -> Leaf x
        _ -> Node x l r) 
    Leaf
    Empty
