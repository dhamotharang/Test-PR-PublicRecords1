import _Control, risk_indicators, gong, ut, targus, LIB_Date, FCRA, Inquiry_AccLogs, PhonesPlus_V2, gateway, nid;
onThor := _Control.Environment.OnThor;

export getDirsByPhone(dataset(Risk_Indicators.Layouts.Layout_Input_Plus_Overrides) input, dataset(Gateway.Layouts.Config) gateways, unsigned1 dppa, unsigned1 glb,
											boolean isFCRA=false, unsigned BSOptions=0, unsigned lastSeenThreshold=risk_indicators.iid_constants.oneyear, 
											string ExactMatchLevel=risk_indicators.iid_constants.default_ExactMatchLevel, string companyID='') := function
											
glb_ok := Risk_Indicators.iid_constants.glb_ok(glb, isFCRA);											

// check corrections
Layout_Dirs_Phone gong_corr(input le, FCRA.Key_Override_Gong_FFID ri) := TRANSFORM
	self.src := 'GH';
	self := ri;
	self := [];	// p3, p7, phone7, area_code
end;
gong_correct_roxie := join(input, FCRA.Key_Override_Gong_FFID,
												keyed(right.flag_file_id in left.gong_correct_ffid),
												gong_corr(left, right), atmost(right.flag_file_id in left.gong_correct_ffid, 100));

gong_correct_thor := join(input(gong_correct_ffid<>[]), pull(FCRA.Key_Override_Gong_FFID),
												(right.flag_file_id in left.gong_correct_ffid),
												gong_corr(left, right), LOCAL, ALL);
												
#IF(onThor)
	gong_correct := gong_correct_thor;
#ELSE
	gong_correct := gong_correct_roxie;
#END

Layout_Dirs_Phone add_gong(input le, gong.key_history_phone rt) := transform
	self.src := 'GH';
	self := rt;
end;
// get gong history using the input phone
g_history_non_fcra_roxie := join(input, gong.Key_History_phone,
										trim(left.phone10)!= '' and keyed(right.p3=left.phone10[1..3]) and keyed(right.p7=left.phone10[4..10]),									 
									add_gong(left,right), ATMOST(keyed(right.p3=left.phone10[1..3]) and keyed(right.p7=left.phone10[4..10]),RiskWise.max_atmost),keep(100));

g_history_non_fcra_thor := join(distribute(input(trim(phone10)!= ''), hash64(phone10)), 
										 distribute(pull(gong.Key_History_phone), hash64(p3+p7)),
										 (right.p3=left.phone10[1..3]) and (right.p7=left.phone10[4..10]),									 
									add_gong(left,right), ATMOST((right.p3=left.phone10[1..3]) and (right.p7=left.phone10[4..10]),RiskWise.max_atmost),keep(100), LOCAL);

#IF(onThor)
	g_history_non_fcra := g_history_non_fcra_thor;
#ELSE
	g_history_non_fcra := g_history_non_fcra_roxie;
#END

g_history_fcra_roxie := join(input, gong.Key_FCRA_History_Phone,
										trim(left.phone10)!= '' and keyed(right.p3=left.phone10[1..3]) and keyed(right.p7=left.phone10[4..10]) and
									  trim((string12)right.did+(string10)right.phone10+(string8)right.dt_first_seen) not in left.gong_correct_record_id,
									add_gong(left,right), ATMOST(keyed(right.p3=left.phone10[1..3]) and keyed(right.p7=left.phone10[4..10]),RiskWise.max_atmost),keep(100));

g_history_fcra_thor := join(distribute(input(trim(phone10)!= ''), hash64(phone10)), 
										distribute(pull(gong.Key_FCRA_History_Phone), hash64(p3+p7)),
										(right.p3=left.phone10[1..3]) and (right.p7=left.phone10[4..10]) and
									  trim((string12)right.did+(string10)right.phone10+(string8)right.dt_first_seen) not in left.gong_correct_record_id,
									add_gong(left,right), ATMOST((right.p3=left.phone10[1..3]) and (right.p7=left.phone10[4..10]),RiskWise.max_atmost),keep(100), LOCAL);

#IF(onThor)
	g_history_fcra := g_history_fcra_thor;
#ELSE
	g_history_fcra := g_history_fcra_roxie;
#END

g_history := if(isFCRA, g_history_fcra, g_history_non_fcra);			

combined := ungroup(gong_correct + g_history);
combo := if(isFCRA, /*group( sort (*/ combined/*, seq), seq)*/, g_history);														


// no longer use today's date for the calculation, use the build date							
cdate := Risk_Indicators.get_Build_date('targus_build_version');


						
Layout_Dirs_Phone add_targus(input le, targus.Key_Targus_Phone rt) := transform
	self.src := 'WP';
	self.phone10 := rt.phone_number;
	self.area_code := rt.phone_number[1..3];
	self.phone7 := rt.phone_number[4..10];
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
	self.z5 := rt.cleanaddress[117..121];
	self.z4 := rt.zip4;
	self.county_code := rt.county;
	self.geo_lat := rt.cleanaddress[146..155];
	self.geo_long := rt.cleanaddress[156..166];
	self.publish_code := if(rt.phone_number[7..10]='0000', 'U', 'P');
	self := rt;
	self := [];
end;

// JRP 02/01/2008 - EOM

// get targus white pages info using the input phone
targus_wp_nonfcra_roxie := join(input, targus.Key_Targus_Phone,
														trim(left.phone10)!= '' and keyed(right.p3=left.phone10[1..3]) and keyed(right.p7=left.phone10[4..10]),
													add_targus(left,right), ATMOST(keyed(right.p3=left.phone10[1..3]) and keyed(right.p7=left.phone10[4..10]),RiskWise.max_atmost),keep(100));

targus_wp_nonfcra_thor := join(distribute(input(trim(phone10)!= ''), hash64(phone10)), 
														 distribute(pull(targus.Key_Targus_Phone), hash64(p3+p7)),
														 (right.p3=left.phone10[1..3]) and (right.p7=left.phone10[4..10]),
													add_targus(left,right), ATMOST((right.p3=left.phone10[1..3]) and (right.p7=left.phone10[4..10]),RiskWise.max_atmost),keep(100), LOCAL);

#IF(onThor)
	targus_wp_nonfcra := targus_wp_nonfcra_thor;
#ELSE
	targus_wp_nonfcra := targus_wp_nonfcra_roxie;
#END

targus_wp_fcra_roxie := join(input, targus.Key_Targus_FCRA_Phone,
												trim(left.phone10)!= '' and keyed(right.p3=left.phone10[1..3]) and keyed(right.p7=left.phone10[4..10]),
											add_targus(left,right), ATMOST(keyed(right.p3=left.phone10[1..3]) and keyed(right.p7=left.phone10[4..10]),RiskWise.max_atmost),keep(100));
											
targus_wp_fcra_thor := join(distribute(input(trim(phone10)!=''), hash64(phone10)), 
											 distribute(pull(targus.Key_Targus_FCRA_Phone), hash64(p3+p7)),
											(right.p3=left.phone10[1..3]) and (right.p7=left.phone10[4..10]),
											add_targus(left,right), ATMOST((right.p3=left.phone10[1..3]) and (right.p7=left.phone10[4..10]),RiskWise.max_atmost),keep(100), LOCAL);

#IF(onThor)
	targus_wp_fcra := targus_wp_fcra_thor;
#ELSE
	targus_wp_fcra := targus_wp_fcra_roxie;
#END

targus_wp := if(isFCRA, targus_wp_fcra, targus_wp_nonfcra);			



// Add call to phones plus, initially for CIID v1
ppkey := Phonesplus_v2.Keys_Scoring().phone.qa;
Layout_Dirs_Phone addPP(input le, ppkey rt) := transform 
	self.src := 'PP';
	self.p7 := rt.cellphone[4..10];
	self.p3 := rt.cellphone[1..3];
	self.phone10 := rt.cellphone;
	self.area_code := rt.cellphone[1..3];
	self.phone7 := rt.cellphone[4..10];
	self.dt_first_seen := (string6)rt.datefirstseen + '01';
	self.dt_last_seen := (string6)rt.datelastseen + '01';
	self.current_record_flag := 'Yes';	// We are considering these all to be current
	self.current_flag := true;	// We are considering these all to be current
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
	self := rt;
	self := [];
end;
// get phones plus using the input phone
phonesPlusNonFcraTemp_roxie := join(input, ppkey,
										trim(left.phone10)!= '' and keyed(left.phone10=right.cellphone) and
										(GLB_ok OR TRIM(right.glb_dppa_flag) not in ['G','B']),									 
									addPP(left,right), ATMOST(keyed(left.phone10=right.cellphone),RiskWise.max_atmost),keep(100));

phonesPlusNonFcraTemp_thor := join(distribute(input(trim(phone10)!=''), hash64(phone10)), 
										distribute(pull(ppkey), hash64(cellphone)),
										(left.phone10=right.cellphone) and
										(GLB_ok OR TRIM(right.glb_dppa_flag) not in ['G','B']),									 
									addPP(left,right), ATMOST((left.phone10=right.cellphone),RiskWise.max_atmost),keep(100), LOCAL);
									
#IF(onThor)
	phonesPlusNonFcraTemp := phonesPlusNonFcraTemp_thor;
#ELSE
	phonesPlusNonFcraTemp := phonesPlusNonFcraTemp_roxie;
#END

phonesPlusNonFcra := if((BSOptions & risk_indicators.iid_constants.BSOptions.IsInstantIDv1) > 0 and ~isFCRA, phonesPlusNonFcraTemp);							

			
in_house := combo + targus_wp + phonesPlusNonFcra;



// only send the records to insurance gateway that haven't already gotten a hit on phone
risk_indicators.Layout_Input prepInsPhones(input le, in_house rt) := transform
	self.phone10 := if(trim(le.phone10)='' /*or trim(le.wphone10)=''*/, skip, le.phone10);
	self := le;
end;
insurance_gw_prep := join(input, in_house, (left.phone10=right.phone10), prepInsPhones(left, right), full only);

// check to see if insurance is requested
doInsurance := (BSOptions & risk_indicators.iid_constants.BSOptions.IncludeInsNAP) > 0 and ~isFCRA;
insurance_gw := if(count(insurance_gw_prep)>0 and glb_ok and doInsurance, 
																						risk_indicators.getInsurancePhoneGW(insurance_gw_prep, gateways, glb, lastSeenThreshold, companyID, ExactMatchLevel, isFCRA));



in_house_with_insurance := in_house + insurance_gw;

// if insurance hit is only a phone match, this will get blanked out in the merge logic, so go to targus gw for only a phone match on IP
in_house_with_insurance_temp := in_house_with_insurance(src<>'IP' OR (src='IP' AND (name_first<>'' OR name_last<>'' OR prim_name<>'')));

layout_waterfall_check := record
	boolean good_result;
	Layout_Dirs_Phone;
end;

ExactFirstNameRequired := ExactMatchLevel[risk_indicators.iid_constants.posExactFirstNameMatch]=risk_indicators.iid_constants.sTrue;
ExactLastNameRequired := ExactMatchLevel[risk_indicators.iid_constants.posExactLastNameMatch]=risk_indicators.iid_constants.sTrue;
ExactAddrRequired := ExactMatchLevel[risk_indicators.iid_constants.posExactAddrMatch]=risk_indicators.iid_constants.sTrue;
ExactPhoneRequired := ExactMatchLevel[risk_indicators.iid_constants.posExactPhoneMatch]=risk_indicators.iid_constants.sTrue;
ExactFirstNameRequiredAllowNickname := ExactMatchLevel[risk_indicators.iid_constants.posExactFirstNameMatchNicknameAllowed]=risk_indicators.iid_constants.sTrue;

layout_waterfall_check check_phones_plus(input le, Layout_Dirs_Phone rt) := transform	
	firstscore := risk_indicators.FnameScore(le.fname, rt.name_first);
	n1 := NID.PreferredFirstNew(le.fname);
	n2 := NID.PreferredFirstNew(rt.name_first);
	firstmatch := risk_indicators.iid_constants.g(firstscore) and if(ExactFirstNameRequired, le.fname=rt.name_first, true) and
							  if(ExactFirstNameRequiredAllowNickname, le.fname=rt.name_first or n1=n2, true);			
	lastscore := risk_indicators.LnameScore(le.lname, rt.name_last);
	lastmatch := risk_indicators.iid_constants.g(lastscore) and if(ExactLastNameRequired, le.lname=rt.name_last, true);
	addrscore := Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range, 
																						rt.prim_range, rt.prim_name, rt.sec_range);
																						
	addrmatch := risk_indicators.iid_constants.ga(addrscore) and if(ExactAddrRequired, le.prim_range=rt.prim_range and le.prim_name=rt.prim_name and 
																																			(le.in_zipcode=rt.z5 or le.z5=rt.z5 or 
																																						(le.in_city=rt.p_city_name and le.in_state=rt.st) or (le.p_city_name=rt.p_city_name and le.st=rt.st)) and
																																			ut.nneq(le.sec_range,rt.sec_range), true);
	
	// check that the phonesplus record actually has some matching information
	// for any source other than phonesplus consider the information a good_result
	self.good_result := rt.src<>'PP' or
											(rt.src='PP' and (firstmatch or lastmatch or addrmatch));  // we could do this for any internal source since we apparently only pay Targus GW when we get a hit
											// but do this now just for PhonesPlus until we have better understanding of the impacts to latency and cost		
								
	self := rt;
end;

waterfall_check := join(input, in_house_with_insurance,
	trim(left.phone10)<>'' and 
	left.phone10=right.phone10,
	check_phones_plus(left, right), keep(400));

// run some stats now on what we've found internally to determine which phones to send to the gateway
phone_source_table := table(waterfall_check, {phone10, src, good_results := count(group, good_result) }, phone10, src );
waterfall_phone_table := table(phone_source_table, {phone10, src_count := count(group),	good_result_count := count(group, good_results>0)}, phone10 );
garbage_phones := waterfall_phone_table(src_count=1 and good_result_count=0);

// throw out any garbage phone results so we can still check Targus gateway on those phones to get some more complete listing data
valid_internal_listings := join(waterfall_check, garbage_phones, left.phone10=right.phone10,
	transform(layout_waterfall_check, self := left), left only);
	

// only send the records to targus gateway that are valid POTS and haven't already gotten a hit on phone
risk_indicators.Layout_Input prep(input le, valid_internal_listings rt) := transform
	self.phone10 := if(trim(le.phone10)='' or trim(le.wphone10)='', skip, le.phone10);
	self := le;
end;

targus_gw_prep := join(input, valid_internal_listings, (left.phone10=right.phone10), prep(left, right), full only);

targus_gw := if(count(targus_gw_prep)>0, risk_indicators.getTargusGW(targus_gw_prep, gateways, dppa, glb), dataset([], layout_dirs_phone));
// output(insurance_gw_prep, named('insurance_gw_prep'));
// output(insurance_gw, named('insurance_gw'));
// output(gateways, named('gateways'));

// OUTPUT(input, NAMED('INPUT'));
// output(waterfall_check, named('waterfall_check'));
// output(phone_source_table, named('phone_source_table'));
// output(waterfall_phone_table, named('waterfall_phone_table'));
// output(garbage_phones, named('garbage_phones'));
// output(valid_internal_listings, named('valid_internal_listings'));
// output(targus_gw_prep, named('targus_gw_prep'));

return dedup(sort(in_house_with_insurance + targus_gw, phone10, -dt_last_seen, name_last, name_first,listed_name,record), record);

end;