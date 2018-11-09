import ut, address, Risk_Indicators, Models, gateway;

export NP2O_Function(dataset(Layout_PRII) indata, dataset(Gateway.Layouts.Config) gateways, unsigned1 glb, unsigned1 dppa, string4 tribCode,
							string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
							string50 DataPermission=risk_indicators.iid_constants.default_DataPermission, OFACversion = 1):= FUNCTION

boolean OFAC := tribCode in ['np21','np25','np27','np50','np60','np80','np81','np82','np90','np91','np92']; 

// JRP 02/12/2008 - Dataset of actioncode settings which are passed to the getactioncodes function.
boolean IsPOBoxCompliant := false;
boolean IsInstantID := false;
actioncode_settings := dataset([{IsPOBoxCompliant, IsInstantID}],riskwise.layouts.actioncode_settings);

risk_indicators.layout_input into(indata le) := TRANSFORM

	clean_a := risk_indicators.MOD_AddressClean.clean_addr(le.addr, le.city, le.State, le.Zip);
	
	ssn_val := cleanSSN( le.socs );
	hphone_val := cleanPhone( le.hphone );
	wphone_val := cleanPhone( le.wphone );
	dob_val := cleanDOB(le.dob);
	dl_num_clean := cleanDL_num( le.drlc );

	self.seq := le.seq;
	self.ssn := ssn_val;
	self.dob := dob_val;
	self.phone10 := hphone_val;	
	self.wphone10 := wphone_val;
	self.fname := stringlib.stringtouppercase(le.first);
	self.mname := stringlib.stringtouppercase(le.middleini);
	self.lname := stringlib.stringtouppercase(le.last);
	self.in_streetAddress := stringlib.stringtouppercase(le.addr);
	self.in_city := stringlib.stringtouppercase(le.city);
	self.in_state := stringlib.stringtouppercase(le.state);
	self.in_zipCode := le.zip;
	self.prim_range := clean_a[1..10];
	self.predir := clean_a[11..12];
	self.prim_name := clean_a[13..40];
	self.addr_suffix := clean_a[41..44];
	self.postdir := clean_a[45..46];
	self.unit_desig := clean_a[47..56];
	self.sec_range := clean_a[57..64];
	self.p_city_name := clean_a[90..114];
	self.st := clean_a[115..116];
	self.z5 := if(clean_a[117..121]<>'',clean_a[117..121],le.zip[1..5]);		// use the input zip if cass zip is empty
	self.zip4 := if(clean_a[122..125]<>'', clean_a[122..125], le.zip[6..9]);	// use the input zip if cass zip is empty
	self.lat := clean_a[146..155];
	self.long := clean_a[156..166];
	self.addr_type := clean_a[139];
	self.addr_status := clean_a[179..182];
	self.county := clean_a[143..145];
	self.geo_blk := clean_a[171..177];
	self.dl_number := stringlib.stringtouppercase(dl_num_clean);
	self.dl_state := stringlib.stringtouppercase(le.drlcstate);
	self.age := if((integer)dob_val != 0, (string3)ut.GetAgeI((integer)dob_val), '');
	self.email_address := le.email;
	self.employer_name := stringlib.stringtouppercase(le.cmpy);
	self.lname_prev := stringlib.stringtouppercase(le.formerlast);
	self.country := le.countrycode;
	self.in_country := le.countrycode;
	self.historydate := le.historydate;
	self := [];
END;

prep := PROJECT(indata, into(LEFT));

ofac_version := map( tribcode = 'np21' and OFACversion = 4 => OFACversion,
																				tribcode in ['np90','np91','np92'] => 3, 
																																														1);
include_ofac := map(	tribcode = 'np21' and OFACversion = 4 => true,
																					tribcode in ['np90','np91','np92'] => true, 
																					false);
watchlist_threshold := map( tribcode = 'np21' and OFACversion = 4 => 0.85, 
																											tribcode in ['np90','np91','np92'] => 0.85, 
																										 0.84);

//options for target model fp1403 to get cvi from np31
DisableInquiriesInCVI := True;			//Disable Customer Network: True
LastSeenThresholdIn := 730;	            //Last Seen Threshold: 730 days (2 years)
IncludeDOBInCVI	:= True;                //Include DOB in CVI Calculation: True
//IncludeDriverLicenseInCVI := FALSE;     //Include DL Verification in CVI Calculation: False
//in_runDLverification=false;           //Include DL Verification: False
//in_include_ofac = FALSE;              //OFAC and/or Additional Watchlists: Off/False
//Include_Additional_watchlists := FALSE; //?
//IncludeAllRC := false;                //Include All Risk Indicators: False
//IncludeCLoverride := false;           //Include CL Override: False
//IncludeMSoverride := false;           //Include MS Override: False
//IncludeMIoverride := false;           //Include MI Override: False
//IsPOBoxCompliant := false;            //PO Box Compliance: False
//RedFlag_version := 0;                 //Red Flags: Off
BSversionin := if(tribcode = 'np31', 41, 1);
DisallowInsurancePhoneHeaderGateway := FALSE;

unsigned3 LastSeenThreshold := if(tribcode = 'np31', LastSeenThresholdIn, risk_indicators.iid_constants.oneyear);	// ID2 uses this and now ciid v1 does
boolean doInquiries := ~DisableInquiriesInCVI AND dataRestriction[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue AND tribcode = 'np31';
unsigned8 BSOptionsin := if(doInquiries, risk_indicators.iid_constants.BSOptions.IncludeInquiries, 0) +
						 if(~DisallowInsurancePhoneHeaderGateway and tribcode = 'np31', risk_indicators.iid_constants.BSOptions.IncludeInsNAP, 0) +
						 if(tribcode = 'np31', risk_indicators.iid_constants.BSOptions.IsInstantIDv1, 0);


iid := risk_indicators.InstantID_Function(prep,
	gateways,
	dppa,
	glb,
	in_isUtility         := false,       // isUtility
	in_ln_branded        := false,       // ln_branded
	in_ofac_only         := true,        // ofac_only
	in_suppressNearDups  := true,        // suppressNearDups
	in_require2Ele       := false,       // require2Ele
	in_from_BIID         := false,       // from_BIID
	in_isFCRA            := false,       // isFCRA
	in_ExcludeWatchLists := ~OFAC,       // excludeWatchLists
	in_from_IT1O         := false,       // from_IT1O
	in_ofac_version      := ofac_version,       // ofac_version
	in_include_ofac      := include_ofac,       // include_ofac
	in_include_additional_watchlists := false,  // include_additional_watchlists
	in_global_watchlist_threshold    := watchlist_threshold,  // global_watchlist_threshold,
	in_BSversion         := BSversionin,        // BSVersion
	in_BSOptions         := BSOptionsin,        // BSOptions
	in_DataRestriction   := DataRestriction,
	in_DataPermission    := DataPermission
);



risk_indicators.layout_output filterAttus( iid le ) := transform
	isGatewayValid := (tribcode in ['np80','np81','np82'] AND (gateways(servicename='attus'))[1].url != '') or
                       tribcode in ['np90','np91','np92'];  // these 3 don't need the gateway present, we search internally now

	self.watchlist_table := if(isGatewayValid, if(tribcode in ['np90','np91','np92'] and le.watchlist_table<>'', 'OFC', le.Watchlist_table), 'XXX' );
	self.watchlist_fname := if(isGatewayValid, le.Watchlist_fname, '');
	self.watchlist_lname := if(isGatewayValid, le.Watchlist_lname, '');
	self.watchlist_address := if(isGatewayValid, le.Watchlist_address, '' );
	self.watchlist_city:= if(isGatewayValid, le.Watchlist_city, '');
	self.watchlist_state := if( isGatewayValid, le.Watchlist_state, '');
	self.watchlist_zip := if(isGatewayValid, le.Watchlist_zip, '');
	self.watchlist_entity_name := if(isGatewayValid, le.Watchlist_Entity_Name, '');
	self.watchlist_record_number := if(isGatewayValid, le.watchlist_record_number , '');
	self.watchlist_program := if(isGatewayValid, le.watchlist_program , '');
	self := le;
end;

ret := if(tribcode in ['np80','np81','np82','np90','np91','np92'], project( iid, filterAttus( LEFT ) ), iid);

// intermediate results
working_layout := RECORD
	Layout_NP2O;
	dataset(Risk_Indicators.Layout_Desc) ri;
	dataset(Risk_Indicators.Layout_Desc) fua;
	unsigned4 seq;
	string verlast := '';
	string veraddr := '';
	Layout_for_Royalties;
END;


working_layout format_out(ret le, indata ri) := TRANSFORM
	doOutput := tribcode <> 'np31';

	self.seq := ri.seq;
	self.acctno := ri.acctno;
	self.account := ri.account;
	self.riskwiseid := (string)le.did;
	
	self.socsverlevel := if(doOutput, (string)le.socsverlevel, '');
	self.phoneverlevel := if(doOutput, (string)le.phoneverlevel, '');
	self.correctdob := if(doOutput, le.correctdob, '');
	self.correcthphone := if(doOutput, if(length(trim(le.correcthphone)) = 10, le.correcthphone, ''), '');
	self.correctsocs := if(doOutput, le.correctssn, '');
	self.correctaddr := if(doOutput, le.correctaddr, '');
	self.altareacode := if(doOutput, if(le.areacodesplitflag = 'Y', le.altareacode, ''), '');
	self.splitdate := if(doOutput, if(le.areacodesplitflag = 'Y', le.areacodesplitdate, ''), '');
	self.dirsfirst := if(doOutput, le.dirsfirst, '');
	self.dirslast := if(doOutput, le.dirslast, '');
	self.dirsaddr := if(doOutput, Risk_Indicators.MOD_AddressClean.street_address('',le.dirs_prim_range, le.dirs_predir, le.dirs_prim_name, le.dirs_suffix, le.dirs_postdir, le.dirs_unit_desig, le.dirs_sec_range), '');
	self.dirscity := if(doOutput, le.dirscity, '');
	self.dirsstate := if(doOutput, le.dirsstate, '');
	self.dirszip := if(doOutput, le.dirszip, '');
	self.nameaddrphone := if(doOutput, le.name_addr_phone, '');
	self.socllowissue := if(doOutput, le.socllowissue, '');
	self.soclhighissue := if(doOutput, le.soclhighissue, '');
	self.soclstate := if(doOutput, le.soclstate, '');	
	self.eqfsfirst := if(doOutput, le.verfirst, '');
	self.eqfslast := if(doOutput, le.verlast, '');
	self.eqfsaddr := if(doOutput, Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range, le.chronopredir, le.chronoprim_name, le.chronosuffix, le.chronopostdir, le.chronounit_desig, le.chronosec_range), '');
	self.eqfscity := if(doOutput, le.chronocity, '');
	self.eqfsstate := if(doOutput, le.chronostate, '');
	self.eqfszip := if(doOutput, le.chronozip, '');
	self.eqfsphone := if(doOutput, le.chronophone, '');
	self.eqfsaddr2 := if(doOutput, Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range2, le.chronopredir2, le.chronoprim_name2, le.chronosuffix2, le.chronopostdir2, le.chronounit_desig2, le.chronosec_range2), '');
	self.eqfscity2 := if(doOutput, le.chronocity2, '');
	self.eqfsstate2 := if(doOutput, le.chronostate2, '');
	self.eqfszip2 := if(doOutput, le.chronozip2, '');
	self.eqfsphone2 := if(doOutput, le.chronophone2, '');
	self.eqfsaddr3 := if(doOutput, Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range3, le.chronopredir3, le.chronoprim_name3, le.chronosuffix3, le.chronopostdir3, le.chronounit_desig3, le.chronosec_range3), '');
	self.eqfscity3 := if(doOutput, le.chronocity3, '');
	self.eqfsstate3 := if(doOutput, le.chronostate3, '');
	self.eqfszip3 := if(doOutput, le.chronozip3, '');
	self.eqfsphone3 := if(doOutput, le.chronophone3, '');	
	self.altlast := if(doOutput, if(le.socsverlevel IN [4,7,9,10,11,12], le.altlast, ''), '');						
	self.altlast2 := if(doOutput, if(le.socsverlevel IN [4,7,9,10,11,12], le.altlast2, ''), '');
	self.altlast3 := if(doOutput, le.correctlast, '');								
	self.hriskalerttable := if(doOutput,if(OFAC and le.watchlist_table <> '', if(tribcode in ['np80','np81','np82'], le.watchlist_table, 'OFC'), ''), '');
	self.hriskalertnum := if(doOutput, if(OFAC and le.watchlist_table <> '' , if(tribcode in ['np80','np81','np82'], le.Watchlist_Record_Number, 
																																																if(le.watchlist_record_number[1..3]='OSC', le.watchlist_record_number[4..10], 
																																																																					 le.watchlist_record_number[5..10])), ''), '');
	self.alertfirst := if(doOutput, if(OFAC, le.Watchlist_fname, ''), '');
	self.alertlast := if(doOutput, if(OFAC, le.Watchlist_lname, ''), '');
	self.alertaddr := if(doOutput, if(OFAC, le.Watchlist_address, ''), '');
	self.alertcity := if(doOutput, if(OFAC, le.Watchlist_city, ''), '');
	self.alertstate := if(doOutput, if(OFAC, le.Watchlist_state, ''), '');
	self.alertzip := if(doOutput, if(OFAC, le.Watchlist_zip, ''), '');
	self.alertentity := if(doOutput, if(OFAC, le.Watchlist_Entity_Name, ''), '');
	self.verlast := if(le.socsverlevel in [2,5,7,8,9,11,12] OR le.phoneverlevel in [2,5,7,8,9,11,12], le.combo_last, '');
	self.veraddr := if(le.socsverlevel in [3,5,6,8,10,11,12] OR le.phoneverlevel in [3,5,6,8,10,11,12], Risk_Indicators.MOD_AddressClean.street_address('',le.combo_prim_range,le.combo_predir,le.combo_prim_name,
																										   le.combo_suffix,le.combo_postdir,le.combo_unit_desig,
																										   le.combo_sec_range),
				    '');
	self.score := map(tribCode in ['np31'] => if((le.socsverlevel=7 and le.phoneverlevel=7) OR (le.socsverlevel=9 and le.phoneverlevel=9), '20',
											  Risk_Indicators.cviScoreV1(le.phoneverlevel,le.socsverlevel,le,self.correctsocs,self.correctaddr,self.correcthphone,'',self.veraddr,self.verlast,OFAC, IncludeDOBInCVI)),
                      tribCode in ['np60'] => Risk_Indicators.cviScore(le.phoneverlevel,le.socsverlevel,le,self.correctsocs,self.correctaddr,self.correcthphone,'ecvi',self.veraddr,self.verlast,OFAC),
                      tribCode in ['np50','np80','np90'] => Risk_Indicators.cviScore(le.phoneverlevel,le.socsverlevel,le,self.correctsocs,self.correctaddr,self.correcthphone,'svi',self.veraddr,self.verlast,OFAC),
                      tribCode in ['np82', 'np92'] => Risk_Indicators.cviScore(le.phoneverlevel,le.socsverlevel,le,self.correctsocs,self.correctaddr,self.correcthphone,'ddvi',self.veraddr,self.verlast,false),
                      Risk_Indicators.cviScore(le.phoneverlevel,le.socsverlevel,le,self.correctsocs,self.correctaddr,self.correcthphone,'',self.veraddr,self.verlast,OFAC));
	self.ri := if(doOutput, RiskWise.patriotReasonCodes(le, 6, OFAC), dataset([],Risk_Indicators.Layout_Desc)); 
	self.reason1 := self.ri[1].hri;
	self.reason2 := self.ri[2].hri;
	self.reason3 := self.ri[3].hri;
	self.reason4 := self.ri[4].hri;
	self.reason5 := self.ri[5].hri;
	self.reason6 := self.ri[6].hri;
	
	FUA_A := OFAC; // include OFAC follow-up action for these three products
	FUA_E := false; // never include non-OFAC FUAs for any NP2O products
	self.fua := if(doOutput, Risk_Indicators.getActionCodes(le, 4, le.socsverlevel, le.phoneverlevel, FUA_A, FUA_E, actioncode_settings ), dataset([],Risk_Indicators.Layout_Desc));
	self.action1 := self.fua[1].hri;
	self.action2 := self.fua[2].hri;
	self.action3 := self.fua[3].hri;
	self.action4 := self.fua[4].hri;
	self.TargusType := le.TargusType;
	self.src := le.src;
	self.TargusGatewayUsed := le.TargusGatewayUsed;		
	self := [];
END;
mapped_results := join(ret, indata, left.seq = right.seq, format_out(left, right), left outer);


// get boca shell results for the models
clam := if(tribCode in ['np25','np27','np31'], Risk_Indicators.Boca_Shell_Function(ret, gateways,dppa, glb, isUtility := false, isLN := false,
                                               includeRelativeInfo := true, includeDLInfo := false, includeVehInfo := false, includeDerogInfo := true,
											   BSOptions := BSOptionsin, BSversion := BSversionin, DataRestriction := DataRestriction,
											   DataPermission := DataPermission),
		 group(dataset([],Risk_Indicators.Layout_Boca_Shell),seq));	

getScore2 := map(tribCode in ['np25'] => Models.AIN605_1_0(clam, OFAC),
			     tribCode in ['np27'] => Models.FD9603_2_0(clam, OFAC),
			     tribCode in ['np31'] => Models.FP1403_1_0(clam, mapped_results, 6),
				  dataset([],Models.Layout_ModelOut));

Layout_NP2O_4_royalties := RECORD
	Layout_NP2O;
	Layout_for_Royalties;
END;

Layout_NP2O_4_royalties addModel(mapped_results le, getScore2 ri) := TRANSFORM
	self.score := if(tribCode = 'np31', ri.score, le.score);
	self.score2 := if(le.score2 <> '000' and tribCode in ['np25','np27'], ri.score, le.score2);
	self.reason1 := le.reason1;	
	self.reason2 := le.reason2;	
	self.reason3 := le.reason3;	
	self.reason4 := le.reason4;	
	self := le;
END;
withModel := join(mapped_results, getScore2, left.seq=right.seq, addModel(left,right), left outer);	

RETURN withModel;

END;