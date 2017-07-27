import AID;
export Watchdog := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20100806a';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;


export rthor_data400__key__watchdog__best_did	:=
record
  unsigned6 did;
  qstring10 phone;
  qstring9 ssn;
  integer4 dob;
  qstring5 title;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
  qstring5 name_suffix;
  qstring10 prim_range;
  string2 predir;
  qstring28 prim_name;
  qstring4 suffix;
  string2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 city_name;
  string2 st;
  qstring5 zip;
  qstring4 zip4;
  unsigned3 addr_dt_last_seen;
  qstring8 dod;
  qstring17 prpty_deed_id;
  qstring22 vehicle_vehnum;
  qstring22 bkrupt_crtcode_caseno;
  integer4 main_count;
  integer4 search_count;
  qstring15 dl_number;
  qstring12 bdid;
  integer4 run_date;
  integer4 total_records;
  unsigned8 rawaid := 0;
  unsigned3 addr_dt_first_seen := 0;
  string10 adl_ind := '';
  string1 valid_ssn := '';
  unsigned8 __filepos;

end;


export rthor_data400__key__watchdog__best_did_nonblank	:=
record
  unsigned6 did;
  qstring10 phone;
  qstring9 ssn;
  integer4 dob;
  qstring5 title;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
  qstring5 name_suffix;
  qstring10 prim_range;
  string2 predir;
  qstring28 prim_name;
  qstring4 suffix;
  string2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 city_name;
  string2 st;
  qstring5 zip;
  qstring4 zip4;
  unsigned3 addr_dt_last_seen;
  qstring8 dod;
  qstring17 prpty_deed_id;
  qstring22 vehicle_vehnum;
  qstring22 bkrupt_crtcode_caseno;
  integer4 main_count;
  integer4 search_count;
  qstring15 dl_number;
  qstring12 bdid;
  integer4 run_date;
  integer4 total_records;
  unsigned8 rawaid := 0;
  unsigned3 addr_dt_first_seen := 0;
  string10 adl_ind := '';
  string1 valid_ssn := '';
  unsigned8 __filepos;

end;

export rthor_data400__key__watchdog__best_nonen_did	:=
record
  unsigned6 did;
  qstring10 phone;
  qstring9 ssn;
  integer4 dob;
  qstring5 title;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
  qstring5 name_suffix;
  qstring10 prim_range;
  string2 predir;
  qstring28 prim_name;
  qstring4 suffix;
  string2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 city_name;
  string2 st;
  qstring5 zip;
  qstring4 zip4;
  unsigned3 addr_dt_last_seen;
  qstring8 dod;
  qstring17 prpty_deed_id;
  qstring22 vehicle_vehnum;
  qstring22 bkrupt_crtcode_caseno;
  integer4 main_count;
  integer4 search_count;
  qstring15 dl_number;
  qstring12 bdid;
  integer4 run_date;
  integer4 total_records;
  unsigned8 rawaid := 0;
  unsigned3 addr_dt_first_seen := 0;
  string10 adl_ind := '';
  string1 valid_ssn := '';
  unsigned8 __filepos;
end;


export rthor_data400__key__watchdog__best_nonen_did_nonblank	:=
record
  unsigned6 did;
  qstring10 phone;
  qstring9 ssn;
  integer4 dob;
  qstring5 title;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
  qstring5 name_suffix;
  qstring10 prim_range;
  string2 predir;
  qstring28 prim_name;
  qstring4 suffix;
  string2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 city_name;
  string2 st;
  qstring5 zip;
  qstring4 zip4;
  unsigned3 addr_dt_last_seen;
  qstring8 dod;
  qstring17 prpty_deed_id;
  qstring22 vehicle_vehnum;
  qstring22 bkrupt_crtcode_caseno;
  integer4 main_count;
  integer4 search_count;
  qstring15 dl_number;
  qstring12 bdid;
  integer4 run_date;
  integer4 total_records;
  unsigned8 rawaid := 0;
  unsigned3 addr_dt_first_seen := 0;
  string10 adl_ind := '';
  string1 valid_ssn := '';
  unsigned8 __filepos;
end;

export rthor_data400__key__watchdog__nonglb_did	:=
RECORD
  unsigned6 did;
  qstring10 phone;
  qstring9 ssn;
  integer4 dob;
  qstring5 title;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
  qstring5 name_suffix;
  qstring10 prim_range;
  string2 predir;
  qstring28 prim_name;
  qstring4 suffix;
  string2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 city_name;
  string2 st;
  qstring5 zip;
  qstring4 zip4;
  unsigned3 addr_dt_last_seen;
  qstring8 dod;
  qstring17 prpty_deed_id;
  qstring22 vehicle_vehnum;
  qstring22 bkrupt_crtcode_caseno;
  integer4 main_count;
  integer4 search_count;
  qstring15 dl_number;
  qstring12 bdid;
  integer4 run_date;
  integer4 total_records;
  unsigned8 rawaid := 0;
  unsigned3 addr_dt_first_seen := 0;
  string10 adl_ind := '';
  string1 valid_ssn := '';
  string1 glb_name;
  string1 glb_address;
  string1 glb_dob;
  string1 glb_ssn;
  string1 glb_phone;
  unsigned8 filepos;
 END;


export rthor_data400__key__watchdog__nonglb_did_nonblank	:=
RECORD
  unsigned6 did;
  qstring10 phone;
  qstring9 ssn;
  integer4 dob;
  qstring5 title;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
  qstring5 name_suffix;
  qstring10 prim_range;
  string2 predir;
  qstring28 prim_name;
  qstring4 suffix;
  string2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 city_name;
  string2 st;
  qstring5 zip;
  qstring4 zip4;
  unsigned3 addr_dt_last_seen;
  qstring8 dod;
  qstring17 prpty_deed_id;
  qstring22 vehicle_vehnum;
  qstring22 bkrupt_crtcode_caseno;
  integer4 main_count;
  integer4 search_count;
  qstring15 dl_number;
  qstring12 bdid;
  integer4 run_date;
  integer4 total_records;
  unsigned8 rawaid := 0;
  unsigned3 addr_dt_first_seen := 0;
  string10 adl_ind := '';
  string1 valid_ssn := '';
  string1 glb_name;
  string1 glb_address;
  string1 glb_dob;
  string1 glb_ssn;
  string1 glb_phone;
  unsigned8 filepos;
 END;


export rthor_data400__key__watchdog__ssn_bads := { string9 s_ssn, unsigned8 cnt };

export dthor_data400__key__watchdog__best_did 								:= dataset(lCSVFileNamePrefix + 'thor_data400__key__watchdog__' + lCSVVersion + '__best_did.csv', rthor_data400__key__watchdog__best_did, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__watchdog__best_did_nonblank 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__watchdog__' + lCSVVersion + '__best_did_nonblank.csv', rthor_data400__key__watchdog__best_did_nonblank, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__watchdog__best_nonen_did 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__watchdog__' + lCSVVersion + '__best_nonen_did.csv', rthor_data400__key__watchdog__best_nonen_did, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__watchdog__best_nonen_did_nonblank 	:= dataset(lCSVFileNamePrefix + 'thor_data400__key__watchdog__' + lCSVVersion + '__best_nonen_did_nonblank.csv', rthor_data400__key__watchdog__best_nonen_did_nonblank, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__watchdog__nonglb_did 							:= dataset(lCSVFileNamePrefix + 'thor_data400__key__watchdog__' + lCSVVersion + '__nonglb_did.csv', rthor_data400__key__watchdog__nonglb_did, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__watchdog__nonglb_did_nonblank 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__watchdog__' + lCSVVersion + '__nonglb_did_nonblank.csv', rthor_data400__key__watchdog__nonglb_did_nonblank, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__watchdog__ssn_bads 								:= dataset(lCSVFileNamePrefix + 'thor_data400__key__watchdog__' + lCSVVersion + '__ssn_bads.csv', rthor_data400__key__watchdog__ssn_bads, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;