import lib_stringlib;

Watercraft.Layout_Watercraft_Coastguard_Base tMerchantVesselAsCoastguard(Watercraft.File_Merchant_Vessels_Prod pInput)
 :=
  transform
	self.watercraft_key											:=	lib_stringlib.stringlib.stringfindreplace(trim(pInput.vessel_id + pInput.vessel_database_key),' ','_');
	self.sequence_key											:=	pInput.date_first_seen;
	self.state_origin											:=	'CG';
	self.source_code											:=	'AW';
	self.vessel_id												:=	pInput.vessel_id;
	self.vessel_database_key									:=	pInput.vessel_database_key;
	self.name_of_vessel											:=	pInput.name_of_vessel;
	self.call_sign												:=	pInput.call_sign;
	self.official_number										:=	pInput.official_number;
	self.imo_number												:=	pInput.imo_number;
	self.hull_number											:=	pInput.hull_number;
	self.hull_identification_number								:=	pInput.hull_identification_number;
	self.vessel_service_type									:=	pInput.vessel_service_type;
	self.flag													:=	pInput.flag;
	self.self_propelled_indicator								:=	pInput.self_propelled_indicator;
	self.registered_gross_tons									:=	pInput.registered_gross_tons;
	self.registered_net_tons									:=	pInput.registered_net_tons;
	self.registered_length										:=	(string)((unsigned8)pInput.registered_length * 12);
	self.registered_breadth										:=	(string)((unsigned8)pInput.registered_breadth * 12);
	self.registered_depth										:=	(string)((unsigned8)pInput.registered_depth * 12);
	self.itc_gross_tons											:=	pInput.itc_gross_tons;
	self.itc_net_tons											:=	pInput.itc_net_tons;
	self.itc_length												:=	(string)((unsigned8)pInput.itc_length * 12);
	self.itc_breadth											:=	(string)((unsigned8)pInput.itc_breadth * 12);
	self.itc_depth												:=	(string)((unsigned8)pInput.itc_depth * 12);
	self.hailing_port											:=	pInput.hailing_port;
	self.hailing_port_state										:=	pInput.hailing_port_state;
	self.hailing_port_province									:=	pInput.hailing_port_province;
	self.home_port_name											:=	pInput.home_port_name;
	self.home_port_state										:=	pInput.home_port_state;
	self.home_port_province										:=	pInput.home_port_province;
	self.trade_ind_coastwise_unrestricted						:=	pInput.trade_coastwise_unrestricted;
	self.trade_ind_limited_coastwise_bowaters_only				:=	pInput.trade_ltd_cstwse_bowaters_only;
	self.trade_ind_limited_coastwise_restricted					:=	pInput.trade_ltd_cstwse_restricted;
	self.trade_ind_limited_coastwise_oil_spill_response_only	:=	pInput.trade_ltd_cstwse_oil_spill_rspnse;
	self.trade_ind_limited_coastwise_under_charter_to_citizen	:=	pInput.trade_ltd_cstwse_charter_to_ctzen;
	self.trade_ind_fishery										:=	pInput.trade_fishery;
	self.trade_ind_limited_fishery_only							:=	pInput.trade_ltd_fishery_only;
	self.trade_ind_recreation									:=	pInput.trade_recreation;
	self.trade_ind_limited_recreation_great_lakes_use_only		:=	pInput.trade_ltd_recreation_great_lakes;
	self.trade_ind_registry										:=	pInput.trade_registry;
	self.trade_ind_limited_registry_cross_border_financing		:=	pInput.trade_ltd_rgstry_cross_border;
	self.trade_ind_limited_registry_no_foreign_voyage			:=	pInput.trade_ltd_rgstry_no_forgn_voyage;
	self.trade_ind_limited_registry_trade_with_canada_only		:=	pInput.trade_ltd_rgstry_trade_w_canada;
	self.trade_ind_great_lakes									:=	pInput.trade_great_lakes;
	self.vessel_complete_build_city								:=	pInput.vessel_complete_build_city;
	self.vessel_complete_build_state							:=	pInput.vessel_complete_build_state;
	self.vessel_complete_build_province							:=	pInput.vessel_complete_build_province;
	self.vessel_complete_build_country							:=	pInput.vessel_complete_build_country;
	self.vessel_build_year										:=	pInput.vessel_build_year;
	self.vessel_hull_build_city									:=	pInput.vessel_hull_build_city;
	self.vessel_hull_build_state								:=	pInput.vessel_hull_build_state;
	self.vessel_hull_build_province								:=	pInput.vessel_hull_build_province;
	self.vessel_hull_build_country								:=	pInput.vessel_hull_build_country;
	self.party_identification_number							:=	pInput.party_identification_number;
	self.main_hp_ahead											:=	pInput.main_hp_ahead;
	self.main_hp_astern											:=	pInput.main_hp_astern;
	self.propulsion_type										:=	pInput.propulsion_type;
	self.hull_material											:=	pInput.hull_material;
	self.ship_yard					 							:=	pInput.ship_yard;
	self.hull_builder_name										:=	pInput.hull_builder_name;
	self.doc_certificate_status									:=	pInput.doc_certificate_status;
	self.date_issued											:=	pInput.date_issued;
	self.date_expires											:=	pInput.date_expires;
	self.hull_design_type										:=	pInput.hull_design_type;
	self.sail_ind												:=	pInput.sail_ind;
	self.party_database_key										:=	pInput.party_database_key;
	self.itc_tons_cod_ind										:=	pInput.itc_tons_cod_ind;
  end
 ;

export Mapping_Merchant_Vessel_As_Coastguard := project(Watercraft.File_Merchant_Vessels_Prod,tMerchantVesselAsCoastguard(left)) : persist('persist::watercraft_merchant_vessel_as_coastguard');