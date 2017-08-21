import lib_stringlib, watercraft;

Watercraft.Macro_Clean_Hull_ID(watercraft.file_WY_new_clean_in, watercraft.Layout_WY_new_clean_in,hull_clean_in)

Layout_WY_new_clean_temp := record
  watercraft.Layout_WY_new_clean_in;
  watercraft.Layout_MIC;
  boolean is_hull_id_in_MIC;
end;



Layout_WY_new_clean_temp main_mapping_temp(hull_clean_in L, watercraft.file_MIC R)
:= transform
  self := L;
  self := R;
  self.is_hull_id_in_MIC := if(trim(L.hull_id, left, right)[1..3] = R.MIC, true, false);
end;


Mapping_WY_as_Main_temp := join(hull_clean_in, watercraft.file_MIC, 
                                trim(left.hull_id, left, right)[1..3] = right.MIC,
                                main_mapping_temp(left, right), left outer, lookup);


Watercraft.Layout_Watercraft_Search_Group search_mapping_format(Mapping_WY_as_Main_temp L, integer1 C)
 :=
  transform
	self.date_first_seen			:=	L.reg_date;
	self.date_last_seen				:=	L.reg_date;
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
	self.watercraft_key				:=	if(trim(L.YEAR, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12 and L.is_hull_id_in_MIC, 
	                                    trim(L.HULL_ID, left, right), if(trim(L.HULL_ID, left, right) <> 'VARIOUS'and trim(L.HULL_ID, left, right) <> 'UNKNOWN',
	                                    (trim(L.HULL_ID, left, right) + trim(L.MAKE, left, right) + trim(L.YEAR, left, right))[1..30],
	                                    (trim(L.MAKE, left, right) + trim(L.YEAR, left, right) + trim(L.NAME, left, right))[1..30]));
	self.sequence_key				:=	L.reg_date;
	self.state_origin				:=	'WY';
	self.source_code				:=	'AW';
	self.dppa_flag                  :=  '';
	self.orig_name					:=	choose(C,L.NAME,L.COOWNERNAME,L.PREVOWNERNAME);
	self.orig_name_type_code		:=	choose(C,'O','C','P'); //Subject to revision!!!
	self.orig_name_type_description	:=	choose(C,'OWNER','CO-OWNER','PREVIOUS OWNER');
	self.orig_name_first			:=	choose(C,L.FIRST_NM,L.COOWNERFNAME,L.PREVOWNERFNAME);
	self.orig_name_middle			:=	choose(C,L.MID_NM,L.COOWNERMNAME,L.PREVOWNERMNAME);
	self.orig_name_last				:=	choose(C,L.LAST_NM,L.COOWNERLNAME,L.PREVOWNERLNAME);
	self.orig_name_suffix			:=	'';
	self.orig_address_1				:=	L._ADDRESS;
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
	self.clean_pname                :=  choose(C,L.owner_pname + L.owner_pname_score, 
	                                             L.coowner_pname + L.coowner_pname_score, 
	                                             L.prevowner_pname + L.prevowner_pname_score);
	self.company_name				:=	choose(C, L.cname1, L.cname2, L.cname3);
	self.clean_address              :=  L.clean_address;            
	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	'';
	self.did_score					:=	'';                              
	self.ssn						:=	'';
	self.history_flag               :=  ''; 
	SELF := []; 
  end
 ; 
 
Mapping_WY_as_Search_norm			:= normalize(Mapping_WY_as_Main_temp,3,search_mapping_format(left,counter));

export Mapping_WY_New_as_Search     := Mapping_WY_as_Search_norm(clean_pname <> '' or company_name <> '');

