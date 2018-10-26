/***
 ** Function takes a doxie formatted Person dataset and filter/project/transform into desired format.
 **	Clear the bad SSNs and defenestrate addresses that have not been seen in a long time.
***/
 
IMPORT doxie, iesp, ut, Address, AID_Build;

out_rec := iesp.identitymanagementreport.t_IdmPersonRecord;

// returns True if the date is longer ago than the years in our constant
// we're expecting DT to be input in YYYYMM format (no DD)
Boolean TooLongAgo(Integer3 DT) := 	FUNCTION
	today := StringLib.getdateYYYYMMDD();
	theDT := (String)DT + '01'; // now it's in YYYYMMDD format
	return ut.DaysApart(today, theDT) > ut.DaysInNYears(IdentityManagement_Services.Constants.MaxYearsSinceLastSeen);
END;


EXPORT out_rec format_person (dataset(doxie.layout_references) dids):= FUNCTION

  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule ());

	// 157096:UNIMPLEMENTED Activity <parameter> Error workaround.
	// Passed in only dids as input parameter and brought header_records_byDID here.
	hh_dids := project(dids, doxie.layout_references_hh);
	d_person := doxie.header_records_byDID(hh_dids, true,,,, true); //include dailies, include all records
 
	
	// #STEP-1: rollup addresses
	d_person_sorted := sort(d_person,
	                        prim_range, predir, prim_name, suffix, postdir, sec_range,
													city_name, st, zip, -dt_last_seen, dt_first_seen);
	
	doxie.Layout_presentation rollupAddr(doxie.Layout_presentation L, doxie.Layout_presentation R) := transform
			self.dt_last_seen := if(R.dt_last_seen > L.dt_last_seen, R.dt_last_seen, L.dt_last_seen);
			self.dt_first_seen := if(R.dt_first_seen < L.dt_first_seen and R.dt_first_seen <> 0, R.dt_first_seen,	L.dt_first_seen);
			self.sec_range := if(L.sec_range <> '', L.sec_range, R.sec_range);
			self.unit_desig := map(L.sec_range <> '' => L.unit_desig,
														R.sec_range <> '' => R.unit_desig,
														'');
			self.rawaid := IF(L.rawaid <> 0,L.rawaid,R.rawaid);
			self := L; // copy at least 20 other fields
	end;
	
	d_addresses 	:= rollup(d_person_sorted,
																left.prim_range = right.prim_range 
																and left.predir = right.predir
																and left.prim_name = right.prim_name
																and left.suffix = right.suffix
																and left.postdir = right.postdir
																and ((left.sec_range = right.sec_range) or (left.sec_range = ''))
																and left.city_name = right.city_name
																and left.st = right.st
																and left.zip = right.zip,																
																rollupAddr(left, right));


	// #STEP-2: add location (Latitude\Longitude) info to addresses.
	headerloc := RECORD
		doxie.Layout_presentation;
		string10 Latitude := '';
		string11 Longitude := '';
	END;
 
	headerloc get_location(doxie.Layout_presentation L, AID_Build.Key_AID_Base R) := transform
			self.Latitude  := R.geo_lat;
			self.Longitude := R.geo_long;
			SELF := L;	
	end;
	
	addr_aids := join (d_addresses, AID_Build.Key_AID_Base,
                   keyed (left.rawaid=right.rawaid),
                   get_location(LEFT,RIGHT),LEFT OUTER,LIMIT(0),KEEP(1));  


	// #STEP-3: project addresses into ESDL format
	iesp.identitymanagementreport.t_IdmAddressInfo formatAddr(headerloc  L) := transform
			self.filtered := L.dt_first_seen = L.dt_last_seen OR TooLongAgo(L.dt_last_seen); // formatted as YYYYMM, so this compares same month
			self.dateLastSeen := iesp.ECL2ESP.toDateYM((unsigned3)L.dt_last_seen);
			self.dateFirstSeen := iesp.ECL2ESP.toDateYM((unsigned3)L.dt_first_seen);
			Addr  := iesp.ECL2ESP.SetAddress(
															L.prim_name, L.prim_range, L.predir, L.postdir, L.suffix, L.unit_desig, L.sec_range,
															L.city_name, L.st, L.zip, L.zip4, L.county_name, '',
															Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name, l.suffix, l.postdir, l.unit_desig, l.sec_range),
															'',
															Address.Addr2FromComponents(l.city_name, l.st, l.zip));
			self.Address := ROW(Addr,TRANSFORM(iesp.share.t_AddressWithGeoLocation,
																					SELF.Latitude := L.Latitude,
																					SELF.Longitude := L.Longitude, SELF := LEFT));			
	end;
		
	AddressWithGeo := SORT(PROJECT(addr_aids,formatAddr(LEFT)),-dateLastSeen,dateFirstSeen); 
		
	// Added Name Akas
	iesp.share.t_Name getakas(doxie.Layout_presentation L) := transform
			string full_name := StringLib.StringCleanSpaces (L.fname + ' ' + L.mname + ' ' + L.lname);
			self.Full    := full_name;
			self.First	 := L.fname;
			self.Middle  := L.mname;
			self.Last  	 := L.lname;
			self.Suffix  := L.name_suffix;
			self 				 := [];
	end;
	
	// Fetch Akas
	name_akas :=   DEDUP(SORT(PROJECT(d_person_sorted,getakas(LEFT)),FULL),FULL); 
					
						
  // Fetch records from the best file; this will be the base for the subject's record to return
  best_recs := doxie.best_records(dids, , FALSE, FALSE, modAccess := mod_access);
	
	// Transform only required fields						
	doxie.Layout_presentation toheader(doxie.layout_best L) := TRANSFORM
		SELF.did 					:= L.did;
		SELF.valid_ssn 		:= IF(L.valid_ssn='G',L.valid_ssn,'');
		SELF.ssn 					:= IF(L.valid_ssn='G',L.ssn,'');
		SELF.dob 					:= L.dob;  
		SELF.title 				:= L.title;  
		SELF.fname 				:= L.fname;  
		SELF.mname				:= L.mname;  
		SELF.lname 				:= L.lname;  
		SELF.name_suffix 	:= L.name_suffix;  
		SELF := [];
	END;
	person_best := PROJECT(best_recs,toheader(LEFT));
	// Calling common function to add SSN info to header records. Bug: 165034.					
	ssnrecs := Functions.add_ssn_issue(person_best);		
		 	 
	// Transforming to the output layout
	out_rec toOut(layouts.headerRecordEx L) := transform
			//self.did := L.did;
			string full_name := StringLib.StringCleanSpaces (L.fname + ' ' + L.mname + ' ' + L.lname);
			Self.Name := iesp.ECL2ESP.SetName (L.fname, L.mname, L.lname, L.name_suffix, L.title, full_name);
			IssuedStartDate := 	iesp.ECL2ESP.toDate(L.ssn_issue_early_fulldate);
			IssuedEndDate   :=  iesp.ECL2ESP.toDate(L.ssn_issue_last_fulldate);
 			// nmd
			self.SSNInfo.SSN              := if(L.ssn_valid_issue,L.SSN, '');
			self.SSNInfo.IssuedStartDate	:= if(L.ssn_valid_issue,IssuedStartDate);
			self.SSNInfo.IssuedEndDate		:= if(L.ssn_valid_issue,IssuedEndDate);
			self.SSNInfo.IssuedLocation		:= if(L.ssn_valid_issue,L.ssn_issue_state, '');
		                                                                       
			self.dob := iesp.ECL2ESP.toDate ((integer) L.dob);
			self.Addresses := choosen(AddressWithGeo, iesp.Constants.IDM.MaxAddress);
			self.gender := iesp.ECL2ESP.GetGender (L.title);
			self.Akas := choosen(name_akas, iesp.Constants.IDM.MaxAkas);
			self := []; // clear about 10 other fields
	end;
	person_recs := project(ssnrecs,toOut(left));

/*******
	// DEBUG
	OUTPUT(d_person       ,   NAMED('d_person'));
	OUTPUT(d_person_sorted,   NAMED('d_person_sorted'));
	OUTPUT(d_addresses,       NAMED('d_addresses'));
	OUTPUT(person_rec,        NAMED('person_rec'));
	OUTPUT(ssn_w_legacy_info, NAMED('ssn_w_legacy_info'));
	OUTPUT(person_w_ssn_info, NAMED('person_w_ssn_info'));
/*******/

	RETURN person_recs;
	
END;