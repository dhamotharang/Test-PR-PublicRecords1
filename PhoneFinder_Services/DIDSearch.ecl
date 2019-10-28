IMPORT PhoneFinder_Services, Gateway, Suppress;

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
  dPhoneHistIn := IF(inMod.hasActiveIdentityCountRules, dWFPrimaryPhones + dWFOtherPhones, dWFPrimaryPhones);

	dFormat2BatchIn := PROJECT(dPhoneHistIn, TRANSFORM(lBatchIn, SELF.homephone := LEFT.phone, SELF.acctno := LEFT.acctno, SELF := []));

	psMod := MODULE(PROJECT(inMod, PhoneFinder_Services.iParam.SearchParams))
	    EXPORT BOOLEAN UseTransUnionIQ411      := FALSE;
		EXPORT BOOLEAN UseTransUnionPVS        := FALSE;
		EXPORT BOOLEAN UseTargus               := FALSE;
		EXPORT BOOLEAN UseLastResort           := FALSE;
		EXPORT BOOLEAN UseInHousePhoneMetadataOnly := FALSE;
	END;

	dPhoneHist := PhoneFinder_Services.GetPhones(dFormat2BatchIn, psMod);

  dPhoneHistPrimaryFlag := JOIN(dPhoneHist,
                                dPhoneHistIn,
                                LEFT.acctno = RIGHT.acctno AND
                                LEFT.phone  = RIGHT.phone,
                                TRANSFORM(lFinal, SELF.isPrimaryPhone := RIGHT.isPrimaryPhone, SELF.isPrimaryIdentity := FALSE, SELF := LEFT),
                                LIMIT(0), KEEP(1));

  // Combine waterfall and phones history
  dWFAllIdentities := dPhonesWaterfall + dPhoneHistPrimaryFlag;

  Suppress.MAC_Suppress(dWFAllIdentities, dWFSuppressIdentities, inMod.application_type, Suppress.Constants.LinkTypes.DID, did, '', '', TRUE, '', TRUE);

	#IF(PhoneFinder_Services.Constants.Debug.PIISearch)
		OUTPUT(dIn, NAMED('dWaterfallSearchIn'));
		OUTPUT(dPhonesWaterfall, NAMED('dPhonesWaterfall'));
		OUTPUT(dWFPrimaryPhones, NAMED('dWFPrimaryPhones'));
		OUTPUT(dWFOtherPhones, NAMED('dWFOtherPhones'));
		OUTPUT(dFormat2BatchIn, NAMED('dFormat2BatchIn'));
		OUTPUT(dPhoneHist, NAMED('dPhoneHist'));
		OUTPUT(dPhoneHistPrimaryFlag, NAMED('dPhoneHistPrimaryFlag'));
		OUTPUT(dWFAllIdentities, NAMED('dWFAllIdentities'));
		OUTPUT(dWFSuppressIdentities, NAMED('dWFSuppressIdentities'));
	#END

	RETURN dWFSuppressIdentities;
END;
