import lib_stringlib, watercraft;

Watercraft.Macro_Clean_Hull_ID(Watercraft.file_CT_clean_in, watercraft.Layout_CT_clean_in,hull_clean_in)
watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, watercraft.Layout_CT_clean_in, wDatasetwithflag)

Watercraft.Layout_Watercraft_Search_Group search_mapping_format(wDatasetwithflag L, integer1 C)
 :=
  transform
	self.date_first_seen			:=	L.reg_date;
	self.date_last_seen				:=	L.reg_date;
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
	self.watercraft_key				:=	if(length(trim(L.HULL_ID, left, right)) = 12 and trim(L.year, left, right) >= '1972' and L.is_hull_id_in_MIC, trim(L.HULL_ID, left, right),
	                                    if(stringlib.stringfind(L.HULL_ID, 'UNKNOWN', 1) = 0, (trim(L.HULL_ID, left, right) + trim(regexreplace('UNKNOWN', L.MAKE, ''),left, right) + trim(L.YEAR, left, right))[1..30],
										(trim(regexreplace('UNKNOWN', L.HULL_ID, ''), left, right) + trim(regexreplace('UNKNOWN', L.MAKE, ''),left, right) + trim(L.YEAR, left, right) + trim(L.NAME,left, right))[1..30]));                     
	self.sequence_key				:=	trim(L.REG_DATE, left, right);
	self.state_origin				:=	'CT';
	self.source_code				:=	'AW';
	self.dppa_flag					:=	'';
	self.orig_name					:=	L.NAME;
	self.orig_name_type_code		:=	'R';
	self.orig_name_type_description	:=	'REGISTRANT';
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
	self.dob						:=	L.DOB;
	self.orig_ssn					:=	'';
	self.orig_fein					:=	'';
	self.gender						:=	'';
	self.phone_1					:=	'';
	self.phone_2					:=	'';
	self.clean_pname                :=  choose(C, L.pname1 + L.pname1_score, L.pname2 + L.pname2_score, 
	                                    L.pname3 + L.pname3_score, trim(L.pname4 + L.pname4_score), 
										trim(L.pname5) + trim(L.pname5_score));
	self.company_name				:=	choose(C, L.cname1, L.cname2, L.cname3, L.cname4, L.cname5);
	self.clean_address              :=  L.clean_address;            
	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	'';
	self.did_score					:=	'';                              
	self.ssn						:=	'';
	self.history_flag				:=	'';
  end
 ; 
 
 
Mapping_CT_as_Search_norm			:= normalize(wDatasetwithflag,5,search_mapping_format(left,counter));

export Mapping_CT_as_Search         := Mapping_CT_as_Search_norm(clean_pname <> '' or company_name <> '');



