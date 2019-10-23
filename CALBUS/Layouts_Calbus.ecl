import Standard, address, BIPV2;

export Layouts_Calbus := module
	
	export Layout_raw := record
    string3		district_branch;
		string9		account_number;          
		string5		sub_account_number;
		string3		district;
		string3		account_type;
		string50	firm_name;
		string50	owner_name;
		string40	business_street ;
		string30	business_city;
		string2		business_state;
		string5		business_zip_5;
		string4		business_zip_plus_4;
		string7		business_foreign_zip;
		string35	business_country_name;
		string8		start_date;
		string1		ownership_code;
	end;
	
	// Record Length= 257
	export Layout_raw_crlf := record
	   Layout_raw;
	   string2 crlf;
	end;

	export Layout_Common := record
			string8   Process_date;
			string8   dt_first_seen;
			string8   dt_last_seen;
			string3	  DISTRICT_BRANCH;
			string13	ACCOUNT_NUMBER;
			string3	  DISTRICT;
			string4	  TAX_CODE_FULL;
			string50	FIRM_NAME;
			string50	OWNER_NAME;
			string40	BUSINESS_STREET;
			string30	BUSINESS_CITY;
			string2	  BUSINESS_STATE;
			string5	  BUSINESS_ZIP_5;
			string4	  BUSINESS_ZIP_PLUS_4;
			string7	  BUSINESS_FOREIGN_ZIP;
			string35	BUSINESS_COUNTRY_NAME;
			string40	MAILING_STREET;
			string30	MAILING_CITY;
			string2	  MAILING_STATE;
			string5	  MAILING_ZIP_5;
			string4	  MAILING_ZIP_PLUS_4;
			string7	  MAILING_FOREIGN_ZIP;
			string35	MAILING_COUNTRY_NAME;
			string8	  START_DATE;
			string5	  INDUSTRY_CODE;
			string6   NAICS_CODE;
			string2	  COUNTY_CODE;
			string3	  CITY_CODE;
			string1	  OWNERSHIP_CODE;
			string45  Tax_code_full_desc;
			string100 Industry_code_desc;
			string40  County_code_desc;
			string40  Ownership_code_desc;
			string10 	Business_prim_range;      //Business clean address
			string2   Business_predir;
			string28 	Business_prim_name;
			string4   Business_addr_suffix;
			string2   Business_postdir;
			string10 	Business_unit_desig;
			string8   Business_sec_range;
			string25 	Business_p_city_name;
			string25 	Business_v_city_name;
			string2   Business_st;
			string5   Business_zip5;
			string4   Business_zip4;
			string4   Business_cart;
			string1   Business_cr_sort_sz;
			string4   Business_lot;
			string1   Business_lot_order;
			string2   Business_dpbc;
			string1   Business_chk_digit;
			string2   Business_addr_rec_type;
			string2   Business_fips_state;
			string3   Business_fips_county;
			string10 	Business_geo_lat;
			string11 	Business_geo_long;
			string4   Business_cbsa;
			string7   Business_geo_blk;
			string1   Business_geo_match;
			string4   Business_err_stat;
			string10 	Mailing_prim_range;       //Mailing clean address
			string2   Mailing_predir;
			string28 	Mailing_prim_name;
			string4   Mailing_addr_suffix;
			string2   Mailing_postdir;
			string10 	Mailing_unit_desig;
			string8   Mailing_sec_range;
			string25 	Mailing_p_city_name;
			string25 	Mailing_v_city_name;
			string2   Mailing_st;
			string5   Mailing_zip5;
			string4   Mailing_zip4;
			string4   Mailing_cart;
			string1   Mailing_cr_sort_sz;
			string4   Mailing_lot;
			string1   Mailing_lot_order;
			string2   Mailing_dpbc;
			string1   Mailing_chk_digit;
			string2   Mailing_addr_rec_type;
			string2   Mailing_fips_state;
			string3   Mailing_fips_county;
			string10 	Mailing_geo_lat;
			string11 	Mailing_geo_long;
			string4   Mailing_cbsa;
			string7   Mailing_geo_blk;
			string1   Mailing_geo_match;
			string4   Mailing_err_stat;
			string5   Owner_title;
			string20  Owner_fname;
			string20  Owner_mname;
			string20  Owner_lname;
			string5   Owner_name_suffix;
			string3   Owner_name_score; 
			string5   sub_account_number;
	    string3   account_type;
  end;
  
  export Layout_AID_Common := record
			unsigned8	raw_aid							:= 0;
			unsigned8	ace_aid							:= 0;
			unsigned8	mail_raw_aid				:= 0;
			unsigned8	mail_ace_aid				:= 0;
			string100 prep_addr_line1			 		;
			string50	prep_addr_line_last			;
			string100 prep_mail_addr_line1		;
			string50	prep_mail_addr_line_last;
			Layout_Common											;   
  end;
			
  export Layout_Bdid := record
			unsigned6 bdid := 0;	  
			bipv2.IDlayouts.l_xlink_ids;	//Added for BIP project
			unsigned8 source_rec_id := 0; //Added for BIP project
			Layout_AID_Common;  
  end;
  
	export Layout_Base := record
			unsigned6 did 					:= 0;
			unsigned1 did_score 		:= 0;
			string9		ssn 					:= '';
			Layout_Bdid;  
  end;
  
	//** Layout that excludes the new AID fields for keys. 
	export Layout_Keys := record
			Layout_Base.did				;
			Layout_Base.did_score ;
			Layout_Base.ssn 			;
			Layout_Bdid.bdid			;
			Layout_Common-sub_account_number-account_type; //excluding new vendor fields from keys 
	end;
	
  export Layout_Autokeys := record
			Layout_Base.bdid;
			Layout_Base.did;
			Layout_Base.ACCOUNT_NUMBER;
			Layout_Base.FIRM_NAME;
			Layout_Base.OWNER_NAME;
			Standard.L_Address.base addr;
			standard.Name OwnerCleanName;
			unsigned6 zero  := 0;
			string1   blank := '';
  end;
		
	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Layout_AID_Temp :=
	  record
			unsigned8		unique_id;
			Layout_AID_Common		 ;			
	end;
		
	export Layout_AID_Clean_Temp :=
	  record
			string1 		addr_type 		:= ''	;
			unsigned8		unique_id						;
			string100 	prep_addr_line1			;
			string50		prep_addr_line_last	;
			unsigned8		raw_aid				:= 0	;
			unsigned8		ace_aid				:= 0	;
			address.Layout_Clean182_fips Clean_Addr;			
	  end;
  
end;