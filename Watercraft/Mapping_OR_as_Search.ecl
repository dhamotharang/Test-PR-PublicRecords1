
import lib_stringlib, watercraft;


Layout_Watercraft_Search_Group_temp := record


watercraft.Layout_OR_clean_in;

string73 clean_pname1;
string73 clean_pname2;
string100 clean_cname1;
string100 clean_cname2;


end;

Layout_Watercraft_Search_Group_temp search_mapping_format_temp(watercraft.file_OR_clean_in L, integer1 C)
 :=transform
 
self.clean_pname1 := choose(C,L.pname1, L.pname2, L.pname3, L.pname4, L.pname5);
self.clean_pname2 := choose(C,L.pname6, L.pname7, L.pname8, L.pname9, L.pname10);
self.clean_cname1 := choose(C,L.cname1, L.cname2, L.cname3, L.cname4, L.cname5);
self.clean_cname2 := choose(C,L.cname6, L.cname7, L.cname8, L.cname9, L.cname10);
self               := L;

end;

Mapping_OR_as_Search_temp1 := normalize(Watercraft.file_OR_clean_in,5,search_mapping_format_temp(left,counter));
Watercraft.Macro_Clean_Hull_ID(Mapping_OR_as_Search_temp1, Layout_Watercraft_Search_Group_temp,hull_clean_in)

Layout_OR_clean_temp2 := record

Layout_Watercraft_Search_Group_temp;
watercraft.Layout_MIC;

boolean is_hull_id_in_MIC;
    	
end;

Layout_OR_clean_temp2 main_mapping_temp1(hull_clean_in L, watercraft.file_MIC R)

:= transform

self := L;
self := R;
self.is_hull_id_in_MIC := if(trim(L.hull_id, left, right)[1..3] = R.MIC, true, false);

end;

Mapping_OR_as_Main_temp2 := join(hull_clean_in, watercraft.file_MIC, trim(left.hull_id, left, right)[1..3] = right.MIC,
main_mapping_temp1(left, right), left outer, lookup);


Watercraft.Layout_Watercraft_Search_Group search_mapping_format(Mapping_OR_as_Main_temp2 L, integer1 C)
 :=
  transform
	self.date_first_seen			:=	if(L.reg_date <> '', L.REG_DATE, L.CURRENT_TITLE_DATE);
	self.date_last_seen				:=	if(L.reg_date <> '', L.REG_DATE, L.CURRENT_TITLE_DATE);
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
	self.watercraft_key				:=	if(trim(L.YEAR, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12 and L.is_hull_id_in_MIC, 
	                                    trim(L.HULL_ID, left, right),if(trim(L.HULL_ID, left, right) <> 'VARIOUS'and trim(L.HULL_ID, left, right) <> 'UNKNOWN',
	                                    (trim(L.HULL_ID, left, right) + trim(L.MAKE, left, right) + trim(L.YEAR, left, right))[1..30],
	                                    (trim(L.MAKE, left, right) + trim(L.YEAR, left, right) + trim(L.NAME, left, right))[1..30]));
	self.sequence_key				:=	L.REG_DATE;
	self.state_origin				:=	'OR';
	self.source_code				:=	'AW';
	self.dppa_flag					:=	'';
	self.orig_name					:=	choose(C,L.NAME, L.NAME2);
	self.orig_name_type_code		:=	'O';
	self.orig_name_type_description	:=	'OWNER';
	self.orig_name_first			:=	L.FIRST_NAME;
	self.orig_name_middle			:=	L.MID;
	self.orig_name_last				:=	L.LAST_NAME;
	self.orig_name_suffix			:=	'';
	self.orig_address_1				:=	L.ADDRESS_1;
	self.orig_address_2				:=	'';
	self.orig_city					:=	L.CITY;
	self.orig_state					:=	L.STATE;
	self.orig_zip					:=	L.ZIP;
	self.orig_fips					:=	choose(C, L.FIPS, '');
	self.dob						:=	'';
	self.orig_ssn					:=	'';
	self.orig_fein					:=	'';
	self.gender						:=	'';
	self.phone_1					:=	'';
	self.phone_2					:=	'';
	self.clean_pname                :=  choose(C,L.clean_pname1,L.clean_pname2);
	self.company_name				:=	choose(C,L.clean_cname1,L.clean_cname2);
	self.clean_address              :=  L.clean_address;            
	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	'';
	self.did_score					:=	'';                              
	self.ssn						:=	'';
	self.history_flag				:=	'';
  end
 ; 
 
export Mapping_OR_as_Search	:= (normalize(Mapping_OR_as_Main_temp2,2,search_mapping_format(left,counter)))
                                (clean_pname <> '' or company_name <> '');