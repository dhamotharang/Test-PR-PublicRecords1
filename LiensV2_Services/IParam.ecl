IMPORT AutoHeaderI, AutokeyI, AutoStandardI, BatchShare, BIPV2,
       Suppress, TopBusiness_Services, FCRA, FFD, iesp, Address, DeathV2_Services, Doxie;

EXPORT IParam := MODULE

	SHARED it := AutoStandardI.InterfaceTranslator;
	SHARED common_params    := INTERFACE(it.did_value.params,
                                         it.bdid_value.params,
                                         it.lname_value.params,
                                         it.state_value.params)
	EXPORT string CertificateNumber := '';
	EXPORT unsigned2 	pt := 10;
	END;

	EXPORT base_params := INTERFACE(
		AutoKeyI.AutoKeyStandardFetchBaseInterface,
		AutoHeaderI.LIBIN.FetchI_Hdr_Indv.base,
		AutoHeaderI.LIBIN.FetchI_Hdr_Biz.base)
	END;

	EXPORT ak_params := INTERFACE(common_params,
                                  base_params,
                                  it.ssn_mask_val.params,
                                  it.party_type.params)
	EXPORT boolean nodeepdive := FALSE;
	END;

	EXPORT search_params := INTERFACE(ak_params,
                                     it.maxresults_val.params,
                                     it.liencasenumber_value.params,
                                     it.FilingNumber_value.params,
                                     it.FilingJurisdiction_value.params,
                                     it.IRSSerialNumber_value.params,
                                     it.rmsid_value.params,
                                     it.tmsid_value.params,
                                     TopBusiness_Services.iParam.BIDParams,
                                     FCRA.iRules)
	EXPORT integer1 non_subject_suppression 	:= Suppress.Constants.NonSubjectSuppression.doNothing;
	EXPORT string person_filter_id := '';
	EXPORT boolean includeCriminalIndicators := FALSE;
	EXPORT boolean subject_only := FALSE;
	END;

	EXPORT batch_params := INTERFACE (BatchShare.IParam.BatchParams,FCRA.iRules)
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

	EXPORT liensRetrieval_params := INTERFACE (FCRA.iRules,  DeathV2_Services.IParam.DeathRestrictions)
        EXPORT STRING32 DeferredTransactionID := ''; // for deferred request
        EXPORT STRING32 TransactionID := ''; // to pass to okc gateway
        EXPORT BOOLEAN  DeferredTaskRequest := FALSE;
        EXPORT BOOLEAN  InputOk := FALSE;
    END;

	EXPORT GetLiensRetrievalParams(iesp.riskview_publicrecordretrieval.t_PublicRecordRetrievalRequest request) := FUNCTION

       options   := request.options;
       search_by := request.SearchBy;

	   //validating the minimum required input fields in the request

         boolean hasFirstName := search_by.Name.First <> '';
         boolean hasLastName := search_by.Name.Last <> '';
         string60 StreetAddrComp := Address.Addr1FromComponents(search_by.Address.StreetNumber, search_by.Address.StreetPreDirection,	search_by.Address.StreetName,
                                                            search_by.Address.StreetSuffix, search_by.Address.StreetPostDirection, search_by.Address.UnitDesignation,
                                                            search_by.Address.UnitNumber);
   	     boolean hasStreetAddress := search_by.Address.StreetAddress1 <> '' OR StreetAddrComp <>'';
         boolean hasCity := search_by.Address.City <> '';
   	     boolean hasState := search_by.Address.State <>'';
   	     boolean hasZip5 := search_by.Address.Zip5 <> '';
         boolean hasSSN := search_by.SSN <> '';
         boolean hasFilingTypeID := search_by.FilingTypeID <> '';
         boolean hasFilingNumber := search_by.FilingNumber <>'';
         boolean hasBook  := search_by.FilingBook <> '';
         boolean hasPage  := search_by.FilingPage <> '';
         boolean hasRecordID := search_by.RecordID <> '';
         boolean hasAgency := search_by.Agency <> '';
         boolean hasAgencyCounty := search_by.AgencyCounty <> '';
         boolean hasAgencyState := search_by.AgencyState <> '';
         boolean hasAgencyID  := search_by.AgencyID <> '';

       // checking for insufficinet input
         input_ok := ((hasFirstName and hasLastName and hasStreetAddress and hasZip5) OR
                   (hasFirstName and hasLastName and hasStreetAddress and hasCity and hasState) OR
                   (hasFirstName and hasLastName and hasSSN))
                    AND
                  ((hasFilingTypeID and (hasFilingNumber or (hasBook and hasPage))) OR hasRecordID)
                    AND
                  ((hasAgency and hasAgencyCounty and hasAgencyState) OR hasAgencyID);

        mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
        death_params := DeathV2_Services.IParam.GetRestrictions(mod_access);
        params := MODULE(PROJECT(death_params, liensRetrieval_params, OPT))
        // EXPORT UNSIGNED6 did              := UniqueId;
         EXPORT INTEGER8 FFDOptionsMask    := FFD.FFDMask.Get(options.FFDOptionsMask);
         EXPORT INTEGER FCRAPurpose        := FCRA.FCRAPurpose.Get(options.FCRAPurpose);
         EXPORT STRING32 DeferredTransactionID := options.DeferredTransactionID;
         EXPORT STRING32 TransactionID         := mod_access.transaction_id;
         EXPORT BOOLEAN DeferredTaskRequest := DeferredTransactionID <> '';
         EXPORT BOOLEAN InputOk             := input_ok;
         END;
         RETURN params;
	END;
END;