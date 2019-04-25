// EXPORT SALT_profile_header := 'todo';


input_lay := RECORD
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
  string5 dodgy_tracking;
  unsigned8 nid;
  unsigned2 address_ind;
  unsigned2 name_ind;
  unsigned8 persistent_record_id;
  unsigned8 uid;
 END;

ds_temp := dataset(ut.foreign_prod + 'thor400_data::new_header_records_20140601', input_lay, thor);

ds1 := CHOOSEN(ds_temp, 1000000);
ds2 := CHOOSEN(ds_temp, 1000000, 1000000000);
ds3 := CHOOSEN(ds_temp, 1000000, 2000000000);
ds4 := CHOOSEN(ds_temp, 1000000, 3000000000);
ds5 := CHOOSEN(ds_temp, 1000000, 4000000000);
ds6 := CHOOSEN(ds_temp, 1000000, 5000000000);
ds7 := CHOOSEN(ds_temp, 1000000, 6000000000);
ds8 := CHOOSEN(ds_temp, 1000000, 7000000000);
ds9 := CHOOSEN(ds_temp, 1000000, 8000000000);
ds10 := CHOOSEN(ds_temp, 1000000, 9000000000);
ds11 := CHOOSEN(ds_temp, 1000000, 10000000000);
ds12 := CHOOSEN(ds_temp, 1000000, 11000000000);
ds13 := CHOOSEN(ds_temp, 1000000, 12000000000);
ds14 := CHOOSEN(ds_temp, 1000000, 13000000000);

ds :=
		ds1 +
		ds2 +
		ds3 +
		ds4 +
		ds5 +
		ds6 +
		ds7 +
		ds8 +
		ds9 +
		ds10 +
		ds11 +
		ds12 +
		ds13 +
		ds14 ;

zz_Koubsky_SALT.mac_profile(ds);
