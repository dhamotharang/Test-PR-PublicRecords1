import doxie, address, risk_indicators, iesp, business_risk, models, ut, riskwise, Gateway;
export InstantID_Batch_Service_records(dataset(Gateway.Layouts.Config)  gateways_in,
                                 dataset(business_risk.Layout_Input_Moxie_2) df,
																 boolean hb,
																 unsigned2 glb,
																 unsigned2 dppa,
																 boolean isUtility,
																 boolean ln_branded_value,
																 string4 tribcode,
																 boolean excludeWatchLists,
																 boolean ofac_only,
																 unsigned1 ofac_version,
																 boolean include_ofac,
																 boolean include_additional_watchlists,
																 real global_watchlist_threshold,
																 integer2 dob_radius_use,
																 boolean isPOBoxCompliant,
																 //bsversion // set directly,
																 //exactMatchLevel set directly,
																 boolean IncludeTargus3220,
																 string50 DataRestriction,
																 boolean includeMSoverride,
																 boolean IncludeDLverification,
																 
																 dataset(iesp.share.t_StringArrayItem) watchlists_request,
																 boolean suppressNearDups,
																 boolean require2ele,
																 boolean fromBiid,
																 boolean isFCRA,
																 boolean from_IT1O,
																 boolean nugen,
																 string Model_name,
																 boolean IncludeFraudScores,
																 boolean IncludeRepAttributes,
																 string50 DataPermission=Risk_Indicators.iid_constants.default_DataPermission
																 ) := function																 

Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := map(IncludeTargus3220 and le.servicename = 'targus' => 'targuse3220',	// if E3220 requested, change servicename for later use
                      le.servicename = 'bridgerwlc' and ofac_version != 4  => '',
													le.servicename);
	self.url := map(IncludeTargus3220 and le.servicename = 'targus' => le.url + '?ver_=1.39',	// need version 1.39 for E3220,
                  le.servicename = 'bridgerwlc' and ofac_version != 4  => '',
									le.url); 
	self := le;								
end;
gateways := project(gateways_in, gw_switch(left));

business_risk.layout_input into_in(df L, integer C) := transform
	self.seq := C;
	self.account		:= L.acctno;
	self.company_name 	:= stringlib.stringtouppercase(L.name_company);
	self.alt_company_name := stringlib.stringtouppercase(L.alt_company_name);
	
	street_address := risk_indicators.MOD_AddressClean.street_address(l.street_addr, l.prim_range, l.predir, l.prim_name, l.addr_suffix, l.postdir, l.unit_desig, l.sec_range);
	clean_bus_addr := risk_indicators.MOD_AddressClean.clean_addr( street_address, l.p_City_name, l.St, l.Z5 ) ;	
	

	self.prim_range := clean_bus_addr[1..10];
	self.predir	 := clean_bus_addr[11..12];
	self.prim_name	 := clean_bus_addr[13..40];
	self.addr_suffix := clean_bus_addr[41..44];
	self.postdir	 := clean_bus_addr[45..46];
	self.unit_desig := clean_bus_addr[47..56];
	self.sec_range  := clean_bus_addr[57..64];
	self.p_city_name := clean_bus_addr[65..89];
	self.v_city_name := clean_bus_addr[90..114];
	self.st		 := clean_bus_addr[115..116];
	self.z5		 := clean_bus_addr[117..121];
	self.zip4		 := clean_bus_addr[122..125];
	self.orig_z5 	 := l.z5;
	self.lat		 := clean_bus_addr[146..155];
	self.long		 := clean_bus_addr[156..166];
	self.addr_type := risk_indicators.iid_constants.override_addr_type(street_address, clean_bus_addr[139], clean_bus_addr[126..129]);
	self.addr_status := clean_bus_addr[179..182];
	self.county := clean_bus_addr[143..145];
	self.geo_blk := clean_bus_addr[171..177];	
			
	self.phone10 		:= L.phoneno;
	
	cleaned_name :=address.CleanPerson73(l.UnParsedFullName);
	boolean valid_cleaned := l.UnParsedFullName <>'';
	
	self.rep_fname :=stringlib.stringtouppercase(if(l.Name_First='' AND valid_cleaned,cleaned_name[6..25],L.Name_First));
	self.rep_lname :=stringlib.stringtouppercase(if(l.Name_Last='' AND valid_cleaned,cleaned_name[46..65],L.Name_Last));
	self.rep_mname :=stringlib.stringtouppercase(if(l.Name_Middle='' AND valid_cleaned,cleaned_name[26..45],L.Name_Middle));
	self.rep_name_suffix :=stringlib.stringtouppercase(if(l.Name_Suffix ='' AND valid_cleaned,cleaned_name[66..70],L.Name_Suffix));	
		
	self.rep_alt_lname	:= stringlib.stringtouppercase(L.name_last_alt);
	self.rep_ssn		:= L.ssn;
	self.rep_dob		:= L.dob;
	self.rep_age := if ((integer)l.dob != 0, (STRING3)ut.GetAgeI((integer)l.dob), '');
	self.rep_phone		:= L.phone_2;

	street_address2 := risk_indicators.MOD_AddressClean.street_address(l.street_addr2, l.prim_range_2, l.predir_2, l.prim_name_2, l.addr_suffix_2, l.postdir_2, l.unit_desig_2, l.sec_range_2);
	clean_rep_addr := risk_indicators.MOD_AddressClean.clean_addr( street_address2, l.p_City_name_2, l.St_2, l.Z5_2 ) ;		
	
	self.rep_prim_range := clean_rep_addr[1..10];
	self.rep_predir	:= clean_rep_addr[11..12];
	self.rep_prim_name	:= clean_rep_addr[13..40];
	self.rep_addr_suffix := clean_rep_addr[41..44];
	self.rep_postdir	:= clean_rep_addr[45..46];
	self.rep_unit_desig := clean_rep_addr[47..56];
	self.rep_sec_range  := clean_rep_addr[57..64];
	self.rep_p_city_name := clean_rep_addr[65..89];
	self.rep_st		:= clean_rep_addr[115..116];
	self.rep_z5		:= clean_rep_addr[117..121];
	self.rep_orig_city 	:= stringlib.stringtouppercase(L.p_city_name_2);
	self.rep_orig_st	:=  stringlib.stringtouppercase(l.st_2);
	self.rep_orig_z5	:=  l.z5_2;
	self.rep_zip4		:= clean_rep_addr[122..125];
	self.rep_lat		:= clean_rep_addr[146..155];
	self.rep_long		:= clean_rep_addr[156..166];
	self.rep_addr_type  := risk_indicators.iid_constants.override_addr_type(street_address2, clean_rep_addr[139],clean_rep_addr[126..129]); 
	self.rep_addr_status := clean_rep_addr[179..182];
	self.rep_county := clean_rep_addr[143..145];
	self.rep_geo_blk := clean_rep_addr[171..177];
	
	dl_num := stringlib.stringFilterOut(L.dl_number,'-');
	dl_num2 := stringlib.stringFilterOut(dl_num,' ');
	
	self.rep_dl_num	:= stringlib.stringtouppercase(dl_num2);
	self.rep_dl_state	:= stringlib.stringtouppercase(L.dl_state);
	self.rep_email := l.rep_email;
	
	self.historydate := if(l.HistoryDateYYYYMM=0, risk_indicators.iid_constants.default_history_date, l.HistoryDateYYYYMM);
	
	self := L;
end;

df2 := project(df, into_in(LEFT, counter));

if( ofac_version = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));

bsversion := 2;
exactMatchlevel := risk_indicators.iid_constants.default_ExactMatchLevel;
AppendBest := 1;
biid := business_risk.InstantID_Function(df2,gateways,hb,dppa,glb,isUtility,ln_branded_value,tribcode,ExcludeWatchLists, 
																			ofac_only,ofac_version,include_ofac,include_additional_watchlists,Global_WatchList_Threshold,dob_radius_use,
																			IsPOBoxCompliant, bsversion, exactMatchLevel, DataRestriction, IncludeMSoverride, IncludeDLverification, watchlists_request,
																			AppendBest, IncludeRepAttributes, false, DataPermission);

// this code is all to append the fraud scores if the boolean IncludeFraudScores is set to true
	risk_indicators.layout_input into(df2 l) := transform
		self.seq := l.seq;
		self.historydate := l.historydate;
		self.fname := l.rep_fname;
		self.mname := l.rep_mname;
		self.lname := l.rep_lname;
		self.suffix := l.rep_name_suffix;
		
		addr1 := Risk_Indicators.MOD_AddressClean.street_address('',l.rep_prim_range,l.rep_predir,l.rep_prim_name,l.rep_addr_suffix,l.rep_postdir,l.rep_unit_desig,l.rep_sec_range);
		clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(addr1, l.rep_orig_city,l.rep_orig_st,l.rep_orig_z5);

		
		SELF.in_streetAddress := addr1;
		SELF.in_city := l.rep_orig_city;
		SELF.in_state := l.rep_orig_st;
		SELF.in_zipCode := l.rep_orig_z5;
		SELF.in_country := l.rep_country;
			
		self.prim_range := clean_a2[1..10];
		self.predir := clean_a2[11..12];
		self.prim_name := clean_a2[13..40];
		self.addr_suffix := clean_a2[41..44];
		self.postdir := clean_a2[45..46];
		self.unit_desig := clean_a2[47..56];
		self.sec_range := clean_a2[57..64];
		self.p_city_name := clean_a2[90..114];
		self.st := clean_a2[115..116];
		self.z5 := clean_a2[117..121];
		self.zip4 := clean_a2[122..125];	
		self.lat := clean_a2[146..155];
		self.long := clean_a2[156..166];
		self.addr_type := clean_a2[139];
		self.addr_status := clean_a2[179..182];
		self.county := clean_a2[143..145];
		self.geo_blk := clean_a2[171..177];
		
		self.country := l.rep_country;
			
		self.ssn := l.rep_ssn;
		self.dob := l.rep_dob;
		self.age := l.rep_age;	
		
		SELF.dl_number := l.rep_dl_num;
		SELF.dl_state := l.rep_dl_state;
		
		SELF.email_address := l.rep_email;
		SELF.ip_address := l.ip_addr;
		
		self.phone10 := l.rep_phone;
		self.wphone10 := l.phone10;
		
		SELF.employer_name := l.company_name;
		SELF.lname_prev := l.rep_alt_lname;
	end;
	prep := PROJECT(df2,into(LEFT));

// match default settings it was using before adding the dataRestriction
boolean runSSNCodes:=true;
boolean runBestAddrCheck:=true; 
boolean runChronoPhoneLookup:=true;	
boolean runAreaCodeSplitSearch:=true;
boolean allowCellphones:=false;
string10 CustomDataFilter:='';
													
	iid := risk_indicators.InstantID_Function(prep, gateways, DPPA, GLB, isUtility, ln_branded_value, ofac_only, 
										suppressNearDups, require2ele, fromBiid, isFCRA, ExcludeWatchlists, from_IT1O, 
										ofac_version, include_ofac, include_additional_watchlists, Global_WatchList_Threshold, 
										dob_radius_use, bsversion, runSSNCodes, runBestAddrCheck, runChronoPhoneLookup, runAreaCodeSplitSearch, allowcellphones,
										exactMatchLevel,DataRestriction,CustomDataFilter, IncludeDLverification, watchlists_request, in_DataPermission:=DataPermission);
										
	
	clam := risk_indicators.Boca_Shell_Function(iid, gateways, DPPA, GLB, isUtility, ln_branded_value, true, false, false, true, DataRestriction:=DataRestriction, DataPermission:=DataPermission);

	riskwise.Layout_BusReasons_Input into_orig_input(biid l) := transform
		self.seq := l.seq;
		addr1 := Risk_Indicators.MOD_AddressClean.street_address('',L.prim_Range,L.predir,L.prim_name,L.addr_suffix,L.postdir,L.unit_desig,L.sec_Range);
		self.orig_addr := addr1;
		self.orig_city := l.p_city_name;
		self.orig_state := l.st;
		self.orig_zip := l.orig_z5;
		self.orig_fax := '';
		self.orig_cmpy := l.company_name;
		self.orig_wphone := l.phone10;
		self.telcoPhoneType := l.TelcordiaPhoneType;
		
		bans_current := if(((integer)(ut.GetDate[1..6]) - (integer)(l.RecentBkDate[1..6])) < 1000, true, false);  // make sure the bans is within the last 10 years
		lien_current := if(((integer)(ut.GetDate[1..6]) - (integer)(l.RecentLienDate[1..6])) < 1000, true, false);  // make sure the bans is within the last 10 years
		self.cmpy_bans :=  map(l.fein='' or (l.company_name='' and addr1='') => '3',
												  l.bkbdidflag and l.lienbdidflag and bans_current and lien_current => '5',
												  l.bkbdidflag and bans_current => '2', 
												  l.lienbdidflag and lien_current => '4',
												   '0');								   
	end;

	orig_input := project(biid, into_orig_input(left));
		
	ret := Models.BD3605_0_0(clam, biid, orig_input, ofac_only, nugen);
	ret2 := Models.BD5605_0_0(clam, biid, orig_input, ofac_only, nugen);
	ret3 := Models.BD9605_generic(clam, biid, orig_input, ofac_only, nugen);

	models.Layout_Model_Batch tf1(biid l, ret r) := transform
		self.seq := l.seq;
		self.acctno := l.account;
		//self.Description := 'BatchBusinessDefender';
		self.score_0_to_999 := r.score;
		self.score_10_to_50 := '';
		self.score_10_to_90 := '';
		self.PRI_1 := if(r.ri[1].hri <> '00', r.ri[1].hri, '');
		self.PRI_Desc_1 := r.ri[1].desc;
		self.PRI_2 := if(r.ri[2].hri <> '00', r.ri[2].hri, '');
		self.PRI_Desc_2 := r.ri[2].desc;
		self.PRI_3 := if(r.ri[3].hri <> '00', r.ri[3].hri, '');
		self.PRI_Desc_3 := r.ri[3].desc;
		self.PRI_4 := if(r.ri[4].hri <> '00', r.ri[4].hri, '');
		self.PRI_Desc_4 := r.ri[4].desc;
	end;
	j1 := join(biid, ret, left.seq = right.seq, tf1(left,right));

	models.Layout_Model_Batch tf2(models.Layout_Model_Batch l, ret2 r) := transform
		self.score_10_to_50 := r.score;
		self := l;
	end;
	j2 := join(j1, ret2, left.seq = right.seq, tf2(left,right));

	models.Layout_Model_Batch tf3(models.Layout_Model_Batch l, ret3 r) := transform
		self.score_10_to_90 := (string)(integer)r.score;
		self := l;
	end;
	j3 := join(j2, ret3, left.seq = right.seq, tf3(left,right));
// end of fraud scores


// Run the Business Shell
bshell := Business_Risk.Business_Shell_Function( biid, glb );

scores := map(
	model_name  = 'rsb801_1' => Models.RSB801_1_0( bshell ),
	model_name != ''         => dataset([], models.Layout_Model_Batch), // unknown custom model gets no results
	IncludeFraudScores => j3,
	dataset([], models.Layout_Model_Batch)
);

business_risk.layout_final_batch into_final(biid L, scores R) := transform
	self.pri_1 := L.pri1;
	self.pri_desc_1 := if( L.pri1 = '', '', Risk_Indicators.getHRIDesc(L.pri1) );
	self.pri_2 := L.pri2;
	self.pri_desc_2 := if( L.pri2 = '', '', Risk_Indicators.getHRIDesc(L.pri2) );
	self.pri_3 := L.pri3;
	self.pri_desc_3 := if( L.pri3 = '', '', Risk_Indicators.getHRIDesc(L.pri3) );
	self.pri_4 := L.pri4;
	self.pri_desc_4 := if( L.pri4 = '', '', Risk_Indicators.getHRIDesc(L.pri4) );
	self.pri_5 := L.pri5;
	self.pri_desc_5 := if( L.pri5 = '', '', Risk_Indicators.getHRIDesc(L.pri5) );
	self.pri_6 := L.pri6;
	self.pri_desc_6 := if( L.pri6 = '', '', Risk_Indicators.getHRIDesc(L.pri6) );
	self.pri_7 := L.pri7;
	self.pri_desc_7 := if( L.pri7 = '', '', Risk_Indicators.getHRIDesc(L.pri7) );
	self.pri_8 := L.pri8;
	self.pri_desc_8 := if( L.pri8 = '', '', Risk_Indicators.getHRIDesc(L.pri8) );
	self.rep_pri_1 := L.rep_pri1;
	self.rep_pri_desc_1 := if (L.rep_pri1 = '', '' , Risk_Indicators.getHRIDesc((L.rep_pri1)));
	self.rep_pri_2 := L.rep_pri2;
	self.rep_pri_desc_2 := if (L.rep_pri2 = '', '' , Risk_Indicators.getHRIDesc((L.rep_pri2)));
	self.rep_pri_3 := L.rep_pri3;
	self.rep_pri_desc_3 := if (L.rep_pri3 = '', '' , Risk_Indicators.getHRIDesc((L.rep_pri3)));
	self.rep_pri_4 := L.rep_pri4;
	self.rep_pri_desc_4 := if (L.rep_pri4 = '', '' , Risk_Indicators.getHRIDesc((L.rep_pri4)));
	self.rep_pri_5 := L.rep_pri5;
	self.rep_pri_desc_5 := if (L.rep_pri5 = '', '' , Risk_Indicators.getHRIDesc((L.rep_pri5)));
	self.rep_pri_6 := L.rep_pri6;
	self.rep_pri_desc_6 := if (L.rep_pri6 = '', '' , Risk_Indicators.getHRIDesc((L.rep_pri6)));
	self.rep_followup_1 := L.rep_followup1;
	self.rep_followup_desc_1 := risk_indicators.getFUADesc(L.rep_followup1);
	self.rep_followup_2 := L.rep_followup2;
	self.rep_followup_desc_2 := risk_indicators.getFUADesc(L.rep_followup2);
	self.rep_followup_3 := L.rep_followup3;
	self.rep_followup_desc_3 := risk_indicators.getFUADesc(L.rep_followup3);
	self.rep_followup_4 := L.rep_followup4;
	self.rep_followup_desc_4 := risk_indicators.getFUADesc(L.rep_followup4);
	self.bdid := intformat(L.bdid, 12, 1);
	self.score := intformat(L.score, 3, 0);
	self.account := L.account;
	self.acctno  := L.account;
	self.verNotRecentFlag := if (L.verNotRecentFlag, 'Y', 'N');
	self.bestCompanyNameScore := intformat(L.bestCompanyNameScore, 3, 0);
	self.bestAddrScore := intformat(L.bestAddrScore, 3, 0);
	self.bestFEINScore := intformat(L.bestFEINScore, 3, 0);
	self.bestPhoneScore := intformat(L.bestPhoneScore, 3, 0);
	self.dt_first_Seen_min := (String)L.dt_first_seen_min;
	self.dt_last_seen_max := (string)L.dt_last_seen_max;
	//self.watchlist_num_with_name := (string)L.watchlist_num_with_name;
	self.dist_homeAddr_BusAddr := (string)L.dist_homeAddr_BusAddr;
	self.dist_homePhone_BusAddr := (string)L.dist_homePhone_busAddr;
	self.dist_homeAddr_busPhone := (string)L.dist_HomeAddr_BusPhone;
	self.dist_homePhone_BusPhone := (string)L.dist_HomePhone_BusPHone;
	self.dist_homePhone_HomeAddr := (string)L.dist_HomePhone_HomeAddr;
	self.dist_BusPhone_BusAddr	:= (string)L.dist_BusPhone_BusAddr;
	self.Hist_date_last_Seen_1 := (string)L.Hist_date_last_seen_1;
	self.Hist_date_last_Seen_2 := (string)L.Hist_date_last_seen_2;
	self.Hist_date_last_Seen_3 := (string)L.Hist_date_last_seen_3;
	self.repWatchlist_num_with_name := (string)L.repWatchlist_Num_With_Name;
	self.UnreleasedLienCount := intformat(L.unreleasedLienCount,4,0);
	self.ReleasedLienCount  := intformat(L.releasedLienCount,4, 0);
	self.TotalBKCount	:= (string)L.bankruptcy_Count;
	self.addr1 := Risk_Indicators.MOD_AddressClean.street_address('',L.prim_range, L.predir, L.prim_name, L.addr_suffix, L.postdir, L.unit_desig, L.sec_range);
	self.rep_addr1 := Risk_Indicators.MOD_AddressClean.street_address('',L.rep_prim_range, L.rep_predir, L.rep_prim_name, L.rep_addr_suffix, L.rep_postdir, L.rep_unit_desig, L.rep_sec_range);
	self.AddrMatchPhone := L.CmpyPhoneFromAddr;
	self.verzip := if (L.verzip != '', intformat((integer)L.verzip,5,1),'');
	self.bestZip := if (L.bestZip != '', intformat((integer)L.bestZip,5,1),'');
	self.bestZip4 := if (L.bestZip4 != '', intformat((integer)L.bestZip4,4,1),'');
	self.phoneMatchZip := if (L.phoneMatchZip != '', intformat((integer)L.phoneMatchZip,5,1),'');
	self.phoneMatchZip4 := if (L.phoneMatchZip4 != '', intformat((integer)L.phoneMatchZip4,4,1),'');
	self.FEINMatchZip1 := if (L.FEINMatchZip1 != '', intformat((integer)L.FEINMatchZip1,5,1),'');
	self.FEINMatchZip4_1 := if (L.FEINMatchZip4_1 != '', intformat((integer)L.FEINMatchZip4_1,4,1),'');
	self.FEINMatchZip2 := if (L.FEINMatchZip2 != '', intformat((integer)L.FEINMatchZip2,5,1),'');
	self.FEINMatchZip4_2 := if (L.FEINMatchZip4_2 != '', intformat((integer)L.FEINMatchZip4_2,4,1),'');
	self.FEINMatchZip3 := if (L.FEINMatchZip3 != '', intformat((integer)L.FEINMatchZip3,5,1),'');
	self.FEINMatchZip4_3 := if (L.FEINMatchZip4_3 != '', intformat((integer)L.FEINMatchZip4_3,4,1),'');
	self.RecentBkZip := if (L.RecentBkZip != '', intformat((integer)L.RecentBkZip,5,1),'');
	self.RecentBkZip4 := if (L.RecentBkZip4 != '', intformat((integer)L.RecentBkZip4,4,1),'');
	self.RecentLienZip := if (L.RecentLienZip != '', intformat((integer)L.RecentLienZip,5,1),'');
	self.RecentLienZip4 := if (L.RecentLienZip4 != '', intformat((integer)L.RecentLienZip4,4,1),'');
	self.watchlist_zip := if (L.watchlist_zip != '', intformat((integer)L.watchlist_zip,5,1),'');
	self.RepZipVerify := if (L.RepZipVerify != '', intformat((integer)L.RepZipVerify,5,1),'');
	self.RepZip4Verify := if (L.RepZip4Verify != '', intformat((integer)L.RepZip4Verify,4,1),'');
	self.RepBestZip := if (L.RepBestZip != '', intformat((integer)L.RepBestZip,5,1),'');
	self.RepBestZip4 := if (L.RepBestZip4 != '', intformat((integer)L.RepBestZip4,4,1),'');
	self.RepPhoneZip := if (L.RepPhoneZip != '', intformat((integer)L.RepPhoneZip,5,1),'');
	self.RepPhoneZip4 := if (L.RepPhoneZip4 != '', intformat((integer)L.RepPhoneZip4,4,1),'');
	self.RepWatchlist_zip := if (L.RepWatchlist_zip != '', intformat((integer)L.RepWatchlist_zip,5,1),'');
	self.Hist_Zip_1 := if (L.Hist_Zip_1 != '', intformat((integer)L.Hist_Zip_1,5,1),'');
	self.Hist_Zip4_1 := if (L.Hist_Zip4_1 != '', intformat((integer)L.Hist_Zip4_1,4,1),'');
	self.Hist_Zip_2 := if (L.Hist_Zip_2 != '', intformat((integer)L.Hist_Zip_2,5,1),'');
	self.Hist_Zip4_2 := if (L.Hist_Zip4_2 != '', intformat((integer)L.Hist_Zip4_2,4,1),'');
	self.Hist_Zip_3 := if (L.Hist_Zip_3 != '', intformat((integer)L.Hist_Zip_3,5,1),'');
	self.Hist_Zip4_3 := if (L.Hist_Zip4_3 != '', intformat((integer)L.Hist_Zip4_3,4,1),'');
	self.areacodesplitdate := if(l.areacodesplitflag='Y', l.areacodesplitdate, '');
	self.altareacode := if(l.areacodesplitflag='Y', l.altareacode, '');
	
	self.fd_score1 := r.score_0_to_999;
	self.fd_score2 := r.score_10_to_50;
	self.fd_score3 := r.score_10_to_90;
	self.fd_Reason1 := r.pri_1;
	self.fd_Desc1 := r.pri_desc_1;
	self.fd_Reason2 := r.pri_2;
	self.fd_Desc2 := r.pri_desc_2;
	self.fd_Reason3 := r.pri_3;
	self.fd_Desc3 := r.pri_desc_3;
	self.fd_Reason4 := r.pri_4;
	self.fd_Desc4 := r.pri_desc_4;
	
	self.Alt_Fname_1				:= if((integer)l.RepNas_Score IN [4,7,9,10,11,12], l.Alt_Fname_1, '');
	self.Alt_Lname_1				:= if((integer)l.RepNas_Score IN [4,7,9,10,11,12], l.Alt_Lname_1, '');
	self.Alt_Date_Last_Seen_1		:= if((integer)l.RepNas_Score IN [4,7,9,10,11,12], l.Alt_Date_Last_Seen_1, '');
	self.Alt_Fname_2				:= if((integer)l.RepNas_Score IN [4,7,9,10,11,12], l.Alt_Fname_2, '');
	self.Alt_Lname_2				:= if((integer)l.RepNas_Score IN [4,7,9,10,11,12], l.Alt_Lname_2, '');
	self.Alt_Date_Last_Seen_2		:= if((integer)l.RepNas_Score IN [4,7,9,10,11,12], l.Alt_Date_Last_Seen_2, '');
	self.Alt_Fname_3				:= if((integer)l.RepNas_Score IN [4,7,9,10,11,12], l.Alt_Fname_3, '');
	self.Alt_Lname_3				:= if((integer)l.RepNas_Score IN [4,7,9,10,11,12], l.Alt_Lname_3, '');
	self.Alt_Date_Last_Seen_3		:= if((integer)l.RepNas_Score IN [4,7,9,10,11,12], l.Alt_Date_Last_Seen_3, '');		
	
	Rep_Attributes := L.Attributes;
	
	SELF.Rep_Lien_Unrel_Lvl := Rep_Attributes(Name = 'Rep_Lien_Unrel_Lvl')[1].Value;
	SELF.Rep_Prop_Owner := Rep_Attributes(Name = 'Rep_Prop_Owner')[1].Value;
	SELF.Rep_Prof_License_Category := Rep_Attributes(Name = 'Rep_Prof_License_Category')[1].Value;
	SELF.Rep_Accident_Count := Rep_Attributes(Name = 'Rep_Accident_Count')[1].Value;
	SELF.Rep_Paydayloan_Flag := Rep_Attributes(Name = 'Rep_Paydayloan_Flag')[1].Value;
	SELF.Rep_Age_Lvl := Rep_Attributes(Name = 'Rep_Age_Lvl')[1].Value;
	SELF.Rep_Bankruptcy_Count := Rep_Attributes(Name = 'Rep_Bankruptcy_Count')[1].Value;
	SELF.Rep_Ssns_Per_Adl := Rep_Attributes(Name = 'Rep_Ssns_Per_Adl')[1].Value;
	SELF.Rep_Past_Arrest := Rep_Attributes(Name = 'Rep_Past_Arrest')[1].Value;
	SELF.Rep_Add1_Lres_Lvl := Rep_Attributes(Name = 'Rep_Add1_Lres_Lvl')[1].Value;
	SELF.Rep_Criminal_Assoc_Lvl := Rep_Attributes(Name = 'Rep_Criminal_Assoc_Lvl')[1].Value;
	SELF.Rep_Felony_Count := Rep_Attributes(Name = 'Rep_Felony_Count')[1].Value;
	
	self := L;
end;


outunchecked := join(biid, scores, left.seq=right.seq, into_final(LEFT,RIGHT), left outer);
//output(df2, named('df2'));
return (choosen(outunchecked,all));
end;

