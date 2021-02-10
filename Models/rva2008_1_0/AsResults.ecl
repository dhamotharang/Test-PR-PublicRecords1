EXPORT AsResults(infile) := FUNCTIONMACRO

  Res(DATASET(RECORDOF(infile)) myfile) := MODULE(rva2008_1_0.Results)
  IMPORT iesp;
  SHARED RCToMessage(SET OF STRING5 rc) := FUNCTION
    d1 := DATASET(rc,{ STRING5 Code });
    iesp.ins_share_iss.t_InsuranceScoreMessage into(d1 le) := TRANSFORM
      SELF.MessageType := rva2008_1_0.RCCodes(le.code).GroupType;
      SELF.Description := rva2008_1_0.RCCodes(le.code).Description;
      SELF.Code := le.code;
    END;
    RETURN PROJECT(d1,into(LEFT));
  END;
    // Simple and quick
  EXPORT BaseF := rva2008_1_0.AppendAll(myfile,do_RVA2008_1_0,addrchangecount03month,addrinputmatchindex,addrinputsubjectowned,addrprevioustimeoldest,assetpropevercount,confirmationinputaddress,confirmationsubjectfound,criminalfelonycount,derogtimenewest,evictioncount,inquiryauto12month,inquirybanking12month,inquiryshortterm12month,lienjudgmenttaxcount,sourcecredheadertimeoldest,ssndeceased,ssnsubjectcount,subjectdeceased);
    BaseLayout TrRVA2008_1_0(BaseF le) := TRANSFORM
      SELF.TransactionId := le.TransactionId;
      SELF.name := 'RVA2008_1_0';
      SELF.description := 'Custom Model for Auto Acceptance Corp';
      SELF.Score := (STRING)le.RVA2008_1_0_Score;
      SELF.Messages := RCToMessage(le.RVA2008_1_0_Reasons);
    END;
    RVA2008_1_0AsBase := PROJECT(BaseF,TrRVA2008_1_0(LEFT));
  EXPORT Base() := RVA2008_1_0AsBase;
    // With attributes
  EXPORT AttrF := rva2008_1_0.AppendAll(myfile,do_RVA2008_1_0,addrchangecount03month,addrinputmatchindex,addrinputsubjectowned,addrprevioustimeoldest,assetpropevercount,confirmationinputaddress,confirmationsubjectfound,criminalfelonycount,derogtimenewest,evictioncount,inquiryauto12month,inquirybanking12month,inquiryshortterm12month,lienjudgmenttaxcount,sourcecredheadertimeoldest,ssndeceased,ssnsubjectcount,subjectdeceased);
    AttrLayout TrRVA2008_1_0(AttrF le) := TRANSFORM
      SELF.TransactionId := le.TransactionId;
      SELF.name := 'RVA2008_1_0';
      SELF.description := 'Custom Model for Auto Acceptance Corp';
      SELF.Score := (STRING)le.RVA2008_1_0_Score;
      SELF.Messages := RCToMessage(le.RVA2008_1_0_Reasons);
      SELF.Attributes := DATASET([
          {'addrchangecount03month',le.addrchangecount03month},
          {'addrinputmatchindex',le.addrinputmatchindex},
          {'addrinputsubjectowned',le.addrinputsubjectowned},
          {'addrprevioustimeoldest',le.addrprevioustimeoldest},
          {'assetpropevercount',le.assetpropevercount},
          {'confirmationinputaddress',le.confirmationinputaddress},
          {'confirmationsubjectfound',le.confirmationsubjectfound},
          {'criminalfelonycount',le.criminalfelonycount},
          {'derogtimenewest',le.derogtimenewest},
          {'evictioncount',le.evictioncount},
          {'inquiryauto12month',le.inquiryauto12month},
          {'inquirybanking12month',le.inquirybanking12month},
          {'inquiryshortterm12month',le.inquiryshortterm12month},
          {'lienjudgmenttaxcount',le.lienjudgmenttaxcount},
          {'sourcecredheadertimeoldest',le.sourcecredheadertimeoldest},
          {'ssndeceased',le.ssndeceased},
          {'ssnsubjectcount',le.ssnsubjectcount},
          {'subjectdeceased',le.subjectdeceased}],NVPair);
    END;
    RVA2008_1_0AsAttr := PROJECT(AttrF,TrRVA2008_1_0(LEFT));
  EXPORT Attr() := RVA2008_1_0AsAttr;
    // Validation
  EXPORT ValidationF := rva2008_1_0.AppendAll_Debug(myfile,do_RVA2008_1_0,addrchangecount03month,addrinputmatchindex,addrinputsubjectowned,addrprevioustimeoldest,assetpropevercount,confirmationinputaddress,confirmationsubjectfound,criminalfelonycount,derogtimenewest,evictioncount,inquiryauto12month,inquirybanking12month,inquiryshortterm12month,lienjudgmenttaxcount,sourcecredheadertimeoldest,ssndeceased,ssnsubjectcount,subjectdeceased);
    ValidationLayout TrRVA2008_1_0(ValidationF le) := TRANSFORM
      SELF.TransactionId := le.TransactionId;
      SELF.name := 'RVA2008_1_0';
      SELF.description := 'Custom Model for Auto Acceptance Corp';
      SELF.Score := (STRING)le.RVA2008_1_0_Score;
      SELF.Messages := RCToMessage(le.RVA2008_1_0_Reasons);
      SELF.Attributes := DATASET([
          {'addrchangecount03month',le.addrchangecount03month},
          {'addrinputmatchindex',le.addrinputmatchindex},
          {'addrinputsubjectowned',le.addrinputsubjectowned},
          {'addrprevioustimeoldest',le.addrprevioustimeoldest},
          {'assetpropevercount',le.assetpropevercount},
          {'confirmationinputaddress',le.confirmationinputaddress},
          {'confirmationsubjectfound',le.confirmationsubjectfound},
          {'criminalfelonycount',le.criminalfelonycount},
          {'derogtimenewest',le.derogtimenewest},
          {'evictioncount',le.evictioncount},
          {'inquiryauto12month',le.inquiryauto12month},
          {'inquirybanking12month',le.inquirybanking12month},
          {'inquiryshortterm12month',le.inquiryshortterm12month},
          {'lienjudgmenttaxcount',le.lienjudgmenttaxcount},
          {'sourcecredheadertimeoldest',le.sourcecredheadertimeoldest},
          {'ssndeceased',le.ssndeceased},
          {'ssnsubjectcount',le.ssnsubjectcount},
          {'subjectdeceased',le.subjectdeceased}],NVPair);
      SELF.PointsAssignment := DATASET([
          {'addrchangecount03month_pts',le.RVA2008_1_0_SCORECARD_model29_addrchangecount03month_score},
          {'addrinputmatchindex_pts',le.RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_score},
          {'addrinputsubjectowned_pts',le.RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_score},
          {'addrprevioustimeoldest_pts',le.RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_score},
          {'assetpropevercount_pts',le.RVA2008_1_0_SCORECARD_model29_assetpropevercount_score},
          {'confirmationinputaddress_pts',le.RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_score},
          {'criminalfelonycount_pts',le.RVA2008_1_0_SCORECARD_model29_criminalfelonycount_score},
          {'derogtimenewest_pts',le.RVA2008_1_0_SCORECARD_model29_derogtimenewest_score},
          {'evictioncount_pts',le.RVA2008_1_0_SCORECARD_model29_evictioncount_score},
          {'inquiryauto12month_pts',le.RVA2008_1_0_SCORECARD_model29_inquiryauto12month_score},
          {'inquirybanking12month_pts',le.RVA2008_1_0_SCORECARD_model29_inquirybanking12month_score},
          {'inquiryshortterm12month_pts',le.RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_score},
          {'lienjudgmenttaxcount_pts',le.RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_score},
          {'sourcecredheadertimeoldest_pts',le.RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_score},
          {'ssnsubjectcount_pts',le.RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_score}],NVPair);
      SELF.ScoreCard := 'SCORECARD_model29';
      SELF.score_date := StringLib.GetDateYYYYMMDD();
      SELF.raw_score := le.RVA2008_1_0_SCORECARD_model29_Score0;
      SELF.calc_temp_score := le.RVA2008_1_0_SCORECARD_model29_Score1;
      SELF.INSUFFICIENT_INFO := FALSE; // Insufficient_Info* not found
      SELF.NO_HIT := le.RVA2008_1_0_No_Hit;
      SELF.reason_codes_base := DATASET([
          {'addrchangecount03month',le.RVA2008_1_0_SCORECARD_model29_addrchangecount03month_contribution_best,le.RVA2008_1_0_SCORECARD_model29_addrchangecount03month_reason},
          {'addrinputmatchindex',le.RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_contribution_best,le.RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_reason},
          {'addrinputsubjectowned',le.RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_contribution_best,le.RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_reason},
          {'addrprevioustimeoldest',le.RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_contribution_best,le.RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_reason},
          {'assetpropevercount',le.RVA2008_1_0_SCORECARD_model29_assetpropevercount_contribution_best,le.RVA2008_1_0_SCORECARD_model29_assetpropevercount_reason},
          {'confirmationinputaddress',le.RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_contribution_best,le.RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_reason},
          {'criminalfelonycount',le.RVA2008_1_0_SCORECARD_model29_criminalfelonycount_contribution_best,le.RVA2008_1_0_SCORECARD_model29_criminalfelonycount_reason},
          {'derogtimenewest',le.RVA2008_1_0_SCORECARD_model29_derogtimenewest_contribution_best,le.RVA2008_1_0_SCORECARD_model29_derogtimenewest_reason},
          {'evictioncount',le.RVA2008_1_0_SCORECARD_model29_evictioncount_contribution_best,le.RVA2008_1_0_SCORECARD_model29_evictioncount_reason},
          {'inquiryauto12month',le.RVA2008_1_0_SCORECARD_model29_inquiryauto12month_contribution_best,le.RVA2008_1_0_SCORECARD_model29_inquiryauto12month_reason},
          {'inquirybanking12month',le.RVA2008_1_0_SCORECARD_model29_inquirybanking12month_contribution_best,le.RVA2008_1_0_SCORECARD_model29_inquirybanking12month_reason},
          {'inquiryshortterm12month',le.RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_contribution_best,le.RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_reason},
          {'lienjudgmenttaxcount',le.RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_contribution_best,le.RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_reason},
          {'sourcecredheadertimeoldest',le.RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_contribution_best,le.RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_reason},
          {'ssnsubjectcount',le.RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_contribution_best,le.RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_reason}],RC_Contributions_Layout);
    END;
    RVA2008_1_0AsValidation := PROJECT(ValidationF,TrRVA2008_1_0(LEFT));
  EXPORT Validation() := RVA2008_1_0AsValidation;
// Now compute some statistics
  Accum := RECORD
    TotalProcessed := COUNT(GROUP);
    RVA2008_1_0_sc_SCORECARD_model29 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1);
    RVA2008_1_0_Deceased := COUNT(GROUP,ValidationF.RVA2008_1_0_Deceased);
    RVA2008_1_0_No_Hit := COUNT(GROUP,ValidationF.RVA2008_1_0_No_Hit);
    RVA2008_1_0_SCORECARD_model29_addrchangecount03month_range_1 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_addrchangecount03month_range=1);
    RVA2008_1_0_SCORECARD_model29_addrchangecount03month_range_2 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_addrchangecount03month_range=2);
    RVA2008_1_0_SCORECARD_model29_addrchangecount03month_range_3 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_addrchangecount03month_range=3);
    RVA2008_1_0_SCORECARD_model29_addrchangecount03month_range_4 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_addrchangecount03month_range=4);
    RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range_1 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range=1);
    RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range_2 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range=2);
    RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range_3 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range=3);
    RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range_4 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range=4);
    RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range_5 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range=5);
    RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range_6 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range=6);
    RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range_7 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range=7);
    RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_range_1 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_range=1);
    RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_range_2 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_range=2);
    RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_range_3 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_range=3);
    RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_range_4 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_range=4);
    RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_range_1 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_range=1);
    RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_range_2 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_range=2);
    RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_range_3 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_range=3);
    RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_range_4 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_range=4);
    RVA2008_1_0_SCORECARD_model29_evictioncount_range_1 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_evictioncount_range=1);
    RVA2008_1_0_SCORECARD_model29_evictioncount_range_2 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_evictioncount_range=2);
    RVA2008_1_0_SCORECARD_model29_evictioncount_range_3 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_evictioncount_range=3);
    RVA2008_1_0_SCORECARD_model29_evictioncount_range_4 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_evictioncount_range=4);
    RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_range_1 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_range=1);
    RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_range_2 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_range=2);
    RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_range_3 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_range=3);
    RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_range_4 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_range=4);
    RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_range_1 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_range=1);
    RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_range_2 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_range=2);
    RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_range_3 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_range=3);
    RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_range_4 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_range=4);
    RVA2008_1_0_SCORECARD_model29_assetpropevercount_range_1 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_assetpropevercount_range=1);
    RVA2008_1_0_SCORECARD_model29_assetpropevercount_range_2 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_assetpropevercount_range=2);
    RVA2008_1_0_SCORECARD_model29_assetpropevercount_range_3 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_assetpropevercount_range=3);
    RVA2008_1_0_SCORECARD_model29_assetpropevercount_range_4 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_assetpropevercount_range=4);
    RVA2008_1_0_SCORECARD_model29_inquirybanking12month_range_1 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_inquirybanking12month_range=1);
    RVA2008_1_0_SCORECARD_model29_inquirybanking12month_range_2 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_inquirybanking12month_range=2);
    RVA2008_1_0_SCORECARD_model29_inquirybanking12month_range_3 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_inquirybanking12month_range=3);
    RVA2008_1_0_SCORECARD_model29_inquirybanking12month_range_4 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_inquirybanking12month_range=4);
    RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_range_1 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_range=1);
    RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_range_2 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_range=2);
    RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_range_3 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_range=3);
    RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_range_4 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_range=4);
    RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_range_5 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_range=5);
    RVA2008_1_0_SCORECARD_model29_criminalfelonycount_range_1 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_criminalfelonycount_range=1);
    RVA2008_1_0_SCORECARD_model29_criminalfelonycount_range_2 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_criminalfelonycount_range=2);
    RVA2008_1_0_SCORECARD_model29_criminalfelonycount_range_3 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_criminalfelonycount_range=3);
    RVA2008_1_0_SCORECARD_model29_criminalfelonycount_range_4 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_criminalfelonycount_range=4);
    RVA2008_1_0_SCORECARD_model29_inquiryauto12month_range_1 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_inquiryauto12month_range=1);
    RVA2008_1_0_SCORECARD_model29_inquiryauto12month_range_2 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_inquiryauto12month_range=2);
    RVA2008_1_0_SCORECARD_model29_inquiryauto12month_range_3 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_inquiryauto12month_range=3);
    RVA2008_1_0_SCORECARD_model29_inquiryauto12month_range_4 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_inquiryauto12month_range=4);
    RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_range_1 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_range=1);
    RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_range_2 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_range=2);
    RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_range_3 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_range=3);
    RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_range_4 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_range=4);
    RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range_1 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range=1);
    RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range_2 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range=2);
    RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range_3 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range=3);
    RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range_4 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range=4);
    RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range_5 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range=5);
    RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range_6 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range=6);
    RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range_7 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range=7);
    RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range_8 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range=8);
    RVA2008_1_0_SCORECARD_model29_derogtimenewest_range_1 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_derogtimenewest_range=1);
    RVA2008_1_0_SCORECARD_model29_derogtimenewest_range_2 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_derogtimenewest_range=2);
    RVA2008_1_0_SCORECARD_model29_derogtimenewest_range_3 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_derogtimenewest_range=3);
    RVA2008_1_0_SCORECARD_model29_derogtimenewest_range_4 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_derogtimenewest_range=4);
    RVA2008_1_0_SCORECARD_model29_derogtimenewest_range_5 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_derogtimenewest_range=5);
    RVA2008_1_0_SCORECARD_model29_derogtimenewest_range_6 := COUNT(GROUP,ValidationF.RVA2008_1_0_sc = 1 AND ValidationF.RVA2008_1_0_SCORECARD_model29_derogtimenewest_range=6);
  END;
  EXPORT StatsF := TABLE(ValidationF,Accum);
  EXPORT Stats() := DATASET([{'ADR Report','','','',0,0,0,'',0,0,'',0,0}
    ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','EXCEPTION','Deceased',0,0,0,'',0,0,'',StatsF[1].RVA2008_1_0_Deceased,100*StatsF[1].RVA2008_1_0_Deceased/StatsF[1].TotalProcessed}
    ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','EXCEPTION','No_Hit',0,0,0,'',0,0,'',StatsF[1].RVA2008_1_0_No_Hit,100*StatsF[1].RVA2008_1_0_No_Hit/StatsF[1].TotalProcessed}
    ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','',0,0,0,'',0,0,'',StatsF[1].RVA2008_1_0_sc_SCORECARD_model29,100*StatsF[1].RVA2008_1_0_sc_SCORECARD_model29/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','addrchangecount03month','-998','-998',0.0,'NUMBER',-0.127115841774383,-0.127115841774383,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_addrchangecount03month_range_1,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_addrchangecount03month_range_1/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','addrchangecount03month','-1','-1',0.0,'NUMBER',-0.127115841774383,-0.127115841774383,'C12',StatsF[1].RVA2008_1_0_SCORECARD_model29_addrchangecount03month_range_2,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_addrchangecount03month_range_2/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','addrchangecount03month','-999999999','0.5',-0.127115841774383,'NUMBER',-0.127115841774383,-0.127115841774383,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_addrchangecount03month_range_3,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_addrchangecount03month_range_3/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','addrchangecount03month','0.5','HIGH',0.127087652224877,'NUMBER',-0.127115841774383,-0.127115841774383,'C14',StatsF[1].RVA2008_1_0_SCORECARD_model29_addrchangecount03month_range_4,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_addrchangecount03month_range_4/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','addrchangecount03month',0,0,0,'TOTAL',0,0,'',StatsF[1].RVA2008_1_0_sc_SCORECARD_model29,100*StatsF[1].RVA2008_1_0_sc_SCORECARD_model29/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','addrprevioustimeoldest','-998','-998',0.0,'NUMBER',-0.129379355322629,-0.129379355322629,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range_1,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range_1/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','addrprevioustimeoldest','-1','-1',0.391107019035651,'NUMBER',-0.129379355322629,-0.129379355322629,'C12',StatsF[1].RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range_2,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range_2/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','addrprevioustimeoldest','-999999999','7.5',0.174250955427562,'NUMBER',-0.129379355322629,-0.129379355322629,'C13',StatsF[1].RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range_3,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range_3/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','addrprevioustimeoldest','7.5','86.5',0.0490651499357637,'NUMBER',-0.129379355322629,-0.129379355322629,'C13',StatsF[1].RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range_4,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range_4/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','addrprevioustimeoldest','86.5','115.5',0.0208498257296678,'NUMBER',-0.129379355322629,-0.129379355322629,'C13',StatsF[1].RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range_5,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range_5/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','addrprevioustimeoldest','115.5','176.5',-0.0818484746821617,'NUMBER',-0.129379355322629,-0.129379355322629,'C13',StatsF[1].RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range_6,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range_6/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','addrprevioustimeoldest','176.5','HIGH',-0.129379355322629,'NUMBER',-0.129379355322629,-0.129379355322629,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range_7,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range_7/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','addrprevioustimeoldest',0,0,0,'TOTAL',0,0,'',StatsF[1].RVA2008_1_0_sc_SCORECARD_model29,100*StatsF[1].RVA2008_1_0_sc_SCORECARD_model29/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','addrinputsubjectowned','-998','-998',0.0,'NUMBER',-0.0918809204789587,-0.0918809204789587,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_range_1,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_range_1/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','addrinputsubjectowned','-1','-1',-0.0561726022157193,'NUMBER',-0.0918809204789587,-0.0918809204789587,'A44',StatsF[1].RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_range_2,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_range_2/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','addrinputsubjectowned','-999999999','0.5',0.0930516666000292,'NUMBER',-0.0918809204789587,-0.0918809204789587,'A44',StatsF[1].RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_range_3,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_range_3/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','addrinputsubjectowned','0.5','HIGH',-0.0918809204789587,'NUMBER',-0.0918809204789587,-0.0918809204789587,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_range_4,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_range_4/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','addrinputsubjectowned',0,0,0,'TOTAL',0,0,'',StatsF[1].RVA2008_1_0_sc_SCORECARD_model29,100*StatsF[1].RVA2008_1_0_sc_SCORECARD_model29/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','addrinputmatchindex','-998','-998',0.0,'NUMBER',-0.100830449123503,-0.100830449123503,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_range_1,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_range_1/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','addrinputmatchindex','-1','-1',0.0,'NUMBER',-0.100830449123503,-0.100830449123503,'C12',StatsF[1].RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_range_2,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_range_2/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','addrinputmatchindex','-999999999','0.5',0.100955889904955,'NUMBER',-0.100830449123503,-0.100830449123503,'F01',StatsF[1].RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_range_3,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_range_3/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','addrinputmatchindex','0.5','HIGH',-0.100830449123503,'NUMBER',-0.100830449123503,-0.100830449123503,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_range_4,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_range_4/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','addrinputmatchindex',0,0,0,'TOTAL',0,0,'',StatsF[1].RVA2008_1_0_sc_SCORECARD_model29,100*StatsF[1].RVA2008_1_0_sc_SCORECARD_model29/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','evictioncount','-998','-998',0.0,'NUMBER',-0.178020801968896,-0.178020801968896,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_evictioncount_range_1,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_evictioncount_range_1/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','evictioncount','-1','-1',0.0,'NUMBER',-0.178020801968896,-0.178020801968896,'C12',StatsF[1].RVA2008_1_0_SCORECARD_model29_evictioncount_range_2,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_evictioncount_range_2/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','evictioncount','-999999999','1',-0.178020801968896,'NUMBER',-0.178020801968896,-0.178020801968896,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_evictioncount_range_3,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_evictioncount_range_3/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','evictioncount','1','HIGH',0.178078662403005,'NUMBER',-0.178020801968896,-0.178020801968896,'D33',StatsF[1].RVA2008_1_0_SCORECARD_model29_evictioncount_range_4,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_evictioncount_range_4/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','evictioncount',0,0,0,'TOTAL',0,0,'',StatsF[1].RVA2008_1_0_sc_SCORECARD_model29,100*StatsF[1].RVA2008_1_0_sc_SCORECARD_model29/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','confirmationinputaddress','-998','-998',0.0,'NUMBER',-0.111168165234986,-0.111168165234986,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_range_1,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_range_1/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','confirmationinputaddress','-1','-1',0.0,'NUMBER',-0.111168165234986,-0.111168165234986,'C12',StatsF[1].RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_range_2,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_range_2/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','confirmationinputaddress','-999999999','0.5',0.111181517096239,'NUMBER',-0.111168165234986,-0.111168165234986,'F01',StatsF[1].RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_range_3,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_range_3/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','confirmationinputaddress','0.5','HIGH',-0.111168165234986,'NUMBER',-0.111168165234986,-0.111168165234986,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_range_4,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_range_4/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','confirmationinputaddress',0,0,0,'TOTAL',0,0,'',StatsF[1].RVA2008_1_0_sc_SCORECARD_model29,100*StatsF[1].RVA2008_1_0_sc_SCORECARD_model29/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','lienjudgmenttaxcount','-998','-998',0.0,'NUMBER',-0.126193151814627,-0.126193151814627,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_range_1,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_range_1/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','lienjudgmenttaxcount','-1','-1',0.0,'NUMBER',-0.126193151814627,-0.126193151814627,'C12',StatsF[1].RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_range_2,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_range_2/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','lienjudgmenttaxcount','-999999999','0.5',-0.126193151814627,'NUMBER',-0.126193151814627,-0.126193151814627,'D34',StatsF[1].RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_range_3,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_range_3/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','lienjudgmenttaxcount','0.5','HIGH',0.126122335670169,'NUMBER',-0.126193151814627,-0.126193151814627,'D34',StatsF[1].RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_range_4,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_range_4/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','lienjudgmenttaxcount',0,0,0,'TOTAL',0,0,'',StatsF[1].RVA2008_1_0_sc_SCORECARD_model29,100*StatsF[1].RVA2008_1_0_sc_SCORECARD_model29/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','assetpropevercount','-998','-998',0.0,'NUMBER',-0.109846840713539,-0.109846840713539,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_assetpropevercount_range_1,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_assetpropevercount_range_1/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','assetpropevercount','-1','-1',0.0,'NUMBER',-0.109846840713539,-0.109846840713539,'C12',StatsF[1].RVA2008_1_0_SCORECARD_model29_assetpropevercount_range_2,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_assetpropevercount_range_2/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','assetpropevercount','-999999999','1.5',0.109908656388069,'NUMBER',-0.109846840713539,-0.109846840713539,'A45',StatsF[1].RVA2008_1_0_SCORECARD_model29_assetpropevercount_range_3,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_assetpropevercount_range_3/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','assetpropevercount','1.5','HIGH',-0.109846840713539,'NUMBER',-0.109846840713539,-0.109846840713539,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_assetpropevercount_range_4,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_assetpropevercount_range_4/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','assetpropevercount',0,0,0,'TOTAL',0,0,'',StatsF[1].RVA2008_1_0_sc_SCORECARD_model29,100*StatsF[1].RVA2008_1_0_sc_SCORECARD_model29/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','inquirybanking12month','-998','-998',0.0,'NUMBER',-0.0447006009247188,-0.0447006009247188,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_inquirybanking12month_range_1,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_inquirybanking12month_range_1/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','inquirybanking12month','-1','-1',0.0,'NUMBER',-0.0447006009247188,-0.0447006009247188,'C12',StatsF[1].RVA2008_1_0_SCORECARD_model29_inquirybanking12month_range_2,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_inquirybanking12month_range_2/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','inquirybanking12month','-999999999','0.5',-0.0447006009247188,'NUMBER',-0.0447006009247188,-0.0447006009247188,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_inquirybanking12month_range_3,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_inquirybanking12month_range_3/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','inquirybanking12month','0.5','HIGH',0.0446544639356558,'NUMBER',-0.0447006009247188,-0.0447006009247188,'I60',StatsF[1].RVA2008_1_0_SCORECARD_model29_inquirybanking12month_range_4,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_inquirybanking12month_range_4/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','inquirybanking12month',0,0,0,'TOTAL',0,0,'',StatsF[1].RVA2008_1_0_sc_SCORECARD_model29,100*StatsF[1].RVA2008_1_0_sc_SCORECARD_model29/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','ssnsubjectcount','-998','-998',0.0,'NUMBER',-0.237420388277113,-0.237420388277113,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_range_1,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_range_1/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','ssnsubjectcount','-1','-1',0.0,'NUMBER',-0.237420388277113,-0.237420388277113,'C12',StatsF[1].RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_range_2,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_range_2/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','ssnsubjectcount','-999999999','0',0.450938368246577,'NUMBER',-0.237420388277113,-0.237420388277113,'F00',StatsF[1].RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_range_3,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_range_3/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','ssnsubjectcount','0','1',-0.237420388277113,'NUMBER',-0.237420388277113,-0.237420388277113,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_range_4,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_range_4/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','ssnsubjectcount','1','HIGH',0.081589076071594,'NUMBER',-0.237420388277113,-0.237420388277113,'S65',StatsF[1].RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_range_5,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_range_5/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','ssnsubjectcount',0,0,0,'TOTAL',0,0,'',StatsF[1].RVA2008_1_0_sc_SCORECARD_model29,100*StatsF[1].RVA2008_1_0_sc_SCORECARD_model29/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','criminalfelonycount','-998','-998',0.0,'NUMBER',-0.0856869472262584,-0.0856869472262584,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_criminalfelonycount_range_1,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_criminalfelonycount_range_1/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','criminalfelonycount','-1','-1',0.0,'NUMBER',-0.0856869472262584,-0.0856869472262584,'C12',StatsF[1].RVA2008_1_0_SCORECARD_model29_criminalfelonycount_range_2,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_criminalfelonycount_range_2/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','criminalfelonycount','-999999999','0',-0.0856869472262584,'NUMBER',-0.0856869472262584,-0.0856869472262584,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_criminalfelonycount_range_3,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_criminalfelonycount_range_3/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','criminalfelonycount','0','HIGH',0.0856212019772778,'NUMBER',-0.0856869472262584,-0.0856869472262584,'D32',StatsF[1].RVA2008_1_0_SCORECARD_model29_criminalfelonycount_range_4,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_criminalfelonycount_range_4/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','criminalfelonycount',0,0,0,'TOTAL',0,0,'',StatsF[1].RVA2008_1_0_sc_SCORECARD_model29,100*StatsF[1].RVA2008_1_0_sc_SCORECARD_model29/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','inquiryauto12month','-998','-998',0.0,'NUMBER',-0.106930143606789,-0.106930143606789,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_inquiryauto12month_range_1,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_inquiryauto12month_range_1/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','inquiryauto12month','-1','-1',0.0,'NUMBER',-0.106930143606789,-0.106930143606789,'C12',StatsF[1].RVA2008_1_0_SCORECARD_model29_inquiryauto12month_range_2,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_inquiryauto12month_range_2/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','inquiryauto12month','-999999999','0.5',-0.106930143606789,'NUMBER',-0.106930143606789,-0.106930143606789,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_inquiryauto12month_range_3,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_inquiryauto12month_range_3/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','inquiryauto12month','0.5','HIGH',0.106868749343492,'NUMBER',-0.106930143606789,-0.106930143606789,'I60',StatsF[1].RVA2008_1_0_SCORECARD_model29_inquiryauto12month_range_4,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_inquiryauto12month_range_4/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','inquiryauto12month',0,0,0,'TOTAL',0,0,'',StatsF[1].RVA2008_1_0_sc_SCORECARD_model29,100*StatsF[1].RVA2008_1_0_sc_SCORECARD_model29/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','inquiryshortterm12month','-998','-998',0.0,'NUMBER',-0.145587984044509,-0.145587984044509,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_range_1,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_range_1/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','inquiryshortterm12month','-1','-1',0.0,'NUMBER',-0.145587984044509,-0.145587984044509,'C12',StatsF[1].RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_range_2,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_range_2/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','inquiryshortterm12month','-999999999','0.5',-0.145587984044509,'NUMBER',-0.145587984044509,-0.145587984044509,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_range_3,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_range_3/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','inquiryshortterm12month','0.5','HIGH',0.145539677615496,'NUMBER',-0.145587984044509,-0.145587984044509,'I60',StatsF[1].RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_range_4,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_range_4/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','inquiryshortterm12month',0,0,0,'TOTAL',0,0,'',StatsF[1].RVA2008_1_0_sc_SCORECARD_model29,100*StatsF[1].RVA2008_1_0_sc_SCORECARD_model29/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','sourcecredheadertimeoldest','-998','-998',0.0,'NUMBER',-0.231932845723712,-0.231932845723712,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range_1,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range_1/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','sourcecredheadertimeoldest','-1','-1',0.0,'NUMBER',-0.231932845723712,-0.231932845723712,'C12',StatsF[1].RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range_2,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range_2/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','sourcecredheadertimeoldest','-999999999','135.5',0.215747425264362,'NUMBER',-0.231932845723712,-0.231932845723712,'C20',StatsF[1].RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range_3,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range_3/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','sourcecredheadertimeoldest','135.5','164.5',0.138849500320951,'NUMBER',-0.231932845723712,-0.231932845723712,'C20',StatsF[1].RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range_4,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range_4/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','sourcecredheadertimeoldest','164.5','264.5',0.0133221520435431,'NUMBER',-0.231932845723712,-0.231932845723712,'C20',StatsF[1].RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range_5,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range_5/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','sourcecredheadertimeoldest','264.5','339.5',-0.0412690302862565,'NUMBER',-0.231932845723712,-0.231932845723712,'C20',StatsF[1].RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range_6,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range_6/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','sourcecredheadertimeoldest','339.5','370.5',-0.100717876711618,'NUMBER',-0.231932845723712,-0.231932845723712,'C20',StatsF[1].RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range_7,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range_7/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','sourcecredheadertimeoldest','370.5','HIGH',-0.231932845723712,'NUMBER',-0.231932845723712,-0.231932845723712,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range_8,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range_8/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','sourcecredheadertimeoldest',0,0,0,'TOTAL',0,0,'',StatsF[1].RVA2008_1_0_sc_SCORECARD_model29,100*StatsF[1].RVA2008_1_0_sc_SCORECARD_model29/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','derogtimenewest','-998','-998',0.0,'NUMBER',-0.0745719346721392,-0.0745719346721392,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_derogtimenewest_range_1,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_derogtimenewest_range_1/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','derogtimenewest','-1','-1',-0.0745719346721392,'NUMBER',-0.0745719346721392,-0.0745719346721392,'',StatsF[1].RVA2008_1_0_SCORECARD_model29_derogtimenewest_range_2,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_derogtimenewest_range_2/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','derogtimenewest','-999999999','3.5',0.221141705304125,'NUMBER',-0.0745719346721392,-0.0745719346721392,'D30',StatsF[1].RVA2008_1_0_SCORECARD_model29_derogtimenewest_range_3,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_derogtimenewest_range_3/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','derogtimenewest','3.5','15.5',0.131207044522461,'NUMBER',-0.0745719346721392,-0.0745719346721392,'D30',StatsF[1].RVA2008_1_0_SCORECARD_model29_derogtimenewest_range_4,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_derogtimenewest_range_4/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','derogtimenewest','15.5','41.5',-0.00251770794789452,'NUMBER',-0.0745719346721392,-0.0745719346721392,'D30',StatsF[1].RVA2008_1_0_SCORECARD_model29_derogtimenewest_range_5,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_derogtimenewest_range_5/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','derogtimenewest','41.5','HIGH',-0.0139670805571985,'NUMBER',-0.0745719346721392,-0.0745719346721392,'D30',StatsF[1].RVA2008_1_0_SCORECARD_model29_derogtimenewest_range_6,100*StatsF[1].RVA2008_1_0_SCORECARD_model29_derogtimenewest_range_6/StatsF[1].TotalProcessed}
      ,{'RVA2008_1_0','Custom Model for Auto Acceptance Corp','SCORECARD_model29','derogtimenewest',0,0,0,'TOTAL',0,0,'',StatsF[1].RVA2008_1_0_sc_SCORECARD_model29,100*StatsF[1].RVA2008_1_0_sc_SCORECARD_model29/StatsF[1].TotalProcessed}
    ],rva2008_1_0.Results.StatsLayout);
  END;
  RETURN res(infile);
ENDMACRO;
