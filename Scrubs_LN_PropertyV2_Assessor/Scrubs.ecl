IMPORT ut,SALT33;
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
  EXPORT  Expanded_Layout := RECORD(Layout_Property_Assessor)
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
    UNSIGNED1 building_area_indicator_Invalid;
    UNSIGNED1 building_area1_indicator_Invalid;
    UNSIGNED1 building_area2_indicator_Invalid;
    UNSIGNED1 building_area3_indicator_Invalid;
    UNSIGNED1 building_area4_indicator_Invalid;
    UNSIGNED1 building_area5_indicator_Invalid;
    UNSIGNED1 building_area6_indicator_Invalid;
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
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT33.StrType)le.process_date);
    SELF.fips_code_Invalid := Fields.InValid_fips_code((SALT33.StrType)le.fips_code);
    SELF.state_code_Invalid := Fields.InValid_state_code((SALT33.StrType)le.state_code);
    SELF.county_name_Invalid := Fields.InValid_county_name((SALT33.StrType)le.county_name);
    SELF.apna_or_pin_number_Invalid := Fields.InValid_apna_or_pin_number((SALT33.StrType)le.apna_or_pin_number);
    SELF.assessee_name_Invalid := Fields.InValid_assessee_name((SALT33.StrType)le.assessee_name);
    SELF.second_assessee_name_Invalid := Fields.InValid_second_assessee_name((SALT33.StrType)le.second_assessee_name);
    SELF.assessee_ownership_rights_code_Invalid := Fields.InValid_assessee_ownership_rights_code((SALT33.StrType)le.assessee_ownership_rights_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.assessee_relationship_code_Invalid := Fields.InValid_assessee_relationship_code((SALT33.StrType)le.assessee_relationship_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.assessee_phone_number_Invalid := Fields.InValid_assessee_phone_number((SALT33.StrType)le.assessee_phone_number);
    SELF.assessee_name_type_code_Invalid := Fields.InValid_assessee_name_type_code((SALT33.StrType)le.assessee_name_type_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.second_assessee_name_type_code_Invalid := Fields.InValid_second_assessee_name_type_code((SALT33.StrType)le.second_assessee_name_type_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.mail_care_of_name_type_code_Invalid := Fields.InValid_mail_care_of_name_type_code((SALT33.StrType)le.mail_care_of_name_type_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.mailing_care_of_name_Invalid := Fields.InValid_mailing_care_of_name((SALT33.StrType)le.mailing_care_of_name);
    SELF.mailing_full_street_address_Invalid := Fields.InValid_mailing_full_street_address((SALT33.StrType)le.mailing_full_street_address);
    SELF.mailing_unit_number_Invalid := Fields.InValid_mailing_unit_number((SALT33.StrType)le.mailing_unit_number);
    SELF.mailing_city_state_zip_Invalid := Fields.InValid_mailing_city_state_zip((SALT33.StrType)le.mailing_city_state_zip);
    SELF.property_full_street_address_Invalid := Fields.InValid_property_full_street_address((SALT33.StrType)le.property_full_street_address);
    SELF.property_unit_number_Invalid := Fields.InValid_property_unit_number((SALT33.StrType)le.property_unit_number);
    SELF.property_city_state_zip_Invalid := Fields.InValid_property_city_state_zip((SALT33.StrType)le.property_city_state_zip);
    SELF.property_address_code_Invalid := Fields.InValid_property_address_code((SALT33.StrType)le.property_address_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.legal_lot_code_Invalid := Fields.InValid_legal_lot_code((SALT33.StrType)le.legal_lot_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.record_type_code_Invalid := Fields.InValid_record_type_code((SALT33.StrType)le.record_type_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.ownership_type_code_Invalid := Fields.InValid_ownership_type_code((SALT33.StrType)le.ownership_type_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.new_record_type_code_Invalid := Fields.InValid_new_record_type_code((SALT33.StrType)le.new_record_type_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.standardized_land_use_code_Invalid := Fields.InValid_standardized_land_use_code((SALT33.StrType)le.standardized_land_use_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.transfer_date_Invalid := Fields.InValid_transfer_date((SALT33.StrType)le.transfer_date);
    SELF.recording_date_Invalid := Fields.InValid_recording_date((SALT33.StrType)le.recording_date);
    SELF.sale_date_Invalid := Fields.InValid_sale_date((SALT33.StrType)le.sale_date);
    SELF.document_type_Invalid := Fields.InValid_document_type((SALT33.StrType)le.document_type,(SALT33.StrType)le.vendor_source_flag);
    SELF.sales_price_Invalid := Fields.InValid_sales_price((SALT33.StrType)le.sales_price);
    SELF.sales_price_code_Invalid := Fields.InValid_sales_price_code((SALT33.StrType)le.sales_price_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.mortgage_loan_amount_Invalid := Fields.InValid_mortgage_loan_amount((SALT33.StrType)le.mortgage_loan_amount);
    SELF.mortgage_loan_type_code_Invalid := Fields.InValid_mortgage_loan_type_code((SALT33.StrType)le.mortgage_loan_type_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.mortgage_lender_name_Invalid := Fields.InValid_mortgage_lender_name((SALT33.StrType)le.mortgage_lender_name);
    SELF.mortgage_lender_type_code_Invalid := Fields.InValid_mortgage_lender_type_code((SALT33.StrType)le.mortgage_lender_type_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.prior_transfer_date_Invalid := Fields.InValid_prior_transfer_date((SALT33.StrType)le.prior_transfer_date);
    SELF.prior_recording_date_Invalid := Fields.InValid_prior_recording_date((SALT33.StrType)le.prior_recording_date);
    SELF.prior_sales_price_Invalid := Fields.InValid_prior_sales_price((SALT33.StrType)le.prior_sales_price);
    SELF.prior_sales_price_code_Invalid := Fields.InValid_prior_sales_price_code((SALT33.StrType)le.prior_sales_price_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.assessed_land_value_Invalid := Fields.InValid_assessed_land_value((SALT33.StrType)le.assessed_land_value);
    SELF.assessed_improvement_value_Invalid := Fields.InValid_assessed_improvement_value((SALT33.StrType)le.assessed_improvement_value);
    SELF.assessed_total_value_Invalid := Fields.InValid_assessed_total_value((SALT33.StrType)le.assessed_total_value);
    SELF.assessed_value_year_Invalid := Fields.InValid_assessed_value_year((SALT33.StrType)le.assessed_value_year);
    SELF.market_land_value_Invalid := Fields.InValid_market_land_value((SALT33.StrType)le.market_land_value);
    SELF.market_improvement_value_Invalid := Fields.InValid_market_improvement_value((SALT33.StrType)le.market_improvement_value);
    SELF.market_total_value_Invalid := Fields.InValid_market_total_value((SALT33.StrType)le.market_total_value);
    SELF.market_value_year_Invalid := Fields.InValid_market_value_year((SALT33.StrType)le.market_value_year);
    SELF.tax_exemption1_code_Invalid := Fields.InValid_tax_exemption1_code((SALT33.StrType)le.tax_exemption1_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.tax_exemption2_code_Invalid := Fields.InValid_tax_exemption2_code((SALT33.StrType)le.tax_exemption2_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.tax_exemption3_code_Invalid := Fields.InValid_tax_exemption3_code((SALT33.StrType)le.tax_exemption3_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.tax_exemption4_code_Invalid := Fields.InValid_tax_exemption4_code((SALT33.StrType)le.tax_exemption4_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.tax_amount_Invalid := Fields.InValid_tax_amount((SALT33.StrType)le.tax_amount);
    SELF.tax_year_Invalid := Fields.InValid_tax_year((SALT33.StrType)le.tax_year);
    SELF.tax_delinquent_year_Invalid := Fields.InValid_tax_delinquent_year((SALT33.StrType)le.tax_delinquent_year);
    SELF.building_area_indicator_Invalid := Fields.InValid_building_area_indicator((SALT33.StrType)le.building_area_indicator,(SALT33.StrType)le.vendor_source_flag);
    SELF.building_area1_indicator_Invalid := Fields.InValid_building_area1_indicator((SALT33.StrType)le.building_area1_indicator,(SALT33.StrType)le.vendor_source_flag);
    SELF.building_area2_indicator_Invalid := Fields.InValid_building_area2_indicator((SALT33.StrType)le.building_area2_indicator,(SALT33.StrType)le.vendor_source_flag);
    SELF.building_area3_indicator_Invalid := Fields.InValid_building_area3_indicator((SALT33.StrType)le.building_area3_indicator,(SALT33.StrType)le.vendor_source_flag);
    SELF.building_area4_indicator_Invalid := Fields.InValid_building_area4_indicator((SALT33.StrType)le.building_area4_indicator,(SALT33.StrType)le.vendor_source_flag);
    SELF.building_area5_indicator_Invalid := Fields.InValid_building_area5_indicator((SALT33.StrType)le.building_area5_indicator,(SALT33.StrType)le.vendor_source_flag);
    SELF.building_area6_indicator_Invalid := Fields.InValid_building_area6_indicator((SALT33.StrType)le.building_area6_indicator,(SALT33.StrType)le.vendor_source_flag);
    SELF.building_area7_indicator_Invalid := Fields.InValid_building_area7_indicator((SALT33.StrType)le.building_area7_indicator,(SALT33.StrType)le.vendor_source_flag);
    SELF.year_built_Invalid := Fields.InValid_year_built((SALT33.StrType)le.year_built);
    SELF.effective_year_built_Invalid := Fields.InValid_effective_year_built((SALT33.StrType)le.effective_year_built);
    SELF.no_of_stories_Invalid := Fields.InValid_no_of_stories((SALT33.StrType)le.no_of_stories);
    SELF.garage_type_code_Invalid := Fields.InValid_garage_type_code((SALT33.StrType)le.garage_type_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.pool_code_Invalid := Fields.InValid_pool_code((SALT33.StrType)le.pool_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.type_construction_code_Invalid := Fields.InValid_type_construction_code((SALT33.StrType)le.type_construction_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.building_quality_code_Invalid := Fields.InValid_building_quality_code((SALT33.StrType)le.building_quality_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.exterior_walls_code_Invalid := Fields.InValid_exterior_walls_code((SALT33.StrType)le.exterior_walls_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.roof_type_code_Invalid := Fields.InValid_roof_type_code((SALT33.StrType)le.roof_type_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.floor_cover_code_Invalid := Fields.InValid_floor_cover_code((SALT33.StrType)le.floor_cover_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.heating_code_Invalid := Fields.InValid_heating_code((SALT33.StrType)le.heating_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.heating_fuel_type_code_Invalid := Fields.InValid_heating_fuel_type_code((SALT33.StrType)le.heating_fuel_type_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.air_conditioning_type_code_Invalid := Fields.InValid_air_conditioning_type_code((SALT33.StrType)le.air_conditioning_type_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.fireplace_indicator_Invalid := Fields.InValid_fireplace_indicator((SALT33.StrType)le.fireplace_indicator,(SALT33.StrType)le.vendor_source_flag);
    SELF.basement_code_Invalid := Fields.InValid_basement_code((SALT33.StrType)le.basement_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.building_class_code_Invalid := Fields.InValid_building_class_code((SALT33.StrType)le.building_class_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.site_influence1_code_Invalid := Fields.InValid_site_influence1_code((SALT33.StrType)le.site_influence1_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.amenities1_code_Invalid := Fields.InValid_amenities1_code((SALT33.StrType)le.amenities1_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.amenities2_code_Invalid := Fields.InValid_amenities2_code((SALT33.StrType)le.amenities2_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.amenities3_code_Invalid := Fields.InValid_amenities3_code((SALT33.StrType)le.amenities3_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.amenities4_code_Invalid := Fields.InValid_amenities4_code((SALT33.StrType)le.amenities4_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.other_buildings1_code_Invalid := Fields.InValid_other_buildings1_code((SALT33.StrType)le.other_buildings1_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.tape_cut_date_Invalid := Fields.InValid_tape_cut_date((SALT33.StrType)le.tape_cut_date);
    SELF.certification_date_Invalid := Fields.InValid_certification_date((SALT33.StrType)le.certification_date);
    SELF.fips_Invalid := Fields.InValid_fips((SALT33.StrType)le.fips);
    SELF.trans_before_proc_Invalid := WHICH(Fields.InValid_transfer_date((SALT33.StrType)le.transfer_date)>0, Fields.InValid_process_date((SALT33.StrType)le.process_date)>0, NOT(le.transfer_date < le.process_date));
    SELF.rec_before_proc_Invalid := WHICH(Fields.InValid_recording_date((SALT33.StrType)le.recording_date)>0, Fields.InValid_process_date((SALT33.StrType)le.process_date)>0, NOT(le.recording_date < le.process_date));
    SELF.sale_before_proc_Invalid := WHICH(Fields.InValid_sale_date((SALT33.StrType)le.sale_date)>0, Fields.InValid_process_date((SALT33.StrType)le.process_date)>0, NOT(le.sale_date < le.process_date));
    SELF.ptrans_before_proc_Invalid := WHICH(Fields.InValid_prior_transfer_date((SALT33.StrType)le.prior_transfer_date)>0, Fields.InValid_process_date((SALT33.StrType)le.process_date)>0, NOT(le.prior_transfer_date < le.process_date));
    SELF.prior_rec_before_proc_Invalid := WHICH(Fields.InValid_prior_recording_date((SALT33.StrType)le.prior_recording_date)>0, Fields.InValid_process_date((SALT33.StrType)le.process_date)>0, NOT(le.prior_recording_date < le.process_date));
    SELF.cert_before_proc_Invalid := WHICH(Fields.InValid_certification_date((SALT33.StrType)le.certification_date)>0, Fields.InValid_process_date((SALT33.StrType)le.process_date)>0, NOT(le.certification_date < le.process_date));
    SELF.cut_before_proc_Invalid := WHICH(Fields.InValid_tape_cut_date((SALT33.StrType)le.tape_cut_date)>0, Fields.InValid_process_date((SALT33.StrType)le.process_date)>0, NOT(le.tape_cut_date < le.process_date));
    SELF.AssImp_Eq_AssTot_Invalid := WHICH(Fields.InValid_assessed_improvement_value((SALT33.StrType)le.assessed_improvement_value)>0, Fields.InValid_assessed_total_value((SALT33.StrType)le.assessed_total_value)>0, NOT(le.assessed_improvement_value < le.assessed_total_value));
    SELF.MarImp_Eq_MarTot_Invalid := WHICH(Fields.InValid_market_improvement_value((SALT33.StrType)le.market_improvement_value)>0, Fields.InValid_market_total_value((SALT33.StrType)le.market_total_value)>0, NOT(le.market_improvement_value < le.market_total_value));
    SELF.AssLnd_Eq_AssTot_Invalid := WHICH(Fields.InValid_assessed_land_value((SALT33.StrType)le.assessed_land_value)>0, Fields.InValid_assessed_total_value((SALT33.StrType)le.assessed_total_value)>0, NOT(le.assessed_land_value <= le.assessed_total_value));
    SELF.MarLnd_Eq_MarTot_Invalid := WHICH(Fields.InValid_market_land_value((SALT33.StrType)le.market_land_value)>0, Fields.InValid_market_total_value((SALT33.StrType)le.market_total_value)>0, NOT(le.market_land_value <= le.market_total_value));
    SELF.tax_less_than_total_assessed_Invalid := IF( ((SALT33.StrType)le.assessed_total_value = ''), WHICH(Fields.InValid_tax_amount((SALT33.StrType)le.tax_amount)>0, Fields.InValid_assessed_total_value((SALT33.StrType)le.assessed_total_value)>0, NOT(le.tax_amount <= le.assessed_total_value)), 0);
    SELF := le;
  END;
  EXPORT ExpandedInfile0 := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile0 := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_Property_Assessor);
  EXPORT WithinList1 := DEDUP(SORT(TABLE(Scrubs_LN_PropertyV2_Assessor.file_fips,{fips_code}),fips_code),ALL) : PERSIST('~temp::Scrubs_LN_PropertyV2_Assessor::Scrubs_LN_PropertyV2_Assessor.file_fips::fips_code',EXPIRE(Config.PersistExpire));
  EXPORT ExpandedInfile1 := JOIN(ExpandedInfile0, WithinList1, LEFT.fips_code=RIGHT.fips_code AND LEFT.fips_code_Invalid=0, TRANSFORM(Expanded_Layout, SELF.fips_code_Invalid:=MAP(RIGHT.fips_code<>''=>0,LEFT.fips_code_Invalid>0=>LEFT.fips_code_Invalid,3),SELF:=LEFT),LEFT OUTER, SMART);
  EXPORT WithinList2 := DEDUP(SORT(TABLE(Scrubs_LN_PropertyV2_Assessor.file_fips,{fips_code}),fips_code),ALL) : PERSIST('~temp::Scrubs_LN_PropertyV2_Assessor::Scrubs_LN_PropertyV2_Assessor.file_fips::fips_code',EXPIRE(Config.PersistExpire));
  EXPORT ExpandedInfile2 := JOIN(ExpandedInfile1, WithinList2, LEFT.fips=RIGHT.fips_code AND LEFT.fips_Invalid=0, TRANSFORM(Expanded_Layout, SELF.fips_Invalid:=MAP(RIGHT.fips_code<>''=>0,LEFT.fips_Invalid>0=>LEFT.fips_Invalid,3),SELF:=LEFT),LEFT OUTER, SMART);
  EXPORT ExpandedInfile := ExpandedInfile2;
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.process_date_Invalid << 0 ) + ( le.fips_code_Invalid << 2 ) + ( le.state_code_Invalid << 4 ) + ( le.county_name_Invalid << 6 ) + ( le.apna_or_pin_number_Invalid << 8 ) + ( le.assessee_name_Invalid << 10 ) + ( le.second_assessee_name_Invalid << 11 ) + ( le.assessee_ownership_rights_code_Invalid << 12 ) + ( le.assessee_relationship_code_Invalid << 13 ) + ( le.assessee_phone_number_Invalid << 14 ) + ( le.assessee_name_type_code_Invalid << 16 ) + ( le.second_assessee_name_type_code_Invalid << 17 ) + ( le.mail_care_of_name_type_code_Invalid << 18 ) + ( le.mailing_care_of_name_Invalid << 19 ) + ( le.mailing_full_street_address_Invalid << 20 ) + ( le.mailing_unit_number_Invalid << 21 ) + ( le.mailing_city_state_zip_Invalid << 22 ) + ( le.property_full_street_address_Invalid << 23 ) + ( le.property_unit_number_Invalid << 24 ) + ( le.property_city_state_zip_Invalid << 25 ) + ( le.property_address_code_Invalid << 26 ) + ( le.legal_lot_code_Invalid << 27 ) + ( le.record_type_code_Invalid << 28 ) + ( le.ownership_type_code_Invalid << 29 ) + ( le.new_record_type_code_Invalid << 30 ) + ( le.standardized_land_use_code_Invalid << 31 ) + ( le.transfer_date_Invalid << 32 ) + ( le.recording_date_Invalid << 34 ) + ( le.sale_date_Invalid << 36 ) + ( le.document_type_Invalid << 38 ) + ( le.sales_price_Invalid << 40 ) + ( le.sales_price_code_Invalid << 41 ) + ( le.mortgage_loan_amount_Invalid << 42 ) + ( le.mortgage_loan_type_code_Invalid << 43 ) + ( le.mortgage_lender_name_Invalid << 44 ) + ( le.mortgage_lender_type_code_Invalid << 45 ) + ( le.prior_transfer_date_Invalid << 46 ) + ( le.prior_recording_date_Invalid << 48 ) + ( le.prior_sales_price_Invalid << 50 ) + ( le.prior_sales_price_code_Invalid << 51 ) + ( le.assessed_land_value_Invalid << 52 ) + ( le.assessed_improvement_value_Invalid << 53 ) + ( le.assessed_total_value_Invalid << 54 ) + ( le.assessed_value_year_Invalid << 55 ) + ( le.market_land_value_Invalid << 56 ) + ( le.market_improvement_value_Invalid << 57 ) + ( le.market_total_value_Invalid << 58 ) + ( le.market_value_year_Invalid << 59 ) + ( le.tax_exemption1_code_Invalid << 60 ) + ( le.tax_exemption2_code_Invalid << 61 ) + ( le.tax_exemption3_code_Invalid << 62 ) + ( le.tax_exemption4_code_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.tax_amount_Invalid << 0 ) + ( le.tax_year_Invalid << 1 ) + ( le.tax_delinquent_year_Invalid << 2 ) + ( le.building_area_indicator_Invalid << 3 ) + ( le.building_area1_indicator_Invalid << 4 ) + ( le.building_area2_indicator_Invalid << 5 ) + ( le.building_area3_indicator_Invalid << 6 ) + ( le.building_area4_indicator_Invalid << 7 ) + ( le.building_area5_indicator_Invalid << 8 ) + ( le.building_area6_indicator_Invalid << 9 ) + ( le.building_area7_indicator_Invalid << 10 ) + ( le.year_built_Invalid << 11 ) + ( le.effective_year_built_Invalid << 12 ) + ( le.no_of_stories_Invalid << 13 ) + ( le.garage_type_code_Invalid << 15 ) + ( le.pool_code_Invalid << 16 ) + ( le.type_construction_code_Invalid << 17 ) + ( le.building_quality_code_Invalid << 18 ) + ( le.exterior_walls_code_Invalid << 19 ) + ( le.roof_type_code_Invalid << 20 ) + ( le.floor_cover_code_Invalid << 21 ) + ( le.heating_code_Invalid << 22 ) + ( le.heating_fuel_type_code_Invalid << 23 ) + ( le.air_conditioning_type_code_Invalid << 24 ) + ( le.fireplace_indicator_Invalid << 25 ) + ( le.basement_code_Invalid << 26 ) + ( le.building_class_code_Invalid << 27 ) + ( le.site_influence1_code_Invalid << 28 ) + ( le.amenities1_code_Invalid << 29 ) + ( le.amenities2_code_Invalid << 30 ) + ( le.amenities3_code_Invalid << 31 ) + ( le.amenities4_code_Invalid << 32 ) + ( le.other_buildings1_code_Invalid << 33 ) + ( le.tape_cut_date_Invalid << 34 ) + ( le.certification_date_Invalid << 36 ) + ( le.fips_Invalid << 38 );
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
    SELF.building_area_indicator_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.building_area1_indicator_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.building_area2_indicator_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.building_area3_indicator_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.building_area4_indicator_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.building_area5_indicator_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.building_area6_indicator_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.building_area7_indicator_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.year_built_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.effective_year_built_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.no_of_stories_Invalid := (le.ScrubsBits2 >> 13) & 3;
    SELF.garage_type_code_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.pool_code_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.type_construction_code_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.building_quality_code_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.exterior_walls_code_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.roof_type_code_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.floor_cover_code_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF.heating_code_Invalid := (le.ScrubsBits2 >> 22) & 1;
    SELF.heating_fuel_type_code_Invalid := (le.ScrubsBits2 >> 23) & 1;
    SELF.air_conditioning_type_code_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.fireplace_indicator_Invalid := (le.ScrubsBits2 >> 25) & 1;
    SELF.basement_code_Invalid := (le.ScrubsBits2 >> 26) & 1;
    SELF.building_class_code_Invalid := (le.ScrubsBits2 >> 27) & 1;
    SELF.site_influence1_code_Invalid := (le.ScrubsBits2 >> 28) & 1;
    SELF.amenities1_code_Invalid := (le.ScrubsBits2 >> 29) & 1;
    SELF.amenities2_code_Invalid := (le.ScrubsBits2 >> 30) & 1;
    SELF.amenities3_code_Invalid := (le.ScrubsBits2 >> 31) & 1;
    SELF.amenities4_code_Invalid := (le.ScrubsBits2 >> 32) & 1;
    SELF.other_buildings1_code_Invalid := (le.ScrubsBits2 >> 33) & 1;
    SELF.tape_cut_date_Invalid := (le.ScrubsBits2 >> 34) & 3;
    SELF.certification_date_Invalid := (le.ScrubsBits2 >> 36) & 3;
    SELF.fips_Invalid := (le.ScrubsBits2 >> 38) & 3;
    SELF.trans_before_proc_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.rec_before_proc_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF.sale_before_proc_Invalid := (le.ScrubsBits1 >> 44) & 3;
    SELF.ptrans_before_proc_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF.prior_rec_before_proc_Invalid := (le.ScrubsBits1 >> 48) & 3;
    SELF.cert_before_proc_Invalid := (le.ScrubsBits1 >> 50) & 3;
    SELF.cut_before_proc_Invalid := (le.ScrubsBits1 >> 52) & 3;
    SELF.AssImp_Eq_AssTot_Invalid := (le.ScrubsBits1 >> 54) & 3;
    SELF.MarImp_Eq_MarTot_Invalid := (le.ScrubsBits1 >> 56) & 3;
    SELF.AssLnd_Eq_AssTot_Invalid := (le.ScrubsBits1 >> 58) & 3;
    SELF.MarLnd_Eq_MarTot_Invalid := (le.ScrubsBits1 >> 60) & 3;
    SELF.tax_less_than_total_assessed_Invalid := (le.ScrubsBits1 >> 62) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.fips_code;
    TotalCnt := COUNT(GROUP); // Number of records in total
    process_date_ALLOW_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=2);
    process_date_LENGTH_ErrorCount := COUNT(GROUP,h.process_date_Invalid=3);
    process_date_Total_ErrorCount := COUNT(GROUP,h.process_date_Invalid>0);
    fips_code_ALLOW_ErrorCount := COUNT(GROUP,h.fips_code_Invalid=1);
    fips_code_LENGTH_ErrorCount := COUNT(GROUP,h.fips_code_Invalid=2);
    fips_code_WITHIN_FILE_ErrorCount := COUNT(GROUP,h.fips_code_Invalid=3);
    fips_code_Total_ErrorCount := COUNT(GROUP,h.fips_code_Invalid>0);
    state_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.state_code_Invalid=1);
    state_code_ALLOW_ErrorCount := COUNT(GROUP,h.state_code_Invalid=2);
    state_code_LENGTH_ErrorCount := COUNT(GROUP,h.state_code_Invalid=3);
    state_code_Total_ErrorCount := COUNT(GROUP,h.state_code_Invalid>0);
    county_name_ALLOW_ErrorCount := COUNT(GROUP,h.county_name_Invalid=1);
    county_name_WORDS_ErrorCount := COUNT(GROUP,h.county_name_Invalid=2);
    county_name_Total_ErrorCount := COUNT(GROUP,h.county_name_Invalid>0);
    apna_or_pin_number_ALLOW_ErrorCount := COUNT(GROUP,h.apna_or_pin_number_Invalid=1);
    apna_or_pin_number_LENGTH_ErrorCount := COUNT(GROUP,h.apna_or_pin_number_Invalid=2);
    apna_or_pin_number_Total_ErrorCount := COUNT(GROUP,h.apna_or_pin_number_Invalid>0);
    assessee_name_ALLOW_ErrorCount := COUNT(GROUP,h.assessee_name_Invalid=1);
    second_assessee_name_ALLOW_ErrorCount := COUNT(GROUP,h.second_assessee_name_Invalid=1);
    assessee_ownership_rights_code_CUSTOM_ErrorCount := COUNT(GROUP,h.assessee_ownership_rights_code_Invalid=1);
    assessee_relationship_code_CUSTOM_ErrorCount := COUNT(GROUP,h.assessee_relationship_code_Invalid=1);
    assessee_phone_number_ALLOW_ErrorCount := COUNT(GROUP,h.assessee_phone_number_Invalid=1);
    assessee_phone_number_LENGTH_ErrorCount := COUNT(GROUP,h.assessee_phone_number_Invalid=2);
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
    transfer_date_LENGTH_ErrorCount := COUNT(GROUP,h.transfer_date_Invalid=3);
    transfer_date_Total_ErrorCount := COUNT(GROUP,h.transfer_date_Invalid>0);
    recording_date_ALLOW_ErrorCount := COUNT(GROUP,h.recording_date_Invalid=1);
    recording_date_CUSTOM_ErrorCount := COUNT(GROUP,h.recording_date_Invalid=2);
    recording_date_LENGTH_ErrorCount := COUNT(GROUP,h.recording_date_Invalid=3);
    recording_date_Total_ErrorCount := COUNT(GROUP,h.recording_date_Invalid>0);
    sale_date_ALLOW_ErrorCount := COUNT(GROUP,h.sale_date_Invalid=1);
    sale_date_CUSTOM_ErrorCount := COUNT(GROUP,h.sale_date_Invalid=2);
    sale_date_LENGTH_ErrorCount := COUNT(GROUP,h.sale_date_Invalid=3);
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
    prior_transfer_date_LENGTH_ErrorCount := COUNT(GROUP,h.prior_transfer_date_Invalid=3);
    prior_transfer_date_Total_ErrorCount := COUNT(GROUP,h.prior_transfer_date_Invalid>0);
    prior_recording_date_ALLOW_ErrorCount := COUNT(GROUP,h.prior_recording_date_Invalid=1);
    prior_recording_date_CUSTOM_ErrorCount := COUNT(GROUP,h.prior_recording_date_Invalid=2);
    prior_recording_date_LENGTH_ErrorCount := COUNT(GROUP,h.prior_recording_date_Invalid=3);
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
    building_area_indicator_CUSTOM_ErrorCount := COUNT(GROUP,h.building_area_indicator_Invalid=1);
    building_area1_indicator_CUSTOM_ErrorCount := COUNT(GROUP,h.building_area1_indicator_Invalid=1);
    building_area2_indicator_CUSTOM_ErrorCount := COUNT(GROUP,h.building_area2_indicator_Invalid=1);
    building_area3_indicator_CUSTOM_ErrorCount := COUNT(GROUP,h.building_area3_indicator_Invalid=1);
    building_area4_indicator_CUSTOM_ErrorCount := COUNT(GROUP,h.building_area4_indicator_Invalid=1);
    building_area5_indicator_CUSTOM_ErrorCount := COUNT(GROUP,h.building_area5_indicator_Invalid=1);
    building_area6_indicator_CUSTOM_ErrorCount := COUNT(GROUP,h.building_area6_indicator_Invalid=1);
    building_area7_indicator_CUSTOM_ErrorCount := COUNT(GROUP,h.building_area7_indicator_Invalid=1);
    year_built_CUSTOM_ErrorCount := COUNT(GROUP,h.year_built_Invalid=1);
    effective_year_built_CUSTOM_ErrorCount := COUNT(GROUP,h.effective_year_built_Invalid=1);
    no_of_stories_ALLOW_ErrorCount := COUNT(GROUP,h.no_of_stories_Invalid=1);
    no_of_stories_LENGTH_ErrorCount := COUNT(GROUP,h.no_of_stories_Invalid=2);
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
    tape_cut_date_LENGTH_ErrorCount := COUNT(GROUP,h.tape_cut_date_Invalid=3);
    tape_cut_date_Total_ErrorCount := COUNT(GROUP,h.tape_cut_date_Invalid>0);
    certification_date_ALLOW_ErrorCount := COUNT(GROUP,h.certification_date_Invalid=1);
    certification_date_CUSTOM_ErrorCount := COUNT(GROUP,h.certification_date_Invalid=2);
    certification_date_LENGTH_ErrorCount := COUNT(GROUP,h.certification_date_Invalid=3);
    certification_date_Total_ErrorCount := COUNT(GROUP,h.certification_date_Invalid>0);
    fips_ALLOW_ErrorCount := COUNT(GROUP,h.fips_Invalid=1);
    fips_LENGTH_ErrorCount := COUNT(GROUP,h.fips_Invalid=2);
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
  END;
  EXPORT SummaryStats := TABLE(h,r,fips_code,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT33.StrType ErrorMessage;
    SALT33.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.fips_code;
    UNSIGNED1 ErrNum := CHOOSE(c,le.process_date_Invalid,le.fips_code_Invalid,le.state_code_Invalid,le.county_name_Invalid,le.apna_or_pin_number_Invalid,le.assessee_name_Invalid,le.second_assessee_name_Invalid,le.assessee_ownership_rights_code_Invalid,le.assessee_relationship_code_Invalid,le.assessee_phone_number_Invalid,le.assessee_name_type_code_Invalid,le.second_assessee_name_type_code_Invalid,le.mail_care_of_name_type_code_Invalid,le.mailing_care_of_name_Invalid,le.mailing_full_street_address_Invalid,le.mailing_unit_number_Invalid,le.mailing_city_state_zip_Invalid,le.property_full_street_address_Invalid,le.property_unit_number_Invalid,le.property_city_state_zip_Invalid,le.property_address_code_Invalid,le.legal_lot_code_Invalid,le.record_type_code_Invalid,le.ownership_type_code_Invalid,le.new_record_type_code_Invalid,le.standardized_land_use_code_Invalid,le.transfer_date_Invalid,le.recording_date_Invalid,le.sale_date_Invalid,le.document_type_Invalid,le.sales_price_Invalid,le.sales_price_code_Invalid,le.mortgage_loan_amount_Invalid,le.mortgage_loan_type_code_Invalid,le.mortgage_lender_name_Invalid,le.mortgage_lender_type_code_Invalid,le.prior_transfer_date_Invalid,le.prior_recording_date_Invalid,le.prior_sales_price_Invalid,le.prior_sales_price_code_Invalid,le.assessed_land_value_Invalid,le.assessed_improvement_value_Invalid,le.assessed_total_value_Invalid,le.assessed_value_year_Invalid,le.market_land_value_Invalid,le.market_improvement_value_Invalid,le.market_total_value_Invalid,le.market_value_year_Invalid,le.tax_exemption1_code_Invalid,le.tax_exemption2_code_Invalid,le.tax_exemption3_code_Invalid,le.tax_exemption4_code_Invalid,le.tax_amount_Invalid,le.tax_year_Invalid,le.tax_delinquent_year_Invalid,le.building_area_indicator_Invalid,le.building_area1_indicator_Invalid,le.building_area2_indicator_Invalid,le.building_area3_indicator_Invalid,le.building_area4_indicator_Invalid,le.building_area5_indicator_Invalid,le.building_area6_indicator_Invalid,le.building_area7_indicator_Invalid,le.year_built_Invalid,le.effective_year_built_Invalid,le.no_of_stories_Invalid,le.garage_type_code_Invalid,le.pool_code_Invalid,le.type_construction_code_Invalid,le.building_quality_code_Invalid,le.exterior_walls_code_Invalid,le.roof_type_code_Invalid,le.floor_cover_code_Invalid,le.heating_code_Invalid,le.heating_fuel_type_code_Invalid,le.air_conditioning_type_code_Invalid,le.fireplace_indicator_Invalid,le.basement_code_Invalid,le.building_class_code_Invalid,le.site_influence1_code_Invalid,le.amenities1_code_Invalid,le.amenities2_code_Invalid,le.amenities3_code_Invalid,le.amenities4_code_Invalid,le.other_buildings1_code_Invalid,le.tape_cut_date_Invalid,le.certification_date_Invalid,le.fips_Invalid,le.trans_before_proc_Invalid,le.rec_before_proc_Invalid,le.sale_before_proc_Invalid,le.ptrans_before_proc_Invalid,le.prior_rec_before_proc_Invalid,le.cert_before_proc_Invalid,le.cut_before_proc_Invalid,le.AssImp_Eq_AssTot_Invalid,le.MarImp_Eq_MarTot_Invalid,le.AssLnd_Eq_AssTot_Invalid,le.MarLnd_Eq_MarTot_Invalid,le.tax_less_than_total_assessed_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_process_date(le.process_date_Invalid),Fields.InvalidMessage_fips_code(le.fips_code_Invalid),Fields.InvalidMessage_state_code(le.state_code_Invalid),Fields.InvalidMessage_county_name(le.county_name_Invalid),Fields.InvalidMessage_apna_or_pin_number(le.apna_or_pin_number_Invalid),Fields.InvalidMessage_assessee_name(le.assessee_name_Invalid),Fields.InvalidMessage_second_assessee_name(le.second_assessee_name_Invalid),Fields.InvalidMessage_assessee_ownership_rights_code(le.assessee_ownership_rights_code_Invalid),Fields.InvalidMessage_assessee_relationship_code(le.assessee_relationship_code_Invalid),Fields.InvalidMessage_assessee_phone_number(le.assessee_phone_number_Invalid),Fields.InvalidMessage_assessee_name_type_code(le.assessee_name_type_code_Invalid),Fields.InvalidMessage_second_assessee_name_type_code(le.second_assessee_name_type_code_Invalid),Fields.InvalidMessage_mail_care_of_name_type_code(le.mail_care_of_name_type_code_Invalid),Fields.InvalidMessage_mailing_care_of_name(le.mailing_care_of_name_Invalid),Fields.InvalidMessage_mailing_full_street_address(le.mailing_full_street_address_Invalid),Fields.InvalidMessage_mailing_unit_number(le.mailing_unit_number_Invalid),Fields.InvalidMessage_mailing_city_state_zip(le.mailing_city_state_zip_Invalid),Fields.InvalidMessage_property_full_street_address(le.property_full_street_address_Invalid),Fields.InvalidMessage_property_unit_number(le.property_unit_number_Invalid),Fields.InvalidMessage_property_city_state_zip(le.property_city_state_zip_Invalid),Fields.InvalidMessage_property_address_code(le.property_address_code_Invalid),Fields.InvalidMessage_legal_lot_code(le.legal_lot_code_Invalid),Fields.InvalidMessage_record_type_code(le.record_type_code_Invalid),Fields.InvalidMessage_ownership_type_code(le.ownership_type_code_Invalid),Fields.InvalidMessage_new_record_type_code(le.new_record_type_code_Invalid),Fields.InvalidMessage_standardized_land_use_code(le.standardized_land_use_code_Invalid),Fields.InvalidMessage_transfer_date(le.transfer_date_Invalid),Fields.InvalidMessage_recording_date(le.recording_date_Invalid),Fields.InvalidMessage_sale_date(le.sale_date_Invalid),Fields.InvalidMessage_document_type(le.document_type_Invalid),Fields.InvalidMessage_sales_price(le.sales_price_Invalid),Fields.InvalidMessage_sales_price_code(le.sales_price_code_Invalid),Fields.InvalidMessage_mortgage_loan_amount(le.mortgage_loan_amount_Invalid),Fields.InvalidMessage_mortgage_loan_type_code(le.mortgage_loan_type_code_Invalid),Fields.InvalidMessage_mortgage_lender_name(le.mortgage_lender_name_Invalid),Fields.InvalidMessage_mortgage_lender_type_code(le.mortgage_lender_type_code_Invalid),Fields.InvalidMessage_prior_transfer_date(le.prior_transfer_date_Invalid),Fields.InvalidMessage_prior_recording_date(le.prior_recording_date_Invalid),Fields.InvalidMessage_prior_sales_price(le.prior_sales_price_Invalid),Fields.InvalidMessage_prior_sales_price_code(le.prior_sales_price_code_Invalid),Fields.InvalidMessage_assessed_land_value(le.assessed_land_value_Invalid),Fields.InvalidMessage_assessed_improvement_value(le.assessed_improvement_value_Invalid),Fields.InvalidMessage_assessed_total_value(le.assessed_total_value_Invalid),Fields.InvalidMessage_assessed_value_year(le.assessed_value_year_Invalid),Fields.InvalidMessage_market_land_value(le.market_land_value_Invalid),Fields.InvalidMessage_market_improvement_value(le.market_improvement_value_Invalid),Fields.InvalidMessage_market_total_value(le.market_total_value_Invalid),Fields.InvalidMessage_market_value_year(le.market_value_year_Invalid),Fields.InvalidMessage_tax_exemption1_code(le.tax_exemption1_code_Invalid),Fields.InvalidMessage_tax_exemption2_code(le.tax_exemption2_code_Invalid),Fields.InvalidMessage_tax_exemption3_code(le.tax_exemption3_code_Invalid),Fields.InvalidMessage_tax_exemption4_code(le.tax_exemption4_code_Invalid),Fields.InvalidMessage_tax_amount(le.tax_amount_Invalid),Fields.InvalidMessage_tax_year(le.tax_year_Invalid),Fields.InvalidMessage_tax_delinquent_year(le.tax_delinquent_year_Invalid),Fields.InvalidMessage_building_area_indicator(le.building_area_indicator_Invalid),Fields.InvalidMessage_building_area1_indicator(le.building_area1_indicator_Invalid),Fields.InvalidMessage_building_area2_indicator(le.building_area2_indicator_Invalid),Fields.InvalidMessage_building_area3_indicator(le.building_area3_indicator_Invalid),Fields.InvalidMessage_building_area4_indicator(le.building_area4_indicator_Invalid),Fields.InvalidMessage_building_area5_indicator(le.building_area5_indicator_Invalid),Fields.InvalidMessage_building_area6_indicator(le.building_area6_indicator_Invalid),Fields.InvalidMessage_building_area7_indicator(le.building_area7_indicator_Invalid),Fields.InvalidMessage_year_built(le.year_built_Invalid),Fields.InvalidMessage_effective_year_built(le.effective_year_built_Invalid),Fields.InvalidMessage_no_of_stories(le.no_of_stories_Invalid),Fields.InvalidMessage_garage_type_code(le.garage_type_code_Invalid),Fields.InvalidMessage_pool_code(le.pool_code_Invalid),Fields.InvalidMessage_type_construction_code(le.type_construction_code_Invalid),Fields.InvalidMessage_building_quality_code(le.building_quality_code_Invalid),Fields.InvalidMessage_exterior_walls_code(le.exterior_walls_code_Invalid),Fields.InvalidMessage_roof_type_code(le.roof_type_code_Invalid),Fields.InvalidMessage_floor_cover_code(le.floor_cover_code_Invalid),Fields.InvalidMessage_heating_code(le.heating_code_Invalid),Fields.InvalidMessage_heating_fuel_type_code(le.heating_fuel_type_code_Invalid),Fields.InvalidMessage_air_conditioning_type_code(le.air_conditioning_type_code_Invalid),Fields.InvalidMessage_fireplace_indicator(le.fireplace_indicator_Invalid),Fields.InvalidMessage_basement_code(le.basement_code_Invalid),Fields.InvalidMessage_building_class_code(le.building_class_code_Invalid),Fields.InvalidMessage_site_influence1_code(le.site_influence1_code_Invalid),Fields.InvalidMessage_amenities1_code(le.amenities1_code_Invalid),Fields.InvalidMessage_amenities2_code(le.amenities2_code_Invalid),Fields.InvalidMessage_amenities3_code(le.amenities3_code_Invalid),Fields.InvalidMessage_amenities4_code(le.amenities4_code_Invalid),Fields.InvalidMessage_other_buildings1_code(le.other_buildings1_code_Invalid),Fields.InvalidMessage_tape_cut_date(le.tape_cut_date_Invalid),Fields.InvalidMessage_certification_date(le.certification_date_Invalid),Fields.InvalidMessage_fips(le.fips_Invalid),InvalidMessage_trans_before_proc(le.trans_before_proc_Invalid),InvalidMessage_rec_before_proc(le.rec_before_proc_Invalid),InvalidMessage_sale_before_proc(le.sale_before_proc_Invalid),InvalidMessage_ptrans_before_proc(le.ptrans_before_proc_Invalid),InvalidMessage_prior_rec_before_proc(le.prior_rec_before_proc_Invalid),InvalidMessage_cert_before_proc(le.cert_before_proc_Invalid),InvalidMessage_cut_before_proc(le.cut_before_proc_Invalid),InvalidMessage_AssImp_Eq_AssTot(le.AssImp_Eq_AssTot_Invalid),InvalidMessage_MarImp_Eq_MarTot(le.MarImp_Eq_MarTot_Invalid),InvalidMessage_AssLnd_Eq_AssTot(le.AssLnd_Eq_AssTot_Invalid),InvalidMessage_MarLnd_Eq_MarTot(le.MarLnd_Eq_MarTot_Invalid),InvalidMessage_tax_less_than_total_assessed(le.tax_less_than_total_assessed_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.process_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.fips_code_Invalid,'ALLOW','LENGTH','WITHIN_FILE','UNKNOWN')
          ,CHOOSE(le.state_code_Invalid,'LEFTTRIM','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.county_name_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.apna_or_pin_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.assessee_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.second_assessee_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.assessee_ownership_rights_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.assessee_relationship_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.assessee_phone_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
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
          ,CHOOSE(le.transfer_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.recording_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.sale_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.document_type_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.sales_price_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sales_price_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mortgage_loan_amount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mortgage_loan_type_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mortgage_lender_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mortgage_lender_type_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prior_transfer_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.prior_recording_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
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
          ,CHOOSE(le.building_area_indicator_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.building_area1_indicator_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.building_area2_indicator_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.building_area3_indicator_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.building_area4_indicator_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.building_area5_indicator_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.building_area6_indicator_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.building_area7_indicator_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.year_built_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.effective_year_built_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.no_of_stories_Invalid,'ALLOW','LENGTH','UNKNOWN')
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
          ,CHOOSE(le.tape_cut_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.certification_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.fips_Invalid,'ALLOW','LENGTH','WITHIN_FILE','UNKNOWN')
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
    SELF.FieldName := CHOOSE(c,'process_date','fips_code','state_code','county_name','apna_or_pin_number','assessee_name','second_assessee_name','assessee_ownership_rights_code','assessee_relationship_code','assessee_phone_number','assessee_name_type_code','second_assessee_name_type_code','mail_care_of_name_type_code','mailing_care_of_name','mailing_full_street_address','mailing_unit_number','mailing_city_state_zip','property_full_street_address','property_unit_number','property_city_state_zip','property_address_code','legal_lot_code','record_type_code','ownership_type_code','new_record_type_code','standardized_land_use_code','transfer_date','recording_date','sale_date','document_type','sales_price','sales_price_code','mortgage_loan_amount','mortgage_loan_type_code','mortgage_lender_name','mortgage_lender_type_code','prior_transfer_date','prior_recording_date','prior_sales_price','prior_sales_price_code','assessed_land_value','assessed_improvement_value','assessed_total_value','assessed_value_year','market_land_value','market_improvement_value','market_total_value','market_value_year','tax_exemption1_code','tax_exemption2_code','tax_exemption3_code','tax_exemption4_code','tax_amount','tax_year','tax_delinquent_year','building_area_indicator','building_area1_indicator','building_area2_indicator','building_area3_indicator','building_area4_indicator','building_area5_indicator','building_area6_indicator','building_area7_indicator','year_built','effective_year_built','no_of_stories','garage_type_code','pool_code','type_construction_code','building_quality_code','exterior_walls_code','roof_type_code','floor_cover_code','heating_code','heating_fuel_type_code','air_conditioning_type_code','fireplace_indicator','basement_code','building_class_code','site_influence1_code','amenities1_code','amenities2_code','amenities3_code','amenities4_code','other_buildings1_code','tape_cut_date','certification_date','fips','trans_before_proc','rec_before_proc','sale_before_proc','ptrans_before_proc','prior_rec_before_proc','cert_before_proc','cut_before_proc','AssImp_Eq_AssTot','MarImp_Eq_MarTot','AssLnd_Eq_AssTot','MarLnd_Eq_MarTot','tax_less_than_total_assessed','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_date','invalid_fips','invalid_state_code','invalid_county_name','invalid_apn','invalid_alpha','invalid_alpha','invalid_ownership_rights_code','invalid_relationship_code','invalid_phone','invalid_name_type_code','invalid_second_name_type_code','invalid_mail_care_of_name_type_code','invalid_alpha','invalid_address','invalid_address','invalid_csz','invalid_address','invalid_address','invalid_csz','invalid_property_address_code','invalid_legal_lot_code','invalid_record_type_code','invalid_ownership_type_code','invalid_new_record_type_code','invalid_land_use','invalid_date','invalid_date','invalid_date','invalid_document_type_code','invalid_prop_amount','invalid_sale_code','invalid_prop_amount','invalid_mortgage_loan_type_code','invalid_alpha','invalid_mortgage_lender_type_code','invalid_date','invalid_date','invalid_prop_amount','invalid_prior_sales_price_code','invalid_prop_amount','invalid_prop_amount','invalid_prop_amount','invalid_year','invalid_prop_amount','invalid_prop_amount','invalid_prop_amount','invalid_year','invalid_tax_exemption1_code','invalid_tax_exemption2_code','invalid_tax_exemption3_code','invalid_tax_exemption4_code','invalid_tax_amount','invalid_year','invalid_year','invalid_building_area_indicator','invalid_building_area1_indicator','invalid_building_area2_indicator','invalid_building_area3_indicator','invalid_building_area4_indicator','invalid_building_area5_indicator','invalid_building_area6_indicator','invalid_building_area7_indicator','invalid_year','invalid_year','invalid_no_of_stories','invalid_garage_type_code','invalid_pool_code','invalid_construction_type','invalid_building_quality_code','invalid_exterior_walls_code','invalid_roof_type_code','invalid_floor_cover_code','invalid_heating_code','invalid_heating_fuel_type_code','invalid_air_conditioning_type_code','invalid_fireplace_indicator','invalid_basement_code','invalid_building_class_code','invalid_site_influence1_code','invalid_amenities1_code','invalid_amenities2_code','invalid_amenities3_code','invalid_amenities4_code','invalid_other_buildings1_code','invalid_date','invalid_date','invalid_fips','RECORDTYPE','RECORDTYPE','RECORDTYPE','RECORDTYPE','RECORDTYPE','RECORDTYPE','RECORDTYPE','RECORDTYPE','RECORDTYPE','RECORDTYPE','RECORDTYPE','RECORDTYPE','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.process_date,(SALT33.StrType)le.fips_code,(SALT33.StrType)le.state_code,(SALT33.StrType)le.county_name,(SALT33.StrType)le.apna_or_pin_number,(SALT33.StrType)le.assessee_name,(SALT33.StrType)le.second_assessee_name,(SALT33.StrType)le.assessee_ownership_rights_code,(SALT33.StrType)le.assessee_relationship_code,(SALT33.StrType)le.assessee_phone_number,(SALT33.StrType)le.assessee_name_type_code,(SALT33.StrType)le.second_assessee_name_type_code,(SALT33.StrType)le.mail_care_of_name_type_code,(SALT33.StrType)le.mailing_care_of_name,(SALT33.StrType)le.mailing_full_street_address,(SALT33.StrType)le.mailing_unit_number,(SALT33.StrType)le.mailing_city_state_zip,(SALT33.StrType)le.property_full_street_address,(SALT33.StrType)le.property_unit_number,(SALT33.StrType)le.property_city_state_zip,(SALT33.StrType)le.property_address_code,(SALT33.StrType)le.legal_lot_code,(SALT33.StrType)le.record_type_code,(SALT33.StrType)le.ownership_type_code,(SALT33.StrType)le.new_record_type_code,(SALT33.StrType)le.standardized_land_use_code,(SALT33.StrType)le.transfer_date,(SALT33.StrType)le.recording_date,(SALT33.StrType)le.sale_date,(SALT33.StrType)le.document_type,(SALT33.StrType)le.sales_price,(SALT33.StrType)le.sales_price_code,(SALT33.StrType)le.mortgage_loan_amount,(SALT33.StrType)le.mortgage_loan_type_code,(SALT33.StrType)le.mortgage_lender_name,(SALT33.StrType)le.mortgage_lender_type_code,(SALT33.StrType)le.prior_transfer_date,(SALT33.StrType)le.prior_recording_date,(SALT33.StrType)le.prior_sales_price,(SALT33.StrType)le.prior_sales_price_code,(SALT33.StrType)le.assessed_land_value,(SALT33.StrType)le.assessed_improvement_value,(SALT33.StrType)le.assessed_total_value,(SALT33.StrType)le.assessed_value_year,(SALT33.StrType)le.market_land_value,(SALT33.StrType)le.market_improvement_value,(SALT33.StrType)le.market_total_value,(SALT33.StrType)le.market_value_year,(SALT33.StrType)le.tax_exemption1_code,(SALT33.StrType)le.tax_exemption2_code,(SALT33.StrType)le.tax_exemption3_code,(SALT33.StrType)le.tax_exemption4_code,(SALT33.StrType)le.tax_amount,(SALT33.StrType)le.tax_year,(SALT33.StrType)le.tax_delinquent_year,(SALT33.StrType)le.building_area_indicator,(SALT33.StrType)le.building_area1_indicator,(SALT33.StrType)le.building_area2_indicator,(SALT33.StrType)le.building_area3_indicator,(SALT33.StrType)le.building_area4_indicator,(SALT33.StrType)le.building_area5_indicator,(SALT33.StrType)le.building_area6_indicator,(SALT33.StrType)le.building_area7_indicator,(SALT33.StrType)le.year_built,(SALT33.StrType)le.effective_year_built,(SALT33.StrType)le.no_of_stories,(SALT33.StrType)le.garage_type_code,(SALT33.StrType)le.pool_code,(SALT33.StrType)le.type_construction_code,(SALT33.StrType)le.building_quality_code,(SALT33.StrType)le.exterior_walls_code,(SALT33.StrType)le.roof_type_code,(SALT33.StrType)le.floor_cover_code,(SALT33.StrType)le.heating_code,(SALT33.StrType)le.heating_fuel_type_code,(SALT33.StrType)le.air_conditioning_type_code,(SALT33.StrType)le.fireplace_indicator,(SALT33.StrType)le.basement_code,(SALT33.StrType)le.building_class_code,(SALT33.StrType)le.site_influence1_code,(SALT33.StrType)le.amenities1_code,(SALT33.StrType)le.amenities2_code,(SALT33.StrType)le.amenities3_code,(SALT33.StrType)le.amenities4_code,(SALT33.StrType)le.other_buildings1_code,(SALT33.StrType)le.tape_cut_date,(SALT33.StrType)le.certification_date,(SALT33.StrType)le.fips,(SALT33.StrType)le.transfer_date+':'+(SALT33.StrType)le.process_date+':'+(SALT33.StrType)le.transfer_date+'<'+(SALT33.StrType)le.process_date,(SALT33.StrType)le.recording_date+':'+(SALT33.StrType)le.process_date+':'+(SALT33.StrType)le.recording_date+'<'+(SALT33.StrType)le.process_date,(SALT33.StrType)le.sale_date+':'+(SALT33.StrType)le.process_date+':'+(SALT33.StrType)le.sale_date+'<'+(SALT33.StrType)le.process_date,(SALT33.StrType)le.prior_transfer_date+':'+(SALT33.StrType)le.process_date+':'+(SALT33.StrType)le.prior_transfer_date+'<'+(SALT33.StrType)le.process_date,(SALT33.StrType)le.prior_recording_date+':'+(SALT33.StrType)le.process_date+':'+(SALT33.StrType)le.prior_recording_date+'<'+(SALT33.StrType)le.process_date,(SALT33.StrType)le.certification_date+':'+(SALT33.StrType)le.process_date+':'+(SALT33.StrType)le.certification_date+'<'+(SALT33.StrType)le.process_date,(SALT33.StrType)le.tape_cut_date+':'+(SALT33.StrType)le.process_date+':'+(SALT33.StrType)le.tape_cut_date+'<'+(SALT33.StrType)le.process_date,(SALT33.StrType)le.assessed_improvement_value+':'+(SALT33.StrType)le.assessed_total_value+':'+(SALT33.StrType)le.assessed_improvement_value+'<'+(SALT33.StrType)le.assessed_total_value,(SALT33.StrType)le.market_improvement_value+':'+(SALT33.StrType)le.market_total_value+':'+(SALT33.StrType)le.market_improvement_value+'<'+(SALT33.StrType)le.market_total_value,(SALT33.StrType)le.assessed_land_value+':'+(SALT33.StrType)le.assessed_total_value+':'+(SALT33.StrType)le.assessed_land_value+'<='+(SALT33.StrType)le.assessed_total_value,(SALT33.StrType)le.market_land_value+':'+(SALT33.StrType)le.market_total_value+':'+(SALT33.StrType)le.market_land_value+'<='+(SALT33.StrType)le.market_total_value,(SALT33.StrType)le.tax_amount+':'+(SALT33.StrType)le.assessed_total_value+':'+(SALT33.StrType)le.tax_amount+'<='+(SALT33.StrType)le.assessed_total_value,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,100,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.fips_code;
      SELF.ruledesc := CHOOSE(c
          ,'process_date:invalid_date:ALLOW','process_date:invalid_date:CUSTOM','process_date:invalid_date:LENGTH'
          ,'fips_code:invalid_fips:ALLOW','fips_code:invalid_fips:LENGTH','fips_code:invalid_fips:WITHIN_FILE'
          ,'state_code:invalid_state_code:LEFTTRIM','state_code:invalid_state_code:ALLOW','state_code:invalid_state_code:LENGTH'
          ,'county_name:invalid_county_name:ALLOW','county_name:invalid_county_name:WORDS'
          ,'apna_or_pin_number:invalid_apn:ALLOW','apna_or_pin_number:invalid_apn:LENGTH'
          ,'assessee_name:invalid_alpha:ALLOW'
          ,'second_assessee_name:invalid_alpha:ALLOW'
          ,'assessee_ownership_rights_code:invalid_ownership_rights_code:CUSTOM'
          ,'assessee_relationship_code:invalid_relationship_code:CUSTOM'
          ,'assessee_phone_number:invalid_phone:ALLOW','assessee_phone_number:invalid_phone:LENGTH'
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
          ,'transfer_date:invalid_date:ALLOW','transfer_date:invalid_date:CUSTOM','transfer_date:invalid_date:LENGTH'
          ,'recording_date:invalid_date:ALLOW','recording_date:invalid_date:CUSTOM','recording_date:invalid_date:LENGTH'
          ,'sale_date:invalid_date:ALLOW','sale_date:invalid_date:CUSTOM','sale_date:invalid_date:LENGTH'
          ,'document_type:invalid_document_type_code:ALLOW','document_type:invalid_document_type_code:CUSTOM'
          ,'sales_price:invalid_prop_amount:ALLOW'
          ,'sales_price_code:invalid_sale_code:CUSTOM'
          ,'mortgage_loan_amount:invalid_prop_amount:ALLOW'
          ,'mortgage_loan_type_code:invalid_mortgage_loan_type_code:CUSTOM'
          ,'mortgage_lender_name:invalid_alpha:ALLOW'
          ,'mortgage_lender_type_code:invalid_mortgage_lender_type_code:CUSTOM'
          ,'prior_transfer_date:invalid_date:ALLOW','prior_transfer_date:invalid_date:CUSTOM','prior_transfer_date:invalid_date:LENGTH'
          ,'prior_recording_date:invalid_date:ALLOW','prior_recording_date:invalid_date:CUSTOM','prior_recording_date:invalid_date:LENGTH'
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
          ,'building_area_indicator:invalid_building_area_indicator:CUSTOM'
          ,'building_area1_indicator:invalid_building_area1_indicator:CUSTOM'
          ,'building_area2_indicator:invalid_building_area2_indicator:CUSTOM'
          ,'building_area3_indicator:invalid_building_area3_indicator:CUSTOM'
          ,'building_area4_indicator:invalid_building_area4_indicator:CUSTOM'
          ,'building_area5_indicator:invalid_building_area5_indicator:CUSTOM'
          ,'building_area6_indicator:invalid_building_area6_indicator:CUSTOM'
          ,'building_area7_indicator:invalid_building_area7_indicator:CUSTOM'
          ,'year_built:invalid_year:CUSTOM'
          ,'effective_year_built:invalid_year:CUSTOM'
          ,'no_of_stories:invalid_no_of_stories:ALLOW','no_of_stories:invalid_no_of_stories:LENGTH'
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
          ,'tape_cut_date:invalid_date:ALLOW','tape_cut_date:invalid_date:CUSTOM','tape_cut_date:invalid_date:LENGTH'
          ,'certification_date:invalid_date:ALLOW','certification_date:invalid_date:CUSTOM','certification_date:invalid_date:LENGTH'
          ,'fips:invalid_fips:ALLOW','fips:invalid_fips:LENGTH','fips:invalid_fips:WITHIN_FILE'
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
          ,'tax_less_than_total_assessed:RECORDTYPE:tax_amount_Invalid','tax_less_than_total_assessed:RECORDTYPE:assessed_total_value_Invalid','tax_less_than_total_assessed:RECORDTYPE:tax_amount_assessed_total_value_Condition_Invalid','UNKNOWN');
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
          ,Fields.InvalidMessage_building_area_indicator(1)
          ,Fields.InvalidMessage_building_area1_indicator(1)
          ,Fields.InvalidMessage_building_area2_indicator(1)
          ,Fields.InvalidMessage_building_area3_indicator(1)
          ,Fields.InvalidMessage_building_area4_indicator(1)
          ,Fields.InvalidMessage_building_area5_indicator(1)
          ,Fields.InvalidMessage_building_area6_indicator(1)
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
          ,InvalidMessage_tax_less_than_total_assessed(1),InvalidMessage_tax_less_than_total_assessed(2),InvalidMessage_tax_less_than_total_assessed(3),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.process_date_ALLOW_ErrorCount,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.fips_code_ALLOW_ErrorCount,le.fips_code_LENGTH_ErrorCount,le.fips_code_WITHIN_FILE_ErrorCount
          ,le.state_code_LEFTTRIM_ErrorCount,le.state_code_ALLOW_ErrorCount,le.state_code_LENGTH_ErrorCount
          ,le.county_name_ALLOW_ErrorCount,le.county_name_WORDS_ErrorCount
          ,le.apna_or_pin_number_ALLOW_ErrorCount,le.apna_or_pin_number_LENGTH_ErrorCount
          ,le.assessee_name_ALLOW_ErrorCount
          ,le.second_assessee_name_ALLOW_ErrorCount
          ,le.assessee_ownership_rights_code_CUSTOM_ErrorCount
          ,le.assessee_relationship_code_CUSTOM_ErrorCount
          ,le.assessee_phone_number_ALLOW_ErrorCount,le.assessee_phone_number_LENGTH_ErrorCount
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
          ,le.transfer_date_ALLOW_ErrorCount,le.transfer_date_CUSTOM_ErrorCount,le.transfer_date_LENGTH_ErrorCount
          ,le.recording_date_ALLOW_ErrorCount,le.recording_date_CUSTOM_ErrorCount,le.recording_date_LENGTH_ErrorCount
          ,le.sale_date_ALLOW_ErrorCount,le.sale_date_CUSTOM_ErrorCount,le.sale_date_LENGTH_ErrorCount
          ,le.document_type_ALLOW_ErrorCount,le.document_type_CUSTOM_ErrorCount
          ,le.sales_price_ALLOW_ErrorCount
          ,le.sales_price_code_CUSTOM_ErrorCount
          ,le.mortgage_loan_amount_ALLOW_ErrorCount
          ,le.mortgage_loan_type_code_CUSTOM_ErrorCount
          ,le.mortgage_lender_name_ALLOW_ErrorCount
          ,le.mortgage_lender_type_code_CUSTOM_ErrorCount
          ,le.prior_transfer_date_ALLOW_ErrorCount,le.prior_transfer_date_CUSTOM_ErrorCount,le.prior_transfer_date_LENGTH_ErrorCount
          ,le.prior_recording_date_ALLOW_ErrorCount,le.prior_recording_date_CUSTOM_ErrorCount,le.prior_recording_date_LENGTH_ErrorCount
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
          ,le.building_area_indicator_CUSTOM_ErrorCount
          ,le.building_area1_indicator_CUSTOM_ErrorCount
          ,le.building_area2_indicator_CUSTOM_ErrorCount
          ,le.building_area3_indicator_CUSTOM_ErrorCount
          ,le.building_area4_indicator_CUSTOM_ErrorCount
          ,le.building_area5_indicator_CUSTOM_ErrorCount
          ,le.building_area6_indicator_CUSTOM_ErrorCount
          ,le.building_area7_indicator_CUSTOM_ErrorCount
          ,le.year_built_CUSTOM_ErrorCount
          ,le.effective_year_built_CUSTOM_ErrorCount
          ,le.no_of_stories_ALLOW_ErrorCount,le.no_of_stories_LENGTH_ErrorCount
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
          ,le.tape_cut_date_ALLOW_ErrorCount,le.tape_cut_date_CUSTOM_ErrorCount,le.tape_cut_date_LENGTH_ErrorCount
          ,le.certification_date_ALLOW_ErrorCount,le.certification_date_CUSTOM_ErrorCount,le.certification_date_LENGTH_ErrorCount
          ,le.fips_ALLOW_ErrorCount,le.fips_LENGTH_ErrorCount,le.fips_WITHIN_FILE_ErrorCount
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
          ,le.tax_less_than_total_assessed_tax_amount_Invalid_ErrorCount,le.tax_less_than_total_assessed_assessed_total_value_Invalid_ErrorCount,le.tax_less_than_total_assessed_tax_amount_assessed_total_value_Condition_Invalid_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.process_date_ALLOW_ErrorCount,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.fips_code_ALLOW_ErrorCount,le.fips_code_LENGTH_ErrorCount,le.fips_code_WITHIN_FILE_ErrorCount
          ,le.state_code_LEFTTRIM_ErrorCount,le.state_code_ALLOW_ErrorCount,le.state_code_LENGTH_ErrorCount
          ,le.county_name_ALLOW_ErrorCount,le.county_name_WORDS_ErrorCount
          ,le.apna_or_pin_number_ALLOW_ErrorCount,le.apna_or_pin_number_LENGTH_ErrorCount
          ,le.assessee_name_ALLOW_ErrorCount
          ,le.second_assessee_name_ALLOW_ErrorCount
          ,le.assessee_ownership_rights_code_CUSTOM_ErrorCount
          ,le.assessee_relationship_code_CUSTOM_ErrorCount
          ,le.assessee_phone_number_ALLOW_ErrorCount,le.assessee_phone_number_LENGTH_ErrorCount
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
          ,le.transfer_date_ALLOW_ErrorCount,le.transfer_date_CUSTOM_ErrorCount,le.transfer_date_LENGTH_ErrorCount
          ,le.recording_date_ALLOW_ErrorCount,le.recording_date_CUSTOM_ErrorCount,le.recording_date_LENGTH_ErrorCount
          ,le.sale_date_ALLOW_ErrorCount,le.sale_date_CUSTOM_ErrorCount,le.sale_date_LENGTH_ErrorCount
          ,le.document_type_ALLOW_ErrorCount,le.document_type_CUSTOM_ErrorCount
          ,le.sales_price_ALLOW_ErrorCount
          ,le.sales_price_code_CUSTOM_ErrorCount
          ,le.mortgage_loan_amount_ALLOW_ErrorCount
          ,le.mortgage_loan_type_code_CUSTOM_ErrorCount
          ,le.mortgage_lender_name_ALLOW_ErrorCount
          ,le.mortgage_lender_type_code_CUSTOM_ErrorCount
          ,le.prior_transfer_date_ALLOW_ErrorCount,le.prior_transfer_date_CUSTOM_ErrorCount,le.prior_transfer_date_LENGTH_ErrorCount
          ,le.prior_recording_date_ALLOW_ErrorCount,le.prior_recording_date_CUSTOM_ErrorCount,le.prior_recording_date_LENGTH_ErrorCount
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
          ,le.building_area_indicator_CUSTOM_ErrorCount
          ,le.building_area1_indicator_CUSTOM_ErrorCount
          ,le.building_area2_indicator_CUSTOM_ErrorCount
          ,le.building_area3_indicator_CUSTOM_ErrorCount
          ,le.building_area4_indicator_CUSTOM_ErrorCount
          ,le.building_area5_indicator_CUSTOM_ErrorCount
          ,le.building_area6_indicator_CUSTOM_ErrorCount
          ,le.building_area7_indicator_CUSTOM_ErrorCount
          ,le.year_built_CUSTOM_ErrorCount
          ,le.effective_year_built_CUSTOM_ErrorCount
          ,le.no_of_stories_ALLOW_ErrorCount,le.no_of_stories_LENGTH_ErrorCount
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
          ,le.tape_cut_date_ALLOW_ErrorCount,le.tape_cut_date_CUSTOM_ErrorCount,le.tape_cut_date_LENGTH_ErrorCount
          ,le.certification_date_ALLOW_ErrorCount,le.certification_date_CUSTOM_ErrorCount,le.certification_date_LENGTH_ErrorCount
          ,le.fips_ALLOW_ErrorCount,le.fips_LENGTH_ErrorCount,le.fips_WITHIN_FILE_ErrorCount
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
          ,le.tax_less_than_total_assessed_tax_amount_Invalid_ErrorCount,le.tax_less_than_total_assessed_assessed_total_value_Invalid_ErrorCount,le.tax_less_than_total_assessed_tax_amount_assessed_total_value_Condition_Invalid_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,151,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT33.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT33.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
