import doxie, suppress, Census_Data, ut, watercraft, AutoStandardI, fcra, FFD, WatercraftV2_Services;

EXPORT get_owners(dataset(WatercraftV2_Services.layouts.owner_raw_rec) owner_key_recs, 
									string in_ssn_mask_type,
									boolean IsFCRA = false) := MODULE

	// it is expected that FCRA compliance like suppressions/DUD was already applied to input owner_key_recs
	shared int_rec := WatercraftV2_Services.Layouts.int_raw_rec;

	export report(boolean isReport = false) := FUNCTION 
				
				ms := WatercraftV2_Services.Functions.ms;
				
				doxie.MAC_Header_Field_Declare(IsFCRA); // need it just for dppa_purpose and penalty-stuff

				WatercraftV2_Services.Layouts.owner_raw_rec get_report(WatercraftV2_Services.Layouts.owner_raw_rec r) := transform
						self.did := if((unsigned6) r.did = 0,'', r.did);
						self.bdid := if((unsigned6) r.bdid = 0,'', r.bdid);
						//Why do we need penalty calculation in the report??? 
						//-> penalty calculation in report because of possible search by name and address, see WatercraftReportService_ids.
						self.penalt:= if (IsFCRA or isReport, 0,
															doxie.FN_Tra_Penalty_DID((string) r.did) +
															doxie.FN_Tra_Penalty_SSN(ms(r.orig_ssn,r.ssn,ssn_value)) +
															doxie.FN_Tra_Penalty_Name(r.fname,r.mname,r.lname) +
															doxie.FN_Tra_Penalty_Addr(r.predir,r.prim_range,r.prim_name,
																r.suffix,r.postdir,r.sec_range,ms(r.p_city_name,r.v_city_name,city_value),ms(r.st,r.state_origin,state_value),r.zip5) +
															doxie.Fn_Tra_Penalty_Phone(ms(r.phone_1,r.phone_2,phone_value)) +
															doxie.FN_Tra_Penalty_DOB(r.dob) +
															doxie.FN_Tra_Penalty_BDID(r.bdid) +
															doxie.FN_Tra_Penalty_FEIN(ms(r.orig_fein,r.fein,fein_val)) +
															doxie.FN_Tra_Penalty_CNAME(r.company_name));
						self := r;	
				end;
				
				report_recs_raw := project(owner_key_recs, get_report(left));

				report_recs_srt := sort(report_recs_raw((watercraft.sDPPA_ok(state_origin,dppa_purpose) or dppa_flag='N') and penalt<6), subject_did, state_origin, watercraft_key, sequence_key,penalt, fname,mname,lname,company_name,did,-date_last_seen);
				report_recs_dep := dedup(report_recs_srt, subject_did, state_origin, watercraft_key, sequence_key,penalt,fname,mname,lname,company_name,did);

				Census_Data.MAC_Fips2County_Keyed(report_recs_dep, st, county, county_name, owner_recs_unmsk)

				Suppress.MAC_Suppress(owner_recs_unmsk,did_pulled,application_type_value,Suppress.Constants.LinkTypes.DID,did);
				Suppress.MAC_Suppress(did_pulled,ssn_pulled,application_type_value,Suppress.Constants.LinkTypes.SSN,ssn);

				// cannot use pullSSN in fcra-side:
				ssn_clean := if (IsFCRA, owner_recs_unmsk, ssn_pulled);
				suppress.mac_mask(ssn_clean, owner_recs_0, ssn, blank, true, false, maskVal:=in_ssn_mask_type);
				suppress.mac_mask(owner_recs_0, owner_recs_1, orig_ssn, blank, true, false, maskVal:=in_ssn_mask_type);
								
				int_rec rollowners(int_rec l,dataset(int_rec) r):=transform
					self.owners := Choosen(Normalize(r,left.owners, Transform(RIGHT)),ut.limits.MAX_WATERCRAFT_OWNERS);
					self :=l;
				END;

				sorted_owner :=  sort(project(owner_recs_1,transform(int_rec,
																self.owners := project(left,
																											transform(WatercraftV2_Services.Layouts.owner_report_rec,
																															 self:=left)),
																self :=left)), subject_did, state_origin,watercraft_key,sequence_key,penalt,-date_last_seen);
																
				grouped_owners :=group(sorted_owner, subject_did, state_origin,watercraft_key,sequence_key);
				pre_owner_recs_report := rollup(grouped_owners,GROUP,
																rollowners(left,rows(left)));	
																
				owner_recs_report := project(pre_owner_recs_report,transform(int_rec,self.owners:=dedup(sort(left.owners,lname,fname,record),lname,fname,record),self:=left));
		
				RETURN owner_recs_report;
		END;


		export search() := FUNCTION 
				
				outrec			:= WatercraftV2_Services.Layouts.search_out;
				inner_params	:= WatercraftV2_Services.Interfaces.ak_params;
				gm				:= AutoStandardI.GlobalModule(IsFCRA);

				temp_mod_one := module(project(gm,inner_params,opt)) end;
				
				temp_mod_two := module(project(gm,inner_params,opt))
					export firstname := gm.entity2_firstname;
					export middlename := gm.entity2_middlename;
					export lastname := gm.entity2_lastname;
					export unparsedfullname := gm.entity2_unparsedfullname;
					export allownicknames := gm.entity2_allownicknames;
					export phoneticmatch := gm.entity2_phoneticmatch;
					export companyname := gm.entity2_companyname;
					export addr := gm.entity2_addr;
					export city := gm.entity2_city;
					export state := gm.entity2_state;
					export zip := gm.entity2_zip;
					export zipradius := gm.entity2_zipradius;
					export phone := gm.entity2_phone;
					export fein := gm.entity2_fein;
					export bdid := gm.entity2_bdid;
					export did := gm.entity2_did;
					export ssn := gm.entity2_ssn;
				end;
				
				doxie.MAC_PruneOldSSNs(owner_key_recs, owners_rec_pruned1, ssn, did, isFCRA);
				doxie.MAC_PruneOldSSNs(owners_rec_pruned1, owners_rec_pruned, orig_ssn, did, isFCRA);
				
				WatercraftV2_Services.Layouts.owner_raw_rec get_owners(WatercraftV2_Services.Layouts.owner_raw_rec r) :=transform
					pre_orig_ssn := r.orig_ssn;
					pre_ssn := r.ssn;
					self.did := if((unsigned6) r.did = 0,'', r.did);
					self.bdid := if((unsigned6) r.bdid = 0,'', r.bdid);
					temp_mod_one_penalty := WatercraftV2_Services.Functions.CalculatePenalty(temp_mod_one, r, pre_orig_ssn, pre_ssn);
					temp_mod_two_penalty := WatercraftV2_Services.Functions.CalculatePenalty(temp_mod_two, r, pre_orig_ssn, pre_ssn);												
					self.penalt := if(isFCRA, 0, if(gm.TwoPartySearch,max(temp_mod_one_penalty,temp_mod_two_penalty),temp_mod_one_penalty));
					self :=r;
				END;
				dppa_purpose := AutoStandardI.InterfaceTranslator.DPPA_Purpose.val(PROJECT(gm, AutoStandardI.InterfaceTranslator.DPPA_Purpose.params));

				search_recs_raw0 := project(owners_rec_pruned, get_owners(left));
																
				Suppress.MAC_Mask(search_recs_raw0, search_recs_raw1, ssn, null, true, false, maskVal:=in_ssn_mask_type);
				Suppress.MAC_Mask(search_recs_raw1, search_recs_raw, orig_ssn, null, true, false, maskVal:=in_ssn_mask_type);

				search_recs_srt := sort(search_recs_raw(watercraft.sDPPA_ok(state_origin,dppa_purpose) or dppa_flag='N'), state_origin, watercraft_key, sequence_key,penalt,fname,mname,lname,company_name,name_suffix,did,-date_last_seen);
				search_recs_dep := dedup(search_recs_srt, state_origin, watercraft_key, sequence_key,penalt,fname,mname,lname,company_name,name_suffix,did);

				Census_Data.MAC_Fips2County_Keyed(search_recs_dep, st, county, county_name, owner_recs_unmsk)

				outrec rollowners(outrec l,dataset(outrec) r):=transform
					self.owners := Choosen(Normalize(r,left.owners, Transform(RIGHT)),ut.limits.MAX_WATERCRAFT_OWNERS);
					self.StatementIDs := [];
					self.isDisputed := false; 
					self :=l;
				END;

				sorted_owner_recs := sort(project(owner_recs_unmsk,transform(outrec,
																					self.owners := project(left,transform(WatercraftV2_Services.Layouts.owner_search_rec,
																																								self:=left)),
																					self :=left,
																					self :=[])),
																	state_origin,watercraft_key,sequence_key);

				owner_recs_search := rollup(group(sorted_owner_recs,state_origin,watercraft_key,sequence_key),
																		group,
																		rollowners(left,rows(left)));	

				RETURN owner_recs_search;
		END;
		
END;