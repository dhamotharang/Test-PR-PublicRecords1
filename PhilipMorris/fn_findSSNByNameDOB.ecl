cRecord := PhilipMorris.Layouts.OutputRecord.CandidateRecord;

export cRecord fn_findSSNByNameDOB(DATASET(cRecord) SearchData, UNSIGNED2 AddressIdHit) := FUNCTION

//FULL DOB AND ZIPCODE
hitsByNameDob := SearchData(MatchesFirstName and MatchesLastName and MatchesZipCode and MatchesYOBMOBDOB and MatchesSSN4
                            and SearchAddressIDHit = AddressIdHit);
rollupRecDob := RECORD
hitsByNameDob.InternalSeqNo ;
hitsByNameDob.SSN ; 
SSNCount := COUNT(GROUP) ;
END;
 // Creates count for ssn.
ssnTableNameDob := Table(hitsByNameDob, rollupRecDob, InternalSeqNo, SSN, FEW);

// remove typo candidates
ssnByNameDobCount1 := IF (COUNT(ssnTableNameDob) > 1, ssnTableNameDob(SSNCount > 1), ssnTableNameDob);

// join table with the data to return
ssnByNameDob_data := dedup(sort(JOIN(hitsByNameDob, ssnByNameDobCount1, LEFT.SSN = RIGHT.SSN, 
TRANSFORM(cRecord, SELF := LEFT)), ssn), ssn);

ssnByNameDob := if( COUNT(ssnByNameDobCount1)=1,ssnByNameDob_data);

RETURN ssnByNameDob;
END;