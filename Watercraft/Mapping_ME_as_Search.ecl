import lib_stringlib, watercraft;

Layout_Watercraft_Search_Group_temp := record


watercraft.Layout_ME_clean_in;

string73 clean_pname_temp;
string100 clean_cname_temp;


end;

Layout_Watercraft_Search_Group_temp search_mapping_format_temp(watercraft.file_me_clean_in L, integer1 C)
 :=transform
 
self.clean_pname_temp := choose(C,L.pname1, L.pname2, L.pname3, L.pname4, L.pname5);
self.clean_cname_temp := choose(C,L.cname1, L.cname2, L.cname3, L.cname4, L.cname5);
self               := L;

end;

Mapping_ME_as_Search_temp1 := normalize(Watercraft.file_ME_clean_in,5,search_mapping_format_temp(left,counter));

Watercraft.Macro_Clean_Hull_ID(Mapping_ME_as_Search_temp1, Layout_Watercraft_Search_Group_temp,hull_clean_in)

Watercraft.Layout_Watercraft_Search_Group search_mapping_format(hull_clean_in L, integer1 C)
 :=
  transform
    temp_res_zip := L.RESIDENCE_ZIP;
	self.date_first_seen			:=	L.reg_date;
	self.date_last_seen				:=	L.reg_date;
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
	self.watercraft_key				:=	if(length(trim(L.HULL_ID, left, right)) = 12 and trim(L.year, left, right) >= '1972', trim(L.HULL_ID, left, right),
	                                    (trim(L.HULL_ID, left, right) + trim(L.MAKE,left, right) + trim(L.YEAR, left, right))[1..30]);                                          
	self.sequence_key				:=	L.REG_DATE + L.ISSUE_TIME;
	self.state_origin				:=	'ME';
	self.source_code				:=	'AW';
	self.dppa_flag                  :=  '';
	self.orig_name					:=	choose(C, L.NAME, L.BUSINESS_NAME, L.BUSINESS_CONTACT);
	self.orig_name_type_code		:=	choose(C, 'O','O', 'Z');
	self.orig_name_type_description	:=	choose(C,'OWNER','OWNER','CONTACT');
	self.orig_name_first			:=	choose(C,L.FIRST_NAME, '', '', '');
	self.orig_name_middle			:=	choose(C,L.MID, '', '', '');
	self.orig_name_last				:=	choose(C,L.LAST_NAME, '', '', '');
	self.orig_name_suffix			:=	choose(C, L.SUFFIX, '', '', '');
	self.orig_address_1				:=	IF(trim(L.ADDRESS_1, LEFT, RIGHT) != trim(L.RESIDENCE_ADDRESS, LEFT, RIGHT) and L.RESIDENCE_ADDRESS <> '' and trim(l.RESIDENCE_COUNTRY,left,right) in ['UNITED STATES' , 'USA'],L.RESIDENCE_ADDRESS,L.ADDRESS_1);
	self.orig_address_2				:=	'';
	self.orig_city					:=	IF(trim(L.ADDRESS_1, LEFT, RIGHT) != trim(L.RESIDENCE_ADDRESS, LEFT, RIGHT) and L.RESIDENCE_ADDRESS <> '' and trim(l.RESIDENCE_COUNTRY,left,right) in ['UNITED STATES' , 'USA'],L.RESIDENCE_TOWN,L.CITY);
	self.orig_state					:=	IF(trim(L.ADDRESS_1, LEFT, RIGHT) != trim(L.RESIDENCE_ADDRESS, LEFT, RIGHT) and L.RESIDENCE_ADDRESS <> '' and trim(l.RESIDENCE_COUNTRY,left,right) in ['UNITED STATES' , 'USA'],L.RESIDENCE_ST,L.STATE);
    self.orig_zip					:=	IF(trim(L.ADDRESS_1, LEFT, RIGHT) != trim(L.RESIDENCE_ADDRESS, LEFT, RIGHT) and L.RESIDENCE_ADDRESS <> '' and trim(l.RESIDENCE_COUNTRY,left,right) in ['UNITED STATES' , 'USA'],temp_res_zip,L.ZIP);
	self.orig_fips					:=	L.FIPS;
	self.dob						:=	choose(C,L.DOB, '','');
	self.orig_ssn					:=	'';
	self.orig_fein					:=	'';
	self.gender						:=	'';
	self.phone_1					:=	'';
	self.phone_2					:=	'';
	self.clean_pname                :=  choose(C,L.clean_pname_temp, '', L.clean_business_contact_pname);
	self.company_name				:=	choose(C,L.clean_cname_temp, L.clean_business_cname, '');
	self.clean_address              :=  L.clean_address;            
	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	'';
	self.did_score					:=	'';                              
	self.ssn						:=	'';
	self.history_flag               :=  '';
  end
 ; 
 
Mapping_ME_as_Search_norm			:= normalize(hull_clean_in,3,search_mapping_format(left,counter));

export Mapping_ME_as_Search        := Mapping_ME_as_Search_norm(clean_pname <> '' or company_name <> '');


