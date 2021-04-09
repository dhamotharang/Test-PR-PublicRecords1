EXPORT Append_RVC2004_3_0_ModelLayouts := MODULE
  EXPORT Prepare := RECORD
    UNSIGNED1 RVC2004_3_0_sc := 0; // Which scorecard was used
    UNSIGNED1 RVC2004_3_0_ex := 0; // Which exception fired
    BOOLEAN RVC2004_3_0_RV5_Attr_200 := FALSE;
    BOOLEAN RVC2004_3_0_RV5_Attr_222 := FALSE;
  END;
  EXPORT Working := RECORD
    UNSIGNED4 AvoidEmpty := 0;
  END;
  EXPORT Debug := RECORD
// Variables for components of score SCORECARD_model13
    UNSIGNED1 RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range := 0;
    REAL4 RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_score := 0;
    REAL4  RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_contribution_best := 0;
    STRING5 RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_reason := '';
    UNSIGNED1 RVC2004_3_0_SCORECARD_model13_derogcount_range := 0;
    REAL4 RVC2004_3_0_SCORECARD_model13_derogcount_score := 0;
    REAL4  RVC2004_3_0_SCORECARD_model13_derogcount_contribution_best := 0;
    STRING5 RVC2004_3_0_SCORECARD_model13_derogcount_reason := '';
    UNSIGNED1 RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_range := 0;
    REAL4 RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_score := 0;
    REAL4  RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_contribution_best := 0;
    STRING5 RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_reason := '';
    UNSIGNED1 RVC2004_3_0_SCORECARD_model13_inquirycollections12month_range := 0;
    REAL4 RVC2004_3_0_SCORECARD_model13_inquirycollections12month_score := 0;
    REAL4  RVC2004_3_0_SCORECARD_model13_inquirycollections12month_contribution_best := 0;
    STRING5 RVC2004_3_0_SCORECARD_model13_inquirycollections12month_reason := '';
    UNSIGNED1 RVC2004_3_0_SCORECARD_model13_bankruptcycount_range := 0;
    REAL4 RVC2004_3_0_SCORECARD_model13_bankruptcycount_score := 0;
    REAL4  RVC2004_3_0_SCORECARD_model13_bankruptcycount_contribution_best := 0;
    STRING5 RVC2004_3_0_SCORECARD_model13_bankruptcycount_reason := '';
    UNSIGNED1 RVC2004_3_0_SCORECARD_model13_CollateralStatus_range := 0;
    REAL4 RVC2004_3_0_SCORECARD_model13_CollateralStatus_score := 0;
    REAL4  RVC2004_3_0_SCORECARD_model13_CollateralStatus_contribution_best := 0;
    STRING5 RVC2004_3_0_SCORECARD_model13_CollateralStatus_reason := '';
    UNSIGNED1 RVC2004_3_0_SCORECARD_model13_inputprovidedphone_range := 0;
    REAL4 RVC2004_3_0_SCORECARD_model13_inputprovidedphone_score := 0;
    REAL4  RVC2004_3_0_SCORECARD_model13_inputprovidedphone_contribution_best := 0;
    STRING5 RVC2004_3_0_SCORECARD_model13_inputprovidedphone_reason := '';
    UNSIGNED1 RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range := 0;
    REAL4 RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_score := 0;
    REAL4  RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_contribution_best := 0;
    STRING5 RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_reason := '';
    UNSIGNED1 RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_range := 0;
    REAL4 RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_score := 0;
    REAL4  RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_contribution_best := 0;
    STRING5 RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_reason := '';
    REAL RVC2004_3_0_SCORECARD_model13_Score0 := 0;
    REAL RVC2004_3_0_SCORECARD_model13_Score1 := 0;
    INTEGER2 RVC2004_3_0_SCORECARD_model13_Score := 0;
    SET OF STRING5 RVC2004_3_0_SCORECARD_model13_Reasons :=[];
  END;
  EXPORT Result := RECORD
    INTEGER2 RVC2004_3_0_Score := 0;
    SET OF STRING5 RVC2004_3_0_Reasons := [];
  END;
END;
