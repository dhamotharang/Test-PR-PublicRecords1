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
								5 => 'High',
								4 => 'Medium High',
								3 => 'Medium',
								2 => 'Undetermined',
								1 => 'Low', 
								0 => 'Invalid',
								//RQ-16410: Changed default value to be blank
								'');
	END;		
	EXPORT STRING getRelationship(UNSIGNED ownershipIndex) := FUNCTION
		RETURN CASE(ownershipIndex,
								5 => PhoneOwnership.Constants.Relationship.SUBJECT,
								//4 => specific relations husband, wife, mother, father ...
								3 => PhoneOwnership.Constants.Relationship.RELATIVE,
								2 => PhoneOwnership.Constants.Relationship.NO_IDENTITY,
								1 => PhoneOwnership.Constants.Relationship.NONE,
								0 => PhoneOwnership.Constants.Relationship.INVALID,
								//RQ-16410: Changed default value to be blank
								'');
	END;	
	
	EXPORT fuzzyString(STRING str) := FUNCTION
		RETURN STD.Metaphone.Primary(str);
	END;

	EXPORT nameMatch(STRING l_name, STRING r_name) := FUNCTION
		result := l_name <> '' AND fuzzyString(l_name) = fuzzyString(r_name);
		RETURN result;
	END;

	//RQ-16410: Moved fuzzy name match functions out of evaluateNameMatch scope to make them reusable. Modified function to make use of nameMatch
	EXPORT fuzzyMatchFirstAndLast(STRING l_fname, STRING l_lname, STRING r_fname, STRING r_lname) := FUNCTION
		result := nameMatch(l_fname, r_fname) AND nameMatch(l_lname, r_lname);
		RETURN result;
	END;

	EXPORT fuzzyMatchFirstOrLast(STRING l_fname, STRING l_lname, STRING r_fname, STRING r_lname) := FUNCTION
		result := nameMatch(l_fname, r_fname) OR nameMatch(l_lname, r_lname);
		RETURN result;
	END;

EXPORT evaluateNameMatch(STRING LFName,STRING LLName,STRING RFName,STRING RLName, boolean flipFL = false) := FUNCTION  
      RETURN  MAP(
          fuzzyMatchFirstAndLast(LFName, LLName, RFName, RLName) => PhoneOwnership.Constants.NameMatch.FIRSTLAST,
          flipFL AND fuzzyMatchFirstAndLast(LFName, LLName, RLName, RFName) => PhoneOwnership.Constants.NameMatch.FIRSTLAST,
          fuzzyMatchFirstOrLast(LFName, LLName, RFName, RLName) => PhoneOwnership.Constants.NameMatch.PARTIAL,
          flipFL AND fuzzyMatchFirstOrLast(LFName, LLName, RLName, RFName) => PhoneOwnership.Constants.NameMatch.PARTIAL,
          PhoneOwnership.Constants.NameMatch.NONE); 
  END;

  EXPORT callerNameMatch(STRING LFName, STRING LLName, STRING RFName, STRING RLName) := FUNCTION  
      // CallerID is not consistent with the name order, hence check for any possible match for switch first and last names
      //RQ-16410: Accounting for AccudataCNAM char limit of 15
      accudataCNAMOverflow := (LENGTH(LFName) + 1 + LENGTH(LLName)) = 15;
	  isInitial := LENGTH(TRIM(LFName)) = 1 OR LENGTH(TRIM(LLName)) = 1 OR LENGTH(TRIM(RFName)) = 1 OR LENGTH(TRIM(RLName)) = 1;
      RETURN MAP(
          //RQ-16410: STD.Metaphone doesn't account for ommitted characters therefore FirstOrLast is being used instead of FirstAndLast
          accudataCNAMOverflow AND fuzzyMatchFirstOrLast(LFName, LLName, RFName, RLName) => PhoneOwnership.Constants.NameMatch.FIRSTLAST,
          isInitial AND (fuzzyMatchFirstAndLast(LFName[1], LLName, RFName, RLName[1]) OR
		  				 fuzzyMatchFirstAndLast(LFName, LLName[1], RFName[1], RLName) OR
						 fuzzyMatchFirstAndLast(LFName[1], LLName, RFName[1], RLName)) => PhoneOwnership.Constants.NameMatch.FIRSTLAST,
          evaluateNameMatch(LFName, LLName, RFName, RLName, TRUE)
	  );
  END;  
	
    //RQ-16410: Added conditions for checkOwnership to strictly enforce high ownership for first initial match and flipped first & last names
	//RQ-16410: Restructured the function for easier readability since additional conditions were added 
	EXPORT checkOwnership(STRING subjectFName, STRING subjectLName,STRING resultFName, STRING resultLName,STRING LNMatchCode,STRING relationship) := FUNCTION
        NoRelationship := relationship = PhoneOwnership.Constants.Relationship.NONE;

        FLNameMatch := EvaluateNameMatch(subjectFName,subjectLName,resultFName,resultLName) = PhoneOwnership.Constants.NameMatch.FIRSTLAST;
        FNPartialLNMatch := LENGTH(TRIM(subjectFName))>=3 AND LENGTH(TRIM(resultFName))>=3 AND fuzzyString(subjectFName) = fuzzyString(resultFName);
        FInitalLNMatch := LENGTH(TRIM(resultFName))=1 AND subjectFName[1] = resultFName[1] AND fuzzyString(subjectLName) = fuzzyString(resultLName);
        LNMatchWFlip := evaluateNameMatch(subjectFName, subjectLName, resultFName, resultLName, TRUE) = PhoneOwnership.Constants.NameMatch.PARTIAL;

        ownershipLevel := MAP(
			// Matched Subject by First and Last names
			FLNameMatch => PhoneOwnership.Constants.Ownership.enumIndex.HIGH,
			// Matched Subject by Firstname  >=3 characters
			NoRelationship AND FNPartialLNMatch	=> PhoneOwnership.Constants.Ownership.enumIndex.HIGH,
			// Matched Subject by first initial and last name
            //RQ-16410: Check if result Firstame is in fact one character
			NoRelationship AND FInitalLNMatch => PhoneOwnership.Constants.Ownership.enumIndex.HIGH,
			// Matched Relative by lastname ONLY
            //RQ-16410: Accounting for flipped first & last names
			NoRelationship AND LNMatchWFlip => PhoneOwnership.Constants.Ownership.enumIndex.MEDIUM,
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

		mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule());
		dBestRecs := Doxie.best_records(dids, modAccess := mod_access);
		
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