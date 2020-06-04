EXPORT Regulatory := MODULE
	import watercraft, BIPV2, suppress;

	EXPORT		Layout_Watercraft_Main_Base
						 :=
							RECORD
							string30	watercraft_key;
							string30	sequence_key;
							string10	watercraft_id;
							string2		state_origin;
							string2		source_code;
							string2		st_registration;
							string15	county_registration;
							string20	registration_number;
							string30	hull_number;
							string2		propulsion_code;
							string20	propulsion_description;
							string2		vehicle_type_code;
							string20	vehicle_type_description;
							string1		fuel_code;
							string20	fuel_description;
							string5		hull_type_code;
							string20	hull_type_description;
							string5		use_code;
							string20	use_description;
							string4		model_year;
							string40	watercraft_name;
							string5		watercraft_class_code;
							string35	watercraft_class_description;
							string5		watercraft_make_code;
							string30	watercraft_make_description;
							string5		watercraft_model_code;
							string30	watercraft_model_description;
							string5		watercraft_length;
							string5		watercraft_width;
							string10	watercraft_weight;
							string3		watercraft_color_1_code;
							string20	watercraft_color_1_description;
							string3		watercraft_color_2_code;
							string20	watercraft_color_2_description;
							string2		watercraft_toilet_code;
							string40	watercraft_toilet_description;
							string2		watercraft_number_of_engines;
							string5		watercraft_hp_1;
							string5		watercraft_hp_2;
							string5		watercraft_hp_3;
							string20	engine_number_1;
							string20	engine_number_2;
							string20	engine_number_3;
							string20	engine_make_1;
							string20	engine_make_2;
							string20	engine_make_3;
							string20	engine_model_1;
							string20	engine_model_2;
							string20	engine_model_3;
							string4		engine_year_1;
							string4		engine_year_2;
							string4		engine_year_3;
							string1		coast_guard_documented_flag;
							string30	coast_guard_number;
							string8		registration_date;
							string8		registration_expiration_date;
							string5		registration_status_code;
							string40	registration_status_description;
							string8		registration_status_date;
							string8		registration_renewal_date;
							string20	decal_number;
							string5		transaction_type_code;
							string40	transaction_type_description;
							string2		title_state;
							string5		title_status_code;
							string40	title_status_description;
							string20	title_number;
							string8		title_issue_date;
							string5		title_type_code;
							string20	title_type_description;
							string1		additional_owner_count;
							string1		lien_1_indicator;
							string40	lien_1_name;
							string8		lien_1_date;
							string60	lien_1_address_1;
							string60	lien_1_address_2;
							string25	lien_1_city;
							string2		lien_1_state;
							string10	lien_1_zip;
							string1		lien_2_indicator;
							string40	lien_2_name;
							string8		lien_2_date;
							string60	lien_2_address_1;
							string60	lien_2_address_2;
							string25	lien_2_city;
							string2		lien_2_state;
							string10	lien_2_zip;
							string2		state_purchased;
							string8		purchase_date;
							string40	dealer;
							string10	purchase_price;
							string1		new_used_flag;
							string5		watercraft_status_code;
							string20	watercraft_status_description;
							string1		history_flag;
							string1		coastguard_flag;
							string4     signatory := '' ;
							unsigned8  persistent_record_id :=0;
							//CCPA-206 Add 2 CCPA fields
							UNSIGNED4	global_sid:=0;
							UNSIGNED8	record_sid:=0;
	END;
		
		
	EXPORT Layout_Watercraft_Search_Base_slim
	 :=
		record
		string8		date_first_seen;
		string8		date_last_seen;
		string8		date_vendor_first_reported;
		string8		date_vendor_last_reported;
		string30	watercraft_key;
		string30	sequence_key;
		string2		state_origin;
		string2		source_code;
		string1		dppa_flag;
		string100	orig_name;
		string1		orig_name_type_code;
		string20	orig_name_type_description;
		string25	orig_name_first;
		string25	orig_name_middle;
		string25	orig_name_last;
		string10	orig_name_suffix;
		string60	orig_address_1;
		string60	orig_address_2;
		string25	orig_city;
		string2		orig_state;
		string10	orig_zip;
		string5		orig_fips;
		string30    orig_province :='';
		string30    orig_country  :='';
		string8		dob;
		string9		orig_ssn;
		string9		orig_fein;
		string1		gender;
		string10	phone_1;
		string10	phone_2;
		string5		title;
		string20	fname;
		string20	mname;
		string20	lname;
		string5		name_suffix;
		string3		name_cleaning_score;
		string60	company_name;
		string10	prim_range;
		string2		predir;
		string28	prim_name;
		string4		suffix;
		string2		postdir;
		string10	unit_desig;
		string8		sec_range;
		string25	p_city_name;
		string25	v_city_name;
		string2		st;
		string5		zip5;
		string4		zip4;
		string3		county;
		string4		cart;
		string1		cr_sort_sz;
		string4		lot;
		string1		lot_order;
		string2		dpbc;
		string1		chk_digit;
		string2		rec_type;
		string2		ace_fips_st;
		string3		ace_fips_county;
		string10	geo_lat;
		string11	geo_long;
		string4		msa;
		string7		geo_blk;
		string1		geo_match;
		string4		err_stat;
		string12	bdid;
		string9		fein;
		string12	did;
		string3		did_score;
		string9		ssn;
		string1		history_flag;
		unsigned8 RawAID:=0;
		string100 Reg_Owner_Name_2:=''; 
		unsigned8 persistent_record_id := 0; 
		//CCPA-206 Add 2 CCPA fields
		UNSIGNED4	global_sid:=0;
		UNSIGNED8	record_sid:=0;
	END;
	
	EXPORT Layout_Watercraft_Search_Base:= record
		// watercraft.Regulatory.Layout_Watercraft_Search_Base_slim;
		Layout_Watercraft_Search_Base_slim;
		unsigned8	source_rec_id  :=  0		;
		suppress.layout_regulatory.LZ_l_xlink_ids;
	END;			
			
	EXPORT Layout_Scrubs_Search_Base := RECORD
		Layout_Watercraft_Search_Base;
		unsigned scrubsbits1;
		unsigned scrubsbits2;
	END;
	
	EXPORT Layout_Scrubs_Main_Base := RECORD
		Layout_Watercraft_Main_Base;
		unsigned scrubsbits1;
		unsigned scrubsbits2;
	END;

	//
	// Special append for watercraft 
	//
	export simple_append_WC (base_ds, filename, Drop_Layout, endrec=false) := functionmacro
		import Watercraft, Suppress;

		Base_File_Append_In := suppress.applyRegulatory.getFile(filename, Drop_Layout);
		src_cd_max := count(base_ds);

		recordof(base_ds) reformat_append(Base_File_Append_In L, Integer C ) := transform
				self.source_rec_id := src_cd_max + C ;
				self := L ;
				self := [] ;
		end;

		Base_file_append := project(Base_File_Append_In, reformat_append(left, COUNTER));	

		return base_ds + Base_file_append;			
	endmacro; // simple_append_WC


	export applyWatercraftSearch(ds) := functionmacro
		import Watercraft, Suppress;

		WatercraftHash(recordof(ds) L) := hashmd5(trim((string)l.watercraft_key, 	left, right), 
			trim((string)l.sequence_key, 		left, right),
			trim((string)l.company_name, left, right),
			trim((string)l.fname, 					left, right),
			trim((string)l.mname, 					left, right),
			trim((string)l.lname, 					left, right)) ;						  
							
		ds1 := Suppress.applyRegulatory.simple_sup(ds, 'file_watercraft_search_sup.txt', WatercraftHash);
							
		return Watercraft.Regulatory.simple_append_WC(ds1, 'file_watercraft_search_inj.txt', Watercraft.Regulatory.Layout_Scrubs_Search_Base); 
	endmacro; // applyWatercraftS


	export applyWatercraftMain (ds) := functionmacro	
		import Watercraft, Suppress;

		WatercraftHash(recordof(ds) L) := hashmd5(trim((string)l.watercraft_key, 	left, right), 
																							trim((string)l.sequence_key, 		left, right)) ;						  
		
		ds1 := Suppress.applyRegulatory.simple_sup(ds, 'file_watercraft_main_sup.txt', WatercraftHash);
									
		return suppress.applyRegulatory.simple_append(ds1, 'file_watercraft_main_inj.txt', Watercraft.Regulatory.Layout_Scrubs_Main_Base); 
	endmacro; // applyWatercraftMain


END;