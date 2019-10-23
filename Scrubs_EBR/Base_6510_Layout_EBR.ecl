import Scrubs_EBR, EBR;
	
	EXPORT Base_6510_Layout_EBR := RECORD
   
	 EBR.Layout_6510_Government_Debarred_Contractor_Base_AID	-clean_business_address -clean_business_name;
	 string10 clean_business_address_prim_range;
   string2 	clean_business_address_predir;
   string28 clean_business_address_prim_name;
   string4 	clean_business_address_addr_suffix;
   string2 	clean_business_address_postdir;
   string10 clean_business_address_unit_desig;
   string8 	clean_business_address_sec_range;
   string25 clean_business_address_p_city_name;
   string25 clean_business_address_v_city_name;
   string2 	clean_business_address_st;
   string5 	clean_business_address_zip;
   string4 	clean_business_address_zip4;
   string4 	clean_business_address_cart;
   string1 	clean_business_address_cr_sort_sz;
   string4 	clean_business_address_lot;
   string1 	clean_business_address_lot_order;
   string2 	clean_business_address_dbpc;
   string1 	clean_business_address_chk_digit;
   string2 	clean_business_address_rec_type;
   string5 	clean_business_address_county;
   string10 clean_business_address_geo_lat;
   string11 clean_business_address_geo_long;
   string4 	clean_business_address_msa;
   string7 	clean_business_address_geo_blk;
   string1 	clean_business_address_geo_match;
   string4 	clean_business_address_err_stat;
	 string5  clean_business_name_title;
	 string20 clean_business_name_fname;
	 string20 clean_business_name_mname;
	 string20 clean_business_name_lname;
	 string5  clean_business_name_name_suffix;
	 string3  clean_business_name_name_score;
	 
 END;