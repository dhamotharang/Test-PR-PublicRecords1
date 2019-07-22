import _Control, risk_indicators, gong, ut, targus, FCRA, Phonesplus_v2;
onThor := _Control.Environment.OnThor;

export getDirsByAddr(dataset(Risk_Indicators.Layouts.Layout_Input_Plus_Overrides) input, boolean isFCRA=false, unsigned1 glb=0, unsigned8 BSOptions=0) := function

glb_ok := Risk_Indicators.iid_constants.glb_ok(glb, isFCRA);	
	
layout_dirs_address add_gong(input le, gong.Key_History_Address rt) := transform
	self.src := 'GH';
	self := rt;
end;

// check corrections
layout_dirs_address gong_corr(input le, FCRA.Key_Override_Gong_FFID ri) := TRANSFORM
	self.src := 'GH';
	self := ri;
	// self := [];	// p3, p7, phone7, area_code
end;
gong_correct_roxie := join(input, FCRA.Key_Override_Gong_FFID,
												keyed(right.flag_file_id in left.gong_correct_ffid),
												gong_corr(left, right), atmost(right.flag_file_id in left.gong_correct_ffid, 100));

gong_correct_thor := join(input(gong_correct_ffid <> []), pull(FCRA.Key_Override_Gong_FFID),
												(right.flag_file_id in left.gong_correct_ffid),
												gong_corr(left, right), all, LOCAL);
												
#IF(onThor)
	gong_correct := gong_correct_thor;
#ELSE
	gong_correct := gong_correct_roxie;
#END

// get gong history using the input address
g_history_non_fcra_roxie := join(input, gong.Key_History_Address,
										trim(left.prim_name)!='' and trim(left.z5)!='' and
										(keyed(right.prim_name=left.prim_name) and keyed(right.st=left.st) and keyed(right.z5=left.z5) and
										keyed(right.prim_range=left.prim_range) and ut.NNEQ(left.sec_range,right.sec_range)),
										add_gong(left,right),
										ATMOST(
											(keyed(right.prim_name=left.prim_name) and keyed(right.st=left.st) and keyed(right.z5=left.z5) and
											 keyed(right.prim_range=left.prim_range)),
											RiskWise.max_atmost
										),
										keep(100));

g_history_non_fcra_thor := join(distribute(input(trim(prim_name)!='' and trim(z5)!=''), hash64(prim_name, z5, prim_range)), 
										distribute(pull(gong.Key_History_Address(trim(prim_name)!='' and trim(z5)!='')), hash64(prim_name, z5, prim_range)),
										((right.prim_name=left.prim_name) and (right.st=left.st) and (right.z5=left.z5) and
										(right.prim_range=left.prim_range) and ut.NNEQ(left.sec_range,right.sec_range)),
										add_gong(left,right),
										ATMOST(
											((right.prim_name=left.prim_name) and (right.st=left.st) and (right.z5=left.z5) and
											 (right.prim_range=left.prim_range)),
											RiskWise.max_atmost
										),
										keep(100), LOCAL);

#IF(onThor)
	g_history_non_fcra := g_history_non_fcra_thor;
#ELSE
	g_history_non_fcra := g_history_non_fcra_roxie;
#END

g_history_fcra_roxie := join(input, gong.Key_FCRA_History_Address,
										trim(left.prim_name)!='' and trim(left.z5)!='' and
										(keyed(right.prim_name=left.prim_name) and keyed(right.st=left.st) and keyed(right.z5=left.z5) and
										keyed(right.prim_range=left.prim_range) and ut.NNEQ(left.sec_range,right.sec_range)) and
										trim((string12)right.did+(string10)right.phone10+(string8)right.dt_first_seen) not in left.gong_correct_record_id,
										add_gong(left,right),
										ATMOST(
											(keyed(right.prim_name=left.prim_name) and keyed(right.st=left.st) and keyed(right.z5=left.z5) and
											 keyed(right.prim_range=left.prim_range)),
											RiskWise.max_atmost
										),
										keep(100));
										
g_history_fcra_thor := join(distribute(input(trim(prim_name)!='' and trim(z5)!=''), hash64(prim_name, z5, prim_range)), 
										distribute(pull(gong.Key_FCRA_History_Address(trim(prim_name)!='' and trim(z5)!='')), hash64(prim_name, z5, prim_range)),
										((right.prim_name=left.prim_name) and (right.st=left.st) and (right.z5=left.z5) and
										(right.prim_range=left.prim_range) and ut.NNEQ(left.sec_range,right.sec_range)) and
										trim((string12)right.did+(string10)right.phone10+(string8)right.dt_first_seen) not in left.gong_correct_record_id,
										add_gong(left,right),
										ATMOST(
											((right.prim_name=left.prim_name) and (right.st=left.st) and (right.z5=left.z5) and
											 (right.prim_range=left.prim_range)),
											RiskWise.max_atmost
										),
										keep(100), LOCAL);
										
#IF(onThor)
	g_history_fcra := g_history_fcra_thor;
#ELSE
	g_history_fcra := g_history_fcra_roxie;
#END

g_history := if(isFCRA, g_history_fcra, g_history_non_fcra);										

							 // do we need to group here?		
combined := ungroup(gong_correct + g_history);
combo := if(isFCRA, /*group( sort (*/ combined/*, seq), seq)*/, g_history);	
						

// no longer use today's date for the calculation, use the build date							
cdate := Risk_Indicators.get_Build_date('targus_build_version');
												

Layout_Dirs_Address add_targus(input le, targus.Key_Targus_Address rt) := transform
	self.phone10 := if(stringlib.stringtouppercase(rt.phone_number[8..10])='XXX', rt.phone_number[1..7], rt.phone_number);
	//self.area_code := rt.phone_number[1..3];
	//self.phone7 := rt.phone_number[4..10];
	self.dt_first_seen := (string6)rt.dt_first_seen + '01';
	self.dt_last_seen := (string6)rt.dt_last_seen + '01';
	self.current_record_flag := if(ut.DaysApart(cdate, (STRING6)rt.dt_last_seen + '01') > 62, 'No', 'Yes');
	self.current_flag := if(ut.DaysApart(cdate, (STRING6)rt.dt_last_seen + '01') > 62, false, true);
	self.business_flag := false;
	self.listing_type_res := 'R';
	self.name_first := rt.fname;
	self.name_middle := rt.minit;
	self.name_last := rt.lname;
	self.p_city_name := rt.city_name;
	self.st := rt.st;
	self.z5 := rt.zip;
	self.z4 := rt.zip4;
	self.county_code := rt.county;
	self.geo_lat := rt.cleanaddress[146..155];
	self.geo_long := rt.cleanaddress[156..166];
	self.publish_code := if(stringlib.stringtouppercase(rt.phone_number[8..10])='XXX', '', 'P');
	self.src := 'WP';
	self := rt;
	self := [];
end;
// get targus white pages info using the input address
targus_wp_nonfcra_roxie := join(input, targus.Key_Targus_Address,
														trim(left.prim_name)!='' and trim(left.z5)!='' and
														(keyed(right.prim_name=left.prim_name) and keyed(right.zip=left.z5) and
														keyed(right.prim_range=left.prim_range) and ut.NNEQ(left.sec_range,right.sec_range)),
														add_targus(left,right),
														ATMOST(
															(keyed(right.prim_name=left.prim_name) and keyed(right.zip=left.z5) and
															keyed(right.prim_range=left.prim_range)),
															RiskWise.max_atmost
														),
														keep(100));
														
targus_wp_nonfcra_thor := join(distribute(input(trim(prim_name)!='' and trim(z5)!=''), hash64(prim_name, z5, prim_range)),  
														distribute(pull(targus.Key_Targus_Address(trim(prim_name)!='' and trim(z5)!='')), hash64(prim_name, zip, prim_range)),
														((right.prim_name=left.prim_name) and (right.zip=left.z5) and
														(right.prim_range=left.prim_range) and ut.NNEQ(left.sec_range,right.sec_range)),
														add_targus(left,right),
														ATMOST(
															((right.prim_name=left.prim_name) and (right.zip=left.z5) and
															(right.prim_range=left.prim_range)),
															RiskWise.max_atmost
														),
														keep(100), LOCAL);
														
#IF(onThor)
	targus_wp_nonfcra := targus_wp_nonfcra_thor;
#ELSE
	targus_wp_nonfcra := targus_wp_nonfcra_roxie;
#END

targus_wp_fcra_roxie := join(input, targus.Key_Targus_FCRA_Address,
												trim(left.prim_name)!='' and trim(left.z5)!='' and
												(keyed(right.prim_name=left.prim_name) and keyed(right.zip=left.z5) and
												keyed(right.prim_range=left.prim_range) and ut.NNEQ(left.sec_range,right.sec_range)),
												add_targus(left,right),
												ATMOST(
													(keyed(right.prim_name=left.prim_name) and keyed(right.zip=left.z5) and
													keyed(right.prim_range=left.prim_range)),
													RiskWise.max_atmost
												),
												keep(100));
targus_wp_fcra_thor := join(distribute(input(trim(prim_name)!='' and trim(z5)!=''), hash64(prim_name, z5, prim_range)),  
												distribute(pull(targus.Key_Targus_FCRA_Address(trim(prim_name)!='' and trim(z5)!='')), hash64(prim_name, zip, prim_range)),
												((right.prim_name=left.prim_name) and (right.zip=left.z5) and
												(right.prim_range=left.prim_range) and ut.NNEQ(left.sec_range,right.sec_range)),
												add_targus(left,right),
												ATMOST(
													((right.prim_name=left.prim_name) and (right.zip=left.z5) and
													(right.prim_range=left.prim_range)),
													RiskWise.max_atmost
												),
												keep(100), LOCAL);

#IF(onThor)
	targus_wp_fcra := targus_wp_fcra_thor;
#ELSE
	targus_wp_fcra := targus_wp_fcra_roxie;
#END

targus_wp := if(isFCRA, targus_wp_fcra, targus_wp_nonfcra);


// Call phones plus, initially for CIID v1
Layout_Dirs_Address addPP(input le, Phonesplus_v2.Keys_Scoring().address.qa rt) := transform
	self.src := 'PA';
	self.phone10 := rt.cellphone;
	// self.area_code := rt.cellphone[1..3];
	// self.phone7 := rt.cellphone[4..10];
	self.dt_first_seen := (string6)rt.datefirstseen + '01';
	self.dt_last_seen := (string6)rt.datelastseen + '01';
	self.current_record_flag := 'Yes';
	self.current_flag := true;
	self.business_flag := false;
	self.listing_type_res := rt.listingtype;
	self.name_first := rt.fname;
	self.name_middle := rt.mname;
	self.name_last := rt.lname;
	self.p_city_name := rt.p_city_name;
	self.st := rt.state;
	self.z5 := rt.zip5;
	self.z4 := rt.zip4;
	self.geo_lat := rt.geo_lat;
	self.geo_long := rt.geo_long;
	self.publish_code := 'P';
	self.suffix := rt.addr_suffix;
	self := rt;
	self := [];			
end;
// get phones plus using the input address
phonesPlusNonFcraTemp_roxie := join(input, Phonesplus_v2.Keys_Scoring().address.qa,
																	trim(left.prim_name)!='' and trim(left.z5)!='' and
																	(keyed(right.prim_name=left.prim_name) and  keyed(right.zip5=left.z5) and
																	keyed(right.prim_range=left.prim_range) and ut.NNEQ(left.sec_range,right.sec_range)) and
																	(GLB_ok OR TRIM(right.glb_dppa_flag) not in ['G','B']),
																	addPP(left,right),
																	ATMOST(
																		(keyed(right.prim_name=left.prim_name) and keyed(right.zip5=left.z5) and
																		keyed(right.prim_range=left.prim_range)),
																		RiskWise.max_atmost
																	),
																	keep(100));

phonesPlusNonFcraTemp_thor := join(distribute(input(trim(prim_name)!='' and trim(z5)!=''), hash64(prim_name, z5, prim_range)), 
																	distribute(pull(Phonesplus_v2.Keys_Scoring().address.qa(trim(prim_name)!='' and trim(zip5)!='')), hash64(prim_name, zip5, prim_range)),
																	((right.prim_name=left.prim_name) and  (right.zip5=left.z5) and
																	(right.prim_range=left.prim_range) and ut.NNEQ(left.sec_range,right.sec_range)) and
																	(GLB_ok OR TRIM(right.glb_dppa_flag) not in ['G','B']),
																	addPP(left,right),
																	ATMOST(
																		((right.prim_name=left.prim_name) and (right.zip5=left.z5) and
																		(right.prim_range=left.prim_range)),
																		RiskWise.max_atmost
																	),
																	keep(100), LOCAL);

#IF(onThor)
	phonesPlusNonFcraTemp := phonesPlusNonFcraTemp_thor;
#ELSE
	phonesPlusNonFcraTemp := phonesPlusNonFcraTemp_roxie;
#END

phonesPlusNonFcra := if((BSOptions & risk_indicators.iid_constants.BSOptions.IsInstantIDv1) > 0 and ~isFCRA, phonesPlusNonFcraTemp);
			
in_house := dedup(sort(combo + targus_wp + phonesPlusNonFcra, -phone10, -dt_last_seen, name_last, name_first,listed_name, record), record);  

return in_house;

end;