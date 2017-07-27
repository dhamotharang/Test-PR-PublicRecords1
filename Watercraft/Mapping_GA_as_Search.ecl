
import lib_stringlib, watercraft;

string fFixHullID(string pHullIDIn) :=	lib_stringlib.StringLib.stringtouppercase(pHullIDIn);

Watercraft.Layout_Watercraft_Search_Group search_mapping_format(Watercraft.Layout_GA_clean_in L, integer1 C)
 :=
  transform
	self.date_first_seen			:=	L.reg_date;
	self.date_last_seen				:=	L.reg_date;
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
	self.watercraft_key			    :=	if(trim(L.year, left, right) >= '1972' and length(trim(fFixHullID(L.HULL_ID),left, right)) = 12, trim(fFixHullID(L.HULL_ID),left, right),
	                                    if(fFixHullID(L.HULL_ID) = '', trim(L.Reg_num, left, right), (trim(fFixHullID(L.HULL_ID), left, right) + trim(L.MAKE, left, right) + trim(L.YEAR, left, right))[1..30]));
	self.sequence_key				:=	trim(L.reg_date, left, right);
	self.state_origin				:=	'GA';
	self.source_code				:=	'AW';
	self.dppa_flag					:=	'';
	self.orig_name					:=	L.NAME;
	self.orig_name_type_code		:=	'O';
	self.orig_name_type_description	:=  'OWNER';
	self.orig_name_first			:=	L.FIRST_NAME;
	self.orig_name_middle			:=	L.MID;
	self.orig_name_last				:=	L.LAST_NAME;
	self.orig_name_suffix			:=	L.suffix;
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
	self.clean_pname                :=  choose(C,L.pname1 + L.pname1_score, L.pname2 + L.pname2_score, 
	                                    L.pname3 + L.pname3_score, L.pname4 + L.pname4_score, 
										L.pname5 + L.pname5_score);
	self.company_name				:=	choose(C, L.cname1, L.cname2, L.cname3, L.cname4, L.cname5);
	self.clean_address              :=  L.clean_address;            
	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	'';
	self.did_score					:=	'';                              
	self.ssn						:=	'';
	self.history_flag				:=	'';
  end;
 ; 
 
Mapping_GA_as_Search_norm			:= normalize(Watercraft.file_GA_clean_in,5,search_mapping_format(left,counter));

export Mapping_GA_as_Search         := Mapping_GA_as_Search_norm(clean_pname <> '' or company_name <> '');




