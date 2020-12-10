import Inquiry_AccLogs, BIPV2, doxie, data_services, _control, std, ut;

//file_in := '~foreign::' + '10.173.14.201:7070' + '::' +'thor_data400::key::fcra::header_qa';  //FCRA
file_in := '~foreign::' + '10.173.14.201:7070' + '::' +'thor_data400::key::header_qa';  //NonFCRA

layout_input := RECORD
  unsigned6 s_did;
  //=>
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
  unsigned4 global_sid;
  unsigned8 record_sid;
  string1 valid_dob;
  unsigned6 hhid;
  string18 county_name;
  string120 listed_name;
  string10 listed_phone;
  unsigned4 dod;
  string1 death_code;
  unsigned4 lookup_did;
 END;

 
inDate := (INTEGER)ut.GetDate;
SevenYrs := Std.Date.AdjustCalendar(inDate,-7,,-1);


file_ds    := DISTRIBUTE(DATASET(file_in, layout_input,flat),(INTEGER) s_did);
file_sort  := SORT(file_ds, dt_last_seen);
file_trim  := DEDUP(file_sort, s_did);
ds2        := file_trim(TRIM((STRING)s_did,LEFT,RIGHT) <> '000000000000');
ds_over_7  := ds2(MAX((INTEGER)dt_last_seen[1..8] > SevenYrs));
idx        := INDEX(ds_over_7,{s_did},layout_input-s_did,file_in);//add keyed fields between the brackets and subtract them from layout_input
ds_final   := choosen(idx,100000);
//OUTPUT(CHOOSEN(idx,9999));


Output(ds_final,, '~layout_input', thor, compressed,overwrite);