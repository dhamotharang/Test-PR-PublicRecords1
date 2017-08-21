IMPORT BairRx_Common, BairRx_PSS, iesp, Bair_ExternalLinkKeys, ut;

EXPORT IParam := MODULE
	
	SHARED GetAgencyORI(iesp.bair_share.t_BAIRUser user) := FUNCTION
		agencyORI := TRIM(user.AgencyORI, LEFT, RIGHT);
		err_code := IF(agencyORI = '', BairRx_Common.STDError.MissingAgencyORI, 0);		
		BairRx_Common.STDError.CFail(err_code <> 0, err_code);		
		RETURN IF(err_code=0, agencyORI, ''); 
	END;
	
	// ------------ PERSON SEARCH -------	
	EXPORT PersonSearchParam := RECORD(BairRx_PSS.SALTLayout.LayoutIn)
		BOOLEAN  ReturnMatchScores;
		BOOLEAN  IncludeNoDIDRecs;
		INTEGER2 AgeLow          := 0;
		INTEGER2 AgeHigh         := 0;
	END;
	
	
	EXPORT GetPersonSearchParams(iesp.bair_person.t_BAIRPersonSearchBy searchBy, iesp.bair_person.t_BAIRPersonSearchOption options,	iesp.bair_share.t_BAIRUser user) := FUNCTION
	
		// err_code := MAP(
			// _agencyORI='' => BairRx_Common.STDError.MissingAgencyORI,
			// 0);					
		// BairRx_Common.STDError.CFail(err_code <> 0, err_code);		
		validRequest := TRUE;	

		baseSearchBy := PROJECT(searchBy, TRANSFORM(iesp.bair_share.t_BAIRBasePSSearchBy, SELF := LEFT, SELF := []));
		baseOptions := PROJECT(options, TRANSFORM(iesp.bair_share.t_BAIRBasePSSearchOption, SELF := LEFT, SELF := []));
		SALTParams := BairRx_PSS.SALTParam.GetInput(baseSearchBy, baseOptions, user);

		includeAllSources := ~options.IncludeEvents AND ~options.IncludeCFS AND ~options.IncludeCrash AND ~options.IncludeLPR AND ~options.IncludeOffenders;

		inParams := PROJECT(SALTParams, TRANSFORM(PersonSearchParam,
			SELF.ReturnMatchScores := options.ReturnScores,
			SELF.IncludeNoDIDRecs := ~options.ExcludeRecordsWithNoLexID;
			SELF.IncludeEvents := options.IncludeEvents OR includeAllSources,
			SELF.IncludeCrash := options.IncludeCrash OR includeAllSources,
			SELF.IncludeCFS := options.IncludeCFS OR includeAllSources,
			SELF.IncludeLPR := options.IncludeLPR OR includeAllSources,
			SELF.IncludeOffenders := options.IncludeOffenders OR includeAllSources,
			SELF.AgencyORI := GetAgencyORI(user);
			SELF.AgeLow    := searchBy.AgeRange.Low;
			SELF.AgeHigh   := searchBy.AgeRange.High;
			SELF := LEFT
			));


			RETURN IF(validRequest, inParams, DATASET([],PersonSearchParam)); 
	END;
		
		
	// ------------ PERSON REPORT --------------

	EXPORT PersonReportParam := RECORD(BairRx_PSS.SALTLayout.LayoutIn)
	END;	
	

	EXPORT GetPersonReportParams(iesp.bair_person.t_BAIRPersonReportBy ReportBy, iesp.bair_person.t_BAIRPersonReportOption options, iesp.bair_share.t_BAIRUser User) := FUNCTION
		
		// err_code := MAP(
			// _agencyORI='' => BairRx_Common.STDError.MissingAgencyORI,
			// 0);					
		// BairRx_Common.STDError.CFail(err_code <> 0, err_code);		
		validRequest := TRUE;	

		baseSearchBy := PROJECT(ReportBy, TRANSFORM(iesp.bair_share.t_BAIRBasePSSearchBy, SELF := LEFT, SELF := []));
		// baseOptions := PROJECT(options, TRANSFORM(iesp.bair_share.t_BAIRBasePSSearchOption, SELF := LEFT, SELF := []));
		SALTParams := BairRx_PSS.SALTParam.GetInput(baseSearchBy, options, user);

		includeAllSources := ~options.IncludeEvents AND ~options.IncludeCFS AND ~options.IncludeCrash AND ~options.IncludeOffenders;

		inParams := PROJECT(SALTParams, TRANSFORM(PersonReportParam,
			// SELF.ReturnMatchScores := options.ReturnScores,
			// SELF.IncludeNoDIDRecs := ~options.ExcludeRecordsWithNoLexID;
			SELF.IncludeEvents := options.IncludeEvents OR includeAllSources,
			SELF.IncludeCrash := options.IncludeCrash OR includeAllSources,
			SELF.IncludeCFS := options.IncludeCFS OR includeAllSources,
			// SELF.IncludeLPR := options.IncludeLPR OR includeAllSources,
			SELF.IncludeOffenders := options.IncludeOffenders OR includeAllSources,
			SELF.AgencyORI := GetAgencyORI(User);
			SELF := LEFT
			));

		RETURN IF(validRequest, inParams, DATASET([], PersonReportParam)); 
		
	END;	
	
	
	EXPORT SetReportOptions (iesp.bair_person.t_BAIRPersonReportOption options) := FUNCTION	
		boolean IncludeNotes := options.IncludeNotes;
		#stored ('IncludeNotes', IncludeNotes);
    integer MaxResults := options.MaxResults;
    #stored ('MaxResults', MaxResults);		
		return OUTPUT (dataset ([],{integer x}), named('__internal__'), extend);
  END;
	
	
	// ------------ VEHICLES -------
	
	EXPORT VehicleSearchParam := RECORD(BairRx_PSS.SALTLayout.LayoutIn) 
		BOOLEAN ReturnMatchScores;
		unsigned MaxVehicleParties;
		unsigned MaxVehicles;
	END;


	EXPORT GetVehicleSearchParams(iesp.bair_vehiclesearch.t_BAIRVehicleSearchBy searchBy, iesp.bair_vehiclesearch.t_BAIRVehicleSearchOption options,	iesp.bair_share.t_BAIRUser user) := FUNCTION
			
		// err_code := MAP(
			// _agencyORI='' => BairRx_Common.STDError.MissingAgencyORI,
			// 0);					
		// BairRx_Common.STDError.CFail(err_code <> 0, err_code);		
		validRequest := TRUE;	

		baseSearchBy := PROJECT(searchBy, TRANSFORM(iesp.bair_share.t_BAIRBasePSSearchBy, SELF := LEFT, SELF := []));
		baseOptions := PROJECT(options, TRANSFORM(iesp.bair_share.t_BAIRBasePSSearchOption, SELF := LEFT, SELF := []));
		SALTParams := BairRx_PSS.SALTParam.GetInput(baseSearchBy, baseOptions, user);

		includeAllSources := ~options.IncludeEvents AND ~options.IncludeCrash AND ~options.IncludeLPR;

		inParams := PROJECT(SALTParams, TRANSFORM(VehicleSearchParam,
			SELF.ReturnMatchScores := options.ReturnScores,
			SELF.IncludeEvents := options.IncludeEvents OR includeAllSources,
			SELF.IncludeCrash := options.IncludeCrash OR includeAllSources,
			SELF.IncludeLPR := options.IncludeLPR OR includeAllSources,
			SELF.IncludeOffenders := FALSE, 
			SELF.IncludeCFS := FALSE,
			SELF.AgencyORI := GetAgencyORI(user),
			SELF.MaxVehicleParties := if(options.MaxVehicleParties>0, min(options.MaxVehicleParties, iesp.bair_constants.MAX_PARTIES_PER_INCIDENT), iesp.bair_constants.MAX_PARTIES_PER_INCIDENT),
			SELF.MaxVehicles       := if(options.MaxVehicles>0, min(options.MaxVehicles, iesp.bair_constants.MAX_VEHICLES_PER_INCIDENT), iesp.bair_constants.MAX_VEHICLES_PER_INCIDENT),
			SELF := LEFT
			));

			RETURN IF(validRequest, inParams, DATASET([],VehicleSearchParam)); 
	END;


	// -------------Phone----------------------	

	EXPORT PhoneSearchParam := RECORD(BairRx_PSS.SALTLayout.LayoutIn)
		BOOLEAN ReturnMatchScores;
		BOOLEAN SearchNarratives;
	END;

	EXPORT GetPhoneSearchParams(iesp.bair_phonesearch.t_BAIRPhoneSearchBy searchBy, iesp.bair_phonesearch.t_BAIRPhoneSearchOption options,	iesp.bair_share.t_BAIRUser user) := FUNCTION
			
		// err_code := MAP(
			// _agencyORI='' => BairRx_Common.STDError.MissingAgencyORI,
			// 0);					
		// BairRx_Common.STDError.CFail(err_code <> 0, err_code);		
		validRequest := TRUE;	

		// default to include ALL if none is specified
		includeAllSources := ~options.IncludeEvents AND ~options.IncludeCFS;
		
		baseSearchBy := PROJECT(searchBy, TRANSFORM(iesp.bair_share.t_BAIRBasePSSearchBy, SELF := LEFT, SELF := []));
		baseOptions := PROJECT(options, TRANSFORM(iesp.bair_share.t_BAIRBasePSSearchOption, SELF := LEFT, SELF := []));
		SALTParams := BairRx_PSS.SALTParam.GetInput(baseSearchBy, baseOptions, user);
	

		inParams := PROJECT(SALTParams, TRANSFORM(PhoneSearchParam,
			SELF.ReturnMatchScores := options.ReturnScores,
			SELF.IncludeEvents := options.IncludeEvents OR includeAllSources,
			SELF.IncludeCFS := options.IncludeCFS OR includeAllSources,
			SELF.AgencyORI := GetAgencyORI(user),
			SELF.SearchNarratives := options.SearchPhonesInNarratives,
			SELF := LEFT
			));

			RETURN IF(validRequest, inParams, DATASET([],PhoneSearchParam)); 
	END;
	
	////////////////////////////////////////////////////
	
	EXPORT SetInputOptions (iesp.bair_share.t_BAIRBaseSearchOption options) := FUNCTION	
		// iesp.ECL2ESP.SetInputSearchOptions(options);	  
		// boolean StrictMatch := global(options).StrictMatch;  //def=false
    // #stored ('StrictMatch', StrictMatch);
		iesp.ECL2ESP.Marshall.Mac_Set(options);
		return OUTPUT (dataset ([],{integer x}), named('__internal__'), extend);
  END;


	EXPORT SetInputUser (iesp.bair_share.t_BAIRUser user) := FUNCTION			
		string in_ssnmask := global(user).SSNMask;
    string6 SSNMask := if (in_ssnmask = '', 'NONE', in_ssnmask);
    #stored('SSNMask', SSNMask);
    unsigned1 DLMask := (unsigned1) global(user).DLMask; // def=0
    #stored('DLMask', DLMask);
		STRING DOBMask := global(user).DOBMask; // def=NONE
    #stored('DOBMask', DOBMask);
		string ORI := global(user).AgencyORI;
		#stored('AgencyORI', TRIM(ORI,LEFT,RIGHT));
		return OUTPUT (dataset ([],{integer x}), named('__internal__'), extend);
  END;	
		
	
END;