import aid;

EXPORT Layout_BusReg_Contact := RECORD
UNSIGNED6 did;
UNSIGNED6 bdid;
UNSIGNED6 br_id;
STRING25  ADCRecordNo;  // New persistent vendor field - 05/07/2014
STRING8   dt_first_seen;
STRING8   dt_last_seen;
STRING1   record_type;

STRING40 NAME;
STRING5  TITLE;
STRING50 ADD;
STRING50 CSZ;
STRING15 FEIN;
STRING12 SSN;
STRING10 PHONE;

STRING5  name_prefix;
STRING20 name_first;
STRING20 name_middle;
STRING20 name_last;
STRING5  name_suffix;
STRING3  name_score;

STRING10 prim_range;
STRING2  predir;
STRING28 prim_name;
STRING4  addr_suffix;
STRING2  postdir;
STRING10 unit_desig;
STRING8  sec_range;
STRING25 p_city_name;
STRING25 v_city_name;
STRING2  st;
STRING5  zip;
STRING4  zip4;
STRING4  cart;
STRING1  cr_sort_sz;
STRING4  lot;
STRING1  lot_order;
STRING2  dpbc;
STRING1  chk_digit;
STRING2  rec_type;
STRING2  ace_fips_st;
STRING3  fipscounty;
STRING10 geo_lat;
STRING11 geo_long;
STRING4  msa;
STRING7  geo_blk;
STRING1  geo_match;
STRING4  err_stat;
string100				Prep_addr_line1;
string50				prep_addr_line_last;			
AID.Common.xAID	Append_RawAID		:=	0;
AID.Common.xAID	Append_ACEAID		:=	0;
END;