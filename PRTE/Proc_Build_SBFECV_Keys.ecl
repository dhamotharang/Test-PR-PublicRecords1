IMPORT	_control,	 PRTE_CSV,	Business_Credit,	BIPV2_Best_SBFE,	PRTE2_Common;

EXPORT Proc_Build_SBFECV_Keys(string pIndexVersion, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION
	
	is_running_in_prod		:=	PRTE2_Common.Constants.is_running_in_prod;
	doDOPS								:=	is_running_in_prod AND NOT skipDOPS;
	lPRTEkeyTemplate			:=	'~prte::key::'+Business_Credit._Dataset().name+'::'+pIndexVersion+'::';
	
	rKeySBFECV__tradeline__key	:= RECORD
		PRTE_CSV.SBFECV.rthor_data400__key__SBFECV__tradeline;
	END;
                                                       
	dKeySBFECV__tradeline__key	:= 	PROJECT(PRTE_CSV.SBFECV.dthor_data400__key__SBFECV__tradeline, rKeySBFECV__tradeline__key);	
	kKeySBFECV__tradeline__key	:=	INDEX(dKeySBFECV__tradeline__key, {Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,Cycle_End_Date}, {dKeySBFECV__tradeline__key}, lPRTEkeyTemplate + Business_Credit.Keynames().ltradeline);
	
	rKeySBFECV__biclassification__key	:= RECORD
		PRTE_CSV.SBFECV.rthor_data400__key__SBFECV__biclassification;
	END;
                                                       
	dKeySBFECV__biclassification__key	:= 	PROJECT(PRTE_CSV.SBFECV.dthor_data400__key__SBFECV__biclassification, rKeySBFECV__biclassification__key);	
	kKeySBFECV__biclassification__key	:=	INDEX(dKeySBFECV__biclassification__key, {Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported}, {dKeySBFECV__biclassification__key}, lPRTEkeyTemplate + Business_Credit.Keynames().lbiclassification);
	
	rKeySBFECV__businessinformation__key	:= RECORD
		PRTE_CSV.SBFECV.rthor_data400__key__SBFECV__businessinformation;
	END;
                                                       
	dKeySBFECV__businessinformation__key	:= 	PROJECT(PRTE_CSV.SBFECV.dthor_data400__key__SBFECV__businessinformation, rKeySBFECV__businessinformation__key);	
	kKeySBFECV__businessinformation__key	:=	INDEX(dKeySBFECV__businessinformation__key, {Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported}, {dKeySBFECV__businessinformation__key}, lPRTEkeyTemplate + Business_Credit.Keynames().lbusinessinformation);
	
	rKeySBFECV__businessowner__key	:= RECORD
		PRTE_CSV.SBFECV.rthor_data400__key__SBFECV__businessowner;
	END;
                                                       
	dKeySBFECV__businessowner__key	:= 	PROJECT(PRTE_CSV.SBFECV.dthor_data400__key__SBFECV__businessowner, rKeySBFECV__businessowner__key);	
	kKeySBFECV__businessowner__key	:=	INDEX(dKeySBFECV__businessowner__key, {Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported}, {dKeySBFECV__businessowner__key}, lPRTEkeyTemplate + Business_Credit.Keynames().lbusinessowner);
	
	rKeySBFECV__individualowner__key	:= RECORD
		PRTE_CSV.SBFECV.rthor_data400__key__SBFECV__individualowner;
	END;
                                                       
	dKeySBFECV__individualowner__key	:= 	PROJECT(PRTE_CSV.SBFECV.dthor_data400__key__SBFECV__individualowner, rKeySBFECV__individualowner__key);	
	kKeySBFECV__individualowner__key	:=	INDEX(dKeySBFECV__individualowner__key, {Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported}, {dKeySBFECV__individualowner__key}, lPRTEkeyTemplate + Business_Credit.Keynames().lindividualowner);

	rKeySBFECV__linkids__key	:= RECORD
		PRTE_CSV.SBFECV.rthor_data400__key__SBFECV__linkids;
	END;
	
	dKeySBFECV__linkids__key	:= 	PROJECT(PRTE_CSV.SBFECV.dthor_data400__key__SBFECV__linkids, rKeySBFECV__linkids__key);	
	kKeySBFECV__linkids__key	:=	INDEX(dKeySBFECV__linkids__key, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dKeySBFECV__linkids__key}, lPRTEkeyTemplate + Business_Credit.Keynames().llinkids);
	
	rKeySBFECV__history__key	:= RECORD
		PRTE_CSV.SBFECV.rthor_data400__key__SBFECV__history;
	END;
                                                       
	dKeySBFECV__history__key	:= 	PROJECT(PRTE_CSV.SBFECV.dthor_data400__key__SBFECV__history, rKeySBFECV__history__key);	
	kKeySBFECV__history__key	:=	INDEX(dKeySBFECV__history__key, {Sbfe_Contributor_Number,Original_Contract_Account_Number}, {dKeySBFECV__history__key}, lPRTEkeyTemplate + Business_Credit.Keynames().lhistory);
	
	rKeySBFECV__masteraccount__key	:= RECORD
		PRTE_CSV.SBFECV.rthor_data400__key__SBFECV__masteraccount;
	END;
                                                       
	dKeySBFECV__masteraccount__key	:= 	PROJECT(PRTE_CSV.SBFECV.dthor_data400__key__SBFECV__masteraccount, rKeySBFECV__masteraccount__key);	
	kKeySBFECV__masteraccount__key	:=	INDEX(dKeySBFECV__masteraccount__key, {Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported}, {dKeySBFECV__masteraccount__key}, lPRTEkeyTemplate + Business_Credit.Keynames().lmasteraccount);
	
	rKeySBFECV__memberspecific__key	:= RECORD
		PRTE_CSV.SBFECV.rthor_data400__key__SBFECV__memberspecific;
	END;
                                                       
	dKeySBFECV__memberspecific__key	:= 	PROJECT(PRTE_CSV.SBFECV.dthor_data400__key__SBFECV__memberspecific, rKeySBFECV__memberspecific__key);	
	kKeySBFECV__memberspecific__key	:=	INDEX(dKeySBFECV__memberspecific__key, {Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported}, {dKeySBFECV__memberspecific__key}, lPRTEkeyTemplate + Business_Credit.Keynames().lmemberspecific);
	
	rKeySBFECV__ioinformation__key	:= RECORD
		PRTE_CSV.SBFECV.rthor_data400__key__SBFECV__ioinformation;
	END;
                                                       
	dKeySBFECV__ioinformation__key	:= 	PROJECT(PRTE_CSV.SBFECV.dthor_data400__key__SBFECV__ioinformation, rKeySBFECV__ioinformation__key);	
	kKeySBFECV__ioinformation__key	:=	INDEX(dKeySBFECV__ioinformation__key, {did}, {dKeySBFECV__ioinformation__key}, lPRTEkeyTemplate + Business_Credit.Keynames().lioinformation);
	
	rKeySBFECV__boinformation__key	:= RECORD
		PRTE_CSV.SBFECV.rthor_data400__key__SBFECV__boinformation;
	END;
                                                       
	dKeySBFECV__boinformation__key	:= 	PROJECT(PRTE_CSV.SBFECV.dthor_data400__key__SBFECV__boinformation, rKeySBFECV__boinformation__key);	
	kKeySBFECV__boinformation__key	:=	INDEX(dKeySBFECV__boinformation__key, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dKeySBFECV__boinformation__key}, lPRTEkeyTemplate + Business_Credit.Keynames().lboinformation);
	
	rKeySBFECV__collateral__key	:= RECORD
		PRTE_CSV.SBFECV.rthor_data400__key__SBFECV__collateral;
	END;
                                                       
	dKeySBFECV__collateral__key	:= 	PROJECT(PRTE_CSV.SBFECV.dthor_data400__key__SBFECV__collateral, rKeySBFECV__collateral__key);	
	kKeySBFECV__collateral__key	:=	INDEX(dKeySBFECV__collateral__key, {Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported}, {dKeySBFECV__collateral__key}, lPRTEkeyTemplate + Business_Credit.Keynames().lcollateral);
	
	rKeySBFECV__releasedates__key	:= RECORD
		PRTE_CSV.SBFECV.rthor_data400__key__SBFECV__releasedates;
	END;
                                                       
	dKeySBFECV__releasedates__key	:= 	PROJECT(PRTE_CSV.SBFECV.dthor_data400__key__SBFECV__releasedates, rKeySBFECV__releasedates__key);	
	kKeySBFECV__releasedates__key	:=	INDEX(dKeySBFECV__releasedates__key, {version}, {dKeySBFECV__releasedates__key}, lPRTEkeyTemplate + Business_Credit.Keynames().lreleasedate);
	
	rKeySBFECV__tradelineguarantor__key	:= RECORD
		PRTE_CSV.SBFECV.rthor_data400__key__SBFECV__tradelineguarantor;
	END;
                                                       
	dKeySBFECV__tradelineguarantor__key	:= 	PROJECT(PRTE_CSV.SBFECV.dthor_data400__key__SBFECV__tradelineguarantor, rKeySBFECV__tradelineguarantor__key);	
	kKeySBFECV__tradelineguarantor__key	:=	INDEX(dKeySBFECV__tradelineguarantor__key, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dKeySBFECV__tradelineguarantor__key}, lPRTEkeyTemplate + Business_Credit.Keynames().ltradelineguarantor);

	rKeyBestSBFECV__linkids__key	:= RECORD
		PRTE_CSV.SBFECV.rthor_data400__key__BestSBFECV__linkids;
	END;
	
	dKeyBestSBFECV__linkids__key	:= 	PROJECT(PRTE_CSV.SBFECV.dthor_data400__key__BestSBFECV__linkids, rKeyBestSBFECV__linkids__key);	
	kKeyBestSBFECV__linkids__key	:=	INDEX(dKeyBestSBFECV__linkids__key, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dKeyBestSBFECV__linkids__key}, lPRTEkeyTemplate + BIPV2_Best_SBFE.Keynames().lbipv2bestlinkids);

	//---------- making DOPS optional and only in PROD build -------------------------------													
	notifyEmail 						:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 								:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');						
	PerformUpdate 					:= PRTE.UpdateVersion('SBFECVKeys',							//	Package name
																								pIndexVersion,						//	Package version
																								notifyEmail,							//	Who to email with specifics
																								'B',											//	B = Boca, A = Alpharetta
																								'N',											//	N = Non-FCRA, F = FCRA
																								'N'												//	N = Do not also include boolean, Y = Include boolean, too
																								);
	PerformUpdateOrNot 			:= IF(doDOPS,PerformUpdate,NoUpdate);

	RETURN	SEQUENTIAL(	BUILD(kKeySBFECV__tradeline__key, UPDATE),
											BUILD(kKeySBFECV__biclassification__key, UPDATE),
											BUILD(kKeySBFECV__businessinformation__key, UPDATE),
											BUILD(kKeySBFECV__businessowner__key, UPDATE),
											BUILD(kKeySBFECV__individualowner__key, UPDATE),
											BUILD(kKeySBFECV__linkids__key, UPDATE),
											BUILD(kKeySBFECV__history__key, UPDATE),
											BUILD(kKeySBFECV__masteraccount__key, UPDATE),
											BUILD(kKeySBFECV__memberspecific__key, UPDATE),
											BUILD(kKeySBFECV__ioinformation__key, UPDATE),
											BUILD(kKeySBFECV__boinformation__key, UPDATE),
											BUILD(kKeySBFECV__collateral__key, UPDATE),
											BUILD(kKeySBFECV__releasedates__key, UPDATE),
											BUILD(kKeySBFECV__tradelineguarantor__key, UPDATE),
											BUILD(kKeyBestSBFECV__linkids__key, UPDATE),
											PerformUpdateOrNot);

END;
