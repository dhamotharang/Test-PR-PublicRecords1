import Address;

	Layout_outf := record
			string12 did;
			string3  did_score;
			string9  ssn;
			Hygenics_SOff.Layout_OKC_Sex_Offender_Common.final;
	end;

ds := Hygenics_SOff.OKC_Sex_Offender_DID;

	Layout_Base_File := recordof(ds);

	In_base_file_sorted := sort(ds, seisint_primary_key, name_type, name_orig);

	Layout_Base_File  trfIterate(Layout_Base_File l, Layout_Base_File r) := transform
		self.did         := if ((r.name_type in ['2','3']) and 
														(r.seisint_primary_key = l.seisint_primary_key), l.did, r.did);
		self.did_score   := if (r.name_type = '0', r.did_score, if(trim(self.did,left,right) <> '','101',l.did_score));
		self.ssn				 := if ((r.name_type in ['2','3']) and 
														(r.seisint_primary_key = l.seisint_primary_key), l.ssn, r.ssn);
		self             := r;
	end;

temp_base_File 		:= iterate(In_base_file_sorted, trfIterate(left,right));

ds_deduped 			:= dedup(sort(temp_base_File,source_file,orig_state
                           , lname, fname, mname, name_suffix
						   , prim_range, predir, prim_name
						   , addr_suffix, postdir, unit_desig
						   , sec_range, v_city_name, zip
						   , -dt_last_reported, name_type)
						   , source_file,orig_state, lname, fname, mname
						   , name_suffix, prim_range, predir
						   , prim_name, addr_suffix, postdir
						   , unit_desig, sec_range, v_city_name
						   , zip, did, ssn, offender_status
						   , reg_date_1, employer_address_1
						   , employer_address_2, date_of_birth, date_of_birth_aka
						   , court_case_number_1, conviction_date_1
						   , offense_date_1, offense_description_1);

sorted_ds_deduped 	:= sort(ds_deduped, seisint_primary_key, orig_state, name_type, name_orig);

	layout_flag := record
		string1 bad_flag 	:= '';
		Layout_Base_File;
	end;

	layout_flag trfTemp(Layout_Base_File l):= transform
		self.bad_flag 		:= '';
		self 				:= l
	end;

temp_ds 	:= project(sorted_ds_deduped, trfTemp(left)) ;

	layout_flag trfFindBadRecs(layout_flag l, layout_flag r) := transform
		self.bad_flag 		:= if (r.name_type = '0', 'G', if (l.seisint_primary_key = r.seisint_primary_key, l.bad_flag, 'B'));
		self     			:= r;
	end;

ds_flaged 	:= iterate(temp_ds, trfFindBadRecs(left,right));

ds_good_recs := ds_flaged(bad_flag <> 'B');

	Layout_outf trfFinal(layout_flag l) := transform
		self := l;
	end;

ds_orig 		:= project(ds_good_recs, trfFinal(left));

ds_no_did 		:= ds_orig(trim(did,left,right) = '' or (integer)trim(did,left,right) = 0);

ds_did    		:= ds_orig(trim(did,left,right) <> '' and (integer)trim(did,left,right) <> 0); 
keys_to_keep 	:= dedup(sort(ds_did,source_file,orig_state, did, -dt_last_reported),source_file,orig_state, did);

	Layout_outf trfJoin(Layout_outf l, Layout_outf r) := transform
		self := l;
	end;

ds_joined_set 	:= join(sort(ds_did, seisint_primary_key), sort(keys_to_keep, seisint_primary_key), left.seisint_primary_key = right.seisint_primary_key, trfJoin(left, right), keep(1));

ds_final 		:= dedup(sort(ds_no_did + ds_joined_set
                      , seisint_primary_key
					  , orig_state
					  , name_type
					  , name_orig)
					  , seisint_primary_key
					  , name_type
					  , name_orig
					  , date_of_birth);

export File_OKC_Sex_Offender_DID := ds_final;