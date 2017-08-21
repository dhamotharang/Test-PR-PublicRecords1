IMPORT	STD;
EXPORT	fn_removeLeadingZeros	(STRING pInput)	:=	FUNCTION
	pFirstNonZero					:=	STD.Str.FilterOut(pInput,'0')[1];
	pFirstNonZeroPosition	:=	STD.Str.Find(pInput, pFirstNonZero, 1);
	pOutput	:=	IF(TRIM(pInput,ALL)='','',												//	If string is Blank, return Blank
								IF(STD.Str.FilterOut(pInput,'0')='','0',				//	If string is all Zeros, return one Zero
									pInput[(UNSIGNED)pFirstNonZeroPosition..]));	//	Return string with leading zeroes removed
	RETURN	pOutput;
END;