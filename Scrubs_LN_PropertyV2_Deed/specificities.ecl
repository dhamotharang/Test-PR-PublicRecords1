IMPORT ut,SALT30;
EXPORT specificities(DATASET(layout_Property_deed) h) := MODULE
EXPORT input_layout := RECORD // project out required fields
  SALT30.UIDType  := 0; // Fill in the value later
  h.ln_fares_id;
  h.process_date;
  h.vendor_source_flag;
  h.current_record;
  h.fips_code;
  h.state_code;
  h.county_name;
  h.old_apn;
  h.apna_or_pin_number;
  h.fares_unformatted_apn;
  h.duplicate_apn_multiple_address_id;
  h.assessee_name;
  h.second_assessee_name;
  h.assessee_ownership_rights_code;
  h.assessee_relationship_code;
  h.assessee_phone_number;
  h.tax_account_number;
  h.contract_owner;
  h.assessee_name_type_code;
  h.second_assessee_name_type_code;
  h.mail_care_of_name_type_code;
  h.mailing_care_of_name;
  h.mailing_full_street_address;
  h.mailing_unit_number;
  h.mailing_city_state_zip;
  h.property_full_street_address;
  h.property_unit_number;
  h.property_city_state_zip;
  h.property_country_code;
  h.property_address_code;
  h.legal_lot_code;
  h.legal_lot_number;
  h.legal_land_lot;
  h.legal_block;
  h.legal_section;
  h.legal_district;
  h.legal_unit;
  h.legal_city_municipality_township;
  h.legal_subdivision_name;
  h.legal_phase_number;
  h.legal_tract_number;
  h.legal_sec_twn_rng_mer;
  h.legal_brief_description;
  h.legal_assessor_map_ref;
  h.census_tract;
  h.record_type_code;
  h.ownership_type_code;
  h.new_record_type_code;
  h.state_land_use_code;
  h.county_land_use_code;
  h.county_land_use_description;
  h.standardized_land_use_code;
  h.timeshare_code;
  h.zoning;
  h.owner_occupied;
  h.recorder_document_number;
  h.recorder_book_number;
  h.recorder_page_number;
  h.transfer_date;
  h.recording_date;
  h.sale_date;
  h.document_type;
  h.sales_price;
  h.sales_price_code;
  h.mortgage_loan_amount;
  h.mortgage_loan_type_code;
  h.mortgage_lender_name;
  h.mortgage_lender_type_code;
  h.prior_transfer_date;
  h.prior_recording_date;
  h.prior_sales_price;
  h.prior_sales_price_code;
  h.assessed_land_value;
  h.assessed_improvement_value;
  h.assessed_total_value;
  h.assessed_value_year;
  h.market_land_value;
  h.market_improvement_value;
  h.market_total_value;
  h.market_value_year;
  h.homestead_homeowner_exemption;
  h.tax_exemption1_code;
  h.tax_exemption2_code;
  h.tax_exemption3_code;
  h.tax_exemption4_code;
  h.tax_rate_code_area;
  h.tax_amount;
  h.tax_year;
  h.tax_delinquent_year;
  h.school_tax_district1;
END;
r := input_layout;
tab := TABLE(h,r);
ut.mac_sequence_records(tab,,h00);
h01 := DISTRIBUTE(h00,); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF := le;
END;
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 :=  h02;
EXPORT input_file_np := h0; // No-persist version for remote_linking
EXPORT input_file := h0 : PERSIST('~temp::::aherzberg_property_salt::Specificities_Cache',EXPIRE(30));
//We have  specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,,LOCAL) : PERSIST('~temp::::aherzberg_property_salt::Cluster_Sizes',EXPIRE(30));
EXPORT TotalClusters := COUNT(ClusterSizes);
SHARED  ln_fares_id_deduped := SALT30.MAC_Field_By_UID(input_file,,ln_fares_id) : PERSIST('~temp::::aherzberg_property_salt::dedups::ln_fares_id',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(ln_fares_id_deduped,ln_fares_id,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ln_fares_id_values_persisted := specs_added;
SHARED  process_date_deduped := SALT30.MAC_Field_By_UID(input_file,,process_date) : PERSIST('~temp::::aherzberg_property_salt::dedups::process_date',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(process_date_deduped,process_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT process_date_values_persisted := specs_added;
SHARED  vendor_source_flag_deduped := SALT30.MAC_Field_By_UID(input_file,,vendor_source_flag) : PERSIST('~temp::::aherzberg_property_salt::dedups::vendor_source_flag',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(vendor_source_flag_deduped,vendor_source_flag,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT vendor_source_flag_values_persisted := specs_added;
SHARED  current_record_deduped := SALT30.MAC_Field_By_UID(input_file,,current_record) : PERSIST('~temp::::aherzberg_property_salt::dedups::current_record',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(current_record_deduped,current_record,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT current_record_values_persisted := specs_added;
SHARED  fips_code_deduped := SALT30.MAC_Field_By_UID(input_file,,fips_code) : PERSIST('~temp::::aherzberg_property_salt::dedups::fips_code',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(fips_code_deduped,fips_code,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT fips_code_values_persisted := specs_added;
SHARED  state_code_deduped := SALT30.MAC_Field_By_UID(input_file,,state_code) : PERSIST('~temp::::aherzberg_property_salt::dedups::state_code',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(state_code_deduped,state_code,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT state_code_values_persisted := specs_added;
SHARED  county_name_deduped := SALT30.MAC_Field_By_UID(input_file,,county_name) : PERSIST('~temp::::aherzberg_property_salt::dedups::county_name',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(county_name_deduped,county_name,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT county_name_values_persisted := specs_added;
SHARED  old_apn_deduped := SALT30.MAC_Field_By_UID(input_file,,old_apn) : PERSIST('~temp::::aherzberg_property_salt::dedups::old_apn',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(old_apn_deduped,old_apn,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT old_apn_values_persisted := specs_added;
SHARED  apna_or_pin_number_deduped := SALT30.MAC_Field_By_UID(input_file,,apna_or_pin_number) : PERSIST('~temp::::aherzberg_property_salt::dedups::apna_or_pin_number',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(apna_or_pin_number_deduped,apna_or_pin_number,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT apna_or_pin_number_values_persisted := specs_added;
SHARED  fares_unformatted_apn_deduped := SALT30.MAC_Field_By_UID(input_file,,fares_unformatted_apn) : PERSIST('~temp::::aherzberg_property_salt::dedups::fares_unformatted_apn',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(fares_unformatted_apn_deduped,fares_unformatted_apn,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT fares_unformatted_apn_values_persisted := specs_added;
SHARED  duplicate_apn_multiple_address_id_deduped := SALT30.MAC_Field_By_UID(input_file,,duplicate_apn_multiple_address_id) : PERSIST('~temp::::aherzberg_property_salt::dedups::duplicate_apn_multiple_address_id',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(duplicate_apn_multiple_address_id_deduped,duplicate_apn_multiple_address_id,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT duplicate_apn_multiple_address_id_values_persisted := specs_added;
SHARED  assessee_name_deduped := SALT30.MAC_Field_By_UID(input_file,,assessee_name) : PERSIST('~temp::::aherzberg_property_salt::dedups::assessee_name',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(assessee_name_deduped,assessee_name,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT assessee_name_values_persisted := specs_added;
SHARED  second_assessee_name_deduped := SALT30.MAC_Field_By_UID(input_file,,second_assessee_name) : PERSIST('~temp::::aherzberg_property_salt::dedups::second_assessee_name',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(second_assessee_name_deduped,second_assessee_name,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT second_assessee_name_values_persisted := specs_added;
SHARED  assessee_ownership_rights_code_deduped := SALT30.MAC_Field_By_UID(input_file,,assessee_ownership_rights_code) : PERSIST('~temp::::aherzberg_property_salt::dedups::assessee_ownership_rights_code',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(assessee_ownership_rights_code_deduped,assessee_ownership_rights_code,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT assessee_ownership_rights_code_values_persisted := specs_added;
SHARED  assessee_relationship_code_deduped := SALT30.MAC_Field_By_UID(input_file,,assessee_relationship_code) : PERSIST('~temp::::aherzberg_property_salt::dedups::assessee_relationship_code',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(assessee_relationship_code_deduped,assessee_relationship_code,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT assessee_relationship_code_values_persisted := specs_added;
SHARED  assessee_phone_number_deduped := SALT30.MAC_Field_By_UID(input_file,,assessee_phone_number) : PERSIST('~temp::::aherzberg_property_salt::dedups::assessee_phone_number',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(assessee_phone_number_deduped,assessee_phone_number,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT assessee_phone_number_values_persisted := specs_added;
SHARED  tax_account_number_deduped := SALT30.MAC_Field_By_UID(input_file,,tax_account_number) : PERSIST('~temp::::aherzberg_property_salt::dedups::tax_account_number',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(tax_account_number_deduped,tax_account_number,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT tax_account_number_values_persisted := specs_added;
SHARED  contract_owner_deduped := SALT30.MAC_Field_By_UID(input_file,,contract_owner) : PERSIST('~temp::::aherzberg_property_salt::dedups::contract_owner',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(contract_owner_deduped,contract_owner,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT contract_owner_values_persisted := specs_added;
SHARED  assessee_name_type_code_deduped := SALT30.MAC_Field_By_UID(input_file,,assessee_name_type_code) : PERSIST('~temp::::aherzberg_property_salt::dedups::assessee_name_type_code',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(assessee_name_type_code_deduped,assessee_name_type_code,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT assessee_name_type_code_values_persisted := specs_added;
SHARED  second_assessee_name_type_code_deduped := SALT30.MAC_Field_By_UID(input_file,,second_assessee_name_type_code) : PERSIST('~temp::::aherzberg_property_salt::dedups::second_assessee_name_type_code',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(second_assessee_name_type_code_deduped,second_assessee_name_type_code,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT second_assessee_name_type_code_values_persisted := specs_added;
SHARED  mail_care_of_name_type_code_deduped := SALT30.MAC_Field_By_UID(input_file,,mail_care_of_name_type_code) : PERSIST('~temp::::aherzberg_property_salt::dedups::mail_care_of_name_type_code',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(mail_care_of_name_type_code_deduped,mail_care_of_name_type_code,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT mail_care_of_name_type_code_values_persisted := specs_added;
SHARED  mailing_care_of_name_deduped := SALT30.MAC_Field_By_UID(input_file,,mailing_care_of_name) : PERSIST('~temp::::aherzberg_property_salt::dedups::mailing_care_of_name',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(mailing_care_of_name_deduped,mailing_care_of_name,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT mailing_care_of_name_values_persisted := specs_added;
SHARED  mailing_full_street_address_deduped := SALT30.MAC_Field_By_UID(input_file,,mailing_full_street_address) : PERSIST('~temp::::aherzberg_property_salt::dedups::mailing_full_street_address',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(mailing_full_street_address_deduped,mailing_full_street_address,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT mailing_full_street_address_values_persisted := specs_added;
SHARED  mailing_unit_number_deduped := SALT30.MAC_Field_By_UID(input_file,,mailing_unit_number) : PERSIST('~temp::::aherzberg_property_salt::dedups::mailing_unit_number',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(mailing_unit_number_deduped,mailing_unit_number,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT mailing_unit_number_values_persisted := specs_added;
SHARED  mailing_city_state_zip_deduped := SALT30.MAC_Field_By_UID(input_file,,mailing_city_state_zip) : PERSIST('~temp::::aherzberg_property_salt::dedups::mailing_city_state_zip',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(mailing_city_state_zip_deduped,mailing_city_state_zip,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT mailing_city_state_zip_values_persisted := specs_added;
SHARED  property_full_street_address_deduped := SALT30.MAC_Field_By_UID(input_file,,property_full_street_address) : PERSIST('~temp::::aherzberg_property_salt::dedups::property_full_street_address',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(property_full_street_address_deduped,property_full_street_address,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT property_full_street_address_values_persisted := specs_added;
SHARED  property_unit_number_deduped := SALT30.MAC_Field_By_UID(input_file,,property_unit_number) : PERSIST('~temp::::aherzberg_property_salt::dedups::property_unit_number',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(property_unit_number_deduped,property_unit_number,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT property_unit_number_values_persisted := specs_added;
SHARED  property_city_state_zip_deduped := SALT30.MAC_Field_By_UID(input_file,,property_city_state_zip) : PERSIST('~temp::::aherzberg_property_salt::dedups::property_city_state_zip',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(property_city_state_zip_deduped,property_city_state_zip,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT property_city_state_zip_values_persisted := specs_added;
SHARED  property_country_code_deduped := SALT30.MAC_Field_By_UID(input_file,,property_country_code) : PERSIST('~temp::::aherzberg_property_salt::dedups::property_country_code',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(property_country_code_deduped,property_country_code,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT property_country_code_values_persisted := specs_added;
SHARED  property_address_code_deduped := SALT30.MAC_Field_By_UID(input_file,,property_address_code) : PERSIST('~temp::::aherzberg_property_salt::dedups::property_address_code',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(property_address_code_deduped,property_address_code,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT property_address_code_values_persisted := specs_added;
SHARED  legal_lot_code_deduped := SALT30.MAC_Field_By_UID(input_file,,legal_lot_code) : PERSIST('~temp::::aherzberg_property_salt::dedups::legal_lot_code',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(legal_lot_code_deduped,legal_lot_code,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT legal_lot_code_values_persisted := specs_added;
SHARED  legal_lot_number_deduped := SALT30.MAC_Field_By_UID(input_file,,legal_lot_number) : PERSIST('~temp::::aherzberg_property_salt::dedups::legal_lot_number',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(legal_lot_number_deduped,legal_lot_number,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT legal_lot_number_values_persisted := specs_added;
SHARED  legal_land_lot_deduped := SALT30.MAC_Field_By_UID(input_file,,legal_land_lot) : PERSIST('~temp::::aherzberg_property_salt::dedups::legal_land_lot',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(legal_land_lot_deduped,legal_land_lot,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT legal_land_lot_values_persisted := specs_added;
SHARED  legal_block_deduped := SALT30.MAC_Field_By_UID(input_file,,legal_block) : PERSIST('~temp::::aherzberg_property_salt::dedups::legal_block',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(legal_block_deduped,legal_block,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT legal_block_values_persisted := specs_added;
SHARED  legal_section_deduped := SALT30.MAC_Field_By_UID(input_file,,legal_section) : PERSIST('~temp::::aherzberg_property_salt::dedups::legal_section',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(legal_section_deduped,legal_section,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT legal_section_values_persisted := specs_added;
SHARED  legal_district_deduped := SALT30.MAC_Field_By_UID(input_file,,legal_district) : PERSIST('~temp::::aherzberg_property_salt::dedups::legal_district',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(legal_district_deduped,legal_district,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT legal_district_values_persisted := specs_added;
SHARED  legal_unit_deduped := SALT30.MAC_Field_By_UID(input_file,,legal_unit) : PERSIST('~temp::::aherzberg_property_salt::dedups::legal_unit',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(legal_unit_deduped,legal_unit,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT legal_unit_values_persisted := specs_added;
SHARED  legal_city_municipality_township_deduped := SALT30.MAC_Field_By_UID(input_file,,legal_city_municipality_township) : PERSIST('~temp::::aherzberg_property_salt::dedups::legal_city_municipality_township',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(legal_city_municipality_township_deduped,legal_city_municipality_township,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT legal_city_municipality_township_values_persisted := specs_added;
SHARED  legal_subdivision_name_deduped := SALT30.MAC_Field_By_UID(input_file,,legal_subdivision_name) : PERSIST('~temp::::aherzberg_property_salt::dedups::legal_subdivision_name',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(legal_subdivision_name_deduped,legal_subdivision_name,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT legal_subdivision_name_values_persisted := specs_added;
SHARED  legal_phase_number_deduped := SALT30.MAC_Field_By_UID(input_file,,legal_phase_number) : PERSIST('~temp::::aherzberg_property_salt::dedups::legal_phase_number',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(legal_phase_number_deduped,legal_phase_number,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT legal_phase_number_values_persisted := specs_added;
SHARED  legal_tract_number_deduped := SALT30.MAC_Field_By_UID(input_file,,legal_tract_number) : PERSIST('~temp::::aherzberg_property_salt::dedups::legal_tract_number',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(legal_tract_number_deduped,legal_tract_number,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT legal_tract_number_values_persisted := specs_added;
SHARED  legal_sec_twn_rng_mer_deduped := SALT30.MAC_Field_By_UID(input_file,,legal_sec_twn_rng_mer) : PERSIST('~temp::::aherzberg_property_salt::dedups::legal_sec_twn_rng_mer',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(legal_sec_twn_rng_mer_deduped,legal_sec_twn_rng_mer,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT legal_sec_twn_rng_mer_values_persisted := specs_added;
SHARED  legal_brief_description_deduped := SALT30.MAC_Field_By_UID(input_file,,legal_brief_description) : PERSIST('~temp::::aherzberg_property_salt::dedups::legal_brief_description',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(legal_brief_description_deduped,legal_brief_description,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT legal_brief_description_values_persisted := specs_added;
SHARED  legal_assessor_map_ref_deduped := SALT30.MAC_Field_By_UID(input_file,,legal_assessor_map_ref) : PERSIST('~temp::::aherzberg_property_salt::dedups::legal_assessor_map_ref',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(legal_assessor_map_ref_deduped,legal_assessor_map_ref,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT legal_assessor_map_ref_values_persisted := specs_added;
SHARED  census_tract_deduped := SALT30.MAC_Field_By_UID(input_file,,census_tract) : PERSIST('~temp::::aherzberg_property_salt::dedups::census_tract',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(census_tract_deduped,census_tract,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT census_tract_values_persisted := specs_added;
SHARED  record_type_code_deduped := SALT30.MAC_Field_By_UID(input_file,,record_type_code) : PERSIST('~temp::::aherzberg_property_salt::dedups::record_type_code',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(record_type_code_deduped,record_type_code,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT record_type_code_values_persisted := specs_added;
SHARED  ownership_type_code_deduped := SALT30.MAC_Field_By_UID(input_file,,ownership_type_code) : PERSIST('~temp::::aherzberg_property_salt::dedups::ownership_type_code',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(ownership_type_code_deduped,ownership_type_code,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ownership_type_code_values_persisted := specs_added;
SHARED  new_record_type_code_deduped := SALT30.MAC_Field_By_UID(input_file,,new_record_type_code) : PERSIST('~temp::::aherzberg_property_salt::dedups::new_record_type_code',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(new_record_type_code_deduped,new_record_type_code,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT new_record_type_code_values_persisted := specs_added;
SHARED  state_land_use_code_deduped := SALT30.MAC_Field_By_UID(input_file,,state_land_use_code) : PERSIST('~temp::::aherzberg_property_salt::dedups::state_land_use_code',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(state_land_use_code_deduped,state_land_use_code,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT state_land_use_code_values_persisted := specs_added;
SHARED  county_land_use_code_deduped := SALT30.MAC_Field_By_UID(input_file,,county_land_use_code) : PERSIST('~temp::::aherzberg_property_salt::dedups::county_land_use_code',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(county_land_use_code_deduped,county_land_use_code,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT county_land_use_code_values_persisted := specs_added;
SHARED  county_land_use_description_deduped := SALT30.MAC_Field_By_UID(input_file,,county_land_use_description) : PERSIST('~temp::::aherzberg_property_salt::dedups::county_land_use_description',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(county_land_use_description_deduped,county_land_use_description,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT county_land_use_description_values_persisted := specs_added;
SHARED  standardized_land_use_code_deduped := SALT30.MAC_Field_By_UID(input_file,,standardized_land_use_code) : PERSIST('~temp::::aherzberg_property_salt::dedups::standardized_land_use_code',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(standardized_land_use_code_deduped,standardized_land_use_code,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT standardized_land_use_code_values_persisted := specs_added;
SHARED  timeshare_code_deduped := SALT30.MAC_Field_By_UID(input_file,,timeshare_code) : PERSIST('~temp::::aherzberg_property_salt::dedups::timeshare_code',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(timeshare_code_deduped,timeshare_code,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT timeshare_code_values_persisted := specs_added;
SHARED  zoning_deduped := SALT30.MAC_Field_By_UID(input_file,,zoning) : PERSIST('~temp::::aherzberg_property_salt::dedups::zoning',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(zoning_deduped,zoning,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT zoning_values_persisted := specs_added;
SHARED  owner_occupied_deduped := SALT30.MAC_Field_By_UID(input_file,,owner_occupied) : PERSIST('~temp::::aherzberg_property_salt::dedups::owner_occupied',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(owner_occupied_deduped,owner_occupied,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT owner_occupied_values_persisted := specs_added;
SHARED  recorder_document_number_deduped := SALT30.MAC_Field_By_UID(input_file,,recorder_document_number) : PERSIST('~temp::::aherzberg_property_salt::dedups::recorder_document_number',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(recorder_document_number_deduped,recorder_document_number,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT recorder_document_number_values_persisted := specs_added;
SHARED  recorder_book_number_deduped := SALT30.MAC_Field_By_UID(input_file,,recorder_book_number) : PERSIST('~temp::::aherzberg_property_salt::dedups::recorder_book_number',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(recorder_book_number_deduped,recorder_book_number,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT recorder_book_number_values_persisted := specs_added;
SHARED  recorder_page_number_deduped := SALT30.MAC_Field_By_UID(input_file,,recorder_page_number) : PERSIST('~temp::::aherzberg_property_salt::dedups::recorder_page_number',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(recorder_page_number_deduped,recorder_page_number,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT recorder_page_number_values_persisted := specs_added;
SHARED  transfer_date_deduped := SALT30.MAC_Field_By_UID(input_file,,transfer_date) : PERSIST('~temp::::aherzberg_property_salt::dedups::transfer_date',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(transfer_date_deduped,transfer_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT transfer_date_values_persisted := specs_added;
SHARED  recording_date_deduped := SALT30.MAC_Field_By_UID(input_file,,recording_date) : PERSIST('~temp::::aherzberg_property_salt::dedups::recording_date',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(recording_date_deduped,recording_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT recording_date_values_persisted := specs_added;
SHARED  sale_date_deduped := SALT30.MAC_Field_By_UID(input_file,,sale_date) : PERSIST('~temp::::aherzberg_property_salt::dedups::sale_date',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(sale_date_deduped,sale_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT sale_date_values_persisted := specs_added;
SHARED  document_type_deduped := SALT30.MAC_Field_By_UID(input_file,,document_type) : PERSIST('~temp::::aherzberg_property_salt::dedups::document_type',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(document_type_deduped,document_type,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT document_type_values_persisted := specs_added;
SHARED  sales_price_deduped := SALT30.MAC_Field_By_UID(input_file,,sales_price) : PERSIST('~temp::::aherzberg_property_salt::dedups::sales_price',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(sales_price_deduped,sales_price,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT sales_price_values_persisted := specs_added;
SHARED  sales_price_code_deduped := SALT30.MAC_Field_By_UID(input_file,,sales_price_code) : PERSIST('~temp::::aherzberg_property_salt::dedups::sales_price_code',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(sales_price_code_deduped,sales_price_code,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT sales_price_code_values_persisted := specs_added;
SHARED  mortgage_loan_amount_deduped := SALT30.MAC_Field_By_UID(input_file,,mortgage_loan_amount) : PERSIST('~temp::::aherzberg_property_salt::dedups::mortgage_loan_amount',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(mortgage_loan_amount_deduped,mortgage_loan_amount,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT mortgage_loan_amount_values_persisted := specs_added;
SHARED  mortgage_loan_type_code_deduped := SALT30.MAC_Field_By_UID(input_file,,mortgage_loan_type_code) : PERSIST('~temp::::aherzberg_property_salt::dedups::mortgage_loan_type_code',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(mortgage_loan_type_code_deduped,mortgage_loan_type_code,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT mortgage_loan_type_code_values_persisted := specs_added;
SHARED  mortgage_lender_name_deduped := SALT30.MAC_Field_By_UID(input_file,,mortgage_lender_name) : PERSIST('~temp::::aherzberg_property_salt::dedups::mortgage_lender_name',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(mortgage_lender_name_deduped,mortgage_lender_name,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT mortgage_lender_name_values_persisted := specs_added;
SHARED  mortgage_lender_type_code_deduped := SALT30.MAC_Field_By_UID(input_file,,mortgage_lender_type_code) : PERSIST('~temp::::aherzberg_property_salt::dedups::mortgage_lender_type_code',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(mortgage_lender_type_code_deduped,mortgage_lender_type_code,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT mortgage_lender_type_code_values_persisted := specs_added;
SHARED  prior_transfer_date_deduped := SALT30.MAC_Field_By_UID(input_file,,prior_transfer_date) : PERSIST('~temp::::aherzberg_property_salt::dedups::prior_transfer_date',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(prior_transfer_date_deduped,prior_transfer_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT prior_transfer_date_values_persisted := specs_added;
SHARED  prior_recording_date_deduped := SALT30.MAC_Field_By_UID(input_file,,prior_recording_date) : PERSIST('~temp::::aherzberg_property_salt::dedups::prior_recording_date',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(prior_recording_date_deduped,prior_recording_date,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT prior_recording_date_values_persisted := specs_added;
SHARED  prior_sales_price_deduped := SALT30.MAC_Field_By_UID(input_file,,prior_sales_price) : PERSIST('~temp::::aherzberg_property_salt::dedups::prior_sales_price',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(prior_sales_price_deduped,prior_sales_price,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT prior_sales_price_values_persisted := specs_added;
SHARED  prior_sales_price_code_deduped := SALT30.MAC_Field_By_UID(input_file,,prior_sales_price_code) : PERSIST('~temp::::aherzberg_property_salt::dedups::prior_sales_price_code',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(prior_sales_price_code_deduped,prior_sales_price_code,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT prior_sales_price_code_values_persisted := specs_added;
SHARED  assessed_land_value_deduped := SALT30.MAC_Field_By_UID(input_file,,assessed_land_value) : PERSIST('~temp::::aherzberg_property_salt::dedups::assessed_land_value',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(assessed_land_value_deduped,assessed_land_value,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT assessed_land_value_values_persisted := specs_added;
SHARED  assessed_improvement_value_deduped := SALT30.MAC_Field_By_UID(input_file,,assessed_improvement_value) : PERSIST('~temp::::aherzberg_property_salt::dedups::assessed_improvement_value',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(assessed_improvement_value_deduped,assessed_improvement_value,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT assessed_improvement_value_values_persisted := specs_added;
SHARED  assessed_total_value_deduped := SALT30.MAC_Field_By_UID(input_file,,assessed_total_value) : PERSIST('~temp::::aherzberg_property_salt::dedups::assessed_total_value',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(assessed_total_value_deduped,assessed_total_value,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT assessed_total_value_values_persisted := specs_added;
SHARED  assessed_value_year_deduped := SALT30.MAC_Field_By_UID(input_file,,assessed_value_year) : PERSIST('~temp::::aherzberg_property_salt::dedups::assessed_value_year',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(assessed_value_year_deduped,assessed_value_year,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT assessed_value_year_values_persisted := specs_added;
SHARED  market_land_value_deduped := SALT30.MAC_Field_By_UID(input_file,,market_land_value) : PERSIST('~temp::::aherzberg_property_salt::dedups::market_land_value',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(market_land_value_deduped,market_land_value,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT market_land_value_values_persisted := specs_added;
SHARED  market_improvement_value_deduped := SALT30.MAC_Field_By_UID(input_file,,market_improvement_value) : PERSIST('~temp::::aherzberg_property_salt::dedups::market_improvement_value',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(market_improvement_value_deduped,market_improvement_value,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT market_improvement_value_values_persisted := specs_added;
SHARED  market_total_value_deduped := SALT30.MAC_Field_By_UID(input_file,,market_total_value) : PERSIST('~temp::::aherzberg_property_salt::dedups::market_total_value',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(market_total_value_deduped,market_total_value,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT market_total_value_values_persisted := specs_added;
SHARED  market_value_year_deduped := SALT30.MAC_Field_By_UID(input_file,,market_value_year) : PERSIST('~temp::::aherzberg_property_salt::dedups::market_value_year',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(market_value_year_deduped,market_value_year,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT market_value_year_values_persisted := specs_added;
SHARED  homestead_homeowner_exemption_deduped := SALT30.MAC_Field_By_UID(input_file,,homestead_homeowner_exemption) : PERSIST('~temp::::aherzberg_property_salt::dedups::homestead_homeowner_exemption',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(homestead_homeowner_exemption_deduped,homestead_homeowner_exemption,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT homestead_homeowner_exemption_values_persisted := specs_added;
SHARED  tax_exemption1_code_deduped := SALT30.MAC_Field_By_UID(input_file,,tax_exemption1_code) : PERSIST('~temp::::aherzberg_property_salt::dedups::tax_exemption1_code',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(tax_exemption1_code_deduped,tax_exemption1_code,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT tax_exemption1_code_values_persisted := specs_added;
SHARED  tax_exemption2_code_deduped := SALT30.MAC_Field_By_UID(input_file,,tax_exemption2_code) : PERSIST('~temp::::aherzberg_property_salt::dedups::tax_exemption2_code',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(tax_exemption2_code_deduped,tax_exemption2_code,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT tax_exemption2_code_values_persisted := specs_added;
SHARED  tax_exemption3_code_deduped := SALT30.MAC_Field_By_UID(input_file,,tax_exemption3_code) : PERSIST('~temp::::aherzberg_property_salt::dedups::tax_exemption3_code',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(tax_exemption3_code_deduped,tax_exemption3_code,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT tax_exemption3_code_values_persisted := specs_added;
SHARED  tax_exemption4_code_deduped := SALT30.MAC_Field_By_UID(input_file,,tax_exemption4_code) : PERSIST('~temp::::aherzberg_property_salt::dedups::tax_exemption4_code',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(tax_exemption4_code_deduped,tax_exemption4_code,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT tax_exemption4_code_values_persisted := specs_added;
SHARED  tax_rate_code_area_deduped := SALT30.MAC_Field_By_UID(input_file,,tax_rate_code_area) : PERSIST('~temp::::aherzberg_property_salt::dedups::tax_rate_code_area',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(tax_rate_code_area_deduped,tax_rate_code_area,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT tax_rate_code_area_values_persisted := specs_added;
SHARED  tax_amount_deduped := SALT30.MAC_Field_By_UID(input_file,,tax_amount) : PERSIST('~temp::::aherzberg_property_salt::dedups::tax_amount',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(tax_amount_deduped,tax_amount,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT tax_amount_values_persisted := specs_added;
SHARED  tax_year_deduped := SALT30.MAC_Field_By_UID(input_file,,tax_year) : PERSIST('~temp::::aherzberg_property_salt::dedups::tax_year',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(tax_year_deduped,tax_year,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT tax_year_values_persisted := specs_added;
SHARED  tax_delinquent_year_deduped := SALT30.MAC_Field_By_UID(input_file,,tax_delinquent_year) : PERSIST('~temp::::aherzberg_property_salt::dedups::tax_delinquent_year',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(tax_delinquent_year_deduped,tax_delinquent_year,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT tax_delinquent_year_values_persisted := specs_added;
SHARED  school_tax_district1_deduped := SALT30.MAC_Field_By_UID(input_file,,school_tax_district1) : PERSIST('~temp::::aherzberg_property_salt::dedups::school_tax_district1',EXPIRE(30)); // Reduce to field values by UID
  SALT30.Mac_Field_Count_UID(school_tax_district1_deduped,school_tax_district1,,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT30.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT school_tax_district1_values_persisted := specs_added;
SALT30.MAC_Field_Nulls(ln_fares_id_values_persisted,Layout_Specificities.ln_fares_id_ChildRec,nv) // Use automated NULL spotting
EXPORT ln_fares_id_nulls := nv;
SALT30.MAC_Field_Bfoul(ln_fares_id_deduped,ln_fares_id,,ln_fares_id_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ln_fares_id_switch := bf;
EXPORT ln_fares_id_max := MAX(ln_fares_id_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(ln_fares_id_values_persisted,ln_fares_id,ln_fares_id_nulls,ol) // Compute column level specificity
EXPORT ln_fares_id_specificity := ol;
SALT30.MAC_Field_Nulls(process_date_values_persisted,Layout_Specificities.process_date_ChildRec,nv) // Use automated NULL spotting
EXPORT process_date_nulls := nv;
SALT30.MAC_Field_Bfoul(process_date_deduped,process_date,,process_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT process_date_switch := bf;
EXPORT process_date_max := MAX(process_date_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(process_date_values_persisted,process_date,process_date_nulls,ol) // Compute column level specificity
EXPORT process_date_specificity := ol;
SALT30.MAC_Field_Nulls(vendor_source_flag_values_persisted,Layout_Specificities.vendor_source_flag_ChildRec,nv) // Use automated NULL spotting
EXPORT vendor_source_flag_nulls := nv;
SALT30.MAC_Field_Bfoul(vendor_source_flag_deduped,vendor_source_flag,,vendor_source_flag_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT vendor_source_flag_switch := bf;
EXPORT vendor_source_flag_max := MAX(vendor_source_flag_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(vendor_source_flag_values_persisted,vendor_source_flag,vendor_source_flag_nulls,ol) // Compute column level specificity
EXPORT vendor_source_flag_specificity := ol;
SALT30.MAC_Field_Nulls(current_record_values_persisted,Layout_Specificities.current_record_ChildRec,nv) // Use automated NULL spotting
EXPORT current_record_nulls := nv;
SALT30.MAC_Field_Bfoul(current_record_deduped,current_record,,current_record_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT current_record_switch := bf;
EXPORT current_record_max := MAX(current_record_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(current_record_values_persisted,current_record,current_record_nulls,ol) // Compute column level specificity
EXPORT current_record_specificity := ol;
SALT30.MAC_Field_Nulls(fips_code_values_persisted,Layout_Specificities.fips_code_ChildRec,nv) // Use automated NULL spotting
EXPORT fips_code_nulls := nv;
SALT30.MAC_Field_Bfoul(fips_code_deduped,fips_code,,fips_code_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT fips_code_switch := bf;
EXPORT fips_code_max := MAX(fips_code_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(fips_code_values_persisted,fips_code,fips_code_nulls,ol) // Compute column level specificity
EXPORT fips_code_specificity := ol;
SALT30.MAC_Field_Nulls(state_code_values_persisted,Layout_Specificities.state_code_ChildRec,nv) // Use automated NULL spotting
EXPORT state_code_nulls := nv;
SALT30.MAC_Field_Bfoul(state_code_deduped,state_code,,state_code_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT state_code_switch := bf;
EXPORT state_code_max := MAX(state_code_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(state_code_values_persisted,state_code,state_code_nulls,ol) // Compute column level specificity
EXPORT state_code_specificity := ol;
SALT30.MAC_Field_Nulls(county_name_values_persisted,Layout_Specificities.county_name_ChildRec,nv) // Use automated NULL spotting
EXPORT county_name_nulls := nv;
SALT30.MAC_Field_Bfoul(county_name_deduped,county_name,,county_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT county_name_switch := bf;
EXPORT county_name_max := MAX(county_name_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(county_name_values_persisted,county_name,county_name_nulls,ol) // Compute column level specificity
EXPORT county_name_specificity := ol;
SALT30.MAC_Field_Nulls(old_apn_values_persisted,Layout_Specificities.old_apn_ChildRec,nv) // Use automated NULL spotting
EXPORT old_apn_nulls := nv;
SALT30.MAC_Field_Bfoul(old_apn_deduped,old_apn,,old_apn_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT old_apn_switch := bf;
EXPORT old_apn_max := MAX(old_apn_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(old_apn_values_persisted,old_apn,old_apn_nulls,ol) // Compute column level specificity
EXPORT old_apn_specificity := ol;
SALT30.MAC_Field_Nulls(apna_or_pin_number_values_persisted,Layout_Specificities.apna_or_pin_number_ChildRec,nv) // Use automated NULL spotting
EXPORT apna_or_pin_number_nulls := nv;
SALT30.MAC_Field_Bfoul(apna_or_pin_number_deduped,apna_or_pin_number,,apna_or_pin_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT apna_or_pin_number_switch := bf;
EXPORT apna_or_pin_number_max := MAX(apna_or_pin_number_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(apna_or_pin_number_values_persisted,apna_or_pin_number,apna_or_pin_number_nulls,ol) // Compute column level specificity
EXPORT apna_or_pin_number_specificity := ol;
SALT30.MAC_Field_Nulls(fares_unformatted_apn_values_persisted,Layout_Specificities.fares_unformatted_apn_ChildRec,nv) // Use automated NULL spotting
EXPORT fares_unformatted_apn_nulls := nv;
SALT30.MAC_Field_Bfoul(fares_unformatted_apn_deduped,fares_unformatted_apn,,fares_unformatted_apn_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT fares_unformatted_apn_switch := bf;
EXPORT fares_unformatted_apn_max := MAX(fares_unformatted_apn_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(fares_unformatted_apn_values_persisted,fares_unformatted_apn,fares_unformatted_apn_nulls,ol) // Compute column level specificity
EXPORT fares_unformatted_apn_specificity := ol;
SALT30.MAC_Field_Nulls(duplicate_apn_multiple_address_id_values_persisted,Layout_Specificities.duplicate_apn_multiple_address_id_ChildRec,nv) // Use automated NULL spotting
EXPORT duplicate_apn_multiple_address_id_nulls := nv;
SALT30.MAC_Field_Bfoul(duplicate_apn_multiple_address_id_deduped,duplicate_apn_multiple_address_id,,duplicate_apn_multiple_address_id_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT duplicate_apn_multiple_address_id_switch := bf;
EXPORT duplicate_apn_multiple_address_id_max := MAX(duplicate_apn_multiple_address_id_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(duplicate_apn_multiple_address_id_values_persisted,duplicate_apn_multiple_address_id,duplicate_apn_multiple_address_id_nulls,ol) // Compute column level specificity
EXPORT duplicate_apn_multiple_address_id_specificity := ol;
SALT30.MAC_Field_Nulls(assessee_name_values_persisted,Layout_Specificities.assessee_name_ChildRec,nv) // Use automated NULL spotting
EXPORT assessee_name_nulls := nv;
SALT30.MAC_Field_Bfoul(assessee_name_deduped,assessee_name,,assessee_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT assessee_name_switch := bf;
EXPORT assessee_name_max := MAX(assessee_name_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(assessee_name_values_persisted,assessee_name,assessee_name_nulls,ol) // Compute column level specificity
EXPORT assessee_name_specificity := ol;
SALT30.MAC_Field_Nulls(second_assessee_name_values_persisted,Layout_Specificities.second_assessee_name_ChildRec,nv) // Use automated NULL spotting
EXPORT second_assessee_name_nulls := nv;
SALT30.MAC_Field_Bfoul(second_assessee_name_deduped,second_assessee_name,,second_assessee_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT second_assessee_name_switch := bf;
EXPORT second_assessee_name_max := MAX(second_assessee_name_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(second_assessee_name_values_persisted,second_assessee_name,second_assessee_name_nulls,ol) // Compute column level specificity
EXPORT second_assessee_name_specificity := ol;
SALT30.MAC_Field_Nulls(assessee_ownership_rights_code_values_persisted,Layout_Specificities.assessee_ownership_rights_code_ChildRec,nv) // Use automated NULL spotting
EXPORT assessee_ownership_rights_code_nulls := nv;
SALT30.MAC_Field_Bfoul(assessee_ownership_rights_code_deduped,assessee_ownership_rights_code,,assessee_ownership_rights_code_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT assessee_ownership_rights_code_switch := bf;
EXPORT assessee_ownership_rights_code_max := MAX(assessee_ownership_rights_code_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(assessee_ownership_rights_code_values_persisted,assessee_ownership_rights_code,assessee_ownership_rights_code_nulls,ol) // Compute column level specificity
EXPORT assessee_ownership_rights_code_specificity := ol;
SALT30.MAC_Field_Nulls(assessee_relationship_code_values_persisted,Layout_Specificities.assessee_relationship_code_ChildRec,nv) // Use automated NULL spotting
EXPORT assessee_relationship_code_nulls := nv;
SALT30.MAC_Field_Bfoul(assessee_relationship_code_deduped,assessee_relationship_code,,assessee_relationship_code_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT assessee_relationship_code_switch := bf;
EXPORT assessee_relationship_code_max := MAX(assessee_relationship_code_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(assessee_relationship_code_values_persisted,assessee_relationship_code,assessee_relationship_code_nulls,ol) // Compute column level specificity
EXPORT assessee_relationship_code_specificity := ol;
SALT30.MAC_Field_Nulls(assessee_phone_number_values_persisted,Layout_Specificities.assessee_phone_number_ChildRec,nv) // Use automated NULL spotting
EXPORT assessee_phone_number_nulls := nv;
SALT30.MAC_Field_Bfoul(assessee_phone_number_deduped,assessee_phone_number,,assessee_phone_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT assessee_phone_number_switch := bf;
EXPORT assessee_phone_number_max := MAX(assessee_phone_number_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(assessee_phone_number_values_persisted,assessee_phone_number,assessee_phone_number_nulls,ol) // Compute column level specificity
EXPORT assessee_phone_number_specificity := ol;
SALT30.MAC_Field_Nulls(tax_account_number_values_persisted,Layout_Specificities.tax_account_number_ChildRec,nv) // Use automated NULL spotting
EXPORT tax_account_number_nulls := nv;
SALT30.MAC_Field_Bfoul(tax_account_number_deduped,tax_account_number,,tax_account_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT tax_account_number_switch := bf;
EXPORT tax_account_number_max := MAX(tax_account_number_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(tax_account_number_values_persisted,tax_account_number,tax_account_number_nulls,ol) // Compute column level specificity
EXPORT tax_account_number_specificity := ol;
SALT30.MAC_Field_Nulls(contract_owner_values_persisted,Layout_Specificities.contract_owner_ChildRec,nv) // Use automated NULL spotting
EXPORT contract_owner_nulls := nv;
SALT30.MAC_Field_Bfoul(contract_owner_deduped,contract_owner,,contract_owner_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT contract_owner_switch := bf;
EXPORT contract_owner_max := MAX(contract_owner_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(contract_owner_values_persisted,contract_owner,contract_owner_nulls,ol) // Compute column level specificity
EXPORT contract_owner_specificity := ol;
SALT30.MAC_Field_Nulls(assessee_name_type_code_values_persisted,Layout_Specificities.assessee_name_type_code_ChildRec,nv) // Use automated NULL spotting
EXPORT assessee_name_type_code_nulls := nv;
SALT30.MAC_Field_Bfoul(assessee_name_type_code_deduped,assessee_name_type_code,,assessee_name_type_code_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT assessee_name_type_code_switch := bf;
EXPORT assessee_name_type_code_max := MAX(assessee_name_type_code_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(assessee_name_type_code_values_persisted,assessee_name_type_code,assessee_name_type_code_nulls,ol) // Compute column level specificity
EXPORT assessee_name_type_code_specificity := ol;
SALT30.MAC_Field_Nulls(second_assessee_name_type_code_values_persisted,Layout_Specificities.second_assessee_name_type_code_ChildRec,nv) // Use automated NULL spotting
EXPORT second_assessee_name_type_code_nulls := nv;
SALT30.MAC_Field_Bfoul(second_assessee_name_type_code_deduped,second_assessee_name_type_code,,second_assessee_name_type_code_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT second_assessee_name_type_code_switch := bf;
EXPORT second_assessee_name_type_code_max := MAX(second_assessee_name_type_code_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(second_assessee_name_type_code_values_persisted,second_assessee_name_type_code,second_assessee_name_type_code_nulls,ol) // Compute column level specificity
EXPORT second_assessee_name_type_code_specificity := ol;
SALT30.MAC_Field_Nulls(mail_care_of_name_type_code_values_persisted,Layout_Specificities.mail_care_of_name_type_code_ChildRec,nv) // Use automated NULL spotting
EXPORT mail_care_of_name_type_code_nulls := nv;
SALT30.MAC_Field_Bfoul(mail_care_of_name_type_code_deduped,mail_care_of_name_type_code,,mail_care_of_name_type_code_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT mail_care_of_name_type_code_switch := bf;
EXPORT mail_care_of_name_type_code_max := MAX(mail_care_of_name_type_code_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(mail_care_of_name_type_code_values_persisted,mail_care_of_name_type_code,mail_care_of_name_type_code_nulls,ol) // Compute column level specificity
EXPORT mail_care_of_name_type_code_specificity := ol;
SALT30.MAC_Field_Nulls(mailing_care_of_name_values_persisted,Layout_Specificities.mailing_care_of_name_ChildRec,nv) // Use automated NULL spotting
EXPORT mailing_care_of_name_nulls := nv;
SALT30.MAC_Field_Bfoul(mailing_care_of_name_deduped,mailing_care_of_name,,mailing_care_of_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT mailing_care_of_name_switch := bf;
EXPORT mailing_care_of_name_max := MAX(mailing_care_of_name_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(mailing_care_of_name_values_persisted,mailing_care_of_name,mailing_care_of_name_nulls,ol) // Compute column level specificity
EXPORT mailing_care_of_name_specificity := ol;
SALT30.MAC_Field_Nulls(mailing_full_street_address_values_persisted,Layout_Specificities.mailing_full_street_address_ChildRec,nv) // Use automated NULL spotting
EXPORT mailing_full_street_address_nulls := nv;
SALT30.MAC_Field_Bfoul(mailing_full_street_address_deduped,mailing_full_street_address,,mailing_full_street_address_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT mailing_full_street_address_switch := bf;
EXPORT mailing_full_street_address_max := MAX(mailing_full_street_address_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(mailing_full_street_address_values_persisted,mailing_full_street_address,mailing_full_street_address_nulls,ol) // Compute column level specificity
EXPORT mailing_full_street_address_specificity := ol;
SALT30.MAC_Field_Nulls(mailing_unit_number_values_persisted,Layout_Specificities.mailing_unit_number_ChildRec,nv) // Use automated NULL spotting
EXPORT mailing_unit_number_nulls := nv;
SALT30.MAC_Field_Bfoul(mailing_unit_number_deduped,mailing_unit_number,,mailing_unit_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT mailing_unit_number_switch := bf;
EXPORT mailing_unit_number_max := MAX(mailing_unit_number_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(mailing_unit_number_values_persisted,mailing_unit_number,mailing_unit_number_nulls,ol) // Compute column level specificity
EXPORT mailing_unit_number_specificity := ol;
SALT30.MAC_Field_Nulls(mailing_city_state_zip_values_persisted,Layout_Specificities.mailing_city_state_zip_ChildRec,nv) // Use automated NULL spotting
EXPORT mailing_city_state_zip_nulls := nv;
SALT30.MAC_Field_Bfoul(mailing_city_state_zip_deduped,mailing_city_state_zip,,mailing_city_state_zip_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT mailing_city_state_zip_switch := bf;
EXPORT mailing_city_state_zip_max := MAX(mailing_city_state_zip_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(mailing_city_state_zip_values_persisted,mailing_city_state_zip,mailing_city_state_zip_nulls,ol) // Compute column level specificity
EXPORT mailing_city_state_zip_specificity := ol;
SALT30.MAC_Field_Nulls(property_full_street_address_values_persisted,Layout_Specificities.property_full_street_address_ChildRec,nv) // Use automated NULL spotting
EXPORT property_full_street_address_nulls := nv;
SALT30.MAC_Field_Bfoul(property_full_street_address_deduped,property_full_street_address,,property_full_street_address_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT property_full_street_address_switch := bf;
EXPORT property_full_street_address_max := MAX(property_full_street_address_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(property_full_street_address_values_persisted,property_full_street_address,property_full_street_address_nulls,ol) // Compute column level specificity
EXPORT property_full_street_address_specificity := ol;
SALT30.MAC_Field_Nulls(property_unit_number_values_persisted,Layout_Specificities.property_unit_number_ChildRec,nv) // Use automated NULL spotting
EXPORT property_unit_number_nulls := nv;
SALT30.MAC_Field_Bfoul(property_unit_number_deduped,property_unit_number,,property_unit_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT property_unit_number_switch := bf;
EXPORT property_unit_number_max := MAX(property_unit_number_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(property_unit_number_values_persisted,property_unit_number,property_unit_number_nulls,ol) // Compute column level specificity
EXPORT property_unit_number_specificity := ol;
SALT30.MAC_Field_Nulls(property_city_state_zip_values_persisted,Layout_Specificities.property_city_state_zip_ChildRec,nv) // Use automated NULL spotting
EXPORT property_city_state_zip_nulls := nv;
SALT30.MAC_Field_Bfoul(property_city_state_zip_deduped,property_city_state_zip,,property_city_state_zip_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT property_city_state_zip_switch := bf;
EXPORT property_city_state_zip_max := MAX(property_city_state_zip_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(property_city_state_zip_values_persisted,property_city_state_zip,property_city_state_zip_nulls,ol) // Compute column level specificity
EXPORT property_city_state_zip_specificity := ol;
SALT30.MAC_Field_Nulls(property_country_code_values_persisted,Layout_Specificities.property_country_code_ChildRec,nv) // Use automated NULL spotting
EXPORT property_country_code_nulls := nv;
SALT30.MAC_Field_Bfoul(property_country_code_deduped,property_country_code,,property_country_code_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT property_country_code_switch := bf;
EXPORT property_country_code_max := MAX(property_country_code_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(property_country_code_values_persisted,property_country_code,property_country_code_nulls,ol) // Compute column level specificity
EXPORT property_country_code_specificity := ol;
SALT30.MAC_Field_Nulls(property_address_code_values_persisted,Layout_Specificities.property_address_code_ChildRec,nv) // Use automated NULL spotting
EXPORT property_address_code_nulls := nv;
SALT30.MAC_Field_Bfoul(property_address_code_deduped,property_address_code,,property_address_code_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT property_address_code_switch := bf;
EXPORT property_address_code_max := MAX(property_address_code_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(property_address_code_values_persisted,property_address_code,property_address_code_nulls,ol) // Compute column level specificity
EXPORT property_address_code_specificity := ol;
SALT30.MAC_Field_Nulls(legal_lot_code_values_persisted,Layout_Specificities.legal_lot_code_ChildRec,nv) // Use automated NULL spotting
EXPORT legal_lot_code_nulls := nv;
SALT30.MAC_Field_Bfoul(legal_lot_code_deduped,legal_lot_code,,legal_lot_code_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT legal_lot_code_switch := bf;
EXPORT legal_lot_code_max := MAX(legal_lot_code_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(legal_lot_code_values_persisted,legal_lot_code,legal_lot_code_nulls,ol) // Compute column level specificity
EXPORT legal_lot_code_specificity := ol;
SALT30.MAC_Field_Nulls(legal_lot_number_values_persisted,Layout_Specificities.legal_lot_number_ChildRec,nv) // Use automated NULL spotting
EXPORT legal_lot_number_nulls := nv;
SALT30.MAC_Field_Bfoul(legal_lot_number_deduped,legal_lot_number,,legal_lot_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT legal_lot_number_switch := bf;
EXPORT legal_lot_number_max := MAX(legal_lot_number_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(legal_lot_number_values_persisted,legal_lot_number,legal_lot_number_nulls,ol) // Compute column level specificity
EXPORT legal_lot_number_specificity := ol;
SALT30.MAC_Field_Nulls(legal_land_lot_values_persisted,Layout_Specificities.legal_land_lot_ChildRec,nv) // Use automated NULL spotting
EXPORT legal_land_lot_nulls := nv;
SALT30.MAC_Field_Bfoul(legal_land_lot_deduped,legal_land_lot,,legal_land_lot_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT legal_land_lot_switch := bf;
EXPORT legal_land_lot_max := MAX(legal_land_lot_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(legal_land_lot_values_persisted,legal_land_lot,legal_land_lot_nulls,ol) // Compute column level specificity
EXPORT legal_land_lot_specificity := ol;
SALT30.MAC_Field_Nulls(legal_block_values_persisted,Layout_Specificities.legal_block_ChildRec,nv) // Use automated NULL spotting
EXPORT legal_block_nulls := nv;
SALT30.MAC_Field_Bfoul(legal_block_deduped,legal_block,,legal_block_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT legal_block_switch := bf;
EXPORT legal_block_max := MAX(legal_block_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(legal_block_values_persisted,legal_block,legal_block_nulls,ol) // Compute column level specificity
EXPORT legal_block_specificity := ol;
SALT30.MAC_Field_Nulls(legal_section_values_persisted,Layout_Specificities.legal_section_ChildRec,nv) // Use automated NULL spotting
EXPORT legal_section_nulls := nv;
SALT30.MAC_Field_Bfoul(legal_section_deduped,legal_section,,legal_section_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT legal_section_switch := bf;
EXPORT legal_section_max := MAX(legal_section_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(legal_section_values_persisted,legal_section,legal_section_nulls,ol) // Compute column level specificity
EXPORT legal_section_specificity := ol;
SALT30.MAC_Field_Nulls(legal_district_values_persisted,Layout_Specificities.legal_district_ChildRec,nv) // Use automated NULL spotting
EXPORT legal_district_nulls := nv;
SALT30.MAC_Field_Bfoul(legal_district_deduped,legal_district,,legal_district_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT legal_district_switch := bf;
EXPORT legal_district_max := MAX(legal_district_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(legal_district_values_persisted,legal_district,legal_district_nulls,ol) // Compute column level specificity
EXPORT legal_district_specificity := ol;
SALT30.MAC_Field_Nulls(legal_unit_values_persisted,Layout_Specificities.legal_unit_ChildRec,nv) // Use automated NULL spotting
EXPORT legal_unit_nulls := nv;
SALT30.MAC_Field_Bfoul(legal_unit_deduped,legal_unit,,legal_unit_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT legal_unit_switch := bf;
EXPORT legal_unit_max := MAX(legal_unit_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(legal_unit_values_persisted,legal_unit,legal_unit_nulls,ol) // Compute column level specificity
EXPORT legal_unit_specificity := ol;
SALT30.MAC_Field_Nulls(legal_city_municipality_township_values_persisted,Layout_Specificities.legal_city_municipality_township_ChildRec,nv) // Use automated NULL spotting
EXPORT legal_city_municipality_township_nulls := nv;
SALT30.MAC_Field_Bfoul(legal_city_municipality_township_deduped,legal_city_municipality_township,,legal_city_municipality_township_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT legal_city_municipality_township_switch := bf;
EXPORT legal_city_municipality_township_max := MAX(legal_city_municipality_township_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(legal_city_municipality_township_values_persisted,legal_city_municipality_township,legal_city_municipality_township_nulls,ol) // Compute column level specificity
EXPORT legal_city_municipality_township_specificity := ol;
SALT30.MAC_Field_Nulls(legal_subdivision_name_values_persisted,Layout_Specificities.legal_subdivision_name_ChildRec,nv) // Use automated NULL spotting
EXPORT legal_subdivision_name_nulls := nv;
SALT30.MAC_Field_Bfoul(legal_subdivision_name_deduped,legal_subdivision_name,,legal_subdivision_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT legal_subdivision_name_switch := bf;
EXPORT legal_subdivision_name_max := MAX(legal_subdivision_name_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(legal_subdivision_name_values_persisted,legal_subdivision_name,legal_subdivision_name_nulls,ol) // Compute column level specificity
EXPORT legal_subdivision_name_specificity := ol;
SALT30.MAC_Field_Nulls(legal_phase_number_values_persisted,Layout_Specificities.legal_phase_number_ChildRec,nv) // Use automated NULL spotting
EXPORT legal_phase_number_nulls := nv;
SALT30.MAC_Field_Bfoul(legal_phase_number_deduped,legal_phase_number,,legal_phase_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT legal_phase_number_switch := bf;
EXPORT legal_phase_number_max := MAX(legal_phase_number_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(legal_phase_number_values_persisted,legal_phase_number,legal_phase_number_nulls,ol) // Compute column level specificity
EXPORT legal_phase_number_specificity := ol;
SALT30.MAC_Field_Nulls(legal_tract_number_values_persisted,Layout_Specificities.legal_tract_number_ChildRec,nv) // Use automated NULL spotting
EXPORT legal_tract_number_nulls := nv;
SALT30.MAC_Field_Bfoul(legal_tract_number_deduped,legal_tract_number,,legal_tract_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT legal_tract_number_switch := bf;
EXPORT legal_tract_number_max := MAX(legal_tract_number_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(legal_tract_number_values_persisted,legal_tract_number,legal_tract_number_nulls,ol) // Compute column level specificity
EXPORT legal_tract_number_specificity := ol;
SALT30.MAC_Field_Nulls(legal_sec_twn_rng_mer_values_persisted,Layout_Specificities.legal_sec_twn_rng_mer_ChildRec,nv) // Use automated NULL spotting
EXPORT legal_sec_twn_rng_mer_nulls := nv;
SALT30.MAC_Field_Bfoul(legal_sec_twn_rng_mer_deduped,legal_sec_twn_rng_mer,,legal_sec_twn_rng_mer_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT legal_sec_twn_rng_mer_switch := bf;
EXPORT legal_sec_twn_rng_mer_max := MAX(legal_sec_twn_rng_mer_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(legal_sec_twn_rng_mer_values_persisted,legal_sec_twn_rng_mer,legal_sec_twn_rng_mer_nulls,ol) // Compute column level specificity
EXPORT legal_sec_twn_rng_mer_specificity := ol;
SALT30.MAC_Field_Nulls(legal_brief_description_values_persisted,Layout_Specificities.legal_brief_description_ChildRec,nv) // Use automated NULL spotting
EXPORT legal_brief_description_nulls := nv;
SALT30.MAC_Field_Bfoul(legal_brief_description_deduped,legal_brief_description,,legal_brief_description_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT legal_brief_description_switch := bf;
EXPORT legal_brief_description_max := MAX(legal_brief_description_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(legal_brief_description_values_persisted,legal_brief_description,legal_brief_description_nulls,ol) // Compute column level specificity
EXPORT legal_brief_description_specificity := ol;
SALT30.MAC_Field_Nulls(legal_assessor_map_ref_values_persisted,Layout_Specificities.legal_assessor_map_ref_ChildRec,nv) // Use automated NULL spotting
EXPORT legal_assessor_map_ref_nulls := nv;
SALT30.MAC_Field_Bfoul(legal_assessor_map_ref_deduped,legal_assessor_map_ref,,legal_assessor_map_ref_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT legal_assessor_map_ref_switch := bf;
EXPORT legal_assessor_map_ref_max := MAX(legal_assessor_map_ref_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(legal_assessor_map_ref_values_persisted,legal_assessor_map_ref,legal_assessor_map_ref_nulls,ol) // Compute column level specificity
EXPORT legal_assessor_map_ref_specificity := ol;
SALT30.MAC_Field_Nulls(census_tract_values_persisted,Layout_Specificities.census_tract_ChildRec,nv) // Use automated NULL spotting
EXPORT census_tract_nulls := nv;
SALT30.MAC_Field_Bfoul(census_tract_deduped,census_tract,,census_tract_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT census_tract_switch := bf;
EXPORT census_tract_max := MAX(census_tract_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(census_tract_values_persisted,census_tract,census_tract_nulls,ol) // Compute column level specificity
EXPORT census_tract_specificity := ol;
SALT30.MAC_Field_Nulls(record_type_code_values_persisted,Layout_Specificities.record_type_code_ChildRec,nv) // Use automated NULL spotting
EXPORT record_type_code_nulls := nv;
SALT30.MAC_Field_Bfoul(record_type_code_deduped,record_type_code,,record_type_code_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT record_type_code_switch := bf;
EXPORT record_type_code_max := MAX(record_type_code_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(record_type_code_values_persisted,record_type_code,record_type_code_nulls,ol) // Compute column level specificity
EXPORT record_type_code_specificity := ol;
SALT30.MAC_Field_Nulls(ownership_type_code_values_persisted,Layout_Specificities.ownership_type_code_ChildRec,nv) // Use automated NULL spotting
EXPORT ownership_type_code_nulls := nv;
SALT30.MAC_Field_Bfoul(ownership_type_code_deduped,ownership_type_code,,ownership_type_code_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ownership_type_code_switch := bf;
EXPORT ownership_type_code_max := MAX(ownership_type_code_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(ownership_type_code_values_persisted,ownership_type_code,ownership_type_code_nulls,ol) // Compute column level specificity
EXPORT ownership_type_code_specificity := ol;
SALT30.MAC_Field_Nulls(new_record_type_code_values_persisted,Layout_Specificities.new_record_type_code_ChildRec,nv) // Use automated NULL spotting
EXPORT new_record_type_code_nulls := nv;
SALT30.MAC_Field_Bfoul(new_record_type_code_deduped,new_record_type_code,,new_record_type_code_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT new_record_type_code_switch := bf;
EXPORT new_record_type_code_max := MAX(new_record_type_code_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(new_record_type_code_values_persisted,new_record_type_code,new_record_type_code_nulls,ol) // Compute column level specificity
EXPORT new_record_type_code_specificity := ol;
SALT30.MAC_Field_Nulls(state_land_use_code_values_persisted,Layout_Specificities.state_land_use_code_ChildRec,nv) // Use automated NULL spotting
EXPORT state_land_use_code_nulls := nv;
SALT30.MAC_Field_Bfoul(state_land_use_code_deduped,state_land_use_code,,state_land_use_code_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT state_land_use_code_switch := bf;
EXPORT state_land_use_code_max := MAX(state_land_use_code_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(state_land_use_code_values_persisted,state_land_use_code,state_land_use_code_nulls,ol) // Compute column level specificity
EXPORT state_land_use_code_specificity := ol;
SALT30.MAC_Field_Nulls(county_land_use_code_values_persisted,Layout_Specificities.county_land_use_code_ChildRec,nv) // Use automated NULL spotting
EXPORT county_land_use_code_nulls := nv;
SALT30.MAC_Field_Bfoul(county_land_use_code_deduped,county_land_use_code,,county_land_use_code_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT county_land_use_code_switch := bf;
EXPORT county_land_use_code_max := MAX(county_land_use_code_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(county_land_use_code_values_persisted,county_land_use_code,county_land_use_code_nulls,ol) // Compute column level specificity
EXPORT county_land_use_code_specificity := ol;
SALT30.MAC_Field_Nulls(county_land_use_description_values_persisted,Layout_Specificities.county_land_use_description_ChildRec,nv) // Use automated NULL spotting
EXPORT county_land_use_description_nulls := nv;
SALT30.MAC_Field_Bfoul(county_land_use_description_deduped,county_land_use_description,,county_land_use_description_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT county_land_use_description_switch := bf;
EXPORT county_land_use_description_max := MAX(county_land_use_description_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(county_land_use_description_values_persisted,county_land_use_description,county_land_use_description_nulls,ol) // Compute column level specificity
EXPORT county_land_use_description_specificity := ol;
SALT30.MAC_Field_Nulls(standardized_land_use_code_values_persisted,Layout_Specificities.standardized_land_use_code_ChildRec,nv) // Use automated NULL spotting
EXPORT standardized_land_use_code_nulls := nv;
SALT30.MAC_Field_Bfoul(standardized_land_use_code_deduped,standardized_land_use_code,,standardized_land_use_code_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT standardized_land_use_code_switch := bf;
EXPORT standardized_land_use_code_max := MAX(standardized_land_use_code_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(standardized_land_use_code_values_persisted,standardized_land_use_code,standardized_land_use_code_nulls,ol) // Compute column level specificity
EXPORT standardized_land_use_code_specificity := ol;
SALT30.MAC_Field_Nulls(timeshare_code_values_persisted,Layout_Specificities.timeshare_code_ChildRec,nv) // Use automated NULL spotting
EXPORT timeshare_code_nulls := nv;
SALT30.MAC_Field_Bfoul(timeshare_code_deduped,timeshare_code,,timeshare_code_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT timeshare_code_switch := bf;
EXPORT timeshare_code_max := MAX(timeshare_code_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(timeshare_code_values_persisted,timeshare_code,timeshare_code_nulls,ol) // Compute column level specificity
EXPORT timeshare_code_specificity := ol;
SALT30.MAC_Field_Nulls(zoning_values_persisted,Layout_Specificities.zoning_ChildRec,nv) // Use automated NULL spotting
EXPORT zoning_nulls := nv;
SALT30.MAC_Field_Bfoul(zoning_deduped,zoning,,zoning_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT zoning_switch := bf;
EXPORT zoning_max := MAX(zoning_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(zoning_values_persisted,zoning,zoning_nulls,ol) // Compute column level specificity
EXPORT zoning_specificity := ol;
SALT30.MAC_Field_Nulls(owner_occupied_values_persisted,Layout_Specificities.owner_occupied_ChildRec,nv) // Use automated NULL spotting
EXPORT owner_occupied_nulls := nv;
SALT30.MAC_Field_Bfoul(owner_occupied_deduped,owner_occupied,,owner_occupied_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT owner_occupied_switch := bf;
EXPORT owner_occupied_max := MAX(owner_occupied_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(owner_occupied_values_persisted,owner_occupied,owner_occupied_nulls,ol) // Compute column level specificity
EXPORT owner_occupied_specificity := ol;
SALT30.MAC_Field_Nulls(recorder_document_number_values_persisted,Layout_Specificities.recorder_document_number_ChildRec,nv) // Use automated NULL spotting
EXPORT recorder_document_number_nulls := nv;
SALT30.MAC_Field_Bfoul(recorder_document_number_deduped,recorder_document_number,,recorder_document_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT recorder_document_number_switch := bf;
EXPORT recorder_document_number_max := MAX(recorder_document_number_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(recorder_document_number_values_persisted,recorder_document_number,recorder_document_number_nulls,ol) // Compute column level specificity
EXPORT recorder_document_number_specificity := ol;
SALT30.MAC_Field_Nulls(recorder_book_number_values_persisted,Layout_Specificities.recorder_book_number_ChildRec,nv) // Use automated NULL spotting
EXPORT recorder_book_number_nulls := nv;
SALT30.MAC_Field_Bfoul(recorder_book_number_deduped,recorder_book_number,,recorder_book_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT recorder_book_number_switch := bf;
EXPORT recorder_book_number_max := MAX(recorder_book_number_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(recorder_book_number_values_persisted,recorder_book_number,recorder_book_number_nulls,ol) // Compute column level specificity
EXPORT recorder_book_number_specificity := ol;
SALT30.MAC_Field_Nulls(recorder_page_number_values_persisted,Layout_Specificities.recorder_page_number_ChildRec,nv) // Use automated NULL spotting
EXPORT recorder_page_number_nulls := nv;
SALT30.MAC_Field_Bfoul(recorder_page_number_deduped,recorder_page_number,,recorder_page_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT recorder_page_number_switch := bf;
EXPORT recorder_page_number_max := MAX(recorder_page_number_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(recorder_page_number_values_persisted,recorder_page_number,recorder_page_number_nulls,ol) // Compute column level specificity
EXPORT recorder_page_number_specificity := ol;
SALT30.MAC_Field_Nulls(transfer_date_values_persisted,Layout_Specificities.transfer_date_ChildRec,nv) // Use automated NULL spotting
EXPORT transfer_date_nulls := nv;
SALT30.MAC_Field_Bfoul(transfer_date_deduped,transfer_date,,transfer_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT transfer_date_switch := bf;
EXPORT transfer_date_max := MAX(transfer_date_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(transfer_date_values_persisted,transfer_date,transfer_date_nulls,ol) // Compute column level specificity
EXPORT transfer_date_specificity := ol;
SALT30.MAC_Field_Nulls(recording_date_values_persisted,Layout_Specificities.recording_date_ChildRec,nv) // Use automated NULL spotting
EXPORT recording_date_nulls := nv;
SALT30.MAC_Field_Bfoul(recording_date_deduped,recording_date,,recording_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT recording_date_switch := bf;
EXPORT recording_date_max := MAX(recording_date_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(recording_date_values_persisted,recording_date,recording_date_nulls,ol) // Compute column level specificity
EXPORT recording_date_specificity := ol;
SALT30.MAC_Field_Nulls(sale_date_values_persisted,Layout_Specificities.sale_date_ChildRec,nv) // Use automated NULL spotting
EXPORT sale_date_nulls := nv;
SALT30.MAC_Field_Bfoul(sale_date_deduped,sale_date,,sale_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT sale_date_switch := bf;
EXPORT sale_date_max := MAX(sale_date_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(sale_date_values_persisted,sale_date,sale_date_nulls,ol) // Compute column level specificity
EXPORT sale_date_specificity := ol;
SALT30.MAC_Field_Nulls(document_type_values_persisted,Layout_Specificities.document_type_ChildRec,nv) // Use automated NULL spotting
EXPORT document_type_nulls := nv;
SALT30.MAC_Field_Bfoul(document_type_deduped,document_type,,document_type_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT document_type_switch := bf;
EXPORT document_type_max := MAX(document_type_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(document_type_values_persisted,document_type,document_type_nulls,ol) // Compute column level specificity
EXPORT document_type_specificity := ol;
SALT30.MAC_Field_Nulls(sales_price_values_persisted,Layout_Specificities.sales_price_ChildRec,nv) // Use automated NULL spotting
EXPORT sales_price_nulls := nv;
SALT30.MAC_Field_Bfoul(sales_price_deduped,sales_price,,sales_price_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT sales_price_switch := bf;
EXPORT sales_price_max := MAX(sales_price_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(sales_price_values_persisted,sales_price,sales_price_nulls,ol) // Compute column level specificity
EXPORT sales_price_specificity := ol;
SALT30.MAC_Field_Nulls(sales_price_code_values_persisted,Layout_Specificities.sales_price_code_ChildRec,nv) // Use automated NULL spotting
EXPORT sales_price_code_nulls := nv;
SALT30.MAC_Field_Bfoul(sales_price_code_deduped,sales_price_code,,sales_price_code_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT sales_price_code_switch := bf;
EXPORT sales_price_code_max := MAX(sales_price_code_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(sales_price_code_values_persisted,sales_price_code,sales_price_code_nulls,ol) // Compute column level specificity
EXPORT sales_price_code_specificity := ol;
SALT30.MAC_Field_Nulls(mortgage_loan_amount_values_persisted,Layout_Specificities.mortgage_loan_amount_ChildRec,nv) // Use automated NULL spotting
EXPORT mortgage_loan_amount_nulls := nv;
SALT30.MAC_Field_Bfoul(mortgage_loan_amount_deduped,mortgage_loan_amount,,mortgage_loan_amount_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT mortgage_loan_amount_switch := bf;
EXPORT mortgage_loan_amount_max := MAX(mortgage_loan_amount_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(mortgage_loan_amount_values_persisted,mortgage_loan_amount,mortgage_loan_amount_nulls,ol) // Compute column level specificity
EXPORT mortgage_loan_amount_specificity := ol;
SALT30.MAC_Field_Nulls(mortgage_loan_type_code_values_persisted,Layout_Specificities.mortgage_loan_type_code_ChildRec,nv) // Use automated NULL spotting
EXPORT mortgage_loan_type_code_nulls := nv;
SALT30.MAC_Field_Bfoul(mortgage_loan_type_code_deduped,mortgage_loan_type_code,,mortgage_loan_type_code_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT mortgage_loan_type_code_switch := bf;
EXPORT mortgage_loan_type_code_max := MAX(mortgage_loan_type_code_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(mortgage_loan_type_code_values_persisted,mortgage_loan_type_code,mortgage_loan_type_code_nulls,ol) // Compute column level specificity
EXPORT mortgage_loan_type_code_specificity := ol;
SALT30.MAC_Field_Nulls(mortgage_lender_name_values_persisted,Layout_Specificities.mortgage_lender_name_ChildRec,nv) // Use automated NULL spotting
EXPORT mortgage_lender_name_nulls := nv;
SALT30.MAC_Field_Bfoul(mortgage_lender_name_deduped,mortgage_lender_name,,mortgage_lender_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT mortgage_lender_name_switch := bf;
EXPORT mortgage_lender_name_max := MAX(mortgage_lender_name_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(mortgage_lender_name_values_persisted,mortgage_lender_name,mortgage_lender_name_nulls,ol) // Compute column level specificity
EXPORT mortgage_lender_name_specificity := ol;
SALT30.MAC_Field_Nulls(mortgage_lender_type_code_values_persisted,Layout_Specificities.mortgage_lender_type_code_ChildRec,nv) // Use automated NULL spotting
EXPORT mortgage_lender_type_code_nulls := nv;
SALT30.MAC_Field_Bfoul(mortgage_lender_type_code_deduped,mortgage_lender_type_code,,mortgage_lender_type_code_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT mortgage_lender_type_code_switch := bf;
EXPORT mortgage_lender_type_code_max := MAX(mortgage_lender_type_code_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(mortgage_lender_type_code_values_persisted,mortgage_lender_type_code,mortgage_lender_type_code_nulls,ol) // Compute column level specificity
EXPORT mortgage_lender_type_code_specificity := ol;
SALT30.MAC_Field_Nulls(prior_transfer_date_values_persisted,Layout_Specificities.prior_transfer_date_ChildRec,nv) // Use automated NULL spotting
EXPORT prior_transfer_date_nulls := nv;
SALT30.MAC_Field_Bfoul(prior_transfer_date_deduped,prior_transfer_date,,prior_transfer_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prior_transfer_date_switch := bf;
EXPORT prior_transfer_date_max := MAX(prior_transfer_date_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(prior_transfer_date_values_persisted,prior_transfer_date,prior_transfer_date_nulls,ol) // Compute column level specificity
EXPORT prior_transfer_date_specificity := ol;
SALT30.MAC_Field_Nulls(prior_recording_date_values_persisted,Layout_Specificities.prior_recording_date_ChildRec,nv) // Use automated NULL spotting
EXPORT prior_recording_date_nulls := nv;
SALT30.MAC_Field_Bfoul(prior_recording_date_deduped,prior_recording_date,,prior_recording_date_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prior_recording_date_switch := bf;
EXPORT prior_recording_date_max := MAX(prior_recording_date_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(prior_recording_date_values_persisted,prior_recording_date,prior_recording_date_nulls,ol) // Compute column level specificity
EXPORT prior_recording_date_specificity := ol;
SALT30.MAC_Field_Nulls(prior_sales_price_values_persisted,Layout_Specificities.prior_sales_price_ChildRec,nv) // Use automated NULL spotting
EXPORT prior_sales_price_nulls := nv;
SALT30.MAC_Field_Bfoul(prior_sales_price_deduped,prior_sales_price,,prior_sales_price_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prior_sales_price_switch := bf;
EXPORT prior_sales_price_max := MAX(prior_sales_price_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(prior_sales_price_values_persisted,prior_sales_price,prior_sales_price_nulls,ol) // Compute column level specificity
EXPORT prior_sales_price_specificity := ol;
SALT30.MAC_Field_Nulls(prior_sales_price_code_values_persisted,Layout_Specificities.prior_sales_price_code_ChildRec,nv) // Use automated NULL spotting
EXPORT prior_sales_price_code_nulls := nv;
SALT30.MAC_Field_Bfoul(prior_sales_price_code_deduped,prior_sales_price_code,,prior_sales_price_code_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prior_sales_price_code_switch := bf;
EXPORT prior_sales_price_code_max := MAX(prior_sales_price_code_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(prior_sales_price_code_values_persisted,prior_sales_price_code,prior_sales_price_code_nulls,ol) // Compute column level specificity
EXPORT prior_sales_price_code_specificity := ol;
SALT30.MAC_Field_Nulls(assessed_land_value_values_persisted,Layout_Specificities.assessed_land_value_ChildRec,nv) // Use automated NULL spotting
EXPORT assessed_land_value_nulls := nv;
SALT30.MAC_Field_Bfoul(assessed_land_value_deduped,assessed_land_value,,assessed_land_value_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT assessed_land_value_switch := bf;
EXPORT assessed_land_value_max := MAX(assessed_land_value_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(assessed_land_value_values_persisted,assessed_land_value,assessed_land_value_nulls,ol) // Compute column level specificity
EXPORT assessed_land_value_specificity := ol;
SALT30.MAC_Field_Nulls(assessed_improvement_value_values_persisted,Layout_Specificities.assessed_improvement_value_ChildRec,nv) // Use automated NULL spotting
EXPORT assessed_improvement_value_nulls := nv;
SALT30.MAC_Field_Bfoul(assessed_improvement_value_deduped,assessed_improvement_value,,assessed_improvement_value_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT assessed_improvement_value_switch := bf;
EXPORT assessed_improvement_value_max := MAX(assessed_improvement_value_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(assessed_improvement_value_values_persisted,assessed_improvement_value,assessed_improvement_value_nulls,ol) // Compute column level specificity
EXPORT assessed_improvement_value_specificity := ol;
SALT30.MAC_Field_Nulls(assessed_total_value_values_persisted,Layout_Specificities.assessed_total_value_ChildRec,nv) // Use automated NULL spotting
EXPORT assessed_total_value_nulls := nv;
SALT30.MAC_Field_Bfoul(assessed_total_value_deduped,assessed_total_value,,assessed_total_value_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT assessed_total_value_switch := bf;
EXPORT assessed_total_value_max := MAX(assessed_total_value_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(assessed_total_value_values_persisted,assessed_total_value,assessed_total_value_nulls,ol) // Compute column level specificity
EXPORT assessed_total_value_specificity := ol;
SALT30.MAC_Field_Nulls(assessed_value_year_values_persisted,Layout_Specificities.assessed_value_year_ChildRec,nv) // Use automated NULL spotting
EXPORT assessed_value_year_nulls := nv;
SALT30.MAC_Field_Bfoul(assessed_value_year_deduped,assessed_value_year,,assessed_value_year_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT assessed_value_year_switch := bf;
EXPORT assessed_value_year_max := MAX(assessed_value_year_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(assessed_value_year_values_persisted,assessed_value_year,assessed_value_year_nulls,ol) // Compute column level specificity
EXPORT assessed_value_year_specificity := ol;
SALT30.MAC_Field_Nulls(market_land_value_values_persisted,Layout_Specificities.market_land_value_ChildRec,nv) // Use automated NULL spotting
EXPORT market_land_value_nulls := nv;
SALT30.MAC_Field_Bfoul(market_land_value_deduped,market_land_value,,market_land_value_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT market_land_value_switch := bf;
EXPORT market_land_value_max := MAX(market_land_value_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(market_land_value_values_persisted,market_land_value,market_land_value_nulls,ol) // Compute column level specificity
EXPORT market_land_value_specificity := ol;
SALT30.MAC_Field_Nulls(market_improvement_value_values_persisted,Layout_Specificities.market_improvement_value_ChildRec,nv) // Use automated NULL spotting
EXPORT market_improvement_value_nulls := nv;
SALT30.MAC_Field_Bfoul(market_improvement_value_deduped,market_improvement_value,,market_improvement_value_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT market_improvement_value_switch := bf;
EXPORT market_improvement_value_max := MAX(market_improvement_value_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(market_improvement_value_values_persisted,market_improvement_value,market_improvement_value_nulls,ol) // Compute column level specificity
EXPORT market_improvement_value_specificity := ol;
SALT30.MAC_Field_Nulls(market_total_value_values_persisted,Layout_Specificities.market_total_value_ChildRec,nv) // Use automated NULL spotting
EXPORT market_total_value_nulls := nv;
SALT30.MAC_Field_Bfoul(market_total_value_deduped,market_total_value,,market_total_value_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT market_total_value_switch := bf;
EXPORT market_total_value_max := MAX(market_total_value_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(market_total_value_values_persisted,market_total_value,market_total_value_nulls,ol) // Compute column level specificity
EXPORT market_total_value_specificity := ol;
SALT30.MAC_Field_Nulls(market_value_year_values_persisted,Layout_Specificities.market_value_year_ChildRec,nv) // Use automated NULL spotting
EXPORT market_value_year_nulls := nv;
SALT30.MAC_Field_Bfoul(market_value_year_deduped,market_value_year,,market_value_year_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT market_value_year_switch := bf;
EXPORT market_value_year_max := MAX(market_value_year_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(market_value_year_values_persisted,market_value_year,market_value_year_nulls,ol) // Compute column level specificity
EXPORT market_value_year_specificity := ol;
SALT30.MAC_Field_Nulls(homestead_homeowner_exemption_values_persisted,Layout_Specificities.homestead_homeowner_exemption_ChildRec,nv) // Use automated NULL spotting
EXPORT homestead_homeowner_exemption_nulls := nv;
SALT30.MAC_Field_Bfoul(homestead_homeowner_exemption_deduped,homestead_homeowner_exemption,,homestead_homeowner_exemption_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT homestead_homeowner_exemption_switch := bf;
EXPORT homestead_homeowner_exemption_max := MAX(homestead_homeowner_exemption_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(homestead_homeowner_exemption_values_persisted,homestead_homeowner_exemption,homestead_homeowner_exemption_nulls,ol) // Compute column level specificity
EXPORT homestead_homeowner_exemption_specificity := ol;
SALT30.MAC_Field_Nulls(tax_exemption1_code_values_persisted,Layout_Specificities.tax_exemption1_code_ChildRec,nv) // Use automated NULL spotting
EXPORT tax_exemption1_code_nulls := nv;
SALT30.MAC_Field_Bfoul(tax_exemption1_code_deduped,tax_exemption1_code,,tax_exemption1_code_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT tax_exemption1_code_switch := bf;
EXPORT tax_exemption1_code_max := MAX(tax_exemption1_code_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(tax_exemption1_code_values_persisted,tax_exemption1_code,tax_exemption1_code_nulls,ol) // Compute column level specificity
EXPORT tax_exemption1_code_specificity := ol;
SALT30.MAC_Field_Nulls(tax_exemption2_code_values_persisted,Layout_Specificities.tax_exemption2_code_ChildRec,nv) // Use automated NULL spotting
EXPORT tax_exemption2_code_nulls := nv;
SALT30.MAC_Field_Bfoul(tax_exemption2_code_deduped,tax_exemption2_code,,tax_exemption2_code_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT tax_exemption2_code_switch := bf;
EXPORT tax_exemption2_code_max := MAX(tax_exemption2_code_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(tax_exemption2_code_values_persisted,tax_exemption2_code,tax_exemption2_code_nulls,ol) // Compute column level specificity
EXPORT tax_exemption2_code_specificity := ol;
SALT30.MAC_Field_Nulls(tax_exemption3_code_values_persisted,Layout_Specificities.tax_exemption3_code_ChildRec,nv) // Use automated NULL spotting
EXPORT tax_exemption3_code_nulls := nv;
SALT30.MAC_Field_Bfoul(tax_exemption3_code_deduped,tax_exemption3_code,,tax_exemption3_code_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT tax_exemption3_code_switch := bf;
EXPORT tax_exemption3_code_max := MAX(tax_exemption3_code_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(tax_exemption3_code_values_persisted,tax_exemption3_code,tax_exemption3_code_nulls,ol) // Compute column level specificity
EXPORT tax_exemption3_code_specificity := ol;
SALT30.MAC_Field_Nulls(tax_exemption4_code_values_persisted,Layout_Specificities.tax_exemption4_code_ChildRec,nv) // Use automated NULL spotting
EXPORT tax_exemption4_code_nulls := nv;
SALT30.MAC_Field_Bfoul(tax_exemption4_code_deduped,tax_exemption4_code,,tax_exemption4_code_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT tax_exemption4_code_switch := bf;
EXPORT tax_exemption4_code_max := MAX(tax_exemption4_code_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(tax_exemption4_code_values_persisted,tax_exemption4_code,tax_exemption4_code_nulls,ol) // Compute column level specificity
EXPORT tax_exemption4_code_specificity := ol;
SALT30.MAC_Field_Nulls(tax_rate_code_area_values_persisted,Layout_Specificities.tax_rate_code_area_ChildRec,nv) // Use automated NULL spotting
EXPORT tax_rate_code_area_nulls := nv;
SALT30.MAC_Field_Bfoul(tax_rate_code_area_deduped,tax_rate_code_area,,tax_rate_code_area_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT tax_rate_code_area_switch := bf;
EXPORT tax_rate_code_area_max := MAX(tax_rate_code_area_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(tax_rate_code_area_values_persisted,tax_rate_code_area,tax_rate_code_area_nulls,ol) // Compute column level specificity
EXPORT tax_rate_code_area_specificity := ol;
SALT30.MAC_Field_Nulls(tax_amount_values_persisted,Layout_Specificities.tax_amount_ChildRec,nv) // Use automated NULL spotting
EXPORT tax_amount_nulls := nv;
SALT30.MAC_Field_Bfoul(tax_amount_deduped,tax_amount,,tax_amount_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT tax_amount_switch := bf;
EXPORT tax_amount_max := MAX(tax_amount_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(tax_amount_values_persisted,tax_amount,tax_amount_nulls,ol) // Compute column level specificity
EXPORT tax_amount_specificity := ol;
SALT30.MAC_Field_Nulls(tax_year_values_persisted,Layout_Specificities.tax_year_ChildRec,nv) // Use automated NULL spotting
EXPORT tax_year_nulls := nv;
SALT30.MAC_Field_Bfoul(tax_year_deduped,tax_year,,tax_year_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT tax_year_switch := bf;
EXPORT tax_year_max := MAX(tax_year_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(tax_year_values_persisted,tax_year,tax_year_nulls,ol) // Compute column level specificity
EXPORT tax_year_specificity := ol;
SALT30.MAC_Field_Nulls(tax_delinquent_year_values_persisted,Layout_Specificities.tax_delinquent_year_ChildRec,nv) // Use automated NULL spotting
EXPORT tax_delinquent_year_nulls := nv;
SALT30.MAC_Field_Bfoul(tax_delinquent_year_deduped,tax_delinquent_year,,tax_delinquent_year_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT tax_delinquent_year_switch := bf;
EXPORT tax_delinquent_year_max := MAX(tax_delinquent_year_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(tax_delinquent_year_values_persisted,tax_delinquent_year,tax_delinquent_year_nulls,ol) // Compute column level specificity
EXPORT tax_delinquent_year_specificity := ol;
SALT30.MAC_Field_Nulls(school_tax_district1_values_persisted,Layout_Specificities.school_tax_district1_ChildRec,nv) // Use automated NULL spotting
EXPORT school_tax_district1_nulls := nv;
SALT30.MAC_Field_Bfoul(school_tax_district1_deduped,school_tax_district1,,school_tax_district1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT school_tax_district1_switch := bf;
EXPORT school_tax_district1_max := MAX(school_tax_district1_values_persisted,field_specificity);
SALT30.MAC_Field_Specificity(school_tax_district1_values_persisted,school_tax_district1,school_tax_district1_nulls,ol) // Compute column level specificity
EXPORT school_tax_district1_specificity := ol;
iSpecificities := DATASET([{0,ln_fares_id_specificity,ln_fares_id_switch,ln_fares_id_max,ln_fares_id_nulls,process_date_specificity,process_date_switch,process_date_max,process_date_nulls,vendor_source_flag_specificity,vendor_source_flag_switch,vendor_source_flag_max,vendor_source_flag_nulls,current_record_specificity,current_record_switch,current_record_max,current_record_nulls,fips_code_specificity,fips_code_switch,fips_code_max,fips_code_nulls,state_code_specificity,state_code_switch,state_code_max,state_code_nulls,county_name_specificity,county_name_switch,county_name_max,county_name_nulls,old_apn_specificity,old_apn_switch,old_apn_max,old_apn_nulls,apna_or_pin_number_specificity,apna_or_pin_number_switch,apna_or_pin_number_max,apna_or_pin_number_nulls,fares_unformatted_apn_specificity,fares_unformatted_apn_switch,fares_unformatted_apn_max,fares_unformatted_apn_nulls,duplicate_apn_multiple_address_id_specificity,duplicate_apn_multiple_address_id_switch,duplicate_apn_multiple_address_id_max,duplicate_apn_multiple_address_id_nulls,assessee_name_specificity,assessee_name_switch,assessee_name_max,assessee_name_nulls,second_assessee_name_specificity,second_assessee_name_switch,second_assessee_name_max,second_assessee_name_nulls,assessee_ownership_rights_code_specificity,assessee_ownership_rights_code_switch,assessee_ownership_rights_code_max,assessee_ownership_rights_code_nulls,assessee_relationship_code_specificity,assessee_relationship_code_switch,assessee_relationship_code_max,assessee_relationship_code_nulls,assessee_phone_number_specificity,assessee_phone_number_switch,assessee_phone_number_max,assessee_phone_number_nulls,tax_account_number_specificity,tax_account_number_switch,tax_account_number_max,tax_account_number_nulls,contract_owner_specificity,contract_owner_switch,contract_owner_max,contract_owner_nulls,assessee_name_type_code_specificity,assessee_name_type_code_switch,assessee_name_type_code_max,assessee_name_type_code_nulls,second_assessee_name_type_code_specificity,second_assessee_name_type_code_switch,second_assessee_name_type_code_max,second_assessee_name_type_code_nulls,mail_care_of_name_type_code_specificity,mail_care_of_name_type_code_switch,mail_care_of_name_type_code_max,mail_care_of_name_type_code_nulls,mailing_care_of_name_specificity,mailing_care_of_name_switch,mailing_care_of_name_max,mailing_care_of_name_nulls,mailing_full_street_address_specificity,mailing_full_street_address_switch,mailing_full_street_address_max,mailing_full_street_address_nulls,mailing_unit_number_specificity,mailing_unit_number_switch,mailing_unit_number_max,mailing_unit_number_nulls,mailing_city_state_zip_specificity,mailing_city_state_zip_switch,mailing_city_state_zip_max,mailing_city_state_zip_nulls,property_full_street_address_specificity,property_full_street_address_switch,property_full_street_address_max,property_full_street_address_nulls,property_unit_number_specificity,property_unit_number_switch,property_unit_number_max,property_unit_number_nulls,property_city_state_zip_specificity,property_city_state_zip_switch,property_city_state_zip_max,property_city_state_zip_nulls,property_country_code_specificity,property_country_code_switch,property_country_code_max,property_country_code_nulls,property_address_code_specificity,property_address_code_switch,property_address_code_max,property_address_code_nulls,legal_lot_code_specificity,legal_lot_code_switch,legal_lot_code_max,legal_lot_code_nulls,legal_lot_number_specificity,legal_lot_number_switch,legal_lot_number_max,legal_lot_number_nulls,legal_land_lot_specificity,legal_land_lot_switch,legal_land_lot_max,legal_land_lot_nulls,legal_block_specificity,legal_block_switch,legal_block_max,legal_block_nulls,legal_section_specificity,legal_section_switch,legal_section_max,legal_section_nulls,legal_district_specificity,legal_district_switch,legal_district_max,legal_district_nulls,legal_unit_specificity,legal_unit_switch,legal_unit_max,legal_unit_nulls,legal_city_municipality_township_specificity,legal_city_municipality_township_switch,legal_city_municipality_township_max,legal_city_municipality_township_nulls,legal_subdivision_name_specificity,legal_subdivision_name_switch,legal_subdivision_name_max,legal_subdivision_name_nulls,legal_phase_number_specificity,legal_phase_number_switch,legal_phase_number_max,legal_phase_number_nulls,legal_tract_number_specificity,legal_tract_number_switch,legal_tract_number_max,legal_tract_number_nulls,legal_sec_twn_rng_mer_specificity,legal_sec_twn_rng_mer_switch,legal_sec_twn_rng_mer_max,legal_sec_twn_rng_mer_nulls,legal_brief_description_specificity,legal_brief_description_switch,legal_brief_description_max,legal_brief_description_nulls,legal_assessor_map_ref_specificity,legal_assessor_map_ref_switch,legal_assessor_map_ref_max,legal_assessor_map_ref_nulls,census_tract_specificity,census_tract_switch,census_tract_max,census_tract_nulls,record_type_code_specificity,record_type_code_switch,record_type_code_max,record_type_code_nulls,ownership_type_code_specificity,ownership_type_code_switch,ownership_type_code_max,ownership_type_code_nulls,new_record_type_code_specificity,new_record_type_code_switch,new_record_type_code_max,new_record_type_code_nulls,state_land_use_code_specificity,state_land_use_code_switch,state_land_use_code_max,state_land_use_code_nulls,county_land_use_code_specificity,county_land_use_code_switch,county_land_use_code_max,county_land_use_code_nulls,county_land_use_description_specificity,county_land_use_description_switch,county_land_use_description_max,county_land_use_description_nulls,standardized_land_use_code_specificity,standardized_land_use_code_switch,standardized_land_use_code_max,standardized_land_use_code_nulls,timeshare_code_specificity,timeshare_code_switch,timeshare_code_max,timeshare_code_nulls,zoning_specificity,zoning_switch,zoning_max,zoning_nulls,owner_occupied_specificity,owner_occupied_switch,owner_occupied_max,owner_occupied_nulls,recorder_document_number_specificity,recorder_document_number_switch,recorder_document_number_max,recorder_document_number_nulls,recorder_book_number_specificity,recorder_book_number_switch,recorder_book_number_max,recorder_book_number_nulls,recorder_page_number_specificity,recorder_page_number_switch,recorder_page_number_max,recorder_page_number_nulls,transfer_date_specificity,transfer_date_switch,transfer_date_max,transfer_date_nulls,recording_date_specificity,recording_date_switch,recording_date_max,recording_date_nulls,sale_date_specificity,sale_date_switch,sale_date_max,sale_date_nulls,document_type_specificity,document_type_switch,document_type_max,document_type_nulls,sales_price_specificity,sales_price_switch,sales_price_max,sales_price_nulls,sales_price_code_specificity,sales_price_code_switch,sales_price_code_max,sales_price_code_nulls,mortgage_loan_amount_specificity,mortgage_loan_amount_switch,mortgage_loan_amount_max,mortgage_loan_amount_nulls,mortgage_loan_type_code_specificity,mortgage_loan_type_code_switch,mortgage_loan_type_code_max,mortgage_loan_type_code_nulls,mortgage_lender_name_specificity,mortgage_lender_name_switch,mortgage_lender_name_max,mortgage_lender_name_nulls,mortgage_lender_type_code_specificity,mortgage_lender_type_code_switch,mortgage_lender_type_code_max,mortgage_lender_type_code_nulls,prior_transfer_date_specificity,prior_transfer_date_switch,prior_transfer_date_max,prior_transfer_date_nulls,prior_recording_date_specificity,prior_recording_date_switch,prior_recording_date_max,prior_recording_date_nulls,prior_sales_price_specificity,prior_sales_price_switch,prior_sales_price_max,prior_sales_price_nulls,prior_sales_price_code_specificity,prior_sales_price_code_switch,prior_sales_price_code_max,prior_sales_price_code_nulls,assessed_land_value_specificity,assessed_land_value_switch,assessed_land_value_max,assessed_land_value_nulls,assessed_improvement_value_specificity,assessed_improvement_value_switch,assessed_improvement_value_max,assessed_improvement_value_nulls,assessed_total_value_specificity,assessed_total_value_switch,assessed_total_value_max,assessed_total_value_nulls,assessed_value_year_specificity,assessed_value_year_switch,assessed_value_year_max,assessed_value_year_nulls,market_land_value_specificity,market_land_value_switch,market_land_value_max,market_land_value_nulls,market_improvement_value_specificity,market_improvement_value_switch,market_improvement_value_max,market_improvement_value_nulls,market_total_value_specificity,market_total_value_switch,market_total_value_max,market_total_value_nulls,market_value_year_specificity,market_value_year_switch,market_value_year_max,market_value_year_nulls,homestead_homeowner_exemption_specificity,homestead_homeowner_exemption_switch,homestead_homeowner_exemption_max,homestead_homeowner_exemption_nulls,tax_exemption1_code_specificity,tax_exemption1_code_switch,tax_exemption1_code_max,tax_exemption1_code_nulls,tax_exemption2_code_specificity,tax_exemption2_code_switch,tax_exemption2_code_max,tax_exemption2_code_nulls,tax_exemption3_code_specificity,tax_exemption3_code_switch,tax_exemption3_code_max,tax_exemption3_code_nulls,tax_exemption4_code_specificity,tax_exemption4_code_switch,tax_exemption4_code_max,tax_exemption4_code_nulls,tax_rate_code_area_specificity,tax_rate_code_area_switch,tax_rate_code_area_max,tax_rate_code_area_nulls,tax_amount_specificity,tax_amount_switch,tax_amount_max,tax_amount_nulls,tax_year_specificity,tax_year_switch,tax_year_max,tax_year_nulls,tax_delinquent_year_specificity,tax_delinquent_year_switch,tax_delinquent_year_max,tax_delinquent_year_nulls,school_tax_district1_specificity,school_tax_district1_switch,school_tax_district1_max,school_tax_district1_nulls}],Layout_Specificities.R) : PERSIST('~temp::::aherzberg_property_salt::Specificities',EXPIRE(30));
EXPORT Specificities := iSpecificities;
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 ln_fares_id_shift0 := ROUND(Specificities[1].ln_fares_id_specificity - 0);
  integer2 ln_fares_id_switch_shift0 := ROUND(1000*Specificities[1].ln_fares_id_switch - 0);
  integer1 process_date_shift0 := ROUND(Specificities[1].process_date_specificity - 0);
  integer2 process_date_switch_shift0 := ROUND(1000*Specificities[1].process_date_switch - 0);
  integer1 vendor_source_flag_shift0 := ROUND(Specificities[1].vendor_source_flag_specificity - 0);
  integer2 vendor_source_flag_switch_shift0 := ROUND(1000*Specificities[1].vendor_source_flag_switch - 0);
  integer1 current_record_shift0 := ROUND(Specificities[1].current_record_specificity - 0);
  integer2 current_record_switch_shift0 := ROUND(1000*Specificities[1].current_record_switch - 0);
  integer1 fips_code_shift0 := ROUND(Specificities[1].fips_code_specificity - 0);
  integer2 fips_code_switch_shift0 := ROUND(1000*Specificities[1].fips_code_switch - 0);
  integer1 state_code_shift0 := ROUND(Specificities[1].state_code_specificity - 0);
  integer2 state_code_switch_shift0 := ROUND(1000*Specificities[1].state_code_switch - 0);
  integer1 county_name_shift0 := ROUND(Specificities[1].county_name_specificity - 0);
  integer2 county_name_switch_shift0 := ROUND(1000*Specificities[1].county_name_switch - 0);
  integer1 old_apn_shift0 := ROUND(Specificities[1].old_apn_specificity - 0);
  integer2 old_apn_switch_shift0 := ROUND(1000*Specificities[1].old_apn_switch - 0);
  integer1 apna_or_pin_number_shift0 := ROUND(Specificities[1].apna_or_pin_number_specificity - 0);
  integer2 apna_or_pin_number_switch_shift0 := ROUND(1000*Specificities[1].apna_or_pin_number_switch - 0);
  integer1 fares_unformatted_apn_shift0 := ROUND(Specificities[1].fares_unformatted_apn_specificity - 0);
  integer2 fares_unformatted_apn_switch_shift0 := ROUND(1000*Specificities[1].fares_unformatted_apn_switch - 0);
  integer1 duplicate_apn_multiple_address_id_shift0 := ROUND(Specificities[1].duplicate_apn_multiple_address_id_specificity - 0);
  integer2 duplicate_apn_multiple_address_id_switch_shift0 := ROUND(1000*Specificities[1].duplicate_apn_multiple_address_id_switch - 0);
  integer1 assessee_name_shift0 := ROUND(Specificities[1].assessee_name_specificity - 0);
  integer2 assessee_name_switch_shift0 := ROUND(1000*Specificities[1].assessee_name_switch - 0);
  integer1 second_assessee_name_shift0 := ROUND(Specificities[1].second_assessee_name_specificity - 0);
  integer2 second_assessee_name_switch_shift0 := ROUND(1000*Specificities[1].second_assessee_name_switch - 0);
  integer1 assessee_ownership_rights_code_shift0 := ROUND(Specificities[1].assessee_ownership_rights_code_specificity - 0);
  integer2 assessee_ownership_rights_code_switch_shift0 := ROUND(1000*Specificities[1].assessee_ownership_rights_code_switch - 0);
  integer1 assessee_relationship_code_shift0 := ROUND(Specificities[1].assessee_relationship_code_specificity - 0);
  integer2 assessee_relationship_code_switch_shift0 := ROUND(1000*Specificities[1].assessee_relationship_code_switch - 0);
  integer1 assessee_phone_number_shift0 := ROUND(Specificities[1].assessee_phone_number_specificity - 0);
  integer2 assessee_phone_number_switch_shift0 := ROUND(1000*Specificities[1].assessee_phone_number_switch - 0);
  integer1 tax_account_number_shift0 := ROUND(Specificities[1].tax_account_number_specificity - 0);
  integer2 tax_account_number_switch_shift0 := ROUND(1000*Specificities[1].tax_account_number_switch - 0);
  integer1 contract_owner_shift0 := ROUND(Specificities[1].contract_owner_specificity - 0);
  integer2 contract_owner_switch_shift0 := ROUND(1000*Specificities[1].contract_owner_switch - 0);
  integer1 assessee_name_type_code_shift0 := ROUND(Specificities[1].assessee_name_type_code_specificity - 0);
  integer2 assessee_name_type_code_switch_shift0 := ROUND(1000*Specificities[1].assessee_name_type_code_switch - 0);
  integer1 second_assessee_name_type_code_shift0 := ROUND(Specificities[1].second_assessee_name_type_code_specificity - 0);
  integer2 second_assessee_name_type_code_switch_shift0 := ROUND(1000*Specificities[1].second_assessee_name_type_code_switch - 0);
  integer1 mail_care_of_name_type_code_shift0 := ROUND(Specificities[1].mail_care_of_name_type_code_specificity - 0);
  integer2 mail_care_of_name_type_code_switch_shift0 := ROUND(1000*Specificities[1].mail_care_of_name_type_code_switch - 0);
  integer1 mailing_care_of_name_shift0 := ROUND(Specificities[1].mailing_care_of_name_specificity - 0);
  integer2 mailing_care_of_name_switch_shift0 := ROUND(1000*Specificities[1].mailing_care_of_name_switch - 0);
  integer1 mailing_full_street_address_shift0 := ROUND(Specificities[1].mailing_full_street_address_specificity - 0);
  integer2 mailing_full_street_address_switch_shift0 := ROUND(1000*Specificities[1].mailing_full_street_address_switch - 0);
  integer1 mailing_unit_number_shift0 := ROUND(Specificities[1].mailing_unit_number_specificity - 0);
  integer2 mailing_unit_number_switch_shift0 := ROUND(1000*Specificities[1].mailing_unit_number_switch - 0);
  integer1 mailing_city_state_zip_shift0 := ROUND(Specificities[1].mailing_city_state_zip_specificity - 0);
  integer2 mailing_city_state_zip_switch_shift0 := ROUND(1000*Specificities[1].mailing_city_state_zip_switch - 0);
  integer1 property_full_street_address_shift0 := ROUND(Specificities[1].property_full_street_address_specificity - 0);
  integer2 property_full_street_address_switch_shift0 := ROUND(1000*Specificities[1].property_full_street_address_switch - 0);
  integer1 property_unit_number_shift0 := ROUND(Specificities[1].property_unit_number_specificity - 0);
  integer2 property_unit_number_switch_shift0 := ROUND(1000*Specificities[1].property_unit_number_switch - 0);
  integer1 property_city_state_zip_shift0 := ROUND(Specificities[1].property_city_state_zip_specificity - 0);
  integer2 property_city_state_zip_switch_shift0 := ROUND(1000*Specificities[1].property_city_state_zip_switch - 0);
  integer1 property_country_code_shift0 := ROUND(Specificities[1].property_country_code_specificity - 0);
  integer2 property_country_code_switch_shift0 := ROUND(1000*Specificities[1].property_country_code_switch - 0);
  integer1 property_address_code_shift0 := ROUND(Specificities[1].property_address_code_specificity - 0);
  integer2 property_address_code_switch_shift0 := ROUND(1000*Specificities[1].property_address_code_switch - 0);
  integer1 legal_lot_code_shift0 := ROUND(Specificities[1].legal_lot_code_specificity - 0);
  integer2 legal_lot_code_switch_shift0 := ROUND(1000*Specificities[1].legal_lot_code_switch - 0);
  integer1 legal_lot_number_shift0 := ROUND(Specificities[1].legal_lot_number_specificity - 0);
  integer2 legal_lot_number_switch_shift0 := ROUND(1000*Specificities[1].legal_lot_number_switch - 0);
  integer1 legal_land_lot_shift0 := ROUND(Specificities[1].legal_land_lot_specificity - 0);
  integer2 legal_land_lot_switch_shift0 := ROUND(1000*Specificities[1].legal_land_lot_switch - 0);
  integer1 legal_block_shift0 := ROUND(Specificities[1].legal_block_specificity - 0);
  integer2 legal_block_switch_shift0 := ROUND(1000*Specificities[1].legal_block_switch - 0);
  integer1 legal_section_shift0 := ROUND(Specificities[1].legal_section_specificity - 0);
  integer2 legal_section_switch_shift0 := ROUND(1000*Specificities[1].legal_section_switch - 0);
  integer1 legal_district_shift0 := ROUND(Specificities[1].legal_district_specificity - 0);
  integer2 legal_district_switch_shift0 := ROUND(1000*Specificities[1].legal_district_switch - 0);
  integer1 legal_unit_shift0 := ROUND(Specificities[1].legal_unit_specificity - 0);
  integer2 legal_unit_switch_shift0 := ROUND(1000*Specificities[1].legal_unit_switch - 0);
  integer1 legal_city_municipality_township_shift0 := ROUND(Specificities[1].legal_city_municipality_township_specificity - 0);
  integer2 legal_city_municipality_township_switch_shift0 := ROUND(1000*Specificities[1].legal_city_municipality_township_switch - 0);
  integer1 legal_subdivision_name_shift0 := ROUND(Specificities[1].legal_subdivision_name_specificity - 0);
  integer2 legal_subdivision_name_switch_shift0 := ROUND(1000*Specificities[1].legal_subdivision_name_switch - 0);
  integer1 legal_phase_number_shift0 := ROUND(Specificities[1].legal_phase_number_specificity - 0);
  integer2 legal_phase_number_switch_shift0 := ROUND(1000*Specificities[1].legal_phase_number_switch - 0);
  integer1 legal_tract_number_shift0 := ROUND(Specificities[1].legal_tract_number_specificity - 0);
  integer2 legal_tract_number_switch_shift0 := ROUND(1000*Specificities[1].legal_tract_number_switch - 0);
  integer1 legal_sec_twn_rng_mer_shift0 := ROUND(Specificities[1].legal_sec_twn_rng_mer_specificity - 0);
  integer2 legal_sec_twn_rng_mer_switch_shift0 := ROUND(1000*Specificities[1].legal_sec_twn_rng_mer_switch - 0);
  integer1 legal_brief_description_shift0 := ROUND(Specificities[1].legal_brief_description_specificity - 0);
  integer2 legal_brief_description_switch_shift0 := ROUND(1000*Specificities[1].legal_brief_description_switch - 0);
  integer1 legal_assessor_map_ref_shift0 := ROUND(Specificities[1].legal_assessor_map_ref_specificity - 0);
  integer2 legal_assessor_map_ref_switch_shift0 := ROUND(1000*Specificities[1].legal_assessor_map_ref_switch - 0);
  integer1 census_tract_shift0 := ROUND(Specificities[1].census_tract_specificity - 0);
  integer2 census_tract_switch_shift0 := ROUND(1000*Specificities[1].census_tract_switch - 0);
  integer1 record_type_code_shift0 := ROUND(Specificities[1].record_type_code_specificity - 0);
  integer2 record_type_code_switch_shift0 := ROUND(1000*Specificities[1].record_type_code_switch - 0);
  integer1 ownership_type_code_shift0 := ROUND(Specificities[1].ownership_type_code_specificity - 0);
  integer2 ownership_type_code_switch_shift0 := ROUND(1000*Specificities[1].ownership_type_code_switch - 0);
  integer1 new_record_type_code_shift0 := ROUND(Specificities[1].new_record_type_code_specificity - 0);
  integer2 new_record_type_code_switch_shift0 := ROUND(1000*Specificities[1].new_record_type_code_switch - 0);
  integer1 state_land_use_code_shift0 := ROUND(Specificities[1].state_land_use_code_specificity - 0);
  integer2 state_land_use_code_switch_shift0 := ROUND(1000*Specificities[1].state_land_use_code_switch - 0);
  integer1 county_land_use_code_shift0 := ROUND(Specificities[1].county_land_use_code_specificity - 0);
  integer2 county_land_use_code_switch_shift0 := ROUND(1000*Specificities[1].county_land_use_code_switch - 0);
  integer1 county_land_use_description_shift0 := ROUND(Specificities[1].county_land_use_description_specificity - 0);
  integer2 county_land_use_description_switch_shift0 := ROUND(1000*Specificities[1].county_land_use_description_switch - 0);
  integer1 standardized_land_use_code_shift0 := ROUND(Specificities[1].standardized_land_use_code_specificity - 0);
  integer2 standardized_land_use_code_switch_shift0 := ROUND(1000*Specificities[1].standardized_land_use_code_switch - 0);
  integer1 timeshare_code_shift0 := ROUND(Specificities[1].timeshare_code_specificity - 0);
  integer2 timeshare_code_switch_shift0 := ROUND(1000*Specificities[1].timeshare_code_switch - 0);
  integer1 zoning_shift0 := ROUND(Specificities[1].zoning_specificity - 0);
  integer2 zoning_switch_shift0 := ROUND(1000*Specificities[1].zoning_switch - 0);
  integer1 owner_occupied_shift0 := ROUND(Specificities[1].owner_occupied_specificity - 0);
  integer2 owner_occupied_switch_shift0 := ROUND(1000*Specificities[1].owner_occupied_switch - 0);
  integer1 recorder_document_number_shift0 := ROUND(Specificities[1].recorder_document_number_specificity - 0);
  integer2 recorder_document_number_switch_shift0 := ROUND(1000*Specificities[1].recorder_document_number_switch - 0);
  integer1 recorder_book_number_shift0 := ROUND(Specificities[1].recorder_book_number_specificity - 0);
  integer2 recorder_book_number_switch_shift0 := ROUND(1000*Specificities[1].recorder_book_number_switch - 0);
  integer1 recorder_page_number_shift0 := ROUND(Specificities[1].recorder_page_number_specificity - 0);
  integer2 recorder_page_number_switch_shift0 := ROUND(1000*Specificities[1].recorder_page_number_switch - 0);
  integer1 transfer_date_shift0 := ROUND(Specificities[1].transfer_date_specificity - 0);
  integer2 transfer_date_switch_shift0 := ROUND(1000*Specificities[1].transfer_date_switch - 0);
  integer1 recording_date_shift0 := ROUND(Specificities[1].recording_date_specificity - 0);
  integer2 recording_date_switch_shift0 := ROUND(1000*Specificities[1].recording_date_switch - 0);
  integer1 sale_date_shift0 := ROUND(Specificities[1].sale_date_specificity - 0);
  integer2 sale_date_switch_shift0 := ROUND(1000*Specificities[1].sale_date_switch - 0);
  integer1 document_type_shift0 := ROUND(Specificities[1].document_type_specificity - 0);
  integer2 document_type_switch_shift0 := ROUND(1000*Specificities[1].document_type_switch - 0);
  integer1 sales_price_shift0 := ROUND(Specificities[1].sales_price_specificity - 0);
  integer2 sales_price_switch_shift0 := ROUND(1000*Specificities[1].sales_price_switch - 0);
  integer1 sales_price_code_shift0 := ROUND(Specificities[1].sales_price_code_specificity - 0);
  integer2 sales_price_code_switch_shift0 := ROUND(1000*Specificities[1].sales_price_code_switch - 0);
  integer1 mortgage_loan_amount_shift0 := ROUND(Specificities[1].mortgage_loan_amount_specificity - 0);
  integer2 mortgage_loan_amount_switch_shift0 := ROUND(1000*Specificities[1].mortgage_loan_amount_switch - 0);
  integer1 mortgage_loan_type_code_shift0 := ROUND(Specificities[1].mortgage_loan_type_code_specificity - 0);
  integer2 mortgage_loan_type_code_switch_shift0 := ROUND(1000*Specificities[1].mortgage_loan_type_code_switch - 0);
  integer1 mortgage_lender_name_shift0 := ROUND(Specificities[1].mortgage_lender_name_specificity - 0);
  integer2 mortgage_lender_name_switch_shift0 := ROUND(1000*Specificities[1].mortgage_lender_name_switch - 0);
  integer1 mortgage_lender_type_code_shift0 := ROUND(Specificities[1].mortgage_lender_type_code_specificity - 0);
  integer2 mortgage_lender_type_code_switch_shift0 := ROUND(1000*Specificities[1].mortgage_lender_type_code_switch - 0);
  integer1 prior_transfer_date_shift0 := ROUND(Specificities[1].prior_transfer_date_specificity - 0);
  integer2 prior_transfer_date_switch_shift0 := ROUND(1000*Specificities[1].prior_transfer_date_switch - 0);
  integer1 prior_recording_date_shift0 := ROUND(Specificities[1].prior_recording_date_specificity - 0);
  integer2 prior_recording_date_switch_shift0 := ROUND(1000*Specificities[1].prior_recording_date_switch - 0);
  integer1 prior_sales_price_shift0 := ROUND(Specificities[1].prior_sales_price_specificity - 0);
  integer2 prior_sales_price_switch_shift0 := ROUND(1000*Specificities[1].prior_sales_price_switch - 0);
  integer1 prior_sales_price_code_shift0 := ROUND(Specificities[1].prior_sales_price_code_specificity - 0);
  integer2 prior_sales_price_code_switch_shift0 := ROUND(1000*Specificities[1].prior_sales_price_code_switch - 0);
  integer1 assessed_land_value_shift0 := ROUND(Specificities[1].assessed_land_value_specificity - 0);
  integer2 assessed_land_value_switch_shift0 := ROUND(1000*Specificities[1].assessed_land_value_switch - 0);
  integer1 assessed_improvement_value_shift0 := ROUND(Specificities[1].assessed_improvement_value_specificity - 0);
  integer2 assessed_improvement_value_switch_shift0 := ROUND(1000*Specificities[1].assessed_improvement_value_switch - 0);
  integer1 assessed_total_value_shift0 := ROUND(Specificities[1].assessed_total_value_specificity - 0);
  integer2 assessed_total_value_switch_shift0 := ROUND(1000*Specificities[1].assessed_total_value_switch - 0);
  integer1 assessed_value_year_shift0 := ROUND(Specificities[1].assessed_value_year_specificity - 0);
  integer2 assessed_value_year_switch_shift0 := ROUND(1000*Specificities[1].assessed_value_year_switch - 0);
  integer1 market_land_value_shift0 := ROUND(Specificities[1].market_land_value_specificity - 0);
  integer2 market_land_value_switch_shift0 := ROUND(1000*Specificities[1].market_land_value_switch - 0);
  integer1 market_improvement_value_shift0 := ROUND(Specificities[1].market_improvement_value_specificity - 0);
  integer2 market_improvement_value_switch_shift0 := ROUND(1000*Specificities[1].market_improvement_value_switch - 0);
  integer1 market_total_value_shift0 := ROUND(Specificities[1].market_total_value_specificity - 0);
  integer2 market_total_value_switch_shift0 := ROUND(1000*Specificities[1].market_total_value_switch - 0);
  integer1 market_value_year_shift0 := ROUND(Specificities[1].market_value_year_specificity - 0);
  integer2 market_value_year_switch_shift0 := ROUND(1000*Specificities[1].market_value_year_switch - 0);
  integer1 homestead_homeowner_exemption_shift0 := ROUND(Specificities[1].homestead_homeowner_exemption_specificity - 0);
  integer2 homestead_homeowner_exemption_switch_shift0 := ROUND(1000*Specificities[1].homestead_homeowner_exemption_switch - 0);
  integer1 tax_exemption1_code_shift0 := ROUND(Specificities[1].tax_exemption1_code_specificity - 0);
  integer2 tax_exemption1_code_switch_shift0 := ROUND(1000*Specificities[1].tax_exemption1_code_switch - 0);
  integer1 tax_exemption2_code_shift0 := ROUND(Specificities[1].tax_exemption2_code_specificity - 0);
  integer2 tax_exemption2_code_switch_shift0 := ROUND(1000*Specificities[1].tax_exemption2_code_switch - 0);
  integer1 tax_exemption3_code_shift0 := ROUND(Specificities[1].tax_exemption3_code_specificity - 0);
  integer2 tax_exemption3_code_switch_shift0 := ROUND(1000*Specificities[1].tax_exemption3_code_switch - 0);
  integer1 tax_exemption4_code_shift0 := ROUND(Specificities[1].tax_exemption4_code_specificity - 0);
  integer2 tax_exemption4_code_switch_shift0 := ROUND(1000*Specificities[1].tax_exemption4_code_switch - 0);
  integer1 tax_rate_code_area_shift0 := ROUND(Specificities[1].tax_rate_code_area_specificity - 0);
  integer2 tax_rate_code_area_switch_shift0 := ROUND(1000*Specificities[1].tax_rate_code_area_switch - 0);
  integer1 tax_amount_shift0 := ROUND(Specificities[1].tax_amount_specificity - 0);
  integer2 tax_amount_switch_shift0 := ROUND(1000*Specificities[1].tax_amount_switch - 0);
  integer1 tax_year_shift0 := ROUND(Specificities[1].tax_year_specificity - 0);
  integer2 tax_year_switch_shift0 := ROUND(1000*Specificities[1].tax_year_switch - 0);
  integer1 tax_delinquent_year_shift0 := ROUND(Specificities[1].tax_delinquent_year_specificity - 0);
  integer2 tax_delinquent_year_switch_shift0 := ROUND(1000*Specificities[1].tax_delinquent_year_switch - 0);
  integer1 school_tax_district1_shift0 := ROUND(Specificities[1].school_tax_district1_specificity - 0);
  integer2 school_tax_district1_switch_shift0 := ROUND(1000*Specificities[1].school_tax_district1_switch - 0);
  END;
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
// Service functions for specificity profiling
  SALT30.MAC_Specificity_Values(ln_fares_id_values_persisted,ln_fares_id,'ln_fares_id',ln_fares_id_specificity,ln_fares_id_specificity_profile);
  SALT30.MAC_Specificity_Values(process_date_values_persisted,process_date,'process_date',process_date_specificity,process_date_specificity_profile);
  SALT30.MAC_Specificity_Values(vendor_source_flag_values_persisted,vendor_source_flag,'vendor_source_flag',vendor_source_flag_specificity,vendor_source_flag_specificity_profile);
  SALT30.MAC_Specificity_Values(current_record_values_persisted,current_record,'current_record',current_record_specificity,current_record_specificity_profile);
  SALT30.MAC_Specificity_Values(fips_code_values_persisted,fips_code,'fips_code',fips_code_specificity,fips_code_specificity_profile);
  SALT30.MAC_Specificity_Values(state_code_values_persisted,state_code,'state_code',state_code_specificity,state_code_specificity_profile);
  SALT30.MAC_Specificity_Values(county_name_values_persisted,county_name,'county_name',county_name_specificity,county_name_specificity_profile);
  SALT30.MAC_Specificity_Values(old_apn_values_persisted,old_apn,'old_apn',old_apn_specificity,old_apn_specificity_profile);
  SALT30.MAC_Specificity_Values(apna_or_pin_number_values_persisted,apna_or_pin_number,'apna_or_pin_number',apna_or_pin_number_specificity,apna_or_pin_number_specificity_profile);
  SALT30.MAC_Specificity_Values(fares_unformatted_apn_values_persisted,fares_unformatted_apn,'fares_unformatted_apn',fares_unformatted_apn_specificity,fares_unformatted_apn_specificity_profile);
  SALT30.MAC_Specificity_Values(duplicate_apn_multiple_address_id_values_persisted,duplicate_apn_multiple_address_id,'duplicate_apn_multiple_address_id',duplicate_apn_multiple_address_id_specificity,duplicate_apn_multiple_address_id_specificity_profile);
  SALT30.MAC_Specificity_Values(assessee_name_values_persisted,assessee_name,'assessee_name',assessee_name_specificity,assessee_name_specificity_profile);
  SALT30.MAC_Specificity_Values(second_assessee_name_values_persisted,second_assessee_name,'second_assessee_name',second_assessee_name_specificity,second_assessee_name_specificity_profile);
  SALT30.MAC_Specificity_Values(assessee_ownership_rights_code_values_persisted,assessee_ownership_rights_code,'assessee_ownership_rights_code',assessee_ownership_rights_code_specificity,assessee_ownership_rights_code_specificity_profile);
  SALT30.MAC_Specificity_Values(assessee_relationship_code_values_persisted,assessee_relationship_code,'assessee_relationship_code',assessee_relationship_code_specificity,assessee_relationship_code_specificity_profile);
  SALT30.MAC_Specificity_Values(assessee_phone_number_values_persisted,assessee_phone_number,'assessee_phone_number',assessee_phone_number_specificity,assessee_phone_number_specificity_profile);
  SALT30.MAC_Specificity_Values(tax_account_number_values_persisted,tax_account_number,'tax_account_number',tax_account_number_specificity,tax_account_number_specificity_profile);
  SALT30.MAC_Specificity_Values(contract_owner_values_persisted,contract_owner,'contract_owner',contract_owner_specificity,contract_owner_specificity_profile);
  SALT30.MAC_Specificity_Values(assessee_name_type_code_values_persisted,assessee_name_type_code,'assessee_name_type_code',assessee_name_type_code_specificity,assessee_name_type_code_specificity_profile);
  SALT30.MAC_Specificity_Values(second_assessee_name_type_code_values_persisted,second_assessee_name_type_code,'second_assessee_name_type_code',second_assessee_name_type_code_specificity,second_assessee_name_type_code_specificity_profile);
  SALT30.MAC_Specificity_Values(mail_care_of_name_type_code_values_persisted,mail_care_of_name_type_code,'mail_care_of_name_type_code',mail_care_of_name_type_code_specificity,mail_care_of_name_type_code_specificity_profile);
  SALT30.MAC_Specificity_Values(mailing_care_of_name_values_persisted,mailing_care_of_name,'mailing_care_of_name',mailing_care_of_name_specificity,mailing_care_of_name_specificity_profile);
  SALT30.MAC_Specificity_Values(mailing_full_street_address_values_persisted,mailing_full_street_address,'mailing_full_street_address',mailing_full_street_address_specificity,mailing_full_street_address_specificity_profile);
  SALT30.MAC_Specificity_Values(mailing_unit_number_values_persisted,mailing_unit_number,'mailing_unit_number',mailing_unit_number_specificity,mailing_unit_number_specificity_profile);
  SALT30.MAC_Specificity_Values(mailing_city_state_zip_values_persisted,mailing_city_state_zip,'mailing_city_state_zip',mailing_city_state_zip_specificity,mailing_city_state_zip_specificity_profile);
  SALT30.MAC_Specificity_Values(property_full_street_address_values_persisted,property_full_street_address,'property_full_street_address',property_full_street_address_specificity,property_full_street_address_specificity_profile);
  SALT30.MAC_Specificity_Values(property_unit_number_values_persisted,property_unit_number,'property_unit_number',property_unit_number_specificity,property_unit_number_specificity_profile);
  SALT30.MAC_Specificity_Values(property_city_state_zip_values_persisted,property_city_state_zip,'property_city_state_zip',property_city_state_zip_specificity,property_city_state_zip_specificity_profile);
  SALT30.MAC_Specificity_Values(property_country_code_values_persisted,property_country_code,'property_country_code',property_country_code_specificity,property_country_code_specificity_profile);
  SALT30.MAC_Specificity_Values(property_address_code_values_persisted,property_address_code,'property_address_code',property_address_code_specificity,property_address_code_specificity_profile);
  SALT30.MAC_Specificity_Values(legal_lot_code_values_persisted,legal_lot_code,'legal_lot_code',legal_lot_code_specificity,legal_lot_code_specificity_profile);
  SALT30.MAC_Specificity_Values(legal_lot_number_values_persisted,legal_lot_number,'legal_lot_number',legal_lot_number_specificity,legal_lot_number_specificity_profile);
  SALT30.MAC_Specificity_Values(legal_land_lot_values_persisted,legal_land_lot,'legal_land_lot',legal_land_lot_specificity,legal_land_lot_specificity_profile);
  SALT30.MAC_Specificity_Values(legal_block_values_persisted,legal_block,'legal_block',legal_block_specificity,legal_block_specificity_profile);
  SALT30.MAC_Specificity_Values(legal_section_values_persisted,legal_section,'legal_section',legal_section_specificity,legal_section_specificity_profile);
  SALT30.MAC_Specificity_Values(legal_district_values_persisted,legal_district,'legal_district',legal_district_specificity,legal_district_specificity_profile);
  SALT30.MAC_Specificity_Values(legal_unit_values_persisted,legal_unit,'legal_unit',legal_unit_specificity,legal_unit_specificity_profile);
  SALT30.MAC_Specificity_Values(legal_city_municipality_township_values_persisted,legal_city_municipality_township,'legal_city_municipality_township',legal_city_municipality_township_specificity,legal_city_municipality_township_specificity_profile);
  SALT30.MAC_Specificity_Values(legal_subdivision_name_values_persisted,legal_subdivision_name,'legal_subdivision_name',legal_subdivision_name_specificity,legal_subdivision_name_specificity_profile);
  SALT30.MAC_Specificity_Values(legal_phase_number_values_persisted,legal_phase_number,'legal_phase_number',legal_phase_number_specificity,legal_phase_number_specificity_profile);
  SALT30.MAC_Specificity_Values(legal_tract_number_values_persisted,legal_tract_number,'legal_tract_number',legal_tract_number_specificity,legal_tract_number_specificity_profile);
  SALT30.MAC_Specificity_Values(legal_sec_twn_rng_mer_values_persisted,legal_sec_twn_rng_mer,'legal_sec_twn_rng_mer',legal_sec_twn_rng_mer_specificity,legal_sec_twn_rng_mer_specificity_profile);
  SALT30.MAC_Specificity_Values(legal_brief_description_values_persisted,legal_brief_description,'legal_brief_description',legal_brief_description_specificity,legal_brief_description_specificity_profile);
  SALT30.MAC_Specificity_Values(legal_assessor_map_ref_values_persisted,legal_assessor_map_ref,'legal_assessor_map_ref',legal_assessor_map_ref_specificity,legal_assessor_map_ref_specificity_profile);
  SALT30.MAC_Specificity_Values(census_tract_values_persisted,census_tract,'census_tract',census_tract_specificity,census_tract_specificity_profile);
  SALT30.MAC_Specificity_Values(record_type_code_values_persisted,record_type_code,'record_type_code',record_type_code_specificity,record_type_code_specificity_profile);
  SALT30.MAC_Specificity_Values(ownership_type_code_values_persisted,ownership_type_code,'ownership_type_code',ownership_type_code_specificity,ownership_type_code_specificity_profile);
  SALT30.MAC_Specificity_Values(new_record_type_code_values_persisted,new_record_type_code,'new_record_type_code',new_record_type_code_specificity,new_record_type_code_specificity_profile);
  SALT30.MAC_Specificity_Values(state_land_use_code_values_persisted,state_land_use_code,'state_land_use_code',state_land_use_code_specificity,state_land_use_code_specificity_profile);
  SALT30.MAC_Specificity_Values(county_land_use_code_values_persisted,county_land_use_code,'county_land_use_code',county_land_use_code_specificity,county_land_use_code_specificity_profile);
  SALT30.MAC_Specificity_Values(county_land_use_description_values_persisted,county_land_use_description,'county_land_use_description',county_land_use_description_specificity,county_land_use_description_specificity_profile);
  SALT30.MAC_Specificity_Values(standardized_land_use_code_values_persisted,standardized_land_use_code,'standardized_land_use_code',standardized_land_use_code_specificity,standardized_land_use_code_specificity_profile);
  SALT30.MAC_Specificity_Values(timeshare_code_values_persisted,timeshare_code,'timeshare_code',timeshare_code_specificity,timeshare_code_specificity_profile);
  SALT30.MAC_Specificity_Values(zoning_values_persisted,zoning,'zoning',zoning_specificity,zoning_specificity_profile);
  SALT30.MAC_Specificity_Values(owner_occupied_values_persisted,owner_occupied,'owner_occupied',owner_occupied_specificity,owner_occupied_specificity_profile);
  SALT30.MAC_Specificity_Values(recorder_document_number_values_persisted,recorder_document_number,'recorder_document_number',recorder_document_number_specificity,recorder_document_number_specificity_profile);
  SALT30.MAC_Specificity_Values(recorder_book_number_values_persisted,recorder_book_number,'recorder_book_number',recorder_book_number_specificity,recorder_book_number_specificity_profile);
  SALT30.MAC_Specificity_Values(recorder_page_number_values_persisted,recorder_page_number,'recorder_page_number',recorder_page_number_specificity,recorder_page_number_specificity_profile);
  SALT30.MAC_Specificity_Values(transfer_date_values_persisted,transfer_date,'transfer_date',transfer_date_specificity,transfer_date_specificity_profile);
  SALT30.MAC_Specificity_Values(recording_date_values_persisted,recording_date,'recording_date',recording_date_specificity,recording_date_specificity_profile);
  SALT30.MAC_Specificity_Values(sale_date_values_persisted,sale_date,'sale_date',sale_date_specificity,sale_date_specificity_profile);
  SALT30.MAC_Specificity_Values(document_type_values_persisted,document_type,'document_type',document_type_specificity,document_type_specificity_profile);
  SALT30.MAC_Specificity_Values(sales_price_values_persisted,sales_price,'sales_price',sales_price_specificity,sales_price_specificity_profile);
  SALT30.MAC_Specificity_Values(sales_price_code_values_persisted,sales_price_code,'sales_price_code',sales_price_code_specificity,sales_price_code_specificity_profile);
  SALT30.MAC_Specificity_Values(mortgage_loan_amount_values_persisted,mortgage_loan_amount,'mortgage_loan_amount',mortgage_loan_amount_specificity,mortgage_loan_amount_specificity_profile);
  SALT30.MAC_Specificity_Values(mortgage_loan_type_code_values_persisted,mortgage_loan_type_code,'mortgage_loan_type_code',mortgage_loan_type_code_specificity,mortgage_loan_type_code_specificity_profile);
  SALT30.MAC_Specificity_Values(mortgage_lender_name_values_persisted,mortgage_lender_name,'mortgage_lender_name',mortgage_lender_name_specificity,mortgage_lender_name_specificity_profile);
  SALT30.MAC_Specificity_Values(mortgage_lender_type_code_values_persisted,mortgage_lender_type_code,'mortgage_lender_type_code',mortgage_lender_type_code_specificity,mortgage_lender_type_code_specificity_profile);
  SALT30.MAC_Specificity_Values(prior_transfer_date_values_persisted,prior_transfer_date,'prior_transfer_date',prior_transfer_date_specificity,prior_transfer_date_specificity_profile);
  SALT30.MAC_Specificity_Values(prior_recording_date_values_persisted,prior_recording_date,'prior_recording_date',prior_recording_date_specificity,prior_recording_date_specificity_profile);
  SALT30.MAC_Specificity_Values(prior_sales_price_values_persisted,prior_sales_price,'prior_sales_price',prior_sales_price_specificity,prior_sales_price_specificity_profile);
  SALT30.MAC_Specificity_Values(prior_sales_price_code_values_persisted,prior_sales_price_code,'prior_sales_price_code',prior_sales_price_code_specificity,prior_sales_price_code_specificity_profile);
  SALT30.MAC_Specificity_Values(assessed_land_value_values_persisted,assessed_land_value,'assessed_land_value',assessed_land_value_specificity,assessed_land_value_specificity_profile);
  SALT30.MAC_Specificity_Values(assessed_improvement_value_values_persisted,assessed_improvement_value,'assessed_improvement_value',assessed_improvement_value_specificity,assessed_improvement_value_specificity_profile);
  SALT30.MAC_Specificity_Values(assessed_total_value_values_persisted,assessed_total_value,'assessed_total_value',assessed_total_value_specificity,assessed_total_value_specificity_profile);
  SALT30.MAC_Specificity_Values(assessed_value_year_values_persisted,assessed_value_year,'assessed_value_year',assessed_value_year_specificity,assessed_value_year_specificity_profile);
  SALT30.MAC_Specificity_Values(market_land_value_values_persisted,market_land_value,'market_land_value',market_land_value_specificity,market_land_value_specificity_profile);
  SALT30.MAC_Specificity_Values(market_improvement_value_values_persisted,market_improvement_value,'market_improvement_value',market_improvement_value_specificity,market_improvement_value_specificity_profile);
  SALT30.MAC_Specificity_Values(market_total_value_values_persisted,market_total_value,'market_total_value',market_total_value_specificity,market_total_value_specificity_profile);
  SALT30.MAC_Specificity_Values(market_value_year_values_persisted,market_value_year,'market_value_year',market_value_year_specificity,market_value_year_specificity_profile);
  SALT30.MAC_Specificity_Values(homestead_homeowner_exemption_values_persisted,homestead_homeowner_exemption,'homestead_homeowner_exemption',homestead_homeowner_exemption_specificity,homestead_homeowner_exemption_specificity_profile);
  SALT30.MAC_Specificity_Values(tax_exemption1_code_values_persisted,tax_exemption1_code,'tax_exemption1_code',tax_exemption1_code_specificity,tax_exemption1_code_specificity_profile);
  SALT30.MAC_Specificity_Values(tax_exemption2_code_values_persisted,tax_exemption2_code,'tax_exemption2_code',tax_exemption2_code_specificity,tax_exemption2_code_specificity_profile);
  SALT30.MAC_Specificity_Values(tax_exemption3_code_values_persisted,tax_exemption3_code,'tax_exemption3_code',tax_exemption3_code_specificity,tax_exemption3_code_specificity_profile);
  SALT30.MAC_Specificity_Values(tax_exemption4_code_values_persisted,tax_exemption4_code,'tax_exemption4_code',tax_exemption4_code_specificity,tax_exemption4_code_specificity_profile);
  SALT30.MAC_Specificity_Values(tax_rate_code_area_values_persisted,tax_rate_code_area,'tax_rate_code_area',tax_rate_code_area_specificity,tax_rate_code_area_specificity_profile);
  SALT30.MAC_Specificity_Values(tax_amount_values_persisted,tax_amount,'tax_amount',tax_amount_specificity,tax_amount_specificity_profile);
  SALT30.MAC_Specificity_Values(tax_year_values_persisted,tax_year,'tax_year',tax_year_specificity,tax_year_specificity_profile);
  SALT30.MAC_Specificity_Values(tax_delinquent_year_values_persisted,tax_delinquent_year,'tax_delinquent_year',tax_delinquent_year_specificity,tax_delinquent_year_specificity_profile);
  SALT30.MAC_Specificity_Values(school_tax_district1_values_persisted,school_tax_district1,'school_tax_district1',school_tax_district1_specificity,school_tax_district1_specificity_profile);
EXPORT AllProfiles := ln_fares_id_specificity_profile + process_date_specificity_profile + vendor_source_flag_specificity_profile + current_record_specificity_profile + fips_code_specificity_profile + state_code_specificity_profile + county_name_specificity_profile + old_apn_specificity_profile + apna_or_pin_number_specificity_profile + fares_unformatted_apn_specificity_profile + duplicate_apn_multiple_address_id_specificity_profile + assessee_name_specificity_profile + second_assessee_name_specificity_profile + assessee_ownership_rights_code_specificity_profile + assessee_relationship_code_specificity_profile + assessee_phone_number_specificity_profile + tax_account_number_specificity_profile + contract_owner_specificity_profile + assessee_name_type_code_specificity_profile + second_assessee_name_type_code_specificity_profile + mail_care_of_name_type_code_specificity_profile + mailing_care_of_name_specificity_profile + mailing_full_street_address_specificity_profile + mailing_unit_number_specificity_profile + mailing_city_state_zip_specificity_profile + property_full_street_address_specificity_profile + property_unit_number_specificity_profile + property_city_state_zip_specificity_profile + property_country_code_specificity_profile + property_address_code_specificity_profile + legal_lot_code_specificity_profile + legal_lot_number_specificity_profile + legal_land_lot_specificity_profile + legal_block_specificity_profile + legal_section_specificity_profile + legal_district_specificity_profile + legal_unit_specificity_profile + legal_city_municipality_township_specificity_profile + legal_subdivision_name_specificity_profile + legal_phase_number_specificity_profile + legal_tract_number_specificity_profile + legal_sec_twn_rng_mer_specificity_profile + legal_brief_description_specificity_profile + legal_assessor_map_ref_specificity_profile + census_tract_specificity_profile + record_type_code_specificity_profile + ownership_type_code_specificity_profile + new_record_type_code_specificity_profile + state_land_use_code_specificity_profile + county_land_use_code_specificity_profile + county_land_use_description_specificity_profile + standardized_land_use_code_specificity_profile + timeshare_code_specificity_profile + zoning_specificity_profile + owner_occupied_specificity_profile + recorder_document_number_specificity_profile + recorder_book_number_specificity_profile + recorder_page_number_specificity_profile + transfer_date_specificity_profile + recording_date_specificity_profile + sale_date_specificity_profile + document_type_specificity_profile + sales_price_specificity_profile + sales_price_code_specificity_profile + mortgage_loan_amount_specificity_profile + mortgage_loan_type_code_specificity_profile + mortgage_lender_name_specificity_profile + mortgage_lender_type_code_specificity_profile + prior_transfer_date_specificity_profile + prior_recording_date_specificity_profile + prior_sales_price_specificity_profile + prior_sales_price_code_specificity_profile + assessed_land_value_specificity_profile + assessed_improvement_value_specificity_profile + assessed_total_value_specificity_profile + assessed_value_year_specificity_profile + market_land_value_specificity_profile + market_improvement_value_specificity_profile + market_total_value_specificity_profile + market_value_year_specificity_profile + homestead_homeowner_exemption_specificity_profile + tax_exemption1_code_specificity_profile + tax_exemption2_code_specificity_profile + tax_exemption3_code_specificity_profile + tax_exemption4_code_specificity_profile + tax_rate_code_area_specificity_profile + tax_amount_specificity_profile + tax_year_specificity_profile + tax_delinquent_year_specificity_profile + school_tax_district1_specificity_profile;
END;
