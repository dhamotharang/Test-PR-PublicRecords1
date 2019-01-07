
EXPORT Layouts_Alpha := MODULE

	EXPORT Layout_InsHead := RECORD
		INTEGER			id;
		UNSIGNED6		RID;
		STRING2 		ADDR_IND;
		STRING9			fb_ssn;
		STRING30		fb_first_name;
		STRING20		fb_mid_name;
		STRING30		fb_last_name;
		STRING30		fb_2lst_name; 
		STRING20		fb_sfx_name;
		STRING20		fb_house_num;
		STRING30		fb_street;
		STRING20		fb_stsfx;
		STRING20		fb_unit_name;
		STRING20		fb_unit_no;
		STRING30		fb_city;
		STRING5			fb_state;
		STRING9			fb_zip;
		STRING3			fb_gender;
		STRING8			fb_dob;
		STRING30		fb_dln;
		STRING2			fb_dlstate;
		STRING20		fb_dln_type;										
		STRING1628 	fb_other;
		STRING8   	fb_loaddt;
		STRING4   	fb_score;
		UNSIGNED6 	fb_seq;
		STRING1   	fb_rest;
		STRING8 		fb_first_dt;
		STRING8			fb_last_dt;
	END;

END;