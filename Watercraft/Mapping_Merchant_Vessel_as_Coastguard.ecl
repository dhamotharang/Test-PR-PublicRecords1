import lib_stringlib;

Watercraft.Layout_Watercraft_Coastguard_Base tMerchantVesselAsCoastguard(Watercraft.File_Merchant_Vessels_Prod L)
 :=
  transform
	self.watercraft_key											:=	lib_stringlib.stringlib.stringfindreplace(trim(L.vessel_id + L.vessel_database_key),' ','_');
	self.sequence_key											:=	L.date_first_seen;
	self.state_origin											:=	'CG';
	self.source_code											:=	'AW';
	self.vessel_id												:=	L.vessel_id;
	self.vessel_database_key									:=	L.vessel_database_key;
	self.name_of_vessel											:=	L.name_of_vessel;
	self.call_sign												:=	L.call_sign;
	self.official_number										:=	L.official_number;
	self.imo_number												:=	L.imo_number;
	self.hull_number											:=	L.hull_number;
	self.hull_identification_number								:=	L.hull_identification_number;
	self.vessel_service_type									:=	L.vessel_service_type;
	self.flag													:=	L.flag;
	self.self_propelled_indicator								:=	L.self_propelled_indicator;
	self.registered_gross_tons									:=	L.registered_gross_tons;
	self.registered_net_tons									:=	L.registered_net_tons;
	self.registered_length										:=	(string)((unsigned8)L.registered_length * 12);
	self.registered_breadth										:=	(string)((unsigned8)L.registered_breadth * 12);
	self.registered_depth										:=	(string)((unsigned8)L.registered_depth * 12);
	self.itc_gross_tons											:=	L.itc_gross_tons;
	self.itc_net_tons											:=	L.itc_net_tons;
	self.itc_length												:=	(string)((unsigned8)L.itc_length * 12);
	self.itc_breadth											:=	(string)((unsigned8)L.itc_breadth * 12);
	self.itc_depth												:=	(string)((unsigned8)L.itc_depth * 12);
	self.hailing_port											:=	L.hailing_port;
	self.hailing_port_state										:=	L.hailing_port_state;
	self.hailing_port_province									:=	L.hailing_port_province;
	self.home_port_name											:=	L.home_port_name;
	self.home_port_state										:=	L.home_port_state;
	self.home_port_province										:=	L.home_port_province;
	self.trade_ind_coastwise_unrestricted						:=	L.trade_coastwise_unrestricted;
	self.trade_ind_limited_coastwise_bowaters_only				:=	L.trade_ltd_cstwse_bowaters_only;
	self.trade_ind_limited_coastwise_restricted					:=	L.trade_ltd_cstwse_restricted;
	self.trade_ind_limited_coastwise_oil_spill_response_only	:=	L.trade_ltd_cstwse_oil_spill_rspnse;
	self.trade_ind_limited_coastwise_under_charter_to_citizen	:=	L.trade_ltd_cstwse_charter_to_ctzen;
	self.trade_ind_fishery										:=	L.trade_fishery;
	self.trade_ind_limited_fishery_only							:=	L.trade_ltd_fishery_only;
	self.trade_ind_recreation									:=	L.trade_recreation;
	self.trade_ind_limited_recreation_great_lakes_use_only		:=	L.trade_ltd_recreation_great_lakes;
	self.trade_ind_registry										:=	L.trade_registry;
	self.trade_ind_limited_registry_cross_border_financing		:=	L.trade_ltd_rgstry_cross_border;
	self.trade_ind_limited_registry_no_foreign_voyage			:=	L.trade_ltd_rgstry_no_forgn_voyage;
	self.trade_ind_limited_registry_trade_with_canada_only		:=	L.trade_ltd_rgstry_trade_w_canada;
	self.trade_ind_great_lakes									:=	L.trade_great_lakes;
	self.vessel_complete_build_city								:=	L.vessel_complete_build_city;
	self.vessel_complete_build_state							:=	L.vessel_complete_build_state;
	self.vessel_complete_build_province							:=	L.vessel_complete_build_province;
	self.vessel_complete_build_country							:=	L.vessel_complete_build_country;
	self.vessel_build_year										:=	L.vessel_build_year;
	self.vessel_hull_build_city									:=	L.vessel_hull_build_city;
	self.vessel_hull_build_state								:=	L.vessel_hull_build_state;
	self.vessel_hull_build_province								:=	L.vessel_hull_build_province;
	self.vessel_hull_build_country								:=	L.vessel_hull_build_country;
	self.party_identification_number							:=	L.party_identification_number;
	self.main_hp_ahead											:=	L.main_hp_ahead;
	self.main_hp_astern											:=	L.main_hp_astern;
	self.propulsion_type										:=	L.propulsion_type;
	self.hull_material											:=	L.hull_material;
	self.ship_yard					 							:=	L.ship_yard;
	self.hull_builder_name										:=	L.hull_builder_name;
	self.doc_certificate_status									:=	L.doc_certificate_status;
	self.date_issued											:=	L.date_issued;
	self.date_expires											:=	L.date_expires;
	self.hull_design_type										:=	L.hull_design_type;
	self.sail_ind												:=	L.sail_ind;
	self.party_database_key										:=	L.party_database_key;
	self.itc_tons_cod_ind										:=	L.itc_tons_cod_ind;
  end
 ;

export Mapping_Merchant_Vessel_As_Coastguard := project(Watercraft.File_Merchant_Vessels_Prod,tMerchantVesselAsCoastguard(left));


 