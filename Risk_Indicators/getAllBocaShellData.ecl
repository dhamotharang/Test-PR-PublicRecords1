IMPORT _Control, Ut, riskwise, models, easi, doxie, dma, fcra_opt_out, USPIS_HotList, AML, gateway, LN_PropertyV2_Services, riskview, Business_Risk_BIP, BIPV2, MDR, ADVO;
onThor := _Control.Environment.OnThor;

EXPORT getAllBocaShellData (
  GROUPED DATASET (risk_indicators.Layout_output) iid, 
  GROUPED DATASET (risk_indicators.layout_bocashell_neutral) ids_wide, //if IsFCRA ids_wide also contains corr. flags
  GROUPED DATASET (risk_indicators.Layout_Boca_Shell) p,
  boolean IsFCRA, boolean isLN, unsigned1 dppa, boolean dppa_ok,

  // optimization options
  boolean includeRelativeInfo=true, boolean includeDLInfo=true,
  boolean includeVehInfo=true, boolean includeDerogInfo=true, 
  unsigned1 BSversion=1, boolean isPreScreen=false, boolean doScore=false, boolean filter_out_fares=false,
	string50 DataRestriction=iid_constants.default_DataRestriction,
	unsigned8 BSOptions = 0,  UNSIGNED1 glb=0,
	dataset(Gateway.Layouts.Config) gateways,
	string50 DataPermission=risk_indicators.iid_constants.default_DataPermission,
	boolean isDirectToConsumerPurpose = false,
	boolean IncludeLnJ = false,
 integer2 ReportingPeriod = 84  
  ) := FUNCTION
	
	// check the first record in the batch to determine if this a realtime transaction or an archive test
	// if the record is default_history_date or same month as today's date, run production_realtime_mode
	production_realtime_mode := iid[1].historydate=risk_indicators.iid_constants.default_history_date
														or iid[1].historydate = (unsigned)((string)risk_indicators.iid_constants.todaydate[1..6]);		
	
	// myGetDate := iid_constants.myGetDate(history_date);	// full history date
	checkDays(string8 d1, string8 d2, unsigned2 days) := ut.DaysApart(d1,d2) <= days and d1>d2;
  IsAML  := (BSOptions & risk_indicators.iid_constants.BSOptions.IsAML) > 0;

  // =============== Get Property Info ===============
  layout_PropertyRecord get_addresses(p le, integer c) := TRANSFORM
    SELF.fname := le.Shell_Input.fname;
    SELF.lname := le.Shell_Input.lname;

    SELF.prim_range := CHOOSE(c,le.Address_Verification.Input_Address_Information.prim_range,
																le.Address_Verification.Address_History_1.prim_range,
																le.Address_Verification.Address_History_2.prim_range);
    SELF.prim_name := CHOOSE (c,le.Address_Verification.Input_Address_Information.prim_name,
																le.Address_Verification.Address_History_1.prim_name,
																le.Address_Verification.Address_History_2.prim_name);
    SELF.st := CHOOSE(c,le.Address_Verification.Input_Address_Information.st,
												le.Address_Verification.Address_History_1.st,
												le.Address_Verification.Address_History_2.st);
		SELF.city_name := CHOOSE(c,le.Address_Verification.Input_Address_Information.city_name,
												le.Address_Verification.Address_History_1.city_name,
												le.Address_Verification.Address_History_2.city_name);
	  SELF.zip5 := CHOOSE(c,le.Address_Verification.Input_Address_Information.zip5,
													le.Address_Verification.Address_History_1.zip5,
													le.Address_Verification.Address_History_2.zip5);
  	SELF.predir := CHOOSE(c,le.Address_Verification.Input_Address_Information.predir,
														le.Address_Verification.Address_History_1.predir,
														le.Address_Verification.Address_History_2.predir);
	  SELF.postdir := CHOOSE(c,le.Address_Verification.Input_Address_Information.postdir,
														 le.Address_Verification.Address_History_1.postdir,
														 le.Address_Verification.Address_History_2.postdir);
	  SELF.addr_suffix := CHOOSE(c,le.Address_Verification.Input_Address_Information.addr_suffix,
																 le.Address_Verification.Address_History_1.addr_suffix,
																 le.Address_Verification.Address_History_2.addr_suffix);
	  SELF.sec_range := CHOOSE(c,le.Address_Verification.Input_Address_Information.sec_range,
															 le.Address_Verification.Address_History_1.sec_range,
															 le.Address_Verification.Address_History_2.sec_range);
	  SELF.county := CHOOSE(c,le.Address_Verification.Input_Address_Information.county,
														le.Address_Verification.Address_History_1.county,
														le.Address_Verification.Address_History_2.county);
	  SELF.geo_blk := CHOOSE(c,le.Address_Verification.Input_Address_Information.geo_blk,
														 le.Address_Verification.Address_History_1.geo_blk,
														 le.Address_Verification.Address_History_2.geo_blk);
	  SELF.hr_address := CHOOSE(c,le.Address_Verification.Input_Address_Information.hr_address,
																le.Address_Verification.Address_History_1.hr_address,
																le.Address_Verification.Address_History_2.hr_address);// was not being passed through
    SELF.did := le.did;
    SELF.seq := le.seq;
		self.historydate := le.historydate;
    SELF := [];
  END;
  p_address := NORMALIZE(p,3,get_addresses (LEFT,COUNTER))(prim_name != '', zip5 != '');

  ids_full := project (ids_wide, transform (Layout_BocaShell_neutral_ids, self := left));
	pre_ids_only := dedup(sort(ids_wide, seq, did), seq, did);
  ids_only := project(pre_ids_only, transform(layout_boca_shell_ids, self := left));
	
	// filter bankruptcy data differently for state of Arizona when query is in InsuranceMode
	boolean InsuranceMode := (BSOptions & risk_indicators.iid_constants.BSOptions.InsuranceMode) > 0;
	ids_only_derogs := project(pre_ids_only, 
						transform(layouts.layout_derogs_input, 
						self.insurance_bk_filter := insuranceMode and 
								(left.shell_input.st='AZ' or stringlib.stringtouppercase(left.shell_input.in_state)='AZ');
						self := left));

	// try to get multiple records per did to pass into derogs
	layouts.layout_derogs_input get_dids(pre_ids_only le, integer c) := TRANSFORM
		self.did := CHOOSE(c,	le.shell_input.did,
													le.iid.did2,
													le.iid.did3);
		self.insurance_bk_filter := insuranceMode and 
								(le.shell_input.st='AZ' or stringlib.stringtouppercase(le.shell_input.in_state)='AZ');
		self := le;
	end;
	p_did := NORMALIZE(pre_ids_only(~isrelat),3,get_dids (LEFT,COUNTER))(did<>0);		
	
	ids_only_mult_dids := p_did + ids_only_derogs(isrelat);		// get normalized did,did2,did3 plus relatives for use in derogs
	
  // without history date
  prop := IF (IsFCRA, 
	            Risk_Indicators.Boca_Shell_Property_FCRA (p_address, ids_only),
								Risk_Indicators.Boca_Shell_Property (p_address, ids_only, includeRelativeInfo, filter_out_fares)) ;
  // with history date
  prop_hist :=  IF (IsFCRA, 
	                  Risk_Indicators.Boca_Shell_Property_Hist_FCRA (p_address, ids_only),
                    Risk_Indicators.Boca_Shell_Property_Hist (p_address, ids_only, includeRelativeInfo, filter_out_fares));
										
  AMLSingleProperty :=  if (production_realtime_mode,   AML.AMLProperty(p_address, ids_only,includeRelativeInfo, filter_out_fares), AML.AMLPropertyHist(p_address, ids_only,includeRelativeInfo, filter_out_fares));
 
	// Build input module for Boca Shell Property Common.
	in_mod_property := MODULE(LN_PropertyV2_Services.interfaces.Iinput_report)
			// Option fields: set each to its default value unless present here in getAllBocaShellData.
			EXPORT faresID                 := '';
			// Data restrictions
			EXPORT data_restriction_mask   := DataRestriction;
			EXPORT srcRestrict             := []; // We'll do restrictions in Boca_Shell_Property_Common
			EXPORT currentVend             := FALSE;
			EXPORT currentOnly             := FALSE;
			EXPORT robustnessScoreSorting  := FALSE;
			EXPORT ssn_mask_value          := 'NONE';
			EXPORT application_type_value  := '';
			EXPORT set_AddressFilters      := ALL;
			EXPORT paSearch                := FALSE;
			// Tuning
			EXPORT DisplayMatchedParty_val := FALSE;
			EXPORT pThresh                 := 10;
			EXPORT lookupVal               := '';
			EXPORT partyType               := '';
			EXPORT incDetails              := FALSE;
			EXPORT TwoPartySearch          := FALSE;
			EXPORT xadl2_weight_threshold_value	:= 0;
			// For penalization
			EXPORT entity1 := ROW([],LN_PropertyV2_Services.interfaces.layout_entity);
			EXPORT entity2 := ROW([],LN_PropertyV2_Services.interfaces.layout_entity);
	END;

	prop_common_roxie := Risk_Indicators.Boca_Shell_Property_Common( p_address, ids_only, includeRelativeInfo, filter_out_fares, IsFCRA, in_mod_property, FALSE);
	prop_common_thor_pre := distribute(Risk_Indicators.Boca_Shell_Property_Common( p_address, ids_only, includeRelativeInfo, filter_out_fares, IsFCRA, in_mod_property, FALSE), hash64(seq))	:	PERSIST('~BOCASHELLFCRA::bocashell_property_results');
	prop_common_thor := sort(group(sort(prop_common_thor_pre, seq, local), seq, local),prim_name,prim_range,zip5,sec_range,census_loose,dataSrce);

	#IF(onThor)
		prop_common := prop_common_thor;
	#ELSE
		prop_common := prop_common_roxie;
	#END
  
	//*** MS-158: take the owned/sold properties and search ADVO by address to identify if an address is a business address so they can be counted and rolled up seperately in new shell fields.

	Risk_Indicators.Layouts.Layout_Relat_Prop_Plus_BusInd tf_pre_ADVO(prop_common l, p r) := transform
		self.zip5 												:= l.zip5;
		self.prim_range 									:= l.prim_range;
		self.prim_name 										:= l.prim_name;
		self.addr_suffix 									:= l.addr_suffix;
		self.predir 											:= l.predir;
		self.postdir 											:= l.postdir;
		self.sec_range 										:= l.sec_range;
		self.city_name										:= l.city_name;
		self.st 													:= l.st;
		self.historydate									:= r.historydate;
		self.Residential_or_Business_Ind	:= '';
		self															:= l;
	end;
									
	pre_ADVO := group(join(prop_common(~isrelat), p,	//we're only counting the input subject's properties, so we can drop any relatives properties before searching ADVO
												 left.seq = right.seq,
												 tf_pre_ADVO(left, right), left outer), seq); 

	Risk_Indicators.Layouts.Layout_Relat_Prop_Plus_BusInd getAdvo1(pre_ADVO le, Advo.Key_Addr1_history ri) := TRANSFORM
		self.Residential_or_Business_Ind	:= ri.Residential_or_Business_Ind;
		self 															:= le;
	END;
	
	//do search of ADVO by property to pick up address type - we are specifically looking for business addresses
	prop_with_advo_roxie := join(pre_ADVO, if(isFCRA, Advo.Key_Addr1_FCRA_history, Advo.Key_Addr1_history),  //join to appropriate FCRA/nonFCRA key
					left.zip5 != '' and 
					left.prim_range != '' and
					keyed(left.zip5 = right.zip) and
					keyed(left.prim_range = right.prim_range) and
					keyed(left.prim_name = right.prim_name) and
					keyed(left.addr_suffix = right.addr_suffix) and
					keyed(left.predir = right.predir) and
					keyed(left.postdir = right.postdir) and
					keyed(left.sec_range = right.sec_range)  and
					((unsigned)RIGHT.date_first_seen < (unsigned)Risk_Indicators.iid_constants.full_history_date(left.historydate)), 
					getAdvo1(LEFT,RIGHT), 
					left outer,
					atmost(riskwise.max_atmost));

	prop_with_advo_thor := join(distribute(pre_ADVO, hash64(zip5,
																												 prim_range,
																												 prim_name)), 
					distribute(pull(if(isFCRA, Advo.Key_Addr1_FCRA_history, Advo.Key_Addr1_history)), hash64(zip, prim_range, prim_name)),  //join to appropriate FCRA/nonFCRA key
					left.zip5 != '' and 
					left.prim_range != '' and
					left.zip5 = right.zip and
					left.prim_range = right.prim_range and
					left.prim_name = right.prim_name and
					left.addr_suffix = right.addr_suffix and
					left.predir = right.predir and
					left.postdir = right.postdir and
					left.sec_range = right.sec_range  and
					((unsigned)RIGHT.date_first_seen < (unsigned)Risk_Indicators.iid_constants.full_history_date(left.historydate)), 
					getAdvo1(LEFT,RIGHT), 
					left outer,
					atmost(left.zip5 = right.zip and
                 left.prim_range = right.prim_range and
                 left.prim_name = right.prim_name and
                 left.addr_suffix = right.addr_suffix and
                 left.predir = right.predir and
                 left.postdir = right.postdir and
                 left.sec_range = right.sec_range, riskwise.max_atmost), LOCAL);
					
	#IF(onThor)
		prop_with_advo := group(sort(prop_with_advo_thor, seq), seq);
	#ELSE
		prop_with_advo := group(prop_with_advo_roxie, seq);
	#END
  
	prop_with_advo_deduped :=  dedup(sort(prop_with_advo, seq, did, zip5, prim_range, prim_name, addr_suffix, predir, postdir, sec_range, -date_first_seen), 
																												seq, did, zip5, prim_range, prim_name, addr_suffix, predir, postdir, sec_range);

  single_property := 
		MAP(BSversion >= 53 						=> sort(group(sort(prop_with_advo_deduped + prop_common(isrelat), seq), seq),prim_name,prim_range,zip5,sec_range,census_loose,dataSrce), 
				BSversion >= 50 						=> prop_common,
																			 IF(production_realtime_mode, prop, prop_hist)
			 );

// AML	
	Layout_prop_ownership := RECORD
	boolean isrelat;
	risk_indicators.Layout_Boca_Shell_ids.seq;
	risk_indicators.Layout_Boca_Shell_ids.did;
	STRING1   property_status_applicant;		
	STRING1   property_status_family;	
  BOOLEAN applicant_owned;
	BOOLEAN occupant_owned;
	BOOLEAN family_owned;
	BOOLEAN family_sold;
	BOOLEAN applicant_sold;
	AML.Layouts.LayoutAMLShell;
END;
									 
										 
Layout_prop_ownership countProperty_ownership(AMLSingleProperty le) := TRANSFORM
		  // new fields for AML attributes version 1
  SELF.seq := le.seq;
	self.relativePropertyCount 	:= IF(le.property_status_family='O', le.property_count, 0);
  SELF.applicant_owned   := le.applicant_owned;
	SELF.family_owned   := le.family_owned;
	SELF.family_sold     := le.family_sold;
	SELF.applicant_sold  := le.applicant_sold;	

	SELF := le;
	self := [];
END;

//kept individual records with Relatives for AML	
AMLSinglePropSort := sort(AMLSingleProperty, seq, did);

Prop_ownership_len := Project(AMLSinglePropSort/*(property_status_family<>' ' and isrelat)*/, countProperty_ownership(left));

Layout_prop_ownership roll_ownership(Prop_ownership_len le, Prop_ownership_len ri) := TRANSFORM
  SELF.seq := le.seq;
	self.relativePropertyCount   := le.RelativePropertyCount + ri.RelativePropertyCount  ;
	SELF := le;
	self := [];
END;

single_property_relat := ROLLUP(SORT(Prop_ownership_len,seq,did,property_status_family), roll_ownership(LEFT,RIGHT), seq, did);
															
layout_bocashell_neutral addRelatInfo(ids_wide le, single_property_relat ri) := TRANSFORM
  SELF.seq := le.seq;
	self.did := le.did;
	self.relativepropertycount := ri.RelativePropertyCount;
	self.AMLAge  := le.age;
	self := le;
END;
	
RelatRecProp := join(ids_wide, 	single_property_relat, 
								left.seq=right.seq and left.did=right.did,
								addRelatInfo(left, right), left outer);



  // Generate the totals
  Rel_Property_Rolled := Risk_Indicators.Roll_Relative_Property(Single_Property(property_status_family<>' '));
  Per_Property_Rolled := Risk_Indicators.Roll_Applicant_Property(Single_Property(property_status_applicant<>' '));

	// Apply the address specific information
	risk_indicators.Layout_Boca_Shell check_best(risk_indicators.Layout_Boca_Shell le, Single_Property ri) :=
	TRANSFORM
		Input_match := LE.Address_Verification.Input_Address_Information.prim_range=RI.prim_range AND
					LE.Address_Verification.Input_Address_Information.prim_name=RI.prim_name AND
					LE.Address_Verification.Input_Address_Information.zip5=RI.zip5 AND
					LE.Address_Verification.Input_Address_Information.sec_range=RI.sec_range;
		Hist1_Match := LE.Address_Verification.Address_History_1.prim_range=RI.prim_range AND
					LE.Address_Verification.Address_History_1.prim_name=RI.prim_name AND
					LE.Address_Verification.Address_History_1.zip5=RI.zip5 AND
					LE.Address_Verification.Address_History_1.sec_range=RI.sec_range;
		Hist2_Match := LE.Address_Verification.Address_History_2.prim_range=RI.prim_range AND
					LE.Address_Verification.Address_History_2.prim_name=RI.prim_name AND
					LE.Address_Verification.Address_History_2.zip5=RI.zip5 AND
					LE.Address_Verification.Address_History_2.sec_range=RI.sec_range;
	  
	
		SELF.Address_Verification.Input_Address_Information.applicant_owned := if (input_match, ri.applicant_owned, le.Address_Verification.Input_Address_Information.applicant_owned);
		SELF.Address_Verification.Input_Address_Information.family_owned := if (input_match, ri.family_owned, LE.Address_Verification.Input_Address_Information.family_owned);
		SELF.Address_Verification.Input_Address_Information.family_sold := if (input_match, ri.family_sold, LE.Address_Verification.Input_Address_Information.family_sold);
		SELF.Address_Verification.Input_Address_Information.applicant_sold := if (input_match, ri.applicant_sold, LE.Address_Verification.Input_Address_Information.applicant_sold);
		SELF.Address_Verification.Input_Address_Information.family_buy_found := if (input_match, ri.family_buy_found, LE.Address_Verification.Input_Address_Information.family_buy_found);
		SELF.Address_Verification.Input_Address_Information.applicant_buy_found := if (input_match, ri.applicant_buy_found, LE.Address_Verification.Input_Address_Information.applicant_buy_found);
		SELF.Address_Verification.Input_Address_Information.family_sale_found := if (input_match, ri.family_sale_found, LE.Address_Verification.Input_Address_Information.family_sale_found);
		SELF.Address_Verification.Input_Address_Information.applicant_sale_found := if (input_match, ri.applicant_sale_found, LE.Address_Verification.Input_Address_Information.applicant_sale_found);
		SELF.Address_Verification.Input_Address_Information.occupant_owned := if (input_match, ri.occupant_owned, LE.Address_Verification.Input_Address_Information.occupant_owned);
		SELF.Address_Verification.Input_Address_Information.purchase_date := if (input_match, ri.purchase_date, LE.Address_Verification.Input_Address_Information.purchase_date);
		SELF.Address_Verification.Input_Address_Information.built_date := if (input_match, ri.built_date, LE.Address_Verification.Input_Address_Information.built_date);
		SELF.Address_Verification.Input_Address_Information.purchase_amount := if (input_match, ri.purchase_amount, LE.Address_Verification.Input_Address_Information.purchase_amount);
		SELF.Address_Verification.Input_Address_Information.mortgage_amount := if (input_match, ri.mortgage_amount, LE.Address_Verification.Input_Address_Information.mortgage_amount);
		SELF.Address_Verification.Input_Address_Information.mortgage_date := if (input_match, ri.mortgage_date, LE.Address_Verification.Input_Address_Information.mortgage_date);
		SELF.Address_Verification.Input_Address_Information.mortgage_type := if( input_match, ri.mortgage_type, LE.Address_Verification.Input_Address_Information.mortgage_type);
		SELF.Address_Verification.Input_Address_Information.type_financing := if( input_match, ri.type_financing, LE.Address_Verification.Input_Address_Information.type_financing);
		SELF.Address_Verification.Input_Address_Information.first_td_due_date := if( input_match, ri.first_td_due_date, LE.Address_Verification.Input_Address_Information.first_td_due_date);
		SELF.Address_Verification.Input_Address_Information.assessed_amount := if (input_match, ri.assessed_amount, LE.Address_Verification.Input_Address_Information.assessed_amount);
		SELF.Address_Verification.Input_Address_Information.assessed_total_value := if (input_match, ri.assessed_total_value, LE.Address_Verification.Input_Address_Information.assessed_total_value);
		SELF.Address_Verification.Input_Address_Information.naprop := if (input_match, ri.naprop, LE.Address_Verification.Input_Address_Information.naprop);
		SELF.Address_Verification.Input_Address_Information.HR_Address := if (input_match, ri.HR_Address, LE.Address_Verification.Input_Address_Information.HR_Address);
		self.Address_Verification.Input_Address_Information.standardized_land_use_code := if (input_match, ri.standardized_land_use_code, LE.Address_Verification.Input_Address_Information.standardized_land_use_code);
		self.Address_Verification.Input_Address_Information.building_area := if (input_match, ri.building_area, LE.Address_Verification.Input_Address_Information.building_area);
		self.Address_Verification.Input_Address_Information.no_of_buildings := if (input_match, ri.no_of_buildings, LE.Address_Verification.Input_Address_Information.no_of_buildings);
		self.Address_Verification.Input_Address_Information.no_of_stories := if (input_match, ri.no_of_stories, LE.Address_Verification.Input_Address_Information.no_of_stories);
		self.Address_Verification.Input_Address_Information.assessed_value_year := if (input_match, ri.assessed_value_year, LE.Address_Verification.Input_Address_Information.assessed_value_year);
		self.Address_Verification.Input_Address_Information.no_of_rooms := if (input_match, ri.no_of_rooms, LE.Address_Verification.Input_Address_Information.no_of_rooms);
		self.Address_Verification.Input_Address_Information.no_of_bedrooms := if (input_match, ri.no_of_bedrooms, LE.Address_Verification.Input_Address_Information.no_of_bedrooms);
		self.Address_Verification.Input_Address_Information.no_of_baths := if (input_match, ri.no_of_baths, LE.Address_Verification.Input_Address_Information.no_of_baths);
		self.Address_Verification.Input_Address_Information.no_of_partial_baths := if (input_match, ri.no_of_partial_baths, LE.Address_Verification.Input_Address_Information.no_of_partial_baths);
		self.Address_Verification.Input_Address_Information.garage_type_code := if (input_match, ri.garage_type_code, LE.Address_Verification.Input_Address_Information.garage_type_code);
		self.Address_Verification.Input_Address_Information.parking_no_of_cars := if (input_match, ri.parking_no_of_cars, LE.Address_Verification.Input_Address_Information.parking_no_of_cars);
		self.Address_Verification.Input_Address_Information.style_code := if (input_match, ri.style_code, LE.Address_Verification.Input_Address_Information.style_code);
		
		SELF.Address_Verification.Address_History_1.applicant_owned := if (hist1_match, ri.applicant_owned, LE.Address_Verification.Address_History_1.applicant_owned);
		SELF.Address_Verification.Address_History_1.family_owned := if (hist1_match, ri.family_owned, LE.Address_Verification.Address_History_1.family_owned);
		SELF.Address_Verification.Address_History_1.family_sold := if (hist1_match, ri.family_sold, LE.Address_Verification.Address_History_1.family_sold);
		SELF.Address_Verification.Address_History_1.applicant_sold := if (hist1_match, ri.applicant_sold, LE.Address_Verification.Address_History_1.applicant_sold);
		SELF.Address_Verification.Address_History_1.family_buy_found := if (hist1_match, ri.family_buy_found, LE.Address_Verification.Address_History_1.family_buy_found);
		SELF.Address_Verification.Address_History_1.applicant_buy_found := if (hist1_match, ri.applicant_buy_found, LE.Address_Verification.Address_History_1.applicant_buy_found);
		SELF.Address_Verification.Address_History_1.family_sale_found := if (hist1_match, ri.family_sale_found, LE.Address_Verification.Address_History_1.family_sale_found);
		SELF.Address_Verification.Address_History_1.applicant_sale_found := if (hist1_match, ri.applicant_sale_found, LE.Address_Verification.Address_History_1.applicant_sale_found);
		SELF.Address_Verification.Address_History_1.occupant_owned := if (hist1_match, ri.occupant_owned, LE.Address_Verification.Address_History_1.occupant_owned);	// check whether this works
		SELF.Address_Verification.Address_History_1.purchase_date := if (hist1_match, ri.purchase_date, LE.Address_Verification.Address_History_1.purchase_date);
		SELF.Address_Verification.Address_History_1.built_date := if (hist1_match, ri.built_date, LE.Address_Verification.Address_History_1.built_date);
		SELF.Address_Verification.Address_History_1.purchase_amount := if (hist1_match, ri.purchase_amount, LE.Address_Verification.Address_History_1.purchase_amount);
		SELF.Address_Verification.Address_History_1.mortgage_amount := if (hist1_match, ri.mortgage_amount, LE.Address_Verification.Address_History_1.mortgage_amount);
		SELF.Address_Verification.Address_History_1.mortgage_date := if (hist1_match, ri.mortgage_date, LE.Address_Verification.Address_History_1.mortgage_date);
		SELF.Address_Verification.Address_History_1.mortgage_type := if (hist1_match, ri.mortgage_type, LE.Address_Verification.Address_History_1.mortgage_type);
		SELF.Address_Verification.Address_History_1.type_financing := if (hist1_match, ri.type_financing, LE.Address_Verification.Address_History_1.type_financing);
		SELF.Address_Verification.Address_History_1.first_td_due_date := if (hist1_match, ri.first_td_due_date, LE.Address_Verification.Address_History_1.first_td_due_date);
		SELF.Address_Verification.Address_History_1.assessed_amount := if (hist1_match, ri.assessed_amount, LE.Address_Verification.Address_History_1.assessed_amount);
		SELF.Address_Verification.Address_History_1.assessed_total_value := if (hist1_match, ri.assessed_total_value, LE.Address_Verification.Address_History_1.assessed_total_value);
		SELF.Address_Verification.Address_History_1.naprop := if (hist1_match, ri.naprop, LE.Address_Verification.Address_History_1.naprop);
		SELF.Address_Verification.Address_History_1.HR_Address := if (hist1_match, ri.HR_Address, LE.Address_Verification.Address_History_1.HR_Address);
		self.Address_Verification.Address_History_1.standardized_land_use_code := if (hist1_match, ri.standardized_land_use_code, LE.Address_Verification.Address_History_1.standardized_land_use_code);
		self.Address_Verification.Address_History_1.building_area := if (hist1_match, ri.building_area, LE.Address_Verification.Address_History_1.building_area);
		self.Address_Verification.Address_History_1.no_of_buildings := if (hist1_match, ri.no_of_buildings, LE.Address_Verification.Address_History_1.no_of_buildings);
		self.Address_Verification.Address_History_1.no_of_stories := if (hist1_match, ri.no_of_stories, LE.Address_Verification.Address_History_1.no_of_stories);
		self.Address_Verification.Address_History_1.assessed_value_year := if (hist1_match, ri.assessed_value_year, LE.Address_Verification.Address_History_1.assessed_value_year);
		self.Address_Verification.Address_History_1.no_of_rooms := if (hist1_match, ri.no_of_rooms, LE.Address_Verification.Address_History_1.no_of_rooms);
		self.Address_Verification.Address_History_1.no_of_bedrooms := if (hist1_match, ri.no_of_bedrooms, LE.Address_Verification.Address_History_1.no_of_bedrooms);
		self.Address_Verification.Address_History_1.no_of_baths := if (hist1_match, ri.no_of_baths, LE.Address_Verification.Address_History_1.no_of_baths);
		self.Address_Verification.Address_History_1.no_of_partial_baths := if (hist1_match, ri.no_of_partial_baths, LE.Address_Verification.Address_History_1.no_of_partial_baths);
		self.Address_Verification.Address_History_1.garage_type_code := if (hist1_match, ri.garage_type_code, LE.Address_Verification.Address_History_1.garage_type_code);
		self.Address_Verification.Address_History_1.parking_no_of_cars := if (hist1_match, ri.parking_no_of_cars, LE.Address_Verification.Address_History_1.parking_no_of_cars);
		self.Address_Verification.Address_History_1.style_code := if (hist1_match, ri.style_code, LE.Address_Verification.Address_History_1.style_code);

		SELF.Address_Verification.Address_History_2.applicant_owned := if (hist2_match, ri.applicant_owned, LE.Address_Verification.Address_History_2.applicant_owned);
		SELF.Address_Verification.Address_History_2.family_owned := if (hist2_match, ri.family_owned, LE.Address_Verification.Address_History_2.family_owned);
		SELF.Address_Verification.Address_History_2.family_sold := if (hist2_match, ri.family_sold, LE.Address_Verification.Address_History_2.family_sold);
		SELF.Address_Verification.Address_History_2.applicant_sold := if (hist2_match, ri.applicant_sold, LE.Address_Verification.Address_History_2.applicant_sold);
		SELF.Address_Verification.Address_History_2.family_buy_found := if (hist2_match, ri.family_buy_found, LE.Address_Verification.Address_History_2.family_buy_found);
		SELF.Address_Verification.Address_History_2.applicant_buy_found := if (hist2_match, ri.applicant_buy_found, LE.Address_Verification.Address_History_2.applicant_buy_found);
		SELF.Address_Verification.Address_History_2.family_sale_found := if (hist2_match, ri.family_sale_found, LE.Address_Verification.Address_History_2.family_sale_found);
		SELF.Address_Verification.Address_History_2.applicant_sale_found := if (hist2_match, ri.applicant_sale_found, LE.Address_Verification.Address_History_2.applicant_sale_found);
		SELF.Address_Verification.Address_History_2.occupant_owned := if (hist2_match, ri.occupant_owned, LE.Address_Verification.Address_History_2.occupant_owned);	// check whether this works
		SELF.Address_Verification.Address_History_2.purchase_date := if (hist2_match, ri.purchase_date, LE.Address_Verification.Address_History_2.purchase_date);
		SELF.Address_Verification.Address_History_2.built_date := if (hist2_match, ri.built_date, LE.Address_Verification.Address_History_2.built_date);
		SELF.Address_Verification.Address_History_2.purchase_amount := if (hist2_match, ri.purchase_amount, LE.Address_Verification.Address_History_2.purchase_amount);
		SELF.Address_Verification.Address_History_2.mortgage_amount := if (hist2_match, ri.mortgage_amount, LE.Address_Verification.Address_History_2.mortgage_amount);
		SELF.Address_Verification.Address_History_2.mortgage_date := if (hist2_match, ri.mortgage_date, LE.Address_Verification.Address_History_2.mortgage_date);
		SELF.Address_Verification.Address_History_2.mortgage_type := if (hist2_match, ri.mortgage_type, LE.Address_Verification.Address_History_2.mortgage_type);
		SELF.Address_Verification.Address_History_2.type_financing := if (hist2_match, ri.type_financing, LE.Address_Verification.Address_History_2.type_financing);
		SELF.Address_Verification.Address_History_2.first_td_due_date := if (hist2_match, ri.first_td_due_date, LE.Address_Verification.Address_History_2.first_td_due_date);
		SELF.Address_Verification.Address_History_2.assessed_amount := if (hist2_match, ri.assessed_amount, LE.Address_Verification.Address_History_2.assessed_amount);
		SELF.Address_Verification.Address_History_2.assessed_total_value := if (hist2_match, ri.assessed_total_value, LE.Address_Verification.Address_History_2.assessed_total_value);
		SELF.Address_Verification.Address_History_2.naprop := if (hist2_match, ri.naprop, LE.Address_Verification.Address_History_2.naprop);
		SELF.Address_Verification.Address_History_2.HR_Address := if (hist2_match, ri.HR_Address, LE.Address_Verification.Address_History_2.HR_Address);
		// edina shell will not get these but populate internally for consistency with other 2 addresses
		self.Address_Verification.Address_History_2.standardized_land_use_code := if (hist2_match, ri.standardized_land_use_code, LE.Address_Verification.Address_History_2.standardized_land_use_code);
		self.Address_Verification.Address_History_2.building_area := if (hist2_match, ri.building_area, LE.Address_Verification.Address_History_2.building_area);
		self.Address_Verification.Address_History_2.no_of_buildings := if (hist2_match, ri.no_of_buildings, LE.Address_Verification.Address_History_2.no_of_buildings);
		self.Address_Verification.Address_History_2.no_of_stories := if (hist2_match, ri.no_of_stories, LE.Address_Verification.Address_History_2.no_of_stories);
		self.Address_Verification.Address_History_2.assessed_value_year := if (hist2_match, ri.assessed_value_year, LE.Address_Verification.Address_History_2.assessed_value_year);
		self.Address_Verification.Address_History_2.no_of_rooms := if (hist2_match, ri.no_of_rooms, LE.Address_Verification.Address_History_2.no_of_rooms);
		self.Address_Verification.Address_History_2.no_of_bedrooms := if (hist2_match, ri.no_of_bedrooms, LE.Address_Verification.Address_History_2.no_of_bedrooms);
		self.Address_Verification.Address_History_2.no_of_baths := if (hist2_match, ri.no_of_baths, LE.Address_Verification.Address_History_2.no_of_baths);
		self.Address_Verification.Address_History_2.no_of_partial_baths := if (hist2_match, ri.no_of_partial_baths, LE.Address_Verification.Address_History_2.no_of_partial_baths);
		self.Address_Verification.Address_History_2.garage_type_code := if (hist2_match, ri.garage_type_code, LE.Address_Verification.Address_History_2.garage_type_code);
		self.Address_Verification.Address_History_2.parking_no_of_cars := if (hist2_match, ri.parking_no_of_cars, LE.Address_Verification.Address_History_2.parking_no_of_cars);
		self.Address_Verification.Address_History_2.style_code := if (hist2_match, ri.style_code, LE.Address_Verification.Address_History_2.style_code);
		
		
		// for NON-FCRA, make sure the input DID matches the DID on the single property record before selecting the dates
		isApplicant := le.did=ri.did;
		dt_first_purchased := if( (le.other_address_info.date_first_purchase!=0 and le.other_address_info.date_first_purchase <= ri.purchase_date_by_did) or ri.purchase_date_by_did=0, 
																											le.other_address_info.date_first_purchase, ri.purchase_date_by_did);
		self.other_address_info.date_first_purchase := if(isApplicant, dt_first_purchased, le.other_address_info.date_first_purchase);
		dt_most_recent_purchase := MAX(le.other_address_info.date_most_recent_purchase,ri.purchase_date_by_did);
		self.other_address_info.date_most_recent_purchase := if(isApplicant, dt_most_recent_purchase, le.other_address_info.date_most_recent_purchase);
		
		myGetDate := risk_indicators.iid_constants.myGetDate(le.historydate);
		
		// use the purchase date by did field to match the date most recent purchase field (using this field should imply that the purchase date is for the DID, so no additional checking should need to be done)
		self.other_address_info.num_purchase30 := le.other_address_info.num_purchase30 + if(isApplicant and checkDays(myGetDate,(string)ri.purchase_date_by_did,30), 1, 0);
		self.other_address_info.num_purchase90 := le.other_address_info.num_purchase90 + if(isApplicant and checkDays(myGetDate,(string)ri.purchase_date_by_did,90), 1, 0);
		self.other_address_info.num_purchase180 := le.other_address_info.num_purchase180 + if(isApplicant and checkDays(myGetDate,(string)ri.purchase_date_by_did,180), 1, 0);
		self.other_address_info.num_purchase12 := le.other_address_info.num_purchase12 + if(isApplicant and checkDays(myGetDate,(string)ri.purchase_date_by_did,ut.DaysInNYears(1)), 1, 0);
		self.other_address_info.num_purchase24 := le.other_address_info.num_purchase24 + if(isApplicant and checkDays(myGetDate,(string)ri.purchase_date_by_did,ut.DaysInNYears(2)), 1, 0);
		self.other_address_info.num_purchase36 := le.other_address_info.num_purchase36 + if(isApplicant and checkDays(myGetDate,(string)ri.purchase_date_by_did,ut.DaysInNYears(3)), 1, 0);
		self.other_address_info.num_purchase60 := le.other_address_info.num_purchase60 + if(isApplicant and checkDays(myGetDate,(string)ri.purchase_date_by_did,ut.DaysInNYears(5)), 1, 0);
		
		dt_first_sale := if(le.other_address_info.date_first_sale=0 or le.other_address_info.date_first_sale > ri.sale_date_by_did, ri.sale_date_by_did, le.other_address_info.date_first_sale);
		self.other_address_info.date_first_sale := if(isApplicant, dt_first_sale, le.other_address_info.date_first_sale);

		dt_most_recent_sale := MAX(le.other_address_info.date_most_recent_sale,ri.sale_date_by_did);
		self.other_address_info.date_most_recent_sale := if(isApplicant, dt_most_recent_sale, le.other_address_info.date_most_recent_sale);
		
		// use the sale date by did field to amtch the date most recent sale field (using this field should imply that the sale date is for the DID, so no additonal checking should need to be done)
		self.other_address_info.num_sold30 := le.other_address_info.num_sold30 + if(isApplicant and checkDays(myGetDate,(string)ri.sale_date_by_did,30), 1, 0);
		self.other_address_info.num_sold90 := le.other_address_info.num_sold90 + if(isApplicant and checkDays(myGetDate,(string)ri.sale_date_by_did,90), 1, 0);
		self.other_address_info.num_sold180 := le.other_address_info.num_sold180 + if(isApplicant and checkDays(myGetDate,(string)ri.sale_date_by_did,180), 1, 0);
		self.other_address_info.num_sold12 := le.other_address_info.num_sold12 + if(isApplicant and checkDays(myGetDate,(string)ri.sale_date_by_did,ut.DaysInNYears(1)), 1, 0);
		self.other_address_info.num_sold24 := le.other_address_info.num_sold24 + if(isApplicant and checkDays(myGetDate,(string)ri.sale_date_by_did,ut.DaysInNYears(2)), 1, 0);
		self.other_address_info.num_sold36 := le.other_address_info.num_sold36 + if(isApplicant and checkDays(myGetDate,(string)ri.sale_date_by_did,ut.DaysInNYears(3)), 1, 0);
		self.other_address_info.num_sold60 := le.other_address_info.num_sold60 + if(isApplicant and checkDays(myGetDate,(string)ri.sale_date_by_did,ut.DaysInNYears(5)), 1, 0);
			
		// distressed sale output from bocashell 3.0
		self.address_verification.recent_property_sales.sale_price1       := if(isApplicant AND ri.sale_price1 > 0      , ri.sale_price1      , le.address_verification.recent_property_sales.sale_price1);
		self.address_verification.recent_property_sales.sale_date1        := if(isApplicant AND ri.sale_date1 > 0       , ri.sale_date1       , le.address_verification.recent_property_sales.sale_date1);
		self.address_verification.recent_property_sales.prev_purch_price1 := if(isApplicant AND ri.prev_purch_price1 > 0, ri.prev_purch_price1, le.address_verification.recent_property_sales.prev_purch_price1);
		self.address_verification.recent_property_sales.prev_purch_date1  := if(isApplicant AND ri.prev_purch_date1 > 0 , ri.prev_purch_date1 , le.address_verification.recent_property_sales.prev_purch_date1);
		self.address_verification.recent_property_sales.sale_price2       := if(isApplicant AND ri.sale_price2 > 0      , ri.sale_price2      , le.address_verification.recent_property_sales.sale_price2);
		self.address_verification.recent_property_sales.sale_date2        := if(isApplicant AND ri.sale_date2 > 0       , ri.sale_date2       , le.address_verification.recent_property_sales.sale_date2);
		self.address_verification.recent_property_sales.prev_purch_price2 := if(isApplicant AND ri.prev_purch_price2 > 0, ri.prev_purch_price2, le.address_verification.recent_property_sales.prev_purch_price2);
		self.address_verification.recent_property_sales.prev_purch_date2  := if(isApplicant AND ri.prev_purch_date2 > 0 , ri.prev_purch_date2 , le.address_verification.recent_property_sales.prev_purch_date2);
				
		SELF := le;
	END;
	
	p2 := p(iid.pullidflag = '');
	pullid_recs := p(iid.pullidflag = '1');

	History_2_Property_Added_a := 
		group (sort (denormalize (p2, single_property,	left.seq = right.seq, check_best (LEFT,RIGHT)),
								 seq), seq);			 
			 
	History_2_Property_added := History_2_Property_Added_a + group(sort(pullid_recs, seq),seq);

  // =============== Vehicles ===============
  vehicles := Risk_Indicators.Boca_Shell_Vehicles(ids_only, dppa, dppa_ok, includeRelativeInfo, BSversion);
  vehicles_hist := Risk_Indicators.Boca_Shell_Vehicles_Hist(ids_only, dppa, dppa_ok, includeRelativeInfo, BSversion);
  vehicles_rolled := if (production_realtime_mode, vehicles, vehicles_hist);


  // =============== Derogs ===============

  derogs := IF (IsFCRA,
                Risk_Indicators.Boca_Shell_Derogs_FCRA (if(BSversion>2,ids_only_mult_dids, ids_only_derogs), bsversion, BSOptions, IncludeLnJ, iid, ReportingPeriod), 
								Risk_Indicators.Boca_Shell_Derogs      (if(BSversion>2,ids_only_mult_dids, ids_only_derogs), BSversion));
  
	derogs_hist := IF (IsFCRA,
                     Risk_Indicators.Boca_Shell_Derogs_Hist_FCRA (if(BSversion>2,ids_only_mult_dids, ids_only_derogs), bsversion, BSOptions, IncludeLnJ, ReportingPeriod),
                     Risk_Indicators.Boca_Shell_Derogs_Hist      (if(BSversion>2,ids_only_mult_dids, ids_only_derogs), bsversion));
  doc_rolled := if (production_realtime_mode, derogs, derogs_hist);
	
	//not used in code...remove
	// relat_derogs := doc_rolled(isrelat);
	// doc_rolled_ind := doc_rolled(~isrelat);
	
	// =============== Watercraft ===============
	watercraft := IF (IsFCRA,
											Risk_Indicators.Boca_Shell_Watercraft_FCRA (ids_only(~isrelat), isPreScreen, bsversion), 
											Risk_Indicators.Boca_Shell_Watercraft      (ids_only, bsVersion/*(~isrelat)*/));
	watercraft_hist := IF (IsFCRA,
													Risk_Indicators.Boca_Shell_Watercraft_Hist_FCRA (ids_only(~isrelat), isPreScreen, bsversion),
													Risk_Indicators.Boca_Shell_Watercraft      (ids_only, bsVersion/*(~isrelat)*/));
	watercraft_rolled := if (production_realtime_mode, watercraft, watercraft_hist);
  
	watercraft_relat := watercraft_rolled(isrelat);
	watercraft_rolled_indv := watercraft_rolled(~isrelat);
	
	
	// =============== Professional Licenses ===============
	proflic := IF (IsFCRA,
											Risk_Indicators.Boca_Shell_Proflic_FCRA (ids_only(~isrelat), bsversion, isPrescreen, isDirectToConsumerPurpose),
											Risk_Indicators.Boca_Shell_Proflic      (ids_only(~isrelat), bsversion));
	proflic_hist := IF (IsFCRA,
													Risk_Indicators.Boca_Shell_Proflic_Hist_FCRA (ids_only(~isrelat), bsversion, isPrescreen, isDirectToConsumerPurpose),
													Risk_Indicators.Boca_Shell_Proflic      (ids_only(~isrelat), bsversion));
	proflic_rolled := if (production_realtime_mode, proflic, proflic_hist);
	

	// =============== Student File ===============
	student_rolled := IF (IsFCRA,
													Risk_Indicators.Boca_Shell_Student_FCRA (ids_only(~isrelat), bsversion),
													Risk_Indicators.Boca_Shell_Student      (ids_only(~isrelat), bsversion, filter_out_fares));  
													// filter_out_fares is our option that tells us we are running this for leadIntegrity.
													// Use that same option here as our marketing flag within student function


// =============== Aircraft ===============
	aircraft := IF (IsFCRA,		Risk_Indicators.Boca_Shell_aircraft_FCRA (ids_only(~isrelat)),
						                Risk_Indicators.Boca_Shell_aircraft      (ids_only/*(~isrelat)*/));
	aircraft_hist := IF (IsFCRA, Risk_Indicators.Boca_Shell_aircraft_Hist_FCRA (ids_only(~isrelat)),
					              Risk_Indicators.Boca_Shell_aircraft      (ids_only/*(~isrelat)*/) );
	aircraft_rolled := if (production_realtime_mode, aircraft, aircraft_hist);

  aircraft_rolled_indv := aircraft_rolled(~isrelat);
	aircraft_rolled_relat :=  aircraft_rolled(isrelat);
	
	
	// =============== AVM ===============
	avm_rolled := IF (IsFCRA,
												Risk_Indicators.Boca_Shell_AVM_FCRA (ids_wide(~isrelat)),
												Risk_Indicators.Boca_Shell_AVM      (ids_wide(~isrelat)));
								
								
	//=========== Gong ============
	gong_rolled := IF (IsFCRA,
												Risk_Indicators.Boca_Shell_Gong_FCRA (ids_wide(~isrelat)),
												Risk_Indicators.Boca_Shell_Gong			 (ids_wide(~isrelat)));
												
												
	// ============ Infutor =============
	infutor_rolled := IF(IsFCRA,
													Risk_Indicators.Boca_Shell_Infutor_FCRA (ids_wide(~isrelat)),
													Risk_Indicators.Boca_Shell_Infutor      (ids_wide(~isrelat)));
													
													
	// =========== Impulse ==============
	impulse_rolled := IF(IsFCRA,
													Risk_Indicators.Boca_Shell_Impulse_FCRA (ids_wide(~isrelat), bsversion, isDirectToConsumerPurpose),
													Risk_indicators.Boca_Shell_Impulse      (ids_wide(~isrelat), bsversion));
																						



													

// get AML info


// iid_getSSNFlags was located prior to rolled_header. When entering a 4 byte ssn, flags were being set before the ssn was fixed.   Layout_output

unique_dids := ungroup(dedup(sort(project(ids_only,transform(doxie.layout_references,self:=left)), did), did));
	
// get best ssn from same function we use in the collection shell  just relatives
bestSSN := risk_indicators.collection_shell_mod.getBestCleaned(unique_dids, 
																																		DataRestriction, 
																																		glb, 
																																		clean_address:=false); // don't need clean address, just the best SSN
																																		
Risk_indicators.layout_output prep_ssnflags(bestSSN le, pre_ids_only ri) := TRANSFORM
  self.seq := ri.seq;
	
	self.historydate := 999999; 
	self.DID := ri.did;  	
	self.score := 0; 
	self.title := '';
	self.fname := le.fname;
	self.mname := le.mname;
	self.lname  := le.lname;
	self.suffix := le.name_suffix;
	self.in_streetAddress := le.street_addr;
	self.in_city  := le.city_name;
	self.in_state := le.st;
	self.in_zipCode := le.zip;
	self.prim_range := le.prim_range;
	self.predir  := le.predir;
	self.prim_name  := le.prim_name;
	self.addr_suffix := le.suffix;
	self.postdir   := le.postdir;
	self.unit_desig  := le.unit_desig;
	self.sec_range   := le.sec_range;
	self.p_city_name := le.city_name;
	self.st           := le.st;
	self.z5           := le.zip;
	self.zip4         := le.zip4;
	self.lat := '';
	self.long := '';
	self.county := ri.county;
	self.geo_blk := ri.geo_blk;
	
	self.addr_type      := le.addr_type;
	self.addr_status     := le.addr_status;
	
	self.ssn  := le.ssn;
	self.dob  := (string)le.dob;
	self.phone10 := le.phone;
  self := [];
END;
  
bestSSNsd := dedup(sort(bestSSN, seq,did), seq,did);


ssnFlagsPrep := group(join(bestSSNsd, pre_ids_only, left.did=right.did, 
	                     prep_ssnflags(left, right)), seq);
	
ExactMatchLevel:=risk_indicators.iid_constants.default_ExactMatchLevel;

//aml  just ids with ssn flags																																	
withSSNFlags := Risk_Indicators.iid_getSSNFlags(ssnFlagsPrep, dppa, glb, isFCRA, false/*runSSNCodes*/, ExactMatchLevel, DataRestriction, BSversion, BSOptions, DataPermission );	

//todo withSSNFlags need again for relatives 
layout_bocashell_neutral add_ssnFlags(	withSSNFlags le, pre_ids_only ri) := TRANSFORM
  self.AMLParentNonUsSSN := if(Risk_Indicators.rcSet.isCode85(le.ssn, le.socllowissue) and stringlib.stringtolowercase(ri.relation) in ['father','mother'], 1, 0);
	self.AMLSocsRCISflag := le.socsRCISflag;
	self.AMLSocllowissue := le.socllowissue;
	self.AMLsocsvalflag  := le.socsvalflag;
	self.AMLSSN          := le.ssn;
	self := ri;
	self := le;
END;


  
//just relatives
ids_full_ssn := join(	withSSNFlags, pre_ids_only, left.seq=right.seq and left.did=right.did,
											add_ssnFlags(left,right));
											
//AML position title   all ids

relatEmpl :=  AML.AMLEmployment(pre_ids_only);

//AML  degree
relatStudent := AML.AMLStudent(ids_only);
//  AML professional license
relatProfLic :=  AML.AMLProfLicense(ids_only);


RelatInput :=  join(ssnFlagsPrep, pre_ids_only,
										left.seq = right.seq and
										left.did = right.did,
										transform(AML.Layouts.RelativeInLayout, 
															self.seq := left.seq,
															self.did := left.did,
															self.relation := right.relation,
															self.fname  := left.fname,
															self.lname := left.lname,
															self.historydate := right.historydate,
															self.isrelat := right.isrelat,
														  self.prim_range := left.prim_range;
															self.predir  := left.predir;
															self.prim_name  := left.prim_name;
															self.addr_suffix := left.suffix;
															self.postdir   := left.postdir;
															self.unit_desig  := left.unit_desig;
															self.sec_range   := left.sec_range;
															self.p_city_name := left.p_city_name;
															self.st           := left.st;
															self.z5           := left.z5;
															self := []));

// AML  address attributes
relatAddr  := AML.AMLAddrAttrib(ssnFlagsPrep);


//  AML  header info
relatHeader :=  AML.AMLGetHeader(group(RelatInput,seq), dppa, glb, isFCRA, DataRestriction);

//AML   relates parents

RelatInfo :=  join(withSSNFlags, pre_ids_only(isrelat),
										left.seq = right.seq and
										left.did = right.did,
										transform(AML.Layouts.RelativeParentLayout, 
															self.seq := left.seq,
															self.did := right.shell_input.did,
															self.relatDid := left.did,
															self.fname  := left.fname,
															self.lname := left.lname,
															self.historydate := right.historydate,
															self.isrelat := right.isrelat,
															self.RelatParentPubRec10yrs := 0;
															self := []));
								
relatParentPubRec := AML.AMLRelativesAssocs(group(RelatInfo, seq), dppa, glb, isFCRA,  DataRestriction);



  // =============== Relative Aggregates ===============
  relrec := layout_bocashell_neutral_ids;

  cntrelrec := TABLE(ids_only(isrelat), {seq, cnt := COUNT(GROUP)}, seq);

  relrec join_relat(p le, ids_full ri) := TRANSFORM
    SELF.dist := ut.zip_Dist(le.Address_Verification.Input_Address_Information.zip5,ri.zip5);
    SELF.relative_within25miles_count := (INTEGER)(SELF.dist < 25);
    SELF.relative_within100miles_count := (INTEGER)(SELF.dist BETWEEN 25 AND 100 AND SELF.dist<>100);
    SELF.relative_within500miles_count := (INTEGER)(SELF.dist BETWEEN 100 AND 500 AND SELF.dist<>500);
    SELF.relative_withinOther_count := (INTEGER)(SELF.dist >= 500);
    SELF.relat_did := ri.did;		
    SELF := ri;
  END;

  relat_joined := JOIN(p, ids_full(isrelat),LEFT.seq=RIGHT.seq, join_relat(LEFT,RIGHT), MANY LOOKUP);
  relat_sorted := DEDUP(SORT(relat_joined,seq,relat_did,dist,-relatives_at_input_address),seq,relat_did);
	// get a table of the counts per relat_did to get rid of indeterminate results in the relative counters that aren't tied to distance
	relative_snapshot_table := table(relat_joined, 
		{seq, relat_did, 
		_relatives_at_input_address := count(group, relatives_at_input_address > 0),
		_relative_suspicious_identities_count := if(count(group, relative_suspicious_identities_count > 0) > 0, 1, 0),
		_relative_bureau_only_count := if(count(group, relative_bureau_only_count > 0) > 0, 1, 0),
		_relative_bureau_only_count_created_1month := if(count(group, relative_bureau_only_count_created_1month > 0) > 0, 1, 0),
		_relative_bureau_only_count_created_6months := if(count(group, relative_bureau_only_count_created_6months > 0) > 0, 1, 0),
	}, seq, relat_did);


relat_sorted2 := join(relat_sorted, relative_snapshot_table, left.seq=right.seq and left.relat_did=right.relat_did,
	transform(relrec,
	SELF.relatives_at_input_address := right._relatives_at_input_address;
	SELF.relative_suspicious_identities_count := right._relative_suspicious_identities_count;
	SELF.relative_bureau_only_count := right._relative_bureau_only_count;
	SELF.relative_bureau_only_count_created_1month := right._relative_bureau_only_count_created_1month;
	SELF.relative_bureau_only_count_created_6months := right._relative_bureau_only_count_created_6months;
	self := left));
	
	
relrec roll_relat(relrec le, relrec ri) := TRANSFORM
	SELF.relative_within25miles_count := le.relative_within25miles_count + ri.relative_within25miles_count;
	SELF.relative_within100miles_count := le.relative_within100miles_count + ri.relative_within100miles_count;
	SELF.relative_within500miles_count := le.relative_within500miles_count + ri.relative_within500miles_count;
	SELF.relative_withinOther_count := le.relative_withinOther_count + ri.relative_withinOther_count;

	SELF.relative_incomeUnder25_count := le.relative_incomeUnder25_count + ri.relative_incomeUnder25_count;
	SELF.relative_incomeUnder50_count := le.relative_incomeUnder50_count + ri.relative_incomeUnder50_count;
	SELF.relative_incomeUnder75_count := le.relative_incomeUnder75_count + ri.relative_incomeUnder75_count;
	SELF.relative_incomeUnder100_count := le.relative_incomeUnder100_count + ri.relative_incomeUnder100_count;
	SELF.relative_incomeOver100_count := le.relative_incomeOver100_count + ri.relative_incomeOver100_count;
	
	SELF.relative_homeUnder50_count := le.relative_homeUnder50_count + ri.relative_homeUnder50_count;
	SELF.relative_homeUnder100_count := le.relative_homeUnder100_count + ri.relative_homeUnder100_count;
	SELF.relative_homeUnder150_count := le.relative_homeUnder150_count + ri.relative_homeUnder150_count;
	SELF.relative_homeUnder200_count := le.relative_homeUnder200_count + ri.relative_homeUnder200_count;
	SELF.relative_homeUnder300_count := le.relative_homeUnder300_count + ri.relative_homeUnder300_count;
	SELF.relative_homeUnder500_count := le.relative_homeUnder500_count + ri.relative_homeUnder500_count;
	SELF.relative_homeOver500_count := le.relative_homeOver500_count + ri.relative_homeOver500_count;
	
	SELF.relative_educationUnder8_count := le.relative_educationUnder8_count + ri.relative_educationUnder8_count;
	SELF.relative_educationUnder12_count := le.relative_educationUnder12_count + ri.relative_educationUnder12_count;
	SELF.relative_educationOver12_count := le.relative_educationOver12_count + ri.relative_educationOver12_count;
	
	SELF.relative_ageUnder20_count := le.relative_ageUnder20_count + ri.relative_ageUnder20_count;
	SELF.relative_ageUnder30_count := le.relative_ageUnder30_count + ri.relative_ageUnder30_count;
	SELF.relative_ageUnder40_count := le.relative_ageUnder40_count + ri.relative_ageUnder40_count;
	SELF.relative_ageUnder50_count := le.relative_ageUnder50_count + ri.relative_ageUnder50_count;
	SELF.relative_ageUnder60_count := le.relative_ageUnder60_count + ri.relative_ageUnder60_count;
	SELF.relative_ageUnder70_count := le.relative_ageUnder70_count + ri.relative_ageUnder70_count;
	SELF.relative_ageOver70_count := le.relative_ageOver70_count + ri.relative_ageOver70_count;
	
	SELF.relatives_at_input_address := le.relatives_at_input_address + ri.relatives_at_input_address;
	
	SELF.relative_suspicious_identities_count := le.relative_suspicious_identities_count + ri.relative_suspicious_identities_count;
	SELF.relative_bureau_only_count := le.relative_bureau_only_count + ri.relative_bureau_only_count;
	SELF.relative_bureau_only_count_created_1month := le.relative_bureau_only_count_created_1month + ri.relative_bureau_only_count_created_1month;
	SELF.relative_bureau_only_count_created_6months := le.relative_bureau_only_count_created_6months + ri.relative_bureau_only_count_created_6months;
		SELF := le;
	END;
	

	
relatives_grouped := group(relat_sorted2, seq);	
relat_rolled := ROLLUP(relatives_grouped,left.seq=right.seq,roll_relat(LEFT,RIGHT));

// =============== put it together ===============

dl_added_back := History_2_Property_Added;

risk_indicators.Layout_Boca_Shell add_back_vehicles(risk_indicators.Layout_Boca_Shell le, vehicles_rolled ri) :=
TRANSFORM
	SELF.Vehicles := PROJECT(ri,TRANSFORM(Layout_Vehicles.Vehicle_Set,SELF := LEFT));
	
	SELF.relatives.relative_vehicle_owned_count := ri.relative_owned_count;	// this field needs both relatives and derogs turned on
	
	SELF := le;
END;
vehicles_added_back := IF(IncludeVehInfo and ~isFCRA,
                          JOIN(dl_added_back, vehicles_rolled, 
                               LEFT.seq=RIGHT.seq, 
                               add_back_vehicles(LEFT,RIGHT), LEFT OUTER, MANY LOOKUP, PARALLEL),
                          dl_added_back);

bsplus := record
	risk_indicators.layout_boca_shell;
	boolean	bjl_populated;
	boolean isDID2;
	boolean isDID3;
end;

// get zipcode for relative
layout_addzip := record
	recordof(doc_rolled);
	STRING5 zip5;
END;
	
layout_addzip add_crim_rels(doc_rolled le, ids_full ri) := transform
	self.zip5 := ri.zip5;
	self := le;
END;

derogs_w_rel_crims := dedup(JOIN(doc_rolled, ids_full(isrelat), 
	left.did=right.did, add_crim_rels(LEFT,RIGHT), LEFT OUTER, MANY LOOKUP, PARALLEL), did);

bsplus add_back_derogs(Layout_Boca_Shell le, derogs_w_rel_crims ri) := TRANSFORM
	crim_dist := if(le.shell_input.z5<>'' and ri.zip5<>'', ut.zip_Dist(le.shell_input.z5,ri.zip5), 9999);//default to 9999 for at least 1 blank zip
	self.Relatives.criminal_relative_within25miles := (INTEGER)(crim_dist < 25 and ri.BJL.criminal_count>0 and ri.isrelat);
  SELF.Relatives.criminal_relative_within100miles := (INTEGER)(crim_dist BETWEEN 25 AND 100 AND crim_dist<>100 and ri.BJL.criminal_count>0 and ri.isrelat);
  SELF.Relatives.criminal_relative_within500miles := (INTEGER)(crim_dist BETWEEN 100 AND 500 AND crim_dist<>500 and ri.BJL.criminal_count>0 and ri.isrelat);
  SELF.Relatives.criminal_relative_withinOther := (INTEGER)(crim_dist >= 500 and ri.BJL.criminal_count>0 and ri.isrelat);
	
	// check for not relative and did is main did for multiple did situations
	mainDid := if(BSversion>2, ~ri.isrelat and le.did=ri.did, ~ri.isrelat);	// not sure a difference but making sure old versions work as they were
	SELF.BJL := IF(mainDid,ri.BJL,le.BJL);
  self.bk_chapters := IF(mainDid,ri.bk_chapters,le.bk_chapters);
	self.bjl_populated := if (mainDid, true, false);
	SELF.Relatives.relative_bankrupt_count := (INTEGER)(ri.isrelat AND ri.BJL.bankrupt);
	SELF.Relatives.relative_criminal_count := (INTEGER)(ri.isrelat AND ri.BJL.criminal_count>0);
	SELF.Relatives.relative_criminal_total := IF(ri.isrelat, ri.BJL.criminal_count, 0);
	SELF.Relatives.relative_felony_count := (INTEGER)(ri.isrelat AND ri.BJL.felony_count>0);
	SELF.Relatives.relative_felony_total := IF(ri.isrelat, ri.BJL.felony_count, 0);
	
	// override the bansflag if needed here for isFCRA
	self.iid.bansflag := map(isFCRA and ri.BJL.filing_count > 0 => '1', 
													 isFCRA and le.iid.bansflag='1' and ri.BJL.filing_count < 1 => '0',
													 le.iid.bansflag);
													 
	self.liens := IF(mainDid,ri.liens,le.liens);		
	
	// populate did2 and did3 derog stuff here for boca shell 3
	isDID2 := ~ri.isrelat and le.iid.did2=ri.did and BSversion>2;
	self.isDID2 := isDID2;
	self.iid.did2_criminal_count := if(isDID2, ri.bjl.criminal_count, le.iid.did2_criminal_count);
	self.iid.did2_felony_count := if(isDID2, ri.bjl.felony_count, le.iid.did2_felony_count);
	self.iid.did2_liens_recent_unreleased_count := if(isDID2, ri.bjl.liens_recent_unreleased_count, le.iid.did2_liens_recent_unreleased_count);
	self.iid.did2_liens_historical_unreleased_count := if(isDID2, ri.bjl.liens_historical_unreleased_count, le.iid.did2_liens_historical_unreleased_count);
	self.iid.did2_liens_recent_released_count := if(isDID2, ri.bjl.liens_recent_released_count, le.iid.did2_liens_recent_released_count);
	self.iid.did2_liens_historical_released_count := if(isDID2, ri.bjl.liens_historical_released_count, le.iid.did2_liens_historical_released_count);
	
	isDID3 := ~ri.isrelat and le.iid.did3=ri.did and BSversion>2;
	self.isDID3 := isDID3;
	self.iid.did3_criminal_count := if(isDID3, ri.bjl.criminal_count, le.iid.did3_criminal_count);
	self.iid.did3_felony_count := if(isDID3, ri.bjl.felony_count, le.iid.did3_felony_count);
	self.iid.did3_liens_recent_unreleased_count := if(isDID3, ri.bjl.liens_recent_unreleased_count, le.iid.did3_liens_recent_unreleased_count);
	self.iid.did3_liens_historical_unreleased_count := if(isDID3, ri.bjl.liens_historical_unreleased_count, le.iid.did3_liens_historical_unreleased_count);
	self.iid.did3_liens_recent_released_count := if(isDID3, ri.bjl.liens_recent_released_count, le.iid.did3_liens_recent_released_count);
	self.iid.did3_liens_historical_released_count := if(isDID3, ri.bjl.liens_historical_released_count, le.iid.did3_liens_historical_released_count);
	
	total_number_derogs_50 := if(mainDID, ri.bjl.criminal_count+ri.bjl.filing_count+ri.bjl.liens_historical_unreleased_count+ri.bjl.liens_recent_unreleased_count+ri.bjl.eviction_count,
																			 le.total_number_derogs);	
	total_number_derogs_original := if(mainDID, ri.bjl.criminal_count+ri.bjl.filing_count+ri.bjl.liens_historical_unreleased_count+ri.bjl.liens_recent_unreleased_count,
																			 le.total_number_derogs);
	// for bocashell version 5.0 and higher, include the eviction count as well because evictions will no longer be part of the liens counts in 5.0 and higher 																		 
	self.total_number_derogs := if(BSversion>=50, total_number_derogs_50, total_number_derogs_original);
	self.LnJ_datasets.LnJLiens := IF(mainDid,ri.LnJLiens, dataset([], Risk_Indicators.Layouts_Derog_Info.Liens));
	self.LnJ_datasets.LnJJudgments := IF(mainDid, ri.LnJJudgments,  dataset([], Risk_Indicators.Layouts_Derog_Info.Judgments));
	SELF.LnJ_attributes.lnj_recent_unreleased_count              := IF(mainDid, RI.lnj_recent_unreleased_count          ,0   );
	SELF.LnJ_attributes.lnj_historical_unreleased_count          := IF(mainDid, RI.lnj_historical_unreleased_count      ,0   );
	SELF.LnJ_attributes.lnj_unreleased_count12                   := IF(mainDid, RI.lnj_unreleased_count12               ,0   );
	SELF.LnJ_attributes.lnj_recent_released_count                := IF(mainDid, RI.lnj_recent_released_count            ,0   );
	SELF.LnJ_attributes.lnj_historical_released_count            := IF(mainDid, RI.lnj_historical_released_count        ,0   );
	SELF.LnJ_attributes.lnj_released_count12                     := IF(mainDid, RI.lnj_released_count12                 ,0   );
	SELF.LnJ_attributes.lnj_last_unreleased_date                 := IF(mainDid, RI.lnj_last_unreleased_date             ,''   );
	SELF.LnJ_attributes.lnj_last_released_date                   := IF(mainDid, RI.lnj_last_released_date               ,0   );
	SELF.LnJ_attributes.lnj_eviction_count                       := IF(mainDid, RI.lnj_eviction_count                   ,0   );
	SELF.LnJ_attributes.lnj_eviction_count12                     := IF(mainDid, RI.lnj_eviction_count12                 ,0   );
	SELF.LnJ_attributes.lnj_last_eviction_date                   := IF(mainDid, RI.lnj_last_eviction_date               ,0   );
	SELF.LnJ_attributes.lnj_eviction_recent_unreleased_count     := IF(mainDid, RI.lnj_eviction_recent_unreleased_count ,0   );
	SELF.LnJ_attributes.lnj_eviction_historical_unreleased_count := IF(mainDid, RI.lnj_eviction_historical_unreleased_count,0);
	SELF.LnJ_attributes.lnj_eviction_recent_released_count       := IF(mainDid, RI.lnj_eviction_recent_released_count   ,0   ) ;
	SELF.LnJ_attributes.lnj_eviction_historical_released_count   := IF(mainDid, RI.lnj_eviction_historical_released_count,0  ) ;
	SELF.LnJ_attributes.lnj_unreleased_civil_judgment_cnt        := IF(mainDid, RI.lnj_unreleased_civil_judgment_cnt    ,0   ) ;
	SELF.LnJ_attributes.lnj_unreleased_civil_judgment_amt        := IF(mainDid, RI.lnj_unreleased_civil_judgment_amt    ,0   ) ;
	SELF.LnJ_attributes.lnj_released_civil_judgment_cnt          := IF(mainDid, RI.lnj_released_civil_judgment_cnt      ,0   ) ;
	SELF.LnJ_attributes.lnj_released_civil_judgment_amt          := IF(mainDid, RI.lnj_released_civil_judgment_amt      ,0   ) ;
	SELF.LnJ_attributes.lnj_unreleased_federal_tax_cnt           := IF(mainDid, RI.lnj_unreleased_federal_tax_cnt       ,0   ) ;
	SELF.LnJ_attributes.lnj_unreleased_federal_tax_amt           := IF(mainDid, RI.lnj_unreleased_federal_tax_amt       ,0   ) ;
	SELF.LnJ_attributes.lnj_released_federal_tax_cnt             := IF(mainDid, RI.lnj_released_federal_tax_cnt         ,0   ) ;
	SELF.LnJ_attributes.lnj_released_federal_tax_amt             := IF(mainDid, RI.lnj_released_federal_tax_amt         ,0   ) ;
	SELF.LnJ_attributes.lnj_unreleased_foreclosure_cnt           := IF(mainDid, RI.lnj_unreleased_foreclosure_cnt       ,0   ) ;
	SELF.LnJ_attributes.lnj_unreleased_foreclosure_amt           := IF(mainDid, RI.lnj_unreleased_foreclosure_amt       ,0   ) ;
	SELF.LnJ_attributes.lnj_released_foreclosure_cnt             := IF(mainDid, RI.lnj_released_foreclosure_cnt         ,0   ) ;
	SELF.LnJ_attributes.lnj_released_foreclosure_amt             := IF(mainDid, RI.lnj_released_foreclosure_amt         ,0   ) ;
	SELF.LnJ_attributes.lnj_unreleased_landlord_tenant_cnt       := IF(mainDid, RI.lnj_unreleased_landlord_tenant_cnt   ,0   ) ;
	SELF.LnJ_attributes.lnj_unreleased_landlord_tenant_amt       := IF(mainDid, RI.lnj_unreleased_landlord_tenant_amt   ,0   ) ;
	SELF.LnJ_attributes.lnj_released_landlord_tenant_cnt         := IF(mainDid, RI.lnj_released_landlord_tenant_cnt     ,0   ) ;
	SELF.LnJ_attributes.lnj_released_landlord_tenant_amt         := IF(mainDid, RI.lnj_released_landlord_tenant_amt     ,0   ) ;
	SELF.LnJ_attributes.lnj_unreleased_lispendens_cnt            := IF(mainDid, RI.lnj_unreleased_lispendens_cnt        ,0   ) ;
	// SELF.LnJ_attributes.lnj_unreleased_lispendens_amt            := IF(mainDid, RI.lnj_unreleased_lispendens_amt        ,0   ) ;
	SELF.LnJ_attributes.lnj_released_lispendens_cnt              := IF(mainDid, RI.lnj_released_lispendens_cnt          ,0   ) ;
	// SELF.LnJ_attributes.lnj_released_lispendens_amt              := IF(mainDid, RI.lnj_released_lispendens_amt          ,0   ) ;
	SELF.LnJ_attributes.lnj_unreleased_other_lj_cnt              := IF(mainDid, RI.lnj_unreleased_other_lj_cnt          ,0   ) ;
	SELF.LnJ_attributes.lnj_unreleased_other_lj_amt              := IF(mainDid, RI.lnj_unreleased_other_lj_amt          ,0   ) ;
	SELF.LnJ_attributes.lnj_released_other_lj_cnt                := IF(mainDid, RI.lnj_released_other_lj_cnt            ,0   ) ;
	SELF.LnJ_attributes.lnj_released_other_lj_amt                := IF(mainDid, RI.lnj_released_other_lj_amt            ,0   ) ;
	SELF.LnJ_attributes.lnj_unreleased_other_tax_cnt             := IF(mainDid, RI.lnj_unreleased_other_tax_cnt         ,0   ) ;
	SELF.LnJ_attributes.lnj_unreleased_other_tax_amt             := IF(mainDid, RI.lnj_unreleased_other_tax_amt         ,0   ) ;
	SELF.LnJ_attributes.lnj_released_other_tax_cnt               := IF(mainDid, RI.lnj_released_other_tax_cnt           ,0   ) ;
	SELF.LnJ_attributes.lnj_released_other_tax_amt               := IF(mainDid, RI.lnj_released_other_tax_amt           ,0   ) ;
	SELF.LnJ_attributes.lnj_unreleased_small_claims_cnt          := IF(mainDid, RI.lnj_unreleased_small_claims_cnt      ,0   ) ;
	SELF.LnJ_attributes.lnj_unreleased_small_claims_amt          := IF(mainDid, RI.lnj_unreleased_small_claims_amt      ,0   ) ;
	SELF.LnJ_attributes.lnj_released_small_claims_cnt            := IF(mainDid, RI.lnj_released_small_claims_cnt        ,0   ) ;
	SELF.LnJ_attributes.lnj_released_small_claims_amt            := IF(mainDid, RI.lnj_released_small_claims_amt        ,0   ) ;
	// SELF.LnJ_attributes.lnj_unreleased_Mechanics_cnt             := IF(mainDid, RI.lnj_unreleased_Mechanics_cnt         ,0   ) ;
	// SELF.LnJ_attributes.lnj_unreleased_Mechanics_amt             := IF(mainDid, RI.lnj_unreleased_Mechanics_amt         ,0   ) ;
	// SELF.LnJ_attributes.lnj_released_Mechanics_cnt               := IF(mainDid, RI.lnj_released_Mechanics_cnt           ,0   ) ;
	// SELF.LnJ_attributes.lnj_released_Mechanics_amt               := IF(mainDid, RI.lnj_released_Mechanics_amt           ,0   ) ;
	SELF.LnJ_attributes.lnj_lien_cnt                             := IF(mainDid, RI.lnj_lien_cnt                         ,0   ) ;
	SELF.LnJ_attributes.lnj_lien_total                           := IF(mainDid, RI.lnj_lien_total                       ,0   ) ;
	SELF.LnJ_attributes.lnj_last_lien_unreleased_date            := IF(mainDid, RI.lnj_last_lien_unreleased_date        ,''   )  ;
	SELF.LnJ_attributes.lnj_last_lien_released_date              := IF(mainDid, RI.lnj_last_lien_released_date          ,0   ) ;
	SELF.LnJ_attributes.lnj_liens_unreleased_all_tax_cnt         := IF(mainDid, RI.lnj_liens_unreleased_all_tax_cnt     ,0   ) ;
	SELF.LnJ_attributes.lnj_liens_unreleased_all_tax_amt         := IF(mainDid, RI.lnj_liens_unreleased_all_tax_amt     ,0   ) ;
	SELF.LnJ_attributes.lnj_liens_released_all_tax_cnt           := IF(mainDid, RI.lnj_liens_released_all_tax_cnt       ,0   ) ;
	SELF.LnJ_attributes.lnj_liens_released_all_tax_amt           := IF(mainDid, RI.lnj_liens_released_all_tax_amt       ,0   ) ;
	SELF.LnJ_attributes.lnj_last_allTax_unreleased_date          := IF(mainDid, RI.lnj_last_allTax_unreleased_date      ,''   )  ;
	SELF.LnJ_attributes.lnj_last_allTax_released_date            := IF(mainDid, RI.lnj_last_allTax_released_date        ,0   ) ;
	SELF.LnJ_attributes.lnj_liens_unreleased_state_tax_cnt       := IF(mainDid, RI.lnj_liens_unreleased_state_tax_cnt   ,0   ) ;
	SELF.LnJ_attributes.lnj_liens_unreleased_state_tax_amt       := IF(mainDid, RI.lnj_liens_unreleased_state_tax_amt   ,0   ) ;
	SELF.LnJ_attributes.lnj_liens_released_state_tax_cnt         := IF(mainDid, RI.lnj_liens_released_state_tax_cnt     ,0   ) ;
	SELF.LnJ_attributes.lnj_liens_released_state_tax_amt         := IF(mainDid, RI.lnj_liens_released_state_tax_amt     ,0   ) ;
	SELF.LnJ_attributes.lnj_last_state_unreleased_date           := IF(mainDid, RI.lnj_last_state_unreleased_date       ,''   )  ;
	SELF.LnJ_attributes.lnj_last_state_released_date             := IF(mainDid, RI.lnj_last_state_released_date         ,0   ) ;
	SELF.LnJ_attributes.lnj_liens_unreleased_federal_tax_cnt     := IF(mainDid, RI.lnj_liens_unreleased_federal_tax_cnt ,0   ) ;
	SELF.LnJ_attributes.lnj_liens_unreleased_federal_tax_amt     := IF(mainDid, RI.lnj_liens_unreleased_federal_tax_amt ,0   ) ;
	SELF.LnJ_attributes.lnj_liens_released_federal_tax_cnt       := IF(mainDid, RI.lnj_liens_released_federal_tax_cnt   ,0   ) ;
	SELF.LnJ_attributes.lnj_liens_released_federal_tax_amt       := IF(mainDid, RI.lnj_liens_released_federal_tax_amt   ,0   ) ;
	SELF.LnJ_attributes.lnj_last_federal_unreleased_date         := IF(mainDid, RI.lnj_last_federal_unreleased_date     ,''   )  ;
	SELF.LnJ_attributes.lnj_last_federal_released_date		     	 := IF(mainDid, RI.lnj_last_federal_released_date		,0   )   ;
	SELF.LnJ_attributes.lnj_jgmt_cnt	                           := IF(mainDid, RI.lnj_jgmt_cnt	                        ,0  );
	SELF.LnJ_attributes.lnj_last_jgmt_unreleased_date            := IF(mainDid, RI.lnj_last_jgmt_unreleased_date        ,''   )  ;
	SELF.LnJ_attributes.lnj_last_jgmt_released_date              := IF(mainDid, RI.lnj_last_jgmt_released_date          ,0   ) ;
	SELF.LnJ_attributes.lnj_jgmt_total                           := IF(mainDid, RI.lnj_jgmt_total                       ,0   ) ;
	//self.LnJ := ri;
	SELF := le;
END;

derogs_added_back_roxie := JOIN(vehicles_added_back, derogs_w_rel_crims, LEFT.seq=RIGHT.seq, add_back_derogs(LEFT,RIGHT), LEFT OUTER, MANY LOOKUP);
derogs_added_back_thor := JOIN(distribute(vehicles_added_back, hash64(seq)), 
															 distribute(derogs_w_rel_crims, hash64(seq)), 
															 LEFT.seq=RIGHT.seq, 
															 add_back_derogs(LEFT,RIGHT), LEFT OUTER, LOCAL);

#IF(onThor)
	derogs_added_back := group(sort(derogs_added_back_thor, seq, local), seq, local);
#ELSE
	derogs_added_back := derogs_added_back_roxie;
#END

bsplus roll_relatives(bsplus le, bsplus ri) := TRANSFORM
	SELF.Relatives.relative_bankrupt_count := le.Relatives.relative_bankrupt_count+ri.Relatives.relative_bankrupt_count;
	unsigned relative_crim_total := le.Relatives.relative_criminal_total+ri.Relatives.relative_criminal_total;
	SELF.Relatives.relative_criminal_total := if(relative_crim_total > 255, 255, relative_crim_total);
	SELF.Relatives.relative_criminal_count := le.Relatives.relative_criminal_count+ri.Relatives.relative_criminal_count;
	SELF.Relatives.relative_felony_total := le.Relatives.relative_felony_total+ri.Relatives.relative_felony_total;
	SELF.Relatives.relative_felony_count := le.Relatives.relative_felony_count+ri.Relatives.relative_felony_count;
	SELF.Relatives.criminal_relative_within25miles := le.Relatives.criminal_relative_within25miles + ri.Relatives.criminal_relative_within25miles;
	SELF.Relatives.criminal_relative_within100miles := le.Relatives.criminal_relative_within100miles + ri.Relatives.criminal_relative_within100miles;
	SELF.Relatives.criminal_relative_within500miles := le.Relatives.criminal_relative_within500miles + ri.Relatives.criminal_relative_within500miles;
	SELF.Relatives.criminal_relative_withinother := le.Relatives.criminal_relative_withinother + ri.Relatives.criminal_relative_withinother;
	SELF.BJL := if (le.BJL_populated, le.bjl, ri.BJL);
	self.bjl_populated := if (le.bjl_populated, true, ri.bjl_populated);
	self.liens := if(le.bjl_populated, le.liens, ri.liens);	
	
	// multiple ADL stuff for bocashell 3
	self.isDID2 := if(le.isDID2, true, ri.isDID2);
	self.iid.did2_criminal_count := if(le.isDID2, le.iid.did2_criminal_count, ri.iid.did2_criminal_count);
	self.iid.did2_felony_count := if(le.isDID2, le.iid.did2_felony_count, ri.iid.did2_felony_count);
	self.iid.did2_liens_recent_unreleased_count := if(le.isDID2, le.iid.did2_liens_recent_unreleased_count, ri.iid.did2_liens_recent_unreleased_count);
	self.iid.did2_liens_historical_unreleased_count := if(le.isDID2, le.iid.did2_liens_historical_unreleased_count, ri.iid.did2_liens_historical_unreleased_count);
	self.iid.did2_liens_recent_released_count := if(le.isDID2, le.iid.did2_liens_recent_released_count, ri.iid.did2_liens_recent_released_count);
	self.iid.did2_liens_historical_released_count := if(le.isDID2, le.iid.did2_liens_historical_released_count, ri.iid.did2_liens_historical_released_count);
	
	self.isDID3 := if(le.isDID3, true, ri.isDID3);
	self.iid.did3_criminal_count := if(le.isDID3, le.iid.did3_criminal_count, ri.iid.did3_criminal_count);
	self.iid.did3_felony_count := if(le.isDID3, le.iid.did3_felony_count, ri.iid.did3_felony_count);
	self.iid.did3_liens_recent_unreleased_count := if(le.isDID3, le.iid.did3_liens_recent_unreleased_count, ri.iid.did3_liens_recent_unreleased_count);
	self.iid.did3_liens_historical_unreleased_count := if(le.isDID3, le.iid.did3_liens_historical_unreleased_count, ri.iid.did3_liens_historical_unreleased_count);
	self.iid.did3_liens_recent_released_count := if(le.isDID3, le.iid.did3_liens_recent_released_count, ri.iid.did3_liens_recent_released_count);
	self.iid.did3_liens_historical_released_count := if(le.isDID3, le.iid.did3_liens_historical_released_count, ri.iid.did3_liens_historical_released_count);
	
	self.total_number_derogs := if(le.bjl_populated, le.total_number_derogs, ri.total_number_derogs);
	
	date_last_derog := if(le.bjl_populated, MAX(MAX(le.bjl.last_criminal_date, (integer)le.bjl.last_liens_unreleased_date),le.bjl.date_last_seen), 0);
	self.date_last_derog := date_last_derog;
	
	SELF := le;
END;

relat_derogs_rolled := IF (includeDerogInfo,
                           project(ROLLUP(SORT(derogs_added_back, seq, -bjl_populated, did),
                                          roll_relatives(LEFT,RIGHT),seq), 
                                   transform(risk_indicators.layout_boca_shell, self := left)),
                           vehicles_added_back);

risk_indicators.Layout_Relatives combine_relatives
 (relrec le, unsigned1 bk_count, unsigned1 crim_count, unsigned1 crim_total, unsigned within25, unsigned within100,
							unsigned within500, unsigned withinother, unsigned rel_veh_count, unsigned felony_count, unsigned felony_total) := TRANSFORM
	SELF.relative_bankrupt_count := bk_count;
	SELF.relative_criminal_count := crim_count;
	SELF.relative_criminal_total := crim_total;
	SELF.relative_felony_count := felony_count;
	SELF.relative_felony_total := felony_total;

	SELF.criminal_relative_within25miles := within25;
	SELF.criminal_relative_within100miles := within100;
	SELF.criminal_relative_within500miles := within500;
	SELF.criminal_relative_withinother := withinother;
	
	SELF.relative_vehicle_owned_count := rel_veh_count;
	
	SELF := le;
END;
risk_indicators.Layout_Boca_Shell add_relat(risk_indicators.Layout_Boca_Shell le, relrec ri) := TRANSFORM
	SELF.Relatives := PROJECT (ri, combine_relatives (ri, le.Relatives.relative_bankrupt_count,
																												le.Relatives.relative_criminal_count,
																												le.Relatives.relative_criminal_total,
																												le.Relatives.criminal_relative_within25miles,
																												le.Relatives.criminal_relative_within100miles,
																												le.Relatives.criminal_relative_within500miles,
																												le.Relatives.criminal_relative_withinother,
																												le.Relatives.relative_vehicle_owned_count,
																												le.Relatives.relative_felony_count,
																												le.Relatives.relative_felony_total));
	SELF := le;
END;

relat_added := IF(includeRelativeInfo,
									JOIN(relat_derogs_rolled, relat_rolled, LEFT.seq=RIGHT.seq, add_relat(LEFT,RIGHT), LEFT OUTER, MANY LOOKUP, PARALLEL),
									relat_derogs_rolled);

risk_indicators.Layout_Boca_Shell add_relat_count(risk_indicators.Layout_Boca_Shell le, cntrelrec ri) := TRANSFORM
	SELF.Relatives.relative_count := ri.cnt;
	SELF := le;
END;

relat_count := IF(includeRelativeInfo,
									JOIN(relat_added, cntrelrec, LEFT.seq=RIGHT.seq, add_relat_count(LEFT,RIGHT), LEFT OUTER, MANY LOOKUP),
									relat_added);


risk_indicators.Layout_Boca_Shell add_relat_prop(risk_indicators.Layout_Boca_Shell le, Rel_Property_Rolled ri) := TRANSFORM
	SELF.Relatives.owned :=  ri.owned;
	SELF.Relatives.sold  := ri.sold;
	SELF.Relatives.ambiguous := ri.ambiguous;
	SELF := le;
END;
relat_prop := IF (includeRelativeInfo,
                  JOIN(relat_count, Rel_Property_Rolled, LEFT.seq=RIGHT.seq, add_relat_prop(LEFT,RIGHT), LEFT OUTER, MANY LOOKUP, PARALLEL),
                  relat_count);

//MS-158: added new business property count and assessed value fields for owned and sold properties.  Special value definitions:
//				-1 = DID not found
//				-2 = no properties found for input subject
//				-3 = no assessed value on property records found (this valid for the assessed value fields)

risk_indicators.Layout_Boca_Shell add_per_prop(risk_indicators.Layout_Boca_Shell le, Per_Property_Rolled ri) := TRANSFORM
	prop_hit														:= le.seq = ri.seq; //indicate if we got any property hits for this person
	SELF.Address_Verification.owned     := ri.owned;
	SELF.Address_Verification.sold      := ri.sold;
	SELF.Address_Verification.ambiguous := ri.ambiguous;
	SELF.Address_Verification.bus_owned.property_total 								:= map(le.DID = 0																			=>	-1,
																																					 ~prop_hit																			=>	-2,
																																																															ri.bus_owned.property_total);
	SELF.Address_Verification.bus_owned.property_owned_assessed_total := map(le.DID = 0																			=>	-1,
																																					 ~prop_hit																			=>	-2,
																																					 ri.bus_owned.property_owned_assessed_total = 0	=> 	-3,
																																																															ri.bus_owned.property_owned_assessed_total);
	SELF.Address_Verification.bus_owned.property_owned_assessed_count := map(le.DID = 0																			=>	-1,
																																					 ~prop_hit																			=>	-2,
																																																															ri.bus_owned.property_owned_assessed_count);
	SELF.Address_Verification.bus_sold.property_total 								:= map(le.DID = 0																			=>	-1,
																																					 ~prop_hit																			=>	-2,
																																																															ri.bus_sold.property_total);
	SELF.Address_Verification.bus_sold.property_owned_assessed_total 	:= map(le.DID = 0																			=>	-1,
																																					 ~prop_hit																			=>	-2,
																																					 ri.bus_sold.property_owned_assessed_total = 0	=> 	-3,
																																																															ri.bus_sold.property_owned_assessed_total);
	SELF.Address_Verification.bus_sold.property_owned_assessed_count 	:= map(le.DID = 0																			=>	-1,
																																					 ~prop_hit																			=>	-2,
																																																															ri.bus_sold.property_owned_assessed_count);
	SELF := le;
END;
per_prop := JOIN(relat_prop, Per_Property_Rolled, LEFT.seq=RIGHT.seq, add_per_prop(LEFT,RIGHT), LEFT OUTER, MANY LOOKUP);



// ================ Add Back Watercraft ================
risk_indicators.Layout_Boca_Shell add_back_watercraft(risk_indicators.Layout_Boca_Shell le, watercraft_rolled_indv ri) := TRANSFORM
                SELF.watercraft := PROJECT(ri,TRANSFORM(Riskwise.Layouts.Layout_Watercraft, SELF := LEFT));  
								self.watercraft_build_date := ri.watercraft_build_date;
                SELF := le;
END;

watercraft_added_back := if(BSversion>1, JOIN(per_prop, watercraft_rolled_indv, 
																							LEFT.seq=RIGHT.seq, 
																							add_back_watercraft(LEFT,RIGHT), LEFT OUTER, MANY LOOKUP, PARALLEL),
																				 per_prop);


// ================ Add Back Professional License ================
risk_indicators.Layout_Boca_Shell add_back_proflic(risk_indicators.Layout_Boca_Shell le, proflic_rolled ri) := TRANSFORM
	SELF.professional_license := PROJECT(ri,TRANSFORM(Riskwise.Layouts.Layout_Professional_License, SELF := LEFT));	
	self.proflic_build_date := ri.proflic_build_date;
	SELF := le;
END;
proflic_added_back := if(BSversion>1, JOIN(watercraft_added_back, proflic_rolled, 
																					 LEFT.seq=RIGHT.seq, 
																					 add_back_proflic(LEFT,RIGHT), LEFT OUTER, MANY LOOKUP, PARALLEL),
																			watercraft_added_back);
		
		
// ================ Add Back Student ================																		
risk_indicators.Layout_Boca_Shell add_back_student(risk_indicators.Layout_Boca_Shell le, student_rolled ri) := TRANSFORM
	SELF.student := PROJECT(ri,TRANSFORM(Riskwise.Layouts.Layout_American_Student, SELF := LEFT.student));	
	SELF := le;
END;
student_added_back := if(BSversion>1, JOIN(proflic_added_back, student_rolled, 
																					 LEFT.seq=RIGHT.seq, 
																					 add_back_student(LEFT,RIGHT), LEFT OUTER, MANY LOOKUP, PARALLEL),
																			proflic_added_back);
		
		
// ================ Add Back Aircraft ================															 
risk_indicators.Layout_Boca_Shell add_back_aircraft(risk_indicators.Layout_Boca_Shell le, aircraft_rolled_indv ri) := TRANSFORM
                SELF.aircraft := PROJECT(ri,TRANSFORM(Riskwise.Layouts.Layout_Aircraft, SELF := LEFT)); 
								self.aircraft_build_date := ri.aircraft_build_date; 
                SELF := le;
END;

aircraft_added_back := if(BSversion>1, JOIN(student_added_back, aircraft_rolled_indv, 
																												LEFT.seq=RIGHT.seq, 
																												add_back_aircraft(LEFT,RIGHT), LEFT OUTER, MANY LOOKUP, PARALLEL),
																									student_added_back);


// ================ Add Back AVM ================															 
risk_indicators.Layout_Boca_Shell add_back_avm(risk_indicators.Layout_Boca_Shell le, avm_rolled ri) := TRANSFORM
	SELF.AVM := PROJECT(ri,TRANSFORM(Riskwise.Layouts.Layout_AVM, SELF := LEFT));	
	SELF := le;
END;
avm_added_back := if(BSversion>1, JOIN(aircraft_added_back, avm_rolled, 
																								LEFT.seq=RIGHT.seq, 
																								add_back_avm(LEFT,RIGHT), LEFT OUTER, MANY LOOKUP, PARALLEL),
																				aircraft_added_back);
																				
																				
// ============== Add Back Gong ================
risk_indicators.Layout_Boca_Shell add_back_gong(risk_indicators.Layout_Boca_Shell le, gong_rolled ri) := TRANSFORM
	SELF.phone_verification.gong_did := PROJECT(ri,TRANSFORM(Risk_Indicators.Layouts.Layout_Gong_DID, SELF := LEFT.gong_did));
	SELF.Velocity_Counters.invalid_phones_per_adl := ri.invalid_phones_per_adl;
	SELF.Velocity_Counters.invalid_phones_per_adl_created_6months := ri.invalid_phones_per_adl_created_6months;
	self.header_summary.phones_on_file := ri.phones_on_file;
	SELF := le;
END;
gong_added_back := IF(BSversion>2, JOIN(avm_added_back, gong_rolled,
																						LEFT.seq=RIGHT.seq,
																						add_back_gong(LEFT,RIGHT), LEFT OUTER, LOOKUP, PARALLEL),
																		avm_added_back);
																					
																					
// =========== Add Back Infutor ================
risk_indicators.Layout_Boca_Shell add_back_infutor(risk_indicators.Layout_Boca_Shell le, infutor_rolled ri) := TRANSFORM
	SELF.Infutor := PROJECT(ri,TRANSFORM(Risk_Indicators.Layouts.Layout_Infutor, SELF := LEFT));
	SELF := le;
END;
infutor_added_back := IF(BSversion>2, JOIN(gong_added_back, infutor_rolled,
																							LEFT.seq=RIGHT.seq,
																							add_back_infutor(LEFT,RIGHT), LEFT OUTER, LOOKUP, PARALLEL),
																			gong_added_back);
																			
																			

// =========== Add Back Infutor ================
risk_indicators.Layout_Boca_Shell add_back_impulse(risk_indicators.Layout_Boca_Shell le, impulse_rolled ri) := TRANSFORM
	SELF.Impulse := PROJECT(ri,TRANSFORM(Risk_Indicators.Layouts.Layout_Impulse, SELF := LEFT));
	SELF := le;
END;
impulse_added_back := IF(BSversion>2, JOIN(infutor_added_back, impulse_rolled,
																							LEFT.seq=RIGHT.seq,
																							add_back_impulse(LEFT,RIGHT), LEFT OUTER, LOOKUP, PARALLEL),
																			infutor_added_back);
																			
//add back for  AML attributes

								 
risk_indicators.layout_bocashell_neutral addWaterCraftAML(ids_full_ssn le, watercraft_relat ri) := TRANSFORM
  	self.relativeWatercraftCount           	 := ri.watercraft_count;
		self := le;
		
END;								 

relatAddWC := join(ids_full_ssn, watercraft_rolled, left.seq=right.seq and left.did=right.did,
                 addWaterCraftAML(left,right),
								 left outer);	

risk_indicators.layout_bocashell_neutral addAIRCraftAML(relatAddWC le, aircraft_rolled_relat ri) := TRANSFORM
  	self.relativeAirCraftCount             := ri.aircraft_count;
		self := le;
		
END;								 

relatAddAC := join(relatAddWC, aircraft_rolled, left.seq=right.seq and left.did=right.did,
                 addAIRCraftAML(left,right),
								 left outer);	


risk_indicators.layout_bocashell_neutral addPropAML(relatAddAC le, RelatRecProp ri) := TRANSFORM
  	self.relativePropertyCount             := ri.relativePropertyCount;
		self.AMLage														 := ri.AMLAge;
		self := le;
		
END;								 
// relaterecprop does contain the individ 
relatAddProp := join(relatAddAC, RelatRecProp, left.seq=right.seq and left.did=right.did,
                 addPropAML(left,right),
								 left outer);	

risk_indicators.layout_bocashell_neutral addEmpAML(relatAddProp  le, relatEmpl ri) := TRANSFORM
  	self.AMLOfficerPosition  := ri.AMLOfficerPosition;
	  self.AMLOfficePositionsCount := ri.AMLOfficePositionsCount;
		self.AMLHRBusiness := ri.AMLHRBusiness;
		self.AMLHRBusinessCount := ri.AMLHRBusinessCount;
		self := le;
		
END;								 

relatAddEmpl := join(relatAddProp, relatEmpl, left.seq=right.seq and left.did=right.did,
                 addEmpAML(left,right), left outer);	

risk_indicators.layout_bocashell_neutral addProfLicAML(relatAddEmpl le, relatProfLic ri) := TRANSFORM
  	self.AMLHRProfLicProv := ri.HRProfLicProv;
		self.AMLProfLic       := if(ri.proflic_count > 0, 1, 0);
		self := le;	
END;								 

relatAddProfLic := join( relatAddEmpl, relatProfLic, left.seq=right.seq and left.did=right.did,
                 addProfLicAML(left,right), left outer);	
								 
								 
risk_indicators.layout_bocashell_neutral addStudentAML(relatAddProfLic le, relatStudent ri) := TRANSFORM
  	self.AMLHRDegreeField := ri.HRDegreeField;
		self.AMLAttendCollege := ri.AttendCollege;
		self := le;	
END;								 

relatAddStudent := join(relatAddProfLic, relatStudent, left.seq=right.seq and left.did=right.did,
                 addStudentAML(left,right), left outer);



risk_indicators.layout_bocashell_neutral addAddrAML(relatAddStudent le, relatAddr ri) := TRANSFORM
  	self.AMLAddressVacancyInd  				 := ri.AMLAddressVacancyInd;
  	self.AMLThrowBackInd       				 := ri.AMLThrowBackInd;
  	self.AMLSeasonalDeliveryInd  			 := ri.AMLSeasonalDeliveryInd;
  	self.AMLResidentialorBusiness_Ind  := ri.AMLResidentialorBusiness_Ind;
		self.AMLPrimRange 								 := ri.AMLPrimRange;
	  self.AMLPredir 										 := ri.AMLPredir;
		self.AMLPrimName 									 := ri.AMLPrimName;
		self.AMLAddrSuffix 								 := ri.AMLAddrSuffix;
		self.AMLPostdir 									 := ri.AMLPostdir;
		self.AMLUnitDesig 								 := ri.AMLUnitDesig;
		self.AMLSecRange 									 := ri.AMLSecRange;
		self.AMLPCityName 								 := ri.AMLPCityName;
		self.AMLst 												 := ri.AMLst;
		self.AMLZ5 												 := ri.AMLZ5;
		self.AMLCounty 										 := ri.AMLCounty;
		self.AMLGeoBlk 										 := ri.AMLGeoBlk;
		self.HRBusPct              				 := ri.HRBusPct;
		self.AMLhRiskAddrFlag              := ri.AMLHRiskAddrflag;
		self.AMLfirstSeenDt                := ri.AMLfirstSeenDt;
		self.AMLEasiTotCrime               := ri.AMLEasiTotCrime;
		self.AMLBusAddr                    := ri.AMLBusAddr;
		self.HighFelonNeighborhood         := ri.HighFelonNeighborhood;
		self := le;	
END;									 
								 
relatAddAddr   := join(relatAddStudent, relatAddr, left.seq=right.seq and left.did=right.did,
                 addAddrAML(left,right), left outer);
								 
relatAddRelPar := join(relatAddAddr, relatParentPubRec,
                       left.seq = right.seq and
											 left.did = right.relatdid,
											 transform(risk_indicators.layout_bocashell_neutral, 
																	self.AMLRelatParentPubRec10yrs := right.RelatParentPubRec10yrs,
																	self := left),
											 left outer);
											 

relatAddHdr := join(relatAddRelPar, relatHeader, 
                      right.seq=left.seq and right.did=left.did,
											transform(risk_indicators.layout_bocashell_neutral, 
																  self.AMLOwnCurrentAddr 		:= right.OwnCurrAddr,
																	self.AMLOwnPrevAddr    		:= right.OwnPrevAddr,
																	self.AMLLengthPrevAddr 		:= right.LengthAtPrevAddr,
																	self.AMLRelatIsVoter    	:= right.relatIsVoter,
																	self.AMLParentIsVoter    	:= right.parentIsVoter,
																	self.AMLParentPubRec10yrs := right.parent_pubRec_10yrs,
  																self.AMLisIncarcerated    := right.isIncarcerated,
  																self.AMLLastMoveOvrYr     := right.LastMoveOvrYr,
																	self.AMLfirstSeenDt    		:= right.firstSeenDt,
																	self.AMLAddrsLast36    		:= right.addrs_last36,
																	self.AMLAddrsLast5years   := right.addrs_last_5years,
																	self := Left),
											left outer);
		
										 
										 
// relative derogs

risk_indicators.layout_bocashell_neutral addDerogsAML(relatAddRelPar le, doc_rolled ri) := TRANSFORM
		self.AMLCriminalCount    := ri.bjl.criminal_count; //- ri.bjl.felony_count;
		self.AMLFelonyCount      := ri.bjl.felony_count;
		self.AMLLiensCount       := ri.bjl.liens_historical_unreleased_count + ri.bjl.liens_recent_unreleased_count +
				                         ri.bjl.liens_historical_released_count + ri.bjl.liens_recent_released_count;
		self.AMLEvictionCount    := ri.bjl.eviction_count;
		self.AMLMinEvent12       := ri.bjl.liens_unreleased_count12 + ri.bjl.liens_released_count12 + ri.bjl.eviction_count12 + ri.bjl.criminal_count12;
		self.AMLMajEvent12       := ri.bjl.criminal_count12;
		self.AMLMajEvent5        := ri.bjl.criminal_count60;
		self.AMLMajEvent5Plus    := ri.bjl.felony_count  -  ri.bjl.criminal_count60;
		self := le;	
END;	


relatAddDerog  := join(relatAddHdr, doc_rolled, 
									left.seq=right.seq and left.did=right.did,
                  addDerogsAML(left,right), left outer);

								 
// get easi census for wealth and fd6
easi_census := ungroup(join(iid, Easi.Key_Easi_Census,
						keyed(right.geolink=left.st+left.county+left.geo_blk),
						transform(easi.layout_census, 
								self.state:= left.st,
								self.county:=left.county,
								self.tract:=left.geo_blk[1..6],
								self.blkgrp:=left.geo_blk[7],
								self.geo_blk:=left.geo_blk,
								self := right), ATMOST(keyed(right.geolink=left.st+left.county+left.geo_blk), Riskwise.max_atmost), KEEP(1)));
					
wealth := Models.WIN704_0_0(impulse_added_back, if(isFCRA, dataset([],Easi.layout_census), easi_census), isFCRA);

withWealth := join(impulse_added_back, wealth,
				left.seq=right.seq,
				transform(Layout_Boca_Shell, self.wealth_indicator := (string)right.wealth_indicator, self := left),
				left outer, many lookup);
				
//aml income  Models.IEN1006_0_1(withWealth, easi_census)),
shell3_bsdata_tmp := map( 
	bsversion > 1 and isFCRA => Models.IED1002_0_6(withWealth, bsversion), //calculates the student.income_level_code and estimated_income
	bsversion > 2 and ~isFCRA => Models.IEN1006_0_1(withWealth, easi_census), 
	bsversion > 1 => withWealth,
	impulse_added_back
);

shell3_bsdata_newIncomeLevelCode := JOIN(shell3_bsdata_tmp, withWealth,
		LEFT.seq=RIGHT.seq,
	TRANSFORM(risk_indicators.Layout_Boca_Shell,
		//use outcome from that model to convert to income code			
			self.student.income_level_code := MAP(
					 bsversion >= 50 => '',
					 IsFCRA and trim(LEFT.student.file_type) = '' => '',
					 IsFCRA and LEFT.did = 0 => '',
					 IsFCRA => LEFT.student.income_level_code,
					 RIGHT.student.income_level_code),
			self.estimated_income := if(bsversion > 2, LEFT.estimated_income, 0),				 
			self := LEFT;),
		LEFT OUTER, LOOKUP, PARALLEL);

shell3_bsdata := if(bsversion >= 2, shell3_bsdata_newIncomeLevelCode, shell3_bsdata_tmp);

// new sections of data for shell 4.0 content
advo_rolled := risk_indicators.boca_shell_advo(ids_wide(~isrelat), isFCRA, datarestriction, isPreScreen, bsversion);  // change to neutral layout
employment_rolled := risk_indicators.boca_shell_employment(ids_wide(~isrelat), isFCRA, isPreScreen, bsversion);	

// need to populate the phones_on_file from the gong search.  inquiries search expects that to be populated
inquiries_input := group(join(ids_wide(~isrelat), gong_added_back, left.seq=right.seq,
		transform(risk_indicators.Layout_BocaShell_Neutral, 
						self.header_summary.phones_on_file := right.header_summary.phones_on_file,
						self.header_summary.phones_on_file_created12months := right.header_summary.phones_on_file_created12months,
						self := left)), seq);
						
inquiries_rolled := if(isFCRA, 
										risk_indicators.boca_shell_inquiries_FCRA(inquiries_input, BSOptions, bsversion, gateways),
										risk_indicators.boca_shell_inquiries(inquiries_input, BSOptions, bsversion, gateways, DataPermission));
LastSeenThreshold := risk_indicators.iid_constants.oneyear;	// set this to default like what it was prior to my BSOptions change									
email_summary_rolled := risk_indicators.boca_shell_email(ids_wide(~isrelat), isFCRA, bsversion, LastSeenThreshold, BSOptions);

with_advo := JOIN(shell3_bsdata, advo_rolled,
									LEFT.seq=RIGHT.seq,
									transform(risk_indicators.Layout_Boca_Shell, 
														self.advo_input_addr := right.advo_input_addr;
														self.advo_addr_hist1 := right.advo_addr_hist1;
														self.advo_addr_hist2 := right.advo_addr_hist2;
														self := left),
									LEFT OUTER, LOOKUP, PARALLEL);

with_employment := JOIN(with_advo, employment_rolled,
									LEFT.seq=RIGHT.seq,
									transform(risk_indicators.Layout_Boca_Shell, 
														self.employment := right.employment;
														self := left),
									LEFT OUTER, LOOKUP, PARALLEL);
									
with_inquiries_roxie := JOIN(with_employment, inquiries_rolled,
									LEFT.seq=RIGHT.seq,
									transform(risk_indicators.Layout_Boca_Shell, 
														self.acc_logs := right.acc_logs;
														self.virtual_fraud := right.virtual_fraud;
														self := left),
									LEFT OUTER, LOOKUP, PARALLEL);
with_inquiries_thor := GROUP(JOIN(DISTRIBUTE(with_employment, HASH64(seq)), 
									DISTRIBUTE(inquiries_rolled, HASH64(seq)),
									LEFT.seq=RIGHT.seq,
									transform(risk_indicators.Layout_Boca_Shell, 
														self.acc_logs := right.acc_logs;
														self.virtual_fraud := right.virtual_fraud;
														self := left),
									LEFT OUTER, LOCAL, PARALLEL), seq);

#IF(onThor)
	with_inquiries := with_inquiries_thor;
#ELSE
	with_inquiries := with_inquiries_roxie;
#END

with_email_summary_roxie := JOIN(with_inquiries, email_summary_rolled,
									LEFT.seq=RIGHT.seq,
									transform(risk_indicators.Layout_Boca_Shell, 
														self.email_summary := right.email_summary;
														self := left),
									LEFT OUTER, LOOKUP, PARALLEL);					
with_email_summary_thor := GROUP(JOIN(DISTRIBUTE(with_inquiries, HASH64(seq)), 
									DISTRIBUTE(email_summary_rolled, HASH64(seq)),
									LEFT.seq=RIGHT.seq,
									transform(risk_indicators.Layout_Boca_Shell, 
														self.email_summary := right.email_summary;
														self := left),
									LEFT OUTER, LOCAL, PARALLEL), seq);

#IF(onThor)
	with_email_summary := with_email_summary_thor;
#ELSE
	with_email_summary := with_email_summary_roxie;
#END

// todo using BH to get Office/agent need to change if we go with PAW											
with_bus_header_summary := if(isFCRA, with_email_summary, risk_indicators.boca_shell_Bus_header(with_email_summary, bsversion)); // won't use business header on FCRA queries
with_address_risk := if(isFCRA, with_bus_header_summary, risk_indicators.Boca_Shell_Address_Risk(with_bus_header_summary, bsversion) );

												

indBSvalues := join(relatAddDerog(~isrelat), with_address_risk, right.seq=left.seq and right.did=left.did,
               transform(layout_bocashell_neutral, self := right; self := left));


AMLIndv := indBSvalues + relatAddDerog(isrelat);
	
// AMLIndexOut := if(~isFCRA and isAML, AML.AMLRollAttributes(group(sort(AMLIndv, seq,did), seq)),
									// Dataset([],layout_bocashell_neutral));
AMLIndexOut := Dataset([],layout_bocashell_neutral);

risk_indicators.Layout_Boca_Shell AddAMLIndex(with_address_risk le, AMLIndexOut ri) := TRANSFORM

	self.AMLAttributes.IndCitizenshipIndex    				:= ri.AMLAttributes.IndCitizenshipIndex;
	self.AMLAttributes.IndMobilityIndex								:= ri.AMLAttributes.IndMobilityIndex;
	self.AMLAttributes.IndLegalEventsIndex						:= ri.AMLAttributes.IndLegalEventsIndex;
	self.AMLAttributes.IndAccesstoFundsIndex					:= ri.AMLAttributes.IndAccesstoFundsIndex;
	self.AMLAttributes.IndBusinessAssocationIndex			:= ri.AMLAttributes.IndBusinessAssocationIndex;
	self.AMLAttributes.IndHighValueAssetIndex					:= ri.AMLAttributes.IndHighValueAssetIndex;
	self.AMLAttributes.IndGeographicIndex							:= ri.AMLAttributes.IndGeographicIndex;
	self.AMLAttributes.IndAssociatesIndex							:= ri.AMLAttributes.IndAssociatesIndex;
	self.AMLAttributes.IndAMLNegativeNews90						:= '0';  //ri.AMLAttributes.IndPublicityCount90;
  self.AMLAttributes.IndAMLNegativeNews24	          := '0'; //ri.AMLAttributes.IndPublicityCount24;
	self.AMLAttributes.IndAgeRange										:= ri.AMLAttributes.IndAgeRange;
	self := le;
	
END;

with_AML  := join(with_address_risk, AMLIndexOut,
                 left.seq=right.shell_input.seq and 
								 left.did=right.shell_input.did,
								 AddAMLIndex(left,right),
								 left outer);
								 
												
with_addr_stability_v2 := models.MSD1010_0_0(group(with_AML,seq));
shell4_bsdata := with_addr_stability_v2;

with_hotlist := 
	join(with_addr_stability_v2, USPIS_HotList.key_addr_search_zip, 
		left.shell_input.z5<>'' and left.shell_input.prim_name<>'' and
		keyed(left.shell_input.z5=right.zip) and
		keyed(left.shell_input.prim_range=right.prim_range) and
		keyed(left.shell_input.prim_name=right.prim_name) and
		keyed(left.shell_input.addr_suffix=right.addr_suffix) and
		keyed(left.shell_input.predir=right.predir) and
		keyed(left.shell_input.postdir=right.postdir) and
		keyed(left.shell_input.sec_range=right.sec_range),
			transform(risk_indicators.Layout_Boca_Shell,
				self.uspis_hotlist := right.zip<>'';
				self := left),
			left outer, atmost(riskwise.max_atmost),keep(1));

bsdata_pre_optout := map(bsversion > 3 and ~isFCRA => with_hotlist,
												 bsversion > 3 => shell4_bsdata,
												 shell3_bsdata);
												 
												 

// prescreen
	ps_opt_outs := if( isFCRA and (BSOptions & risk_indicators.iid_constants.BSOptions.IncludePreScreen) > 0,
		fcra_opt_out.identify_opt_outs(ungroup(project(bsdata_pre_optout, transform(risk_indicators.Layout_Input, self := left.shell_input))) ),
		dataset( [], {boolean opt_out_hit, risk_indicators.layout_input} )
	);
	risk_indicators.Layout_Boca_Shell setPreScreenFlag( risk_indicators.Layout_Boca_Shell le, ps_opt_outs ri ) := TRANSFORM
// per bug 111118, flag minors as opt outs in prescreen mode
		myGetDate := risk_indicators.iid_constants.myGetDate(le.historydate);
		best_reported_age := risk_indicators.years_apart((unsigned)myGetDate, le.reported_dob);
		prescreen_minor := isPreScreen and best_reported_age between 1 and 20;
		opted_out := ri.opt_out_hit or prescreen_minor;				
		flagBit := risk_indicators.iid_constants.SetFlag( iid_constants.IIDFlag.IsPreScreen, opted_out );
		self.iid.iid_flags := le.iid.iid_flags | flagBit;
		self := le;
	END;
	withPreScreen := join( bsdata_pre_optout, ps_opt_outs, left.seq=right.seq, setPreScreenFlag(left,right), keep(1), LEFT OUTER );

// do-not-mail
// per Chris Brodeur, DNM is non-FCRA only
	risk_indicators.Layout_Boca_Shell setDNMFlag( risk_indicators.Layout_Boca_Shell le, dma.key_DNM_Name_Address ri ) := TRANSFORM
		is_hit := ri.l_zip != '';
		flagBit := risk_indicators.iid_constants.SetFlag( iid_constants.IIDFlag.IsDoNotMail, is_hit );
		self.iid.iid_flags := le.iid.iid_flags | flagBit;
		self := le;
	END;
	withDoNotMail := join(bsdata_pre_optout, dma.key_DNM_Name_Address,
		left.shell_input.z5 != ''
		and keyed(left.shell_input.prim_name = right.l_prim_name)
		and keyed(left.shell_input.prim_range = right.l_prim_range)
		and keyed(left.shell_input.st = right.l_st)
		and keyed(right.l_city_code in doxie.Make_CityCodes(left.shell_input.p_city_name).rox)
		and keyed(left.shell_input.z5= right.l_zip)
		and keyed(left.shell_input.sec_range = right.l_sec_range)
		and keyed(left.shell_input.lname = right.l_lname)
		and keyed(left.shell_input.fname = right.l_fname),
		setDNMFlag(left,right), left outer, keep(1)
	);

with_DNM_PreScreen := map(
	    isFCRA and (BSOptions & risk_indicators.iid_constants.BSOptions.IncludePreScreen) > 0 => group(withPreScreen,seq),
	not isFCRA and (BSOptions & risk_indicators.iid_constants.BSOptions.IncludeDoNotMail) > 0 => group(withDoNotMail,seq),
	bsdata_pre_optout
);
	
	// For new FCRA legislation in rhode island, where SSN is verified, but without enough supporting information, 
	// we need to override certain fields in the shell to ensure that we dont return a real score and instead force a 222
	rhode_island_patch := project(with_DNM_PreScreen, 
		transform(risk_indicators.Layout_Boca_Shell, 
			// check input address state or current address state = 'RI'
			
			// determine which of the 3 addresses is best and check the respective State field from that address
			current_address_st := 
				map(left.address_verification.input_address_information.isbestmatch => 
							left.address_verification.input_address_information.st, // input is current
						left.address_verification.address_history_1.isbestmatch => 
							left.address_verification.address_history_1.st, // hist 1 is current
						left.address_verification.address_history_2.isbestmatch => 
							left.address_verification.address_history_2.st, // hist 2 is current
						'');  // if none are flagged as the current address, we don't need to worry about it being in Rhode Island
											 
			isRhodeIsland := left.shell_input.st='RI' or current_address_st = 'RI';
			rhode_island_override := isRhodeIsland and 
																		left.shell_input.ssn<>'' and
																		left.iid.nas_summary in [6,7,9] and 
																		left.iid.nap_summary <= 2 and 
																		(integer)left.dobmatchlevel< 4 and 
																		left.address_verification.input_address_information.naprop <= 2;
			
			// if override condition is met, set the following fields to a value that will ensure a 222    
			self.iid.nas_summary := if(rhode_island_override, 1, left.iid.nas_summary); 
      self.truedid := if(rhode_island_override, false, left.truedid);
      self.address_verification.owned.property_total := if(rhode_island_override, 0, left.address_verification.owned.property_total);
      self.address_verification.sold.property_total := if(rhode_island_override, 0, left.address_verification.sold.property_total);
      self.bjl.liens_recent_unreleased_count := if(rhode_island_override, 0, left.bjl.liens_recent_unreleased_count);
      self.bjl.liens_historical_unreleased_count := if(rhode_island_override, 0, left.bjl.liens_historical_unreleased_count);
      self.LnJ_attributes.lnj_recent_unreleased_count := if(rhode_island_override, 0, left.LnJ_attributes.lnj_recent_unreleased_count);
      self.LnJ_attributes.lnj_historical_unreleased_count := if(rhode_island_override, 0, left.LnJ_attributes.lnj_historical_unreleased_count);
			self.iid.sources := if(rhode_island_override, '', left.iid.sources);
      self.header_summary.ver_sources := if(rhode_island_override, '', left.header_summary.ver_sources);
      self.bjl.criminal_count := if(rhode_island_override, 0, left.bjl.criminal_count);
      self.iid.bansflag := if(rhode_island_override, '3', left.iid.bansflag);
      self.bjl.bankrupt := if(rhode_island_override, false, left.bjl.bankrupt);
      self.bjl.filing_count := if(rhode_island_override, 0, left.bjl.filing_count);
      self.bjl.bk_recent_count := if(rhode_island_override, 0, left.bjl.bk_recent_count);
      self.iid.decsflag := if(rhode_island_override, '0', left.iid.decsflag);
      self.professional_license.professional_license_flag := if(rhode_island_override, false, left.professional_license.professional_license_flag); 
      self.watercraft.watercraft_count := if(rhode_island_override, 0, left.watercraft.watercraft_count); 
      self.avm.input_address_information.avm_land_use_code := if(rhode_island_override, '', left.avm.input_address_information.avm_land_use_code); 
      self.student.file_type := if(rhode_island_override, '', left.student.file_type); 
      self.rhode_island_insufficient_verification := if(rhode_island_override, true, false); 
			self := left));

bsdata41 := if(isFCRA, rhode_island_patch, with_DNM_PreScreen);


// --------------------[ add 5.0 sections here ]--------------------

// nonfcra 5.0 data only
insurance_phones_rolled := Risk_Indicators.Boca_Shell_Insurance_Phones(ids_wide(~isrelat));
bureau_phones_rolled := Risk_Indicators.Boca_Shell_Bureau_Phones(ids_wide(~isrelat));

with_insurance_phones := join(bsdata41, insurance_phones_rolled, left.seq=right.seq,
	transform(risk_indicators.Layout_Boca_Shell, 
		self.seq := left.seq,
		self.insurance_phones_summary := right;
		self := left), left outer, keep(1), parallel);
		
with_bureau_phone_verification := join(with_insurance_phones, bureau_phones_rolled, left.seq=right.seq,
	transform(risk_indicators.Layout_Boca_Shell, 
		self.seq := left.seq,
		self.Experian_Phone_Verification := right.phone_ver_bureau;
		self.phone_ver_bureau := right.phone_ver_bureau;
		self := left), left outer, keep(1), parallel);										

// everything in shell 5.0 up to this point is non-fcra only.  if isFCRA, start with bsdata41
shell50_branch1 := if(isFCRA, group(bsdata41, seq), group(with_bureau_phone_verification, seq));

with_college_attendance := risk_indicators.boca_shell_college_attendance(shell50_branch1, isFCRA);		
with_source_profile := risk_indicators.getSourceProfile(with_college_attendance);		
with_economic_trajectory := risk_indicators.getEconomicTrajectory(with_source_profile);		
with_address_occupancy := Risk_Indicators.Boca_Shell_Address_Occupancy(with_economic_trajectory, isFCRA);		
with_build_dates := risk_indicators.Boca_Shell_data_build_dates(with_address_occupancy, isFCRA);

bsData50 := if(bsversion>=50, group(with_build_dates, seq), group(bsdata41, seq));

// --------------------[ add 5.1 sections here ]--------------------

// nonfcra 5.1 data only
mod_FDN := Risk_Indicators.Boca_Shell_FDN( PROJECT( iid, Risk_Indicators.Layout_Input ) );

test_fraud_data         := mod_FDN.test_fraud_metrics;
contributory_fraud_data := mod_FDN.contributory_fraud_metrics;

with_test_fraud_data := join(bsData50, test_fraud_data, left.seq=right.seq,
	transform(risk_indicators.Layout_Boca_Shell, 
		self.seq := left.seq,
		self.Test_Fraud := right;
		self := left), left outer, keep(1), parallel);
		
with_contributory_fraud_data := join(with_test_fraud_data, contributory_fraud_data, left.seq=right.seq,
	transform(risk_indicators.Layout_Boca_Shell, 
		self.seq := left.seq,
		self.Contributory_Fraud := right;
		self := left), left outer, keep(1), parallel);										

// everything in shell 5.1 up to this point is non-fcra only. if isFCRA or if no FDN permission, start with bsData50.
shell51_branch1 := if(isFCRA or ~Risk_Indicators.iid_constants.FDNcftf_ok(DataPermission), group(bsData50, seq), group(with_contributory_fraud_data, seq));

bsData51 := if(bsversion>=51, group(shell51_branch1, seq), group(bsData50, seq));

bsData52_a := if(bsversion >= 52 and ~isFCRA, risk_indicators.Boca_Shell_PII_Stability(bsdata51), bsdata51);

bsData := if(bsversion >= 52, 
	risk_indicators.Boca_Shell_BestPII_Data(bsData52_a, isFCRA, glb, dppa, bsversion, datarestriction, datapermission, bsoptions),
	bsData52_a);

// output fraudPoint 2.0 attributes
// gateways := DATASET([],risk_indicators.Layout_Gateways_In);	// net acuity is not used for version 41 attributes in the shell
ipdata := DATASET([],riskwise.Layout_IP2O);	// net acuity is not used for version 41 attributes in the shell
// fdAttributesV2 := Models.getFDAttributes(final, iid, '', gateways, dppa, 0, '');	// hardcoding glb = 0 here as it is not really needed for anything
fdAttributesV2 := Models.getFDAttributes(bsData, iid, '', ipdata);

risk_indicators.Layout_Boca_Shell addFDattributesV2(bsData le, fdAttributesV2 ri) := TRANSFORM
	self.fdAttributesv2 := ri.version2;
	self.fpAttributes201.IDVerAddressVehicleRegistration := ri.version201.IDVerAddressVehicleRegistation;
	self.fpAttributes201 := ri.version201;
	self := le;
END;
wFDAttrV2 := join(bsData, fdAttributesV2, left.seq=right.input.seq, addFDattributesV2(LEFT,RIGHT), LEFT OUTER);

final := if(~isFCRA and BSversion>=41, group(wFDAttrV2,seq), BSdata);	// only do fraudpoint v2 attributes for non-fcra

// --------------------[ add models ]--------------------

wModels := risk_indicators.getAllBocaShellModels(final, isFCRA, easi_census);

// append riskview alerts for bsversion >= 50 and fcra
isCalifornia_in_person := false;  // for this purpose within the shell, the applicant won't be applying in person in california.  that is a product specific setting
with_alerts := if(bsversion >= 50 and isFCRA, riskview.getRiskviewAlerts(wModels, isCalifornia_in_person, if(isPrescreen, 'PRESCREENING', '')), wModels);

final2 := if(production_realtime_mode and ~doScore, final, group(with_alerts,seq));	// only add models in archive run or if doScore is requested, check version if realtime run	

defaultOffset := project(final2, 
	transform(risk_indicators.Layout_Boca_Shell, 
		defaultOffset_6mos 	:= left.archive_date_6mo='99999999' or left.did = 0;
		defaultOffset_12mos := left.archive_date_12mo='99999999' or left.did = 0;
		defaultOffset_24mos := left.archive_date_24mo='99999999' or left.did = 0;
		// the new BS 5.3 'Credit Derived Performance' fields only apply when running in archive mode.  Here we will default the fields to '-1' if running in current mode or if
		// any of the offset history dates are more than a year in the future or if a DID was not found.
		self.BJL.bk_count12_6mos 								:= if(defaultOffset_6mos, -1, left.BJL.bk_count12_6mos); 
		self.BJL.bk_count12_12mos 							:= if(defaultOffset_12mos, -1, left.BJL.bk_count12_12mos); 
		self.BJL.bk_count12_24mos 							:= if(defaultOffset_24mos, -1, left.BJL.bk_count12_24mos); 
		self.BJL.criminal_count12_6mos 					:= if(defaultOffset_6mos, -1, left.BJL.criminal_count12_6mos); 
		self.BJL.criminal_count12_12mos 				:= if(defaultOffset_12mos, -1, left.BJL.criminal_count12_12mos); 
		self.BJL.criminal_count12_24mos 				:= if(defaultOffset_24mos, -1, left.BJL.criminal_count12_24mos); 
		self.BJL.liens_unreleased_count12_6mos 	:= if(defaultOffset_6mos, -1, left.BJL.liens_unreleased_count12_6mos); 
		self.BJL.liens_unreleased_count12_12mos := if(defaultOffset_12mos, -1, left.BJL.liens_unreleased_count12_12mos); 
		self.BJL.liens_unreleased_count12_24mos := if(defaultOffset_24mos, -1, left.BJL.liens_unreleased_count12_24mos); 
		self.BJL.eviction_count12_6mos 					:= if(defaultOffset_6mos, -1, left.BJL.eviction_count12_6mos); 
		self.BJL.eviction_count12_12mos 				:= if(defaultOffset_12mos, -1, left.BJL.eviction_count12_12mos); 
		self.BJL.eviction_count12_24mos 				:= if(defaultOffset_24mos, -1, left.BJL.eviction_count12_24mos); 
		self.Impulse.count12_6mos 							:= if(defaultOffset_6mos, -1, left.Impulse.count12_6mos); 
		self.Impulse.count12_12mos 							:= if(defaultOffset_12mos, -1, left.Impulse.count12_12mos); 
		self.Impulse.count12_24mos 							:= if(defaultOffset_24mos, -1, left.Impulse.count12_24mos); 
		self.ACC_logs.Collection.Count12_6mos		:= if(defaultOffset_6mos, -1, left.ACC_logs.Collection.Count12_6mos); 
		self.ACC_logs.Collection.Count12_12mos	:= if(defaultOffset_12mos, -1, left.ACC_logs.Collection.Count12_12mos); 
		self.ACC_logs.Collection.Count12_24mos	:= if(defaultOffset_24mos, -1, left.ACC_logs.Collection.Count12_24mos); 
		self.ACC_logs.HighRiskCredit.Count12_6mos		:= if(defaultOffset_6mos, -1, left.ACC_logs.HighRiskCredit.Count12_6mos); 
		self.ACC_logs.HighRiskCredit.Count12_12mos	:= if(defaultOffset_12mos, -1, left.ACC_logs.HighRiskCredit.Count12_12mos); 
		self.ACC_logs.HighRiskCredit.Count12_24mos	:= if(defaultOffset_24mos, -1, left.ACC_logs.HighRiskCredit.Count12_24mos); 
		self := left));
		
finalOffset := if(bsversion >= 53 and isFCRA, defaultOffset, final2);

//MS-71: add BIP header information to the shell
options := MODULE(Business_Risk_BIP.LIB_Business_Shell_LIBIN)
	EXPORT UNSIGNED1	DPPA_Purpose 											:= dppa;
	EXPORT UNSIGNED1	GLBA_Purpose 											:= glb;
	EXPORT STRING50		DataRestrictionMask								:= DataRestriction;
	EXPORT STRING50		DataPermissionMask								:= DataPermission;
	EXPORT STRING10		IndustryClass											:= '';
	EXPORT UNSIGNED1	LinkSearchLevel										:= Business_Risk_BIP.Constants.LinkSearch.Default;
	EXPORT UNSIGNED1	BusShellVersion										:= Business_Risk_BIP.Constants.Default_BusShellVersion;
	EXPORT UNSIGNED1	MarketingMode											:= 0;
	EXPORT STRING50		AllowedSources										:= Business_Risk_BIP.Constants.Default_AllowedSources;
	EXPORT UNSIGNED1	BIPBestAppend											:= Business_Risk_BIP.Constants.BIPBestAppend.Default;
	EXPORT UNSIGNED1	OFAC_Version											:= 0;
	EXPORT REAL				Global_Watchlist_Threshold				:= 0;
	EXPORT UNSIGNED1	KeepLargeBusinesses								:= 0;
	EXPORT BOOLEAN    IncludeTargusGateway 							:= false;
	EXPORT BOOLEAN    RunTargusGatewayAnywayForTesting 	:= false;
	EXPORT BOOLEAN    OverrideExperianRestriction 			:= false;	
	EXPORT BOOLEAN    DoNotUseAuthRepInBIPAppend  			:= false;
	EXPORT BOOLEAN		IsBIID20													:= false;	
END;

linkingOptions := MODULE(BIPV2.mod_sources.iParams)
	EXPORT STRING DataRestrictionMask		:= Options.DataRestrictionMask; 
	EXPORT BOOLEAN ignoreFares					:= FALSE; 
	EXPORT BOOLEAN ignoreFidelity				:= FALSE; 
	EXPORT BOOLEAN AllowAll							:= IF(Options.AllowedSources = Business_Risk_BIP.Constants.AllowDNBDMI, TRUE, FALSE); 
	EXPORT BOOLEAN AllowGLB							:= Risk_Indicators.iid_constants.GLB_OK(Options.GLBA_Purpose, FALSE );
	EXPORT BOOLEAN AllowDPPA						:= Risk_Indicators.iid_constants.DPPA_OK(Options.DPPA_Purpose, FALSE );
	EXPORT UNSIGNED1 DPPAPurpose				:= Options.DPPA_Purpose;
	EXPORT UNSIGNED1 GLBPurpose					:= Options.GLBA_Purpose;
	EXPORT BOOLEAN IncludeMinors				:= TRUE; 
	EXPORT BOOLEAN LNBranded						:= TRUE; 
END;

AllowedSourcesSet := 
		SET(
			CHOOSEN(
				Business_Risk_BIP.Constants.AllowedSources(
						(
							Source <> MDR.SourceTools.src_Dunn_Bradstreet OR 
							StringLib.StringFind(Options.AllowedSources, Business_Risk_BIP.Constants.AllowDNBDMI, 1) > 0
						) AND
						(
							Options.MarketingMode = Business_Risk_BIP.Constants.Default_MarketingMode OR 
							Source NOT IN SET(Business_Risk_BIP.Constants.MarketingRestrictedSources, Source)
						) AND
						(
							Options.OverrideExperianRestriction = True OR
							Source NOT IN SET(Business_Risk_BIP.Constants.ExperianRestrictedSources, Source)
						)
				), 
				300
			), 
			Source );

withBIP_Header := Risk_Indicators.Boca_Shell_BIP_Header(finalOffset, Options, linkingOptions, AllowedSourcesSet, isFCRA, BSVersion); 

withEquifaxFraudFlags := Risk_Indicators.Boca_Shell_Equifax_FraudFlags(group(withBIP_Header, seq), isFCRA); 

final53 := if(bsversion >= 53, group(withEquifaxFraudFlags, seq), finalOffset);


// final53 := finalOffset;

// output(derogs_added_back, named('derogs_added_back'));
// output(final, named('final'));
// output(choosen(insurance_phones_rolled, eyeball), named('insurance_phones_rolled'));
// output(choosen(ingenix_rolled, eyeball), named('ingenix_rolled'));
// output(choosen(experian_phones_rolled, eyeball), named('experian_phones_rolled'));
// output(choosen(mari_rolled, eyeball), named('mari_rolled'));	
// output(derogs_added_back, named('derogs_added_back'));
// output(relat_derogs_rolled, named('relat_derogs_rolled'));	
// output(doc_rolled, named('doc_rolled'));
// output(derogs_w_rel_crims, named('derogs_w_rel_crims'));
// output(derogs_hist, named('derogs_hist'));
// output(bsData, named('bsData'));
// output(relative_snapshot_table, named('relative_snapshot_table'));
// output(relat_sorted2, named('relat_sorted2'));
// output(relat_rolled, named('relat_rolled'));
// output(final2, named('final2'));
// output(IncludeLnJ, named('IncludeLnJ'));
// output(prop_common, named('prop_common'));
// output(pre_ADVO, named('pre_ADVO'));
// output(prop_with_advo, named('prop_with_advo'));
// output(prop_with_advo_deduped, named('prop_with_advo_deduped'));
// output(single_property, named('single_property'));
// output(Rel_Property_Rolled, named('Rel_Property_Rolled'));
// output(Per_Property_Rolled, named('Per_Property_Rolled'));
// output(per_prop, named('per_prop'));

RETURN final53; 
END;