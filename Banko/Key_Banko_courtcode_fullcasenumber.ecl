IMPORT	STD;
EXPORT	Key_Banko_courtcode_fullcasenumber(BOOLEAN	isFCRA	=	FALSE)	:=	FUNCTION

	//	Get the Key Name
key_name	:=	Banko.BuildFullKeyName(isFCRA);

	//	Create a slim version of Banko.Key_Banko_courtcode_casenumber 
rSlimFileBankoFixedJoinRec	:=	RECORD
	BankoJoinRecord.CaseKey;
	BankoJoinRecord.BKCaseNumber;
	BankoJoinRecord.CaseID;
	BankoJoinRecord.court_code;
END;

dSlimFileBankoFixedJoinRec			:=	PROJECT(File_Banko_FixedJoinRec(isFCRA),rSlimFileBankoFixedJoinRec);
dSlimFileBankoFixedJoinRecDedup	:=	DEDUP(SORT(DISTRIBUTE(dSlimFileBankoFixedJoinRec),RECORD,LOCAL),RECORD,LOCAL);

RETURN INDEX(dSlimFileBankoFixedJoinRecDedup,
					{court_code,BKCaseNumber,CaseID},
					{dSlimFileBankoFixedJoinRec},
					key_name);									
END;