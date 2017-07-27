
import lib_stringlib, watercraft;

Layout_Watercraft_Search_Group_temp := record


Watercraft.Layout_IA_clean_in;

string73 clean_pname;
string100 clean_cname;


end;

Layout_Watercraft_Search_Group_temp search_mapping_format_temp(Watercraft.Layout_IA_clean_in L, integer1 C)
 :=transform
 
self.clean_pname := choose(C,L.pname1 + L.pname1_score, L.pname2 + L.pname2_score, L.pname3 + L.pname3_score, 
                     L.pname4 + L.pname4_score, L.pname5 + L.pname5_score);
					 
self.clean_cname := choose(C,L.cname1, L.cname2, L.cname3, L.cname4, L.cname5);

self := L;

end;

Mapping_IA_as_Search_temp := normalize(Watercraft.file_IA_clean_in,5,search_mapping_format_temp(left,counter));

Watercraft.Layout_Watercraft_Search_Group search_mapping_format(Layout_Watercraft_Search_Group_temp L, integer1 C)
 :=
  transform
	self.date_first_seen			:=	L.reg_date[1..6] + '01';
	self.date_last_seen				:=	L.reg_date[1..6] + '01';
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
	self.watercraft_key				:=	if(L.HULL_ID = '', trim(L.REG_NUM, left, right), if(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12, trim(L.HULL_ID,left, right),
	                                    (trim(L.HULL_ID, left, right) + trim(L.MAKE, left, right) + trim(L.YEAR, left, right))[1..30]));                                          
	self.sequence_key				:=	trim(L.reg_date[1..6], left, right);
	self.state_origin				:=	'IA';
	self.source_code				:=	'AW';
	self.dppa_flag					:=	'';
	self.orig_name					:=	choose(C,L.NAME, '');
	self.orig_name_type_code		:=	'O';
	self.orig_name_type_description	:=	'OWNER';
	self.orig_name_first			:=	choose(C,L.FIRST_NAME, L.Second_Owners_first_Name);
	self.orig_name_middle			:=	choose(C,L.MID, L.Second_Owners_Middle_Initial);
	self.orig_name_last				:=	choose(C,L.LAST_NAME, L.Second_Owners_Last_Name);
	self.orig_name_suffix			:=	'';
	self.orig_address_1				:=	L.ADDRESS_1;
	self.orig_address_2				:=	'';
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
	self.clean_pname                :=  choose(C,L.clean_pname,L.clean_second_owner_pname);
	self.company_name				:=	choose(C,L.clean_cname,L.clean_second_owner_cname);
	self.clean_address              :=  L.clean_address;            
	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	'';
	self.did_score					:=	'';                              
	self.ssn						:=	'';
	self.history_flag				:=	'';
  end
 ; 
 
export Mapping_IA_as_Search	:= (normalize(Mapping_IA_as_Search_temp,2,search_mapping_format(left,counter)))
                                (clean_pname <> '' or company_name <> '');






