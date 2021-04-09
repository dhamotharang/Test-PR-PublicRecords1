EXPORT Append_RVC2004_3_0_Debug( infile,do_model=true,p_CollateralStatus,p_OutOfStatuteIndicator,p_addrinputlengthofres,p_addrprevioustimeoldest,p_bankruptcycount,p_confirmationsubjectfound,p_dayssince_LastPaymentDate,p_derogcount,p_inputprovidedphone,p_inquirycollections12month,p_ssndeceased,p_subjectdeceased) := FUNCTIONMACRO
  
  RPrep := RECORD
    infile;
    rvc2004_3_0.Append_RVC2004_3_0_ModelLayouts.Prepare;
    rvc2004_3_0.Append_RVC2004_3_0_ModelLayouts.Working;
  END;
  RPrep PrepareMe(infile le) := TRANSFORM
    SELF.RVC2004_3_0_RV5_Attr_200 := (real) le.p_ssndeceased = 1 or (real) le.p_subjectdeceased = 1;
    SELF.RVC2004_3_0_RV5_Attr_222 := (real) le.p_confirmationsubjectfound = -998 or (real) le.p_confirmationsubjectfound < 1;
    SELF.RVC2004_3_0_ex := WHICH(SELF.RVC2004_3_0_RV5_Attr_200,SELF.RVC2004_3_0_RV5_Attr_222);
    SELF.RVC2004_3_0_sc := IF ( SELF.RVC2004_3_0_ex = 0, 1, 0 );
    SELF := le;
  END;
  Prepared := PROJECT(infile,PrepareMe(LEFT));
  rres := RECORD
    infile;
    rvc2004_3_0.Append_RVC2004_3_0_ModelLayouts.Result;
    rvc2004_3_0.Append_RVC2004_3_0_ModelLayouts.Prepare;
    rvc2004_3_0.Append_RVC2004_3_0_ModelLayouts.Debug;
  END;
  rres TrEx(Prepared le) := TRANSFORM
    SELF.RVC2004_3_0_Score := CHOOSE(le.RVC2004_3_0_ex,200,222);
    SELF.RVC2004_3_0_Reasons := CHOOSE( le.RVC2004_3_0_ex,[],[]);
    SELF := le;
  END;
// Transform to compute result
  rres tr1(Prepared le) := TRANSFORM
// Computations for components of score SCORECARD_model13

    SELF.RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range := WHICH(((REAL)le.p_dayssince_LastPaymentDate) >= -998 AND ((REAL)le.p_dayssince_LastPaymentDate) <= -998,((REAL)le.p_dayssince_LastPaymentDate) >= -1 AND ((REAL)le.p_dayssince_LastPaymentDate) <= -1,((REAL)le.p_dayssince_LastPaymentDate) >= -999999999 AND ((REAL)le.p_dayssince_LastPaymentDate) <= 20.5,((REAL)le.p_dayssince_LastPaymentDate) >= 20.5 AND ((REAL)le.p_dayssince_LastPaymentDate) <= 22.5,((REAL)le.p_dayssince_LastPaymentDate) >= 22.5 AND ((REAL)le.p_dayssince_LastPaymentDate) <= 31.5,((REAL)le.p_dayssince_LastPaymentDate) >= 31.5 AND ((REAL)le.p_dayssince_LastPaymentDate) <= 40.5,((REAL)le.p_dayssince_LastPaymentDate) >= 40.5 AND ((REAL)le.p_dayssince_LastPaymentDate) <= 97.5,((REAL)le.p_dayssince_LastPaymentDate) >= 97.5 AND ((REAL)le.p_dayssince_LastPaymentDate) <= 473,((REAL)le.p_dayssince_LastPaymentDate) >= 473 AND ((REAL)le.p_dayssince_LastPaymentDate) <= 1298,((REAL)le.p_dayssince_LastPaymentDate) >= 1298);
    SELF.RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_score := CHOOSE(SELF.RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range,0.0,0.0,2.78502174482666,2.47927717616396,2.289394242031,2.16059645912678,1.28419126267805,-0.801117736469187,-1.56111814895788,-1.88830934823268,0);
    SELF.RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_contribution_best := CHOOSE(SELF.RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range,0.0 - 2.78502174482666,0.0 - 2.78502174482666,2.78502174482666 - 2.78502174482666,2.47927717616396 - 2.78502174482666,2.289394242031 - 2.78502174482666,2.16059645912678 - 2.78502174482666,1.28419126267805 - 2.78502174482666,-0.801117736469187 - 2.78502174482666,-1.56111814895788 - 2.78502174482666,-1.88830934823268 - 2.78502174482666,0);
    SELF.RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_reason := CHOOSE(SELF.RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range,'Z01','','','Z06','Z06','Z06','Z06','Z06','Z06','Z06','99999');

    SELF.RVC2004_3_0_SCORECARD_model13_derogcount_range := WHICH(((REAL)le.p_derogcount) >= -998 AND ((REAL)le.p_derogcount) <= -998,((REAL)le.p_derogcount) >= -1 AND ((REAL)le.p_derogcount) <= -1,((REAL)le.p_derogcount) >= -999999999 AND ((REAL)le.p_derogcount) <= 0.5,((REAL)le.p_derogcount) >= 0.5);
    SELF.RVC2004_3_0_SCORECARD_model13_derogcount_score := CHOOSE(SELF.RVC2004_3_0_SCORECARD_model13_derogcount_range,0.0,0.0,0.09127972345498,-0.0912002663257225,0);
    SELF.RVC2004_3_0_SCORECARD_model13_derogcount_contribution_best := CHOOSE(SELF.RVC2004_3_0_SCORECARD_model13_derogcount_range,0.0 - 0.09127972345498,0.0 - 0.09127972345498,0.09127972345498 - 0.09127972345498,-0.0912002663257225 - 0.09127972345498,0);
    SELF.RVC2004_3_0_SCORECARD_model13_derogcount_reason := CHOOSE(SELF.RVC2004_3_0_SCORECARD_model13_derogcount_range,'','C12','','D30','99999');

    SELF.RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_range := WHICH(((REAL)le.p_addrprevioustimeoldest) >= -998 AND ((REAL)le.p_addrprevioustimeoldest) <= -998,((REAL)le.p_addrprevioustimeoldest) >= -1 AND ((REAL)le.p_addrprevioustimeoldest) <= -1,((REAL)le.p_addrprevioustimeoldest) >= -999999999 AND ((REAL)le.p_addrprevioustimeoldest) <= 63.5,((REAL)le.p_addrprevioustimeoldest) >= 63.5 AND ((REAL)le.p_addrprevioustimeoldest) <= 293.5,((REAL)le.p_addrprevioustimeoldest) >= 293.5);
    SELF.RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_score := CHOOSE(SELF.RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_range,0.0,0.0,-0.243533121323617,0.0163999320923906,0.0766876845593337,0);
    SELF.RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_contribution_best := CHOOSE(SELF.RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_range,0.0 - 0.0766876845593337,0.0 - 0.0766876845593337,-0.243533121323617 - 0.0766876845593337,0.0163999320923906 - 0.0766876845593337,0.0766876845593337 - 0.0766876845593337,0);
    SELF.RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_reason := CHOOSE(SELF.RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_range,'','C12','C13','C13','','99999');

    SELF.RVC2004_3_0_SCORECARD_model13_inquirycollections12month_range := WHICH(((REAL)le.p_inquirycollections12month) >= -998 AND ((REAL)le.p_inquirycollections12month) <= -998,((REAL)le.p_inquirycollections12month) >= -1 AND ((REAL)le.p_inquirycollections12month) <= -1,((REAL)le.p_inquirycollections12month) >= -999999999 AND ((REAL)le.p_inquirycollections12month) <= 0.5,((REAL)le.p_inquirycollections12month) >= 0.5);
    SELF.RVC2004_3_0_SCORECARD_model13_inquirycollections12month_score := CHOOSE(SELF.RVC2004_3_0_SCORECARD_model13_inquirycollections12month_range,0.0,0.0,0.230273226976335,-0.230087456778504,0);
    SELF.RVC2004_3_0_SCORECARD_model13_inquirycollections12month_contribution_best := CHOOSE(SELF.RVC2004_3_0_SCORECARD_model13_inquirycollections12month_range,0.0 - 0.230273226976335,0.0 - 0.230273226976335,0.230273226976335 - 0.230273226976335,-0.230087456778504 - 0.230273226976335,0);
    SELF.RVC2004_3_0_SCORECARD_model13_inquirycollections12month_reason := CHOOSE(SELF.RVC2004_3_0_SCORECARD_model13_inquirycollections12month_range,'','C12','','I61','99999');

    SELF.RVC2004_3_0_SCORECARD_model13_bankruptcycount_range := WHICH(((REAL)le.p_bankruptcycount) >= -998 AND ((REAL)le.p_bankruptcycount) <= -998,((REAL)le.p_bankruptcycount) >= -1 AND ((REAL)le.p_bankruptcycount) <= -1,((REAL)le.p_bankruptcycount) >= -999999999 AND ((REAL)le.p_bankruptcycount) <= 0.5,((REAL)le.p_bankruptcycount) >= 0.5);
    SELF.RVC2004_3_0_SCORECARD_model13_bankruptcycount_score := CHOOSE(SELF.RVC2004_3_0_SCORECARD_model13_bankruptcycount_range,0.0,0.0,0.22054154165021,-0.220487704235926,0);
    SELF.RVC2004_3_0_SCORECARD_model13_bankruptcycount_contribution_best := CHOOSE(SELF.RVC2004_3_0_SCORECARD_model13_bankruptcycount_range,0.0 - 0.22054154165021,0.0 - 0.22054154165021,0.22054154165021 - 0.22054154165021,-0.220487704235926 - 0.22054154165021,0);
    SELF.RVC2004_3_0_SCORECARD_model13_bankruptcycount_reason := CHOOSE(SELF.RVC2004_3_0_SCORECARD_model13_bankruptcycount_range,'','C12','','D31','99999');

    SELF.RVC2004_3_0_SCORECARD_model13_CollateralStatus_range := WHICH(((STRING)le.p_CollateralStatus) >= '-998' AND ((STRING)le.p_CollateralStatus) <= '-998',((STRING)le.p_CollateralStatus) >= 'Secured' AND ((STRING)le.p_CollateralStatus) <= 'Secured',((STRING)le.p_CollateralStatus) >= 'Unsecured' AND ((STRING)le.p_CollateralStatus) <= 'Unsecured',((STRING)le.p_CollateralStatus) > 'Unsecured');
    SELF.RVC2004_3_0_SCORECARD_model13_CollateralStatus_score := CHOOSE(SELF.RVC2004_3_0_SCORECARD_model13_CollateralStatus_range,0.0,0.175881297202286,-0.175769990917404,0.0,0);
    SELF.RVC2004_3_0_SCORECARD_model13_CollateralStatus_contribution_best := CHOOSE(SELF.RVC2004_3_0_SCORECARD_model13_CollateralStatus_range,0.0 - 0.175881297202286,0.175881297202286 - 0.175881297202286,-0.175769990917404 - 0.175881297202286,0.0 - 0.175881297202286,0);
    SELF.RVC2004_3_0_SCORECARD_model13_CollateralStatus_reason := CHOOSE(SELF.RVC2004_3_0_SCORECARD_model13_CollateralStatus_range,'Z01','','Z03','Z03','99999');

    SELF.RVC2004_3_0_SCORECARD_model13_inputprovidedphone_range := WHICH(((REAL)le.p_inputprovidedphone) >= -998 AND ((REAL)le.p_inputprovidedphone) <= -998,((REAL)le.p_inputprovidedphone) >= -1 AND ((REAL)le.p_inputprovidedphone) <= -1,((REAL)le.p_inputprovidedphone) >= -999999999 AND ((REAL)le.p_inputprovidedphone) <= 0.5,((REAL)le.p_inputprovidedphone) >= 0.5);
    SELF.RVC2004_3_0_SCORECARD_model13_inputprovidedphone_score := CHOOSE(SELF.RVC2004_3_0_SCORECARD_model13_inputprovidedphone_range,0.0,0.0,-0.126184162516679,0.126065595425946,0);
    SELF.RVC2004_3_0_SCORECARD_model13_inputprovidedphone_contribution_best := CHOOSE(SELF.RVC2004_3_0_SCORECARD_model13_inputprovidedphone_range,0.0 - 0.126065595425946,0.0 - 0.126065595425946,-0.126184162516679 - 0.126065595425946,0.126065595425946 - 0.126065595425946,0);
    SELF.RVC2004_3_0_SCORECARD_model13_inputprovidedphone_reason := CHOOSE(SELF.RVC2004_3_0_SCORECARD_model13_inputprovidedphone_range,'','C12','F05','','99999');

    SELF.RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range := WHICH(((REAL)le.p_addrinputlengthofres) >= -998 AND ((REAL)le.p_addrinputlengthofres) <= -998,((REAL)le.p_addrinputlengthofres) >= -1 AND ((REAL)le.p_addrinputlengthofres) <= -1,((REAL)le.p_addrinputlengthofres) >= -999999999 AND ((REAL)le.p_addrinputlengthofres) <= 85.5,((REAL)le.p_addrinputlengthofres) >= 85.5 AND ((REAL)le.p_addrinputlengthofres) <= 175.5,((REAL)le.p_addrinputlengthofres) >= 175.5 AND ((REAL)le.p_addrinputlengthofres) <= 228.5,((REAL)le.p_addrinputlengthofres) >= 228.5 AND ((REAL)le.p_addrinputlengthofres) <= 401.5,((REAL)le.p_addrinputlengthofres) >= 401.5);
    SELF.RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_score := CHOOSE(SELF.RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range,0.0,0.0,-0.162252436093801,-0.0744986191707646,0.0134295817085936,0.106913758369424,0.380188696628816,0);
    SELF.RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_contribution_best := CHOOSE(SELF.RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range,0.0 - 0.380188696628816,0.0 - 0.380188696628816,-0.162252436093801 - 0.380188696628816,-0.0744986191707646 - 0.380188696628816,0.0134295817085936 - 0.380188696628816,0.106913758369424 - 0.380188696628816,0.380188696628816 - 0.380188696628816,0);
    SELF.RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_reason := CHOOSE(SELF.RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range,'','C12','C13','C13','C13','C13','','99999');

    SELF.RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_range := WHICH(((STRING)le.p_OutOfStatuteIndicator) >= '-998' AND ((STRING)le.p_OutOfStatuteIndicator) <= '-998',((STRING)le.p_OutOfStatuteIndicator) >= 'N' AND ((STRING)le.p_OutOfStatuteIndicator) <= 'N',((STRING)le.p_OutOfStatuteIndicator) >= 'Y' AND ((STRING)le.p_OutOfStatuteIndicator) <= 'Y',((STRING)le.p_OutOfStatuteIndicator) > 'Y');
    SELF.RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_score := CHOOSE(SELF.RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_range,0.0,0.517999357387536,-0.517699218854416,0.0,0);
    SELF.RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_contribution_best := CHOOSE(SELF.RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_range,0.0 - 0.517999357387536,0.517999357387536 - 0.517999357387536,-0.517699218854416 - 0.517999357387536,0.0 - 0.517999357387536,0);
    SELF.RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_reason := CHOOSE(SELF.RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_range,'Z01','','Z03','Z03','99999');
// Now compute values for score SCORECARD_model13
    SELF.RVC2004_3_0_SCORECARD_model13_Score0 := -1.78172567586037 + SELF.RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_Score + SELF.RVC2004_3_0_SCORECARD_model13_derogcount_Score + SELF.RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_Score + SELF.RVC2004_3_0_SCORECARD_model13_inquirycollections12month_Score + SELF.RVC2004_3_0_SCORECARD_model13_bankruptcycount_Score + SELF.RVC2004_3_0_SCORECARD_model13_CollateralStatus_Score + SELF.RVC2004_3_0_SCORECARD_model13_inputprovidedphone_Score + SELF.RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_Score + SELF.RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_Score;
    SELF.RVC2004_3_0_SCORECARD_model13_Score1 := (700 + 20 * ((SELF.RVC2004_3_0_SCORECARD_model13_Score0 - 0 - LN(0.049227)) / LN(2)));
    SELF.RVC2004_3_0_SCORECARD_model13_Score := ROUND( MAP (  SELF.RVC2004_3_0_SCORECARD_model13_Score1 < 501 => 501, SELF.RVC2004_3_0_SCORECARD_model13_Score1 > 900 => 900,SELF.RVC2004_3_0_SCORECARD_model13_Score1));
    SELF.RVC2004_3_0_Score := SELF.RVC2004_3_0_SCORECARD_model13_Score;
    aggregateRCs := SORT(
      TABLE(
      DATASET([
        {SELF.RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_contribution_best,SELF.RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_reason}
        ,{SELF.RVC2004_3_0_SCORECARD_model13_derogcount_contribution_best,SELF.RVC2004_3_0_SCORECARD_model13_derogcount_reason}
        ,{SELF.RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_contribution_best,SELF.RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_reason}
        ,{SELF.RVC2004_3_0_SCORECARD_model13_inquirycollections12month_contribution_best,SELF.RVC2004_3_0_SCORECARD_model13_inquirycollections12month_reason}
        ,{SELF.RVC2004_3_0_SCORECARD_model13_bankruptcycount_contribution_best,SELF.RVC2004_3_0_SCORECARD_model13_bankruptcycount_reason}
        ,{SELF.RVC2004_3_0_SCORECARD_model13_CollateralStatus_contribution_best,SELF.RVC2004_3_0_SCORECARD_model13_CollateralStatus_reason}
        ,{SELF.RVC2004_3_0_SCORECARD_model13_inputprovidedphone_contribution_best,SELF.RVC2004_3_0_SCORECARD_model13_inputprovidedphone_reason}
        ,{SELF.RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_contribution_best,SELF.RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_reason}
        ,{SELF.RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_contribution_best,SELF.RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_reason}
      ], rvc2004_3_0.ReasonType),
      {Reason_Code, Contribution_Sum := SUM(GROUP,Contribution)}, Reason_Code)
      (Reason_Code <> '', Contribution_Sum <> 0 ), Contribution_Sum, Reason_Code);
    topNRCs := CHOOSEN(aggregateRCs, 4);
    combineRCs := topNRCs & IF(~EXISTS(topNRCs(Reason_Code[1] = 'I')), aggregateRCs(Reason_Code[1] = 'I')[1]);
    SET OF STRING5 RVC2004_3_0_SCORECARD_model13_Reasons_best := SET(combineRCs(Reason_Code <> ''), Reason_Code);
    SELF.RVC2004_3_0_SCORECARD_model13_Reasons := RVC2004_3_0_SCORECARD_model13_Reasons_Best;
    SELF.RVC2004_3_0_Reasons := SELF.RVC2004_3_0_SCORECARD_model13_Reasons;
    SELF := le;
  END;
  RETURN PROJECT(Prepared(RVC2004_3_0_ex > 0),TrEX(LEFT))+ PROJECT( Prepared(RVC2004_3_0_sc = 1),Tr1(LEFT));
ENDMACRO;
