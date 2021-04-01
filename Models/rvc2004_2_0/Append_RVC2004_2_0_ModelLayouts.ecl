EXPORT Append_RVC2004_2_0_ModelLayouts := MODULE
  EXPORT Prepare := RECORD
    UNSIGNED1 RVC2004_2_0_sc := 0; // Which scorecard was used
    UNSIGNED1 RVC2004_2_0_ex := 0; // Which exception fired
    BOOLEAN RVC2004_2_0_RV5_Attr_200 := FALSE;
    BOOLEAN RVC2004_2_0_RV5_Attr_222 := FALSE;
  END;
  EXPORT Working := RECORD
    UNSIGNED4 AvoidEmpty := 0;
  END;
  EXPORT Debug := RECORD
// Variables for components of score SCORECARD_model12
    UNSIGNED1 RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range := 0;
    REAL4 RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_score := 0;
    REAL4  RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_contribution_best := 0;
    STRING5 RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_reason := '';
    UNSIGNED1 RVC2004_2_0_SCORECARD_model12_derogcount_range := 0;
    REAL4 RVC2004_2_0_SCORECARD_model12_derogcount_score := 0;
    REAL4  RVC2004_2_0_SCORECARD_model12_derogcount_contribution_best := 0;
    STRING5 RVC2004_2_0_SCORECARD_model12_derogcount_reason := '';
    UNSIGNED1 RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_range := 0;
    REAL4 RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_score := 0;
    REAL4  RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_contribution_best := 0;
    STRING5 RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_reason := '';
    UNSIGNED1 RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range := 0;
    REAL4 RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_score := 0;
    REAL4  RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_contribution_best := 0;
    STRING5 RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_reason := '';
    UNSIGNED1 RVC2004_2_0_SCORECARD_model12_inputprovidedphone_range := 0;
    REAL4 RVC2004_2_0_SCORECARD_model12_inputprovidedphone_score := 0;
    REAL4  RVC2004_2_0_SCORECARD_model12_inputprovidedphone_contribution_best := 0;
    STRING5 RVC2004_2_0_SCORECARD_model12_inputprovidedphone_reason := '';
    UNSIGNED1 RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_range := 0;
    REAL4 RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_score := 0;
    REAL4  RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_contribution_best := 0;
    STRING5 RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_reason := '';
    UNSIGNED1 RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_range := 0;
    REAL4 RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_score := 0;
    REAL4  RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_contribution_best := 0;
    STRING5 RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_reason := '';
    UNSIGNED1 RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_range := 0;
    REAL4 RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_score := 0;
    REAL4  RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_contribution_best := 0;
    STRING5 RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_reason := '';
    REAL RVC2004_2_0_SCORECARD_model12_Score0 := 0;
    REAL RVC2004_2_0_SCORECARD_model12_Score1 := 0;
    INTEGER2 RVC2004_2_0_SCORECARD_model12_Score := 0;
    SET OF STRING5 RVC2004_2_0_SCORECARD_model12_Reasons :=[];
  END;
  EXPORT Result := RECORD
    INTEGER2 RVC2004_2_0_Score := 0;
    SET OF STRING5 RVC2004_2_0_Reasons := [];
  END;
END;
