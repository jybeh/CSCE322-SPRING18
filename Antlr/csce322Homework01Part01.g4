grammar csce322Homework01Part01;

@members{
  int i = 1;
}

// tokens
SECBEGIN : '<<';
SECEND : '>>';
TITLESTART: '<';
TITLE : 'Trains' | 'Hands';
NUM : [0-9]+;
ROWEND : '#';
LISTBEGIN : '{';
LISTEND : '}';
DOMINOBEGIN : '[';
DOMINOEND : ']';
HALF : ',';

WS : [\t\r\n ]+ { skip(); };

ANYTHING : .;

// rules
dominoes  : ( trains | hands | portion | listDominoes | listDomino | dominoTokens | domino | ANYTHING{ System.out.println("Notification: Problem on Line " + i); System.exit(1);} )*
          endFile EOF;

trains : portion sectionBegin listDominoes+ sectionConclude;

hands : portion sectionBegin listDominoes+ sectionConclude;

portion : titleStart portionTitle;

listDominoes  : listDomino rowEnd listDominoes
              | listDomino{ i++; };

listDomino : listBegin dominoTokens listEnd;

dominoTokens : domino dominoTokens
             | domino;

domino : dominoBegin dominoNum dominoHalf dominoNum dominoEnd;

anythings :{ System.out.println("Notification: Problem on Line " + i); System.exit(1);}
           anything anythings | anything;

//scanner printing
titleStart : TITLESTART;
portionTitle  : TITLE{ System.out.println("Portion: " + $TITLE.text); };
sectionBegin  : SECBEGIN{ System.out.println("Begin Section"); i++; };
sectionConclude : SECEND{ System.out.println("Conclude Section"); i++; };
listBegin : LISTBEGIN{ System.out.println("Begin List"); };
listEnd : LISTEND{ System.out.println("Conclude List"); };
dominoBegin : DOMINOBEGIN{ System.out.println("Begin Domino"); };
dominoNum : NUM{ System.out.println("Half: "+ $NUM.text); };
dominoHalf  : HALF{};
dominoEnd : DOMINOEND{ System.out.println("Conclude Domino"); };
rowEnd  : ROWEND{ System.out.println("Conclude Row"); i++; };
endFile : { System.out.println("Conclude File"); };
anything : ANYTHING{ System.out.println("Notification: Problem on Line " + i); System.exit(1); };
