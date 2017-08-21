// Duplicate check input and output structures
IMPORT Text_Search;
EXPORT Layout_Dup		:= MODULE
	EXPORT Ident := RECORD
		Text_Search.Types.SourceID  src;
		Text_Search.Types.DocID			doc;
		Text_Search.Types.RID_Type	rid;
		UNSIGNED8										mask;			// field bit mask set by caller
	END;
	EXPORT Candidate := RECORD
		Ident;
		UNSIGNED8										hashVal;
	END;
	EXPORT Value := RECORD
		Ident;
		STRING	str{MAXLENGTH(500)};
	END;
END;