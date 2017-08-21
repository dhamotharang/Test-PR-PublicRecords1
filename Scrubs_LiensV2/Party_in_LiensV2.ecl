import LiensV2, ut, address;

rlayout_liens_party := RECORD
string50 tmsid;
string50 rmsid;
string10 orig_rmsid;    //Hogan Only
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
string20 source_file;
end;

party_file_CA_Federal 	:= project(LiensV2.file_CA_federal_party, transform(rlayout_liens_party, self.source_file := 'CA FEDERAL'; self := LEFT; self := []));
party_file_chicago_law 	:= project(LiensV2.file_Chicago_Law_party, transform(rlayout_liens_party, self.source_file := 'CHICAGO LAW'; self := LEFT; self := []));
party_file_hogan 				:= project(LiensV2.file_Hogan_party, transform(rlayout_liens_party, self.source_file := 'HOGAN'; self := LEFT; self := []));
party_file_ilfdln      	:= project(LiensV2.file_ILFDLN_party, transform(rlayout_liens_party, self.source_file := 'ILFDLN'; self := LEFT; self := []));
party_file_ma          	:= project(LiensV2.file_MA_party, transform(rlayout_liens_party, self.source_file := 'MA'; self := LEFT; self := []));
party_file_nyc         	:= project(LiensV2.file_NYC_party, transform(rlayout_liens_party, self.source_file := 'NYC'; self := LEFT; self := []));
party_file_nyfdln      	:= project(LiensV2.file_NYFDLN_party, transform(rlayout_liens_party, self.source_file := 'NYFDLN'; self := LEFT; self := []));
party_file_sa          	:= project(LiensV2.file_SA_party, transform(rlayout_liens_party, self.source_file := 'SA'; self := LEFT; self := []));
party_file_superior    	:= project(LiensV2.file_Superior_party, transform(rlayout_liens_party, self.source_file := 'SUPERIOR'; self := LEFT; self := []));


EXPORT Party_in_LiensV2 := party_file_CA_Federal +
																party_file_chicago_law +
																party_file_hogan +
																party_file_ilfdln +
																party_file_ma +
																party_file_nyc	+
																party_file_nyfdln	+ 
																party_file_sa 	+
																party_file_superior;




