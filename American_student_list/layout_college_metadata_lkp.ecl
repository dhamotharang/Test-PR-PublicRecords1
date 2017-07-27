export layout_college_metadata_lkp
	:=
		RECORD
			string6		act_code;
			string70	act_school_name;
			string60	ln_college_name;
			string60	asl_matchkey_cn;
			string30	state;
			string40	country;
			string1		act_participation_flag;	
			string6		alloy_matchkey;
			string5		tier;
			string60	asl_college_name;
			string3		asl_college_type;
			string3		asl_college_code;		
			string50	alloy_school_name;
			string1		alloy_school_size_code;
			string1		alloy_competitive_code;
			string1		alloy_tuition_code;
		END;