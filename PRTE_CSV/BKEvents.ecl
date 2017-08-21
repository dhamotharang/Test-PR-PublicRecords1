IMPORT	PRTE2_Common,	Banko,	STD;

EXPORT	BKEvents	:=	MODULE

	SHARED	lSubDirName					:=	'';
	SHARED	lCSVVersion					:=	(STRING8)Std.Date.Today();
	SHARED	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
//	Non FCRA
	EXPORT	rthor_data400__key__Banko__courtcode_casenumber_caseid_payload	:=	RECORD
		RECORDOF(Banko.Key_Banko_courtcode_casenumber(FALSE));
	END;
	
	EXPORT	rthor_data400__key__Banko__courtcode_fullcasenumber_caseid_payload	:=	RECORD
		RECORDOF(Banko.Key_Banko_courtcode_fullcasenumber(FALSE));
	END;

	EXPORT	dthor_data400__key__Banko__courtcode_casenumber_caseid_payload						:=	DATASET([], rthor_data400__key__Banko__courtcode_casenumber_caseid_payload);
	EXPORT	dthor_data400__key__Banko__courtcode_fullcasenumber_caseid_payload				:=	DATASET([], rthor_data400__key__Banko__courtcode_fullcasenumber_caseid_payload);
	
// FCRA
	EXPORT	rthor_data400__key__Banko__FCRA__courtcode_casenumber_caseid_payload	:=	RECORD
		RECORDOF(Banko.Key_Banko_courtcode_casenumber(TRUE));
	END;
	
	EXPORT	rthor_data400__key__Banko__FCRA__courtcode_fullcasenumber_caseid_payload	:=	RECORD
		RECORDOF(Banko.Key_Banko_courtcode_fullcasenumber(TRUE));
	END;

	EXPORT	dthor_data400__key__Banko__FCRA__courtcode_casenumber_caseid_payload			:=	DATASET([], rthor_data400__key__Banko__FCRA__courtcode_casenumber_caseid_payload);
	EXPORT	dthor_data400__key__Banko__FCRA__courtcode_fullcasenumber_caseid_payload	:=	DATASET([], rthor_data400__key__Banko__FCRA__courtcode_fullcasenumber_caseid_payload);

END;
