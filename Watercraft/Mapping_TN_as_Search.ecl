
import lib_stringlib, watercraft;

watercraft.Macro_Is_hull_id_in_MIC(Watercraft.file_TN_clean_in, watercraft.Layout_TN_clean_in, wDatasetwithflag)

Watercraft.Layout_Watercraft_Search_Group search_mapping_format(wDatasetwithflag L)
 :=
  transform
	self.date_first_seen			:=	L.reg_date;
	self.date_last_seen				:=	L.reg_date;
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
	self.watercraft_key				:=	if(length(trim(L.HULL_ID, left, right)) = 12 and trim(L.year, left, right) >= '1972' and L.is_hull_id_in_MIC, trim(L.HULL_ID, left, right),
	                                    if(stringlib.stringfilterout(L.HULL_ID, '0') <> '' and stringlib.stringfilterout(L.HULL_ID, '*') <> '' and  trim(L.HULL_ID, left, right) <> 'UNKNOWN', 
									    (trim(L.HULL_ID, left, right) + trim(L.MAKE,left, right) + trim(L.YEAR, left, right))[1..30],trim(L.reg_num, left, right)));            
	self.sequence_key				:=	trim(L.REG_DATE, left, right);
	self.state_origin				:=	'TN';
	self.source_code				:=	'AW';
	self.dppa_flag					:=	'';
	self.orig_name					:=	L.NAME;
	self.orig_name_type_code		:=	'O';
	self.orig_name_type_description	:=	'OWNER';
	self.orig_name_first			:=	L.FIRST_NAME;
	self.orig_name_middle			:=	L.MID;
	self.orig_name_last				:=	L.LAST_NAME;
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
	self.clean_pname                :=  L.pname1;
	self.company_name				:=	L.cname1;
	self.clean_address              :=  L.clean_address;            
	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	'';
	self.did_score					:=	'';                              
	self.ssn						:=	'';
	self.history_flag				:=	'';
  end
 ; 
 
 
Mapping_TN_as_Search_norm			:= project(wDatasetwithflag, search_mapping_format(left));

export Mapping_TN_as_Search         := Mapping_TN_as_Search_norm(clean_pname <> '' or company_name <> '');


