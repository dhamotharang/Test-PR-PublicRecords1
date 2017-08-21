//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','InsuranceHeader_Property_Transactions_DeedsMortgages.BWR_PopulationStatistics - Population Statistics - SALT V3.4.1');
IMPORT InsuranceHeader_Property_Transactions_DeedsMortgages,SALT34;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  InsuranceHeader_Property_Transactions_DeedsMortgages.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* recording_date_field */,/* SourceType_field */,/* did_field */,/* apnt_or_pin_number_field */,/* recorder_book_number_field */,/* primname_field */,/* zip_field */,/* sales_price_field */,/* first_td_loan_amount_field */,/* primrange_field */,/* secrange_field */,/* contract_date_field */,/* document_number_field */,/* recorder_page_number_field */,/* prim_range_alpha_field */,/* sec_range_alpha_field */,/* name_field */,/* prim_name_num_field */,/* prim_name_alpha_field */,/* sec_range_num_field */,/* fips_code_field */,/* county_name_field */,/* lender_name_field */,/* prim_range_num_field */,/* city_field */,/* st_field */,/* ln_fares_id_field */,/* prim_range_field */,/* prim_name_field */,/* sec_range_field */,/* document_type_code_field */,/* locale_field */,/* address_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
