import ut, business_risk, Risk_Indicators, Models, gateway, Royalty, STD;

export SDBO_Function(dataset(Layout_SD5I) indata, dataset(Gateway.Layouts.Config) gateways, unsigned1 dppa, unsigned1 glb,  
				 boolean isUtility=false, 
         boolean ln_branded=false, 
         string4 tribcode,
         unsigned1 ofac_version = 1,
         boolean include_ofac = false,
         boolean include_additional_watchlists = false,
         real global_watchlist_threshold = 0.84, 
		 string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
		 string50 DataPermission=risk_indicators.iid_constants.default_DataPermission,
         unsigned1 LexIdSourceOptout = 1,
         string TransactionID = '',
         string BatchUID = '',
         unsigned6 GlobalCompanyId = 0) := FUNCTION


	
gn(UNSIGNED1 I) := i BETWEEN 90 AND 100;	
min2(integer L, integer R) :=  if (l < r , l, r);

// risk_indicators instant_id function returns 0-12, but this needs to get mapped to 0-8.  this conversion works for both nap and nas
unsigned1 convertInstIDLevel(unsigned1 level) := map(level = 1 => 1,
										   level = 4 => 2,
										   level = 6 => 3,
										   level = 7 => 4,
										   level = 9 => 5,
										   level = 10 => 6,
										   level = 11 => 7,
										   level = 12 => 8,
										   0);	// 0,2,3,5,8 all translate into 0 on the 0-8 scale
									
// business_risk instant id was designed differently, convert those levels to what riskwise customers are used to.  this conversion works on bnat									
unsigned1 convertBusInstIDLevel(unsigned1 level) := map(level = 1 => 1,
											 level = 3 => 3,
											 level = 4 => 5,
											 level = 5 => 5,
											 level = 8 => 8,
											 0);   // 0,2,6,7 all translate into 0 on st. cloud platform
			
unsigned1 convertBNAP(unsigned1 level) := map(level = 1 => 1,
											 level in [3, 4] => 5,
											 level = 5 => 6,
											 level = 8 => 8,
											 0);   // 0,2,6,7 all translate into 0 on st. cloud platform			

// Only going to populate the business portion here			
Business_Risk.Layout_Input into_biid_in(indata le) := TRANSFORM
	boolean useFirst := le.apptype not in ['1','4'];	// is first input business?  otherwise use second input
	
	clean_a := risk_indicators.MOD_AddressClean.clean_addr(if(useFirst, le.addr, le.addr2), 
															if(useFirst, le.city, le.city2), 
															if(useFirst, le.state, le.state2), 
															if(useFirst, le.zip, le.zip2)) ;
	
	ssn := if(useFirst, le.socs, le.socs2);
	ssn_val := cleanSSN( ssn );

	phone := if(useFirst, le.hphone, le.hphone2);
	hphone_val := cleanPhone( phone );

	self.seq := le.seq;
	self.historydate := le.historydate;
	self.Account := le.account;
	self.bdid	:= 0;  // isn't an input field in our products
	self.score := 0;  // isn't an input value in our products either
	cmpy := if(useFirst, le.cmpy, le.cmpy2);
	self.company_name := STD.Str.touppercase(cmpy);
	self.alt_company_name := '';  // don't have one
	self.prim_range := clean_a[1..10]; 
	self.predir := clean_a[11..12];
	self.prim_name := clean_a[13..40];
	self.addr_suffix := clean_a[41..44];
	self.postdir := clean_a[45..46];
	self.unit_desig := clean_a[47..56];
	self.sec_range := clean_a[57..64];
	self.p_city_name := clean_a[90..114];
	self.v_city_name := clean_a[65..89];
	self.st := clean_a[115..116];
	self.z5 := clean_a[117..121];
	self.zip4 := clean_a[122..125];
	inputZip := if(useFirst, le.zip, le.zip2);
	self.orig_z5 := inputZip;
	self.lat := clean_a[146..155];
	self.long := clean_a[156..166];
	self.addr_type := clean_a[139];
	self.addr_status := clean_a[179..182];	
	self.county := clean_a[143..145];
	self.geo_blk := clean_a[171..177];
	self.fein		 := ssn_val;
	self.phone10    := hphone_val;  // the business and consumer phones will be in the hphone field
	self.ip_addr	 := le.ipaddr;
	self.rep_fname	 := '';//STD.Str.touppercase(le.first);
	self.rep_mname  := ''; // don't have one on input
	self.rep_lname  := '';//STD.Str.touppercase(le.last);
	self.rep_name_suffix := ''; // don't have one on input
	self.rep_alt_Lname := ''; // don't have one on input
	
	fax_val := if(useFirst, le.wphone, le.wphone2);
	fax := cleanPhone( fax_val );
	
	//wphone could be a fax. if wphone is populated, use iid to do phone verification on that
	self.rep_phone		:= fax;
	self.rep_prim_range := if(fax!='', clean_a[1..10], '');
	self.rep_predir := if(fax!='', clean_a[11..12], '');
	self.rep_prim_name := if(fax!='', clean_a[13..40], '');
	self.rep_addr_suffix := if(fax!='', clean_a[41..44], '');
	self.rep_postdir := if(fax!='', clean_a[45..46], '');
	self.rep_unit_desig := if(fax!='', clean_a[47..56], '');
	self.rep_sec_range := if(fax!='', clean_a[57..64], '');
	self.rep_p_city_name := if(fax!='', clean_a[90..114], '');
	self.rep_st := if(fax!='', clean_a[115..116], '');
	self.rep_z5 := if(fax!='', clean_a[117..121], '');
	self.rep_zip4 := if(fax!='', clean_a[122..125], '');	
	self.rep_lat := if(fax!='', clean_a[146..155], '');
	self.rep_long := if(fax!='', clean_a[156..166], '');
	self.rep_addr_type := if(fax!='', clean_a[139], '');
	self.rep_addr_status := if(fax!='', clean_a[179..182], '');
	self.rep_county := if(fax!='', clean_a[143..145], '');
	self.rep_geo_blk := if(fax!='', clean_a[171..177], '');
	
	self.rep_orig_city := '';
	self.rep_orig_st := '';
	self.rep_orig_z5 := '';
	self.rep_ssn		:= '';
	self.rep_dob		:= '';
	self.rep_age 		:= '';
	self.rep_dl_num := '';
	self.rep_dl_state := '';
	self.rep_email		:= '';
	self.rep_country := '';

	self.country := if(le.tribcode in ['b2bz', 'b2b4'], if(useFirst, STD.Str.touppercase(le.countrycode), STD.Str.touppercase(le.countrycode2)), '');//le.countrycode;
END;
biid_prep := project(indata,into_biid_in(LEFT));

boolean hasbdids := false;
boolean ExcludeWatchLists := false;
boolean ofac_only := tribcode != 'ex41';   //Set OFAC to false is tribcode = ex41 per bug 33454.
BOOLEAN suppressNearDups := true;
boolean require2Ele:= true;
boolean from_BIID := false;
boolean isFCRA := false;
boolean fdReasonsWith38 := true; // all SDBO products should be using fdReasonCodesWith38 instead of just fdReasonCodes
boolean inCalif:=false;

isbridgerservicename := count( gateways(ServiceName = 'bridgerwlc') ) > 0;
         
_ofac_version := 
  map( 
    ofac_version = 4 => 4,
    tribcode in ['b2b4'] => 3, 
    ofac_version);
    
_include_ofac := 
  map(
    ofac_version in [2, 3, 4] => true,
    tribcode in ['b2b4'] => true, 
    false );
    
_include_additional_watchlists := include_additional_watchlists;

_global_watchlist_threshold :=
  map(
    ofac_version = 4 and include_ofac => 0.85,
    tribcode in ['b2b4'] => 0.85, 
    global_watchlist_threshold);

biid_res := business_risk.InstantID_Function(biid_prep,gateways,hasbdids,dppa,glb,isUtility,ln_branded,tribcode,ExcludeWatchLists,ofac_only,
								_ofac_version,_include_ofac,_include_additional_watchlists, _global_watchlist_threshold, datarestriction:=datarestriction, datapermission:=datapermission,
                                LexIdSourceOptout := LexIdSourceOptout, 
                                TransactionID := TransactionID, 
                                BatchUID := BatchUID, 
                                GlobalCompanyID := GlobalCompanyID);				

dbus_Royalties := DATASET([], Royalty.Layouts.Royalty) : STORED('Bus_Royalties');

business_risk.layout_output filterAttus_bus( biid_res le ) := transform
	isGatewayValid := (tribcode in ['b2bz'] AND (gateways(servicename='attus'))[1].url != '') or tribcode='b2b4';  // b2b4 doesn't need a gateway present, we get the data internally now
	self.watchlist_table := if(isGatewayValid, if(tribcode='b2b4' and le.watchlist_table<>'', 'OFC', le.Watchlist_table), 'XXX' );
	self.watchlist_fname := if(isGatewayValid, le.Watchlist_fname, '');
	self.watchlist_lname := if(isGatewayValid, le.Watchlist_lname, '');
	self.watchlist_address := if(isGatewayValid, le.Watchlist_address, '' );
	self.watchlist_city:= if(isGatewayValid, le.Watchlist_city, '');
	self.watchlist_state := if( isGatewayValid, le.Watchlist_state, '');
	self.watchlist_zip := if(isGatewayValid, le.Watchlist_zip, '');
	self.watchlist_cmpy := if(isGatewayValid, le.watchlist_cmpy, '');
	self.watchlist_record_number := if(isGatewayValid, le.watchlist_record_number , '');
	self.watchlist_country := if(isGatewayValid, le.watchlist_country, '');
	self.watchlist_program := if(isGatewayValid, le.watchlist_program , '');
	
	self.repwatchlist_table := if(isGatewayValid, le.repWatchlist_table, 'XXX' );
	self.repwatchlist_fname := if(isGatewayValid, le.repWatchlist_fname, '');
	self.repwatchlist_lname := if(isGatewayValid, le.repWatchlist_lname, '');
	self.repwatchlist_address := if(isGatewayValid, le.repWatchlist_address, '' );
	self.repwatchlist_city:= if(isGatewayValid, le.repWatchlist_city, '');
	self.repwatchlist_state := if( isGatewayValid, le.repWatchlist_state, '');
	self.repwatchlist_zip := if(isGatewayValid, le.repWatchlist_zip, '');
	self.repwatchlist_entity_name := if(isGatewayValid, le.repwatchlist_entity_name, '');
	self.repwatchlist_record_number := if(isGatewayValid, le.repwatchlist_record_number , '');
	self.repwatchlist_country := if(isGatewayValid, le.repwatchlist_country, '');
	self.repwatchlist_program := if(isGatewayValid, le.repwatchlist_program , '');

	self := le;
end;
biid := if(tribcode in ['b2bz','b2b4'], project( biid_res, filterAttus_bus( LEFT ) ), biid_res);


// populate the consumer input
risk_indicators.layout_input into_iid_prep(indata le) := TRANSFORM
	boolean useFirst := le.apptype in ['1','4'];	// is first input consumer?  otherwise use second input
	
	a1_val := if(useFirst, le.addr, le.addr2);
	city := if(useFirst, le.city, le.city2);
	state := if(useFirst, le.state, le.state2);
	zip := if(useFirst, le.zip, le.zip2);
	clean_a := Risk_Indicators.MOD_AddressClean.clean_addr(a1_val, city, state, zip);
	

	ssn := if(useFirst, le.socs, le.socs2);
	ssn_val := cleanSSN( ssn );

	phone := if(useFirst, le.hphone, le.hphone2);
	hphone_val := cleanPhone( phone );

	wphone := if(useFirst, le.wphone, le.wphone2);
	wphone_val := cleanPhone( wphone );

	dob := if(useFirst, le.dob, le.dob2);
	dob_val := cleanDOB(dob);

	drlc := if(useFirst, le.drlc, le.drlc2);
	dl_num_clean := cleanDL_num( drlc );

	self.seq := le.seq;
	self.ssn := ssn_val;
	self.dob := dob_val;
	self.phone10 := hphone_val;	
	self.wphone10 := wphone_val;
	first := if(useFirst, le.first, le.first2);
	self.fname := STD.Str.touppercase(first);
	last := if(useFirst, le.last, le.last2);
	self.lname := STD.Str.touppercase(last);
	inAddr := if(useFirst, le.addr, le.addr2);
	self.in_streetAddress := STD.Str.touppercase(inAddr);
	inCity := if(useFirst, le.city, le.city2);
	self.in_city := STD.Str.touppercase(inCity);
	inState := if(useFirst, le.state, le.state2);
	self.in_state := STD.Str.touppercase(inState);
	inZip := if(useFirst, le.zip, le.zip2);
	self.in_zipCode := inZip;
	self.prim_range := clean_a[1..10];
	self.predir := clean_a[11..12];
	self.prim_name := clean_a[13..40];
	self.addr_suffix := clean_a[41..44];
	self.postdir := clean_a[45..46];
	self.unit_desig := clean_a[47..56];
	self.sec_range := clean_a[57..64];
	self.p_city_name := clean_a[90..114];
	self.st := clean_a[115..116];
	self.z5 := if(clean_a[117..121]<>'',clean_a[117..121],inZip[1..5]);		// use the input zip if cass zip is empty
	self.zip4 := if(clean_a[122..125]<>'', clean_a[122..125], inZip[6..9]);	// use the input zip if cass zip is empty
	self.lat := clean_a[146..155];
	self.long := clean_a[156..166];
	self.addr_type := clean_a[139];
	self.addr_status := clean_a[179..182];
	self.county := clean_a[143..145];
	self.geo_blk := clean_a[171..177];
	self.dl_number := STD.Str.touppercase(dl_num_clean);
	drlcstate := if(useFirst, le.drlcstate, le.drlcstate2);
	self.dl_state := STD.Str.touppercase(drlcstate);
	self.age := if((integer)dob_val != 0, (string3)ut.Age((integer)dob_val), '');
	email := if(useFirst, le.email, le.email2);
	self.email_address := email;
	cmpy := if(useFirst, le.cmpy, le.cmpy2);
	self.employer_name := STD.Str.touppercase(cmpy);
	countrycode := if(useFirst, STD.Str.touppercase(le.countrycode), STD.Str.touppercase(le.countrycode2));
	self.country := countrycode;
	self.in_country := countrycode;
	self.historydate := le.historydate;
	self := [];
END;
iid_prep := project(indata, into_iid_prep(left));

iid_res := Risk_Indicators.InstantID_Function(iid_prep, gateways, dppa, glb, isUtility, ln_branded, ofac_only, 
									suppressNearDups, require2Ele, from_BIID, isFCRA, in_DataRestriction:=DataRestriction,
									in_DataPermission:=DataPermission,
                                    LexIdSourceOptout := LexIdSourceOptout, 
                                    TransactionID := TransactionID, 
                                    BatchUID := BatchUID, 
                                    GlobalCompanyID := GlobalCompanyID);

iidRoyalties :=Royalty.RoyaltyTargus.GetOnlineRoyalties(iid_res, src, TargusType, TRUE, FALSE, FALSE, TRUE);

dRoyalties := Royalty.MAC_RoyaltyCombine(iidRoyalties, dbus_Royalties);

risk_indicators.layout_output filterAttus( iid_res le ) := transform
	isGatewayValid := (tribcode in ['b2bz'] AND (gateways(servicename='attus'))[1].url != '') or tribcode='b2b4';  // b2b4 doesn't need a gateway present, we get the data internally now
	self.watchlist_table := if(isGatewayValid, if(tribcode='b2b4' and le.watchlist_table<>'', 'OFC', le.Watchlist_table), 'XXX' );
	self.watchlist_fname := if(isGatewayValid, le.Watchlist_fname, '');
	self.watchlist_lname := if(isGatewayValid, le.Watchlist_lname, '');
	self.watchlist_address := if(isGatewayValid, le.Watchlist_address, '' );
	self.watchlist_city:= if(isGatewayValid, le.Watchlist_city, '');
	self.watchlist_state := if( isGatewayValid, le.Watchlist_state, '');
	self.watchlist_zip := if(isGatewayValid, le.Watchlist_zip, '');
	self.watchlist_entity_name := if(isGatewayValid, le.Watchlist_Entity_Name, '');
	self.watchlist_record_number := if(isGatewayValid, le.watchlist_record_number , '');
	self.watchlist_contry := if(isGatewayValid, le.watchlist_contry , '');
	self.watchlist_program := if(isGatewayValid, le.watchlist_program , '');
	self := le;
end;

iid := if(tribcode in ['b2bz', 'b2b4'], project( iid_res, filterAttus( LEFT ) ), iid_res);

// put the biid and iid results together
layout_combo := RECORD
	Business_Risk.Layout_Output biid;
	Risk_Indicators.Layout_Output iid;
END;

layout_combo combine(biid le, iid ri) := TRANSFORM
	self.biid := le;
	self.iid := ri;
END;
biidIID := join(biid, iid, left.seq=right.seq, combine(left,right));

xlayout := record
	RiskWise.Layout_SDBO;
	string tribcode := '';
	string orig_cmpy := '';
	string orig_wphone := '';
	string orig_fax := '';
	string orig_addr := '';
	string orig_city := '';
	string orig_state := '';
	string orig_zip := '';
	string1 cmpy_bans := '';
	string1 telcophonetype := '';
	string10	phoneLat				:= '';
	string11	phoneLong				:= '';
	string10	addrLat				:= '';
	string11	addrLong				:= '';
	string10	phoneLat2				:= '';
	string11	phoneLong2			:= '';
	string10	addrLat2				:= '';
	string11	addrLong2				:= '';
	string1 apptype := '';
	string1 apptype2 := '';
END;

// populate SDBO fields with results from biid and iid
xlayout fill_output(biidIID le, indata ri) := TRANSFORM	
	boolean isFirstCon := ri.apptype in ['1','4'];	// is the first input a consumer
	self.apptype := ri.apptype;
	self.apptype2 := ri.apptype2;
	self.seq := ri.seq;
	self.account := ri.account;
	self.acctno := ri.acctno;
	self.tribcode := ri.tribcode;
	self.riskwiseid := if(isFirstCon, (string)le.iid.did, (string)le.biid.bdid); // for testing
	
	// original input for use with Business reason codes
	self.orig_cmpy := if(isFirstCon, ri.cmpy2, ri.cmpy);
	wphone := if(isFirstCon, ri.hphone2, ri.hphone);
	fax := if(isFirstCon, ri.wphone2, ri.wphone);
	self.orig_wphone := wphone;
	self.orig_fax := fax;
	self.orig_addr := if(isFirstCon, ri.addr2, ri.addr);
	self.orig_city := if(isFirstCon, ri.city2, ri.city);
	self.orig_state := if(isFirstCon, ri.state2, ri.state);
	self.orig_zip := if(isFirstCon, ri.zip2, ri.zip);
	self.telcophonetype := if(wphone='', '', le.biid.TelcordiaPhoneType);	
	
	input1present := ri.first<>'' or ri.last<>'' or ri.cmpy<>'' or ri.addr<>'' or ri.hphone<>'';
// start of billto output	
	self.hriskhphoneflag := if(ri.hphone='', '7', if(isFirstCon, le.iid.hriskphoneflag, if(le.biid.hriskphoneflag='U', '0',le.biid.hriskphoneflag)));
	self.hriskwphoneflag := if(ri.wphone='', '7', if(isFirstCon, le.iid.wphonetypeflag, if(le.biid.rep_hriskphoneflag='U', '0',le.biid.rep_hriskphoneflag)));  
	self.hphonevalflag := if(ri.hphone='', '4', if(isFirstCon, le.iid.phonevalflag, le.biid.phonevalidflag));
	self.wphonevalflag := if(ri.wphone='', '4', if(isFirstCon, le.iid.wphonevalflag, le.biid.rep_phonevalflag)); 
	self.hphonezipflag := if(ri.hphone='' or ri.zip='', '2', if(isFirstCon, le.iid.phonezipflag, if(le.biid.phonezipmismatch, '1', '0')));
	self.wphonezipflag := if(ri.wphone='' or ri.zip='', '2', if(isFirstCon, 
														if(ri.hphone=ri.wphone,le.iid.phonezipflag, '0'), // defaulting to 0, (no mismatch) since we don't have a flag for this in iid, unless the input wphone is the same as hphone
														if(le.biid.rep_phonezipmismatch='1', '1', '0') ) );  
	self.hriskaddrflag := if(ri.addr='', '5', if(isFirstCon, le.iid.hriskaddrflag, le.biid.hriskaddrflag));
	self.decsflag := if(isFirstCon, if(le.iid.ssn='', '2', le.iid.decsflag), '3');
	self.socsdobflag := if(isFirstCon, if(le.iid.ssn='', '3', le.iid.socsdobflag), '4');
	self.socsvalflag := if(isFirstCon, if(le.iid.ssn='', '3', le.iid.socsvalflag), '4');
	self.drlcvalflag := if(isFirstCon, if(le.iid.drlcvalflag='3', '1', le.iid.drlcvalflag), '3');
	self.addrvalflag := if(isFirstCon, le.iid.addrvalflag, le.biid.addrvalidflag);
	self.dwelltypeflag := if(isFirstCon, le.iid.dwelltype, le.biid.BAddrType);
		
	// for bansflag if it's a consumer app, it's easy, just use rep_bansflag.  for business, some calculating needs to be done
	bans_current := if(((integer)((STRING8)Std.Date.Today())[1..6] - (integer)(le.biid.RecentBkDate[1..6])) < 1000, true, false);  // make sure the bans is within the last 10 years
	lien_current := if(((integer)((STRING8)Std.Date.Today())[1..6] - (integer)(le.biid.RecentLienDate[1..6])) < 1000, true, false);  // make sure the bans is within the last 10 years
	self.bansflag := if(isFirstCon, le.iid.bansflag, 
										   map(ri.socs='' or (ri.cmpy='' and ri.addr='') => '3',
											  le.biid.bkbdidflag and le.biid.lienbdidflag and bans_current and lien_current => '5',
										       le.biid.bkbdidflag and bans_current => '2', 
											  le.biid.lienbdidflag and lien_current => '4',
						   					   '0')); 												 												    									
	self.firstcount := if(isFirstCon, (string)min2(le.iid.combo_firstcount, 2), '0');
	self.lastcount := if(isFirstCon, (string)min2(le.iid.combo_lastcount, 2), '0');
	self.cmpycount := if(isFirstCon, (string)min2(le.iid.combo_cmpycount, 2), if(le.biid.CnameMatchflag = 'Y', '1', '0'));
	self.addrcount := if(isFirstCon, (string)min2(le.iid.combo_addrcount, 2), if(le.biid.AddrMatchflag = 'Y', '1', '0'));
	socscount := if(isFirstCon, (string)min2(le.iid.combo_ssncount, 2), if(le.biid.FeinMatchflag = 'Y', '1', '0'));
	self.socscount := socscount;
	self.hphonecount := if(isFirstCon, (string)min2(le.iid.combo_hphonecount, 2), if(le.biid.PhoneMatchflag = 'Y', '1', '0'));
	self.wphonecount := if(isFirstCon, (string)min2(le.iid.combo_wphonecount, 2), if(le.biid.repphoneverflag = 'Y', '1', '0'));	
	self.dobcount := if(isFirstCon, (string)min2(le.iid.combo_dobcount, 2), '0');
	self.drlccount := '0';
	self.emailcount := '0';
	self.socsverlevel := if(isFirstCon, (string)convertInstIDLevel((integer)le.iid.socsverlevel), (string)convertBusInstIDLevel((integer)le.biid.BNAT_Indicator));
	self.cmpyphoneverlevel := if(isFirstCon, '', intformat(convertBusInstIDLevel((integer)le.biid.BNAP_Indicator),2,1));  // in st.cloud cmpyphoneverlevel is actually the verlevel on the homephone
	self.cmpyfaxverlevel := if(isFirstCon, '', intformat(convertInstIDLevel((integer)le.biid.repnap_score), 2, 1));  // and cmpyfaxverlevel is the verlevel on the workphone
	self.hphoneverlevel := if(isFirstCon, intformat(convertInstIDLevel((integer)le.iid.phoneverlevel),2,1), '');
	self.numelever := (string)(if(self.firstcount>'0',1,0)+if(self.lastcount>'0',1,0)+if(self.addrcount>'0',1,0)+if(self.cmpycount>'0',1,0)+if(self.socscount>'0',1,0)+
						if(self.hphonecount>'0',1,0)+if(self.wphonecount>'0',1,0)+if(self.dobcount>'0',1,0)+if(self.drlccount>'0',1,0)+if(self.emailcount>'0',1,0));
	self.numsource := (string)((integer)self.firstcount+(integer)self.lastcount+(integer)self.cmpycount+(integer)self.addrcount+(integer)self.socscount+
							(integer)self.hphonecount+(integer)self.wphonecount+(integer)self.dobcount);
	self.verfirst := if(isFirstCon, le.iid.combo_first, '');
	self.verlast := if(isFirstCon, le.iid.combo_last, '');
	self.vercmpy := if(isFirstCon, le.iid.combo_cmpy, le.biid.vercmpy);
	self.veraddr := if(isFirstCon, Risk_Indicators.MOD_AddressClean.street_address('',le.iid.combo_prim_range,le.iid.combo_predir,le.iid.combo_prim_name,le.iid.combo_suffix,
													le.iid.combo_postdir,le.iid.combo_unit_desig,le.iid.combo_sec_range), le.biid.veraddr);
	self.vercity := if(isFirstCon, le.iid.combo_city, le.biid.vercity);
	self.verstate := if(isFirstCon, le.iid.combo_state, le.biid.verstate);
	
	bverzip5 := if (le.biid.verzip != '', intformat((integer)le.biid.verzip,5,1),'');
	bverzip4 := if (le.biid.verzip4 != '', intformat((integer)le.biid.verzip4,4,1),'');
	
	self.verzip := if(isFirstCon, le.iid.combo_zip, bverzip5 + bverzip4);
	// only output the socs if it matches input
	self.versocs := if(isFirstCon, if((integer)socscount>0,le.iid.combo_ssn,''), if((integer)socscount>0,le.biid.verfein,''));
	self.verdob := if(isFirstCon, le.iid.combo_dob, le.biid.RepDOBVerify);
	self.verhphone := if(isFirstCon, le.iid.combo_hphone, le.biid.verphone);
	self.verwphone := if(isFirstCon, le.iid.combo_wphone, le.biid.repphoneverify);
	self.verdrlc := ''; // always blank
	self.veremail := ''; // always blank
	self.socsmiskeyflag := if(isFirstCon, if(le.iid.socsmiskeyflag,'1','0'), '2');
	self.hphonemiskeyflag := if(isFirstCon, if(le.iid.hphonemiskeyflag, '1','0'), if(le.biid.phonemiskeyflag,'1','0'));
	self.wphonemiskeyflag := if(isFirstCon, if(gn(le.iid.combo_wphonescore), '1', '0'), if(le.biid.rep_phonemiskeyflag, '1', '0'));
	self.addrmiskeyflag := if(isFirstCon, if(le.iid.addrmiskeyflag,'1','0'), if(le.biid.addrmiskeyflag,'1','0'));
	self.phoneLat := map(ri.apptype in ['1','4'] => le.iid.hphonelat,
					  input1present => le.biid.busphonelat, '');
	self.phoneLong	:= map(ri.apptype in ['1','4'] => le.iid.hphonelong,
					  input1present => le.biid.busphonelong, '');
	self.addrLat := map(ri.apptype in ['1','4'] => le.iid.lat,
					  input1present => le.biid.lat, '');
	self.addrLong := map(ri.apptype in ['1','4'] => le.iid.long,
					  input1present => le.biid.long, '');		
	self.alerttable1 := if(ri.tribcode in ['b2bz','b2b4'], if(isFirstCon,le.iid.watchlist_table, le.biid.watchlist_table), '');	

	//self.apptype := ri.apptype;
					    
//start of shipto info

	boolean isSecondCon := ri.apptype2 in ['1','4'];	// is second input consumer
	input2present := ri.first2<>'' or ri.last2<>'' or ri.cmpy2<>'' or ri.addr2<>'' or ri.hphone2<>'';
	self.hriskhphoneflag2 := if(ri.hphone2='', '7', if(isSecondCon, le.iid.hriskphoneflag, if(le.biid.hriskphoneflag='U', '0',le.biid.hriskphoneflag)));
	self.hriskwphoneflag2 := if(ri.wphone2='', '7', if(isSecondCon, le.iid.wphonetypeflag, if(le.biid.rep_hriskphoneflag='U', '0',le.biid.rep_hriskphoneflag))); 
	self.hphonevalflag2 := if(ri.hphone2='', '4', if(isSecondCon, le.iid.phonevalflag, le.biid.phonevalidflag));
	self.wphonevalflag2 := if(ri.wphone2='', '4', if(isSecondCon, le.iid.wphonevalflag, le.biid.rep_phonevalflag));
	self.hphonezipflag2 := if(ri.hphone2='' or ri.zip2='', '2', if(isSecondCon, le.iid.phonezipflag, if(le.biid.phonezipmismatch, '1', '0')));
	self.wphonezipflag2 := if(ri.wphone2='' or ri.zip2='', '2', if(isSecondCon, 
														if(ri.hphone2=ri.wphone2,le.iid.phonezipflag, '0'), // defaulting to 0, (no mismatch) since we don't have a flag for this in iid, unless the input wphone is the same as hphone
														if(le.biid.rep_phonezipmismatch='1', '1', '0') ) );
	self.hriskaddrflag2 := if(ri.addr2='', '5', if(isSecondCon, le.iid.hriskaddrflag, le.biid.hriskaddrflag));
	self.decsflag2 := if(isSecondCon, if(le.iid.ssn='', '2',le.iid.decsflag), '3');
	self.socsdobflag2 := if(isSecondCon, if(le.iid.ssn='', '3', le.iid.socsdobflag), '4');
	self.socsvalflag2 := if(isSecondCon, if(le.iid.ssn='', '3',le.iid.socsvalflag), '4');
	self.drlcvalflag2 := if(isSecondCon, if(le.iid.drlcvalflag='3', '1', le.iid.drlcvalflag), '3');
	self.addrvalflag2 := if(~input2present, '', if(isSecondCon, le.iid.addrvalflag, le.biid.addrvalidflag));
	self.dwelltypeflag2 := if(~input2present, '', if(isSecondCon, le.iid.dwelltype, le.biid.BAddrType));
			
	// for bansflag if it's a consumer app, it's easy, just use rep_bansflag.  for business, some calculating and scoring needs to be done
	self.bansflag2 := if(isSecondCon, le.iid.bansflag, 
										   map(ri.socs2='' or (ri.cmpy2='' and ri.addr2='') => '3',
											  le.biid.bkbdidflag and le.biid.lienbdidflag and bans_current and lien_current => '5',
										       le.biid.bkbdidflag and bans_current => '2', 
											  le.biid.lienbdidflag and lien_current => '4',
						   					   '0')); 								
	self.cmpy_bans := if(isFirstCon, self.bansflag2, self.bansflag);	// used in reason codes												    				
	self.firstcount2 := if(isSecondCon, (string)min2(le.iid.combo_firstcount, 2), '0');
	self.lastcount2 := if(isSecondCon, (string)min2(le.iid.combo_lastcount, 2), '0');
	self.cmpycount2 := if(~input2present, '0', if(isSecondCon, (string)min2(le.iid.combo_cmpycount, 2), if(le.biid.CnameMatchflag = 'Y', '1', '0')));
	self.addrcount2 := if(~input2present, '0', if(isSecondCon, (string)min2(le.iid.combo_addrcount, 2), if(le.biid.AddrMatchflag = 'Y', '1', '0')));
	socscount2 := if(~input2present, '0', if(isSecondCon, (string)min2(le.iid.combo_ssncount, 2), if(le.biid.FeinMatchflag = 'Y', '1', '0')));
	self.socscount2 := socscount2;
	self.hphonecount2 := if(~input2present, '0', if(isSecondCon, (string)min2(le.iid.combo_hphonecount, 2), if(le.biid.PhoneMatchflag = 'Y', '1', '0')));
	self.wphonecount2 := if(~input2present, '0', if(isSecondCon, (string)min2(le.iid.combo_wphonecount, 2), if(le.biid.repphoneverflag = 'Y', '1', '0')));	
	self.dobcount2 := if(~input2present, '0', if(isSecondCon, (string)min2(le.iid.combo_dobcount, 2), '0'));
	self.drlccount2 := '0';
	self.emailcount2 := '0';
	self.socsverlevel2 := if(~input2present, '0', if(isSecondCon, (string)convertInstIDLevel((integer)le.iid.socsverlevel), (string)convertBusInstIDLevel((integer)le.biid.BNAT_Indicator)));
	self.cmpyphoneverlevel2 := if(~input2present, '00', if(isSecondCon, '', intformat(convertBNAP((integer)le.biid.BNAP_Indicator),2,1)));  // in st.cloud cmpyphoneverlevel is actually the verlevel on the homephone
	self.cmpyfaxverlevel2 := if(~input2present, '00', if(isSecondCon, '', intformat(convertInstIDLevel((integer)le.biid.repnap_score), 2, 1)));  // and cmpyfaxverlevel is the verlevel on the workphone
	self.hphoneverlevel2 := if(~input2present, '', if(isSecondCon, intformat(convertInstIDLevel((integer)le.iid.phoneverlevel),2,1), ''));
	self.numelever2 := (string)(if(self.firstcount2>'0',1,0)+if(self.lastcount2>'0',1,0)+if(self.addrcount2>'0',1,0)+if(self.cmpycount2>'0',1,0)+if(self.socscount2>'0',1,0)+
										 if(self.hphonecount2>'0',1,0)+if(self.wphonecount2>'0',1,0)+if(self.dobcount2>'0',1,0)+if(self.drlccount2>'0',1,0)+if(self.emailcount2>'0',1,0));
	self.numsource2 := (string)((integer)self.firstcount2+(integer)self.lastcount2+(integer)self.cmpycount2+(integer)self.addrcount2+(integer)self.socscount2+
										 (integer)self.hphonecount2+(integer)self.wphonecount2+(integer)self.dobcount2);
	self.verfirst2 := if(~input2present, '', if(isSecondCon, le.iid.combo_first, ''));
	self.verlast2 := if(~input2present, '', if(isSecondCon, le.iid.combo_last, ''));
	self.vercmpy2 := if(~input2present, '', if(isSecondCon, le.iid.combo_cmpy, le.biid.vercmpy));
	self.veraddr2 := if(~input2present, '', if(isSecondCon, Risk_Indicators.MOD_AddressClean.street_address('',le.iid.combo_prim_range,le.iid.combo_predir,le.iid.combo_prim_name,le.iid.combo_suffix,
																															 le.iid.combo_postdir,le.iid.combo_unit_desig,le.iid.combo_sec_range), le.biid.veraddr));
	self.vercity2 := if(~input2present, '', if(isSecondCon, le.iid.combo_city, le.biid.vercity));
	self.verstate2 := if(~input2present, '', if(isSecondCon, le.iid.combo_state, le.biid.verstate));
	self.verzip2 := if(~input2present, '', if(isSecondCon, le.iid.combo_zip, bverzip5 + bverzip4));
	// only output the social if it matches input
	self.versocs2 := if(~input2present, '', if(isSecondCon, if((integer)socscount2>0,le.iid.combo_ssn,''), if((integer)socscount2>0,le.biid.verfein,'')));
	self.verdob2 := if(~input2present, '', if(isSecondCon, le.iid.combo_dob, le.biid.RepDOBVerify));
	self.verhphone2 := if(~input2present, '', if(isSecondCon, le.iid.combo_hphone, le.biid.verphone));
	self.verwphone2 := if(~input2present, '', if(isSecondCon, le.iid.combo_wphone, le.biid.repphoneverify));
	self.verdrlc2 := ''; // always blank
	self.veremail2 := ''; // always blank
	self.socsmiskeyflag2 := if(isSecondCon, if(le.iid.socsmiskeyflag, '1','0'), '2');
	self.hphonemiskeyflag2 := if(isSecondCon, if(le.iid.hphonemiskeyflag, '1','0'), if(le.biid.phonemiskeyflag, '1', '0'));
	self.wphonemiskeyflag2 := if(isSecondCon, if(gn(le.iid.combo_wphonescore), '1', '0'), if(le.biid.rep_phonemiskeyflag, '1', '0'));
	self.addrmiskeyflag2 := if(isSecondCon, if(le.iid.addrmiskeyflag,'1','0'), if(le.biid.addrmiskeyflag,'1','0'));
	self.phoneLat2 := map(ri.apptype2 in ['1','4'] => le.iid.hphonelat,
					  ~input2present => le.biid.busphonelat, '');
	self.phoneLong2	:= map(ri.apptype2 in ['1','4'] => le.iid.hphonelong,
					  ~input2present => le.biid.busphonelong, '');
	self.addrLat2 := map(ri.apptype2 in ['1','4'] => le.iid.lat,
					  ~input2present => le.biid.lat, '');
	self.addrLong2 := map(ri.apptype2 in ['1','4'] => le.iid.long,
					  ~input2present => le.biid.long, '');	
	self.alerttable2 := if(ri.tribcode in ['b2bz', 'b2b4'], if(isSecondCon,le.iid.watchlist_table, le.biid.watchlist_table), '');	
	//self.apptype2 := ri.apptype2;
	self := [];
END;
mapped_results := join(biidIID, indata, left.iid.seq=right.seq, fill_output(left,right), left outer);
BSOptions := 0;
clam := Risk_Indicators.Boca_Shell_Function(iid, gateways, dppa, glb, false, false, true, false, false, true, datarestriction:=datarestriction, BSOptions:=BSOptions, datapermission:=datapermission,
                                                                               LexIdSourceOptout := LexIdSourceOptout, 
                                                                               TransactionID := TransactionID, 
                                                                               BatchUID := BatchUID, 
                                                                               GlobalCompanyID := GlobalCompanyID);
emptyclam := group(dataset([],Risk_Indicators.Layout_Boca_Shell),seq);

origInput := project(mapped_results, TRANSFORM(Layout_BusReasons_Input, self := left));

// for ex24, replace the consumer fraud defender score with business defender combined model... so instead of passing empty clam, pass in the full clam
fraudDefenderScore := map(tribcode in ['b2b2','b2bz','b2b4','b2bc','ex41','ex98'] => Models.FD5603_2_0(clam, ofac_only, isFCRA, inCalif, fdReasonsWith38), 
							tribcode='ex24' => Models.BD5605_1_0(clam, biid, origInput, ofac_only, nugen:=true),  // set nugen = true so the combined reason code set logic is applied
							dataset([],Models.Layout_ModelOut));

businessDefenderScore := map(tribcode in ['b2b2','b2bc','ex24'] => Models.BD5605_1_0(emptyclam, biid, origInput, ofac_only),
								tribcode in ['b2bz', 'b2b4'] => Models.BD5605_3_0(emptyclam, biid, origInput, ofac_only), 
								tribcode in ['ex41'] => Models.BD5605_2_0(emptyclam, biid, origInput, ofac_only), 
								tribcode in ['ex98'] => Models.BD9605_1_0(emptyclam, biid, origInput, ofac_only),
								dataset([],Models.Layout_ModelOut));

//ex41 and ex98 are exceptions to the rule.  the business score always goes in score field, and score3 is blank.
// ex41 has fdReasoncodes in set 1 and bdReasoncodes in set 2
// ex98 has bdReasoncodes in set 1 and fdReasoncodes in set 2

xlayout addFraudDefender(mapped_results le, fraudDefenderScore ri) := TRANSFORM
	useIt := le.apptype in ['1','4'];														// return 0-999 for ex24, don't cut off leading zeros
	self.score := if(useIt, if(tribcode in ['ex41', 'ex98'], '', if(tribcode='ex24', ri.score, ri.score[2..3]) ), le.score);
	self.reason11 := if(useIt, ri.ri[1].hri, le.reason11);
	self.reason21 := if(useIt, ri.ri[2].hri, le.reason21);
	self.reason31 := if(useIt, ri.ri[3].hri, le.reason31);
	self.reason41 := if(useIt, ri.ri[4].hri, le.reason41);
	
	useIt3 := le.apptype2 in ['1','4'];														// return 0-999 for ex24, don't cut off leading zeros
	self.score3 := if(useIt3, if(tribcode in ['ex41','ex98'], '', if(tribcode='ex24', ri.score, ri.score[2..3]) ), le.score3);
	self.reason13 := if(useIt3, ri.ri[1].hri, le.reason13);
	self.reason23 := if(useIt3, ri.ri[2].hri, le.reason23);
	self.reason33 := if(useIt3, ri.ri[3].hri, le.reason33);
	self.reason43 := if(useIt3, ri.ri[4].hri, le.reason43);
	
	self := le;
END;

withFraudDefender := join(mapped_results, fraudDefenderScore, left.seq = right.seq, addFraudDefender(LEFT,RIGHT), left outer);

xlayout addBusinessDefender(withFraudDefender le, businessDefenderScore ri) := TRANSFORM
	useIt := le.apptype not in ['1','4'];
	self.score := if(useIt or tribcode in ['ex41', 'ex98'], ri.score, le.score);
	self.reason11 := if(useIt, ri.ri[1].hri, le.reason11);
	self.reason21 := if(useIt, ri.ri[2].hri, le.reason21);
	self.reason31 := if(useIt, ri.ri[3].hri, le.reason31);
	self.reason41 := if(useIt, ri.ri[4].hri, le.reason41);
	
	useScore := le.apptype2 not in ['1','4'] and tribcode not in ['ex41','ex98','b2bc'];
	useReasons := le.apptype2 not in ['1','4'] and tribcode in ['b2b2','b2bz','b2b4','ex24','ex41'];
	self.score3 := if(useScore, ri.score, le.score3);
	self.reason13 := if(useReasons, ri.ri[1].hri, le.reason13);
	self.reason23 := if(useReasons, ri.ri[2].hri, le.reason23);
	self.reason33 := if(useReasons, ri.ri[3].hri, le.reason33);
	self.reason43 := if(useReasons, ri.ri[4].hri, le.reason43);
	
	self := le;
END;
withBusinessDefender := join(withFraudDefender, businessDefenderScore, left.seq=right.seq, addBusinessDefender(left,right), left outer);


riskwise.Layout_SDBO format_output(withBusinessDefender le) := TRANSFORM
	self.seq := le.seq;
	self.account := le.account;
	self.acctno := le.acctno;
	self.riskwiseid := le.riskwiseid;
	
	self.hriskhphoneflag := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.hriskhphoneflag, '');
	self.hriskwphoneflag := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.hriskwphoneflag, '');
	self.hphonevalflag := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.hphonevalflag, '');
	self.wphonevalflag := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.wphonevalflag, '');
	self.hphonezipflag := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.hphonezipflag, '');
	self.wphonezipflag := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.wphonezipflag, '');
	self.hriskaddrflag := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.hriskaddrflag, '');
	self.decsflag := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.decsflag, '');
	self.socsdobflag := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.socsdobflag, '');
	self.socsvalflag := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.socsvalflag, '');
	self.drlcvalflag := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.drlcvalflag, '');
	self.addrvalflag := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.addrvalflag, '');
	self.dwelltypeflag := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.dwelltypeflag, '');
	self.bansflag := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.bansflag, '');
	self.firstcount := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.firstcount, '');
	self.lastcount := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.lastcount, '');
	self.cmpycount := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.cmpycount, '');
	self.addrcount := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.addrcount, '');
	self.socscount := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.socscount, '');
	self.hphonecount := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.hphonecount, '');
	self.wphonecount := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.wphonecount, '');
	self.dobcount := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.dobcount, '');
	self.drlccount := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.drlccount, '');
	self.emailcount := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.emailcount, '');
	self.socsverlevel := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.socsverlevel, '');
	self.cmpyphoneverlevel := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.cmpyphoneverlevel, '');
	self.cmpyfaxverlevel := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.cmpyfaxverlevel, '');
	self.hphoneverlevel := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.hphoneverlevel, '');
	self.numelever := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.numelever, '');
	self.numsource := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.numsource, '');
	self.verfirst := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.verfirst, '');
	self.verlast := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.verlast, '');
	self.vercmpy := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.vercmpy, '');
	self.veraddr := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.veraddr, '');
	self.vercity := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.vercity, '');
	self.verstate := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.verstate, '');
	self.verzip := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.verzip, '');
	self.versocs := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.versocs, '');
	self.verdob := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.verdob, '');
	self.verhphone := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.verhphone, '');
	self.verwphone := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.verwphone, '');
	self.verdrlc := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.verdrlc, '');
	self.veremail := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.veremail, '');
	self.socsmiskeyflag := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.socsmiskeyflag, '');
	self.hphonemiskeyflag := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.hphonemiskeyflag, '');
	self.wphonemiskeyflag := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.wphonemiskeyflag, '');
	self.addrmiskeyflag := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'], le.addrmiskeyflag, '');
	self.alerttable1 :=  if(le.tribcode in ['b2bz','b2b4'], le.alerttable1, '');
	self.newjlunrlsdjdgmtcount := if(le.tribcode in ['ex24'], le.newjlunrlsdjdgmtcount, '');
	self.oldjlunrlsdjdgmtcount := if(le.tribcode in ['ex24'], le.oldjlunrlsdjdgmtcount, '');
	self.jlrlsdjdgmtcount := if(le.tribcode in ['ex24'], le.jlrlsdjdgmtcount, '');
	self.jlunrlsdliencount := if(le.tribcode in ['ex24'], le.jlunrlsdliencount, '');
	self.jlrlsdliencount := if(le.tribcode in ['ex24'], le.jlrlsdliencount, '');
	self.score := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24', 'ex41', 'ex98'], le.score, '');
	self.reason11 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24', 'ex41', 'ex98'], le.reason11, '');
	self.reason21 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24', 'ex41', 'ex98'], le.reason21, '');
	self.reason31 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24', 'ex41', 'ex98'], le.reason31, '');
	self.reason41 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24', 'ex41', 'ex98'], le.reason41, '');
		
	self.hriskhphoneflag2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.hriskhphoneflag2, '');
	self.hriskwphoneflag2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.hriskwphoneflag2, '');
	self.hphonevalflag2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.hphonevalflag2, '');
	self.wphonevalflag2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.wphonevalflag2 , '');
	self.hphonezipflag2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.hphonezipflag2, '');
	self.wphonezipflag2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.wphonezipflag2, '');
	self.hriskaddrflag2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.hriskaddrflag2, '');	
	self.decsflag2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.decsflag2, '');
	self.socsdobflag2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.socsdobflag2, '');
	self.socsvalflag2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.socsvalflag2, '');
	self.drlcvalflag2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.drlcvalflag2, '');
	self.addrvalflag2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.addrvalflag2, '');
	self.dwelltypeflag2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.dwelltypeflag2, '');
	self.bansflag2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.bansflag2, '');			    									
	self.firstcount2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.firstcount2, '');
	self.lastcount2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.lastcount2, '');
	self.cmpycount2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.cmpycount2, '');
	self.addrcount2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.addrcount2, '');
	self.socscount2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.socscount2, '');
	self.hphonecount2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.hphonecount2, '');
	self.wphonecount2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.wphonecount2, '');
	self.dobcount2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.dobcount2, '');
	self.drlccount2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.drlccount2, '');
	self.emailcount2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.emailcount2, '');
	self.socsverlevel2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.socsverlevel2, '');
	self.cmpyphoneverlevel2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.cmpyphoneverlevel2, '');
	self.cmpyfaxverlevel2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.cmpyfaxverlevel2, '');
	self.hphoneverlevel2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.hphoneverlevel2, '');
	self.numelever2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.numelever2, '');
	self.numsource2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.numsource2, '');
	self.verfirst2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.verfirst2, '');
	self.verlast2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.verlast2, '');
	self.vercmpy2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.vercmpy2, '');
	self.veraddr2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.veraddr2, '');
	self.vercity2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.vercity2, '');
	self.verstate2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.verstate2, '');
	self.verzip2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.verzip2, '');
	self.versocs2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.versocs2, '');
	self.verdob2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.verdob2, '');
	self.verhphone2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.verhphone2, '');
	self.verwphone2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.verwphone2, '');
	self.verdrlc2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.verdrlc2, '');
	self.veremail2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.veremail2, '');
	self.socsmiskeyflag2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.socsmiskeyflag2, '');
	self.hphonemiskeyflag2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.hphonemiskeyflag2, '');
	self.wphonemiskeyflag2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.wphonemiskeyflag2, '');
	self.addrmiskeyflag2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.addrmiskeyflag2, '');
	self.alerttable2 :=  if(le.tribcode in ['b2bz','b2b4'], le.alerttable2, ''); 
	self.newjlunrlsdjdgmtcount2 := if(le.tribcode in ['ex24'], le.newjlunrlsdjdgmtcount2, '');
	self.oldjlunrlsdjdgmtcount2 := if(le.tribcode in ['ex24'], le.oldjlunrlsdjdgmtcount2, '');
	self.jlrlsdjdgmtcount2 := if(le.tribcode in ['ex24'], le.jlrlsdjdgmtcount2, '');
	self.jlunrlsdliencount2 := if(le.tribcode in ['ex24'], le.jlunrlsdliencount2, '');
	self.jlrlsdliencount2 := if(le.tribcode in ['ex24'], le.jlrlsdliencount2, '');
	self.score3 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'], le.score3, '');
	self.reason13 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24', 'ex41', 'ex98'], le.reason13, '');
	self.reason23 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24', 'ex41', 'ex98'], le.reason23, '');
	self.reason33 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24', 'ex41', 'ex98'], le.reason33, '');
	self.reason43 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24', 'ex41', 'ex98'], le.reason43, '');
	
	self.distphoneaddr := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'b2bc', 'ex24'] and le.phoneLat != '' and le.addrLat != '', 
						(string)round(ut.ll_dist((real)le.phoneLat,(real)le.phoneLong,(real)le.addrLat,(real)le.addrLong)),
						''); // this is the only distance calculated for b2bc
						
	self.distphone2addr2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'] and le.phoneLat2 != '' and le.addrLat2 != '',
						 (string)round(ut.ll_dist((real)le.phoneLat2,(real)le.phoneLong2,(real)le.addrLat2,(real)le.addrLong2)),
						 '');
	self.distphoneaddr2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'] and le.phoneLat != '' and le.addrLat2 != '',
						(string)round(ut.ll_dist((real)le.phoneLat,(real)le.phoneLong,(real)le.addrLat2,(real)le.addrLong2)),
						'');
	self.distphonephone2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'] and le.phoneLat != '' and le.phoneLat2 != '',
						 (string)round(ut.ll_dist((real)le.phoneLat,(real)le.phoneLong,(real)le.phoneLat2,(real)le.phoneLong2)), 
						 '');
	self.distaddraddr2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'] and le.addrLat != '' and le.addrLat2 != '',
						(string)round(ut.ll_dist((real)le.addrLat,(real)le.addrLong,(real)le.addrLat2,(real)le.addrLong2)), 
						'');
	self.distaddrphone2 := if(le.tribcode in ['b2b2', 'b2bz','b2b4', 'ex24'] and le.addrLat != '' and le.phoneLat2 != '',
						(string)round(ut.ll_dist((real)le.addrLat,(real)le.addrLong,(real)le.phoneLat2,(real)le.phoneLong2)),
						'');
END;

final := project(withBusinessDefender, format_output(left));

// output(biid_res, named('biid_res'));
// output(biid, named('biid'));
// output(iid_res, named('iid_res'));
// output(iid, named('iid'));
// output(origInput, named('origInput'));
// output(clam, named('clam'));
//output(fraudDefenderScore, named('fraudDefenderScore'));
// output(businessDefenderScore, named('businessDefenderScore'));
/*
output(withFraudDefender, named('withFraudDefender'));
output(withBusinessDefender, named('withBusinessDefender'));
*/
#STORED('Royalties', dRoyalties);
return final;

END;