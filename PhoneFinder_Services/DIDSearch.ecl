IMPORT Gateway,Suppress;

lBatchIn := PhoneFinder_Services.Layouts.BatchInAppendDID;
lFinal   := PhoneFinder_Services.Layouts.PhoneFinder.Final;

EXPORT DIDSearch( DATASET(lBatchIn)                        dIn,
									PhoneFinder_Services.iParam.ReportParams inMod,
									DATASET(Gateway.Layouts.Config)          dGateways,
									DATASET(lBatchIn)                        dInBestInfo) :=
FUNCTION
	// Waterfall phones
	dPhonesWaterfall := PhoneFinder_Services.GetWaterfallPhones(dIn,inMod,dGateways,,dInBestInfo);
	
	// Get inhouse phone records for the primary phone
	dWFPrimaryPhones := DEDUP(SORT(dPhonesWaterfall(isPrimaryPhone),acctno),acctno);
	
	lBatchIn tFormat2BatchIn(lBatchIn le,lFinal ri) :=
	TRANSFORM
		SELF.homephone := ri.phone;
		SELF           := le;
	END;
	
	dFormat2BatchIn := JOIN(dIn,
													dWFPrimaryPhones,
													LEFT.acctno = RIGHT.acctno,
													tFormat2BatchIn(LEFT,RIGHT),
													LIMIT(0),KEEP(1));
	
	psMod := MODULE(PROJECT(inMod,PhoneFinder_Services.iParam.ReportParams,OPT))
		EXPORT BOOLEAN UseQSent      := FALSE;
		EXPORT BOOLEAN UseTargus     := FALSE;
		EXPORT BOOLEAN UseLastResort := FALSE;
	END;
	
	dPrimaryPhoneHist := PhoneFinder_Services.GetPhones(dFormat2BatchIn,psMod);
	
	lFinal tPrimaryPhoneFlag(dPrimaryPhoneHist pInput) :=
	TRANSFORM
		SELF.isPrimaryPhone    := TRUE;
		SELF.batch_in          := PROJECT(pInput.batch_in,TRANSFORM(lBatchIn, SELF.homephone := '',SELF := LEFT));
		SELF                   := pInput;
	END;
	
	dPrimaryPhoneFlag := PROJECT(dPrimaryPhoneHist,tPrimaryPhoneFlag(LEFT));
	
	lFinal UpdateInputDID (lFinal l, lFinal r):= TRANSFORM
		SELF.batch_in.did := r.batch_in.did;
		SELF := l;
	END;
	
	dWFPrimaryRecs := JOIN(dPrimaryPhoneFlag,dWFPrimaryPhones,
													LEFT.acctno=RIGHT.acctno,
													UpdateInputDID(LEFT,RIGHT),
													LEFT OUTER,
													LIMIT(0), KEEP (1));
													
	// limiting no.of other phones returned based on MaxOtherPhones	option for each acct						
	dCombined := TOPN(GROUP(SORT(dPhonesWaterfall(~isPrimaryPhone), acctno, -phone_score), acctno), inMod.MaxOtherPhones, acctno) + dWFPrimaryRecs;

 dCombinedWithDIDs := PhoneFinder_Services.Functions.AppendDIDs(dCombined);
	
	
	Suppress.MAC_Suppress(dCombinedWithDIDs,dSuppress,inMod.ApplicationType,Suppress.Constants.LinkTypes.DID,did,'','',TRUE,'',TRUE);
	
	#IF(PhoneFinder_Services.Constants.Debug.PIISearch)
		OUTPUT(dIn,NAMED('dWaterfallSearchIn'));
		OUTPUT(dPhonesWaterfall,NAMED('dPhonesWaterfall'));
		OUTPUT(dWFPrimaryPhones,NAMED('dWFPrimaryPhones'));
		OUTPUT(dFormat2BatchIn,NAMED('dFormat2BatchIn'));
		OUTPUT(dPrimaryPhoneHist,NAMED('dPrimaryPhoneHist'));
		OUTPUT(dPrimaryPhoneFlag,NAMED('dPrimaryPhoneFlag'));
		OUTPUT(dCombined,NAMED('dCombined'));
		OUTPUT(dCombinedWithDIDs,NAMED('dCombinedWithDIDs'));
		OUTPUT(dSuppress,NAMED('dDIDSearchSuppress'));
	#END
	
	RETURN dSuppress;
END;