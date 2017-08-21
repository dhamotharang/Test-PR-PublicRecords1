#workunit('name', 'Convert corp to new layout');

Layout_Corp_old_Base := record
unsigned6 bdid := 0;       // Seisint Business Identifier
unsigned4 dt_first_seen;
unsigned4 dt_last_seen;
unsigned4 dt_vendor_first_reported;
unsigned4 dt_vendor_last_reported;
corp.Layout_Corporate_Direct_Corp_In;
string10  corp_phone10;
string10  corp_ra_phone10;
STRING1   record_type;           // 'C' Current
                               // 'H' Historical
end;

Layout_Corp_new_Base := record
unsigned6 bdid := 0;       // Seisint Business Identifier
unsigned4 dt_first_seen;
unsigned4 dt_last_seen;
unsigned4 dt_vendor_first_reported;
unsigned4 dt_vendor_last_reported;
corp.Layout_Corporate_Direct_Corp_In;
string32  corp_sos_charter_nbr;  // For application display
string10  corp_phone10;
string10  corp_ra_phone10;
STRING1   record_type;           // 'C' Current
                                 // 'H' Historical
end;

corp_base := dataset('~thor_data400::base::corp_basew20050719-121957', Layout_Corp_old_Base, flat);

Layout_Corp_Cont_old_Base := record
unsigned6 bdid := 0;       // Seisint Business Identifier
unsigned6 did := 0;
unsigned4 dt_first_seen;
unsigned4 dt_last_seen;
unsigned4 dt_vendor_first_reported;
unsigned4 dt_vendor_last_reported;
string30  corp_key;
string2   corp_vendor;
string2   corp_state_origin;
string8   corp_process_date;
string32  corp_orig_sos_charter_nbr;
string350 corp_legal_name;
string8   corp_address1_type_cd;
string60  corp_address1_type_desc;
string70  corp_address1_line1;
string70  corp_address1_line2;
string70  corp_address1_line3;
string70  corp_address1_line4;
string70  corp_address1_line5;
string70  corp_address1_line6;
string8   corp_address1_effective_date;
string30  corp_phone_number;
string8   corp_phone_number_type_cd;
string60  corp_phone_number_type_desc;
string30  corp_email_address;
string30  corp_web_address;
string30  cont_filing_reference_nbr;
string8   cont_filing_date;
string8   cont_filing_cd;
string60  cont_filing_desc;
string8   cont_type_cd;
string60  cont_type_desc;
string100 cont_name;
string60  cont_title_desc;
string10  cont_fein;
string9   cont_ssn;
string8   cont_dob;
string8   cont_effective_date;
string8   cont_address_type_cd;
string60  cont_address_type_desc;
string70  cont_address_line1;
string70  cont_address_line2;
string70  cont_address_line3;
string70  cont_address_line4;
string70  cont_address_line5;
string70  cont_address_line6;
string8   cont_address_effective_date;
string30  cont_phone_number;
string8   cont_phone_number_type_cd;
string60  cont_phone_number_type_desc;
string30  cont_email_address;
string30  cont_web_address;
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
string5   cont_title;
string20  cont_fname;
string20  cont_mname;
string20  cont_lname;
string5   cont_name_suffix;
string3   cont_score;
string70  cont_cname;
string3   cont_cname_score;
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
string10  corp_phone10;
string10  cont_phone10;
STRING1   record_type;           // 'C' Current
                                 // 'H' Historical
end;

Layout_Corp_Cont_new_Base := record
unsigned6 bdid := 0;       // Seisint Business Identifier
unsigned6 did := 0;
unsigned4 dt_first_seen;
unsigned4 dt_last_seen;
unsigned4 dt_vendor_first_reported;
unsigned4 dt_vendor_last_reported;
string30  corp_key;
string2   corp_vendor;
string2   corp_state_origin;
string8   corp_process_date;
string32  corp_orig_sos_charter_nbr;
string32  corp_sos_charter_nbr;  // For application display
string350 corp_legal_name;
string8   corp_address1_type_cd;
string60  corp_address1_type_desc;
string70  corp_address1_line1;
string70  corp_address1_line2;
string70  corp_address1_line3;
string70  corp_address1_line4;
string70  corp_address1_line5;
string70  corp_address1_line6;
string8   corp_address1_effective_date;
string30  corp_phone_number;
string8   corp_phone_number_type_cd;
string60  corp_phone_number_type_desc;
string30  corp_email_address;
string30  corp_web_address;
string30  cont_filing_reference_nbr;
string8   cont_filing_date;
string8   cont_filing_cd;
string60  cont_filing_desc;
string8   cont_type_cd;
string60  cont_type_desc;
string100 cont_name;
string60  cont_title_desc;
string10  cont_fein;
string9   cont_ssn;
string8   cont_dob;
string8   cont_effective_date;
string8   cont_address_type_cd;
string60  cont_address_type_desc;
string70  cont_address_line1;
string70  cont_address_line2;
string70  cont_address_line3;
string70  cont_address_line4;
string70  cont_address_line5;
string70  cont_address_line6;
string8   cont_address_effective_date;
string30  cont_phone_number;
string8   cont_phone_number_type_cd;
string60  cont_phone_number_type_desc;
string30  cont_email_address;
string30  cont_web_address;
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
string5   cont_title;
string20  cont_fname;
string20  cont_mname;
string20  cont_lname;
string5   cont_name_suffix;
string3   cont_score;
string70  cont_cname;
string3   cont_cname_score;
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
string10  corp_phone10;
string10  cont_phone10;
STRING1   record_type;           // 'C' Current
                                 // 'H' Historical
end;



corp_cont_base := dataset('~thor_data400::base::corp_cont_basew20050719-121957', Layout_Corp_Cont_old_Base, flat);



//transform them to new layout
Layout_Corp_new_Base tocorpnewlayout(corp_base l) := transform
self.corp_sos_charter_nbr := corp.map_charter_number(l.corp_vendor,l.corp_state_origin,l.corp_orig_sos_charter_nbr);
self := l;
end;

corp_new_base := project(corp_base,tocorpnewlayout(left));

output(corp_new_base,,'~thor_data400::base::corp_basew20050719_newformat',overwrite);

//cont transform
Layout_Corp_Cont_new_Base tocorpcontactnewlayout(corp_cont_base l) := transform
self.corp_sos_charter_nbr := corp.map_charter_number(l.corp_vendor,l.corp_state_origin,l.corp_orig_sos_charter_nbr);
self := l;
end;

corp_cont_new_base := project(corp_cont_base, tocorpcontactnewlayout(left));

output(corp_cont_new_base,,'~thor_data400::base::corp_cont_basew20050719_newformat',overwrite);
