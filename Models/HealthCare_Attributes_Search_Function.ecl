IMPORT STD, Address, Models, ut, risk_indicators, easi, doxie, Header, dx_header, MDR, drivers, Riskwise, gateway, DeathV2_Services, AutoStandardI, Suppress;

EXPORT HealthCare_Attributes_Search_Function(
														DATASET(Models.layouts.Layout_HealthCare_Attributes_In) indata,
														UNSIGNED1 GLBPurpose,
														UNSIGNED1 DPPAPurpose,
														STRING50 DataRestriction = risk_indicators.iid_constants.default_DataRestriction,
														STRING50 DataPermission = risk_indicators.iid_constants.default_DataPermission,
                                                        unsigned1 LexIdSourceOptout = 1,
                                                        string TransactionID = '',
                                                        string BatchUID = '',
                                                        unsigned6 GlobalCompanyId = 0
													) := FUNCTION

mod_access := MODULE(Doxie.IDataAccess)
	EXPORT glb := GLBPurpose;
	EXPORT dppa := DPPAPurpose;
	EXPORT unsigned1 lexid_source_optout := LexIdSourceOptout;
	EXPORT string transaction_id := TransactionID; // esp transaction id or batch uid
	EXPORT unsigned6 global_company_id := GlobalCompanyId; // mbs gcid
END;

/* ***************************************
	 *            Clean Input:             *
   *************************************** */
	 
	risk_indicators.Layout_Input intoInput(Models.layouts.Layout_HealthCare_Attributes_In le) := TRANSFORM
		cleanDOB := RiskWise.cleanDOB(le.DateOfBirth);

		self.DID := le.did;
		SELF.phone10 := le.HomePhone;
		SELF.wphone10 := le.WorkPhone;
		SELF.seq := (INTEGER)le.Seq;	
		SELF.ssn := IF(le.SSN='000000000', '', le.SSN);	// blank out social if it is all 0's
		SELF.dob := cleanDOB;
		SELF.age := IF(TRIM(cleanDOB) = '', '', (STRING3)ut.Age((INTEGER)cleanDOB));
		SELF.fname := le.FirstName;
		SELF.mname := le.MiddleName;
		SELF.lname := le.LastName;
		SELF.suffix := le.SuffixName;
		clean_addr := risk_indicators.MOD_AddressClean.clean_addr(le.streetAddr, le.City, le.State, le.Zip) ;											
		SELF.in_streetAddress := le.streetAddr;
		SELF.in_city := le.City;
		SELF.in_state := le.State;
		SELF.in_zipCode := le.Zip;

		SELF.prim_range := Address.CleanFields(clean_addr).prim_range;
		SELF.predir := Address.CleanFields(clean_addr).predir;
		SELF.prim_name := Address.CleanFields(clean_addr).prim_name;
		SELF.addr_suffix := Address.CleanFields(clean_addr).addr_suffix;
		SELF.postdir := Address.CleanFields(clean_addr).postdir;
		SELF.unit_desig := Address.CleanFields(clean_addr).unit_desig;
		SELF.sec_range := Address.CleanFields(clean_addr).sec_range;
		SELF.p_city_name := Address.CleanFields(clean_addr).p_city_name;
		SELF.st := Address.CleanFields(clean_addr).st;
		SELF.z5 := Address.CleanFields(clean_addr).zip;
		SELF.zip4 := Address.CleanFields(clean_addr).zip4;
		SELF.lat := Address.CleanFields(clean_addr).geo_lat;
		SELF.long := Address.CleanFields(clean_addr).geo_long;
		SELF.addr_type := Address.CleanFields(clean_addr).rec_type[1];
		SELF.addr_status := Address.CleanFields(clean_addr).err_stat;
		SELF.county := Address.CleanFields(clean_addr).county[3..5]; // we only want the county fips, not all 5.  first 2 are the state fips
		SELF.geo_blk := Address.CleanFields(clean_addr).geo_blk;
		
		self.historydate := le.historydate;
		SELF := [];
	END;
	
	cleanIn := project(indata, intoInput(LEFT));
	
	
/* ***************************************
	 *     Set Boca Shell Parameters:      *
   *************************************** */
	 
	UNSIGNED1 bsVersion := 3;  // estimated income doesn't currently need all the stuff we added for version 4
	BOOLEAN	require2Ele := FALSE;  // don't need, this is a riskwise legacy thing
	BOOLEAN isLn := FALSE;  // ln_branded is not used
	BOOLEAN doRelatives := true;
	BOOLEAN doDL := true;
	BOOLEAN doVehicle := true;
	BOOLEAN doDerogs := true;
	BOOLEAN suppressNearDups := FALSE;  // not needed
	BOOLEAN fromBIID := FALSE;  // not calling InstantID function from within Business instantID
	BOOLEAN isFCRA := FALSE;  // not FCRA query
	BOOLEAN fromIT1O := FALSE;  // not a legacy IT1O query, don't need the extra phone searching IT1O does
	BOOLEAN doScore := FALSE;  // don't need to append Fraudpoint scores for this function
	BOOLEAN nugen := FALSE;   // this is a reason codes setting inside of IID reason codes, don't need to turn this on
	BOOLEAN isUtility := FALSE;  // don't need to search utility records for estimated income
	BOOLEAN ofacOnly := FALSE;  // don't search watchlists at all
	BOOLEAN ofacSearching := FALSE;// don't search watchlists at all
	UNSIGNED1 ofacVersion := 0;// don't search watchlists at all
	BOOLEAN includeAdditionalWatchlists := FALSE;// don't search watchlists at all
	BOOLEAN excludeWatchlists := TRUE; // don't search watchlists at all
	BOOLEAN filterOutFares := false;  //  we can use all property data here unless we hear otherwise
	gateways := Gateway.Constants.void_gateway;

/* ***************************************
	 *     Gather Boca Shell Results:      *
   *************************************** */
	iid := Risk_Indicators.InstantID_Function(cleanIn, gateways, DPPAPurpose, GLBPurpose, isUtility, isLn, ofacOnly, 
																					suppressNearDups, require2Ele, fromBIID, isFCRA, excludeWatchlists, fromIT1O, ofacVersion, ofacSearching, includeAdditionalWatchlists,
																					in_BSversion := bsVersion, in_DataRestriction := DataRestriction, in_DataPermission := DataPermission,
                                                                                    LexIdSourceOptout := LexIdSourceOptout, 
                                                                                    TransactionID := TransactionID, 
                                                                                    BatchUID := BatchUID, 
                                                                                    GlobalCompanyID := GlobalCompanyID);

	clam := Risk_Indicators.Boca_Shell_Function(iid, gateways, DPPAPurpose, GLBPurpose, isUtility, isLn, doRelatives, doDL, 
																						doVehicle, doDerogs, bsVersion, doScore, nugen, filterOutFares, DataRestriction := DataRestriction, DataPermission := DataPermission,
                                                                                        LexIdSourceOptout := LexIdSourceOptout, 
                                                                                        TransactionID := TransactionID, 
                                                                                        BatchUID := BatchUID, 
                                                                                        GlobalCompanyID := GlobalCompanyID);
		
/* ***************************************
	 *       Gather Health Care Attributes:        *
   *************************************** */
	
//Beginning of model code

rHeader := record
	integer 		seq;
	UNSIGNED3 	EstimatedHHIncome;
	string12		in_DID;
	dx_header.layouts.i_header_address;
end;

rStats := record
	data				addrID;
	integer8		adults_cnt;
	integer8		adult_age;
	decimal8_2	ave_adult;
	decimal8_2	var_adult_age;
	decimal8_2	stdev_adult;
	integer8		children_cnt;
	integer8		child_age;
	decimal8_2	ave_child;
	decimal8_2	var_child_age;
	decimal8_2	stdev_children;
end;

rDemo := record
	integer			seq;
	data				addrID;
	string28 		prim_name;
	string12		did;
	string20		fname;
	string20		lname;
	integer8		dob;
	integer8		dod;
	integer8		age;
	string12		geolink;
	integer8		HHID_count := 1;
	integer8		HHID_parent_count;
	integer8		HHID_adulteen_count;
	integer8		HHID_child_count;
	UNSIGNED3 	EstimatedHHIncome;
	string12		in_DID;
end;

rFinal := record
	integer8		seq;
	string28 		prim_name;
	string12		did;
	integer8		dod;
	string12		GEOLINK;
	integer8		HHID_count;
	integer8		HHID_parent_count;
	integer8		HHID_adulteen_count;
	integer8		HHID_child_count;
	decimal8_2	EstimatedHHSize;
	string2			HHOccupantDescription;
	decimal8_2	CensusAveHHSize;
	UNSIGNED3 	EstimatedHHIncome;
	string12		in_DID;
	rstats;
end;

rAttributes := record
	integer 		seq;
	string12		did;
	Models.layouts.Layout_HealthCare_Attributes;
end;

header_addr := dx_header.key_header_address();

unsigned3 	LastSeenThreshold := Risk_Indicators.iid_constants.oneyear;
	
//Join the input address to the key_header_address to get all header records for the address
//*** kwh - possible enhancement??  We are possibly losing DOB's in the below join since we are only keeping recs with last seen date within last year, which sometimes is missing DOB and therefore not kept.  
//*** There can be older header records (not within last year) that do have the DOB.  Can we append DOB from an older record to the record/s we do keep?

rHeader getHeader(clam l, header_addr r) := transform
	self.seq 	:= l.seq;
	self.EstimatedHHIncome := l.estimated_income;
	self.in_DID := (string)l.did;
	self 			:= r;
end;

glb_ok 	:= Risk_Indicators.iid_constants.glb_ok(GLBPurpose, isFCRA);
dppa_ok := Risk_Indicators.iid_constants.dppa_ok(DPPApurpose, isFCRA);

hdr_Recs_unsuppressed := join(clam, header_addr,									
								keyed(left.Shell_Input.prim_name = right.prim_name) and
								keyed(left.Shell_Input.z5 = right.zip) and
								keyed(left.Shell_Input.prim_range = right.prim_range) and
								keyed(left.Shell_Input.sec_range = right.sec_range) and
								right.dob <> 0 and
								trim(left.Shell_Input.addr_suffix) = trim(right.suffix) and
								trim(left.Shell_Input.predir) = trim(right.predir) and
								trim(left.Shell_Input.postdir) = trim(right.postdir) and
								// check permissions of the user
								right.src not in risk_indicators.iid_constants.masked_header_sources(DataRestriction, isFCRA) AND
								// glb check
								glb_ok AND
								// dppa check
								(	~mdr.Source_is_DPPA(RIGHT.src) OR 
									(dppa_ok AND drivers.state_dppa_ok(mdr.sourceTools.translateSource(RIGHT.src),DPPApurpose,RIGHT.src))) and
								// last seen date is within a year
								ut.DaysApart(Risk_Indicators.iid_constants.myGetDate(left.historydate), (string)right.dt_last_seen) <= LastSeenThreshold,
								getHeader(left, right), left outer, keep(200), ATMOST(RiskWise.max_atmost));

hdr_Recs := Suppress.MAC_SuppressSource(hdr_Recs_unsuppressed, mod_access);

//Dedup the header address file by DID, keeping record with most recent last seen date
hdr_Rec_DID := dedup(sort(hdr_Recs, did, -dt_last_seen),did);		


//Join the address record to Death Master - pick up DOD and build AID, GEOlink and determine age for counting adults and children 
{rDemo, UNSIGNED4 global_sid} getDemos(hdr_Rec_DID l, doxie.key_death_masterV2_ssa_DID r) := transform
		self.global_sid := r.global_sid;
        self.addrID := Header.AddressID_fromparts(l.prim_range,l.predir,l.prim_name,l.suffix,l.postdir,l.sec_range,l.zip,l.st);
		address_cat := l.prim_range + ' ' + l.predir + ' ' + l.prim_name + ' ' + l.suffix + ' ' + l.postdir + ' ' + l.unit_desig + ' ' + l.sec_range;
		clean_address := Risk_Indicators.MOD_AddressClean.clean_addr(address_cat, l.city_name, l.st, l.zip);
		self.geolink := clean_address[115..116]+clean_address[143..145]+clean_address[171..177];
		self.dob := l.dob;
		self.did := (string)l.did;
		self.prim_name := l.prim_name;
		self.dod := (integer)r.dod8;
		ages := if(l.dob > 0,(INTEGER)((STRING8)Std.Date.Today())[1..4] - (integer)((STRING)l.dob)[1..4],0);
		self.age := ages;
		self.HHID_count := if((integer)r.dod8 = 0, 1, 0);
		self.HHID_parent_count := if(ages >=25, 1, 0);		
		self.HHID_adulteen_count := if(ages < 25 and ages > 19, 1, 0);
		self.HHID_child_count := if(ages > 0 and ages < 19, 1, 0);
		self := l;
		self := [];
end;

deathparams := DeathV2_Services.IParam.GetDeathRestrictions(AutoStandardI.GlobalModule());
hdr_Rec_DOD_unsuppressed := join(hdr_Rec_DID, doxie.key_death_masterV2_ssa_DID,  
					left.did <> 0 and																					  
					keyed(left.did = right.l_did) and
					not DeathV2_Services.functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
					getDemos(left, right), left outer, keep(1), ATMOST(RiskWise.max_atmost));

hdr_Rec_DOD := Suppress.Suppress_ReturnOldLayout(hdr_Rec_DOD_unsuppressed, mod_access, rDemo);
//Sort by address ID to again get all same household members grouped together
//*** kwh - changed to sort by addrID instead of seq. Is the sort by geolink necessary...would it always be the same within addrID?
srtd_by_AID := sort(hdr_Rec_DOD, addrID, geolink, dod);  //12/27 - add sort by DOD to ensure that a deceased person is not the only record kept later in the rollup


//Calculate household statistics by address ID
stats_adults := TABLE(srtd_by_AID(age >= 24 and dod =0), {addrID,  //12/27 - added dod check to not count deceased
		adults_cnt := COUNT(GROUP),
		adult_age := SUM(GROUP, age),
		ave_adult := AVE(group, age),
		var_adult_age := VARIANCE(GROUP, age),
		stdev_adult := sqrt(variance(group, age))
		},addrID ,few);

stats_children := TABLE(srtd_by_AID(age < 24 and age > 0 and dod =0), {addrID,  //12/27 - added dod check to not count deceased
		children_cnt := COUNT(GROUP),
		child_age := SUM(GROUP, age),
		ave_child := AVE(group, age),
		var_child_age := VARIANCE(GROUP, age),
		stdev_children := sqrt(variance(group, age))
		},addrID ,few);


//Join the adult stats and child stats tables
rStats joinStats(stats_adults l, stats_children r) := transform
	self := l;
	self := r;
end;

wStats := join(stats_adults, stats_children,
					left.addrID = right.addrID,
					joinStats(left, right),full outer);


//Do rollup of all records that are of the same address ID (household) and sum counts of total occupants, adults, college age, children
rDemo peopleRoll(rDemo l, rDemo r) := transform
	self.HHID_count := IF(r.dod =0, l.HHID_count + r.HHID_count, l.HHID_count);  //12/27 - check for deceased and do not count if so
	self.HHID_parent_count := IF(r.dod =0, l.HHID_parent_count + r.HHID_parent_count, l.HHID_parent_count);
	self.HHID_adulteen_count := IF(r.dod = 0, l.HHID_adulteen_count + r.HHID_adulteen_count, l.HHID_adulteen_count);
	self.HHID_child_count := IF(r.dod = 0, l.HHID_child_count + r.HHID_child_count, l.HHID_child_count);
	self := l;
	self := [];
end;
rollCounts := rollup(srtd_by_AID, peopleRoll(left,right), addrID);  


//Filter out the deceased
//*** kwh - possible enhancement? Filtering by DOD here (after the rollup) could cause an entire address (household)
//*** to be dropped if the deceased person happens to be the record that is kept in the rollup.  Should we filter out 
//*** deceased people before the peopleRoll rollup so they are not even counted?
// rollAddr := rollCounts(dod = 0); 12/27 - instead of dropping deceased, not counting them in earlier rollups and stats  
rollAddr := rollCounts;    


//Join to the census file to pick up household size.  Also pick up median hh income if we were not able to determine income from Boca shell.
rFinal getCensus(rollAddr l, EASI.Key_Easi_Census r) := transform
		self.addrID := l.addrID;
		self.prim_name := l.prim_name;
		self.CensusAveHHSize := (decimal8_2)r.HHSize; 
		self.EstimatedHHIncome := if(l.EstimatedHHIncome=0 and r.med_hhinc!='', (integer)r.med_hhinc, l.EstimatedHHIncome);  
		self := r;
		self := l;
		self := [];
end;

wCensus := join(rollAddr, EASI.Key_Easi_Census,
					// left.geolink <> '' and     //kwh - records not having geolink were already dropped in srtd_by_AID
					keyed(left.geolink = right.geolink),
					getCensus(left, right), left outer, keep(1), ATMOST(RiskWise.max_atmost));


//Append stats 
rFinal getStats(wCensus l, wStats r) := transform
		self := r;
		self := l;
		self := [];
end;

wAllStats := join(wCensus, wStats,
					left.addrID = right.addrID,
					getStats(left, right), left outer, keep(1), ATMOST(RiskWise.max_atmost));


//Calculate hhsize
/*For HH clusters 46 and over
1 or 2 Adults show average age in band and stdev < 5
Round to census ave HHSize 

For HH Clusters 24-45
1 or 2 Adults with average age between 23 and 26 with stdev < 5
Compare Census HH counts with actual count.
If actual count = census count and hh4_plus_p > hh3_p, increment actual count by 1

For HH Clusteres 19-23 showing signs of cohorts
2+ Adults show average age between 18 and 24 with stdev <=3
No mods
*/
rFinal calcHHSize(wAllStats l) := transform
	hhsize_base := map(l.ave_adult > 45.0 and l.stdev_adult < 5.0 => l.HHID_count,
										(l.ave_adult between 24.0 and 45.0) and l.stdev_adult < 5.0 and l.HHID_child_count <= 1 => l.HHID_parent_count + l.HHID_child_count + 1,
										(l.ave_adult between 24.0 and 45.0) and l.stdev_adult < 5.0 and l.HHID_child_count > 1 	=> l.HHID_parent_count + l.HHID_child_count,
										 l.HHID_count);
	
	hhsize_adj := if(hhsize_base = 0 and l.dod =0, l.CensusAveHHSize, hhsize_base);  //do not default to census hhsize if deceased (address may be vacant)
	
	self.EstimatedHHSize := if(l.prim_name = '', 0, hhsize_adj);  //blank prim_name means input address did not match the header so set attributes to default
	
//*** kwh - Potential enhancement - additional reason code value that indicates "unknown", for when there was at least one address 
//***       record on the header file for a person who did not have a DOB.  This means there is potentially more people at the
//***				household than we were able to determine.  
//***				Also - would another potential enhancement be that we take each of the household members from the address header and 
//***				search for their most recent (best) address?  There seem to be cases where we are over counting here because of header 
//***				records existing on the address file for people who no longer actually reside there.  (recently moved out etc...)  				 
	self.HHOccupantDescription	:= map(l.prim_name ='' => 'ND', 																	 	//unable to verify input address
												 l.dod <> 0  => 'AV', 																				//Address Potentially Vacant - only person at the input address is deceased
												 l.stdev_adult >= 10.0 and l.hhid_parent_count > 1 => 'MG', 	//potentially multi-generational
												(l.ave_adult between 19.0 and 23.0) and l.stdev_adult < 4.0 and l.HHID_child_count = 0 and l.hhid_parent_count > 2  => 'RM', //potentially roommates - college ages
												(l.ave_adult between 24.0 and 45.0) and l.stdev_adult < 5.5 and l.HHID_child_count <= 2 and l.hhid_parent_count > 2 => 'PM', //potentially multi-family - or bad data
												'TH');																												//Traditional household
	self := l;
end;

final := project(wAllStats, calcHHSize(left));

// output(final,,'~jshaw::out::HHsize',thor, overwrite);


//Final project into the Health Care Attribute layout 
rAttributes projHCA(final l) := transform
	self.did := l.in_DID;  //return the DID that is associated with the input name/address (from the BOCA shell)
	self := l;
	self := [];
end;

HCAttributes := project(sort(final, seq), projHCA(left)); 
// HCAttributes := project(final, projHCA(left)); 

// output(clam, named('clam'));
// output(hdr_Recs, named('hdr_Recs'));
// output(hdr_Rec_DID, named('hdr_Rec_DID'));
// output(hdr_Rec_DOD, named('hdr_Rec_DOD'));
// output(srtd_by_AID, named('srtd_by_AID'));
// output(stats_adults, named('stats_adults'));
// output(stats_children, named('stats_children'));
// output(wStats, named('wStats'));
// output(rollAddr, named('rollAddr'));
// output(wAllStats, named('wAllStats'));
// output(final, named('final'));
// output(HCAttributes, named('HCAttributes'));

	RETURN(HCAttributes);
	
END;
