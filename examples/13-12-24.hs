-- listen und rekursion
a = [1,2,3,4]

-- Einfache Rekursion 
-- Mit (x:xs) können wir Listen aufspalten
-- in x ist das erste Element der Liste, in xs die restlichen

sum' :: Num a => [a] -> a
sum' (x:xs) = x + sum' xs -- Rekursiver Aufruf
sum' [] = 0               -- Base Case 

-- a -> Die gesamte Liste
-- x -> Das erste Element
-- xs -> Die restlichen Elemente 
test a@(x:xs) = (a, x, xs)





-- Rekursion auf Bäumen
data Tree = Node Tree Tree | Leaf Double
myTree = Node (Node (Leaf 1) (Leaf 2)) (Leaf 3)
{-

      x
     /\
    x  3
   /\
  1 2

-}

treeMax :: Tree -> Double
treeMax (Node a b) = max (treeMax a) (treeMax b) -- Rekursiver Aufruf
treeMax (Leaf a) = a                             -- Base Case






-- Higher Order Funktions
-- Funktionen, welche Funktionen als Parameter entgegennehmen
-- Mit den Klammern (...) notiert man, dass dieser Parameter eine Funktion ist

applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

-- applyTwice (+2) 2 = 6







-- Curried Functions
-- Funktionen welche laut der Signatur mehr Parameter erwarten, als in der Definition gegeben 
addTwo :: Num a => a -> a
addTwo = (+2)

-- addTwo ist wieder eine Funktion welche noch ein Parameter erwartet
-- addTwo 4 = 6





-- Eingebaute Funktionen sum, map, filter
-- sum addiert alle Elemente einer Liste
summe = sum [1,2,3,4]





-- map
-- map wendet eine Funktion auf jedes Element in einer Liste an
-- (\x -> x * x) ist eine lambda (anonyme) Funktion
-- die Funktion square führt also die Funktion (\x -> x * x) für jedes Element in xs aus
square :: Floating a => [a] -> [a]
square xs = map (\x -> x * x) xs


-- map selber implementieren mit expliziter Rekursion
-- Auf der linke Seite spaltet : ein Elemnt ab, au f der rechten Seite 
-- fügt : das Elemnt (f x) zum Anfang der Liste (map' f xs) hinzu 
map' :: (a -> a) -> [a] -> [a]
map' f (x:xs) = f x : map' f xs
map' _ [] = []






-- filter
-- filter Entfernt alle Elemente einer Liste, für die die gegebene Funktion zu False evaluiert 
biggerThan2 :: (Num a, Ord a) => [a] -> [a]
biggerThan2 xs = filter (\x -> x > 2) xs

-- Kürzer mit currying
biggerThan2' = filter (\x -> x > 2)

-- ... und infix Funktion
biggerThan2'' = filter (> 2)





-- take
-- take n xs nimmt n Elemnte der Liste xs
-- Praktisch wenn man mit unendlichen Listen arbeitet 
first2Items :: [a] -> [a]
first2Items xs = take 2 xs





-- iterate
-- iterate f x nimmt die funktion f, wendet diese auf den Wert x an, wendet dann wieder f auf dieses Ergebnis an, und so weiter (unendlich oft)
-- -> iterate f x = ...f(f(f(x)))...
powerOfTwos = take 8 $ iterate (*2) 1

-- $ hat die niedrigste Präzedenz: Alles auf der rechten Seite wird zuerst ausgewertet, und dann das Ergebnis auf die linke Seite angewendet 
-- take 8 $ iterate f x, wendet also f 8 mal auf x an 




-- concat
-- concat nimmt eine Liste an Listen und fügt die inerenn listen zusammen
b = [[1, 2, 3], [4, 5, 6]]
flat = concat b -- = [1,2,3,4,5,6]





-- Komposition 
-- Funktionskomposition wie man diese z.B. aus der Mathe kennt.
-- f . g x = g(f(x))

sumOfPowers xs = sum (map (^2) xs)
sumOfPowers' = sum . map (^2)

--sumTo4 = sumOfPowers [1,2,3,4]

-- Hier sieht man auch wieder Currying: (map (^2)) ist eine Funktion die nur noch einen Parameter erwartet (da (^2) schon auf angewandt wurde)
-- Desswegen können wir jetzt den . operator benutzten um die Komposition mit sum zu bilden 
-- Ohne currying: sumOfPowers' xs = (sum . map (^2)) xs 





-- folds (mini intro)
-- Folds fassen die explizite Rekursionsdefinition in Hilfsfunktionen zusammen,
-- damit man mit einer einfachen Funktion die Rekursion (diw wir davor in mehreren Schritten definieren mussten)
-- anwenden kann

-- sum mit foldl
-- sum' :: Num a => [a] -> a
-- sum' (x:xs) = x + sum' xs
-- sum' [] = 0

sum2 :: Num a => [a] -> a
sum2 xs = foldl (\acc x -> acc + x) 0 xs

-- Mit currying
sum3 :: Num a => [a] -> a
sum3 = foldl (\acc x -> acc + x) 0

-- Mit infix Funktion
sum4 :: Num a => [a] -> a
sum4 = foldl (+) 0

-- Man sieht, mit currying, infix notation und folds kann man sich viele Zeichen spaaren.
-- Ist bei einfachen Beispielen wie sum nicht so wild. Aber wenn man komplexere rekursionen hat,
-- dann wird das umso wichtiger. 

