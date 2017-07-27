import watercraft;


file_VA_filter  := watercraft.file_VA_clean_in(Fips_Used <> '' or Fips_Docked <> '');


Layout_VA_clean_temp := record

watercraft.Layout_VA_clean_in;
watercraft.Layout_MIC;

boolean is_hull_id_in_MIC;
    	
end;

Layout_VA_clean_temp main_mapping_temp(file_VA_filter L, watercraft.file_MIC R)

:= transform

self := L;
self := R;
self.is_hull_id_in_MIC := if(trim(L.hull_id, left, right)[1..3] = R.MIC, true, false);

end;

Mapping_VA_as_Main_temp := join(file_VA_filter, watercraft.file_MIC, trim(left.hull_id, left, right)[1..3] = right.MIC,
main_mapping_temp(left, right), left outer, lookup);


watercraft.Layout_Watercraft_Coastguard_Base main_mapping_format(Mapping_VA_as_Main_temp L) := transform


self.watercraft_key					   :=	if(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12 and L.is_hull_id_in_MIC, 
                                            trim(L.HULL_ID,left, right),if(L.HULL_ID <> '',(trim(L.HULL_ID, left, right) + trim(L.MAKE, left, right) + trim(L.YEAR, left, right)
											+ trim(L.NAME, left, right))[1..30], if(L.MAKE <> '' and trim(L.YEAR, left, right) = '0', L.REG_NUM, 
											(trim(L.MAKE, left, right) + trim(L.YEAR, left, right) + trim(L.FIRST_NAME, left, right) + trim(L.MID, left, right)
											+ trim(L.LAST_NAME, left, right))[1..30])));
	self.sequence_key				   :=	trim(L.reg_date, left, right);
self.state_origin                      :=  'VA';
self.source_code                       :=  'AW';
self.vessel_id                         :=  '';
self.vessel_database_key               :=  '';
self.name_of_vessel                    :=  '';
self.call_sign                         :=  '';
self.official_number                   :=  '';
self.imo_number                        :=  '';
self.hull_number                       :=  '';
self.hull_identification_number        :=  L.HULL_ID;
self.vessel_service_type               :=  L.USE_1;
self.flag                              :=  '';
self.self_propelled_indicator          :=  '';
self.registered_gross_tons             :=  '';
self.registered_net_tons               :=  '';
self.registered_length                 :=  '';
self.registered_breadth                :=  '';
self.registered_depth                  :=  '';
self.itc_gross_tons                    :=  '';
self.itc_net_tons                      :=  '';
self.itc_length                        :=  '';
self.itc_breadth                       :=  '';
self.itc_depth                         :=  '';
self.hailing_port                      :=  L.Fips_Used;
self.hailing_port_state                :=  '';
self.hailing_port_province             :=  '';
self.home_port_name                    :=  L.Fips_Docked;
self.home_port_state                   :=  '';
self.home_port_province                :=  '';
self.trade_ind_coastwise_unrestricted  :=  '';
self.trade_ind_limited_coastwise_bowaters_only                  :=  '';
self.trade_ind_limited_coastwise_restricted                     :=  '';
self.trade_ind_limited_coastwise_oil_spill_response_only        :=  '';
self.trade_ind_limited_coastwise_under_charter_to_citizen       :=  '';
self.trade_ind_fishery                                          :=  '';
self.trade_ind_limited_fishery_only                             :=  '';
self.trade_ind_recreation                                       :=  '';
self.trade_ind_limited_recreation_great_lakes_use_only          :=  '';
self.trade_ind_registry                                         :=  '';
self.trade_ind_limited_registry_cross_border_financing          :=  '';
self.trade_ind_limited_registry_no_foreign_voyage               :=  '';
self.trade_ind_limited_registry_trade_with_canada_only          :=  '';
self.trade_ind_great_lakes                                      :=  '';
self.vessel_complete_build_city                                 :=  '';
self.vessel_complete_build_state                                :=  '';
self.vessel_complete_build_province                             :=  '';
self.vessel_complete_build_country                              :=  '';
self.vessel_build_year                                          :=  '';
self.vessel_hull_build_city                                     :=  '';
self.vessel_hull_build_state                                    :=  '';
self.vessel_hull_build_province                                 :=  '';
self.vessel_hull_build_country                                  :=  '';
self.party_identification_number                                :=  '';
self.main_hp_ahead                                              :=  '';
self.main_hp_astern                                             :=  '';
self.propulsion_type                                            :=  L.PROP;
self.hull_material                                              :=  '';
self.ship_yard                                                  :=  '';
self.hull_builder_name                                          :=  '';
self.doc_certificate_status                                     :=  '';
self.date_issued                                                :=  '';
self.date_expires                                               :=  '';
self.hull_design_type                                           :=  '';
self.sail_ind                                                   :=  '';
self.party_database_key                                         :=  '';
self.itc_tons_cod_ind                                           :=  '';

  
end;

export Mapping_VA_as_Coastguard := project(Mapping_VA_as_Main_temp, main_mapping_format(left));


