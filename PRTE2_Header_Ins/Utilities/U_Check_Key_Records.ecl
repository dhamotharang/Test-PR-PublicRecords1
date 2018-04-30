/* **********************************************************************************
PRTE2_Header_Ins.U_Check_Key_Records
********************************************************************************** */
IMPORT PRTE2_Common, PRTE2_Header_Ins;

Add_Foreign_prod				:= PRTE2_Common.Constants.Add_Foreign_prod;
	
NewDIDs := [888809439154,888809439160,888809439162,888809439164,888809439166,888809439168,888809439170,888809439172,
							888809439175,888809439179,888809439182,888809439184,888809439186,888809439188,888809439190,888809439192,
							888809439206,888809439212,888809439214,888809439216,888809439218,888809439220,888809439222,888809439224,
							888809439227,888809439231,888809439234,888809439236,888809439238,888809439240,888809439242,888809439244];

DIDKeyLay_i := RECORD
  unsigned6 s_did;
END;
DIDKeyLay := RECORD
  unsigned6 did;
  unsigned6 rid;
  string1 pflag1;
  string1 pflag2;
  string1 pflag3;
  string2 src;
  unsigned3 dt_first_seen;
  unsigned3 dt_last_seen;
  unsigned3 dt_vendor_last_reported;
  unsigned3 dt_vendor_first_reported;
  unsigned3 dt_nonglb_last_seen;
  string1 rec_type;
  qstring18 vendor_id;
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
  string3 county;
  qstring7 geo_blk;
  qstring5 cbsa;
  string1 tnt;
  string1 valid_ssn;
  string1 jflag1;
  string1 jflag2;
  string1 jflag3;
  unsigned8 rawaid;
  unsigned8 persistent_record_id;
  string1 valid_dob;
  unsigned6 hhid;
  string18 county_name;
  string120 listed_name;
  string10 listed_phone;
  unsigned4 dod;
  string1 death_code;
  unsigned4 lookup_did;
END;

KeyFileName := Add_Foreign_prod('~prte::key::header::qa::data');
prct_data_key := INDEX({DIDKeyLay_i}, DIDKeyLay, keyFileName);
DS1 := prct_data_key(s_did in NewDIDs); 

COUNT(NewDIDs);
COUNT(DS1);
OUTPUT(DS1,all);