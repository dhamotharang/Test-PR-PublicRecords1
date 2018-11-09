IMPORT  doxie,mdr,  NID,BIPV2,ut;

EXPORT keys := MODULE

	EXPORT key_cbrs_phone10_gong := INDEX(
		FILES.Gong_Raw_Weekly(phone10 <> '' and (integer)phone10 <> 0), 
		 {phone10}, 
		 {FILES.Gong_Raw_Weekly}, 
		'~prte::key::cbrs.phone10_gong_' + doxie.Version_SuperKey );

	EXPORT key_gong_npa := INDEX(
		FILES.File_Npa_Zip, 
		 {areacode}, 
		 {FILES.File_Npa_Zip}, 
		Constants.Gong_Key + doxie.Version_SuperKey + '::npa');
		
	EXPORT key_gong_zip := INDEX(
		FILES.File_Npa_Zip, 
		 {zip}, 
		 {FILES.File_Npa_Zip}, 
		Constants.Gong_Key + doxie.Version_SuperKey + '::zip');
		
	EXPORT key_gong_address_current := INDEX(
		FILES.File_Address_Current, 
		 {prim_name, st, z5, prim_range, sec_range, predir, suffix}, 
		 {phone10, listed_name, fname, mname, lname, name_suffix, dual_name_flag, 
		 date_first_seen, listing_type, publish_code, omit_phone}, 
		'~prte::key::gong_address_current_' + doxie.Version_SuperKey );
		
	EXPORT key_gong_cn := INDEX(
		FILES.f_cn_norm_dep(metaphonelib.DMetaPhone1(cn) <> ''), 
		 {string6 dph_cn := metaphonelib.DMetaPhone1(cn), cn, st, p_city_name, v_city_name, z5},
		 {listed_name, phone10}, 
		'~prte::key::gong_cn_' + doxie.Version_SuperKey );
		
	EXPORT key_gong_cn_to_company := INDEX(
		FILES.DS_gong_cn_to_company, 
		 {listed_name, st, p_city_name, z5, phone10}, 
		 {Files.DS_gong_cn_to_company}, 
		'~prte::key::gong_cn_to_company_' + doxie.Version_SuperKey );

	EXPORT key_gong_czsslf := INDEX(
		FILES.Gong_Raw_Weekly(trim(p_city_name) <> ''), 
		{p_city_name,z5,prim_name,prim_range,name_last,name_first},
		{FILES.Gong_Raw_Weekly}, 
		'~prte::key::gong_czsslf_' + doxie.Version_SuperKey );
		
	EXPORT key_gong_did := INDEX(
		FILES.DS_gong_did(did<>0), 
		 {unsigned6 l_did := did},
		 {FILES.DS_gong_did}, 
		'~prte::key::gong_did_' + doxie.Version_SuperKey );

	EXPORT key_gong_eda_npa_nxx_line := INDEX(
		FILES.DS_gong_eda_npa_nxx_line, 
		 {string3 npa := phone10[1..3],string3 nxx := phone10[4..6],string4 line := phone10[7..10]}, 
		 {FILES.DS_gong_eda_npa_nxx_line}, 
		'~prte::key::gong_eda_npa_nxx_line_' + doxie.Version_SuperKey );

	EXPORT key_gong_eda_st_bizword_city := INDEX(
		FILES.DS_gong_eda_st_bizword_city, 
		 {string2 st := st,string30 word := word,string25 city := city}, 
		 {FILES.DS_gong_eda_st_bizword_city}, 
		'~prte::key::gong_eda_st_bizword_city_' + doxie.Version_SuperKey );

	EXPORT key_gong_eda_st_city_prim_name_prim_range := INDEX(
		FILES.DS_gong_eda_st_city_prim_name_prim_range, 
		 {string2 st := st,string25 city := city,string28 prim_name := prim_name,string10 prim_range := prim_range},
		 {FILES.DS_gong_eda_st_city_prim_name_prim_range}, 
		'~prte::key::gong_eda_st_city_prim_name_prim_range_' + doxie.Version_SuperKey );

	EXPORT key_gong_eda_st_lname_city := INDEX(
		FILES.DS_gong_eda_st_lname_city,
		{string2 st := st,string20 lname := name_last,string25 city := city}, 
		 {FILES.DS_gong_eda_st_lname_city}, 
		'~prte::key::gong_eda_st_lname_city_' + doxie.Version_SuperKey );

	EXPORT key_gong_eda_st_lname_fname_city := INDEX(
		FILES.DS_gong_eda_st_lname_fname_city, 
		 {string2 st := st;string20 lname := name_last;string20 fname := fname;string25 city := city}, 
		 {FILES.DS_gong_eda_st_lname_fname_city}, 
		'~prte::key::gong_eda_st_lname_fname_city_' + doxie.Version_SuperKey );
		
	EXPORT key_gong_hhid := INDEX(
		FILES.DS_gong_hhid(hhid<>0), 
		 {unsigned6 s_hhid := hhid}, 
		 {FILES.DS_gong_hhid}, 
		'~prte::key::gong_hhid_' + doxie.Version_SuperKey );

	EXPORT key_gong_history_surnames := INDEX(
		file_history_surname, 
		 {k_name_last,k_name_first,k_st}, 
		 {file_history_surname}, 
		'~prte::key::gong_history::' + doxie.Version_SuperKey  + '::surnames');

	EXPORT key_gong_history_address(boolean IsFCRA) := INDEX(
		FILES.DS_gong_history_address(IsFCRA), 
		{prim_name,st,z5,prim_range,sec_range,
				boolean current_flag := if(current_record_flag='Y',true,false),
				boolean business_flag := if(listing_type_bus='B',true,false)},
		{FILES.DS_gong_history_address(IsFCRA)}, 
		if(IsFCRA,
		'~prte::key::gong_history::fcra::' + doxie.Version_SuperKey  + '::address',
		'~prte::key::gong_history_address_' + doxie.Version_SuperKey ));

	EXPORT key_gong_history_city_st_name := INDEX(
		FILES.DS_gong_history_city_st_name, 
		{unsigned4 city_code := HASH((qstring25)city_name),st,
			string6 dph_name_last := metaphonelib.DMetaPhone1(name_last),
			name_last,
			string20 p_name_first := NID.PreferredFirstVersionedStr(name_first, NID.version),
			name_first},
		 {FILES.DS_gong_history_city_st_name}, 
		'~prte::key::gong_history_city_st_name_' + doxie.Version_SuperKey );

	EXPORT key_gong_history_cleanname := INDEX(
		FILES.DS_gong_history_cleanname, 
		{string6 dph_name_last := metaphonelib.DMetaPhone1(name_last),
			name_last,st,
						string20 p_name_first := NID.PreferredFirstNew(name_first),
			name_first}, 
		 {FILES.DS_gong_history_cleanname}, 
		'~prte::key::gong_history_cleanname_' + doxie.Version_SuperKey );
		
	EXPORT key_gong_history_companyname := INDEX(
		FILES.DS_gong_history_companyname, 
		 {listed_name_new, st, p_city_name, boolean current_flag := if(current_record_flag='Y',true,false)}, 
		 {FILES.DS_gong_history_companyname}, 
		'~prte::key::gong_history_companyname_' + doxie.Version_SuperKey );

	EXPORT key_gong_history_did(Boolean IsFCRA) := INDEX(
		FILES.DS_gong_history_did(IsFCRA), 
		 {unsigned6 l_did := did, 
			boolean current_flag := if(current_record_flag='Y',true,false),
			boolean business_flag := if(listing_type_bus='B',true,false)},
		 {FILES.DS_gong_history_did(IsFCRA)}, 
		if(	IsFCRA,
			'~prte::key::gong_history::fcra::' + doxie.Version_SuperKey  + '::did',
			'~prte::key::gong_history_did_' + doxie.Version_SuperKey ));

	EXPORT key_gong_history_hhid := INDEX(
		FILES.DS_gong_history_hhid, 
		 {unsigned6 s_hhid := hhid,
				boolean current_flag := if(current_record_flag='Y',true,false),
				boolean business_flag := if(listing_type_bus='B',true,false)},
		 {FILES.DS_gong_history_hhid}, 
		'~prte::key::gong_history_hhid_' + doxie.Version_SuperKey );
		


	EXPORT LinkIds := MODULE

		shared Base				:= Files.File_History_Full_Prepped_for_Keys;
		
		BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, '~prte::key::gong_history_linkids_' + doxie.Version_SuperKey )
		export Key := k;


		//DEFINE THE INDEX ACCESS
		export kFetch2(
			dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
			string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																									//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																									//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
			unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
			joinLimit = 25000,
			unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
			) :=
		FUNCTION

			BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, out, Level, joinLimit, JoinType);
			return out;																					

		END;
		
		// Depricated version of the above kFetch2
		export kFetch(
			dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
			string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																									//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																									//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
			unsigned2 ScoreThreshold = 0								//Applied at lowest leve of ID
			) :=
		FUNCTION

			inputs_for2 := project(inputs, BIPV2.IDlayouts.l_xlink_ids2);
			f2 := kFetch2(inputs_for2, Level, ScoreThreshold);
			return project(f2, recordof(Key));																					
		END;
	END;

	EXPORT key_gong_history_name := INDEX(
		FILES.DS_gong_history_name, 
			{string6 dph_name_last := metaphonelib.DMetaPhone1(name_last),
			name_last,st,
			string20 p_name_first := NID.PreferredFirstNew(name_first),
			name_first}, 
		 {FILES.DS_gong_history_name}, 
		'~prte::key::gong_history_name_' + doxie.Version_SuperKey );

	EXPORT key_gong_history_npa_nxx_line := INDEX(
		FILES.DS_gong_history_npa_nxx_line(length(TRIM(phone10))=10), 
		 {string3 npa := phone10[1..3],
					string3 nxx := phone10[4..6],
					string4 line := phone10[7..10],
					boolean current_flag := if(current_record_flag='Y',true,false),
					boolean business_flag := if(listing_type_bus='B',true,false)}, 
		 {FILES.DS_gong_history_npa_nxx_line}, 
		'~prte::key::gong_history_npa_nxx_line_' + doxie.Version_SuperKey );
				 
	EXPORT key_gong_history_phone(boolean IsFCRA) := function
	ut.MAC_CLEAR_FIELDS(file_history_phone(IsFCRA), file_history_phone_cleared,Constants.fields_to_clear);
	keyfile := if(isFCRA, file_history_phone_cleared,file_history_phone_cleared(isFCRA));
	return INDEX(keyfile, 
								{p7 := phone7,p3 := area_code,st,
								boolean current_flag := if(current_record_flag='Y',true,false),
								boolean business_flag := if(listing_type_bus='B',true,false)},
								{keyfile}, 
								if(IsFCRA,
									'~prte::key::gong_history::fcra::' + doxie.Version_SuperKey  + '::phone',
									'~prte::key::gong_history_phone_' + doxie.Version_SuperKey ));
end;

	EXPORT key_gong_history_wdtg := INDEX(
		FILES.DS_gong_history_wdtg, 
		 {	// keyed fields
			string6 dph_name_last := metaphonelib.DMetaPhone1(name_last),
			dt_first_seen,
			integer4 zip5 := (integer4)z5,
			string20 p_name_first := NID.PreferredFirstNew(name_first),
			name_last,
			name_first
		},
		 {FILES.DS_gong_history_wdtg}, 
		'~prte::key::gong_history_wdtg_' + doxie.Version_SuperKey );

	EXPORT key_gong_history_wild_name_zip := INDEX(
		FILES.DS_gong_history_wild_name_zip, 
		{name_last,st,name_first,integer4 zip5 := (integer4)z5}, 
		{FILES.DS_gong_history_wild_name_zip}, 
		'~prte::key::gong_history_wild_name_zip_' + doxie.Version_SuperKey );

	EXPORT key_gong_history_zip_name := INDEX(
		FILES.DS_gong_history_zip_name(metaphonelib.DMetaPhone1(name_last) <> '',trim(z5)<>''), 
		{string6 dph_name_last := metaphonelib.DMetaPhone1(name_last),
			integer4 zip5 := (integer4)z5,
			string20 p_name_first := NID.PreferredFirstNew(name_first),
			name_last, name_first},
		{FILES.DS_gong_history_zip_name}, 
		'~prte::key::gong_history_zip_name_' + doxie.Version_SuperKey );

	EXPORT key_gong_hist_bdid := INDEX(
		FILES.DS_gong_hist_bdid, 
		 {bdid}, 
		 {FILES.DS_gong_hist_bdid}, 
		'~prte::key::gong_hist_bdid_' + doxie.Version_SuperKey );

	EXPORT key_gong_lczf := INDEX(
		FILES.Gong_Raw_Weekly, 
		 {name_last,p_city_name,z5,name_first},
		 {Files.Gong_Raw_Weekly}, 
		'~prte::key::gong_lczf_' + doxie.Version_SuperKey );
		
	EXPORT key_gong_phone := INDEX(
		FILES.DS_gong_phone, 
		 {STRING7 ph7 := phone7,STRING3 ph3 := area_code,st,
			boolean business_flag := if(listing_type_bus = 'B', true, false)},
		 {FILES.DS_gong_phone}, 
		'~prte::key::gong_phone_' + doxie.Version_SuperKey );
		
	EXPORT key_gong_scoring := INDEX(
		FILES.DS_gong_scoring, 
		 {phone10, fsn},
		 {Files.DS_gong_scoring}, 
		'~prte::key::gong_scoring_' + doxie.Version_SuperKey );

	EXPORT key_gong_surnamecnt := INDEX(
		FILES.DS_gong_surnamecnt, 
		 {name_last}, 
		 {st,cnt}, 
		'~prte::key::gong_surnamecnt_' + doxie.Version_SuperKey );
		
	EXPORT key_phone_table_v2(boolean IsFCRA, boolean filtered) := INDEX(
		file_phone_table_v2(IsFCRA,filtered), 
		 {phone10}, 
		 {file_phone_table_v2(IsFCRA,filtered)}, 
		 if(IsFCRA,
			'~prte::key::business_header::filtered::fcra::' + doxie.Version_SuperKey  + '::hri::phone10_v2',
			'~prte::key::phone_table_v2_' + doxie.Version_SuperKey ));
		
		
END;
