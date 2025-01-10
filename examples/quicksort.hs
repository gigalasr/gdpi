-- a sorted list is a list that has all the values smaller than or equal to the head of the list in front (and those values are sorted), then comes the head of the list in the middle and then come values that are bigger than the head ( they are also sorted)

quicksort [] = []
quicksort (x : xs) =
    let smaller = quicksort [e | e <- xs, e <= x]
        bigger = quicksort [e | e <- xs, e > x]
     in smaller ++ [x] ++ bigger
