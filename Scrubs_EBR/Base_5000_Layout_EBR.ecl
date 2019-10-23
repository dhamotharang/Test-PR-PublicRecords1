import Scrubs_EBR, EBR;
	
	EXPORT Base_5000_Layout_EBR := RECORD
   
	 EBR.Layout_5000_Bank_Details_Base_AID	 -clean_address;
	 string10 clean_address_prim_range;
   string2 	clean_address_predir;
   string28 clean_address_prim_name;
   string4 	clean_address_addr_suffix;
   string2 	clean_address_postdir;
   string10 clean_address_unit_desig;
   string8 	clean_address_sec_range;
   string25 clean_address_p_city_name;
   string25 clean_address_v_city_name;
   string2 	clean_address_st;
   string5 	clean_address_zip;
   string4 	clean_address_zip4;
   string4 	clean_address_cart;
   string1 	clean_address_cr_sort_sz;
   string4 	clean_address_lot;
   string1 	clean_address_lot_order;
   string2 	clean_address_dbpc;
   string1 	clean_address_chk_digit;
   string2 	clean_address_rec_type;
   string5 	clean_address_county;
   string10 clean_address_geo_lat;
   string11 clean_address_geo_long;
   string4 	clean_address_msa;
   string7 	clean_address_geo_blk;
   string1 	clean_address_geo_match;
   string4 	clean_address_err_stat;
	 
 END;