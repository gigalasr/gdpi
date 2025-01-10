
--calculatePlantWaterDemand :: Plant -> DailyThroughput
--calculatePlantWaterDemand = sum . map budWaterDemand
-- äquivalent zu: calculatePlantWaterDemand xs = sum (map budWaterDemand xs)
-- Mit foldr



-- Was sind folds?
-- Folds reduzieren eine Datenstruktur auf einen zusammengefassten Wert 

-- TIPP: https://hoogle.haskell.org/

{- 
  foldr implementation
  (Fängt am Ende / rechts an)

  Foldable: "The Foldable class represents data structures that can be reduced to a summary value one element at a time"
            => Die Klasse Foldable beinhaltet unter anderem die Funktion foldr
               und ist auf Typen wie z.B. [] oder Either implementiert

    foldr nimmt eine Funktion, einen Startwert und z.B. eine Liste als argumente. 
    Die Funktion wird rekursiv auf jedes Element in der Liste angewendet. 
    Die Funktion wird in jedem Schritt mit einem sog. Akumulator aufgerufen und einem Element aus der liste. 
    Der Akumulator wird dann gleich dem Rückgabewert der Funktion gesetzt.
-}

--                                     Startwert
--                                         |     Foldable vom Typ a (z.B. Liste)
--      Klassenconstraint   Funktion       |     |
--        /----------\     /---------\     |    / \    -> Resultat 
foldr' :: (Foldable s) => (a -> b -> b) -> b -> s a -> b
--                         |    |    
--                      Wert    Akumulator

-- z.B. summe einer liste
sum' xs = foldr (\x a -> x + a) 0 xs 


-- Foldr für Listen
foldr'' :: (a -> b -> b) -> b -> [a] -> b
foldr'' _ a [] = a 
foldr'' f a (x:xs) = f x (foldr'' f a xs)
--                   |
--           f kann erst aufgerufen werden, wenn (foldr'' f a xs)
--           ausgewertet wurde. D.h. der rekursive Aufruf geht erstmal
--           bis ganz zum ende der Liste (bis wir bei foldr'' _ a [] = a sind)
--           und kann dann von da aus wieder die Rekursionskette hoch gehen 
--           und f anwenden


-- Foldr1 für Listen (hat kein startwert)
foldr1' :: (a -> a -> a) -> [a] -> a
foldr1' _ [x]    = x
foldr1' f (x:xs) = f x (foldr1' f xs)


-- foldl
foldl' :: Foldable t => (b -> a -> b) -> b -> t a -> b
--                       |
--                  Akumulator zuerst 


-- foldl für Listen
-- Fängt links an am Anfang an 
foldl'' :: (b -> a -> b) -> b -> [a] -> b
foldl'' _ a [] = a
foldl'' f a (x:xs) = foldl' f (f a x) xs
--                    |          |
--                    |       f kann direkt aufgerufen werden
--                    |
--                 rekursion geht direkt mit dem nächsten Element weiter    















foldr' = undefined
foldl' = undefined