import ut, address, Risk_Indicators, Models, RiskWise, gateway;

export NP2O_Function_FCRA(dataset(RiskWise.Layout_PRII) indata, dataset(Gateway.Layouts.Config) gateways, unsigned1 glb, unsigned1 dppa, 
string4 tribCode,string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
string50 DataPermission=risk_indicators.iid_constants.default_DataPermission,
boolean UsePersonContext) := 

FUNCTION


Risk_Indicators.Layout_Input into(indata le) := TRANSFORM
	clean_a := Risk_Indicators.MOD_AddressClean.clean_addr(le.addr, le.city, le.state, le.zip);

	ssn_val := RiskWise.cleanSSN( le.socs );
	hphone_val := RiskWise.cleanPhone( le.hphone );
	wphone_val := RiskWise.cleanPhone( le.wphone );
	dob_val := riskwise.cleanDOB( le.dob );
	dl_num_clean := RiskWise.cleanDL_num( le.drlc );

	self.historydate := le.historydate;
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
	
	self := [];
END;
prep := PROJECT(indata,into(LEFT));

// Use Boca Shell version 2 for ex49 and np33

IN_BSversion := map(tribCode in ['ex49'] => 41,
										tribCode in ['np33']=> 2, 
										1);
clam := Risk_Indicators.Boca_Shell_Function_FCRA(/* DATASET (Layout_input) */ prep, 
																									/* DATASET (Layout_Gateways_In) */ gateways,
																									/* unsigned1 */ dppa,
																									/* unsigned1 */ glb,
																									/* boolean isUtility = */ false,
																									/* boolean isLN = */ false,
																									/* boolean require2Ele = */ false,
																									/* boolean includeRelativeInfo = */ false,
																									/* boolean includeDLInfo = */ false,
																									/* boolean includeVehInfo = */ false,
																									/* boolean includeDerogInfo = */ true,
																									/* IN_OFAC_Only = */ TRUE,
																									/* IN_SuppressNearDups = */ FALSE,
																									/* IN_From_BIID = */ FALSE,
																									/* IN_ExcludeWatchLists = */ FALSE,
																									/* IN_From_IT1O = */ FALSE,
						   						   						   				/* IN_OFAC_Version = */ 1,
						   						   						   				/* IN_Include_OFAC = */ FALSE,
						   						   						   				/* IN_Include_additional_watchlists = */ FALSE,
						   						   						   				/* IN_Global_watchlist_threshold = */ 0.84,
						   						   						   				/* IN_BSversion = */ IN_BSversion,
						   						   						   				/* IN_IsPreScreen = */ false,
							 							 							 				/* IN_doScore = */ false, 
																									/* boolean nugen = */ false,
							 							 							 				/* ADL_Based_Shell = */ false,
																									DataRestriction,
																									/* IN_AppendBest = */ 0,
																									/* BSOptions = */ 0,
																									DataPermission);



// intermediate results
working_layout := RECORD
	RiskWise.Layout_NP2O;
	unsigned4 seq;
	boolean inCalif := false;
END;



working_layout format_out(clam le, indata ri) := TRANSFORM
	self.inCalif := Stringlib.stringtouppercase(ri.state) = 'CA' and ((integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount+
								  (integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount+
								  (integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;
	self.seq := ri.seq;
	self.acctno := ri.acctno;
	self.account := ri.account;
	self.riskwiseid := (string)le.did;
	
	self.score2 := if(tribcode in ['np12','ex29','np32','np52'] and self.inCalif, '000', '');	
	
	hit_ofac := Risk_Indicators.rcSet.isCode32(le.iid.watchlist_table, le.iid.watchlist_record_number);
	score_tmp := if(tribCode in ['np32','np33'], if((le.iid.nas_summary=7 and le.iid.nap_summary=7) OR (le.iid.nas_summary=9 and le.iid.nap_summary=9), '20', (string)le.iid.cvi), '');

	self.score := if(tribcode in ['np32','np33'], if(hit_ofac, '10', score_tmp), score_tmp);
	
	// Per Bug 58288 - EQ99 logging in no longer necessary, removing.
	self.billing := dataset([],risk_indicators.Layout_Billing);
	
	self := [];
END;
mapped_results := JOIN(clam, indata, left.seq=right.seq, format_out(left, right), left outer);

getScore2 := map(tribCode in ['ex49'] => ungroup(Models.RVR1311_1_0(clam, mapped_results[1].inCalif /* inCalif*/ )),
								 tribCode in ['np33'] => ungroup(Models.RVR711_0_0(clam, false /* inCalif */, false /* useRcSetV1 */)),
								 tribCode in ['ex29','np32'] => Models.TBD605_0_0(clam, true, mapped_results[1].inCalif), 
								 tribCode = 'np12' => Models.AWD606_4_0(clam, true, mapped_results[1].inCalif),
								 tribCode = 'np52' => Models.RVB705_1_0(ungroup(clam), true, mapped_results[1].inCalif),
								 dataset([],Models.Layout_ModelOut));


RiskWise.Layout_NP2O addModel(mapped_results le, getScore2 ri) := TRANSFORM
	self.score2 := map((le.score2 <> '100' or ri.score in ['101','102','103','104','105']) and tribCode in ['ex49'] => ri.score,
										 (le.score2 <> '000' or ri.score in ['101','102','103','104','105']) and tribCode in ['np12','ex29','np32','np52','np33'] => ri.score,
											le.score2);
							

	self.reason1 := if(Risk_Indicators.rcSet.isCode36(ri.ri[1].hri), '36', ri.ri[1].hri);	
	self.reason2 := ri.ri[2].hri;	
	self.reason3 := ri.ri[3].hri;	
	self.reason4 := ri.ri[4].hri;	
	self := le;
END;
withModel := join(mapped_results, getScore2, left.seq=right.seq, addModel(left,right), left outer);	

RETURN withModel;

END;