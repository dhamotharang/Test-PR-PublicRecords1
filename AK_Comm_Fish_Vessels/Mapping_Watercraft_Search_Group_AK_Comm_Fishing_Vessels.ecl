import lib_stringlib, watercraft, ak_comm_fish_vessels;

Watercraft.Layout_Watercraft_Search_Group search_mapping_format(ak_comm_fish_vessels.layout_vessels_clean L)
 := transform
 	
	string3 v_suffix 	:=  MAP(L.OWNER_NAME_SUF = 'J' => 'JR',
							    L.OWNER_NAME_SUF = 'S' => 'SR',																								  				
							    L.OWNER_NAME_SUF = '1' => 'I',
							    L.OWNER_NAME_SUF = '2' => 'II',
							    L.OWNER_NAME_SUF = '3' => 'III',
							    L.OWNER_NAME_SUF = '4' => 'IV',
							    L.OWNER_NAME_SUF = '5' => 'V',
							    L.OWNER_NAME_SUF = '6' => 'VI',
							    '');
							
	self.date_first_seen			:=	if(l.lic_year<>'' and l.lic_month<>'' and l.lic_day<>'',
	                                     if(l.lic_year<'40','20'+l.lic_year+l.lic_month+l.lic_day,
										 if(l.lic_year>='40','19'+l.lic_year+l.lic_month+l.lic_day,
										'')),'');
	self.date_last_seen				:=	if(l.lic_year<>'' and l.lic_month<>'' and l.lic_day<>'',
	                                     if(l.lic_year<'40','20'+l.lic_year+l.lic_month+l.lic_day,
										 if(l.lic_year>='40','19'+l.lic_year+l.lic_month+l.lic_day,
										'')),'');
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
	self.watercraft_key				:=	trim(L.VADGF_VESSEL_NUMBER)+trim(L.YEAR_BUILT)+'FV';     
	self.sequence_key				:=	'';
	self.state_origin				:=	'FV';
	self.source_code				:=	'FV';
	self.dppa_flag					:=	'';
	self.orig_name					:=	StringLib.StringCleanSpaces(L.OWNER_LNAME+L.OWNER_FNAME+L.OWNER_MI+' '+v_suffix);
	self.orig_name_type_code		:=	'O';
	self.orig_name_type_description	:=  'OWNER';
	self.orig_name_first			:=	trim(L.OWNER_FNAME,left,right);
	self.orig_name_middle			:=	trim(L.OWNER_MI,left,right);
	self.orig_name_last				:=	trim(L.OWNER_LNAME,left,right);
	self.orig_name_suffix			:=	v_suffix;
	self.orig_address_1				:=	trim(L.OWNER_STREET,left,right);
	self.orig_address_2				:=	'';
	self.orig_city					:=	trim(L.OWNER_CITY,left,right);
	self.orig_state					:=	trim(L.OWNER_STATE,left,right);
	self.orig_zip					:=	trim(L.OWNER_ZIP,left,right);
	self.orig_fips					:=	'';
	self.dob						:=	'';
	self.orig_ssn					:=	if(length(trim(L.OWNER_SSN,left,right)) <> 0 and 
										(length(trim(L.OWNER_SSN,left,right)) = 4 or
										length(trim(L.OWNER_SSN,left,right)) = 9), trim(L.OWNER_SSN,left,right), '');
	self.orig_fein					:=	'';
	self.gender						:=	'';
	self.phone_1					:=	'';
	self.phone_2					:=	'';
	self.clean_pname                :=  trim(L.pname,right,left);
	self.company_name				:=	trim(L.cname,right,left);
	self.clean_address              :=  L.clean_address;            
	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	'';
	self.did_score					:=	''; 
	self.ssn                        :=  '';
	self.history_flag				:=	'';
  end; 

export Mapping_Watercraft_Search_Group_AK_Comm_Fishing_Vessels := dedup(project(ak_comm_fish_vessels.file_vessels_clean,search_mapping_format(left))(clean_pname <> '' or company_name <> ''),all);