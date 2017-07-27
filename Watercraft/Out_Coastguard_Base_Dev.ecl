import Watercraft_UMF, Ut,Business_Header_SS,Business_Header,watercraft;
 
 Join_CG :=     Watercraft.Mapping_CG_as_Coastguard
										+ Watercraft.Mapping_WI_as_CoastGuard; 
										
										  
 //Add persistent record id 
 
 dedup_coast := dedup(project(Join_CG, transform( Watercraft.Layout_Watercraft_Coastguard_Base, 
 
    self.watercraft_key := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.watercraft_key));
    self.sequence_key := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.sequence_key));
    self.state_origin := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.state_origin));
		self.source_code := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.source_code));
		self.vessel_id  := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.vessel_id));
		self.vessel_database_key := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.vessel_database_key));
		self.name_of_vessel:= stringlib.stringcleanspaces(stringlib.stringtouppercase(left.name_of_vessel));
		self.call_sign:= stringlib.stringcleanspaces(stringlib.stringtouppercase(left.call_sign));
		self.official_number:= stringlib.stringcleanspaces(stringlib.stringtouppercase(left.official_number));
		self.imo_number := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.imo_number ));
		self.hull_number := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.hull_number));
		self.hull_identification_number := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.hull_identification_number));
		self.vessel_service_type := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.vessel_service_type));
			self.flag := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.flag));
			self.self_propelled_indicator := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.self_propelled_indicator));
			self.registered_gross_tons := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.registered_gross_tons));
			self.registered_net_tons := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.registered_net_tons));
			self.registered_length := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.registered_length));
			self.registered_breadth := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.registered_breadth));
			self.registered_depth := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.registered_depth));
			self.itc_gross_tons := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.itc_gross_tons));
			self.itc_net_tons := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.itc_net_tons));
			self.itc_length := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.itc_length));
			self.itc_breadth := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.itc_breadth));
			self.itc_depth := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.itc_depth));
		  self.hailing_port := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.hailing_port));
			self.hailing_port_state := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.hailing_port_state));
		  self.hailing_port_province := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.hailing_port_province));
		  self.home_port_name := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.home_port_name));
			self.home_port_state := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.home_port_state));
		  self.home_port_province := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.home_port_province));
			self.trade_ind_coastwise_unrestricted := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.trade_ind_coastwise_unrestricted));
			self.trade_ind_limited_coastwise_bowaters_only := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.trade_ind_limited_coastwise_bowaters_only));
			self.trade_ind_limited_coastwise_restricted := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.trade_ind_limited_coastwise_restricted));
			self.trade_ind_limited_coastwise_oil_spill_response_only := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.trade_ind_limited_coastwise_oil_spill_response_only));
			self.trade_ind_limited_coastwise_under_charter_to_citizen := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.trade_ind_limited_coastwise_under_charter_to_citizen));
			self.trade_ind_fishery := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.trade_ind_fishery));
			self.trade_ind_limited_fishery_only := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.trade_ind_limited_fishery_only));
			self.trade_ind_recreation := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.trade_ind_recreation ));
			self.trade_ind_limited_recreation_great_lakes_use_only := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.trade_ind_limited_recreation_great_lakes_use_only));
			self.trade_ind_registry := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.trade_ind_registry));
			self.trade_ind_limited_registry_cross_border_financing := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.trade_ind_limited_registry_cross_border_financing));
			self.trade_ind_limited_registry_no_foreign_voyage := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.trade_ind_limited_registry_no_foreign_voyage));
			self.trade_ind_limited_registry_trade_with_canada_only := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.trade_ind_limited_registry_trade_with_canada_only));
			self.trade_ind_great_lakes := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.trade_ind_great_lakes));
		  self.vessel_complete_build_city := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.vessel_complete_build_city));
			self.vessel_complete_build_state := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.vessel_complete_build_state));
		  self.vessel_complete_build_province := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.vessel_complete_build_province));
		  self.vessel_complete_build_country := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.vessel_complete_build_country));
			self.vessel_build_year := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.vessel_build_year));
		  self.vessel_hull_build_city := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.vessel_hull_build_city ));
			self.vessel_hull_build_state := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.vessel_hull_build_state));
		  self.vessel_hull_build_province := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.vessel_hull_build_province));
		  self.vessel_hull_build_country := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.vessel_hull_build_country));
		  self.party_identification_number := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.party_identification_number));
			self.main_hp_ahead := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.main_hp_ahead));
			self.main_hp_astern := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.main_hp_astern));
		  self.propulsion_type := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.propulsion_type));
		  self.hull_material := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.hull_material));
		  self.ship_yard := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.ship_yard ));
		  self.hull_builder_name := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.hull_builder_name));
		  self.doc_certificate_status := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.doc_certificate_status));
		  self.date_issued:= stringlib.stringcleanspaces(stringlib.stringtouppercase(left.date_issued));
		  self.date_expires := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.date_expires));
		  self.hull_design_type := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.hull_design_type));
		  self.sail_ind := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.sail_ind));
		  self.party_database_key := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.party_database_key));
		  self.itc_tons_cod_ind := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.itc_tons_cod_ind));
		)),all); 
		
Base_Coastguard_Dev := project(dedup_coast , transform(Watercraft.Layout_Watercraft_Coastguard_Base, 
	
	self.persistent_record_id := HASH64(trim(left.watercraft_key,left,right) +','+
																			trim(left.sequence_key ,left,right) +','+
																			trim(left.state_origin ,left,right) +','+
																			trim(left.source_code,left,right) +','+
																			trim(left.vessel_id,left,right) +','+
																			trim(left.vessel_database_key,left,right) +','+
																			trim(left.name_of_vessel,left,right) +','+
																			trim(left.call_sign,left,right) +','+
																			trim(left.official_number,left,right) +','+
																			trim(left.imo_number,left,right) +','+
																			trim(left.hull_number,left,right) +','+
																			trim(left.hull_identification_number,left,right) +','+
																			trim(left.vessel_service_type,left,right) +','+
																			trim(left.flag,left,right) +','+
																			trim(left.self_propelled_indicator,left,right) +','+
																			trim(left.registered_gross_tons,left,right) +','+
																			trim(left.registered_net_tons,left,right) +','+
																			trim(left.registered_length,left,right) +','+
																			trim(left.registered_breadth,left,right) +','+
																			trim(left.registered_depth,left,right) +','+
																			trim(left.itc_gross_tons,left,right) +','+
																			trim(left.itc_net_tons,left,right) +','+
																			trim(left.itc_length,left,right) +','+
																			trim(left.itc_breadth,left,right) +','+
																			trim(left.itc_depth,left,right) +','+
																			trim(left.hailing_port,left,right) +','+
																			trim(left.hailing_port_state,left,right) +','+
																			trim(left.hailing_port_province,left,right) +','+
																			trim(left.home_port_name,left,right) +','+
																			trim(left.home_port_state,left,right) +','+
																			trim(left.home_port_province,left,right) +','+
																			trim(left.trade_ind_coastwise_unrestricted,left,right) +','+
																			trim(left.trade_ind_limited_coastwise_bowaters_only,left,right) +','+
																			trim(left.trade_ind_limited_coastwise_restricted,left,right) +','+
																			trim(left.trade_ind_limited_coastwise_oil_spill_response_only,left,right) +','+
																			trim(left.trade_ind_limited_coastwise_under_charter_to_citizen,left,right) +','+
																			trim(left.trade_ind_fishery,left,right) +','+
																			trim(left.trade_ind_limited_fishery_only,left,right) +','+
																			trim(left.trade_ind_recreation,left,right) +','+
																			trim(left.trade_ind_limited_recreation_great_lakes_use_only,left,right) +','+
																			trim(left.trade_ind_registry,left,right) +','+
																			trim(left.trade_ind_limited_registry_cross_border_financing,left,right) +','+
																			trim(left.trade_ind_limited_registry_no_foreign_voyage,left,right) +','+
																			trim(left.trade_ind_limited_registry_trade_with_canada_only,left,right) +','+
																			trim(left.trade_ind_great_lakes,left,right) +','+
																			trim(left.vessel_complete_build_city,left,right) +','+
																			trim(left.vessel_complete_build_state,left,right) +','+
																			trim(left.vessel_complete_build_province,left,right) +','+
																			trim(left.vessel_complete_build_country,left,right) +','+
																			trim(left.vessel_build_year,left,right) +','+
																			trim(left.vessel_hull_build_city,left,right) +','+
																			trim(left.vessel_hull_build_state,left,right) +','+
																			trim(left.vessel_hull_build_province,left,right) +','+
																			trim(left.vessel_hull_build_country,left,right) +','+
																			trim(left.party_identification_number,left,right) +','+
																			trim(left.main_hp_ahead,left,right) +','+
																			trim(left.main_hp_astern,left,right) +','+
																			trim(left.propulsion_type,left,right) +','+
																			trim(left.hull_material,left,right) +','+
																			trim(left.ship_yard,left,right) +','+
																			trim(left.hull_builder_name,left,right) +','+
																			trim(left.doc_certificate_status,left,right) +','+
																			trim(left.date_issued,left,right) +','+
																			trim(left.date_expires,left,right) +','+
																			trim(left.hull_design_type,left,right) +','+
																			trim(left.sail_ind,left,right) +','+
																			trim(left.party_database_key,left,right) +','+
																			trim(left.itc_tons_cod_ind,left,right) );

self := left)); 
 
 export Out_Coastguard_Base_Dev := Base_Coastguard_Dev;