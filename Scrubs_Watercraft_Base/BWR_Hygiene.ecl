//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Watercraft_Base.BWR_Hygiene - Hygiene & Stats - SALT V3.0 A21');
IMPORT Scrubs_Watercraft_Base,SALT30;
// First create an instantiated hygiene module
  infile := Scrubs_Watercraft_Base.In_Watercraft_Base;
  h := Scrubs_Watercraft_Base.Hygiene(infile);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(SALT30.MAC_Character_Counts.EclRecord(p,'Layout_Watercraft_Base'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT30.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT30.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,watercraft_key,Examples),NAMED('watercraft_keyBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,sequence_key,Examples),NAMED('sequence_keyBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,watercraft_id,Examples),NAMED('watercraft_idBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,state_origin,Examples),NAMED('state_originBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,source_code,Examples),NAMED('source_codeBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,st_registration,Examples),NAMED('st_registrationBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,county_registration,Examples),NAMED('county_registrationBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,registration_number,Examples),NAMED('registration_numberBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,hull_number,Examples),NAMED('hull_numberBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,propulsion_description,Examples),NAMED('propulsion_descriptionBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,vehicle_type_code,Examples),NAMED('vehicle_type_codeBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,vehicle_type_description,Examples),NAMED('vehicle_type_descriptionBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,fuel_code,Examples),NAMED('fuel_codeBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,fuel_description,Examples),NAMED('fuel_descriptionBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,hull_type_code,Examples),NAMED('hull_type_codeBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,hull_type_description,Examples),NAMED('hull_type_descriptionBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,use_code,Examples),NAMED('use_codeBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,use_description,Examples),NAMED('use_descriptionBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,model_year,Examples),NAMED('model_yearBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,watercraft_name,Examples),NAMED('watercraft_nameBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,watercraft_class_code,Examples),NAMED('watercraft_class_codeBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,watercraft_class_description,Examples),NAMED('watercraft_class_descriptionBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,watercraft_make_code,Examples),NAMED('watercraft_make_codeBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,watercraft_make_description,Examples),NAMED('watercraft_make_descriptionBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,watercraft_model_code,Examples),NAMED('watercraft_model_codeBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,watercraft_model_description,Examples),NAMED('watercraft_model_descriptionBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,watercraft_length,Examples),NAMED('watercraft_lengthBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,watercraft_width,Examples),NAMED('watercraft_widthBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,watercraft_weight,Examples),NAMED('watercraft_weightBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,watercraft_color_1_code,Examples),NAMED('watercraft_color_1_codeBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,watercraft_color_1_description,Examples),NAMED('watercraft_color_1_descriptionBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,watercraft_color_2_code,Examples),NAMED('watercraft_color_2_codeBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,watercraft_color_2_description,Examples),NAMED('watercraft_color_2_descriptionBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,watercraft_toilet_code,Examples),NAMED('watercraft_toilet_codeBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,watercraft_toilet_description,Examples),NAMED('watercraft_toilet_descriptionBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,watercraft_number_of_engines,Examples),NAMED('watercraft_number_of_enginesBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,watercraft_hp_1,Examples),NAMED('watercraft_hp_1Bysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,watercraft_hp_2,Examples),NAMED('watercraft_hp_2Bysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,watercraft_hp_3,Examples),NAMED('watercraft_hp_3Bysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,engine_number_1,Examples),NAMED('engine_number_1Bysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,engine_number_2,Examples),NAMED('engine_number_2Bysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,engine_number_3,Examples),NAMED('engine_number_3Bysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,engine_make_1,Examples),NAMED('engine_make_1Bysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,engine_make_2,Examples),NAMED('engine_make_2Bysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,engine_make_3,Examples),NAMED('engine_make_3Bysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,engine_model_1,Examples),NAMED('engine_model_1Bysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,engine_model_2,Examples),NAMED('engine_model_2Bysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,engine_model_3,Examples),NAMED('engine_model_3Bysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,engine_year_1,Examples),NAMED('engine_year_1Bysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,engine_year_2,Examples),NAMED('engine_year_2Bysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,engine_year_3,Examples),NAMED('engine_year_3Bysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,coast_guard_documented_flag,Examples),NAMED('coast_guard_documented_flagBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,coast_guard_number,Examples),NAMED('coast_guard_numberBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,registration_date,Examples),NAMED('registration_dateBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,registration_expiration_date,Examples),NAMED('registration_expiration_dateBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,registration_status_code,Examples),NAMED('registration_status_codeBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,registration_status_description,Examples),NAMED('registration_status_descriptionBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,registration_status_date,Examples),NAMED('registration_status_dateBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,registration_renewal_date,Examples),NAMED('registration_renewal_dateBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,decal_number,Examples),NAMED('decal_numberBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,transaction_type_code,Examples),NAMED('transaction_type_codeBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,transaction_type_description,Examples),NAMED('transaction_type_descriptionBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,title_state,Examples),NAMED('title_stateBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,title_status_code,Examples),NAMED('title_status_codeBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,title_status_description,Examples),NAMED('title_status_descriptionBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,title_number,Examples),NAMED('title_numberBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,title_issue_date,Examples),NAMED('title_issue_dateBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,title_type_code,Examples),NAMED('title_type_codeBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,title_type_description,Examples),NAMED('title_type_descriptionBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,additional_owner_count,Examples),NAMED('additional_owner_countBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,lien_1_indicator,Examples),NAMED('lien_1_indicatorBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,lien_1_name,Examples),NAMED('lien_1_nameBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,lien_1_date,Examples),NAMED('lien_1_dateBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,lien_1_address_1,Examples),NAMED('lien_1_address_1Bysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,lien_1_address_2,Examples),NAMED('lien_1_address_2Bysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,lien_1_city,Examples),NAMED('lien_1_cityBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,lien_1_state,Examples),NAMED('lien_1_stateBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,lien_1_zip,Examples),NAMED('lien_1_zipBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,lien_2_indicator,Examples),NAMED('lien_2_indicatorBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,lien_2_name,Examples),NAMED('lien_2_nameBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,lien_2_date,Examples),NAMED('lien_2_dateBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,lien_2_address_1,Examples),NAMED('lien_2_address_1Bysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,lien_2_address_2,Examples),NAMED('lien_2_address_2Bysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,lien_2_city,Examples),NAMED('lien_2_cityBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,lien_2_state,Examples),NAMED('lien_2_stateBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,lien_2_zip,Examples),NAMED('lien_2_zipBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,state_purchased,Examples),NAMED('state_purchasedBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,purchase_date,Examples),NAMED('purchase_dateBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,dealer,Examples),NAMED('dealerBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,purchase_price,Examples),NAMED('purchase_priceBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,new_used_flag,Examples),NAMED('new_used_flagBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,watercraft_status_code,Examples),NAMED('watercraft_status_codeBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,watercraft_status_description,Examples),NAMED('watercraft_status_descriptionBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,history_flag,Examples),NAMED('history_flagBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,coastguard_flag,Examples),NAMED('coastguard_flagBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,signatory,Examples),NAMED('signatoryBysource_code'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_code,persistent_record_id,Examples),NAMED('persistent_record_idBysource_code'));
