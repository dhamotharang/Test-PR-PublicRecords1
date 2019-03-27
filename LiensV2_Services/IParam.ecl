IMPORT AutoHeaderI, AutokeyI, AutoStandardI, BatchShare, BIPV2, 
       Suppress, TopBusiness_Services, FCRA;

EXPORT IParam := MODULE
	
	shared it 				:= AutoStandardI.InterfaceTranslator;	
	shared common_params := interface(it.did_value.params,
																		it.bdid_value.params,
																		it.lname_value.params,
																		it.state_value.params
																		)
		export string CertificateNumber := '';
		export unsigned2 	pt := 10;
	end;
	
	export base_params := interface(
		AutoKeyI.AutoKeyStandardFetchBaseInterface,
		AutoHeaderI.LIBIN.FetchI_Hdr_Indv.base,
		AutoHeaderI.LIBIN.FetchI_Hdr_Biz.base)
	end;
	
	export ak_params := interface(common_params,
																base_params,
																it.ssn_mask_val.params,
																it.party_type.params
																)
		export boolean nodeepdive := false;
	end;
	
	export search_params := INTERFACE(ak_params,
																		it.maxresults_val.params,
																		it.liencasenumber_value.params,
																		it.FilingNumber_value.params,
																		it.FilingJurisdiction_value.params,
																		it.IRSSerialNumber_value.params,
																		it.rmsid_value.params,
																		it.tmsid_value.params,
																		TopBusiness_Services.iParam.BIDParams,
																		FCRA.iRules)
			export integer1 non_subject_suppression 	:= Suppress.Constants.NonSubjectSuppression.doNothing;
			export string person_filter_id := '';
			export boolean includeCriminalIndicators := false;
			export boolean subject_only := false;
	END;

	EXPORT batch_params := INTERFACE (BatchShare.IParam.BatchParamsV2,FCRA.iRules)
		EXPORT SET OF STRING1 party_types := ['A','C','D',''];
		EXPORT BOOLEAN no_did_append			:= FALSE;
		EXPORT BOOLEAN no_bdid_append		 	:= FALSE;
		// Preferential matching:
		EXPORT BOOLEAN MatchName     			:= FALSE;
		EXPORT BOOLEAN MatchStrAddr  			:= FALSE;     
		EXPORT BOOLEAN MatchCity     			:= FALSE;
		EXPORT BOOLEAN MatchState    			:= FALSE;       
		EXPORT BOOLEAN MatchZip      			:= FALSE;         
		EXPORT BOOLEAN MatchSSN      			:= FALSE;  
		//Non Subject Suppression param
		EXPORT INTEGER1 non_subject_suppression := Suppress.Constants.NonSubjectSuppression.doNothing;
    EXPORT STRING1  BIPFetchLevel := BIPV2.IDconstants.Fetch_Level_SELEID;
	END;
END;