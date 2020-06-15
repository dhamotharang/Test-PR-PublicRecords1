import AutoStandardI, AutoHeaderI, doxie, iesp, ut, suppress;
		
export Raw := module
		
	// ==========================================================================
  // Returns header records in search view
  // ==========================================================================

	export SEARCH_VIEW := MODULE
		export params := interface(
			AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,
			AutoStandardI.InterfaceTranslator.score_threshold_value.params,
			AutoStandardI.InterfaceTranslator.StrictMatch_value.params,
			AutoStandardI.InterfaceTranslator.addr_suffix_value.params,
			AutoStandardI.InterfaceTranslator.all_dids.params,
      doxie.IDataAccess)
      export string DataPermissionMask := ''; //conflicting definition; instead of '00000000000000' as in AutoStandardI.Constants.DataPermissionMask_default
			export includeSSNHri := false;
			export includeAddrHri := false;
			export includePhoneHri := false;
			export allowPartialSSNMatch := false;
			export allowEditDist := false;
			export IncludeAlternatePhonesCount := false;
		  export IncludePhonesPlus := false;
	  end;
		
		//Returns records
		export byDID(dataset(doxie.layout_references_hh) in_dids, params in_mod) := FUNCTION

			// needed for the macros below
			ssn_mask_value := in_mod.ssn_mask;
			phone_value := AutoStandardI.InterfaceTranslator.phone_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.phone_value.params));
			unsigned1 maxHriPer_value := 10;
		
			dids_d := dedup(sort(in_dids,did),did);

			allDIDRecs := Functions.allDidRecs.val(project(in_mod, Functions.allDidRecs.params));
			ageOrDob := Functions.ageOrDob.val(project(in_mod, Functions.ageOrDob.params));
			ssn_value := AutoStandardI.InterfaceTranslator.ssn_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.ssn_value.params));
			
			// only do gong fetch by DID if age/dob entered (and not getting AllDIDRecords)
			gongByDIDOnly := (ageOrDob or ssn_value <> '') and not AllDIDRecs;  
			pre_recs := doxie.header_records_byDID(dids_d, true, false,,false,allDIDRecs,true,not AllDIDRecs,gongByDIDOnly);
			
			// need to apply special filtering based on presence of input criteria
			filt_recs := Functions.filterRecs.do(pre_recs, project(in_mod, Functions.filterRecs.params));

			// for phone searches, Moxie returns household members of the matched subjects
			// only get household matches for gong records
			add_recs := Functions.householdRecs(filt_recs(src = 'PH', did <> 0, listed_phone <> ''));
			all_recs := filt_recs + add_recs(phone_value <> '');
			
			// when searching by phone, only want current Gong matches appended that match the input phone
			
			base_recs := doxie.base_presentation(all_recs,phone_value);

			doxie.mac_AddHRISSN(base_recs, with_ssn_risk, false)
			ssn_risk_use := IF(in_mod.includeSSNHri, with_ssn_risk, base_recs);
			
			doxie.mac_AddHRIAddress(ssn_risk_use, with_addr_risk)
			addr_risk_use := IF(in_mod.includeAddrHri, with_addr_risk, ssn_risk_use);
      
			mod_access := PROJECT(in_mod, doxie.IDataAccess);			
			
			doxie.mac_AddHRIPhone(addr_risk_use, with_phone_risk, mod_access)
			phone_risk_use := IF(in_mod.includePhoneHri, with_phone_risk, addr_risk_use);

			hbr1 := doxie.header_base_rollup(phone_risk_use, mod_access);
			
			Layouts.HFS_wide Norm_phones(hbr1 L,integer cnt) := TRANSFORM
				in_ph := L.phones((match_type between 1 and 4) OR(match_type =5 and gong_score <=100));
				ph_cnt := EXISTS(in_ph);
				ph := in_ph[cnt];
				keep_ph := Functions.phoneMatch(ph.phone10,phone_value);
				SELF.phone := L.phone;
				SELF.timezone := L.timezone;
				SELF.listed_phone := IF(ph_cnt,if(keep_ph,ph.phone10,''),IF(L.phone<>'',L.listed_phone,''));
				SELF.listed_timezone := IF(ph_cnt,if(keep_ph,ph.timezone,''),IF(L.phone<>'',L.timezone,''));
				SELF.listed_name := IF(ph_cnt,if(keep_ph,ph.listed_name,''),IF(L.phone<>'',L.listed_name,''));
				SELF.listed_name_first 	:= 	IF(ph_cnt,'',IF(L.phone<>'',L.listed_name_first,''));
				SELF.listed_name_last 	:= 	IF(ph_cnt,'',IF(L.phone<>'',L.listed_name_last,''));
				SELF.listed_name_prefix := 	IF(ph_cnt,'',IF(L.phone<>'',L.listed_name_prefix,''));
				SELF.listed_name_middle := 	IF(ph_cnt,'',IF(L.phone<>'',L.listed_name_middle,''));
				SELF.listing_type_res := IF(ph_cnt,if(keep_ph,ph.listing_type_res,''),IF(L.phone<>'',L.listing_type_res,''));
				SELF.listing_type_bus := IF(ph_cnt,if(keep_ph,ph.listing_type_bus,''),IF(L.phone<>'',L.listing_type_bus,''));
				SELF.listing_type_gov := IF(ph_cnt,if(keep_ph,ph.listing_type_gov,''),IF(L.phone<>'',L.listing_type_gov,''));
				SELF.listing_type_cell := IF(ph_cnt,if(keep_ph,ph.listing_type_cell,''),IF(L.phone<>'',L.listing_type_cell,''));
				SELF.carrier := IF(ph_cnt,if(keep_ph,ph.carrier,''),L.carrier);
				SELF.carrier_city := IF(ph_cnt,if(keep_ph,ph.carrier_city,''),L.carrier_city);
				SELF.carrier_state := IF(ph_cnt,if(keep_ph,ph.carrier_state,''),L.carrier_state);
				SELF.PhoneType := IF(ph_cnt,if(keep_ph,ph.PhoneType,''),L.PhoneType); 
				SELF.phone_first_seen := IF(ph_cnt,if(keep_ph,ph.phone_first_seen,0),L.phone_first_seen);
				SELF.phone_last_seen := IF(ph_cnt,if(keep_ph,ph.phone_last_seen,0),L.phone_last_seen);
				SELF.caption_text := IF(ph_cnt,if(keep_ph,ph.caption_text,''),L.caption_text);
				SELF := L;
			END;
     
      hbr2 := NORMALIZE(hbr1,ut.max2(COUNT(LEFT.phones((match_type between 1 and 4) OR(match_type =5 and gong_score <=100))),1),Norm_phones(LEFT,counter));
  
	    //with the addition of phonesPlus, product also decided to not flatten rows with different phone numbers.
			hbr := if (in_mod.IncludePhonesPlus or in_mod.IncludeAlternatePhonesCount, hbr1, hbr2);		
			
			recs_ssn := Functions.add_ssn_issue(hbr);
			
			Suppress.MAC_Mask(recs_ssn, final_recs, ssn, null, true, false)

			// output(base_recs,		named('base_recs'));	// DEBUG
			// output(hbr1, 				named('hbr1'));				// DEBUG
			// output(hbr,					named('hbr'));				// DEBUG
			// output(recs_ssn, 		named('recs_ssn'));		// DEBUG
			// output(with_mask,		named('with_mask'));	// DEBUG
			// output(final_recs, 	named('final_recs'));	// DEBUG
			return final_recs;
		end;
	end;
	
	export ROLLUP_VIEW := MODULE
		export params := interface(
		  AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,
			AutoStandardI.InterfaceTranslator.score_threshold_value.params,
			AutoStandardI.InterfaceTranslator.StrictMatch_value.params,
			AutoStandardI.InterfaceTranslator.addr_suffix_value.params,
			AutoStandardI.InterfaceTranslator.all_dids.params,
      doxie.IDataAccess)
      export string DataPermissionMask := ''; //conflicting definition; instead of '00000000000000' as in AutoStandardI.Constants.DataPermissionMask_default
			export IncludeBankruptcies := false;
			export includeSSNHri := false;
			export includeAddrHri := false;
			export includePhoneHri := false;
			export allowPartialSSNMatch := false;
			export allowEditDist := false;
			export includeDailies := true;
			export reduceddata := false;
	  end;
		
		export byDID(dataset(doxie.layout_references_hh) in_dids, params in_mod, boolean incSourceDocCounts=false) := FUNCTION

			// needed for the macros below
			ssn_mask_value := in_mod.ssn_mask;
			phone_value := AutoStandardI.InterfaceTranslator.phone_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.phone_value.params));
			unsigned1 maxHriPer_value := 10;
			mod_access := PROJECT(in_mod, doxie.IDataAccess);
		
			dids_d := dedup(sort(in_dids,did),did);
			
			allDIDRecs := Functions.allDidRecs.val(project(in_mod, Functions.allDidRecs.params));
			ageOrDob := Functions.ageOrDob.val(project(in_mod, Functions.ageOrDob.params));
			ssn_value := AutoStandardI.InterfaceTranslator.ssn_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.ssn_value.params));
			
			// only do gong fetch by DID if age/dob entered (and not getting AllDIDRecords)
			gongByDIDOnly := (ageOrDob or ssn_value <> '') and not AllDIDRecs;  

			pre_recs := doxie.header_records_byDID(dids_d, in_mod.includeDailies, false,,false,allDidRecs,true,not AllDIDRecs,gongByDIDOnly);
			
			// need to apply special filtering based on presence of input criteria
			filt_recs := Functions.filterRecs.do(pre_recs, project(in_mod, Functions.filterRecs.params));

			// for phone searches, Moxie returns household members of the matched subjects
			// only get household matches for gong records
			add_recs := Functions.householdRecs(filt_recs(src = 'PH', did <> 0, listed_phone <> ''));
			all_recs := filt_recs + add_recs(phone_value <> '');

			// when searching by phone, only want current Gong matches appended that match the input phone
			base_recs := doxie.base_presentation(all_recs, phone_value, in_mod.reduceddata);

			doxie.mac_AddHRISSN(base_recs, with_ssn_risk, false)
			ssn_risk_use := IF(in_mod.includeSSNHri, with_ssn_risk, base_recs);
			
			doxie.mac_AddHRIAddress(ssn_risk_use, with_addr_risk)
			addr_risk_use := IF(in_mod.includeAddrHri, with_addr_risk, ssn_risk_use);
			
			doxie.mac_AddHRIPhone(addr_risk_use, with_phone_risk, mod_access);
			phone_risk_use := IF(in_mod.includePhoneHri, with_phone_risk, addr_risk_use);

			recs_ssn := Functions.add_ssn_issue(project(phone_risk_use,Layouts.HFS_wide));

			// compute rids with doccnt values
			//
			//   NOTE: This is similar to functionality in doxie.header_base_rollup that
			//         is called in the corresponding SEARCH_VIEW.byDID section above
			//
			recs_ssn addListings(recs_ssn L) := transform
				self.rids := if(
					L.did<>'' and L.phone<>'',
					dataset([doxie.makeRidRec(L.did+'PH'+L.phone, 'PH', 1)]),
					dataset([], doxie.Layout_Rollup.RidRec));
				self := L;
			end;
			with_listings := project(recs_ssn, addListings(left));
			doxie.Layout_Rollup.RidRecDid getRids(recs_ssn L) := transform
				self.listed_phone	:= L.phone;
				self.r.rid				:= L.rid;
				self.r.src				:= L.src;
				self							:= L;
			END;
			inRids := dedup(sort(project(recs_ssn,getRids(left)),record),record); // needs dedup

			srcRids := doxie.lookup_rid_src(inRids, mod_access, true);
			recs_ssn addRids(recs_ssn le, srcRids ri) := transform
				self.rids := ri.r + le.rids;
				self := le;
			end;
			with_rids := join(
				with_listings, srcRids,
				left.rid<>'' and left.rid=right.r.rid,
				addRids(left,right),
				left outer, keep(1)
			);
			recs_rids := if(incSourceDocCounts, with_rids, recs_ssn);
			
			grouped_recs := group(sort(recs_rids, did, st, prim_name, prim_range, sec_range, zip, doxie.tnt_score(tnt)), 
																					 did, st, prim_name, prim_range, sec_range, zip);

			Layouts.rollupRecord doAddressRollup(grouped_recs le, DATASET(recordof(grouped_recs)) allRecs) := TRANSFORM
				self.penalt := min(allRecs,penalt);
				self.names := choosen(dedup(sort(project(allRecs, Layouts.NameRec), lname, fname, mname, name_suffix), 
															lname, fname, mname, name_suffix), constants.max_names);
				self.ssns := choosen(dedup(sort(project(allRecs, Layouts.SsnRec), ssn), ssn), constants.max_ssns);
				self.dates := choosen(dedup(sort(project(allRecs, Layouts.DatesRec), -dob, -dod), 
															ut.NNEQ_Date(LEFT.dob,RIGHT.dob) and ut.NNEQ_Date(LEFT.dod,RIGHT.dod)), 
															constants.max_dates);

				// don't show current listing name that isn't the subject (the current holder of the searched phone)
				Layouts.PhonesRec makePhones(doxie.Layout_Phones ri) := TRANSFORM
					self.phone10 := if((ri.match_type<5 or (ri.match_type = 5 and ri.gong_score <= 100)) and 
															(phone_value = '' or Functions.phoneMatch(ri.phone10,phone_value)), 
													ri.phone10, skip);
					self.listed_name := if(ri.listed, ri.listed_name, '');
					self := ri;
				END;
				
				phone_children := NORMALIZE(allRecs,LEFT.phones,makePhones(RIGHT));
				self.phones := choosen(dedup(sort(phone_children, -phone10, -listed_name, -listed),
																		left.phone10 = right.phone10 and ut.nneq(left.listed_name, right.listed_name)), 
																		constants.max_phones);
				
				// assimilate rids
				rids_children := normalize(allrecs, left.rids, transform(doxie.Layout_Rollup.RidRec, self:=right));
				self.rids := choosen(dedup(sort(rids_children,record),record), ut.limits.HEADER_PER_DID);
				
				self.first_seen := MIN(allrecs(first_seen <> 0), first_seen);
				self.last_seen := MAX(allrecs(last_seen <> 0), last_seen);
				self := le;
				self := [];
			END;
			
			rolled_recs := rollup(grouped_recs, GROUP, doAddressRollup(LEFT, ROWS(LEFT)));

			Suppress.MAC_Mask_dsSSN(rolled_recs, with_mask, ssns, ssn);

			// lookup bankruptcy info if requested
			macros.add_bankruptcy_info(with_mask, final_recs, Layouts.rollupRecord, in_mod.IncludeBankruptcies);			

			// output(pre_recs, 				named('pre_recs'),extend);				// DEBUG
			// output(filt_recs, 			named('filt_recs'),extend);	// DEBUG
			// output(add_recs, 				named('add_recs'),extend);	// DEBUG
			// output(all_recs, 				named('all_recs'),extend);	// DEBUG
			// output(base_recs, 			named('base_recs'),extend);	// DEBUG
			// output(phone_risk_use, 	named('phone_risk_use'),extend);	// DEBUG
			// output(recs_ssn, 				named('recs_ssn'),extend);				// DEBUG
			// output(with_listings,		named('with_listings'),extend);	// DEBUG
			// output(inRids, 					named('inRids'),extend);					// DEBUG
			// output(srcRids,  				named('srcRids'),extend);				// DEBUG
			// output(recs_rids,  			named('recs_rids'),extend);			// DEBUG
			// output(grouped_recs, 		named('grouped_recs'),extend);		// DEBUG
			// output(rolled_recs,			named('rolled_recs'),extend);		// DEBUG
			// output(final_recs, 			named('final_recs'),extend);			// DEBUG
			
			return final_recs;
			
		end;
	end;	
end;
