﻿export Layout_Sample_Cleave := record
  unsigned6 rcid;
  unsigned6 bdid;
  string2   source;
  qstring34 vendor_id;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  qstring120 company_name;
  qstring10 prim_range;
  string2   predir;
  qstring28 prim_name;
  qstring4  addr_suffix;
  string2   postdir;
  qstring5  unit_desig;
  qstring8  sec_range;
  qstring25 city;
  string2   state;
  unsigned3 zip;
  unsigned2 zip4;
  string3   county;
  string4   msa;
  unsigned6 phone;
  unsigned4 fein;
	unsigned2 pscore;  // penalty field
  end;
