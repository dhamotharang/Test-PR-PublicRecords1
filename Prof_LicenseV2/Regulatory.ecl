EXPORT Regulatory := MODULE;

	export drop_Prof_LicenseV2_layout := RECORD
		string15 prolic_seq_id; //unsigned6
		string50 prolic_key;
		string8 date_first_seen;
		string8 date_last_seen;
		string60 profession_or_board;
		string60 license_type;
		string45 status;
		string20 orig_license_number;
		string20 license_number;
		string20 previous_license_number;
		string60 previous_license_type;
		string100 company_name;
		string80 orig_name;
		string3 name_order;
		string80 orig_former_name;
		string3 former_name_order;
		string80 orig_addr_1;
		string80 orig_addr_2;
		string80 orig_addr_3;
		string80 orig_addr_4;
		string40 orig_city;
		string2 orig_st;
		string9 orig_zip;
		string25 county_str;
		string35 country_str;
		string1 business_flag;
		string10 phone;
		string8 sex;
		string8 dob;
		string8 issue_date;
		string8 expiration_date;
		string8 last_renewal_date;
		string50 license_obtained_by;
		string1 board_action_indicator;
		string2 source_st;
		string60 vendor;
		string8 action_record_type;
		string50 action_complaint_violation_cds;
		string200 action_complaint_violation_desc;
		string8 action_complaint_violation_dt;
		string50 action_case_number;
		string8 action_effective_dt;
		string20 action_cds;
		string200 action_desc;
		string30 action_final_order_no;
		string30 action_status;
		string8 action_posting_status_dt;
		string100 action_original_filename_or_url;
		string15 additional_name_addr_type;
		string80 additional_orig_name;
		string3 additional_name_order;
		string80 additional_orig_additional_1;
		string80 additional_orig_additional_2;
		string80 additional_orig_additional_3;
		string80 additional_orig_additional_4;
		string40 additional_orig_city;
		string2 additional_orig_st;
		string9 additional_orig_zip;
		string10 additional_phone;
		string50 misc_occupation;
		string20 misc_practice_hours;
		string50 misc_practice_type;
		string50 misc_email;
		string10 misc_fax;
		string50 misc_web_site;
		string50 misc_other_id;
		string10 misc_other_id_type;
		string75 education_continuing_education;
		string30 education_1_school_attended;
		string15 education_1_dates_attended;
		string25 education_1_curriculum;
		string15 education_1_degree;
		string30 education_2_school_attended;
		string15 education_2_dates_attended;
		string25 education_2_curriculum;
		string15 education_2_degree;
		string30 education_3_school_attended;
		string15 education_3_dates_attended;
		string25 education_3_curriculum;
		string15 education_3_degree;
		string75 additional_licensing_specifics;
		string5 personal_pob_cd;
		string25 personal_pob_desc;
		string5 personal_race_cd;
		string25 personal_race_desc;
		string10 status_status_cds;
		string8 status_effective_dt;
		string8 status_renewal_desc;
		string20 status_other_agency;
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 suffix;
		string2 postdir;
		string10 unit_desig;
		string8 sec_range;
		string25 p_city_name;
		string25 v_city_name;
		string2 st;
		string5 zip;
		string4 zip4;
		string4 cart;
		string1 cr_sort_sz;
		string4 lot;
		string1 lot_order;
		string2 dpbc;
		string1 chk_digit;
		string2 record_type;
		string2 ace_fips_st;
		string3 county;
		string10 geo_lat;
		string11 geo_long;
		string4 msa;
		string7 geo_blk;
		string1 geo_match;
		string4 err_stat;
		string5 title;
		string20 fname;
		string20 mname;
		string20 lname;
		string5 name_suffix;
		string3 pl_score_in;
		string18 county_name;
		string12 did;
		string3 score;
		string9 best_ssn;
		string12 bdid;
		string10 global_sid; // unsigned4 global_sid;
		// unsigned8 record_sid;
	END;
	
	EXPORT prepBase_Did(_base_ds) := FUNCTIONMACRO
		import Prof_LicenseV2;
		
		local _dsSup := Prof_LicenseV2.Regulatory.applyProfLicenseSup(_base_ds);
		return Prof_LicenseV2.Regulatory.applyProfLicenseInj_Did(_dsSup);

	ENDMACRO;

	EXPORT prepBase_Id(_base_ds) := FUNCTIONMACRO
		import Prof_LicenseV2;
		
		local _dsSup := Prof_LicenseV2.Regulatory.applyProfLicenseSup(_base_ds);
		return Prof_LicenseV2.Regulatory.applyProfLicenseInj_Id(_dsSup);

	ENDMACRO;

	EXPORT applyProfLicenseSup(_base_ds) := FUNCTIONMACRO
		import Prof_LicenseV2, Suppress, Std;

		local _DidAddressAslHash (recordof(_base_ds) _L) :=  hashmd5(
															(string)((unsigned6)_l.did)
															,Std.Str.CleanSpaces((string)_l.license_number)
															, Std.Str.CleanSpaces((string)_l.license_type)
															);
							
		local _dsUpdated := Suppress.applyRegulatory.simple_sup(_base_ds, 'file_prof_license_sup.txt', _DidAddressAslHash);
		return (_dsUpdated);

	ENDMACRO;

	EXPORT applyProfLicenseInj_Did(_base_ds) := FUNCTIONMACRO
		import Prof_LicenseV2, Suppress, Std;
		local _Base_File_Append_In := suppress.applyregulatory.getFile('file_prof_license_inj.txt', Prof_LicenseV2.Regulatory.drop_Prof_LicenseV2_layout );
		
		local unsigned6 _mpsi := max(_base_ds, prolic_seq_id);
		recordof(_base_ds) reformat_key(Prof_LicenseV2.Regulatory.drop_Prof_LicenseV2_layout  _pInput) := 
			 transform
				self.did := (unsigned6) _pInput.did;
				self.global_sid := (unsigned4) _pInput.global_sid;
				self.record_sid := 0;
				self.prolic_seq_id := _mpsi + (unsigned6) _pInput.prolic_seq_id;
				self := _pInput;
				self := [];
		end;
 
		local _Base_File_Append := project(_Base_File_Append_In, reformat_key(LEFT)); 
		
		return _base_ds + _Base_File_Append;
	ENDMACRO;

	EXPORT applyProfLicenseInj_Id(_base_ds) := FUNCTIONMACRO
		import Prof_LicenseV2, Suppress, Std;
		local _Base_File_Append_In := suppress.applyregulatory.getFile('file_prof_license_inj.txt', Prof_LicenseV2.Regulatory.drop_Prof_LicenseV2_layout );
		
		unsigned6 _mpsi := max(_base_ds, prolic_seq_id);
		recordof(_base_ds) reformat_key(Prof_LicenseV2.Regulatory.drop_Prof_LicenseV2_layout  _pInput) := 
			 transform
				self.global_sid := (unsigned4) _pInput.global_sid;
				self.record_sid := 0;
				self.prolic_seq_id := _mpsi + (unsigned6)_pInput.prolic_seq_id;
				self := _pInput;
				self := [];
		end;
 
		local _Base_File_Append := project(_Base_File_Append_In, reformat_key(LEFT)); 
		
		return _base_ds + _Base_File_Append;
	ENDMACRO;

END;