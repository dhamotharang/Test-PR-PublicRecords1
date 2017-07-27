export Layout_Cleaned_File :=  record
string100 clean_company_name;

//string100 clean_address_split;

//string73 clean_cleaned_name;
string5   			CCT1_Clean_title							;
string20 	 			CCT1_Clean_fname							;
string20  			CCT1_Clean_mname							;
string20 				CCT1_Clean_lname							;
string5  		 		CCT1_Clean_name_suffix 				;
string3     		CCT1_Clean_cleaning_score 	  ;


//string73 clean_cleaned_name_2;
string5   			CCT2_Clean_title							;
string20 	 			CCT2_Clean_fname							;
string20  			CCT2_Clean_mname							;
string20 				CCT2_Clean_lname							;
string5  		 		CCT2_Clean_name_suffix 				;
string3     		CCT2_Clean_cleaning_score 	  ;


recordof(Fictitious_Business_Names.File_Out_AllFlat_Rollup);

string10  	CCT_Address_Clean_prim_range			;
string2  		CCT_Address_Clean_predir					;
string28 		CCT_Address_Clean_prim_name				;
string4   	CCT_Address_Clean_addr_suffix			;
string2  		CCT_Address_Clean_postdir					;
string10  	CCT_Address_Clean_unit_desig			;
string8   	CCT_Address_Clean_sec_range				;
string25 		CCT_Address_Clean_p_city_name			;
string25 		CCT_Address_Clean_v_city_name			;
string2  		CCT_Address_Clean_st							;
string5  		CCT_Address_Clean_zip							;
string4  		CCT_Address_Clean_zip4						;
string4  		CCT_Address_Clean_cart						;
string1  		CCT_Address_Clean_cr_sort_sz			;
string4   	CCT_Address_Clean_lot							;
string1  		CCT_Address_Clean_lot_order				;
string2  		CCT_Address_Clean_dpbc						;
string1  		CCT_Address_Clean_chk_digit				;
string2  		CCT_Address_Clean_record_type			;
string2  	CCT_Address_Clean_ace_fips_st				;
string3  	CCT_Address_Clean_fipscounty				;
string10 	CCT_Address_Clean_geo_lat						;
string11 	CCT_Address_Clean_geo_long					;
string4 	CCT_Address_Clean_msa								;
string7  	CCT_Address_Clean_geo_match					;
string4  	CCT_Address_Clean_err_stat					;	

string10  	Business_Address_Clean_prim_range			;
string2 	 	Business_Address_Clean_predir					;
string28 		Business_Address_Clean_prim_name			;
string4   	Business_Address_Clean_addr_suffix		;
string2  		Business_Address_Clean_postdir				;
string10  	Business_Address_Clean_unit_desig			;
string8   	Business_Address_Clean_sec_range			;
string25 		Business_Address_Clean_p_city_name		;
string25 		Business_Address_Clean_v_city_name		;
string2  		Business_Address_Clean_st							;
string5  		Business_Address_Clean_zip						;
string4  		Business_Address_Clean_zip4						;
string4  		Business_Address_Clean_cart						;
string1  		Business_Address_Clean_cr_sort_sz			;
string4   	Business_Address_Clean_lot						;
string1  		Business_Address_Clean_lot_order			;
string2 	 	Business_Address_Clean_dpbc						;
string1  		Business_Address_Clean_chk_digit			;
string2 	 	Business_Address_Clean_record_type		;
string2  		Business_Address_Clean_ace_fips_st		;
string3  		Business_Address_Clean_fipscounty			;
string10 		Business_Address_Clean_geo_lat				;
string11 		Business_Address_Clean_geo_long				;
string4 		Business_Address_Clean_msa						;
string7  		Business_Address_Clean_geo_match			;
string4  		Business_Address_Clean_err_stat				;	

string10 BusinessTelephone_clean									;
string10 ContactTelephone_clean										;
end;
