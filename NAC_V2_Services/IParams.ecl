IMPORT NAC_V2_Services, STD, AutoKeyI, AutoHeaderI, iesp, BatchShare;

EXPORT IParams := MODULE

  // Returns a SET with the programs that they are allowed to see/search
	SHARED dynamicSet(STRING inBitStr) := FUNCTION
		Dynamic_ds := DATASET(LENGTH(inBitStr),
									TRANSFORM({STRING1 Program, STRING1 Permission},
										SELF.Program    := NAC_V2_Services.Constants.ProgramsAllowed[COUNTER],
										SELF.Permission := inBitStr[COUNTER]), 
								  LOCAL);
		// Return the set of programs the user is allowed to see
		//so where the Permission='1' and to avoid empty set values we 
		//don't add empty values Program<>'' to the set
		// The output SET will look like [S,D,P]
		RETURN SET(Dynamic_ds(Permission='1' AND Program<>''),Program);
	END;

	EXPORT CommonParams := INTERFACE(BatchShare.IParam.BatchParams)
	  // The following 4 fields are supplied to the query by MBS
		EXPORT STRING4 NacGroupId      := '';
		EXPORT STRING2 SourceState     := '';
		EXPORT SET OF STRING1 SET_PAS  := [];
		EXPORT SET OF STRING1 SET_PAR  := [];
		// The following 4 fields are Only used by the online/search query -
		//if they are conducting an investigative search,
		//they can search on a state different than their SourceState,
		//they can request to see records other then 'E' eligible_status_indicator,
		//IsOnline - set to TRUE if the search is being conducted from the
		//online GUI as opposed to xml-direct since we only allow *wildard* program searches
		//from the online GUI.
		EXPORT STRING2 InvestigativeState    := '';
		EXPORT STRING1 EligibilityStatus     := ''; 
		EXPORT BOOLEAN InvestigativePurpose  := FALSE;
		EXPORT BOOLEAN IsOnline              := FALSE;
		// The following 2 fields are only used by the online/search query as input global flags.
		// However, they are record based input fields in the batch NAC2 query
		EXPORT BOOLEAN IncludeEligibilityHistory    := TRUE;
		EXPORT BOOLEAN IncludeInterstateAllPrograms := TRUE;
		// Autokey flag - set to TRUE in batch searches
		EXPORT BOOLEAN NoFail := FALSE;
	END;

	EXPORT getBatchParams() := FUNCTION
		STRING32 ProgramsAllowedSearch   := '' : STORED('ProgramsAllowedSearch');
		STRING32 ProgramsAllowedReturned := '' : STORED('ProgramsAllowedReturned');
		STRING2  in_SourceState          := '' : STORED('SourceState');
		STRING4  in_NacGroupID           := '' : STORED('NacGroupId');

		in_mod := MODULE(CommonParams)
		  EXPORT STRING4 NacGroupId     := STD.STR.ToUpperCase(in_NacGroupID);
			EXPORT STRING2 SourceState    := STD.STR.ToUpperCase(in_SourceState);
			EXPORT SET OF STRING1 SET_PAS := dynamicSet(ProgramsAllowedSearch);
			EXPORT SET OF STRING1 SET_PAR := dynamicSet(ProgramsAllowedReturned);
			EXPORT BOOLEAN NoFail         := TRUE;
			 // Internal field
			EXPORT UNSIGNED2 PenaltThreshold := 10 : STORED('PenaltThreshold');
		END;
		RETURN in_mod;
	END;

	EXPORT getEspParams(iesp.nac2_search.t_NAC2SearchRequest inIesp) := FUNCTION
		Nac_groupID   := STD.STR.ToUpperCase(inIesp.SearchBy.NacGroupId);
		Program_State := STD.STR.ToUpperCase(inIesp.SearchBy.InvestigativeFields.ProgramState);
		Source_State  := STD.STR.ToUpperCase(inIesp.SearchBy.SourceState);
    Investigative_State := IF(Program_State <> '',Program_State, Source_State);	

		in_mod := MODULE(CommonParams)
			EXPORT STRING4   NacGroupID                   := Nac_groupID;
			EXPORT STRING2   SourceState                  := Source_State;
			EXPORT SET OF STRING1 SET_PAS                 := dynamicSet(inIesp.SearchBy.ProgramsAllowedSearch);
			EXPORT SET OF STRING1 SET_PAR                 := dynamicSet(inIesp.SearchBy.ProgramsAllowedReturned); 
			EXPORT STRING2   InvestigativeState           := Investigative_State;
			EXPORT STRING1   EligibilityStatus            := STD.STR.ToUpperCase(inIesp.SearchBy.InvestigativeFields.EligibilityStatus);
			EXPORT BOOLEAN   InvestigativePurpose         := inIesp.Options.InvestigativePurpose;
			// The following 2 fields are defaulted to TRUE at ESP layer
			EXPORT BOOLEAN   IncludeEligibilityHistory    := inIesp.Options.IncludeEligibilityHistory;
			EXPORT BOOLEAN   IncludeInterstateAllPrograms := inIesp.Options.IncludeInterstateAllPrograms;
		  EXPORT BOOLEAN   IsOnline                     := inIesp.Options.IsOnline;
			 // Internal field - defaulted to 10
			EXPORT UNSIGNED2 PenaltThreshold              := IF(inIesp.SearchBy.PenaltThreshold=0,10,inIesp.SearchBy.PenaltThreshold);
		END;
		RETURN in_mod;
	END;

	EXPORT AK_params := INTERFACE(AutoKeyI.AutoKeyStandardFetchBaseInterface)
		EXPORT BOOLEAN   workHard 			:= TRUE;
		EXPORT BOOLEAN   isdeepDive 		:= FALSE;
	END;

END;
