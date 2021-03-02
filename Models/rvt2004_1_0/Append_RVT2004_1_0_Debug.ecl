EXPORT Append_RVT2004_1_0_Debug( infile,do_model=true,p_addrchangecount60month,p_addrcurrentownershipindex,p_addronfilecount,p_addrprevioustimeoldest,p_alertregulatorycondition,p_assetpropevercount,p_bankruptcystatus,p_confirmationsubjectfound,p_evictioncount,p_inquiryauto12month,p_inquirybanking12month,p_inquirycollections12month,p_inquiryshortterm12month,p_lienjudgmentcount,p_shorttermloanrequest,p_sourcenonderogcount,p_sourcenonderogcount06month,p_ssndeceased,p_subjectdeceased,p_subjectrecordtimeoldest) := FUNCTIONMACRO
  
  RPrep := RECORD
    infile;
    rvt2004_1_0.Append_RVT2004_1_0_ModelLayouts.Prepare;
    rvt2004_1_0.Append_RVT2004_1_0_ModelLayouts.Working;
  END;
  RPrep PrepareMe(infile le) := TRANSFORM
    SELF.L_addrprevioustimeoldest_alt := (real) le.p_addrprevioustimeoldest;
    SELF.L_ca_creditseeking_orig := map((real) le.p_inquiryshortterm12month = 1 and ((real) le.p_inquiryauto12month = 1 or (real) le.p_shorttermloanrequest = 1) => 5,(real) le.p_inquiryshortterm12month = 1 and ((real) le.p_inquirybanking12month <> 0 or (real) le.p_inquirycollections12month = 1) => 4,(real) le.p_inquiryshortterm12month = 1 => 3,((real) le.p_inquiryauto12month = 1 or (real) le.p_shorttermloanrequest = 1) => 2,((real) le.p_inquirybanking12month = 1 or (real) le.p_inquirycollections12month = 1) => 1,0);
    SELF.L_ca_creditseeking := map(SELF.L_ca_creditseeking_orig = 1 and (real) le.p_inquirybanking12month = 0 and (real) le.p_inquirycollections12month = 1 => 7,SELF.L_ca_creditseeking_orig = 2 and (real) le.p_inquirybanking12month = 0 and (real) le.p_shorttermloanrequest = 1 => 6,SELF.L_ca_creditseeking_orig);
    SELF.L_ca_addrchangeindex := map((real) le.p_subjectrecordtimeoldest <= 84 and (real) le.p_subjectrecordtimeoldest >= 0 => map((real) le.p_addronfilecount > 5 => 5,(real) le.p_addronfilecount > 3 => 4,(real) le.p_addronfilecount > 2 => 3,(real) le.p_addronfilecount > 1 => 2, 1),map((real) le.p_addrchangecount60month > 3 => 5,(real) le.p_addrchangecount60month > 1 => 4,(real) le.p_addrchangecount60month > 0 => 3, 2));
    SELF.L_ca_nonderogindex_alt := map((real) le.p_sourcenonderogcount > 3 and (real) le.p_sourcenonderogcount06month > 1 => 3,(real) le.p_sourcenonderogcount > 3 or (real) le.p_sourcenonderogcount06month > 1 => 2, 1);
    SELF.L_ca_derogseverityindex_orig := map((real) le.p_evictioncount > 3 or ((real) le.p_evictioncount > 1 and (real) le.p_lienjudgmentcount > 0) or ((real) le.p_evictioncount > 0 and (real) le.p_bankruptcystatus = 2) => 5,(real) le.p_evictioncount > 1 or ((real) le.p_evictioncount > 0 and (real) le.p_lienjudgmentcount > 0) => 4,(real) le.p_evictioncount > 0 => 3,(real) le.p_bankruptcystatus = 2 => 2,(real) le.p_lienjudgmentcount > 0 => 1,0);
    SELF.L_ca_derogseverityindex := map((SELF.L_ca_derogseverityindex_orig = 2 or SELF.L_ca_derogseverityindex_orig = 3) and (real) le.p_evictioncount = 0 and (real) le.p_bankruptcystatus = 2 => 8,(SELF.L_ca_derogseverityindex_orig = 2 or SELF.L_ca_derogseverityindex_orig = 3) and (real) le.p_evictioncount = 1 and (real) le.p_bankruptcystatus <> 2 => 7,(SELF.L_ca_derogseverityindex_orig = 4 or SELF.L_ca_derogseverityindex_orig = 5) and (real) le.p_evictioncount > 0 and (real) le.p_bankruptcystatus <> 2 and (real) le.p_lienjudgmentcount = 0 => 6,SELF.L_ca_derogseverityindex_orig);
    SELF.RVT2004_1_0_Alert := ((real) le.p_alertregulatorycondition = 3);
    SELF.RVT2004_1_0_No_Hit := ((real) le.p_confirmationsubjectfound = -998) or ((real) le.p_confirmationsubjectfound < 1);
    SELF.RVT2004_1_0_Deceased := ((real) le.p_ssndeceased = 1) or ((real) le.p_subjectdeceased = 1);
    SELF.RVT2004_1_0_ex := WHICH(SELF.RVT2004_1_0_Alert,SELF.RVT2004_1_0_No_Hit,SELF.RVT2004_1_0_Deceased);
    SELF.RVT2004_1_0_sc := IF ( SELF.RVT2004_1_0_ex = 0, 1, 0 );
    SELF := le;
  END;
  Prepared := PROJECT(infile,PrepareMe(LEFT));
  rres := RECORD
    infile;
    rvt2004_1_0.Append_RVT2004_1_0_ModelLayouts.Result;
    rvt2004_1_0.Append_RVT2004_1_0_ModelLayouts.Prepare;
    rvt2004_1_0.Append_RVT2004_1_0_ModelLayouts.Debug;
  END;
  rres TrEx(Prepared le) := TRANSFORM
    SELF.RVT2004_1_0_Score := CHOOSE(le.RVT2004_1_0_ex,100,222,200);
    SELF.RVT2004_1_0_Reasons := CHOOSE( le.RVT2004_1_0_ex,[],[],[]);
    SELF := le;
  END;
// Transform to compute result
  rres tr1(Prepared le) := TRANSFORM
// Computations for components of score SCORECARD_model110

    SELF.RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range := WHICH(((REAL)le.p_addrcurrentownershipindex) >= -998 AND ((REAL)le.p_addrcurrentownershipindex) <= -998,((REAL)le.p_addrcurrentownershipindex) >= -1 AND ((REAL)le.p_addrcurrentownershipindex) <= -1,((REAL)le.p_addrcurrentownershipindex) >= -998 AND ((REAL)le.p_addrcurrentownershipindex) <= -998,((REAL)le.p_addrcurrentownershipindex) >= 999 AND ((REAL)le.p_addrcurrentownershipindex) <= 999,((REAL)le.p_addrcurrentownershipindex) >= -999999999 AND ((REAL)le.p_addrcurrentownershipindex) <= 0.5,((REAL)le.p_addrcurrentownershipindex) >= 0.5 AND ((REAL)le.p_addrcurrentownershipindex) <= 2.5,((REAL)le.p_addrcurrentownershipindex) >= 2.5 AND ((REAL)le.p_addrcurrentownershipindex) <= 3.5,((REAL)le.p_addrcurrentownershipindex) >= 3.5);
    SELF.RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_score := CHOOSE(SELF.RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range,0.0,0.0,0.0,0.0,0.241278264062402,0.00593506382761733,-0.422097965223441,-0.426452499208887,0);
    SELF.RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_contribution_best := CHOOSE(SELF.RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range,0.0 - 0.044169642,0.0 - 0.044169642,0.0 - 0.044169642,0.0 - 0.044169642,0.241278264062402 - 0.044169642,0.00593506382761733 - 0.044169642,-0.422097965223441 - 0.044169642,-0.426452499208887 - 0.044169642,0);
    SELF.RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_reason := CHOOSE(SELF.RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_range,'','A44','','','A44','A44','A44','A44','99999');

    SELF.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range := WHICH(le.L_ca_creditseeking >= -998 AND le.L_ca_creditseeking <= -998,le.L_ca_creditseeking >= -1 AND le.L_ca_creditseeking <= -1,le.L_ca_creditseeking >= -998 AND le.L_ca_creditseeking <= -998,le.L_ca_creditseeking >= 999 AND le.L_ca_creditseeking <= 999,le.L_ca_creditseeking >= -999999999 AND le.L_ca_creditseeking <= 0,le.L_ca_creditseeking >= 1 AND le.L_ca_creditseeking <= 1,le.L_ca_creditseeking >= 2 AND le.L_ca_creditseeking <= 2,le.L_ca_creditseeking >= 3 AND le.L_ca_creditseeking <= 3,le.L_ca_creditseeking >= 4 AND le.L_ca_creditseeking <= 4,le.L_ca_creditseeking >= 5 AND le.L_ca_creditseeking <= 5,le.L_ca_creditseeking >= 6 AND le.L_ca_creditseeking <= 6,le.L_ca_creditseeking >= 6);
    SELF.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_score := CHOOSE(SELF.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range,0.0,0.0,0.0,0.0,-0.362569357925149,0.0367915769388987,0.222011816622779,0.467339660305824,0.943890182033126,0.979326295061764,0.222011816622779,0.0367915769388987,0);
    SELF.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_contribution_best := CHOOSE(SELF.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range,0.0 - -0.145916024,0.0 - -0.145916024,0.0 - -0.145916024,0.0 - -0.145916024,-0.362569357925149 - -0.145916024,0.0367915769388987 - -0.145916024,0.222011816622779 - -0.145916024,0.467339660305824 - -0.145916024,0.943890182033126 - -0.145916024,0.979326295061764 - -0.145916024,0.222011816622779 - -0.145916024,0.0367915769388987 - -0.145916024,0);
    SELF.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_reason := CHOOSE(SELF.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_range,'','I60','','','I60','I60','I60','I60','I60','I60','C21','I61','99999');

    SELF.RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range := WHICH(le.L_ca_addrchangeindex >= -998 AND le.L_ca_addrchangeindex <= -998,le.L_ca_addrchangeindex >= -1 AND le.L_ca_addrchangeindex <= -1,le.L_ca_addrchangeindex >= -998 AND le.L_ca_addrchangeindex <= -998,le.L_ca_addrchangeindex >= 999 AND le.L_ca_addrchangeindex <= 999,le.L_ca_addrchangeindex >= -999999999 AND le.L_ca_addrchangeindex <= 1.5,le.L_ca_addrchangeindex >= 1.5 AND le.L_ca_addrchangeindex <= 2.5,le.L_ca_addrchangeindex >= 2.5 AND le.L_ca_addrchangeindex <= 3.5,le.L_ca_addrchangeindex >= 3.5 AND le.L_ca_addrchangeindex <= 4.5,le.L_ca_addrchangeindex >= 4.5);
    SELF.RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_score := CHOOSE(SELF.RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range,0.0,0.0,0.0,0.0,-0.361445513556842,-0.0326651072762166,0.228542788688605,0.345993801395147,0.650067423161005,0);
    SELF.RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_contribution_best := CHOOSE(SELF.RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range,0.0 - -0.050522645,0.0 - -0.050522645,0.0 - -0.050522645,0.0 - -0.050522645,-0.361445513556842 - -0.050522645,-0.0326651072762166 - -0.050522645,0.228542788688605 - -0.050522645,0.345993801395147 - -0.050522645,0.650067423161005 - -0.050522645,0);
    SELF.RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_reason := CHOOSE(SELF.RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_range,'','C14','','','C14','C14','C14','C14','C14','99999');

    SELF.RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range := WHICH(le.L_ca_nonderogindex_alt >= -998 AND le.L_ca_nonderogindex_alt <= -998,le.L_ca_nonderogindex_alt >= -1 AND le.L_ca_nonderogindex_alt <= -1,le.L_ca_nonderogindex_alt >= -998 AND le.L_ca_nonderogindex_alt <= -998,le.L_ca_nonderogindex_alt >= 999 AND le.L_ca_nonderogindex_alt <= 999,le.L_ca_nonderogindex_alt >= -999999999 AND le.L_ca_nonderogindex_alt <= 1.5,le.L_ca_nonderogindex_alt >= 1.5);
    SELF.RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_score := CHOOSE(SELF.RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range,0.0,0.0,0.0,0.0,0.269980986524245,-0.254808888546115,0);
    SELF.RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_contribution_best := CHOOSE(SELF.RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range,0.0 - 0.251102104,0.0 - 0.251102104,0.0 - 0.251102104,0.0 - 0.251102104,0.269980986524245 - 0.251102104,-0.254808888546115 - 0.251102104,0);
    SELF.RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_reason := CHOOSE(SELF.RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_range,'','C12','','','C12','C12','99999');

    SELF.RVT2004_1_0_SCORECARD_model110_assetpropevercount_range := WHICH(((REAL)le.p_assetpropevercount) >= -998 AND ((REAL)le.p_assetpropevercount) <= -998,((REAL)le.p_assetpropevercount) >= -1 AND ((REAL)le.p_assetpropevercount) <= -1,((REAL)le.p_assetpropevercount) >= -998 AND ((REAL)le.p_assetpropevercount) <= -998,((REAL)le.p_assetpropevercount) >= 999 AND ((REAL)le.p_assetpropevercount) <= 999,((REAL)le.p_assetpropevercount) >= -999999999 AND ((REAL)le.p_assetpropevercount) <= 0.5,((REAL)le.p_assetpropevercount) >= 0.5 AND ((REAL)le.p_assetpropevercount) <= 1.5,((REAL)le.p_assetpropevercount) >= 1.5);
    SELF.RVT2004_1_0_SCORECARD_model110_assetpropevercount_score := CHOOSE(SELF.RVT2004_1_0_SCORECARD_model110_assetpropevercount_range,0.0,0.0,0.0,0.0,0.258573459164827,-0.146309609694865,-0.597848433083429,0);
    SELF.RVT2004_1_0_SCORECARD_model110_assetpropevercount_contribution_best := CHOOSE(SELF.RVT2004_1_0_SCORECARD_model110_assetpropevercount_range,0.0 - 0.233084749,0.0 - 0.233084749,0.0 - 0.233084749,0.0 - 0.233084749,0.258573459164827 - 0.233084749,-0.146309609694865 - 0.233084749,-0.597848433083429 - 0.233084749,0);
    SELF.RVT2004_1_0_SCORECARD_model110_assetpropevercount_reason := CHOOSE(SELF.RVT2004_1_0_SCORECARD_model110_assetpropevercount_range,'','A41','','','A41','A41','A41','99999');

    SELF.RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range := WHICH(le.L_addrprevioustimeoldest_alt >= -998 AND le.L_addrprevioustimeoldest_alt <= -998,le.L_addrprevioustimeoldest_alt >= -1 AND le.L_addrprevioustimeoldest_alt <= -1,le.L_addrprevioustimeoldest_alt >= -998 AND le.L_addrprevioustimeoldest_alt <= -998,le.L_addrprevioustimeoldest_alt >= 999 AND le.L_addrprevioustimeoldest_alt <= 999,le.L_addrprevioustimeoldest_alt >= -999999999 AND le.L_addrprevioustimeoldest_alt <= 96,le.L_addrprevioustimeoldest_alt >= 96 AND le.L_addrprevioustimeoldest_alt <= 132,le.L_addrprevioustimeoldest_alt >= 132 AND le.L_addrprevioustimeoldest_alt <= 204,le.L_addrprevioustimeoldest_alt >= 204 AND le.L_addrprevioustimeoldest_alt <= 240,le.L_addrprevioustimeoldest_alt >= 240);
    SELF.RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_score := CHOOSE(SELF.RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range,0.0,-0.192125399167892,0.0,0.0,0.195602970040618,0.129691677434657,0.0169316915846859,-0.0774303118296151,-0.377374107224287,0);
    SELF.RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_contribution_best := CHOOSE(SELF.RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range,0.0 - 0.006917638,-0.192125399167892 - 0.006917638,0.0 - 0.006917638,0.0 - 0.006917638,0.195602970040618 - 0.006917638,0.129691677434657 - 0.006917638,0.0169316915846859 - 0.006917638,-0.0774303118296151 - 0.006917638,-0.377374107224287 - 0.006917638,0);
    SELF.RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_reason := CHOOSE(SELF.RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_range,'','C13','','','C13','C13','C13','C13','C13','99999');

    SELF.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range := WHICH(le.L_ca_derogseverityindex >= -998 AND le.L_ca_derogseverityindex <= -998,le.L_ca_derogseverityindex >= -1 AND le.L_ca_derogseverityindex <= -1,le.L_ca_derogseverityindex >= -998 AND le.L_ca_derogseverityindex <= -998,le.L_ca_derogseverityindex >= 999 AND le.L_ca_derogseverityindex <= 999,le.L_ca_derogseverityindex >= -999999999 AND le.L_ca_derogseverityindex <= 0,le.L_ca_derogseverityindex >= 1 AND le.L_ca_derogseverityindex <= 1,le.L_ca_derogseverityindex >= 2 AND le.L_ca_derogseverityindex <= 2,le.L_ca_derogseverityindex >= 3 AND le.L_ca_derogseverityindex <= 3,le.L_ca_derogseverityindex >= 4 AND le.L_ca_derogseverityindex <= 4,le.L_ca_derogseverityindex >= 5 AND le.L_ca_derogseverityindex <= 5,le.L_ca_derogseverityindex >= 6 AND le.L_ca_derogseverityindex <= 6,le.L_ca_derogseverityindex >= 7 AND le.L_ca_derogseverityindex <= 7,le.L_ca_derogseverityindex >= 7);
    SELF.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_score := CHOOSE(SELF.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range,0.0,0.0,0.0,0.0,-0.204450773503088,-0.129339415823904,0.331183108776348,0.331183108776348,0.475902823827432,0.475902823827432,0.475902823827432,0.331183108776348,0.331183108776348,0);
    SELF.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_contribution_best := CHOOSE(SELF.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range,0.0 - -0.17793609,0.0 - -0.17793609,0.0 - -0.17793609,0.0 - -0.17793609,-0.204450773503088 - -0.17793609,-0.129339415823904 - -0.17793609,0.331183108776348 - -0.17793609,0.331183108776348 - -0.17793609,0.475902823827432 - -0.17793609,0.475902823827432 - -0.17793609,0.475902823827432 - -0.17793609,0.331183108776348 - -0.17793609,0.331183108776348 - -0.17793609,0);
    SELF.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_reason := CHOOSE(SELF.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_range,'','','','','','D34','D30','D30','D30','D30','D33','D33','D31','99999');
// Now compute values for score SCORECARD_model110
    SELF.RVT2004_1_0_SCORECARD_model110_Score0 := -0.172921378314879 + SELF.RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_Score + SELF.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_Score + SELF.RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_Score + SELF.RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_Score + SELF.RVT2004_1_0_SCORECARD_model110_assetpropevercount_Score + SELF.RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_Score + SELF.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_Score;
    SELF.RVT2004_1_0_SCORECARD_model110_Score1 := (700 + -40 * ((SELF.RVT2004_1_0_SCORECARD_model110_Score0 - 0 - LN(0.35685210312076)) / LN(2)));
    SELF.RVT2004_1_0_SCORECARD_model110_Score := ROUND( MAP (  SELF.RVT2004_1_0_SCORECARD_model110_Score1 < 501 => 501, SELF.RVT2004_1_0_SCORECARD_model110_Score1 > 900 => 900,SELF.RVT2004_1_0_SCORECARD_model110_Score1));
    SELF.RVT2004_1_0_Score := SELF.RVT2004_1_0_SCORECARD_model110_Score;
    aggregateRCs := SORT(
      TABLE(
      DATASET([
        {SELF.RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_contribution_best,SELF.RVT2004_1_0_SCORECARD_model110_addrcurrentownershipindex_reason}
        ,{SELF.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_contribution_best,SELF.RVT2004_1_0_SCORECARD_model110_L_ca_creditseeking_reason}
        ,{SELF.RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_contribution_best,SELF.RVT2004_1_0_SCORECARD_model110_L_ca_addrchangeindex_reason}
        ,{SELF.RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_contribution_best,SELF.RVT2004_1_0_SCORECARD_model110_L_ca_nonderogindex_alt_reason}
        ,{SELF.RVT2004_1_0_SCORECARD_model110_assetpropevercount_contribution_best,SELF.RVT2004_1_0_SCORECARD_model110_assetpropevercount_reason}
        ,{SELF.RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_contribution_best,SELF.RVT2004_1_0_SCORECARD_model110_L_addrprevioustimeoldest_alt_reason}
        ,{SELF.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_contribution_best,SELF.RVT2004_1_0_SCORECARD_model110_L_ca_derogseverityindex_reason}
      ], rvt2004_1_0.ReasonType),
      {Reason_Code, Contribution_Sum := SUM(GROUP,Contribution)}, Reason_Code)
      (Reason_Code <> '', Contribution_Sum > 0 ), -Contribution_Sum, Reason_Code);
    topNRCs := CHOOSEN(aggregateRCs, 4);
    combineRCs := topNRCs & IF(~EXISTS(topNRCs(Reason_Code[1] = 'I')), aggregateRCs(Reason_Code[1] = 'I')[1]);
    SET OF STRING5 RVT2004_1_0_SCORECARD_model110_Reasons_best := SET(combineRCs(Reason_Code <> ''), Reason_Code);
    SELF.RVT2004_1_0_SCORECARD_model110_Reasons := RVT2004_1_0_SCORECARD_model110_Reasons_Best;
    SELF.RVT2004_1_0_Reasons := SELF.RVT2004_1_0_SCORECARD_model110_Reasons;
    SELF := le;
  END;
  RETURN PROJECT(Prepared(RVT2004_1_0_ex > 0),TrEX(LEFT))+PROJECT( Prepared(RVT2004_1_0_sc = 1),Tr1(LEFT));
ENDMACRO;
