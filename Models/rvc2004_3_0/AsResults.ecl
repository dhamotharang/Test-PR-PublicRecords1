EXPORT AsResults(infile) := FUNCTIONMACRO

  Res(DATASET(RECORDOF(infile)) myfile) := MODULE(rvc2004_3_0.Results)
  IMPORT iesp;
  SHARED RCToMessage(SET OF STRING5 rc) := FUNCTION
    d1 := DATASET(rc,{ STRING5 Code });
    iesp.ins_share_iss.t_InsuranceScoreMessage into(d1 le) := TRANSFORM
      SELF.MessageType := rvc2004_3_0.RCCodes(le.code).GroupType;
      SELF.Description := rvc2004_3_0.RCCodes(le.code).Description;
      SELF.Code := le.code;
    END;
    RETURN PROJECT(d1,into(LEFT));
  END;
    // Simple and quick
  EXPORT BaseF := rvc2004_3_0.AppendAll(myfile,do_RVC2004_3_0,CollateralStatus,OutOfStatuteIndicator,addrinputlengthofres,addrprevioustimeoldest,bankruptcycount,confirmationsubjectfound,dayssince_LastPaymentDate,derogcount,inputprovidedphone,inquirycollections12month,ssndeceased,subjectdeceased);
    BaseLayout TrRVC2004_3_0(BaseF le) := TRANSFORM
      SELF.TransactionId := le.TransactionId;
      SELF.name := 'RVC2004_3_0';
      SELF.description := 'Shellpoint Custom Model (previous_HE segment)';
      SELF.Score := (STRING)le.RVC2004_3_0_Score;
      SELF.Messages := RCToMessage(le.RVC2004_3_0_Reasons);
    END;
    RVC2004_3_0AsBase := PROJECT(BaseF,TrRVC2004_3_0(LEFT));
  EXPORT Base() := RVC2004_3_0AsBase;
    // With attributes
  EXPORT AttrF := rvc2004_3_0.AppendAll(myfile,do_RVC2004_3_0,CollateralStatus,OutOfStatuteIndicator,addrinputlengthofres,addrprevioustimeoldest,bankruptcycount,confirmationsubjectfound,dayssince_LastPaymentDate,derogcount,inputprovidedphone,inquirycollections12month,ssndeceased,subjectdeceased);
    AttrLayout TrRVC2004_3_0(AttrF le) := TRANSFORM
      SELF.TransactionId := le.TransactionId;
      SELF.name := 'RVC2004_3_0';
      SELF.description := 'Shellpoint Custom Model (previous_HE segment)';
      SELF.Score := (STRING)le.RVC2004_3_0_Score;
      SELF.Messages := RCToMessage(le.RVC2004_3_0_Reasons);
      SELF.Attributes := DATASET([
          {'CollateralStatus',le.CollateralStatus},
          {'OutOfStatuteIndicator',le.OutOfStatuteIndicator},
          {'addrinputlengthofres',le.addrinputlengthofres},
          {'addrprevioustimeoldest',le.addrprevioustimeoldest},
          {'bankruptcycount',le.bankruptcycount},
          {'confirmationsubjectfound',le.confirmationsubjectfound},
          {'dayssince_LastPaymentDate',le.dayssince_LastPaymentDate},
          {'derogcount',le.derogcount},
          {'inputprovidedphone',le.inputprovidedphone},
          {'inquirycollections12month',le.inquirycollections12month},
          {'ssndeceased',le.ssndeceased},
          {'subjectdeceased',le.subjectdeceased}],NVPair);
    END;
    RVC2004_3_0AsAttr := PROJECT(AttrF,TrRVC2004_3_0(LEFT));
  EXPORT Attr() := RVC2004_3_0AsAttr;
    // Validation
  EXPORT ValidationF := rvc2004_3_0.AppendAll_Debug(myfile,do_RVC2004_3_0,CollateralStatus,OutOfStatuteIndicator,addrinputlengthofres,addrprevioustimeoldest,bankruptcycount,confirmationsubjectfound,dayssince_LastPaymentDate,derogcount,inputprovidedphone,inquirycollections12month,ssndeceased,subjectdeceased);
    ValidationLayout TrRVC2004_3_0(ValidationF le) := TRANSFORM
      SELF.TransactionId := le.TransactionId;
      SELF.name := 'RVC2004_3_0';
      SELF.description := 'Shellpoint Custom Model (previous_HE segment)';
      SELF.Score := (STRING)le.RVC2004_3_0_Score;
      SELF.Messages := RCToMessage(le.RVC2004_3_0_Reasons);
      SELF.Attributes := DATASET([
          {'CollateralStatus',le.CollateralStatus},
          {'OutOfStatuteIndicator',le.OutOfStatuteIndicator},
          {'addrinputlengthofres',le.addrinputlengthofres},
          {'addrprevioustimeoldest',le.addrprevioustimeoldest},
          {'bankruptcycount',le.bankruptcycount},
          {'confirmationsubjectfound',le.confirmationsubjectfound},
          {'dayssince_LastPaymentDate',le.dayssince_LastPaymentDate},
          {'derogcount',le.derogcount},
          {'inputprovidedphone',le.inputprovidedphone},
          {'inquirycollections12month',le.inquirycollections12month},
          {'ssndeceased',le.ssndeceased},
          {'subjectdeceased',le.subjectdeceased}],NVPair);
      SELF.PointsAssignment := DATASET([
          {'CollateralStatus_pts',le.RVC2004_3_0_SCORECARD_model13_CollateralStatus_score},
          {'OutOfStatuteIndicator_pts',le.RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_score},
          {'addrinputlengthofres_pts',le.RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_score},
          {'addrprevioustimeoldest_pts',le.RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_score},
          {'bankruptcycount_pts',le.RVC2004_3_0_SCORECARD_model13_bankruptcycount_score},
          {'dayssince_LastPaymentDate_pts',le.RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_score},
          {'derogcount_pts',le.RVC2004_3_0_SCORECARD_model13_derogcount_score},
          {'inputprovidedphone_pts',le.RVC2004_3_0_SCORECARD_model13_inputprovidedphone_score},
          {'inquirycollections12month_pts',le.RVC2004_3_0_SCORECARD_model13_inquirycollections12month_score}],NVPair);
      SELF.ScoreCard := 'SCORECARD_model13';
      SELF.score_date := StringLib.GetDateYYYYMMDD();
      SELF.raw_score := le.RVC2004_3_0_SCORECARD_model13_Score0;
      SELF.calc_temp_score := le.RVC2004_3_0_SCORECARD_model13_Score1;
      SELF.INSUFFICIENT_INFO := FALSE; // Insufficient_Info* not found
      SELF.NO_HIT := FALSE; // No_Hit* not found
      SELF.reason_codes_base := DATASET([
          {'CollateralStatus',le.RVC2004_3_0_SCORECARD_model13_CollateralStatus_contribution_best,le.RVC2004_3_0_SCORECARD_model13_CollateralStatus_reason},
          {'OutOfStatuteIndicator',le.RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_contribution_best,le.RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_reason},
          {'addrinputlengthofres',le.RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_contribution_best,le.RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_reason},
          {'addrprevioustimeoldest',le.RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_contribution_best,le.RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_reason},
          {'bankruptcycount',le.RVC2004_3_0_SCORECARD_model13_bankruptcycount_contribution_best,le.RVC2004_3_0_SCORECARD_model13_bankruptcycount_reason},
          {'dayssince_LastPaymentDate',le.RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_contribution_best,le.RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_reason},
          {'derogcount',le.RVC2004_3_0_SCORECARD_model13_derogcount_contribution_best,le.RVC2004_3_0_SCORECARD_model13_derogcount_reason},
          {'inputprovidedphone',le.RVC2004_3_0_SCORECARD_model13_inputprovidedphone_contribution_best,le.RVC2004_3_0_SCORECARD_model13_inputprovidedphone_reason},
          {'inquirycollections12month',le.RVC2004_3_0_SCORECARD_model13_inquirycollections12month_contribution_best,le.RVC2004_3_0_SCORECARD_model13_inquirycollections12month_reason}],RC_Contributions_Layout);
    END;
    RVC2004_3_0AsValidation := PROJECT(ValidationF,TrRVC2004_3_0(LEFT));
  EXPORT Validation() := RVC2004_3_0AsValidation;
// Now compute some statistics
  Accum := RECORD
    TotalProcessed := COUNT(GROUP);
    RVC2004_3_0_sc_SCORECARD_model13 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1);
    RVC2004_3_0_RV5_Attr_200 := COUNT(GROUP,ValidationF.RVC2004_3_0_RV5_Attr_200);
    RVC2004_3_0_RV5_Attr_222 := COUNT(GROUP,ValidationF.RVC2004_3_0_RV5_Attr_222);
    RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_1 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range=1);
    RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_2 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range=2);
    RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_3 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range=3);
    RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_4 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range=4);
    RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_5 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range=5);
    RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_6 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range=6);
    RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_7 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range=7);
    RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_8 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range=8);
    RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_9 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range=9);
    RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_10 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range=10);
    RVC2004_3_0_SCORECARD_model13_derogcount_range_1 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_derogcount_range=1);
    RVC2004_3_0_SCORECARD_model13_derogcount_range_2 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_derogcount_range=2);
    RVC2004_3_0_SCORECARD_model13_derogcount_range_3 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_derogcount_range=3);
    RVC2004_3_0_SCORECARD_model13_derogcount_range_4 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_derogcount_range=4);
    RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_range_1 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_range=1);
    RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_range_2 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_range=2);
    RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_range_3 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_range=3);
    RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_range_4 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_range=4);
    RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_range_5 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_range=5);
    RVC2004_3_0_SCORECARD_model13_inquirycollections12month_range_1 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_inquirycollections12month_range=1);
    RVC2004_3_0_SCORECARD_model13_inquirycollections12month_range_2 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_inquirycollections12month_range=2);
    RVC2004_3_0_SCORECARD_model13_inquirycollections12month_range_3 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_inquirycollections12month_range=3);
    RVC2004_3_0_SCORECARD_model13_inquirycollections12month_range_4 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_inquirycollections12month_range=4);
    RVC2004_3_0_SCORECARD_model13_bankruptcycount_range_1 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_bankruptcycount_range=1);
    RVC2004_3_0_SCORECARD_model13_bankruptcycount_range_2 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_bankruptcycount_range=2);
    RVC2004_3_0_SCORECARD_model13_bankruptcycount_range_3 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_bankruptcycount_range=3);
    RVC2004_3_0_SCORECARD_model13_bankruptcycount_range_4 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_bankruptcycount_range=4);
    RVC2004_3_0_SCORECARD_model13_CollateralStatus_range_1 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_CollateralStatus_range=1);
    RVC2004_3_0_SCORECARD_model13_CollateralStatus_range_2 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_CollateralStatus_range=2);
    RVC2004_3_0_SCORECARD_model13_CollateralStatus_range_3 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_CollateralStatus_range=3);
    RVC2004_3_0_SCORECARD_model13_CollateralStatus_range_4 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_CollateralStatus_range=4);
    RVC2004_3_0_SCORECARD_model13_inputprovidedphone_range_1 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_inputprovidedphone_range=1);
    RVC2004_3_0_SCORECARD_model13_inputprovidedphone_range_2 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_inputprovidedphone_range=2);
    RVC2004_3_0_SCORECARD_model13_inputprovidedphone_range_3 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_inputprovidedphone_range=3);
    RVC2004_3_0_SCORECARD_model13_inputprovidedphone_range_4 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_inputprovidedphone_range=4);
    RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range_1 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range=1);
    RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range_2 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range=2);
    RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range_3 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range=3);
    RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range_4 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range=4);
    RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range_5 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range=5);
    RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range_6 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range=6);
    RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range_7 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range=7);
    RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_range_1 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_range=1);
    RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_range_2 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_range=2);
    RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_range_3 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_range=3);
    RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_range_4 := COUNT(GROUP,ValidationF.RVC2004_3_0_sc = 1 AND ValidationF.RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_range=4);
  END;
  EXPORT StatsF := TABLE(ValidationF,Accum);
  EXPORT Stats() := DATASET([{'ADR Report','','','',0,0,0,'',0,0,'',0,0}
    ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','EXCEPTION','RV5_Attr_200',0,0,0,'',0,0,'',StatsF[1].RVC2004_3_0_RV5_Attr_200,100*StatsF[1].RVC2004_3_0_RV5_Attr_200/StatsF[1].TotalProcessed}
    ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','EXCEPTION','RV5_Attr_222',0,0,0,'',0,0,'',StatsF[1].RVC2004_3_0_RV5_Attr_222,100*StatsF[1].RVC2004_3_0_RV5_Attr_222/StatsF[1].TotalProcessed}
    ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','',0,0,0,'',0,0,'',StatsF[1].RVC2004_3_0_sc_SCORECARD_model13,100*StatsF[1].RVC2004_3_0_sc_SCORECARD_model13/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','dayssince_LastPaymentDate','-998','-998',0.0,'NUMBER',0.0,2.78502174482666,'Z01',StatsF[1].RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_1,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','dayssince_LastPaymentDate','-1','-1',0.0,'NUMBER',0.0,2.78502174482666,'',StatsF[1].RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_2,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_2/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','dayssince_LastPaymentDate','-999999999','20.5',2.78502174482666,'NUMBER',0.0,2.78502174482666,'',StatsF[1].RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_3,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_3/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','dayssince_LastPaymentDate','20.5','22.5',2.47927717616396,'NUMBER',0.0,2.78502174482666,'Z06',StatsF[1].RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_4,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_4/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','dayssince_LastPaymentDate','22.5','31.5',2.289394242031,'NUMBER',0.0,2.78502174482666,'Z06',StatsF[1].RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_5,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_5/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','dayssince_LastPaymentDate','31.5','40.5',2.16059645912678,'NUMBER',0.0,2.78502174482666,'Z06',StatsF[1].RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_6,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_6/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','dayssince_LastPaymentDate','40.5','97.5',1.28419126267805,'NUMBER',0.0,2.78502174482666,'Z06',StatsF[1].RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_7,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_7/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','dayssince_LastPaymentDate','97.5','473',-0.801117736469187,'NUMBER',0.0,2.78502174482666,'Z06',StatsF[1].RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_8,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_8/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','dayssince_LastPaymentDate','473','1298',-1.56111814895788,'NUMBER',0.0,2.78502174482666,'Z06',StatsF[1].RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_9,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_9/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','dayssince_LastPaymentDate','1298','HIGH',-1.88830934823268,'NUMBER',0.0,2.78502174482666,'Z06',StatsF[1].RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_10,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_dayssince_LastPaymentDate_range_10/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','dayssince_LastPaymentDate',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_3_0_sc_SCORECARD_model13,100*StatsF[1].RVC2004_3_0_sc_SCORECARD_model13/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','derogcount','-998','-998',0.0,'NUMBER',0.0,0.09127972345498,'',StatsF[1].RVC2004_3_0_SCORECARD_model13_derogcount_range_1,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_derogcount_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','derogcount','-1','-1',0.0,'NUMBER',0.0,0.09127972345498,'C12',StatsF[1].RVC2004_3_0_SCORECARD_model13_derogcount_range_2,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_derogcount_range_2/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','derogcount','-999999999','0.5',0.09127972345498,'NUMBER',0.0,0.09127972345498,'',StatsF[1].RVC2004_3_0_SCORECARD_model13_derogcount_range_3,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_derogcount_range_3/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','derogcount','0.5','HIGH',-0.0912002663257225,'NUMBER',0.0,0.09127972345498,'D30',StatsF[1].RVC2004_3_0_SCORECARD_model13_derogcount_range_4,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_derogcount_range_4/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','derogcount',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_3_0_sc_SCORECARD_model13,100*StatsF[1].RVC2004_3_0_sc_SCORECARD_model13/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','addrprevioustimeoldest','-998','-998',0.0,'NUMBER',0.0,0.0766876845593337,'',StatsF[1].RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_range_1,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','addrprevioustimeoldest','-1','-1',0.0,'NUMBER',0.0,0.0766876845593337,'C12',StatsF[1].RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_range_2,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_range_2/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','addrprevioustimeoldest','-999999999','63.5',-0.243533121323617,'NUMBER',0.0,0.0766876845593337,'C13',StatsF[1].RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_range_3,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_range_3/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','addrprevioustimeoldest','63.5','293.5',0.0163999320923906,'NUMBER',0.0,0.0766876845593337,'C13',StatsF[1].RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_range_4,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_range_4/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','addrprevioustimeoldest','293.5','HIGH',0.0766876845593337,'NUMBER',0.0,0.0766876845593337,'',StatsF[1].RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_range_5,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_addrprevioustimeoldest_range_5/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','addrprevioustimeoldest',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_3_0_sc_SCORECARD_model13,100*StatsF[1].RVC2004_3_0_sc_SCORECARD_model13/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','inquirycollections12month','-998','-998',0.0,'NUMBER',0.0,0.230273226976335,'',StatsF[1].RVC2004_3_0_SCORECARD_model13_inquirycollections12month_range_1,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_inquirycollections12month_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','inquirycollections12month','-1','-1',0.0,'NUMBER',0.0,0.230273226976335,'C12',StatsF[1].RVC2004_3_0_SCORECARD_model13_inquirycollections12month_range_2,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_inquirycollections12month_range_2/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','inquirycollections12month','-999999999','0.5',0.230273226976335,'NUMBER',0.0,0.230273226976335,'',StatsF[1].RVC2004_3_0_SCORECARD_model13_inquirycollections12month_range_3,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_inquirycollections12month_range_3/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','inquirycollections12month','0.5','HIGH',-0.230087456778504,'NUMBER',0.0,0.230273226976335,'I61',StatsF[1].RVC2004_3_0_SCORECARD_model13_inquirycollections12month_range_4,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_inquirycollections12month_range_4/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','inquirycollections12month',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_3_0_sc_SCORECARD_model13,100*StatsF[1].RVC2004_3_0_sc_SCORECARD_model13/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','bankruptcycount','-998','-998',0.0,'NUMBER',0.0,0.22054154165021,'',StatsF[1].RVC2004_3_0_SCORECARD_model13_bankruptcycount_range_1,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_bankruptcycount_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','bankruptcycount','-1','-1',0.0,'NUMBER',0.0,0.22054154165021,'C12',StatsF[1].RVC2004_3_0_SCORECARD_model13_bankruptcycount_range_2,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_bankruptcycount_range_2/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','bankruptcycount','-999999999','0.5',0.22054154165021,'NUMBER',0.0,0.22054154165021,'',StatsF[1].RVC2004_3_0_SCORECARD_model13_bankruptcycount_range_3,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_bankruptcycount_range_3/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','bankruptcycount','0.5','HIGH',-0.220487704235926,'NUMBER',0.0,0.22054154165021,'D31',StatsF[1].RVC2004_3_0_SCORECARD_model13_bankruptcycount_range_4,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_bankruptcycount_range_4/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','bankruptcycount',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_3_0_sc_SCORECARD_model13,100*StatsF[1].RVC2004_3_0_sc_SCORECARD_model13/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','CollateralStatus','-998','-998',0.0,'NUMBER',0.0,0.175881297202286,'Z01',StatsF[1].RVC2004_3_0_SCORECARD_model13_CollateralStatus_range_1,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_CollateralStatus_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','CollateralStatus','Secured','Secured',0.175881297202286,'NUMBER',0.0,0.175881297202286,'',StatsF[1].RVC2004_3_0_SCORECARD_model13_CollateralStatus_range_2,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_CollateralStatus_range_2/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','CollateralStatus','Unsecured','Unsecured',-0.175769990917404,'NUMBER',0.0,0.175881297202286,'Z03',StatsF[1].RVC2004_3_0_SCORECARD_model13_CollateralStatus_range_3,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_CollateralStatus_range_3/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','CollateralStatus','','HIGH',0.0,'NUMBER',0.0,0.175881297202286,'Z03',StatsF[1].RVC2004_3_0_SCORECARD_model13_CollateralStatus_range_4,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_CollateralStatus_range_4/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','CollateralStatus',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_3_0_sc_SCORECARD_model13,100*StatsF[1].RVC2004_3_0_sc_SCORECARD_model13/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','inputprovidedphone','-998','-998',0.0,'NUMBER',0.0,0.126065595425946,'',StatsF[1].RVC2004_3_0_SCORECARD_model13_inputprovidedphone_range_1,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_inputprovidedphone_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','inputprovidedphone','-1','-1',0.0,'NUMBER',0.0,0.126065595425946,'C12',StatsF[1].RVC2004_3_0_SCORECARD_model13_inputprovidedphone_range_2,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_inputprovidedphone_range_2/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','inputprovidedphone','-999999999','0.5',-0.126184162516679,'NUMBER',0.0,0.126065595425946,'F05',StatsF[1].RVC2004_3_0_SCORECARD_model13_inputprovidedphone_range_3,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_inputprovidedphone_range_3/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','inputprovidedphone','0.5','HIGH',0.126065595425946,'NUMBER',0.0,0.126065595425946,'',StatsF[1].RVC2004_3_0_SCORECARD_model13_inputprovidedphone_range_4,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_inputprovidedphone_range_4/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','inputprovidedphone',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_3_0_sc_SCORECARD_model13,100*StatsF[1].RVC2004_3_0_sc_SCORECARD_model13/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','addrinputlengthofres','-998','-998',0.0,'NUMBER',0.0,0.380188696628816,'',StatsF[1].RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range_1,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','addrinputlengthofres','-1','-1',0.0,'NUMBER',0.0,0.380188696628816,'C12',StatsF[1].RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range_2,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range_2/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','addrinputlengthofres','-999999999','85.5',-0.162252436093801,'NUMBER',0.0,0.380188696628816,'C13',StatsF[1].RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range_3,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range_3/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','addrinputlengthofres','85.5','175.5',-0.0744986191707646,'NUMBER',0.0,0.380188696628816,'C13',StatsF[1].RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range_4,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range_4/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','addrinputlengthofres','175.5','228.5',0.0134295817085936,'NUMBER',0.0,0.380188696628816,'C13',StatsF[1].RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range_5,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range_5/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','addrinputlengthofres','228.5','401.5',0.106913758369424,'NUMBER',0.0,0.380188696628816,'C13',StatsF[1].RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range_6,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range_6/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','addrinputlengthofres','401.5','HIGH',0.380188696628816,'NUMBER',0.0,0.380188696628816,'',StatsF[1].RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range_7,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_addrinputlengthofres_range_7/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','addrinputlengthofres',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_3_0_sc_SCORECARD_model13,100*StatsF[1].RVC2004_3_0_sc_SCORECARD_model13/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','OutOfStatuteIndicator','-998','-998',0.0,'NUMBER',0.0,0.517999357387536,'Z01',StatsF[1].RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_range_1,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','OutOfStatuteIndicator','N','N',0.517999357387536,'NUMBER',0.0,0.517999357387536,'',StatsF[1].RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_range_2,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_range_2/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','OutOfStatuteIndicator','Y','Y',-0.517699218854416,'NUMBER',0.0,0.517999357387536,'Z03',StatsF[1].RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_range_3,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_range_3/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','OutOfStatuteIndicator','','HIGH',0.0,'NUMBER',0.0,0.517999357387536,'Z03',StatsF[1].RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_range_4,100*StatsF[1].RVC2004_3_0_SCORECARD_model13_OutOfStatuteIndicator_range_4/StatsF[1].TotalProcessed}
      ,{'RVC2004_3_0','Shellpoint Custom Model (previous_HE segment)','SCORECARD_model13','OutOfStatuteIndicator',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_3_0_sc_SCORECARD_model13,100*StatsF[1].RVC2004_3_0_sc_SCORECARD_model13/StatsF[1].TotalProcessed}
    ],rvc2004_3_0.Results.StatsLayout);
  END;
  RETURN res(infile);
ENDMACRO;
