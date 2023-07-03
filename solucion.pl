/*
Los precios son:
codos: $5.
caños: $3 el metro.
canillas: las triangulares $20, del resto $12 hasta 5 cm de ancho,
 $15 si son de más de 5 cm.
*/
precio(codo( _ ), 5).
precio(canio( _ , Longitud), Precio):-
    Precio is Longitud * 3.
precio(canilla(triangular, _ , _ ), 20).
precio(canilla(Tipo, _ , Ancho), 12):-
    Tipo \= triangular,
    Ancho =< 5.
precio(canilla(Tipo, _ , Ancho), 15):-
    Tipo \= triangular,
    Ancho > 5.

% 2 puedoEnchufar/2
color(codo( Color ), Color).
color(canio( Color , _ ), Color).
color(canilla( _ , Color , _ ), Color).
color(extremo( _ , Color), Color).

coloresEnchufables(rojo, negro).
coloresEnchufables(azul, rojo).
coloresEnchufables(Color, Color).

puedoEnchufar(Pieza1, Pieza2):- 
    color(Pieza1, Color1),
    color(Pieza2, Color2),
    Pieza1 \= extremo(derecho, _),
    Pieza2 \= extremo(izquierdo, _),
    coloresEnchufables(Color1, Color2).

%3 Modificamos puedoEnchufar/2 para que se banque cañerías
puedoEnchufar(Canieria, CanieriaOPieza):- 
    last(Canieria, Pieza),
    puedoEnchufar(Pieza, CanieriaOPieza).

puedoEnchufar(CanieriaOPieza, [Pieza | _ ]):- 
    puedoEnchufar(CanieriaOPieza, Pieza).

%4 canieriaBienArmada/1
canieriaBienArmada([Pieza]):- 
        color(Pieza, _).
canieriaBienArmada([Canieria]):- 
        canieriaBienArmada(Canieria).
canieriaBienArmada([CanieriaOPieza | CanieriasOPiezas]):-
    puedoEnchufar(CanieriaOPieza, CanieriasOPiezas), %Acoplamiento mínimo
    canieriaBienArmada([CanieriaOPieza]),
    canieriaBienArmada(CanieriasOPiezas).

%5 Modificación del modelo a causa de la llegada del extremo

%6 Validar que..
% [codo azul, [codo rojo, codo negro]]
% [codo azul, [codo rojo, codo negro], codo negro]

%7 - Clase del 8/7 o la otra... Dijo Mati.



