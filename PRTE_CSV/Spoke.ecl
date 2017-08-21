export Spoke :=

module
			
//	shared	lSubDirName					:=	'';
//	shared	lCSVVersion					:=	'';
//	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

export keybuild := RECORD
   string50 first_name;
   string50 last_name;
   string125 job_title;
   string255 company_name;
   string30 validation_date;
   string100 company_street_address;
   string40 company_city;
   string5 company_state;
   string16 company_postal_code;
   string20 company_phone_number;
   string30 company_annual_revenue;
   string255 company_business_description;
  END;

export layout_clean_name := RECORD
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string3 name_score;
  END;

export layout_clean182_fips := RECORD
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

export cleaned_dates := RECORD
   unsigned4 validation_date;
  END;

export cleaned_phones := RECORD
   string10 company_phone_number;
  END;

export rthor_data400__key__spoke__bdid	:=
record
  unsigned6 bdid;
  unsigned6 did;
  unsigned1 did_score;
  unsigned1 bdid_score;
  unsigned8 raw_aid;
  unsigned8 ace_aid;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  string1 record_type;
  keybuild rawfields;
  layout_clean_name clean_contact_name;
  layout_clean182_fips clean_company_address;
  cleaned_dates clean_dates;
  cleaned_phones clean_phones;
  unsigned8 __internal_fpos__;
end;

export rthor_data400__key__spoke__did	:=
record
  unsigned6 did;
  unsigned1 did_score;
  unsigned6 bdid;
  unsigned1 bdid_score;
  unsigned8 raw_aid;
  unsigned8 ace_aid;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  string1 record_type;
  keybuild rawfields;
  layout_clean_name clean_contact_name;
  layout_clean182_fips clean_company_address;
  cleaned_dates clean_dates;
  cleaned_phones clean_phones;
  unsigned8 __internal_fpos__;
end;

export layout_virtual := RECORD,maxlength(8192)
   string first_name;
   string last_name;
   string job_title;
   string company_name;
   string validation_date;
   string company_street_address;
   string company_city;
   string company_state;
   string company_postal_code;
   string company_phone_number;
   string company_annual_revenue;
   string company_business_description;
   string lf;
  END;

export rthor_data400__key__spoke__linkids := 
record
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  unsigned6 powid;
  unsigned6 empid;
  unsigned6 dotid;
  unsigned2 ultscore;
  unsigned2 orgscore;
  unsigned2 selescore;
  unsigned2 proxscore;
  unsigned2 powscore;
  unsigned2 empscore;
  unsigned2 dotscore;
  unsigned2 ultweight;
  unsigned2 orgweight;
  unsigned2 seleweight;
  unsigned2 proxweight;
  unsigned2 powweight;
  unsigned2 empweight;
  unsigned2 dotweight;
  unsigned6 did;
  unsigned1 did_score;
  unsigned6 bdid;
  unsigned1 bdid_score;
  unsigned8 raw_aid;
  unsigned8 ace_aid;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  string1 record_type;
  layout_virtual rawfields;
  layout_clean_name clean_contact_name;
  layout_clean182_fips clean_company_address;
  cleaned_dates clean_dates;
  cleaned_phones clean_phones;
  integer1 fp;
end;

export dthor_data400__key__spoke__bdid 									:= dataset([],rthor_data400__key__spoke__bdid);
export dthor_data400__key__spoke__did 									:= dataset([],rthor_data400__key__spoke__did);
export dthor_data400__key__spoke__linkids								:= dataset([],rthor_data400__key__spoke__linkids);
end;