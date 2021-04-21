EXPORT AsResults(infile) := FUNCTIONMACRO

  Res(DATASET(RECORDOF(infile)) myfile) := MODULE(rvc2004_2_0.Results)
  IMPORT iesp;
  SHARED RCToMessage(SET OF STRING5 rc) := FUNCTION
    d1 := DATASET(rc,{ STRING5 Code });
    iesp.ins_share_iss.t_InsuranceScoreMessage into(d1 le) := TRANSFORM
      SELF.MessageType := rvc2004_2_0.RCCodes(le.code).GroupType;
      SELF.Description := rvc2004_2_0.RCCodes(le.code).Description;
      SELF.Code := le.code;
    END;
    RETURN PROJECT(d1,into(LEFT));
  END;
    // Simple and quick
  EXPORT BaseF := rvc2004_2_0.AppendAll(myfile,do_RVC2004_2_0,ChargeOffAmount,OutOfStatuteIndicator,addrinputownershipindex,confirmationinputaddress,confirmationsubjectfound,dayssince_LastPaymentDate,derogcount,inputprovidedphone,sourcecredheadertimeoldest,ssndeceased,subjectdeceased);
    BaseLayout TrRVC2004_2_0(BaseF le) := TRANSFORM
      SELF.TransactionId := le.TransactionId;
      SELF.name := 'RVC2004_2_0';
      SELF.description := 'Shellpoint Custom Model (previous_nonHE segment)';
      SELF.Score := (STRING)le.RVC2004_2_0_Score;
      SELF.Messages := RCToMessage(le.RVC2004_2_0_Reasons);
    END;
    RVC2004_2_0AsBase := PROJECT(BaseF,TrRVC2004_2_0(LEFT));
  EXPORT Base() := RVC2004_2_0AsBase;
    // With attributes
  EXPORT AttrF := rvc2004_2_0.AppendAll(myfile,do_RVC2004_2_0,ChargeOffAmount,OutOfStatuteIndicator,addrinputownershipindex,confirmationinputaddress,confirmationsubjectfound,dayssince_LastPaymentDate,derogcount,inputprovidedphone,sourcecredheadertimeoldest,ssndeceased,subjectdeceased);
    AttrLayout TrRVC2004_2_0(AttrF le) := TRANSFORM
      SELF.TransactionId := le.TransactionId;
      SELF.name := 'RVC2004_2_0';
      SELF.description := 'Shellpoint Custom Model (previous_nonHE segment)';
      SELF.Score := (STRING)le.RVC2004_2_0_Score;
      SELF.Messages := RCToMessage(le.RVC2004_2_0_Reasons);
      SELF.Attributes := DATASET([
          {'ChargeOffAmount',le.ChargeOffAmount},
          {'OutOfStatuteIndicator',le.OutOfStatuteIndicator},
          {'addrinputownershipindex',le.addrinputownershipindex},
          {'confirmationinputaddress',le.confirmationinputaddress},
          {'confirmationsubjectfound',le.confirmationsubjectfound},
          {'dayssince_LastPaymentDate',le.dayssince_LastPaymentDate},
          {'derogcount',le.derogcount},
          {'inputprovidedphone',le.inputprovidedphone},
          {'sourcecredheadertimeoldest',le.sourcecredheadertimeoldest},
          {'ssndeceased',le.ssndeceased},
          {'subjectdeceased',le.subjectdeceased}],NVPair);
    END;
    RVC2004_2_0AsAttr := PROJECT(AttrF,TrRVC2004_2_0(LEFT));
  EXPORT Attr() := RVC2004_2_0AsAttr;
    // Validation
  EXPORT ValidationF := rvc2004_2_0.AppendAll_Debug(myfile,do_RVC2004_2_0,ChargeOffAmount,OutOfStatuteIndicator,addrinputownershipindex,confirmationinputaddress,confirmationsubjectfound,dayssince_LastPaymentDate,derogcount,inputprovidedphone,sourcecredheadertimeoldest,ssndeceased,subjectdeceased);
    ValidationLayout TrRVC2004_2_0(ValidationF le) := TRANSFORM
      SELF.TransactionId := le.TransactionId;
      SELF.name := 'RVC2004_2_0';
      SELF.description := 'Shellpoint Custom Model (previous_nonHE segment)';
      SELF.Score := (STRING)le.RVC2004_2_0_Score;
      SELF.Messages := RCToMessage(le.RVC2004_2_0_Reasons);
      SELF.Attributes := DATASET([
          {'ChargeOffAmount',le.ChargeOffAmount},
          {'OutOfStatuteIndicator',le.OutOfStatuteIndicator},
          {'addrinputownershipindex',le.addrinputownershipindex},
          {'confirmationinputaddress',le.confirmationinputaddress},
          {'confirmationsubjectfound',le.confirmationsubjectfound},
          {'dayssince_LastPaymentDate',le.dayssince_LastPaymentDate},
          {'derogcount',le.derogcount},
          {'inputprovidedphone',le.inputprovidedphone},
          {'sourcecredheadertimeoldest',le.sourcecredheadertimeoldest},
          {'ssndeceased',le.ssndeceased},
          {'subjectdeceased',le.subjectdeceased}],NVPair);
      SELF.PointsAssignment := DATASET([
          {'ChargeOffAmount_pts',le.RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_score},
          {'OutOfStatuteIndicator_pts',le.RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_score},
          {'addrinputownershipindex_pts',le.RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_score},
          {'confirmationinputaddress_pts',le.RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_score},
          {'dayssince_LastPaymentDate_pts',le.RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_score},
          {'derogcount_pts',le.RVC2004_2_0_SCORECARD_model12_derogcount_score},
          {'inputprovidedphone_pts',le.RVC2004_2_0_SCORECARD_model12_inputprovidedphone_score},
          {'sourcecredheadertimeoldest_pts',le.RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_score}],NVPair);
      SELF.ScoreCard := 'SCORECARD_model12';
      SELF.score_date := StringLib.GetDateYYYYMMDD();
      SELF.raw_score := le.RVC2004_2_0_SCORECARD_model12_Score0;
      SELF.calc_temp_score := le.RVC2004_2_0_SCORECARD_model12_Score1;
      SELF.INSUFFICIENT_INFO := FALSE; // Insufficient_Info* not found
      SELF.NO_HIT := FALSE; // No_Hit* not found
      SELF.reason_codes_base := DATASET([
          {'ChargeOffAmount',le.RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_contribution_best,le.RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_reason},
          {'OutOfStatuteIndicator',le.RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_contribution_best,le.RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_reason},
          {'addrinputownershipindex',le.RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_contribution_best,le.RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_reason},
          {'confirmationinputaddress',le.RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_contribution_best,le.RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_reason},
          {'dayssince_LastPaymentDate',le.RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_contribution_best,le.RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_reason},
          {'derogcount',le.RVC2004_2_0_SCORECARD_model12_derogcount_contribution_best,le.RVC2004_2_0_SCORECARD_model12_derogcount_reason},
          {'inputprovidedphone',le.RVC2004_2_0_SCORECARD_model12_inputprovidedphone_contribution_best,le.RVC2004_2_0_SCORECARD_model12_inputprovidedphone_reason},
          {'sourcecredheadertimeoldest',le.RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_contribution_best,le.RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_reason}],RC_Contributions_Layout);
    END;
    RVC2004_2_0AsValidation := PROJECT(ValidationF,TrRVC2004_2_0(LEFT));
  EXPORT Validation() := RVC2004_2_0AsValidation;
// Now compute some statistics
  Accum := RECORD
    TotalProcessed := COUNT(GROUP);
    RVC2004_2_0_sc_SCORECARD_model12 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1);
    RVC2004_2_0_RV5_Attr_200 := COUNT(GROUP,ValidationF.RVC2004_2_0_RV5_Attr_200);
    RVC2004_2_0_RV5_Attr_222 := COUNT(GROUP,ValidationF.RVC2004_2_0_RV5_Attr_222);
    RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range_1 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range=1);
    RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range_2 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range=2);
    RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range_3 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range=3);
    RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range_4 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range=4);
    RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range_5 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range=5);
    RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range_6 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range=6);
    RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range_7 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range=7);
    RVC2004_2_0_SCORECARD_model12_derogcount_range_1 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_derogcount_range=1);
    RVC2004_2_0_SCORECARD_model12_derogcount_range_2 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_derogcount_range=2);
    RVC2004_2_0_SCORECARD_model12_derogcount_range_3 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_derogcount_range=3);
    RVC2004_2_0_SCORECARD_model12_derogcount_range_4 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_derogcount_range=4);
    RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_range_1 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_range=1);
    RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_range_2 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_range=2);
    RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_range_3 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_range=3);
    RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_range_4 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_range=4);
    RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range_1 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range=1);
    RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range_2 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range=2);
    RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range_3 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range=3);
    RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range_4 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range=4);
    RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range_5 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range=5);
    RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range_6 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range=6);
    RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range_7 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range=7);
    RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range_8 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range=8);
    RVC2004_2_0_SCORECARD_model12_inputprovidedphone_range_1 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_inputprovidedphone_range=1);
    RVC2004_2_0_SCORECARD_model12_inputprovidedphone_range_2 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_inputprovidedphone_range=2);
    RVC2004_2_0_SCORECARD_model12_inputprovidedphone_range_3 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_inputprovidedphone_range=3);
    RVC2004_2_0_SCORECARD_model12_inputprovidedphone_range_4 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_inputprovidedphone_range=4);
    RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_range_1 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_range=1);
    RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_range_2 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_range=2);
    RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_range_3 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_range=3);
    RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_range_4 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_range=4);
    RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_range_1 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_range=1);
    RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_range_2 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_range=2);
    RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_range_3 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_range=3);
    RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_range_4 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_range=4);
    RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_range_1 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_range=1);
    RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_range_2 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_range=2);
    RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_range_3 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_range=3);
    RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_range_4 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_range=4);
    RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_range_5 := COUNT(GROUP,ValidationF.RVC2004_2_0_sc = 1 AND ValidationF.RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_range=5);
  END;
  EXPORT StatsF := TABLE(ValidationF,Accum);
  EXPORT Stats() := DATASET([{'ADR Report','','','',0,0,0,'',0,0,'',0,0}
    ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','EXCEPTION','RV5_Attr_200',0,0,0,'',0,0,'',StatsF[1].RVC2004_2_0_RV5_Attr_200,100*StatsF[1].RVC2004_2_0_RV5_Attr_200/StatsF[1].TotalProcessed}
    ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','EXCEPTION','RV5_Attr_222',0,0,0,'',0,0,'',StatsF[1].RVC2004_2_0_RV5_Attr_222,100*StatsF[1].RVC2004_2_0_RV5_Attr_222/StatsF[1].TotalProcessed}
    ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','',0,0,0,'',0,0,'',StatsF[1].RVC2004_2_0_sc_SCORECARD_model12,100*StatsF[1].RVC2004_2_0_sc_SCORECARD_model12/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','dayssince_LastPaymentDate','-998','-998',0.0,'NUMBER',0.0,2.90868702779944,'Z01',StatsF[1].RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range_1,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','dayssince_LastPaymentDate','-1','-1',0.0,'NUMBER',0.0,2.90868702779944,'',StatsF[1].RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range_2,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range_2/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','dayssince_LastPaymentDate','-999999999','13.5',2.90868702779944,'NUMBER',0.0,2.90868702779944,'',StatsF[1].RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range_3,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range_3/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','dayssince_LastPaymentDate','13.5','25.5',2.79160099181279,'NUMBER',0.0,2.90868702779944,'Z06',StatsF[1].RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range_4,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range_4/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','dayssince_LastPaymentDate','25.5','63.5',1.8704884685878,'NUMBER',0.0,2.90868702779944,'Z06',StatsF[1].RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range_5,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range_5/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','dayssince_LastPaymentDate','63.5','227.5',0.148985327141811,'NUMBER',0.0,2.90868702779944,'Z06',StatsF[1].RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range_6,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range_6/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','dayssince_LastPaymentDate','227.5','HIGH',-2.28956824523366,'NUMBER',0.0,2.90868702779944,'Z06',StatsF[1].RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range_7,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_dayssince_LastPaymentDate_range_7/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','dayssince_LastPaymentDate',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_2_0_sc_SCORECARD_model12,100*StatsF[1].RVC2004_2_0_sc_SCORECARD_model12/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','derogcount','-998','-998',0.0,'NUMBER',0.0,0.206897909402591,'',StatsF[1].RVC2004_2_0_SCORECARD_model12_derogcount_range_1,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_derogcount_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','derogcount','-1','-1',0.0,'NUMBER',0.0,0.206897909402591,'C12',StatsF[1].RVC2004_2_0_SCORECARD_model12_derogcount_range_2,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_derogcount_range_2/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','derogcount','-999999999','1.5',0.206897909402591,'NUMBER',0.0,0.206897909402591,'',StatsF[1].RVC2004_2_0_SCORECARD_model12_derogcount_range_3,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_derogcount_range_3/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','derogcount','1.5','HIGH',-0.206841677937945,'NUMBER',0.0,0.206897909402591,'D30',StatsF[1].RVC2004_2_0_SCORECARD_model12_derogcount_range_4,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_derogcount_range_4/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','derogcount',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_2_0_sc_SCORECARD_model12,100*StatsF[1].RVC2004_2_0_sc_SCORECARD_model12/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','addrinputownershipindex','-998','-998',0.0,'NUMBER',0.0,0.123004769601752,'',StatsF[1].RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_range_1,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','addrinputownershipindex','-1','-1',0.0,'NUMBER',0.0,0.123004769601752,'C12',StatsF[1].RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_range_2,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_range_2/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','addrinputownershipindex','-999999999','3.5',-0.0530990948270477,'NUMBER',0.0,0.123004769601752,'A44',StatsF[1].RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_range_3,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_range_3/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','addrinputownershipindex','3.5','HIGH',0.123004769601752,'NUMBER',0.0,0.123004769601752,'',StatsF[1].RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_range_4,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_addrinputownershipindex_range_4/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','addrinputownershipindex',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_2_0_sc_SCORECARD_model12,100*StatsF[1].RVC2004_2_0_sc_SCORECARD_model12/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','ChargeOffAmount','-998','-998',0.0,'NUMBER',0.0,0.307355877385115,'Z01',StatsF[1].RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range_1,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','ChargeOffAmount','-1','-1',0.0,'NUMBER',0.0,0.307355877385115,'',StatsF[1].RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range_2,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range_2/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','ChargeOffAmount','-999999999','4432.92',-0.368397706825698,'NUMBER',0.0,0.307355877385115,'Z04',StatsF[1].RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range_3,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range_3/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','ChargeOffAmount','4432.92','11517.91',-0.124064717201017,'NUMBER',0.0,0.307355877385115,'Z04',StatsF[1].RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range_4,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range_4/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','ChargeOffAmount','11517.91','16063.795',-0.0427750798132533,'NUMBER',0.0,0.307355877385115,'Z04',StatsF[1].RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range_5,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range_5/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','ChargeOffAmount','16063.795','24316.115',0.0735522392490668,'NUMBER',0.0,0.307355877385115,'Z04',StatsF[1].RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range_6,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range_6/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','ChargeOffAmount','24316.115','47222.515',0.196296354816782,'NUMBER',0.0,0.307355877385115,'Z04',StatsF[1].RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range_7,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range_7/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','ChargeOffAmount','47222.515','HIGH',0.307355877385115,'NUMBER',0.0,0.307355877385115,'',StatsF[1].RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range_8,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_ChargeOffAmount_range_8/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','ChargeOffAmount',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_2_0_sc_SCORECARD_model12,100*StatsF[1].RVC2004_2_0_sc_SCORECARD_model12/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','inputprovidedphone','-998','-998',0.0,'NUMBER',0.0,0.11595697711271,'',StatsF[1].RVC2004_2_0_SCORECARD_model12_inputprovidedphone_range_1,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_inputprovidedphone_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','inputprovidedphone','-1','-1',0.0,'NUMBER',0.0,0.11595697711271,'C12',StatsF[1].RVC2004_2_0_SCORECARD_model12_inputprovidedphone_range_2,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_inputprovidedphone_range_2/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','inputprovidedphone','-999999999','0.5',-0.115997439845944,'NUMBER',0.0,0.11595697711271,'F05',StatsF[1].RVC2004_2_0_SCORECARD_model12_inputprovidedphone_range_3,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_inputprovidedphone_range_3/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','inputprovidedphone','0.5','HIGH',0.11595697711271,'NUMBER',0.0,0.11595697711271,'',StatsF[1].RVC2004_2_0_SCORECARD_model12_inputprovidedphone_range_4,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_inputprovidedphone_range_4/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','inputprovidedphone',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_2_0_sc_SCORECARD_model12,100*StatsF[1].RVC2004_2_0_sc_SCORECARD_model12/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','confirmationinputaddress','-998','-998',0.0,'NUMBER',0.0,0.0923792591262736,'',StatsF[1].RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_range_1,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','confirmationinputaddress','-1','-1',-0.337887501368304,'NUMBER',0.0,0.0923792591262736,'C12',StatsF[1].RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_range_2,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_range_2/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','confirmationinputaddress','-999999999','0.5',-3.92028713838522E-4,'NUMBER',0.0,0.0923792591262736,'F01',StatsF[1].RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_range_3,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_range_3/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','confirmationinputaddress','0.5','HIGH',0.0923792591262736,'NUMBER',0.0,0.0923792591262736,'',StatsF[1].RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_range_4,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_confirmationinputaddress_range_4/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','confirmationinputaddress',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_2_0_sc_SCORECARD_model12,100*StatsF[1].RVC2004_2_0_sc_SCORECARD_model12/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','OutOfStatuteIndicator','-998','-998',0.0,'NUMBER',0.0,0.522622593458921,'Z01',StatsF[1].RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_range_1,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','OutOfStatuteIndicator','N','N',0.522622593458921,'NUMBER',0.0,0.522622593458921,'',StatsF[1].RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_range_2,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_range_2/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','OutOfStatuteIndicator','Y','Y',-0.52216878252275,'NUMBER',0.0,0.522622593458921,'Z03',StatsF[1].RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_range_3,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_range_3/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','OutOfStatuteIndicator','','HIGH',0.0,'NUMBER',0.0,0.522622593458921,'Z03',StatsF[1].RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_range_4,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_OutOfStatuteIndicator_range_4/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','OutOfStatuteIndicator',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_2_0_sc_SCORECARD_model12,100*StatsF[1].RVC2004_2_0_sc_SCORECARD_model12/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','sourcecredheadertimeoldest','-998','-998',0.0,'NUMBER',0.0,0.188800668917611,'',StatsF[1].RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_range_1,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_range_1/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','sourcecredheadertimeoldest','-1','-1',0.0,'NUMBER',0.0,0.188800668917611,'C12',StatsF[1].RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_range_2,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_range_2/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','sourcecredheadertimeoldest','-999999999','293.5',-0.135530518722703,'NUMBER',0.0,0.188800668917611,'C20',StatsF[1].RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_range_3,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_range_3/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','sourcecredheadertimeoldest','293.5','421.5',-0.0694870572956636,'NUMBER',0.0,0.188800668917611,'C20',StatsF[1].RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_range_4,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_range_4/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','sourcecredheadertimeoldest','421.5','HIGH',0.188800668917611,'NUMBER',0.0,0.188800668917611,'',StatsF[1].RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_range_5,100*StatsF[1].RVC2004_2_0_SCORECARD_model12_sourcecredheadertimeoldest_range_5/StatsF[1].TotalProcessed}
      ,{'RVC2004_2_0','Shellpoint Custom Model (previous_nonHE segment)','SCORECARD_model12','sourcecredheadertimeoldest',0,0,0,'TOTAL',0,0,'',StatsF[1].RVC2004_2_0_sc_SCORECARD_model12,100*StatsF[1].RVC2004_2_0_sc_SCORECARD_model12/StatsF[1].TotalProcessed}
    ],rvc2004_2_0.Results.StatsLayout);
  END;
  RETURN res(infile);
ENDMACRO;
