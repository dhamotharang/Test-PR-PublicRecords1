import risk_indicators, ut, address, codes, daybatchPCNSR, Models, easi, gateway;

export IT1O_Function(DATASET(Layout_IT1I) inf, dataset(Gateway.Layouts.Config) gateways, unsigned dppa_purpose, unsigned1 glb_purpose, 
						boolean isUtility=false, boolean ln_branded=false, 
						string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction, string32 appType,
						string50 DataPermission=risk_indicators.iid_constants.default_DataPermission) := function
						
tribcode := inf[1].tribcode;

risk_indicators.Layout_input into(inf le) := TRANSFORM	
	self.seq := le.seq;
	self.historydate := le.historydate;
	self.ssn := cleanSSN( le.socs );
	self.dob := cleanDOB( le.dob );
	self.age := if (le.dob!='',(STRING3)ut.GetAgeI((integer)le.dob), '');
	self.phone10 := cleanPhone( le.hphone );
	self.wphone10 := cleanPhone( le.wphone );
	
	self.fname := stringlib.stringtouppercase(le.first);
	self.mname := '';
	self.lname := stringlib.stringtouppercase(le.last);
	self.suffix := '';
	SELF.in_streetAddress := stringlib.stringtouppercase(le.addr);
	self.in_city := stringlib.stringtouppercase(le.city);
	self.in_state := stringlib.stringtouppercase(le.state);
	self.in_zipcode := le.zip;	
	SELF.in_country := '';
	
	clean_a := risk_indicators.MOD_AddressClean.clean_addr(le.addr, le.city, le.State, le.Zip) ;	
	
	self.prim_range := clean_a[1..10];
	self.predir := clean_a[11..12];
	self.prim_name := clean_a[13..40];
	self.addr_suffix := clean_a[41..44];
	self.postdir := clean_a[45..46];
	self.unit_desig := clean_a[47..56];
	self.sec_range := clean_a[57..64];
	self.p_city_name := clean_a[90..114];
	self.st := clean_a[115..116];
	self.z5 := clean_a[117..121];	
	self.zip4 := clean_a[122..125];
	self.lat := clean_a[146..155];
	self.long := clean_a[156..166];
	self.addr_type := clean_a[139];
	self.addr_status := clean_a[179..182];
	self.county := clean_a[143..145];
	self.geo_blk := clean_a[171..177];
	self.country := '';
	SELF.dl_number := cleanDL_num( le.drlc );
	SELF.dl_state := stringlib.stringtouppercase(le.drlcstate);
	SELF.email_address := '';
	SELF.ip_address := '';
	SELF.employer_name := '';
	SELF.lname_prev := '';
	self := [];
END;

prep := PROJECT(inf,into(LEFT));

skiptrace_call := riskwise.skip_trace(prep, DPPA_Purpose, glb_Purpose,datarestriction,appType, DataPermission);

skiptrace_set := ['it51'];//,'it70'];
skipprep := project(ungroup(skiptrace_call), transform(risk_indicators.Layout_Input, self:=left));

// actual skip trace results
skiptrace1 := project(skiptrace_call, transform(riskwise.Layout_SkipTrace,
										self.seq := if(tribcode='it70', left.seq*2+1, left.seq*2),
										self := left));
// hang onto bankruptcy and deceased info from skiptrace, but best data replaced back to original input data
skiptrace2 := join(prep, skiptrace_call, left.seq=right.seq, transform(riskwise.Layout_SkipTrace,
			self.seq := if(tribcode='it70', left.seq*2, skip),
			SELF.in_streetAddress := left.in_streetAddress,
			SELF.in_city := left.in_city,
			SELF.in_state := left.in_state,
			SELF.in_zipCode := left.in_zipcode,
			self.prim_range := left.prim_range,
			self.predir := left.predir,
			self.prim_name := left.prim_name,
			self.addr_suffix := left.addr_suffix,
			self.postdir := left.postdir,
			self.unit_desig := left.unit_desig,
			self.sec_range := left.sec_range,
			self.p_city_name := left.p_city_name,
			self.st := left.st,
			self.z5 := left.z5,
			self.zip4 := left.zip4,
			self.lat := left.lat,
			self.long := left.long,
			self.addr_type := left.addr_type,
			self.addr_status := left.addr_status,
			self.county := left.county,
			self.geo_blk := left.geo_blk,
			self.phone10 := left.phone10,
			self := right));
			
skiptrace := skiptrace1 + skiptrace2;


iid_prep := if(tribcode in skiptrace_set, skipprep, prep);
it70iid_prep := if( tribcode='it70',skipprep, dataset([], Risk_Indicators.Layout_Input) ); // prepare skiptrace info for it70's RecoverScore




boolean ofac_only := true;
boolean suppressNearDups := true;
boolean require2Ele := false;
boolean fromBIID := false;
boolean isFCRA := false;
boolean excludeWatchlists := false;
boolean from_IT1O := true;

bsVersion := if( tribcode in ['it37','it61'], 2, 1 );


// boolean includeRelativeInfo := true;
// boolean includeDLInfo := true;
// boolean includeVehInfo := true;
// boolean includeDerogInfo := true;


// convert sequence numbers. even numbers for regular iid, odd for it70 data
iideven := project( iid_prep,     transform( risk_indicators.layout_input, self.seq := left.seq*2,   self := left ) );
iidodd  := project( it70iid_prep, transform( risk_indicators.layout_input, self.seq := left.seq*2+1, self := left ) );

iid_prep_all := iideven + iidodd;



iid_results := Risk_Indicators.InstantID_Function(iid_prep_all, gateways, DPPA_Purpose, GLB_Purpose, isUtility, ln_branded, 
										ofac_only, suppressNearDups,require2ele, fromBIID, isFCRA, excludeWatchLists, from_IT1O, in_BSversion:=bsVersion,
										in_DataRestriction := DataRestriction, in_DataPermission := DataPermission);



riskwise.Layout_SkipTrace get_confidence(skiptrace le, iid_results rt) := transform
	self.addr_confidence_a := map(le.addr_type_a='X' => '',
							le.addr_type_a in ['U','C'] and rt.chronophone<>'' and
								risk_indicators.ga(Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range, 
													    rt.chronoprim_range, rt.chronoprim_name, rt.chronosec_range)) => 'A',
								
							le.addr_type_a in ['U','C'] and rt.chronophone='' and
								risk_indicators.ga(Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range, 
													    rt.chronoprim_range, rt.chronoprim_name, rt.chronosec_range)) => 'B',
								
							risk_indicators.ga(Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range, 
													    rt.chronoprim_range2, rt.chronoprim_name2, rt.chronosec_range2)) => 'B',
							
							risk_indicators.ga(Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range,
													    rt.chronoprim_range3, rt.chronoprim_name3, rt.chronosec_range3)) => 'C',
							'');							
	self := le;		
end;


full_skip_trace := join(skiptrace, iid_results, LEFT.seq= RIGHT.seq, get_confidence(left,right) );


// fill in as much as possible from iid_function results	
dwelltype(STRING1 at) := MAP(at='F' => '', at='G' => 'S', at='H' => 'A', at='P' => 'E', at='R' => 'R', at='S' => '', '');					  		
invalidSet := ['E101','E212','E213','E214','E216','E302','E412','E413','E420','E421','E423','E500','E501','E502','E503','E600'];
ambiguousSet := ['E422','E425','E427','E428','E429','E430','E431','E504'];	
addrvalflag(STRING4 stat) := MAP(stat IN invalidSet => 'N', stat IN ambiguousSet => 'M', stat = '' => '', 'V');	   

xlayout := record
	risk_indicators.Layout_Output iid;
	riskwise.Layout_SkipTrace skiptrace;
     string2 in_drlcstate := '';
     string2 in_debttype := '';
     string8 in_chargeoffdate := '';
     string8 in_opendate := '';
     string8 in_lastpymt := '';
     string6 in_chargeoffamt := '';
     string6 in_balance := '';
	STRING6 refresh_date :='';  // for demographic data rollup
	RiskWise.Layout_IT1O;
	string3 median_hh_size := '';
end;

xlayout map_iid_results(inf le, iid_results rt) := transform
	self.seq := le.seq;
	self.iid := rt;
	self.account := le.account;
	self.acctno := le.acctno;
	self.in_debttype := le.debttype;
	self.in_chargeoffdate := le.chargeoffdate;
	self.in_opendate := le.opendate;
	self.in_lastpymt := le.lastpymt;
	self.in_chargeoffamt := le.chargeoffamt;
	self.in_balance := le.balance;
	self.correctsocs := rt.correctssn;

	ia1 := rt.in_streetAddress;					
	clean_input_addr := Risk_Indicators.MOD_AddressClean.clean_addr(ia1, rt.in_city, rt.in_state, rt.in_zipcode);


	a1 := Risk_Indicators.MOD_AddressClean.street_address('',rt.chronoprim_range,rt.chronopredir,rt.chronoprim_name,rt.chronosuffix,rt.chronopostdir, rt.chronounit_desig, rt.chronosec_range);
  clean_addr := Risk_Indicators.MOD_AddressClean.clean_addr(a1, rt.chronocity, rt.chronostate, rt.chronozip);

	in_av := addrvalflag(clean_input_addr[179..182]);
	self.inputaddrcharflag := map(rt.in_streetAddress = '' => '0',
						in_av in ['N', 'M'] => '1',  // this is different than address history records, where invalid or ambiguous = 'U'
						dwelltype(clean_input_addr[139]));
	self.first := rt.chronofirst;
	self.last := rt.chronolast;
	// return the cleaned input address in the case we don't get a hit in chronology
	self.addr := if(a1='', Risk_Indicators.MOD_AddressClean.street_address('',clean_input_addr[1..10],clean_input_addr[11..12],clean_input_addr[13..40],clean_input_addr[41..44],
											clean_input_addr[45..46],clean_input_addr[47..56],clean_input_addr[57..64]),
					   Risk_Indicators.MOD_AddressClean.street_address('',clean_addr[1..10],clean_addr[11..12],clean_addr[13..40],clean_addr[41..44],
											clean_addr[45..46],clean_addr[47..56],clean_addr[57..64]));
	self.city := if(a1='',clean_input_addr[90..114],clean_addr[90..114]);
	self.state := if(a1='',clean_input_addr[115..116],clean_addr[115..116]);
	self.zip := trim(if(a1='',clean_input_addr[117..125],clean_addr[117..125]));
	self.addrstatusflag := map(a1='' => '0', // other address not found
						 risk_indicators.ga(risk_indicators.addrscore.AddressScore(clean_input_addr[1..10], clean_input_addr[13..40], clean_input_addr[57..64], 
						 clean_addr[1..10], clean_addr[13..40], clean_addr[57..64])) => '1',  // same as input address
						'2'); // different address than input
						
	av := addrvalflag(if(a1='', clean_input_addr[179..182], clean_addr[179..182]));
	self.addrcharflag := map(ia1='' and a1 = '' => '0',
							   av in ['N', 'M'] => 'U',
							   dwelltype(if(a1='', clean_input_addr[139], clean_addr[139])));
						
													
	self.first2 := rt.chronofirst2;
	self.last2 := rt.chronolast2;
	// even though the chronology addresses are already parsed, they don't include the addr_type and addr_status, so they need to be cleaned again to get those pieces
	a1_2 :=  Risk_Indicators.MOD_AddressClean.street_address('',rt.chronoprim_range2,rt.chronopredir2,rt.chronoprim_name2,rt.chronosuffix2,rt.chronopostdir2, rt.chronounit_desig2, rt.chronosec_range2);
	clean_addr2 := Risk_Indicators.MOD_AddressClean.clean_addr(a1_2, rt.chronocity2, rt.chronostate2, rt.chronozip2);
	
	
	self.addr2 := Risk_Indicators.MOD_AddressClean.street_address('',clean_addr2[1..10],clean_addr2[11..12],clean_addr2[13..40],clean_addr2[41..44],
													clean_addr2[45..46],clean_addr2[47..56],clean_addr2[57..64]);
	self.city2 := clean_addr2[90..114];
	self.state2 := clean_addr2[115..116];
	self.zip2 := trim(clean_addr2[117..125]);
	self.addrstatusflag2 := map(a1_2= '' => '0', // other address not found
						risk_indicators.ga(risk_indicators.addrscore.AddressScore(clean_input_addr[1..10], clean_input_addr[13..40], clean_input_addr[57..64],
										clean_addr2[1..10], clean_addr2[13..40], clean_addr2[57..64])) => '1',  // same as input address
						'2'); // different address than input
						
	av2 := addrvalflag(clean_addr2[179..182]);
	self.addrcharflag2 := map(a1_2 = '' => '0',
						av2 in ['N', 'M'] => 'U',
						dwelltype(clean_addr2[139]));									
	
	self.first3 := rt.chronofirst3;
	self.last3 := rt.chronolast3;
	// even though the chronology addresses are already parsed, they don't include the addr_type and addr_status, so they need to be cleaned again to get those pieces
	a1_3 := Risk_Indicators.MOD_AddressClean.street_address('',rt.chronoprim_range3,rt.chronopredir3,rt.chronoprim_name3,rt.chronosuffix3,rt.chronopostdir3, rt.chronounit_desig3, rt.chronosec_range3);
	clean_addr3 := Risk_Indicators.MOD_AddressClean.clean_addr(a1_3, rt.chronocity3, rt.chronostate3, rt.chronozip3);
	
	self.addr3 := Risk_Indicators.MOD_AddressClean.street_address('',clean_addr3[1..10],clean_addr3[11..12],clean_addr3[13..40],clean_addr3[41..44],
													clean_addr3[45..46],clean_addr3[47..56],clean_addr3[57..64]);
	self.city3 := clean_addr3[90..114];
	self.state3 := clean_addr3[115..116];
	self.zip3 := trim(clean_addr3[117..125]);
	self.addrstatusflag3 := map(a1_3= '' => '0', // other address not found
						risk_indicators.ga(risk_indicators.addrscore.AddressScore(clean_input_addr[1..10], clean_input_addr[13..40], clean_input_addr[57..64], 
										clean_addr3[1..10], clean_addr3[13..40], clean_addr3[57..64])) => '1',  // same as input address
						'2'); // different address than input
					
	av3 := addrvalflag(clean_addr3[179..182]);
	self.addrcharflag3 := map(a1_3 = '' => '0',
						av3 in ['N', 'M'] => 'U',
						dwelltype(clean_addr3[139]));	
						
	self.phone := rt.chronophone;
	self.phonestatusflag := if(rt.chronoaddrscore=0, '', (string)rt.chronoaddrscore); 
								
	self.phone2 := rt.chronophone2;
	self.phonestatusflag2 := if(rt.chronoaddrscore2=0, '', (string)rt.chronoaddrscore2); 	
							
	self.phone3 := rt.chronophone3;							
	self.phonestatusflag3 := if(rt.chronoaddrscore3=0, '', (string)rt.chronoaddrscore3); 
	
	// get area code split data for all 3 chrono phones
	acs := riskwise.getAreaCodeSplit(rt.chronophone);
	self.altareacode := if(acs[1].areacodesplitflag12blank='1', acs[1].altareacode, '');
	self.splitdate := if(acs[1].areacodesplitflag12blank='1', acs[1].areacodesplitdate, '');
	
	acs2 := riskwise.getAreaCodeSplit(rt.chronophone2);
	self.altareacode2 := if(acs2[1].areacodesplitflag12blank='1', acs2[1].altareacode, '');
	self.splitdate2 := if(acs2[1].areacodesplitflag12blank='1', acs2[1].areacodesplitdate, '');
		
	acs3 := riskwise.getAreaCodeSplit(rt.chronophone3);
	self.altareacode3 := if(acs3[1].areacodesplitflag12blank='1', acs3[1].altareacode, '');
	self.splitdate3 := if(acs3[1].areacodesplitflag12blank='1', acs3[1].areacodesplitdate, '');
	
	self.inputsocscharflag := rt.inputsocscharflag;
	
	self := [];
end;			
// end of address history

wIID  := join(inf, iid_results, (LEFT.seq*2) = RIGHT.seq, map_iid_results(left, right));


// search demographic data
	xlayout get_household(xlayout le, daybatchPCNSR.Key_PCNSR_DID rt) := transform
		self.hownstatusflag := map(rt.own_rent='9' => '4',
							  rt.own_rent in ['7','8'] => '3',
							  rt.own_rent in ['1','2','3','4','5','6'] => '2',
							  '0');
		self.estincome := (string)round(((integer)rt.find_income_in_1000s)/1000);
		self.refresh_date := rt.refresh_date;
		self := le;
	end;

	hous_recs := join(wIID, DayBatchPCNSR.Key_PCNSR_DID, 
					left.iid.did!=0 and keyed(right.did=left.iid.did), 
					get_household(left, right), left outer, ATMOST(keyed(right.did=left.iid.did), RiskWise.max_atmost), keep(50));
	

	xlayout roll_hous(xlayout le, xlayout rt) := transform
		self := if(le.refresh_date > rt.refresh_date, le, rt); 
	end;
	
	groupedHouse   := group(sort(ungroup(hous_recs),seq),seq);
	wHouseHold   := rollup(groupedHouse, true, roll_hous(left, right));
// end demographic


xlayout add_skip_trace(wHouseHold le, full_skip_trace rt) := transform
	self.skiptrace := rt;
	self.bansmatchflag := rt.bansmatchflag;
	self.banscasenum := rt.banscasenum;
	self.bansprcode := rt.bansprcode;
	self.bansdispcode := rt.bansdispcode;
	self.bansdatefiled := rt.bansdatefiled;
	self.bansfirst := rt.bansfirst;
	self.bansmiddle := rt.bansmiddle;
	self.banslast := rt.banslast;
	self.banscnty := rt.banscnty;
	self.bansecoaflag := rt.bansecoaflag;
	self.decsflag := if(rt.decsflag='0', '', rt.decsflag);
	self.decsdob := rt.decsdob;
	self.decszip := rt.decszip;
	self.decszip2 := rt.decszip2;
	self.decslast := rt.decslast;
	self.decsfirst := rt.decsfirst;
	self.decsdod := rt.decsdod;
	self := le;
end;

full_skip_trace_even := full_skip_trace( seq % 2 = 0 );
full_skip_trace_odd  := full_skip_trace( seq % 2 = 1 );
alldata   := join(wHouseHold, full_skip_trace_even, left.seq*2=right.seq,   add_skip_trace(left,right));
alldata70 := join(wHouseHold, full_skip_trace_odd,  left.seq*2+1=right.seq, add_skip_trace(left,right));


// need to clean the input address using the old cleaner for msn605.1 model - temporarily
xlayout getOldCleaner(alldata le) := TRANSFORM	
	
	clean_a := risk_indicators.MOD_AddressClean.clean_addr_paro(le.iid.in_streetAddress, le.iid.in_city, le.iid.in_State, le.iid.in_Zipcode);	
	
	self.iid.st := clean_a[115..116];
	self.iid.county := clean_a[143..145];
	self.iid.geo_blk := clean_a[171..177];

	self := le;
END;
easi_prep_paro := PROJECT(alldata, getOldCleaner(LEFT));



// use the 2000 census result temporarily for the msn605.1 score because the new census caused score decreases
easi_census_msn605 := join(easi_prep_paro, Easi.Key_Easi_Census_2000,
						keyed(right.geolink=left.iid.st+left.iid.county+left.iid.geo_blk) and tribcode in ['it60','it61','it70'],
						transform(easi.layout_census, 
									self.state:= left.iid.st,
									self.county:=left.iid.county,
									self.tract:=left.iid.geo_blk[1..6],
									self.blkgrp:=left.iid.geo_blk[7],
									self.geo_blk:=left.iid.geo_blk,
									self := right));	

// keep the 2010 easi census for all other models besides msn605.1									
easi_census := join(alldata, Easi.Key_Easi_Census,
						keyed(right.geolink=left.iid.st+left.iid.county+left.iid.geo_blk) and tribcode in ['it37','it60','it61','it70'],
						transform(easi.layout_census, 
									self.state:= left.iid.st,
									self.county:=left.iid.county,
									self.tract:=left.iid.geo_blk[1..6],
									self.blkgrp:=left.iid.geo_blk[7],
									self.geo_blk:=left.iid.geo_blk,
									self := right));

									

xlayout addEASI(alldata le, easi_census rt) := transform
	self.estincome := if(le.estincome='0' and rt.med_hhinc!='', (string)round(((integer)rt.med_hhinc)/1000), le.estincome);
	self.median_hh_size := rt.hhsize;
	self := le;
end;

withEASI := join(alldata, easi_Census,
						right.geolink=left.iid.st+left.iid.county+left.iid.geo_blk and tribcode in ['it37', 'it60','it61','it70'],
						addEASI(left,right),left outer,lookup);						

xlayout sortPhones(withEASI le) := transform
	p1 := map((le.phone='' and le.phone2='' and le.phone3='') or le.phone<>'' => 1, // leave the order the same
			 le.phone='' and le.phone2<>'' => 2, // put phone2 into the place of phone1
			 le.phone='' and le.phone2='' and le.phone3<>'' => 3, // put phone3 into phone1 if phone1 and phone2 are empty
			 1);  // default to keeping the same order
	p2 := map((le.phone='' and le.phone2='' and le.phone3='') or (le.phone<>'' and le.phone2<>'')=> 2, // leave the order the same
		      le.phone='' and le.phone2<>'' and le.phone3<>'' => 3, // put phone3 into the place of phone2 because phone2 has been bumped to phone1
			 le.phone='' and le.phone2='' and le.phone3<>'' => 1, // put phone1 into phone2 if phone1 and phone2 are empty
			 le.phone='' and le.phone2<>'' and le.phone3='' => 1, // put phone1 into phone2 if phone1 and phone3 are empty
			 le.phone2='' and le.phone3<>'' => 3,  // put phone3 into the place of phone2
			 2);  // default to keeping the same order	
	p3 := map(p1=1 and p2=2 => 3,
			p1=1 and p2=3 => 2,
			p1=2 and p2=3 => 1,
			p1=3 and p2=1 => 2,
			3);
			
	self.phone := map(p1=1 => le.phone,
				   p1=2 => le.phone2,
				   p1=3 => le.phone3,
				   le.phone);	   
	self.phonestatusflag := map(p1=1 => le.phonestatusflag,
				   p1=2 => le.phonestatusflag2,
				   p1=3 => le.phonestatusflag3,
				   le.phonestatusflag);	   
	self.altareacode := map(p1=1 => le.altareacode,
				   p1=2 => le.altareacode2,
				   p1=3 => le.altareacode3,
				   le.altareacode);
	self.splitdate := map(p1=1 => le.splitdate,
				   p1=2 => le.splitdate2,
				   p1=3 => le.splitdate3,
				   le.splitdate);
	self.addrstatusflag := map(p1=1 => le.addrstatusflag,
				   p1=2 => le.addrstatusflag2,
				   p1=3 => le.addrstatusflag3,
				   le.addrstatusflag);
	self.addrcharflag := map(p1=1 => le.addrcharflag,
				   p1=2 => le.addrcharflag2,
				   p1=3 => le.addrcharflag3,
				   le.addrcharflag);
	self.first := map(p1=1 => le.first,
				   p1=2 => le.first2,
				   p1=3 => le.first3,
				   le.first);			   
	self.last := map(p1=1 => le.last,
				   p1=2 => le.last2,
				   p1=3 => le.last3,
				   le.last);
	self.addr := map(p1=1 => le.addr,
				   p1=2 => le.addr2,
				   p1=3 => le.addr3,
				   le.addr);
	self.city := map(p1=1 => le.city,
				   p1=2 => le.city2,
				   p1=3 => le.city3,
				   le.city);			   
	self.state := map(p1=1 => le.state,
				   p1=2 => le.state2,
				   p1=3 => le.state3,
				   le.state);
	self.zip := map(p1=1 => le.zip,
				   p1=2 => le.zip2,
				   p1=3 => le.zip3,
				   le.zip);
	
	self.phone2 := map(p2=1 => le.phone,
				   p2=2 => le.phone2,
				   p2=3 => le.phone3,
				   le.phone2);	   
	self.phonestatusflag2 := map(p2=1 => le.phonestatusflag,
				   p2=2 => le.phonestatusflag2,
				   p2=3 => le.phonestatusflag3,
				   le.phonestatusflag2);	   
	self.altareacode2 := map(p2=1 => le.altareacode,
				   p2=2 => le.altareacode2,
				   p2=3 => le.altareacode3,
				   le.altareacode2);
	self.splitdate2 := map(p2=1 => le.splitdate,
				   p2=2 => le.splitdate2,
				   p2=3 => le.splitdate3,
				   le.splitdate2);
	self.addrstatusflag2 := map(p2=1 => le.addrstatusflag,
				   p2=2 => le.addrstatusflag2,
				   p2=3 => le.addrstatusflag3,
				   le.addrstatusflag2);
	self.addrcharflag2 := map(p2=1 => le.addrcharflag,
				   p2=2 => le.addrcharflag2,
				   p2=3 => le.addrcharflag3,
				   le.addrcharflag2);
	self.first2 := map(p2=1 => le.first,
				   p2=2 => le.first2,
				   p2=3 => le.first3,
				   le.first2);			   
	self.last2 := map(p2=1 => le.last,
				   p2=2 => le.last2,
				   p2=3 => le.last3,
				   le.last2);
	self.addr2 := map(p2=1 => le.addr,
				   p2=2 => le.addr2,
				   p2=3 => le.addr3,
				   le.addr2);
	self.city2 := map(p2=1 => le.city,
				   p2=2 => le.city2,
				   p2=3 => le.city3,
				   le.city2);			   
	self.state2 := map(p2=1 => le.state,
				   p2=2 => le.state2,
				   p2=3 => le.state3,
				   le.state2);
	self.zip2 := map(p2=1 => le.zip,
				   p2=2 => le.zip2,
				   p2=3 => le.zip3,
				   le.zip2);
				   
	self.phone3 := map(p3=1 => le.phone,
				   p3=2 => le.phone2,
				   p3=3 => le.phone3,
				   le.phone3);	   
	self.phonestatusflag3 := map(p3=1 => le.phonestatusflag,
				   p3=2 => le.phonestatusflag2,
				   p3=3 => le.phonestatusflag3,
				   le.phonestatusflag3);	   
	self.altareacode3 := map(p3=1 => le.altareacode,
				   p3=2 => le.altareacode2,
				   p3=3 => le.altareacode3,
				   le.altareacode3);
	self.splitdate3 := map(p3=1 => le.splitdate,
				   p3=2 => le.splitdate2,
				   p3=3 => le.splitdate3,
				   le.splitdate3);
	self.addrstatusflag3 := map(p3=1 => le.addrstatusflag,
				   p3=2 => le.addrstatusflag2,
				   p3=3 => le.addrstatusflag3,
				   le.addrstatusflag3);
	self.addrcharflag3 := map(p3=1 => le.addrcharflag,
				   p3=2 => le.addrcharflag2,
				   p3=3 => le.addrcharflag3,
				   le.addrcharflag3);
	self.first3 := map(p3=1 => le.first,
				   p3=2 => le.first2,
				   p3=3 => le.first3,
				   le.first3);			   
	self.last3 := map(p3=1 => le.last,
				   p3=2 => le.last2,
				   p3=3 => le.last3,
				   le.last3);
	self.addr3 := map(p3=1 => le.addr,
				   p3=2 => le.addr2,
				   p3=3 => le.addr3,
				   le.addr3);
	self.city3 := map(p3=1 => le.city,
				   p3=2 => le.city2,
				   p3=3 => le.city3,
				   le.city3);			   
	self.state3 := map(p3=1 => le.state,
				   p3=2 => le.state2,
				   p3=3 => le.state3,
				   le.state3);
	self.zip3 := map(p3=1 => le.zip,
				   p3=2 => le.zip2,
				   p3=3 => le.zip3,
				   le.zip3);
				   
	self := le;
	
end;

sortedPhones := project(withEASI, sortPhones(left));

riskwise.Layout_IT1O filloutput(sortedPhones le) := transform
	self.seq := le.seq;
	self.acctno := le.acctno;
	self.account := le.account;
	self.riskwiseid := (String)le.iid.did;
	self.bansmatchflag := if(tribcode in ['it37', 'it60', 'it61', 'bkd0', 'wst4', 'it70'], le.bansmatchflag, '');
	self.banscasenum := if(tribcode in ['it37', 'it60', 'it61', 'bkd0', 'wst4', 'it70'], le.banscasenum, '');
	self.bansprcode := if(tribcode in ['it37', 'it60', 'it61', 'bkd0', 'wst4', 'it70'], le.bansprcode, '');
	self.bansdispcode := if(tribcode in ['it37', 'it60', 'it61', 'bkd0', 'wst4', 'it70'], le.bansdispcode, '');
	self.bansdatefiled := if(tribcode in ['it37', 'it60', 'it61', 'bkd0', 'wst4', 'it70'], le.bansdatefiled, '');
	self.bansfirst := if(tribcode in ['it37', 'it60', 'it61', 'bkd0', 'wst4', 'it70'], le.bansfirst, '');
	self.bansmiddle := if(tribcode in ['it37', 'it60', 'it61', 'bkd0', 'wst4', 'it70'], le.bansmiddle, '');
	self.banslast := if(tribcode in ['it37', 'it60', 'it61', 'bkd0', 'wst4', 'it70'], le.banslast, '');
	self.banscnty := if(tribcode in ['it37', 'it60', 'it61', 'bkd0', 'wst4', 'it70'], le.banscnty, '');
	self.bansecoaflag := if(tribcode in ['it37', 'it60', 'it61', 'bkd0', 'wst4', 'it70'], le.bansecoaflag, '');
	self.decsflag := if(tribcode in ['it37', 'at00',  'it60', 'it61', 'bkd0', 'wst4', 'it70'], le.decsflag, '');
	self.decsdob := if(tribcode in ['it37', 'at00', 'it60', 'it61', 'i200', 'bkd0', 'wst4', 'it70'], le.decsdob, '');
	self.decszip := if(tribcode in ['it37', 'at00', 'it60', 'it61', 'i200', 'bkd0', 'wst4', 'it70'], le.decszip, '');
	self.decszip2 := if(tribcode in ['it37', 'at00', 'it60', 'it61', 'i200', 'bkd0', 'wst4', 'it70'], le.decszip2, '');
	self.decslast := if(tribcode in ['it37', 'at00', 'it60', 'it61', 'i200', 'bkd0', 'wst4', 'it70'], le.decslast, '');
	self.decsfirst := if(tribcode in ['it37', 'at00', 'it60', 'it61', 'i200', 'bkd0', 'wst4', 'it70'], le.decsfirst, '');
	self.decsdod := if(tribcode in ['it37', 'at00', 'it60', 'it61', 'i200', 'bkd0', 'wst4', 'it70'], le.decsdod, '');
	self.inputaddrcharflag := if(tribcode in ['it37', 'it90', 'it21', 'at00', 'it51', 'it60', 'it61', 'wst4', 'it70'], le.inputaddrcharflag, '');
	self.inputsocscharflag := if(tribcode in ['it37', 'it90', 'it21', 'at00', 'it51', 'it60', 'it61', 'wst4', 'it70'], le.inputsocscharflag, '');
	self.socsstatusflag := if(tribcode in ['it37', 'it90', 'at00', 'it51', 'it60', 'it61', 'wst4'], le.socsstatusflag, '');
	self.correctsocs := if(tribcode in ['it37', 'it90', 'it21', 'at00', 'it51', 'it60', 'it61', 'wst4', 'it70'], le.correctsocs, '');
	
	self.phonestatusflag := if(tribcode in ['it37', 'it90', 'at00', 'it60', 'it61', 'wst4', 'it70'], le.phonestatusflag, '');
	self.phone := if(tribcode in ['it37', 'it90', 'at00', 'it60', 'it61', 'wst4', 'it70'], le.phone, '');
	self.altareacode := if(tribcode in ['it37', 'it90', 'at00', 'it60', 'it61', 'wst4', 'it70'], le.altareacode, '');
	self.splitdate := if(tribcode in ['it37', 'it90', 'at00', 'it60', 'it61', 'wst4', 'it70'], le.splitdate, '');
	self.internalcode := if(tribcode in ['it37', 'it90', 'at00', 'it60', 'it61', 'wst4'], '00', '');
	
	self.phonestatusflag2 := if(tribcode in [ 'at00'], le.phonestatusflag2, '');
	self.phone2 := if(tribcode in [ 'at00'], le.phone2, '');
	self.altareacode2 := if(tribcode in [ 'at00'], le.altareacode2, '');
	self.splitdate2 := if(tribcode in [ 'at00'], le.splitdate2, '');
	self.internalcode2 := if(tribcode in [ 'at00'], '00', '');
	
	self.phonestatusflag3 := if(tribcode in ['at00'], le.phonestatusflag3, '');
	self.phone3 := if(tribcode in [ 'at00'], le.phone3, '');
	self.altareacode3 := if(tribcode in [ 'at00'], le.altareacode3, '');
	self.splitdate3 := if(tribcode in [ 'at00'], le.splitdate3, '');
	self.internalcode3 := if(tribcode in [ 'at00'], '00', '');
	
	self.addrstatusflag := if(tribcode in ['it37', 'it90', 'at00', 'it60', 'it61', 'wst4', 'it70'], le.addrstatusflag, '');
	self.addrcharflag := if(tribcode in ['it37', 'it90', 'at00', 'it60', 'it61', 'wst4', 'it70'], le.addrcharflag, '');
	self.first := if(tribcode in ['it37', 'it90', 'at00', 'it60', 'it61', 'wst4', 'it70'], le.first, '');
	self.last := if(tribcode in ['it37', 'it90', 'at00', 'it60', 'it61', 'wst4', 'it70'], le.last, '');
	self.addr := if(tribcode in ['it37', 'it90', 'at00', 'it60', 'it61', 'wst4', 'it70'], le.addr, '');
	self.city := if(tribcode in ['it37', 'it90', 'at00', 'it60', 'it61', 'wst4', 'it70'], le.city, '');
	self.state := if(tribcode in ['it37', 'it90', 'at00', 'it60', 'it61', 'wst4', 'it70'], le.state, '');
	self.zip := if(tribcode in ['it37', 'it90', 'at00', 'it60', 'it61', 'wst4', 'it70'], le.zip, '');
	self.internalcode4 := '';  // always blank
	
	self.addrstatusflag2 := if(tribcode in [ 'at00'], le.addrstatusflag2, '');
	self.addrcharflag2 := if(tribcode in [ 'at00'], le.addrcharflag2, '');
	self.first2 := if(tribcode in [ 'at00'], le.first2, '');
	self.last2 := if(tribcode in [ 'at00'], le.last2, '');
	self.addr2 := if(tribcode in [ 'at00'], le.addr2, '');
	self.city2 := if(tribcode in [ 'at00'], le.city2, '');
	self.state2 := if(tribcode in [ 'at00'], le.state2, '');
	self.zip2 := if(tribcode in [ 'at00'], le.zip2, '');
	self.internalcode5 := '';  // always blank
	
	self.addrstatusflag3 := if(tribcode in [ 'at00'], le.addrstatusflag3, '');
	self.addrcharflag3 := if(tribcode in [ 'at00'], le.addrcharflag3, '');
	self.first3 := if(tribcode in [ 'at00'], le.first3, '');
	self.last3 := if(tribcode in [ 'at00'], le.last3, '');
	self.addr3 := if(tribcode in [ 'at00'], le.addr3, '');
	self.city3 := if(tribcode in [ 'at00'], le.city3, '');
	self.state3 := if(tribcode in [ 'at00'], le.state3, '');
	self.zip3 := map(tribcode='it21' => le.in_balance, // for it21, this is being populated with inputflux.balance
				  tribcode in[ 'at00'] => le.zip3, '');  
	
	self.hownstatusflag := if(tribcode in ['it21', 'it37', 'it60', 'it61', 'it70'], le.hownstatusflag, '');  
	self.estincome := if(tribcode in ['it21','it37', 'it60', 'it61', 'it70'], le.estincome, '');
	self.score := '';  
	self.score2 := if(tribcode in ['it21','it37','it60', 'it61', 'it70'], le.median_hh_size, ''); 
	self.score3 := map(
					tribcode in ['it90', 'at00'] => '0',
					tribcode='it70' => '',
					le.bansmatchflag='0' and le.decsflag='' and tribcode='wst4' => '0',
					''
	);
	
	self.internalcode6 := if(tribcode='it51', le.in_debttype, ''); // hang on to the input debt_type to determine which score field to output rsn509_1 for it51

end;

mapped_results := project(sortedPhones, filloutput(left));

// add IBO Model MSN605_1_0

includeRelativeInfo := true;
includeDLInfo       := false;
includeVehInfo      := false;
includeDerogInfo    := true;

// get boca shell results for the models
fullclam := if(tribCode in ['it51','it37','it60','it61','it70','i200'],
		Risk_Indicators.Boca_Shell_Function(iid_results, gateways, DPPA_Purpose, GLB_Purpose, isUtility, ln_branded, 
													includeRelativeInfo, includeDLInfo, includeVehInfo, includeDerogInfo, bsversion, 
													DataRestriction := DataRestriction, DataPermission := DataPermission ),
		group(dataset([],Risk_Indicators.Layout_Boca_Shell),seq));	
clam     := if( tribcode='it70', fullclam( seq % 2 = 0 ), fullclam );
skipclam := fullclam( seq % 2 = 1 );



riskwise.Layout_IT1O_model_in prep_rsn(alldata le) := transform
	self.seq := le.skiptrace.seq;
	self.addr_type_a := le.skiptrace.addr_type_a;
	self.addr_confidence_a := le.skiptrace.addr_confidence_a;
	self.phone_type_a := le.skiptrace.phone_type_a;
	self.bansmatchflag := le.skiptrace.bansmatchflag;
	self.bansdispcode  := le.skiptrace.bansdispcode;
	self.decsflag := le.skiptrace.decsflag;
	self.in_drlcstate := le.in_drlcstate;
	self.in_debttype := le.in_debttype;
	self.in_chargeoffdate := le.in_chargeoffdate;
	self.in_opendate := le.in_opendate;
	self.in_lastpymt := le.in_lastpymt;
	self.in_chargeoffamt := le.in_chargeoffamt;
	self.in_balance := le.in_balance;
end;

rsn_prep := project(alldata, prep_rsn(left));


// it170 uses recoverscore
Recover_Output := RECORD
	INTEGER seq;
	STRING3 address_index;
	STRING3 telephone_index;
	STRING3 contactability_score;
	STRING3 asset_index;
	STRING3 lifecycle_stress_index;
	STRING3 liquidity_score;
	STRING3 recover_score;
END;

recoverscore_batchin := project(alldata70, transform(models.Layout_RecoverScore_Batch_Input,
			self.seq := left.seq*2+1,
			self.debt_type := '2', // hard coded to medical recover score
			self.address_type := left.skiptrace.addr_type_a,
			self.address_confidence := left.skiptrace.addr_confidence_a,
			self.phone_type := left.skiptrace.phone_type_a,
			self.bankruptcy := left.skiptrace.bansdispcode,
			self.deceased := left.skiptrace.decsflag,
			self.debt_amount := left.in_chargeoffamt,
			self := []));
			
RSscore := if( tribcode = 'it70', Models.RecoverScore2(skipclam, recoverscore_batchin, returnall:=true), dataset( [], Models.Layout_Recoverscore ) );


// put the old address cleaner results into the clam so that they match up inside the msn model
clam_paro := join(easi_prep_paro, clam, left.seq*2=right.seq, transform(risk_indicators.layout_boca_shell, 	self.shell_input.st := left.iid.st,
																																																					self.shell_input.county := left.iid.county,
																																																					self.shell_input.geo_blk := left.iid.geo_blk,
																																																					self := right));

firstscore := map(  
				tribCode in ['it60','it61','it70'] => Models.MSN605_1_0(group(clam_paro,seq), easi_census_msn605, true),  
				tribcode = 'it51' => group(Models.RSN509_1_0(clam, rsn_prep), seq),
				tribcode = 'i200' => group(Models.RSN509_2_0(clam, rsn_prep), seq),
				group(dataset([],Models.Layout_ModelOut),seq));
				
			
RiskWise.Layout_IT1O addModel(mapped_results le, firstscore ri) := transform
	SELF.score := if(tribcode='it51' and le.internalcode6='08', '', ri.score);
	self.score2 := if(tribcode='it51' and le.internalcode6='08', ri.score, le.score2);
	self.internalcode6 := '';  // set the internalcode field back to blank after it's used to determine which score to populate
	SELF := le;
end;

withModel := join(mapped_results, firstscore, left.seq*2=right.seq, addModel(left,right),left outer);

thirdscore := map(
	tribcode in ['it37','it61'] => Models.RSN804_1_0( clam, full_skip_trace, easi_census ),
	dataset([],Models.Layout_ModelOut)
);

withModel3 := join( withModel, thirdscore, 2*left.seq=right.seq,
	transform( RiskWise.Layout_IT1O,
		self.score3 := right.score,
		self := left
	),
	left outer
);

RiskWise.Layout_IT4O addRS( withModel3 le, RSscore ri ) := TRANSFORM
	self.rsaddressindex         := (STRING3)(INTEGER)ri.address_index;
	self.rstelephoneindex       := (STRING3)(INTEGER)ri.telephone_index;
	self.rscontactabilityscore  := (STRING3)(INTEGER)ri.contactability_score;
	self.rsassetindex           := (STRING3)(INTEGER)ri.asset_index;
	self.rslifecyclestressindex := (STRING3)(INTEGER)ri.lifecycle_stress_index;
	self.rsliquidityscore       := (STRING3)(INTEGER)ri.liquidity_score;
	self.rsscore                := (STRING3)(INTEGER)ri.recover_score;

	SELF := le;
END;

modelWithRS := join( withModel3, RSscore, LEFT.seq+1 = (INTEGER)RIGHT.seq, addRS(LEFT,RIGHT), left outer );

return modelWithRS;

end;