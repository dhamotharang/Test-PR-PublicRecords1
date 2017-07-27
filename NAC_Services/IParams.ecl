IMPORT NAC_Services,NAC_V2_Services,STD,iesp;
EXPORT IParams := MODULE

	EXPORT getBatchParams(STRING2 in_state) := FUNCTION
		input_State := STD.STR.ToUpperCase(in_state);
		nac_batch_params := MODULE(NAC_V2_Services.IParams.CommonParams)
			EXPORT STRING4   NacGroupID                := input_State+'01'; //does not change for the whole batch
			EXPORT STRING2   SourceState               := input_State; //does not change for the whole batch
			EXPORT SET OF STRING1 SET_PAS              := NAC_V2_Services.Constants.SNAP_DSNAP_SET;
			EXPORT SET OF STRING1 SET_PAR              := NAC_Services.Constants.MATCH_ProgramsAllowedReturn;
			EXPORT BOOLEAN   IncludeEligibilityHistory := FALSE	: STORED('Include12MonthHistory');
			EXPORT UNSIGNED2 PenaltThreshold           := 10    : STORED('PenaltThreshold'); // Internal field
			EXPORT BOOLEAN   noFail						         := TRUE;
		end;
		RETURN nac_batch_params;
	END;

	EXPORT getEspParams(iesp.nac_search.t_NACSearchRequest inIesp) := FUNCTION
	  inv_purpose := inIesp.Options.InvestigativePurpose;
    input_State := STD.STR.ToUpperCase(inIesp.SearchBy.Investigativefields.BenefitState);
		prog_allowed_return := IF(inv_purpose,NAC_V2_Services.Constants.SNAP_DSNAP_SET,
		                                      NAC_Services.Constants.MATCH_ProgramsAllowedReturn);

		nac_mod := MODULE(NAC_V2_Services.IParams.CommonParams)
		  EXPORT STRING4   NacGroupID                 := input_State+'01';
			EXPORT STRING2   SourceState                := input_State;
			EXPORT SET OF STRING1 SET_PAS               := NAC_V2_Services.Constants.SNAP_DSNAP_SET;
			EXPORT SET OF STRING1 SET_PAR               := prog_allowed_return;
			EXPORT BOOLEAN   InvestigativePurpose				:= inv_purpose;
			EXPORT BOOLEAN   IncludeEligibilityHistory  := inIesp.Options.Include12MonthHistory;
			EXPORT STRING2   InvestigativeState         := input_State;
			EXPORT UNSIGNED2 PenaltThreshold            := 10 : STORED('PenaltThreshold'); // Internal field
		end;
		RETURN nac_mod;
	END;

END;