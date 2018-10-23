IMPORT doxie, DueDiligence, Risk_Indicators, STD;


EXPORT getIndBestData(DATASET(DueDiligence.Layouts.Indv_Internal) inData,
												UNSIGNED1 dppa,
												UNSIGNED1 glba,
												BOOLEAN includeReport = FALSE) := FUNCTION
												
	
		glbaOK:= Risk_Indicators.iid_constants.glb_ok(glba, FALSE );
		dppaOK := Risk_Indicators.iid_constants.dppa_ok(dppa, FALSE);	

		//since bestData will not have seq just DID, lets make sure we have unique DIDs
		uniqueDIDs := DEDUP(SORT(inData, individual.did), individual.did);
		
		doxie.mac_best_records(uniqueDIDs, individual.did, bestData, dppaOK, glbaOK, , doxie.DataRestriction.fixed_DRM);
		
		addBestData := JOIN(inData, bestData,
                        LEFT.individual.did = RIGHT.did,
                        TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                  SELF.individual.ssn := IF(LEFT.individual.ssn = DueDiligence.Constants.EMPTY, RIGHT.ssn, LEFT.individual.ssn);
                                  SELF.individual.dob := IF(LEFT.individual.dob = DueDiligence.Constants.NUMERIC_ZERO, RIGHT.dob, LEFT.individual.dob);
                                  SELF.individual.phone := IF(LEFT.individual.phone = DueDiligence.Constants.EMPTY, RIGHT.phone, LEFT.individual.phone);
                                  
                                  SELF.individual.firstName := IF(LEFT.individual.firstName = DueDiligence.Constants.EMPTY, RIGHT.fname, LEFT.individual.firstName);
                                  SELF.individual.middleName := IF(LEFT.individual.middleName = DueDiligence.Constants.EMPTY, RIGHT.mname, LEFT.individual.middleName);
                                  SELF.individual.lastName := IF(LEFT.individual.lastName = DueDiligence.Constants.EMPTY, RIGHT.lname, LEFT.individual.lastName);
                                  SELF.individual.suffix := IF(LEFT.individual.suffix = DueDiligence.Constants.EMPTY, RIGHT.name_suffix, LEFT.individual.suffix);
                                  
                                  updateAddress := IF(LEFT.fullInputAddressProvided, FALSE, TRUE);
                                  
                                  SELF.individual.prim_range := IF(updateAddress, RIGHT.prim_range, LEFT.individual.prim_range);
                                  SELF.individual.predir := IF(updateAddress, RIGHT.predir, LEFT.individual.predir);
                                  SELF.individual.prim_name := IF(updateAddress, RIGHT.prim_name, LEFT.individual.prim_name);
                                  SELF.individual.addr_suffix := IF(updateAddress, RIGHT.suffix, LEFT.individual.addr_suffix);
                                  SELF.individual.postdir := IF(updateAddress, RIGHT.postdir, LEFT.individual.postdir);
                                  SELF.individual.unit_desig := IF(updateAddress, RIGHT.unit_desig, LEFT.individual.unit_desig);
                                  SELF.individual.sec_range := IF(updateAddress, RIGHT.sec_range, LEFT.individual.sec_range);
                                  SELF.individual.city := IF(updateAddress, RIGHT.city_name, LEFT.individual.city);
                                  SELF.individual.state := IF(updateAddress, RIGHT.st, LEFT.individual.state);
                                  SELF.individual.zip5 := IF(updateAddress, RIGHT.zip, LEFT.individual.zip5);
                                  SELF.individual.zip4 := IF(updateAddress, RIGHT.zip4, LEFT.individual.zip4);
                                  
                                  SELF.inputSSN := LEFT.individual.ssn;
                                  
                                  SELF.bestSSN := RIGHT.ssn;
                                  SELF.bestPhone := RIGHT.phone;
                                  SELF.bestDOB := RIGHT.dob;
                                  
                                  SELF.bestName.firstName := RIGHT.fname;
                                  SELF.bestName.middleName := RIGHT.mname;
                                  SELF.bestName.lastName := RIGHT.lname;
                                  SELF.bestName.suffix := RIGHT.name_suffix;
                                  
                                  SELF.bestAddress.prim_range := RIGHT.prim_range;
                                  SELF.bestAddress.predir := RIGHT.predir;
                                  SELF.bestAddress.prim_name := RIGHT.prim_name;
                                  SELF.bestAddress.addr_suffix := RIGHT.suffix;
                                  SELF.bestAddress.postdir := RIGHT.postdir;
                                  SELF.bestAddress.unit_desig := RIGHT.unit_desig;
                                  SELF.bestAddress.sec_range := RIGHT.sec_range;
                                  SELF.bestAddress.city := RIGHT.city_name;
                                  SELF.bestAddress.state := RIGHT.st;
                                  SELF.bestAddress.zip5 := RIGHT.zip;
                                  SELF.bestAddress.zip4 := RIGHT.zip4;
                                  
                                  
                                  validDOB := STD.Date.IsValidDate(RIGHT.dob);
                                  validHistDate := STD.Date.IsValidDate(LEFT.historyDate);

                                  
                                  SELF.estimatedAge := IF(validDOB AND validHistDate, STD.Date.YearsBetween(RIGHT.dob, LEFT.historyDate), 0);
                                                                    
                                  SELF := LEFT;
                                  SELF := [];),
                        LEFT OUTER,
                        ATMOST(1));
		
		
		// OUTPUT(inData, NAMED('inData'));
		// OUTPUT(uniqueDIDs, NAMED('uniqueDIDs'));
		// OUTPUT(bestData, NAMED('bestData'), overwrite);
		// OUTPUT(addBestData, NAMED('addBestData'));

		RETURN addBestData;
END;