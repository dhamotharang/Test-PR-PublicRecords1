import lib_stringlib, watercraft;

Watercraft.Macro_Clean_Hull_ID(WATERCRAFT.file_NE_clean_in, watercraft.Layout_NE_clean_in,hull_clean_in)

Layout_NE_clean_temp := record

watercraft.Layout_NE_clean_in;
watercraft.Layout_MIC;

boolean is_hull_id_in_MIC;
    	
end;

Layout_NE_clean_temp main_mapping_temp(hull_clean_in L, watercraft.file_MIC R)

:= transform

self := L;
self := R;
self.is_hull_id_in_MIC := if(trim(L.hull_id, left, right)[1..3] = R.MIC, true, false);

end;

Mapping_NE_as_Main_temp := join(hull_clean_in, watercraft.file_MIC, trim(left.hull_id, left, right)[1..3] = right.MIC,
main_mapping_temp(left, right), left outer, lookup);




Watercraft.Layout_Watercraft_Search_Group search_mapping_format(Mapping_NE_as_Main_temp L, integer1 C)
 :=
  transform
	self.date_first_seen			:=	L.REG_DATE;
	self.date_last_seen				:=	L.REG_DATE;
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
	self.watercraft_key				:=	if(trim(L.YEAR, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID, left, right), if(L.HULL_ID = '',
	                                    (trim(L.MAKE, left, right) + trim(L.YEAR, left, right) + trim(L.NAME, left, right))[1..30], (trim(L.HULL_ID, left, right) + 
									    trim(L.MAKE, left, right) + trim(L.YEAR, left, right))[1..30]));
	self.sequence_key				:=	L.REG_DATE;
	self.state_origin				:=	'NE';
	self.source_code				:=	'AW';
	self.dppa_flag                  :=  '';
	self.orig_name					:=	L.NAME;
	self.orig_name_type_code		:=	'O';
	self.orig_name_type_description	:=	'OWNER';
	self.orig_name_first			:=	L.FIRST_NAME;
	self.orig_name_middle			:=	L.MID;
	self.orig_name_last				:=	L.LAST_NAME;
	self.orig_name_suffix			:=	'';
	self.orig_address_1				:=	trim(L.ADDRESS_1, left, right);
	self.orig_address_2				:=	L.Title_Address_2;
	self.orig_city					:=	L.CITY;
	self.orig_state					:=	L.STATE;
	self.orig_zip					:=	L.ZIP;
	self.orig_fips					:=	L.FIPS;
	self.dob						:=	'';
	self.orig_ssn					:=	'';
	self.orig_fein					:=	'';
	self.gender						:=	'';
	self.phone_1					:=	'';
	self.phone_2					:=	'';
	self.clean_pname                :=  choose(C,L.pname1, L.pname2,L.pname3, L.pname4, L.pname5);
	self.company_name				:=	choose(C,L.cname1, L.cname2,L.cname3, L.cname4, L.cname5 );
	self.clean_address              :=  L.clean_address;            
	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	'';
	self.did_score					:=	'';                              
	self.ssn						:=	'';
	self.history_flag               :=  '';
  end
 ; 
 
Mapping_NE_as_Search_norm			:= normalize(Mapping_NE_as_Main_temp,5,search_mapping_format(left,counter));

export Mapping_NE_as_Search         := Mapping_NE_as_Search_norm(clean_pname <> '' or company_name <> '');









