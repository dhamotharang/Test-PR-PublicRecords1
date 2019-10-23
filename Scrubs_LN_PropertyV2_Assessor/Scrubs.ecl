IMPORT SALT311,STD;
IMPORT Scrubs_LN_PropertyV2_Assessor,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
  EXPORT InValidMessage_trans_before_proc(UNSIGNED1 wh) := CHOOSE(wh, 'transfer_date_Invalid', 'process_date_Invalid', 'transfer_date_process_date_Condition_Invalid');
  EXPORT InValidMessage_rec_before_proc(UNSIGNED1 wh) := CHOOSE(wh, 'recording_date_Invalid', 'process_date_Invalid', 'recording_date_process_date_Condition_Invalid');
  EXPORT InValidMessage_sale_before_proc(UNSIGNED1 wh) := CHOOSE(wh, 'sale_date_Invalid', 'process_date_Invalid', 'sale_date_process_date_Condition_Invalid');
  EXPORT InValidMessage_ptrans_before_proc(UNSIGNED1 wh) := CHOOSE(wh, 'prior_transfer_date_Invalid', 'process_date_Invalid', 'prior_transfer_date_process_date_Condition_Invalid');
  EXPORT InValidMessage_prior_rec_before_proc(UNSIGNED1 wh) := CHOOSE(wh, 'prior_recording_date_Invalid', 'process_date_Invalid', 'prior_recording_date_process_date_Condition_Invalid');
  EXPORT InValidMessage_cert_before_proc(UNSIGNED1 wh) := CHOOSE(wh, 'certification_date_Invalid', 'process_date_Invalid', 'certification_date_process_date_Condition_Invalid');
  EXPORT InValidMessage_cut_before_proc(UNSIGNED1 wh) := CHOOSE(wh, 'tape_cut_date_Invalid', 'process_date_Invalid', 'tape_cut_date_process_date_Condition_Invalid');
  EXPORT InValidMessage_AssImp_Eq_AssTot(UNSIGNED1 wh) := CHOOSE(wh, 'assessed_improvement_value_Invalid', 'assessed_total_value_Invalid', 'assessed_improvement_value_assessed_total_value_Condition_Invalid');
  EXPORT InValidMessage_MarImp_Eq_MarTot(UNSIGNED1 wh) := CHOOSE(wh, 'market_improvement_value_Invalid', 'market_total_value_Invalid', 'market_improvement_value_market_total_value_Condition_Invalid');
  EXPORT InValidMessage_AssLnd_Eq_AssTot(UNSIGNED1 wh) := CHOOSE(wh, 'assessed_land_value_Invalid', 'assessed_total_value_Invalid', 'assessed_land_value_assessed_total_value_Condition_Invalid');
  EXPORT InValidMessage_MarLnd_Eq_MarTot(UNSIGNED1 wh) := CHOOSE(wh, 'market_land_value_Invalid', 'market_total_value_Invalid', 'market_land_value_market_total_value_Condition_Invalid');
  EXPORT InValidMessage_tax_less_than_total_assessed(UNSIGNED1 wh) := CHOOSE(wh, 'tax_amount_Invalid', 'assessed_total_value_Invalid', 'tax_amount_assessed_total_value_Condition_Invalid');
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 159;
  EXPORT NumRulesFromFieldType := 123;
  EXPORT NumRulesFromRecordType := 36;
  EXPORT NumFieldsWithRules := 96;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_Property_Assessor)
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 fips_code_Invalid;
    UNSIGNED1 state_code_Invalid;
    UNSIGNED1 county_name_Invalid;
    UNSIGNED1 apna_or_pin_number_Invalid;
    UNSIGNED1 assessee_name_Invalid;
    UNSIGNED1 second_assessee_name_Invalid;
    UNSIGNED1 assessee_ownership_rights_code_Invalid;
    UNSIGNED1 assessee_relationship_code_Invalid;
    UNSIGNED1 assessee_phone_number_Invalid;
    UNSIGNED1 assessee_name_type_code_Invalid;
    UNSIGNED1 second_assessee_name_type_code_Invalid;
    UNSIGNED1 mail_care_of_name_type_code_Invalid;
    UNSIGNED1 mailing_care_of_name_Invalid;
    UNSIGNED1 mailing_full_street_address_Invalid;
    UNSIGNED1 mailing_unit_number_Invalid;
    UNSIGNED1 mailing_city_state_zip_Invalid;
    UNSIGNED1 property_full_street_address_Invalid;
    UNSIGNED1 property_unit_number_Invalid;
    UNSIGNED1 property_city_state_zip_Invalid;
    UNSIGNED1 property_address_code_Invalid;
    UNSIGNED1 legal_lot_code_Invalid;
    UNSIGNED1 record_type_code_Invalid;
    UNSIGNED1 ownership_type_code_Invalid;
    UNSIGNED1 new_record_type_code_Invalid;
    UNSIGNED1 standardized_land_use_code_Invalid;
    UNSIGNED1 transfer_date_Invalid;
    UNSIGNED1 recording_date_Invalid;
    UNSIGNED1 sale_date_Invalid;
    UNSIGNED1 document_type_Invalid;
    UNSIGNED1 sales_price_Invalid;
    UNSIGNED1 sales_price_code_Invalid;
    UNSIGNED1 mortgage_loan_amount_Invalid;
    UNSIGNED1 mortgage_loan_type_code_Invalid;
    UNSIGNED1 mortgage_lender_name_Invalid;
    UNSIGNED1 mortgage_lender_type_code_Invalid;
    UNSIGNED1 prior_transfer_date_Invalid;
    UNSIGNED1 prior_recording_date_Invalid;
    UNSIGNED1 prior_sales_price_Invalid;
    UNSIGNED1 prior_sales_price_code_Invalid;
    UNSIGNED1 assessed_land_value_Invalid;
    UNSIGNED1 assessed_improvement_value_Invalid;
    UNSIGNED1 assessed_total_value_Invalid;
    UNSIGNED1 assessed_value_year_Invalid;
    UNSIGNED1 market_land_value_Invalid;
    UNSIGNED1 market_improvement_value_Invalid;
    UNSIGNED1 market_total_value_Invalid;
    UNSIGNED1 market_value_year_Invalid;
    UNSIGNED1 tax_exemption1_code_Invalid;
    UNSIGNED1 tax_exemption2_code_Invalid;
    UNSIGNED1 tax_exemption3_code_Invalid;
    UNSIGNED1 tax_exemption4_code_Invalid;
    UNSIGNED1 tax_amount_Invalid;
    UNSIGNED1 tax_year_Invalid;
    UNSIGNED1 tax_delinquent_year_Invalid;
    UNSIGNED1 building_area_Invalid;
    UNSIGNED1 building_area_indicator_Invalid;
    UNSIGNED1 building_area1_Invalid;
    UNSIGNED1 building_area1_indicator_Invalid;
    UNSIGNED1 building_area2_Invalid;
    UNSIGNED1 building_area2_indicator_Invalid;
    UNSIGNED1 building_area3_Invalid;
    UNSIGNED1 building_area3_indicator_Invalid;
    UNSIGNED1 building_area4_Invalid;
    UNSIGNED1 building_area4_indicator_Invalid;
    UNSIGNED1 building_area5_Invalid;
    UNSIGNED1 building_area5_indicator_Invalid;
    UNSIGNED1 building_area6_Invalid;
    UNSIGNED1 building_area6_indicator_Invalid;
    UNSIGNED1 building_area7_Invalid;
    UNSIGNED1 building_area7_indicator_Invalid;
    UNSIGNED1 year_built_Invalid;
    UNSIGNED1 effective_year_built_Invalid;
    UNSIGNED1 no_of_stories_Invalid;
    UNSIGNED1 garage_type_code_Invalid;
    UNSIGNED1 pool_code_Invalid;
    UNSIGNED1 type_construction_code_Invalid;
    UNSIGNED1 building_quality_code_Invalid;
    UNSIGNED1 exterior_walls_code_Invalid;
    UNSIGNED1 roof_type_code_Invalid;
    UNSIGNED1 floor_cover_code_Invalid;
    UNSIGNED1 heating_code_Invalid;
    UNSIGNED1 heating_fuel_type_code_Invalid;
    UNSIGNED1 air_conditioning_type_code_Invalid;
    UNSIGNED1 fireplace_indicator_Invalid;
    UNSIGNED1 basement_code_Invalid;
    UNSIGNED1 building_class_code_Invalid;
    UNSIGNED1 site_influence1_code_Invalid;
    UNSIGNED1 amenities1_code_Invalid;
    UNSIGNED1 amenities2_code_Invalid;
    UNSIGNED1 amenities3_code_Invalid;
    UNSIGNED1 amenities4_code_Invalid;
    UNSIGNED1 other_buildings1_code_Invalid;
    UNSIGNED1 tape_cut_date_Invalid;
    UNSIGNED1 certification_date_Invalid;
    UNSIGNED1 fips_Invalid;
    UNSIGNED1 trans_before_proc_Invalid;
    UNSIGNED1 rec_before_proc_Invalid;
    UNSIGNED1 sale_before_proc_Invalid;
    UNSIGNED1 ptrans_before_proc_Invalid;
    UNSIGNED1 prior_rec_before_proc_Invalid;
    UNSIGNED1 cert_before_proc_Invalid;
    UNSIGNED1 cut_before_proc_Invalid;
    UNSIGNED1 AssImp_Eq_AssTot_Invalid;
    UNSIGNED1 MarImp_Eq_MarTot_Invalid;
    UNSIGNED1 AssLnd_Eq_AssTot_Invalid;
    UNSIGNED1 MarLnd_Eq_MarTot_Invalid;
    UNSIGNED1 tax_less_than_total_assessed_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_Property_Assessor)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(Layout_Property_Assessor) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT311.StrType)le.process_date);
    SELF.fips_code_Invalid := Fields.InValid_fips_code((SALT311.StrType)le.fips_code);
    SELF.state_code_Invalid := Fields.InValid_state_code((SALT311.StrType)le.state_code);
    SELF.county_name_Invalid := Fields.InValid_county_name((SALT311.StrType)le.county_name);
    SELF.apna_or_pin_number_Invalid := Fields.InValid_apna_or_pin_number((SALT311.StrType)le.apna_or_pin_number);
    SELF.assessee_name_Invalid := Fields.InValid_assessee_name((SALT311.StrType)le.assessee_name);
    SELF.second_assessee_name_Invalid := Fields.InValid_second_assessee_name((SALT311.StrType)le.second_assessee_name);
    SELF.assessee_ownership_rights_code_Invalid := Fields.InValid_assessee_ownership_rights_code((SALT311.StrType)le.assessee_ownership_rights_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.assessee_relationship_code_Invalid := Fields.InValid_assessee_relationship_code((SALT311.StrType)le.assessee_relationship_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.assessee_phone_number_Invalid := Fields.InValid_assessee_phone_number((SALT311.StrType)le.assessee_phone_number);
    SELF.assessee_name_type_code_Invalid := Fields.InValid_assessee_name_type_code((SALT311.StrType)le.assessee_name_type_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.second_assessee_name_type_code_Invalid := Fields.InValid_second_assessee_name_type_code((SALT311.StrType)le.second_assessee_name_type_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.mail_care_of_name_type_code_Invalid := Fields.InValid_mail_care_of_name_type_code((SALT311.StrType)le.mail_care_of_name_type_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.mailing_care_of_name_Invalid := Fields.InValid_mailing_care_of_name((SALT311.StrType)le.mailing_care_of_name);
    SELF.mailing_full_street_address_Invalid := Fields.InValid_mailing_full_street_address((SALT311.StrType)le.mailing_full_street_address);
    SELF.mailing_unit_number_Invalid := Fields.InValid_mailing_unit_number((SALT311.StrType)le.mailing_unit_number);
    SELF.mailing_city_state_zip_Invalid := Fields.InValid_mailing_city_state_zip((SALT311.StrType)le.mailing_city_state_zip);
    SELF.property_full_street_address_Invalid := Fields.InValid_property_full_street_address((SALT311.StrType)le.property_full_street_address);
    SELF.property_unit_number_Invalid := Fields.InValid_property_unit_number((SALT311.StrType)le.property_unit_number);
    SELF.property_city_state_zip_Invalid := Fields.InValid_property_city_state_zip((SALT311.StrType)le.property_city_state_zip);
    SELF.property_address_code_Invalid := Fields.InValid_property_address_code((SALT311.StrType)le.property_address_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.legal_lot_code_Invalid := Fields.InValid_legal_lot_code((SALT311.StrType)le.legal_lot_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.record_type_code_Invalid := Fields.InValid_record_type_code((SALT311.StrType)le.record_type_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.ownership_type_code_Invalid := Fields.InValid_ownership_type_code((SALT311.StrType)le.ownership_type_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.new_record_type_code_Invalid := Fields.InValid_new_record_type_code((SALT311.StrType)le.new_record_type_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.standardized_land_use_code_Invalid := Fields.InValid_standardized_land_use_code((SALT311.StrType)le.standardized_land_use_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.transfer_date_Invalid := Fields.InValid_transfer_date((SALT311.StrType)le.transfer_date);
    SELF.recording_date_Invalid := Fields.InValid_recording_date((SALT311.StrType)le.recording_date);
    SELF.sale_date_Invalid := Fields.InValid_sale_date((SALT311.StrType)le.sale_date);
    SELF.document_type_Invalid := Fields.InValid_document_type((SALT311.StrType)le.document_type,(SALT311.StrType)le.vendor_source_flag);
    SELF.sales_price_Invalid := Fields.InValid_sales_price((SALT311.StrType)le.sales_price);
    SELF.sales_price_code_Invalid := Fields.InValid_sales_price_code((SALT311.StrType)le.sales_price_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.mortgage_loan_amount_Invalid := Fields.InValid_mortgage_loan_amount((SALT311.StrType)le.mortgage_loan_amount);
    SELF.mortgage_loan_type_code_Invalid := Fields.InValid_mortgage_loan_type_code((SALT311.StrType)le.mortgage_loan_type_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.mortgage_lender_name_Invalid := Fields.InValid_mortgage_lender_name((SALT311.StrType)le.mortgage_lender_name);
    SELF.mortgage_lender_type_code_Invalid := Fields.InValid_mortgage_lender_type_code((SALT311.StrType)le.mortgage_lender_type_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.prior_transfer_date_Invalid := Fields.InValid_prior_transfer_date((SALT311.StrType)le.prior_transfer_date);
    SELF.prior_recording_date_Invalid := Fields.InValid_prior_recording_date((SALT311.StrType)le.prior_recording_date);
    SELF.prior_sales_price_Invalid := Fields.InValid_prior_sales_price((SALT311.StrType)le.prior_sales_price);
    SELF.prior_sales_price_code_Invalid := Fields.InValid_prior_sales_price_code((SALT311.StrType)le.prior_sales_price_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.assessed_land_value_Invalid := Fields.InValid_assessed_land_value((SALT311.StrType)le.assessed_land_value);
    SELF.assessed_improvement_value_Invalid := Fields.InValid_assessed_improvement_value((SALT311.StrType)le.assessed_improvement_value);
    SELF.assessed_total_value_Invalid := Fields.InValid_assessed_total_value((SALT311.StrType)le.assessed_total_value);
    SELF.assessed_value_year_Invalid := Fields.InValid_assessed_value_year((SALT311.StrType)le.assessed_value_year);
    SELF.market_land_value_Invalid := Fields.InValid_market_land_value((SALT311.StrType)le.market_land_value);
    SELF.market_improvement_value_Invalid := Fields.InValid_market_improvement_value((SALT311.StrType)le.market_improvement_value);
    SELF.market_total_value_Invalid := Fields.InValid_market_total_value((SALT311.StrType)le.market_total_value);
    SELF.market_value_year_Invalid := Fields.InValid_market_value_year((SALT311.StrType)le.market_value_year);
    SELF.tax_exemption1_code_Invalid := Fields.InValid_tax_exemption1_code((SALT311.StrType)le.tax_exemption1_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.tax_exemption2_code_Invalid := Fields.InValid_tax_exemption2_code((SALT311.StrType)le.tax_exemption2_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.tax_exemption3_code_Invalid := Fields.InValid_tax_exemption3_code((SALT311.StrType)le.tax_exemption3_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.tax_exemption4_code_Invalid := Fields.InValid_tax_exemption4_code((SALT311.StrType)le.tax_exemption4_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.tax_amount_Invalid := Fields.InValid_tax_amount((SALT311.StrType)le.tax_amount);
    SELF.tax_year_Invalid := Fields.InValid_tax_year((SALT311.StrType)le.tax_year);
    SELF.tax_delinquent_year_Invalid := Fields.InValid_tax_delinquent_year((SALT311.StrType)le.tax_delinquent_year);
    SELF.building_area_Invalid := Fields.InValid_building_area((SALT311.StrType)le.building_area,(SALT311.StrType)le.sales_price);
    SELF.building_area_indicator_Invalid := Fields.InValid_building_area_indicator((SALT311.StrType)le.building_area_indicator,(SALT311.StrType)le.vendor_source_flag);
    SELF.building_area1_Invalid := Fields.InValid_building_area1((SALT311.StrType)le.building_area1,(SALT311.StrType)le.sales_price);
    SELF.building_area1_indicator_Invalid := Fields.InValid_building_area1_indicator((SALT311.StrType)le.building_area1_indicator,(SALT311.StrType)le.vendor_source_flag);
    SELF.building_area2_Invalid := Fields.InValid_building_area2((SALT311.StrType)le.building_area2,(SALT311.StrType)le.sales_price);
    SELF.building_area2_indicator_Invalid := Fields.InValid_building_area2_indicator((SALT311.StrType)le.building_area2_indicator,(SALT311.StrType)le.vendor_source_flag);
    SELF.building_area3_Invalid := Fields.InValid_building_area3((SALT311.StrType)le.building_area3,(SALT311.StrType)le.sales_price);
    SELF.building_area3_indicator_Invalid := Fields.InValid_building_area3_indicator((SALT311.StrType)le.building_area3_indicator,(SALT311.StrType)le.vendor_source_flag);
    SELF.building_area4_Invalid := Fields.InValid_building_area4((SALT311.StrType)le.building_area4,(SALT311.StrType)le.sales_price);
    SELF.building_area4_indicator_Invalid := Fields.InValid_building_area4_indicator((SALT311.StrType)le.building_area4_indicator,(SALT311.StrType)le.vendor_source_flag);
    SELF.building_area5_Invalid := Fields.InValid_building_area5((SALT311.StrType)le.building_area5,(SALT311.StrType)le.sales_price);
    SELF.building_area5_indicator_Invalid := Fields.InValid_building_area5_indicator((SALT311.StrType)le.building_area5_indicator,(SALT311.StrType)le.vendor_source_flag);
    SELF.building_area6_Invalid := Fields.InValid_building_area6((SALT311.StrType)le.building_area6,(SALT311.StrType)le.sales_price);
    SELF.building_area6_indicator_Invalid := Fields.InValid_building_area6_indicator((SALT311.StrType)le.building_area6_indicator,(SALT311.StrType)le.vendor_source_flag);
    SELF.building_area7_Invalid := Fields.InValid_building_area7((SALT311.StrType)le.building_area7,(SALT311.StrType)le.sales_price);
    SELF.building_area7_indicator_Invalid := Fields.InValid_building_area7_indicator((SALT311.StrType)le.building_area7_indicator,(SALT311.StrType)le.vendor_source_flag);
    SELF.year_built_Invalid := Fields.InValid_year_built((SALT311.StrType)le.year_built);
    SELF.effective_year_built_Invalid := Fields.InValid_effective_year_built((SALT311.StrType)le.effective_year_built);
    SELF.no_of_stories_Invalid := Fields.InValid_no_of_stories((SALT311.StrType)le.no_of_stories);
    SELF.garage_type_code_Invalid := Fields.InValid_garage_type_code((SALT311.StrType)le.garage_type_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.pool_code_Invalid := Fields.InValid_pool_code((SALT311.StrType)le.pool_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.type_construction_code_Invalid := Fields.InValid_type_construction_code((SALT311.StrType)le.type_construction_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.building_quality_code_Invalid := Fields.InValid_building_quality_code((SALT311.StrType)le.building_quality_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.exterior_walls_code_Invalid := Fields.InValid_exterior_walls_code((SALT311.StrType)le.exterior_walls_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.roof_type_code_Invalid := Fields.InValid_roof_type_code((SALT311.StrType)le.roof_type_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.floor_cover_code_Invalid := Fields.InValid_floor_cover_code((SALT311.StrType)le.floor_cover_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.heating_code_Invalid := Fields.InValid_heating_code((SALT311.StrType)le.heating_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.heating_fuel_type_code_Invalid := Fields.InValid_heating_fuel_type_code((SALT311.StrType)le.heating_fuel_type_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.air_conditioning_type_code_Invalid := Fields.InValid_air_conditioning_type_code((SALT311.StrType)le.air_conditioning_type_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.fireplace_indicator_Invalid := Fields.InValid_fireplace_indicator((SALT311.StrType)le.fireplace_indicator,(SALT311.StrType)le.vendor_source_flag);
    SELF.basement_code_Invalid := Fields.InValid_basement_code((SALT311.StrType)le.basement_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.building_class_code_Invalid := Fields.InValid_building_class_code((SALT311.StrType)le.building_class_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.site_influence1_code_Invalid := Fields.InValid_site_influence1_code((SALT311.StrType)le.site_influence1_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.amenities1_code_Invalid := Fields.InValid_amenities1_code((SALT311.StrType)le.amenities1_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.amenities2_code_Invalid := Fields.InValid_amenities2_code((SALT311.StrType)le.amenities2_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.amenities3_code_Invalid := Fields.InValid_amenities3_code((SALT311.StrType)le.amenities3_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.amenities4_code_Invalid := Fields.InValid_amenities4_code((SALT311.StrType)le.amenities4_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.other_buildings1_code_Invalid := Fields.InValid_other_buildings1_code((SALT311.StrType)le.other_buildings1_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.tape_cut_date_Invalid := Fields.InValid_tape_cut_date((SALT311.StrType)le.tape_cut_date);
    SELF.certification_date_Invalid := Fields.InValid_certification_date((SALT311.StrType)le.certification_date);
    SELF.fips_Invalid := Fields.InValid_fips((SALT311.StrType)le.fips);
    SELF.trans_before_proc_Invalid := WHICH(Fields.InValid_transfer_date((SALT311.StrType)le.transfer_date)>0, Fields.InValid_process_date((SALT311.StrType)le.process_date)>0, NOT(le.transfer_date < le.process_date));
    SELF.rec_before_proc_Invalid := WHICH(Fields.InValid_recording_date((SALT311.StrType)le.recording_date)>0, Fields.InValid_process_date((SALT311.StrType)le.process_date)>0, NOT(le.recording_date < le.process_date));
    SELF.sale_before_proc_Invalid := WHICH(Fields.InValid_sale_date((SALT311.StrType)le.sale_date)>0, Fields.InValid_process_date((SALT311.StrType)le.process_date)>0, NOT(le.sale_date < le.process_date));
    SELF.ptrans_before_proc_Invalid := WHICH(Fields.InValid_prior_transfer_date((SALT311.StrType)le.prior_transfer_date)>0, Fields.InValid_process_date((SALT311.StrType)le.process_date)>0, NOT(le.prior_transfer_date < le.process_date));
    SELF.prior_rec_before_proc_Invalid := WHICH(Fields.InValid_prior_recording_date((SALT311.StrType)le.prior_recording_date)>0, Fields.InValid_process_date((SALT311.StrType)le.process_date)>0, NOT(le.prior_recording_date < le.process_date));
    SELF.cert_before_proc_Invalid := WHICH(Fields.InValid_certification_date((SALT311.StrType)le.certification_date)>0, Fields.InValid_process_date((SALT311.StrType)le.process_date)>0, NOT(le.certification_date < le.process_date));
    SELF.cut_before_proc_Invalid := WHICH(Fields.InValid_tape_cut_date((SALT311.StrType)le.tape_cut_date)>0, Fields.InValid_process_date((SALT311.StrType)le.process_date)>0, NOT(le.tape_cut_date < le.process_date));
    SELF.AssImp_Eq_AssTot_Invalid := WHICH(Fields.InValid_assessed_improvement_value((SALT311.StrType)le.assessed_improvement_value)>0, Fields.InValid_assessed_total_value((SALT311.StrType)le.assessed_total_value)>0, NOT(le.assessed_improvement_value < le.assessed_total_value));
    SELF.MarImp_Eq_MarTot_Invalid := WHICH(Fields.InValid_market_improvement_value((SALT311.StrType)le.market_improvement_value)>0, Fields.InValid_market_total_value((SALT311.StrType)le.market_total_value)>0, NOT(le.market_improvement_value < le.market_total_value));
    SELF.AssLnd_Eq_AssTot_Invalid := WHICH(Fields.InValid_assessed_land_value((SALT311.StrType)le.assessed_land_value)>0, Fields.InValid_assessed_total_value((SALT311.StrType)le.assessed_total_value)>0, NOT(le.assessed_land_value <= le.assessed_total_value));
    SELF.MarLnd_Eq_MarTot_Invalid := WHICH(Fields.InValid_market_land_value((SALT311.StrType)le.market_land_value)>0, Fields.InValid_market_total_value((SALT311.StrType)le.market_total_value)>0, NOT(le.market_land_value <= le.market_total_value));
    SELF.tax_less_than_total_assessed_Invalid := IF( ((SALT311.StrType)le.assessed_total_value = ''), WHICH(Fields.InValid_tax_amount((SALT311.StrType)le.tax_amount)>0, Fields.InValid_assessed_total_value((SALT311.StrType)le.assessed_total_value)>0, NOT(le.tax_amount <= le.assessed_total_value)), 0);
    SELF := le;
  END;
  EXPORT ExpandedInfile0 := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT WithinList1 := DEDUP(SORT(TABLE(Scrubs_LN_PropertyV2_Assessor.file_fips,{fips_code}),fips_code),ALL) : PERSIST('~temp::Scrubs_LN_PropertyV2_Assessor::Scrubs_LN_PropertyV2_Assessor.file_fips::fips_code',EXPIRE(Scrubs_LN_PropertyV2_Assessor.Config.PersistExpire));
  EXPORT ExpandedInfile1 := JOIN(ExpandedInfile0, WithinList1, LEFT.fips_code=RIGHT.fips_code AND LEFT.fips_code_Invalid=0, TRANSFORM(Expanded_Layout, SELF.fips_code_Invalid:=MAP(RIGHT.fips_code<>''=>0,LEFT.fips_code_Invalid>0=>LEFT.fips_code_Invalid,3),SELF:=LEFT),LEFT OUTER, SMART);
  EXPORT WithinList2 := DEDUP(SORT(TABLE(Scrubs_LN_PropertyV2_Assessor.file_fips,{fips_code}),fips_code),ALL) : PERSIST('~temp::Scrubs_LN_PropertyV2_Assessor::Scrubs_LN_PropertyV2_Assessor.file_fips::fips_code',EXPIRE(Scrubs_LN_PropertyV2_Assessor.Config.PersistExpire));
  EXPORT ExpandedInfile2 := JOIN(ExpandedInfile1, WithinList2, LEFT.fips=RIGHT.fips_code AND LEFT.fips_Invalid=0, TRANSFORM(Expanded_Layout, SELF.fips_Invalid:=MAP(RIGHT.fips_code<>''=>0,LEFT.fips_Invalid>0=>LEFT.fips_Invalid,3),SELF:=LEFT),LEFT OUTER, SMART);
  EXPORT ExpandedInfile := ExpandedInfile2;
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_Property_Assessor);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.process_date_Invalid << 0 ) + ( le.fips_code_Invalid << 2 ) + ( le.state_code_Invalid << 4 ) + ( le.county_name_Invalid << 6 ) + ( le.apna_or_pin_number_Invalid << 8 ) + ( le.assessee_name_Invalid << 10 ) + ( le.second_assessee_name_Invalid << 11 ) + ( le.assessee_ownership_rights_code_Invalid << 12 ) + ( le.assessee_relationship_code_Invalid << 13 ) + ( le.assessee_phone_number_Invalid << 14 ) + ( le.assessee_name_type_code_Invalid << 16 ) + ( le.second_assessee_name_type_code_Invalid << 17 ) + ( le.mail_care_of_name_type_code_Invalid << 18 ) + ( le.mailing_care_of_name_Invalid << 19 ) + ( le.mailing_full_street_address_Invalid << 20 ) + ( le.mailing_unit_number_Invalid << 21 ) + ( le.mailing_city_state_zip_Invalid << 22 ) + ( le.property_full_street_address_Invalid << 23 ) + ( le.property_unit_number_Invalid << 24 ) + ( le.property_city_state_zip_Invalid << 25 ) + ( le.property_address_code_Invalid << 26 ) + ( le.legal_lot_code_Invalid << 27 ) + ( le.record_type_code_Invalid << 28 ) + ( le.ownership_type_code_Invalid << 29 ) + ( le.new_record_type_code_Invalid << 30 ) + ( le.standardized_land_use_code_Invalid << 31 ) + ( le.transfer_date_Invalid << 32 ) + ( le.recording_date_Invalid << 34 ) + ( le.sale_date_Invalid << 36 ) + ( le.document_type_Invalid << 38 ) + ( le.sales_price_Invalid << 40 ) + ( le.sales_price_code_Invalid << 41 ) + ( le.mortgage_loan_amount_Invalid << 42 ) + ( le.mortgage_loan_type_code_Invalid << 43 ) + ( le.mortgage_lender_name_Invalid << 44 ) + ( le.mortgage_lender_type_code_Invalid << 45 ) + ( le.prior_transfer_date_Invalid << 46 ) + ( le.prior_recording_date_Invalid << 48 ) + ( le.prior_sales_price_Invalid << 50 ) + ( le.prior_sales_price_code_Invalid << 51 ) + ( le.assessed_land_value_Invalid << 52 ) + ( le.assessed_improvement_value_Invalid << 53 ) + ( le.assessed_total_value_Invalid << 54 ) + ( le.assessed_value_year_Invalid << 55 ) + ( le.market_land_value_Invalid << 56 ) + ( le.market_improvement_value_Invalid << 57 ) + ( le.market_total_value_Invalid << 58 ) + ( le.market_value_year_Invalid << 59 ) + ( le.tax_exemption1_code_Invalid << 60 ) + ( le.tax_exemption2_code_Invalid << 61 ) + ( le.tax_exemption3_code_Invalid << 62 ) + ( le.tax_exemption4_code_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.tax_amount_Invalid << 0 ) + ( le.tax_year_Invalid << 1 ) + ( le.tax_delinquent_year_Invalid << 2 ) + ( le.building_area_Invalid << 3 ) + ( le.building_area_indicator_Invalid << 4 ) + ( le.building_area1_Invalid << 5 ) + ( le.building_area1_indicator_Invalid << 6 ) + ( le.building_area2_Invalid << 7 ) + ( le.building_area2_indicator_Invalid << 8 ) + ( le.building_area3_Invalid << 9 ) + ( le.building_area3_indicator_Invalid << 10 ) + ( le.building_area4_Invalid << 11 ) + ( le.building_area4_indicator_Invalid << 12 ) + ( le.building_area5_Invalid << 13 ) + ( le.building_area5_indicator_Invalid << 14 ) + ( le.building_area6_Invalid << 15 ) + ( le.building_area6_indicator_Invalid << 16 ) + ( le.building_area7_Invalid << 17 ) + ( le.building_area7_indicator_Invalid << 18 ) + ( le.year_built_Invalid << 19 ) + ( le.effective_year_built_Invalid << 20 ) + ( le.no_of_stories_Invalid << 21 ) + ( le.garage_type_code_Invalid << 23 ) + ( le.pool_code_Invalid << 24 ) + ( le.type_construction_code_Invalid << 25 ) + ( le.building_quality_code_Invalid << 26 ) + ( le.exterior_walls_code_Invalid << 27 ) + ( le.roof_type_code_Invalid << 28 ) + ( le.floor_cover_code_Invalid << 29 ) + ( le.heating_code_Invalid << 30 ) + ( le.heating_fuel_type_code_Invalid << 31 ) + ( le.air_conditioning_type_code_Invalid << 32 ) + ( le.fireplace_indicator_Invalid << 33 ) + ( le.basement_code_Invalid << 34 ) + ( le.building_class_code_Invalid << 35 ) + ( le.site_influence1_code_Invalid << 36 ) + ( le.amenities1_code_Invalid << 37 ) + ( le.amenities2_code_Invalid << 38 ) + ( le.amenities3_code_Invalid << 39 ) + ( le.amenities4_code_Invalid << 40 ) + ( le.other_buildings1_code_Invalid << 41 ) + ( le.tape_cut_date_Invalid << 42 ) + ( le.certification_date_Invalid << 44 ) + ( le.fips_Invalid << 46 ) + ( le.MarImp_Eq_MarTot_Invalid << 0 ) + ( le.AssLnd_Eq_AssTot_Invalid << 2 ) + ( le.MarLnd_Eq_MarTot_Invalid << 4 ) + ( le.tax_less_than_total_assessed_Invalid << 6 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_Property_Assessor);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.fips_code_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.state_code_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.county_name_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.apna_or_pin_number_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.assessee_name_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.second_assessee_name_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.assessee_ownership_rights_code_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.assessee_relationship_code_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.assessee_phone_number_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.assessee_name_type_code_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.second_assessee_name_type_code_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.mail_care_of_name_type_code_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.mailing_care_of_name_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.mailing_full_street_address_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.mailing_unit_number_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.mailing_city_state_zip_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.property_full_street_address_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.property_unit_number_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.property_city_state_zip_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.property_address_code_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.legal_lot_code_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.record_type_code_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.ownership_type_code_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.new_record_type_code_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.standardized_land_use_code_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.transfer_date_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.recording_date_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.sale_date_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.document_type_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.sales_price_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.sales_price_code_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.mortgage_loan_amount_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.mortgage_loan_type_code_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.mortgage_lender_name_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.mortgage_lender_type_code_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.prior_transfer_date_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF.prior_recording_date_Invalid := (le.ScrubsBits1 >> 48) & 3;
    SELF.prior_sales_price_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.prior_sales_price_code_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.assessed_land_value_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.assessed_improvement_value_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.assessed_total_value_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.assessed_value_year_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.market_land_value_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.market_improvement_value_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.market_total_value_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.market_value_year_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.tax_exemption1_code_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.tax_exemption2_code_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.tax_exemption3_code_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.tax_exemption4_code_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.tax_amount_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.tax_year_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.tax_delinquent_year_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.building_area_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.building_area_indicator_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.building_area1_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.building_area1_indicator_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.building_area2_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.building_area2_indicator_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.building_area3_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.building_area3_indicator_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.building_area4_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.building_area4_indicator_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.building_area5_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.building_area5_indicator_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.building_area6_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.building_area6_indicator_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.building_area7_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.building_area7_indicator_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.year_built_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.effective_year_built_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.no_of_stories_Invalid := (le.ScrubsBits2 >> 21) & 3;
    SELF.garage_type_code_Invalid := (le.ScrubsBits2 >> 23) & 1;
    SELF.pool_code_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.type_construction_code_Invalid := (le.ScrubsBits2 >> 25) & 1;
    SELF.building_quality_code_Invalid := (le.ScrubsBits2 >> 26) & 1;
    SELF.exterior_walls_code_Invalid := (le.ScrubsBits2 >> 27) & 1;
    SELF.roof_type_code_Invalid := (le.ScrubsBits2 >> 28) & 1;
    SELF.floor_cover_code_Invalid := (le.ScrubsBits2 >> 29) & 1;
    SELF.heating_code_Invalid := (le.ScrubsBits2 >> 30) & 1;
    SELF.heating_fuel_type_code_Invalid := (le.ScrubsBits2 >> 31) & 1;
    SELF.air_conditioning_type_code_Invalid := (le.ScrubsBits2 >> 32) & 1;
    SELF.fireplace_indicator_Invalid := (le.ScrubsBits2 >> 33) & 1;
    SELF.basement_code_Invalid := (le.ScrubsBits2 >> 34) & 1;
    SELF.building_class_code_Invalid := (le.ScrubsBits2 >> 35) & 1;
    SELF.site_influence1_code_Invalid := (le.ScrubsBits2 >> 36) & 1;
    SELF.amenities1_code_Invalid := (le.ScrubsBits2 >> 37) & 1;
    SELF.amenities2_code_Invalid := (le.ScrubsBits2 >> 38) & 1;
    SELF.amenities3_code_Invalid := (le.ScrubsBits2 >> 39) & 1;
    SELF.amenities4_code_Invalid := (le.ScrubsBits2 >> 40) & 1;
    SELF.other_buildings1_code_Invalid := (le.ScrubsBits2 >> 41) & 1;
    SELF.tape_cut_date_Invalid := (le.ScrubsBits2 >> 42) & 3;
    SELF.certification_date_Invalid := (le.ScrubsBits2 >> 44) & 3;
    SELF.fips_Invalid := (le.ScrubsBits2 >> 46) & 3;
    SELF.trans_before_proc_Invalid := (le.ScrubsBits1 >> 48) & 3;
    SELF.rec_before_proc_Invalid := (le.ScrubsBits1 >> 50) & 3;
    SELF.sale_before_proc_Invalid := (le.ScrubsBits1 >> 52) & 3;
    SELF.ptrans_before_proc_Invalid := (le.ScrubsBits1 >> 54) & 3;
    SELF.prior_rec_before_proc_Invalid := (le.ScrubsBits1 >> 56) & 3;
    SELF.cert_before_proc_Invalid := (le.ScrubsBits1 >> 58) & 3;
    SELF.cut_before_proc_Invalid := (le.ScrubsBits1 >> 60) & 3;
    SELF.AssImp_Eq_AssTot_Invalid := (le.ScrubsBits1 >> 62) & 3;
    SELF.MarImp_Eq_MarTot_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.AssLnd_Eq_AssTot_Invalid := (le.ScrubsBits2 >> 2) & 3;
    SELF.MarLnd_Eq_MarTot_Invalid := (le.ScrubsBits2 >> 4) & 3;
    SELF.tax_less_than_total_assessed_Invalid := (le.ScrubsBits2 >> 6) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h, BOOLEAN Glob = FALSE) := MODULE
  r := RECORD
    TYPEOF(h.fips_code) fips_code := IF(Glob, '', h.fips_code);
    TotalCnt := COUNT(GROUP); // Number of records in total
    process_date_ALLOW_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=2);
    process_date_LENGTHS_ErrorCount := COUNT(GROUP,h.process_date_Invalid=3);
    process_date_Total_ErrorCount := COUNT(GROUP,h.process_date_Invalid>0);
    fips_code_ALLOW_ErrorCount := COUNT(GROUP,h.fips_code_Invalid=1);
    fips_code_LENGTHS_ErrorCount := COUNT(GROUP,h.fips_code_Invalid=2);
    fips_code_WITHIN_FILE_ErrorCount := COUNT(GROUP,h.fips_code_Invalid=3);
    fips_code_Total_ErrorCount := COUNT(GROUP,h.fips_code_Invalid>0);
    state_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.state_code_Invalid=1);
    state_code_ALLOW_ErrorCount := COUNT(GROUP,h.state_code_Invalid=2);
    state_code_LENGTHS_ErrorCount := COUNT(GROUP,h.state_code_Invalid=3);
    state_code_Total_ErrorCount := COUNT(GROUP,h.state_code_Invalid>0);
    county_name_ALLOW_ErrorCount := COUNT(GROUP,h.county_name_Invalid=1);
    county_name_WORDS_ErrorCount := COUNT(GROUP,h.county_name_Invalid=2);
    county_name_Total_ErrorCount := COUNT(GROUP,h.county_name_Invalid>0);
    apna_or_pin_number_ALLOW_ErrorCount := COUNT(GROUP,h.apna_or_pin_number_Invalid=1);
    apna_or_pin_number_LENGTHS_ErrorCount := COUNT(GROUP,h.apna_or_pin_number_Invalid=2);
    apna_or_pin_number_Total_ErrorCount := COUNT(GROUP,h.apna_or_pin_number_Invalid>0);
    assessee_name_ALLOW_ErrorCount := COUNT(GROUP,h.assessee_name_Invalid=1);
    second_assessee_name_ALLOW_ErrorCount := COUNT(GROUP,h.second_assessee_name_Invalid=1);
    assessee_ownership_rights_code_CUSTOM_ErrorCount := COUNT(GROUP,h.assessee_ownership_rights_code_Invalid=1);
    assessee_relationship_code_CUSTOM_ErrorCount := COUNT(GROUP,h.assessee_relationship_code_Invalid=1);
    assessee_phone_number_ALLOW_ErrorCount := COUNT(GROUP,h.assessee_phone_number_Invalid=1);
    assessee_phone_number_LENGTHS_ErrorCount := COUNT(GROUP,h.assessee_phone_number_Invalid=2);
    assessee_phone_number_Total_ErrorCount := COUNT(GROUP,h.assessee_phone_number_Invalid>0);
    assessee_name_type_code_CUSTOM_ErrorCount := COUNT(GROUP,h.assessee_name_type_code_Invalid=1);
    second_assessee_name_type_code_CUSTOM_ErrorCount := COUNT(GROUP,h.second_assessee_name_type_code_Invalid=1);
    mail_care_of_name_type_code_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_care_of_name_type_code_Invalid=1);
    mailing_care_of_name_ALLOW_ErrorCount := COUNT(GROUP,h.mailing_care_of_name_Invalid=1);
    mailing_full_street_address_ALLOW_ErrorCount := COUNT(GROUP,h.mailing_full_street_address_Invalid=1);
    mailing_unit_number_ALLOW_ErrorCount := COUNT(GROUP,h.mailing_unit_number_Invalid=1);
    mailing_city_state_zip_ALLOW_ErrorCount := COUNT(GROUP,h.mailing_city_state_zip_Invalid=1);
    property_full_street_address_ALLOW_ErrorCount := COUNT(GROUP,h.property_full_street_address_Invalid=1);
    property_unit_number_ALLOW_ErrorCount := COUNT(GROUP,h.property_unit_number_Invalid=1);
    property_city_state_zip_ALLOW_ErrorCount := COUNT(GROUP,h.property_city_state_zip_Invalid=1);
    property_address_code_CUSTOM_ErrorCount := COUNT(GROUP,h.property_address_code_Invalid=1);
    legal_lot_code_CUSTOM_ErrorCount := COUNT(GROUP,h.legal_lot_code_Invalid=1);
    record_type_code_CUSTOM_ErrorCount := COUNT(GROUP,h.record_type_code_Invalid=1);
    ownership_type_code_CUSTOM_ErrorCount := COUNT(GROUP,h.ownership_type_code_Invalid=1);
    new_record_type_code_CUSTOM_ErrorCount := COUNT(GROUP,h.new_record_type_code_Invalid=1);
    standardized_land_use_code_CUSTOM_ErrorCount := COUNT(GROUP,h.standardized_land_use_code_Invalid=1);
    transfer_date_ALLOW_ErrorCount := COUNT(GROUP,h.transfer_date_Invalid=1);
    transfer_date_CUSTOM_ErrorCount := COUNT(GROUP,h.transfer_date_Invalid=2);
    transfer_date_LENGTHS_ErrorCount := COUNT(GROUP,h.transfer_date_Invalid=3);
    transfer_date_Total_ErrorCount := COUNT(GROUP,h.transfer_date_Invalid>0);
    recording_date_ALLOW_ErrorCount := COUNT(GROUP,h.recording_date_Invalid=1);
    recording_date_CUSTOM_ErrorCount := COUNT(GROUP,h.recording_date_Invalid=2);
    recording_date_LENGTHS_ErrorCount := COUNT(GROUP,h.recording_date_Invalid=3);
    recording_date_Total_ErrorCount := COUNT(GROUP,h.recording_date_Invalid>0);
    sale_date_ALLOW_ErrorCount := COUNT(GROUP,h.sale_date_Invalid=1);
    sale_date_CUSTOM_ErrorCount := COUNT(GROUP,h.sale_date_Invalid=2);
    sale_date_LENGTHS_ErrorCount := COUNT(GROUP,h.sale_date_Invalid=3);
    sale_date_Total_ErrorCount := COUNT(GROUP,h.sale_date_Invalid>0);
    document_type_ALLOW_ErrorCount := COUNT(GROUP,h.document_type_Invalid=1);
    document_type_CUSTOM_ErrorCount := COUNT(GROUP,h.document_type_Invalid=2);
    document_type_Total_ErrorCount := COUNT(GROUP,h.document_type_Invalid>0);
    sales_price_ALLOW_ErrorCount := COUNT(GROUP,h.sales_price_Invalid=1);
    sales_price_code_CUSTOM_ErrorCount := COUNT(GROUP,h.sales_price_code_Invalid=1);
    mortgage_loan_amount_ALLOW_ErrorCount := COUNT(GROUP,h.mortgage_loan_amount_Invalid=1);
    mortgage_loan_type_code_CUSTOM_ErrorCount := COUNT(GROUP,h.mortgage_loan_type_code_Invalid=1);
    mortgage_lender_name_ALLOW_ErrorCount := COUNT(GROUP,h.mortgage_lender_name_Invalid=1);
    mortgage_lender_type_code_CUSTOM_ErrorCount := COUNT(GROUP,h.mortgage_lender_type_code_Invalid=1);
    prior_transfer_date_ALLOW_ErrorCount := COUNT(GROUP,h.prior_transfer_date_Invalid=1);
    prior_transfer_date_CUSTOM_ErrorCount := COUNT(GROUP,h.prior_transfer_date_Invalid=2);
    prior_transfer_date_LENGTHS_ErrorCount := COUNT(GROUP,h.prior_transfer_date_Invalid=3);
    prior_transfer_date_Total_ErrorCount := COUNT(GROUP,h.prior_transfer_date_Invalid>0);
    prior_recording_date_ALLOW_ErrorCount := COUNT(GROUP,h.prior_recording_date_Invalid=1);
    prior_recording_date_CUSTOM_ErrorCount := COUNT(GROUP,h.prior_recording_date_Invalid=2);
    prior_recording_date_LENGTHS_ErrorCount := COUNT(GROUP,h.prior_recording_date_Invalid=3);
    prior_recording_date_Total_ErrorCount := COUNT(GROUP,h.prior_recording_date_Invalid>0);
    prior_sales_price_ALLOW_ErrorCount := COUNT(GROUP,h.prior_sales_price_Invalid=1);
    prior_sales_price_code_CUSTOM_ErrorCount := COUNT(GROUP,h.prior_sales_price_code_Invalid=1);
    assessed_land_value_ALLOW_ErrorCount := COUNT(GROUP,h.assessed_land_value_Invalid=1);
    assessed_improvement_value_ALLOW_ErrorCount := COUNT(GROUP,h.assessed_improvement_value_Invalid=1);
    assessed_total_value_ALLOW_ErrorCount := COUNT(GROUP,h.assessed_total_value_Invalid=1);
    assessed_value_year_CUSTOM_ErrorCount := COUNT(GROUP,h.assessed_value_year_Invalid=1);
    market_land_value_ALLOW_ErrorCount := COUNT(GROUP,h.market_land_value_Invalid=1);
    market_improvement_value_ALLOW_ErrorCount := COUNT(GROUP,h.market_improvement_value_Invalid=1);
    market_total_value_ALLOW_ErrorCount := COUNT(GROUP,h.market_total_value_Invalid=1);
    market_value_year_CUSTOM_ErrorCount := COUNT(GROUP,h.market_value_year_Invalid=1);
    tax_exemption1_code_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_exemption1_code_Invalid=1);
    tax_exemption2_code_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_exemption2_code_Invalid=1);
    tax_exemption3_code_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_exemption3_code_Invalid=1);
    tax_exemption4_code_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_exemption4_code_Invalid=1);
    tax_amount_ALLOW_ErrorCount := COUNT(GROUP,h.tax_amount_Invalid=1);
    tax_year_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_year_Invalid=1);
    tax_delinquent_year_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_delinquent_year_Invalid=1);
    building_area_CUSTOM_ErrorCount := COUNT(GROUP,h.building_area_Invalid=1);
    building_area_indicator_CUSTOM_ErrorCount := COUNT(GROUP,h.building_area_indicator_Invalid=1);
    building_area1_CUSTOM_ErrorCount := COUNT(GROUP,h.building_area1_Invalid=1);
    building_area1_indicator_CUSTOM_ErrorCount := COUNT(GROUP,h.building_area1_indicator_Invalid=1);
    building_area2_CUSTOM_ErrorCount := COUNT(GROUP,h.building_area2_Invalid=1);
    building_area2_indicator_CUSTOM_ErrorCount := COUNT(GROUP,h.building_area2_indicator_Invalid=1);
    building_area3_CUSTOM_ErrorCount := COUNT(GROUP,h.building_area3_Invalid=1);
    building_area3_indicator_CUSTOM_ErrorCount := COUNT(GROUP,h.building_area3_indicator_Invalid=1);
    building_area4_CUSTOM_ErrorCount := COUNT(GROUP,h.building_area4_Invalid=1);
    building_area4_indicator_CUSTOM_ErrorCount := COUNT(GROUP,h.building_area4_indicator_Invalid=1);
    building_area5_CUSTOM_ErrorCount := COUNT(GROUP,h.building_area5_Invalid=1);
    building_area5_indicator_CUSTOM_ErrorCount := COUNT(GROUP,h.building_area5_indicator_Invalid=1);
    building_area6_CUSTOM_ErrorCount := COUNT(GROUP,h.building_area6_Invalid=1);
    building_area6_indicator_CUSTOM_ErrorCount := COUNT(GROUP,h.building_area6_indicator_Invalid=1);
    building_area7_CUSTOM_ErrorCount := COUNT(GROUP,h.building_area7_Invalid=1);
    building_area7_indicator_CUSTOM_ErrorCount := COUNT(GROUP,h.building_area7_indicator_Invalid=1);
    year_built_CUSTOM_ErrorCount := COUNT(GROUP,h.year_built_Invalid=1);
    effective_year_built_CUSTOM_ErrorCount := COUNT(GROUP,h.effective_year_built_Invalid=1);
    no_of_stories_ALLOW_ErrorCount := COUNT(GROUP,h.no_of_stories_Invalid=1);
    no_of_stories_LENGTHS_ErrorCount := COUNT(GROUP,h.no_of_stories_Invalid=2);
    no_of_stories_Total_ErrorCount := COUNT(GROUP,h.no_of_stories_Invalid>0);
    garage_type_code_CUSTOM_ErrorCount := COUNT(GROUP,h.garage_type_code_Invalid=1);
    pool_code_CUSTOM_ErrorCount := COUNT(GROUP,h.pool_code_Invalid=1);
    type_construction_code_CUSTOM_ErrorCount := COUNT(GROUP,h.type_construction_code_Invalid=1);
    building_quality_code_CUSTOM_ErrorCount := COUNT(GROUP,h.building_quality_code_Invalid=1);
    exterior_walls_code_CUSTOM_ErrorCount := COUNT(GROUP,h.exterior_walls_code_Invalid=1);
    roof_type_code_CUSTOM_ErrorCount := COUNT(GROUP,h.roof_type_code_Invalid=1);
    floor_cover_code_CUSTOM_ErrorCount := COUNT(GROUP,h.floor_cover_code_Invalid=1);
    heating_code_CUSTOM_ErrorCount := COUNT(GROUP,h.heating_code_Invalid=1);
    heating_fuel_type_code_CUSTOM_ErrorCount := COUNT(GROUP,h.heating_fuel_type_code_Invalid=1);
    air_conditioning_type_code_CUSTOM_ErrorCount := COUNT(GROUP,h.air_conditioning_type_code_Invalid=1);
    fireplace_indicator_CUSTOM_ErrorCount := COUNT(GROUP,h.fireplace_indicator_Invalid=1);
    basement_code_CUSTOM_ErrorCount := COUNT(GROUP,h.basement_code_Invalid=1);
    building_class_code_CUSTOM_ErrorCount := COUNT(GROUP,h.building_class_code_Invalid=1);
    site_influence1_code_CUSTOM_ErrorCount := COUNT(GROUP,h.site_influence1_code_Invalid=1);
    amenities1_code_CUSTOM_ErrorCount := COUNT(GROUP,h.amenities1_code_Invalid=1);
    amenities2_code_CUSTOM_ErrorCount := COUNT(GROUP,h.amenities2_code_Invalid=1);
    amenities3_code_CUSTOM_ErrorCount := COUNT(GROUP,h.amenities3_code_Invalid=1);
    amenities4_code_CUSTOM_ErrorCount := COUNT(GROUP,h.amenities4_code_Invalid=1);
    other_buildings1_code_CUSTOM_ErrorCount := COUNT(GROUP,h.other_buildings1_code_Invalid=1);
    tape_cut_date_ALLOW_ErrorCount := COUNT(GROUP,h.tape_cut_date_Invalid=1);
    tape_cut_date_CUSTOM_ErrorCount := COUNT(GROUP,h.tape_cut_date_Invalid=2);
    tape_cut_date_LENGTHS_ErrorCount := COUNT(GROUP,h.tape_cut_date_Invalid=3);
    tape_cut_date_Total_ErrorCount := COUNT(GROUP,h.tape_cut_date_Invalid>0);
    certification_date_ALLOW_ErrorCount := COUNT(GROUP,h.certification_date_Invalid=1);
    certification_date_CUSTOM_ErrorCount := COUNT(GROUP,h.certification_date_Invalid=2);
    certification_date_LENGTHS_ErrorCount := COUNT(GROUP,h.certification_date_Invalid=3);
    certification_date_Total_ErrorCount := COUNT(GROUP,h.certification_date_Invalid>0);
    fips_ALLOW_ErrorCount := COUNT(GROUP,h.fips_Invalid=1);
    fips_LENGTHS_ErrorCount := COUNT(GROUP,h.fips_Invalid=2);
    fips_WITHIN_FILE_ErrorCount := COUNT(GROUP,h.fips_Invalid=3);
    fips_Total_ErrorCount := COUNT(GROUP,h.fips_Invalid>0);
    trans_before_proc_transfer_date_Invalid_ErrorCount := COUNT(GROUP,h.trans_before_proc_Invalid=1);
    trans_before_proc_process_date_Invalid_ErrorCount := COUNT(GROUP,h.trans_before_proc_Invalid=2);
    trans_before_proc_transfer_date_process_date_Condition_Invalid_ErrorCount := COUNT(GROUP,h.trans_before_proc_Invalid=3);
    trans_before_proc_Total_ErrorCount := COUNT(GROUP,h.trans_before_proc_Invalid>0);
    rec_before_proc_recording_date_Invalid_ErrorCount := COUNT(GROUP,h.rec_before_proc_Invalid=1);
    rec_before_proc_process_date_Invalid_ErrorCount := COUNT(GROUP,h.rec_before_proc_Invalid=2);
    rec_before_proc_recording_date_process_date_Condition_Invalid_ErrorCount := COUNT(GROUP,h.rec_before_proc_Invalid=3);
    rec_before_proc_Total_ErrorCount := COUNT(GROUP,h.rec_before_proc_Invalid>0);
    sale_before_proc_sale_date_Invalid_ErrorCount := COUNT(GROUP,h.sale_before_proc_Invalid=1);
    sale_before_proc_process_date_Invalid_ErrorCount := COUNT(GROUP,h.sale_before_proc_Invalid=2);
    sale_before_proc_sale_date_process_date_Condition_Invalid_ErrorCount := COUNT(GROUP,h.sale_before_proc_Invalid=3);
    sale_before_proc_Total_ErrorCount := COUNT(GROUP,h.sale_before_proc_Invalid>0);
    ptrans_before_proc_prior_transfer_date_Invalid_ErrorCount := COUNT(GROUP,h.ptrans_before_proc_Invalid=1);
    ptrans_before_proc_process_date_Invalid_ErrorCount := COUNT(GROUP,h.ptrans_before_proc_Invalid=2);
    ptrans_before_proc_prior_transfer_date_process_date_Condition_Invalid_ErrorCount := COUNT(GROUP,h.ptrans_before_proc_Invalid=3);
    ptrans_before_proc_Total_ErrorCount := COUNT(GROUP,h.ptrans_before_proc_Invalid>0);
    prior_rec_before_proc_prior_recording_date_Invalid_ErrorCount := COUNT(GROUP,h.prior_rec_before_proc_Invalid=1);
    prior_rec_before_proc_process_date_Invalid_ErrorCount := COUNT(GROUP,h.prior_rec_before_proc_Invalid=2);
    prior_rec_before_proc_prior_recording_date_process_date_Condition_Invalid_ErrorCount := COUNT(GROUP,h.prior_rec_before_proc_Invalid=3);
    prior_rec_before_proc_Total_ErrorCount := COUNT(GROUP,h.prior_rec_before_proc_Invalid>0);
    cert_before_proc_certification_date_Invalid_ErrorCount := COUNT(GROUP,h.cert_before_proc_Invalid=1);
    cert_before_proc_process_date_Invalid_ErrorCount := COUNT(GROUP,h.cert_before_proc_Invalid=2);
    cert_before_proc_certification_date_process_date_Condition_Invalid_ErrorCount := COUNT(GROUP,h.cert_before_proc_Invalid=3);
    cert_before_proc_Total_ErrorCount := COUNT(GROUP,h.cert_before_proc_Invalid>0);
    cut_before_proc_tape_cut_date_Invalid_ErrorCount := COUNT(GROUP,h.cut_before_proc_Invalid=1);
    cut_before_proc_process_date_Invalid_ErrorCount := COUNT(GROUP,h.cut_before_proc_Invalid=2);
    cut_before_proc_tape_cut_date_process_date_Condition_Invalid_ErrorCount := COUNT(GROUP,h.cut_before_proc_Invalid=3);
    cut_before_proc_Total_ErrorCount := COUNT(GROUP,h.cut_before_proc_Invalid>0);
    AssImp_Eq_AssTot_assessed_improvement_value_Invalid_ErrorCount := COUNT(GROUP,h.AssImp_Eq_AssTot_Invalid=1);
    AssImp_Eq_AssTot_assessed_total_value_Invalid_ErrorCount := COUNT(GROUP,h.AssImp_Eq_AssTot_Invalid=2);
    AssImp_Eq_AssTot_assessed_improvement_value_assessed_total_value_Condition_Invalid_ErrorCount := COUNT(GROUP,h.AssImp_Eq_AssTot_Invalid=3);
    AssImp_Eq_AssTot_Total_ErrorCount := COUNT(GROUP,h.AssImp_Eq_AssTot_Invalid>0);
    MarImp_Eq_MarTot_market_improvement_value_Invalid_ErrorCount := COUNT(GROUP,h.MarImp_Eq_MarTot_Invalid=1);
    MarImp_Eq_MarTot_market_total_value_Invalid_ErrorCount := COUNT(GROUP,h.MarImp_Eq_MarTot_Invalid=2);
    MarImp_Eq_MarTot_market_improvement_value_market_total_value_Condition_Invalid_ErrorCount := COUNT(GROUP,h.MarImp_Eq_MarTot_Invalid=3);
    MarImp_Eq_MarTot_Total_ErrorCount := COUNT(GROUP,h.MarImp_Eq_MarTot_Invalid>0);
    AssLnd_Eq_AssTot_assessed_land_value_Invalid_ErrorCount := COUNT(GROUP,h.AssLnd_Eq_AssTot_Invalid=1);
    AssLnd_Eq_AssTot_assessed_total_value_Invalid_ErrorCount := COUNT(GROUP,h.AssLnd_Eq_AssTot_Invalid=2);
    AssLnd_Eq_AssTot_assessed_land_value_assessed_total_value_Condition_Invalid_ErrorCount := COUNT(GROUP,h.AssLnd_Eq_AssTot_Invalid=3);
    AssLnd_Eq_AssTot_Total_ErrorCount := COUNT(GROUP,h.AssLnd_Eq_AssTot_Invalid>0);
    MarLnd_Eq_MarTot_market_land_value_Invalid_ErrorCount := COUNT(GROUP,h.MarLnd_Eq_MarTot_Invalid=1);
    MarLnd_Eq_MarTot_market_total_value_Invalid_ErrorCount := COUNT(GROUP,h.MarLnd_Eq_MarTot_Invalid=2);
    MarLnd_Eq_MarTot_market_land_value_market_total_value_Condition_Invalid_ErrorCount := COUNT(GROUP,h.MarLnd_Eq_MarTot_Invalid=3);
    MarLnd_Eq_MarTot_Total_ErrorCount := COUNT(GROUP,h.MarLnd_Eq_MarTot_Invalid>0);
    tax_less_than_total_assessed_tax_amount_Invalid_ErrorCount := COUNT(GROUP,h.tax_less_than_total_assessed_Invalid=1);
    tax_less_than_total_assessed_assessed_total_value_Invalid_ErrorCount := COUNT(GROUP,h.tax_less_than_total_assessed_Invalid=2);
    tax_less_than_total_assessed_tax_amount_assessed_total_value_Condition_Invalid_ErrorCount := COUNT(GROUP,h.tax_less_than_total_assessed_Invalid=3);
    tax_less_than_total_assessed_Total_ErrorCount := COUNT(GROUP,h.tax_less_than_total_assessed_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.process_date_Invalid > 0 OR h.fips_code_Invalid > 0 OR h.state_code_Invalid > 0 OR h.county_name_Invalid > 0 OR h.apna_or_pin_number_Invalid > 0 OR h.assessee_name_Invalid > 0 OR h.second_assessee_name_Invalid > 0 OR h.assessee_ownership_rights_code_Invalid > 0 OR h.assessee_relationship_code_Invalid > 0 OR h.assessee_phone_number_Invalid > 0 OR h.assessee_name_type_code_Invalid > 0 OR h.second_assessee_name_type_code_Invalid > 0 OR h.mail_care_of_name_type_code_Invalid > 0 OR h.mailing_care_of_name_Invalid > 0 OR h.mailing_full_street_address_Invalid > 0 OR h.mailing_unit_number_Invalid > 0 OR h.mailing_city_state_zip_Invalid > 0 OR h.property_full_street_address_Invalid > 0 OR h.property_unit_number_Invalid > 0 OR h.property_city_state_zip_Invalid > 0 OR h.property_address_code_Invalid > 0 OR h.legal_lot_code_Invalid > 0 OR h.record_type_code_Invalid > 0 OR h.ownership_type_code_Invalid > 0 OR h.new_record_type_code_Invalid > 0 OR h.standardized_land_use_code_Invalid > 0 OR h.transfer_date_Invalid > 0 OR h.recording_date_Invalid > 0 OR h.sale_date_Invalid > 0 OR h.document_type_Invalid > 0 OR h.sales_price_Invalid > 0 OR h.sales_price_code_Invalid > 0 OR h.mortgage_loan_amount_Invalid > 0 OR h.mortgage_loan_type_code_Invalid > 0 OR h.mortgage_lender_name_Invalid > 0 OR h.mortgage_lender_type_code_Invalid > 0 OR h.prior_transfer_date_Invalid > 0 OR h.prior_recording_date_Invalid > 0 OR h.prior_sales_price_Invalid > 0 OR h.prior_sales_price_code_Invalid > 0 OR h.assessed_land_value_Invalid > 0 OR h.assessed_improvement_value_Invalid > 0 OR h.assessed_total_value_Invalid > 0 OR h.assessed_value_year_Invalid > 0 OR h.market_land_value_Invalid > 0 OR h.market_improvement_value_Invalid > 0 OR h.market_total_value_Invalid > 0 OR h.market_value_year_Invalid > 0 OR h.tax_exemption1_code_Invalid > 0 OR h.tax_exemption2_code_Invalid > 0 OR h.tax_exemption3_code_Invalid > 0 OR h.tax_exemption4_code_Invalid > 0 OR h.tax_amount_Invalid > 0 OR h.tax_year_Invalid > 0 OR h.tax_delinquent_year_Invalid > 0 OR h.building_area_Invalid > 0 OR h.building_area_indicator_Invalid > 0 OR h.building_area1_Invalid > 0 OR h.building_area1_indicator_Invalid > 0 OR h.building_area2_Invalid > 0 OR h.building_area2_indicator_Invalid > 0 OR h.building_area3_Invalid > 0 OR h.building_area3_indicator_Invalid > 0 OR h.building_area4_Invalid > 0 OR h.building_area4_indicator_Invalid > 0 OR h.building_area5_Invalid > 0 OR h.building_area5_indicator_Invalid > 0 OR h.building_area6_Invalid > 0 OR h.building_area6_indicator_Invalid > 0 OR h.building_area7_Invalid > 0 OR h.building_area7_indicator_Invalid > 0 OR h.year_built_Invalid > 0 OR h.effective_year_built_Invalid > 0 OR h.no_of_stories_Invalid > 0 OR h.garage_type_code_Invalid > 0 OR h.pool_code_Invalid > 0 OR h.type_construction_code_Invalid > 0 OR h.building_quality_code_Invalid > 0 OR h.exterior_walls_code_Invalid > 0 OR h.roof_type_code_Invalid > 0 OR h.floor_cover_code_Invalid > 0 OR h.heating_code_Invalid > 0 OR h.heating_fuel_type_code_Invalid > 0 OR h.air_conditioning_type_code_Invalid > 0 OR h.fireplace_indicator_Invalid > 0 OR h.basement_code_Invalid > 0 OR h.building_class_code_Invalid > 0 OR h.site_influence1_code_Invalid > 0 OR h.amenities1_code_Invalid > 0 OR h.amenities2_code_Invalid > 0 OR h.amenities3_code_Invalid > 0 OR h.amenities4_code_Invalid > 0 OR h.other_buildings1_code_Invalid > 0 OR h.tape_cut_date_Invalid > 0 OR h.certification_date_Invalid > 0 OR h.fips_Invalid > 0 OR h.trans_before_proc_Invalid > 0 OR h.rec_before_proc_Invalid > 0 OR h.sale_before_proc_Invalid > 0 OR h.ptrans_before_proc_Invalid > 0 OR h.prior_rec_before_proc_Invalid > 0 OR h.cert_before_proc_Invalid > 0 OR h.cut_before_proc_Invalid > 0 OR h.AssImp_Eq_AssTot_Invalid > 0 OR h.MarImp_Eq_MarTot_Invalid > 0 OR h.AssLnd_Eq_AssTot_Invalid > 0 OR h.MarLnd_Eq_MarTot_Invalid > 0 OR h.tax_less_than_total_assessed_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := IF(Glob, TABLE(h,r), TABLE(h,r,fips_code,FEW));
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.process_date_Total_ErrorCount > 0, 1, 0) + IF(le.fips_code_Total_ErrorCount > 0, 1, 0) + IF(le.state_code_Total_ErrorCount > 0, 1, 0) + IF(le.county_name_Total_ErrorCount > 0, 1, 0) + IF(le.apna_or_pin_number_Total_ErrorCount > 0, 1, 0) + IF(le.assessee_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.second_assessee_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assessee_ownership_rights_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.assessee_relationship_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.assessee_phone_number_Total_ErrorCount > 0, 1, 0) + IF(le.assessee_name_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.second_assessee_name_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_care_of_name_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mailing_care_of_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailing_full_street_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailing_unit_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailing_city_state_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.property_full_street_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.property_unit_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.property_city_state_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.property_address_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.legal_lot_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ownership_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.new_record_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.standardized_land_use_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.transfer_date_Total_ErrorCount > 0, 1, 0) + IF(le.recording_date_Total_ErrorCount > 0, 1, 0) + IF(le.sale_date_Total_ErrorCount > 0, 1, 0) + IF(le.document_type_Total_ErrorCount > 0, 1, 0) + IF(le.sales_price_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sales_price_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mortgage_loan_amount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mortgage_loan_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mortgage_lender_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mortgage_lender_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prior_transfer_date_Total_ErrorCount > 0, 1, 0) + IF(le.prior_recording_date_Total_ErrorCount > 0, 1, 0) + IF(le.prior_sales_price_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prior_sales_price_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.assessed_land_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assessed_improvement_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assessed_total_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assessed_value_year_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.market_land_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.market_improvement_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.market_total_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.market_value_year_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tax_exemption1_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tax_exemption2_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tax_exemption3_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tax_exemption4_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tax_amount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.tax_year_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tax_delinquent_year_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area_indicator_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area1_indicator_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area2_indicator_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area3_indicator_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area4_indicator_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area5_indicator_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area6_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area6_indicator_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area7_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area7_indicator_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.year_built_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.effective_year_built_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.no_of_stories_Total_ErrorCount > 0, 1, 0) + IF(le.garage_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.pool_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.type_construction_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_quality_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.exterior_walls_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.roof_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.floor_cover_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.heating_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.heating_fuel_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.air_conditioning_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fireplace_indicator_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.basement_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_class_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.site_influence1_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.amenities1_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.amenities2_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.amenities3_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.amenities4_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.other_buildings1_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tape_cut_date_Total_ErrorCount > 0, 1, 0) + IF(le.certification_date_Total_ErrorCount > 0, 1, 0) + IF(le.fips_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.process_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fips_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fips_code_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fips_code_WITHIN_FILE_ErrorCount > 0, 1, 0) + IF(le.state_code_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.state_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_code_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.county_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.apna_or_pin_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.apna_or_pin_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.assessee_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.second_assessee_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assessee_ownership_rights_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.assessee_relationship_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.assessee_phone_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assessee_phone_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.assessee_name_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.second_assessee_name_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_care_of_name_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mailing_care_of_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailing_full_street_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailing_unit_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailing_city_state_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.property_full_street_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.property_unit_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.property_city_state_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.property_address_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.legal_lot_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ownership_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.new_record_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.standardized_land_use_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.transfer_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.transfer_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.transfer_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.recording_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.recording_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.recording_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.sale_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sale_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sale_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.document_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.document_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sales_price_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sales_price_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mortgage_loan_amount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mortgage_loan_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mortgage_lender_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mortgage_lender_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prior_transfer_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prior_transfer_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prior_transfer_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prior_recording_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prior_recording_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prior_recording_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prior_sales_price_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prior_sales_price_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.assessed_land_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assessed_improvement_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assessed_total_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assessed_value_year_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.market_land_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.market_improvement_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.market_total_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.market_value_year_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tax_exemption1_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tax_exemption2_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tax_exemption3_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tax_exemption4_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tax_amount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.tax_year_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tax_delinquent_year_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area_indicator_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area1_indicator_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area2_indicator_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area3_indicator_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area4_indicator_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area5_indicator_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area6_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area6_indicator_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area7_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_area7_indicator_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.year_built_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.effective_year_built_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.no_of_stories_ALLOW_ErrorCount > 0, 1, 0) + IF(le.no_of_stories_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.garage_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.pool_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.type_construction_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_quality_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.exterior_walls_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.roof_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.floor_cover_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.heating_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.heating_fuel_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.air_conditioning_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fireplace_indicator_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.basement_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.building_class_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.site_influence1_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.amenities1_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.amenities2_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.amenities3_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.amenities4_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.other_buildings1_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tape_cut_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.tape_cut_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tape_cut_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.certification_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certification_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certification_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fips_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fips_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fips_WITHIN_FILE_ErrorCount > 0, 1, 0) + IF(le.trans_before_proc_transfer_date_Invalid_ErrorCount > 0, 1, 0) + IF(le.trans_before_proc_process_date_Invalid_ErrorCount > 0, 1, 0) + IF(le.trans_before_proc_transfer_date_process_date_Condition_Invalid_ErrorCount > 0, 1, 0) + IF(le.rec_before_proc_recording_date_Invalid_ErrorCount > 0, 1, 0) + IF(le.rec_before_proc_process_date_Invalid_ErrorCount > 0, 1, 0) + IF(le.rec_before_proc_recording_date_process_date_Condition_Invalid_ErrorCount > 0, 1, 0) + IF(le.sale_before_proc_sale_date_Invalid_ErrorCount > 0, 1, 0) + IF(le.sale_before_proc_process_date_Invalid_ErrorCount > 0, 1, 0) + IF(le.sale_before_proc_sale_date_process_date_Condition_Invalid_ErrorCount > 0, 1, 0) + IF(le.ptrans_before_proc_prior_transfer_date_Invalid_ErrorCount > 0, 1, 0) + IF(le.ptrans_before_proc_process_date_Invalid_ErrorCount > 0, 1, 0) + IF(le.ptrans_before_proc_prior_transfer_date_process_date_Condition_Invalid_ErrorCount > 0, 1, 0) + IF(le.prior_rec_before_proc_prior_recording_date_Invalid_ErrorCount > 0, 1, 0) + IF(le.prior_rec_before_proc_process_date_Invalid_ErrorCount > 0, 1, 0) + IF(le.prior_rec_before_proc_prior_recording_date_process_date_Condition_Invalid_ErrorCount > 0, 1, 0) + IF(le.cert_before_proc_certification_date_Invalid_ErrorCount > 0, 1, 0) + IF(le.cert_before_proc_process_date_Invalid_ErrorCount > 0, 1, 0) + IF(le.cert_before_proc_certification_date_process_date_Condition_Invalid_ErrorCount > 0, 1, 0) + IF(le.cut_before_proc_tape_cut_date_Invalid_ErrorCount > 0, 1, 0) + IF(le.cut_before_proc_process_date_Invalid_ErrorCount > 0, 1, 0) + IF(le.cut_before_proc_tape_cut_date_process_date_Condition_Invalid_ErrorCount > 0, 1, 0) + IF(le.AssImp_Eq_AssTot_assessed_improvement_value_Invalid_ErrorCount > 0, 1, 0) + IF(le.AssImp_Eq_AssTot_assessed_total_value_Invalid_ErrorCount > 0, 1, 0) + IF(le.AssImp_Eq_AssTot_assessed_improvement_value_assessed_total_value_Condition_Invalid_ErrorCount > 0, 1, 0) + IF(le.MarImp_Eq_MarTot_market_improvement_value_Invalid_ErrorCount > 0, 1, 0) + IF(le.MarImp_Eq_MarTot_market_total_value_Invalid_ErrorCount > 0, 1, 0) + IF(le.MarImp_Eq_MarTot_market_improvement_value_market_total_value_Condition_Invalid_ErrorCount > 0, 1, 0) + IF(le.AssLnd_Eq_AssTot_assessed_land_value_Invalid_ErrorCount > 0, 1, 0) + IF(le.AssLnd_Eq_AssTot_assessed_total_value_Invalid_ErrorCount > 0, 1, 0) + IF(le.AssLnd_Eq_AssTot_assessed_land_value_assessed_total_value_Condition_Invalid_ErrorCount > 0, 1, 0) + IF(le.MarLnd_Eq_MarTot_market_land_value_Invalid_ErrorCount > 0, 1, 0) + IF(le.MarLnd_Eq_MarTot_market_total_value_Invalid_ErrorCount > 0, 1, 0) + IF(le.MarLnd_Eq_MarTot_market_land_value_market_total_value_Condition_Invalid_ErrorCount > 0, 1, 0) + IF(le.tax_less_than_total_assessed_tax_amount_Invalid_ErrorCount > 0, 1, 0) + IF(le.tax_less_than_total_assessed_assessed_total_value_Invalid_ErrorCount > 0, 1, 0) + IF(le.tax_less_than_total_assessed_tax_amount_assessed_total_value_Condition_Invalid_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT311.StrType ErrorMessage;
    SALT311.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.fips_code;
    UNSIGNED1 ErrNum := CHOOSE(c,le.process_date_Invalid,le.fips_code_Invalid,le.state_code_Invalid,le.county_name_Invalid,le.apna_or_pin_number_Invalid,le.assessee_name_Invalid,le.second_assessee_name_Invalid,le.assessee_ownership_rights_code_Invalid,le.assessee_relationship_code_Invalid,le.assessee_phone_number_Invalid,le.assessee_name_type_code_Invalid,le.second_assessee_name_type_code_Invalid,le.mail_care_of_name_type_code_Invalid,le.mailing_care_of_name_Invalid,le.mailing_full_street_address_Invalid,le.mailing_unit_number_Invalid,le.mailing_city_state_zip_Invalid,le.property_full_street_address_Invalid,le.property_unit_number_Invalid,le.property_city_state_zip_Invalid,le.property_address_code_Invalid,le.legal_lot_code_Invalid,le.record_type_code_Invalid,le.ownership_type_code_Invalid,le.new_record_type_code_Invalid,le.standardized_land_use_code_Invalid,le.transfer_date_Invalid,le.recording_date_Invalid,le.sale_date_Invalid,le.document_type_Invalid,le.sales_price_Invalid,le.sales_price_code_Invalid,le.mortgage_loan_amount_Invalid,le.mortgage_loan_type_code_Invalid,le.mortgage_lender_name_Invalid,le.mortgage_lender_type_code_Invalid,le.prior_transfer_date_Invalid,le.prior_recording_date_Invalid,le.prior_sales_price_Invalid,le.prior_sales_price_code_Invalid,le.assessed_land_value_Invalid,le.assessed_improvement_value_Invalid,le.assessed_total_value_Invalid,le.assessed_value_year_Invalid,le.market_land_value_Invalid,le.market_improvement_value_Invalid,le.market_total_value_Invalid,le.market_value_year_Invalid,le.tax_exemption1_code_Invalid,le.tax_exemption2_code_Invalid,le.tax_exemption3_code_Invalid,le.tax_exemption4_code_Invalid,le.tax_amount_Invalid,le.tax_year_Invalid,le.tax_delinquent_year_Invalid,le.building_area_Invalid,le.building_area_indicator_Invalid,le.building_area1_Invalid,le.building_area1_indicator_Invalid,le.building_area2_Invalid,le.building_area2_indicator_Invalid,le.building_area3_Invalid,le.building_area3_indicator_Invalid,le.building_area4_Invalid,le.building_area4_indicator_Invalid,le.building_area5_Invalid,le.building_area5_indicator_Invalid,le.building_area6_Invalid,le.building_area6_indicator_Invalid,le.building_area7_Invalid,le.building_area7_indicator_Invalid,le.year_built_Invalid,le.effective_year_built_Invalid,le.no_of_stories_Invalid,le.garage_type_code_Invalid,le.pool_code_Invalid,le.type_construction_code_Invalid,le.building_quality_code_Invalid,le.exterior_walls_code_Invalid,le.roof_type_code_Invalid,le.floor_cover_code_Invalid,le.heating_code_Invalid,le.heating_fuel_type_code_Invalid,le.air_conditioning_type_code_Invalid,le.fireplace_indicator_Invalid,le.basement_code_Invalid,le.building_class_code_Invalid,le.site_influence1_code_Invalid,le.amenities1_code_Invalid,le.amenities2_code_Invalid,le.amenities3_code_Invalid,le.amenities4_code_Invalid,le.other_buildings1_code_Invalid,le.tape_cut_date_Invalid,le.certification_date_Invalid,le.fips_Invalid,le.trans_before_proc_Invalid,le.rec_before_proc_Invalid,le.sale_before_proc_Invalid,le.ptrans_before_proc_Invalid,le.prior_rec_before_proc_Invalid,le.cert_before_proc_Invalid,le.cut_before_proc_Invalid,le.AssImp_Eq_AssTot_Invalid,le.MarImp_Eq_MarTot_Invalid,le.AssLnd_Eq_AssTot_Invalid,le.MarLnd_Eq_MarTot_Invalid,le.tax_less_than_total_assessed_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_process_date(le.process_date_Invalid),Fields.InvalidMessage_fips_code(le.fips_code_Invalid),Fields.InvalidMessage_state_code(le.state_code_Invalid),Fields.InvalidMessage_county_name(le.county_name_Invalid),Fields.InvalidMessage_apna_or_pin_number(le.apna_or_pin_number_Invalid),Fields.InvalidMessage_assessee_name(le.assessee_name_Invalid),Fields.InvalidMessage_second_assessee_name(le.second_assessee_name_Invalid),Fields.InvalidMessage_assessee_ownership_rights_code(le.assessee_ownership_rights_code_Invalid),Fields.InvalidMessage_assessee_relationship_code(le.assessee_relationship_code_Invalid),Fields.InvalidMessage_assessee_phone_number(le.assessee_phone_number_Invalid),Fields.InvalidMessage_assessee_name_type_code(le.assessee_name_type_code_Invalid),Fields.InvalidMessage_second_assessee_name_type_code(le.second_assessee_name_type_code_Invalid),Fields.InvalidMessage_mail_care_of_name_type_code(le.mail_care_of_name_type_code_Invalid),Fields.InvalidMessage_mailing_care_of_name(le.mailing_care_of_name_Invalid),Fields.InvalidMessage_mailing_full_street_address(le.mailing_full_street_address_Invalid),Fields.InvalidMessage_mailing_unit_number(le.mailing_unit_number_Invalid),Fields.InvalidMessage_mailing_city_state_zip(le.mailing_city_state_zip_Invalid),Fields.InvalidMessage_property_full_street_address(le.property_full_street_address_Invalid),Fields.InvalidMessage_property_unit_number(le.property_unit_number_Invalid),Fields.InvalidMessage_property_city_state_zip(le.property_city_state_zip_Invalid),Fields.InvalidMessage_property_address_code(le.property_address_code_Invalid),Fields.InvalidMessage_legal_lot_code(le.legal_lot_code_Invalid),Fields.InvalidMessage_record_type_code(le.record_type_code_Invalid),Fields.InvalidMessage_ownership_type_code(le.ownership_type_code_Invalid),Fields.InvalidMessage_new_record_type_code(le.new_record_type_code_Invalid),Fields.InvalidMessage_standardized_land_use_code(le.standardized_land_use_code_Invalid),Fields.InvalidMessage_transfer_date(le.transfer_date_Invalid),Fields.InvalidMessage_recording_date(le.recording_date_Invalid),Fields.InvalidMessage_sale_date(le.sale_date_Invalid),Fields.InvalidMessage_document_type(le.document_type_Invalid),Fields.InvalidMessage_sales_price(le.sales_price_Invalid),Fields.InvalidMessage_sales_price_code(le.sales_price_code_Invalid),Fields.InvalidMessage_mortgage_loan_amount(le.mortgage_loan_amount_Invalid),Fields.InvalidMessage_mortgage_loan_type_code(le.mortgage_loan_type_code_Invalid),Fields.InvalidMessage_mortgage_lender_name(le.mortgage_lender_name_Invalid),Fields.InvalidMessage_mortgage_lender_type_code(le.mortgage_lender_type_code_Invalid),Fields.InvalidMessage_prior_transfer_date(le.prior_transfer_date_Invalid),Fields.InvalidMessage_prior_recording_date(le.prior_recording_date_Invalid),Fields.InvalidMessage_prior_sales_price(le.prior_sales_price_Invalid),Fields.InvalidMessage_prior_sales_price_code(le.prior_sales_price_code_Invalid),Fields.InvalidMessage_assessed_land_value(le.assessed_land_value_Invalid),Fields.InvalidMessage_assessed_improvement_value(le.assessed_improvement_value_Invalid),Fields.InvalidMessage_assessed_total_value(le.assessed_total_value_Invalid),Fields.InvalidMessage_assessed_value_year(le.assessed_value_year_Invalid),Fields.InvalidMessage_market_land_value(le.market_land_value_Invalid),Fields.InvalidMessage_market_improvement_value(le.market_improvement_value_Invalid),Fields.InvalidMessage_market_total_value(le.market_total_value_Invalid),Fields.InvalidMessage_market_value_year(le.market_value_year_Invalid),Fields.InvalidMessage_tax_exemption1_code(le.tax_exemption1_code_Invalid),Fields.InvalidMessage_tax_exemption2_code(le.tax_exemption2_code_Invalid),Fields.InvalidMessage_tax_exemption3_code(le.tax_exemption3_code_Invalid),Fields.InvalidMessage_tax_exemption4_code(le.tax_exemption4_code_Invalid),Fields.InvalidMessage_tax_amount(le.tax_amount_Invalid),Fields.InvalidMessage_tax_year(le.tax_year_Invalid),Fields.InvalidMessage_tax_delinquent_year(le.tax_delinquent_year_Invalid),Fields.InvalidMessage_building_area(le.building_area_Invalid),Fields.InvalidMessage_building_area_indicator(le.building_area_indicator_Invalid),Fields.InvalidMessage_building_area1(le.building_area1_Invalid),Fields.InvalidMessage_building_area1_indicator(le.building_area1_indicator_Invalid),Fields.InvalidMessage_building_area2(le.building_area2_Invalid),Fields.InvalidMessage_building_area2_indicator(le.building_area2_indicator_Invalid),Fields.InvalidMessage_building_area3(le.building_area3_Invalid),Fields.InvalidMessage_building_area3_indicator(le.building_area3_indicator_Invalid),Fields.InvalidMessage_building_area4(le.building_area4_Invalid),Fields.InvalidMessage_building_area4_indicator(le.building_area4_indicator_Invalid),Fields.InvalidMessage_building_area5(le.building_area5_Invalid),Fields.InvalidMessage_building_area5_indicator(le.building_area5_indicator_Invalid),Fields.InvalidMessage_building_area6(le.building_area6_Invalid),Fields.InvalidMessage_building_area6_indicator(le.building_area6_indicator_Invalid),Fields.InvalidMessage_building_area7(le.building_area7_Invalid),Fields.InvalidMessage_building_area7_indicator(le.building_area7_indicator_Invalid),Fields.InvalidMessage_year_built(le.year_built_Invalid),Fields.InvalidMessage_effective_year_built(le.effective_year_built_Invalid),Fields.InvalidMessage_no_of_stories(le.no_of_stories_Invalid),Fields.InvalidMessage_garage_type_code(le.garage_type_code_Invalid),Fields.InvalidMessage_pool_code(le.pool_code_Invalid),Fields.InvalidMessage_type_construction_code(le.type_construction_code_Invalid),Fields.InvalidMessage_building_quality_code(le.building_quality_code_Invalid),Fields.InvalidMessage_exterior_walls_code(le.exterior_walls_code_Invalid),Fields.InvalidMessage_roof_type_code(le.roof_type_code_Invalid),Fields.InvalidMessage_floor_cover_code(le.floor_cover_code_Invalid),Fields.InvalidMessage_heating_code(le.heating_code_Invalid),Fields.InvalidMessage_heating_fuel_type_code(le.heating_fuel_type_code_Invalid),Fields.InvalidMessage_air_conditioning_type_code(le.air_conditioning_type_code_Invalid),Fields.InvalidMessage_fireplace_indicator(le.fireplace_indicator_Invalid),Fields.InvalidMessage_basement_code(le.basement_code_Invalid),Fields.InvalidMessage_building_class_code(le.building_class_code_Invalid),Fields.InvalidMessage_site_influence1_code(le.site_influence1_code_Invalid),Fields.InvalidMessage_amenities1_code(le.amenities1_code_Invalid),Fields.InvalidMessage_amenities2_code(le.amenities2_code_Invalid),Fields.InvalidMessage_amenities3_code(le.amenities3_code_Invalid),Fields.InvalidMessage_amenities4_code(le.amenities4_code_Invalid),Fields.InvalidMessage_other_buildings1_code(le.other_buildings1_code_Invalid),Fields.InvalidMessage_tape_cut_date(le.tape_cut_date_Invalid),Fields.InvalidMessage_certification_date(le.certification_date_Invalid),Fields.InvalidMessage_fips(le.fips_Invalid),InvalidMessage_trans_before_proc(le.trans_before_proc_Invalid),InvalidMessage_rec_before_proc(le.rec_before_proc_Invalid),InvalidMessage_sale_before_proc(le.sale_before_proc_Invalid),InvalidMessage_ptrans_before_proc(le.ptrans_before_proc_Invalid),InvalidMessage_prior_rec_before_proc(le.prior_rec_before_proc_Invalid),InvalidMessage_cert_before_proc(le.cert_before_proc_Invalid),InvalidMessage_cut_before_proc(le.cut_before_proc_Invalid),InvalidMessage_AssImp_Eq_AssTot(le.AssImp_Eq_AssTot_Invalid),InvalidMessage_MarImp_Eq_MarTot(le.MarImp_Eq_MarTot_Invalid),InvalidMessage_AssLnd_Eq_AssTot(le.AssLnd_Eq_AssTot_Invalid),InvalidMessage_MarLnd_Eq_MarTot(le.MarLnd_Eq_MarTot_Invalid),InvalidMessage_tax_less_than_total_assessed(le.tax_less_than_total_assessed_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.process_date_Invalid,'ALLOW','CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fips_code_Invalid,'ALLOW','LENGTHS','WITHIN_FILE','UNKNOWN')
          ,CHOOSE(le.state_code_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.county_name_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.apna_or_pin_number_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.assessee_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.second_assessee_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.assessee_ownership_rights_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.assessee_relationship_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.assessee_phone_number_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.assessee_name_type_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.second_assessee_name_type_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_care_of_name_type_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mailing_care_of_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mailing_full_street_address_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mailing_unit_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mailing_city_state_zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.property_full_street_address_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.property_unit_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.property_city_state_zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.property_address_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.legal_lot_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.record_type_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ownership_type_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.new_record_type_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.standardized_land_use_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.transfer_date_Invalid,'ALLOW','CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.recording_date_Invalid,'ALLOW','CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.sale_date_Invalid,'ALLOW','CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.document_type_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.sales_price_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sales_price_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mortgage_loan_amount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mortgage_loan_type_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mortgage_lender_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mortgage_lender_type_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prior_transfer_date_Invalid,'ALLOW','CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.prior_recording_date_Invalid,'ALLOW','CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.prior_sales_price_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prior_sales_price_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.assessed_land_value_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.assessed_improvement_value_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.assessed_total_value_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.assessed_value_year_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.market_land_value_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.market_improvement_value_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.market_total_value_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.market_value_year_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.tax_exemption1_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.tax_exemption2_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.tax_exemption3_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.tax_exemption4_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.tax_amount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.tax_year_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.tax_delinquent_year_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.building_area_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.building_area_indicator_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.building_area1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.building_area1_indicator_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.building_area2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.building_area2_indicator_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.building_area3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.building_area3_indicator_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.building_area4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.building_area4_indicator_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.building_area5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.building_area5_indicator_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.building_area6_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.building_area6_indicator_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.building_area7_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.building_area7_indicator_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.year_built_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.effective_year_built_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.no_of_stories_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.garage_type_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.pool_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.type_construction_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.building_quality_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.exterior_walls_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.roof_type_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.floor_cover_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.heating_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.heating_fuel_type_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.air_conditioning_type_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fireplace_indicator_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.basement_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.building_class_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.site_influence1_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.amenities1_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.amenities2_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.amenities3_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.amenities4_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.other_buildings1_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.tape_cut_date_Invalid,'ALLOW','CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.certification_date_Invalid,'ALLOW','CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fips_Invalid,'ALLOW','LENGTHS','WITHIN_FILE','UNKNOWN')
          ,CHOOSE(le.trans_before_proc_Invalid,'transfer_date_Invalid','process_date_Invalid','transfer_date_process_date_Condition_Invalid','UNKNOWN')
          ,CHOOSE(le.rec_before_proc_Invalid,'recording_date_Invalid','process_date_Invalid','recording_date_process_date_Condition_Invalid','UNKNOWN')
          ,CHOOSE(le.sale_before_proc_Invalid,'sale_date_Invalid','process_date_Invalid','sale_date_process_date_Condition_Invalid','UNKNOWN')
          ,CHOOSE(le.ptrans_before_proc_Invalid,'prior_transfer_date_Invalid','process_date_Invalid','prior_transfer_date_process_date_Condition_Invalid','UNKNOWN')
          ,CHOOSE(le.prior_rec_before_proc_Invalid,'prior_recording_date_Invalid','process_date_Invalid','prior_recording_date_process_date_Condition_Invalid','UNKNOWN')
          ,CHOOSE(le.cert_before_proc_Invalid,'certification_date_Invalid','process_date_Invalid','certification_date_process_date_Condition_Invalid','UNKNOWN')
          ,CHOOSE(le.cut_before_proc_Invalid,'tape_cut_date_Invalid','process_date_Invalid','tape_cut_date_process_date_Condition_Invalid','UNKNOWN')
          ,CHOOSE(le.AssImp_Eq_AssTot_Invalid,'assessed_improvement_value_Invalid','assessed_total_value_Invalid','assessed_improvement_value_assessed_total_value_Condition_Invalid','UNKNOWN')
          ,CHOOSE(le.MarImp_Eq_MarTot_Invalid,'market_improvement_value_Invalid','market_total_value_Invalid','market_improvement_value_market_total_value_Condition_Invalid','UNKNOWN')
          ,CHOOSE(le.AssLnd_Eq_AssTot_Invalid,'assessed_land_value_Invalid','assessed_total_value_Invalid','assessed_land_value_assessed_total_value_Condition_Invalid','UNKNOWN')
          ,CHOOSE(le.MarLnd_Eq_MarTot_Invalid,'market_land_value_Invalid','market_total_value_Invalid','market_land_value_market_total_value_Condition_Invalid','UNKNOWN')
          ,CHOOSE(le.tax_less_than_total_assessed_Invalid,'tax_amount_Invalid','assessed_total_value_Invalid','tax_amount_assessed_total_value_Condition_Invalid','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'process_date','fips_code','state_code','county_name','apna_or_pin_number','assessee_name','second_assessee_name','assessee_ownership_rights_code','assessee_relationship_code','assessee_phone_number','assessee_name_type_code','second_assessee_name_type_code','mail_care_of_name_type_code','mailing_care_of_name','mailing_full_street_address','mailing_unit_number','mailing_city_state_zip','property_full_street_address','property_unit_number','property_city_state_zip','property_address_code','legal_lot_code','record_type_code','ownership_type_code','new_record_type_code','standardized_land_use_code','transfer_date','recording_date','sale_date','document_type','sales_price','sales_price_code','mortgage_loan_amount','mortgage_loan_type_code','mortgage_lender_name','mortgage_lender_type_code','prior_transfer_date','prior_recording_date','prior_sales_price','prior_sales_price_code','assessed_land_value','assessed_improvement_value','assessed_total_value','assessed_value_year','market_land_value','market_improvement_value','market_total_value','market_value_year','tax_exemption1_code','tax_exemption2_code','tax_exemption3_code','tax_exemption4_code','tax_amount','tax_year','tax_delinquent_year','building_area','building_area_indicator','building_area1','building_area1_indicator','building_area2','building_area2_indicator','building_area3','building_area3_indicator','building_area4','building_area4_indicator','building_area5','building_area5_indicator','building_area6','building_area6_indicator','building_area7','building_area7_indicator','year_built','effective_year_built','no_of_stories','garage_type_code','pool_code','type_construction_code','building_quality_code','exterior_walls_code','roof_type_code','floor_cover_code','heating_code','heating_fuel_type_code','air_conditioning_type_code','fireplace_indicator','basement_code','building_class_code','site_influence1_code','amenities1_code','amenities2_code','amenities3_code','amenities4_code','other_buildings1_code','tape_cut_date','certification_date','fips','trans_before_proc','rec_before_proc','sale_before_proc','ptrans_before_proc','prior_rec_before_proc','cert_before_proc','cut_before_proc','AssImp_Eq_AssTot','MarImp_Eq_MarTot','AssLnd_Eq_AssTot','MarLnd_Eq_MarTot','tax_less_than_total_assessed','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_date','invalid_fips','invalid_state_code','invalid_county_name','invalid_apn','invalid_alpha','invalid_alpha','invalid_ownership_rights_code','invalid_relationship_code','invalid_phone','invalid_name_type_code','invalid_second_name_type_code','invalid_mail_care_of_name_type_code','invalid_alpha','invalid_address','invalid_address','invalid_csz','invalid_address','invalid_address','invalid_csz','invalid_property_address_code','invalid_legal_lot_code','invalid_record_type_code','invalid_ownership_type_code','invalid_new_record_type_code','invalid_land_use','invalid_date','invalid_date','invalid_date','invalid_document_type_code','invalid_prop_amount','invalid_sale_code','invalid_prop_amount','invalid_mortgage_loan_type_code','invalid_alpha','invalid_mortgage_lender_type_code','invalid_date','invalid_date','invalid_prop_amount','invalid_prior_sales_price_code','invalid_prop_amount','invalid_prop_amount','invalid_prop_amount','invalid_year','invalid_prop_amount','invalid_prop_amount','invalid_prop_amount','invalid_year','invalid_tax_exemption1_code','invalid_tax_exemption2_code','invalid_tax_exemption3_code','invalid_tax_exemption4_code','invalid_tax_amount','invalid_year','invalid_year','invalid_building_area','invalid_building_area_indicator','invalid_building_area','invalid_building_area1_indicator','invalid_building_area','invalid_building_area2_indicator','invalid_building_area','invalid_building_area3_indicator','invalid_building_area','invalid_building_area4_indicator','invalid_building_area','invalid_building_area5_indicator','invalid_building_area','invalid_building_area6_indicator','invalid_building_area','invalid_building_area7_indicator','invalid_year','invalid_year','invalid_no_of_stories','invalid_garage_type_code','invalid_pool_code','invalid_construction_type','invalid_building_quality_code','invalid_exterior_walls_code','invalid_roof_type_code','invalid_floor_cover_code','invalid_heating_code','invalid_heating_fuel_type_code','invalid_air_conditioning_type_code','invalid_fireplace_indicator','invalid_basement_code','invalid_building_class_code','invalid_site_influence1_code','invalid_amenities1_code','invalid_amenities2_code','invalid_amenities3_code','invalid_amenities4_code','invalid_other_buildings1_code','invalid_date','invalid_date','invalid_fips','RECORDTYPE','RECORDTYPE','RECORDTYPE','RECORDTYPE','RECORDTYPE','RECORDTYPE','RECORDTYPE','RECORDTYPE','RECORDTYPE','RECORDTYPE','RECORDTYPE','RECORDTYPE','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.process_date,(SALT311.StrType)le.fips_code,(SALT311.StrType)le.state_code,(SALT311.StrType)le.county_name,(SALT311.StrType)le.apna_or_pin_number,(SALT311.StrType)le.assessee_name,(SALT311.StrType)le.second_assessee_name,(SALT311.StrType)le.assessee_ownership_rights_code,(SALT311.StrType)le.assessee_relationship_code,(SALT311.StrType)le.assessee_phone_number,(SALT311.StrType)le.assessee_name_type_code,(SALT311.StrType)le.second_assessee_name_type_code,(SALT311.StrType)le.mail_care_of_name_type_code,(SALT311.StrType)le.mailing_care_of_name,(SALT311.StrType)le.mailing_full_street_address,(SALT311.StrType)le.mailing_unit_number,(SALT311.StrType)le.mailing_city_state_zip,(SALT311.StrType)le.property_full_street_address,(SALT311.StrType)le.property_unit_number,(SALT311.StrType)le.property_city_state_zip,(SALT311.StrType)le.property_address_code,(SALT311.StrType)le.legal_lot_code,(SALT311.StrType)le.record_type_code,(SALT311.StrType)le.ownership_type_code,(SALT311.StrType)le.new_record_type_code,(SALT311.StrType)le.standardized_land_use_code,(SALT311.StrType)le.transfer_date,(SALT311.StrType)le.recording_date,(SALT311.StrType)le.sale_date,(SALT311.StrType)le.document_type,(SALT311.StrType)le.sales_price,(SALT311.StrType)le.sales_price_code,(SALT311.StrType)le.mortgage_loan_amount,(SALT311.StrType)le.mortgage_loan_type_code,(SALT311.StrType)le.mortgage_lender_name,(SALT311.StrType)le.mortgage_lender_type_code,(SALT311.StrType)le.prior_transfer_date,(SALT311.StrType)le.prior_recording_date,(SALT311.StrType)le.prior_sales_price,(SALT311.StrType)le.prior_sales_price_code,(SALT311.StrType)le.assessed_land_value,(SALT311.StrType)le.assessed_improvement_value,(SALT311.StrType)le.assessed_total_value,(SALT311.StrType)le.assessed_value_year,(SALT311.StrType)le.market_land_value,(SALT311.StrType)le.market_improvement_value,(SALT311.StrType)le.market_total_value,(SALT311.StrType)le.market_value_year,(SALT311.StrType)le.tax_exemption1_code,(SALT311.StrType)le.tax_exemption2_code,(SALT311.StrType)le.tax_exemption3_code,(SALT311.StrType)le.tax_exemption4_code,(SALT311.StrType)le.tax_amount,(SALT311.StrType)le.tax_year,(SALT311.StrType)le.tax_delinquent_year,(SALT311.StrType)le.building_area,(SALT311.StrType)le.building_area_indicator,(SALT311.StrType)le.building_area1,(SALT311.StrType)le.building_area1_indicator,(SALT311.StrType)le.building_area2,(SALT311.StrType)le.building_area2_indicator,(SALT311.StrType)le.building_area3,(SALT311.StrType)le.building_area3_indicator,(SALT311.StrType)le.building_area4,(SALT311.StrType)le.building_area4_indicator,(SALT311.StrType)le.building_area5,(SALT311.StrType)le.building_area5_indicator,(SALT311.StrType)le.building_area6,(SALT311.StrType)le.building_area6_indicator,(SALT311.StrType)le.building_area7,(SALT311.StrType)le.building_area7_indicator,(SALT311.StrType)le.year_built,(SALT311.StrType)le.effective_year_built,(SALT311.StrType)le.no_of_stories,(SALT311.StrType)le.garage_type_code,(SALT311.StrType)le.pool_code,(SALT311.StrType)le.type_construction_code,(SALT311.StrType)le.building_quality_code,(SALT311.StrType)le.exterior_walls_code,(SALT311.StrType)le.roof_type_code,(SALT311.StrType)le.floor_cover_code,(SALT311.StrType)le.heating_code,(SALT311.StrType)le.heating_fuel_type_code,(SALT311.StrType)le.air_conditioning_type_code,(SALT311.StrType)le.fireplace_indicator,(SALT311.StrType)le.basement_code,(SALT311.StrType)le.building_class_code,(SALT311.StrType)le.site_influence1_code,(SALT311.StrType)le.amenities1_code,(SALT311.StrType)le.amenities2_code,(SALT311.StrType)le.amenities3_code,(SALT311.StrType)le.amenities4_code,(SALT311.StrType)le.other_buildings1_code,(SALT311.StrType)le.tape_cut_date,(SALT311.StrType)le.certification_date,(SALT311.StrType)le.fips,(SALT311.StrType)le.transfer_date+':'+(SALT311.StrType)le.process_date+':'+(SALT311.StrType)le.transfer_date+'<'+(SALT311.StrType)le.process_date,(SALT311.StrType)le.recording_date+':'+(SALT311.StrType)le.process_date+':'+(SALT311.StrType)le.recording_date+'<'+(SALT311.StrType)le.process_date,(SALT311.StrType)le.sale_date+':'+(SALT311.StrType)le.process_date+':'+(SALT311.StrType)le.sale_date+'<'+(SALT311.StrType)le.process_date,(SALT311.StrType)le.prior_transfer_date+':'+(SALT311.StrType)le.process_date+':'+(SALT311.StrType)le.prior_transfer_date+'<'+(SALT311.StrType)le.process_date,(SALT311.StrType)le.prior_recording_date+':'+(SALT311.StrType)le.process_date+':'+(SALT311.StrType)le.prior_recording_date+'<'+(SALT311.StrType)le.process_date,(SALT311.StrType)le.certification_date+':'+(SALT311.StrType)le.process_date+':'+(SALT311.StrType)le.certification_date+'<'+(SALT311.StrType)le.process_date,(SALT311.StrType)le.tape_cut_date+':'+(SALT311.StrType)le.process_date+':'+(SALT311.StrType)le.tape_cut_date+'<'+(SALT311.StrType)le.process_date,(SALT311.StrType)le.assessed_improvement_value+':'+(SALT311.StrType)le.assessed_total_value+':'+(SALT311.StrType)le.assessed_improvement_value+'<'+(SALT311.StrType)le.assessed_total_value,(SALT311.StrType)le.market_improvement_value+':'+(SALT311.StrType)le.market_total_value+':'+(SALT311.StrType)le.market_improvement_value+'<'+(SALT311.StrType)le.market_total_value,(SALT311.StrType)le.assessed_land_value+':'+(SALT311.StrType)le.assessed_total_value+':'+(SALT311.StrType)le.assessed_land_value+'<='+(SALT311.StrType)le.assessed_total_value,(SALT311.StrType)le.market_land_value+':'+(SALT311.StrType)le.market_total_value+':'+(SALT311.StrType)le.market_land_value+'<='+(SALT311.StrType)le.market_total_value,(SALT311.StrType)le.tax_amount+':'+(SALT311.StrType)le.assessed_total_value+':'+(SALT311.StrType)le.tax_amount+'<='+(SALT311.StrType)le.assessed_total_value,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,108,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_Property_Assessor) prevDS = DATASET([], Layout_Property_Assessor)):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.fips_code;
      SELF.ruledesc := CHOOSE(c
          ,'process_date:invalid_date:ALLOW','process_date:invalid_date:CUSTOM','process_date:invalid_date:LENGTHS'
          ,'fips_code:invalid_fips:ALLOW','fips_code:invalid_fips:LENGTHS','fips_code:invalid_fips:WITHIN_FILE'
          ,'state_code:invalid_state_code:LEFTTRIM','state_code:invalid_state_code:ALLOW','state_code:invalid_state_code:LENGTHS'
          ,'county_name:invalid_county_name:ALLOW','county_name:invalid_county_name:WORDS'
          ,'apna_or_pin_number:invalid_apn:ALLOW','apna_or_pin_number:invalid_apn:LENGTHS'
          ,'assessee_name:invalid_alpha:ALLOW'
          ,'second_assessee_name:invalid_alpha:ALLOW'
          ,'assessee_ownership_rights_code:invalid_ownership_rights_code:CUSTOM'
          ,'assessee_relationship_code:invalid_relationship_code:CUSTOM'
          ,'assessee_phone_number:invalid_phone:ALLOW','assessee_phone_number:invalid_phone:LENGTHS'
          ,'assessee_name_type_code:invalid_name_type_code:CUSTOM'
          ,'second_assessee_name_type_code:invalid_second_name_type_code:CUSTOM'
          ,'mail_care_of_name_type_code:invalid_mail_care_of_name_type_code:CUSTOM'
          ,'mailing_care_of_name:invalid_alpha:ALLOW'
          ,'mailing_full_street_address:invalid_address:ALLOW'
          ,'mailing_unit_number:invalid_address:ALLOW'
          ,'mailing_city_state_zip:invalid_csz:ALLOW'
          ,'property_full_street_address:invalid_address:ALLOW'
          ,'property_unit_number:invalid_address:ALLOW'
          ,'property_city_state_zip:invalid_csz:ALLOW'
          ,'property_address_code:invalid_property_address_code:CUSTOM'
          ,'legal_lot_code:invalid_legal_lot_code:CUSTOM'
          ,'record_type_code:invalid_record_type_code:CUSTOM'
          ,'ownership_type_code:invalid_ownership_type_code:CUSTOM'
          ,'new_record_type_code:invalid_new_record_type_code:CUSTOM'
          ,'standardized_land_use_code:invalid_land_use:CUSTOM'
          ,'transfer_date:invalid_date:ALLOW','transfer_date:invalid_date:CUSTOM','transfer_date:invalid_date:LENGTHS'
          ,'recording_date:invalid_date:ALLOW','recording_date:invalid_date:CUSTOM','recording_date:invalid_date:LENGTHS'
          ,'sale_date:invalid_date:ALLOW','sale_date:invalid_date:CUSTOM','sale_date:invalid_date:LENGTHS'
          ,'document_type:invalid_document_type_code:ALLOW','document_type:invalid_document_type_code:CUSTOM'
          ,'sales_price:invalid_prop_amount:ALLOW'
          ,'sales_price_code:invalid_sale_code:CUSTOM'
          ,'mortgage_loan_amount:invalid_prop_amount:ALLOW'
          ,'mortgage_loan_type_code:invalid_mortgage_loan_type_code:CUSTOM'
          ,'mortgage_lender_name:invalid_alpha:ALLOW'
          ,'mortgage_lender_type_code:invalid_mortgage_lender_type_code:CUSTOM'
          ,'prior_transfer_date:invalid_date:ALLOW','prior_transfer_date:invalid_date:CUSTOM','prior_transfer_date:invalid_date:LENGTHS'
          ,'prior_recording_date:invalid_date:ALLOW','prior_recording_date:invalid_date:CUSTOM','prior_recording_date:invalid_date:LENGTHS'
          ,'prior_sales_price:invalid_prop_amount:ALLOW'
          ,'prior_sales_price_code:invalid_prior_sales_price_code:CUSTOM'
          ,'assessed_land_value:invalid_prop_amount:ALLOW'
          ,'assessed_improvement_value:invalid_prop_amount:ALLOW'
          ,'assessed_total_value:invalid_prop_amount:ALLOW'
          ,'assessed_value_year:invalid_year:CUSTOM'
          ,'market_land_value:invalid_prop_amount:ALLOW'
          ,'market_improvement_value:invalid_prop_amount:ALLOW'
          ,'market_total_value:invalid_prop_amount:ALLOW'
          ,'market_value_year:invalid_year:CUSTOM'
          ,'tax_exemption1_code:invalid_tax_exemption1_code:CUSTOM'
          ,'tax_exemption2_code:invalid_tax_exemption2_code:CUSTOM'
          ,'tax_exemption3_code:invalid_tax_exemption3_code:CUSTOM'
          ,'tax_exemption4_code:invalid_tax_exemption4_code:CUSTOM'
          ,'tax_amount:invalid_tax_amount:ALLOW'
          ,'tax_year:invalid_year:CUSTOM'
          ,'tax_delinquent_year:invalid_year:CUSTOM'
          ,'building_area:invalid_building_area:CUSTOM'
          ,'building_area_indicator:invalid_building_area_indicator:CUSTOM'
          ,'building_area1:invalid_building_area:CUSTOM'
          ,'building_area1_indicator:invalid_building_area1_indicator:CUSTOM'
          ,'building_area2:invalid_building_area:CUSTOM'
          ,'building_area2_indicator:invalid_building_area2_indicator:CUSTOM'
          ,'building_area3:invalid_building_area:CUSTOM'
          ,'building_area3_indicator:invalid_building_area3_indicator:CUSTOM'
          ,'building_area4:invalid_building_area:CUSTOM'
          ,'building_area4_indicator:invalid_building_area4_indicator:CUSTOM'
          ,'building_area5:invalid_building_area:CUSTOM'
          ,'building_area5_indicator:invalid_building_area5_indicator:CUSTOM'
          ,'building_area6:invalid_building_area:CUSTOM'
          ,'building_area6_indicator:invalid_building_area6_indicator:CUSTOM'
          ,'building_area7:invalid_building_area:CUSTOM'
          ,'building_area7_indicator:invalid_building_area7_indicator:CUSTOM'
          ,'year_built:invalid_year:CUSTOM'
          ,'effective_year_built:invalid_year:CUSTOM'
          ,'no_of_stories:invalid_no_of_stories:ALLOW','no_of_stories:invalid_no_of_stories:LENGTHS'
          ,'garage_type_code:invalid_garage_type_code:CUSTOM'
          ,'pool_code:invalid_pool_code:CUSTOM'
          ,'type_construction_code:invalid_construction_type:CUSTOM'
          ,'building_quality_code:invalid_building_quality_code:CUSTOM'
          ,'exterior_walls_code:invalid_exterior_walls_code:CUSTOM'
          ,'roof_type_code:invalid_roof_type_code:CUSTOM'
          ,'floor_cover_code:invalid_floor_cover_code:CUSTOM'
          ,'heating_code:invalid_heating_code:CUSTOM'
          ,'heating_fuel_type_code:invalid_heating_fuel_type_code:CUSTOM'
          ,'air_conditioning_type_code:invalid_air_conditioning_type_code:CUSTOM'
          ,'fireplace_indicator:invalid_fireplace_indicator:CUSTOM'
          ,'basement_code:invalid_basement_code:CUSTOM'
          ,'building_class_code:invalid_building_class_code:CUSTOM'
          ,'site_influence1_code:invalid_site_influence1_code:CUSTOM'
          ,'amenities1_code:invalid_amenities1_code:CUSTOM'
          ,'amenities2_code:invalid_amenities2_code:CUSTOM'
          ,'amenities3_code:invalid_amenities3_code:CUSTOM'
          ,'amenities4_code:invalid_amenities4_code:CUSTOM'
          ,'other_buildings1_code:invalid_other_buildings1_code:CUSTOM'
          ,'tape_cut_date:invalid_date:ALLOW','tape_cut_date:invalid_date:CUSTOM','tape_cut_date:invalid_date:LENGTHS'
          ,'certification_date:invalid_date:ALLOW','certification_date:invalid_date:CUSTOM','certification_date:invalid_date:LENGTHS'
          ,'fips:invalid_fips:ALLOW','fips:invalid_fips:LENGTHS','fips:invalid_fips:WITHIN_FILE'
          ,'trans_before_proc:RECORDTYPE:transfer_date_Invalid','trans_before_proc:RECORDTYPE:process_date_Invalid','trans_before_proc:RECORDTYPE:transfer_date_process_date_Condition_Invalid'
          ,'rec_before_proc:RECORDTYPE:recording_date_Invalid','rec_before_proc:RECORDTYPE:process_date_Invalid','rec_before_proc:RECORDTYPE:recording_date_process_date_Condition_Invalid'
          ,'sale_before_proc:RECORDTYPE:sale_date_Invalid','sale_before_proc:RECORDTYPE:process_date_Invalid','sale_before_proc:RECORDTYPE:sale_date_process_date_Condition_Invalid'
          ,'ptrans_before_proc:RECORDTYPE:prior_transfer_date_Invalid','ptrans_before_proc:RECORDTYPE:process_date_Invalid','ptrans_before_proc:RECORDTYPE:prior_transfer_date_process_date_Condition_Invalid'
          ,'prior_rec_before_proc:RECORDTYPE:prior_recording_date_Invalid','prior_rec_before_proc:RECORDTYPE:process_date_Invalid','prior_rec_before_proc:RECORDTYPE:prior_recording_date_process_date_Condition_Invalid'
          ,'cert_before_proc:RECORDTYPE:certification_date_Invalid','cert_before_proc:RECORDTYPE:process_date_Invalid','cert_before_proc:RECORDTYPE:certification_date_process_date_Condition_Invalid'
          ,'cut_before_proc:RECORDTYPE:tape_cut_date_Invalid','cut_before_proc:RECORDTYPE:process_date_Invalid','cut_before_proc:RECORDTYPE:tape_cut_date_process_date_Condition_Invalid'
          ,'AssImp_Eq_AssTot:RECORDTYPE:assessed_improvement_value_Invalid','AssImp_Eq_AssTot:RECORDTYPE:assessed_total_value_Invalid','AssImp_Eq_AssTot:RECORDTYPE:assessed_improvement_value_assessed_total_value_Condition_Invalid'
          ,'MarImp_Eq_MarTot:RECORDTYPE:market_improvement_value_Invalid','MarImp_Eq_MarTot:RECORDTYPE:market_total_value_Invalid','MarImp_Eq_MarTot:RECORDTYPE:market_improvement_value_market_total_value_Condition_Invalid'
          ,'AssLnd_Eq_AssTot:RECORDTYPE:assessed_land_value_Invalid','AssLnd_Eq_AssTot:RECORDTYPE:assessed_total_value_Invalid','AssLnd_Eq_AssTot:RECORDTYPE:assessed_land_value_assessed_total_value_Condition_Invalid'
          ,'MarLnd_Eq_MarTot:RECORDTYPE:market_land_value_Invalid','MarLnd_Eq_MarTot:RECORDTYPE:market_total_value_Invalid','MarLnd_Eq_MarTot:RECORDTYPE:market_land_value_market_total_value_Condition_Invalid'
          ,'tax_less_than_total_assessed:RECORDTYPE:tax_amount_Invalid','tax_less_than_total_assessed:RECORDTYPE:assessed_total_value_Invalid','tax_less_than_total_assessed:RECORDTYPE:tax_amount_assessed_total_value_Condition_Invalid'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_process_date(1),Fields.InvalidMessage_process_date(2),Fields.InvalidMessage_process_date(3)
          ,Fields.InvalidMessage_fips_code(1),Fields.InvalidMessage_fips_code(2),Fields.InvalidMessage_fips_code(3)
          ,Fields.InvalidMessage_state_code(1),Fields.InvalidMessage_state_code(2),Fields.InvalidMessage_state_code(3)
          ,Fields.InvalidMessage_county_name(1),Fields.InvalidMessage_county_name(2)
          ,Fields.InvalidMessage_apna_or_pin_number(1),Fields.InvalidMessage_apna_or_pin_number(2)
          ,Fields.InvalidMessage_assessee_name(1)
          ,Fields.InvalidMessage_second_assessee_name(1)
          ,Fields.InvalidMessage_assessee_ownership_rights_code(1)
          ,Fields.InvalidMessage_assessee_relationship_code(1)
          ,Fields.InvalidMessage_assessee_phone_number(1),Fields.InvalidMessage_assessee_phone_number(2)
          ,Fields.InvalidMessage_assessee_name_type_code(1)
          ,Fields.InvalidMessage_second_assessee_name_type_code(1)
          ,Fields.InvalidMessage_mail_care_of_name_type_code(1)
          ,Fields.InvalidMessage_mailing_care_of_name(1)
          ,Fields.InvalidMessage_mailing_full_street_address(1)
          ,Fields.InvalidMessage_mailing_unit_number(1)
          ,Fields.InvalidMessage_mailing_city_state_zip(1)
          ,Fields.InvalidMessage_property_full_street_address(1)
          ,Fields.InvalidMessage_property_unit_number(1)
          ,Fields.InvalidMessage_property_city_state_zip(1)
          ,Fields.InvalidMessage_property_address_code(1)
          ,Fields.InvalidMessage_legal_lot_code(1)
          ,Fields.InvalidMessage_record_type_code(1)
          ,Fields.InvalidMessage_ownership_type_code(1)
          ,Fields.InvalidMessage_new_record_type_code(1)
          ,Fields.InvalidMessage_standardized_land_use_code(1)
          ,Fields.InvalidMessage_transfer_date(1),Fields.InvalidMessage_transfer_date(2),Fields.InvalidMessage_transfer_date(3)
          ,Fields.InvalidMessage_recording_date(1),Fields.InvalidMessage_recording_date(2),Fields.InvalidMessage_recording_date(3)
          ,Fields.InvalidMessage_sale_date(1),Fields.InvalidMessage_sale_date(2),Fields.InvalidMessage_sale_date(3)
          ,Fields.InvalidMessage_document_type(1),Fields.InvalidMessage_document_type(2)
          ,Fields.InvalidMessage_sales_price(1)
          ,Fields.InvalidMessage_sales_price_code(1)
          ,Fields.InvalidMessage_mortgage_loan_amount(1)
          ,Fields.InvalidMessage_mortgage_loan_type_code(1)
          ,Fields.InvalidMessage_mortgage_lender_name(1)
          ,Fields.InvalidMessage_mortgage_lender_type_code(1)
          ,Fields.InvalidMessage_prior_transfer_date(1),Fields.InvalidMessage_prior_transfer_date(2),Fields.InvalidMessage_prior_transfer_date(3)
          ,Fields.InvalidMessage_prior_recording_date(1),Fields.InvalidMessage_prior_recording_date(2),Fields.InvalidMessage_prior_recording_date(3)
          ,Fields.InvalidMessage_prior_sales_price(1)
          ,Fields.InvalidMessage_prior_sales_price_code(1)
          ,Fields.InvalidMessage_assessed_land_value(1)
          ,Fields.InvalidMessage_assessed_improvement_value(1)
          ,Fields.InvalidMessage_assessed_total_value(1)
          ,Fields.InvalidMessage_assessed_value_year(1)
          ,Fields.InvalidMessage_market_land_value(1)
          ,Fields.InvalidMessage_market_improvement_value(1)
          ,Fields.InvalidMessage_market_total_value(1)
          ,Fields.InvalidMessage_market_value_year(1)
          ,Fields.InvalidMessage_tax_exemption1_code(1)
          ,Fields.InvalidMessage_tax_exemption2_code(1)
          ,Fields.InvalidMessage_tax_exemption3_code(1)
          ,Fields.InvalidMessage_tax_exemption4_code(1)
          ,Fields.InvalidMessage_tax_amount(1)
          ,Fields.InvalidMessage_tax_year(1)
          ,Fields.InvalidMessage_tax_delinquent_year(1)
          ,Fields.InvalidMessage_building_area(1)
          ,Fields.InvalidMessage_building_area_indicator(1)
          ,Fields.InvalidMessage_building_area1(1)
          ,Fields.InvalidMessage_building_area1_indicator(1)
          ,Fields.InvalidMessage_building_area2(1)
          ,Fields.InvalidMessage_building_area2_indicator(1)
          ,Fields.InvalidMessage_building_area3(1)
          ,Fields.InvalidMessage_building_area3_indicator(1)
          ,Fields.InvalidMessage_building_area4(1)
          ,Fields.InvalidMessage_building_area4_indicator(1)
          ,Fields.InvalidMessage_building_area5(1)
          ,Fields.InvalidMessage_building_area5_indicator(1)
          ,Fields.InvalidMessage_building_area6(1)
          ,Fields.InvalidMessage_building_area6_indicator(1)
          ,Fields.InvalidMessage_building_area7(1)
          ,Fields.InvalidMessage_building_area7_indicator(1)
          ,Fields.InvalidMessage_year_built(1)
          ,Fields.InvalidMessage_effective_year_built(1)
          ,Fields.InvalidMessage_no_of_stories(1),Fields.InvalidMessage_no_of_stories(2)
          ,Fields.InvalidMessage_garage_type_code(1)
          ,Fields.InvalidMessage_pool_code(1)
          ,Fields.InvalidMessage_type_construction_code(1)
          ,Fields.InvalidMessage_building_quality_code(1)
          ,Fields.InvalidMessage_exterior_walls_code(1)
          ,Fields.InvalidMessage_roof_type_code(1)
          ,Fields.InvalidMessage_floor_cover_code(1)
          ,Fields.InvalidMessage_heating_code(1)
          ,Fields.InvalidMessage_heating_fuel_type_code(1)
          ,Fields.InvalidMessage_air_conditioning_type_code(1)
          ,Fields.InvalidMessage_fireplace_indicator(1)
          ,Fields.InvalidMessage_basement_code(1)
          ,Fields.InvalidMessage_building_class_code(1)
          ,Fields.InvalidMessage_site_influence1_code(1)
          ,Fields.InvalidMessage_amenities1_code(1)
          ,Fields.InvalidMessage_amenities2_code(1)
          ,Fields.InvalidMessage_amenities3_code(1)
          ,Fields.InvalidMessage_amenities4_code(1)
          ,Fields.InvalidMessage_other_buildings1_code(1)
          ,Fields.InvalidMessage_tape_cut_date(1),Fields.InvalidMessage_tape_cut_date(2),Fields.InvalidMessage_tape_cut_date(3)
          ,Fields.InvalidMessage_certification_date(1),Fields.InvalidMessage_certification_date(2),Fields.InvalidMessage_certification_date(3)
          ,Fields.InvalidMessage_fips(1),Fields.InvalidMessage_fips(2),Fields.InvalidMessage_fips(3)
          ,InvalidMessage_trans_before_proc(1),InvalidMessage_trans_before_proc(2),InvalidMessage_trans_before_proc(3)
          ,InvalidMessage_rec_before_proc(1),InvalidMessage_rec_before_proc(2),InvalidMessage_rec_before_proc(3)
          ,InvalidMessage_sale_before_proc(1),InvalidMessage_sale_before_proc(2),InvalidMessage_sale_before_proc(3)
          ,InvalidMessage_ptrans_before_proc(1),InvalidMessage_ptrans_before_proc(2),InvalidMessage_ptrans_before_proc(3)
          ,InvalidMessage_prior_rec_before_proc(1),InvalidMessage_prior_rec_before_proc(2),InvalidMessage_prior_rec_before_proc(3)
          ,InvalidMessage_cert_before_proc(1),InvalidMessage_cert_before_proc(2),InvalidMessage_cert_before_proc(3)
          ,InvalidMessage_cut_before_proc(1),InvalidMessage_cut_before_proc(2),InvalidMessage_cut_before_proc(3)
          ,InvalidMessage_AssImp_Eq_AssTot(1),InvalidMessage_AssImp_Eq_AssTot(2),InvalidMessage_AssImp_Eq_AssTot(3)
          ,InvalidMessage_MarImp_Eq_MarTot(1),InvalidMessage_MarImp_Eq_MarTot(2),InvalidMessage_MarImp_Eq_MarTot(3)
          ,InvalidMessage_AssLnd_Eq_AssTot(1),InvalidMessage_AssLnd_Eq_AssTot(2),InvalidMessage_AssLnd_Eq_AssTot(3)
          ,InvalidMessage_MarLnd_Eq_MarTot(1),InvalidMessage_MarLnd_Eq_MarTot(2),InvalidMessage_MarLnd_Eq_MarTot(3)
          ,InvalidMessage_tax_less_than_total_assessed(1),InvalidMessage_tax_less_than_total_assessed(2),InvalidMessage_tax_less_than_total_assessed(3)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.process_date_ALLOW_ErrorCount,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTHS_ErrorCount
          ,le.fips_code_ALLOW_ErrorCount,le.fips_code_LENGTHS_ErrorCount,le.fips_code_WITHIN_FILE_ErrorCount
          ,le.state_code_LEFTTRIM_ErrorCount,le.state_code_ALLOW_ErrorCount,le.state_code_LENGTHS_ErrorCount
          ,le.county_name_ALLOW_ErrorCount,le.county_name_WORDS_ErrorCount
          ,le.apna_or_pin_number_ALLOW_ErrorCount,le.apna_or_pin_number_LENGTHS_ErrorCount
          ,le.assessee_name_ALLOW_ErrorCount
          ,le.second_assessee_name_ALLOW_ErrorCount
          ,le.assessee_ownership_rights_code_CUSTOM_ErrorCount
          ,le.assessee_relationship_code_CUSTOM_ErrorCount
          ,le.assessee_phone_number_ALLOW_ErrorCount,le.assessee_phone_number_LENGTHS_ErrorCount
          ,le.assessee_name_type_code_CUSTOM_ErrorCount
          ,le.second_assessee_name_type_code_CUSTOM_ErrorCount
          ,le.mail_care_of_name_type_code_CUSTOM_ErrorCount
          ,le.mailing_care_of_name_ALLOW_ErrorCount
          ,le.mailing_full_street_address_ALLOW_ErrorCount
          ,le.mailing_unit_number_ALLOW_ErrorCount
          ,le.mailing_city_state_zip_ALLOW_ErrorCount
          ,le.property_full_street_address_ALLOW_ErrorCount
          ,le.property_unit_number_ALLOW_ErrorCount
          ,le.property_city_state_zip_ALLOW_ErrorCount
          ,le.property_address_code_CUSTOM_ErrorCount
          ,le.legal_lot_code_CUSTOM_ErrorCount
          ,le.record_type_code_CUSTOM_ErrorCount
          ,le.ownership_type_code_CUSTOM_ErrorCount
          ,le.new_record_type_code_CUSTOM_ErrorCount
          ,le.standardized_land_use_code_CUSTOM_ErrorCount
          ,le.transfer_date_ALLOW_ErrorCount,le.transfer_date_CUSTOM_ErrorCount,le.transfer_date_LENGTHS_ErrorCount
          ,le.recording_date_ALLOW_ErrorCount,le.recording_date_CUSTOM_ErrorCount,le.recording_date_LENGTHS_ErrorCount
          ,le.sale_date_ALLOW_ErrorCount,le.sale_date_CUSTOM_ErrorCount,le.sale_date_LENGTHS_ErrorCount
          ,le.document_type_ALLOW_ErrorCount,le.document_type_CUSTOM_ErrorCount
          ,le.sales_price_ALLOW_ErrorCount
          ,le.sales_price_code_CUSTOM_ErrorCount
          ,le.mortgage_loan_amount_ALLOW_ErrorCount
          ,le.mortgage_loan_type_code_CUSTOM_ErrorCount
          ,le.mortgage_lender_name_ALLOW_ErrorCount
          ,le.mortgage_lender_type_code_CUSTOM_ErrorCount
          ,le.prior_transfer_date_ALLOW_ErrorCount,le.prior_transfer_date_CUSTOM_ErrorCount,le.prior_transfer_date_LENGTHS_ErrorCount
          ,le.prior_recording_date_ALLOW_ErrorCount,le.prior_recording_date_CUSTOM_ErrorCount,le.prior_recording_date_LENGTHS_ErrorCount
          ,le.prior_sales_price_ALLOW_ErrorCount
          ,le.prior_sales_price_code_CUSTOM_ErrorCount
          ,le.assessed_land_value_ALLOW_ErrorCount
          ,le.assessed_improvement_value_ALLOW_ErrorCount
          ,le.assessed_total_value_ALLOW_ErrorCount
          ,le.assessed_value_year_CUSTOM_ErrorCount
          ,le.market_land_value_ALLOW_ErrorCount
          ,le.market_improvement_value_ALLOW_ErrorCount
          ,le.market_total_value_ALLOW_ErrorCount
          ,le.market_value_year_CUSTOM_ErrorCount
          ,le.tax_exemption1_code_CUSTOM_ErrorCount
          ,le.tax_exemption2_code_CUSTOM_ErrorCount
          ,le.tax_exemption3_code_CUSTOM_ErrorCount
          ,le.tax_exemption4_code_CUSTOM_ErrorCount
          ,le.tax_amount_ALLOW_ErrorCount
          ,le.tax_year_CUSTOM_ErrorCount
          ,le.tax_delinquent_year_CUSTOM_ErrorCount
          ,le.building_area_CUSTOM_ErrorCount
          ,le.building_area_indicator_CUSTOM_ErrorCount
          ,le.building_area1_CUSTOM_ErrorCount
          ,le.building_area1_indicator_CUSTOM_ErrorCount
          ,le.building_area2_CUSTOM_ErrorCount
          ,le.building_area2_indicator_CUSTOM_ErrorCount
          ,le.building_area3_CUSTOM_ErrorCount
          ,le.building_area3_indicator_CUSTOM_ErrorCount
          ,le.building_area4_CUSTOM_ErrorCount
          ,le.building_area4_indicator_CUSTOM_ErrorCount
          ,le.building_area5_CUSTOM_ErrorCount
          ,le.building_area5_indicator_CUSTOM_ErrorCount
          ,le.building_area6_CUSTOM_ErrorCount
          ,le.building_area6_indicator_CUSTOM_ErrorCount
          ,le.building_area7_CUSTOM_ErrorCount
          ,le.building_area7_indicator_CUSTOM_ErrorCount
          ,le.year_built_CUSTOM_ErrorCount
          ,le.effective_year_built_CUSTOM_ErrorCount
          ,le.no_of_stories_ALLOW_ErrorCount,le.no_of_stories_LENGTHS_ErrorCount
          ,le.garage_type_code_CUSTOM_ErrorCount
          ,le.pool_code_CUSTOM_ErrorCount
          ,le.type_construction_code_CUSTOM_ErrorCount
          ,le.building_quality_code_CUSTOM_ErrorCount
          ,le.exterior_walls_code_CUSTOM_ErrorCount
          ,le.roof_type_code_CUSTOM_ErrorCount
          ,le.floor_cover_code_CUSTOM_ErrorCount
          ,le.heating_code_CUSTOM_ErrorCount
          ,le.heating_fuel_type_code_CUSTOM_ErrorCount
          ,le.air_conditioning_type_code_CUSTOM_ErrorCount
          ,le.fireplace_indicator_CUSTOM_ErrorCount
          ,le.basement_code_CUSTOM_ErrorCount
          ,le.building_class_code_CUSTOM_ErrorCount
          ,le.site_influence1_code_CUSTOM_ErrorCount
          ,le.amenities1_code_CUSTOM_ErrorCount
          ,le.amenities2_code_CUSTOM_ErrorCount
          ,le.amenities3_code_CUSTOM_ErrorCount
          ,le.amenities4_code_CUSTOM_ErrorCount
          ,le.other_buildings1_code_CUSTOM_ErrorCount
          ,le.tape_cut_date_ALLOW_ErrorCount,le.tape_cut_date_CUSTOM_ErrorCount,le.tape_cut_date_LENGTHS_ErrorCount
          ,le.certification_date_ALLOW_ErrorCount,le.certification_date_CUSTOM_ErrorCount,le.certification_date_LENGTHS_ErrorCount
          ,le.fips_ALLOW_ErrorCount,le.fips_LENGTHS_ErrorCount,le.fips_WITHIN_FILE_ErrorCount
          ,le.trans_before_proc_transfer_date_Invalid_ErrorCount,le.trans_before_proc_process_date_Invalid_ErrorCount,le.trans_before_proc_transfer_date_process_date_Condition_Invalid_ErrorCount
          ,le.rec_before_proc_recording_date_Invalid_ErrorCount,le.rec_before_proc_process_date_Invalid_ErrorCount,le.rec_before_proc_recording_date_process_date_Condition_Invalid_ErrorCount
          ,le.sale_before_proc_sale_date_Invalid_ErrorCount,le.sale_before_proc_process_date_Invalid_ErrorCount,le.sale_before_proc_sale_date_process_date_Condition_Invalid_ErrorCount
          ,le.ptrans_before_proc_prior_transfer_date_Invalid_ErrorCount,le.ptrans_before_proc_process_date_Invalid_ErrorCount,le.ptrans_before_proc_prior_transfer_date_process_date_Condition_Invalid_ErrorCount
          ,le.prior_rec_before_proc_prior_recording_date_Invalid_ErrorCount,le.prior_rec_before_proc_process_date_Invalid_ErrorCount,le.prior_rec_before_proc_prior_recording_date_process_date_Condition_Invalid_ErrorCount
          ,le.cert_before_proc_certification_date_Invalid_ErrorCount,le.cert_before_proc_process_date_Invalid_ErrorCount,le.cert_before_proc_certification_date_process_date_Condition_Invalid_ErrorCount
          ,le.cut_before_proc_tape_cut_date_Invalid_ErrorCount,le.cut_before_proc_process_date_Invalid_ErrorCount,le.cut_before_proc_tape_cut_date_process_date_Condition_Invalid_ErrorCount
          ,le.AssImp_Eq_AssTot_assessed_improvement_value_Invalid_ErrorCount,le.AssImp_Eq_AssTot_assessed_total_value_Invalid_ErrorCount,le.AssImp_Eq_AssTot_assessed_improvement_value_assessed_total_value_Condition_Invalid_ErrorCount
          ,le.MarImp_Eq_MarTot_market_improvement_value_Invalid_ErrorCount,le.MarImp_Eq_MarTot_market_total_value_Invalid_ErrorCount,le.MarImp_Eq_MarTot_market_improvement_value_market_total_value_Condition_Invalid_ErrorCount
          ,le.AssLnd_Eq_AssTot_assessed_land_value_Invalid_ErrorCount,le.AssLnd_Eq_AssTot_assessed_total_value_Invalid_ErrorCount,le.AssLnd_Eq_AssTot_assessed_land_value_assessed_total_value_Condition_Invalid_ErrorCount
          ,le.MarLnd_Eq_MarTot_market_land_value_Invalid_ErrorCount,le.MarLnd_Eq_MarTot_market_total_value_Invalid_ErrorCount,le.MarLnd_Eq_MarTot_market_land_value_market_total_value_Condition_Invalid_ErrorCount
          ,le.tax_less_than_total_assessed_tax_amount_Invalid_ErrorCount,le.tax_less_than_total_assessed_assessed_total_value_Invalid_ErrorCount,le.tax_less_than_total_assessed_tax_amount_assessed_total_value_Condition_Invalid_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.process_date_ALLOW_ErrorCount,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTHS_ErrorCount
          ,le.fips_code_ALLOW_ErrorCount,le.fips_code_LENGTHS_ErrorCount,le.fips_code_WITHIN_FILE_ErrorCount
          ,le.state_code_LEFTTRIM_ErrorCount,le.state_code_ALLOW_ErrorCount,le.state_code_LENGTHS_ErrorCount
          ,le.county_name_ALLOW_ErrorCount,le.county_name_WORDS_ErrorCount
          ,le.apna_or_pin_number_ALLOW_ErrorCount,le.apna_or_pin_number_LENGTHS_ErrorCount
          ,le.assessee_name_ALLOW_ErrorCount
          ,le.second_assessee_name_ALLOW_ErrorCount
          ,le.assessee_ownership_rights_code_CUSTOM_ErrorCount
          ,le.assessee_relationship_code_CUSTOM_ErrorCount
          ,le.assessee_phone_number_ALLOW_ErrorCount,le.assessee_phone_number_LENGTHS_ErrorCount
          ,le.assessee_name_type_code_CUSTOM_ErrorCount
          ,le.second_assessee_name_type_code_CUSTOM_ErrorCount
          ,le.mail_care_of_name_type_code_CUSTOM_ErrorCount
          ,le.mailing_care_of_name_ALLOW_ErrorCount
          ,le.mailing_full_street_address_ALLOW_ErrorCount
          ,le.mailing_unit_number_ALLOW_ErrorCount
          ,le.mailing_city_state_zip_ALLOW_ErrorCount
          ,le.property_full_street_address_ALLOW_ErrorCount
          ,le.property_unit_number_ALLOW_ErrorCount
          ,le.property_city_state_zip_ALLOW_ErrorCount
          ,le.property_address_code_CUSTOM_ErrorCount
          ,le.legal_lot_code_CUSTOM_ErrorCount
          ,le.record_type_code_CUSTOM_ErrorCount
          ,le.ownership_type_code_CUSTOM_ErrorCount
          ,le.new_record_type_code_CUSTOM_ErrorCount
          ,le.standardized_land_use_code_CUSTOM_ErrorCount
          ,le.transfer_date_ALLOW_ErrorCount,le.transfer_date_CUSTOM_ErrorCount,le.transfer_date_LENGTHS_ErrorCount
          ,le.recording_date_ALLOW_ErrorCount,le.recording_date_CUSTOM_ErrorCount,le.recording_date_LENGTHS_ErrorCount
          ,le.sale_date_ALLOW_ErrorCount,le.sale_date_CUSTOM_ErrorCount,le.sale_date_LENGTHS_ErrorCount
          ,le.document_type_ALLOW_ErrorCount,le.document_type_CUSTOM_ErrorCount
          ,le.sales_price_ALLOW_ErrorCount
          ,le.sales_price_code_CUSTOM_ErrorCount
          ,le.mortgage_loan_amount_ALLOW_ErrorCount
          ,le.mortgage_loan_type_code_CUSTOM_ErrorCount
          ,le.mortgage_lender_name_ALLOW_ErrorCount
          ,le.mortgage_lender_type_code_CUSTOM_ErrorCount
          ,le.prior_transfer_date_ALLOW_ErrorCount,le.prior_transfer_date_CUSTOM_ErrorCount,le.prior_transfer_date_LENGTHS_ErrorCount
          ,le.prior_recording_date_ALLOW_ErrorCount,le.prior_recording_date_CUSTOM_ErrorCount,le.prior_recording_date_LENGTHS_ErrorCount
          ,le.prior_sales_price_ALLOW_ErrorCount
          ,le.prior_sales_price_code_CUSTOM_ErrorCount
          ,le.assessed_land_value_ALLOW_ErrorCount
          ,le.assessed_improvement_value_ALLOW_ErrorCount
          ,le.assessed_total_value_ALLOW_ErrorCount
          ,le.assessed_value_year_CUSTOM_ErrorCount
          ,le.market_land_value_ALLOW_ErrorCount
          ,le.market_improvement_value_ALLOW_ErrorCount
          ,le.market_total_value_ALLOW_ErrorCount
          ,le.market_value_year_CUSTOM_ErrorCount
          ,le.tax_exemption1_code_CUSTOM_ErrorCount
          ,le.tax_exemption2_code_CUSTOM_ErrorCount
          ,le.tax_exemption3_code_CUSTOM_ErrorCount
          ,le.tax_exemption4_code_CUSTOM_ErrorCount
          ,le.tax_amount_ALLOW_ErrorCount
          ,le.tax_year_CUSTOM_ErrorCount
          ,le.tax_delinquent_year_CUSTOM_ErrorCount
          ,le.building_area_CUSTOM_ErrorCount
          ,le.building_area_indicator_CUSTOM_ErrorCount
          ,le.building_area1_CUSTOM_ErrorCount
          ,le.building_area1_indicator_CUSTOM_ErrorCount
          ,le.building_area2_CUSTOM_ErrorCount
          ,le.building_area2_indicator_CUSTOM_ErrorCount
          ,le.building_area3_CUSTOM_ErrorCount
          ,le.building_area3_indicator_CUSTOM_ErrorCount
          ,le.building_area4_CUSTOM_ErrorCount
          ,le.building_area4_indicator_CUSTOM_ErrorCount
          ,le.building_area5_CUSTOM_ErrorCount
          ,le.building_area5_indicator_CUSTOM_ErrorCount
          ,le.building_area6_CUSTOM_ErrorCount
          ,le.building_area6_indicator_CUSTOM_ErrorCount
          ,le.building_area7_CUSTOM_ErrorCount
          ,le.building_area7_indicator_CUSTOM_ErrorCount
          ,le.year_built_CUSTOM_ErrorCount
          ,le.effective_year_built_CUSTOM_ErrorCount
          ,le.no_of_stories_ALLOW_ErrorCount,le.no_of_stories_LENGTHS_ErrorCount
          ,le.garage_type_code_CUSTOM_ErrorCount
          ,le.pool_code_CUSTOM_ErrorCount
          ,le.type_construction_code_CUSTOM_ErrorCount
          ,le.building_quality_code_CUSTOM_ErrorCount
          ,le.exterior_walls_code_CUSTOM_ErrorCount
          ,le.roof_type_code_CUSTOM_ErrorCount
          ,le.floor_cover_code_CUSTOM_ErrorCount
          ,le.heating_code_CUSTOM_ErrorCount
          ,le.heating_fuel_type_code_CUSTOM_ErrorCount
          ,le.air_conditioning_type_code_CUSTOM_ErrorCount
          ,le.fireplace_indicator_CUSTOM_ErrorCount
          ,le.basement_code_CUSTOM_ErrorCount
          ,le.building_class_code_CUSTOM_ErrorCount
          ,le.site_influence1_code_CUSTOM_ErrorCount
          ,le.amenities1_code_CUSTOM_ErrorCount
          ,le.amenities2_code_CUSTOM_ErrorCount
          ,le.amenities3_code_CUSTOM_ErrorCount
          ,le.amenities4_code_CUSTOM_ErrorCount
          ,le.other_buildings1_code_CUSTOM_ErrorCount
          ,le.tape_cut_date_ALLOW_ErrorCount,le.tape_cut_date_CUSTOM_ErrorCount,le.tape_cut_date_LENGTHS_ErrorCount
          ,le.certification_date_ALLOW_ErrorCount,le.certification_date_CUSTOM_ErrorCount,le.certification_date_LENGTHS_ErrorCount
          ,le.fips_ALLOW_ErrorCount,le.fips_LENGTHS_ErrorCount,le.fips_WITHIN_FILE_ErrorCount
          ,le.trans_before_proc_transfer_date_Invalid_ErrorCount,le.trans_before_proc_process_date_Invalid_ErrorCount,le.trans_before_proc_transfer_date_process_date_Condition_Invalid_ErrorCount
          ,le.rec_before_proc_recording_date_Invalid_ErrorCount,le.rec_before_proc_process_date_Invalid_ErrorCount,le.rec_before_proc_recording_date_process_date_Condition_Invalid_ErrorCount
          ,le.sale_before_proc_sale_date_Invalid_ErrorCount,le.sale_before_proc_process_date_Invalid_ErrorCount,le.sale_before_proc_sale_date_process_date_Condition_Invalid_ErrorCount
          ,le.ptrans_before_proc_prior_transfer_date_Invalid_ErrorCount,le.ptrans_before_proc_process_date_Invalid_ErrorCount,le.ptrans_before_proc_prior_transfer_date_process_date_Condition_Invalid_ErrorCount
          ,le.prior_rec_before_proc_prior_recording_date_Invalid_ErrorCount,le.prior_rec_before_proc_process_date_Invalid_ErrorCount,le.prior_rec_before_proc_prior_recording_date_process_date_Condition_Invalid_ErrorCount
          ,le.cert_before_proc_certification_date_Invalid_ErrorCount,le.cert_before_proc_process_date_Invalid_ErrorCount,le.cert_before_proc_certification_date_process_date_Condition_Invalid_ErrorCount
          ,le.cut_before_proc_tape_cut_date_Invalid_ErrorCount,le.cut_before_proc_process_date_Invalid_ErrorCount,le.cut_before_proc_tape_cut_date_process_date_Condition_Invalid_ErrorCount
          ,le.AssImp_Eq_AssTot_assessed_improvement_value_Invalid_ErrorCount,le.AssImp_Eq_AssTot_assessed_total_value_Invalid_ErrorCount,le.AssImp_Eq_AssTot_assessed_improvement_value_assessed_total_value_Condition_Invalid_ErrorCount
          ,le.MarImp_Eq_MarTot_market_improvement_value_Invalid_ErrorCount,le.MarImp_Eq_MarTot_market_total_value_Invalid_ErrorCount,le.MarImp_Eq_MarTot_market_improvement_value_market_total_value_Condition_Invalid_ErrorCount
          ,le.AssLnd_Eq_AssTot_assessed_land_value_Invalid_ErrorCount,le.AssLnd_Eq_AssTot_assessed_total_value_Invalid_ErrorCount,le.AssLnd_Eq_AssTot_assessed_land_value_assessed_total_value_Condition_Invalid_ErrorCount
          ,le.MarLnd_Eq_MarTot_market_land_value_Invalid_ErrorCount,le.MarLnd_Eq_MarTot_market_total_value_Invalid_ErrorCount,le.MarLnd_Eq_MarTot_market_land_value_market_total_value_Condition_Invalid_ErrorCount
          ,le.tax_less_than_total_assessed_tax_amount_Invalid_ErrorCount,le.tax_less_than_total_assessed_assessed_total_value_Invalid_ErrorCount,le.tax_less_than_total_assessed_tax_amount_assessed_total_value_Condition_Invalid_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 7,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT311.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT311.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    jGlob := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    jSrc := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    j := IF(Glob, jGlob, jSrc);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := hygiene(PROJECT(h, Layout_Property_Assessor));
    hygiene_summaryStats := mod_hygiene.Summary('', Glob);
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.Source;
      SELF.ruledesc := CHOOSE(c
          ,'ln_fares_id:' + getFieldTypeText(h.ln_fares_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'process_date:' + getFieldTypeText(h.process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendor_source_flag:' + getFieldTypeText(h.vendor_source_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'current_record:' + getFieldTypeText(h.current_record) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_code:' + getFieldTypeText(h.fips_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state_code:' + getFieldTypeText(h.state_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county_name:' + getFieldTypeText(h.county_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'old_apn:' + getFieldTypeText(h.old_apn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'apna_or_pin_number:' + getFieldTypeText(h.apna_or_pin_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fares_unformatted_apn:' + getFieldTypeText(h.fares_unformatted_apn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'duplicate_apn_multiple_address_id:' + getFieldTypeText(h.duplicate_apn_multiple_address_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessee_name:' + getFieldTypeText(h.assessee_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'second_assessee_name:' + getFieldTypeText(h.second_assessee_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessee_ownership_rights_code:' + getFieldTypeText(h.assessee_ownership_rights_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessee_relationship_code:' + getFieldTypeText(h.assessee_relationship_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessee_phone_number:' + getFieldTypeText(h.assessee_phone_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_account_number:' + getFieldTypeText(h.tax_account_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contract_owner:' + getFieldTypeText(h.contract_owner) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessee_name_type_code:' + getFieldTypeText(h.assessee_name_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'second_assessee_name_type_code:' + getFieldTypeText(h.second_assessee_name_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_care_of_name_type_code:' + getFieldTypeText(h.mail_care_of_name_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_care_of_name:' + getFieldTypeText(h.mailing_care_of_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_full_street_address:' + getFieldTypeText(h.mailing_full_street_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_unit_number:' + getFieldTypeText(h.mailing_unit_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_city_state_zip:' + getFieldTypeText(h.mailing_city_state_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'property_full_street_address:' + getFieldTypeText(h.property_full_street_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'property_unit_number:' + getFieldTypeText(h.property_unit_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'property_city_state_zip:' + getFieldTypeText(h.property_city_state_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'property_country_code:' + getFieldTypeText(h.property_country_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'property_address_code:' + getFieldTypeText(h.property_address_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_lot_code:' + getFieldTypeText(h.legal_lot_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_lot_number:' + getFieldTypeText(h.legal_lot_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_land_lot:' + getFieldTypeText(h.legal_land_lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_block:' + getFieldTypeText(h.legal_block) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_section:' + getFieldTypeText(h.legal_section) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_district:' + getFieldTypeText(h.legal_district) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_unit:' + getFieldTypeText(h.legal_unit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_city_municipality_township:' + getFieldTypeText(h.legal_city_municipality_township) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_subdivision_name:' + getFieldTypeText(h.legal_subdivision_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_phase_number:' + getFieldTypeText(h.legal_phase_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_tract_number:' + getFieldTypeText(h.legal_tract_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_sec_twn_rng_mer:' + getFieldTypeText(h.legal_sec_twn_rng_mer) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_brief_description:' + getFieldTypeText(h.legal_brief_description) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_assessor_map_ref:' + getFieldTypeText(h.legal_assessor_map_ref) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'census_tract:' + getFieldTypeText(h.census_tract) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_type_code:' + getFieldTypeText(h.record_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ownership_type_code:' + getFieldTypeText(h.ownership_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'new_record_type_code:' + getFieldTypeText(h.new_record_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state_land_use_code:' + getFieldTypeText(h.state_land_use_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county_land_use_code:' + getFieldTypeText(h.county_land_use_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county_land_use_description:' + getFieldTypeText(h.county_land_use_description) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'standardized_land_use_code:' + getFieldTypeText(h.standardized_land_use_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'timeshare_code:' + getFieldTypeText(h.timeshare_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zoning:' + getFieldTypeText(h.zoning) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'owner_occupied:' + getFieldTypeText(h.owner_occupied) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recorder_document_number:' + getFieldTypeText(h.recorder_document_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recorder_book_number:' + getFieldTypeText(h.recorder_book_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recorder_page_number:' + getFieldTypeText(h.recorder_page_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'transfer_date:' + getFieldTypeText(h.transfer_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recording_date:' + getFieldTypeText(h.recording_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sale_date:' + getFieldTypeText(h.sale_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'document_type:' + getFieldTypeText(h.document_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sales_price:' + getFieldTypeText(h.sales_price) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sales_price_code:' + getFieldTypeText(h.sales_price_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mortgage_loan_amount:' + getFieldTypeText(h.mortgage_loan_amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mortgage_loan_type_code:' + getFieldTypeText(h.mortgage_loan_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mortgage_lender_name:' + getFieldTypeText(h.mortgage_lender_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mortgage_lender_type_code:' + getFieldTypeText(h.mortgage_lender_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prior_transfer_date:' + getFieldTypeText(h.prior_transfer_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prior_recording_date:' + getFieldTypeText(h.prior_recording_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prior_sales_price:' + getFieldTypeText(h.prior_sales_price) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prior_sales_price_code:' + getFieldTypeText(h.prior_sales_price_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessed_land_value:' + getFieldTypeText(h.assessed_land_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessed_improvement_value:' + getFieldTypeText(h.assessed_improvement_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessed_total_value:' + getFieldTypeText(h.assessed_total_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessed_value_year:' + getFieldTypeText(h.assessed_value_year) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'market_land_value:' + getFieldTypeText(h.market_land_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'market_improvement_value:' + getFieldTypeText(h.market_improvement_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'market_total_value:' + getFieldTypeText(h.market_total_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'market_value_year:' + getFieldTypeText(h.market_value_year) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'homestead_homeowner_exemption:' + getFieldTypeText(h.homestead_homeowner_exemption) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_exemption1_code:' + getFieldTypeText(h.tax_exemption1_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_exemption2_code:' + getFieldTypeText(h.tax_exemption2_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_exemption3_code:' + getFieldTypeText(h.tax_exemption3_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_exemption4_code:' + getFieldTypeText(h.tax_exemption4_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_rate_code_area:' + getFieldTypeText(h.tax_rate_code_area) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_amount:' + getFieldTypeText(h.tax_amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_year:' + getFieldTypeText(h.tax_year) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_delinquent_year:' + getFieldTypeText(h.tax_delinquent_year) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'school_tax_district1:' + getFieldTypeText(h.school_tax_district1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'school_tax_district1_indicator:' + getFieldTypeText(h.school_tax_district1_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'school_tax_district2:' + getFieldTypeText(h.school_tax_district2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'school_tax_district2_indicator:' + getFieldTypeText(h.school_tax_district2_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'school_tax_district3:' + getFieldTypeText(h.school_tax_district3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'school_tax_district3_indicator:' + getFieldTypeText(h.school_tax_district3_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_size:' + getFieldTypeText(h.lot_size) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_size_acres:' + getFieldTypeText(h.lot_size_acres) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_size_frontage_feet:' + getFieldTypeText(h.lot_size_frontage_feet) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_size_depth_feet:' + getFieldTypeText(h.lot_size_depth_feet) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'land_acres:' + getFieldTypeText(h.land_acres) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'land_square_footage:' + getFieldTypeText(h.land_square_footage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'land_dimensions:' + getFieldTypeText(h.land_dimensions) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'building_area:' + getFieldTypeText(h.building_area) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'building_area_indicator:' + getFieldTypeText(h.building_area_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'building_area1:' + getFieldTypeText(h.building_area1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'building_area1_indicator:' + getFieldTypeText(h.building_area1_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'building_area2:' + getFieldTypeText(h.building_area2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'building_area2_indicator:' + getFieldTypeText(h.building_area2_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'building_area3:' + getFieldTypeText(h.building_area3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'building_area3_indicator:' + getFieldTypeText(h.building_area3_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'building_area4:' + getFieldTypeText(h.building_area4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'building_area4_indicator:' + getFieldTypeText(h.building_area4_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'building_area5:' + getFieldTypeText(h.building_area5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'building_area5_indicator:' + getFieldTypeText(h.building_area5_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'building_area6:' + getFieldTypeText(h.building_area6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'building_area6_indicator:' + getFieldTypeText(h.building_area6_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'building_area7:' + getFieldTypeText(h.building_area7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'building_area7_indicator:' + getFieldTypeText(h.building_area7_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'year_built:' + getFieldTypeText(h.year_built) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'effective_year_built:' + getFieldTypeText(h.effective_year_built) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'no_of_buildings:' + getFieldTypeText(h.no_of_buildings) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'no_of_stories:' + getFieldTypeText(h.no_of_stories) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'no_of_units:' + getFieldTypeText(h.no_of_units) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'no_of_rooms:' + getFieldTypeText(h.no_of_rooms) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'no_of_bedrooms:' + getFieldTypeText(h.no_of_bedrooms) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'no_of_baths:' + getFieldTypeText(h.no_of_baths) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'no_of_partial_baths:' + getFieldTypeText(h.no_of_partial_baths) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'no_of_plumbing_fixtures:' + getFieldTypeText(h.no_of_plumbing_fixtures) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'garage_type_code:' + getFieldTypeText(h.garage_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'parking_no_of_cars:' + getFieldTypeText(h.parking_no_of_cars) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pool_code:' + getFieldTypeText(h.pool_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'style_code:' + getFieldTypeText(h.style_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'type_construction_code:' + getFieldTypeText(h.type_construction_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'foundation_code:' + getFieldTypeText(h.foundation_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'building_quality_code:' + getFieldTypeText(h.building_quality_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'building_condition_code:' + getFieldTypeText(h.building_condition_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'exterior_walls_code:' + getFieldTypeText(h.exterior_walls_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'interior_walls_code:' + getFieldTypeText(h.interior_walls_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'roof_cover_code:' + getFieldTypeText(h.roof_cover_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'roof_type_code:' + getFieldTypeText(h.roof_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'floor_cover_code:' + getFieldTypeText(h.floor_cover_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'water_code:' + getFieldTypeText(h.water_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sewer_code:' + getFieldTypeText(h.sewer_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'heating_code:' + getFieldTypeText(h.heating_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'heating_fuel_type_code:' + getFieldTypeText(h.heating_fuel_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'air_conditioning_code:' + getFieldTypeText(h.air_conditioning_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'air_conditioning_type_code:' + getFieldTypeText(h.air_conditioning_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'elevator:' + getFieldTypeText(h.elevator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fireplace_indicator:' + getFieldTypeText(h.fireplace_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fireplace_number:' + getFieldTypeText(h.fireplace_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'basement_code:' + getFieldTypeText(h.basement_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'building_class_code:' + getFieldTypeText(h.building_class_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'site_influence1_code:' + getFieldTypeText(h.site_influence1_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'site_influence2_code:' + getFieldTypeText(h.site_influence2_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'site_influence3_code:' + getFieldTypeText(h.site_influence3_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'site_influence4_code:' + getFieldTypeText(h.site_influence4_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'site_influence5_code:' + getFieldTypeText(h.site_influence5_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'amenities1_code:' + getFieldTypeText(h.amenities1_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'amenities2_code:' + getFieldTypeText(h.amenities2_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'amenities3_code:' + getFieldTypeText(h.amenities3_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'amenities4_code:' + getFieldTypeText(h.amenities4_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'amenities5_code:' + getFieldTypeText(h.amenities5_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'amenities2_code1:' + getFieldTypeText(h.amenities2_code1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'amenities2_code2:' + getFieldTypeText(h.amenities2_code2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'amenities2_code3:' + getFieldTypeText(h.amenities2_code3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'amenities2_code4:' + getFieldTypeText(h.amenities2_code4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'amenities2_code5:' + getFieldTypeText(h.amenities2_code5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'extra_features1_area:' + getFieldTypeText(h.extra_features1_area) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'extra_features1_indicator:' + getFieldTypeText(h.extra_features1_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'extra_features2_area:' + getFieldTypeText(h.extra_features2_area) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'extra_features2_indicator:' + getFieldTypeText(h.extra_features2_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'extra_features3_area:' + getFieldTypeText(h.extra_features3_area) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'extra_features3_indicator:' + getFieldTypeText(h.extra_features3_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'extra_features4_area:' + getFieldTypeText(h.extra_features4_area) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'extra_features4_indicator:' + getFieldTypeText(h.extra_features4_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other_buildings1_code:' + getFieldTypeText(h.other_buildings1_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other_buildings2_code:' + getFieldTypeText(h.other_buildings2_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other_buildings3_code:' + getFieldTypeText(h.other_buildings3_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other_buildings4_code:' + getFieldTypeText(h.other_buildings4_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other_buildings5_code:' + getFieldTypeText(h.other_buildings5_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other_impr_building1_indicator:' + getFieldTypeText(h.other_impr_building1_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other_impr_building2_indicator:' + getFieldTypeText(h.other_impr_building2_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other_impr_building3_indicator:' + getFieldTypeText(h.other_impr_building3_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other_impr_building4_indicator:' + getFieldTypeText(h.other_impr_building4_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other_impr_building5_indicator:' + getFieldTypeText(h.other_impr_building5_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other_impr_building_area1:' + getFieldTypeText(h.other_impr_building_area1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other_impr_building_area2:' + getFieldTypeText(h.other_impr_building_area2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other_impr_building_area3:' + getFieldTypeText(h.other_impr_building_area3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other_impr_building_area4:' + getFieldTypeText(h.other_impr_building_area4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other_impr_building_area5:' + getFieldTypeText(h.other_impr_building_area5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'topograpy_code:' + getFieldTypeText(h.topograpy_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'neighborhood_code:' + getFieldTypeText(h.neighborhood_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'condo_project_or_building_name:' + getFieldTypeText(h.condo_project_or_building_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessee_name_indicator:' + getFieldTypeText(h.assessee_name_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'second_assessee_name_indicator:' + getFieldTypeText(h.second_assessee_name_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other_rooms_indicator:' + getFieldTypeText(h.other_rooms_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_care_of_name_indicator:' + getFieldTypeText(h.mail_care_of_name_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'comments:' + getFieldTypeText(h.comments) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tape_cut_date:' + getFieldTypeText(h.tape_cut_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certification_date:' + getFieldTypeText(h.certification_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'edition_number:' + getFieldTypeText(h.edition_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prop_addr_propagated_ind:' + getFieldTypeText(h.prop_addr_propagated_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_ownership_rights:' + getFieldTypeText(h.ln_ownership_rights) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_relationship_type:' + getFieldTypeText(h.ln_relationship_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_mailing_country_code:' + getFieldTypeText(h.ln_mailing_country_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_property_name:' + getFieldTypeText(h.ln_property_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_property_name_type:' + getFieldTypeText(h.ln_property_name_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_land_use_category:' + getFieldTypeText(h.ln_land_use_category) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_lot:' + getFieldTypeText(h.ln_lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_block:' + getFieldTypeText(h.ln_block) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_unit:' + getFieldTypeText(h.ln_unit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_subfloor:' + getFieldTypeText(h.ln_subfloor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_floor_cover:' + getFieldTypeText(h.ln_floor_cover) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_mobile_home_indicator:' + getFieldTypeText(h.ln_mobile_home_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_condo_indicator:' + getFieldTypeText(h.ln_condo_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_property_tax_exemption:' + getFieldTypeText(h.ln_property_tax_exemption) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_veteran_status:' + getFieldTypeText(h.ln_veteran_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_old_apn_indicator:' + getFieldTypeText(h.ln_old_apn_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips:' + getFieldTypeText(h.fips) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_ln_fares_id_cnt
          ,le.populated_process_date_cnt
          ,le.populated_vendor_source_flag_cnt
          ,le.populated_current_record_cnt
          ,le.populated_fips_code_cnt
          ,le.populated_state_code_cnt
          ,le.populated_county_name_cnt
          ,le.populated_old_apn_cnt
          ,le.populated_apna_or_pin_number_cnt
          ,le.populated_fares_unformatted_apn_cnt
          ,le.populated_duplicate_apn_multiple_address_id_cnt
          ,le.populated_assessee_name_cnt
          ,le.populated_second_assessee_name_cnt
          ,le.populated_assessee_ownership_rights_code_cnt
          ,le.populated_assessee_relationship_code_cnt
          ,le.populated_assessee_phone_number_cnt
          ,le.populated_tax_account_number_cnt
          ,le.populated_contract_owner_cnt
          ,le.populated_assessee_name_type_code_cnt
          ,le.populated_second_assessee_name_type_code_cnt
          ,le.populated_mail_care_of_name_type_code_cnt
          ,le.populated_mailing_care_of_name_cnt
          ,le.populated_mailing_full_street_address_cnt
          ,le.populated_mailing_unit_number_cnt
          ,le.populated_mailing_city_state_zip_cnt
          ,le.populated_property_full_street_address_cnt
          ,le.populated_property_unit_number_cnt
          ,le.populated_property_city_state_zip_cnt
          ,le.populated_property_country_code_cnt
          ,le.populated_property_address_code_cnt
          ,le.populated_legal_lot_code_cnt
          ,le.populated_legal_lot_number_cnt
          ,le.populated_legal_land_lot_cnt
          ,le.populated_legal_block_cnt
          ,le.populated_legal_section_cnt
          ,le.populated_legal_district_cnt
          ,le.populated_legal_unit_cnt
          ,le.populated_legal_city_municipality_township_cnt
          ,le.populated_legal_subdivision_name_cnt
          ,le.populated_legal_phase_number_cnt
          ,le.populated_legal_tract_number_cnt
          ,le.populated_legal_sec_twn_rng_mer_cnt
          ,le.populated_legal_brief_description_cnt
          ,le.populated_legal_assessor_map_ref_cnt
          ,le.populated_census_tract_cnt
          ,le.populated_record_type_code_cnt
          ,le.populated_ownership_type_code_cnt
          ,le.populated_new_record_type_code_cnt
          ,le.populated_state_land_use_code_cnt
          ,le.populated_county_land_use_code_cnt
          ,le.populated_county_land_use_description_cnt
          ,le.populated_standardized_land_use_code_cnt
          ,le.populated_timeshare_code_cnt
          ,le.populated_zoning_cnt
          ,le.populated_owner_occupied_cnt
          ,le.populated_recorder_document_number_cnt
          ,le.populated_recorder_book_number_cnt
          ,le.populated_recorder_page_number_cnt
          ,le.populated_transfer_date_cnt
          ,le.populated_recording_date_cnt
          ,le.populated_sale_date_cnt
          ,le.populated_document_type_cnt
          ,le.populated_sales_price_cnt
          ,le.populated_sales_price_code_cnt
          ,le.populated_mortgage_loan_amount_cnt
          ,le.populated_mortgage_loan_type_code_cnt
          ,le.populated_mortgage_lender_name_cnt
          ,le.populated_mortgage_lender_type_code_cnt
          ,le.populated_prior_transfer_date_cnt
          ,le.populated_prior_recording_date_cnt
          ,le.populated_prior_sales_price_cnt
          ,le.populated_prior_sales_price_code_cnt
          ,le.populated_assessed_land_value_cnt
          ,le.populated_assessed_improvement_value_cnt
          ,le.populated_assessed_total_value_cnt
          ,le.populated_assessed_value_year_cnt
          ,le.populated_market_land_value_cnt
          ,le.populated_market_improvement_value_cnt
          ,le.populated_market_total_value_cnt
          ,le.populated_market_value_year_cnt
          ,le.populated_homestead_homeowner_exemption_cnt
          ,le.populated_tax_exemption1_code_cnt
          ,le.populated_tax_exemption2_code_cnt
          ,le.populated_tax_exemption3_code_cnt
          ,le.populated_tax_exemption4_code_cnt
          ,le.populated_tax_rate_code_area_cnt
          ,le.populated_tax_amount_cnt
          ,le.populated_tax_year_cnt
          ,le.populated_tax_delinquent_year_cnt
          ,le.populated_school_tax_district1_cnt
          ,le.populated_school_tax_district1_indicator_cnt
          ,le.populated_school_tax_district2_cnt
          ,le.populated_school_tax_district2_indicator_cnt
          ,le.populated_school_tax_district3_cnt
          ,le.populated_school_tax_district3_indicator_cnt
          ,le.populated_lot_size_cnt
          ,le.populated_lot_size_acres_cnt
          ,le.populated_lot_size_frontage_feet_cnt
          ,le.populated_lot_size_depth_feet_cnt
          ,le.populated_land_acres_cnt
          ,le.populated_land_square_footage_cnt
          ,le.populated_land_dimensions_cnt
          ,le.populated_building_area_cnt
          ,le.populated_building_area_indicator_cnt
          ,le.populated_building_area1_cnt
          ,le.populated_building_area1_indicator_cnt
          ,le.populated_building_area2_cnt
          ,le.populated_building_area2_indicator_cnt
          ,le.populated_building_area3_cnt
          ,le.populated_building_area3_indicator_cnt
          ,le.populated_building_area4_cnt
          ,le.populated_building_area4_indicator_cnt
          ,le.populated_building_area5_cnt
          ,le.populated_building_area5_indicator_cnt
          ,le.populated_building_area6_cnt
          ,le.populated_building_area6_indicator_cnt
          ,le.populated_building_area7_cnt
          ,le.populated_building_area7_indicator_cnt
          ,le.populated_year_built_cnt
          ,le.populated_effective_year_built_cnt
          ,le.populated_no_of_buildings_cnt
          ,le.populated_no_of_stories_cnt
          ,le.populated_no_of_units_cnt
          ,le.populated_no_of_rooms_cnt
          ,le.populated_no_of_bedrooms_cnt
          ,le.populated_no_of_baths_cnt
          ,le.populated_no_of_partial_baths_cnt
          ,le.populated_no_of_plumbing_fixtures_cnt
          ,le.populated_garage_type_code_cnt
          ,le.populated_parking_no_of_cars_cnt
          ,le.populated_pool_code_cnt
          ,le.populated_style_code_cnt
          ,le.populated_type_construction_code_cnt
          ,le.populated_foundation_code_cnt
          ,le.populated_building_quality_code_cnt
          ,le.populated_building_condition_code_cnt
          ,le.populated_exterior_walls_code_cnt
          ,le.populated_interior_walls_code_cnt
          ,le.populated_roof_cover_code_cnt
          ,le.populated_roof_type_code_cnt
          ,le.populated_floor_cover_code_cnt
          ,le.populated_water_code_cnt
          ,le.populated_sewer_code_cnt
          ,le.populated_heating_code_cnt
          ,le.populated_heating_fuel_type_code_cnt
          ,le.populated_air_conditioning_code_cnt
          ,le.populated_air_conditioning_type_code_cnt
          ,le.populated_elevator_cnt
          ,le.populated_fireplace_indicator_cnt
          ,le.populated_fireplace_number_cnt
          ,le.populated_basement_code_cnt
          ,le.populated_building_class_code_cnt
          ,le.populated_site_influence1_code_cnt
          ,le.populated_site_influence2_code_cnt
          ,le.populated_site_influence3_code_cnt
          ,le.populated_site_influence4_code_cnt
          ,le.populated_site_influence5_code_cnt
          ,le.populated_amenities1_code_cnt
          ,le.populated_amenities2_code_cnt
          ,le.populated_amenities3_code_cnt
          ,le.populated_amenities4_code_cnt
          ,le.populated_amenities5_code_cnt
          ,le.populated_amenities2_code1_cnt
          ,le.populated_amenities2_code2_cnt
          ,le.populated_amenities2_code3_cnt
          ,le.populated_amenities2_code4_cnt
          ,le.populated_amenities2_code5_cnt
          ,le.populated_extra_features1_area_cnt
          ,le.populated_extra_features1_indicator_cnt
          ,le.populated_extra_features2_area_cnt
          ,le.populated_extra_features2_indicator_cnt
          ,le.populated_extra_features3_area_cnt
          ,le.populated_extra_features3_indicator_cnt
          ,le.populated_extra_features4_area_cnt
          ,le.populated_extra_features4_indicator_cnt
          ,le.populated_other_buildings1_code_cnt
          ,le.populated_other_buildings2_code_cnt
          ,le.populated_other_buildings3_code_cnt
          ,le.populated_other_buildings4_code_cnt
          ,le.populated_other_buildings5_code_cnt
          ,le.populated_other_impr_building1_indicator_cnt
          ,le.populated_other_impr_building2_indicator_cnt
          ,le.populated_other_impr_building3_indicator_cnt
          ,le.populated_other_impr_building4_indicator_cnt
          ,le.populated_other_impr_building5_indicator_cnt
          ,le.populated_other_impr_building_area1_cnt
          ,le.populated_other_impr_building_area2_cnt
          ,le.populated_other_impr_building_area3_cnt
          ,le.populated_other_impr_building_area4_cnt
          ,le.populated_other_impr_building_area5_cnt
          ,le.populated_topograpy_code_cnt
          ,le.populated_neighborhood_code_cnt
          ,le.populated_condo_project_or_building_name_cnt
          ,le.populated_assessee_name_indicator_cnt
          ,le.populated_second_assessee_name_indicator_cnt
          ,le.populated_other_rooms_indicator_cnt
          ,le.populated_mail_care_of_name_indicator_cnt
          ,le.populated_comments_cnt
          ,le.populated_tape_cut_date_cnt
          ,le.populated_certification_date_cnt
          ,le.populated_edition_number_cnt
          ,le.populated_prop_addr_propagated_ind_cnt
          ,le.populated_ln_ownership_rights_cnt
          ,le.populated_ln_relationship_type_cnt
          ,le.populated_ln_mailing_country_code_cnt
          ,le.populated_ln_property_name_cnt
          ,le.populated_ln_property_name_type_cnt
          ,le.populated_ln_land_use_category_cnt
          ,le.populated_ln_lot_cnt
          ,le.populated_ln_block_cnt
          ,le.populated_ln_unit_cnt
          ,le.populated_ln_subfloor_cnt
          ,le.populated_ln_floor_cover_cnt
          ,le.populated_ln_mobile_home_indicator_cnt
          ,le.populated_ln_condo_indicator_cnt
          ,le.populated_ln_property_tax_exemption_cnt
          ,le.populated_ln_veteran_status_cnt
          ,le.populated_ln_old_apn_indicator_cnt
          ,le.populated_fips_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_ln_fares_id_pcnt
          ,le.populated_process_date_pcnt
          ,le.populated_vendor_source_flag_pcnt
          ,le.populated_current_record_pcnt
          ,le.populated_fips_code_pcnt
          ,le.populated_state_code_pcnt
          ,le.populated_county_name_pcnt
          ,le.populated_old_apn_pcnt
          ,le.populated_apna_or_pin_number_pcnt
          ,le.populated_fares_unformatted_apn_pcnt
          ,le.populated_duplicate_apn_multiple_address_id_pcnt
          ,le.populated_assessee_name_pcnt
          ,le.populated_second_assessee_name_pcnt
          ,le.populated_assessee_ownership_rights_code_pcnt
          ,le.populated_assessee_relationship_code_pcnt
          ,le.populated_assessee_phone_number_pcnt
          ,le.populated_tax_account_number_pcnt
          ,le.populated_contract_owner_pcnt
          ,le.populated_assessee_name_type_code_pcnt
          ,le.populated_second_assessee_name_type_code_pcnt
          ,le.populated_mail_care_of_name_type_code_pcnt
          ,le.populated_mailing_care_of_name_pcnt
          ,le.populated_mailing_full_street_address_pcnt
          ,le.populated_mailing_unit_number_pcnt
          ,le.populated_mailing_city_state_zip_pcnt
          ,le.populated_property_full_street_address_pcnt
          ,le.populated_property_unit_number_pcnt
          ,le.populated_property_city_state_zip_pcnt
          ,le.populated_property_country_code_pcnt
          ,le.populated_property_address_code_pcnt
          ,le.populated_legal_lot_code_pcnt
          ,le.populated_legal_lot_number_pcnt
          ,le.populated_legal_land_lot_pcnt
          ,le.populated_legal_block_pcnt
          ,le.populated_legal_section_pcnt
          ,le.populated_legal_district_pcnt
          ,le.populated_legal_unit_pcnt
          ,le.populated_legal_city_municipality_township_pcnt
          ,le.populated_legal_subdivision_name_pcnt
          ,le.populated_legal_phase_number_pcnt
          ,le.populated_legal_tract_number_pcnt
          ,le.populated_legal_sec_twn_rng_mer_pcnt
          ,le.populated_legal_brief_description_pcnt
          ,le.populated_legal_assessor_map_ref_pcnt
          ,le.populated_census_tract_pcnt
          ,le.populated_record_type_code_pcnt
          ,le.populated_ownership_type_code_pcnt
          ,le.populated_new_record_type_code_pcnt
          ,le.populated_state_land_use_code_pcnt
          ,le.populated_county_land_use_code_pcnt
          ,le.populated_county_land_use_description_pcnt
          ,le.populated_standardized_land_use_code_pcnt
          ,le.populated_timeshare_code_pcnt
          ,le.populated_zoning_pcnt
          ,le.populated_owner_occupied_pcnt
          ,le.populated_recorder_document_number_pcnt
          ,le.populated_recorder_book_number_pcnt
          ,le.populated_recorder_page_number_pcnt
          ,le.populated_transfer_date_pcnt
          ,le.populated_recording_date_pcnt
          ,le.populated_sale_date_pcnt
          ,le.populated_document_type_pcnt
          ,le.populated_sales_price_pcnt
          ,le.populated_sales_price_code_pcnt
          ,le.populated_mortgage_loan_amount_pcnt
          ,le.populated_mortgage_loan_type_code_pcnt
          ,le.populated_mortgage_lender_name_pcnt
          ,le.populated_mortgage_lender_type_code_pcnt
          ,le.populated_prior_transfer_date_pcnt
          ,le.populated_prior_recording_date_pcnt
          ,le.populated_prior_sales_price_pcnt
          ,le.populated_prior_sales_price_code_pcnt
          ,le.populated_assessed_land_value_pcnt
          ,le.populated_assessed_improvement_value_pcnt
          ,le.populated_assessed_total_value_pcnt
          ,le.populated_assessed_value_year_pcnt
          ,le.populated_market_land_value_pcnt
          ,le.populated_market_improvement_value_pcnt
          ,le.populated_market_total_value_pcnt
          ,le.populated_market_value_year_pcnt
          ,le.populated_homestead_homeowner_exemption_pcnt
          ,le.populated_tax_exemption1_code_pcnt
          ,le.populated_tax_exemption2_code_pcnt
          ,le.populated_tax_exemption3_code_pcnt
          ,le.populated_tax_exemption4_code_pcnt
          ,le.populated_tax_rate_code_area_pcnt
          ,le.populated_tax_amount_pcnt
          ,le.populated_tax_year_pcnt
          ,le.populated_tax_delinquent_year_pcnt
          ,le.populated_school_tax_district1_pcnt
          ,le.populated_school_tax_district1_indicator_pcnt
          ,le.populated_school_tax_district2_pcnt
          ,le.populated_school_tax_district2_indicator_pcnt
          ,le.populated_school_tax_district3_pcnt
          ,le.populated_school_tax_district3_indicator_pcnt
          ,le.populated_lot_size_pcnt
          ,le.populated_lot_size_acres_pcnt
          ,le.populated_lot_size_frontage_feet_pcnt
          ,le.populated_lot_size_depth_feet_pcnt
          ,le.populated_land_acres_pcnt
          ,le.populated_land_square_footage_pcnt
          ,le.populated_land_dimensions_pcnt
          ,le.populated_building_area_pcnt
          ,le.populated_building_area_indicator_pcnt
          ,le.populated_building_area1_pcnt
          ,le.populated_building_area1_indicator_pcnt
          ,le.populated_building_area2_pcnt
          ,le.populated_building_area2_indicator_pcnt
          ,le.populated_building_area3_pcnt
          ,le.populated_building_area3_indicator_pcnt
          ,le.populated_building_area4_pcnt
          ,le.populated_building_area4_indicator_pcnt
          ,le.populated_building_area5_pcnt
          ,le.populated_building_area5_indicator_pcnt
          ,le.populated_building_area6_pcnt
          ,le.populated_building_area6_indicator_pcnt
          ,le.populated_building_area7_pcnt
          ,le.populated_building_area7_indicator_pcnt
          ,le.populated_year_built_pcnt
          ,le.populated_effective_year_built_pcnt
          ,le.populated_no_of_buildings_pcnt
          ,le.populated_no_of_stories_pcnt
          ,le.populated_no_of_units_pcnt
          ,le.populated_no_of_rooms_pcnt
          ,le.populated_no_of_bedrooms_pcnt
          ,le.populated_no_of_baths_pcnt
          ,le.populated_no_of_partial_baths_pcnt
          ,le.populated_no_of_plumbing_fixtures_pcnt
          ,le.populated_garage_type_code_pcnt
          ,le.populated_parking_no_of_cars_pcnt
          ,le.populated_pool_code_pcnt
          ,le.populated_style_code_pcnt
          ,le.populated_type_construction_code_pcnt
          ,le.populated_foundation_code_pcnt
          ,le.populated_building_quality_code_pcnt
          ,le.populated_building_condition_code_pcnt
          ,le.populated_exterior_walls_code_pcnt
          ,le.populated_interior_walls_code_pcnt
          ,le.populated_roof_cover_code_pcnt
          ,le.populated_roof_type_code_pcnt
          ,le.populated_floor_cover_code_pcnt
          ,le.populated_water_code_pcnt
          ,le.populated_sewer_code_pcnt
          ,le.populated_heating_code_pcnt
          ,le.populated_heating_fuel_type_code_pcnt
          ,le.populated_air_conditioning_code_pcnt
          ,le.populated_air_conditioning_type_code_pcnt
          ,le.populated_elevator_pcnt
          ,le.populated_fireplace_indicator_pcnt
          ,le.populated_fireplace_number_pcnt
          ,le.populated_basement_code_pcnt
          ,le.populated_building_class_code_pcnt
          ,le.populated_site_influence1_code_pcnt
          ,le.populated_site_influence2_code_pcnt
          ,le.populated_site_influence3_code_pcnt
          ,le.populated_site_influence4_code_pcnt
          ,le.populated_site_influence5_code_pcnt
          ,le.populated_amenities1_code_pcnt
          ,le.populated_amenities2_code_pcnt
          ,le.populated_amenities3_code_pcnt
          ,le.populated_amenities4_code_pcnt
          ,le.populated_amenities5_code_pcnt
          ,le.populated_amenities2_code1_pcnt
          ,le.populated_amenities2_code2_pcnt
          ,le.populated_amenities2_code3_pcnt
          ,le.populated_amenities2_code4_pcnt
          ,le.populated_amenities2_code5_pcnt
          ,le.populated_extra_features1_area_pcnt
          ,le.populated_extra_features1_indicator_pcnt
          ,le.populated_extra_features2_area_pcnt
          ,le.populated_extra_features2_indicator_pcnt
          ,le.populated_extra_features3_area_pcnt
          ,le.populated_extra_features3_indicator_pcnt
          ,le.populated_extra_features4_area_pcnt
          ,le.populated_extra_features4_indicator_pcnt
          ,le.populated_other_buildings1_code_pcnt
          ,le.populated_other_buildings2_code_pcnt
          ,le.populated_other_buildings3_code_pcnt
          ,le.populated_other_buildings4_code_pcnt
          ,le.populated_other_buildings5_code_pcnt
          ,le.populated_other_impr_building1_indicator_pcnt
          ,le.populated_other_impr_building2_indicator_pcnt
          ,le.populated_other_impr_building3_indicator_pcnt
          ,le.populated_other_impr_building4_indicator_pcnt
          ,le.populated_other_impr_building5_indicator_pcnt
          ,le.populated_other_impr_building_area1_pcnt
          ,le.populated_other_impr_building_area2_pcnt
          ,le.populated_other_impr_building_area3_pcnt
          ,le.populated_other_impr_building_area4_pcnt
          ,le.populated_other_impr_building_area5_pcnt
          ,le.populated_topograpy_code_pcnt
          ,le.populated_neighborhood_code_pcnt
          ,le.populated_condo_project_or_building_name_pcnt
          ,le.populated_assessee_name_indicator_pcnt
          ,le.populated_second_assessee_name_indicator_pcnt
          ,le.populated_other_rooms_indicator_pcnt
          ,le.populated_mail_care_of_name_indicator_pcnt
          ,le.populated_comments_pcnt
          ,le.populated_tape_cut_date_pcnt
          ,le.populated_certification_date_pcnt
          ,le.populated_edition_number_pcnt
          ,le.populated_prop_addr_propagated_ind_pcnt
          ,le.populated_ln_ownership_rights_pcnt
          ,le.populated_ln_relationship_type_pcnt
          ,le.populated_ln_mailing_country_code_pcnt
          ,le.populated_ln_property_name_pcnt
          ,le.populated_ln_property_name_type_pcnt
          ,le.populated_ln_land_use_category_pcnt
          ,le.populated_ln_lot_pcnt
          ,le.populated_ln_block_pcnt
          ,le.populated_ln_unit_pcnt
          ,le.populated_ln_subfloor_pcnt
          ,le.populated_ln_floor_cover_pcnt
          ,le.populated_ln_mobile_home_indicator_pcnt
          ,le.populated_ln_condo_indicator_pcnt
          ,le.populated_ln_property_tax_exemption_pcnt
          ,le.populated_ln_veteran_status_pcnt
          ,le.populated_ln_old_apn_indicator_pcnt
          ,le.populated_fips_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,219,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.Source;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_Property_Assessor));
    deltaHygieneSummary := mod_Delta.DifferenceSummary(Glob);
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),219,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_Property_Assessor) inFile, BOOLEAN doErrorOverall = TRUE, BOOLEAN doErrorPerSrc = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedPerSource := FromExpanded(expandedFile, FALSE);
  mod_fromexpandedOverall := FromExpanded(expandedFile, TRUE);
  scrubsSummaryPerSource := mod_fromexpandedPerSource.SummaryStats;
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_LN_PropertyV2_Assessor, Fields, 'RECORDOF(scrubsSummaryOverall)', 'fips_code');
  scrubsSummaryPerSource_Standard := NORMALIZE(scrubsSummaryPerSource, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsPerSource := mod_fromexpandedPerSource.AllErrors;
  tErrsPerSource := TABLE(DISTRIBUTE(allErrsPerSource, HASH(src, FieldName, ErrorType)), {src, FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, src, FieldName, ErrorType, FieldContents, LOCAL);
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryPerSource_Standard_addErr := IF(doErrorPerSrc,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryPerSource_Standard, HASH(source, field, ruletype)), source, field, ruletype, LOCAL),
  	                                                       SORT(tErrsPerSource, src, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.source = RIGHT.src AND LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryPerSource_Standard_GeneralErrs := IF(doErrorPerSrc, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryPerSource, fips_code, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryPerSource_Standard_addErr & scrubsSummaryPerSource_Standard_GeneralErrs & scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
