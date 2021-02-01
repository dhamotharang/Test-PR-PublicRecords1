EXPORT Append_RVA2008_1_0_Debug( infile,do_model=true,p_addrchangecount03month,p_addrinputmatchindex,p_addrinputsubjectowned,p_addrprevioustimeoldest,p_assetpropevercount,p_confirmationinputaddress,p_confirmationsubjectfound,p_criminalfelonycount,p_derogtimenewest,p_evictioncount,p_inquiryauto12month,p_inquirybanking12month,p_inquiryshortterm12month,p_lienjudgmenttaxcount,p_sourcecredheadertimeoldest,p_ssndeceased,p_ssnsubjectcount,p_subjectdeceased) := FUNCTIONMACRO
  
  RPrep := RECORD
    infile;
    rva2008_1_0.Append_RVA2008_1_0_ModelLayouts.Prepare;
    rva2008_1_0.Append_RVA2008_1_0_ModelLayouts.Working;
  END;
  RPrep PrepareMe(infile le) := TRANSFORM
    SELF.RVA2008_1_0_Deceased := ((REAL) le.p_ssndeceased = 1) or ((REAL) le.p_subjectdeceased = 1);
    SELF.RVA2008_1_0_No_Hit := (REAL) le.p_confirmationsubjectfound < 1;
    SELF.RVA2008_1_0_ex := WHICH(SELF.RVA2008_1_0_Deceased,SELF.RVA2008_1_0_No_Hit);
    SELF.RVA2008_1_0_sc := IF ( SELF.RVA2008_1_0_ex = 0, 1, 0 );
    SELF := le;
  END;
  Prepared := PROJECT(infile,PrepareMe(LEFT));
  rres := RECORD
    infile;
    rva2008_1_0.Append_RVA2008_1_0_ModelLayouts.Result;
    rva2008_1_0.Append_RVA2008_1_0_ModelLayouts.Prepare;
    rva2008_1_0.Append_RVA2008_1_0_ModelLayouts.Debug;
  END;
  rres TrEx(Prepared le) := TRANSFORM
    SELF.RVA2008_1_0_Score := CHOOSE(le.RVA2008_1_0_ex,200,222);
    SELF.RVA2008_1_0_Reasons := CHOOSE( le.RVA2008_1_0_ex,[],[]);
    SELF := le;
  END;
// Transform to compute result
  rres tr1(Prepared le) := TRANSFORM
// Computations for components of score SCORECARD_model29

    SELF.RVA2008_1_0_SCORECARD_model29_addrchangecount03month_range := WHICH(((REAL)le.p_addrchangecount03month) >= -998 AND ((REAL)le.p_addrchangecount03month) <= -998,((REAL)le.p_addrchangecount03month) >= -1 AND ((REAL)le.p_addrchangecount03month) <= -1,((REAL)le.p_addrchangecount03month) >= -999999999 AND ((REAL)le.p_addrchangecount03month) <= 0.5,((REAL)le.p_addrchangecount03month) >= 0.5);
    SELF.RVA2008_1_0_SCORECARD_model29_addrchangecount03month_score := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_addrchangecount03month_range,0.0,0.0,-0.127115841774383,0.127087652224877,0);
    SELF.RVA2008_1_0_SCORECARD_model29_addrchangecount03month_contribution_best := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_addrchangecount03month_range,0.0 - -0.127115841774383,0.0 - -0.127115841774383,-0.127115841774383 - -0.127115841774383,0.127087652224877 - -0.127115841774383,0);
    SELF.RVA2008_1_0_SCORECARD_model29_addrchangecount03month_reason := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_addrchangecount03month_range,'','C12','','C14','99999');

    SELF.RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range := WHICH(((REAL)le.p_addrprevioustimeoldest) >= -998 AND ((REAL)le.p_addrprevioustimeoldest) <= -998,((REAL)le.p_addrprevioustimeoldest) >= -1 AND ((REAL)le.p_addrprevioustimeoldest) <= -1,((REAL)le.p_addrprevioustimeoldest) >= -999999999 AND ((REAL)le.p_addrprevioustimeoldest) <= 7.5,((REAL)le.p_addrprevioustimeoldest) >= 7.5 AND ((REAL)le.p_addrprevioustimeoldest) <= 86.5,((REAL)le.p_addrprevioustimeoldest) >= 86.5 AND ((REAL)le.p_addrprevioustimeoldest) <= 115.5,((REAL)le.p_addrprevioustimeoldest) >= 115.5 AND ((REAL)le.p_addrprevioustimeoldest) <= 176.5,((REAL)le.p_addrprevioustimeoldest) >= 176.5);
    SELF.RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_score := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range,0.0,0.391107019035651,0.174250955427562,0.0490651499357637,0.0208498257296678,-0.0818484746821617,-0.129379355322629,0);
    SELF.RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_contribution_best := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range,0.0 - -0.129379355322629,0.391107019035651 - -0.129379355322629,0.174250955427562 - -0.129379355322629,0.0490651499357637 - -0.129379355322629,0.0208498257296678 - -0.129379355322629,-0.0818484746821617 - -0.129379355322629,-0.129379355322629 - -0.129379355322629,0);
    SELF.RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_reason := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_range,'','C12','C13','C13','C13','C13','','99999');

    SELF.RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_range := WHICH(((REAL)le.p_addrinputsubjectowned) >= -998 AND ((REAL)le.p_addrinputsubjectowned) <= -998,((REAL)le.p_addrinputsubjectowned) >= -1 AND ((REAL)le.p_addrinputsubjectowned) <= -1,((REAL)le.p_addrinputsubjectowned) >= -999999999 AND ((REAL)le.p_addrinputsubjectowned) <= 0.5,((REAL)le.p_addrinputsubjectowned) >= 0.5);
    SELF.RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_score := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_range,0.0,-0.0561726022157193,0.0930516666000292,-0.0918809204789587,0);
    SELF.RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_contribution_best := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_range,0.0 - -0.0918809204789587,-0.0561726022157193 - -0.0918809204789587,0.0930516666000292 - -0.0918809204789587,-0.0918809204789587 - -0.0918809204789587,0);
    SELF.RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_reason := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_range,'','A44','A44','','99999');

    SELF.RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_range := WHICH(((REAL)le.p_addrinputmatchindex) >= -998 AND ((REAL)le.p_addrinputmatchindex) <= -998,((REAL)le.p_addrinputmatchindex) >= -1 AND ((REAL)le.p_addrinputmatchindex) <= -1,((REAL)le.p_addrinputmatchindex) >= -999999999 AND ((REAL)le.p_addrinputmatchindex) <= 0.5,((REAL)le.p_addrinputmatchindex) >= 0.5);
    SELF.RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_score := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_range,0.0,0.0,0.100955889904955,-0.100830449123503,0);
    SELF.RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_contribution_best := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_range,0.0 - -0.100830449123503,0.0 - -0.100830449123503,0.100955889904955 - -0.100830449123503,-0.100830449123503 - -0.100830449123503,0);
    SELF.RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_reason := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_range,'','C12','F01','','99999');

    SELF.RVA2008_1_0_SCORECARD_model29_evictioncount_range := WHICH(((REAL)le.p_evictioncount) >= -998 AND ((REAL)le.p_evictioncount) <= -998,((REAL)le.p_evictioncount) >= -1 AND ((REAL)le.p_evictioncount) <= -1,((REAL)le.p_evictioncount) >= -999999999 AND ((REAL)le.p_evictioncount) <= 1,((REAL)le.p_evictioncount) >= 1);
    SELF.RVA2008_1_0_SCORECARD_model29_evictioncount_score := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_evictioncount_range,0.0,0.0,-0.178020801968896,0.178078662403005,0);
    SELF.RVA2008_1_0_SCORECARD_model29_evictioncount_contribution_best := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_evictioncount_range,0.0 - -0.178020801968896,0.0 - -0.178020801968896,-0.178020801968896 - -0.178020801968896,0.178078662403005 - -0.178020801968896,0);
    SELF.RVA2008_1_0_SCORECARD_model29_evictioncount_reason := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_evictioncount_range,'','C12','','D33','99999');

    SELF.RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_range := WHICH(((REAL)le.p_confirmationinputaddress) >= -998 AND ((REAL)le.p_confirmationinputaddress) <= -998,((REAL)le.p_confirmationinputaddress) >= -1 AND ((REAL)le.p_confirmationinputaddress) <= -1,((REAL)le.p_confirmationinputaddress) >= -999999999 AND ((REAL)le.p_confirmationinputaddress) <= 0.5,((REAL)le.p_confirmationinputaddress) >= 0.5);
    SELF.RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_score := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_range,0.0,0.0,0.111181517096239,-0.111168165234986,0);
    SELF.RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_contribution_best := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_range,0.0 - -0.111168165234986,0.0 - -0.111168165234986,0.111181517096239 - -0.111168165234986,-0.111168165234986 - -0.111168165234986,0);
    SELF.RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_reason := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_range,'','C12','F01','','99999');

    SELF.RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_range := WHICH(((REAL)le.p_lienjudgmenttaxcount) >= -998 AND ((REAL)le.p_lienjudgmenttaxcount) <= -998,((REAL)le.p_lienjudgmenttaxcount) >= -1 AND ((REAL)le.p_lienjudgmenttaxcount) <= -1,((REAL)le.p_lienjudgmenttaxcount) >= -999999999 AND ((REAL)le.p_lienjudgmenttaxcount) <= 0.5,((REAL)le.p_lienjudgmenttaxcount) >= 0.5);
    SELF.RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_score := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_range,0.0,0.0,-0.126193151814627,0.126122335670169,0);
    SELF.RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_contribution_best := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_range,0.0 - -0.126193151814627,0.0 - -0.126193151814627,-0.126193151814627 - -0.126193151814627,0.126122335670169 - -0.126193151814627,0);
    SELF.RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_reason := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_range,'','C12','D34','D34','99999');

    SELF.RVA2008_1_0_SCORECARD_model29_assetpropevercount_range := WHICH(((REAL)le.p_assetpropevercount) >= -998 AND ((REAL)le.p_assetpropevercount) <= -998,((REAL)le.p_assetpropevercount) >= -1 AND ((REAL)le.p_assetpropevercount) <= -1,((REAL)le.p_assetpropevercount) >= -999999999 AND ((REAL)le.p_assetpropevercount) <= 1.5,((REAL)le.p_assetpropevercount) >= 1.5);
    SELF.RVA2008_1_0_SCORECARD_model29_assetpropevercount_score := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_assetpropevercount_range,0.0,0.0,0.109908656388069,-0.109846840713539,0);
    SELF.RVA2008_1_0_SCORECARD_model29_assetpropevercount_contribution_best := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_assetpropevercount_range,0.0 - -0.109846840713539,0.0 - -0.109846840713539,0.109908656388069 - -0.109846840713539,-0.109846840713539 - -0.109846840713539,0);
    SELF.RVA2008_1_0_SCORECARD_model29_assetpropevercount_reason := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_assetpropevercount_range,'','C12','A45','','99999');

    SELF.RVA2008_1_0_SCORECARD_model29_inquirybanking12month_range := WHICH(((REAL)le.p_inquirybanking12month) >= -998 AND ((REAL)le.p_inquirybanking12month) <= -998,((REAL)le.p_inquirybanking12month) >= -1 AND ((REAL)le.p_inquirybanking12month) <= -1,((REAL)le.p_inquirybanking12month) >= -999999999 AND ((REAL)le.p_inquirybanking12month) <= 0.5,((REAL)le.p_inquirybanking12month) >= 0.5);
    SELF.RVA2008_1_0_SCORECARD_model29_inquirybanking12month_score := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_inquirybanking12month_range,0.0,0.0,-0.0447006009247188,0.0446544639356558,0);
    SELF.RVA2008_1_0_SCORECARD_model29_inquirybanking12month_contribution_best := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_inquirybanking12month_range,0.0 - -0.0447006009247188,0.0 - -0.0447006009247188,-0.0447006009247188 - -0.0447006009247188,0.0446544639356558 - -0.0447006009247188,0);
    SELF.RVA2008_1_0_SCORECARD_model29_inquirybanking12month_reason := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_inquirybanking12month_range,'','C12','','I60','99999');

    SELF.RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_range := WHICH(((REAL)le.p_ssnsubjectcount) >= -998 AND ((REAL)le.p_ssnsubjectcount) <= -998,((REAL)le.p_ssnsubjectcount) >= -1 AND ((REAL)le.p_ssnsubjectcount) <= -1,((REAL)le.p_ssnsubjectcount) >= -999999999 AND ((REAL)le.p_ssnsubjectcount) <= 0,((REAL)le.p_ssnsubjectcount) >= 0 AND ((REAL)le.p_ssnsubjectcount) <= 1,((REAL)le.p_ssnsubjectcount) >= 1);
    SELF.RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_score := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_range,0.0,0.0,0.450938368246577,-0.237420388277113,0.081589076071594,0);
    SELF.RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_contribution_best := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_range,0.0 - -0.237420388277113,0.0 - -0.237420388277113,0.450938368246577 - -0.237420388277113,-0.237420388277113 - -0.237420388277113,0.081589076071594 - -0.237420388277113,0);
    SELF.RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_reason := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_range,'','C12','F00','','S65','99999');

    SELF.RVA2008_1_0_SCORECARD_model29_criminalfelonycount_range := WHICH(((REAL)le.p_criminalfelonycount) >= -998 AND ((REAL)le.p_criminalfelonycount) <= -998,((REAL)le.p_criminalfelonycount) >= -1 AND ((REAL)le.p_criminalfelonycount) <= -1,((REAL)le.p_criminalfelonycount) >= -999999999 AND ((REAL)le.p_criminalfelonycount) <= 0,((REAL)le.p_criminalfelonycount) >= 0);
    SELF.RVA2008_1_0_SCORECARD_model29_criminalfelonycount_score := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_criminalfelonycount_range,0.0,0.0,-0.0856869472262584,0.0856212019772778,0);
    SELF.RVA2008_1_0_SCORECARD_model29_criminalfelonycount_contribution_best := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_criminalfelonycount_range,0.0 - -0.0856869472262584,0.0 - -0.0856869472262584,-0.0856869472262584 - -0.0856869472262584,0.0856212019772778 - -0.0856869472262584,0);
    SELF.RVA2008_1_0_SCORECARD_model29_criminalfelonycount_reason := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_criminalfelonycount_range,'','C12','','D32','99999');

    SELF.RVA2008_1_0_SCORECARD_model29_inquiryauto12month_range := WHICH(((REAL)le.p_inquiryauto12month) >= -998 AND ((REAL)le.p_inquiryauto12month) <= -998,((REAL)le.p_inquiryauto12month) >= -1 AND ((REAL)le.p_inquiryauto12month) <= -1,((REAL)le.p_inquiryauto12month) >= -999999999 AND ((REAL)le.p_inquiryauto12month) <= 0.5,((REAL)le.p_inquiryauto12month) >= 0.5);
    SELF.RVA2008_1_0_SCORECARD_model29_inquiryauto12month_score := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_inquiryauto12month_range,0.0,0.0,-0.106930143606789,0.106868749343492,0);
    SELF.RVA2008_1_0_SCORECARD_model29_inquiryauto12month_contribution_best := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_inquiryauto12month_range,0.0 - -0.106930143606789,0.0 - -0.106930143606789,-0.106930143606789 - -0.106930143606789,0.106868749343492 - -0.106930143606789,0);
    SELF.RVA2008_1_0_SCORECARD_model29_inquiryauto12month_reason := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_inquiryauto12month_range,'','C12','','I60','99999');

    SELF.RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_range := WHICH(((REAL)le.p_inquiryshortterm12month) >= -998 AND ((REAL)le.p_inquiryshortterm12month) <= -998,((REAL)le.p_inquiryshortterm12month) >= -1 AND ((REAL)le.p_inquiryshortterm12month) <= -1,((REAL)le.p_inquiryshortterm12month) >= -999999999 AND ((REAL)le.p_inquiryshortterm12month) <= 0.5,((REAL)le.p_inquiryshortterm12month) >= 0.5);
    SELF.RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_score := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_range,0.0,0.0,-0.145587984044509,0.145539677615496,0);
    SELF.RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_contribution_best := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_range,0.0 - -0.145587984044509,0.0 - -0.145587984044509,-0.145587984044509 - -0.145587984044509,0.145539677615496 - -0.145587984044509,0);
    SELF.RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_reason := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_range,'','C12','','I60','99999');

    SELF.RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range := WHICH(((REAL)le.p_sourcecredheadertimeoldest) >= -998 AND ((REAL)le.p_sourcecredheadertimeoldest) <= -998,((REAL)le.p_sourcecredheadertimeoldest) >= -1 AND ((REAL)le.p_sourcecredheadertimeoldest) <= -1,((REAL)le.p_sourcecredheadertimeoldest) >= -999999999 AND ((REAL)le.p_sourcecredheadertimeoldest) <= 135.5,((REAL)le.p_sourcecredheadertimeoldest) >= 135.5 AND ((REAL)le.p_sourcecredheadertimeoldest) <= 164.5,((REAL)le.p_sourcecredheadertimeoldest) >= 164.5 AND ((REAL)le.p_sourcecredheadertimeoldest) <= 264.5,((REAL)le.p_sourcecredheadertimeoldest) >= 264.5 AND ((REAL)le.p_sourcecredheadertimeoldest) <= 339.5,((REAL)le.p_sourcecredheadertimeoldest) >= 339.5 AND ((REAL)le.p_sourcecredheadertimeoldest) <= 370.5,((REAL)le.p_sourcecredheadertimeoldest) >= 370.5);
    SELF.RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_score := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range,0.0,0.0,0.215747425264362,0.138849500320951,0.0133221520435431,-0.0412690302862565,-0.100717876711618,-0.231932845723712,0);
    SELF.RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_contribution_best := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range,0.0 - -0.231932845723712,0.0 - -0.231932845723712,0.215747425264362 - -0.231932845723712,0.138849500320951 - -0.231932845723712,0.0133221520435431 - -0.231932845723712,-0.0412690302862565 - -0.231932845723712,-0.100717876711618 - -0.231932845723712,-0.231932845723712 - -0.231932845723712,0);
    SELF.RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_reason := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_range,'','C12','C20','C20','C20','C20','C20','','99999');

    SELF.RVA2008_1_0_SCORECARD_model29_derogtimenewest_range := WHICH(((REAL)le.p_derogtimenewest) >= -998 AND ((REAL)le.p_derogtimenewest) <= -998,((REAL)le.p_derogtimenewest) >= -1 AND ((REAL)le.p_derogtimenewest) <= -1,((REAL)le.p_derogtimenewest) >= -999999999 AND ((REAL)le.p_derogtimenewest) <= 3.5,((REAL)le.p_derogtimenewest) >= 3.5 AND ((REAL)le.p_derogtimenewest) <= 15.5,((REAL)le.p_derogtimenewest) >= 15.5 AND ((REAL)le.p_derogtimenewest) <= 41.5,((REAL)le.p_derogtimenewest) >= 41.5);
    SELF.RVA2008_1_0_SCORECARD_model29_derogtimenewest_score := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_derogtimenewest_range,0.0,-0.0745719346721392,0.221141705304125,0.131207044522461,-0.00251770794789452,-0.0139670805571985,0);
    SELF.RVA2008_1_0_SCORECARD_model29_derogtimenewest_contribution_best := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_derogtimenewest_range,0.0 - -0.0745719346721392,-0.0745719346721392 - -0.0745719346721392,0.221141705304125 - -0.0745719346721392,0.131207044522461 - -0.0745719346721392,-0.00251770794789452 - -0.0745719346721392,-0.0139670805571985 - -0.0745719346721392,0);
    SELF.RVA2008_1_0_SCORECARD_model29_derogtimenewest_reason := CHOOSE(SELF.RVA2008_1_0_SCORECARD_model29_derogtimenewest_range,'','','D30','D30','D30','D30','99999');
// Now compute values for score SCORECARD_model29
    SELF.RVA2008_1_0_SCORECARD_model29_Score0 := -1.15797592599641 + SELF.RVA2008_1_0_SCORECARD_model29_addrchangecount03month_Score + SELF.RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_Score + SELF.RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_Score + SELF.RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_Score + SELF.RVA2008_1_0_SCORECARD_model29_evictioncount_Score + SELF.RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_Score + SELF.RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_Score + SELF.RVA2008_1_0_SCORECARD_model29_assetpropevercount_Score + SELF.RVA2008_1_0_SCORECARD_model29_inquirybanking12month_Score + SELF.RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_Score + SELF.RVA2008_1_0_SCORECARD_model29_criminalfelonycount_Score + SELF.RVA2008_1_0_SCORECARD_model29_inquiryauto12month_Score + SELF.RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_Score + SELF.RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_Score + SELF.RVA2008_1_0_SCORECARD_model29_derogtimenewest_Score;
    SELF.RVA2008_1_0_SCORECARD_model29_Score1 := (725 + -50 * ((SELF.RVA2008_1_0_SCORECARD_model29_Score0 - 0 - LN(0.157809362992116)) / LN(2)));
    SELF.RVA2008_1_0_SCORECARD_model29_Score := ROUND( MAP (  SELF.RVA2008_1_0_SCORECARD_model29_Score1 < 501 => 501, SELF.RVA2008_1_0_SCORECARD_model29_Score1 > 900 => 900,SELF.RVA2008_1_0_SCORECARD_model29_Score1));
    SELF.RVA2008_1_0_Score := SELF.RVA2008_1_0_SCORECARD_model29_Score;
    aggregateRCs := SORT(
      TABLE(
      DATASET([
        {SELF.RVA2008_1_0_SCORECARD_model29_addrchangecount03month_contribution_best,SELF.RVA2008_1_0_SCORECARD_model29_addrchangecount03month_reason}
        ,{SELF.RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_contribution_best,SELF.RVA2008_1_0_SCORECARD_model29_addrprevioustimeoldest_reason}
        ,{SELF.RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_contribution_best,SELF.RVA2008_1_0_SCORECARD_model29_addrinputsubjectowned_reason}
        ,{SELF.RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_contribution_best,SELF.RVA2008_1_0_SCORECARD_model29_addrinputmatchindex_reason}
        ,{SELF.RVA2008_1_0_SCORECARD_model29_evictioncount_contribution_best,SELF.RVA2008_1_0_SCORECARD_model29_evictioncount_reason}
        ,{SELF.RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_contribution_best,SELF.RVA2008_1_0_SCORECARD_model29_confirmationinputaddress_reason}
        ,{SELF.RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_contribution_best,SELF.RVA2008_1_0_SCORECARD_model29_lienjudgmenttaxcount_reason}
        ,{SELF.RVA2008_1_0_SCORECARD_model29_assetpropevercount_contribution_best,SELF.RVA2008_1_0_SCORECARD_model29_assetpropevercount_reason}
        ,{SELF.RVA2008_1_0_SCORECARD_model29_inquirybanking12month_contribution_best,SELF.RVA2008_1_0_SCORECARD_model29_inquirybanking12month_reason}
        ,{SELF.RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_contribution_best,SELF.RVA2008_1_0_SCORECARD_model29_ssnsubjectcount_reason}
        ,{SELF.RVA2008_1_0_SCORECARD_model29_criminalfelonycount_contribution_best,SELF.RVA2008_1_0_SCORECARD_model29_criminalfelonycount_reason}
        ,{SELF.RVA2008_1_0_SCORECARD_model29_inquiryauto12month_contribution_best,SELF.RVA2008_1_0_SCORECARD_model29_inquiryauto12month_reason}
        ,{SELF.RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_contribution_best,SELF.RVA2008_1_0_SCORECARD_model29_inquiryshortterm12month_reason}
        ,{SELF.RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_contribution_best,SELF.RVA2008_1_0_SCORECARD_model29_sourcecredheadertimeoldest_reason}
        ,{SELF.RVA2008_1_0_SCORECARD_model29_derogtimenewest_contribution_best,SELF.RVA2008_1_0_SCORECARD_model29_derogtimenewest_reason}
      ], rva2008_1_0.ReasonType),
      {Reason_Code, Contribution_Sum := SUM(GROUP,Contribution)}, Reason_Code)
      (Reason_Code <> '', Contribution_Sum <> 0 ), -Contribution_Sum, Reason_Code);
    topNRCs := CHOOSEN(aggregateRCs, 4);
    combineRCs := topNRCs & IF(~EXISTS(topNRCs(Reason_Code[1] = 'I')), aggregateRCs(Reason_Code[1] = 'I')[1]);
    SET OF STRING5 RVA2008_1_0_SCORECARD_model29_Reasons_best := SET(combineRCs(Reason_Code <> ''), Reason_Code);
    SELF.RVA2008_1_0_SCORECARD_model29_Reasons := RVA2008_1_0_SCORECARD_model29_Reasons_Best;
    SELF.RVA2008_1_0_Reasons := SELF.RVA2008_1_0_SCORECARD_model29_Reasons;
    SELF := le;
  END;
  RETURN PROJECT(Prepared(RVA2008_1_0_ex > 0),TrEX(LEFT))+PROJECT( Prepared(RVA2008_1_0_sc = 1),Tr1(LEFT));
ENDMACRO;
