import watercraft;

file_in := watercraft.file_NC_clean_in;


//using blank instead of 'E502' when name without blank but address with blank in clean_address

watercraft.layout_NC_clean_in tformat(watercraft.layout_NC_clean_in L) := transform

self.clean_address1 := if(L.name <> '' and L.address_1 = '' and L.address2 = '', ' ', L.clean_address1);
self.clean_address2 := if(L.name <> '' and L.address_2 = '' and L.address2_2 = '', ' ', L.clean_address2);
self.clean_address3 := if(L.name_3 <> '' and L.address_3 = '' and L.address2_3 = '', ' ', L.clean_address3);
self.clean_address4 := if(L.name_3 <> '' and L.address_4 = '' and L.address2_4 = '', ' ', L.clean_address4);
self                := L;
end;

file_temp := project(file_in, tformat(left));

Watercraft.Macro_Clean_Hull_ID(file_temp, watercraft.Layout_NC_clean_in,hull_clean_in)

Watercraft.Layout_Watercraft_Search_Group search_mapping_format(hull_clean_in L, integer1 C)
 :=
  transform
	self.date_first_seen			:=	L.process_date;
	self.date_last_seen				:=	L.process_date;
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
	self.watercraft_key				        :=	if(length(trim(L.HULL_ID, left, right)) = 12 and trim(L.year, left, right) >= '1972', trim(L.HULL_ID, left, right) ,
	                                            (trim(L.HULL_ID, left, right) + trim(L.MAKE,left, right) + trim(L.YEAR, left, right) + trim(L.reg_num, left, right))[1..30]);                                    
	self.sequence_key				:=	trim(L.RENEWNUM, left, right);
	self.state_origin				:=	'NC';
	self.source_code				:=	'AW';
	self.dppa_flag                  :=  '';
	self.orig_name					:=	choose(C,L.NAME, L.NAME, L.NAME_3, L.NAME_3);
	self.orig_name_type_code		:=	'O';
	self.orig_name_type_description	:=	'OWNER';
	self.orig_name_first			:=	L.FIRST_NAME;
	self.orig_name_middle			:=  L.MID;
	self.orig_name_last				:=	L.LAST_NAME;
	self.orig_name_suffix			:=	'';
	self.orig_address_1				:=	choose(C,L.ADDRESS_1, L.ADDRESS_2, L.ADDRESS_3, L.ADDRESS_4);
	self.orig_address_2				:=	choose(C,L.ADDRESS2, L.ADDRESS2_2, L.ADDRESS2_3, L.ADDRESS2_4);
	self.orig_city					:=	choose(C,L.CITY, L.CITY_2, L.CITY_3, L.CITY_4);
	self.orig_state					:=	CHOOSE(C,L.STATE, L.STATE_2, L.STATE_3, L.STATE_4);
	self.orig_zip					:=	CHOOSE(C,L.ZIP, L.ZIP_2 + L.ZIP4_2, L.ZIP_2 + L.ZIP4_3, L.ZIP_2 + L.ZIP4_4);
	self.orig_fips					:=	L.FIPS;
	self.dob						:=	'';
	self.orig_ssn					:=	'';
	self.orig_fein					:=	'';
	self.gender						:=	'';
	self.phone_1					:=	choose(C, L.PHONE, L.PHONE_2, L.PHONE_3, L.PHONE_4);
	self.phone_2					:=	'';
	self.clean_pname                :=  choose(C,L.clean_pname1,L.clean_pname2,L.clean_pname3, L.clean_pname3);
	self.company_name				:=	choose(C,L.clean_cname,L.clean_cname, L.clean_cname3, L.clean_cname3);
	self.clean_address              :=  choose(C,L.clean_address1, L.clean_address2, L.clean_address3, L.clean_address4);            
	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	'';
	self.did_score					:=	'';                              
	self.ssn						:=	'';
	self.history_flag               :=  '';
  end
 ; 
 

//FILTER OUT CLEAN_PNAME WITH BLANK AND COMPANY_NAME WITH BLANK

Mapping_NC_as_Search_name	:= (normalize(hull_clean_in,4,search_mapping_format(left,counter)))
                                (clean_pname <> '' and trim(clean_pname, left, right) <> '0' or company_name <> '');
								
//FILTER OUT CLEAN_ADDRESS WITH 'E502'
								
Mapping_NC_as_Search_address := Mapping_NC_as_Search_name(trim(clean_address, left, right) <> 'E502');

export Mapping_NC_as_Search	:= Mapping_NC_as_Search_address;
								





