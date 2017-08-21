export Layout_Corporate_Direct_Cont_In := record

string8   dt_first_seen;
string8   dt_last_seen;
	
string30  corp_key;
string30  corp_supp_key;
string2	  corp_vendor;
string3   corp_vendor_county;
string5   corp_vendor_subcode;
string2	  corp_state_origin;
string8	  corp_process_date;
string32  corp_orig_sos_charter_nbr;
	
string350 corp_legal_name;
	
string8	  corp_address1_type_cd;
string60  corp_address1_type_desc;
string70  corp_address1_line1;
string70  corp_address1_line2;
string70  corp_address1_line3;
string70  corp_address1_line4;
string70  corp_address1_line5;
string70  corp_address1_line6;
string8	  corp_address1_effective_date;
	
string30  corp_phone_number;
string8	  corp_phone_number_type_cd;
string60  corp_phone_number_type_desc;
string15  corp_fax_nbr;
string30  corp_email_address;
string30  corp_web_address;
	
string30  cont_filing_reference_nbr;
string8	  cont_filing_date;
string8	  cont_filing_cd;
string60  cont_filing_desc;
	
string8	  cont_type_cd;
string60  cont_type_desc;
string100 cont_name;
string60  cont_title1_desc;
string60  cont_title2_desc;
string60  cont_title3_desc;
string60  cont_title4_desc;
string60  cont_title5_desc;
string32  cont_sos_charter_nbr;
string10  cont_fein;
string9	  cont_ssn;
string8	  cont_dob;
string8   cont_status_cd;
string60  cont_status_desc;
string8	  cont_effective_date;
string1	  cont_effective_cd;
string60  cont_effective_desc;
string350 cont_addl_info;   //modified length from 100 to 350
	
string8	  cont_address_type_cd;
string60  cont_address_type_desc;
string70  cont_address_line1;
string70  cont_address_line2;
string70  cont_address_line3;
string70  cont_address_line4;
string70  cont_address_line5;
string70  cont_address_line6;
string8	  cont_address_effective_date;
string30  cont_address_county;
	
string30  cont_phone_number;
string8	  cont_phone_number_type_cd;
string60  cont_phone_number_type_desc;
string15  cont_fax_nbr;
string30  cont_email_address;
string30  cont_web_address;
/*	
string182 corp_addr1_clean;

string73  cont_pname1;	
string73  cont_pname2;	
string73  cont_pname3;	
string73  cont_pname4;	
string73  cont_pname5;
	
string70  cont_cname1;
string3	  cont_cname1_score;
	
string70  cont_cname2;
string3	  cont_cname2_score;

string182 cont_addr_clean;
*/
string10  corp_addr1_prim_range;
string2   corp_addr1_predir;
string28  corp_addr1_prim_name;
string4   corp_addr1_addr_suffix;
string2   corp_addr1_postdir;
string10  corp_addr1_unit_desig;
string8   corp_addr1_sec_range;
string25  corp_addr1_p_city_name;
string25  corp_addr1_v_city_name;
string2   corp_addr1_state;
string5   corp_addr1_zip5;
string4   corp_addr1_zip4;
string4   corp_addr1_cart;
string1   corp_addr1_cr_sort_sz;
string4   corp_addr1_lot;
string1   corp_addr1_lot_order;
string2   corp_addr1_dpbc;
string1   corp_addr1_chk_digit;
string2   corp_addr1_rec_type;
string2   corp_addr1_ace_fips_st;
string3   corp_addr1_county;
string10  corp_addr1_geo_lat;
string11  corp_addr1_geo_long;
string4   corp_addr1_msa;
string7   corp_addr1_geo_blk;
string1   corp_addr1_geo_match;
string4   corp_addr1_err_stat;
string5   cont_title1;
string20  cont_fname1;
string20  cont_mname1;
string20  cont_lname1;
string5   cont_name_suffix1;
string3   cont_score1;
string5   cont_title2;
string20  cont_fname2;
string20  cont_mname2;
string20  cont_lname2;
string5   cont_name_suffix2;
string3   cont_score2;
string5   cont_title3;
string20  cont_fname3;
string20  cont_mname3;
string20  cont_lname3;
string5   cont_name_suffix3;
string3   cont_score3;
string5   cont_title4;
string20  cont_fname4;
string20  cont_mname4;
string20  cont_lname4;
string5   cont_name_suffix4;
string3   cont_score4;
string5   cont_title5;
string20  cont_fname5;
string20  cont_mname5;
string20  cont_lname5;
string5   cont_name_suffix5;
string3   cont_score5;
string70  cont_cname1;
string3   cont_cname1_score;
string70  cont_cname2;
string3   cont_cname2_score;
string10  cont_prim_range;
string2   cont_predir;
string28  cont_prim_name;
string4   cont_addr_suffix;
string2   cont_postdir;
string10  cont_unit_desig;
string8   cont_sec_range;
string25  cont_p_city_name;
string25  cont_v_city_name;
string2   cont_state;
string5   cont_zip5;
string4   cont_zip4;
string4   cont_cart;
string1   cont_cr_sort_sz;
string4   cont_lot;
string1   cont_lot_order;
string2   cont_dpbc;
string1   cont_chk_digit;
string2   cont_rec_type;
string2   cont_ace_fips_st;
string3   cont_county;
string10  cont_geo_lat;
string11  cont_geo_long;
string4   cont_msa;
string7   cont_geo_blk;
string1   cont_geo_match;
string4   cont_err_stat;
// Adding the following fields for AID purposes
string100	corp_prep_addr_line1;
string50	corp_prep_addr_last_line;	
string100	cont_prep_addr_line1;
string50	cont_prep_addr_last_line;
	
end;