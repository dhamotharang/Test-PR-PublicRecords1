import doxie,ut,header, data_services;

layout:=record
  string1 pflag1:='';
  string1 pflag2:='';
  string1 pflag3:='';
  string2 src:='';
  unsigned3 dt_first_seen:=0;
  unsigned3 dt_last_seen:=0;
  unsigned3 dt_vendor_last_reported:=0;
  unsigned3 dt_vendor_first_reported:=0;
  unsigned3 dt_nonglb_last_seen:=0;
  string1 rec_type:='';
  qstring18 vendor_id:='';
  qstring10 phone:='';
  qstring9 ssn:='';
  integer4 dob:=0;
  qstring5 title:='';
  qstring20 fname:='';
  qstring20 mname:='';
  qstring20 lname:='';
  qstring5 name_suffix:='';
  qstring10 prim_range:='';
  string2 predir:='';
  qstring28 prim_name:='';
  qstring4 suffix:='';
  string2 postdir:='';
  qstring10 unit_desig:='';
  qstring8 sec_range:='';
  qstring25 city_name:='';
  string2 st:='';
  qstring5 zip:='';
  qstring4 zip4:='';
  string3 county:='';
  qstring7 geo_blk:='';
  qstring5 cbsa:='';
  string1 tnt:='';
  string1 valid_ssn:='';
  string1 jflag1:='';
  string1 jflag2:='';
  string1 jflag3:='';
  unsigned8 rawaid:=0;
  string5 dodgy_tracking:='';
  unsigned8 persistent_record_id:=0;
  unsigned4 not_in_bureau:=0;
 END;

export key_NLR_payload := INDEX (Header.Prep_NLR_key, {did,rid}, layout,
		Data_Services.Data_location.person_header+'thor_data400::key::header_nlr::did.rid_'+doxie.version_superkey);