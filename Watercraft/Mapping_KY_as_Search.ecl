import lib_stringlib, watercraft;

watercraft.Layout_KY_clean_in reformat(watercraft.file_KY_clean_in L) := transform

self.BT_HIN_NO := if(trim(L.BT_HIN_NO,left,right)in['NO S/N','NOS/N','N/S/N', 'UNK', 'UNKNOWN','UNKN'],'',if(StringLib.StringFind(L.BT_HIN_NO,'S/N',1) = 1,trim(L.BT_HIN_NO,left,right)[4..],L.BT_HIN_NO)) ;
self := L;
end;

hull_clean_in := project(watercraft.file_KY_clean_in, reformat(left));

Watercraft.Layout_Watercraft_Search_Group search_mapping_format(hull_clean_in L)
 :=
  transform
	self.date_first_seen			:=	L.BT_REG_DATE[7..10]+L.BT_REG_DATE[1..2]+L.BT_REG_DATE[4..5];
	self.date_last_seen				:=	L.BT_REG_DATE[7..10]+L.BT_REG_DATE[1..2]+L.BT_REG_DATE[4..5];
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
    self.watercraft_key			    :=	if(length(trim(L.BT_HIN_NO, left, right)) = 12 and trim(L.BT_MODEL_YEAR, left, right) >= '1972', trim(L.BT_HIN_NO, left, right),
										        (trim(L.BT_HIN_NO,left, right) + trim(L.BT_MAKE,left, right) + trim(L.BT_MODEL_YEAR, left, right) + trim(L.ON_NAME_LAST,left, right) + trim(L.ON_NAME_FIRST,left, right))[1..30]);                          
	self.sequence_key			    :=	L.BT_REG_DATE[7..10]+L.BT_REG_DATE[1..2]+L.BT_REG_DATE[4..5];
	self.state_origin				:=	'KY';
	self.source_code				:=	'KY';
	self.dppa_flag					:=	'';
	self.orig_name					:=	'';
	self.orig_name_type_code		:=	'O';
	self.orig_name_type_description	:=	'OWNER';
	self.orig_name_first			:=	L.ON_NAME_FIRST;
	self.orig_name_middle			:=	L.ON_NAME_INIT;
	self.orig_name_last				:=	L.ON_NAME_LAST;
	self.orig_name_suffix			:=	'';
	self.orig_address_1				:=	trim(L.ON_STREET,left,right);
	self.orig_address_2				:=	'';
	self.orig_city					:=	L.ON_CITY;
	self.orig_state					:=	L.ON_STATE;
	self.orig_zip					:=	L.ON_ZIP;
	self.orig_fips					:=	'';
	self.dob						:=	'';
	self.orig_ssn					:=	'';
	self.orig_fein					:=	'';
	self.gender						:=	L.ON_SEX;
	self.phone_1					:=	L.ON_PHONE;
	self.phone_2					:=	'';
	self.clean_pname                :=  L.pname;
	self.company_name				:=	L.cname;
	self.clean_address              :=  L.clean_address;            
	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	'';
	self.did_score					:=	'';                              
	self.ssn						:=	'';
	self.history_flag				:=	'';
  end
 ; 
 
Mapping_KY_as_Search_norm			:= project(hull_clean_in,search_mapping_format(left));

export Mapping_KY_as_Search         := Mapping_KY_as_Search_norm(clean_pname <> '' or company_name <> '');

