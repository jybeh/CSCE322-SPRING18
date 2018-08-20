percentMatch(Hand,Domino):-
    length(Hand, HandLength),
    numberMatch(Num, Hand, Domino),
    PercentMatch is Num/HandLength,
    PercentMatch >= (0.1).

numberMatch(0, [], _).

numberMatch(Number, [H|T], Domino):-
    isMatchDomino(H, Domino),
    numberMatch(NumberM, T, Domino),
    Number is NumberM + 1.

numberMatch(Number, [H|T], Domino):-
    not(isMatchDomino(H, Domino)),
    numberMatch(Number, T, Domino).

isMatchDomino((X,Y), (Y,Z)).
isMatchDomino((X,Y), (X,Z)).
isMatchDomino((X,Y), (Z,X)).
isMatchDomino((X,Y), (Z,Y)).
