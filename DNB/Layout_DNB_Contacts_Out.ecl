export Layout_DNB_Contacts_Out := record
string12 did;
string12 bdid;
// From DNB Names record
string8  date_first_seen;
string8  date_last_seen;
string9  duns_number;
string13 exec_first_name;
string1  exec_middle_initial;
string15 exec_last_name;
string3  exec_suffix;
string2  exec_title_code;
string30 exec_title;
string30 exec_vanity_title;
string5  title;
string20 fname;
string20 mname;
string20 lname;
string5  name_suffix;
string3  name_score;
// Company Information for contact
string90 company_name;
/*
string10 company_prim_range ;
string2  company_predir;
string28 company_prim_name;
string4  company_addr_suffix;
string2  company_postdir;
string10 company_unit_desig;
string8  company_sec_range;
string25 company_p_city_name;
string25 company_v_city_name;
string2  company_st;
string5  company_zip;
string4  company_zip4;
string5  company_county;
string10 company_geo_lat;
string11 company_geo_long;
string4  company_msa;
string10 company_phone10;
*/
string1   record_type;           // 'C' Current
                                 // 'H' Historical
string1   active_duns_number;    // 'Y' Active Duns Number
                                 // 'N' Inactive Duns Number (deleted)
end;