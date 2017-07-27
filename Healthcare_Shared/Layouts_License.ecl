EXPORT Layouts_License := MODULE

EXPORT license_in_layout := RECORD
		STRING group_key;
		STRING lic_num_in;
	  STRING lic_state_in;
	  STRING lic_type_in;
	  STRING prac_state_in;
END;

EXPORT candidates_layout := RECORD
		STRING group_key;
		STRING surrogate_key;
		STRING licensenumber;
		STRING licensestate;
		STRING licensetype;
		STRING licensestatus;
		STRING effective_date;
		STRING termination_date;
		// STRING license_start_date;
		// STRING license_end_date;
		// STRING license_load_date;
END;

EXPORT parsed_license_layout := RECORD
		STRING group_key;
		STRING lic_num_raw;
		STRING lic_state_in;
		STRING lic_type_in;
		STRING lic_nums_tok;
		UNSIGNED count_nums_tok;
		STRING lic_longest_num;
		STRING parsed_input_license_num;
		STRING lic_alphas_tok;
		UNSIGNED count_alphas_tok;
		STRING two_letter_tok_1;
		STRING two_letter_tok_2;
		STRING parsed_input_license_state;
		STRING prac_state;
		STRING parsed_input_license_type := '';
		unsigned input_lic_st := 9999999;
END;

EXPORT t_match_output_layout_license := RECORD
		STRING group_key;
		STRING lic_num_in;
		STRING lic_state_in;
		STRING lic_type_in;
		STRING aug_lic1_num;
		STRING aug_lic1_state;
		STRING aug_lic1_type;
		STRING aug_lic1_status;
		STRING aug_lic1_start_date;
		STRING aug_lic1_end_date;
		STRING license_ustat;
END;							
								
EXPORT aug_layout_license := RECORD
		candidates_layout;
		INTEGER verifying_record := 0;
END;

EXPORT lic_skinny_ranked := RECORD
	Healthcare_Shared.layouts_commonized.layout_all_license;
	candidates_layout;
	// UNSIGNED lic1_st := 0;
	UNSIGNED license_rank := 99;
	INTEGER lic_ustat := 0;
	INTEGER score := -1;
	STRING score_decode := '';
	INTEGER verifier := 0;
END;

EXPORT layout_std_license_rank := RECORD
	healthcare_shared.layouts_commonized.layout_std_common.surrogate_key;
	healthcare_shared.layouts_commonized.layout_std_common.lic_filedate;
	healthcare_shared.layouts_commonized.layout_all_license;
	INTEGER license_rank;
	// STRING filecode;
END;

END;