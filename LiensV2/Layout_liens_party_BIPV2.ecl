﻿import address, BIPV2; 

EXPORT Layout_liens_party_BIPv2 := record
string50 tmsid;
string50 rmsid;
string orig_full_debtorname := '';
string orig_name := ''; 
string orig_lname := '';
string orig_fname := '';
string orig_mname := '';
string orig_suffix := '';
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
BIPV2.IDlayouts.l_xlink_ids;
UNSIGNED4	xadl2_keys_used			:=	0 ;
STRING		xadl2_keys_desc			:=	'';
INTEGER2	xadl2_weight				:=	0 ;
UNSIGNED2	xadl2_Score					:=	0 ;
UNSIGNED2	xadl2_distance			:=	0 ;
STRING22	xadl2_matches				:=	'';
STRING		xadl2_matches_desc	:=	'';
end;