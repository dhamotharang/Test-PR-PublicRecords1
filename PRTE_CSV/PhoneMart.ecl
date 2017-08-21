IMPORT PRTE2_Common;

EXPORT PhoneMart := MODULE

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20081114';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
EXPORT rthor_data400__key__phonesplus__did	:= RECORD
  unsigned6 l_did;
  string10 phone;
  unsigned6 did;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  string1 record_type;
  qstring18 cid_number;
  string10 csd_ref_number;
	STRING10 old_csd_ref_number;
  string9 ssn;
  string80 address;									//BUG 186793
  string28 city;
  string2 state;
  string5 zipcode;
  string1 history_flag;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  unsigned8 __internal_fpos__;
 END;

	EXPORT dthor_data400__key__phonemart__did	:= dataset([], rthor_data400__key__phonesplus__did);


end;