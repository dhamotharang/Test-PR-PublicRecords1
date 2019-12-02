IMPORT Risk_indicators, ut, LN_PropertyV2_Services, AML;

// EXPORT IndProperty(DATASET(Risk_indicators.layout_bocashell_neutral) IndivIds) := FUNCTION
EXPORT IndProperty(DATASET(Layouts.LayoutAMLShellV2) IndivIds, 
										string50 DataRestriction = Risk_indicators.iid_constants.default_DataRestriction) := FUNCTION


//version 2	


Risk_indicators.Layout_Boca_Shell prepBSN(IndivIds le) := TRANSFORM
	SELF.seq := le.seq;
	SELF.did := le.did;
	SELF.HistoryDate := le.historydate;

	
	SELF.Shell_Input.title := le.title;
	SELF.Shell_Input.fname   := le.fname;
	SELF.Shell_Input.mname   := le.mname;
	SELF.Shell_Input.lname   := le.lname;
	SELF.Shell_Input.suffix   := le.suffix;

	SELF.Shell_Input.in_streetAddress   := le.in_streetAddress;
	SELF.Shell_Input.in_city   := le.in_city;
	SELF.Shell_Input.in_state   := le.in_state;
	SELF.Shell_Input.in_zipCode   := le.in_zipCode;
	SELF.Shell_Input.in_country   := le.in_country;

	SELF.Shell_Input.prim_range   := le.prim_range;
	SELF.Shell_Input.predir   := le.predir;
	SELF.Shell_Input.prim_name   := le.prim_name;
	SELF.Shell_Input.addr_suffix   := le.addr_suffix;
	SELF.Shell_Input.postdir   := le.postdir;
	SELF.Shell_Input.unit_desig   := le.unit_desig;
	SELF.Shell_Input.sec_range   := le.sec_range;
	SELF.Shell_Input.p_city_name   := le.city_name;
	SELF.Shell_Input.st   := le.st;
	SELF.Shell_Input.z5   := le.z5;
	SELF.Shell_Input.zip4   := le.zip4;
	SELF.Shell_Input.lat :=  le.lat;
	SELF.Shell_Input.long :=  le.long;
	SELF.Shell_Input.county :=  le.county;
	SELF.Shell_Input.geo_blk :=  le.geo_blk;
	
	SELF.Address_Verification.Address_History_1.prim_range := le.AddrHist1_prim_range;
	SELF.Address_Verification.Address_History_1.predir := le.AddrHist1_predir;
	SELF.Address_Verification.Address_History_1.prim_name := le.AddrHist1_prim_name;
	SELF.Address_Verification.Address_History_1.addr_suffix := le.AddrHist1_addr_suffix;
	SELF.Address_Verification.Address_History_1.postdir := le.AddrHist1_postdir;
	SELF.Address_Verification.Address_History_1.unit_desig := le.AddrHist1_unit_desig;
	SELF.Address_Verification.Address_History_1.sec_range := le.AddrHist1_sec_range;
	SELF.Address_Verification.Address_History_1.city_name := le.AddrHist1_city_name;
	SELF.Address_Verification.Address_History_1.st := le.AddrHist1_st;
	SELF.Address_Verification.Address_History_1.zip5 := le.AddrHist1_zip5;
	SELF.Address_Verification.Address_History_1.county := le.AddrHist1_county;
	SELF.Address_Verification.Address_History_1.geo_blk := le.AddrHist1_geo_blk;
	
	SELF.Address_Verification.Address_History_2.prim_range := le.AddrHist2_prim_range;
	SELF.Address_Verification.Address_History_2.predir := le.AddrHist2_predir;
	SELF.Address_Verification.Address_History_2.prim_name := le.AddrHist2_prim_name;
	SELF.Address_Verification.Address_History_2.addr_suffix := le.AddrHist2_addr_suffix;
	SELF.Address_Verification.Address_History_2.postdir := le.AddrHist2_postdir;
	SELF.Address_Verification.Address_History_2.unit_desig := le.AddrHist2_unit_desig;
	SELF.Address_Verification.Address_History_2.sec_range := le.AddrHist2_sec_range;
	SELF.Address_Verification.Address_History_2.city_name := le.AddrHist2_city_name;
	SELF.Address_Verification.Address_History_2.st := le.AddrHist2_st;
	SELF.Address_Verification.Address_History_2.zip5 := le.AddrHist2_zip5;
	SELF.Address_Verification.Address_History_2.county := le.AddrHist2_county;
	SELF.Address_Verification.Address_History_2.geo_blk := le.AddrHist2_geo_blk;
	
  self := le;
	self := [];	
END;



pre_ids_only := dedup(sort(IndivIds, seq, did), seq, did);
ids_only := group(project(pre_ids_only, transform(Risk_Indicators.layout_boca_shell_ids, self := left)), seq);
PrepPropIds := project(IndivIds, prepBSN(left));

boolean includeRelativeInfo := false;
boolean filter_out_fares := false;
boolean IsFCRA := false;

 // =============== Get Property Info ===============
  Risk_Indicators.layout_PropertyRecord get_addresses(PrepPropIds le, integer c) := TRANSFORM
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
  p_address := group(NORMALIZE(PrepPropIds,3,get_addresses (LEFT,COUNTER))(prim_name != '', zip5 != ''), seq);

  
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

	IndivProp := 
		Risk_Indicators.Boca_Shell_Property_Common( p_address, ids_only, includeRelativeInfo, filter_out_fares, IsFCRA, in_mod_property, FALSE );
		
  // productaop  := group(if(production_realtime_mode, prop, prop_hist), seq);
	
	Per_Property_Rolled := Risk_Indicators.Roll_Applicant_Property(IndivProp(property_status_applicant<>' '));

// OUTPUT(pre_ids_only, NAMED('pre_ids_only'), OVERWRITE);
// OUTPUT(ids_only, NAMED('ids_only'), OVERWRITE);
// OUTPUT(p_address, NAMED('p_address'), OVERWRITE);
// OUTPUT(prop, NAMED('prop'), OVERWRITE);
// OUTPUT(prop_hist, NAMED('prop_hist'), OVERWRITE);
// OUTPUT(IndivProp, NAMED('IndivProp'), OVERWRITE);
// OUTPUT(Per_Property_Rolled, NAMED('Per_Property_Rolled'), OVERWRITE);

RETURN  Per_Property_Rolled;

END;