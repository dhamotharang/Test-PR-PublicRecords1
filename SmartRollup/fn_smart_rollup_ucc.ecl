import iesp;
export fn_smart_rollup_ucc(dataset(iesp.ucc.t_UCCReport2Record) inRecs,integer inDID) := function
   outLayout := record
	  string1   subject_is;
		string40  ucc_id;
		string1   active_inactive;
		unsigned4 regist_date_9999;
		recordof(inRecs);
	end;
	inActiveTypeSet := ['RELEASE','EXPUNGED','DELETED','LAPSED','TERMINATED','TERMINATION','UCC3 TERMINATION'];
	inActiveStatusSet := ['D','E','L','EXPUNGED'];
	outLayout assignType(inRecs L) := transform
	  self.subject_is := map(count(L.Debtors2.parsedParties((integer)uniqueId=inDid)) > 0 => iesp.Constants.SMART.DEBTOR,
		                       count(L.Secureds2.parsedParties((integer)uniqueId=inDid)) > 0 or
		                       count(L.creditors2.parsedParties((integer)uniqueId=inDid)) > 0 or
 		                       count(L.Assignees2.parsedParties((integer)uniqueId=inDid)) > 0 => iesp.Constants.SMART.SECURER,
													  iesp.Constants.SMART.UNKNOWN);  
	  self.ucc_id := l.filingJurisdiction+'|'+l.originFilingNumber;
	  //CHECK for specific values in 2 fields (Status Type and Filing Type)  
		isInactive := (count(L.filings2(stringlib.StringToUpperCase(stringlib.stringfilterout(_type,'-')) in inActiveTypeSet)) > 0)
		               OR (L.filingStatus in inActiveStatusSet);
	  self.active_inactive := if (isInactive,iesp.Constants.SMART.INACTIVE,iesp.Constants.SMART.ACTIVE);
    self.regist_date_9999 := 99999999 - iesp.ECL2ESP.DateToInteger(l.OriginFilingDate);																					
		self := l
	end;
  fRecs := project(inRecs, assignType(LEFT));
	sRecs   := SORT(fRecs,  subject_is, ucc_id, active_inactive , regist_date_9999, record); 
	dRecs   := DEDUP(sRecs, subject_is, ucc_id);
  finalSort := SORT(dRecs,  subject_is, active_inactive, regist_date_9999); 
	outRecs := project(finalSort, transform(iesp.smartlinxreport.t_SLRUcc, self.SubjectIs := LEFT.subject_is,self.activeInActive := LEFT.active_inactive,self := LEFT ));
	RETURN outRecs; 
end;