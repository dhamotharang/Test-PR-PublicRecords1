
import lib_stringlib, watercraft;
/*
Watercraft.Layout_Watercraft_Search_Group search_mapping_format_1(Watercraft.Layout_AR_clean_in L, integer1 C)
 :=
  transform
	self.date_first_seen			:=	'';
	self.date_last_seen				:=	'';
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
	self.watercraft_key				:=	if(L.REG_NUM = ''or L.REG_NUM[1..2]<>'AR', ('AR-'+ trim(L.REG_NUM, left, right) + trim(L.HULL_ID,left, right) + trim(L.NAME, left, right))[1..30],
	                                    (trim(L.REG_NUM, left, right) + trim(L.HULL_ID,left, right) + trim(L.NAME, left, right))[1..30]);                                          
	self.sequence_key				:=	'';
	self.sequence_key				:=	'';
	self.state_origin				:=	'AR';
	self.source_code				:=	'IT';
	self.orig_name					:=	L.NAME;
	self.orig_name_type_code		:=	'O';
	self.orig_name_type_description	:=  'OWNER';
	self.orig_name_first			:=	L.FIRST_NAME;
	self.orig_name_middle			:=	L.MID;
	self.orig_name_last				:=	L.LAST_NAME;
	self.orig_name_suffix			:=	'';
	self.orig_address_1				:=	L.ADDRESS_1;
	self.orig_address_2				:=	Add2;
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
  end
 ; 


Mapping_AR_as_Search_norm_1			:= normalize(Watercraft.file_AR_clean_in,5,search_mapping_format_1(left,counter));

Watercraft.Layout_Watercraft_Search_Group search_mapping_format_2(Watercraft.Layout_AR_clean_in L, integer1 C)
 :=
  transform
	self.date_first_seen			:=	'';
	self.date_last_seen				:=	'';
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
	self.watercraft_key				:=	if(L.REG_NUM = ''or L.REG_NUM[1..2]<>'AR', ('AR-'+ trim(L.REG_NUM, left, right) + trim(L.HULL_ID,left, right) + trim(L.NAME, left, right))[1..30],
	                                    (trim(L.REG_NUM, left, right) + trim(L.HULL_ID,left, right) + trim(L.NAME, left, right))[1..30]);                                          
	self.sequence_key				:=	'';
	self.sequence_key				:=	'';
	self.state_origin				:=	'AR';
	self.source_code				:=	'IT';
	self.orig_name					:=	L.NAME2;
	self.orig_name_type_code		:=	'O';
	self.orig_name_type_description	:=  'OWNER';
	self.orig_name_first			:=	'';
	self.orig_name_middle			:=	'';
	self.orig_name_last				:=	'';
	self.orig_name_suffix			:=	'';
	self.orig_address_1				:=	L.ADDRESS_1;
	self.orig_address_2				:=	Add2;
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
	self.clean_pname                :=  choose(C,L.pname6 + L.pname6_score, L.pname7 + L.pname7_score, 
	                                    L.pname8 + L.pname8_score, L.pname9 + L.pname9_score, 
										L.pname10 + L.pname10_score);
	self.company_name				:=	choose(C, L.cname6, L.cname7, L.cname8, L.cname9, L.cname10);
	self.clean_address              :=  L.clean_address;            
	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	'';
	self.did_score					:=	'';                              
	self.ssn						:=	'';
  end
 ; 

Mapping_AR_as_Search_norm_2			:= normalize(Watercraft.file_AR_clean_in,5,search_mapping_format_2(left,counter));


export Mapping_AR_as_Search         := Mapping_AR_as_Search_norm(clean_pname <> '' or company_name <> '') : persist('persist::watercraft_AR_as_search');

*/

Layout_Watercraft_Search_Group_temp := record


Watercraft.Layout_AR_clean_in;

string73 clean_pname1;
string73 clean_pname2;
string60 company_name1;
string60 company_name2;

end;

Layout_Watercraft_Search_Group_temp search_mapping_format_temp(Watercraft.Layout_AR_clean_in L, integer1 C)
 :=transform
 
self.clean_pname1 := choose(C,L.pname1 + L.pname1_score, L.pname2 + L.pname2_score, 
	                                    L.pname3 + L.pname3_score, L.pname4 + L.pname4_score, 
										L.pname5 + L.pname5_score);
self.clean_pname2 := choose(C,L.pname6 + L.pname6_score, L.pname7 + L.pname7_score, 
	                                    L.pname8 + L.pname8_score, L.pname9 + L.pname9_score, 
										L.pname10 + L.pname10_score);
self.company_name1 := choose(C, L.cname1, L.cname2, L.cname3, L.cname4, L.cname5);
self.company_name2 := choose(C, L.cname6, L.cname7, L.cname8, L.cname9, L.cname10);
self               := L;

end;

Mapping_AR_as_Search_temp := normalize(Watercraft.file_AR_clean_in,5,search_mapping_format_temp(left,counter));

Watercraft.Macro_Clean_Hull_ID(Mapping_AR_as_Search_temp, Layout_Watercraft_Search_Group_temp,hull_clean_in)

Watercraft.Layout_Watercraft_Search_Group search_mapping_format(hull_clean_in L, integer1 C)
 :=
  transform
	self.date_first_seen			:=	L.REG_DATE;
	self.date_last_seen				:=	L.REG_DATE;
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
	self.watercraft_key				:=	(trim(L.HULL_ID, left, right) + trim(L.MAKE,left, right) + trim(L.YEAR, left, right))[1..30];                                          
	self.sequence_key				:=	trim(L.REG_DATE, left, right);
	self.state_origin				:=	'AR';
	self.source_code				:=	'AW';
	self.dppa_flag					:=	'';
	self.orig_name					:=	choose(C,L.NAME, L.NAME2);
	self.orig_name_type_code		:=	'O';
	self.orig_name_type_description	:=	'OWNER';
	self.orig_name_first			:=	choose(C,L.FIRST_NAME, '');
	self.orig_name_middle			:=	choose(C,L.MID,'');
	self.orig_name_last				:=	choose(C,L.LAST_NAME,'');
	self.orig_name_suffix			:=	'';
	self.orig_address_1				:=	L.ADDRESS_1;
	self.orig_address_2				:=	L.ADD2;
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
	self.clean_pname                :=  choose(C,L.clean_pname1,L.clean_pname2);
	self.company_name				:=	choose(C,L.company_name1,L.company_name2);
	self.clean_address              :=  L.clean_address;            
	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	'';
	self.did_score					:=	'';                              
	self.ssn						:=	'';
	self.history_flag				:=	'';
  end
 ; 
 
Mapping_AR_as_Search_norm	:= normalize(hull_clean_in,2,search_mapping_format(left,counter));

export Mapping_AR_as_Search := Mapping_AR_as_Search_norm(clean_pname <> '' or company_name <> '');

