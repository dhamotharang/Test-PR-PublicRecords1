IMPORT	dx_Banko,dx_common;
EXPORT	Data_Key_Banko_Delta_rid(BOOLEAN	isFCRA	=	FALSE)	:=	FUNCTION

RETURN PROJECT(File_Banko_FixedJoinRec(isFCRA)(record_sid <> 0),dx_common.layout_ridkey);
								
END;
