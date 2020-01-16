import AutoStandardI, _validate, census_data, codes, death_master, doxie, dx_death_master,
       MDR, STD, suppress, ut;

export raw := 
MODULE

shared rec := deathv2_services.layouts;
shared death_params := DeathV2_Services.IParam.GetDeathRestrictions(AutoStandardI.GlobalModule());
shared appType := death_params.application_type;

//****** GET DEATH IDS

export get_death_ids := 
MODULE
	export rec.death_id FROM_DIDS(
		dataset(doxie.layout_references) dids,
		boolean checkRNA=false) := 
	FUNCTION
    loc_glb_ok := death_params.isValidGlb(checkRNA); 
    death_raw_recs := dx_death_master.Get.byDid(dedup(dids, all), did, death_params, /*skip_glb_check=*/TRUE, ut.limits.DEATH_PER_DID);
    death_raw_recs_glb_ok := death_raw_recs(loc_glb_ok OR death.glb_flag <> 'Y');
    res := 
      PROJECT(death_raw_recs_glb_ok(death.state_death_id <> ''), 
        TRANSFORM(rec.death_id, 
        SELF := LEFT.death));

		RETURN DEDUP(res, ALL);
	END;
END;

//****** GET BASE

shared get_base := 
MODULE
	export rec.base_internal FROM_DEATH_IDS(
		dataset(rec.death_id) ids,
		string ssn_mask_value								
		) := 
	FUNCTION
		death_ids := dedup(ids, all);
	  death_raw := dx_death_master.Get.byDeathId(death_ids, state_death_id, death_params);
    death_recs := project(death_raw, transform(rec.base_internal,
      self.dead_age := ut.Age((unsigned8)left.death.dob8, (unsigned8)left.death.dod8);
      self.dead_age_unit := '';
      self.county_name := '';
      self.death_location := '';
      self.base.did := if((unsigned)left.death.did > 0, left.death.did, '');
      self.base := left.death;
      self.src := left.death.src;
	  // establishing this flag earlier since IsLimitedAccessDMF is included in output layout
	  self.IsLimitedAccessDMF := left.death.src = MDR.sourceTools.src_Death_Restricted;	
      self := left));

	  census_data.MAC_Fips2County_Keyed(death_recs,base.state,base.fipscounty,county_name,wct);

    return dedup(wct, all);
	END;


END;

//****** GET REPORT IN INTERNAL LAYOUT WHICH SHOWS WHAT FILE PRODUCED EACH FIELD

//These two FNs for population the cause_of_death field

shared fn_cause_of_death(string cause, string prim_code, string under_code) := 
FUNCTION

 underlying_cause(string pcd, string ucd, unsigned2 pos) := //shift when the pcd = ucd1
 FUNCTION
	same := ut.Word(ucd,1,';') = pcd;
	adjustment := if(same, 1, 0);
	
	return ut.Word(ucd,pos + adjustment,';');
 END;
 
 prim_decode			:= STD.STR.ToUpperCase(Codes.KeyCodes('DEATH_MASTER','INTERNATIONAL_CLASSIFICATION_OF_DISEASES',,ut.word(prim_code,1,';')));			
 under_decode1		:= STD.STR.ToUpperCase(Codes.KeyCodes('DEATH_MASTER','INTERNATIONAL_CLASSIFICATION_OF_DISEASES',,underlying_cause(prim_code,under_code,1)));
 under_decode2 		:= STD.STR.ToUpperCase(Codes.KeyCodes('DEATH_MASTER','INTERNATIONAL_CLASSIFICATION_OF_DISEASES',,underlying_cause(prim_code,under_code,2)));
 under_decode3 		:= STD.STR.ToUpperCase(Codes.KeyCodes('DEATH_MASTER','INTERNATIONAL_CLASSIFICATION_OF_DISEASES',,underlying_cause(prim_code,under_code,3)));
 
 sep := '; ';
 dec := map(cause = '' and 
						prim_code = '' and 
						under_code = ''				=> '',										//blank if no data
						cause <> ''						=> cause,									//use cause if provided
																	   trim(prim_decode) + 		//otherwise decode and slap these together
																		 if(under_decode1 <> '', sep + trim(under_decode1), '') +
																		 if(under_decode2 <> '', sep + trim(under_decode2), '') +
																		 if(under_decode3 <> '', sep + trim(under_decode3), ''));

	return if(dec[1] = sep[1], dec[3..], dec);	//pull off the ; when prim was blank and under was not

END;


shared get_report_internal := 
MODULE
	export rec.report_internal FROM_DEATH_IDS(
		dataset(rec.death_id) ids,
		string ssn_mask_value
		) := 
	FUNCTION
    sea := get_base.from_death_ids(ids, ssn_mask_value);
	
    state_death_ids_ddp := dedup(sort(project(sea, transform(rec.death_id, SELF := LEFT)), 
      state_death_id), state_death_id);
    supp_recs := dx_death_master.Append.supplementalByDeathId(state_death_ids_ddp, state_death_id);

		jnd := join(sea, supp_recs,
									left.state_death_id = right.state_death_id,
									transform(rec.report_internal,
														death_supp := right.death_supp; 
														self.dead_age := if(death_supp.decedent_age = '', 
																								left.dead_age,
																								DeathV2_Services.splitAge(death_supp.decedent_age).int);
														self.dead_age_unit := 
																						 if(death_supp.decedent_age = '' and left.dead_age > 0,
																								'YEARS',
																								DeathV2_Services.splitAge(death_supp.decedent_age).unit);
														self.supp.state_death_flag := if(death_supp.source_state in death_master.Constants('').set_EmptySuppStates,
																													   '', 
																														 death_supp.state_death_flag);
														self.death_location := 
															map(death_supp.hospital_status <> '' and death_supp.place_of_death <> '' 	=> trim(death_supp.hospital_status) + ', ' + trim(death_supp.place_of_death),
																  death_supp.hospital_status <> '' 																=> death_supp.hospital_status,
																																																 death_supp.place_of_death);
														self.supp.cause_of_death := fn_cause_of_death(death_supp.CAUSE,death_supp.PRIMARY_CAUSE_OF_DEATH,death_supp.UNDERLYING_CAUSE_OF_DEATH);							
														self.supp := death_supp,
														self := left),
									left outer,
									keep(1), limit(0));
	
		//*** PULL
		Suppress.MAC_Suppress(jnd,pl1,appType,Suppress.Constants.LinkTypes.DID,base.DID);
		Suppress.MAC_Suppress(pl1,pl2,appType,Suppress.Constants.LinkTypes.SSN,base.ssn);
		Suppress.MAC_Suppress(pl2,pl3,appType,Suppress.Constants.LinkTypes.SSN,supp.ssn);
		
		//*** ADD ADDR COUNTY NAME AND PICK A COUNTY_NAME TO USE AT TOP LEVEL
		census_data.MAC_Fips2County_Keyed(pl3,base.state,base.fipscounty,county_name,wct1);
		wct2 := project(wct1, transform(rec.report_internal,
																		self.county_name := map(left.county_name <> ''			=> left.county_name,
																														left.supp.county_residence);
																		self := left));
		
		//*** PENALIZE
		pen := project(wct2, transform(rec.report_internal,
			tempmodaddr := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
				export boolean allow_wildcard := false;
				export string city_field := left.supp.v_city_name;
				export string city2_field := '';
				export string pname_field := left.supp.prim_name;
				export string postdir_field := left.supp.postdir;
				export string prange_field := left.supp.prim_range;
				export string predir_field := left.supp.predir;
				export string state_field := if(left.supp.state='',left.base.state,left.supp.state);
				export string suffix_field := left.supp.addr_suffix;
				export string zip_field := if(left.supp.zip5='',left.base.zip_lastres,left.supp.zip5);
			end;
			tempmoddid := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_DID.full,opt))
				export string did_field := left.base.did;
			end;
			tempmodssn := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_SSN.full,opt))
				export string ssn_field := left.base.ssn;
			end;
			tempmodindvname := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
				export boolean allow_wildcard := false;
				export string fname_field := left.base.fname;
				export string lname_field := left.base.lname;
				export string mname_field := left.base.mname;
			end;
			tempmoddob := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_DOB.full,opt))
				export string dob_field := left.base.dob8;
			end;
			tempmoddod := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_DOD.full,opt))
				export string dod_field := left.base.dod8;
			end;
			self.penalt := AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmodaddr) +
										 AutoStandardI.LIBCALL_PenaltyI_DID.val(tempmoddid) +
										 AutoStandardI.LIBCALL_PenaltyI_SSN.val(tempmodssn) +
										 AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmodindvname) +
										 AutoStandardI.LIBCALL_PenaltyI_DOB.val(tempmoddob) +
										 AutoStandardI.LIBCALL_PenaltyI_DOD.val(tempmoddod);
			self := left));
		//*** MASK																						 
		suppress.MAC_Mask(pen,  msk1, base.ssn, '', true, false);
		suppress.MAC_Mask(msk1, msk2, supp.ssn, '', true, false);

		return msk2;
	END;
END;
	
	//****** GET REPORT IN EXTERNAL, COMPLETELY FLAT LAYOUT

export get_report := 
MODULE
	export rec.report_external FROM_DEATH_IDS(
		dataset(rec.death_id) ids,
		string ssn_mask_value
		) := 
	FUNCTION
		int := get_report_internal.FROM_DEATH_IDS(ids, ssn_mask_value);
		ext := project(int, transform(rec.report_external,
																	self.state_death_flag := left.supp.state_death_flag,
																	self := left.base,
																	self := left.supp,
																	self.IsLimitedAccessDMF_supp := (left.supp.dod != '') and left.IsLimitedAccessDMF,
																	self.st := left.base.state,
		               self.IsLimitedAccessDMF := left.IsLimitedAccessDMF;  
																self := left));
													
		return ext;
	END;
	
	export rec.report_external FROM_DIDS(
		dataset(doxie.layout_references) dids,
		string ssn_mask_value								
		) := 
	FUNCTION
		ids := get_death_ids.FROM_DIDS(dids);
		rep := FROM_DEATH_IDS(ids, ssn_mask_value);
		return rep;	
	END;
END;

END;