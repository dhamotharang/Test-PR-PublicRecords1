EXPORT AID_Helpers := 
MODULE
	SHARED STRING fRawFixCommon(STRING pStringIn) :=
	FUNCTION
			 STRING lNoPeriod     := REGEXREPLACE('([^0-9])\\.',pStringIn,'\\1 ');
			 STRING lNoComma      := StringLib.StringFindReplace(lNoPeriod,',',' ');
			 STRING lCleanSpaces  := StringLib.StringCleanSpaces(lNoPeriod);	//don't want to remove comma yet
			 STRING lUpperCase    := StringLib.StringToUpperCase(lCleanSpaces);
			 RETURN lUpperCase;
	END;

	EXPORT STRING fRawFixLine1(STRING pStringIn) := 
	FUNCTION
			 STRING lFixedCommon        := fRawFixCommon(pStringIn);
			 STRING lFixReversedPOBox   := REGEXREPLACE('^([0-9]+) (PO BOX)$',lFixedCommon,'\\2 \\1');          // Must be in form of "1234 PO BOX" only, with no extraneous chars
			 STRING lRemoveExtraSpcs		:= regexreplace('P[[:space:]]+O BOX',lFixReversedPOBox,'PO BOX');
			 RETURN lRemoveExtraSpcs;
	END;

	EXPORT STRING fRawFixLineLast(STRING pStringIn) := 
	FUNCTION
			 STRING lFixedCommon      := fRawFixCommon(pStringIn);
			 STRING lSplitStateAndZip := REGEXREPLACE('(^| )([A-Z]{2})([0-9]{5})(-?[0-9]{4})?$',lFixedCommon,'\\1\\2 \\3\\4');
			 STRING lDropZip4         := REGEXREPLACE('(^| )([0-9]{5})-?[0-9]{4}$',lSplitStateAndZip,'\\1\\2');
			 string ldropblanks				:= if(trim(lDropZip4,left,right) = ','	,'',lDropZip4);
			 RETURN ldropblanks;
	END;
END;

/* Per tony
	space after comma before state will let it find more.  Also, changing "P O BOX" to "PO BOX" 
	will help find cached ones, too
*/