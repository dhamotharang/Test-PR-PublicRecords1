EXPORT Jigsaw := 

MODULE

	SHARED	lSubDirName					:=	'';
	SHARED	lCSVVersion					:=	'20091214';
	SHARED	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

  SHARED Keybuild := 
	RECORD
    STRING7 companyid;
    STRING8 contactid;
    STRING128 firstname;
    STRING128 lastname;
    STRING128 title;
    STRING70 email;
    STRING10 phone;
    STRING2 rank;
    STRING128 companyname;
    STRING128 companystreetaddress;
    STRING60 companycity;
    STRING30 companystate;
    STRING15 companyzip;
    STRING15 companycountry;
    STRING70 companyurl;
    STRING1 graveyardstatus;
    STRING20 updatetimestamp;
    STRING9 status;
  END;

  SHARED Layout_Clean_Name := 
	RECORD
   STRING5 title;
   STRING20 fname;
   STRING20 mname;
   STRING20 lname;
   STRING5 name_suffix;
   STRING3 name_score;
  END;

  SHARED Layout_Clean182_fips :=
	RECORD
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

EXPORT rthor_data400__key__jigsaw_bdid	:=
RECORD
  UNSIGNED6 bdid;
  UNSIGNED6 did;
  UNSIGNED1 did_score;
  UNSIGNED1 bdid_score;
  UNSIGNED8 raw_aid;
  UNSIGNED8 ace_aid;
  UNSIGNED4 dt_first_seen;
  UNSIGNED4 dt_last_seen;
  UNSIGNED4 dt_vendor_first_reported;
  UNSIGNED4 dt_vendor_last_reported;
  STRING1 record_type;
  Keybuild rawfields;
  Layout_Clean_Name clean_name;
  Layout_Clean182_fips clean_address;
  UNSIGNED8 __internal_fpos__;
END;

EXPORT rthor_data400__key__jigsaw_did	:=
RECORD
  UNSIGNED6 did;
  UNSIGNED1 did_score;
  UNSIGNED6 bdid;
  UNSIGNED1 bdid_score;
  UNSIGNED8 raw_aid;
  UNSIGNED8 ace_aid;
  UNSIGNED4 dt_first_seen;
  UNSIGNED4 dt_last_seen;
  UNSIGNED4 dt_vendor_first_reported;
  UNSIGNED4 dt_vendor_last_reported;
  STRING1 record_type;
  Keybuild rawfields;
  Layout_Clean_Name clean_name;
  Layout_Clean182_fips clean_address;
  UNSIGNED8 __internal_fpos__;
END;

EXPORT rthor_data400__key__jigsaw_linkids	:=
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
	UNSIGNED8 source_rec_id;
  UNSIGNED6 did;
  UNSIGNED1 did_score;
  UNSIGNED6 bdid;
  UNSIGNED1 bdid_score;
  UNSIGNED8 raw_aid;
  UNSIGNED8 ace_aid;
  UNSIGNED4 dt_first_seen;
  UNSIGNED4 dt_last_seen;
  UNSIGNED4 dt_vendor_first_reported;
  UNSIGNED4 dt_vendor_last_reported;
  STRING1 record_type;
  Keybuild rawfields;
  Layout_Clean_Name clean_name;
  Layout_Clean182_fips clean_address;
  INTEGER1 fp;
END;

EXPORT dthor_data400__key__jigsaw__bdid 	 := DATASET([], rthor_data400__key__jigsaw_bdid);
EXPORT dthor_data400__key__jigsaw__did 	   := DATASET([], rthor_data400__key__jigsaw_did);
EXPORT dthor_data400__key__jigsaw__linkids := DATASET([], rthor_data400__key__jigsaw_linkids);

END;
