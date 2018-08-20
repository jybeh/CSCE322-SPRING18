grammar csce322Homework01Part02;

@members{
	 boolean isAtLeastOneHand = false;
   boolean isAtLeastOneTrain = false;
   boolean isValidDominoes = true;
	 boolean isValidTrain = true;
   int handDominoesNum = 0;
   int trainDominoesNum = 0;
   int totalDominoes = 0;
	 int listSize = 0;
	 int i = 0;
	 int currentSize = 0;
	 int maxListSize = 0;
	 int minListSize = 0;
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

trainDomino @after { trainDominoesNum++; totalDominoes++; listSize++; }
						: dominoBegin dominoNum dominoHalf dominoNum dominoEnd;
handDomino 	@after {totalDominoes++;}
						: dominoBegin dominoNum dominoHalf dominoNum dominoEnd;

trains : trainPortion sectionBegin listTrainDominoes sectionConclude;
listTrainDominoes : listTrainDominoTokens rowEnd listTrainDominoTokens;
listTrainDominoTokens : listTrainDomino rowEnd listTrainDominoTokens
                      | listTrainDomino;
listTrainDomino @after{
									currentSize = listSize;

									if(i==0){
										maxListSize = currentSize;
										minListSize = currentSize;
									}

									if(currentSize > maxListSize){
										maxListSize = currentSize;
									}

									if(currentSize < minListSize){
										minListSize = currentSize;
									}

									if((maxListSize-minListSize) > 1){
										isValidTrain = false;
									}

									i++;
									listSize = 0;
								}
								: listBegin trainDominoTokens listEnd;

hands : handPortion sectionBegin listHandDominoes sectionConclude;
listHandDominoes  : listHandDominoTokens rowEnd listHandDominoTokens;
listHandDominoTokens  : listHandDomino rowEnd listHandDominoTokens
                      | listHandDomino;
listHandDomino	@after {handDominoesNum ++;}
								: listBegin handDominoTokens listEnd;

trainPortionTitle	: TITLETRAIN;
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

	if(isValidTrain == false){
		System.out.println("Notification: Semantic Problem 3");
		isValidDominoes = false;
	}

  if(isValidDominoes == true){
    System.out.print( trainDominoesNum + " dominoes have been played");
  }
};
