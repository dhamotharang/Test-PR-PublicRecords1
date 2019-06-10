IMPORT Gateway, Phones, Suppress;

lBatchIn := PhoneFinder_Services.Layouts.BatchInAppendDID;
lFinal   := PhoneFinder_Services.Layouts.PhoneFinder.Final;

EXPORT DIDSearch( DATASET(lBatchIn)                        dIn, 
									PhoneFinder_Services.iParam.SearchParams inMod, 
									DATASET(Gateway.Layouts.Config)          dGateways, 
									DATASET(lBatchIn)                        dInBestInfo) :=
FUNCTION
	// Waterfall phones
	dPhonesWaterfall := PhoneFinder_Services.GetWaterfallPhones(dIn, inMod, dGateways, , dInBestInfo);
	
	// Get inhouse phone records for the primary phone
	dWFPrimaryPhones := DEDUP(SORT(dPhonesWaterfall(isPrimaryPhone), acctno), acctno);
	
  // Phones history for all phones
	lBatchIn tFormat2BatchIn(lBatchIn le, lFinal ri) :=
	TRANSFORM
		SELF.homephone := ri.phone;
		SELF           := le;
	END;
	
  // If no RIs for identity counts, then we only need the primary phone history
	dFormat2BatchIn := PROJECT(IF(inMod.hasActiveIdentityCountRules, dPhonesWaterfall(typeflag != Phones.Constants.TypeFlag.DataSource_PV), dWFPrimaryPhones),
                              TRANSFORM(lBatchIn, SELF.homephone := LEFT.phone, SELF := LEFT.batch_in));
	
	psMod := MODULE(PROJECT(inMod, PhoneFinder_Services.iParam.SearchParams, OPT))
		EXPORT BOOLEAN UseQSent                := FALSE;
		EXPORT BOOLEAN UseTargus               := FALSE;
		EXPORT BOOLEAN UseLastResort           := FALSE;
		EXPORT BOOLEAN UseInHousePhoneMetadata := FALSE;
	END;
	
	dPhoneHist := PhoneFinder_Services.GetPhones(dFormat2BatchIn, psMod);
  
  // Combine waterfall and phones history and keep the waterfall record (best record) for the phone
  dWFAllIdentities := dPhonesWaterfall + PROJECT(dPhoneHist, TRANSFORM(lFinal, SELF.batch_in.homephone := '', SELF := LEFT));
  
  Suppress.MAC_Suppress(dWFAllIdentities, dWFSuppressIdentities, inMod.ApplicationType, Suppress.Constants.LinkTypes.DID, did, '', '', TRUE, '', TRUE);

  // Count the number of identities for each phone to calculate RI
  dWFCntPhoneIdentities := IF(inMod.hasActiveIdentityCountRules,
                              PhoneFinder_Services.GetIdentitiesCount(dWFSuppressIdentities),
                              dWFSuppressIdentities);

  // Assign the primary phone flag
	lFinal tPrimaryPhoneHist(lFinal le, lFinal ri) :=
	TRANSFORM
		SELF.isPrimaryPhone    := TRUE;
		SELF.isPrimaryIdentity := FALSE;
		SELF.batch_in          := PROJECT(le.batch_in, TRANSFORM(lBatchIn, SELF.did := ri.batch_in.did, SELF.homephone := '', SELF := LEFT));
		SELF                   := le;
	END;
	
	dPrimaryPhoneHist := JOIN(dWFCntPhoneIdentities(~isPrimaryIdentity),
                            dWFPrimaryPhones,
                            LEFT.acctno = RIGHT.acctno AND
                            LEFT.phone  = RIGHT.phone,
                            tPrimaryPhoneHist(LEFT, RIGHT),
                            LIMIT(0), KEEP(1));

	// limiting no.of other phones returned based on MaxOtherPhones	option for each acct
  dWaterfallPhonesOnly := dWFCntPhoneIdentities(isPrimaryIdentity);

	dCombined := TOPN(GROUP(SORT(dWaterfallPhonesOnly(~isPrimaryPhone), acctno, -phone_score), acctno), inMod.MaxOtherPhones, acctno) +
                dWaterfallPhonesOnly(isPrimaryPhone) + dPrimaryPhoneHist;
	
	#IF(PhoneFinder_Services.Constants.Debug.PIISearch)
		OUTPUT(dIn, NAMED('dWaterfallSearchIn'));
		OUTPUT(dPhonesWaterfall, NAMED('dPhonesWaterfall'));
		OUTPUT(dWFPrimaryPhones, NAMED('dWFPrimaryPhones'));
		OUTPUT(dFormat2BatchIn, NAMED('dFormat2BatchIn'));
		OUTPUT(dPhoneHist, NAMED('dPhoneHist'));
		OUTPUT(dWFAllIdentities, NAMED('dWFAllIdentities'));
		OUTPUT(dWFSuppressIdentities, NAMED('dWFSuppressIdentities'));
		OUTPUT(dWFCntPhoneIdentities, NAMED('dWFCntPhoneIdentities'));
		OUTPUT(dPrimaryPhoneHist, NAMED('dPrimaryPhoneHist'));
		OUTPUT(dWaterfallPhonesOnly, NAMED('dWaterfallPhonesOnly'));
		OUTPUT(dCombined, NAMED('dCombined'));
	#END
	
	RETURN dCombined;
END;