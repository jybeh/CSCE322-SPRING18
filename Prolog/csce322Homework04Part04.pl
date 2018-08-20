getNext([H|_],Domino, Next):-
    isMatchDomino(H,Domino),
    Next = H.

getNext([_|T], Domino, Next):-
    getNext(T,Domino, NextT),
    Next = NextT.

isMatchDomino((X,Y), (Y,Z)).
isMatchDomino((X,Y), (X,Z)).
isMatchDomino((X,Y), (Z,X)).
isMatchDomino((X,Y), (Z,Y)).
