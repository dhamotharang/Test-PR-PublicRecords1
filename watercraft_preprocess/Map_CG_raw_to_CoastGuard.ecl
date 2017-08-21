import lib_stringlib, watercraft, watercraft_preprocess, ut, codes;

// translates merchent_vessel.mp Ab intio graph into ECL 

Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_CG_clean_in, watercraft.Layout_CG, hull_clean_in)

watercraft.Layout_Watercraft_Coastguard_Base CG_mapping_format(hull_clean_in L) := transform
	self.watercraft_key				:=	L.VESSEL_ID;
	self.sequence_key			    :=	StringLib.StringCleanSpaces(trim(L.NAME,left,right)+trim(L.FIRST_NAME,left,right)+trim(L.MID,left,right)+trim(L.LAST_NAME,left,right));
	self.state_origin					:=	'US';
	self.source_code					:=	'CG';
	self.vessel_id						:=	L.REG_NUM;  //L.VESSEL_ID - this is correct mapping but incorrect in Prod so will keep Prod mapping for consistency;
	self.vessel_database_key	:=	if(trim(L.VESSEL_DATABASE_KEY,left,right)= 'NULL', '', trim(L.VESSEL_DATABASE_KEY,left,right));
	self.name_of_vessel				:=	L.NAME_OF_VESSEL;
	self.call_sign						:=	L.CALL_SIGN;
	self.imo_number						:=	L.IMO_NUMBER;
	self.hull_number					:=	L.HULL_ID;
	self.hull_identification_number	:=	L.HULL_IDENTIFICATION_NUMBER_2;
	self.vessel_service_type				:=	L.VESSEL_SERVICE_TYPE;
	self.flag												:=	L.FLAG;
	self.self_propelled_indicator		:=	L.SELF_PROPELLED_INDICATOR;
	self.registered_gross_tons			:=	L.REGISTERED_GROSS_TONS;
	self.registered_net_tons				:=	L.REGISTERED_NET_TONS;
	self.registered_breadth					:=	(string)((decimal2)L.REGISTERED_BREADTH * 12.0);
	self.registered_depth						:=	(string)((decimal2)L.REGISTERED_DEPTH * 12.0);
	self.itc_gross_tons							:=	L.ITC_GROSS_TONS;
	self.itc_net_tons								:=	L.ITC_NET_TONS;
	self.itc_length									:=	(string)((decimal2)L.ITC_LENGTH * 12.0);
	self.itc_breadth								:=	(string)((decimal2)L.ITC_BREADTH * 12.0);
	self.itc_depth									:=	(string)((decimal2)L.ITC_DEPTH * 12.0);
	t_hailing_port 				:=  if( L.HAILING_PORT_STATE =''  and codes.valid_st(trim(L.HAILING_PORT[length(trim(L.HAILING_PORT,left,right))-2..],left,right))=true ,stringlib.stringfilterout(trim(L.HAILING_PORT[1.. length(trim(L.HAILING_PORT,left,right))-3],left,right),','),L.HAILING_PORT); 
  t_hailing_port_state 	:=  if( L.HAILING_PORT_STATE =''  and codes.valid_st(trim(L.HAILING_PORT[length(trim(L.HAILING_PORT,left,right))-2..],left,right))=true ,trim(L.HAILING_PORT[length(trim(L.HAILING_PORT,left,right))-2..],left,right),L.HAILING_PORT_STATE); 
	self.hailing_port								:=	t_hailing_port;
	self.hailing_port_state					:=	t_hailing_port_state;
	self.hailing_port_province			:=	L.HAILING_PORT_PROVINCE;
	self.trade_ind_coastwise_unrestricted											:=	L.TRADE_INDICATOR_COASTWISE_UNRESTRIC;
	self.trade_ind_limited_coastwise_bowaters_only						:=	L.TRADE_INDICATOR_LIMITED_COASTWISE_B;
	self.trade_ind_limited_coastwise_restricted								:=	L.TRADE_INDICATOR_LIMITED_COASTWISE_R;
	self.trade_ind_limited_coastwise_oil_spill_response_only	:=	L.TRADE_INDICATOR_LIMITED_COASTWISE_O;
	self.trade_ind_limited_coastwise_under_charter_to_citizen	:=	L.TRADE_INDICATOR_LIMITED_COASTWISE_U;
	self.trade_ind_fishery																		:=	L.TRADE_INDICATOR_FISHERY;
	self.trade_ind_limited_fishery_only												:=	L.TRADE_INDICATOR_LIMITED_FISHERY_ONL;
	self.trade_ind_recreation																	:=	L.TRADE_INDICATOR_RECREATION;
	self.trade_ind_limited_recreation_great_lakes_use_only		:=	L.TRADE_INDICATOR_LIMITED_RECREATION_;
	self.trade_ind_registry																		:=	L.TRADE_INDICATOR_REGISTRY;
	self.trade_ind_limited_registry_cross_border_financing		:=	L.TRADE_INDICATOR_LIMITED_REGISTRY_CR;
	self.trade_ind_limited_registry_no_foreign_voyage					:=	L.TRADE_INDICATOR_LIMITED_REGISTRY_NO;
	self.trade_ind_limited_registry_trade_with_canada_only		:=	L.TRADE_INDICATOR_LIMITED_REGISTRY_TR;
	self.trade_ind_great_lakes																:=	L.TRADE_INDICATOR_GREAT_LAKES;
	self.vessel_complete_build_city														:=	L.VESSEL_COMPLETE_BUILD_CITY;
	self.vessel_complete_build_state													:=	L.VESSEL_COMPLETE_BUILD_STATE;
	self.vessel_complete_build_province												:=	L.VESSEL_COMPLETE_BUILD_PROVINCE;
	self.vessel_complete_build_country												:=	L.VESSEL_COMPLETE_BUILD_COUNTRY;
	self.vessel_hull_build_city																:=	L.VESSEL_HULL_BUILD_CITY;
	self.vessel_hull_build_state															:=	L.VESSEL_HULL_BUILD_STATE;
	self.vessel_hull_build_province														:=	L.VESSEL_HULL_BUILD_PROVINCE;
	self.vessel_hull_build_country														:=	L.VESSEL_HULL_BUILD_COUNTRY;
	self.party_identification_number													:=	L.PARTY_IDENTIFICATION_NUMBER;
	self.main_hp_ahead																				:=	L.MAIN_HP_AHEAD;
	self.main_hp_astern																				:=	L.MAIN_HP_ASTERN;
	self.propulsion_type																			:=	L.PROPULSION_TYPE;
	self.hull_material																				:=	L.HULL;
	self.hull_design_type																			:=	L.HULL_CONFIGURATION;
	self.sail_ind																							:=	if (stringlib.stringfind(L.HULL_SHAPE,'SAIL',1)<>0,'Y','N');
	self := L;
	self := [];
END;

EXPORT Map_CG_raw_to_CoastGuard := dedup(project(hull_clean_in,CG_mapping_format(left)));