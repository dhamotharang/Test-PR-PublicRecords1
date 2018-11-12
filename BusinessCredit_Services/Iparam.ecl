IMPORT AutoStandardI, BIPV2, BatchShare, STD;

EXPORT IParam := MODULE

	EXPORT CompanyIds := INTERFACE
		EXPORT DATASET (BIPV2.IDlayouts.l_xlink_ids2) BusinessIds := DATASET([], BIPV2.IDlayouts.l_xlink_ids2);
		EXPORT STRING120 CompanyName := '';
		EXPORT STRING10	 Company_StreetNumber :=	'';
		EXPORT STRING2	 Company_StreetPreDirection :=	'';
		EXPORT STRING28	 Company_StreetName :=	'';
		EXPORT STRING4	 Company_StreetSuffix := '';
		EXPORT STRING2	 Company_StreetPostDirection := '';
		EXPORT STRING8	 Company_UnitNumber :=	'';
		EXPORT STRING10	 Company_UnitDesignation :=	'';
		EXPORT STRING60	 Company_StreetAddress1 :=	'';
		EXPORT STRING25	 Company_City := '';
		EXPORT STRING2	 Company_State := '';
		EXPORT STRING5	 Company_Zip := '';
		EXPORT STRING10	 Company_Phone := '';
		EXPORT UNSIGNED2 Company_Radius := 0;
		EXPORT STRING11	 Tin := '';
		EXPORT STRING100 Company_URL := '';
		EXPORT STRING100 Company_Email := '';
	END;

	EXPORT AuthRepIDs := INTERFACE (AutoStandardI.InterfaceTranslator.did_value.params)
		Export STRING2 		DLState := '';
		Export STRING50 	DLNumber :=  '';
		EXPORT STRING30 	LastName :=  '';
		EXPORT STRING30 	FirstName :=  '';
		EXPORT STRING30 	MiddleName :=  '';
		EXPORT STRING10 	AuthRep_StreetNumber :=  '';
		EXPORT STRING2 		AuthRep_StreetPreDirection :=  '';
		EXPORT STRING28 	AuthRep_StreetName :=  '';
		EXPORT STRING4 		AuthRep_StreetSuffix :=  '';
		EXPORT STRING2 		AuthRep_StreetPostDirection :=  '';
		EXPORT STRING8 		AuthRep_UnitNumber :=  '';
		EXPORT STRING10		AuthRep_UnitDesignation :=  '';
		EXPORT STRING60 	AuthRep_StreetAddress1 :=  '';
		EXPORT STRING25 	AuthRep_City :=  '';
		EXPORT STRING2 		AuthRep_State :=  '';
		EXPORT STRING5 		AuthRep_Zip :=  '';
		EXPORT STRING10 	AuthRep_Phone :=  '';
		EXPORT UNSIGNED8 	DOB := 0;
		EXPORT STRING11 	SSN :=  '';
	END;
	
	EXPORT reportrecords := INTERFACE(AutoStandardI.InterfaceTranslator.glb_purpose.params, 
																		AutoStandardI.InterfaceTranslator.dppa_purpose.params,
																		AutoStandardI.InterfaceTranslator.ssn_mask_value.params,
																		AutoStandardI.InterfaceTranslator.dob_mask_value.params,
																		AutoStandardI.InterfaceTranslator.application_type_val.params,
																		CompanyIds,
																		AuthRepIDs)
		
		EXPORT STRING  DataPermissionMask 		:= AutoStandardI.Constants.DataPermissionMask_default;
		EXPORT STRING	 DataRestrictionMask 		:= AutoStandardI.Constants.DataRestrictionMask_default;
		EXPORT BOOLEAN Include_BusinessCredit := FALSE;
		EXPORT BOOLEAN LimitPaymentHistory24Months := FALSE;
		EXPORT STRING SBFEContributorIds := '';  
		EXPORT STRING1 FetchLevel 						:= BIPV2.IDconstants.Fetch_Level_SELEID;
    EXPORT BOOLEAN IncludeScores          := TRUE; // Always TRUE unless called from LNSmallBusiness.SmallBusiness_BIP_Combined_Service 
    EXPORT BOOLEAN TestDataEnabled        := FALSE;
		EXPORT STRING  TestDataTableName      := '';
		EXPORT BOOLEAN UseInputDataAsIs       := FALSE;
	END;
	
	EXPORT BatchParams :=
			INTERFACE(BatchShare.IParam.BatchParams);
			EXPORT STRING1 BIPFetchLevel;
			EXPORT UNSIGNED8 MaxSearchResultsPerAcct;
			EXPORT BOOLEAN IncludeBusHeader;
  END;

  // Function to initalize the batch params
	EXPORT getBatchParams() :=	FUNCTION
			BaseBatchParams := BatchShare.IParam.getBatchParams();
			
			inMod := MODULE(PROJECT(BaseBatchParams,BatchParams,OPT))
				EXPORT UNSIGNED8 MaxSearchResultsPerAcct := BusinessCredit_Services.Constants.MaxSearchResultsPerAcct : STORED('Max_Search_Results_Per_Acct');
				EXPORT UNSIGNED8 MaxResultsPerAcct := BusinessCredit_Services.Constants.MaxResultsPerAcct : STORED('Max_Results_Per_Acct');	
				BipFetchLevelTmp := BIPV2.IDconstants.Fetch_Level_SELEID : STORED('BIPFetchLevel');
				EXPORT STRING1 BIPFetchLevel := STD.Str.touppercase(BipFetchLevelTmp);
				EXPORT BOOLEAN IncludeBusHeader := FALSE : STORED('Include_BusHeader');
			END;
			
			RETURN inMod;
	END;
		
END;