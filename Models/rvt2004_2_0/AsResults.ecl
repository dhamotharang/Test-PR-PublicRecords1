EXPORT AsResults(infile) := FUNCTIONMACRO

  Res(DATASET(RECORDOF(infile)) myfile) := MODULE(rvt2004_2_0.Results)
  IMPORT iesp;
  SHARED RCToMessage(SET OF STRING5 rc) := FUNCTION
    d1 := DATASET(rc,{ STRING5 Code });
    iesp.ins_share_iss.t_InsuranceScoreMessage into(d1 le) := TRANSFORM
      SELF.MessageType := rvt2004_2_0.RCCodes(le.code).GroupType;
      SELF.Description := rvt2004_2_0.RCCodes(le.code).Description;
      SELF.Code := le.code;
    END;
    RETURN PROJECT(d1,into(LEFT));
  END;
    // Simple and quick
  EXPORT BaseF := rvt2004_2_0.AppendAll(myfile,do_RVT2004_2_0,addrchangecount60month,addrcurrentownershipindex,addronfilecount,addrprevioustimeoldest,alertregulatorycondition,assetpropcurrentcount,assetpropeversoldcount,bankruptcystatus,confirmationsubjectfound,evictioncount,inquiryauto12month,inquirybanking12month,inquirycollections12month,inquiryshortterm12month,lienjudgmentcount,lienjudgmentsmallclaimscount,shorttermloanrequest,sourcenonderogcount,sourcenonderogcount06month,ssndeceased,subjectdeceased,subjectrecordtimeoldest);
    BaseLayout TrRVT2004_2_0(BaseF le) := TRANSFORM
      SELF.TransactionId := le.TransactionId;
      SELF.name := 'RVT2004_2_0';
      SELF.description := 'T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386';
      SELF.Score := (STRING)le.RVT2004_2_0_Score;
      SELF.Messages := RCToMessage(le.RVT2004_2_0_Reasons);
    END;
    RVT2004_2_0AsBase := PROJECT(BaseF,TrRVT2004_2_0(LEFT));
  EXPORT Base() := RVT2004_2_0AsBase;
    // With attributes
  EXPORT AttrF := rvt2004_2_0.AppendAll(myfile,do_RVT2004_2_0,addrchangecount60month,addrcurrentownershipindex,addronfilecount,addrprevioustimeoldest,alertregulatorycondition,assetpropcurrentcount,assetpropeversoldcount,bankruptcystatus,confirmationsubjectfound,evictioncount,inquiryauto12month,inquirybanking12month,inquirycollections12month,inquiryshortterm12month,lienjudgmentcount,lienjudgmentsmallclaimscount,shorttermloanrequest,sourcenonderogcount,sourcenonderogcount06month,ssndeceased,subjectdeceased,subjectrecordtimeoldest);
    AttrLayout TrRVT2004_2_0(AttrF le) := TRANSFORM
      SELF.TransactionId := le.TransactionId;
      SELF.name := 'RVT2004_2_0';
      SELF.description := 'T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386';
      SELF.Score := (STRING)le.RVT2004_2_0_Score;
      SELF.Messages := RCToMessage(le.RVT2004_2_0_Reasons);
      SELF.Attributes := DATASET([
          {'addrchangecount60month',le.addrchangecount60month},
          {'addrcurrentownershipindex',le.addrcurrentownershipindex},
          {'addronfilecount',le.addronfilecount},
          {'addrprevioustimeoldest',le.addrprevioustimeoldest},
          {'alertregulatorycondition',le.alertregulatorycondition},
          {'assetpropcurrentcount',le.assetpropcurrentcount},
          {'assetpropeversoldcount',le.assetpropeversoldcount},
          {'bankruptcystatus',le.bankruptcystatus},
          {'confirmationsubjectfound',le.confirmationsubjectfound},
          {'evictioncount',le.evictioncount},
          {'inquiryauto12month',le.inquiryauto12month},
          {'inquirybanking12month',le.inquirybanking12month},
          {'inquirycollections12month',le.inquirycollections12month},
          {'inquiryshortterm12month',le.inquiryshortterm12month},
          {'lienjudgmentcount',le.lienjudgmentcount},
          {'lienjudgmentsmallclaimscount',le.lienjudgmentsmallclaimscount},
          {'shorttermloanrequest',le.shorttermloanrequest},
          {'sourcenonderogcount',le.sourcenonderogcount},
          {'sourcenonderogcount06month',le.sourcenonderogcount06month},
          {'ssndeceased',le.ssndeceased},
          {'subjectdeceased',le.subjectdeceased},
          {'subjectrecordtimeoldest',le.subjectrecordtimeoldest}],NVPair);
    END;
    RVT2004_2_0AsAttr := PROJECT(AttrF,TrRVT2004_2_0(LEFT));
  EXPORT Attr() := RVT2004_2_0AsAttr;
    // Validation
  EXPORT ValidationF := rvt2004_2_0.AppendAll_Debug(myfile,do_RVT2004_2_0,addrchangecount60month,addrcurrentownershipindex,addronfilecount,addrprevioustimeoldest,alertregulatorycondition,assetpropcurrentcount,assetpropeversoldcount,bankruptcystatus,confirmationsubjectfound,evictioncount,inquiryauto12month,inquirybanking12month,inquirycollections12month,inquiryshortterm12month,lienjudgmentcount,lienjudgmentsmallclaimscount,shorttermloanrequest,sourcenonderogcount,sourcenonderogcount06month,ssndeceased,subjectdeceased,subjectrecordtimeoldest);
    ValidationLayout TrRVT2004_2_0(ValidationF le) := TRANSFORM
      SELF.TransactionId := le.TransactionId;
      SELF.name := 'RVT2004_2_0';
      SELF.description := 'T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386';
      SELF.Score := (STRING)le.RVT2004_2_0_Score;
      SELF.Messages := RCToMessage(le.RVT2004_2_0_Reasons);
      SELF.Attributes := DATASET([
          {'addrchangecount60month',le.addrchangecount60month},
          {'addrcurrentownershipindex',le.addrcurrentownershipindex},
          {'addronfilecount',le.addronfilecount},
          {'addrprevioustimeoldest',le.addrprevioustimeoldest},
          {'alertregulatorycondition',le.alertregulatorycondition},
          {'assetpropcurrentcount',le.assetpropcurrentcount},
          {'assetpropeversoldcount',le.assetpropeversoldcount},
          {'bankruptcystatus',le.bankruptcystatus},
          {'confirmationsubjectfound',le.confirmationsubjectfound},
          {'evictioncount',le.evictioncount},
          {'inquiryauto12month',le.inquiryauto12month},
          {'inquirybanking12month',le.inquirybanking12month},
          {'inquirycollections12month',le.inquirycollections12month},
          {'inquiryshortterm12month',le.inquiryshortterm12month},
          {'lienjudgmentcount',le.lienjudgmentcount},
          {'lienjudgmentsmallclaimscount',le.lienjudgmentsmallclaimscount},
          {'shorttermloanrequest',le.shorttermloanrequest},
          {'sourcenonderogcount',le.sourcenonderogcount},
          {'sourcenonderogcount06month',le.sourcenonderogcount06month},
          {'ssndeceased',le.ssndeceased},
          {'subjectdeceased',le.subjectdeceased},
          {'subjectrecordtimeoldest',le.subjectrecordtimeoldest}
          ,{'L_ca_creditseeking_orig',le.L_ca_creditseeking_orig}
          ,{'L_ca_creditseeking',le.L_ca_creditseeking}
          ,{'L_ca_derogseverityindex_orig',le.L_ca_derogseverityindex_orig}
          ,{'L_ca_derogseverityindex',le.L_ca_derogseverityindex}
          ,{'L_ca_nonderogindex',le.L_ca_nonderogindex}
          ,{'L_ca_addrchangeindex',le.L_ca_addrchangeindex}],NVPair);
      SELF.PointsAssignment := DATASET([
          {'L_ca_addrchangeindex_pts',le.RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_score},
          {'L_ca_creditseeking_pts',le.RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_score},
          {'L_ca_derogseverityindex_pts',le.RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_score},
          {'L_ca_nonderogindex_pts',le.RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_score},
          {'addrcurrentownershipindex_pts',le.RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_score},
          {'addrprevioustimeoldest_pts',le.RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_score},
          {'assetpropcurrentcount_pts',le.RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_score},
          {'assetpropeversoldcount_pts',le.RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_score}],NVPair);
      SELF.ScoreCard := 'SCORECARD_model47';
      SELF.score_date := StringLib.GetDateYYYYMMDD();
      SELF.raw_score := le.RVT2004_2_0_SCORECARD_model47_Score0;
      SELF.calc_temp_score := le.RVT2004_2_0_SCORECARD_model47_Score1;
      SELF.INSUFFICIENT_INFO := FALSE; // Insufficient_Info* not found
      SELF.NO_HIT := le.RVT2004_2_0_No_Hit;
      SELF.reason_codes_base := DATASET([
          {'L_ca_addrchangeindex',le.RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_contribution_best,le.RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_reason},
          {'L_ca_creditseeking',le.RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_contribution_best,le.RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_reason},
          {'L_ca_derogseverityindex',le.RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_contribution_best,le.RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_reason},
          {'L_ca_nonderogindex',le.RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_contribution_best,le.RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_reason},
          {'addrcurrentownershipindex',le.RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_contribution_best,le.RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_reason},
          {'addrprevioustimeoldest',le.RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_contribution_best,le.RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_reason},
          {'assetpropcurrentcount',le.RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_contribution_best,le.RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_reason},
          {'assetpropeversoldcount',le.RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_contribution_best,le.RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_reason}],RC_Contributions_Layout);
    END;
    RVT2004_2_0AsValidation := PROJECT(ValidationF,TrRVT2004_2_0(LEFT));
  EXPORT Validation() := RVT2004_2_0AsValidation;
// Now compute some statistics
  Accum := RECORD
    TotalProcessed := COUNT(GROUP);
    RVT2004_2_0_sc_SCORECARD_model47 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1);
    RVT2004_2_0_Alert := COUNT(GROUP,ValidationF.RVT2004_2_0_Alert);
    RVT2004_2_0_No_Hit := COUNT(GROUP,ValidationF.RVT2004_2_0_No_Hit);
    RVT2004_2_0_Deceased := COUNT(GROUP,ValidationF.RVT2004_2_0_Deceased);
    RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_1 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range=1);
    RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_2 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range=2);
    RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_3 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range=3);
    RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_4 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range=4);
    RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_5 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range=5);
    RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_6 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range=6);
    RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_7 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range=7);
    RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_8 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range=8);
    RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_9 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range=9);
    RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_10 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range=10);
    RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_11 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range=11);
    RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_range_1 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_range=1);
    RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_range_2 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_range=2);
    RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_range_3 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_range=3);
    RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_range_4 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_range=4);
    RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_range_5 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_range=5);
    RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range_1 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range=1);
    RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range_2 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range=2);
    RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range_3 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range=3);
    RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range_4 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range=4);
    RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range_5 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range=5);
    RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range_6 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range=6);
    RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_1 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range=1);
    RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_2 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range=2);
    RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_3 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range=3);
    RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_4 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range=4);
    RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_5 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range=5);
    RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_6 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range=6);
    RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_7 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range=7);
    RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_8 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range=8);
    RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_9 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range=9);
    RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_10 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range=10);
    RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range_1 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range=1);
    RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range_2 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range=2);
    RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range_3 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range=3);
    RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range_4 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range=4);
    RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range_5 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range=5);
    RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range_6 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range=6);
    RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_range_1 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_range=1);
    RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_range_2 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_range=2);
    RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_range_3 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_range=3);
    RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_range_4 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_range=4);
    RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_range_5 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_range=5);
    RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range_1 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range=1);
    RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range_2 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range=2);
    RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range_3 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range=3);
    RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range_4 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range=4);
    RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range_5 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range=5);
    RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range_6 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range=6);
    RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_1 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range=1);
    RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_2 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range=2);
    RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_3 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range=3);
    RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_4 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range=4);
    RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_5 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range=5);
    RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_6 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range=6);
    RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_7 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range=7);
    RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_8 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range=8);
    RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_9 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range=9);
    RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_10 := COUNT(GROUP,ValidationF.RVT2004_2_0_sc = 1 AND ValidationF.RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range=10);
  END;
  EXPORT StatsF := TABLE(ValidationF,Accum);
  EXPORT Stats() := DATASET([{'ADR Report','','','',0,0,0,'',0,0,'',0,0}
    ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','EXCEPTION','Alert',0,0,0,'',0,0,'',StatsF[1].RVT2004_2_0_Alert,100*StatsF[1].RVT2004_2_0_Alert/StatsF[1].TotalProcessed}
    ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','EXCEPTION','No_Hit',0,0,0,'',0,0,'',StatsF[1].RVT2004_2_0_No_Hit,100*StatsF[1].RVT2004_2_0_No_Hit/StatsF[1].TotalProcessed}
    ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','EXCEPTION','Deceased',0,0,0,'',0,0,'',StatsF[1].RVT2004_2_0_Deceased,100*StatsF[1].RVT2004_2_0_Deceased/StatsF[1].TotalProcessed}
    ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','',0,0,0,'',0,0,'',StatsF[1].RVT2004_2_0_sc_SCORECARD_model47,100*StatsF[1].RVT2004_2_0_sc_SCORECARD_model47/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','addrprevioustimeoldest','-998','-998',0.0,'NUMBER',0.016988448,0.016988448,'',StatsF[1].RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_1,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_1/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','addrprevioustimeoldest','-1','-1',-0.28084870461577,'NUMBER',0.016988448,0.016988448,'C13',StatsF[1].RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_2,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_2/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','addrprevioustimeoldest','-999999999','6',0.491375089074481,'NUMBER',0.016988448,0.016988448,'C13',StatsF[1].RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_3,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_3/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','addrprevioustimeoldest','6','12',0.321048883673525,'NUMBER',0.016988448,0.016988448,'C13',StatsF[1].RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_4,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_4/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','addrprevioustimeoldest','12','24',0.180121585542426,'NUMBER',0.016988448,0.016988448,'C13',StatsF[1].RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_5,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_5/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','addrprevioustimeoldest','24','72',0.151031197731993,'NUMBER',0.016988448,0.016988448,'C13',StatsF[1].RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_6,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_6/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','addrprevioustimeoldest','72','96',0.114801189635962,'NUMBER',0.016988448,0.016988448,'C13',StatsF[1].RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_7,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_7/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','addrprevioustimeoldest','96','156',-0.0288430799118979,'NUMBER',0.016988448,0.016988448,'C13',StatsF[1].RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_8,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_8/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','addrprevioustimeoldest','156','228',-0.0640308901228473,'NUMBER',0.016988448,0.016988448,'C13',StatsF[1].RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_9,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_9/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','addrprevioustimeoldest','228','288',-0.255266542810333,'NUMBER',0.016988448,0.016988448,'C13',StatsF[1].RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_10,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_10/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','addrprevioustimeoldest','288','HIGH',-0.45962051977284,'NUMBER',0.016988448,0.016988448,'C13',StatsF[1].RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_11,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range_11/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','addrprevioustimeoldest',0,0,0,'TOTAL',0,0,'',StatsF[1].RVT2004_2_0_sc_SCORECARD_model47,100*StatsF[1].RVT2004_2_0_sc_SCORECARD_model47/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','assetpropeversoldcount','-998','-998',0.0,'NUMBER',0.256330125,0.256330125,'',StatsF[1].RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_range_1,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_range_1/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','assetpropeversoldcount','-1','-1',0.0,'NUMBER',0.256330125,0.256330125,'',StatsF[1].RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_range_2,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_range_2/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','assetpropeversoldcount','-999999999','0.5',0.338302614099309,'NUMBER',0.256330125,0.256330125,'A45',StatsF[1].RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_range_3,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_range_3/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','assetpropeversoldcount','0.5','1.5',-0.210498982583842,'NUMBER',0.256330125,0.256330125,'',StatsF[1].RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_range_4,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_range_4/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','assetpropeversoldcount','1.5','HIGH',-0.538333965350616,'NUMBER',0.256330125,0.256330125,'',StatsF[1].RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_range_5,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_range_5/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','assetpropeversoldcount',0,0,0,'TOTAL',0,0,'',StatsF[1].RVT2004_2_0_sc_SCORECARD_model47,100*StatsF[1].RVT2004_2_0_sc_SCORECARD_model47/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','addrcurrentownershipindex','-998','-998',0.0,'NUMBER',0.032557624,0.032557624,'',StatsF[1].RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range_1,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range_1/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','addrcurrentownershipindex','-1','-1',0.0,'NUMBER',0.032557624,0.032557624,'A44',StatsF[1].RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range_2,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range_2/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','addrcurrentownershipindex','-999999999','0.5',0.369840206147756,'NUMBER',0.032557624,0.032557624,'A44',StatsF[1].RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range_3,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range_3/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','addrcurrentownershipindex','0.5','2.5',0.153617815307213,'NUMBER',0.032557624,0.032557624,'A44',StatsF[1].RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range_4,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range_4/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','addrcurrentownershipindex','2.5','3.5',-0.11136892139623,'NUMBER',0.032557624,0.032557624,'A44',StatsF[1].RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range_5,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range_5/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','addrcurrentownershipindex','3.5','HIGH',-0.482905249758621,'NUMBER',0.032557624,0.032557624,'A44',StatsF[1].RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range_6,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range_6/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','addrcurrentownershipindex',0,0,0,'TOTAL',0,0,'',StatsF[1].RVT2004_2_0_sc_SCORECARD_model47,100*StatsF[1].RVT2004_2_0_sc_SCORECARD_model47/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_creditseeking','-998','-998',0.0,'NUMBER',-0.188809907,-0.188809907,'',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_1,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_1/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_creditseeking','-1','-1',0.0,'NUMBER',-0.188809907,-0.188809907,'I60',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_2,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_2/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_creditseeking','-999999999','1',-0.537997066263463,'NUMBER',-0.188809907,-0.188809907,'I60',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_3,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_3/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_creditseeking','2','2',0.0548804249144252,'NUMBER',-0.188809907,-0.188809907,'I60',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_4,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_4/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_creditseeking','3','3',0.190031718225198,'NUMBER',-0.188809907,-0.188809907,'I60',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_5,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_5/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_creditseeking','4','4',0.650769565235421,'NUMBER',-0.188809907,-0.188809907,'I60',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_6,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_6/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_creditseeking','5','5',1.00836443079308,'NUMBER',-0.188809907,-0.188809907,'I60',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_7,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_7/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_creditseeking','6','6',1.18265340641186,'NUMBER',-0.188809907,-0.188809907,'I60',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_8,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_8/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_creditseeking','7','7',0.190031718225198,'NUMBER',-0.188809907,-0.188809907,'C21',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_9,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_9/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_creditseeking','7','HIGH',0.0548804249144252,'NUMBER',-0.188809907,-0.188809907,'I61',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_10,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range_10/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_creditseeking',0,0,0,'TOTAL',0,0,'',StatsF[1].RVT2004_2_0_sc_SCORECARD_model47,100*StatsF[1].RVT2004_2_0_sc_SCORECARD_model47/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_addrchangeindex','-998','-998',0.0,'NUMBER',-0.005703807,-0.005703807,'',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range_1,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range_1/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_addrchangeindex','-1','-1',0.0,'NUMBER',-0.005703807,-0.005703807,'C14',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range_2,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range_2/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_addrchangeindex','-999999999','2.5',-0.052677852519793,'NUMBER',-0.005703807,-0.005703807,'C14',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range_3,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range_3/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_addrchangeindex','2.5','4.5',0.0093886967604785,'NUMBER',-0.005703807,-0.005703807,'C14',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range_4,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range_4/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_addrchangeindex','4.5','5.5',0.0857939935789934,'NUMBER',-0.005703807,-0.005703807,'C14',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range_5,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range_5/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_addrchangeindex','5.5','HIGH',0.187917227284159,'NUMBER',-0.005703807,-0.005703807,'C14',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range_6,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range_6/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_addrchangeindex',0,0,0,'TOTAL',0,0,'',StatsF[1].RVT2004_2_0_sc_SCORECARD_model47,100*StatsF[1].RVT2004_2_0_sc_SCORECARD_model47/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','assetpropcurrentcount','-998','-998',0.0,'NUMBER',0.149654754,0.149654754,'',StatsF[1].RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_range_1,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_range_1/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','assetpropcurrentcount','-1','-1',0.0,'NUMBER',0.149654754,0.149654754,'',StatsF[1].RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_range_2,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_range_2/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','assetpropcurrentcount','-999999999','0.5',0.343155403853238,'NUMBER',0.149654754,0.149654754,'A42',StatsF[1].RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_range_3,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_range_3/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','assetpropcurrentcount','0.5','1.5',-0.260918946043492,'NUMBER',0.149654754,0.149654754,'A42',StatsF[1].RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_range_4,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_range_4/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','assetpropcurrentcount','1.5','HIGH',-0.33457231340859,'NUMBER',0.149654754,0.149654754,'A42',StatsF[1].RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_range_5,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_range_5/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','assetpropcurrentcount',0,0,0,'TOTAL',0,0,'',StatsF[1].RVT2004_2_0_sc_SCORECARD_model47,100*StatsF[1].RVT2004_2_0_sc_SCORECARD_model47/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_nonderogindex','-998','-998',0.0,'NUMBER',0.073420476,0.073420476,'',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range_1,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range_1/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_nonderogindex','-1','-1',0.0,'NUMBER',0.073420476,0.073420476,'C12',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range_2,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range_2/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_nonderogindex','-999999999','2.5',0.224638954157977,'NUMBER',0.073420476,0.073420476,'C12',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range_3,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range_3/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_nonderogindex','2.5','3.5',0.0534093514829876,'NUMBER',0.073420476,0.073420476,'C12',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range_4,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range_4/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_nonderogindex','3.5','4.5',-0.248370773172574,'NUMBER',0.073420476,0.073420476,'C12',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range_5,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range_5/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_nonderogindex','4.5','HIGH',-0.453675193810595,'NUMBER',0.073420476,0.073420476,'C12',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range_6,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range_6/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_nonderogindex',0,0,0,'TOTAL',0,0,'',StatsF[1].RVT2004_2_0_sc_SCORECARD_model47,100*StatsF[1].RVT2004_2_0_sc_SCORECARD_model47/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_derogseverityindex','-998','-998',0.0,'NUMBER',-0.316279327,-0.316279327,'',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_1,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_1/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_derogseverityindex','-1','-1',0.0,'NUMBER',-0.316279327,-0.316279327,'',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_2,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_2/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_derogseverityindex','-999999999','1',-0.413793157156462,'NUMBER',-0.316279327,-0.316279327,'',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_3,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_3/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_derogseverityindex','2','2',-0.0314225344056521,'NUMBER',-0.316279327,-0.316279327,'D34',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_4,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_4/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_derogseverityindex','3','3',0.400599180681259,'NUMBER',-0.316279327,-0.316279327,'D30',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_5,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_5/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_derogseverityindex','4','4',0.683351662414589,'NUMBER',-0.316279327,-0.316279327,'D33',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_6,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_6/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_derogseverityindex','5','5',0.958117552563772,'NUMBER',-0.316279327,-0.316279327,'D30',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_7,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_7/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_derogseverityindex','6','6',0.958117552563772,'NUMBER',-0.316279327,-0.316279327,'D33',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_8,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_8/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_derogseverityindex','7','7',0.400599180681259,'NUMBER',-0.316279327,-0.316279327,'D34',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_9,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_9/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_derogseverityindex','7','HIGH',0.400599180681259,'NUMBER',-0.316279327,-0.316279327,'D31',StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_10,100*StatsF[1].RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range_10/StatsF[1].TotalProcessed}
      ,{'RVT2004_2_0','T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386','SCORECARD_model47','L_ca_derogseverityindex',0,0,0,'TOTAL',0,0,'',StatsF[1].RVT2004_2_0_sc_SCORECARD_model47,100*StatsF[1].RVT2004_2_0_sc_SCORECARD_model47/StatsF[1].TotalProcessed}
    ],rvt2004_2_0.Results.StatsLayout);
  END;
  RETURN res(infile);
ENDMACRO;
