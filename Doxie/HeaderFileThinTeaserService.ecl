/*--SOAP--
<message name="HeaderFileThinTeaserService">
  <part name="IndustryCLASS" type="xsd:string"/>
  <part name="SSN" type="xsd:string"/>
  <part name="SSNTypos" type="xsd:boolean"/>
	<part name="UnParsedFullName" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="RelativeFirstName1" type="xsd:string"/>
  <part name="RelativeFirstName2" type="xsd:string"/>
  <part name="LastName" type="xsd:string"/>
  <part name="OtherLastName1" type="xsd:string"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="PhoneticDistanceMatch" type="xsd:boolean"/>
  <part name="DistanceThreshold" type="xsd:unsignedInt"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="OtherCity1" type="xsd:string"/>
  <part name="County" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="OtherState1" type="xsd:string"/>
  <part name="OtherState2" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="ZipRadius" type="xsd:unsignedInt"/>
	<part name="CurrentResidentsOnly" type="xsd:boolean"/>
  <part name="Phone" type="xsd:string"/>
  <part name="DOB" type="xsd:unsignedInt"/>
  <part name="AgeLow" type="xsd:byte"/>
  <part name="AgeHigh" type="xsd:byte"/>
  <part name="AllowDateSeen" type="xsd:boolean"/>
  <part name="DateFirstSeen" type="xsd:integer"/>
  <part name="DateLastSeen" type="xsd:integer"/>
  <part name="DID" type="xsd:string" required="1"/>
  <part name="Household" type="xsd:boolean"/> 
  <part name="LookupType" type="xsd:string"/>
  <part name="RID" type="xsd:string"/>
  <part name="IncludeAllDIDRecords" type="xsd:boolean"/>
  <part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
  <part name="NoLookupSearch" type="xsd:boolean"/>
  <part name="BestOnly" type="xsd:boolean"/>
	<part name="CurrentOnly" type="xsd:boolean"/>
  <part name="DoNotFillBlanks" type="xsd:boolean"/> 
  <part name="Raw" type="xsd:boolean"/> 
	<part name="GroupByDID" type="xsd:boolean"/> 
  <part name="DIDOnly" type="xsd:boolean"/>
  <part name="ScoreThreshold" type="xsd:unsignedInt"/>
  <part name="AddressLimit" type="xsd:unsignedInt"/>
  <part name="SSNMask" type="xsd:string"/>
  <part name="DLMask" type="xsd:string"/>
  <part name="IncludeZeroDIDRefs" type="xsd:boolean"/>
  <part name="IncludeHRI" type="xsd:boolean"/>
  <part name="MaxHriPer" type="xsd:unsignedInt"/> 
  <part name="ProbationOverride" type="xsd:boolean"/>
  <part name="LnBranded" type="xsd:boolean"/>
  <part name="KeepOldSsns" type="xsd:boolean"/>
	<part name="DialRecordMatch" type="xsd:unsignedInt"/>
	<part name="DialContactPrecision" type="xsd:unsignedInt"/>
	<part name="DialBounceDistance" type="xsd:unsignedInt"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DidTypeMask" type="xsd:string"/>
  <part name="AllowWildcard" type="xsd:boolean"/>
  <part name="AllowHeaderQuick" type="xsd:boolean"/>
	<part name="IncludeRelativeNames" type="xsd:boolean"/>
	<part name="IncludePhonesFeedback" type="xsd:boolean"/>
	<part name="NonExclusion" type="xsd:boolean"/>
	<part name="ReducedData" type="xsd:boolean"/>
	<part name="StrictMatch" type="xsd:boolean"/>
	<part name="IncludeAddressCDSDetails" type="xsd:boolean"/>
	<part name="IncludeDLInfo" type="xsd:boolean"/>
</message>
*/
/*--INFO-- Special Thin teaser search (originally developed for PSM).
					Does a header search, then gets Best records back for the 
					matching DIDs (and transforms them into the rollup person search layouts
					for backward compatibility)
					
					Modifications have since been made to go directly against a Watchdog teaser key
					for the majority of requests in an effort to improve performance again.
*/
/*
<message name="HeaderFileThinTeaserService" wuTimeout="300000">

*/
IMPORT ut, watchdog, NID, suppress, standard, doxie;
			 
EXPORT HeaderFileThinTeaserService := MACRO
#constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
#Constant('applicationType',suppress.Constants.ApplicationTypes.Consumer);

	boolean  includeRelatives := false : stored('IncludeRelativeNames');

	// default values
	unsigned1 nameLimit := 5;
	unsigned1 addressLimit := 5;
	unsigned1 relativeLimit := 5;

	doxie.MAC_Header_Field_Declare();

	// get the dids
	dids := doxie.Get_Dids();

	PrefFirstMatch(string20 l, string20 r) :=
		NID.mod_PFirstTools.SUBPFLeqPFR(l,r) or NID.mod_PFirstTools.SUBPFLeqR(l,r);

	PrefFirstMatch2(string20 pfname, string20 r) := function
		return NID.mod_PFirstTools.SubLinPFR(pfname, r) or pfname[1..length(trim(r))]=r;
	end;
		
	PhoneticNameMatch(string20 l, string20 r) :=
	  metaphonelib.DMetaPhone1(l)[1..6] = metaphonelib.DMetaPhone1(r)[1..6] and
		datalib.namesimilar(l,r,1) <= 6;

	out_layout := RECORD
		doxie.Layout_Rollup.KeyRec_feedback - [output_seq_no, RelativeNames];
		DATASET(Standard.Name_DID) RelativeNames {MAXCOUNT(doxie.rollup_limits.relatives_names)};
	END;

	out_layout_plus := RECORD(out_layout)
		integer4 total_records;
	end;
	
	doxie.mac_best_records(dids,
												 did,
												 bestout,
												 dppa_ok,
												 glb_ok,
												 // use nonblank key
												 true,
												 doxie.DataRestriction.fixed_DRM,
												 include_dod := true);	

	out_layout_plus getRec(doxie.layout_best r, boolean bestaddr = false) := TRANSFORM
		// currently the only fuzzy options are nicknames/phonetics/zipradius, 
		// so penalt only needs to account for these
		self.penalt := doxie.FN_Tra_Penalty_Name(r.fname,r.mname,r.lname) +
								 doxie.FN_Tra_Penalty_Addr(r.predir,r.prim_range,r.prim_name,r.suffix,
																					 r.postdir,r.sec_range,r.city_name,r.st,
																					 r.zip);
	
		doxie.Layout_Rollup.NameRec makeName() := TRANSFORM
			self := r;
		END;
	
		self.nameRecs := dataset([makeName()]);
														 
		doxie.Layout_Rollup.AddrRec_feedback makeAddr() := TRANSFORM
			self.last_seen := r.addr_dt_last_seen;
			self.city_name := r.city_name;
			self.st := r.st;
			self.zip := r.zip;
			self.zip4 := r.zip4;	
			self := [];
		END;
  
		self.addrRecs := dataset([makeAddr()]);

		doxie.Layout_Rollup.DobRec makeDOB() := TRANSFORM
			self.dob := r.dob;
			self.age := ut.age(r.dob);
		END;
	
		self.dobRecs := dataset([makeDOB()]);
		dod := (unsigned4) r.dod;
		doxie.Layout_Rollup.DodRec makeDOD() := TRANSFORM
			self.dod := dod;
			self.dead_age := IF(dod<>0 and r.dob<>0, (dod-r.dob) div 10000, 0);
		END;
	
		self.dodRecs := dataset([makeDOD()]);
	
		self.did := INTFORMAT(r.did,12,1);
		self := r;
		
		self := [];
	END;

	// match them against the best file, and include the input criteria in the join to enable picking the best 
	best_info_hdr := topn(join(dids, bestout, 
										 (left.did=right.did) and
										 (lname_value = '' or right.lname = lname_value or
										     (phonetics and PhoneticNameMatch(right.lname,lname_value))) and
										 (fname_value = '' or right.fname = fname_value or 
										    (nicknames and PrefFirstMatch(right.fname,fname_value))) and
										 (state_value = '' or right.st = state_value or zipradius_value <> 0) and
										 (pname_value = '' or right.prim_name = pname_value) and
										 (zipradius_value = 0 or zip_value = [] or (integer4)right.zip in zip_value) and
										 (zipradius_value <> 0 or zip_val = '' or right.zip = zip_val) and
										 (zipradius_value <> 0 or city_value = '' or right.city_name = city_value), 
										 getRec(RIGHT)),
									MaxResultsThisTime_val,penalt,-addrRecs[1].last_seen, -total_records, addrRecs[1].zip, record);

	// for certain patterns, optimize the lookup by skipping get_dids and using new 
	// watchdog teaser key

	// want to always return results that match the input criteria
	// so use a choosen to pick a large enough sample (10K for now), then
	// a topn to pick the best candidates

	zips_within_city := ut.ZipsWithinCity(state_value, city_value);
	zips_within_city_strs :=set(project(dataset(zips_within_city,{Integer4 zip}),transform({string5 zip},self.zip:=intformat(left.zip,5,1))),zip);
	zip_value_strs :=set(project(dataset(zip_value,{Integer4 zip}),transform({string5 zip},self.zip:=intformat(left.zip,5,1))),zip);
		
	// A double project is required here to transform the fetched dataset to doxie.layout_best so
	// so the dataset can use the same transform getRec() as the join above.  The double project
	// can be eliminated by putting the join above and the code below into a function and using
	// a macro to call the transform, but this method is overkill.
	
	best_info_wdog := if(~(ut.glb_ok(GLB_purpose)) and doxie.DataRestriction.restrictPreGLB,
												topn(project(project(choosen(
														 watchdog.key_watchdog_teaser_v2(
																	keyed(lname = lname_value) and
																	keyed(state_value = '' or st = state_value) and
																	keyed(fname_value = '' or PrefFirstMatch2(pfname, fname_value)) and
																	Keyed(fname_value = '' or nicknames or fname = fname_value) and
																	keyed((zipradius_value = 0 or zip_value = [] or zip in zip_value_strs) and
																			(zipradius_value <> 0 or zip_val = '' or zip = zip_val) and
																			(zipradius_value <> 0 or city_value = '' or zip in zips_within_city_strs)))
																				,10000), doxie.layout_best),
																				getRec(LEFT, true)),
																	MaxResultsThisTime_val, penalt, -addrRecs[1].last_seen, -total_records, addrRecs[1].zip, record),
																	
													topn(project(project(choosen(
														 watchdog.key_watchdog_teaser(
																	keyed(lname = lname_value) and
																	keyed(state_value = '' or st = state_value) and
																	keyed(fname_value = '' or PrefFirstMatch2(pfname, fname_value)) and
																	Keyed(fname_value = '' or nicknames or fname = fname_value) and
																	keyed((zipradius_value = 0 or zip_value = [] or zip in zip_value_strs) and
																			(zipradius_value <> 0 or zip_val = '' or zip = zip_val) and
																			(zipradius_value <> 0 or city_value = '' or zip in zips_within_city_strs)))
																				,10000), doxie.layout_best),
																				getRec(LEFT, true)),
																	MaxResultsThisTime_val, penalt, -addrRecs[1].last_seen, -total_records, addrRecs[1].zip, record));
		
	// use the watchdog teaser key if possible (lname required; phonetics, mname, dob/age range not supported)
	best_info := IF(lname_value = '' or mname_value <> '' or dob_val <> 0 or agelow_val <> 0 or agehigh_val <> 0 
								or phonetics, best_info_hdr, best_info_wdog);	

	just_dids_hh := PROJECT(best_info,TRANSFORM(doxie.layout_references_hh, SELF.did := (unsigned)LEFT.did));
	hdr_recs := doxie.header_records_byDID(just_dids_hh);

	out_layout_plus combine(best_info l, DATASET(RECORDOF(hdr_recs)) r) := TRANSFORM
		names := l.nameRecs + PROJECT(r, doxie.Layout_Rollup.NameRec);
		SELF.nameRecs := CHOOSEN(DEDUP(SORT(names, RECORD), RECORD), nameLimit);
		
		doxie.Layout_Rollup.AddrRec_feedback makeAddrs(hdr_recs ri) := TRANSFORM
			self.last_seen := ri.dt_last_seen;
			self.city_name := ri.city_name;
			self.st := ri.st;
			self.zip := ri.zip;
			self.zip4 := ri.zip4;		
			self := [];
		END;
	
		// this is the consumer data that needs the dates to be inveted because the source
		// first_seen and last_seen are actually stored in te vendor dates.			
		doxie.Layout_Rollup.AddrRec_feedback makeAddrsCnsmr(hdr_recs ri) := TRANSFORM			
			self.city_name := ri.city_name;
			self.st := ri.st;
			self.zip := ri.zip;
			self.zip4 := ri.zip4;				
			self.dt_vendor_last_reported := ri.dt_last_seen;
			self.dt_vendor_first_reported := ri.dt_first_seen;
			self.last_seen := ri.dt_vendor_last_reported;
			self.first_seen := ri.dt_vendor_first_reported;
			self := [];
		END;
	
		rSorted := SORT(r, prim_name, city_name, zip, -dt_last_seen, record);

		uniqAddrs := DEDUP(rSorted, prim_name, city_name, zip);
		// do the sorting according to industry class because of dt_vendor_last_seen 
		// contains the actual date to be shown.
		uniqAddrsSorted := PROJECT(SORT(uniqAddrs, -dt_last_seen), makeAddrs(LEFT));
	
		cSorted := SORT(r, city_name, zip, -dt_last_seen, -dt_vendor_last_reported, record);
		
		recordof(cSorted) mytrans(cSorted l, cSorted r) := transform
				ut.mac_roll_DLS(dt_last_seen);
				ut.mac_roll_DLS(dt_vendor_last_reported);
				ut.mac_roll_DFS(dt_first_seen);
				ut.mac_roll_DFS(dt_vendor_first_reported);
				self := r;
		end;
		
		cUniqRollup := ROLLUP(cSorted, mytrans(left, right), 
					left.city_name = right.city_name and 
					left.zip = right.zip);
	
	 cUniqAddrsSorted := PROJECT(SORT(cUniqRollup, -dt_last_seen, -dt_vendor_last_reported), makeAddrsCnsmr(LEFT));
	
		// need to combine the slimmed addresses and dedup, keeping the best addr first		
		allAddrs := DEDUP(l.addrRecs & IF(ut.IndustryClass.is_knowx, cUniqAddrsSorted, uniqAddrsSorted), city_name, zip);
		//allAddrs := cUniqAddrsSorted;
	
		SELF.addrRecs := CHOOSEN(allAddrs, addressLimit);
		SELF := l;
	END;
//output(hdr_recs, named('hdr_recs'));
	recs_history := DENORMALIZE(best_info, hdr_recs, (unsigned)LEFT.did = RIGHT.did, GROUP, combine(LEFT,ROWS(RIGHT)));
	recs_use := IF(dial_recordmatch_value > 3, recs_history, best_info);

	// add relative names if requested
	just_dids := PROJECT(best_info,TRANSFORM(doxie.layout_references, SELF.did := (unsigned)LEFT.did));
	just_dids_grpd := group(just_dids, did);
	rels := doxie.relative_names(just_dids_grpd,false,industry_class_value='CNSMR');
 
	out_layout_plus addRels(best_info le, rels ri) :=	TRANSFORM
		SELF.RelativeNames := CHOOSEN(ri.names, relativeLimit);
		SELF := le;
	END;

	with_rels := JOIN(recs_use, rels, (unsigned6)LEFT.did=RIGHT.did, addRels(LEFT,RIGHT), LOOKUP, LEFT OUTER);

	final_res := IF(includeRelatives, with_rels, recs_use);
	final_sorted := SORT(final_res, penalt, -addrRecs[1].last_seen, -total_records, record);
	
  final_out := PROJECT(final_sorted, out_layout);
	Suppress.MAC_Suppress(final_out,final_out_clean,application_type_value,Suppress.Constants.LinkTypes.DID,did);

	doxie.MAC_Marshall_Results(final_out_clean, outfile);
	
	output(outfile, NAMED('Results'));

ENDMACRO;
// HeaderFileThinTeaserService();