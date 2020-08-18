EXPORT layout_BBB := RECORD
UNSIGNED1 level := 0;
UNSIGNED6 bdid;
STRING7 bbb_id;
STRING100 company_name;
//string100 address;
STRING12 country;
STRING14 phone;
STRING8 phone_type;
STRING8 report_date;
STRING255 http_link;
STRING100 member_title := '';
STRING8 member_since_date := '';
// clean address
STRING10 prim_range;
STRING2 predir;
STRING28 prim_name;
STRING4 addr_suffix;
STRING2 postdir;
STRING10 unit_desig;
STRING8 sec_range;
//string25 p_city_name;
STRING25 v_city_name;
STRING2 st;
STRING5 zip;
STRING4 zip4;
STRING4 cart;
STRING1 cr_sort_sz;
STRING4 lot;
STRING1 lot_order;
STRING2 dbpc;
STRING1 chk_digit;
STRING2 rec_type;
STRING2 fips_state;
STRING3 fips_county;
STRING10 geo_lat;//
STRING11 geo_long;
STRING4 msa;
STRING7 geo_blk;
STRING1 geo_match;
STRING4 err_stat;
// clean pphone
STRING10 phone10;
/* ******** place holder */
STRING1 TypeOfBusiness := '';
END;
