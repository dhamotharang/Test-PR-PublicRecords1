import header, ut, doxie, data_services, Watchdog_V2;

TeaserLayout := RECORD
  qstring20 lname;
  string2 st;
  string20 pfname :='';
  qstring20 fname;
  qstring5 zip;
  unsigned6 did;
  qstring10 phone;
  qstring9 ssn;
  integer4 dob;
  qstring5 title;
  qstring20 mname;
  qstring5 name_suffix;
  qstring10 prim_range;
  string2 predir;
  qstring28 prim_name;
  qstring4 suffix;
  string2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 city_name;
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
  unsigned8 rawaid;
  unsigned3 addr_dt_first_seen;
  string10 adl_ind;
  string1 valid_ssn;
  string1 glb_name;
  string1 glb_address;
  string1 glb_dob;
  string1 glb_ssn;
  string1 glb_phone;
  unsigned8 filepos;
 END;




Parms := Module(Watchdog_V2.UniversalKeyInterface)
EXPORT Permissions := Watchdog_V2.fn_UniversalKeySearch.PermissionsType.nonglb_noneq_teaser;
END;

EXPORT FilteredDS := Watchdog_V2.fn_UniversalKeySearch.FetchRecords(Parms);

SortNonglb_noneq_teaser := SORT (FilteredDS, lname,SKEW(1.0));

Nonglb_noneq_teaser := PROJECT(SortNonglb_noneq_teaser,TRANSFORM(TeaserLayout,self.pfname := datalib.preferredFirstNew(left.fname, true),SELF :=LEFT));

EXPORT key_watchdog_teaser_V2 := Nonglb_noneq_teaser;
 


