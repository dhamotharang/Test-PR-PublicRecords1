EXPORT Append_RVC2004_2_0_Debug( infile,do_model=true,p_ChargeOffAmount,p_OutOfStatuteIndicator,p_addrinputownershipindex,p_confirmationinputaddress,p_confirmationsubjectfound,p_dayssince_LastPaymentDate,p_derogcount,p_inputprovidedphone,p_sourcecredheadertimeoldest,p_ssndeceased,p_subjectdeceased) := FUNCTIONMACRO
  
  RPrep := RECORD
    infile;
    rvc2004_2_0.Append_RVC2004_2_0_ModelLayouts.Prepare;
    rvc2004_2_0.Append_RVC2004_2_0_ModelLayouts.Working;
  END;
  RPrep PrepareMe(infile le) := TRANSFORM
    SELF.RVC2004_2_0_RV5_Attr_200 := (real) le.p_ssndeceased = 1 or (real) le.p_subjectdeceased = 1;
    SELF.RVC2004_2_0_RV5_Attr_222 := (real) le.p_confirmationsubjectfound = -998 or (real) le.p_confirmationsubjectfound < 1;
    SELF.RVC2004_2_0_ex := WHICH(SELF.RVC2004_2_0_RV5_Attr_200,SELF.RVC2004_2_0_RV5_Attr_222);
    SELF.RVC2004_2_0_sc := IF ( SELF.RVC2004_2_0_ex = 0, 1, 0 );
    SELF := le;
  END;
  Prepared := PROJECT(infile,PrepareMe(LEFT));
  rres := RECORD
    infile;
    rvc2004_2_0.Append_RVC2004_2_0_ModelLayouts.Result;
    rvc2004_2_0.Append_RVC2004_2_0_ModelLayouts.Prepare;
    rvc2004_2_0.Append_RVC2004_2_0_ModelLayouts.Debug;
  END;
  rres TrEx(Prepared le) := TRANSFORM
    SELF.RVC2004_2_0_Score := CHOOSE(le.RVC2004_2_0_ex,200,222);
    SELF.RVC2004_2_0_Reasons := CHOOSE( le.RVC2004_2_0_ex,[],[]);
    SELF := le;
  END;
// Transform to compute result
  rres tr1(Prepared le) := TRANSFORM
// Computations for components of score SCORECARD_model12

    SELF.RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range := WHICH(((REAL)le.p_dayssince_LastPaymentDate) >= -998 AND ((REAL)le.p_dayssince_LastPaymentDate) <= -998,((REAL)le.p_dayssince_LastPaymentDate) >= -1 AND ((REAL)le.p_dayssince_LastPaymentDate) <= -1,((REAL)le.p_dayssince_LastPaymentDate) >= -999999999 AND ((REAL)le.p_dayssince_LastPaymentDate) <= 13.5,((REAL)le.p_dayssince_LastPaymentDate) >= 13.5 AND ((REAL)le.p_dayssince_LastPaymentDate) <= 25.5,((REAL)le.p_dayssince_LastPaymentDate) >= 25.5 AND ((REAL)le.p_dayssince_LastPaymentDate) <= 63.5,((REAL)le.p_dayssince_LastPaymentDate) >= 63.5 AND ((REAL)le.p_dayssince_LastPaymentDate) <= 227.5,((REAL)le.p_dayssince_LastPaymentDate) >= 227.5);
    SELF.RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_score := CHOOSE(SELF.RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range,0.0,0.0,2.90868702779944,2.79160099181279,1.8704884685878,0.148985327141811,-2.28956824523366,0);
    SELF.RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_contribution_best := CHOOSE(SELF.RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range,0.0 - 2.90868702779944,0.0 - 2.90868702779944,2.90868702779944 - 2.90868702779944,2.79160099181279 - 2.90868702779944,1.8704884685878 - 2.90868702779944,0.148985327141811 - 2.90868702779944,-2.28956824523366 - 2.90868702779944,0);
    SELF.RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_reason := CHOOSE(SELF.RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range,'Z01','','','Z06','Z06','Z06','Z06','99999');

    SELF.RVC2004_2_0_SCORECARD_model12_derogcount_range := WHICH(((REAL)le.p_derogcount) >= -998 AND ((REAL)le.p_derogcount) <= -998,((REAL)le.p_derogcount) >= -1 AND ((REAL)le.p_derogcount) <= -1,((REAL)le.p_derogcount) >= -999999999 AND ((REAL)le.p_derogcount) <= 1.5,((REAL)le.p_derogcount) >= 1.5);
    SELF.RVC2004_2_0_SCORECARD_model12_derogcount_score := CHOOSE(SELF.RVC2004_2_0_SCORECARD_model12_derogcount_range,0.0,0.0,0.206897909402591,-0.206841677937945,0);
    SELF.RVC2004_2_0_SCORECARD_model12_derogcount_contribution_best := CHOOSE(SELF.RVC2004_2_0_SCORECARD_model12_derogcount_range,0.0 - 0.206897909402591,0.0 - 0.206897909402591,0.206897909402591 - 0.206897909402591,-0.206841677937945 - 0.206897909402591,0);
    SELF.RVC2004_2_0_SCORECARD_model12_derogcount_reason := CHOOSE(SELF.RVC2004_2_0_SCORECARD_model12_derogcount_range,'','C12','','D30','99999');

    SELF.RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_range := WHICH(((REAL)le.p_addrinputownershipindex) >= -998 AND ((REAL)le.p_addrinputownershipindex) <= -998,((REAL)le.p_addrinputownershipindex) >= -1 AND ((REAL)le.p_addrinputownershipindex) <= -1,((REAL)le.p_addrinputownershipindex) >= -999999999 AND ((REAL)le.p_addrinputownershipindex) <= 3.5,((REAL)le.p_addrinputownershipindex) >= 3.5);
    SELF.RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_score := CHOOSE(SELF.RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_range,0.0,0.0,-0.0530990948270477,0.123004769601752,0);
    SELF.RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_contribution_best := CHOOSE(SELF.RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_range,0.0 - 0.123004769601752,0.0 - 0.123004769601752,-0.0530990948270477 - 0.123004769601752,0.123004769601752 - 0.123004769601752,0);
    SELF.RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_reason := CHOOSE(SELF.RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_range,'','C12','A44','','99999');

    SELF.RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range := WHICH(((REAL)le.p_ChargeOffAmount) >= -998 AND ((REAL)le.p_ChargeOffAmount) <= -998,((REAL)le.p_ChargeOffAmount) >= -1 AND ((REAL)le.p_ChargeOffAmount) <= -1,((REAL)le.p_ChargeOffAmount) >= -999999999 AND ((REAL)le.p_ChargeOffAmount) <= 4432.92,((REAL)le.p_ChargeOffAmount) >= 4432.92 AND ((REAL)le.p_ChargeOffAmount) <= 11517.91,((REAL)le.p_ChargeOffAmount) >= 11517.91 AND ((REAL)le.p_ChargeOffAmount) <= 16063.795,((REAL)le.p_ChargeOffAmount) >= 16063.795 AND ((REAL)le.p_ChargeOffAmount) <= 24316.115,((REAL)le.p_ChargeOffAmount) >= 24316.115 AND ((REAL)le.p_ChargeOffAmount) <= 47222.515,((REAL)le.p_ChargeOffAmount) >= 47222.515);
    SELF.RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_score := CHOOSE(SELF.RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range,0.0,0.0,-0.368397706825698,-0.124064717201017,-0.0427750798132533,0.0735522392490668,0.196296354816782,0.307355877385115,0);
    SELF.RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_contribution_best := CHOOSE(SELF.RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range,0.0 - 0.307355877385115,0.0 - 0.307355877385115,-0.368397706825698 - 0.307355877385115,-0.124064717201017 - 0.307355877385115,-0.0427750798132533 - 0.307355877385115,0.0735522392490668 - 0.307355877385115,0.196296354816782 - 0.307355877385115,0.307355877385115 - 0.307355877385115,0);
    SELF.RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_reason := CHOOSE(SELF.RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range,'Z01','','Z04','Z04','Z04','Z04','Z04','','99999');

    SELF.RVC2004_2_0_SCORECARD_model12_inputprovidedphone_range := WHICH(((REAL)le.p_inputprovidedphone) >= -998 AND ((REAL)le.p_inputprovidedphone) <= -998,((REAL)le.p_inputprovidedphone) >= -1 AND ((REAL)le.p_inputprovidedphone) <= -1,((REAL)le.p_inputprovidedphone) >= -999999999 AND ((REAL)le.p_inputprovidedphone) <= 0.5,((REAL)le.p_inputprovidedphone) >= 0.5);
    SELF.RVC2004_2_0_SCORECARD_model12_inputprovidedphone_score := CHOOSE(SELF.RVC2004_2_0_SCORECARD_model12_inputprovidedphone_range,0.0,0.0,-0.115997439845944,0.11595697711271,0);
    SELF.RVC2004_2_0_SCORECARD_model12_inputprovidedphone_contribution_best := CHOOSE(SELF.RVC2004_2_0_SCORECARD_model12_inputprovidedphone_range,0.0 - 0.11595697711271,0.0 - 0.11595697711271,-0.115997439845944 - 0.11595697711271,0.11595697711271 - 0.11595697711271,0);
    SELF.RVC2004_2_0_SCORECARD_model12_inputprovidedphone_reason := CHOOSE(SELF.RVC2004_2_0_SCORECARD_model12_inputprovidedphone_range,'','C12','F05','','99999');

    SELF.RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_range := WHICH(((REAL)le.p_confirmationinputaddress) >= -998 AND ((REAL)le.p_confirmationinputaddress) <= -998,((REAL)le.p_confirmationinputaddress) >= -1 AND ((REAL)le.p_confirmationinputaddress) <= -1,((REAL)le.p_confirmationinputaddress) >= -999999999 AND ((REAL)le.p_confirmationinputaddress) <= 0.5,((REAL)le.p_confirmationinputaddress) >= 0.5);
    SELF.RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_score := CHOOSE(SELF.RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_range,0.0,-0.337887501368304,-3.92028713838522E-4,0.0923792591262736,0);
    SELF.RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_contribution_best := CHOOSE(SELF.RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_range,0.0 - 0.0923792591262736,-0.337887501368304 - 0.0923792591262736,-3.92028713838522E-4 - 0.0923792591262736,0.0923792591262736 - 0.0923792591262736,0);
    SELF.RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_reason := CHOOSE(SELF.RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_range,'','C12','F01','','99999');

    SELF.RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_range := WHICH(((STRING)le.p_OutOfStatuteIndicator) >= '-998' AND ((STRING)le.p_OutOfStatuteIndicator) <= '-998',((STRING)le.p_OutOfStatuteIndicator) >= 'N' AND ((STRING)le.p_OutOfStatuteIndicator) <= 'N',((STRING)le.p_OutOfStatuteIndicator) >= 'Y' AND ((STRING)le.p_OutOfStatuteIndicator) <= 'Y',((STRING)le.p_OutOfStatuteIndicator) > 'Y');
    SELF.RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_score := CHOOSE(SELF.RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_range,0.0,0.522622593458921,-0.52216878252275,0.0,0);
    SELF.RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_contribution_best := CHOOSE(SELF.RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_range,0.0 - 0.522622593458921,0.522622593458921 - 0.522622593458921,-0.52216878252275 - 0.522622593458921,0.0 - 0.522622593458921,0);
    SELF.RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_reason := CHOOSE(SELF.RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_range,'Z01','','Z03','Z03','99999');

    SELF.RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_range := WHICH(((REAL)le.p_sourcecredheadertimeoldest) >= -998 AND ((REAL)le.p_sourcecredheadertimeoldest) <= -998,((REAL)le.p_sourcecredheadertimeoldest) >= -1 AND ((REAL)le.p_sourcecredheadertimeoldest) <= -1,((REAL)le.p_sourcecredheadertimeoldest) >= -999999999 AND ((REAL)le.p_sourcecredheadertimeoldest) <= 293.5,((REAL)le.p_sourcecredheadertimeoldest) >= 293.5 AND ((REAL)le.p_sourcecredheadertimeoldest) <= 421.5,((REAL)le.p_sourcecredheadertimeoldest) >= 421.5);
    SELF.RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_score := CHOOSE(SELF.RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_range,0.0,0.0,-0.135530518722703,-0.0694870572956636,0.188800668917611,0);
    SELF.RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_contribution_best := CHOOSE(SELF.RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_range,0.0 - 0.188800668917611,0.0 - 0.188800668917611,-0.135530518722703 - 0.188800668917611,-0.0694870572956636 - 0.188800668917611,0.188800668917611 - 0.188800668917611,0);
    SELF.RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_reason := CHOOSE(SELF.RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_range,'','C12','C20','C20','','99999');
// Now compute values for score SCORECARD_model12
    SELF.RVC2004_2_0_SCORECARD_model12_Score0 := -1.80641556868857 + SELF.RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_Score + SELF.RVC2004_2_0_SCORECARD_model12_derogcount_Score + SELF.RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_Score + SELF.RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_Score + SELF.RVC2004_2_0_SCORECARD_model12_inputprovidedphone_Score + SELF.RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_Score + SELF.RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_Score + SELF.RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_Score;
    SELF.RVC2004_2_0_SCORECARD_model12_Score1 := (700 + 20 * ((SELF.RVC2004_2_0_SCORECARD_model12_Score0 - 0 - LN(0.049227)) / LN(2)));
    SELF.RVC2004_2_0_SCORECARD_model12_Score := ROUND( MAP (  SELF.RVC2004_2_0_SCORECARD_model12_Score1 < 501 => 501, SELF.RVC2004_2_0_SCORECARD_model12_Score1 > 900 => 900,SELF.RVC2004_2_0_SCORECARD_model12_Score1));
    SELF.RVC2004_2_0_Score := SELF.RVC2004_2_0_SCORECARD_model12_Score;
    aggregateRCs := SORT(
      TABLE(
      DATASET([
        {SELF.RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_contribution_best,SELF.RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_reason}
        ,{SELF.RVC2004_2_0_SCORECARD_model12_derogcount_contribution_best,SELF.RVC2004_2_0_SCORECARD_model12_derogcount_reason}
        ,{SELF.RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_contribution_best,SELF.RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_reason}
        ,{SELF.RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_contribution_best,SELF.RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_reason}
        ,{SELF.RVC2004_2_0_SCORECARD_model12_inputprovidedphone_contribution_best,SELF.RVC2004_2_0_SCORECARD_model12_inputprovidedphone_reason}
        ,{SELF.RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_contribution_best,SELF.RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_reason}
        ,{SELF.RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_contribution_best,SELF.RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_reason}
        ,{SELF.RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_contribution_best,SELF.RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_reason}
      ], rvc2004_2_0.ReasonType),
      {Reason_Code, Contribution_Sum := SUM(GROUP,Contribution)}, Reason_Code)
      (Reason_Code <> '', Contribution_Sum <> 0 ), Contribution_Sum, Reason_Code);
    topNRCs := CHOOSEN(aggregateRCs, 4);
    combineRCs := topNRCs & IF(~EXISTS(topNRCs(Reason_Code[1] = 'I')), aggregateRCs(Reason_Code[1] = 'I')[1]);
    SET OF STRING5 RVC2004_2_0_SCORECARD_model12_Reasons_best := SET(combineRCs(Reason_Code <> ''), Reason_Code);
    SELF.RVC2004_2_0_SCORECARD_model12_Reasons := RVC2004_2_0_SCORECARD_model12_Reasons_Best;
    SELF.RVC2004_2_0_Reasons := SELF.RVC2004_2_0_SCORECARD_model12_Reasons;
    SELF := le;
  END;
  RETURN PROJECT(Prepared(RVC2004_2_0_ex > 0),TrEX(LEFT))+PROJECT( Prepared(RVC2004_2_0_sc = 1),Tr1(LEFT));
ENDMACRO;
