import BatchShare, Doxie, doxie_crs, Watercraft, ut, FFD, BIPV2;

EXPORT Layouts := MODULE
	
	shared s_key_rec := recordof(watercraft.key_watercraft_sid);
	
	export search_watercraftkey := record
		string30 watercraft_key := '';
		string30 sequence_key := '';
		string2	state_origin := '';
		boolean isDeepDive := false;
		unsigned6 subject_did := 0;
	end;
	
	export search_hullnum := record
		string30 hull_num := '';
	END;
	
	export search_offnum := RECORD
		string10 off_num := '';
	END;

	export search_vesselname := RECORD
		string50 vessel_name := '';
	END;

	export acct_rec:= RECORD
	  Doxie.layout_inBatchMaster.acctno;
		unsigned6 ldid;
		unsigned6 lbdid;
    search_watercraftkey and not [subject_did];
		BIPV2.IDlayouts.l_header_ids;
	END;
	
	export batch_in := RECORD
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDid;
		BatchShare.Layouts.ShareName;
		BatchShare.Layouts.ShareAddress;
		BatchShare.Layouts.SharePII;
		string10  	homephone := '';
		STRING120 comp_name     := '';
		STRING9   FEIN          := '';
		BIPV2.IDlayouts.l_header_ids;
	END;
	
	Export ak_payload_rec := RECORD
		Watercraft.Layout_Watercraft_Search_Base.watercraft_key;
		Watercraft.Layout_Watercraft_Search_Base.sequence_key;
		Watercraft.Layout_Watercraft_Search_Base.state_origin;
		Watercraft.Layout_Watercraft_Search_Base.fname;
		Watercraft.Layout_Watercraft_Search_Base.lname;
		Watercraft.Layout_Watercraft_Search_Base.mname;
		Watercraft.Layout_Watercraft_Search_Base.dob;
		Watercraft.Layout_Watercraft_Search_Base.prim_name;
		Watercraft.Layout_Watercraft_Search_Base.prim_range;
		Watercraft.Layout_Watercraft_Search_Base.st;
		Watercraft.Layout_Watercraft_Search_Base.zip5;
		Watercraft.Layout_Watercraft_Search_Base.sec_range;
		Watercraft.Layout_Watercraft_Search_Base.company_name;	
		unsigned6 ldid;
		unsigned6 lbdid;
		string10 phone;
		unsigned1 zero;
		string25 city;
		string2 bstate; 
		string25 bcity; 
		string10 bphone; 
		string10	bprim_range; 
		string28	bprim_name; 
		string8		bsec_range;
		string5 bzip5; 
		string9 fein_use; 
		string9 ssn_use; 
	END;
	
	export flat_s := record
		search_watercraftkey and not [subject_did];
		string25  state_origin_full := '';
		string10	rec_type;
		s_key_rec.date_last_seen;
		boolean NonDMVSource;
	END;
	
	export flat_c := record
		string50	name_of_vessel := '';
		//description
		string6		registered_breadth := '';
		string6		registered_depth := '';
		string7		registered_length := '';
		string7		registered_gross_tons := '';
		string7		registered_net_tons := '';
		//registration
		string5		registration_status_code := '';
		string40	registration_status_description := '';
		string20	registration_number := '';
		string8		registration_date := '';
		string8		registration_expiration_date := '';		
		string7		main_hp_ahead;
		string7		main_hp_astern;		//manufacturer
		string50	ship_yard := '';
		//hailing port
		string50	hailing_port := '';
		string2		hailing_port_state := '';
		string50	hailing_port_province := '';
		//vessel build
		string4		vessel_build_year := '';
		string50	vessel_complete_build_city := '';
		string2		vessel_complete_build_state := '';
		string50	vessel_complete_build_province := '';
		string64	vessel_complete_build_country := '';
		string50	vessel_hull_build_city := '';
		string2		vessel_hull_build_state := '';
		string50	vessel_hull_build_province := '';
		string64	vessel_hull_build_country := '';	
		//vessel info
		string10	vessel_id;
		string10	vessel_database_key;
		string8		call_sign;
		string30	imo_number;
		string10	party_identification_number;
		//itc
		string7		itc_gross_tons;
		string7		itc_net_tons;
		string7		itc_length;
		string6		itc_breadth;
		string6		itc_depth;
		//home port
		string50	home_port_name;
		string2		home_port_state;
		string50	home_port_province;
	END;
	
	export flat_w := RECORD
		//description
		string30	hull_number := '';
		string5		hull_type_code := '';
		string20	hull_type_description := '';
		//wk description
		string5		watercraft_length := '';
		string5		watercraft_width := '';
		string10	watercraft_weight := '';
		string5		watercraft_class_code := '';
		string35	watercraft_class_description := '';
		string5		watercraft_make_code := '';
		string30	watercraft_make_description := '';
		string5		watercraft_model_code := '';
		string30	watercraft_model_description := '';
		string3		watercraft_color_1_code := '';
		string20	watercraft_color_1_description := '';
		string3		watercraft_color_2_code := '';
		string20	watercraft_color_2_description := '';
		string4		model_year := '';
		//additional desc
		string5		use_code := '';
		string20	use_description := '';
		string2 	propulsion_code := '';
		string20	propulsion_description := '';
		string1 	fuel_code := '';
		string20	fuel_description := '';
		//title
		string2		title_state := '';
		string5		title_status_code := '';
		string40	title_status_description := '';
		string20	title_number := '';
		string5		title_type_code := '';
		string20	title_type_description := '';
		string8		title_issue_date := '';
		//purchase
		string2		state_purchased := '';		
		string8		purchase_date := '';
		string10	purchase_price := '';
		string40	dealer := '';
		string1		new_used_flag;	
		//registration_info
		string2		st_registration := '';
		string15	county_registration := '';
		string8		registration_status_date := '';
		string8		registration_renewal_date := '';
		string20	decal_number := '';
		string5		transaction_type_code := '';
		string40	transaction_type_description := '';			
		string40	watercraft_toilet_description;		
		string4   signatory := '' ;	
		//vessel desc
		string2 	vehicle_type_code := '';
		string20	vehicle_type_description := '';
		string2 	watercraft_number_of_engines := '';
		//coast guard
		string1		coast_guard_documented_flag := '';
		string30	coast_guard_number := '';
	END;
	
	export flat_rec := RECORD
		flat_s;
		flat_c and not [registration_status_code];
		flat_w and not [hull_type_code, watercraft_class_code, 
										watercraft_make_code, watercraft_model_code, 
										watercraft_color_1_code, watercraft_color_2_code,
										use_code, propulsion_code, fuel_code,
										title_status_code, title_type_code,
										county_registration,	transaction_type_code,
										vehicle_type_code, watercraft_number_of_engines,
										coast_guard_documented_flag];
	END;
	
	export owner_report_rec := RECORD
		doxie_crs.layout_watercraft_owner;
		BIPV2.IDlayouts.l_header_ids;
		s_key_rec.orig_address_1;
		s_key_rec.orig_address_2;
		s_key_rec.orig_country;
		s_key_rec.orig_province;
		s_key_rec.orig_fips;
		String8 gender;
		s_key_rec.orig_name;
		s_key_rec.orig_name_first;
		s_key_rec.orig_name_middle;
		s_key_rec.orig_name_last;
		s_key_rec.bdid;
		s_key_rec.orig_fein; // this should be changed to fein when autokeys are rebuilt
		s_key_rec.fein; //added fein field
		s_key_rec.orig_ssn;
		s_key_rec.phone_1;
		s_key_rec.phone_2;
		FFD.Layouts.CommonRawRecordElements;
	END;
																				
	export owner_search_rec := RECORD
		unsigned2 penalt := 0;
		owner_report_rec and not [orig_name_first, orig_name_middle, orig_name_last,
																 orig_country, orig_province, orig_fips, gender];
	END;
	
	EXPORT owner_raw_rec := record
		s_key_rec.dppa_flag;
		unsigned2 penalt := 0;
		unsigned6 subject_did;
		BIPV2.IDlayouts.l_header_ids;
		flat_s;
		owner_report_rec;
		s_key_rec.persistent_record_id;
	END;

	export engine_rec := RECORD
		doxie_crs.layout_watercraft_engine;
		string20 engine_number;
		string4 engine_year;
		string2		watercraft_number_of_engines;
	END;
	
	export lien_rec := RECORD
		doxie_crs.layout_watercraft_lien;
		string8 lien_date;
		string1 lien_indicator;
	END;
	
	export wc_desc  := RECORD
		string40 watercraft_name := '';
		flat_w;
		flat_c and not [name_of_vessel, registered_length, ship_yard];
  END;		
	
	export engine_1_layout := RECORD
		string20	engine_1_number := '';
		string20	engine_1_make := '';
		string20	engine_1_model := '';
		string4		engine_1_year := '';
		string5		watercraft_hp_1:= '';
	END;

	export engine_2_layout := RECORD
		string20	engine_2_number := '';
		string20	engine_2_make := '';
		string20	engine_2_model := '';
		string4		engine_2_year := '';
		string5		watercraft_hp_2:= '';
	END;
	
	export engine_3_layout := RECORD
		string20	engine_3_number := '';
		string20	engine_3_make := '';
		string20	engine_3_model := '';
		string4		engine_3_year := '';
		string5		watercraft_hp_3:= '';
	END;	
	
		export own1_layout := RECORD
			//person and address info
			String12 did_1;
			String12 bdid_1;
			unsigned6 ultID_1;
			unsigned6 orgID_1;
			unsigned6 seleID_1;
			unsigned6 proxID_1;
			unsigned6 powID_1;
			unsigned6 empID_1;
			unsigned6 dotID_1;
			string100	orig_name_1:= '';
			string1		orig_name_type_code_1:= '';
			string20	orig_name_type_description_1:= '';
			string25	orig_name_first_1:= '';
			string25	orig_name_middle_1:= '';
			string25	orig_name_last_1:= '';
			string60	orig_address_1_1:= '';
			string60	orig_address_2_1:= '';
			string5		orig_fips_1:= '';
			string30  orig_province_1:='';
			string30  orig_country_1:='';
			string8		dob_1:= '';
			string9		orig_ssn_1:= '';
			string9		orig_fein_1:= '';
			string1		gender_1:= '';
			string10	phone_1_1:= '';
			string10	phone_2_1:= '';
			string5		title_1:= '';
			string20	fname_1:= '';
			string20	mname_1:= '';
			string20	lname_1:= '';
			string5		name_suffix_1:= '';
			string60	company_name_1:= '';
			string10	prim_range_1:= '';
			string2		predir_1:= '';
			string28	prim_name_1:= '';
			string4		suffix_1:= '';
			string2		postdir_1:= '';
			string10	unit_desig_1:= '';
			string8		sec_range_1:= '';
			string25	p_city_name_1:= '';
			string25	v_city_name_1:= '';
			string2		st_1:= '';
			string5		zip5_1:= '';
			string4		zip4_1:= '';
			string3		county_1:= '';	
	END;
	
	export own2_layout := RECORD
			//person and address info
			String12 did_2;
			String12 bdid_2;
			unsigned6 ultID_2;
			unsigned6 orgID_2;
			unsigned6 seleID_2;
			unsigned6 proxID_2;
			unsigned6 powID_2;
			unsigned6 empID_2;
			unsigned6 dotID_2;
			string100	orig_name_2:= '';
			string1		orig_name_type_code_2:= '';
			string20	orig_name_type_description_2:= '';
			string25	orig_name_first_2:= '';
			string25	orig_name_middle_2:= '';
			string25	orig_name_last_2:= '';
			string60	orig_address_1_2:= '';
			string60	orig_address_2_2:= '';
			string5		orig_fips_2:= '';
			string30  orig_province_2:='';
			string30  orig_country_2:='';
			string8		dob_2:= '';
			string9		orig_ssn_2:= '';
			string9		orig_fein_2:= '';
			string1		gender_2:= '';
			string10	phone_1_2:= '';
			string10	phone_2_2:= '';
			string5		title_2:= '';
			string20	fname_2:= '';
			string20	mname_2:= '';
			string20	lname_2:= '';
			string5		name_suffix_2:= '';
			string60	company_name_2:= '';
			string10	prim_range_2:= '';
			string2		predir_2:= '';
			string28	prim_name_2:= '';
			string4		suffix_2:= '';
			string2		postdir_2:= '';
			string10	unit_desig_2:= '';
			string8		sec_range_2:= '';
			string25	p_city_name_2:= '';
			string25	v_city_name_2:= '';
			string2		st_2:= '';
			string5		zip5_2:= '';
			string4		zip4_2:= '';
			string3		county_2:= '';	
	END;	
	
	export LH1_Layout := RECORd
		string40	lien_name_1;
		string60	lien_address_1_1;
		string60	lien_address_2_1;
		string25	lien_city_1;
		string2	lien_state_1;
		string10	lien_zip_1;
		string8 lien_date_1;
		string1 lien_indicator_1;
	END;
	
	export LH2_Layout := RECORd
		string40	lien_name_2;
		string60	lien_address_1_2;
		string60	lien_address_2_2;
		string25	lien_city_2;
		string2	lien_state_2;
		string10	lien_zip_2;
		string8 lien_date_2;
		string1 lien_indicator_2;
	END;
	
	export search_out := record
		boolean   isDeepDive := FALSE;
		unsigned2 penalt :=0;
		unsigned6 subject_did;
		string30	watercraft_key;
		string30	sequence_key;
		string2		state_origin;
		string8 date_last_seen;
		boolean   NonDMVSource;
		string30	hull_number;
		string40	watercraft_name;
		string8		registration_date;
		string20	registration_number;
		string30	Make;
		string30	Model;
		unsigned2 YearMake;
		string20	MajorColor;
		string20	MinorColor;
		unsigned2	watercraft_length;
		dataset(engine_rec) engines {maxcount(ut.limits.MAX_WATERCRAFT_ENGINES)}; // thor_data400::key::watercraft::fcra::20160701::wid
		dataset(owner_search_rec) owners {maxcount(ut.limits.MAX_WATERCRAFT_OWNERS)}; // thor_data400::key::watercraft::fcra::20160701::sid
		//thor_data400::key::watercraft::fcra::20160701::cid & thor_data400::key::watercraft::fcra::20160701::wid
		FFD.Layouts.CommonRawRecordElements;
	end;
	
	export report_out := RECORD
		flat_rec;
		dataset(engine_rec) engines {maxcount(ut.limits.MAX_WATERCRAFT_ENGINES)};
		dataset(lien_rec)    lienholders {maxcount(ut.limits.MAX_WATERCRAFT_LH)};
		dataset(owner_report_rec)   owners {maxcount(ut.limits.MAX_WATERCRAFT_OWNERS)};
		FFD.Layouts.CommonRawRecordElements;
	END;
	
	export batch_out :=record
		//key info
		batch_in.acctno;
		string1   output_type := '';
		search_watercraftkey and not [isDeepDive, subject_did];
		string10	watercraft_id:= '';
		string2		source_code:= '';
		boolean   NonDMVSource;
		wc_desc;
		engine_1_layout;
		engine_2_layout;
		engine_3_layout;
		own1_layout;
		own2_layout;
		LH1_Layout;
		LH2_Layout; 
		unsigned2 penalt := 0;
    Batchshare.layouts.ShareErrors;
		FFD.Layouts.ConsumerStatementBatch.SequenceNumber;
		FFD.Layouts.ConsumerFlags;
    string12 inquiry_lexid := '';
  end;
	
	export batch_out_pre :=record(batch_out)
		dataset (FFD.Layouts.ConsumerStatementBatch) statements;
	end;
	
	
	main_rec := Watercraft.Layout_Watercraft_Main_Base;
	shared ExtraInfo := RECORD
		acct_rec.acctno; //for batch
		unsigned2 penalt := 0; //for batch
		main_rec.propulsion_code;
		main_rec.vehicle_type_code;
		main_rec.hull_type_code;
		main_rec.watercraft_make_code;
	END;

	EXPORT WCReportEX := RECORD
		report_out;
		ExtraInfo;
		unsigned6 subject_did;
	END;

  export batch_report := record (WCReportEX)
    BatchShare.Layouts.ShareErrors;
  end;
	
	EXPORT int_raw_rec := record
		s_key_rec.dppa_flag;
		unsigned2 penalt := 0;
		unsigned6 subject_did;
		flat_s;
		dataset(owner_report_rec) owners {maxcount(20)};	
	end;
	
	EXPORT c_key_plus_rec := RECORD
		unsigned6 subject_did;
		Watercraft.Layout_Watercraft_Coastguard_Base;
		dataset(FFD.Layouts.StatementIdRec) StatementIds := dataset([],FFD.Layouts.StatementIdRec);
		boolean isDisputed := false;
	END;

	EXPORT s_key_plus_rec := RECORD
		unsigned6 subject_did;
		Watercraft.Layout_Watercraft_Search_Base_slim;
		dataset(FFD.Layouts.StatementIdRec) StatementIds := dataset([],FFD.Layouts.StatementIdRec);
		boolean isDisputed := false;
	END;

	EXPORT w_key_plus_rec := RECORD
		unsigned6 subject_did;
		Watercraft.Layout_Watercraft_Main_Base;
		dataset(FFD.Layouts.StatementIdRec) StatementIds := dataset([],FFD.Layouts.StatementIdRec);
		boolean isDisputed := false;
	END;
	
END;