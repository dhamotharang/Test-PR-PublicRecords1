IMPORT std;

 
EXPORT StringSplit(STRING inStr, STRING1 delimiter = ' ', UNSIGNED6 MAXLEN = 4000) :=
	FUNCTION
		
			return Std.Str.SplitWords(instr, delimiter)	;
	
	END:DEPRECATED('USE Std.Str.SplitWords instead');