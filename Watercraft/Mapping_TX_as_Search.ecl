import watercraft, lib_stringlib;

Watercraft.Macro_Clean_Hull_ID(watercraft.file_TX_clean_in, watercraft.layout_TX_clean_in,hull_clean_in)

watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, watercraft.Layout_TX_clean_in, wDatasetwithflag)

string fFixHullID(string pHullIDIn)
 := lib_stringlib.StringLib.StringFilter(lib_stringlib.stringlib.stringtouppercase(pHullIDIn),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ ');

Watercraft.Layout_Watercraft_Search_Group search_mapping_format(wDatasetwithflag L) := transform
 
	self.date_first_seen			:=	L.REG_DATE;
	self.date_last_seen				:=	L.REG_DATE;
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
	self.watercraft_key				:=	if(trim(L.YEAR, left, right) >= '1972' and length(trim(fFixHullID(L.HULL_ID),left, right)) = 12 and L.is_hull_id_in_MIC, 
	                                    trim(fFixHullID(L.HULL_ID), left, right), if(fFixHullID(L.HULL_ID) <> '' and trim(fFixHullID(L.HULL_ID), left, right) <> 'UNKN'and 
									    trim(fFixHullID(L.HULL_ID), left, right) <> 'UNKNOWN' and trim(L.YEAR, left, right) <> '19',
	                                    (trim(fFixHullID(L.HULL_ID), left, right) + trim(L.MAKE, left, right) + trim(L.YEAR, left, right))[1..30],
	                                    (trim(L.MAKE, left, right) + trim(L.YEAR, left, right) + trim(L.NAME, left, right))[1..30]));
	self.sequence_key				:=	L.REG_DATE;

	self.state_origin				:=	'TX';
	self.source_code				:=	'AW';
	self.dppa_flag					:=	'';
	self.orig_name					:=	L.NAME;
	self.orig_name_type_code		:=  'O';
	self.orig_name_type_description	:=	'OWNER';
	self.orig_name_first			:=	L.FIRST_NAME;
	self.orig_name_middle			:=	L.MID;
	self.orig_name_last				:=	L.LAST_NAME;
	self.orig_name_suffix			:=	L.PRIMARY_OWNER_SUFFIX;
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
	self.clean_pname                :=  L.pname;
	self.company_name				:=	L.cname;
	self.clean_address              :=  L.clean_address;            
	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	'';
	self.did_score					:=	'';                              
	self.ssn						:=	'';
	self.history_flag				:=	'';
  end
 ; 
 
 
export Mapping_TX_as_Search	:= project(wDatasetwithflag,search_mapping_format(left))(clean_pname <> '' or company_name <> '');

