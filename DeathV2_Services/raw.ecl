import doxie, ut, suppress, death_master, census_data, _validate, codes, AutoStandardI, STD, MDR;

export raw := 
MODULE

shared rec := deathv2_services.layouts;
shared deathparams := DeathV2_Services.IParam.GetDeathRestrictions(AutoStandardI.GlobalModule());
shared glb_ok := ut.glb_ok(deathparams.glbpurpose);
shared appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));

//****** GET DEATH IDS

export get_death_ids := 
MODULE
	export rec.death_id FROM_DIDS(
		dataset(doxie.layout_references) dids,
		boolean checkRNA=false) := 
	FUNCTION
	  loc_glb_ok := ut.glb_ok(deathparams.glbpurpose,checkRNA);
		key := doxie.key_death_masterV2_ssa_DID;
		res := join(dedup(dids, all),key,
									keyed(left.did = right.l_did)
									 and	not DeathV2_Services.functions.Restricted(right.src, right.glb_flag, loc_glb_ok, deathparams), 	
									transform(rec.death_id,
														self := right),
									keep(ut.limits.DEATH_PER_DID), limit (0))(state_death_id <> '');		
		return dedup(res, all);
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
		key := Death_Master.key_death_id_base_ssa;		
		jnd := join(dedup(ids, all),key,
									keyed(left.state_death_id = right.state_death_id)
									and	not DeathV2_Services.functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
									transform(rec.base_internal,
														self.dead_age := ut.Age((unsigned8)right.dob8, (unsigned8)right.dod8),
														self.dead_age_unit := '',
														self.county_name := '',
														self.death_location := '',
														self.base.did := if((unsigned)right.did > 0, right.did, ''),
														self.base := right,
														self.src := right.src,
														self := left),
									keep(1), limit(0)); // m:1
		
	  census_data.MAC_Fips2County_Keyed(jnd,base.state,base.fipscounty,county_name,wct);
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
 
 prim_decode			:= stringlib.StringToUpperCase(Codes.KeyCodes('DEATH_MASTER','INTERNATIONAL_CLASSIFICATION_OF_DISEASES',,ut.word(prim_code,1,';')));			
 under_decode1		:= stringlib.StringToUpperCase(Codes.KeyCodes('DEATH_MASTER','INTERNATIONAL_CLASSIFICATION_OF_DISEASES',,underlying_cause(prim_code,under_code,1)));
 under_decode2 		:= stringlib.StringToUpperCase(Codes.KeyCodes('DEATH_MASTER','INTERNATIONAL_CLASSIFICATION_OF_DISEASES',,underlying_cause(prim_code,under_code,2)));
 under_decode3 		:= stringlib.StringToUpperCase(Codes.KeyCodes('DEATH_MASTER','INTERNATIONAL_CLASSIFICATION_OF_DISEASES',,underlying_cause(prim_code,under_code,3)));
 
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
		key := Death_Master.key_death_id_supplemental_ssa;
		sea := get_base.from_death_ids(ids, ssn_mask_value);

	  //some date formatting code
		val(string date) := _Validate.Date.fIsValid(date,,true,true);
		string8 flipdate(string8 indate) := indate[5..8] + indate[1..4];
	
		mac_fixdate(date) := macro
			self.supp.date := map(val(right.date)							=> right.date,
													  val(flipdate(right.date))		=> flipdate(right.date),
													  ''),
		endmacro;
	
		//join to supp key
		jnd := join(sea, key,
									keyed(left.state_death_id = right.state_death_id),
									transform(rec.report_internal,
														self.dead_age := if(right.decedent_age = '', 
																								left.dead_age,
																								DeathV2_Services.splitAge(right.decedent_age).int);
														self.dead_age_unit := 
																						 if(right.decedent_age = '' and left.dead_age > 0,
																								'YEARS',
																								DeathV2_Services.splitAge(right.decedent_age).unit);
														SELF.IsLimitedAccessDMF := (left.src = MDR.sourceTools.src_Death_Restricted);
														self.supp.state_death_flag := if(right.source_state in death_master.Constants('').set_EmptySuppStates,
																													   '', 
																														 right.state_death_flag);
														self.death_location := 
															map(right.hospital_status <> '' and right.place_of_death <> '' 	=> trim(right.hospital_status) + ', ' + trim(right.place_of_death),
																  right.hospital_status <> '' 																=> right.hospital_status,
																																																 right.place_of_death);
														self.supp.cause_of_death := fn_cause_of_death(right.CAUSE,right.PRIMARY_CAUSE_OF_DEATH,right.UNDERLYING_CAUSE_OF_DEATH);
														mac_fixdate(process_date)
														 mac_fixdate(filed_date)
														 mac_fixdate(disposition_date)
														 mac_fixdate(injury_date)
														 mac_fixdate(surgery_date)
														 mac_fixdate(date_last_trans)										
														self.supp := right,
														self := left),
									left outer,
									keep(1));
	
	
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