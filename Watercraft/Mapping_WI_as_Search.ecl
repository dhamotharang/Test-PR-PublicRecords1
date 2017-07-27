
import lib_stringlib, watercraft;
/*
Watercraft.Layout_Watercraft_Search_Group search_mapping_format_1(Watercraft.Layout_WI_clean_in L, integer1 C)
 :=
  transform
	self.date_first_seen			:=	'';
	self.date_last_seen				:=	'';
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
	self.watercraft_key				:=	'WI-' + trim(L.reg_num, left, right);
	self.sequence_key				:=	'';
	self.state_origin				:=	'WI';
	self.source_code				:=	'IT';
	self.orig_name					:=	L.NAME;
	self.orig_name_type_code		:=	'O';
	self.orig_name_type_description	:=	'OWNER';
	self.orig_name_first			:=	L.FIRST_NAME;
	self.orig_name_middle			:=	L.MID;
	self.orig_name_last				:=	L.LAST_NAME;
	self.orig_name_suffix			:=	'';
	self.orig_address_1				:=	L.ADDRESS_1;
	self.orig_address_2				:=	L.ADDRESS2;
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
	self.clean_pname                :=  choose(C,L.pname1 + L.pname1_score, L.pname2 + L.pname2_score);
	self.company_name				:=	L.cname1;
	self.clean_address              :=  L.clean_address;            
	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	'';
	self.did_score					:=	'';                              
	self.ssn						:=	'';
  end
 ; 
 
Mapping_WI_as_Search_1			:= normalize(Watercraft.file_WI_clean_in,2,search_mapping_format_1(left,counter));


Watercraft.Layout_Watercraft_Search_Group search_mapping_format_2(Watercraft.Layout_WI_clean_in L, integer1 C)
 :=
  transform
	self.date_first_seen			:=	'';
	self.date_last_seen				:=	'';
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
	self.watercraft_key				:=	'WI-' + trim(L.reg_num, left, right);
	self.sequence_key				:=	'';
	self.state_origin				:=	'WI';
	self.source_code				:=	'IT';
	self.orig_name					:=	L.BUSINESS;
	self.orig_name_type_code		:=	'O';
	self.orig_name_type_description	:=	'OWNER';
	self.orig_name_first			:=	'';
	self.orig_name_middle			:=	'';
	self.orig_name_last				:=	'';
	self.orig_name_suffix			:=	'';
	self.orig_address_1				:=	L.ADDRESS_1;
	self.orig_address_2				:=	L.ADDRESS2;
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
	self.clean_pname                :=  choose(C,L.BUSINESS_pname1 + L.BUSINESS_pname1_score, L.BUSINESS_pname2 + L.BUSINESS_pname2_score);
	self.company_name				:=	L.BUSINESS_cname1;
	self.clean_address              :=  L.clean_address;            
	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	'';
	self.did_score					:=	'';                              
	self.ssn						:=	'';          
	
  end
 ; 
 
Mapping_WI_as_Search_2			:= normalize(Watercraft.file_WI_clean_in,2,search_mapping_format_2(left,counter));



Watercraft.Layout_Watercraft_Search_Group search_mapping_format_3(Watercraft.Layout_WI_clean_in L, integer1 C)
 :=
  transform
	self.date_first_seen			:=	'';
	self.date_last_seen				:=	'';
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
	self.watercraft_key				:=	'WI-' + trim(L.reg_num, left, right);
	self.sequence_key				:=	'';
	self.state_origin				:=	'WI';
	self.source_code				:=	'IT';
	self.orig_name					:=	L.CONTACT;
	self.orig_name_type_code		:=	'Z';
	self.orig_name_type_description	:=	'CONTACT';
	self.orig_name_first			:=	'';
	self.orig_name_middle			:=	'';
	self.orig_name_last				:=	'';
	self.orig_name_suffix			:=	'';
	self.orig_address_1				:=	L.ADDRESS_1;
	self.orig_address_2				:=	L.ADDRESS2;
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
	self.clean_pname                :=  choose(C,L.CONTACT_pname1 + L.CONTACT_pname1_score, L.CONTACT_pname2 + L.CONTACT_pname2_score);
	self.company_name				:=	L.CONTACT_cname1;
	self.clean_address              :=  L.clean_address;            
	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	'';
	self.did_score					:=	'';                              
	self.ssn						:=	'';                
	
  end
 ; 
 
Mapping_WI_as_Search_3			    := normalize(Watercraft.file_WI_clean_in,2,search_mapping_format_3(left,counter));




export Mapping_WI_as_Search         := (Mapping_WI_as_Search_1 + Mapping_WI_as_Search_2 + Mapping_WI_as_Search_3)
                                       (clean_pname <> '' or company_name <> '') : PERSIST('persist::Watercraft_WI_as_Search');*/

Layout_Watercraft_Search_Group_temp := record


Watercraft.Layout_WI_clean_in;

string73 clean_pname1;
string73 clean_pname2;
string73 clean_pname3;


end;

Layout_Watercraft_Search_Group_temp search_mapping_format_temp(Watercraft.Layout_WI_clean_in L, integer1 C)
 :=transform
 
self.clean_pname1 := choose(C,L.pname1 + L.pname1_score, L.pname2 + L.pname2_score);
self.clean_pname2 := choose(C,L.BUSINESS_pname1 + L.BUSINESS_pname1_score, L.BUSINESS_pname2 + L.BUSINESS_pname2_score);
self.clean_pname3 := choose(C,L.CONTACT_pname1 + L.CONTACT_pname1_score, L.CONTACT_pname2 + L.CONTACT_pname2_score);
self               := L;

end;

Mapping_WI_as_Search_temp := normalize(Watercraft.file_WI_clean_in,2,search_mapping_format_temp(left,counter));


Watercraft.Layout_Watercraft_Search_Group search_mapping_format(Layout_Watercraft_Search_Group_temp L, integer1 C)
 :=
  transform
	self.date_first_seen			:=	L.reg_date;
	self.date_last_seen				:=	L.reg_date;
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
	self.watercraft_key				:=	trim(L.reg_num, left, right);
	self.sequence_key				:=	trim(L.reg_date, left, right);
	self.state_origin				:=	'WI';
	self.source_code				:=	'AW';
	self.dppa_flag					:=	'';
	self.orig_name					:=	choose(C,L.NAME, L.BUSINESS, L.CONTACT);
	self.orig_name_type_code		:=	choose(C,'O','O','Z');
	self.orig_name_type_description	:=	choose(C,'OWNER','OWNER','CONTACT');
	self.orig_name_first			:=	choose(C,L.FIRST_NAME, '', '');
	self.orig_name_middle			:=	choose(C,L.MID, '', '');
	self.orig_name_last				:=	choose(C,L.LAST_NAME, '', '');
	self.orig_name_suffix			:=	'';
	self.orig_address_1				:=	L.ADDRESS_1;
	self.orig_address_2				:=	L.ADDRESS2;
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
	self.clean_pname                :=  choose(C,L.clean_pname1,L.clean_pname2,L.clean_pname3);
	self.company_name				:=	choose(C,L.cname1,L.BUSINESS_cname1, L.CONTACT_cname1);
	self.clean_address              :=  L.clean_address;            
	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	'';
	self.did_score					:=	'';                              
	self.ssn						:=	'';
	self.history_flag				:=	'';
  end
 ; 
 
export Mapping_WI_as_Search	:= (normalize(Mapping_WI_as_Search_temp,3,search_mapping_format(left,counter)))
                                (clean_pname <> '' or company_name <> '');

