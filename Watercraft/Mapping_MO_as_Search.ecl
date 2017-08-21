import lib_stringlib, watercraft;
Watercraft.Macro_Clean_Hull_ID(watercraft.file_MO_clean_in, watercraft.Layout_MO_clean_in,hull_clean_in)

Watercraft.Layout_Watercraft_Search_Group search_mapping_format(hull_clean_in L) :=
transform
	
	self.date_first_seen			:=	if(l.REG_DATE='19910926','',l.REG_DATE);
	self.date_last_seen				:=	if(l.REG_DATE='19910926','',l.REG_DATE);
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
    self.watercraft_key			    :=	(trim(L.HULL_ID, left, right) + trim(L.MAKE,left, right) + trim(L.YEAR, left, right))[1..30];                                          
	self.sequence_key				:=	if((trim(L.REG_DATE, left, right)<>''),L.REG_DATE,L.NAME);
	self.state_origin				:=	'MO';
	self.source_code				:=	'AW';
	self.dppa_flag					:=	'';
	self.orig_name					:=	L.NAME;
	self.orig_name_type_code		:=	'R';
	self.orig_name_type_description	:=	'REGISTRANT';
	self.orig_name_first			:=	'';
	self.orig_name_middle			:=	'';
	self.orig_name_last				:=	'';
	self.orig_name_suffix			:=	'';
	self.orig_address_1				:=	trim(L.ADDRESS_1,left,right);
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
	self.clean_pname                :=  L.pname+L.pname_score;
	self.company_name				:=	L.cname;
	self.clean_address              :=  L.clean_address;            
	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	'';
	self.did_score					:=	'';                              
	self.ssn						:=	'';
	self.history_flag				:=	'';
end; 
 
Mapping_MO_as_Search_norm			:= project(hull_clean_in,search_mapping_format(left));

export Mapping_MO_as_Search         := Mapping_MO_as_Search_norm(clean_pname <> '' or company_name <> '');
