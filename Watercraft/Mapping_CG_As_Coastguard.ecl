import ut, codes; 
ds_water_old := watercraft.file_CG_clean_in_pre20090709; 
ds_water_new := watercraft.file_CG_clean_in;//new layout

watercraft.Layout_CG_clean_in_pre20090407 old_format(ds_water_old l) := transform
self := l;
end;

ds_water_proj_pre20090407 := project(ds_water_old, old_format(left));

watercraft.Layout_CG_clean_in_pre20090407 old_format2(ds_water_new l) := transform
self := l;
end;

ds_water_proj_pre20090709 := project(ds_water_new, old_format2(left));

ds_water_concat := ds_water_proj_pre20090709 + ds_water_proj_pre20090407 + watercraft.file_CG_clean_in_pre20090407;

Watercraft.Macro_Clean_Hull_ID(ds_water_concat, watercraft.Layout_CG_clean_in_pre20090407,hull_clean_in)
//watercraft.Macro_Is_hull_id_in_MIC(watercraft.file_CG_clean_in,watercraft.layout_CG_clean_in,wDatasetwithflag)
//Watercraft.Macro_Clean_Hull_ID(watercraft.file_CG_clean_in, watercraft.Layout_CG_clean_in,hull_clean_in)

watercraft.Layout_Watercraft_Coastguard_Base CG_mapping_format(hull_clean_in L) := transform


    self.watercraft_key				                            :=	L.vessel_id;
	self.sequence_key				        					:= trim(L.NAME,left,right)+trim(L.FIRST_NAME,left,right)+trim(L.MID,left,right)+trim(L.LAST_NAME,left,right);

	self.state_origin											:=	'US';
	self.source_code											:=	'CG';
	self.vessel_id												:=	L.REG_NUM;
	self.vessel_database_key									:=	 if(trim(L.vessel_database_key,left,right)= 'NULL', '', trim(L.vessel_database_key,left,right));
	self.name_of_vessel											:=	L.name_of_vessel;
	self.call_sign												:=	L.call_sign;
	self.official_number										:=	'';
	self.imo_number												:=	L.imo_number;
	self.hull_number											:=	L.hull_id;
	self.hull_identification_number								:=	L.hull_identification_number_2;
	self.vessel_service_type									:=	'';
	self.flag													:=	L.flag;
	self.self_propelled_indicator								:=	L.self_propelled_indicator;
	self.registered_gross_tons									:=	L.registered_gross_tons;
	self.registered_net_tons									:=	L.registered_net_tons;
	self.registered_length										:=	'';
	self.registered_breadth										:=	(string)((decimal2)L.registered_breadth * 12.0);
	self.registered_depth										:=	(string)((decimal2)L.registered_depth * 12.0);
	self.itc_gross_tons											:=	L.itc_gross_tons;
	self.itc_net_tons											:=	L.itc_net_tons;
	self.itc_length												:=	(string)((decimal2)L.itc_length * 12.0);
	self.itc_breadth											:=	(string)((decimal2)L.itc_breadth * 12.0);
	self.itc_depth												:=	(string)((decimal2)L.itc_depth * 12.0);
	
	t_hailing_port :=  if( L.hailing_port_state =''  and codes.valid_st(trim(L.hailing_port[length(trim(L.hailing_port,left,right))-2..],left,right))=true ,stringlib.stringfilterout(trim(L.hailing_port[1.. length(trim(L.hailing_port,left,right))-3],left,right),','),L.hailing_port); 
    t_hailing_port_state :=  if( L.hailing_port_state =''  and codes.valid_st(trim(L.hailing_port[length(trim(L.hailing_port,left,right))-2..],left,right))=true ,trim(L.hailing_port[length(trim(L.hailing_port,left,right))-2..],left,right),L.hailing_port_state); 

	self.hailing_port											:=	t_hailing_port;
	self.hailing_port_state										:=	t_hailing_port_state;
	self.hailing_port_province									:=	L.hailing_port_province;
	self.home_port_name											:=	'';
	self.home_port_state										:=	'';
	self.home_port_province										:=	'';
	self.trade_ind_coastwise_unrestricted						:=	L.trade_Indicator_coastwise_unrestric;
	self.trade_ind_limited_coastwise_bowaters_only				:=	L.Trade_Indicator_Limited_Coastwise_B;
	self.trade_ind_limited_coastwise_restricted					:=	L.Trade_Indicator_Limited_Coastwise_R;
	self.trade_ind_limited_coastwise_oil_spill_response_only	:=	L.Trade_Indicator_Limited_Coastwise_O;
	self.trade_ind_limited_coastwise_under_charter_to_citizen	:=	L.Trade_Indicator_Limited_Coastwise_U;
	self.trade_ind_fishery										:=	L.Trade_Indicator_Fishery;
	self.trade_ind_limited_fishery_only							:=	L.Trade_Indicator_Limited_Fishery_Onl;
	self.trade_ind_recreation									:=	L.Trade_Indicator_Recreation;
	self.trade_ind_limited_recreation_great_lakes_use_only		:=	L.Trade_Indicator_Limited_Recreation_;
	self.trade_ind_registry										:=	L.Trade_Indicator_Registry;
	self.trade_ind_limited_registry_cross_border_financing		:=	L.Trade_Indicator_Limited_Registry_Cr;
	self.trade_ind_limited_registry_no_foreign_voyage			:=	L.Trade_Indicator_Limited_Registry_No;
	self.trade_ind_limited_registry_trade_with_canada_only		:=	L.Trade_Indicator_Limited_Registry_Tr;
	self.trade_ind_great_lakes									:=	L.Trade_Indicator_Great_Lakes;
	self.vessel_complete_build_city								:=	L.Vessel_Complete_Build_City;
	self.vessel_complete_build_state							:=	L.vessel_complete_build_state;
	self.vessel_complete_build_province							:=	L.vessel_complete_build_province;
	self.vessel_complete_build_country							:=	L.vessel_complete_build_country;
	self.vessel_build_year										:=	'';
	self.vessel_hull_build_city									:=	L.vessel_hull_build_city;
	self.vessel_hull_build_state								:=	L.vessel_hull_build_state;
	self.vessel_hull_build_province								:=	L.vessel_hull_build_province;
	self.vessel_hull_build_country								:=	L.vessel_hull_build_country;
	self.party_identification_number							:=	L.party_identification_number;
	self.main_hp_ahead											:=	L.main_hp_ahead;
	self.main_hp_astern											:=	L.main_hp_astern;
	self.propulsion_type										:=	L.propulsion_type;
	self.hull_material											:=	'';
	self.ship_yard					 							:=	'';
	self.hull_builder_name										:=	'';
	self.doc_certificate_status									:=	'';
	self.date_issued											:=	'';
	self.date_expires											:=	'';
	self.hull_design_type										:=	L.Hull_Configuration;
	self.sail_ind												:=	if (stringlib.stringfind(L.Hull_Shape,'Sail',1)<>0,'Y','N');
	self.party_database_key										:=	'';
	self.itc_tons_cod_ind										:=	'';
  end
 ;

export Mapping_CG_As_Coastguard := dedup(project(hull_clean_in,CG_mapping_format(left)),all);

