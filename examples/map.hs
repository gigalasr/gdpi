map' f = foldl (\acc x -> acc ++ [f x]) []

map'' f = foldr (\x acc -> f x : acc) []
