import lib_stringlib, watercraft, ak_comm_fish_vessels;

Watercraft.Layout_Watercraft_Search_Group search_mapping_format(ak_comm_fish_vessels.layout_permits_clean L)
 := transform
 	
	string3 v_suffix 	:=  MAP(L.HOLDER_SUFFIX = 'J' => 'JR',
							    L.HOLDER_SUFFIX = 'S' => 'SR',																								  				
							    L.HOLDER_SUFFIX = '1' => 'I',
							    L.HOLDER_SUFFIX = '2' => 'II',
							    L.HOLDER_SUFFIX = '3' => 'III',
							    L.HOLDER_SUFFIX = '4' => 'IV',
							    L.HOLDER_SUFFIX = '5' => 'V',
							    L.HOLDER_SUFFIX = '6' => 'VI',
							   '');
							
	self.date_first_seen			:=	if(l.eff_year<>'' and l.eff_month<>'' and l.eff_day<>'',
	                                     if(l.eff_year<'40','20'+l.eff_year+l.eff_month+l.eff_day,
										 if(l.eff_year>='40','19'+l.eff_year+l.eff_month+l.eff_day,
										'')),'');
	self.date_last_seen				:=	if(l.eff_year<>'' and l.eff_month<>'' and l.eff_day<>'',
	                                     if(l.eff_year<'40','20'+l.eff_year+l.eff_month+l.eff_day,
										 if(l.eff_year>='40','19'+l.eff_year+l.eff_month+l.eff_day,
										'')),'');
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
	self.watercraft_key				:=	(string)(integer)L.PADFG_VESSEL_NUMBER+'FV';     
	self.sequence_key				:=	l.sequence_number;
	self.state_origin				:=	'FV';
	self.source_code				:=	'FV';
	self.dppa_flag					:=	'';
	self.orig_name					:=	StringLib.StringCleanSpaces(L.HOLDER_LNAME+L.HOLDER_FNAME+L.HOLDER_MINITIAL+' '+v_suffix);
	self.orig_name_type_code		:=	'O';
	self.orig_name_type_description	:=  'HAS FISHING PERMIT';
	self.orig_name_first			:=	trim(L.HOLDER_FNAME,left,right);
	self.orig_name_middle			:=	trim(L.HOLDER_MINITIAL,left,right);
	self.orig_name_last				:=	trim(L.HOLDER_LNAME,left,right);
	self.orig_name_suffix			:=	v_suffix;
	self.orig_address_1				:=	trim(L.HOLDER_STREET,left,right);
	self.orig_address_2				:=	'';
	self.orig_city					:=	trim(L.HOLDER_CITY,left,right);
	self.orig_state					:=	trim(L.HOLDER_STATE,left,right);
	self.orig_zip					:=	trim(L.HOLDER_ZIP,left,right);
	self.orig_fips					:=	'';
	self.dob						:=	'';
	self.orig_ssn                   := if(length(trim(l.holder_ssn))<9,'',l.holder_ssn);
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

export Mapping_Watercraft_Search_Group_AK_Comm_Fishing_Permit := dedup(project(ak_comm_fish_vessels.file_permits_clean((integer)PADFG_VESSEL_NUMBER<>0),search_mapping_format(left))(clean_pname <> '' or company_name <> ''),all);