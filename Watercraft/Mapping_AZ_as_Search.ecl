

import lib_stringlib, watercraft;


watercraft.Macro_Is_hull_id_in_MIC(watercraft.file_AZ_clean_in, watercraft.Layout_AZ_clean_in, wDatasetwithflag)

Watercraft.Layout_Watercraft_Search_Group search_mapping_format(wDatasetwithflag L, integer1 C)
 :=
  transform
	self.date_first_seen			:=	L.REG_DATE;
	self.date_last_seen				:=	L.REG_DATE;
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
	self.watercraft_key				:=	if(length(trim(L.HULL_ID, left, right)) = 12 and trim(L.year, left, right) >= '1972'
	                                    and trim(L.HULL_ID, left, right) <> '000000000000'and L.is_hull_id_in_MIC,trim(L.HULL_ID, left, right),
									    if(trim(L.HULL_ID, left, right) = '000000000000' or trim(L.YEAR, left, right) = '1900' or
										L.MAKE = ''or trim(L.HULL_ID, left, right) ='NONE' , trim(L.REG_NUM, left, right), (trim(L.HULL_ID, left, right) + trim(L.MAKE,left, right) + trim(L.YEAR, left, right))[1..30]));                                          
	self.sequence_key				:=	trim(L.REG_DATE, left, right);

	self.state_origin				:=	'AZ';
	self.source_code				:=	'AW';
	self.dppa_flag					:=	'';
	self.orig_name					:=	L.NAME;
	self.orig_name_type_code		:=	'R';
	self.orig_name_type_description	:=  'REGISTRANT';
	self.orig_name_first			:=	L.FIRST_NAME;
	self.orig_name_middle			:=	L.MID;
	self.orig_name_last				:=	L.LAST_NAME;
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
	self.clean_pname                :=  choose(C,L.pname1, L.pname2);
	self.company_name				:=	choose(C,L.cname1, L.cname2);
	self.clean_address              :=  L.clean_address;            
	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	'';
	self.did_score					:=	'';                              
	self.ssn						:=	'';
	self.history_flag				:=	'';
  end
 ; 
 
export Mapping_AZ_as_Search			:= normalize(wDatasetwithflag,2,search_mapping_format(left,counter))(clean_pname <> '' or company_name <> '');



