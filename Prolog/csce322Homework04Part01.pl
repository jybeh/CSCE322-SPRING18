haveDoubles([]).
haveDoubles([Element|T]):-
  isContainDouble(Element),
  haveDoubles(T).

% check isDoubleExist in each hand
isContainDouble([Element|_]):-
    doubleHand(Element).
isContainDouble([_|T]):-
    isContainDouble(T).

doubleHand((X,X)).
