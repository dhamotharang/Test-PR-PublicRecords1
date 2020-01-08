IMPORT ProfileBooster.ProfileBoosterV2_KEL, ProfileBooster, STD, Risk_Indicators;
IMPORT KEL11 AS KEL;

EXPORT getProfileBooster11Attrs(DATASET(ProfileBooster.Layouts.Layout_PB_BatchOutFlat) PB1Result, 
																STRING8 histDate = (STRING8)STD.Date.Today(), 
																INTEGER Score_threshold = 80,
																INTEGER GLBA = 1,
																INTEGER DPPA = 3,
																STRING  DataRestrictionMask	= '00000000000000000000000000000000000000000000000000',
																STRING  DataPermissionMask	= '11111111111111111111111111111111111111111111111111'
																
																) := FUNCTION
	
	PP1 := PROJECT(PB1Result, TRANSFORM(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Input_Layout, 
		SELF.historydate := histDate;
		SELF.lexid := (STRING)LEFT.lexid;
		SELF.Account := LEFT.acctno;
		SELF := LEFT;
		SELF := [];
		));	
	PP := DISTRIBUTE(PP1, RANDOM());

	myCFG := MODULE(ProfileBooster.ProfileBoosterV2_KEL.CFG_Compile)
	END;

	Options := MODULE(ProfileBooster.ProfileBoosterV2_KEL.Interface_Options)
		EXPORT STRING AttributeSetName := 'Development KEL Attributes';
		EXPORT STRING VersionName := 'Version 1.0';
		EXPORT BOOLEAN isFCRA := FALSE;
		EXPORT STRING ArchiveDate := histDate;
		EXPORT STRING InputFileName := '';
		EXPORT STRING Data_Restriction_Mask := DataRestrictionMask;
		EXPORT STRING Data_Permission_Mask := DataPermissionMask;
		EXPORT UNSIGNED GLBAPurpose := GLBA;
		EXPORT UNSIGNED DPPAPurpose := DPPA;
		EXPORT INTEGER ScoreThreshold := Score_threshold;
		EXPORT BOOLEAN OutputMasterResults := FALSE;
		EXPORT BOOLEAN isMarketing := TRUE; // When TRUE enables Marketing Restrictions
	END;

	PB11Result:= ProfileBooster.ProfileBoosterV2_KEL.FnThor_GetAttrsV11(PP, Options);
	// OUTPUT(CHOOSEN(PB11Result,1000),named('PB11_Sample1'));
	
	MergedLayout := RECORD
		RECORDOF(PB1Result);
		ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Layouts.LayoutPersonPB11 -LexID -G_ProcUID;// -P_InpAcct;
	END;
	
	MergedLayout xFormFinal(PB1Result L, PB11Result R) := TRANSFORM
		SELF := L;
		SELF := R;
		SELF := [];
	END;
	MergedResult := JOIN(PB1Result, PB11Result,
											LEFT.AcctNo = RIGHT.P_InpAcct,
											// LEFT.LexID = RIGHT.LexID,
											xFormFinal(LEFT,RIGHT),
											LEFT OUTER, KEEP(1), ATMOST(100));
											
  FinalLayout := RECORD
		MergedLayout -P_InpAcct;
	END;
	
	PreFinalResult := PROJECT(MergedResult, FinalLayout);
	
	FinalLayout PB11_xfm1(PreFinalResult l) := TRANSFORM
		Modification1 := l.v1_VerifiedProspectFound = '1' and l.PurchCntEv = -99999;
		SELF.PurchCntEv := IF(Modification1,0,l.PurchCntEv);
		SELF.PurchItemCntEv := IF(Modification1,0,l.PurchItemCntEv);
		SELF.PurchOldMsnc := IF(Modification1,-99998,l.PurchOldMsnc);
		SELF.PurchNewMsnc := IF(Modification1,-99998,l.PurchNewMsnc);
		SELF.PurchTotEv := IF(Modification1,-99998,l.PurchTotEv);
		SELF.PurchAmtAvg := IF(Modification1,-99998,l.PurchAmtAvg);
		SELF.PurchNewAmt := IF(Modification1,-99998,l.PurchNewAmt);
		SELF.AstVehAutoCntEv := IF(Modification1,0,l.AstVehAutoCntEv);
		SELF.AstVehAutoCarCntEv := IF(Modification1,0,l.AstVehAutoCarCntEv);
		SELF.AstVehAutoSUVCntEv := IF(Modification1,0,l.AstVehAutoSUVCntEv);
		SELF.AstVehAutoTruckCntEv := IF(Modification1,0,l.AstVehAutoTruckCntEv);
		SELF.AstVehAutoVanCntEv := IF(Modification1,0,l.AstVehAutoVanCntEv);
		SELF.AstVehAutoNewTypeIndx := IF(Modification1,-99998,l.AstVehAutoNewTypeIndx);
		SELF.AstVehAutoExpCntEv := IF(Modification1,0,l.AstVehAutoExpCntEv);
		SELF.AstVehAutoEliteCntEv := IF(Modification1,0,l.AstVehAutoEliteCntEv);
		SELF.AstVehAutoLuxuryCntEv := IF(Modification1,0,l.AstVehAutoLuxuryCntEv);
		SELF.AstVehAutoOrigOwnCntEv := IF(Modification1,0,l.AstVehAutoOrigOwnCntEv);
		SELF.AstVehAutoMakeCntEv := IF(Modification1,0,l.AstVehAutoMakeCntEv);
		SELF.AstVehAutoFreqMake := IF(Modification1,'-99998',l.AstVehAutoFreqMake);
		SELF.AstVehAutoFreqMakeCntEv := IF(Modification1,0,l.AstVehAutoFreqMakeCntEv);
		SELF.AstVehAuto2ndFreqMake := IF(Modification1,'-99998',l.AstVehAuto2ndFreqMake);
		SELF.AstVehAuto2ndFreqMakeCntEv := IF(Modification1,0,l.AstVehAuto2ndFreqMakeCntEv);
		SELF.AstVehAutoEmrgPriceAvg := IF(Modification1,-99998,l.AstVehAutoEmrgPriceAvg);
		SELF.AstVehAutoEmrgPriceMax := IF(Modification1,-99998,l.AstVehAutoEmrgPriceMax);
		SELF.AstVehAutoEmrgPriceMin := IF(Modification1,-99998,l.AstVehAutoEmrgPriceMin);
		SELF.AstVehAutoNewPrice := IF(Modification1,-99998,l.AstVehAutoNewPrice);
		SELF.AstVehAutoEmrgPriceDiff := IF(Modification1,-99998,l.AstVehAutoEmrgPriceDiff);
		SELF.AstVehAutoLastAgeAvg := IF(Modification1,-99998,l.AstVehAutoLastAgeAvg);
		SELF.AstVehAutoLastAgeMax := IF(Modification1,-99998,l.AstVehAutoLastAgeMax);
		SELF.AstVehAutoLastAgeMin := IF(Modification1,-99998,l.AstVehAutoLastAgeMin);
		SELF.AstVehAutoEmrgAgeAvg := IF(Modification1,-99998,l.AstVehAutoEmrgAgeAvg);
		SELF.AstVehAutoEmrgAgeMax := IF(Modification1,-99998,l.AstVehAutoEmrgAgeMax);
		SELF.AstVehAutoEmrgAgeMin := IF(Modification1,-99998,l.AstVehAutoEmrgAgeMin);
		SELF.AstVehAutoEmrgSpanAvg := IF(Modification1,-99998,l.AstVehAutoEmrgSpanAvg);
		SELF.AstVehAutoNewMsnc := IF(Modification1,-99998,l.AstVehAutoNewMsnc);
		SELF.AstVehAutoTimeOwnSpanAvg := IF(Modification1,-99998,l.AstVehAutoTimeOwnSpanAvg);
		SELF.AstVehOtherCntEv := IF(Modification1,0,l.AstVehOtherCntEv);
		SELF.AstVehOtherATVCntEv := IF(Modification1,0,l.AstVehOtherATVCntEv);
		SELF.AstVehOtherCamperCntEv := IF(Modification1,0,l.AstVehOtherCamperCntEv);
		SELF.AstVehOtherCommCntEv := IF(Modification1,0,l.AstVehOtherCommCntEv);
		SELF.AstVehOtherMtrCntEv := IF(Modification1,0,l.AstVehOtherMtrCntEv);
		SELF.AstVehOtherScooterCntEv := IF(Modification1,0,l.AstVehOtherScooterCntEv);
		SELF.AstVehOtherNewTypeIndx := IF(Modification1,-99998,l.AstVehOtherNewTypeIndx);
		SELF.AstVehOtherOrigOwnCntEv := IF(Modification1,0,l.AstVehOtherOrigOwnCntEv);
		SELF.AstVehOtherNewMsnc := IF(Modification1,-99998,l.AstVehOtherNewMsnc);
		SELF.AstVehOtherPriceAvg := IF(Modification1,-99998,l.AstVehOtherPriceAvg);
		SELF.AstVehOtherPriceMax := IF(Modification1,-99998,l.AstVehOtherPriceMax);
		SELF.AstVehOtherPriceMin := IF(Modification1,-99998,l.AstVehOtherPriceMin);
		SELF.AstVehOtherNewPrice := IF(Modification1,-99998,l.AstVehOtherNewPrice);

		SELF := l;
		SELF := [];
	END;	
	Xfm1Result := PROJECT(PreFinalResult, PB11_xfm1(LEFT));	
	
	FinalLayout PB11_xfm2(Xfm1Result l) := TRANSFORM
		Modification2 := l.v1_VerifiedProspectFound = '-1' and l.PurchCntEv <> -99999;
		SELF.v1_VerifiedProspectFound := IF(Modification2,'1',l.v1_VerifiedProspectFound);
		SELF := l;
		SELF := [];
	END;
	Xfm2Result := PROJECT(Xfm1Result, PB11_xfm2(LEFT));	
	
	FinalLayout PB11_xfm3(Xfm2Result l) := TRANSFORM
		Modification3 := l.PurchCntEv = 0;
		SELF.PurchItemCntEv := IF(Modification3,0,l.PurchItemCntEv);
		SELF.PurchOldMsnc := IF(Modification3,-99998,l.PurchOldMsnc);
		SELF.PurchNewMsnc := IF(Modification3,-99998,l.PurchNewMsnc);
		SELF.PurchTotEv := IF(Modification3,-99998,l.PurchTotEv);
		SELF.PurchAmtAvg := IF(Modification3,-99998,l.PurchAmtAvg);
		SELF.PurchNewAmt := IF(Modification3,-99998,l.PurchNewAmt);
		SELF := l;
		SELF := [];
	END;
	Xfm3Result := PROJECT(Xfm2Result, PB11_xfm3(LEFT));	
	
	FinalLayout PB11_xfm4(Xfm2Result l) := TRANSFORM
		Modification4 := l.PurchCntEv > 0;
		SELF.PurchItemCntEv := IF(Modification4 AND l.PurchItemCntEv=0,-99997,l.PurchItemCntEv);
		SELF.PurchOldMsnc := IF(Modification4 AND l.PurchOldMsnc=-99998,-99997,l.PurchOldMsnc);
		SELF.PurchNewMsnc := IF(Modification4 AND l.PurchNewMsnc=-99998,-99997,l.PurchNewMsnc);
		SELF.PurchTotEv := IF(Modification4 AND l.PurchTotEv=-99998,-99997,l.PurchTotEv);
		SELF.PurchAmtAvg := IF(Modification4 AND l.PurchAmtAvg=-99998,-99997,l.PurchAmtAvg);
		SELF.PurchNewAmt := IF(Modification4 AND l.PurchNewAmt=-99998,-99997,l.PurchNewAmt);
		SELF := l;
		SELF := [];
	END;
	FinalResult := PROJECT(Xfm3Result, PB11_xfm4(LEFT));
	
	RETURN FinalResult;
END;