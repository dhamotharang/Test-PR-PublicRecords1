EXPORT STRING ExtractString (STRING pString, unsigned2 pInstance, STRING pDelim = '|') := FUNCTION
	
	SET OF STRING120	S_Name := STRINGLIB.SPLITWORDS(pString, pDelim, true);
	
	RETURN TRIM(S_NAME [pInstance],LEFT,RIGHT);		
END;			
