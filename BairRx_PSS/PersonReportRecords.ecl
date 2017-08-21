IMPORT BairRx_PSS, BairRx_Common, BairRx_Event, BairRx_CFS, BairRx_Crash, BairRx_Offender, Bair_ExternalLinkKeys, iesp, ut;

EXPORT PersonReportRecords(dataset(BairRx_PSS.IParam.PersonReportParam) in_params, integer max_results, boolean include_notes) := FUNCTION

	// Get raw recs and finally the entity IDs needed.
	dXLinkRecs := BairRx_PSS.SALTSearch.GetCleanRecs(in_params);			
	dMatchRecs := dXLinkRecs(match);   // should have DID/LexID since search was by LexID
	dEntityIDs := choosen(PROJECT(DEDUP(SORT(dMatchRecs, eid), eid), TRANSFORM(iesp.share.t_StringArrayItem, self.value := left.eid)), iesp.bair_constants.MAX_EID_RECS);
	
	iesp.bair_share.t_BAIRBaseReportBy xt() := TRANSFORM
		SELF.EntityIds := dEntityIDs;
		SELf := []
	end;
	
	// Take input EIDs and build a common input_params for use by report services
	search_EntityIDs := DATASET([xt()]);
	eid_params := BairRx_Common.IParam.getReportParams(search_EntityIDs); 

	// Event records
	EventRecs := BairRx_Event.ReportRecords(eid_params, max_results, include_notes);		
	
	// CFS records
	CFSRecs := BairRx_CFS.ReportRecords(eid_params, max_results, include_notes);
	
	// Crash records
	CrashRecs := BairRx_Crash.ReportRecords(eid_params, max_results, include_notes);
	
	// Offender records
	OffenderRecs := BairRx_Offender.ReportRecords(eid_params, max_results,include_notes); 
	
	// Possible names
	iesp.share.t_Name name_xt(recordof(dMatchRecs) l) := transform
		self.First   := l.fname; 
		self.Middle  := l.mname;
		self.Last    := l.lname;
		self := [];
	end;
	dNames_recs := project(dedup(sort(dMatchRecs, lname, fname, mname), lname, fname, mname), name_xt(left));
	
	// DOBs
	dob0 := dedup(sort(dMatchRecs(dob<>0), dob), dob);
	dDOBs := project(dob0, TRANSFORM(iesp.bair_person.t_BAIRPersonSearchDOB,
					                         _dob       := iesp.ECL2ESP.toDate(left.dob);
					                         self.Year  := _dob.Year;	
					                         self.Month := _dob.Month;	
					                         self.Day   := _dob.Day;	
					                         self.Age   := ut.GetAgeI(left.dob)
																	)
				          );
				
	// Addresses	
	addr0 := dedup(sort(dMatchRecs(BairRx_PSS.Constants.IsPersonalRecord(prepped_rec_type), prim_name<>'' or prim_range<>'' or p_city_name<>'' or st<>'' or zip<>''),
	                    st, p_city_name, zip, prim_range, prim_name), st, p_city_name, zip, prim_range, prim_name);
	dAddrs := project(addr0, transform(iesp.bair_share.t_BAIRAddressExt, 
							                       self.StreetNumber        := left.prim_range,
							                       self.StreetPreDirection  := left.predir,
							                       self.StreetName          := left.prim_name,
							                       self.StreetSuffix        := left.addr_suffix,
							                       self.StreetPostDirection := left.postdir,
							                       self.UnitDesignation     := left.unit_desig,
							                       self.UnitNumber          := left.sec_range,	
							                       self.StreetAddress1      := left.prepped_addr1,
							                       self.StreetAddress2      := left.prepped_addr2,						
							                       self.City                := left.p_city_name,
							                       self.State               := left.st,
							                       self.Zip5                := left.zip,							
							                       self.Zip4                := left.zip4,							
							                       self.County              := left.county,	
							                       self.Latitude            := left.latitude,
							                       self.Longitude           := left.longitude,
							                       self.AddressType         := BairRx_PSS.Constants.RecordTypeLabel(LEFT.prepped_rec_type),
							                       self := []
																		)
									 );
	
	// SSNs
	ssn0 := dedup(sort(dMatchRecs(possible_ssn <> ''), possible_ssn), possible_ssn);
	dSSNRecs := project(ssn0, transform(iesp.bair_person.t_BAIRPersonSearchSSN, self.SSN := left.possible_ssn));
	
	// put it all together
	iesp.bair_person.t_BAIRPersonReportResponse BuildResponse() := transform 
		self.LexID           := (string)in_params[1].lexid;
		self.Names           := choosen(dNames_recs, iesp.bair_constants.MAX_NAME_RECS);
		self.DOBs            := choosen(dDOBs, iesp.bair_constants.MAX_DOB_RECS);
		self.Addresses       := choosen(dAddrs, iesp.bair_constants.MAX_ADDRESS_RECS);
		self.PossibleSSNs    := choosen(dSSNRecs, iesp.bair_constants.MAX_SSN_RECS);
		self.EIDs            := project(dEntityIDs, transform(iesp.share.t_StringArrayItem, self := left, self := []));
		self.EventRecords    := project(choosen(EventRecs, iesp.bair_constants.MAX_RECS_PER_MODE),    
		                                transform(iesp.bair_person.t_BAIRPersonReportEventRecord, self := left, self := []));   
		self.CFSRecords      := project(choosen(CFSRecs, iesp.bair_constants.MAX_RECS_PER_MODE),      
		                                transform(iesp.bair_person.t_BAIRPersonReportCFSRecord, self := left, self := []));   
		self.CrashRecords    := project(choosen(CrashRecs, iesp.bair_constants.MAX_RECS_PER_MODE),                         
		                                transform(iesp.bair_person.t_BAIRPersonReportCrashRecord, self := left, self := []));   
		self.OffenderRecords := project(choosen(OffenderRecs.records, iesp.bair_constants.MAX_RECS_PER_MODE), 
		                                transform(iesp.bair_person.t_BAIRPersonReportOffenderRecord, self := left, self := []));   
		self := []
	end;
	
	ResultRecs := dataset([buildresponse()]); 
	
	// Some debug
	IF(BairRx_Common.Debug.IsMin(), output(in_params, named('in_params')));
	IF(BairRx_Common.Debug.IsMax(), output(dXLinkRecs, named('dXLinkRecs')));
	IF(BairRx_Common.Debug.IsMin(), output(dMatchRecs, named('dMatchRecs')));
	IF(BairRx_Common.Debug.IsMin(), output(dEntityIDs, named('dEntityIDs')));
	
	return ResultRecs;
	 
END;