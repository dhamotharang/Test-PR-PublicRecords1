EXPORT Append_RVT2004_1_0_ModelLayouts := MODULE
  EXPORT Prepare := RECORD
    REAL L_addrprevioustimeoldest_alt := 0.0;
    REAL L_ca_creditseeking_orig := 0.0;
    REAL L_ca_creditseeking := 0.0;
    REAL L_ca_addrchangeindex := 0.0;
    REAL L_ca_nonderogindex_alt := 0.0;
    REAL L_ca_derogseverityindex_orig := 0.0;
    REAL L_ca_derogseverityindex := 0.0;
    UNSIGNED1 RVT2004_1_0_sc := 0; // Which scorecard was used
    UNSIGNED1 RVT2004_1_0_ex := 0; // Which exception fired
    BOOLEAN RVT2004_1_0_Alert := FALSE;
    BOOLEAN RVT2004_1_0_No_Hit := FALSE;
    BOOLEAN RVT2004_1_0_Deceased := FALSE;
  END;
  EXPORT Working := RECORD
    UNSIGNED4 AvoidEmpty := 0;
  END;
  EXPORT Debug := RECORD
// Variables for components of score SCORECARD_model110
    UNSIGNED1 RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range := 0;
    REAL4 RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_score := 0;
    REAL4  RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_contribution_best := 0;
    STRING5 RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_reason := '';
    UNSIGNED1 RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range := 0;
    REAL4 RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_score := 0;
    REAL4  RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_contribution_best := 0;
    STRING5 RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_reason := '';
    UNSIGNED1 RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range := 0;
    REAL4 RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_score := 0;
    REAL4  RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_contribution_best := 0;
    STRING5 RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_reason := '';
    UNSIGNED1 RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range := 0;
    REAL4 RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_score := 0;
    REAL4  RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_contribution_best := 0;
    STRING5 RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_reason := '';
    UNSIGNED1 RVT2004_1_0_SCORECARD_model110_assetpropevercount_range := 0;
    REAL4 RVT2004_1_0_SCORECARD_model110_assetpropevercount_score := 0;
    REAL4  RVT2004_1_0_SCORECARD_model110_assetpropevercount_contribution_best := 0;
    STRING5 RVT2004_1_0_SCORECARD_model110_assetpropevercount_reason := '';
    UNSIGNED1 RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range := 0;
    REAL4 RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_score := 0;
    REAL4  RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_contribution_best := 0;
    STRING5 RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_reason := '';
    UNSIGNED1 RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range := 0;
    REAL4 RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_score := 0;
    REAL4  RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_contribution_best := 0;
    STRING5 RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_reason := '';
    REAL RVT2004_1_0_SCORECARD_model110_Score0 := 0;
    REAL RVT2004_1_0_SCORECARD_model110_Score1 := 0;
    INTEGER2 RVT2004_1_0_SCORECARD_model110_Score := 0;
    SET OF STRING5 RVT2004_1_0_SCORECARD_model110_Reasons :=[];
  END;
  EXPORT Result := RECORD
    INTEGER2 RVT2004_1_0_Score := 0;
    SET OF STRING5 RVT2004_1_0_Reasons := [];
  END;
END;
