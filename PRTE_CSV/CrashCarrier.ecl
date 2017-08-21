export CrashCarrier := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

sprayed_fixed :=
record
   string8 carrier_id;
   string8 crash_id;
   string1 carrier_source_code;
   string120 carrier_name;
   string50 carrier_street;
   string25 carrier_city;
   string5 carrier_city_code;
   string2 carrier_state;
   string10 carrier_zip_code;
   string25 crash_colonia;
   string2 prefix;
   string8 docket_number;
   string1 interstate;
   string1 no_id_flag;
   string12 state_number;
   string2 state_issuing_number;
end;
	
export rthor_data400__key__crashcarrier__linkids :=
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
  unsigned6 bdid;
  unsigned1 bdid_score;
  unsigned6 did;
  unsigned1 did_score;
  unsigned8 source_rec_id;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  sprayed_fixed raw;
  string2 source;
  string120 cleaned_carrier_name;
  string50 cleaned_carrier_street;
  string25 cleaned_carrier_city;
  string2 cleaned_carrier_state;
  string10 cleaned_carrier_zip_code;
  string2 cleaned_prefix;
  string60 carrier_name_source_desc;
  string20 interstate_desc;
  string20 no_census_number_desc;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
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
  unsigned8 ace_aid;
  unsigned8 raw_aid;
  integer1 fp;
end;

export dthor_data400__key__crashcarrier__linkids 	:= dataset([], rthor_data400__key__crashcarrier__linkids);
																										// dataset(lCSVFileNamePrefix + 'thor_data400__key__crashcarrier__' + lCSVVersion + '__linkids.csv', rthor_data400__key__crashcarrier__linkids, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));

end;