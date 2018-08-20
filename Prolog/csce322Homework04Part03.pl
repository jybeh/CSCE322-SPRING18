% longestTrain(Hand,Hand).

longestTrain([H|T], Train):-
      isMatchDomino(H),
      Train = [H].

longestTrain([_|T], Train):-
      longestTrain(T, Train).

isMatchDomino((X,X)).
