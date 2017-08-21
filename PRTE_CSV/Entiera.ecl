export Entiera := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20080921';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

EXPORT address__layout_clean_name := 
RECORD
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string3 name_score;
  END;

EXPORT address__layout_clean182 := 
RECORD
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
   string5 county;
   string10 geo_lat;
   string11 geo_long;
   string4 msa;
   string7 geo_blk;
   string1 geo_match;
   string4 err_stat;
  END;

export rthor_200__key__entiera__did	:=
record
	unsigned integer6 did;
	string orig_pmghousehold_id;
	string orig_pmgindividual_id;
	string orig_first_name;
	string orig_last_name;
	string orig_address;
	string orig_city;
	string orig_state;
	string orig_zip;
	string orig_zip4;
	string orig_email;
	string orig_ip;
	string orig_login_date;
	string orig_site;
	string orig_e360_id;
	string orig_teramedia_id;
	unsigned integer8 did_score;
	address__layout_clean_name clean_name;
	address__layout_clean182 clean_address;
	string9 best_ssn;
	unsigned integer4 best_dob;
	string8 process_date;
	unsigned integer8 __internal_fpos__;
end;

export dthor_200__key__entiera__did := dataset(lCSVFileNamePrefix + 'thor_200__key__entiera__' + lCSVVersion + '__did.csv', rthor_200__key__entiera__did, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;