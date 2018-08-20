module.exports = {
    onePlayerOneMove: onePlayerOneMove
}

var helpers = require( './helpers' );

function onePlayerOneMove( train ){
    function whatever( hand ){
      console.log(train);
      var initialDomino= initialTrain(train);
      console.log(initialDomino);
      var result = dominoRules(hand, train);
      console.log(result);
      // for(i=0;i<train.length;i++){
      //   train.shift();
      //   console.log("Shifting" + train);
      // }
      // for(i=0;i<result.length;i++){
      //   train.push(result[i]);
      // }

      return train;
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
        console.log(initialTrain);
        return initialTrain;
      }else if(checkDomino(swapDomino(hand[i]), initialTrain[0])){
        //initialTrain.splice(0,0, swapDomino(hand[i]));
        initialTrain.unshift(hand[i]);
        console.log("swap");
        return initialTrain;
      }else if(checkDomino(initialTrain[initialTrain.length-1], hand[i])){
        //initialTrain.splice(0,initialTrain.length-1, swapDomino(hand[i]));
        initialTrain.push(hand[i]);
        console.log(initialTrain);
        return initialTrain;
      }else if(checkDomino(initialTrain[initialTrain.length-1], swapDomino(hand[i]))){
        //initialTrain.splice(0,initialTrain.length-1, swapDomino(hand[i]));
        initialTrain.push(swapDomino(hand[i]));
        console.log(initialTrain);
        return initialTrain;
      }
    }
  return initialTrain;
}
