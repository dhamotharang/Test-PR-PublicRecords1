export POESFROMUTILITIES := 
module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20090820g';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
shared layout_clean_name := RECORD
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string3 name_score;
  END;

shared layout_clean_slim := RECORD
   string10 prim_range;
   string2 predir;
   string28 prim_name;
   string4 addr_suffix;
   string2 postdir;
   string10 unit_desig;
   string8 sec_range;
   string25 city_name;
   string2 st;
   string5 zip;
   string4 zip4;
  END;

shared utilraw := RECORD
   string15 id;
   string10 exchange_serial_number;
   string8 date_added_to_exchange;
   string8 connect_date;
   string8 record_date;
   string10 util_type;
   string25 orig_lname;
   string20 orig_fname;
   string20 orig_mname;
   string5 orig_name_suffix;
   string1 addr_type;
   string1 addr_dual;
   string10 address_street;
   string100 address_street_name;
   string5 address_street_type;
   string2 address_street_direction;
   string10 address_apartment;
   string20 address_city;
   string2 address_state;
   string10 address_zip;
   string2 drivers_license_state_code;
   string22 drivers_license;
   string1 csa_indicator;
   string1 name_flag;
  END;

export rthor_data400__key__PFU__bdid := 
record
  unsigned6 bdid;
  string2 source;
  unsigned6 did;
  unsigned1 did_score;
  unsigned1 bdid_score;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  string40 vendor_id;
  Layout_clean_name subject_name;
  Layout_Clean_Slim subject_address;
  unsigned5 subject_phone;
  unsigned4 subject_ssn;
  unsigned4 subject_dob;
  string35 subject_job_title;
  unsigned8 subject_rawaid;
  unsigned8 subject_aceaid;
  string120 company_name;
  Layout_Clean_Slim company_address;
  unsigned5 company_phone;
  unsigned4 company_fein;
  unsigned8 company_rawaid;
  unsigned8 company_aceaid;
  utilraw rawfields;
 END;
 
export rthor_data400__key__PFU__did :=
RECORD
  unsigned6 did;
  string2 source;
  unsigned1 did_score;
  unsigned6 bdid;
  unsigned1 bdid_score;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  string40 vendor_id;
  Layout_clean_name subject_name;
  Layout_Clean_Slim subject_address;
  unsigned5 subject_phone;
  unsigned4 subject_ssn;
  unsigned4 subject_dob;
  string35 subject_job_title;
  unsigned8 subject_rawaid;
  unsigned8 subject_aceaid;
  string120 company_name;
  Layout_Clean_Slim company_address;
  unsigned5 company_phone;
  unsigned4 company_fein;
  unsigned8 company_rawaid;
  unsigned8 company_aceaid;
  utilraw rawfields;
 END;

export dthor_data400__key__PFU__bdid 									:= dataset([]								, rthor_data400__key__PFU__bdid									);
export dthor_data400__key__PFU__did 									:= dataset([]								, rthor_data400__key__PFU__did									);

end;
