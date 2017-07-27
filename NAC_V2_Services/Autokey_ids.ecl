IMPORT NAC_V2,NAC_V2_Services,AutokeyB2,AutokeyI,AutoStandardI;
EXPORT AutoKey_Ids := MODULE

	inner_ak_id_search(NAC_V2_Services.IParams.AK_params in_mod) := FUNCTION
		// 1. Define values for obtaining autokeys AND payloads.
		c := NAC_V2.Autokey_constants();
		ak_QAname		:= c.str_autokeyname;
		ak_typeStr	:= c.ak_typeStr;
		ak_skipSet	:= c.ak_skipset;
		ak_dataset	:= c.ak_dataset;

		// 2. Configure the autokey search.		
		tempmod := MODULE(PROJECT(in_mod,autokeyI.AutoKeyStandardFetchArgumentInterface,OPT))
			EXPORT string					autokey_keyname_root	:= ^.ak_QAname;
			EXPORT string					typestr								:= ^.ak_typeStr;
			EXPORT SET OF string1	get_skip_set					:= ^.ak_skipSet;
			EXPORT boolean				useAllLookups					:= TRUE;
			EXPORT boolean 				SSNTypos							:= TRUE;
			EXPORT boolean 				nicknames 						:= TRUE;
			EXPORT boolean 				allownicknames 				:= TRUE;
		END;

		// 3. Get autokey 'fake' ids (fids) based on batch input.
		ids := autokeyi.AutoKeyStandardFetch(tempmod).ids;
		// 4. Get lookup ids via autokey payload (outpl).			
		AutokeyB2.mac_get_payload(ids, ak_QAname, ak_dataset, outpl, did, zero, ak_typeStr);

		// 5. Slim the autokey payload (outpl) to just what's needed for matching.
		ds_ids_by_ak := PROJECT(outpl, 
											 TRANSFORM(NAC_V2_Services.Layouts.search_layout, 
															SELF.acctno := 0, //we will get the acctno back from the left side
															SELF.did := LEFT.did,
															SELF.isDeepDive := false,
															SELF.case_identifier := LEFT.case_identifier,
															SELF.client_identifier := LEFT.client_identifier,
															SELF.state := LEFT.case_program_state));
		RETURN ds_ids_by_ak;
	END;

	search_val(NAC_V2_Services.Layouts.process_layout in_rec,
						 NAC_V2_Services.IParams.CommonParams in_mod) := FUNCTION
		default_mod := AutoStandardI.DefaultMODULE(); //need to use fake module to satisfy the interface signature
		mod_by_addr1 := MODULE(PROJECT(default_mod,NAC_V2_Services.IParams.AK_params,opt))
			EXPORT firstname 	:= in_rec.name_first;
			EXPORT middlename := in_rec.name_middle;
			EXPORT lastname		:= in_rec.name_last;
			EXPORT prim_range	:= in_rec.addr1_prim_range;
			EXPORT predir 		:= in_rec.addr1_predir;
			EXPORT prim_name 	:= in_rec.addr1_prim_name;
			EXPORT addr_suffix:= in_rec.addr1_suffix;
			EXPORT postdir		:= in_rec.addr1_postdir;
			EXPORT sec_range 	:= in_rec.addr1_sec_range;
			EXPORT city 			:= in_rec.addr1_city;
			EXPORT state 			:= in_rec.addr1_state;
			EXPORT zip 				:= in_rec.addr1_zip;
			EXPORT ssn 				:= in_rec.ssn;
			EXPORT dob 				:= (UNSIGNED)in_rec.dob;
			EXPORT noFail			:= in_mod.noFail;
		END;

		mod_by_addr2 := MODULE(PROJECT(default_mod,NAC_V2_Services.IParams.AK_params,OPT))
			EXPORT firstname 	:= in_rec.name_first;
			EXPORT middlename := in_rec.name_middle;
			EXPORT lastname		:= in_rec.name_last;
			EXPORT prim_range	:= in_rec.addr2_prim_range;
			EXPORT predir 		:= in_rec.addr2_predir;
			EXPORT prim_name 	:= in_rec.addr2_prim_name;
			EXPORT addr_suffix:= in_rec.addr2_suffix;
			EXPORT postdir		:= in_rec.addr2_postdir;
			EXPORT sec_range 	:= in_rec.addr2_sec_range;
			EXPORT city 			:= in_rec.addr2_city;
			EXPORT state 			:= in_rec.addr2_state;
			EXPORT zip 				:= in_rec.addr2_zip;
			EXPORT ssn 				:= in_rec.ssn;
			EXPORT dob 				:= (UNSIGNED)in_rec.dob;
			EXPORT noFail			:= in_mod.noFail;
		END;

		ids_by_addr1 := inner_ak_id_search(mod_by_addr1);
		ids_by_addr2 := IF(in_rec.addr2_prim_range <> '' AND in_rec.addr2_prim_name <> '', inner_ak_id_search(mod_by_addr2));
				
		// Combine results AND limit number of results per acctno search (mostly done for batch)
		//this search was done on only one acctno
		RETURN CHOOSEN(DEDUP(SORT(ids_by_addr1 + ids_by_addr2,case_identifier,client_identifier, state),
									 case_identifier,client_identifier,state), NAC_V2_Services.Constants.MAX_IDS_PER_ACCTNO);		
	END;

	EXPORT val(DATASET(NAC_V2_Services.Layouts.process_layout) ds_in,
						 NAC_V2_Services.IParams.CommonParams in_mod) := FUNCTION

		// Attach a dataSET OF ids to input RECORD.
		rec_in_plus_IDs := RECORD
			NAC_V2_Services.Layouts.process_layout;
			DATASET(NAC_V2_Services.Layouts.search_layout) ids{maxcount(NAC_V2_Services.Constants.MAX_IDS_PER_ACCTNO)};
		END;

		// Use LIBCALL_FetchI_Hdr_Indv to grab DIDs.
		rec_in_plus_IDs xformDeepDiveForIds(NAC_V2_Services.Layouts.process_layout L) := TRANSFORM				
			SELF.ids 	:= search_val(L, in_mod);	
			SELF      := L;
		END;

		ds_input_with_IDs := PROJECT(ds_in, xformDeepDiveForIds(LEFT));

		// Normalize the dids dataset returned with each acctno to individual dids.
		NAC_V2_Services.Layouts.search_layout xformNormalizeIds(rec_in_plus_IDs L, NAC_V2_Services.Layouts.search_layout R) := TRANSFORM
			SELF.acctno := L.acctno;
			SELF.did    := R.did;
			SELF.isDeepDive := FALSE;
			SELF.case_identifier := R.case_identifier;
			SELF.client_identifier := R.client_identifier;
			SELF.state := R.state;
		END;

		ds_normalized_ids := NORMALIZE(ds_input_with_IDs, LEFT.ids, xformNormalizeIds(LEFT,RIGHT));

		ds_normalized_ids_ddpd := DEDUP(SORT(ds_normalized_ids,acctno,case_identifier,client_identifier, state),
																		acctno,case_identifier,client_identifier,state);														
		RETURN ds_normalized_ids_ddpd;
	END;

END;