import _Control, ut, std;

file_in := '~foreign::' + '10.173.14.201:7070' + '::' +'thor_data400::key::liensv2::fcra::party::tmsid.rmsid_qa';

layout_input := RECORD
  string50 tmsid;
  string50 rmsid;
  //=>
  string orig_full_debtorname;
  string orig_name;
  string orig_lname;
  string orig_fname;
  string orig_mname;
  string orig_suffix;
  string9 tax_id;
  string9 ssn;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string cname;
  string orig_address1;
  string orig_address2;
  string orig_city;
  string orig_state;
  string orig_zip5;
  string orig_zip4;
  string orig_county;
  string orig_country;
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
  string phone;
  string name_type;
  string12 did;
  string12 bdid;
  string8 date_first_seen;
  string8 date_last_seen;
  string8 date_vendor_first_reported;
  string8 date_vendor_last_reported;
  unsigned8 persistent_record_id;
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
  unsigned4 global_sid;
  unsigned8 record_sid;
  string10 orig_rmsid;
  unsigned8 __internal_fpos__;
 END;
 
 
inDate := (INTEGER)ut.GetDate;
SevenYrs := Std.Date.AdjustCalendar(inDate,-7,,-1);
//output(SevenYrs); 


file_ds    := DISTRIBUTE(DATASET(file_in, layout_input,flat),(INTEGER) did);
file_sort  := SORT(file_ds, -date_last_seen);
file_trim  := DEDUP(file_sort, did);
ds2        := file_trim(TRIM(did,LEFT,RIGHT) <> '000000000000');
ds_over_7  := ds2(MAX((INTEGER)date_last_seen[1..8] > SevenYrs));
idx        := INDEX(ds_over_7,{tmsid,rmsid},layout_input-rmsid AND layout_input-tmsid,file_in);//add keyed fields between the brackets and subtract them from layout_input

OUTPUT(CHOOSEN(idx,500));
