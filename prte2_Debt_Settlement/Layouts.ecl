Import Prte2;
EXPORT Layouts := MODULE

export Addressb2_layout:=RECORD
  string28 prim_name;
  string10 prim_range;
  string2 st;
  unsigned4 city_code;
  string5 zip;
  string8 sec_range;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;


Export Phoneb2_Layout:=RECORD
  string7 p7;
  string3 p3;
  string40 cname_indic;
  string40 cname_sec;
  string2 st;
  unsigned6 bdid;
  unsigned4 lookups;
 END;
 
common := RECORD
   string5 avdanumber;
   string35 attorneyname;
   string80 businessname;
   string70 dba;
   string15 orgid;
   string70 address1;
   string70 address2;
   string30 city;
   string2 state;
   string5 zip;
   string4 zip4;
   string16 phone;
   string16 fax;
   string50 email;
   string50 url;
   string75 status;
   string8 licensedatefrom;
   string8 licensedateto;
   string70 source;
   string50 miscellaneous;
  END;

layout_clean_name := RECORD
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string3 name_score;
  END;

layout_clean182_fips := RECORD
   string10 prim_range;
   string2 predir;
   string28 prim_name;
   string4 addr_suffix;
   string2 postdir;
   string10 unit_desig;
   string8 sec_range;
   string25 p_city_name;
   string25 v_city_name;
   string2 st;
   string5 zip;
   string4 zip4;
   string4 cart;
   string1 cr_sort_sz;
   string4 lot;
   string1 lot_order;
   string2 dbpc;
   string1 chk_digit;
   string2 rec_type;
   string2 fips_state;
   string3 fips_county;
   string10 geo_lat;
   string11 geo_long;
   string4 msa;
   string7 geo_blk;
   string1 geo_match;
   string4 err_stat;
  END;

cleaned_phones := RECORD
   string10 phone;
   string10 fax;
  END;

Export Payload_Layout:=RECORD
  unsigned6 fakeid;
  unsigned6 did;
  unsigned1 did_score;
  unsigned6 bdid;
  unsigned1 bdid_score;
  unsigned8 raw_aid;
  unsigned8 ace_aid;
  string1 record_type;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  common rawfields;
  layout_clean_name clean_attorney_name;
  layout_clean182_fips clean_address;
  cleaned_phones clean_phones;
	Prte2.Layouts.DEFLT_CPA;
  END;
 End;
