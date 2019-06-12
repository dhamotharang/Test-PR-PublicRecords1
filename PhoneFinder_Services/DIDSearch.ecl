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
	
  // Limit number of Other phones returned based on MaxOtherPhones option for each acct
  dWFOtherPhones := TOPN(GROUP(SORT(dPhonesWaterfall(~isPrimaryPhone), acctno, -phone_score), acctno), inMod.MaxOtherPhones, acctno);

  // Phones history for all phones
	lBatchIn tFormat2BatchIn(lBatchIn le, lFinal ri) :=
	TRANSFORM
		SELF.homephone := ri.phone;
		SELF           := le;
	END;
	
  // If no RIs for identity counts, then we only need the primary phone history
	dFormat2BatchIn := PROJECT(IF(inMod.hasActiveIdentityCountRules, dWFPrimaryPhones + dWFOtherPhones, dWFPrimaryPhones),
                              TRANSFORM(lBatchIn, SELF.homephone := LEFT.phone, SELF := LEFT.batch_in));
	
	psMod := MODULE(PROJECT(inMod, PhoneFinder_Services.iParam.SearchParams, OPT))
		EXPORT BOOLEAN UseQSent                := FALSE;
		EXPORT BOOLEAN UseTargus               := FALSE;
		EXPORT BOOLEAN UseLastResort           := FALSE;
		EXPORT BOOLEAN UseInHousePhoneMetadata := FALSE;
	END;
	
	dPhoneHist := PhoneFinder_Services.GetPhones(dFormat2BatchIn, psMod);
  
  // Combine waterfall and phones history
  dWFAllIdentities := dPhonesWaterfall + PROJECT(dPhoneHist, TRANSFORM(lFinal, SELF.batch_in.homephone := '', SELF := LEFT));
  
  Suppress.MAC_Suppress(dWFAllIdentities, dWFSuppressIdentities, inMod.ApplicationType, Suppress.Constants.LinkTypes.DID, did, '', '', TRUE, '', TRUE);
 
	#IF(PhoneFinder_Services.Constants.Debug.PIISearch)
		OUTPUT(dIn, NAMED('dWaterfallSearchIn'));
		OUTPUT(dPhonesWaterfall, NAMED('dPhonesWaterfall'));
		OUTPUT(dWFPrimaryPhones, NAMED('dWFPrimaryPhones'));
		OUTPUT(dWFOtherPhones, NAMED('dWFOtherPhones'));
		OUTPUT(dFormat2BatchIn, NAMED('dFormat2BatchIn'));
		OUTPUT(dPhoneHist, NAMED('dPhoneHist'));
		OUTPUT(dWFAllIdentities, NAMED('dWFAllIdentities'));
		OUTPUT(dWFSuppressIdentities, NAMED('dWFSuppressIdentities'));
	#END
	
	RETURN dWFSuppressIdentities;
END;