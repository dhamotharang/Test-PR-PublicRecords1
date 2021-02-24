EXPORT Append_RVT2004_2_0_Model( infile,do_model=true,p_addrchangecount60month,p_addrcurrentownershipindex,p_addronfilecount,p_addrprevioustimeoldest,p_alertregulatorycondition,p_assetpropcurrentcount,p_assetpropeversoldcount,p_bankruptcystatus,p_confirmationsubjectfound,p_evictioncount,p_inquiryauto12month,p_inquirybanking12month,p_inquirycollections12month,p_inquiryshortterm12month,p_lienjudgmentcount,p_lienjudgmentsmallclaimscount,p_shorttermloanrequest,p_sourcenonderogcount,p_sourcenonderogcount06month,p_ssndeceased,p_subjectdeceased,p_subjectrecordtimeoldest) := FUNCTIONMACRO
  
  RPrep := RECORD
    infile;
    rvt2004_2_0.Append_RVT2004_2_0_ModelLayouts.Prepare;
    rvt2004_2_0.Append_RVT2004_2_0_ModelLayouts.Working;
  END;
  RPrep PrepareMe(infile le) := TRANSFORM
    SELF.L_ca_creditseeking_orig := map((real) le.p_inquiryshortterm12month = 1 and (real) le.p_inquiryauto12month = 1 => 6,(real) le.p_inquiryshortterm12month = 1 and (real) le.p_inquirybanking12month = 1 => 5,(real) le.p_inquiryshortterm12month = 1 => 4,(real) le.p_inquiryauto12month = 1 or (real) le.p_shorttermloanrequest > 0 => 3,(real) le.p_inquirybanking12month = 1 or (real) le.p_inquirycollections12month = 1 => 2,1);
    SELF.L_ca_creditseeking := map(SELF.L_ca_creditseeking_orig = 2 and (real) le.p_inquirybanking12month = 0 and (real) le.p_inquirycollections12month = 1 => 8,SELF.L_ca_creditseeking_orig = 3 and (real) le.p_inquiryauto12month = 0 and (real) le.p_shorttermloanrequest = 1 => 7,SELF.L_ca_creditseeking_orig);
    SELF.L_ca_derogseverityindex_orig := map((real) le.p_evictioncount > 1 or ((real) le.p_evictioncount = 1 and ((real) le.p_bankruptcystatus = 2 or (real) le.p_lienjudgmentsmallclaimscount > 0)) => 5,(real) le.p_evictioncount > 0 => 4,(real) le.p_lienjudgmentsmallclaimscount > 0 or (real) le.p_bankruptcystatus = 2 => 3,(real) le.p_lienjudgmentcount > 0 => 2,1);
    SELF.L_ca_derogseverityindex := map(SELF.L_ca_derogseverityindex_orig = 3 and (real) le.p_lienjudgmentsmallclaimscount = 0 and (real) le.p_bankruptcystatus = 2 => 8,SELF.L_ca_derogseverityindex_orig = 3 and (real) le.p_lienjudgmentsmallclaimscount > 0 and (real) le.p_bankruptcystatus <> 2 => 7,SELF.L_ca_derogseverityindex_orig = 5 and (real) le.p_evictioncount > 1 and (real) le.p_bankruptcystatus <> 2 and (real) le.p_lienjudgmentsmallclaimscount = 0 => 6,SELF.L_ca_derogseverityindex_orig);
    SELF.L_ca_nonderogindex := map((real) le.p_sourcenonderogcount06month > 2 => 7,(real) le.p_sourcenonderogcount > 4 and (real) le.p_sourcenonderogcount06month > 1 => 6,(real) le.p_sourcenonderogcount > 4 or ((real) le.p_sourcenonderogcount > 3 and (real) le.p_sourcenonderogcount06month = 2) => 5,(real) le.p_sourcenonderogcount > 3 or (real) le.p_sourcenonderogcount06month > 1 => 4,(real) le.p_sourcenonderogcount > 2 => 3,(real) le.p_sourcenonderogcount = 2 and (real) le.p_sourcenonderogcount06month = 1 => 2,1);
    SELF.L_ca_addrchangeindex := map((real) le.p_subjectrecordtimeoldest >= 0 and (real) le.p_subjectrecordtimeoldest <= 84 and (real) le.p_addronfilecount > 5 => 6,(real) le.p_subjectrecordtimeoldest >= 0 and (real) le.p_subjectrecordtimeoldest <= 84 and (real) le.p_addronfilecount > 4 => 5,(real) le.p_subjectrecordtimeoldest >= 0 and (real) le.p_subjectrecordtimeoldest <= 84 and (real) le.p_addronfilecount > 2 => 4,(real) le.p_subjectrecordtimeoldest >= 0 and (real) le.p_subjectrecordtimeoldest <= 84 and (real) le.p_addronfilecount > 1 => 3,(real) le.p_subjectrecordtimeoldest >= 0 and (real) le.p_subjectrecordtimeoldest <= 84 => 2,(real) le.p_addrchangecount60month > 4 => 6,(real) le.p_addrchangecount60month > 2 => 5,(real) le.p_addrchangecount60month > 1 => 4,(real) le.p_addrchangecount60month > 0 => 3,1);
    SELF.RVT2004_2_0_Alert := ((real) le.p_alertregulatorycondition = 3);
    SELF.RVT2004_2_0_No_Hit := ((real) le.p_confirmationsubjectfound = -998) or ((real) le.p_confirmationsubjectfound < 1);
    SELF.RVT2004_2_0_Deceased := ((real) le.p_ssndeceased = 1) or ((real) le.p_subjectdeceased = 1);
    SELF.RVT2004_2_0_ex := WHICH(SELF.RVT2004_2_0_Alert,SELF.RVT2004_2_0_No_Hit,SELF.RVT2004_2_0_Deceased);
    SELF.RVT2004_2_0_sc := IF ( SELF.RVT2004_2_0_ex = 0, 1, 0 );
    SELF := le;
  END;
  Prepared := PROJECT(infile,PrepareMe(LEFT));
  rres := RECORD
    infile;
    rvt2004_2_0.Append_RVT2004_2_0_ModelLayouts.Result;
  END;
  rres TrEx(Prepared le) := TRANSFORM
    SELF.RVT2004_2_0_Score := CHOOSE(le.RVT2004_2_0_ex,100,222,200);
    SELF.RVT2004_2_0_Reasons := CHOOSE( le.RVT2004_2_0_ex,[],[],[]);
    SELF := le;
  END;
// Transform to compute result
  rres tr1(Prepared le) := TRANSFORM
// Computations for components of score SCORECARD_model47

    UNSIGNED1 RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range := WHICH(((REAL)le.p_addrprevioustimeoldest) >= -998 AND ((REAL)le.p_addrprevioustimeoldest) <= -998,((REAL)le.p_addrprevioustimeoldest) >= -1 AND ((REAL)le.p_addrprevioustimeoldest) <= -1,((REAL)le.p_addrprevioustimeoldest) >= -999999999 AND ((REAL)le.p_addrprevioustimeoldest) <= 6,((REAL)le.p_addrprevioustimeoldest) >= 6 AND ((REAL)le.p_addrprevioustimeoldest) <= 12,((REAL)le.p_addrprevioustimeoldest) >= 12 AND ((REAL)le.p_addrprevioustimeoldest) <= 24,((REAL)le.p_addrprevioustimeoldest) >= 24 AND ((REAL)le.p_addrprevioustimeoldest) <= 72,((REAL)le.p_addrprevioustimeoldest) >= 72 AND ((REAL)le.p_addrprevioustimeoldest) <= 96,((REAL)le.p_addrprevioustimeoldest) >= 96 AND ((REAL)le.p_addrprevioustimeoldest) <= 156,((REAL)le.p_addrprevioustimeoldest) >= 156 AND ((REAL)le.p_addrprevioustimeoldest) <= 228,((REAL)le.p_addrprevioustimeoldest) >= 228 AND ((REAL)le.p_addrprevioustimeoldest) <= 288,((REAL)le.p_addrprevioustimeoldest) >= 288);
    REAL4 RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_score := CHOOSE(RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range,0.0,-0.28084870461577,0.491375089074481,0.321048883673525,0.180121585542426,0.151031197731993,0.114801189635962,-0.0288430799118979,-0.0640308901228473,-0.255266542810333,-0.45962051977284,0);
    REAL4 RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_contribution_best := CHOOSE(RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range,0.0 - 0.016988448,-0.28084870461577 - 0.016988448,0.491375089074481 - 0.016988448,0.321048883673525 - 0.016988448,0.180121585542426 - 0.016988448,0.151031197731993 - 0.016988448,0.114801189635962 - 0.016988448,-0.0288430799118979 - 0.016988448,-0.0640308901228473 - 0.016988448,-0.255266542810333 - 0.016988448,-0.45962051977284 - 0.016988448,0);
    STRING5 RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_reason := CHOOSE(RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_range,'','C13','C13','C13','C13','C13','C13','C13','C13','C13','C13','99999');

    UNSIGNED1 RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_range := WHICH(((REAL)le.p_assetpropeversoldcount) >= -998 AND ((REAL)le.p_assetpropeversoldcount) <= -998,((REAL)le.p_assetpropeversoldcount) >= -1 AND ((REAL)le.p_assetpropeversoldcount) <= -1,((REAL)le.p_assetpropeversoldcount) >= -999999999 AND ((REAL)le.p_assetpropeversoldcount) <= 0.5,((REAL)le.p_assetpropeversoldcount) >= 0.5 AND ((REAL)le.p_assetpropeversoldcount) <= 1.5,((REAL)le.p_assetpropeversoldcount) >= 1.5);
    REAL4 RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_score := CHOOSE(RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_range,0.0,0.0,0.338302614099309,-0.210498982583842,-0.538333965350616,0);
    REAL4 RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_contribution_best := CHOOSE(RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_range,0.0 - 0.256330125,0.0 - 0.256330125,0.338302614099309 - 0.256330125,-0.210498982583842 - 0.256330125,-0.538333965350616 - 0.256330125,0);
    STRING5 RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_reason := CHOOSE(RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_range,'','','A45','','','99999');

    UNSIGNED1 RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range := WHICH(((REAL)le.p_addrcurrentownershipindex) >= -998 AND ((REAL)le.p_addrcurrentownershipindex) <= -998,((REAL)le.p_addrcurrentownershipindex) >= -1 AND ((REAL)le.p_addrcurrentownershipindex) <= -1,((REAL)le.p_addrcurrentownershipindex) >= -999999999 AND ((REAL)le.p_addrcurrentownershipindex) <= 0.5,((REAL)le.p_addrcurrentownershipindex) >= 0.5 AND ((REAL)le.p_addrcurrentownershipindex) <= 2.5,((REAL)le.p_addrcurrentownershipindex) >= 2.5 AND ((REAL)le.p_addrcurrentownershipindex) <= 3.5,((REAL)le.p_addrcurrentownershipindex) >= 3.5);
    REAL4 RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_score := CHOOSE(RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range,0.0,0.0,0.369840206147756,0.153617815307213,-0.11136892139623,-0.482905249758621,0);
    REAL4 RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_contribution_best := CHOOSE(RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range,0.0 - 0.032557624,0.0 - 0.032557624,0.369840206147756 - 0.032557624,0.153617815307213 - 0.032557624,-0.11136892139623 - 0.032557624,-0.482905249758621 - 0.032557624,0);
    STRING5 RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_reason := CHOOSE(RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_range,'','A44','A44','A44','A44','A44','99999');

    UNSIGNED1 RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range := WHICH(le.L_ca_creditseeking >= -998 AND le.L_ca_creditseeking <= -998,le.L_ca_creditseeking >= -1 AND le.L_ca_creditseeking <= -1,le.L_ca_creditseeking >= -999999999 AND le.L_ca_creditseeking <= 1,le.L_ca_creditseeking >= 2 AND le.L_ca_creditseeking <= 2,le.L_ca_creditseeking >= 3 AND le.L_ca_creditseeking <= 3,le.L_ca_creditseeking >= 4 AND le.L_ca_creditseeking <= 4,le.L_ca_creditseeking >= 5 AND le.L_ca_creditseeking <= 5,le.L_ca_creditseeking >= 6 AND le.L_ca_creditseeking <= 6,le.L_ca_creditseeking >= 7 AND le.L_ca_creditseeking <= 7,le.L_ca_creditseeking >= 7);
    REAL4 RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_score := CHOOSE(RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range,0.0,0.0,-0.537997066263463,0.0548804249144252,0.190031718225198,0.650769565235421,1.00836443079308,1.18265340641186,0.190031718225198,0.0548804249144252,0);
    REAL4 RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_contribution_best := CHOOSE(RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range,0.0 - -0.188809907,0.0 - -0.188809907,-0.537997066263463 - -0.188809907,0.0548804249144252 - -0.188809907,0.190031718225198 - -0.188809907,0.650769565235421 - -0.188809907,1.00836443079308 - -0.188809907,1.18265340641186 - -0.188809907,0.190031718225198 - -0.188809907,0.0548804249144252 - -0.188809907,0);
    STRING5 RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_reason := CHOOSE(RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_range,'','I60','I60','I60','I60','I60','I60','I60','C21','I61','99999');

    UNSIGNED1 RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range := WHICH(le.L_ca_addrchangeindex >= -998 AND le.L_ca_addrchangeindex <= -998,le.L_ca_addrchangeindex >= -1 AND le.L_ca_addrchangeindex <= -1,le.L_ca_addrchangeindex >= -999999999 AND le.L_ca_addrchangeindex <= 2.5,le.L_ca_addrchangeindex >= 2.5 AND le.L_ca_addrchangeindex <= 4.5,le.L_ca_addrchangeindex >= 4.5 AND le.L_ca_addrchangeindex <= 5.5,le.L_ca_addrchangeindex >= 5.5);
    REAL4 RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_score := CHOOSE(RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range,0.0,0.0,-0.052677852519793,0.0093886967604785,0.0857939935789934,0.187917227284159,0);
    REAL4 RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_contribution_best := CHOOSE(RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range,0.0 - -0.005703807,0.0 - -0.005703807,-0.052677852519793 - -0.005703807,0.0093886967604785 - -0.005703807,0.0857939935789934 - -0.005703807,0.187917227284159 - -0.005703807,0);
    STRING5 RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_reason := CHOOSE(RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_range,'','C14','C14','C14','C14','C14','99999');

    UNSIGNED1 RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_range := WHICH(((REAL)le.p_assetpropcurrentcount) >= -998 AND ((REAL)le.p_assetpropcurrentcount) <= -998,((REAL)le.p_assetpropcurrentcount) >= -1 AND ((REAL)le.p_assetpropcurrentcount) <= -1,((REAL)le.p_assetpropcurrentcount) >= -999999999 AND ((REAL)le.p_assetpropcurrentcount) <= 0.5,((REAL)le.p_assetpropcurrentcount) >= 0.5 AND ((REAL)le.p_assetpropcurrentcount) <= 1.5,((REAL)le.p_assetpropcurrentcount) >= 1.5);
    REAL4 RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_score := CHOOSE(RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_range,0.0,0.0,0.343155403853238,-0.260918946043492,-0.33457231340859,0);
    REAL4 RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_contribution_best := CHOOSE(RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_range,0.0 - 0.149654754,0.0 - 0.149654754,0.343155403853238 - 0.149654754,-0.260918946043492 - 0.149654754,-0.33457231340859 - 0.149654754,0);
    STRING5 RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_reason := CHOOSE(RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_range,'','','A42','A42','A42','99999');

    UNSIGNED1 RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range := WHICH(le.L_ca_nonderogindex >= -998 AND le.L_ca_nonderogindex <= -998,le.L_ca_nonderogindex >= -1 AND le.L_ca_nonderogindex <= -1,le.L_ca_nonderogindex >= -999999999 AND le.L_ca_nonderogindex <= 2.5,le.L_ca_nonderogindex >= 2.5 AND le.L_ca_nonderogindex <= 3.5,le.L_ca_nonderogindex >= 3.5 AND le.L_ca_nonderogindex <= 4.5,le.L_ca_nonderogindex >= 4.5);
    REAL4 RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_score := CHOOSE(RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range,0.0,0.0,0.224638954157977,0.0534093514829876,-0.248370773172574,-0.453675193810595,0);
    REAL4 RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_contribution_best := CHOOSE(RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range,0.0 - 0.073420476,0.0 - 0.073420476,0.224638954157977 - 0.073420476,0.0534093514829876 - 0.073420476,-0.248370773172574 - 0.073420476,-0.453675193810595 - 0.073420476,0);
    STRING5 RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_reason := CHOOSE(RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_range,'','C12','C12','C12','C12','C12','99999');

    UNSIGNED1 RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range := WHICH(le.L_ca_derogseverityindex >= -998 AND le.L_ca_derogseverityindex <= -998,le.L_ca_derogseverityindex >= -1 AND le.L_ca_derogseverityindex <= -1,le.L_ca_derogseverityindex >= -999999999 AND le.L_ca_derogseverityindex <= 1,le.L_ca_derogseverityindex >= 2 AND le.L_ca_derogseverityindex <= 2,le.L_ca_derogseverityindex >= 3 AND le.L_ca_derogseverityindex <= 3,le.L_ca_derogseverityindex >= 4 AND le.L_ca_derogseverityindex <= 4,le.L_ca_derogseverityindex >= 5 AND le.L_ca_derogseverityindex <= 5,le.L_ca_derogseverityindex >= 6 AND le.L_ca_derogseverityindex <= 6,le.L_ca_derogseverityindex >= 7 AND le.L_ca_derogseverityindex <= 7,le.L_ca_derogseverityindex >= 7);
    REAL4 RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_score := CHOOSE(RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range,0.0,0.0,-0.413793157156462,-0.0314225344056521,0.400599180681259,0.683351662414589,0.958117552563772,0.958117552563772,0.400599180681259,0.400599180681259,0);
    REAL4 RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_contribution_best := CHOOSE(RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range,0.0 - -0.316279327,0.0 - -0.316279327,-0.413793157156462 - -0.316279327,-0.0314225344056521 - -0.316279327,0.400599180681259 - -0.316279327,0.683351662414589 - -0.316279327,0.958117552563772 - -0.316279327,0.958117552563772 - -0.316279327,0.400599180681259 - -0.316279327,0.400599180681259 - -0.316279327,0);
    STRING5 RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_reason := CHOOSE(RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_range,'','','','D34','D30','D33','D30','D33','D34','D31','99999');
// Now compute values for score SCORECARD_model47
    REAL RVT2004_2_0_SCORECARD_model47_Score0 := -1.58477952594377 + RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_Score + RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_Score + RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_Score + RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_Score + RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_Score + RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_Score + RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_Score + RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_Score;
    REAL RVT2004_2_0_SCORECARD_model47_Score1 := (700 + -40 * ((RVT2004_2_0_SCORECARD_model47_Score0 - 0 - LN(0.35685210312076)) / LN(2)));
    INTEGER2 RVT2004_2_0_SCORECARD_model47_Score := ROUND( MAP (  RVT2004_2_0_SCORECARD_model47_Score1 < 501 => 501, RVT2004_2_0_SCORECARD_model47_Score1 > 900 => 900,RVT2004_2_0_SCORECARD_model47_Score1));
    SELF.RVT2004_2_0_Score := RVT2004_2_0_SCORECARD_model47_Score;
    aggregateRCs := SORT(
      TABLE(
      DATASET([
        {RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_contribution_best,RVT2004_2_0_SCORECARD_model47_addrprevioustimeoldest_reason}
        ,{RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_contribution_best,RVT2004_2_0_SCORECARD_model47_assetpropeversoldcount_reason}
        ,{RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_contribution_best,RVT2004_2_0_SCORECARD_model47_addrcurrentownershipindex_reason}
        ,{RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_contribution_best,RVT2004_2_0_SCORECARD_model47_L_ca_creditseeking_reason}
        ,{RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_contribution_best,RVT2004_2_0_SCORECARD_model47_L_ca_addrchangeindex_reason}
        ,{RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_contribution_best,RVT2004_2_0_SCORECARD_model47_assetpropcurrentcount_reason}
        ,{RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_contribution_best,RVT2004_2_0_SCORECARD_model47_L_ca_nonderogindex_reason}
        ,{RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_contribution_best,RVT2004_2_0_SCORECARD_model47_L_ca_derogseverityindex_reason}
      ], rvt2004_2_0.ReasonType),
      {Reason_Code, Contribution_Sum := SUM(GROUP,Contribution)}, Reason_Code)
      (Reason_Code <> '', Contribution_Sum > 0 ), -Contribution_Sum, Reason_Code);
    topNRCs := CHOOSEN(aggregateRCs, 4);
    combineRCs := topNRCs & IF(~EXISTS(topNRCs(Reason_Code[1] = 'I')), aggregateRCs(Reason_Code[1] = 'I')[1]);
    SET OF STRING5 RVT2004_2_0_SCORECARD_model47_Reasons_best := SET(combineRCs(Reason_Code <> ''), Reason_Code);
    SET OF STRING5 RVT2004_2_0_SCORECARD_model47_Reasons := RVT2004_2_0_SCORECARD_model47_Reasons_Best;
    SELF.RVT2004_2_0_Reasons := RVT2004_2_0_SCORECARD_model47_Reasons;
    SELF := le;
  END;
  RETURN PROJECT(Prepared(RVT2004_2_0_ex > 0),TrEX(LEFT))+PROJECT( Prepared(RVT2004_2_0_sc = 1),Tr1(LEFT));
ENDMACRO;
