﻿IMPORT dx_common;
EXPORT layout_patriot_common := record
STRING10 pty_key;
STRING60 source;
STRING350 orig_pty_name;
STRING350 orig_vessel_name;
STRING100 country;
STRING10  name_type;
STRING50 addr_1;
STRING50 addr_2;
STRING50 addr_3;
STRING50 addr_4;
STRING50 addr_5;
STRING50 addr_6;
STRING50 addr_7;
STRING50 addr_8;
STRING50 addr_9;
STRING50 addr_10;
STRING75 remarks_1;
STRING75 remarks_2;
STRING75 remarks_3;
STRING75 remarks_4;
STRING75 remarks_5;
STRING75 remarks_6;
STRING75 remarks_7;
STRING75 remarks_8;
STRING75 remarks_9;
STRING75 remarks_10;
STRING75 remarks_11;
STRING75 remarks_12;
STRING75 remarks_13;
STRING75 remarks_14;
STRING75 remarks_15;
STRING75 remarks_16;
STRING75 remarks_17;
STRING75 remarks_18;
STRING75 remarks_19;
STRING75 remarks_20;
STRING75 remarks_21;
STRING75 remarks_22;
STRING75 remarks_23;
STRING75 remarks_24;
STRING75 remarks_25;
STRING75 remarks_26;
STRING75 remarks_27;
STRING75 remarks_28;
STRING75 remarks_29;
STRING75 remarks_30;
STRING350 company_name;
string entity_flag;
STRING5 title;
STRING20 fname;
STRING20 mname;
STRING20 lname;
STRING5 suffix;
STRING3 a_score;
STRING10 prim_range;
STRING2 predir;
STRING28 prim_name;
STRING4 addr_suffix;
STRING2 postdir;
STRING10 unit_desig;
STRING8 sec_range;
STRING25 p_city_name;
STRING25 v_city_name;
STRING2 st;
STRING5 zip;
STRING4 zip4;
STRING4 cart;
STRING1 cr_sort_sz;
STRING4 lot;
STRING1 lot_order;
STRING2 dpbc;
STRING1 chk_digit;
STRING2 record_type;
STRING2 ace_fips_st;
STRING3 county;
STRING10 geo_lat;
STRING11 geo_long;
STRING4 msa;
STRING7 geo_blk;
STRING1 geo_match;
STRING4 err_stat;
//DF-28226 - fields defined for delta build
dx_common.layout_metadata;
UNSIGNED6 did        := 0;
END;
