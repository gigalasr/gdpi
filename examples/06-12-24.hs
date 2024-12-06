-- Kontext Sensitivität

-- Zwei Identifier mit dem gleichen Namen!?
data Fertelizer = NPK Double Double Double 
data NPK = N | P | K


-- Nach dem :: sind wir in der Typdomain
-- somit versteht Haskell, dass hierbei der Typ NPK gemeint
-- ist und nicht der Konstrutor NPK 
foo :: NPK -> Double
foo N = 5 -- Patternmatching: Nur für die Instanz N wird 5 zurück gegeben
foo _ = 0 -- Der _ heißt, uns ist egal was an der Stelle steht. Somit gilt das Pattern für alle anderen Fälle


-- Hier wird NPK in einer Fuktionsdefinition genutzt
-- Somit versteht Haskell, dass der Konstruktor NPK gemeint ist. 
foo' :: Fertelizer -> Double
foo' (NPK x y z) = x


-- Prefix Funktion
-- Funktionen mit Buchstaben sind
-- Prefix Funktionen. D.h. die Argumente werden
-- nach dem Funktionsnamen geschrieben 
foobar x y = x

-- Infix Funktion
-- Mathematische Operatoren sind auch nur Funktionen in Haskell.
-- Diese sind als sog. Infix Funktionen Implementiert.
-- Infix Funktionen sind Funktionen bei denen das erste Argument links und
-- das zweite Argument rechts von der Funktion steht.
bar = 5 + 4

-- Man kann Infix Funktionen auch als Prefix Funktionen nutzen
bar' = (+) 5 4 

-- Man kann Prefix Funktionen auch als Infix Funktionen nutzen
add :: Int -> Int -> Int
add x y = x + y 

bar'' = 4 `add` 5 

-- Infix Funktionen kann man auch selber definieren
-- Infix Funktionen werden mit symbolen und nicht Buchstaben definiert
(@@) :: Int -> Int -> Int
(@@) a b = a + b

bar''' = 4 @@ 5 


-- Pattern Matching 
-- Wir können auch Funktionsdefinitionen mit einem Konkreten Wert angeben.
-- Haskell arbeitet die Definitionen dann von oben nach unten durch
-- und nimmt die erste passende Definition.
data Day = Mon | Tue | Wed | Thu | Fri | Sat | Sun 
data Weather = Fog | Sunnny | Rain
    deriving (Show)

ulm :: Day -> Weather
ulm Mon = Fog 
ulm Thu = Sunnny
ulm _ = Rain  

today = ulm Tue -- == Rain
today' = ulm Mon -- == Fog

-- Wenn wir die Funktion wie folgt definert hätten, dann wäre der einzige Rückgabewert Rain
-- da eben die Definitionen von oben nach unten überprüft werden.
-- ulm :: Day -> Weather
-- ulm _ = Rain  
-- ulm Mon = Fog 
-- ulm Thu = Sunnny


-- Guards & Error
-- Error: Programm wird Terminiert 
barbar :: Int -> Bool
barbar x
    | x == 5 = True
    | otherwise = error "Was machst du!?"

burber :: Int -> Bool
burber x
    | x > 5 && x < 10 = True
    | otherwise = False

-- Maybe
-- Maybe kann man nutzen, um im Typsystem zu kodieren, ob ein Wert
-- ein Valider Wert ist, oder kein Wert.
--
-- Das ist im Vergleich zu z.B. C ziemlich praktisch. Hier würe man einfach
-- nur z.B. -1 als Wert zurück geben, falls die Funktion fehlschlägt.
-- Aber es könnte ja auch den Fall geben, wo -1 auch ein Valider Wert ist!
-- Somit kann man Maybe in Haskell nutzen, um dies auf dem Typsystem zu beschreiben
foobarbarbar :: Maybe Int -> Int
foobarbarbar (Just x) = x 
foobarbarbar Nothing = 0

-- Z.b. um im Fall x=0 => 1/x = undefined kontrolliert im Typsystem
-- zu beschreiben, dass unser Rückgabewert kein Valider Wert ist
oneoverx :: (Fractional a, Eq a) => a -> Maybe a
oneoverx 0 = Nothing
oneoverx x = Just (1 / x) 


-- Advent of Code
-- Weihnachtliche Programieraufgaben :)
-- https://adventofcode.com/