EXPORT POEsFromEmails := 
MODULE

	SHARED	lCSVVersion					:=	'20091209a';

  SHARED layout_clean_name := RECORD
   STRING5 title;
   STRING20 fname;
   STRING20 mname;
   STRING20 lname;
   STRING5 name_suffix;
   STRING3 name_score;
  END;

  SHARED layout_clean_125 := RECORD
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
  END;

  SHARED layout_clean_slim := RECORD
   STRING10 prim_range;
   STRING2 predir;
   STRING28 prim_name;
   STRING4 addr_suffix;
   STRING2 postdir;
   STRING10 unit_desig;
   STRING8 sec_range;
   STRING25 city_name;
   STRING2 st;
   STRING5 zip;
   STRING4 zip4;
  END;

  EXPORT rthor_data400__key__POEsFromEmails__bdid	:=
  RECORD
   UNSIGNED6 bdid;
   UNSIGNED6 did;
   UNSIGNED6 group_id;
   UNSIGNED6 agrp_bdid;
   UNSIGNED4 date_first_seen;
   UNSIGNED4 date_last_seen;
   STRING200 clean_email;
   STRING2 email_src;
   REAL8 distance;
   Layout_Clean_Name pname;
   STRING9 best_ssn;
   UNSIGNED4 best_dob;
   Layout_Clean_125 person_addr;
   STRING10 person_addr_geo_lat;
   STRING11 person_addr_geo_long;
   UNSIGNED8 append_rawaid;
   UNSIGNED8 bh_rec_key;
   STRING120 bh_company_name;
   UNSIGNED6 bh_phone;
   Layout_Clean_Slim bh_company_addr;
   STRING10 bh_company_addr_geo_lat;
   STRING11 bh_company_addr_geo_long;
   UNSIGNED8 bh_rawaid;
  END;

  EXPORT rthor_data400__key__POEsFromEmails__did	:=
  RECORD
   UNSIGNED6 did;
   UNSIGNED6 bdid;
   UNSIGNED6 group_id;
   UNSIGNED6 agrp_bdid;
   UNSIGNED4 date_first_seen;
   UNSIGNED4 date_last_seen;
   STRING200 clean_email;
   STRING2 email_src;
   REAL8 distance;
   Layout_Clean_Name pname;
   STRING9 best_ssn;
   UNSIGNED4 best_dob;
   Layout_Clean_125 person_addr;
   STRING10 person_addr_geo_lat;
   STRING11 person_addr_geo_long;
   UNSIGNED8 append_rawaid;
   UNSIGNED8 bh_rec_key;
   STRING120 bh_company_name;
   UNSIGNED6 bh_phone;
   Layout_Clean_Slim bh_company_addr;
   STRING10 bh_company_addr_geo_lat;
   STRING11 bh_company_addr_geo_long;
   UNSIGNED8 bh_rawaid;
  END;

  EXPORT rthor_data400__key__POEsFromEmails__linkids	:=
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
   UNSIGNED6 bdid;
   UNSIGNED6 group_id;
   UNSIGNED6 agrp_bdid;
   UNSIGNED4 date_first_seen;
   UNSIGNED4 date_last_seen;
   STRING200 clean_email;
   STRING2 email_src;
   REAL8 distance;
   layout_clean_name pname;
   STRING9 best_ssn;
   UNSIGNED4 best_dob;
   layout_clean_125 person_addr;
   STRING10 person_addr_geo_lat;
   STRING11 person_addr_geo_long;
   UNSIGNED8 append_rawaid;
   UNSIGNED8 bh_rec_key;
   STRING120 bh_company_name;
   UNSIGNED6 bh_phone;
   layout_clean_slim bh_company_addr;
   STRING10 bh_company_addr_geo_lat;
   STRING11 bh_company_addr_geo_long;
   UNSIGNED8 bh_rawaid;
   INTEGER1 fp;
  END;

  EXPORT dthor_data400__key__POEsFromEmails__bdid 	 := DATASET([], rthor_data400__key__POEsFromEmails__bdid);
  EXPORT dthor_data400__key__POEsFromEmails__did  	 := DATASET([], rthor_data400__key__POEsFromEmails__did);
  EXPORT dthor_data400__key__POEsFromEmails__linkids := DATASET([], rthor_data400__key__POEsFromEmails__linkids);

END;