EXPORT One_Click_Data := 

MODULE
	SHARED	lCSVVersion					:=	'20091209a';

  SHARED Keybuild := RECORD
   STRING9 ssn;
   STRING40 firstname;
   STRING40 lastname;
   STRING39 dob;
   STRING64 homeaddress;
   STRING40 homecity;
   STRING13 homestate;
   STRING12 homezip;
   STRING10 homephone;
   STRING10 mobilephone;
   STRING100 emailaddress;
   STRING92 workname;
   STRING62 workaddress;
   STRING28 workcity;
   STRING2 workstate;
   STRING5 workzip;
   STRING35 workphone;
   STRING50 ref1firstname;
   STRING50 ref1lastname;
   STRING10 ref1phone;
   STRING8 lastinquirydate;
   STRING16 ip;
  END;

  SHARED layout_clean_name := RECORD
   STRING5 title;
   STRING20 fname;
   STRING20 mname;
   STRING20 lname;
   STRING5 name_suffix;
   STRING3 name_score;
  END;

  SHARED layout_clean182_fips := RECORD
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
   STRING2 dbpc;
   STRING1 chk_digit;
   STRING2 rec_type;
   STRING2 fips_state;
   STRING3 fips_county;
   STRING10 geo_lat;
   STRING11 geo_long;
   STRING4 msa;
   STRING7 geo_blk;
   STRING1 geo_match;
   STRING4 err_stat;
  END;

  SHARED cleaned_dates := RECORD
   UNSIGNED4 dob;
   UNSIGNED4 lastinquirydate;
  END;

  SHARED cleaned_phones := RECORD
   UNSIGNED5 homephone;
   UNSIGNED5 mobilephone;
   UNSIGNED5 workphone;
   UNSIGNED5 ref1phone;
  END;

  EXPORT rthor_data400__key__one_click_data__bdid	:=
  RECORD
   UNSIGNED6 bdid;
   UNSIGNED6 did;
   UNSIGNED1 did_score;
   UNSIGNED1 bdid_score;
   UNSIGNED8 raw_home_aid;
   UNSIGNED8 ace_home_aid;
   UNSIGNED8 raw_work_aid;
   UNSIGNED8 ace_work_aid;
   UNSIGNED4 dt_first_seen;
   UNSIGNED4 dt_last_seen;
   UNSIGNED4 dt_vendor_first_reported;
   UNSIGNED4 dt_vendor_last_reported;
   STRING1 record_type;
   Keybuild rawfields;
   Layout_Clean_Name clean_name;
   Layout_Clean182_fips clean_home_address;
   Layout_Clean182_fips clean_work_address;
   Cleaned_Dates clean_dates;
   Cleaned_Phones clean_phones;
   UNSIGNED8 __internal_fpos__;
  END;

  EXPORT rthor_data400__key__one_click_data__did	:=
  RECORD
   UNSIGNED6 did;
   UNSIGNED1 did_score;
   UNSIGNED6 bdid;
   UNSIGNED1 bdid_score;
   UNSIGNED8 raw_home_aid;
   UNSIGNED8 ace_home_aid;
   UNSIGNED8 raw_work_aid;
   UNSIGNED8 ace_work_aid;
   UNSIGNED4 dt_first_seen;
   UNSIGNED4 dt_last_seen;
   UNSIGNED4 dt_vendor_first_reported;
   UNSIGNED4 dt_vendor_last_reported;
   STRING1 record_type;
   Keybuild rawfields;
   Layout_Clean_Name clean_name;
   Layout_Clean182_fips clean_home_address;
   Layout_Clean182_fips clean_work_address;
   Cleaned_Dates clean_dates;
   Cleaned_Phones clean_phones;
   UNSIGNED8 __internal_fpos__;
  END;

  EXPORT rthor_data400__key__one_click_data__linkids	:=
  RECORD
   UNSIGNED6 ultid;
   UNSIGNED6 orgid;
   UNSIGNED6 seleid;
   UNSIGNED6 proxid;
   UNSIGNED6 powid;
   UNSIGNED6 empid;
   UNSIGNED6 dotid;
   UNSIGNED2 ultscore;
   UNSIGNED2 orgscore;
   UNSIGNED2 selescore;
   UNSIGNED2 proxscore;
   UNSIGNED2 powscore;
   UNSIGNED2 empscore;
   UNSIGNED2 dotscore;
   UNSIGNED2 ultweight;
   UNSIGNED2 orgweight;
   UNSIGNED2 seleweight;
   UNSIGNED2 proxweight;
   UNSIGNED2 powweight;
   UNSIGNED2 empweight;
   UNSIGNED2 dotweight;
   UNSIGNED6 did;
   UNSIGNED1 did_score;
   UNSIGNED6 bdid;
   UNSIGNED1 bdid_score;
   UNSIGNED8 raw_home_aid;
   UNSIGNED8 ace_home_aid;
   UNSIGNED8 raw_work_aid;
   UNSIGNED8 ace_work_aid;
   UNSIGNED4 dt_first_seen;
   UNSIGNED4 dt_last_seen;
   UNSIGNED4 dt_vendor_first_reported;
   UNSIGNED4 dt_vendor_last_reported;
   STRING1 record_type;
   Keybuild rawfields;
   layout_clean_name clean_name;
   layout_clean182_fips clean_home_address;
   layout_clean182_fips clean_work_address;
   cleaned_dates clean_dates;
   cleaned_phones clean_phones;
   INTEGER1 fp;
  END;

  EXPORT dthor_data400__key__one_click_data__bdid 	 := DATASET([], rthor_data400__key__one_click_data__bdid);
  EXPORT dthor_data400__key__one_click_data__did  	 := DATASET([], rthor_data400__key__one_click_data__did);
  EXPORT dthor_data400__key__one_click_data__linkids := DATASET([], rthor_data400__key__one_click_data__linkids);

END;