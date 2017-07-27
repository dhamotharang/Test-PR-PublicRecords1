import lib_stringlib, watercraft;

gender_desc(string1 code) 

:= case(code, 

'F' => 'FEMALE',
'M' => 'MALE', '');


Layout_MN_clean_temp := record

watercraft.Layout_MN_clean_in;
watercraft.Layout_MIC;

boolean is_hull_id;


boolean is_hull_id_in_MIC;
    	
end;

Layout_MN_clean_temp main_mapping_temp(watercraft.file_MN_clean_in L, watercraft.file_MIC R)

:= transform

self := L;
self := R;
self.is_hull_id := if(L.HULL_ID <> '' and trim(L.HULL_ID, left, right) <> 'UNKNOWN' and trim(L.HULL_ID, left, right) <> '************' 
                   and trim(L.HULL_ID, LEFT, RIGHT) <> '000000000000', true, false);
self.is_hull_id_in_MIC := if(trim(L.hull_id, left, right)[1..3] = R.MIC, true, false);

end;

Mapping_MN_as_Main_temp := join(watercraft.file_MN_clean_in, watercraft.file_MIC, trim(left.hull_id, left, right)[1..3] = right.MIC,
main_mapping_temp(left, right), left outer, lookup);



Watercraft.Layout_Watercraft_Search_Group search_mapping_format(Mapping_MN_as_Main_temp L, integer1 C)
 :=
  transform
	self.date_first_seen			:=	IF(L.REG_DATE <> '', L.REG_DATE, (string4)((unsigned4)(L.EXPDATE[1..4]) - 3) + L.EXPDATE[5..8]);
	self.date_last_seen				:=	IF(L.REG_DATE <> '', L.REG_DATE, (string4)((unsigned4)(L.EXPDATE[1..4]) - 3) + L.EXPDATE[5..8]);
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
	self.watercraft_key				:=	if(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID,left, right),
	                                    if(L.is_HULL_ID, (trim(L.HULL_ID, left, right) + trim(L.MAKE, left, right) + trim(L.YEAR, left, right))[1..30],
									    if(L.make = ''or trim(L.year, left, right) = '0', trim(L.REG_NUM, left, right), (trim(L.MAKE, left, right) + trim(L.YEAR, left, right) 
										+ trim(L.NAME, left, right))[1..30])));
	self.sequence_key				:=	trim(L.reg_date, left, right);
	self.state_origin				:=	'MN';
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
	self.orig_address_2				:=	'';
	self.orig_city					:=	L.CITY;
	self.orig_state					:=	L.STATE;
	self.orig_zip					:=	L.ZIP;
	self.orig_fips					:=	L.FIPS;
	self.dob						:=	'';
	self.orig_ssn					:=	'';
	self.orig_fein					:=	'';
	self.gender						:=	gender_desc(L.GENDER);
	self.phone_1					:=	'';
	self.phone_2					:=	'';
	self.clean_pname                :=  choose(C,L.pname1 + L.pname1_score, L.pname2 + L.pname2_score, 
	                                    L.pname3 + L.pname3_score, L.pname4 + L.pname4_score, 
										L.pname5 + L.pname5_score);
	self.company_name				:=	choose(C, L.cname1, L.cname2, L.cname3, L.cname4, L.cname5);
	self.clean_address              :=  L.clean_address;            
	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	'';
	self.did_score					:=	'';                              
	self.ssn						:=	'';
	self.history_flag               :=  '';
  end
 ; 
 
Mapping_MN_as_Search_norm			:= normalize(Mapping_MN_as_Main_temp,5,search_mapping_format(left,counter));

export Mapping_MN_as_Search         := Mapping_MN_as_Search_norm(clean_pname <> '' or company_name <> '');




