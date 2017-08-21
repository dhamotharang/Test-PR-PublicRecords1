IMPORT	_control,	 PRTE_CSV,	Banko,	PRTE2_Common;
EXPORT	Proc_Build_BKEvents_Keys(STRING	pIndexVersion,	BOOLEAN	skipDOPS=FALSE,	STRING	emailTo='')	:=	FUNCTION
	
	is_running_in_prod			:=	PRTE2_Common.Constants.is_running_in_prod;
	doDOPS									:=	is_running_in_prod AND NOT skipDOPS;
	lPRTEkeyTemplate				:=	'~prte::key::banko::'+pIndexVersion+'::';
	lPRTEFCRAkeyTemplate		:=	'~prte::key::banko::fcra::'+pIndexVersion+'::';
	lPRTECasenumberName			:=	'courtcode.casenumber.caseid.payload';
	lPRTEFullCasenumberName	:=	'courtcode.fullcasenumber.caseid.payload';
	
//	Non FCRA
	rKeyBanko__courtcode_casenumber_caseid_payload__key	:= RECORD
		PRTE_CSV.BKEvents.rthor_data400__key__Banko__courtcode_casenumber_caseid_payload;
	END;
                                                       
	dKeyBanko__courtcode_casenumber_caseid_payload__key	:= 	PROJECT(PRTE_CSV.BKEvents.dthor_data400__key__Banko__courtcode_casenumber_caseid_payload, rKeyBanko__courtcode_casenumber_caseid_payload__key);	
	kKeyBanko__courtcode_casenumber_caseid_payload__key	:=	INDEX(dKeyBanko__courtcode_casenumber_caseid_payload__key, {court_code,casekey,CaseID}, {dKeyBanko__courtcode_casenumber_caseid_payload__key}, lPRTEkeyTemplate + lPRTECasenumberName);
	
	rKeyBanko__courtcode_fullcasenumber_caseid_payload__key	:= RECORD
		PRTE_CSV.BKEvents.rthor_data400__key__Banko__courtcode_fullcasenumber_caseid_payload;
	END;
                                                       
	dKeyBanko__courtcode_fullcasenumber_caseid_payload__key	:= 	PROJECT(PRTE_CSV.BKEvents.dthor_data400__key__Banko__courtcode_fullcasenumber_caseid_payload, rKeyBanko__courtcode_fullcasenumber_caseid_payload__key);	
	kKeyBanko__courtcode_fullcasenumber_caseid_payload__key	:=	INDEX(dKeyBanko__courtcode_fullcasenumber_caseid_payload__key, {court_code,BKCaseNumber,CaseID}, {dKeyBanko__courtcode_fullcasenumber_caseid_payload__key}, lPRTEkeyTemplate + lPRTEFullCasenumberName);
	
// FCRA
	rKeyBanko__FCRA__courtcode_casenumber_caseid_payload__key	:= RECORD
		PRTE_CSV.BKEvents.rthor_data400__key__Banko__FCRA__courtcode_casenumber_caseid_payload;
	END;
                                                       
	dKeyBanko__FCRA__courtcode_casenumber_caseid_payload__key	:= 	PROJECT(PRTE_CSV.BKEvents.dthor_data400__key__Banko__FCRA__courtcode_casenumber_caseid_payload, rKeyBanko__FCRA__courtcode_casenumber_caseid_payload__key);	
	kKeyBanko__FCRA__courtcode_casenumber_caseid_payload__key	:=	INDEX(dKeyBanko__FCRA__courtcode_casenumber_caseid_payload__key, {court_code,casekey,CaseID}, {dKeyBanko__FCRA__courtcode_casenumber_caseid_payload__key}, lPRTEFCRAkeyTemplate + lPRTECasenumberName);
	
	rKeyBanko__FCRA__courtcode_fullcasenumber_caseid_payload__key	:= RECORD
		PRTE_CSV.BKEvents.rthor_data400__key__Banko__FCRA__courtcode_fullcasenumber_caseid_payload;
	END;
                                                       
	dKeyBanko__FCRA__courtcode_fullcasenumber_caseid_payload__key	:= 	PROJECT(PRTE_CSV.BKEvents.dthor_data400__key__Banko__FCRA__courtcode_fullcasenumber_caseid_payload, rKeyBanko__FCRA__courtcode_fullcasenumber_caseid_payload__key);	
	kKeyBanko__FCRA__courtcode_fullcasenumber_caseid_payload__key	:=	INDEX(dKeyBanko__FCRA__courtcode_fullcasenumber_caseid_payload__key, {court_code,BKCaseNumber,CaseID}, {dKeyBanko__FCRA__courtcode_fullcasenumber_caseid_payload__key}, lPRTEFCRAkeyTemplate + lPRTEFullCasenumberName);

	//---------- making DOPS optional and only in PROD build -------------------------------													
	notifyEmail 						:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 								:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');						
	PerformUpdate 					:= PRTE.UpdateVersion('BKEventsKeys',						//	Package name
																								pIndexVersion,						//	Package version
																								notifyEmail,							//	Who to email with specifics
																								'B',											//	B = Boca, A = Alpharetta
																								'N',											//	N = Non-FCRA, F = FCRA
																								'N'												//	N = Do not also include boolean, Y = Include boolean, too
																								);
	PerformUpdateOrNot 			:= IF(doDOPS,PerformUpdate,NoUpdate);

	RETURN	SEQUENTIAL(	BUILD(kKeyBanko__courtcode_casenumber_caseid_payload__key, UPDATE),
											BUILD(kKeyBanko__courtcode_fullcasenumber_caseid_payload__key, UPDATE),
											BUILD(kKeyBanko__FCRA__courtcode_casenumber_caseid_payload__key, UPDATE),
											BUILD(kKeyBanko__FCRA__courtcode_fullcasenumber_caseid_payload__key, UPDATE),
											PerformUpdateOrNot);

END;
