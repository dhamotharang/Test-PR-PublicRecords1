IMPORT	PRTE2_Common,	Business_Credit,	BIPV2_Best_SBFE,	ut;

EXPORT	SBFECV	:=	MODULE

	SHARED	lSubDirName					:=	'';
	SHARED	lCSVVersion					:=	ut.GetDate;
	SHARED	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
	EXPORT	rthor_data400__key__SBFECV__tradeline	:=	RECORD
		RECORDOF(Business_Credit.key_tradeline());
	END;
	
	EXPORT	rthor_data400__key__SBFECV__biclassification	:=	RECORD
		RECORDOF(Business_Credit.Key_BusinessClassification());
	END;
	
	EXPORT	rthor_data400__key__SBFECV__businessinformation	:=	RECORD
		RECORDOF(Business_Credit.Key_BusinessInformation());
	END;
	
	EXPORT	rthor_data400__key__SBFECV__businessowner	:=	RECORD
		RECORDOF(Business_Credit.Key_BusinessOwner());
	END;
	
	EXPORT	rthor_data400__key__SBFECV__individualowner	:=	RECORD
		RECORDOF(Business_Credit.Key_IndividualOwner());
	END;
	
	EXPORT	rthor_data400__key__SBFECV__linkids	:=	RECORD
		RECORDOF(Business_Credit.Key_LinkIds().key);
	END;
	
	EXPORT	rthor_data400__key__SBFECV__history	:=	RECORD
		RECORDOF(Business_Credit.Key_History());
	END;
	
	EXPORT	rthor_data400__key__SBFECV__masteraccount	:=	RECORD
		RECORDOF(Business_Credit.Key_MasterAccount());
	END;
	
	EXPORT	rthor_data400__key__SBFECV__memberspecific	:=	RECORD
		RECORDOF(Business_Credit.Key_MemberSpecific());
	END;
	
	EXPORT	rthor_data400__key__SBFECV__ioinformation	:=	RECORD
		RECORDOF(Business_Credit.Key_IndividualOwnerInformation());
	END;
	
	EXPORT	rthor_data400__key__SBFECV__boinformation	:=	RECORD
		RECORDOF(Business_Credit.Key_BusinessOwnerInformation().key);
	END;
	
	EXPORT	rthor_data400__key__SBFECV__collateral	:=	RECORD
		RECORDOF(Business_Credit.Key_Collateral());
	END;
	
	EXPORT	rthor_data400__key__SBFECV__releasedates	:=	RECORD
		RECORDOF(Business_Credit.Key_ReleaseDates());
	END;
	
	EXPORT	rthor_data400__key__SBFECV__tradelineguarantor	:=	RECORD
		RECORDOF(Business_Credit.Key_TradelineGuarantor().key);
	END;
	
	EXPORT	rthor_data400__key__BestSBFECV__linkids	:=	RECORD
		RECORDOF(BIPV2_Best_SBFE.Key_LinkIds().key);
	END;

	EXPORT	dthor_data400__key__SBFECV__tradeline						:=	DATASET([], rthor_data400__key__SBFECV__tradeline);
	EXPORT	dthor_data400__key__SBFECV__biclassification		:=	DATASET([], rthor_data400__key__SBFECV__biclassification);
	EXPORT	dthor_data400__key__SBFECV__businessinformation	:=	DATASET([], rthor_data400__key__SBFECV__businessinformation);
	EXPORT	dthor_data400__key__SBFECV__businessowner				:=	DATASET([], rthor_data400__key__SBFECV__businessowner);
	EXPORT	dthor_data400__key__SBFECV__individualowner			:=	DATASET([], rthor_data400__key__SBFECV__individualowner);
	EXPORT	dthor_data400__key__SBFECV__linkids							:=	DATASET([], rthor_data400__key__SBFECV__linkids);
	EXPORT	dthor_data400__key__SBFECV__history							:=	DATASET([], rthor_data400__key__SBFECV__history);
	EXPORT	dthor_data400__key__SBFECV__masteraccount				:=	DATASET([], rthor_data400__key__SBFECV__masteraccount);
	EXPORT	dthor_data400__key__SBFECV__memberspecific			:=	DATASET([], rthor_data400__key__SBFECV__memberspecific);
	EXPORT	dthor_data400__key__SBFECV__ioinformation				:=	DATASET([], rthor_data400__key__SBFECV__ioinformation);
	EXPORT	dthor_data400__key__SBFECV__boinformation				:=	DATASET([], rthor_data400__key__SBFECV__boinformation);
	EXPORT	dthor_data400__key__SBFECV__collateral					:=	DATASET([], rthor_data400__key__SBFECV__collateral);
	EXPORT	dthor_data400__key__SBFECV__releasedates				:=	DATASET([], rthor_data400__key__SBFECV__releasedates);
	EXPORT	dthor_data400__key__SBFECV__tradelineguarantor	:=	DATASET([], rthor_data400__key__SBFECV__tradelineguarantor);
	EXPORT	dthor_data400__key__BestSBFECV__linkids					:=	DATASET([], rthor_data400__key__BestSBFECV__linkids);

END;
