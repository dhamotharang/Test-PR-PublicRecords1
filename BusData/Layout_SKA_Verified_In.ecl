export Layout_SKA_Verified_In := record
string5    TTL;               //Formerly PRENAME
string30   FIRST_NAME;        //Changed from length of 15
string1    MIDDLE;
string30   LAST_NAME;         //Changed from length of 15
string31   T1;                //Formerly COMPANY_TITLE
string3    DO;                //Changed from length of 15
string3    DEPTCODE;          //Formerly KEY_CODE
string31   DEPT_EXPL;         //Formerly KEY_TITLE
string40   KEY_FILE;
string100  COMPANY1;          //Formerly COMPANY_NAME and length of 31
string80   ADDRESS1;          //Changed from length of 31
string30   CITY;              //Changed from length of 17
string2    STATE; 
string10   ZIP;
string80   ADDRESS2;          //Changed from length of 31
string30   CITY2;             //Changed from length of 17
string2    STATE2;
string10   ZIP2;
string5    FIPS;
string12   PHONE;
string3    SPEC;
string31   SPEC_EXPL;
string3    SPEC2;
string40   SPEC2_EXPL;
string3    SPEC3;
string40   SPEC3_EXPL;
string7    ID;
string10   PERSID;            //Changed from length of 7
string3    OWNER;
string1    EMAILAVAIL;        //Added as part of new layout

string5    title;
string20   fname;
string20   mname;
string20   lname;
string5    name_suffix;
string3    name_score;
string10   mail_prim_range;
string2    mail_predir;
string28   mail_prim_name;
string4    mail_addr_suffix;
string2    mail_postdir;
string10   mail_unit_desig;
string8    mail_sec_range;
string25   mail_p_city_name;
string25   mail_v_city_name;
string2    mail_st;
string5    mail_zip;
string4    mail_zip4;
string4    mail_cart;
string1    mail_cr_sort_sz;
string4    mail_lot;
string1    mail_lot_order;
string2    mail_dbpc;
string1    mail_chk_digit;
string2    mail_rec_type;
string2    mail_ace_fips_state;
string3    mail_county;
string10   mail_geo_lat;
string11   mail_geo_long;
string4    mail_msa;
string7    mail_geo_blk;
string1    mail_geo_match;
string4    mail_err_stat;
string10   alt_prim_range;
string2    alt_predir;
string28   alt_prim_name;
string4    alt_addr_suffix;
string2    alt_postdir;
string10   alt_unit_desig;
string8    alt_sec_range;
string25   alt_p_city_name;
string25   alt_v_city_name;
string2    alt_st;
string5    alt_zip;
string4    alt_zip4;
string4    alt_cart;
string1    alt_cr_sort_sz;
string4    alt_lot;
string1    alt_lot_order;
string2    alt_dbpc;
string1    alt_chk_digit;
string2    alt_rec_type;
string2    alt_ace_fips_state;
string3    alt_county;
string10   alt_geo_lat;
string11   alt_geo_long;
string4    alt_msa;
string7    alt_geo_blk;
string1    alt_geo_match;
string4    alt_err_stat;
string1    lf;
end;