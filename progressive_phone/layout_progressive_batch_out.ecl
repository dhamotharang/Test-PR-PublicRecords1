// layout updated to include matchcodes field for batch hit rate optimization project 4/2010

export layout_progressive_batch_out := record
       string20 acctno;
			 string8  matchcodes;
			 integer error_code;
	     string20 subj_first;
       string20 subj_middle;
       string20 subj_last;
       string5 subj_suffix; 
	     string10 subj_phone10;
       string120 subj_name_dual;
       string2 subj_phone_type;
       string6 subj_date_first;
       string6 subj_date_last;
       string3 phpl_phones_plus_type;
       string30 phpl_phone_carrier;
       string25 phpl_carrier_city;
       string2 phpl_carrier_state; 
	     string2 subj_phone_type_new := '';
		   string1 switch_type := '';
		   unsigned sort_order := 0;
		   unsigned sort_order_internal := 0;
		   unsigned sub_rule_number := 0;
		   string1 dup_phone_flag := '';
		   string2 vendor := '';
			 string40	subj_phone_relationship;
			 string3 phone_score := '';
			 string3 subj_phone_integrator_code := '';
			 string30 royalty_type := ''; //internal
			 string20 service_version := ''; //internal
			 layout_waterfall_phones_phone_shell;
end;