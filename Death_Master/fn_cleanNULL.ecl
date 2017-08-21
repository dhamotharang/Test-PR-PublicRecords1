EXPORT	fn_cleanNULL(STRING	pInput)	:=	FUNCTION
	RETURN(IF(StringLib.StringToUpperCase(TRIM(pInput,LEFT,RIGHT))[1..4]='NULL','',TRIM(pInput,LEFT,RIGHT)));
END;
