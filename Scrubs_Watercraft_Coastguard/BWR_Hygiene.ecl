//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Watercraft_Coastguard.BWR_Hygiene - Hygiene & Stats - SALT V3.0 Beta 2');
IMPORT Scrubs_Watercraft_Coastguard,SALT30;
// First create an instantiated hygiene module
  infile := Scrubs_Watercraft_Coastguard.In_Watercraft_Coastguard;
  h := Scrubs_Watercraft_Coastguard.Hygiene(infile);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(SALT30.MAC_Character_Counts.EclRecord(p,'Layout_Watercraft_Coastguard'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT30.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT30.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,watercraft_key,Examples),NAMED('watercraft_keyBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,sequence_key,Examples),NAMED('sequence_keyBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,state_origin,Examples),NAMED('state_originBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,source_code,Examples),NAMED('source_codeBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,vessel_id,Examples),NAMED('vessel_idBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,vessel_database_key,Examples),NAMED('vessel_database_keyBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,name_of_vessel,Examples),NAMED('name_of_vesselBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,call_sign,Examples),NAMED('call_signBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,official_number,Examples),NAMED('official_numberBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,imo_number,Examples),NAMED('imo_numberBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,hull_number,Examples),NAMED('hull_numberBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,hull_identification_number,Examples),NAMED('hull_identification_numberBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,vessel_service_type,Examples),NAMED('vessel_service_typeBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,flag,Examples),NAMED('flagBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,self_propelled_indicator,Examples),NAMED('self_propelled_indicatorBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,registered_gross_tons,Examples),NAMED('registered_gross_tonsBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,registered_net_tons,Examples),NAMED('registered_net_tonsBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,registered_length,Examples),NAMED('registered_lengthBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,registered_breadth,Examples),NAMED('registered_breadthBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,registered_depth,Examples),NAMED('registered_depthBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,itc_gross_tons,Examples),NAMED('itc_gross_tonsBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,itc_net_tons,Examples),NAMED('itc_net_tonsBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,itc_length,Examples),NAMED('itc_lengthBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,itc_breadth,Examples),NAMED('itc_breadthBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,itc_depth,Examples),NAMED('itc_depthBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,hailing_port,Examples),NAMED('hailing_portBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,hailing_port_state,Examples),NAMED('hailing_port_stateBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,hailing_port_province,Examples),NAMED('hailing_port_provinceBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,home_port_name,Examples),NAMED('home_port_nameBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,home_port_state,Examples),NAMED('home_port_stateBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,home_port_province,Examples),NAMED('home_port_provinceBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,trade_ind_coastwise_unrestricted,Examples),NAMED('trade_ind_coastwise_unrestrictedBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,trade_ind_limited_coastwise_bowaters_only,Examples),NAMED('trade_ind_limited_coastwise_bowaters_onlyBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,trade_ind_limited_coastwise_restricted,Examples),NAMED('trade_ind_limited_coastwise_restrictedBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,trade_ind_limited_coastwise_oil_spill_response_only,Examples),NAMED('trade_ind_limited_coastwise_oil_spill_response_onlyBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,trade_ind_limited_coastwise_under_charter_to_citizen,Examples),NAMED('trade_ind_limited_coastwise_under_charter_to_citizenBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,trade_ind_fishery,Examples),NAMED('trade_ind_fisheryBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,trade_ind_limited_fishery_only,Examples),NAMED('trade_ind_limited_fishery_onlyBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,trade_ind_recreation,Examples),NAMED('trade_ind_recreationBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,trade_ind_limited_recreation_great_lakes_use_only,Examples),NAMED('trade_ind_limited_recreation_great_lakes_use_onlyBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,trade_ind_registry,Examples),NAMED('trade_ind_registryBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,trade_ind_limited_registry_cross_border_financing,Examples),NAMED('trade_ind_limited_registry_cross_border_financingBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,trade_ind_limited_registry_no_foreign_voyage,Examples),NAMED('trade_ind_limited_registry_no_foreign_voyageBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,trade_ind_limited_registry_trade_with_canada_only,Examples),NAMED('trade_ind_limited_registry_trade_with_canada_onlyBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,trade_ind_great_lakes,Examples),NAMED('trade_ind_great_lakesBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,vessel_complete_build_city,Examples),NAMED('vessel_complete_build_cityBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,vessel_complete_build_state,Examples),NAMED('vessel_complete_build_stateBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,vessel_complete_build_province,Examples),NAMED('vessel_complete_build_provinceBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,vessel_complete_build_country,Examples),NAMED('vessel_complete_build_countryBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,vessel_build_year,Examples),NAMED('vessel_build_yearBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,vessel_hull_build_city,Examples),NAMED('vessel_hull_build_cityBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,vessel_hull_build_state,Examples),NAMED('vessel_hull_build_stateBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,vessel_hull_build_province,Examples),NAMED('vessel_hull_build_provinceBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,vessel_hull_build_country,Examples),NAMED('vessel_hull_build_countryBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,party_identification_number,Examples),NAMED('party_identification_numberBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,main_hp_ahead,Examples),NAMED('main_hp_aheadBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,main_hp_astern,Examples),NAMED('main_hp_asternBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,propulsion_type,Examples),NAMED('propulsion_typeBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,hull_material,Examples),NAMED('hull_materialBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,ship_yard,Examples),NAMED('ship_yardBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,hull_builder_name,Examples),NAMED('hull_builder_nameBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,doc_certificate_status,Examples),NAMED('doc_certificate_statusBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,date_issued,Examples),NAMED('date_issuedBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,date_expires,Examples),NAMED('date_expiresBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,hull_design_type,Examples),NAMED('hull_design_typeBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,sail_ind,Examples),NAMED('sail_indBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,party_database_key,Examples),NAMED('party_database_keyBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,itc_tons_cod_ind,Examples),NAMED('itc_tons_cod_indBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,persistent_record_id,Examples),NAMED('persistent_record_idBysource_code'));
