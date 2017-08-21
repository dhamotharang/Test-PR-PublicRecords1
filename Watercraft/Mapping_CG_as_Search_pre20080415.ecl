import watercraft, lib_stringlib;

Watercraft.Macro_Clean_Hull_ID(watercraft.file_CG_clean_in_pre20080415, watercraft.Layout_CG_clean_in_pre20080415,hull_clean_in)

//watercraft.Macro_Is_hull_id_in_MIC(watercraft.file_CG_clean_in,watercraft.layout_CG_clean_in,wDatasetwithflag)

watercraft.Layout_Watercraft_Search_Group search_mapping_format(hull_clean_in L)
 :=
  transform
	self.date_first_seen			:=	if(L.reg_date <> '', L.reg_date, L.Cod_expire_date);
	self.date_last_seen				:=	if(L.reg_date <> '', L.reg_date, L.Cod_expire_date);
	self.date_vendor_first_reported	:=  L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
	self.watercraft_key				:=	L.vessel_id;
	self.sequence_key			    :=	if(trim(L.REG_DATE,left,right)<>'',
										L.REG_DATE,trim(L.NAME,left,right)+trim(L.FIRST_NAME,left,right)+trim(L.MID,left,right)+trim(L.LAST_NAME,left,right));

	self.state_origin				:=	'US';
	self.source_code				:=	'CG';
	self.dppa_flag                  :=  '';
	self.orig_name					:=	L.NAME;
	self.orig_name_type_code		:=	'';
	self.orig_name_type_description	:=	trim(L.organization_type, left, right);
	self.orig_name_first			:=	L.FIRST_NAME;
	self.orig_name_middle			:=	L.MID;
	self.orig_name_last				:=	L.last_name;
	self.orig_name_suffix			:=	'';
	self.orig_address_1				:=	L.ADDRESS_1;
	self.orig_address_2             :=  L.Street_Address_Line_2;
	self.orig_city					:=	L.city;
	self.orig_state					:=	L.state;
	self.orig_zip					:=	L.ZIP;
	self.orig_fips					:=	L.fips;
	self.orig_province              :=  l.province;
	self.orig_country               :=  l.country;
	self.dob						:=	'';
	self.orig_ssn					:=	'';
	self.orig_fein					:=	'';
	self.gender						:=	'';
	self.phone_1					:=	'';
	self.phone_2					:=	'';
	self.clean_pname			    :=	L.clean_pname;
	self.company_name				:=	L.clean_cname;
	self.Clean_address				:=	L.clean_address;

	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	'';
	self.did_score					:=	'';
	self.ssn						:=	'';
	self.history_flag				:=	'';
  end
 ;
 
 


export Mapping_CG_As_Search_pre20080415	:= project(hull_clean_in,search_mapping_format(left));


