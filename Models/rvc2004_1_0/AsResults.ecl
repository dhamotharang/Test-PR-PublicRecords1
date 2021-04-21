EXPORT AsResults(infile) := FUNCTIONMACRO

  Res(DATASET(RECORDOF(infile)) myfile) := MODULE(rvc2004_1_0.Results)
  IMPORT iesp;
  SHARED RCToMessage(SET OF STRING5 rc) := FUNCTION
    d1 := DATASET(rc,{ STRING5 Code });
    iesp.ins_share_iss.t_InsuranceScoreMessage into(d1 le) := TRANSFORM
      SELF.MessageType := rvc2004_1_0.RCCodes(le.code).GroupType;
      SELF.Description := rvc2004_1_0.RCCodes(le.code).Description;
      SELF.Code := le.code;
    END;
    RETURN PROJECT(d1,into(LEFT));
  END;
    // Simple and quick
  EXPORT BaseF := rvc2004_1_0.AppendAll(myfile,do_RVC2004_1_0,ChargeOffAmount,CollateralStatus,LoanType,OutOfStatuteIndicator,addrcurrentphoneservice,addrinputmatchindex,addrinputsubjectowned,addrprevioussubjectowned,addrprevioustimeoldest,confirmationsubjectfound,dayssince_OpenDate,dayssince_ReceivedDate,sourcecredheadertimeoldest,ssndeceased,subjectdeceased);
    BaseLayout TrRVC2004_1_0(BaseF le) := TRANSFORM
      SELF.TransactionId := le.TransactionId;
      SELF.name := 'RVC2004_1_0';
      SELF.description := 'Shellpoint Custom Model (neverpaid segment)';
      SELF.Score := (STRING)le.RVC2004_1_0_Score;
      SELF.Messages := RCToMessage(le.RVC2004_1_0_Reasons);
    END;
    RVC2004_1_0AsBase := PROJECT(BaseF,TrRVC2004_1_0(LEFT));
  EXPORT Base() := RVC2004_1_0AsBase;
    // With attributes
  EXPORT AttrF := rvc2004_1_0.AppendAll(myfile,do_RVC2004_1_0,ChargeOffAmount,CollateralStatus,LoanType,OutOfStatuteIndicator,addrcurrentphoneservice,addrinputmatchindex,addrinputsubjectowned,addrprevioussubjectowned,addrprevioustimeoldest,confirmationsubjectfound,dayssince_OpenDate,dayssince_ReceivedDate,sourcecredheadertimeoldest,ssndeceased,subjectdeceased);
    AttrLayout TrRVC2004_1_0(AttrF le) := TRANSFORM
      SELF.TransactionId := le.TransactionId;
      SELF.name := 'RVC2004_1_0';
      SELF.description := 'Shellpoint Custom Model (neverpaid segment)';
      SELF.Score := (STRING)le.RVC2004_1_0_Score;
      SELF.Messages := RCToMessage(le.RVC2004_1_0_Reasons);
      SELF.Attributes := DATASET([
          {'ChargeOffAmount',le.ChargeOffAmount},
          {'CollateralStatus',le.CollateralStatus},
          {'LoanType',le.LoanType},
          {'OutOfStatuteIndicator',le.OutOfStatuteIndicator},
          {'addrcurrentphoneservice',le.addrcurrentphoneservice},
          {'addrinputmatchindex',le.addrinputmatchindex},
          {'addrinputsubjectowned',le.addrinputsubjectowned},
          {'addrprevioussubjectowned',le.addrprevioussubjectowned},
          {'addrprevioustimeoldest',le.addrprevioustimeoldest},
          {'confirmationsubjectfound',le.confirmationsubjectfound},
          {'dayssince_OpenDate',le.dayssince_OpenDate},
          {'dayssince_ReceivedDate',le.dayssince_ReceivedDate},
          {'sourcecredheadertimeoldest',le.sourcecredheadertimeoldest},
          {'ssndeceased',le.ssndeceased},
          {'subjectdeceased',le.subjectdeceased}],NVPair);
    END;
    RVC2004_1_0AsAttr := PROJECT(AttrF,TrRVC2004_1_0(LEFT));
  EXPORT Attr() := RVC2004_1_0AsAttr;
    // Validation
  EXPORT ValidationF := rvc2004_1_0.AppendAll_Debug(myfile,do_RVC2004_1_0,ChargeOffAmount,CollateralStatus,LoanType,OutOfStatuteIndicator,addrcurrentphoneservice,addrinputmatchindex,addrinputsubjectowned,addrprevioussubjectowned,addrprevioustimeoldest,confirmationsubjectfound,dayssince_OpenDate,dayssince_ReceivedDate,sourcecredheadertimeoldest,ssndeceased,subjectdeceased);
    ValidationLayout TrRVC2004_1_0(ValidationF le) := TRANSFORM
      SELF.TransactionId := le.TransactionId;
      SELF.name := 'RVC2004_1_0';
      SELF.description := 'Shellpoint Custom Model (neverpaid segment)';
      SELF.Score := (STRING)le.RVC2004_1_0_Score;
      SELF.Messages := RCToMessage(le.RVC2004_1_0_Reasons);
      SELF.Attributes := DATASET([
          {'ChargeOffAmount',le.ChargeOffAmount},
          {'CollateralStatus',le.CollateralStatus},
          {'LoanType',le.LoanType},
          {'OutOfStatuteIndicator',le.OutOfStatuteIndicator},
          {'addrcurrentphoneservice',le.addrcurrentphoneservice},
          {'addrinputmatchindex',le.addrinputmatchindex},
          {'addrinputsubjectowned',le.addrinputsubjectowned},
          {'addrprevioussubjectowned',le.addrprevioussubjectowned},
          {'addrprevioustimeoldest',le.addrprevioustimeoldest},
          {'confirmationsubjectfound',le.confirmationsubjectfound},
          {'dayssince_OpenDate',le.dayssince_OpenDate},
          {'dayssince_ReceivedDate',le.dayssince_ReceivedDate},
          {'sourcecredheadertimeoldest',le.sourcecredheadertimeoldest},
          {'ssndeceased',le.ssndeceased},
          {'subjectdeceased',le.subjectdeceased}],NVPair);
      SELF.PointsAssignment := DATASET([
          {'ChargeOffAmount_pts',le.RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_score},
          {'CollateralStatus_pts',le.RVC2004_1_0_SCORECARD_model6_CollateralStatus_score},
          {'LoanType_pts',le.RVC2004_1_0_SCORECARD_model6_LoanType_score},
          {'OutOfStatuteIndicator_pts',le.RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_score},
          {'addrcurrentphoneservice_pts',le.RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_score},
          {'addrinputmatchindex_pts',le.RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_score},
          {'addrinputsubjectowned_pts',le.RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_score},
          {'addrprevioussubjectowned_pts',le.RVC2004_1_0_SCORECARD_model6_addrprevioussubjectowned_score},
          {'addrprevioustimeoldest_pts',le.RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_score},
          {'dayssince_OpenDate_pts',le.RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_score},
          {'dayssince_ReceivedDate_pts',le.RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_score},
          {'sourcecredheadertimeoldest_pts',le.RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_score}],NVPair);
      SELF.ScoreCard := 'SCORECARD_model6';
      SELF.score_date := StringLib.GetDateYYYYMMDD();
      SELF.raw_score := le.RVC2004_1_0_SCORECARD_model6_Score0;
      SELF.calc_temp_score := le.RVC2004_1_0_SCORECARD_model6_Score1;
      SELF.INSUFFICIENT_INFO := FALSE; // Insufficient_Info* not found
      SELF.NO_HIT := FALSE; // No_Hit* not found
      SELF.reason_codes_base := DATASET([
          {'ChargeOffAmount',le.RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_contribution_best,le.RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_reason},
          {'CollateralStatus',le.RVC2004_1_0_SCORECARD_model6_CollateralStatus_contribution_best,le.RVC2004_1_0_SCORECARD_model6_CollateralStatus_reason},
          {'LoanType',le.RVC2004_1_0_SCORECARD_model6_LoanType_contribution_best,le.RVC2004_1_0_SCORECARD_model6_LoanType_reason},
          {'OutOfStatuteIndicator',le.RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_contribution_best,le.RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_reason},
          {'addrcurrentphoneservice',le.RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_contribution_best,le.RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_reason},
          {'addrinputmatchindex',le.RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_contribution_best,le.RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_reason},
          {'addrinputsubjectowned',le.RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_contribution_best,le.RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_reason},
          {'addrprevioussubjectowned',le.RVC2004_1_0_SCORECARD_model6_addrprevioussubjectowned_contribution_best,le.RVC2004_1_0_SCORECARD_model6_addrprevioussubjectowned_reason},
          {'addrprevioustimeoldest',le.RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_contribution_best,le.RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_reason},
          {'dayssince_OpenDate',le.RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_contribution_best,le.RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_reason},
          {'dayssince_ReceivedDate',le.RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_contribution_best,le.RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_reason},
          {'sourcecredheadertimeoldest',le.RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_contribution_best,le.RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_reason}],RC_Contributions_Layout);
    END;
    RVC2004_1_0AsValidation := PROJECT(ValidationF,TrRVC2004_1_0(LEFT));
  EXPORT Validation() := RVC2004_1_0AsValidation;
// Now compute some statistics
  Accum := RECORD
    TotalProcessed := COUNT(GROUP);
    RVC2004_1_0_sc_SCORECARD_model6 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1);
    RVC2004_1_0_RV5_Attr_200 := COUNT(GROUP,ValidationF.RVC2004_1_0_RV5_Attr_200);
    RVC2004_1_0_RV5_Attr_222 := COUNT(GROUP,ValidationF.RVC2004_1_0_RV5_Attr_222);
    RVC2004_1_0_SCORECARD_model6_LoanType_range_1 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_LoanType_range=1);
    RVC2004_1_0_SCORECARD_model6_LoanType_range_2 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_LoanType_range=2);
    RVC2004_1_0_SCORECARD_model6_LoanType_range_3 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_LoanType_range=3);
    RVC2004_1_0_SCORECARD_model6_LoanType_range_4 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_LoanType_range=4);
    RVC2004_1_0_SCORECARD_model6_LoanType_range_5 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_LoanType_range=5);
    RVC2004_1_0_SCORECARD_model6_LoanType_range_6 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_LoanType_range=6);
    RVC2004_1_0_SCORECARD_model6_LoanType_range_7 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_LoanType_range=7);
    RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_range_1 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_range=1);
    RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_range_2 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_range=2);
    RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_range_3 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_range=3);
    RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_range_4 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_range=4);
    RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_range_1 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_range=1);
    RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_range_2 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_range=2);
    RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_range_3 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_range=3);
    RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_range_4 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_range=4);
    RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_range_5 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_range=5);
    RVC2004_1_0_SCORECARD_model6_addrprevioussubjectowned_range_1 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_addrprevioussubjectowned_range=1);
    RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_range_1 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_range=1);
    RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_range_2 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_range=2);
    RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_range_3 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_range=3);
    RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_range_4 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_range=4);
    RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_range_1 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_range=1);
    RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_range_2 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_range=2);
    RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_range_3 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_range=3);
    RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_range_4 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_range=4);
    RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_range_5 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_range=5);
    RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_range_6 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_range=6);
    RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_range_1 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_range=1);
    RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_range_2 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_range=2);
    RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_range_3 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_range=3);
    RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_range_4 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_range=4);
    RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range_1 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range=1);
    RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range_2 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range=2);
    RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range_3 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range=3);
    RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range_4 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range=4);
    RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range_5 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range=5);
    RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range_6 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range=6);
    RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range_7 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range=7);
    RVC2004_1_0_SCORECARD_model6_CollateralStatus_range_1 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_CollateralStatus_range=1);
    RVC2004_1_0_SCORECARD_model6_CollateralStatus_range_2 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_CollateralStatus_range=2);
    RVC2004_1_0_SCORECARD_model6_CollateralStatus_range_3 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_CollateralStatus_range=3);
    RVC2004_1_0_SCORECARD_model6_CollateralStatus_range_4 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_CollateralStatus_range=4);
    RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_range_1 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_range=1);
    RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_range_2 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_range=2);
    RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_range_3 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_range=3);
    RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_range_4 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_range=4);
    RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_range_5 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_range=5);
    RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_range_1 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_range=1);
    RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_range_2 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_range=2);
    RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_range_3 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_range=3);
    RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_range_4 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_range=4);
    RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_range_1 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_range=1);
    RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_range_2 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_range=2);
    RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_range_3 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_range=3);
    RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_range_4 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_range=4);
    RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_range_5 := COUNT(GROUP,ValidationF.RVC2004_1_0_sc = 1 AND ValidationF.RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_range=5);
  END;
  EXPORT StatsF := TABLE(ValidationF,Accum);
  EXPORT Stats() := DATASET([{'ADR Report','','','',0,0,0,'',0,0,'',0,0}
    ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','EXCEPTION','RV5_Attr_200',0,0,0,'',0,0,'',StatsF[1].RVC2004_1_0_RV5_Attr_200,100*StatsF[1].RVC2004_1_0_RV5_Attr_200/StatsF[1].TotalProcessed}
    ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','EXCEPTION','RV5_Attr_222',0,0,0,'',0,0,'',StatsF[1].RVC2004_1_0_RV5_Attr_222,100*StatsF[1].RVC2004_1_0_RV5_Attr_222/StatsF[1].TotalProcessed}
    ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','',0,0,0,'',0,0,'',StatsF[1].RVC2004_1_0_sc_SCORECARD_model6,100*StatsF[1].RVC2004_1_0_sc_SCORECARD_model6/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','LoanType','-998','-998',0.0,'NUMBER',0.0,0.437226314256582,'Z01',StatsF[1].RVC2004_1_0_SCORECARD_model6_LoanType_range_1,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_LoanType_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','LoanType','CFD','CFD',-0.783823199084631,'NUMBER',0.0,0.437226314256582,'Z03',StatsF[1].RVC2004_1_0_SCORECARD_model6_LoanType_range_2,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_LoanType_range_2/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','LoanType','HE','HE',0.437226314256582,'NUMBER',0.0,0.437226314256582,'',StatsF[1].RVC2004_1_0_SCORECARD_model6_LoanType_range_3,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_LoanType_range_3/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','LoanType','HI','HI',0.0808731487276667,'NUMBER',0.0,0.437226314256582,'Z03',StatsF[1].RVC2004_1_0_SCORECARD_model6_LoanType_range_4,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_LoanType_range_4/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','LoanType','MHCH','MHCH',-0.213208434163752,'NUMBER',0.0,0.437226314256582,'Z03',StatsF[1].RVC2004_1_0_SCORECARD_model6_LoanType_range_5,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_LoanType_range_5/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','LoanType','MHLH','MHLH',-0.48149235638988,'NUMBER',0.0,0.437226314256582,'Z03',StatsF[1].RVC2004_1_0_SCORECARD_model6_LoanType_range_6,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_LoanType_range_6/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','LoanType','','HIGH',0.0,'NUMBER',0.0,0.437226314256582,'Z03',StatsF[1].RVC2004_1_0_SCORECARD_model6_LoanType_range_7,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_LoanType_range_7/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','LoanType',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_1_0_sc_SCORECARD_model6,100*StatsF[1].RVC2004_1_0_sc_SCORECARD_model6/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','addrinputsubjectowned','-998','-998',0.0,'NUMBER',0.0,0.25984141212094,'',StatsF[1].RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_range_1,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','addrinputsubjectowned','-1','-1',0.0,'NUMBER',0.0,0.25984141212094,'C12',StatsF[1].RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_range_2,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_range_2/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','addrinputsubjectowned','-999999999','0.5',-0.126883825848919,'NUMBER',0.0,0.25984141212094,'A44',StatsF[1].RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_range_3,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_range_3/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','addrinputsubjectowned','0.5','HIGH',0.25984141212094,'NUMBER',0.0,0.25984141212094,'',StatsF[1].RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_range_4,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_addrinputsubjectowned_range_4/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','addrinputsubjectowned',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_1_0_sc_SCORECARD_model6,100*StatsF[1].RVC2004_1_0_sc_SCORECARD_model6/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','addrprevioustimeoldest','-998','-998',0.0,'NUMBER',0.0,0.227389143242477,'',StatsF[1].RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_range_1,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','addrprevioustimeoldest','-1','-1',0.0,'NUMBER',0.0,0.227389143242477,'C12',StatsF[1].RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_range_2,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_range_2/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','addrprevioustimeoldest','-999999999','205.5',-0.178058014191334,'NUMBER',0.0,0.227389143242477,'C13',StatsF[1].RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_range_3,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_range_3/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','addrprevioustimeoldest','205.5','353.5',0.180458239359927,'NUMBER',0.0,0.227389143242477,'C13',StatsF[1].RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_range_4,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_range_4/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','addrprevioustimeoldest','353.5','HIGH',0.227389143242477,'NUMBER',0.0,0.227389143242477,'',StatsF[1].RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_range_5,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_addrprevioustimeoldest_range_5/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','addrprevioustimeoldest',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_1_0_sc_SCORECARD_model6,100*StatsF[1].RVC2004_1_0_sc_SCORECARD_model6/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','addrprevioussubjectowned','-999999999','HIGH',0.0,'NUMBER',0.0,0.393204356454376,'C12',StatsF[1].RVC2004_1_0_SCORECARD_model6_addrprevioussubjectowned_range_1,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_addrprevioussubjectowned_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','addrprevioussubjectowned',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_1_0_sc_SCORECARD_model6,100*StatsF[1].RVC2004_1_0_sc_SCORECARD_model6/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','addrinputmatchindex','-998','-998',0.0,'NUMBER',0.0,0.109644071572997,'',StatsF[1].RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_range_1,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','addrinputmatchindex','-1','-1',0.0,'NUMBER',0.0,0.109644071572997,'C12',StatsF[1].RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_range_2,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_range_2/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','addrinputmatchindex','-999999999','1.5',-0.348450615891214,'NUMBER',0.0,0.109644071572997,'F01',StatsF[1].RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_range_3,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_range_3/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','addrinputmatchindex','1.5','HIGH',0.109644071572997,'NUMBER',0.0,0.109644071572997,'',StatsF[1].RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_range_4,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_addrinputmatchindex_range_4/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','addrinputmatchindex',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_1_0_sc_SCORECARD_model6,100*StatsF[1].RVC2004_1_0_sc_SCORECARD_model6/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','ChargeOffAmount','-998','-998',0.0,'NUMBER',0.0,0.375117906627449,'Z01',StatsF[1].RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_range_1,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','ChargeOffAmount','-1','-1',0.0,'NUMBER',0.0,0.375117906627449,'',StatsF[1].RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_range_2,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_range_2/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','ChargeOffAmount','-999999999','8546.265',0.375117906627449,'NUMBER',0.0,0.375117906627449,'',StatsF[1].RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_range_3,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_range_3/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','ChargeOffAmount','8546.265','18436.145',0.309244208292874,'NUMBER',0.0,0.375117906627449,'Z04',StatsF[1].RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_range_4,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_range_4/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','ChargeOffAmount','18436.145','34264.93',-0.0976038497040409,'NUMBER',0.0,0.375117906627449,'Z04',StatsF[1].RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_range_5,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_range_5/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','ChargeOffAmount','34264.93','HIGH',-0.285617568483362,'NUMBER',0.0,0.375117906627449,'Z04',StatsF[1].RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_range_6,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_ChargeOffAmount_range_6/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','ChargeOffAmount',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_1_0_sc_SCORECARD_model6,100*StatsF[1].RVC2004_1_0_sc_SCORECARD_model6/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','addrcurrentphoneservice','-998','-998',0.0,'NUMBER',0.0,0.17581248093876,'',StatsF[1].RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_range_1,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','addrcurrentphoneservice','-1','-1',0.0,'NUMBER',0.0,0.17581248093876,'C12',StatsF[1].RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_range_2,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_range_2/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','addrcurrentphoneservice','-999999999','0.5',-0.176496997665736,'NUMBER',0.0,0.17581248093876,'L78',StatsF[1].RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_range_3,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_range_3/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','addrcurrentphoneservice','0.5','HIGH',0.17581248093876,'NUMBER',0.0,0.17581248093876,'',StatsF[1].RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_range_4,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_addrcurrentphoneservice_range_4/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','addrcurrentphoneservice',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_1_0_sc_SCORECARD_model6,100*StatsF[1].RVC2004_1_0_sc_SCORECARD_model6/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','dayssince_ReceivedDate','-998','-998',0.0,'NUMBER',0.0,1.84983879208409,'Z01',StatsF[1].RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range_1,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','dayssince_ReceivedDate','-1','-1',0.0,'NUMBER',0.0,1.84983879208409,'',StatsF[1].RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range_2,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range_2/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','dayssince_ReceivedDate','-999999999','309',1.84983879208409,'NUMBER',0.0,1.84983879208409,'',StatsF[1].RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range_3,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range_3/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','dayssince_ReceivedDate','309','1358.5',0.933891056825015,'NUMBER',0.0,1.84983879208409,'Z02',StatsF[1].RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range_4,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range_4/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','dayssince_ReceivedDate','1358.5','2314',0.147011498338894,'NUMBER',0.0,1.84983879208409,'Z02',StatsF[1].RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range_5,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range_5/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','dayssince_ReceivedDate','2314','3731',0.0658874265823452,'NUMBER',0.0,1.84983879208409,'Z02',StatsF[1].RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range_6,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range_6/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','dayssince_ReceivedDate','3731','HIGH',-0.846610037669496,'NUMBER',0.0,1.84983879208409,'Z02',StatsF[1].RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range_7,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_dayssince_ReceivedDate_range_7/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','dayssince_ReceivedDate',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_1_0_sc_SCORECARD_model6,100*StatsF[1].RVC2004_1_0_sc_SCORECARD_model6/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','CollateralStatus','-998','-998',0.0,'NUMBER',0.0,0.506249019049611,'Z01',StatsF[1].RVC2004_1_0_SCORECARD_model6_CollateralStatus_range_1,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_CollateralStatus_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','CollateralStatus','Secured','Secured',0.506249019049611,'NUMBER',0.0,0.506249019049611,'',StatsF[1].RVC2004_1_0_SCORECARD_model6_CollateralStatus_range_2,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_CollateralStatus_range_2/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','CollateralStatus','Unsecured','Unsecured',-0.505505156657995,'NUMBER',0.0,0.506249019049611,'Z03',StatsF[1].RVC2004_1_0_SCORECARD_model6_CollateralStatus_range_3,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_CollateralStatus_range_3/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','CollateralStatus','','HIGH',0.0,'NUMBER',0.0,0.506249019049611,'Z03',StatsF[1].RVC2004_1_0_SCORECARD_model6_CollateralStatus_range_4,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_CollateralStatus_range_4/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','CollateralStatus',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_1_0_sc_SCORECARD_model6,100*StatsF[1].RVC2004_1_0_sc_SCORECARD_model6/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','dayssince_OpenDate','-998','-998',0.0,'NUMBER',0.0,0.518838613059721,'Z01',StatsF[1].RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_range_1,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','dayssince_OpenDate','-1','-1',0.0,'NUMBER',0.0,0.518838613059721,'',StatsF[1].RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_range_2,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_range_2/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','dayssince_OpenDate','-999999999','4785.5',0.518838613059721,'NUMBER',0.0,0.518838613059721,'',StatsF[1].RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_range_3,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_range_3/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','dayssince_OpenDate','4785.5','7697.5',-0.15284397845779,'NUMBER',0.0,0.518838613059721,'Z05',StatsF[1].RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_range_4,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_range_4/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','dayssince_OpenDate','7697.5','HIGH',-0.27403651626685,'NUMBER',0.0,0.518838613059721,'Z05',StatsF[1].RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_range_5,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_dayssince_OpenDate_range_5/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','dayssince_OpenDate',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_1_0_sc_SCORECARD_model6,100*StatsF[1].RVC2004_1_0_sc_SCORECARD_model6/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','OutOfStatuteIndicator','-998','-998',0.0,'NUMBER',0.0,0.400744957361021,'Z01',StatsF[1].RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_range_1,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','OutOfStatuteIndicator','N','N',0.400744957361021,'NUMBER',0.0,0.400744957361021,'',StatsF[1].RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_range_2,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_range_2/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','OutOfStatuteIndicator','Y','Y',-0.399632991058556,'NUMBER',0.0,0.400744957361021,'Z03',StatsF[1].RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_range_3,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_range_3/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','OutOfStatuteIndicator','','HIGH',0.0,'NUMBER',0.0,0.400744957361021,'Z03',StatsF[1].RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_range_4,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_OutOfStatuteIndicator_range_4/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','OutOfStatuteIndicator',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_1_0_sc_SCORECARD_model6,100*StatsF[1].RVC2004_1_0_sc_SCORECARD_model6/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','sourcecredheadertimeoldest','-998','-998',0.0,'NUMBER',0.0,0.393416528917569,'',StatsF[1].RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_range_1,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','sourcecredheadertimeoldest','-1','-1',0.0,'NUMBER',0.0,0.393416528917569,'C12',StatsF[1].RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_range_2,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_range_2/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','sourcecredheadertimeoldest','-999999999','345.5',-0.275087108555596,'NUMBER',0.0,0.393416528917569,'C20',StatsF[1].RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_range_3,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_range_3/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','sourcecredheadertimeoldest','345.5','423.5',0.0295111082163462,'NUMBER',0.0,0.393416528917569,'C20',StatsF[1].RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_range_4,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_range_4/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','sourcecredheadertimeoldest','423.5','HIGH',0.393416528917569,'NUMBER',0.0,0.393416528917569,'',StatsF[1].RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_range_5,100*StatsF[1].RVC2004_1_0_SCORECARD_model6_sourcecredheadertimeoldest_range_5/StatsF[1].TotalProcessed}
      ,{'RVC2004_1_0','Shellpoint Custom Model (neverpaid segment)','SCORECARD_model6','sourcecredheadertimeoldest',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_1_0_sc_SCORECARD_model6,100*StatsF[1].RVC2004_1_0_sc_SCORECARD_model6/StatsF[1].TotalProcessed}
    ],rvc2004_1_0.Results.StatsLayout);
  END;
  RETURN res(infile);
ENDMACRO;
