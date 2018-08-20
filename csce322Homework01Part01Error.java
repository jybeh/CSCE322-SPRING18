import java.io.IOException;
import org.antlr.v4.runtime.*;

class csce322Homework01Part01Error extends BaseErrorListener{
    @Override
	public void syntaxError(Recognizer<?, ?> recognizer, Object offendingSymbol, int line,
				int position, String msg, RecognitionException e) {

	// replace with code to process syntax Errors
	//System.out.println( "HELLO" );
	//System.err.println( msg );
  System.out.println( "Notification: Problem on Line " + line );

  System.exit(0);
  }
}
