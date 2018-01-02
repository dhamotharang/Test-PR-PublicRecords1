import autokeyb2, doxie, data_services;

rec := RECORD
  unsigned6 fakeid;
  string15 booking_sid;
  string10 prim_range;
  string28 prim_name;
  string8 sec_range;
  string25 p_city_name;
  string2 state;
  string5 zip5;
  string20 fname;
  string20 mname;
  string20 lname;
  string9 ssn;
  string8 date_of_birth;
  unsigned8 did;
  string25 home_phone;
  string30 work_phone;
  //string did_str;
  unsigned1 zero;
  string1 blank;
  unsigned8 __internal_fpos__;
 END;

d := dataset([],rec);

export Key_Appriss_Autokey_Payload := index(dedup(d,record,all)
                                          ,{fakeid}
										  ,{d}
										  ,data_services.data_location.prefix() + 'thor_200::key::appriss::autokey::qa::payload');
										  