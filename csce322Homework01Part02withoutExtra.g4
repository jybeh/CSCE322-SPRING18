grammar csce322Homework01Part02;

@members{
	 boolean isAtLeastOneHand = false;
   boolean isAtLeastOneTrain = false;
   boolean isValidDominoes = true;
   int handDominoesNum = 0;
   int trainDominoesNum = 0;
   int totalDominoes = 0;
}

// tokens
SECBEGIN : '<<';
SECEND : '>>';
TITLESTART: '<';
TITLETRAIN : 'Trains';
TITLEHANDS : 'Hands';
NUM : [0-9]+;
ROWEND : '#';
LISTBEGIN : '{';
LISTEND : '}';
DOMINOBEGIN : '[';
DOMINOEND : ']';
HALF : ',';

WS : [ \t\r\n]+ { skip(); };

// rules
dominoes  : trains hands semantics EOF
          | hands trains semantics EOF;
trainPortion : TITLESTART trainPortionTitle;
handPortion : TITLESTART handPortionTitle;
trainDominoTokens : trainDomino trainDominoTokens
              		| trainDomino;
handDominoTokens 	: handDomino handDominoTokens
									| handDomino;
//fix take out dominoBegin to dominoEnd
trainDomino @after {trainDominoesNum++; totalDominoes++;}
						: dominoBegin dominoNum dominoHalf dominoNum dominoEnd;
handDomino 	@after {totalDominoes++;}
						: dominoBegin dominoNum dominoHalf dominoNum dominoEnd;

trains : trainPortion sectionBegin listTrainDominoes sectionConclude;
listTrainDominoes : listTrainDominoTokens rowEnd listTrainDominoTokens;
listTrainDominoTokens : listTrainDomino rowEnd listTrainDominoTokens
                      | listTrainDomino;
listTrainDomino : listBegin trainDominoTokens listEnd;

hands : handPortion sectionBegin listHandDominoes sectionConclude;
listHandDominoes  : listHandDominoTokens rowEnd listHandDominoTokens;
listHandDominoTokens  : listHandDomino rowEnd listHandDominoTokens
                      | listHandDomino;
listHandDomino	@after {handDominoesNum ++;}
								: listBegin handDominoTokens listEnd;

trainPortionTitle : TITLETRAIN;
handPortionTitle : TITLEHANDS;
sectionBegin : SECBEGIN;
sectionConclude : SECEND;
listBegin : LISTBEGIN;
listEnd : LISTEND;
dominoBegin : DOMINOBEGIN;
dominoNum : NUM;
dominoHalf : HALF;
dominoEnd : DOMINOEND;
rowEnd : ROWEND;

semantics : {
  if(handDominoesNum < 3 || handDominoesNum >= 10){
    System.out.println("Notification: Semantic Problem 1");
    isValidDominoes = false;
  }

  else if(trainDominoesNum>(int)(0.2*totalDominoes)){
    System.out.println("Notification: Semantic Problem 2");
    isValidDominoes = false;
  }

  if(isValidDominoes == true){
    System.out.print( trainDominoesNum + " dominoes have been played");
  }
};
