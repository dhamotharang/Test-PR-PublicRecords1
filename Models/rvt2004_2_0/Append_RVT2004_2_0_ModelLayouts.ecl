EXPORT Append_RVT2004_2_0_ModelLayouts := MODULE
  EXPORT Prepare := RECORD
    REAL L_ca_creditseeking_orig := 0.0;
    REAL L_ca_creditseeking := 0.0;
    REAL L_ca_derogseverityindex_orig := 0.0;
    REAL L_ca_derogseverityindex := 0.0;
    REAL L_ca_nonderogindex := 0.0;
    REAL L_ca_addrchangeindex := 0.0;
    UNSIGNED1 RVT2004_2_0_sc := 0; // Which scorecard was used
    UNSIGNED1 RVT2004_2_0_ex := 0; // Which exception fired
    BOOLEAN RVT2004_2_0_Alert := FALSE;
    BOOLEAN RVT2004_2_0_No_Hit := FALSE;
    BOOLEAN RVT2004_2_0_Deceased := FALSE;
  END;
  EXPORT Working := RECORD
    UNSIGNED4 AvoidEmpty := 0;
  END;
  EXPORT Debug := RECORD
// Variables for components of score SCORECARD_model47
    UNSIGNED1 RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range := 0;
    REAL4 RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_score := 0;
    REAL4  RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_contribution_best := 0;
    STRING5 RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_reason := '';
    UNSIGNED1 RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_range := 0;
    REAL4 RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_score := 0;
    REAL4  RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_contribution_best := 0;
    STRING5 RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_reason := '';
    UNSIGNED1 RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range := 0;
    REAL4 RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_score := 0;
    REAL4  RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_contribution_best := 0;
    STRING5 RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_reason := '';
    UNSIGNED1 RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range := 0;
    REAL4 RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_score := 0;
    REAL4  RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_contribution_best := 0;
    STRING5 RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_reason := '';
    UNSIGNED1 RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range := 0;
    REAL4 RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_score := 0;
    REAL4  RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_contribution_best := 0;
    STRING5 RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_reason := '';
    UNSIGNED1 RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_range := 0;
    REAL4 RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_score := 0;
    REAL4  RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_contribution_best := 0;
    STRING5 RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_reason := '';
    UNSIGNED1 RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range := 0;
    REAL4 RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_score := 0;
    REAL4  RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_contribution_best := 0;
    STRING5 RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_reason := '';
    UNSIGNED1 RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range := 0;
    REAL4 RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_score := 0;
    REAL4  RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_contribution_best := 0;
    STRING5 RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_reason := '';
    REAL RVT2004_2_0_SCORECARD_model47_Score0 := 0;
    REAL RVT2004_2_0_SCORECARD_model47_Score1 := 0;
    INTEGER2 RVT2004_2_0_SCORECARD_model47_Score := 0;
    SET OF STRING5 RVT2004_2_0_SCORECARD_model47_Reasons :=[];
  END;
  EXPORT Result := RECORD
    INTEGER2 RVT2004_2_0_Score := 0;
    SET OF STRING5 RVT2004_2_0_Reasons := [];
  END;
END;
