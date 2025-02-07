data Plant leaf flower fruit stem
    = Leaf leaf
    | Flower flower
    | Fruit fruit
    | Stem stem (Plant leaf flower fruit stem)
    | Node [Plant leaf flower fruit stem]
    deriving (Show, Eq)

data StackPlant leaf flower fruit stem
    = LEAF leaf
    | FLOWER flower
    | FRUIT fruit
    | STEM stem
    | NODE Int
    deriving (Show, Eq)

foldPlant :: (leaf -> a) -> (flower -> a) -> (fruit -> a) -> (stem -> a -> a) -> ([a] -> a) -> Plant leaf flower fruit stem -> a
foldPlant leaf flower fruit stem node = f
    where
        f (Leaf l) = leaf l
        f (Flower f) = flower f
        f (Fruit f) = fruit f
        f (Stem s p) = stem s (f p)
        f (Node ps) = node (map f ps)


fruits :: Plant leaf flower fruit stem -> Integer
fruits = foldPlant (\x -> 0) (\x -> 0) (\x -> 1) (const id) sum


plantToStack :: Plant leaf flower fruit stem -> [StackPlant leaf flower fruit stem]
plantToStack = foldPlant
    (\a -> [LEAF a])
    (\a -> [FLOWER a])
    (\a -> [FRUIT a])
    (\s p -> p ++ [STEM s])
    (\ps -> concat (reverse ps) ++ [NODE (length ps)])


stackToPlants :: [StackPlant leaf flower fruit stem] -> [Plant leaf flower fruit stem]
stackToPlants = foldl
    (\ps c -> case c of
        LEAF l -> Leaf l : ps
        FLOWER f -> Flower f : ps
        FRUIT f -> Fruit f : ps
        STEM s -> Stem s (head ps) : tail ps
        NODE n -> Node (take n ps) : drop n ps)
    []

plnt = plantToStack (Stem 3.0 ( Node [ Leaf 2 , Stem 4.0 (Flower 0.4) ] ))

