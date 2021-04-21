EXPORT Append_RVC2004_1_0_Model( infile,do_model=true,p_ChargeOffAmount,p_CollateralStatus,p_LoanType,p_OutOfStatuteIndicator,p_addrcurrentphoneservice,p_addrinputmatchindex,p_addrinputsubjectowned,p_addrprevioussubjectowned,p_addrprevioustimeoldest,p_confirmationsubjectfound,p_dayssince_OpenDate,p_dayssince_ReceivedDate,p_sourcecredheadertimeoldest,p_ssndeceased,p_subjectdeceased) := FUNCTIONMACRO
  
  RPrep := RECORD
    infile;
    rvc2004_1_0.Append_RVC2004_1_0_ModelLayouts.Prepare;
    rvc2004_1_0.Append_RVC2004_1_0_ModelLayouts.Working;
  END;
  RPrep PrepareMe(infile le) := TRANSFORM
    SELF.RVC2004_1_0_RV5_Attr_200 := (real) le.p_ssndeceased = 1 or (real) le.p_subjectdeceased = 1;
    SELF.RVC2004_1_0_RV5_Attr_222 := (real) le.p_confirmationsubjectfound = -998 or (real) le.p_confirmationsubjectfound < 1;
    SELF.RVC2004_1_0_ex := WHICH(SELF.RVC2004_1_0_RV5_Attr_200,SELF.RVC2004_1_0_RV5_Attr_222);
    SELF.RVC2004_1_0_sc := IF ( SELF.RVC2004_1_0_ex = 0, 1, 0 );
    SELF := le;
  END;
  Prepared := PROJECT(infile,PrepareMe(LEFT));
  rres := RECORD
    infile;
    rvc2004_1_0.Append_RVC2004_1_0_ModelLayouts.Result;
  END;
  rres TrEx(Prepared le) := TRANSFORM
    SELF.RVC2004_1_0_Score := CHOOSE(le.RVC2004_1_0_ex,200,222);
    SELF.RVC2004_1_0_Reasons := CHOOSE( le.RVC2004_1_0_ex,[],[]);
    SELF := le;
  END;
// Transform to compute result
  rres tr1(Prepared le) := TRANSFORM
// Computations for components of score SCORECARD_model6

    UNSIGNED1 RVC2004_1_0_SCORECARD_model6_LoanType_range := WHICH(((STRING)le.p_LoanType) >= '-998' AND ((STRING)le.p_LoanType) <= '-998',((STRING)le.p_LoanType) >= 'CFD' AND ((STRING)le.p_LoanType) <= 'CFD',((STRING)le.p_LoanType) >= 'HE' AND ((STRING)le.p_LoanType) <= 'HE',((STRING)le.p_LoanType) >= 'HI' AND ((STRING)le.p_LoanType) <= 'HI',((STRING)le.p_LoanType) >= 'MHCH' AND ((STRING)le.p_LoanType) <= 'MHCH',((STRING)le.p_LoanType) >= 'MHLH' AND ((STRING)le.p_LoanType) <= 'MHLH',((STRING)le.p_LoanType) > 'MHLH');
    REAL4 RVC2004_1_0_SCORECARD_model6_LoanType_score := CHOOSE(RVC2004_1_0_SCORECARD_model6_LoanType_range,0.0,-0.783823199084631,0.437226314256582,0.0808731487276667,-0.213208434163752,-0.48149235638988,0.0,0);
    REAL4 RVC2004_1_0_SCORECARD_model6_LoanType_contribution_best := CHOOSE(RVC2004_1_0_SCORECARD_model6_LoanType_range,0.0 - 0.437226314256582,-0.783823199084631 - 0.437226314256582,0.437226314256582 - 0.437226314256582,0.0808731487276667 - 0.437226314256582,-0.213208434163752 - 0.437226314256582,-0.48149235638988 - 0.437226314256582,0.0 - 0.437226314256582,0);
    STRING5 RVC2004_1_0_SCORECARD_model6_LoanType_reason := CHOOSE(RVC2004_1_0_SCORECARD_model6_LoanType_range,'Z01','Z03','','Z03','Z03','Z03','Z03','99999');

    UNSIGNED1 RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_range := WHICH(((REAL)le.p_addrinputsubjectowned) >= -998 AND ((REAL)le.p_addrinputsubjectowned) <= -998,((REAL)le.p_addrinputsubjectowned) >= -1 AND ((REAL)le.p_addrinputsubjectowned) <= -1,((REAL)le.p_addrinputsubjectowned) >= -999999999 AND ((REAL)le.p_addrinputsubjectowned) <= 0.5,((REAL)le.p_addrinputsubjectowned) >= 0.5);
    REAL4 RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_score := CHOOSE(RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_range,0.0,0.0,-0.126883825848919,0.25984141212094,0);
    REAL4 RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_contribution_best := CHOOSE(RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_range,0.0 - 0.25984141212094,0.0 - 0.25984141212094,-0.126883825848919 - 0.25984141212094,0.25984141212094 - 0.25984141212094,0);
    STRING5 RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_reason := CHOOSE(RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_range,'','C12','A44','','99999');

    UNSIGNED1 RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_range := WHICH(((REAL)le.p_addrprevioustimeoldest) >= -998 AND ((REAL)le.p_addrprevioustimeoldest) <= -998,((REAL)le.p_addrprevioustimeoldest) >= -1 AND ((REAL)le.p_addrprevioustimeoldest) <= -1,((REAL)le.p_addrprevioustimeoldest) >= -999999999 AND ((REAL)le.p_addrprevioustimeoldest) <= 205.5,((REAL)le.p_addrprevioustimeoldest) >= 205.5 AND ((REAL)le.p_addrprevioustimeoldest) <= 353.5,((REAL)le.p_addrprevioustimeoldest) >= 353.5);
    REAL4 RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_score := CHOOSE(RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_range,0.0,0.0,-0.178058014191334,0.180458239359927,0.227389143242477,0);
    REAL4 RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_contribution_best := CHOOSE(RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_range,0.0 - 0.227389143242477,0.0 - 0.227389143242477,-0.178058014191334 - 0.227389143242477,0.180458239359927 - 0.227389143242477,0.227389143242477 - 0.227389143242477,0);
    STRING5 RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_reason := CHOOSE(RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_range,'','C12','C13','C13','','99999');

    UNSIGNED1 RVC2004_1_0_SCORECARD_model6_addrprevioussubjectowned_range := WHICH(((REAL)le.p_addrprevioussubjectowned) >= -999999999);
    REAL4 RVC2004_1_0_SCORECARD_model6_addrprevioussubjectowned_score := CHOOSE(RVC2004_1_0_SCORECARD_model6_addrprevioussubjectowned_range,0.0,0);
    REAL4 RVC2004_1_0_SCORECARD_model6_addrprevioussubjectowned_contribution_best := CHOOSE(RVC2004_1_0_SCORECARD_model6_addrprevioussubjectowned_range,0.0 - 0.393204356454376,0);
    STRING5 RVC2004_1_0_SCORECARD_model6_addrprevioussubjectowned_reason := 'C12';

    UNSIGNED1 RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_range := WHICH(((REAL)le.p_addrinputmatchindex) >= -998 AND ((REAL)le.p_addrinputmatchindex) <= -998,((REAL)le.p_addrinputmatchindex) >= -1 AND ((REAL)le.p_addrinputmatchindex) <= -1,((REAL)le.p_addrinputmatchindex) >= -999999999 AND ((REAL)le.p_addrinputmatchindex) <= 1.5,((REAL)le.p_addrinputmatchindex) >= 1.5);
    REAL4 RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_score := CHOOSE(RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_range,0.0,0.0,-0.348450615891214,0.109644071572997,0);
    REAL4 RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_contribution_best := CHOOSE(RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_range,0.0 - 0.109644071572997,0.0 - 0.109644071572997,-0.348450615891214 - 0.109644071572997,0.109644071572997 - 0.109644071572997,0);
    STRING5 RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_reason := CHOOSE(RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_range,'','C12','F01','','99999');

    UNSIGNED1 RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_range := WHICH(((REAL)le.p_ChargeOffAmount) >= -998 AND ((REAL)le.p_ChargeOffAmount) <= -998,((REAL)le.p_ChargeOffAmount) >= -1 AND ((REAL)le.p_ChargeOffAmount) <= -1,((REAL)le.p_ChargeOffAmount) >= -999999999 AND ((REAL)le.p_ChargeOffAmount) <= 8546.265,((REAL)le.p_ChargeOffAmount) >= 8546.265 AND ((REAL)le.p_ChargeOffAmount) <= 18436.145,((REAL)le.p_ChargeOffAmount) >= 18436.145 AND ((REAL)le.p_ChargeOffAmount) <= 34264.93,((REAL)le.p_ChargeOffAmount) >= 34264.93);
    REAL4 RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_score := CHOOSE(RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_range,0.0,0.0,0.375117906627449,0.309244208292874,-0.0976038497040409,-0.285617568483362,0);
    REAL4 RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_contribution_best := CHOOSE(RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_range,0.0 - 0.375117906627449,0.0 - 0.375117906627449,0.375117906627449 - 0.375117906627449,0.309244208292874 - 0.375117906627449,-0.0976038497040409 - 0.375117906627449,-0.285617568483362 - 0.375117906627449,0);
    STRING5 RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_reason := CHOOSE(RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_range,'Z01','','','Z04','Z04','Z04','99999');

    UNSIGNED1 RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_range := WHICH(((REAL)le.p_addrcurrentphoneservice) >= -998 AND ((REAL)le.p_addrcurrentphoneservice) <= -998,((REAL)le.p_addrcurrentphoneservice) >= -1 AND ((REAL)le.p_addrcurrentphoneservice) <= -1,((REAL)le.p_addrcurrentphoneservice) >= -999999999 AND ((REAL)le.p_addrcurrentphoneservice) <= 0.5,((REAL)le.p_addrcurrentphoneservice) >= 0.5);
    REAL4 RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_score := CHOOSE(RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_range,0.0,0.0,-0.176496997665736,0.17581248093876,0);
    REAL4 RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_contribution_best := CHOOSE(RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_range,0.0 - 0.17581248093876,0.0 - 0.17581248093876,-0.176496997665736 - 0.17581248093876,0.17581248093876 - 0.17581248093876,0);
    STRING5 RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_reason := CHOOSE(RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_range,'','C12','L78','','99999');

    UNSIGNED1 RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range := WHICH(((REAL)le.p_dayssince_ReceivedDate) >= -998 AND ((REAL)le.p_dayssince_ReceivedDate) <= -998,((REAL)le.p_dayssince_ReceivedDate) >= -1 AND ((REAL)le.p_dayssince_ReceivedDate) <= -1,((REAL)le.p_dayssince_ReceivedDate) >= -999999999 AND ((REAL)le.p_dayssince_ReceivedDate) <= 309,((REAL)le.p_dayssince_ReceivedDate) >= 309 AND ((REAL)le.p_dayssince_ReceivedDate) <= 1358.5,((REAL)le.p_dayssince_ReceivedDate) >= 1358.5 AND ((REAL)le.p_dayssince_ReceivedDate) <= 2314,((REAL)le.p_dayssince_ReceivedDate) >= 2314 AND ((REAL)le.p_dayssince_ReceivedDate) <= 3731,((REAL)le.p_dayssince_ReceivedDate) >= 3731);
    REAL4 RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_score := CHOOSE(RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range,0.0,0.0,1.84983879208409,0.933891056825015,0.147011498338894,0.0658874265823452,-0.846610037669496,0);
    REAL4 RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_contribution_best := CHOOSE(RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range,0.0 - 1.84983879208409,0.0 - 1.84983879208409,1.84983879208409 - 1.84983879208409,0.933891056825015 - 1.84983879208409,0.147011498338894 - 1.84983879208409,0.0658874265823452 - 1.84983879208409,-0.846610037669496 - 1.84983879208409,0);
    STRING5 RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_reason := CHOOSE(RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range,'Z01','','','Z02','Z02','Z02','Z02','99999');

    UNSIGNED1 RVC2004_1_0_SCORECARD_model6_CollateralStatus_range := WHICH(((STRING)le.p_CollateralStatus) >= '-998' AND ((STRING)le.p_CollateralStatus) <= '-998',((STRING)le.p_CollateralStatus) >= 'Secured' AND ((STRING)le.p_CollateralStatus) <= 'Secured',((STRING)le.p_CollateralStatus) >= 'Unsecured' AND ((STRING)le.p_CollateralStatus) <= 'Unsecured',((STRING)le.p_CollateralStatus) > 'Unsecured');
    REAL4 RVC2004_1_0_SCORECARD_model6_CollateralStatus_score := CHOOSE(RVC2004_1_0_SCORECARD_model6_CollateralStatus_range,0.0,0.506249019049611,-0.505505156657995,0.0,0);
    REAL4 RVC2004_1_0_SCORECARD_model6_CollateralStatus_contribution_best := CHOOSE(RVC2004_1_0_SCORECARD_model6_CollateralStatus_range,0.0 - 0.506249019049611,0.506249019049611 - 0.506249019049611,-0.505505156657995 - 0.506249019049611,0.0 - 0.506249019049611,0);
    STRING5 RVC2004_1_0_SCORECARD_model6_CollateralStatus_reason := CHOOSE(RVC2004_1_0_SCORECARD_model6_CollateralStatus_range,'Z01','','Z03','Z03','99999');

    UNSIGNED1 RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_range := WHICH(((REAL)le.p_dayssince_OpenDate) >= -998 AND ((REAL)le.p_dayssince_OpenDate) <= -998,((REAL)le.p_dayssince_OpenDate) >= -1 AND ((REAL)le.p_dayssince_OpenDate) <= -1,((REAL)le.p_dayssince_OpenDate) >= -999999999 AND ((REAL)le.p_dayssince_OpenDate) <= 4785.5,((REAL)le.p_dayssince_OpenDate) >= 4785.5 AND ((REAL)le.p_dayssince_OpenDate) <= 7697.5,((REAL)le.p_dayssince_OpenDate) >= 7697.5);
    REAL4 RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_score := CHOOSE(RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_range,0.0,0.0,0.518838613059721,-0.15284397845779,-0.27403651626685,0);
    REAL4 RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_contribution_best := CHOOSE(RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_range,0.0 - 0.518838613059721,0.0 - 0.518838613059721,0.518838613059721 - 0.518838613059721,-0.15284397845779 - 0.518838613059721,-0.27403651626685 - 0.518838613059721,0);
    STRING5 RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_reason := CHOOSE(RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_range,'Z01','','','Z05','Z05','99999');

    UNSIGNED1 RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_range := WHICH(((STRING)le.p_OutOfStatuteIndicator) >= '-998' AND ((STRING)le.p_OutOfStatuteIndicator) <= '-998',((STRING)le.p_OutOfStatuteIndicator) >= 'N' AND ((STRING)le.p_OutOfStatuteIndicator) <= 'N',((STRING)le.p_OutOfStatuteIndicator) >= 'Y' AND ((STRING)le.p_OutOfStatuteIndicator) <= 'Y',((STRING)le.p_OutOfStatuteIndicator) > 'Y');
    REAL4 RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_score := CHOOSE(RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_range,0.0,0.400744957361021,-0.399632991058556,0.0,0);
    REAL4 RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_contribution_best := CHOOSE(RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_range,0.0 - 0.400744957361021,0.400744957361021 - 0.400744957361021,-0.399632991058556 - 0.400744957361021,0.0 - 0.400744957361021,0);
    STRING5 RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_reason := CHOOSE(RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_range,'Z01','','Z03','Z03','99999');

    UNSIGNED1 RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_range := WHICH(((REAL)le.p_sourcecredheadertimeoldest) >= -998 AND ((REAL)le.p_sourcecredheadertimeoldest) <= -998,((REAL)le.p_sourcecredheadertimeoldest) >= -1 AND ((REAL)le.p_sourcecredheadertimeoldest) <= -1,((REAL)le.p_sourcecredheadertimeoldest) >= -999999999 AND ((REAL)le.p_sourcecredheadertimeoldest) <= 345.5,((REAL)le.p_sourcecredheadertimeoldest) >= 345.5 AND ((REAL)le.p_sourcecredheadertimeoldest) <= 423.5,((REAL)le.p_sourcecredheadertimeoldest) >= 423.5);
    REAL4 RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_score := CHOOSE(RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_range,0.0,0.0,-0.275087108555596,0.0295111082163462,0.393416528917569,0);
    REAL4 RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_contribution_best := CHOOSE(RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_range,0.0 - 0.393416528917569,0.0 - 0.393416528917569,-0.275087108555596 - 0.393416528917569,0.0295111082163462 - 0.393416528917569,0.393416528917569 - 0.393416528917569,0);
    STRING5 RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_reason := CHOOSE(RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_range,'','C12','C20','C20','','99999');
// Now compute values for score SCORECARD_model6
    REAL RVC2004_1_0_SCORECARD_model6_Score0 := -6.20383556354911 + RVC2004_1_0_SCORECARD_model6_LoanType_Score + RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_Score + RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_Score + RVC2004_1_0_SCORECARD_model6_addrprevioussubjectowned_Score + RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_Score + RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_Score + RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_Score + RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_Score + RVC2004_1_0_SCORECARD_model6_CollateralStatus_Score + RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_Score + RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_Score + RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_Score;
    REAL RVC2004_1_0_SCORECARD_model6_Score1 := (700 + 20 * ((RVC2004_1_0_SCORECARD_model6_Score0 - 0 - LN(0.049227)) / LN(2)));
    INTEGER2 RVC2004_1_0_SCORECARD_model6_Score := ROUND( MAP (  RVC2004_1_0_SCORECARD_model6_Score1 < 501 => 501, RVC2004_1_0_SCORECARD_model6_Score1 > 900 => 900,RVC2004_1_0_SCORECARD_model6_Score1));
    SELF.RVC2004_1_0_Score := RVC2004_1_0_SCORECARD_model6_Score;
    aggregateRCs := SORT(
      TABLE(
      DATASET([
        {RVC2004_1_0_SCORECARD_model6_LoanType_contribution_best,RVC2004_1_0_SCORECARD_model6_LoanType_reason}
        ,{RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_contribution_best,RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_reason}
        ,{RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_contribution_best,RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_reason}
        ,{RVC2004_1_0_SCORECARD_model6_addrprevioussubjectowned_contribution_best,RVC2004_1_0_SCORECARD_model6_addrprevioussubjectowned_reason}
        ,{RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_contribution_best,RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_reason}
        ,{RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_contribution_best,RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_reason}
        ,{RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_contribution_best,RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_reason}
        ,{RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_contribution_best,RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_reason}
        ,{RVC2004_1_0_SCORECARD_model6_CollateralStatus_contribution_best,RVC2004_1_0_SCORECARD_model6_CollateralStatus_reason}
        ,{RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_contribution_best,RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_reason}
        ,{RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_contribution_best,RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_reason}
        ,{RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_contribution_best,RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_reason}
      ], rvc2004_1_0.ReasonType),
      {Reason_Code, Contribution_Sum := SUM(GROUP,Contribution)}, Reason_Code)
      (Reason_Code <> '', Contribution_Sum <> 0 ), Contribution_Sum, Reason_Code);
    topNRCs := CHOOSEN(aggregateRCs, 4);
    combineRCs := topNRCs & IF(~EXISTS(topNRCs(Reason_Code[1] = 'I')), aggregateRCs(Reason_Code[1] = 'I')[1]);
    SET OF STRING5 RVC2004_1_0_SCORECARD_model6_Reasons_best := SET(combineRCs(Reason_Code <> ''), Reason_Code);
    SET OF STRING5 RVC2004_1_0_SCORECARD_model6_Reasons := RVC2004_1_0_SCORECARD_model6_Reasons_Best;
    SELF.RVC2004_1_0_Reasons := RVC2004_1_0_SCORECARD_model6_Reasons;
    SELF := le;
  END;
  RETURN PROJECT(Prepared(RVC2004_1_0_ex > 0),TrEX(LEFT))+PROJECT( Prepared(RVC2004_1_0_sc = 1),Tr1(LEFT));
ENDMACRO;
