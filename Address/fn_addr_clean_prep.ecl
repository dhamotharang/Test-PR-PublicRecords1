//Usage: ut.fn_addr_clean_prep(<Input Address>, 'first' OR 'last' to indicate which address line to format)
IMPORT lib_StringLib;
export fn_addr_clean_prep(string address, string firstorlast) := function

	//Format raw address before passing it to AID macro
	STRING	fRawFixCommon(STRING pStringIn) := FUNCTION
			STRING	lNoPeriod						:=	REGEXREPLACE('([^0-9])\\.',pStringIn,'\\1 ');
			STRING	lCleanSpaces				:=	lib_StringLib.StringLib.StringCleanSpaces(lNoPeriod);
			STRING	lNoSpaceBeforeComma	:=	lib_StringLib.StringLib.StringFindReplace(lCleanSpaces,' ,',',');
			STRING	lUpperCase					:=	lib_StringLib.StringLib.StringToUpperCase(lNoSpaceBeforeComma);
			RETURN	lUpperCase;
		END;

	STRING	fRawFixLine1(STRING pStringIn) := FUNCTION
			STRING	lFixedCommon				:=	fRawFixCommon(pStringIn);
			STRING	lFixReversedPOBox		:=	REGEXREPLACE('^([0-9]+) (PO BOX)$',lFixedCommon,'\\2 \\1');		// Must be in form of "1234 PO BOX" only, with no extraneous chars
			RETURN	lFixReversedPOBox;
		END;

	STRING	fRawFixLineLast(STRING pStringIn) := FUNCTION
			STRING	lFixedCommon				:=	fRawFixCommon(pStringIn);
			STRING	lSplitStateAndZip		:=	REGEXREPLACE('(^| )([A-Z]{2})([0-9]{5})(-?[0-9]{4})?$',lFixedCommon,'\\1\\2 \\3\\4');
			STRING	lDropZip4						:=	REGEXREPLACE('(^| )([0-9]{5})-?[0-9]{4}$',lSplitStateAndZip,'\\1\\2');
			RETURN	lDropZip4;
		END;

	PreppedAddress	:=	IF(firstorlast = 'first',
												fRawFixLine1(address),
												IF(firstorlast = 'last',
													fRawFixLineLast(address),
													ERROR('Please use a valid "first" or "last" address line indicator')
													)
												);										
		
	RETURN PreppedAddress;
END;