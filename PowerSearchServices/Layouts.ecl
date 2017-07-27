IMPORT Text_Search,Text_FragV1;

EXPORT Layouts := MODULE

	EXPORT answerRec := RECORD
		UNSIGNED key;
		UNSIGNED seq;
		Text_FragV1.Layout_AnswerListData;
		STRING8 dod;
		string1 deceased;
		UNSIGNED hitScore;
		UNSIGNED argScore;
		STRING   source{MAXLENGTH(1024)};
	END;

	EXPORT scoreRec := RECORD
		UNSIGNED key;
		Text_Search.Layout_RPN_Oprnd.searcharg;
		Text_Search.Layout_RPN_Oprnd.freq;
		REAL ratio;
		UNSIGNED score;
	END;

END;