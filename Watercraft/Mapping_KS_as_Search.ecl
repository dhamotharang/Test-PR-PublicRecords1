import lib_stringlib, watercraft;

Watercraft.Macro_Clean_Hull_ID(watercraft.file_KS_clean_in, watercraft.Layout_KS_clean_in,hull_clean_in)

Layout_KS_clean_temp := record

watercraft.Layout_KS_clean_in;
watercraft.Layout_MIC;

boolean is_hull_id_in_MIC;
    	
end;

Layout_KS_clean_temp main_mapping_temp(hull_clean_in L, watercraft.file_MIC R)

:= transform

self := L;
self := R;
self.is_hull_id_in_MIC := if(trim(L.hull_id, left, right)[1..3] = R.MIC, true, false);

end;

Mapping_KS_as_Main_temp := join(hull_clean_in, watercraft.file_MIC, trim(left.hull_id, left, right)[1..3] = right.MIC,
main_mapping_temp(left, right), left outer, lookup);


Watercraft.Layout_Watercraft_Search_Group search_mapping_format(Mapping_KS_as_Main_temp L)
 :=
  transform
	self.date_first_seen			:=	(string4)((unsigned2)(L.EXPIRATION_DATE[1..4]) - 3) + L.EXPIRATION_DATE[5..8];
	self.date_last_seen				:=	(string4)((unsigned2)(L.EXPIRATION_DATE[1..4]) - 3) + L.EXPIRATION_DATE[5..8];
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
	self.watercraft_key				:=	if(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID,left, right),
	                                    if(L.HULL_ID = '' or trim(L.YEAR, left, right) = '0' or L.make ='', trim(L.Reg_num, left, right), 
										(trim(L.HULL_ID, left, right) + trim(L.MAKE, left, right) + trim(L.YEAR, left, right))[1..30]));
	self.sequence_key				:=	trim(L.EXPIRATION_DATE, left, right);
	self.state_origin				:=	'KS';
	self.source_code				:=	'AW';
	self.dppa_flag					:=	'';
	self.orig_name					:=	L.NAME;
	self.orig_name_type_code		:=	'R';
	self.orig_name_type_description	:=	'REGISTRANT';
	self.orig_name_first			:=	L.FIRST_NAME;
	self.orig_name_middle			:=	L.MID;
	self.orig_name_last				:=	L.LAST_NAME;
	self.orig_name_suffix			:=	'';
	self.orig_address_1				:=	trim(L.ADDRESS_1, left, right);
	self.orig_address_2				:=	'';
	self.orig_city					:=	L.CITY;
	self.orig_state					:=	L.STATE;
	self.orig_zip					:=	L.ZIP;
	self.orig_fips					:=	L.FIPS;
	self.dob						:=	L.DOB;
	self.orig_ssn					:=	'';
	self.orig_fein					:=	'';
	self.gender						:=	'';
	self.phone_1					:=	'';
	self.phone_2					:=	'';
	self.clean_pname                :=  L.clean_pname;
	self.company_name				:=	L.clean_cname;
	self.clean_address              :=  L.clean_address;            
	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	'';
	self.did_score					:=	'';                              
	self.ssn						:=	'';
	self.history_flag				:=	'';
  end
 ; 
 
Mapping_KS_as_Search_norm			:= project(Mapping_KS_as_Main_temp,search_mapping_format(left));

export Mapping_KS_as_Search         := Mapping_KS_as_Search_norm(clean_pname <> '' or company_name <> '');


