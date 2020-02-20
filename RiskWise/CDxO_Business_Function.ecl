import Risk_Indicators, Models, Business_Risk, gateway, Riskwise;

export CDxO_Business_Function(DATASET(Layout_CD2I) indata, 
															dataset(Gateway.Layouts.Config) gateways, 
															unsigned1 glb, 
															unsigned1 dppa,
															string4 tribcode,
                              unsigned1 ofac_version = 1,
                              boolean include_ofac = false,
                              real global_watchlist_threshold = 0.84,
															string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
															string50 DataPermission=risk_indicators.iid_constants.default_DataPermission,
                                                            unsigned1 LexIdSourceOptout = 1,
                                                            string TransactionID = '',
                                                            string BatchUID = '',
                                                            unsigned6 GlobalCompanyId = 0) := 

FUNCTION

// THIS IS ONLY CALLED FOR nd10
// Added nd11 and parameter for tribcode.

Business_Risk.Layout_BIID_BtSt into_btst_in(indata le) := TRANSFORM
	// Clean BillTo
	clean_a := Risk_Indicators.MOD_AddressClean.clean_addr(le.addr, le.city, le.state, le.zip);
	
	hphone_val := RiskWise.cleanPhone( le.hphone );
	wphone_val := RiskWise.cleanPhone( le.wphone );
	dl_num_clean := RiskWise.cleanDL_num( le.drlc );
	
	
	self.bill_to_input.seq := le.seq;
	self.bill_to_input.historydate := le.historydate;
	self.bill_to_input.bdid := 0;
	self.bill_to_input.score := 0;
	self.bill_to_input.account := le.account;
	self.bill_to_input.company_name := stringlib.stringtouppercase(le.cmpy);
	self.bill_to_input.prim_range := clean_a[1..10];
	self.bill_to_input.predir := clean_a[11..12];
	self.bill_to_input.prim_name := clean_a[13..40];
	self.bill_to_input.addr_suffix := clean_a[41..44];
	self.bill_to_input.postdir := clean_a[45..46];
	self.bill_to_input.unit_desig := clean_a[47..56];
	self.bill_to_input.sec_range := clean_a[57..64];
	self.bill_to_input.p_city_name := clean_a[90..114];
	self.bill_to_input.v_city_name := clean_a[65..89];
	self.bill_to_input.st := clean_a[115..116];
	self.bill_to_input.z5 := if(clean_a[117..121]<>'', clean_a[117..121], le.zip[1..5]);
	self.bill_to_input.zip4 := '';
	self.bill_to_input.orig_z5 := le.zip[1..5];
	self.bill_to_input.lat := clean_a[146..155];
	self.bill_to_input.long := clean_a[156..166];
	self.bill_to_input.addr_type := clean_a[139]; 
	self.bill_to_input.addr_status := clean_a[179..182]; 
	self.bill_to_input.phone10 := wphone_val;
	self.bill_to_input.ip_addr := le.ipaddr;
	self.bill_to_input.rep_fname := stringlib.stringtouppercase(le.first);
	self.bill_to_input.rep_lname := stringlib.stringtouppercase(le.last);
	self.bill_to_input.rep_prim_range := clean_a[1..10];
	self.bill_to_input.rep_predir := clean_a[11..12];
	self.bill_to_input.rep_prim_name := clean_a[13..40];
	self.bill_to_input.rep_addr_suffix := clean_a[41..44];
	self.bill_to_input.rep_postdir := clean_a[45..46];
	self.bill_to_input.rep_unit_desig := clean_a[47..56];
	self.bill_to_input.rep_sec_range := clean_a[57..64];
	self.bill_to_input.rep_p_city_name := clean_a[90..114];
	self.bill_to_input.rep_st := clean_a[115..116];
	self.bill_to_input.rep_z5 := if(clean_a[117..121]<>'', clean_a[117..121], le.zip[1..5]);
	self.bill_to_input.rep_zip4 := '';
	self.bill_to_input.rep_orig_city := stringlib.stringtouppercase(le.city);
	self.bill_to_input.rep_orig_st := stringlib.stringtouppercase(le.state);
	self.bill_to_input.rep_orig_z5 := le.zip[1..5];
	self.bill_to_input.rep_lat := clean_a[146..155];
	self.bill_to_input.rep_long := clean_a[156..166];
	self.bill_to_input.rep_addr_type := clean_a[139];
	self.bill_to_input.rep_addr_status := clean_a[179..182];
	self.bill_to_input.rep_phone := hphone_val;
	self.bill_to_input.rep_dl_num := stringlib.stringtouppercase(dl_num_clean);
	self.bill_to_input.rep_dl_state := stringlib.stringtouppercase(le.drlcstate);
	self.bill_to_input.rep_email := le.email;
	
	
	// Clean ShipTo
	clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(le.addr2, le.city2, le.state2, le.zip2);
	
	hphone_val2 := RiskWise.cleanPhone( le.hphone2 );
	
	self.ship_to_input.seq := le.seq;
	self.ship_to_input.historydate := le.historydate;
	self.ship_to_input.bdid := 0;
	self.ship_to_input.score := 0;
	self.ship_to_input.account := le.account;
	self.ship_to_input.company_name := stringlib.stringtouppercase(le.cmpy2);
	self.ship_to_input.prim_range := clean_a2[1..10];
	self.ship_to_input.predir := clean_a2[11..12];
	self.ship_to_input.prim_name := clean_a2[13..40];
	self.ship_to_input.addr_suffix := clean_a2[41..44];
	self.ship_to_input.postdir := clean_a2[45..46];
	self.ship_to_input.unit_desig := clean_a2[47..56];
	self.ship_to_input.sec_range := clean_a2[57..64];
	self.ship_to_input.p_city_name := clean_a2[90..114];
	self.ship_to_input.v_city_name := clean_a2[65..89];
	self.ship_to_input.st := clean_a2[115..116];
	self.ship_to_input.z5 := if(clean_a2[117..121]<>'', clean_a2[117..121], le.zip2[1..5]);
	self.ship_to_input.zip4 := '';
	self.ship_to_input.orig_z5 := le.zip2[1..5];
	self.ship_to_input.lat := clean_a2[146..155];
	self.ship_to_input.long := clean_a2[156..166];
	self.ship_to_input.addr_type := clean_a2[139]; 
	self.ship_to_input.addr_status := clean_a2[179..182]; 
	self.ship_to_input.phone10 := hphone_val2;	// there is no wphone on input, so use hphone?
	self.ship_to_input.rep_fname := stringlib.stringtouppercase(le.first2);
	self.ship_to_input.rep_lname := stringlib.stringtouppercase(le.last2);
	self.ship_to_input.rep_prim_range := clean_a2[1..10];
	self.ship_to_input.rep_predir := clean_a2[11..12];
	self.ship_to_input.rep_prim_name := clean_a2[13..40];
	self.ship_to_input.rep_addr_suffix := clean_a2[41..44];
	self.ship_to_input.rep_postdir := clean_a2[45..46];
	self.ship_to_input.rep_unit_desig := clean_a2[47..56];
	self.ship_to_input.rep_sec_range := clean_a2[57..64];
	self.ship_to_input.rep_p_city_name := clean_a2[90..114];
	self.ship_to_input.rep_st := clean_a2[115..116];
	self.ship_to_input.rep_z5 := if(clean_a2[117..121]<>'', clean_a2[117..121], le.zip2[1..5]);
	self.ship_to_input.rep_zip4 := '';
	self.ship_to_input.rep_orig_city := stringlib.stringtouppercase(le.city2);
	self.ship_to_input.rep_orig_st := stringlib.stringtouppercase(le.state2);
	self.ship_to_input.rep_orig_z5 := le.zip2[1..5];
	self.ship_to_input.rep_lat := clean_a2[146..155];
	self.ship_to_input.rep_long := clean_a2[156..166];
	self.ship_to_input.rep_addr_type := clean_a2[139];
	self.ship_to_input.rep_addr_status := clean_a2[179..182];
	self.ship_to_input.rep_phone := hphone_val2;
	self := [];
end;
prep := project(indata,into_btst_in(LEFT));

BS3_tribs						:= ['nd10'];
BSversion           := map(tribcode='nd11' => 51,
													 tribcode in BS3_tribs => 2,
													 1);

biid_results := Business_Risk.InstantId_Function_BtSt(prep, gateways, false, dppa, glb, false, false, tribcode, ofac_version, include_ofac, , global_watchlist_threshold, 
                                                      dataRestriction:=DataRestriction, dataPermission:=dataPermission,
                                                      LexIdSourceOptout := LexIdSourceOptout, 
                                                      TransactionID := TransactionID, 
                                                      BatchUID := BatchUID, 
                                                      GlobalCompanyID := GlobalCompanyID);


// intermediate results
working_layout := record
	Layout_CDxO;
	unsigned4 seq;
end;


// business_risk instant id was designed differently, convert those levels to what riskwise customers are used to on the 0-6 scale for PB1O.									
UNSIGNED1 convertPhoneLevel(unsigned1 level) := MAP(level=1 => 2,
										  level=2 => 1,
										  level=3 => 3,
										  level=4 or level=5 => 4,
										  level=6 or level=7 => 5,
										  level=8 => 6,
										  0);									

// PB01 uses a businesslevel which is basically a phonelevel, and bumps a 4 or 5 to a 6 if the taxid is found. so i'm using a combination of bnap and bnat to calculate cmpyverlevel
UNSIGNED1 convertCmpyVerLevel(unsigned1 bnap, unsigned1 bnat) := MAP(bnap = 1 => 1,  // phone match only
													    bnap = 2 => 1, // address or company match, but not both together
													    bnap = 3 => 2, // address and phone match
													    bnap in [4,5] => 3,	// company and phone match
													    bnap in [6,7,8] and bnat=8 => 6, // company, address and fein match
													    bnap in [6,7] or bnat in [6,7] => 4,  // company and address match
													    bnap = 8 and bnat != 8 => 5,  // company, address and phone match, but not fein
													    0);

working_layout fill_output(biid_results le, indata ri) := TRANSFORM
	self.seq := ri.seq;
	self.account := ri.account;
	self.riskwiseid := (string)le.bill_to_output.repdid;
	
	// first input (bill to)
	self.phoneverlevel := (string)le.bill_to_output.RepNAP_Score;
	self.cmpyverlevel := (string)convertCmpyVerLevel((integer)le.bill_to_output.BNAP_Indicator, (integer)le.bill_to_output.BNAT_Indicator);	
	self.cmpyphoneverlevel := (string)(convertPhoneLevel((integer)le.bill_to_output.BNAP_Indicator));
	
	self.correctlast := le.bill_to_output.rep_correctlast;
	self.correctcmpyname := if(le.bill_to_output.cmpyMiskeyFlag, le.bill_to_output.vercmpy, '');
	self.correcthphone := le.bill_to_output.rep_correcthphone;
	self.correctaddr := le.bill_to_output.rep_correctaddr;
			
	self.hphonetypeflag := le.bill_to_output.rep_hriskphoneflag;
	self.wphonetypeflag := le.bill_to_output.hriskphoneflag;
	self.dwelltypeflag := le.bill_to_output.rep_dwelltype;
		
	// second input (ship to)	
	self.phoneverlevel2 := (string)le.ship_to_output.RepNAP_Score;
	self.cmpyverlevel2 := (string)convertCmpyVerLevel((integer)le.ship_to_output.BNAP_Indicator, (integer)le.ship_to_output.BNAT_Indicator);
	self.cmpyphoneverlevel2 := (string)(convertPhoneLevel((integer)le.ship_to_output.BNAP_Indicator));
	
	self.correctlast2 := le.ship_to_output.rep_correctlast;
	self.correchphone2 := le.ship_to_output.rep_correcthphone;
	self.correctaddr2 := le.ship_to_output.rep_correctaddr;
			
	self.hphonetypeflag2 := le.ship_to_output.rep_phonetype;
	self.dwelltypeflag2 := le.ship_to_output.rep_dwelltype;
	
	ip := trim(ri.ipaddr);
	self.billing := if(Stringlib.StringFilterOut(ip[1],'0123456789')='' and ip<>'', 
					dataset([{'na99',1}], risk_indicators.Layout_Billing),
					dataset([],risk_indicators.Layout_Billing));
	
	self := [];
END;
mapped_results := JOIN(biid_results, indata, left.bill_to_output.seq = (right.seq * 2), fill_output(left,right), left outer);


risk_indicators.Layout_CIID_BtSt_In convertIt(prep le) := TRANSFORM
	a1_val := Risk_Indicators.MOD_AddressClean.street_address('',le.bill_to_input.rep_prim_range,le.bill_to_input.rep_predir, le.bill_to_input.rep_prim_name,le.bill_to_input.rep_addr_suffix,
								   le.bill_to_input.rep_postdir,le.bill_to_input.rep_unit_desig, le.bill_to_input.rep_sec_range);

  clean_a := Risk_Indicators.MOD_AddressClean.clean_addr(a1_val, le.bill_to_input.rep_orig_city, le.bill_to_input.rep_orig_st, le.bill_to_input.rep_orig_z5);

	self.bill_to_in.seq := le.bill_to_input.seq;
	self.Bill_To_In.historydate := le.bill_to_input.historydate;
	self.bill_to_in.title := '';
	self.bill_to_in.fname := le.bill_to_input.rep_fname;
	self.bill_to_in.mname := le.bill_to_input.rep_mname;
	self.bill_to_in.lname := le.bill_to_input.rep_lname;
	self.bill_to_in.suffix := le.bill_to_input.rep_name_suffix;

	self.bill_to_in.in_streetAddress := Risk_Indicators.MOD_AddressClean.street_address('',clean_a[1..10],clean_a[11..12], clean_a[13..40],clean_a[41..44],	// artificially call the cassed addr the input
								   clean_a[45..46],clean_a[47..56], clean_a[57..64]);
	self.bill_to_in.in_city := le.bill_to_input.rep_orig_city;
	self.bill_to_in.in_state := le.bill_to_input.rep_orig_st;
	self.bill_to_in.in_zipCode := le.bill_to_input.rep_orig_z5;
	self.bill_to_in.in_country := '';

	self.bill_to_in.prim_range := le.bill_to_input.rep_prim_range;
	self.bill_to_in.predir := le.bill_to_input.rep_predir;
	self.bill_to_in.prim_name := le.bill_to_input.rep_prim_name;
	self.bill_to_in.addr_suffix := le.bill_to_input.rep_addr_suffix;
	self.bill_to_in.postdir := le.bill_to_input.rep_postdir;
	self.bill_to_in.unit_desig := le.bill_to_input.rep_unit_desig;
	self.bill_to_in.sec_range := le.bill_to_input.rep_sec_range;
	self.bill_to_in.p_city_name := le.bill_to_input.rep_p_city_name;
	self.bill_to_in.st := le.bill_to_input.rep_st;
	self.bill_to_in.z5 := le.bill_to_input.rep_z5;
	self.bill_to_in.zip4 := le.bill_to_input.rep_zip4;
	self.bill_to_in.lat := le.bill_to_input.rep_lat;
	self.bill_to_in.long := le.bill_to_input.rep_long;
	
	self.bill_to_in.county := clean_a[143..145];	
	self.bill_to_in.geo_blk := clean_a[171..177]; 
	
	self.bill_to_in.addr_type := le.bill_to_input.rep_addr_type;
	self.bill_to_in.addr_status := le.bill_to_input.rep_addr_status;
	
	self.bill_to_in.country := le.bill_to_input.rep_country;
	
	self.bill_to_in.ssn := le.bill_to_input.rep_ssn;
	self.bill_to_in.dob := le.bill_to_input.rep_dob;
	self.bill_to_in.age := le.bill_to_input.rep_age;
	
	self.bill_to_in.dl_number := le.bill_to_input.rep_dl_num;
	self.bill_to_in.dl_state := le.bill_to_input.rep_dl_state;
	
	self.bill_to_in.email_address := le.bill_to_input.rep_email;
	self.bill_to_in.ip_address := le.bill_to_input.ip_addr;

	self.bill_to_in.phone10 := le.bill_to_input.rep_phone;
	self.bill_to_in.wphone10 := le.bill_to_input.phone10;
	self.bill_to_in.employer_name := le.bill_to_input.company_name;
	self.bill_to_in.lname_prev := '';

	// ship to
	a1_val2 := Risk_Indicators.MOD_AddressClean.street_address('',le.ship_to_input.rep_prim_range,le.ship_to_input.rep_predir, le.ship_to_input.rep_prim_name,le.ship_to_input.rep_addr_suffix,
								    le.ship_to_input.rep_postdir,le.ship_to_input.rep_unit_desig, le.ship_to_input.rep_sec_range);

	clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(a1_val2, le.ship_to_input.rep_orig_city, le.ship_to_input.rep_orig_st, le.ship_to_input.rep_orig_z5);
	
	self.ship_to_in.seq := le.ship_to_input.seq;
	self.ship_to_in.historydate := le.ship_to_input.historydate;
	self.ship_to_in.title := '';
	self.ship_to_in.fname := le.ship_to_input.rep_fname;
	self.ship_to_in.mname := le.ship_to_input.rep_mname;
	self.ship_to_in.lname := le.ship_to_input.rep_lname;
	self.ship_to_in.suffix := le.ship_to_input.rep_name_suffix;

	self.ship_to_in.in_streetAddress := Risk_Indicators.MOD_AddressClean.street_address('',clean_a2[1..10],clean_a2[11..12], clean_a2[13..40],clean_a2[41..44],	// articially call the cassed addr the input
													    clean_a2[45..46],clean_a2[47..56], clean_a2[57..64]);
	self.ship_to_in.in_city := le.ship_to_input.rep_orig_city;
	self.ship_to_in.in_state := le.ship_to_input.rep_orig_st;
	self.ship_to_in.in_zipCode := le.ship_to_input.rep_orig_z5;
	self.ship_to_in.in_country := '';

	self.ship_to_in.prim_range := le.ship_to_input.rep_prim_range;
	self.ship_to_in.predir := le.ship_to_input.rep_predir;
	self.ship_to_in.prim_name := le.ship_to_input.rep_prim_name;
	self.ship_to_in.addr_suffix := le.ship_to_input.rep_addr_suffix;
	self.ship_to_in.postdir := le.ship_to_input.rep_postdir;
	self.ship_to_in.unit_desig := le.ship_to_input.rep_unit_desig;
	self.ship_to_in.sec_range := le.ship_to_input.rep_sec_range;
	self.ship_to_in.p_city_name := le.ship_to_input.rep_p_city_name;
	self.ship_to_in.st := le.ship_to_input.rep_st;
	self.ship_to_in.z5 := le.ship_to_input.rep_z5;
	self.ship_to_in.zip4 := le.ship_to_input.rep_zip4;
	self.ship_to_in.lat := le.ship_to_input.rep_lat;
	self.ship_to_in.long := le.ship_to_input.rep_long;
	
	self.ship_to_in.county := clean_a2[143..145];
	self.ship_to_in.geo_blk := clean_a2[171..177]; 
	
	self.ship_to_in.addr_type := le.ship_to_input.rep_addr_type;
	self.ship_to_in.addr_status := le.ship_to_input.rep_addr_status;
	
	self.ship_to_in.country := le.ship_to_input.rep_country;
	
	self.ship_to_in.ssn := le.ship_to_input.rep_ssn;
	self.ship_to_in.dob := le.ship_to_input.rep_dob;
	self.ship_to_in.age := le.ship_to_input.rep_age;
	
	self.ship_to_in.dl_number := le.ship_to_input.rep_dl_num;
	self.ship_to_in.dl_state := le.ship_to_input.rep_dl_state;
	
	self.ship_to_in.email_address := le.ship_to_input.rep_email;
	self.ship_to_in.ip_address := le.ship_to_input.ip_addr;

	self.ship_to_in.phone10 := le.ship_to_input.rep_phone;
	self.ship_to_in.wphone10 := le.ship_to_input.phone10;
	self.ship_to_in.employer_name := le.ship_to_input.company_name;
	self.ship_to_in.lname_prev := '';
END;
BTSTInput := PROJECT(prep, convertIt(LEFT));

iid_results := risk_indicators.InstantId_BtSt_Function(BTSTInput,gateways,dppa,glb,false,false, true, true, true,BSversion, 
DataRestriction:=DataRestriction, dataPermission:= dataPermission,
LexIdSourceOptout := LexIdSourceOptout, 
TransactionID := TransactionID, 
BatchUID := BatchUID, 
GlobalCompanyID := GlobalCompanyID);
									// turned off dl,vehicle, and derogs because cdn606_2_0 doesn't use that data
									// now passing in BSversion as nd11 needs version 3
									
includeRelativeInfo := (tribcode not in ['nd05','nd06']);
includeDLInfo       := false;
includeVehInfo      := false;
includeDerogInfo    := if(tribcode='nd11', true, false);
									
getBS := Risk_Indicators.BocaShell_BtSt_Function(iid_results, gateways, dppa, glb, false, false, 
	includeRelativeInfo, includeDLInfo,includeVehInfo,includeDerogInfo,
	BSversion, DataRestriction:=DataRestriction, dataPermission:=dataPermission,
    LexIdSourceOptout := LexIdSourceOptout, 
    TransactionID := TransactionID, 
    BatchUID := BatchUID, 
    GlobalCompanyID := GlobalCompanyID);	

working_layout addIP(mapped_results le, getBS ri) := TRANSFORM
	self.ipcontinent := ri.ip2o.continent;
	self.ipcountry := StringLib.StringToUpperCase(ri.ip2o.countrycode);
	self.iproutingtype := ri.ip2o.iproutingmethod;
	self.ipstate := if(self.ipcountry='US', StringLib.StringToUpperCase(ri.ip2o.state), '');
	self.topleveldomain := StringLib.StringToUpperCase(ri.ip2o.topleveldomain);
     self.secondleveldomain := StringLib.StringToUpperCase(ri.ip2o.secondleveldomain);
	
	self := le;
END;
withIP := JOIN(mapped_results, getBS, (left.seq*2) = right.bill_to_out.seq, addIP(left,right), left outer);

getScore := map(
								tribcode = 'nd11' => Models.CDN1508_1_0(getBS, indata, /* is business */ true, biid_results),
								tribcode = 'nd10' => Models.CDN810_1_0(getBS, indata,/* IBICID */ true, /* is business */ true, biid_results, iid_results, 1), // ND10 is the same as ND11 except v1 reason codes
																		 Models.CDN606_2_0(getBS, indata, true, /* is business */ true, biid_results)
																		);

working_layout addBTmodel(withIP le, getScore ri) := TRANSFORM
	self.score := ri.score[1..3];
	self.score2 := ri.score[4..6];
	self.score3 := ri.score[7..9];
	
	// outRC := (integer)ri.score[1..3] <= 780 or (integer)ri.score[4..6] <= 750;
	outRC := if(tribcode='nd11', true, (integer)ri.score[1..3] <= 780 or (integer)ri.score[4..6] <= 750);
	self.reason := if(outRC, ri.ri[1].hri, '');
	self.reason2 := if(outRC, ri.ri[2].hri, '');
	self.reason3 := if(outRC, ri.ri[3].hri, '');
	self.reason4 := if(outRC, ri.ri[4].hri, '');
	self.reason5 := if(outRC, ri.ri[5].hri, '');
	self.reason6 := if(outRC, ri.ri[6].hri, '');
	
	outRC2 := if(tribcode='nd11', true, (integer)ri.score[1..3] <= 780 or (integer)ri.score[7..9] <= 750);
	self.reason7 := if(outRC2, ri.ri[7].hri, '');
	self.reason8 := if(outRC2, ri.ri[8].hri, '');
	self.reason9 := if(outRC2, ri.ri[9].hri, '');
	self.reason10 := if(outRC2, ri.ri[10].hri, '');
	self.reason11 := if(outRC2, ri.ri[11].hri, '');
	self.reason12 := if(outRC2, ri.ri[12].hri, '');
	
	self := le;
END;
withModel := JOIN(withIP, getScore, (left.seq*2) = right.seq, addBTmodel(left, right), left outer);


Layout_CDxO format_output(withModel le, biid_results ri) := TRANSFORM
	outVdata := if(tribcode='nd11', true, (integer)le.score <= 750 or (integer)le.score2 <= 750);
	self.verfirst := if(outVdata, ri.bill_to_output.RepFNameVerify, '');
	self.verlast := if(outVdata, ri.bill_to_output.RepLNameVerify, '');
	self.veraddr := if(outVdata, ri.bill_to_output.RepAddrVerify, '');
	self.vercity := if(outVdata, ri.bill_to_output.RepCityVerify, '');
	self.verstate := if(outVdata, ri.bill_to_output.RepStateVerify, '');
	self.verszip := if(outVdata, ri.bill_to_output.RepZipVerify + ri.Bill_to_Output.RepZip4Verify, '');
	self.nameaddrphone := if(outVdata, ri.bill_to_output.RepPhoneFromAddr, '');
	
	outVdata2 := if(tribcode='nd11', true, (integer)le.score <= 750 or (integer)le.score3 <= 750);
	self.verfirst2 := if(outVdata2, ri.ship_to_output.RepFNameVerify, '');
	self.verlast2 := if(outVdata2, ri.ship_to_output.RepLNameVerify, '');
	self.veraddr2 := if(outVdata2, ri.ship_to_output.RepAddrVerify, '');
	self.vercity2 := if(outVdata2, ri.ship_to_output.RepCityVerify, '');
	self.verstate2 := if(outVdata2, ri.ship_to_output.RepStateVerify, '');
	self.verszip2 := if(outVdata2, ri.ship_to_output.RepZipVerify + ri.ship_to_output.RepZip4Verify, '');
	self.nameaddrphone2 := if(outVdata2, ri.ship_to_output.RepPhoneFromAddr, '');
	
	self := le;
END;
final := JOIN(withModel, biid_results, (left.seq*2) = right.bill_to_output.seq, format_output(left,right), left outer);

RETURN final;

END;