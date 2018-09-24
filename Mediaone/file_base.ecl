EXPORT file_base := MODULE
	IMPORT Data_Services;
  EXPORT layout:=RECORD
    // Original Data
    STRING    email;
    STRING    fname;
    STRING    lname;
    STRING    address;
    STRING    city;
    STRING    zip;
    STRING    state;
    STRING    phone;
    STRING    source;
    STRING    ip;
    STRING    date_time;
    STRING    gender;
    STRING    dob;
    STRING    nonincentivized_opt_in;
    STRING    incentivized_opt_in;

    // Information harvested from the DID lookup process
    UNSIGNED8 did;
    UNSIGNED8 did_score;
    UNSIGNED8 aid;

    // Information harvested from the CleanPersonFML73 function
    STRING5  clean_title;
    STRING20 clean_fname;
    STRING20 clean_mname;
    STRING20 clean_lname;
    STRING5  clean_name_suffix;
    STRING3  clean_name_score;

    // information harvested from the AID lookup process
    STRING10 clean_prim_range;
    STRING2  clean_predir;
    STRING28 clean_prim_name;
    STRING4  clean_addr_suffix;
    STRING2  clean_postdir;
    STRING10 clean_unit_desig;
    STRING8  clean_sec_range;
    STRING25 clean_p_city_name;
    STRING25 clean_v_city_name;
    STRING2  clean_st;
    STRING5  clean_zip;
    STRING4  clean_zip4;
    STRING4  clean_cart;
    STRING1  clean_cr_sort_sz;
    STRING4  clean_lot;
    STRING1  clean_lot_order;
    STRING2  clean_dbpc;
    STRING1  clean_chk_digit;
    STRING2  clean_rec_type;
    STRING5  clean_county;
    STRING10 clean_geo_lat;
    STRING11 clean_geo_long;
    STRING4  clean_msa;
    STRING7  clean_geo_blk;
    STRING1  clean_geo_match;
    STRING4  clean_err_stat;

    // Instance tracking fields
    STRING8  date_first_seen;
    STRING8  date_last_seen;
    STRING8  date_vendor_first_reported;
    STRING8  date_vendor_last_reported;
		boolean		current_rec; //Added to distinguish historical records from new full file replacement
  END;
	
	EXPORT file:=DATASET('~thor::base::mediaone',layout,THOR);
END;