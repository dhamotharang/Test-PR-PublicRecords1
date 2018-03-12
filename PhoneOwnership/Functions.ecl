IMPORT Autokey_batch,BatchServices,DeathV2_Services,Doxie,Doxie_crs,Doxie_Raw,PhoneOwnership,Phones,Relationship,STD,ut;
EXPORT Functions := MODULE

	SHARED today := STD.Date.Today();
	EXPORT getSearchLevel(STRING searchLevel) := FUNCTION
	RETURN CASE(ut.CleanSpacesAndUpper(searchLevel),
							'BASIC'    => PhoneOwnership.Constants.SearchLevel.BASIC,
							'PREMIUM'  => PhoneOwnership.Constants.SearchLevel.PREMIUM,
							// 'ULTIMATE' => Phones.PhoneOwnership_Constants.SearchLevel.ULTIMATE, //future development
							PhoneOwnership.Constants.SearchLevel.BASIC);		
	END;
	EXPORT getUseCase(STRING useCaseMask) := FUNCTION
		RETURN MAP((INTEGER)useCaseMask[1] > 0 => PhoneOwnership.Constants.UseCaseValues[1],
								(INTEGER)useCaseMask[2] > 0 => PhoneOwnership.Constants.UseCaseValues[2],
								(INTEGER)useCaseMask[3] > 0 => PhoneOwnership.Constants.UseCaseValues[3],
								(INTEGER)useCaseMask[4] > 0 => PhoneOwnership.Constants.UseCaseValues[4],
								// Will need to determine how the service should handle multiple useCases. TCPA will be the default and only value used in this release. Req 3.2.2
								PhoneOwnership.Constants.UseCaseValues[3]); 														
	END;
	
	EXPORT STRING getOwnershipValue(UNSIGNED ownershipIndex) := FUNCTION
		RETURN CASE(ownershipIndex,
								5 => 'HIGH', //PhoneOwnership.Constants.Ownership.HIGH,
								4 => 'MEDIUM_HIGH', //PhoneOwnership.Constants.Ownership.MEDIUM_HIGH,
								3 => 'MEDIUM', //PhoneOwnership.Constants.Ownership.MEDIUM,
								2 => 'UNDETERMINED', //PhoneOwnership.Constants.Ownership.UNDETERMINED,
								1 => 'LOW', //PhoneOwnership.Constants.Ownership.LOW,
								0 => 'INVALID', //PhoneOwnership.Constants.Ownership.INVALID,
								'UNDETERMINED'); //PhoneOwnership.Constants.Ownership.UNDETERMINED));													
	END;		
	
	EXPORT fuzzyString(STRING str) := FUNCTION
		RETURN STD.Metaphone.Primary(str);
	END;

	EXPORT evaluateNameMatch(STRING InputFName,STRING InputLName,STRING ResultFName,STRING ResultLName) := FUNCTION	
			RETURN  MAP(InputFName<>'' AND InputLName<>'' AND
									fuzzyString(InputFName) = fuzzyString(ResultFName) AND 
									fuzzyString(InputLName) = fuzzyString(ResultLName) => PhoneOwnership.Constants.NameMatch.FIRSTLAST,
								(InputFName != '' AND fuzzyString(InputFName) = fuzzyString(ResultFName)) OR 
								(InputLName != '' AND fuzzyString(InputLName) = fuzzyString(ResultLName)) => PhoneOwnership.Constants.NameMatch.PARTIAL,
								PhoneOwnership.Constants.NameMatch.NONE);	
	END;
	
	EXPORT getReasonCodes(BOOLEAN subject, BOOLEAN noOwner, BOOLEAN disconnected) := FUNCTION
		subjectReason := IF(subject,PhoneOwnership.Constants.Reason_Codes.MATCH,PhoneOwnership.Constants.Reason_Codes.NO_MATCH);
		noOwnerReason := IF(noOwner,PhoneOwnership.Constants.Reason_Codes.NO_IDENTITY,'');
		disconnectedReason := IF(disconnected,PhoneOwnership.Constants.Reason_Codes.DISCONNECTED,'');
		
		reason := subjectReason + noOwnerReason + disconnectedReason;
		
		RETURN STD.STr.RemoveSuffix(reason,',');
	
	END;
	
	// Best info
	EXPORT GetBestInfo(DATASET(PhoneOwnership.Layouts.PhonesCommon) dBatchIn) :=FUNCTION

		dids := DEDUP(PROJECT(dBatchIn(did<>0),doxie.layout_references),did,ALL);
		dBestRecs := Doxie.best_records(dids);
		
		PhoneOwnership.Layouts.PhonesCommon getBestInfo(PhoneOwnership.Layouts.PhonesCommon l, doxie.layout_best r) := TRANSFORM
			SELF.acctno		   := l.acctno;
			SELF.seq			   := 1;
			SELF.did		     := l.did;
			SELF.dt_last_seen:= (STRING)today;
			SELF             := r;
			SELF             := l;
		END;
		dBestInfo := JOIN(dBatchIn,dBestRecs,
											LEFT.did = RIGHT.did,
											getBestInfo(LEFT,RIGHT),
											LEFT OUTER,LIMIT(0),KEEP(1));
											
		didsForHeaderRecs := DEDUP(PROJECT(dBestInfo(did<>0 AND lname<>batch_in.name_last),doxie.layout_references_hh),did,ALL);
		dsHeader := doxie.header_records_byDID(didsForHeaderRecs);
		dsSortedHeaderRecs := SORT(dsHeader,did,-dt_last_seen,dt_first_seen);
		
		PhoneOwnership.Layouts.PhonesCommon getAlternateNames(PhoneOwnership.Layouts.PhonesCommon l, doxie.Layout_presentation r) := TRANSFORM
			SELF.acctno		   	:= l.acctno;
			SELF.seq			   	:= 2;
			SELF.did		     	:= l.did;
			SELF.dt_last_seen	:= (STRING)r.dt_last_seen;
			SELF.dt_first_seen:= (STRING)r.dt_first_seen;
			SELF             	:= r;
			SELF             	:= l;
		END;		
		dsAlternateName := JOIN(dBestInfo,dsSortedHeaderRecs,
												LEFT.did=RIGHT.did AND
												LEFT.batch_in.name_last <> LEFT.lname AND
												LEFT.batch_in.name_last=RIGHT.lname,
												getAlternateNames(LEFT,RIGHT),
												NOSORT, LIMIT(0),KEEP(1));
												
		// OUTPUT(dBatchIn,NAMED('dBatchIn'));
		// OUTPUT(dBestRecs,NAMED('dBestRecs'));
		// OUTPUT(dBestInfo,NAMED('dBestInfo'));
		// OUTPUT(didsForHeaderRecs,NAMED('didsForHeaderRecs'));
		// OUTPUT(dsSortedHeaderRecs,NAMED('dsSortedHeaderRecs'));
		// OUTPUT(dsAlternateName,NAMED('dsAlternateName'));
		RETURN dBestInfo + dsAlternateName;
	END;
	
END;