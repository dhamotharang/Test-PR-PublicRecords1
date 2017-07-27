import doxie, Accurint_AccLogs, ut;

export Raw := MODULE

	 EXPORT getLogsByDID(dataset(doxie.layout_references) in_dids) := FUNCTION
		 key := Accurint_AccLogs.Key_LinkID;
		 vks := JOIN(DEDUP(SORT(in_dids,did),did),key,
						KEYED(LEFT.did = RIGHT.link_id),
						TRANSFORM(Layouts.AccLogId, self := RIGHT),
						LIMIT(Constant.LOGS_PER_DID, fail(203, doxie.ErrorCodes(203))));									
		
		return vks;
	END;
	
	EXPORT getLogsByDOB(Integer aDob,  IParam.SearchInterface aInputData) := FUNCTION
		key := Accurint_AccLogs.Key_DOBLFName;
		
		INTEGER dDob := aDob;
		BOOLEAN isDayRange := (dDob % 100) = 0 AND dDob > 0;
		BOOLEAN isMonthRange := (dDob % 10000) = 0 AND dDob > 0;
				
		dobLow := dDob;

		dobHigh := MAP(isMonthRange => dDob + 1231,
									isDayRange => dDob + 31,
									dDob);

		res := LIMIT(key (dob between dobLow and dobHigh, 
							orig_company_id in [aInputData.companyId_1,  
														 aInputData.companyId_2, aInputData.companyId_3,
														 aInputData.companyId_4, aInputData.companyId_5, 
														 aInputData.companyId_6, aInputData.companyId_7, 
														 aInputData.companyId_8, aInputData.companyId_9,
														 aInputData.companyId_10]), 
												 Constant.LOGS_PER_DOB, 
												 fail(203, doxie.ErrorCodes(203)), 
													KEYED);
		
		ids := project(res, TRANSFORM(Layouts.AccLogId, SELF := LEFT));
		
		RETURN ids;
	END;
	
	
	EXPORT Layouts.AccLogId getLogsByDL(dataset(Layouts.DLNumber) dlnum) := FUNCTION
		key := Accurint_AccLogs.Key_DL;
		
		vks := JOIN(DEDUP(SORT(dlnum,orig_dl),orig_dl),key,
		        KEYED(LEFT.orig_dl = RIGHT.dl),						
						TRANSFORM(Layouts.AccLogId, self := RIGHT),
						LIMIT(Constant.LOGS_PER_DL_NUMBER,fail(11, doxie.ErrorCodes(11))));
		
		RETURN vks;
	END;
		
	EXPORT Layouts.AccLogId getLogsByUserId(dataset(Layouts.UserId) userIds, IParam.SearchInterface aInputData) := FUNCTION
		startDt := aInputData.startDate;
		endDt := aInputData.endDate;
		key := Accurint_AccLogs.Key_UserID;		
				
		dataRes := JOIN(userIds, key, 
			KEYED(LEFT.user_Id= RIGHT.user_Id)
			AND KEYED(startDt = '' OR RIGHT.date_added >= (integer4)startDt)
			AND KEYED(endDt = '' OR RIGHT.date_added <= (integer4)endDt),						
			TRANSFORM(Layouts.AccLogId, 
					self.record_id := RIGHT.record_id),
					LIMIT(Constant.LOGS_PER_USER_ID, 
					fail(203, doxie.ErrorCodes(203))));						
						
		RETURN dataRes;
	END;
	
	EXPORT getLogsByCharterNumber(dataset(Layouts.Unique_Id) chNum) := FUNCTION
		key := Accurint_AccLogs.Key_Charter;
		
		vks := JOIN(DEDUP(SORT(chNum,orig_unique_id),orig_unique_id),key,
		        KEYED(LEFT.orig_unique_id = RIGHT.charter_number),						
						TRANSFORM(Layouts.AccLogId, self := RIGHT),
							LIMIT(Constant.LOGS_PER_CHARTER_NUMBER,
							fail(203, doxie.ErrorCodes(203))));
		
		RETURN vks;
		
	END;
	
	EXPORT getLogsByUCC(dataset(Layouts.Unique_Id) uccNumm) := FUNCTION
		key := Accurint_AccLogs.Key_UCC;
		
		vks := JOIN(DEDUP(SORT(uccNumm,orig_unique_id),orig_unique_id),key,
		        KEYED(LEFT.orig_unique_id = RIGHT.ucc_number),						
						TRANSFORM(Layouts.AccLogId, self := RIGHT),
								LIMIT(Constant.LOGS_PER_UCC,
								fail(203, doxie.ErrorCodes(203))));
		RETURN vks;
		
	END;
	
	EXPORT getLogsByFEIN(dataset(Layouts.Unique_id) fein) := FUNCTION
		key := Accurint_AccLogs.Key_FEIN;
			
		vks := JOIN(DEDUP(SORT(fein,orig_unique_id),orig_unique_id),key,
						KEYED((unsigned6)LEFT.orig_unique_id = RIGHT.fein),						
						TRANSFORM(Layouts.AccLogId, self := RIGHT),
								LIMIT(Constant.LOGS_PER_FEIN,
								fail(203, doxie.ErrorCodes(203))));
		RETURN vks;
	END;
	
	EXPORT getLogsByDomain(dataset(Layouts.Unique_Id) domainNum) := FUNCTION
		Key := Accurint_AccLogs.Key_Domain;
		
		vks := JOIN(DEDUP(SORT(domainNum,orig_unique_id),orig_unique_id),key,
		        KEYED(LEFT.orig_unique_id = RIGHT.Domain),						
						TRANSFORM(Layouts.AccLogId, self := RIGHT),
								LIMIT(Constant.LOGS_PER_DOMAIN,
								fail(203, doxie.ErrorCodes(203))));
		
		RETURN vks;
	END;
	
	SHARED Layouts.MainAccLogs makeLogRecord(Layouts.AccLogId le, 
				Accurint_AccLogs.key_RecordID ri, 
				IParam.SearchInterface aInputData) := TRANSFORM								
				SELF := ri;
				
	END;
	
	// Returns the main file data
	EXPORT getLogsResults(DATASET(Layouts.AccLogId) aRecordIds,
		IParam.SearchInterface aInputData):= FUNCTION	
			
    logRec0 := JOIN(aRecordIds, Accurint_AccLogs.key_RecordID,
                          KEYED(LEFT.record_id = RIGHT.record_id),                          
                          makeLogRecord(LEFT, RIGHT, aInputData),
													KEEP(1),
                          LIMIT(0));
		
		RETURN logRec0;
	END;
	
END;