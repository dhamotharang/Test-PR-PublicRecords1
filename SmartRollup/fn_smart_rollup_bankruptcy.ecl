import iesp,smartRollup;
                                            
export fn_smart_rollup_bankruptcy(dataset(iesp.bankruptcy.t_BankruptcyReport2Record) inRecs) := function
 outLayout := record
   string40 bankruptcy_id;
	 string1 active_closed;
	 unsigned4 regist_date_9999;
	 recordof(inRecs);
	end;
	outLayout f_it(inRecs l) := transform
	  self.bankruptcy_id := l.filingJurisdiction+'|'+l.caseType+'|'+l.caseNumber;
	  self.active_closed := SmartRollup.fn_blj_active_closed('B',l.Disposition, l.statusHistory[1]._type);
		dateToUse := map(iesp.ECL2ESP.DateToInteger(l.OriginalFilingDate) > 0 => iesp.ECL2ESP.DateToInteger(l.OriginalFilingDate),
                     iesp.ECL2ESP.DateToInteger(l.filingDate) > 0 => iesp.ECL2ESP.DateToInteger(l.filingDate),		                 
                     iesp.ECL2ESP.DateToInteger(l.reopenDate)	> 0 => iesp.ECL2ESP.DateToInteger(l.reopenDate),									 
										 iesp.ECL2ESP.DateToInteger(l.dischargeDate) > 0 => iesp.ECL2ESP.DateToInteger(l.dischargeDate),
										 iesp.ECL2ESP.DateToInteger(l.closedDate)
		                 );
		self.regist_date_9999 := 99999999 - dateToUse ;
		self := l;
	end;
	fRecs := project(inRecs, f_it(left));
	sRecs := SORT(fRecs,  bankruptcy_id, active_closed , regist_date_9999, record); 
	dRecs := DEDUP(sRecs, bankruptcy_id);
  finalSort := SORT(dRecs, active_closed, regist_date_9999);
	outRecs := project(finalSort, transform(iesp.smartlinxreport.t_SLRBankruptcy, self.activeClosed := LEFT.active_closed,self := LEFT ));
	RETURN outRecs; 
end;