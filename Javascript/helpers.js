module.exports = {
    readDominoesFile:readDominoesFile
}

function readDominoesFile( file )
{
    var text;
    var lines = [];
    var rows = [];
    var filesystem = require( 'fs' );

    text = filesystem.readFileSync( file );
    rows = text.toString().split( "\n" );
    rows.pop();

    for( var r = 0; r < rows.length; r++ ){
	rows[r] = rows[r].split( ";" );
	for( var c = 0; c < rows[r].length; c++ ){
	    rows[r][c] = rows[r][c].split( "," );
	    rows[r][c][0] = parseInt( rows[r][c][0] );
	    rows[r][c][1] = parseInt( rows[r][c][1] );
	}
    }

    return rows;
}

function splitHandDominoesToDominoesArray( dominoesRow ){
    var dominoesArray = dominoesRow.split(';');
    return dominoesArray;
}
