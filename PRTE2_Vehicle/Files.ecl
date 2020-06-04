import std, NID, ut, prte2_vehicle, VehicleV2, standard, BIPV2,VINA, Data_Services;

EXPORT Files := module

EXPORT file_vina_base := DATASET(data_services.foreign_prod + 'thor_data400::base::vintelligence',VINA.layout_base_vintelligence,THOR);

//incoming files
export in_main		:= dataset(constants.in_prefix_name + 'main', layouts.in_main,CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
export in_party		:= dataset(constants.in_prefix_name + 'party', layouts.in_party,CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));

//bse files
export main_base	:= dataset(constants.base_prefix_name + 'main', layouts.Base_Main, thor);

export party_bip	:= dataset(constants.base_prefix_name + 'party', layouts.Base_Party_BIP, thor);

export main_slim	:= project(main_base, {main_base} - [cust_name, bug_num]);

//Blank Files
export wildcard_public				:= dataset([],layouts.wildcard_public);
export keymodelindex_public		:= dataset([],layouts.keymodelindex_public);
export keynameindex_public		:= dataset([],layouts.keynameindex_public);
export ws_bodystyle						:= dataset([],layouts.wc_vehicle_bodystyle);
export wc_vehicle_make				:= dataset([],layouts.wc_vehicle_make);



//Intermediate files for keybuilding
layouts.Party_Building	xformBuilding(party_bip pInput) := transform
self.ttl_number 											:= if(	(pInput.source_code = 'AE' and	pInput.state_origin = 'ME') 
																								or pInput.state_origin = 'NE','', pInput.ttl_number);
self.date_first_seen									:= (unsigned3)((string)pInput.Date_First_Seen)[1..6];
self.date_last_seen										:=	(unsigned3)((string)pInput.Date_Last_Seen)[1..6];
self.date_vendor_first_reported				:=	(unsigned3)((string)pInput.Date_Vendor_First_Reported)[1..6];
self.date_vendor_last_reported				:=	(unsigned3)((string)pInput.Date_Vendor_Last_Reported)[1..6];																				
self.append_clean_name.title					:=	pInput.title;
self.append_clean_name.fname					:=	pInput.fname;                                                                                                                      
self.append_clean_name.mname					:=	pInput.mname;                                                                                                                      
self.append_clean_name.lname					:=	pInput.lname;                                                                                                                      
self.append_clean_name.name_suffix		:=	pInput.name_suffix;                                                                                                                     
self.append_clean_name.name_score			:=	pInput.name_score; 
self.append_clean_address.prim_range	:=	pInput.prim_range;                                                                      
self.append_clean_address.predir			:=	pInput.predir;                                                                      
self.append_clean_address.prim_name		:=	pInput.prim_name;                                                                      
self.append_clean_address.addr_suffix	:=  pInput.addr_suffix;                                                                      
self.append_clean_address.postdir			:=	pInput.postdir;                                                                      
self.append_clean_address.unit_desig	:=	pInput.unit_desig;                                                                      
self.append_clean_address.sec_range		:=	pInput.sec_range;                                                                      
self.append_clean_address.v_city_name	:=	pInput.v_city_name;
self.append_clean_address.st					:=	pInput.st;
self.append_clean_address.zip5				:=	pInput.zip5;
self.append_clean_address.zip4				:=	pInput.zip4;
self.append_clean_address.fips_state	:=	pInput.fips_state;
self.append_clean_address.fips_county	:=	pInput.fips_county;
self.append_clean_address.geo_lat			:=	pInput.geo_lat;
self.append_clean_address.geo_long		:=	pInput.geo_long;
self.append_clean_address.cbsa				:=	pInput.cbsa;
self.append_clean_address.geo_blk			:=	pInput.geo_blk;
self.append_clean_address.geo_match		:=	pInput.geo_match;
self.append_clean_address.err_stat		:=	pInput.err_stat;													
self := pInput;
self := [];
end;
																													
export party_building				:= project(party_bip,	xformBuilding(left));
																			
export party_clean_sequence := project(party_building, layouts.party_sequence);
export party_slim						:= project(party_building, {layouts.party_sequence} - [SRC_FIRST_DATE, SRC_LAST_DATE] - BIPV2.IDlayouts.l_xlink_ids);
export party_dedup  				:= fn_AgePerPlateAddr(party_clean_sequence);
	
end;