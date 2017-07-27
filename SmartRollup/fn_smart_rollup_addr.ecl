import doxie, iesp, lib_word, ut,smartRollup;
export fn_smart_rollup_addr(dataset(iesp.bpsreport.t_BpsReportAddress) inRecs, integer inDid) := function
  tempLayout := record(recordof(inRecs))
	  integer did;
	  string pCity;
		integer fromDate;
		integer toDate
	end;
	tempLayout  setDates(inRecs l) := transform
	 self.did := inDid;
	 self.fromDate := iesp.ECL2ESP.DateToInteger(l.DateFirstSeen);
	 self.toDate := iesp.ECL2ESP.DateToInteger(l.DateLastSeen);;
	 self := l; 
	 self := [];
	end;
	//temporarily assign dates into integers so MACRO can roll them up.
	tempaddrs := project(inRecs,setDates(LEFT));
  smartRollup.MAC_suppress_ADDR_dups(tempaddrs, addrRecsPlus,AddressEx.StreetNumber, AddressEx.StreetPreDirection, 
	                                    AddressEx.StreetName, AddressEx.StreetPostDirection, AddressEx.StreetSuffix, AddressEx.UnitNumber, AddressEx.City, 
	                                    AddressEx.State,AddressEx.Zip5, fromDate, toDate,''/*inputCity*/);
	iesp.bpsreport.t_BpsReportAddress  assignDates(tempAddrs l) := transform
	  self.DateFirstSeen := iesp.ECL2ESP.todate(l.fromDate);
		self.DateLastSeen := iesp.ECL2ESP.todate(l.toDate);
		self := l;
	end;
	//move temporary dates back to there t_Date values.
	outrecs := project(addrRecsPlus, assignDates(left));
	RETURN outrecs; 
end;