data Graph a b c
    = Red a
    | Blue b
    | Sub c (Graph a b c)
    | Node [Graph a b c]
    deriving (Show, Eq)




foldGraph :: (red -> a) -> (blue -> a) -> (sub -> a -> a) -> ([a] -> a) -> Graph red blue sub -> a
foldGraph fRed fBlue fSub fNode = f
    where 
        f (Red a) = fRed a 
        f (Blue a) = fBlue a
        f (Sub a b) = fSub a (f b)
        f (Node ps) = fNode (map f ps)




mapGraph :: (red1 -> red2) -> (blue1 -> blue2) -> (sub1 -> sub2) -> Graph red1 blue1 sub1 -> Graph red2 blue2 sub2
mapGraph fRed fBlue fSub = f
    where 
        f (Red a) = Red (fRed a)
        f (Blue a) = Blue (fBlue a)
        f (Sub a b) = Sub (fSub a) (f b)
        f (Node ps) = Node (map f ps)




-- Graphen zu Liste
-- Idee: Operationen als Stack sehen
-- Red, Blue legen etwas auf den Stack
-- Sub, Node nehmen etwas vom Stack 
data GraphAsStack a b c 
    = RED a
    | BLUE b
    | SUB c
    | NODE Int
    deriving (Show, Eq)







