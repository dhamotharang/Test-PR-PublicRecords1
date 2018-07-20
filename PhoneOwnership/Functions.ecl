IMPORT Doxie,PhoneOwnership,Phones,STD,ut;
EXPORT Functions := MODULE

	EXPORT TODAY := STD.Date.Today();
	EXPORT getSearchLevel(STRING searchLevel) := FUNCTION
	RETURN CASE(ut.CleanSpacesAndUpper(searchLevel),
							'BASIC'    => PhoneOwnership.Constants.SearchLevel.BASIC,
							'PREMIUM'  => PhoneOwnership.Constants.SearchLevel.PREMIUM,
							'ULTIMATE' => PhoneOwnership.Constants.SearchLevel.ULTIMATE,
							PhoneOwnership.Constants.SearchLevel.BASIC);		
	END;
	EXPORT getUseCase(STRING useCaseMask) := FUNCTION
		RETURN MAP( // PhoneOwnership will only use TCPA currently. 
					// KTR will handle validating correct Zumigo credentials before sending to Roxie.
					//(INTEGER)useCaseMask[1] > 0 => PhoneOwnership.Constants.UseCaseValues[1],
					//(INTEGER)useCaseMask[2] > 0 => PhoneOwnership.Constants.UseCaseValues[2],
					(INTEGER)useCaseMask[3] > 0 => PhoneOwnership.Constants.UseCaseValues[3],
					//(INTEGER)useCaseMask[4] > 0 => PhoneOwnership.Constants.UseCaseValues[4],
					// TCPA will be the default and only value used in this release. Req 3.2.2
					PhoneOwnership.Constants.UseCaseValues[3]); 														
	END;
	
	EXPORT STRING getOwnershipValue(UNSIGNED ownershipIndex) := FUNCTION
		RETURN CASE(ownershipIndex,
								5 => 'High', //PhoneOwnership.Constants.Ownership.HIGH,
								4 => 'Medium High', //PhoneOwnership.Constants.Ownership.MEDIUM_HIGH,
								3 => 'Medium', //PhoneOwnership.Constants.Ownership.MEDIUM,
								2 => 'Undetermined', //PhoneOwnership.Constants.Ownership.UNDETERMINED,
								1 => 'Low', //PhoneOwnership.Constants.Ownership.LOW,
								0 => 'Invalid', //PhoneOwnership.Constants.Ownership.INVALID,
								'Undetermined'); //PhoneOwnership.Constants.Ownership.UNDETERMINED));													
	END;		
	EXPORT STRING getRelationship(UNSIGNED ownershipIndex) := FUNCTION
		RETURN CASE(ownershipIndex,
								5 => PhoneOwnership.Constants.Relationship.SUBJECT,
								//4 => specific relations husband, wife, mother, father ...
								3 => PhoneOwnership.Constants.Relationship.RELATIVE,
								2 => PhoneOwnership.Constants.Relationship.NO_IDENTITY,
								1 => PhoneOwnership.Constants.Relationship.NONE,
								0 => PhoneOwnership.Constants.Relationship.INVALID,
								PhoneOwnership.Constants.Relationship.NO_IDENTITY);
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

	EXPORT checkOwnership(STRING subjectFName, STRING subjectLName,STRING resultFName, STRING resultLName,STRING LNMatchCode,STRING relationship) := FUNCTION
		ownershipLevel := MAP(
			// Matched Subject by First and Last names
			EvaluateNameMatch(subjectFName,subjectLName,resultFName,resultLName)=PhoneOwnership.Constants.NameMatch.FIRSTLAST 
																					=> PhoneOwnership.Constants.Ownership.enumIndex.HIGH,
			// Matched Subject by Firstname  >=3 characters
			relationship = PhoneOwnership.Constants.Relationship.NONE AND LENGTH(subjectFName)>=3 AND LENGTH(resultFName)>=3 AND 
							fuzzyString(subjectFName) = fuzzyString(resultFName) 	=> PhoneOwnership.Constants.Ownership.enumIndex.HIGH,
			// Matched Subject by first initial and last name
			relationship = PhoneOwnership.Constants.Relationship.NONE AND subjectFName[1] = resultFName[1] AND 
							fuzzyString(subjectLName) = fuzzyString(resultLName) 	=> PhoneOwnership.Constants.Ownership.enumIndex.HIGH,
			// Matched Relative by lastname ONLY
			relationship = PhoneOwnership.Constants.Relationship.NONE AND fuzzyString(subjectFName) != fuzzyString(resultFName) AND 
							fuzzyString(subjectLName) = fuzzyString(resultLName) 	=> PhoneOwnership.Constants.Ownership.enumIndex.MEDIUM,
			PhoneOwnership.Constants.Ownership.enumIndex.LOW
		);

		RETURN ownershipLevel;
	END;	
	
	EXPORT getReasonCodes(BOOLEAN subject, BOOLEAN noOwner, BOOLEAN disconnected, BOOLEAN suspended) := FUNCTION
		subjectReason := IF(subject,PhoneOwnership.Constants.Reason_Codes.MATCH,'');
		unlinkedReason := IF(NOT subject AND NOT noOwner,PhoneOwnership.Constants.Reason_Codes.NO_MATCH,'');
		noOwnerReason := IF(noOwner,PhoneOwnership.Constants.Reason_Codes.NO_IDENTITY,'');
		disconnectedReason := IF(disconnected,PhoneOwnership.Constants.Reason_Codes.DISCONNECTED,'');
		suspendedReason := IF(suspended,PhoneOwnership.Constants.Reason_Codes.CONFIRMED_SUSPENDED,'');
		reason := subjectReason + unlinkedReason + noOwnerReason + disconnectedReason + suspendedReason;
		
		RETURN STD.STr.RemoveSuffix(reason,',');
	
	END;
	
	// Best info
	EXPORT GetBestInfo(DATASET(PhoneOwnership.Layouts.PhonesCommon) dBatchIn) :=FUNCTION

		dids := DEDUP(PROJECT(dBatchIn(did<>0),doxie.layout_references),did,ALL);
		dBestRecs := Doxie.best_records(dids);
		
		PhoneOwnership.Layouts.PhonesCommon getBestInfo(PhoneOwnership.Layouts.PhonesCommon l, doxie.layout_best r) := TRANSFORM
			SELF.acctno		 := l.acctno;
			SELF.seq		 := 1; // Primary identity
			SELF.did		 := l.did;
			SELF.phone		 := l.phone;
			SELF             := r;
			SELF             := l;
		END;
		dBestInfo := JOIN(dBatchIn,dBestRecs,
							LEFT.did = RIGHT.did,
							getBestInfo(LEFT,RIGHT),
							LIMIT(0),KEEP(1));

		didsForHeaderRecs := DEDUP(PROJECT(dBestInfo(did<>0 AND lname<>batch_in.name_last),doxie.layout_references_hh),did,ALL);
		dsHeader := doxie.header_records_byDID(didsForHeaderRecs);
		dsSortedHeaderRecs := SORT(dsHeader,did,-dt_last_seen,dt_first_seen);
		PhoneOwnership.Layouts.PhonesCommon getAlternateNames(PhoneOwnership.Layouts.PhonesCommon l, doxie.Layout_presentation r) := TRANSFORM
			SELF.acctno		   	:= l.acctno;
			SELF.seq			:= 2; // Secondary identity
			SELF.did		    := l.did;
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
		//keep zero DID records	since phone info could be resolved by Zumigo or Accudata CNAM									
		dAllRecs := dBestInfo + dsAlternateName + dBatchIn(did=0);
		// OUTPUT(dBatchIn,NAMED('dBatchIn'));
		// OUTPUT(dBestRecs,NAMED('dBestRecs'));
		// OUTPUT(dBestInfo,NAMED('dBestInfo'));
		// OUTPUT(didsForHeaderRecs,NAMED('didsForHeaderRecs'));
		// OUTPUT(dsSortedHeaderRecs,NAMED('dsSortedHeaderRecs'));
		// OUTPUT(dsAlternateName,NAMED('dsAlternateName'));
		RETURN dAllRecs;
	END;	
	
END;