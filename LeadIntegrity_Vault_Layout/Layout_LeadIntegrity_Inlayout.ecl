﻿EXPORT Layout_LeadIntegrity_Inlayout := RECORD
  unsigned4 seq;
  string30 acctno;
  string9 ssn;
  string120 unparsedfullname;
  string30 name_first;
  string30 name_middle;
  string30 name_last;
  string5 name_suffix;
  string8 dob;
  string65 street_addr;
  string25 p_city_name;
  string2 st;
  string5 z5;
  string20 dl_number;
  string2 dl_state;
  string10 home_phone;
  string10 work_phone;
  unsigned3 historydateyyyymm;
  unsigned6 lexid;
 END;