IMPORT	dx_Banko;
EXPORT	data_Key_Banko_courtcode_fullcasenumber(BOOLEAN	isFCRA	=	FALSE)	:=	FUNCTION

	//	Create a slim version of Banko.Key_Banko_courtcode_casenumber 
rSlimFileBankoFixedJoinRec	:=	RECORD
	BankoJoinRecord.CaseKey;
	BankoJoinRecord.BKCaseNumber;
	BankoJoinRecord.CaseID;
	BankoJoinRecord.court_code;
END;

dSlimFileBankoFixedJoinRec			:=	PROJECT(File_Banko_FixedJoinRec(isFCRA),rSlimFileBankoFixedJoinRec);
dSlimFileBankoFixedJoinRecDedup	:=	DEDUP(SORT(DISTRIBUTE(dSlimFileBankoFixedJoinRec),RECORD,LOCAL),RECORD,LOCAL);

RETURN PROJECT(dSlimFileBankoFixedJoinRecDedup, dx_Banko.layouts.i_Layout_Key_Banko_CourtCode_FullCaseNumber);
								
END;

