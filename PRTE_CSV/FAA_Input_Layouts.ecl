import FAA; 

export FAA_Input_Layouts := module

	shared max_size := _Dataset().max_record_size;

	export Input := module

		export Sprayed := module
		
			export layout_faa_airmen := record,maxlength(max_size)
				string d_score;
				string best_ssn;
				string did_out;   
				string date_first_seen;
				string date_last_seen;
				string current_flag;
				string record_type;
				string letter_code;
				string unique_id;
				string orig_rec_type;
				string orig_fname;
				string orig_lname;
				string street1;
				string street2;
				string city;
				string state;
				string zip_code;
				string country;
				string region;
				string med_class;
				string med_date;
				string med_exp_date;
				string prim_range;
				string predir;
				string prim_name;
				string suffix;
				string postdir;
				string unit_desig;
				string sec_range;
				string p_city_name;
				string v_city_name;
				string st;
				string zip;
				string zip4;
				string cart;
				string cr_sort_sz;
				string lot;
				string lot_order;
				string dpbc;
				string chk_digit;
				string rec_type;
				string ace_fips_st;
				string county;
				string county_name;
				string geo_lat;
				string geo_long;
				string msa;
				string geo_blk;
				string geo_match;
				string err_stat;
				string title;
				string fname;
				string mname;
				string lname;
				string name_suffix;
				string oer;
				string airmen_id;
				string __internal_fpos__;
				string persistent_record_id;
				string did;
			end; //layout_faa_airmen
			
			export layout_faa_aircraft_reg := record,maxlength(max_size)
				string d_score;
				string best_ssn;
				string did_out; 
				string bdid_out;
				string date_first_seen;
				string date_last_seen;
				string current_flag;
				string n_number;
				string serial_number;
				string mfr_mdl_code;
				string eng_mfr_mdl;
				string year_mfr;
				string type_registrant;
				string name;
				string street;
				string street2;
				string city;
				string state;
				string zip_code;
				string region;
				string orig_county;
				string country;
				string last_action_date;
				string cert_issue_date;
				string certification;
				string type_aircraft;
				string type_engine;
				string status_code;
				string mode_s_code;
				string fract_owner;
				string aircraft_mfr_name;
				string model_name;
				string prim_range;
				string predir;
				string prim_name;
				string addr_suffix;
				string postdir;
				string unit_desig;
				string sec_range;
				string p_city_name;
				string v_city_name;
				string st;
				string zip;
				string z4;
				string cart;
				string cr_sort_sz;
				string lot;
				string lot_order;
				string dpbc;
				string chk_digit;
				string rec_type;
				string ace_fips_st;
				string county;
				string geo_lat;
				string geo_long;
				string msa;
				string geo_blk;
				string geo_match;
				string err_stat;
				string title;
				string fname;
				string mname;
				string lname;
				string name_suffix;
				string compname;
				string lf;
				string aircraft_id;
				string persistent_record_id;	
				string __internal_fpos__;		
				string did;
				string bd;
			end; //layout_faa_aircraft_reg
	
			export layout_faa_airmen_certs := record,maxlength(max_size)
				string date_first_seen;
				string date_last_seen;
				string current_flag;
				string letter;
				string unique_id;
				string rec_type;
				string cer_type;
				string cer_type_mapped;
				string cer_level;
				string cer_level_mapped;
				string cer_exp_date;
				string ratings;
				string filler;
				string lfcr;
				string persistent_record_id;
				string uid;
				string __internal_fpos__;
			end; //layout_faa_airmen_certs			
			
		end; //Sprayed
		
		export Fixed := module
			
			export layout_faa_airmen := record
				faa.layout_airmen_data_out and not source;
				unsigned6 airmen_id := 0;
				unsigned8 __internal_fpos__;
				unsigned8 persistent_record_id := 0;
				unsigned8 did;
			end; //layout_faa_airmen
	
			export layout_faa_aircraft_reg := record
				faa.layout_aircraft_registration_out;
				unsigned6 aircraft_id;
				unsigned8 persistent_record_id := 0;	
				unsigned8 __internal_fpos__;		
				unsigned8 did;
				unsigned6 bd;
			end;
	
			export layout_faa_airmen_certs := record
				faa.layout_airmen_certificate_out;
				string7 uid;
				unsigned8 __internal_fpos__;
			end;
			
		end; //Fixed

	end; //Input		


	export AutoKey := module
	
			export Airmen := module
		
				export layout_faa_airmen := record
					faa.layout_airmen_data_out and not source;
					unsigned6 	airmen_id 	:= 0;
					unsigned1 	zero				:= 0;
					string1 		blank				:= '';
					unsigned6 	did_out6 		:= 0;
				end;
				
			end; //Airmen
	
	end; //AutoKey

end: DEPRECATED('Use PRTE2_FAA.Layouts instead.');
 //Layouts_FAA