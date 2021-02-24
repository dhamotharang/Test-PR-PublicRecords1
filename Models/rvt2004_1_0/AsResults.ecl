EXPORT AsResults(infile) := FUNCTIONMACRO

  Res(DATASET(RECORDOF(infile)) myfile) := MODULE(rvt2004_1_0.Results)
  IMPORT iesp;
  SHARED RCToMessage(SET OF STRING5 rc) := FUNCTION
    d1 := DATASET(rc,{ STRING5 Code });
    iesp.ins_share_iss.t_InsuranceScoreMessage into(d1 le) := TRANSFORM
      SELF.MessageType := rvt2004_1_0.RCCodes(le.code).GroupType;
      SELF.Description := rvt2004_1_0.RCCodes(le.code).Description;
      SELF.Code := le.code;
    END;
    RETURN PROJECT(d1,into(LEFT));
  END;
    // Simple and quick
  EXPORT BaseF := rvt2004_1_0.AppendAll(myfile,do_RVT2004_1_0,addrchangecount60month,addrcurrentownershipindex,addronfilecount,addrprevioustimeoldest,alertregulatorycondition,assetpropevercount,bankruptcystatus,confirmationsubjectfound,evictioncount,inquiryauto12month,inquirybanking12month,inquirycollections12month,inquiryshortterm12month,lienjudgmentcount,shorttermloanrequest,sourcenonderogcount,sourcenonderogcount06month,ssndeceased,subjectdeceased,subjectrecordtimeoldest);
    BaseLayout TrRVT2004_1_0(BaseF le) := TRANSFORM
      SELF.TransactionId := le.TransactionId;
      SELF.name := 'RVT2004_1_0';
      SELF.description := 'T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386';
      SELF.Score := (STRING)le.RVT2004_1_0_Score;
      SELF.Messages := RCToMessage(le.RVT2004_1_0_Reasons);
    END;
    RVT2004_1_0AsBase := PROJECT(BaseF,TrRVT2004_1_0(LEFT));
  EXPORT Base() := RVT2004_1_0AsBase;
    // With attributes
  EXPORT AttrF := rvt2004_1_0.AppendAll(myfile,do_RVT2004_1_0,addrchangecount60month,addrcurrentownershipindex,addronfilecount,addrprevioustimeoldest,alertregulatorycondition,assetpropevercount,bankruptcystatus,confirmationsubjectfound,evictioncount,inquiryauto12month,inquirybanking12month,inquirycollections12month,inquiryshortterm12month,lienjudgmentcount,shorttermloanrequest,sourcenonderogcount,sourcenonderogcount06month,ssndeceased,subjectdeceased,subjectrecordtimeoldest);
    AttrLayout TrRVT2004_1_0(AttrF le) := TRANSFORM
      SELF.TransactionId := le.TransactionId;
      SELF.name := 'RVT2004_1_0';
      SELF.description := 'T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386';
      SELF.Score := (STRING)le.RVT2004_1_0_Score;
      SELF.Messages := RCToMessage(le.RVT2004_1_0_Reasons);
      SELF.Attributes := DATASET([
          {'addrchangecount60month',le.addrchangecount60month},
          {'addrcurrentownershipindex',le.addrcurrentownershipindex},
          {'addronfilecount',le.addronfilecount},
          {'addrprevioustimeoldest',le.addrprevioustimeoldest},
          {'alertregulatorycondition',le.alertregulatorycondition},
          {'assetpropevercount',le.assetpropevercount},
          {'bankruptcystatus',le.bankruptcystatus},
          {'confirmationsubjectfound',le.confirmationsubjectfound},
          {'evictioncount',le.evictioncount},
          {'inquiryauto12month',le.inquiryauto12month},
          {'inquirybanking12month',le.inquirybanking12month},
          {'inquirycollections12month',le.inquirycollections12month},
          {'inquiryshortterm12month',le.inquiryshortterm12month},
          {'lienjudgmentcount',le.lienjudgmentcount},
          {'shorttermloanrequest',le.shorttermloanrequest},
          {'sourcenonderogcount',le.sourcenonderogcount},
          {'sourcenonderogcount06month',le.sourcenonderogcount06month},
          {'ssndeceased',le.ssndeceased},
          {'subjectdeceased',le.subjectdeceased},
          {'subjectrecordtimeoldest',le.subjectrecordtimeoldest}],NVPair);
    END;
    RVT2004_1_0AsAttr := PROJECT(AttrF,TrRVT2004_1_0(LEFT));
  EXPORT Attr() := RVT2004_1_0AsAttr;
    // Validation
  EXPORT ValidationF := rvt2004_1_0.AppendAll_Debug(myfile,do_RVT2004_1_0,addrchangecount60month,addrcurrentownershipindex,addronfilecount,addrprevioustimeoldest,alertregulatorycondition,assetpropevercount,bankruptcystatus,confirmationsubjectfound,evictioncount,inquiryauto12month,inquirybanking12month,inquirycollections12month,inquiryshortterm12month,lienjudgmentcount,shorttermloanrequest,sourcenonderogcount,sourcenonderogcount06month,ssndeceased,subjectdeceased,subjectrecordtimeoldest);
    ValidationLayout TrRVT2004_1_0(ValidationF le) := TRANSFORM
      SELF.TransactionId := le.TransactionId;
      SELF.name := 'RVT2004_1_0';
      SELF.description := 'T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386';
      SELF.Score := (STRING)le.RVT2004_1_0_Score;
      SELF.Messages := RCToMessage(le.RVT2004_1_0_Reasons);
      SELF.Attributes := DATASET([
          {'addrchangecount60month',le.addrchangecount60month},
          {'addrcurrentownershipindex',le.addrcurrentownershipindex},
          {'addronfilecount',le.addronfilecount},
          {'addrprevioustimeoldest',le.addrprevioustimeoldest},
          {'alertregulatorycondition',le.alertregulatorycondition},
          {'assetpropevercount',le.assetpropevercount},
          {'bankruptcystatus',le.bankruptcystatus},
          {'confirmationsubjectfound',le.confirmationsubjectfound},
          {'evictioncount',le.evictioncount},
          {'inquiryauto12month',le.inquiryauto12month},
          {'inquirybanking12month',le.inquirybanking12month},
          {'inquirycollections12month',le.inquirycollections12month},
          {'inquiryshortterm12month',le.inquiryshortterm12month},
          {'lienjudgmentcount',le.lienjudgmentcount},
          {'shorttermloanrequest',le.shorttermloanrequest},
          {'sourcenonderogcount',le.sourcenonderogcount},
          {'sourcenonderogcount06month',le.sourcenonderogcount06month},
          {'ssndeceased',le.ssndeceased},
          {'subjectdeceased',le.subjectdeceased},
          {'subjectrecordtimeoldest',le.subjectrecordtimeoldest}
          ,{'L_addrprevioustimeoldest_alt',le.L_addrprevioustimeoldest_alt}
          ,{'L_ca_creditseeking_orig',le.L_ca_creditseeking_orig}
          ,{'L_ca_creditseeking',le.L_ca_creditseeking}
          ,{'L_ca_addrchangeindex',le.L_ca_addrchangeindex}
          ,{'L_ca_nonderogindex_alt',le.L_ca_nonderogindex_alt}
          ,{'L_ca_derogseverityindex_orig',le.L_ca_derogseverityindex_orig}
          ,{'L_ca_derogseverityindex',le.L_ca_derogseverityindex}],NVPair);
      SELF.PointsAssignment := DATASET([
          {'L_addrprevioustimeoldest_alt_pts',le.RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_score},
          {'L_ca_addrchangeindex_pts',le.RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_score},
          {'L_ca_creditseeking_pts',le.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_score},
          {'L_ca_derogseverityindex_pts',le.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_score},
          {'L_ca_nonderogindex_alt_pts',le.RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_score},
          {'addrcurrentownershipindex_pts',le.RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_score},
          {'assetpropevercount_pts',le.RVT2004_1_0_SCORECARD_model110_assetpropevercount_score}],NVPair);
      SELF.ScoreCard := 'SCORECARD_model110';
      SELF.score_date := StringLib.GetDateYYYYMMDD();
      SELF.raw_score := le.RVT2004_1_0_SCORECARD_model110_Score0;
      SELF.calc_temp_score := le.RVT2004_1_0_SCORECARD_model110_Score1;
      SELF.INSUFFICIENT_INFO := FALSE; // Insufficient_Info* not found
      SELF.NO_HIT := le.RVT2004_1_0_No_Hit;
      SELF.reason_codes_base := DATASET([
          {'L_addrprevioustimeoldest_alt',le.RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_contribution_best,le.RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_reason},
          {'L_ca_addrchangeindex',le.RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_contribution_best,le.RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_reason},
          {'L_ca_creditseeking',le.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_contribution_best,le.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_reason},
          {'L_ca_derogseverityindex',le.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_contribution_best,le.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_reason},
          {'L_ca_nonderogindex_alt',le.RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_contribution_best,le.RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_reason},
          {'addrcurrentownershipindex',le.RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_contribution_best,le.RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_reason},
          {'assetpropevercount',le.RVT2004_1_0_SCORECARD_model110_assetpropevercount_contribution_best,le.RVT2004_1_0_SCORECARD_model110_assetpropevercount_reason}],RC_Contributions_Layout);
    END;
    RVT2004_1_0AsValidation := PROJECT(ValidationF,TrRVT2004_1_0(LEFT));
  EXPORT Validation() := RVT2004_1_0AsValidation;
// Now compute some statistics
  Accum := RECORD
    TotalProcessed := COUNT(GROUP);
    RVT2004_1_0_sc_SCORECARD_model110 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1);
    RVT2004_1_0_Alert := COUNT(GROUP,ValidationF.RVT2004_1_0_Alert);
    RVT2004_1_0_No_Hit := COUNT(GROUP,ValidationF.RVT2004_1_0_No_Hit);
    RVT2004_1_0_Deceased := COUNT(GROUP,ValidationF.RVT2004_1_0_Deceased);
    RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range_1 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range=1);
    RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range_2 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range=2);
    RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range_3 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range=3);
    RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range_4 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range=4);
    RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range_5 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range=5);
    RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range_6 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range=6);
    RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range_7 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range=7);
    RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range_8 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range=8);
    RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_1 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range=1);
    RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_2 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range=2);
    RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_3 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range=3);
    RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_4 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range=4);
    RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_5 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range=5);
    RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_6 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range=6);
    RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_7 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range=7);
    RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_8 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range=8);
    RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_9 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range=9);
    RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_10 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range=10);
    RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_11 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range=11);
    RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_12 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range=12);
    RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range_1 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range=1);
    RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range_2 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range=2);
    RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range_3 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range=3);
    RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range_4 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range=4);
    RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range_5 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range=5);
    RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range_6 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range=6);
    RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range_7 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range=7);
    RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range_8 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range=8);
    RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range_9 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range=9);
    RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range_1 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range=1);
    RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range_2 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range=2);
    RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range_3 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range=3);
    RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range_4 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range=4);
    RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range_5 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range=5);
    RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range_6 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range=6);
    RVT2004_1_0_SCORECARD_model110_assetpropevercount_range_1 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_assetpropevercount_range=1);
    RVT2004_1_0_SCORECARD_model110_assetpropevercount_range_2 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_assetpropevercount_range=2);
    RVT2004_1_0_SCORECARD_model110_assetpropevercount_range_3 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_assetpropevercount_range=3);
    RVT2004_1_0_SCORECARD_model110_assetpropevercount_range_4 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_assetpropevercount_range=4);
    RVT2004_1_0_SCORECARD_model110_assetpropevercount_range_5 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_assetpropevercount_range=5);
    RVT2004_1_0_SCORECARD_model110_assetpropevercount_range_6 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_assetpropevercount_range=6);
    RVT2004_1_0_SCORECARD_model110_assetpropevercount_range_7 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_assetpropevercount_range=7);
    RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range_1 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range=1);
    RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range_2 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range=2);
    RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range_3 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range=3);
    RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range_4 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range=4);
    RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range_5 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range=5);
    RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range_6 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range=6);
    RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range_7 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range=7);
    RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range_8 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range=8);
    RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range_9 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range=9);
    RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_1 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range=1);
    RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_2 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range=2);
    RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_3 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range=3);
    RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_4 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range=4);
    RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_5 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range=5);
    RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_6 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range=6);
    RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_7 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range=7);
    RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_8 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range=8);
    RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_9 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range=9);
    RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_10 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range=10);
    RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_11 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range=11);
    RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_12 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range=12);
    RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_13 := COUNT(GROUP,ValidationF.RVT2004_1_0_sc = 1 AND ValidationF.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range=13);
  END;
  EXPORT StatsF := TABLE(ValidationF,Accum);
  EXPORT Stats() := DATASET([{'ADR Report','','','',0,0,0,'',0,0,'',0,0}
    ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','EXCEPTION','Alert',0,0,0,'',0,0,'',StatsF[1].RVT2004_1_0_Alert,100*StatsF[1].RVT2004_1_0_Alert/StatsF[1].TotalProcessed}
    ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','EXCEPTION','No_Hit',0,0,0,'',0,0,'',StatsF[1].RVT2004_1_0_No_Hit,100*StatsF[1].RVT2004_1_0_No_Hit/StatsF[1].TotalProcessed}
    ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','EXCEPTION','Deceased',0,0,0,'',0,0,'',StatsF[1].RVT2004_1_0_Deceased,100*StatsF[1].RVT2004_1_0_Deceased/StatsF[1].TotalProcessed}
    ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','',0,0,0,'',0,0,'',StatsF[1].RVT2004_1_0_sc_SCORECARD_model110,100*StatsF[1].RVT2004_1_0_sc_SCORECARD_model110/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','addrcurrentownershipindex','-998','-998',0.0,'NUMBER',0.044169642,0.044169642,'',StatsF[1].RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range_1,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range_1/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','addrcurrentownershipindex','-1','-1',0.0,'NUMBER',0.044169642,0.044169642,'A44',StatsF[1].RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range_2,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range_2/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','addrcurrentownershipindex','-998','-998',0.0,'NUMBER',0.044169642,0.044169642,'',StatsF[1].RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range_3,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range_3/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','addrcurrentownershipindex','999','999',0.0,'NUMBER',0.044169642,0.044169642,'',StatsF[1].RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range_4,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range_4/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','addrcurrentownershipindex','-999999999','0.5',0.241278264062402,'NUMBER',0.044169642,0.044169642,'A44',StatsF[1].RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range_5,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range_5/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','addrcurrentownershipindex','0.5','2.5',0.00593506382761733,'NUMBER',0.044169642,0.044169642,'A44',StatsF[1].RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range_6,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range_6/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','addrcurrentownershipindex','2.5','3.5',-0.422097965223441,'NUMBER',0.044169642,0.044169642,'A44',StatsF[1].RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range_7,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range_7/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','addrcurrentownershipindex','3.5','HIGH',-0.426452499208887,'NUMBER',0.044169642,0.044169642,'A44',StatsF[1].RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range_8,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range_8/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','addrcurrentownershipindex',0,0,0,'TOTAL',0,0,'',StatsF[1].RVT2004_1_0_sc_SCORECARD_model110,100*StatsF[1].RVT2004_1_0_sc_SCORECARD_model110/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_creditseeking','-998','-998',0.0,'NUMBER',-0.145916024,-0.145916024,'',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_1,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_1/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_creditseeking','-1','-1',0.0,'NUMBER',-0.145916024,-0.145916024,'I60',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_2,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_2/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_creditseeking','-998','-998',0.0,'NUMBER',-0.145916024,-0.145916024,'',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_3,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_3/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_creditseeking','999','999',0.0,'NUMBER',-0.145916024,-0.145916024,'',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_4,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_4/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_creditseeking','-999999999','0',-0.362569357925149,'NUMBER',-0.145916024,-0.145916024,'I60',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_5,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_5/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_creditseeking','1','1',0.0367915769388987,'NUMBER',-0.145916024,-0.145916024,'I60',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_6,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_6/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_creditseeking','2','2',0.222011816622779,'NUMBER',-0.145916024,-0.145916024,'I60',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_7,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_7/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_creditseeking','3','3',0.467339660305824,'NUMBER',-0.145916024,-0.145916024,'I60',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_8,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_8/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_creditseeking','4','4',0.943890182033126,'NUMBER',-0.145916024,-0.145916024,'I60',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_9,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_9/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_creditseeking','5','5',0.979326295061764,'NUMBER',-0.145916024,-0.145916024,'I60',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_10,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_10/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_creditseeking','6','6',0.222011816622779,'NUMBER',-0.145916024,-0.145916024,'C21',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_11,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_11/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_creditseeking','6','HIGH',0.0367915769388987,'NUMBER',-0.145916024,-0.145916024,'I61',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_12,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range_12/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_creditseeking',0,0,0,'TOTAL',0,0,'',StatsF[1].RVT2004_1_0_sc_SCORECARD_model110,100*StatsF[1].RVT2004_1_0_sc_SCORECARD_model110/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_addrchangeindex','-998','-998',0.0,'NUMBER',-0.050522645,-0.050522645,'',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range_1,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range_1/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_addrchangeindex','-1','-1',0.0,'NUMBER',-0.050522645,-0.050522645,'C14',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range_2,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range_2/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_addrchangeindex','-998','-998',0.0,'NUMBER',-0.050522645,-0.050522645,'',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range_3,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range_3/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_addrchangeindex','999','999',0.0,'NUMBER',-0.050522645,-0.050522645,'',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range_4,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range_4/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_addrchangeindex','-999999999','1.5',-0.361445513556842,'NUMBER',-0.050522645,-0.050522645,'C14',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range_5,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range_5/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_addrchangeindex','1.5','2.5',-0.0326651072762166,'NUMBER',-0.050522645,-0.050522645,'C14',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range_6,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range_6/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_addrchangeindex','2.5','3.5',0.228542788688605,'NUMBER',-0.050522645,-0.050522645,'C14',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range_7,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range_7/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_addrchangeindex','3.5','4.5',0.345993801395147,'NUMBER',-0.050522645,-0.050522645,'C14',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range_8,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range_8/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_addrchangeindex','4.5','HIGH',0.650067423161005,'NUMBER',-0.050522645,-0.050522645,'C14',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range_9,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range_9/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_addrchangeindex',0,0,0,'TOTAL',0,0,'',StatsF[1].RVT2004_1_0_sc_SCORECARD_model110,100*StatsF[1].RVT2004_1_0_sc_SCORECARD_model110/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_nonderogindex_alt','-998','-998',0.0,'NUMBER',0.251102104,0.251102104,'',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range_1,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range_1/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_nonderogindex_alt','-1','-1',0.0,'NUMBER',0.251102104,0.251102104,'C12',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range_2,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range_2/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_nonderogindex_alt','-998','-998',0.0,'NUMBER',0.251102104,0.251102104,'',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range_3,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range_3/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_nonderogindex_alt','999','999',0.0,'NUMBER',0.251102104,0.251102104,'',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range_4,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range_4/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_nonderogindex_alt','-999999999','1.5',0.269980986524245,'NUMBER',0.251102104,0.251102104,'C12',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range_5,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range_5/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_nonderogindex_alt','1.5','HIGH',-0.254808888546115,'NUMBER',0.251102104,0.251102104,'C12',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range_6,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range_6/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_nonderogindex_alt',0,0,0,'TOTAL',0,0,'',StatsF[1].RVT2004_1_0_sc_SCORECARD_model110,100*StatsF[1].RVT2004_1_0_sc_SCORECARD_model110/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','assetpropevercount','-998','-998',0.0,'NUMBER',0.233084749,0.233084749,'',StatsF[1].RVT2004_1_0_SCORECARD_model110_assetpropevercount_range_1,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_assetpropevercount_range_1/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','assetpropevercount','-1','-1',0.0,'NUMBER',0.233084749,0.233084749,'A41',StatsF[1].RVT2004_1_0_SCORECARD_model110_assetpropevercount_range_2,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_assetpropevercount_range_2/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','assetpropevercount','-998','-998',0.0,'NUMBER',0.233084749,0.233084749,'',StatsF[1].RVT2004_1_0_SCORECARD_model110_assetpropevercount_range_3,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_assetpropevercount_range_3/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','assetpropevercount','999','999',0.0,'NUMBER',0.233084749,0.233084749,'',StatsF[1].RVT2004_1_0_SCORECARD_model110_assetpropevercount_range_4,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_assetpropevercount_range_4/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','assetpropevercount','-999999999','0.5',0.258573459164827,'NUMBER',0.233084749,0.233084749,'A41',StatsF[1].RVT2004_1_0_SCORECARD_model110_assetpropevercount_range_5,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_assetpropevercount_range_5/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','assetpropevercount','0.5','1.5',-0.146309609694865,'NUMBER',0.233084749,0.233084749,'A41',StatsF[1].RVT2004_1_0_SCORECARD_model110_assetpropevercount_range_6,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_assetpropevercount_range_6/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','assetpropevercount','1.5','HIGH',-0.597848433083429,'NUMBER',0.233084749,0.233084749,'A41',StatsF[1].RVT2004_1_0_SCORECARD_model110_assetpropevercount_range_7,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_assetpropevercount_range_7/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','assetpropevercount',0,0,0,'TOTAL',0,0,'',StatsF[1].RVT2004_1_0_sc_SCORECARD_model110,100*StatsF[1].RVT2004_1_0_sc_SCORECARD_model110/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_addrprevioustimeoldest_alt','-998','-998',0.0,'NUMBER',0.006917638,0.006917638,'',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range_1,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range_1/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_addrprevioustimeoldest_alt','-1','-1',-0.192125399167892,'NUMBER',0.006917638,0.006917638,'C13',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range_2,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range_2/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_addrprevioustimeoldest_alt','-998','-998',0.0,'NUMBER',0.006917638,0.006917638,'',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range_3,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range_3/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_addrprevioustimeoldest_alt','999','999',0.0,'NUMBER',0.006917638,0.006917638,'',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range_4,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range_4/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_addrprevioustimeoldest_alt','-999999999','96',0.195602970040618,'NUMBER',0.006917638,0.006917638,'C13',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range_5,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range_5/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_addrprevioustimeoldest_alt','96','132',0.129691677434657,'NUMBER',0.006917638,0.006917638,'C13',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range_6,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range_6/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_addrprevioustimeoldest_alt','132','204',0.0169316915846859,'NUMBER',0.006917638,0.006917638,'C13',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range_7,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range_7/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_addrprevioustimeoldest_alt','204','240',-0.0774303118296151,'NUMBER',0.006917638,0.006917638,'C13',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range_8,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range_8/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_addrprevioustimeoldest_alt','240','HIGH',-0.377374107224287,'NUMBER',0.006917638,0.006917638,'C13',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range_9,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range_9/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_addrprevioustimeoldest_alt',0,0,0,'TOTAL',0,0,'',StatsF[1].RVT2004_1_0_sc_SCORECARD_model110,100*StatsF[1].RVT2004_1_0_sc_SCORECARD_model110/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_derogseverityindex','-998','-998',0.0,'NUMBER',-0.17793609,-0.17793609,'',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_1,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_1/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_derogseverityindex','-1','-1',0.0,'NUMBER',-0.17793609,-0.17793609,'',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_2,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_2/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_derogseverityindex','-998','-998',0.0,'NUMBER',-0.17793609,-0.17793609,'',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_3,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_3/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_derogseverityindex','999','999',0.0,'NUMBER',-0.17793609,-0.17793609,'',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_4,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_4/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_derogseverityindex','-999999999','0',-0.204450773503088,'NUMBER',-0.17793609,-0.17793609,'',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_5,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_5/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_derogseverityindex','1','1',-0.129339415823904,'NUMBER',-0.17793609,-0.17793609,'D34',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_6,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_6/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_derogseverityindex','2','2',0.331183108776348,'NUMBER',-0.17793609,-0.17793609,'D30',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_7,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_7/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_derogseverityindex','3','3',0.331183108776348,'NUMBER',-0.17793609,-0.17793609,'D30',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_8,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_8/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_derogseverityindex','4','4',0.475902823827432,'NUMBER',-0.17793609,-0.17793609,'D30',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_9,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_9/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_derogseverityindex','5','5',0.475902823827432,'NUMBER',-0.17793609,-0.17793609,'D30',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_10,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_10/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_derogseverityindex','6','6',0.475902823827432,'NUMBER',-0.17793609,-0.17793609,'D33',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_11,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_11/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_derogseverityindex','7','7',0.331183108776348,'NUMBER',-0.17793609,-0.17793609,'D33',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_12,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_12/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_derogseverityindex','7','HIGH',0.331183108776348,'NUMBER',-0.17793609,-0.17793609,'D31',StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_13,100*StatsF[1].RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range_13/StatsF[1].TotalProcessed}
      ,{'RVT2004_1_0','T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model110','L_ca_derogseverityindex',0,0,0,'TOTAL',0,0,'',StatsF[1].RVT2004_1_0_sc_SCORECARD_model110,100*StatsF[1].RVT2004_1_0_sc_SCORECARD_model110/StatsF[1].TotalProcessed}
    ],rvt2004_1_0.Results.StatsLayout);
  END;
  RETURN res(infile);
ENDMACRO;
