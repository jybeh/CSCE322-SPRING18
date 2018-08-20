module.exports = {
    manyPlayersManyMoves: manyPlayersManyMoves
}

var helpers = require( './helpers' );

function manyPlayersManyMoves( trains ){
    function whatever( hands ){
      var trainsResult = [];
      var trainsLength = trains.length;
      for(x=0;x<trainsLength;x++){
        var hand = hands.shift();
        var train = trains.shift();
        var initialDomino= initialTrain(train);
        train = dominoRules(hand, train);
        trainsResult.push(train);
      }
      trains = trainsResult;

	    return trains;
    }
    return whatever;
}

function swapDomino(domino){
    var temp = domino[1];
    domino[1] = domino[0];
    domino[0] = temp;

    return domino;
}

function checkDomino(frontDomino,backDomino){
  return (frontDomino[1]== backDomino[0]);
}

function initialTrain(train){
  var initialDomino=[];
  for(i=0;i<train.length-1;i++){
    if(train[i][1] == train [i+1][0]){
      initialDomino.push(train[i]);
      initialDomino.push(train[i+1]);
    }
  }
  if(initialDomino.length == 0){
      initialDomino.push(train[0]);
  }
  return initialDomino;
}

function dominoRules(hand, initialTrain){
    for(i=0;i<hand.length;i++){
      if(checkDomino(hand[i], initialTrain[0])){
        //initialTrain.splice(0,0, hand[i]);
        initialTrain.unshift(hand[i]);
        hand.splice(i,1);
        i=-1;
      }else if(checkDomino(swapDomino(hand[i]), initialTrain[0])){
        //initialTrain.splice(0,0, swapDomino(hand[i]));
        initialTrain.unshift(hand[i]);
        hand.splice(i,1);
        i=-1;
      }else if(checkDomino(initialTrain[initialTrain.length-1], hand[i])){
        //initialTrain.splice(0,initialTrain.length-1, swapDomino(hand[i]));
        initialTrain.push(hand[i]);
        hand.splice(i,1);
        i=-1;
      }else if(checkDomino(initialTrain[initialTrain.length-1], swapDomino(hand[i]))){
        //initialTrain.splice(0,initialTrain.length-1, swapDomino(hand[i]));
        initialTrain.push(hand[i]);
        hand.splice(i,1);
        i=-1;
      }
    }
  return initialTrain;
}
