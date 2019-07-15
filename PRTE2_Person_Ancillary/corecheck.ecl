import data_services;

Seg_layout := RECORD
  unsigned8 did;
  unsigned8 rid;
  string9 src;
  unsigned8 source_rid;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  string1 ambiguous;
  string1 consumer_disclosure;
  unsigned2 cleavepenalty;
  string1 ssn_ind;
  string1 dob_ind;
  string1 dlno_ind;
  string1 fname_ind;
  string1 mname_ind;
  string1 lname_ind;
  string2 addr_ind;
  string1 best_addr_ind;
  string1 phone_ind;
  string10 phone;
  string9 ssn;
  unsigned4 dob;
  string25 dl_nbr;
  string2 dl_state;
  string5 title;
  string20 fname;
  string20 mname;
  string28 lname;
  string5 sname;
  string5 occupation;
  string1 gender;
  string1 derived_gender;
  unsigned8 address_id;
  string4 addr_error_code;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 city;
  string2 st;
  string5 zip;
  string4 zip4;
  string5 addressstatus;
  string3 addresstype;
  unsigned6 boca_did;
  string18 vendor_id;
  string6 ambest;
  string20 policy_number;
  string2 insurance_type;
  string20 claim_number;
  unsigned4 dt_effective_first;
  unsigned4 dt_effective_last;
  string5 ssn5;
  string4 ssn4;
  unsigned8 __internal_fpos__;
END;

filename := '~prte::key::insuranceheader_xlink::qa::idl';

coreCheck2 := index({unsigned8 did}, seg_layout, filename);
																				 
export corecheck:=Project(coreCheck2,TRANSFORM(layouts.layout_coreCheck2,
                                  SELF:=Left;
																  SELF := []));
															
