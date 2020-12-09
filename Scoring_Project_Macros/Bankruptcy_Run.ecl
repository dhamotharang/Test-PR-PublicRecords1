import _Control, std, ut, lib_stringlib.StringLib, lib_timelib.TimeLib, Scoring_Project_Macros;


inDate := (INTEGER)ut.GetDate;
TenYrs := Std.Date.AdjustCalendar(inDate,-10,,-1);


//test
//file_in := '~foreign::' + '10.173.44.105:7070' + '::' + 'thor_data400::key::bankruptcyv3::fcra::search::tmsid_linkids_qa';   //FCRA
file_in := '~foreign::' + '10.173.44.105:7070' + '::' + 'thor_data400::key::bankruptcyv3::search::tmsid_linkids_qa';          //NonFCRA


layout_input := RECORD
  string50 tmsid;
  //=>
  string8 process_date;
  string12 caseid;
  string12 defendantid;
  string12 recid;
  string10 seq_number;
  string5 court_code;
  string7 case_number;
  string25 orig_case_number;
  string3 chapter;
  string1 filing_type;
  string1 business_flag;
  string1 corp_flag;
  string8 discharged;
  string35 disposition;
  string3 pro_se_ind;
  string8 converted_date;
  string30 orig_county;
  string2 debtor_type;
  string3 debtor_seq;
  string9 ssn;
  string1 ssnsrc;
  string9 ssnmatch;
  string1 ssnmsrc;
  string1 screen;
  string2 dcode;
  string3 disptype;
  string3 dispreason;
  string8 statusdate;
  string8 holdcase;
  string8 datevacated;
  string8 datetransferred;
  string12 activityreceipt;
  string9 tax_id;
  string2 name_type;
  string200 orig_name;
  string50 orig_fname;
  string30 orig_mname;
  string50 orig_lname;
  string5 orig_name_suffix;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string150 cname;
  string150 orig_company;
  string80 orig_addr1;
  string80 orig_addr2;
  string80 orig_city;
  string2 orig_st;
  string5 orig_zip5;
  string4 orig_zip4;
  string250 orig_email;
  string10 orig_fax;
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
  string10 phone;
  string12 did;
  string12 bdid;
  string9 app_ssn;
  string9 app_tax_id;
  string8 date_first_seen;
  string8 date_last_seen;
  string8 date_vendor_first_reported;
  string8 date_vendor_last_reported;
  string35 disptypedesc;
  string35 srcdesc;
  string35 srcmtchdesc;
  string35 screendesc;
  string35 dcodedesc;
  string8 date_filed;
  string128 record_type;
  string1 delete_flag;
  unsigned6 dotid;
  unsigned2 dotscore;
  unsigned2 dotweight;
  unsigned6 empid;
  unsigned2 empscore;
  unsigned2 empweight;
  unsigned6 powid;
  unsigned2 powscore;
  unsigned2 powweight;
  unsigned6 proxid;
  unsigned2 proxscore;
  unsigned2 proxweight;
  unsigned6 seleid;
  unsigned2 selescore;
  unsigned2 seleweight;
  unsigned6 orgid;
  unsigned2 orgscore;
  unsigned2 orgweight;
  unsigned6 ultid;
  unsigned2 ultscore;
  unsigned2 ultweight;
  unsigned8 source_rec_id;
 END;



RVSS_Lay := RECORD
STRING alphanumericinput;
STRING includeallheaderresults;
STRING did;
STRING socs;
STRING yob;
STRING housenum;
STRING hphone;
STRING zip5;
STRING fname;
STRING middle;
STRING lname;
STRING suffix;
STRING addr;
STRING city;
STRING state;
STRING zip;
STRING dob;
STRING instant_ip;
STRING8 date_last_seen;
END;



RVSS_Lay RVSS(layout_input L):= TRANSFORM
	SELF.alphanumericinput       := '1';
	SELF.did                     := L.did;
	SELF.includeallheaderresults := '1';
	SELF.socs := '';
	SELF.yob  := '';
	SELF.housenum := '';
	SELF.hphone := '';
	SELF.zip5 := '';
	SELF.fname := '';
	SELF.middle := '';
	SELF.lname := '';
	SELF.suffix := '';
	SELF.addr := '';
	SELF.city := '';
	SELF.state := '';
	SELF.zip := '';
	SELF.dob := '';
	SELF.instant_ip := 'http://broxievip.sc.seisint.com:9876';
	SELF.date_last_seen := L.date_last_seen;
END;




ds1        := DISTRIBUTE(DATASET(file_in,layout_input,THOR),(INTEGER)tmsid);
idx        := INDEX(ds1,{tmsid},layout_input-{tmsid},file_in);
file_sort  := SORT(idx,-tmsid);
file_trim  := DEDUP(file_sort,[tmsid,did],ALL);
ds2        := file_trim(TRIM(did,LEFT,RIGHT) <> '000000000000');
//ds2        := file_trim(TRIM(did,LEFT,RIGHT) = '124796567270');
ds_less_10 := ds2(MAX((INTEGER)date_last_seen[1..8] > TenYrs));
final_lay  := CHOOSEN(PROJECT(ds2,RVSS(LEFT)),25);
output(final_lay);


