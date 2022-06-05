module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

-- Parcial Gnomos --

type Material = (String, Number)
type Edificio = (String, [Material])
type Aldea = (Number, [Material], [Edificio])

--(50, [("acero", 15), ("acero", 20), ("piedra", 5)], [("Barracas", [("Acero", 20)])])

-- (1) --
-- A --

esDeCalidad :: Material -> Bool
esDeCalidad material = snd material > 20

-- B --

disponibles :: String -> Aldea -> Number
disponibles nombre (p, m, e) = length (filtrarMaterialesPorNombre nombre m)

filtrarMaterialesPorNombre :: String -> [Material] -> [String] 
filtrarMaterialesPorNombre nombre m = filter (==nombre) (nombreMaterialesDisponibles m)

nombreMaterialesDisponibles :: [Material] -> [String]
nombreMaterialesDisponibles materialesDisponibles = map fst materialesDisponibles

-- C --

valorTotal :: Aldea -> Number
valorTotal (p, m, e) = sum (materialesDisponiblesyUsados m e)

materialesDisponiblesyUsados :: [Material] -> [Edificio] -> [Number]
materialesDisponiblesyUsados m e = filtrarMaterialesPorCantidad m ++ filtrarMaterialesPorCantidadUsados e

filtrarMaterialesPorCantidad ::[Material] -> [Number]
filtrarMaterialesPorCantidad m = map snd m

filtrarMaterialesPorCantidadUsados :: [Edificio] -> [Number]
filtrarMaterialesPorCantidadUsados e = map snd (concat (map snd e))

-- (2) --
-- A --

tenerGnomito :: Aldea -> Aldea
tenerGnomito (p, m, e) = (p + 1, m, e)

-- B --

-- (50, [("Madera de pino", 15), ("Acero", 20), ("Madera de arce", 5)], [("Panaderia", [("Madera de pino",20)])])
lustrarMaderas :: Aldea -> Aldea
lustrarMaderas (p, m, e) = (p, aumentar5 m, e)

aumentar5 :: [Material] -> [Material]   
aumentar5 [] = []    
aumentar5 (x:xs)    
    | (head.words) (fst x) == "Madera" = (fst x, snd x + 5) : aumentar5 xs
    | otherwise = (fst x, snd x) : aumentar5 xs

-- C --

recolectar :: Material -> Number -> Aldea -> Aldea
recolectar material n (p, m, e) = (p, (agregarAListaNVeces material n) ++ m, e)

agregarAListaNVeces :: Material -> Number -> [Material]
agregarAListaNVeces material 0 = []
agregarAListaNVeces material n = [material] ++ agregarAListaNVeces material (n - 1)

-- D --

c :: Edificio -> Aldea -> Aldea
c edificio (p, m, e) = (p, quitarMaterialesUsados (snd edificio) m, e ++ [edificio])

quitarMaterialesUsados :: [Material] -> [Material] -> [Material]
quitarMaterialesUsados materialesEdificio m = map (quitarMaterial materialesEdificio) m 

quitarMaterial :: [Material] -> Material -> Material
quitarMaterial [x] material
    | fst x == fst material = (fst x, snd material - snd x)
    | otherwise = material
quitarMaterial (x:xs) material 
    | fst x == fst material = (fst x, snd material - snd x)
    | otherwise = quitarMaterial xs material

-- (3) --
-- a --

--https://www.utnianos.com.ar/foro/attachment.php?aid=8771
 