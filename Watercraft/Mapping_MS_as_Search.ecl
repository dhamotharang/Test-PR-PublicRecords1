import lib_stringlib, watercraft;

Watercraft.Macro_Clean_Hull_ID(watercraft.file_MS_clean_in, watercraft.Layout_MS_clean_in,hull_clean_in)


Watercraft.Layout_Watercraft_Search_Group search_mapping_format(hull_clean_in L, integer1 C)
 :=
  transform
	self.date_first_seen			:=	L.TRANSACTION_DATE;
	self.date_last_seen				:=	L.TRANSACTION_DATE;
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
	self.watercraft_key			    :=	if(trim(L.YEAR, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12, trim(L.HULL_ID, left, right), if(L.HULL_ID = '',
	                                    (trim(L.MAKE, left, right) + trim(L.YEAR, left, right) + trim(L.FIRST_NAME, left, right) + trim(L.MID, left, right)
									    + trim(L.LAST_NAME, left, right))[1..30], (trim(L.HULL_ID, left, right) + trim(L.MAKE, left, right) + trim(L.YEAR, left, right))[1..30]));
	self.sequence_key				:=	L.TRANSACTION_DATE;
	self.state_origin				:=	'MS';
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
	self.gender						:=	'';
	self.phone_1					:=	'';
	self.phone_2					:=	'';
	self.clean_pname                :=  choose(C,L.clean_pname1, L.clean_pname2);
	self.company_name				:=	L.clean_cname;
	self.clean_address              :=  L.clean_address;            
	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	'';
	self.did_score					:=	'';                              
	self.ssn						:=	'';
	self.history_flag               :=  '';
  end
 ; 
 
Mapping_MS_as_Search_norm			:= normalize(hull_clean_in,2,search_mapping_format(left,counter));

export Mapping_MS_as_Search         := Mapping_MS_as_Search_norm(clean_pname <> '' or company_name <> '');


