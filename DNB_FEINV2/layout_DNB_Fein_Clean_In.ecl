export layout_DNB_Fein_Clean_In := record
string8 process_date; 
string50 tmsid ; 
string9 TAX_ID_NUMBER;
string9 SOURCE_DUNS_NUMBER;
string50 orig_BUSINESS_NAME;
string50 clean_BUSINESS_NAME;
string30 ADDRESS;
string20 CITY;
string2 STATE;
string5 ZIP_CODE;
string50 REFERENCE_NAME_SOURCE;
string8 DATE_INPUT_DATA ;
string9 CASE_DUNS_NUMBER;
string2 CONFIDENCE_CODE;
string1 INDIRECT_DIRECT_SOURCE_IND;
string1 BEST_FEIN_Indicator;
string182  cleaned_address; 
end;