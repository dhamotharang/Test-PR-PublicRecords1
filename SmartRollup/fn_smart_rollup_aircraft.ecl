import iesp;
export fn_smart_rollup_aircraft(dataset(iesp.faaaircraft.t_aircraftReportRecord) inRecs, integer inDID =0) := function
  outLayout := record
	 string40 aircraft_id;
	 string1 current_prior;
	 unsigned4 regist_date_9999;
	 recordof(inRecs);
	end;
	outLayout f_it(inRecs l) := transform
	  self.aircraft_id := l.aircraftnumber;
	  self.current_prior := if(l.STATUS[1] = 'A',iesp.Constants.SMART.CURRENT,iesp.Constants.SMART.PRIOR);
		self.regist_date_9999 := 99999999 - iesp.ECL2ESP.DateToInteger(l.dateLastSeen) ;
		self := l;
	end;
	fRecs := project(inRecs, f_it(left));
	sRecs := SORT(fRecs,  aircraft_id, current_prior , regist_date_9999, record); 
	dRecs := DEDUP(sRecs, aircraft_id);
  finalSort := SORT(dRecs, current_prior, regist_date_9999);
	outRecs := project(finalSort, transform(iesp.smartlinxreport.t_SLRAircraft, self.currentPrior := LEFT.current_prior,self := LEFT ));
	RETURN outRecs; 
end;