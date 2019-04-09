﻿import liensv2, address;

export layout_liens_party_for_hogan := record

string50 tmsid;
string50 rmsid;
string10 orig_rmsid;
BOOLEAN	bCBFlag		:=	FALSE;
STRING	eviction	:=	'';
string orig_full_debtorname := '';
string orig_name := ''; 
string orig_lname := '';
string orig_fname := '';
string orig_mname := '';
string orig_suffix := '';
STRING8	DOB	:=	'';
string9 tax_id := '';
string9 ssn := '';
address.Layout_Clean_Name;
string cname := '';
string orig_address1 := '';
string orig_address2 := '';
string orig_city := '';
string orig_state := '';
string orig_zip5 := '';
string orig_zip4 := '';
string orig_county := '';
string orig_country :='';
address.Layout_Clean182;
string phone := '';
string name_type := '';
string12 DID  := '';
string12 BDID := '';
string8  date_first_seen := '';
string8  date_last_seen := '';
string8  date_vendor_first_reported := '';
string8  date_vendor_last_reported := '';
unsigned8 persistent_record_id := 0 ; 
string50 TMSID_old;
string50 RMSID_old;
unsigned4 global_sid;
unsigned8 record_sid;

end;