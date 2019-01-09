import doxie, ut, codes, iesp;
import AutoStandardI, VehicleV2_Services, Autokey_batch, CriminalRecords_Services;
import VehicleV2, VehicleCodes, suppress, Census_Data, doxie_raw, MDR,Driversv2;


export Functions := MODULE;

	EXPORT get_state(VehicleV2_Services.IParam.polkParams in_mod) := FUNCTION
		tmp_state := AutoStandardI.InterfaceTranslator.state_value.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.state_value.params));
		state_val := IF(in_mod.state='', tmp_state, in_mod.state);
		RETURN TRIM(stringlib.stringtouppercase(state_val));
	END;

	EXPORT STRING getSearchDataSource(VehicleV2_Services.IParam.polkParams in_mod, BOOLEAN doCombined) := FUNCTION
		/* doCombined = true Rules: if state with in list LOCAL_STATES_SEARCH,
			datasource should be local.  If no state provided datasource should be 
			all (local and realtime) unless the datasource in in_mod has value 
			Constant.Local_val*/
			
		state := get_state(in_mod);

		IsLocalState := state IN Constant.LOCAL_STATES_SEARCH;	
			
		/*DataSource := MAP((NOT doCombined) => in_mod.DataSource, 
											(NOT EXISTS(state)) => Constant.ALL_VAL, 
											isLocalState => Constant.LOCAL_VAL, 
											Constant.ALL_VAL);	*/
		datasource := IF (doCombined AND in_mod.datasource != Constant.Local_val
												,IF(isLocalState, Constant.LOCAL_VAL, Constant.All_val)
												,in_mod.datasource);
		
		RETURN DataSource;
	END;
	
/* Need to change this lic_plate_filter to FUNCTION instead of MODULE */
export 	lic_plate_filter_New(dataset(VehicleV2_Services.Layouts.lic_plate_key_payload_fields_New) pre_dedup,unsigned return_count,unsigned starting_record,
		unsigned penalt_threshold,unsigned max_results, unsigned in_limit,unsigned dppa_purpose,string1 state_type_val)
	:= MODULE
	
		sort_fields_rec := record
		string30 Vehicle_Key;
		string15 Iteration_Key;
		string15 Sequence_Key;
		boolean is_current;
		unsigned4 date;
		unsigned2 party_penalty;
		string1 state_type;
		end;
		
		sort_fields_rec get_penalt(VehicleV2_Services.Layouts.lic_plate_key_payload_fields_New l):=transform
			self.party_penalty :=	doxie.FN_Tra_Penalty_SSN(l.use_ssn) +
							doxie.FN_Tra_Penalty_Name(l.fname, 
								l.mname, l.lname)+ 
							doxie.FN_Tra_Penalty_Addr(l.predir,
								l.prim_range, 
								l.prim_name,
								l.addr_suffix, 
								l.postdir,
								l.sec_range,
								l.v_city_name,
								l.State_origin, l.zip5)+
								doxie.FN_Tra_Penalty_CName(l.append_clean_cname);
			self := l;
		END;
		
		
		w_penalt := project(pre_dedup,get_penalt(left));

		srt_w_penalt :=	sort(w_penalt,vehicle_key,iteration_key,sequence_key);
		
		w_penalt_group0 := group(srt_w_penalt,vehicle_key,iteration_key,sequence_key);
		
		VehicleV2_Services.Mac_DppaCheck(w_penalt_group0,w_penalt_group)
		// Date and is_current should be uniform across group within the key. This is because during key build
		// we only took the latest date per group and is current is always the same per group in the data
		
		sort_fields_rec get_fields_trickle(w_penalt_group l, dataset(recordof(w_penalt_group)) r) :=transform
			self.party_penalty :=min(r,party_penalty);
			self.state_type := min(r,state_type);
			self := l;
		END;



		veh_res_trickle0 := ungroup(rollup(w_penalt_group,group,get_fields_trickle(left,rows(left))));			
				

		rep_w_seq :=record
			veh_res_trickle0;
			unsigned2 seq_srt;
			unsigned2 seq_srt2 :=0;
		end;
		
		rep_w_seq add_seq(veh_res_trickle0 l,integer C):=transform
			self.seq_srt := C;
			self := l;
		END;
		
		
		// if state type is 'A' that means moxie search with state_origin input so we only want records
		// where the state origin field matches. If state type is 'B' that means moxie search with state input
		// so we only want records where the state origin or the state fields match the input. This excludes
		// previously registered states
		state_type_set := if(state_type_val='A',['A'],['A','B']);

		vehs_wseq0 := project(sort(veh_res_trickle0(party_penalty < penalt_threshold and (state_type_val='C' or state_type in state_type_set) ),
			party_penalty,if(is_current,0,1), -Date, - ((unsigned) sequence_key[1..6])), add_seq(left,counter));

		rep_w_seq roll_seq(vehs_wseq0 l,vehs_wseq0 r):=transform
			self.seq_srt := if(l.vehicle_key=r.vehicle_key,l.seq_srt,r.seq_srt);
			self.seq_srt2 := r.seq_srt;
			self := r;
		END;
		
		vehs0 := iterate(sort(vehs_wseq0,vehicle_key,seq_srt),roll_seq(left,right));

		shared vehs1 := choosen(vehs0,max_results);
		
		shared vehs2 := choosen(sort(vehs1, seq_srt,seq_srt2),
		return_Count,starting_Record);
		
		vehs3 := project(vehs2,transform(Layout_VehKey_wseq,self:=left,self.seq:=counter));
		
		export recs := if(in_limit = 0,vehs3,choosen(vehs3,in_limit));
		export cnt := count(vehs1);			

	end;
	

  shared Layout_Report_out_veh := record
    Layout_Report_Vehicle;
    VehicleV2_Services.Layout_Vehicle_Key.Sequence_Key;
    Autokey_batch.Layouts.rec_inBatchMaster.acctno;
    BOOLEAN cnp_entered;
  END;
			
			
	
	
	SHARED MAC_Report_Out := MACRO
		best_major_color_desc := VehicleCodes.getColor(r.best_Major_Color_Code); // use keycodes instead?
    best_minor_color_desc := VehicleCodes.getColor(r.best_Minor_Color_Code);		
		
		BrandCodeType1 := VehicleV2_Services.Exp_Code_Translations.get_brandType(r.brand_code_1);				 
		BrandCodeType2 := VehicleV2_Services.Exp_Code_Translations.get_brandType(r.brand_code_2);
		BrandCodeType3 := VehicleV2_Services.Exp_Code_Translations.get_brandType(r.brand_code_3);
		BrandCodeType4 := VehicleV2_Services.Exp_Code_Translations.get_brandType(r.brand_code_4);
		BrandCodeType5 := VehicleV2_Services.Exp_Code_Translations.get_brandType(r.brand_code_5);
		BrandDS := dataset([{ut.date_slashed_MMDDYYYY_to_YYYYMMDD(r.brand_date_1),r.brand_state_1,r.brand_code_1,BrandCodeType1},
																		 {ut.date_slashed_MMDDYYYY_to_YYYYMMDD(r.brand_date_2),r.brand_state_2,r.brand_code_2,BrandCodeType2},
																		 {ut.date_slashed_MMDDYYYY_to_YYYYMMDD(r.brand_date_3),r.brand_state_3,r.brand_code_3,BrandCodeType3},
																		 {ut.date_slashed_MMDDYYYY_to_YYYYMMDD(r.brand_date_4),r.brand_state_4,r.brand_code_4,BrandCodeType4},
																		 {ut.date_slashed_MMDDYYYY_to_YYYYMMDD(r.brand_date_5),r.brand_state_5,r.brand_code_5,BrandCodeType5}
		                       ], 
		           VehicleV2_Services.assorted_layouts.layout_brand);
    
    self.vin := if(r.vina_vin<>'', r.vina_vin, r.orig_vin);		
    self.series_desc := IF(r.VINA_Series_Desc<>'',r.VINA_Series_Desc,
														IF(r.orig_series_desc[1..3] !='000',r.orig_series_desc,''));
    veh_type_desc := VehicleV2_Services.Polk_Code_Translations.Veh_Type_Description(r.Orig_Vehicle_Type_Code[1]);		
		self.vehicle_type_desc := veh_type_desc;
		self.body_style_desc := r.VINA_Body_Style_Desc;
    self.major_color_desc := best_major_color_desc;
    self.minor_color_desc := best_minor_color_desc;
    self.VINA_VP_RESTRAINT_Desc := Codes.VEHICLE_REGISTRATION.VP_RESTRAINT(r.VINA_VP_Restraint);
    self.VINA_VP_AIR_CONDITIONING_Desc := codes.VEHICLE_REGISTRATION.VP_AIR_CONDITIONING(r.VINA_VP_AIR_CONDITIONING);
    self.VINA_VP_POWER_STEERING_Desc := codes.VEHICLE_REGISTRATION.VP_POWER_STEERING(r.VINA_VP_POWER_STEERING);
    self.VINA_VP_POWER_BRAKES_Desc := codes.VEHICLE_REGISTRATION.VP_POWER_BRAKES(r.VINA_VP_POWER_BRAKES);
    self.VINA_VP_Power_Windows_Desc := codes.VEHICLE_REGISTRATION.VP_POWER_WINDOWS(r.VINA_VP_Power_Windows);
    self.VINA_VP_Tilt_Wheel_Desc := codes.VEHICLE_REGISTRATION.VP_Tilt_Wheel(r.VINA_VP_Tilt_Wheel);
    self.VINA_VP_Roof_Desc := codes.VEHICLE_REGISTRATION.VP_ROOF(r.VINA_VP_Roof);
    self.VINA_VP_Optional_Roof1_Desc := codes.VEHICLE_REGISTRATION.VP_OPTIONAL_ROOF1(r.VINA_VP_Optional_Roof1);
    self.VINA_VP_Optional_Roof2_Desc := codes.VEHICLE_REGISTRATION.VP_OPTIONAL_ROOF2(r.VINA_VP_Optional_Roof2);
    self.VINA_VP_Radio_Desc := codes.VEHICLE_REGISTRATION.VP_RADIO(r.VINA_VP_Radio);
    self.VINA_VP_Optional_Radio1_Desc := codes.VEHICLE_REGISTRATION.VP_OPTIONAL_RADIO1(r.VINA_VP_Optional_Radio1);
    self.VINA_VP_Optional_Radio2_Desc := codes.VEHICLE_REGISTRATION.VP_OPTIONAL_RADIO2(r.VINA_VP_Optional_Radio2);
    self.VINA_VP_Transmission_Desc := codes.VEHICLE_REGISTRATION.VP_TRANSMISSION(r.VINA_VP_Transmission);
    self.VINA_VP_Optional_Transmission1_Desc := codes.VEHICLE_REGISTRATION.VP_TRANSMISSION(r.VINA_VP_Optional_Transmission1);
    self.VINA_VP_Optional_Transmission2_Desc := codes.VEHICLE_REGISTRATION.VP_TRANSMISSION(r.VINA_VP_Optional_Transmission2);
    self.VINA_VP_Anti_Lock_Brakes_Desc := codes.VEHICLE_REGISTRATION.VP_ANTI_LOCK_BRAKES(r.VINA_VP_Anti_Lock_Brakes);
    self.VINA_VP_Front_Wheel_Drive_Desc := codes.VEHICLE_REGISTRATION.VP_FRONT_WHEEL_DRIVE(r.VINA_VP_Front_Wheel_Drive);
    self.VINA_VP_Four_Wheel_Drive_Desc := codes.VEHICLE_REGISTRATION.VP_FOUR_WHEEL_DRIVE(r.VINA_VP_Four_Wheel_Drive);
    self.VINA_VP_Security_System_Desc := codes.VEHICLE_REGISTRATION.VP_SECURITY_SYSTEM(r.VINA_VP_Security_System);
    self.VINA_VP_Daytime_Running_Lights_Desc := codes.VEHICLE_REGISTRATION.VP_DAYTIME_RUNNING_LIGHTS(r.VINA_VP_Daytime_Running_Lights);
    self.BASE_PRICE := r.vina_price;
    self.fuel_type_name := codes.VEHICLE_REGISTRATION.FUEL_CODE(r.VINA_Fuel_Code);		
		self.brands := (DEDUP(BrandDS, ALL))(brand_state <> '');
    self := r; // sets tod_flag for MVR combined DGL 2015
    self.state_origin_decoded :=codes.general.state_long(r.state_origin);
    self.is_deep_dive := l.is_deep_dive;
    self.Sequence_Key := l.Sequence_Key;
	ENDMACRO;
	
	SHARED Layout_Report_Out_Veh makeVehReport(Layout_Vehicle_Key l, VehicleV2.Key_Vehicle_Main_Key r) := TRANSFORM		
    self.model_year := r.best_model_year;
		self.make_desc := IF(r.vina_make_desc != '',r.vina_make_desc,r.orig_make_desc);   
		self.model_desc := IF(r.vina_model_desc != '',r.vina_model_desc,r.orig_model_desc);
    MAC_Report_Out();		
		SELF := L;
		SELF := [];
	END;
	
  SHARED Layout_Report_Out_Veh makeVehSearch(Layout_VKeysWithInput l, VehicleV2.Key_Vehicle_Main_Key r, VehicleV2_Services.IParam.searchParams aInputData) := transform
    
		make_description := IF(r.vina_make_desc != '',r.vina_make_desc,r.orig_make_desc);
    model_description := IF(r.vina_model_desc != '',r.vina_model_desc,r.orig_model_desc);  
    STRING year_make := aInputData.ModelYear;
    STRING make_desc := aInputData.make;
    STRING model_desc := aInputData.model;
    model_year := r.best_model_year;
    self.model_year := if(year_make = '' or model_year = year_make, model_year,skip);

    self.make_desc := if( stringlib.StringToUpperCase(make_description) = stringlib.StringToUpperCase(make_desc)[1..length(trim(make_description))] or make_desc='',make_description,skip);
   
    self.model_desc := if( stringlib.StringToUpperCase(model_description) = stringlib.StringToUpperCase(model_desc)[1..length(trim(model_description))] or model_desc='',model_description,skip);
    MAC_Report_Out();
		self.cnp_entered := aInputData.companyname != '' 
									OR aInputData.lastname != '' 
									OR aInputData.firstname != '';
		self := L;
    self.Target_Sequence_Keys := [];
  end;

  // Keys
  shared keyVParty := VehicleV2.Key_Vehicle_Party_Key;
  shared keyCd3 := Codes.Key_Codes_V3;

  shared rec_party := record
    VehicleV2_Services.Layouts.Layout_Report_Party_New;
    keyVParty.orig_lien_date;
    keyVParty.orig_name_type;
    keyVParty.vehicle_key;
    keyVParty.iteration_key;
		keyVParty.Source_Code;
		string70 std_lienholder_name;
    boolean HasCriminalConviction;
    boolean IsSexualOffender;
		string1 name_source_cd;
		string30 name_source;
		string8 title_issue_date;
    string17 title_number;
    string30 reported_name;
  end;

    // Constant
  shared STRING UNDER_AGE_LNAME := 'UNDERAGE INDIVIDUAL';
  shared STRING PARTY_T_INDV := 'I';
  shared STRING BLNK := '';
  shared STRING SP := ' ';

  ///// ======================== penalty functions ======================== /////
  shared penaltyCName(VehicleV2_Services.IParam.searchParams aInputData, STRING cnameFld) := FUNCTION
    tm := MODULE(PROJECT(aInputData, AutoStandardI.LIBIN.PenaltyI_Biz_Name.full, OPT))
      EXPORT cname_field := cnameFld;
    END;
    RETURN AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tm);
  END;

  shared penaltyDID(VehicleV2_Services.IParam.searchParams aInputData, STRING didFld) := FUNCTION
    tm := MODULE(PROJECT(aInputData, AutoStandardI.LIBIN.PenaltyI_DID.full, OPT))
      EXPORT did_field := didFld;
    END;
    RETURN AutoStandardI.LIBCALL_PenaltyI_DID.val(tm);
  END;

  shared penaltySSN(VehicleV2_Services.IParam.searchParams aInputData, STRING ssnFld) := FUNCTION
    tm := MODULE(PROJECT(aInputData, AutoStandardI.LIBIN.PenaltyI_SSN.full, OPT))
      EXPORT ssn_field := ssnFld;
    END;
    RETURN AutoStandardI.LIBCALL_PenaltyI_SSN.val(tm);
  END;

  shared penaltyName(VehicleV2_Services.IParam.searchParams aInputData, STRING fnameFld, STRING mnameFld, STRING lnameFld, BOOLEAN allowWld = FALSE) := FUNCTION
    tm := MODULE(PROJECT(aInputData, AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, OPT))
      EXPORT fname_field := fnameFld;
      EXPORT mname_field := mnameFld;
      EXPORT lname_field := lnameFld;
      EXPORT allow_wildcard := allowWld;
    END;
    RETURN AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tm);
  END;

  shared penaltyAddr(VehicleV2_Services.IParam.searchParams aInputData,
                STRING predirFld, STRING prangeFld, STRING pnameFld, STRING suffixFld,
                STRING postdirFld, STRING secRangeFld, STRING cityFld, STRING stateFld,
                STRING zipFld, BOOLEAN allowWld = FALSE, STRING city2Fld = BLNK) := FUNCTION
      tm := MODULE(PROJECT(aInputData, AutoStandardI.LIBIN.PenaltyI_Addr.full, OPT))
        EXPORT allow_wildcard := allowWld;
        EXPORT city_field := cityFld;
        EXPORT city2_field := city2Fld;
        EXPORT pname_field := pnameFld;
        EXPORT postdir_field := postdirFld;
        EXPORT prange_field := prangeFld;
        EXPORT predir_field := predirFld;
        EXPORT state_field := stateFld;
        EXPORT suffix_field := suffixFld;
        EXPORT zip_field := zipFld;
        EXPORT sec_range_field := secRangeFld;
    END;
    RETURN AutoStandardI.LIBCALL_PenaltyI_Addr.val(tm);
  END;
	
	shared partyPenaltyAddr(Layout_VKeysWithInput l, STRING predirFld, STRING prangeFld, STRING pnameFld, STRING suffixFld,
                STRING postdirFld, STRING secRangeFld, STRING cityFld, STRING stateFld,
                STRING zipFld, BOOLEAN allowWld = FALSE, STRING city2Fld = BLNK) := function
								
		addr := MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Addr.full, opt))
		
				// The 'input' address:
				EXPORT predir         	:= l.predir;
				EXPORT prim_name      	:= l.prim_name;
				EXPORT prim_range     	:= l.prim_range;
				EXPORT postdir        	:= l.postdir;
				EXPORT addr_suffix    	:= l.addr_suffix;
				EXPORT sec_range      	:= l.sec_range;
				EXPORT p_city_name    	:= l.p_city_name;
				EXPORT st             	:= l.st;
				EXPORT z5             	:= l.z5;	
			
				// The address in the matching record:						
				EXPORT allow_wildcard  	:= allowWld;					
				EXPORT city_field      	:= cityFld;
				EXPORT city2_field     	:= city2Fld;
				EXPORT pname_field     	:= pnameFld;
				EXPORT postdir_field   	:= postdirFld;
				EXPORT prange_field    	:= prangeFld;
				EXPORT predir_field    	:= predirFld;
				EXPORT state_field     	:= stateFld;
				EXPORT suffix_field    	:= suffixFld;
				EXPORT zip_field       	:= zipFld;						
				EXPORT sec_range_field 	:= secRangeFld;
				EXPORT useGlobalScope  	:= FALSE;
			END;				
			return AutoStandardI.LIBCALL_PenaltyI_Addr.val(addr);
	end;			
	
  shared penaltyBDID(IParam.searchParams aInputData, STRING bdidFld) := FUNCTION
    tm := MODULE(PROJECT(aInputData, AutoStandardI.LIBIN.PenaltyI_BDID.full, OPT))
      EXPORT bdid_field := bdidFld;
    END;
    RETURN AutoStandardI.LIBCALL_PenaltyI_BDID.val(tm);
  END;
  ///// ======================== penalty functions end ======================== /////

  shared string70 ms(string70 a, string70 b, string70 c) :=
      map(a = BLNK => b,
          b = BLNK => a,
          ut.StringSimilar(a, c) <= ut.StringSimilar(b, c) => a,
          b);

  shared rec_party get_parties_report ( keyVParty r) := TRANSFORM
    UNSIGNED1 age := IF(r.Orig_DOB = BLNK, 0, ut.age((integer) r.Orig_DOB));
    BOOLEAN ofage := ut.PermissionTools.GLB.minorOK(age);
    SELF.history_desc := IF(ofage, Codes.VEHICLE_REGISTRATION.HISTORY_FLAG(r.History), BLNK);
    SELF.Append_DID := IF (ofage AND r.Append_DID != 0, INTFORMAT (r.Append_DID, 12, 1), BLNK);
    SELF.Append_BDID := IF(ofage AND r.Append_BDID != 0, INTFORMAT (r.Append_BDID, 12, 1), BLNK);
    SELF.party_penalty := 0;
    SELF.orig_sex_desc := IF(ofage, Codes.GENERAL.GENDER(r.Orig_Sex), BLNK);
    SELF.lname := IF(ofage, r.Append_Clean_Name.lname, UNDER_AGE_LNAME);
    SELF := IF(ofage, r.Append_Clean_Name);
    SELF := IF(ofage, r.Append_Clean_Address);
    SELF.age := IF(ofage, (STRING) age, BLNK);
    SELF.Vehicle_Key := r.Vehicle_Key;
    SELF.Iteration_Key := r.Iteration_Key;
    SELF.Sequence_Key := r.Sequence_Key;
    SELF.Orig_Name_Type := r.Orig_Name_Type;
    SELF := IF(ofage, r);
    SELF.County_Name := '';
    SELF.HasCriminalConviction := FALSE;
    SELF.IsSexualOffender := FALSE;
		self := r; //business ids
		self := [];
  END;
		
  // same as report but with penalty calculations; implemented as a function to minimize transform content
  shared rec_party get_parties_search (Layout_VKeysWithInput l, keyVParty r,
                                       IParam.searchParams aInputData, boolean penalize_by_party_addr = false) := FUNCTION

    aInputData_E2 := VehicleV2_Services.IParam.getSearchModule_entity2();
		
		rec_party mTransform := TRANSFORM
      UNSIGNED1 age := IF(r.Orig_DOB = BLNK, 0, ut.age ((integer) r.Orig_DOB));
      BOOLEAN ofage := ut.PermissionTools.GLB.minorOK(age);
      
      //company name and its penalty
      STRING company := IF(r.Orig_Party_Type = PARTY_T_INDV, BLNK, TRIM(r.Orig_Name));
      comp_name_E1 := TRIM(aInputData.company);
			comp_name_E2 := TRIM(aInputData_E2.company);
      cname_penalty_E1 := penaltyCName(aInputData, company);
			cname_penalty_E2 := penaltyCName(aInputData_E2, company);
      penaltyCompany_E1 := IF(StringLib.StringFind(company, SP + comp_name_E1 + SP, 1) > 0 OR
        StringLib.StringFind(company, comp_name_E1 + SP, 1) = 1 OR
        StringLib.StringReverse(company)[1..length(comp_name_E1)+1] = StringLib.StringReverse(SP + comp_name_E1) OR
        ut.StringSimilar(company, aInputData.Company) = 0,
        IF(cname_penalty_E1 > 1, 1, cname_penalty_E1), cname_penalty_E1);
				
			penaltyCompany_E2 := IF(StringLib.StringFind(company, SP + comp_name_E2 + SP, 1) > 0 OR
        StringLib.StringFind(company, comp_name_E2 + SP, 1) = 1 OR
        StringLib.StringReverse(company)[1..length(comp_name_E2)+1] = StringLib.StringReverse(SP + comp_name_E2) OR
        ut.StringSimilar(company, aInputData_E2.Company) = 0,
        IF(cname_penalty_E2 > 1, 1, cname_penalty_E2), cname_penalty_E2);

			byparty_addr_penalty := partyPenaltyAddr(l,r.Append_Clean_Address.predir,
																		 r.Append_Clean_Address.prim_range,
																		 r.Append_Clean_Address.prim_name,
																		 r.Append_Clean_Address.addr_suffix,
																		 r.Append_Clean_Address.postdir,
																		 r.Append_Clean_Address.sec_range,
																		 ms(r.Orig_City, r.Append_Clean_Address.v_city_name, l.p_city_name),
																		 r.Orig_State, r.Append_Clean_Address.zip5);
			addr_penalty := penaltyAddr(aInputData,r.Append_Clean_Address.predir,
																		 r.Append_Clean_Address.prim_range,
																		 r.Append_Clean_Address.prim_name,
																		 r.Append_Clean_Address.addr_suffix,
																		 r.Append_Clean_Address.postdir,
																		 r.Append_Clean_Address.sec_range,
																		 ms(r.Orig_City, r.Append_Clean_Address.v_city_name, aInputData.city),
																		 r.Orig_State, r.Append_Clean_Address.zip5);													 

			computed_addr_penalty := IF(penalize_by_party_addr, byparty_addr_penalty, addr_penalty);
			
      //penalty E1 = single party search , E2 = two party search
			penalty_E1 := IF(NOT ofage, 0,
											penaltyDID(aInputData,(STRING) r.Append_DID) +
											penaltySSN(aInputData, ms(r.Orig_SSN, r.Append_SSN, aInputData.ssn)) +
											penaltyName(aInputData, r.Append_Clean_Name.fname,
																	r.Append_Clean_Name.mname,
																	r.Append_Clean_Name.lname) +
											computed_addr_penalty +																		 
											penaltyBDID(aInputData, (STRING) r.Append_BDID) +
											penaltyCompany_E1);
			penalty_E2 := IF(NOT ofage, 0,
											penaltyDID(aInputData_E2,(STRING) r.Append_DID) +
											penaltySSN(aInputData_E2, ms(r.Orig_SSN, r.Append_SSN, aInputData_E2.ssn)) +
											penaltyName(aInputData_E2, r.Append_Clean_Name.fname,
																	r.Append_Clean_Name.mname,
																	r.Append_Clean_Name.lname) +
											penaltyAddr(aInputData_E2,r.Append_Clean_Address.predir,
																	r.Append_Clean_Address.prim_range,
																	r.Append_Clean_Address.prim_name,
																	r.Append_Clean_Address.addr_suffix,
																	r.Append_Clean_Address.postdir,
																	r.Append_Clean_Address.sec_range,
																	ms(r.Orig_City, r.Append_Clean_Address.v_city_name, aInputData_E2.city),
																	r.Orig_State, r.Append_Clean_Address.zip5) +
											penaltyBDID(aInputData_E2, (STRING) r.Append_BDID) +
											penaltyCompany_E2);
											
			raw_penalty := if(AutoStandardI.GlobalModule().TwoPartySearch,max(penalty_E1,penalty_E2),penalty_E1);
			
      SELF.history_desc := IF(ofage, Codes.VEHICLE_REGISTRATION.HISTORY_FLAG(r.History), BLNK);
      SELF.Append_DID := IF(ofage AND r.Append_DID != 0, INTFORMAT (r.Append_DID, 12, 1), BLNK);
      SELF.Append_BDID := IF(ofage AND r.Append_BDID != 0, INTFORMAT (r.Append_BDID, 12, 1), BLNK);
      SELF.party_penalty := raw_penalty;
      SELF.orig_sex_desc := IF(ofage, Codes.GENERAL.GENDER(r.Orig_Sex), BLNK);
      SELF.lname := IF(ofage, r.Append_Clean_Name.lname, UNDER_AGE_LNAME);
      SELF := IF(ofage, r.Append_Clean_Name);
      SELF := IF(ofage, r.Append_Clean_Address);
      SELF.age := IF(ofage, (STRING) age, BLNK);
      SELF.Vehicle_Key := r.Vehicle_Key;
      SELF.Iteration_Key := r.Iteration_Key;
      SELF.Sequence_Key := r.Sequence_Key;
      SELF.Orig_Name_Type := r.Orig_Name_Type;
      SELF := IF(ofage, r);
      SELF.County_Name := '';
      SELF.HasCriminalConviction := FALSE;
      SELF.IsSexualOffender := FALSE;
			self := [];
    END;
    return mTransform;
  END;

  shared Layout_Report_Batch_Extra := RECORD(VehicleV2_Services.Layouts.Layout_Report_Batch_New)
    Layout_Report_Out_Veh.cnp_entered;    
  END;
	
  shared VehicleV2_Services.Layouts.Layout_Report_Batch_New GetRolledView (
    GROUPED dataset (Layout_Report_Out_Veh) pre_veh_recs1,
    dataset (rec_party) pre_party_recs0,
    IParam.reportParams aInputData,
    boolean report_mode) := FUNCTION
    
    unsigned2 penalty_threshold := aInputData.penalty_threshold;    
    string title_issue_date := aInputData.titleIssueDate;
    string previous_title_issue_date := aInputData.previousTitleIssueDate;

    //Added the ENTRP FILTER
    party_active := pre_party_recs0(reg_latest_expiration_date>ut.IndustryClass.sys_Date);
    party_inactive := pre_party_recs0(reg_latest_expiration_date<=ut.IndustryClass.sys_Date);
    doxie_raw.MAC_ENTRP_CLEAN(party_inactive,reg_latest_expiration_date,party_entrp);
    
    party_ftr_recs := (party_entrp+party_active);                          

    //Pick Current                      
    party_curr_reg := CHOOSEN(SORT(party_ftr_recs,-reg_latest_expiration_date,record),1);
    
    //Need to pick all the registrants for the VehKey.ItrKey,SeqKey
    party_curr_key := JOIN(party_curr_reg,pre_party_recs0
                            ,LEFT.Vehicle_key = RIGHT.Vehicle_key AND
                             LEFT.Iteration_key = RIGHT.Iteration_key AND
                             LEFT.Sequence_key = RIGHT.Sequence_key,
                             TRANSFORM(recordof(pre_party_recs0),SELF := RIGHT));  

    //Pick Curr or filter ENTRP res
    party_entrp_recs := if(ut.industryClass.EntDateVal=1,party_curr_key,party_ftr_recs);
    party_res_1 := IF(ut.IndustryClass.is_entrp,party_entrp_recs,pre_party_recs0);
    party_res := group(sort(party_res_1, Vehicle_Key, -Iteration_Key), Vehicle_key, Iteration_key);
      
    Census_Data.MAC_Fips2County_Keyed(party_res, st, fips_county, county_name, pre_party_recs1)

		Suppress.MAC_Suppress(pre_party_recs1,pull_dids,aInputData.applicationType,Suppress.Constants.LinkTypes.DID,append_DID);
		Suppress.MAC_Suppress(pull_dids,pull_ssns0,aInputData.applicationType,Suppress.Constants.LinkTypes.SSN,append_ssn);
		Suppress.MAC_Suppress(pull_ssns0,pull_ssns,aInputData.applicationType,Suppress.Constants.LinkTypes.SSN,orig_ssn);
    doxie.MAC_PruneOldSSNs(pull_ssns, party_recs_pruned0, append_ssn, append_did);
    doxie.MAC_PruneOldSSNs(party_recs_pruned0,party_recs_pruned,orig_ssn,append_did);
    
    
    ssn_mask_value := aInputData.ssnMask;
    dl_mask_value := aInputData.dl_Mask;
    exclude_lessors := aInputData.excludeLessors;
    displayMatchedParty_value := aInputData.displayMatchedParty;
      
    suppress.mac_mask(party_recs_pruned, party_recs0, append_ssn, blank, true, false);  
    suppress.mac_mask(party_recs0,party_recs1,orig_ssn,blank,true,false)
    suppress.mac_mask(party_recs1,party_recs,blank,Orig_DL_Number,false,true)

		dppa_ok := AutoStandardI.InterfaceTranslator.dppa_ok.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.dppa_ok.params));
		glb_ok := AutoStandardI.InterfaceTranslator.glb_ok.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.glb_ok.params));
		
		temp_rec := record
			party_recs;
			integer did;
		end;
	
		temp := project(party_recs, transform(temp_rec, self.did := (integer)left.append_did, self := left));
	
		doxie.mac_best_records(temp,
													 did,
													 outfile,
													 dppa_ok,
													 glb_ok, 
													 ,
													 doxie.DataRestriction.fixed_DRM);
						
						
			// use best file to get DOB and SEX, if missing in the original data.
		rec_party get_dob_sex(party_recs r, outfile ri) := transform
      age := if(r.orig_dob != '', ut.age((integer)r.orig_dob), if (ri.dob = 0, 0, ut.age(ri.dob)));
      ofage :=ut.PermissionTools.glb.minorOk(age);
      best_sex := map (ri.title = 'MS' => 'F', ri.title = 'MR' => 'M','U'); // same as in drivers

      self.orig_dob := if( r.orig_dob <> '' and ofage,r.orig_dob,(string8) ri.dob);
      self.orig_sex := if(r.orig_sex <>'' and ofage,r.orig_sex,best_sex);
      self.orig_sex_desc := if(ofage and r.orig_sex_desc='', CODES.GENERAl.GENDER(best_sex),r.orig_sex_desc);
      SELF.age := IF(ofage, (STRING) age, '');
      SELF.Vehicle_Key := r.Vehicle_Key;
      SELF.Iteration_Key := r.Iteration_Key;
      SELF.Sequence_Key := r.Sequence_Key;
      SELF.Orig_Name_Type := r.Orig_Name_Type;
			SELF := IF(ofage, r);
    END;

		w_dl_fields := join(party_recs, outfile,
												(integer)left.append_did = right.did,
												get_dob_sex(left, right), keep(1), left outer);
										 
    Layout_Report_Out_Veh getDecode_fuel(Layout_Report_Out_Veh l, keyCd3 r):=transform
      self.fuel_type_name := r.long_desc;
      self := l;
    END;
    
    pre_veh_recs2 := join(pre_veh_recs1 ,keyCd3,  keyed(right.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
          keyed(right.field_name= (STRING50)'FUEL_TYPE') AND
          keyed(right.field_name2 = left.state_origin) AND
          keyed((string15)left.vina_fuel_code = right.code),
        getDecode_fuel(LEFT,RIGHT),left outer, keep(1), limit(1000,skip));

    Layout_Report_Batch_Extra getDecode_body(Layout_Report_Out_Veh l, keyCd3 r):=transform
      self.body_style_desc := if(r.long_desc<>'', r.long_desc,l.body_style_desc);
			self.nonDMVSource := l.source_code in MDR.sourceTools.set_infutor_all_veh; 
      self := l;
      self := [];
    END;

    veh_recs := join(pre_veh_recs2, keyCd3, keyed(right.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
          keyed(right.field_name= (STRING50)'BODY_CODE') AND
          keyed(left.state_origin = right.field_name2) AND 
          keyed(left.body_style_desc = right.code),
        getDecode_body(LEFT,RIGHT),left outer, keep(1), limit(1000,skip));
    

    VehicleV2_Services.Layouts.Layout_Report_Batch_New rollIt (Layout_Report_Batch_Extra l, dataset(rec_party) r, boolean report_mode) := transform

      party_r := r;
	   
      //get different kinds of records (owner/registrant/lessee/lienholder/lessor)
      r_recs := party_r(orig_name_type = '4');
      l_recs := party_r(orig_name_type = '7');
      pre_o_recs := party_r(orig_name_type = '1');
      lessee_recs := party_r(orig_name_type = '5');
      lessor_recs := if(~Exclude_lessors,  party_r(orig_name_type = '2'));

      len_ttl_issue_dt := length(title_issue_date);
      len_prev_ttl_issue_dt := length(previous_title_issue_date);
      ttl_issue_dt := (unsigned4) title_issue_date;
      ttl_prev_issue_dt := previous_title_issue_date;

      o_recs := pre_o_recs (
        map (len_ttl_issue_dt = 4=>ttl_issue_dt between (unsigned4) (ttl_earliest_issue_date[1..4]) and (unsigned4) (ttl_latest_issue_date[1..4]),
             len_ttl_issue_dt = 6=>ttl_issue_dt between (unsigned4) (ttl_earliest_issue_date[1..6]) and (unsigned4) (ttl_latest_issue_date[1..6]),
             len_ttl_issue_dt = 8=>ttl_issue_dt between (unsigned4) (ttl_earliest_issue_date[1..8]) and (unsigned4) (ttl_latest_issue_date[1..8]),
             ttl_issue_dt=0) and
                          map(len_prev_ttl_issue_dt = 4 => ttl_prev_issue_dt = ttl_previous_issue_date[1..4],
                              len_prev_ttl_issue_dt = 6 => ttl_prev_issue_dt = ttl_previous_issue_date[1..6],
                              len_prev_ttl_issue_dt = 8 => ttl_prev_issue_dt = ttl_previous_issue_date[1..8],
                              ttl_prev_issue_dt=''));
      

      party_dup(dataset(rec_party) recs) := if(report_mode,
                                          dedup(sort(recs,
                                            except sequence_key, orig_address, orig_city, orig_state, orig_zip),
                                       except sequence_key, orig_address, orig_city, orig_state, orig_zip),
                                       dedup(sort(recs,
                                      fname,mname,lname,append_clean_cname,name_suffix,title, append_ssn,orig_ssn,prim_range,predir, prim_name,addr_suffix, postdir, 
                                      unit_desig, sec_range, v_city_name, st, zip5 ,zip4 ,Orig_DL_Number,history,Reg_True_License_Plate,
                                      Reg_License_Plate,Reg_First_Date,Reg_Earliest_Effective_Date,Reg_Latest_Effective_Date),
                                      fname,mname,lname,append_clean_cname,name_suffix,title, append_ssn,orig_ssn,prim_range,predir, prim_name,addr_suffix, postdir, 
                                      unit_desig, sec_range, v_city_name, st, zip5 ,zip4 ,Orig_DL_Number,history,Reg_True_License_Plate,
                                      Reg_License_Plate,Reg_First_Date,Reg_Earliest_Effective_Date,Reg_Latest_Effective_Date));
      
      SELF.matched_party := IF(DisplayMatchedParty_value AND l.cnp_entered,
        SORT(party_r,vehicle_key, iteration_key, sequence_key,party_penalty,orig_name_type,record)[1]);
      registrants := party_dup(r_recs);
      lessees     := party_dup(lessee_recs);

      lessors := choosen(dedup(sort(lessor_recs, 
                                        except sequence_key, orig_address, orig_city, orig_state, orig_zip), 
                                   except sequence_key, orig_address, orig_city, orig_state, orig_zip),Constant.max_child_count);
   

      owners     := if(report_mode,dedup(sort(o_recs,
                                         except sequence_key, orig_address, orig_city, orig_state, orig_zip), 
                                       except sequence_key, orig_address, orig_city, orig_state, orig_zip),
                                         dedup(sort(o_recs,
                    fname,mname,lname,append_clean_cname,name_suffix,title, append_ssn,orig_ssn,prim_range,predir, prim_name,addr_suffix, postdir, 
                    unit_desig, sec_range, v_city_name, st, zip5 ,zip4 ,Orig_DL_Number,history,Ttl_Number,Ttl_Earliest_Issue_Date,
                    Ttl_Latest_Issue_Date),
                    fname,mname,lname,append_clean_cname,name_suffix,title, append_ssn,orig_ssn,prim_range,predir, prim_name,addr_suffix, postdir, 
                    unit_desig, sec_range, v_city_name, st, zip5 ,zip4 ,Orig_DL_Number,history,Ttl_Number,Ttl_Earliest_Issue_Date,
                    Ttl_Latest_Issue_Date ));

            lienholders := choosen(dedup(sort(l_recs,
                                       except sequence_key), 
                                 except sequence_key),Constant.max_child_count);
      
      rec_party roll_parties(rec_party le, rec_party ri) :=
      TRANSFORM
        SELF.Reg_First_Date := (STRING8) ut.min2 ((unsigned)le.Reg_First_Date, (unsigned)ri.Reg_First_Date);
        SELF.Reg_Earliest_Effective_date := (STRING8) ut.min2 ((unsigned)le.Reg_Earliest_Effective_date,(unsigned)ri.Reg_Earliest_Effective_date);
        SELF.Reg_Latest_Effective_Date := (STRING8) MAX ((unsigned)le.Reg_Latest_Effective_Date, (unsigned)ri.Reg_Latest_Effective_Date);
        SELF.Reg_Latest_Expiration_Date := (STRING8) MAX((unsigned)le.Reg_Latest_Expiration_Date, (unsigned)ri.Reg_Latest_Expiration_Date);
        SELF := le;
      END;

      party_roller(DATASET(rec_party) pty) := 
                            ROLLUP(SORT(pty, RECORD, 
                                EXCEPT Reg_First_Date, Reg_Earliest_Effective_date, Reg_Latest_Effective_Date, Reg_Latest_Expiration_Date),
                            roll_parties(LEFT,RIGHT), RECORD, 
                                EXCEPT Reg_First_Date, Reg_Earliest_Effective_date, Reg_Latest_Effective_Date, Reg_Latest_Expiration_Date);
      
      self.is_current  := if(exists(pre_o_recs) and ~exists(owners),skip,exists(r_recs(history='')) or exists(lessee_recs(history='')) or l.is_current);
      self.datasource  := Constant.local_val_out;
		
      self.registrants := 
            choosen(sort(PROJECT(party_roller(registrants), TRANSFORM(VehicleV2_Services.assorted_layouts.layout_registrant,SELF.matchFlags:=[],SELF:=LEFT)),
          sequence_key, if(report_mode,0,party_penalty), lname,fname, mname,name_suffix,orig_name),VehicleV2_Services.Constant.max_child_count);
                              
      self.owners      := choosen(sort(PROJECT(party_roller(owners), TRANSFORM(VehicleV2_Services.Layouts.Layout_owner,SELF.matchFlags:=[],SELF:=LEFT)),
                              sequence_key, if(report_mode,0,party_penalty), lname,fname, mname,name_suffix,orig_name),Constant.max_child_count);
      self.lienholders :=  sort(project(lienholders,TRANSFORM(VehicleV2_Services.Assorted_Layouts.Layout_lienholder,SELF.matchFlags:=[],SELF:=LEFT)),
                              sequence_key, if(report_mode,0,party_penalty), lname,fname, mname,name_suffix,orig_name);
      self.lessees :=  choosen(sort(project(party_roller(lessees), TRANSFORM(VehicleV2_Services.Assorted_Layouts.layout_lessee,SELF.matchFlags:=[],SELF:=LEFT)),
                              sequence_key, if(report_mode,0,party_penalty), lname,fname, mname,name_suffix,orig_name),Constant.max_child_count);
      self.lessors := sort(project(lessors,TRANSFORM(VehicleV2_Services.Assorted_Layouts.layout_lessee_or_lessor,SELF.matchFlags:=[],SELF:=LEFT)),
                            sequence_key, if(report_mode,0,party_penalty), lname,fname, mname,name_suffix,orig_name);       										
        // self.plate   := r_recs[1];
      // self.title   := o_recs[1];
      
      /* Web not ready to be able to search on leasees yet */
      // mpp := ut.imin2(
      // ut.iMin2(if(exists(registrants),MIN(registrants, party_penalty),100),if(exists(owners), MIN(owners, party_penalty),100)),
      // if(exists(lessees),MIN(lessees, party_penalty),100));
      
      mpp := MIN (if(exists(registrants),MIN(registrants, party_penalty),100),if(exists(owners), MIN(owners, party_penalty),100));

      self.min_party_penalty :=IF(report_mode, 0, IF(mpp > penalty_threshold, SKIP, mpp));

      self := l;
    end;


    rolled_recs := denormalize(veh_recs,w_dl_fields,
      left.vehicle_key=right.vehicle_key and left.iteration_key=right.iteration_key
      and left.sequence_key = right.sequence_key,group,rollIt(left,rows(right), report_mode),grouped)
      (exists(owners) or exists(registrants) or exists(lienholders) or exists(lessees) or
      exists(lessors) or exists(Brands));
			
    //might need a rollup here
    rolled_out_recs := dedup(sort(rolled_recs, except iteration_key), except iteration_key);		
		
    return rolled_out_recs;
  end;

	SHARED MAC_JoinLatestDLAndPrePartyRecs(inputPrePartyRecs, outputPrePartyRecs) := MACRO
		// latest DL recs by expire date by did
		latest_dl_recs :=	DEDUP(
																		SORT(
																				JOIN(inputPrePartyRecs, Driversv2.Key_DL_DID, 
																								KEYED((UNSIGNED)LEFT.append_did = RIGHT.did),
																								TRANSFORM(RIGHT),
																								LEFT OUTER,
																								LIMIT(DriversV2.Constants.DL_PER_DID, SKIP)
																								), 
																			did,-expiration_date,-lic_issue_date),
																did);

		// add driver license number		
		outputPrePartyRecs := JOIN(inputPrePartyRecs, 
								latest_dl_recs, 
								(UNSIGNED)LEFT.append_did = RIGHT.did,
									TRANSFORM(RECORDOF(inputPrePartyRecs),
										SELF.orig_dl_number := IF(LEFT.orig_dl_number!='', LEFT.orig_dl_number,
																  IF(LEFT.orig_name_type IN ['1','4'], RIGHT.dl_number, '')), // owner/registrant
																	SELF:=LEFT),
									LEFT OUTER,KEEP(1));
	ENDMACRO;

  EXPORT GetVehicleReport (VehicleV2_Services.IParam.reportParams aInputData, GROUPED dataset(Layout_Vehicle_Key) in_veh_keys,
                     STRING in_ssn_mask_type = '') := FUNCTION
										 
		boolean isCNSMR := aInputData.IndustryClass = 'CNSMR';
    dppa_purpose_x := aInputData.dppapurpose;  // from business_header/doxie_MAC_Field_Declare()
		boolean include_non_regulated_data := aInputData.IncludeNonRegulatedSources and ~doxie.DataRestriction.InfutorMV;
		
	  pre_veh_recs0_info := join(in_veh_keys, VehicleV2.Key_Vehicle_Main_Key,
                          keyed(left.Vehicle_Key = right.Vehicle_Key) and
                          keyed((left.Iteration_Key = '') OR left.Iteration_Key = right.Iteration_Key) and
													(include_non_regulated_data or right.source_code not in MDR.sourceTools.set_infutor_all_veh),
                          makeVehReport(left, right),
                          limit(VehicleV2_Services.Constant.VEHICLE_PER_KEY,skip));

			pre_veh_recs0 := if(~isCNSMR, pre_veh_recs0_info);

    _pre_veh_recs1 := pre_veh_recs0(ut.PermissionTools.dppa.state_ok(state_origin,dppa_purpose_x,,source_code) or
																	  (source_code in MDR.sourceTools.set_infutor_all_veh and ut.PermissionTools.dppa.ok(dppa_purpose_x)));

    r_j_vehicleparty := JOIN(in_veh_keys, keyVParty,
                KEYED(LEFT.Vehicle_key = RIGHT.Vehicle_key) AND
                KEYED(LEFT.Iteration_key = RIGHT.Iteration_key) AND
                KEYED(LEFT.Sequence_key = RIGHT.Sequence_key) and
								(include_non_regulated_data or right.source_code not in MDR.sourceTools.set_infutor_all_veh),
                get_parties_report (RIGHT),
                KEEP(VehicleV2_Services.Constant.PARTIES_PER_VEHICLE),
								LIMIT(0));
													
  
 	r_j := if(~isCNSMR, r_j_vehicleparty);
    pre_party_recs0 := UNGROUP(r_j);		
		MAC_JoinLatestDLAndPrePartyRecs(pre_party_recs0, outputPrePartyRecs);
		
    return GetRolledView (_pre_veh_recs1, outputPrePartyRecs, aInputData, true);
  END;

  EXPORT Get_VehicleSearch (VehicleV2_Services.IParam.searchParams aInputData, GROUPED dataset(VehicleV2_Services.Layout_VKeysWithInput) in_veh_keys,                      
                      STRING in_ssn_mask_type = '', BOOLEAN penalize_by_party = FALSE) := FUNCTION
											
		boolean isCNSMR := aInputData.IndustryClass = 'CNSMR';									
    dppa_purpose_x := aInputData.dppapurpose;  // from business_header/doxie_MAC_Field_Declare()
    unsigned2 penalty_threshold := aInputData.penalty_threshold;    
		boolean include_non_regulated_data := aInputData.IncludeNonRegulatedSources and ~doxie.DataRestriction.InfutorMV;
		
    pre_veh_recs0_info := join(in_veh_keys, VehicleV2.Key_Vehicle_Main_Key,
                          keyed(left.Vehicle_Key = right.Vehicle_Key) and
                          keyed(left.Iteration_Key = right.Iteration_Key) and
													(include_non_regulated_data or right.source_code not in MDR.sourceTools.set_infutor_all_veh),
                          makeVehSearch(left, right, aInputData),
                          limit(VehicleV2_Services.Constant.VEHICLE_PER_KEY,skip));
														
			pre_veh_recs0 := if(~isCNSMR, pre_veh_recs0_info);

    pre_veh_recs1 := pre_veh_recs0(ut.PermissionTools.dppa.state_ok(state_origin,dppa_purpose_x,,source_code) or
																	 (source_code in MDR.sourceTools.set_infutor_all_veh and ut.PermissionTools.dppa.ok(dppa_purpose_x)));
		
    r_j_vehicleparty := JOIN(in_veh_keys, keyVParty,
                KEYED(LEFT.Vehicle_key = RIGHT.Vehicle_key) AND
                KEYED(LEFT.Iteration_key = RIGHT.Iteration_key) AND
                KEYED(LEFT.Sequence_key = RIGHT.Sequence_key) and
								(include_non_regulated_data or right.source_code not in MDR.sourceTools.set_infutor_all_veh),
                get_parties_search (LEFT, RIGHT, aInputData, penalize_by_party),
                KEEP(Constant.PARTIES_PER_VEHICLE),
								LIMIT(0));
    					
  
 	 r_j := if(~isCNSMR, r_j_vehicleparty);

    pre_party_recs := UNGROUP(r_j(party_penalty <= penalty_threshold));

		MAC_JoinLatestDLAndPrePartyRecs(pre_party_recs, outputPrePartyRecs); 

    // add crim indicators
    recsIn := PROJECT(outputPrePartyRecs,TRANSFORM({rec_party,STRING12 UniqueId},SELF.UniqueId:=LEFT.append_did,SELF:=LEFT));
    CriminalRecords_Services.MAC_Indicators(recsIn,recsOut);
    pre_party_recs1 := IF(aInputData.IncludeCriminalIndicators,PROJECT(recsOut,rec_party),outputPrePartyRecs);

		commonParam := MODULE(PROJECT(aInputData, VehicleV2_Services.IParam.reportParams,opt)) END;
		
		return GetRolledView (pre_veh_recs1, pre_party_recs1, commonParam, false);
  END;

MAC_SetPersonOrBusiness(childRecord):= MACRO    
  childRecord.UniqueId := L.append_did;
	childRecord.Name := iesp.ECL2ESP.SetName (L.fname, L.mname, L.lname, L.name_suffix, '');
  childRecord.Address := iesp.ECL2ESP.SetAddress (L.prim_name, L.prim_range, L.predir, L.postdir, L.addr_suffix,
                                    L.unit_desig, L.sec_range, L.v_city_name, L.st, L.zip5, L.zip4, L.county_name);
  childRecord.SSN := L.Orig_SSN;
  childRecord.AppendSSN := L.append_ssn;
	childRecord.DriverLicenseNumber := L.Orig_DL_Number;
	childRecord.Gender := L.orig_sex_desc;
	childRecord.DOB := iesp.ECL2ESP.toDate ((integer4) L.Orig_DOB);	
	childRecord.BusinessName := L.Append_Clean_CName;
  childRecord.BusinessId := L.append_bdid;  
	childRecord.SurnameMatch := L.matchFlags.surnameFlag='Y';
	childRecord.FullNameMatch := L.matchFlags.fullNameFlag='Y';
	childRecord.AddressMatch := L.matchFlags.addressMatchFlag='Y';
	childRecord.HasCriminalConviction := L.HasCriminalConviction;
	childRecord.IsSexualOffender := L.IsSexualOffender;
ENDMACRO;

export transform_vehicles (dataset (VehicleV2_Services.Layout_Report) vehi) := function


	iesp.motorvehicle.t_MotorVehicleSearchRegistrant SetRecordRegistrants (VehicleV2_Services.Layouts.Layout_registrant_New L) := TRANSFORM		
		SELF.HistoryDescription := L.history_desc;
		MAC_SetPersonOrBusiness(SELF.RegistrantInfo);		
		SELF.RegistrantInfo.NameSource := L.name_source;
    SELF.RegistrantInfo.ReportedName := L.reported_name;
		SELF.RegistrationInfo.TrueLicensePlate := L.reg_true_license_plate;
		SELF.RegistrationInfo.LicenseState := L.reg_license_state;
		SELF.RegistrationInfo.FirstDate := iesp.ECL2ESP.toDatestring8(L.reg_first_date);
		SELF.RegistrationInfo.EarliestEffectiveDate := iesp.ECL2ESP.toDatestring8(L.reg_earliest_effective_date);
		SELF.RegistrationInfo.LatestEffectiveDate := iesp.ECL2ESP.toDatestring8(L.reg_latest_effective_date);
		SELF.RegistrationInfo.LatestExpirationDate := iesp.ECL2ESP.toDatestring8(L.reg_latest_expiration_date);
		SELF.RegistrationInfo.LicensePlate := L.Reg_License_Plate;
		SELF.RegistrationInfo.LicensePlateTypeCode := L.Reg_License_Plate_Type_Code;
		SELF.RegistrationInfo.LicensePlateTypeDesc := L.Reg_License_Plate_Type_Desc;
		SELF.RegistrationInfo.PreviousLicensePlate := L.reg_previous_license_plate;
		SELF.RegistrationInfo.PreviousLicenseState := L.reg_previous_license_state;
	
		SELF.VendorInfo.FirstReportedDate := iesp.ECL2ESP.toDateYM(L.date_vendor_first_reported);
		SELF.VendorInfo.LastReportedDate := iesp.ECL2ESP.toDateYM(L.date_vendor_last_reported);
		SELF.TitleIssueDate := iesp.ECL2ESP.toDatestring8(L.title_issue_date);
    SELF.TitleNumber := L.title_number;
	END;

	iesp.motorvehicle.t_MotorVehicleSearchOwner SetRecordOwners (VehicleV2_Services.Layouts.Layout_owner L) := TRANSFORM
		SELF.HistoryDescription := L.history_desc;
		
		MAC_SetPersonOrBusiness(SELF.OwnerInfo);
		SELF.OwnerInfo.NameSource := '';
    SELF.OwnerInfo.ReportedName := L.reported_name;
		SELF.TitleInfo.Number := L.Ttl_Number;
		SELF.TitleInfo.EarliestIssueDate := iesp.ECL2ESP.toDatestring8(L.ttl_earliest_issue_date) ;
		SELF.VendorInfo.FirstReportedDate := iesp.ECL2ESP.toDateYM(L.date_vendor_first_reported);
		SELF.VendorInfo.LastReportedDate := iesp.ECL2ESP.toDateYM(L.date_vendor_last_reported);
		SELF.SourceDateFirstSeen := iesp.ECL2ESP.toDatestring8(L.SRC_FIRST_DATE) ;
		SELF.SourceDateLastSeen := iesp.ECL2ESP.toDatestring8(L.SRC_LAST_DATE) ;
	END;
	
	iesp.motorvehicle.t_MotorVehicleSearchLienHolder setRecordLienHolders(VehicleV2_Services.Assorted_Layouts.Layout_lienholder L) := TRANSFORM
		SELF.HistoryDescription := L.history_desc;
		MAC_SetPersonOrBusiness(SELF.LienHolderInfo);
    SELF.LienHolderInfo.ReportedName := '';
		SELF.LienHolderInfo.NameSource := L.name_source;
		SELF.LienDate := iesp.ECL2ESP.toDatestring8(L.orig_lien_date);
		SELF.StandardizedName := L.std_lienholder_name;
	END;
	
	iesp.motorvehicle.t_MotorVehicleSearchLessee SetRecordLessees(VehicleV2_Services.Assorted_Layouts.Layout_lessee L) := TRANSFORM
	  SELF.HistoryDescription := L.History_desc;
		MAC_SetPersonOrBusiness(SELF.LesseeInfo);
		SELF.LesseeInfo.NameSource := '';
    SELF.LesseeInfo.ReportedName := '';
	END;
	
	iesp.motorvehicle.t_MotorVehicleSearchLessor SetRecordLessors(VehicleV2_Services.Assorted_Layouts.layout_lessee_or_lessor L) := TRANSFORM
		SELF.HistoryDescription := L.History_desc;
		MAC_SetPersonOrBusiness(SELF.LessorInfo);
		SELF.LessorInfo.NameSource := L.name_source;
    SELF.LessorInfo.ReportedName := '';
	END;
	
	iesp.motorvehicle.t_MotorVehicleSearchBrand SetRecordBrand(VehicleV2_Services.Assorted_Layouts.layout_brand L) := TRANSFORM
		SELF.Date := iesp.ECL2ESP.toDatestring8(L.Brand_Date);			
		SELF.State := L.Brand_State;		
		SELF.Code := L.Brand_Code;
		SELF._Type := L.Brand_Type;		
	END;
	
	iesp.motorvehicle.t_MotorVehicleSearch2Record toOutRecord (VehicleV2_Services.Layout_Report L) := TRANSFORM
	
		SELF.DataSource := L.DataSource;
		SELF.ExternalKey := (String)l.Vehicle_Key+l.Iteration_Key+l.Sequence_Key;
		SELF.AlsoFound := L.is_deep_dive;
		SELF.NonDMVSource := L.NonDMVSource;		
		SELF.VehicleInfo := PROJECT(L, TRANSFORM(iesp.motorvehicle.t_MotorVehicleSearchVehicleInfo,
			SELF.VehicleRecordId := LEFT.Vehicle_Key;
			SELF.IterationKey := LEFT.iteration_key;
			SELF.SequenceKey := LEFT.sequence_key;
			SELF.VIN := LEFT.Vin;
			SELF.YearMake := (INTEGER4)LEFT.model_year;
			SELF.Make := LEFT.make_desc;
			SELF.Model := LEFT.model_desc;
			//SELF.Series := LEFT.vina_vp_series;
			SELF.Series := LEFT.series_desc;
			SELF.MajorColor := LEFT.major_color_desc;
			SELF.MinorColor := LEFT.minor_color_desc;
			SELF._Type := LEFT.vehicle_type_desc;
			SELF.Style := LEFT.body_style_desc;
			SELF.StateOfOrigin := LEFT.state_origin;			
			SELF.MatchCode := LEFT.matchCode;							
		));
		
		SELF.MatchedParty := PROJECT(L.matched_party, TRANSFORM(iesp.motorvehicle.t_MotorVehicleSearchMatchedParty, 
			//SELF.UniqueId := ;
			SELF.OriginName := LEFT.Orig_Name;
			SELF.OriginNameType := LEFT.orig_name_type;
			//SELF.SSN := ;
			//SELF.AppendSSN := ;
			SELF.Name := iesp.ECL2ESP.SetName(LEFT.fname, LEFT.mname, LEFT.lname, LEFT.name_suffix, '');
			SELF.Address := iesp.ECL2ESP.SetAddress (LEFT.prim_name, LEFT.prim_range, LEFT.predir, LEFT.postdir, LEFT.addr_suffix,
                                               LEFT.unit_desig, LEFT.sec_range, LEFT.v_city_name, LEFT.st, LEFT.zip5, LEFT.zip4, '');

			//SELF.DriverLicenseNumber := };
			//SELF.Gender := ;
			//share.t_Date DOB := ;
			//SELF.BusinessName := ;
			//SELF.BusinessId := ;
			self := [];			
		));
		 self.registrants := project (choosen (L.registrants, iesp.Constants.MV.MaxCountRegistrants), SetRecordRegistrants(Left));		
		
		 self.owners := project (choosen (L.owners, iesp.Constants.MV.MaxCountOwners), setRecordOwners(Left));
		 self.lienHolders := project (choosen (L.LienHolders, iesp.Constants.MV.MaxCountLienHolders), setRecordLienHolders(Left));
		 self.Lessees := project (choosen (L.Lessees, 1), SetRecordLessees(Left));
		 self.Lessors := project (choosen (L.lessors, 1), SetRecordLessors(Left));
		 self.Brands := project(choosen(L.brands, iesp.Constants.MV.MaxCountBrands), SetRecordBrand(Left));
		self := [];
	end;


RETURN PROJECT (vehi, toOutRecord(Left));

END;


export VehicleV2_Services.Layout_Report RemoveLatLong(VehicleV2_Services.Layout_Report L) := transform
	self.registrants := project(L.registrants, transform(VehicleV2_Services.assorted_layouts.layout_registrant, 
	                                                     self.geo_lat := '', self.geo_long := '', self := left));
																													
	self.owners      := project(L.owners,      transform(VehicleV2_Services.Layouts.Layout_owner, 
	                                                     self.geo_lat := '', self.geo_long := '', self := left));
																													
	self.lienholders := project(L.lienholders, transform(VehicleV2_Services.assorted_Layouts.Layout_lienholder, 
	                                                     self.geo_lat := '', self.geo_long := '', self := left));
																													
	self.lessees     := project(L.lessees,     transform(VehicleV2_Services.assorted_Layouts.layout_lessee, 
	                                                     self.geo_lat := '', self.geo_long := '', self := left));
																													
	self.lessors     := project(L.lessors,     transform(VehicleV2_Services.assorted_Layouts.layout_lessee_or_lessor, 
	                                                     self.geo_lat := '', self.geo_long := '', self := left));
																													 
	self := L;
end;	


END;
