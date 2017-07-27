


fein_base := dnb.File_DNB_FEIN_In;
FEIN_replace := dataset('~thor_data400::in::dnb_fein_20050406_clean_replacement', dnb.Layout_DNB_FEIN_In, flat);

layout_dnb_base_counts := record
Total_Records := count(group);
Total_TAX_ID_NUMBER := count(group, fein_base.TAX_ID_NUMBER = '');
Total_SOURCE_DUNS_NUMBER := count(group, fein_base.SOURCE_DUNS_NUMBER = '');
Total_BUSINESS_NAME := count(group, fein_base.BUSINESS_NAME = '');
Total_ADDRESS := count(group, fein_base.ADDRESS = '');
Total_CITY := count(group, fein_base.CITY = '');
Total_STATE := count(group, fein_base.STATE = '');
Total_ZIP_CODE := count(group, fein_base.ZIP_CODE = '');
Total_REFERENCE_NAME_OR_SOURCE := count(group, fein_base.REFERENCE_NAME_OR_SOURCE = '');
Total_DATE_OF_INPUT_DATA := count(group, fein_base.DATE_OF_INPUT_DATA = '');
Total_CASE_DUNS_NUMBER := count(group, fein_base.CASE_DUNS_NUMBER = '');
Total_DB_PARENT_DUNS_NUMBER := count(group, fein_base.DB_PARENT_DUNS_NUMBER = '');
Total_DB_HEADQUARTERS_DUNS_NUMBER := count(group, fein_base.DB_HEADQUARTERS_DUNS_NUMBER = '');
Total_DB_TELEPHONE_NUMBER := count(group, fein_base.DB_TELEPHONE_NUMBER = '');
Total_DB_CHIEF_EXECUTIVE_TITLE := count(group, fein_base.DB_CHIEF_EXECUTIVE_TITLE = '');
Total_DB_COMPANY_NAME := count(group, fein_base.DB_COMPANY_NAME = '');
Total_DB_TRADESTYLE := count(group, fein_base.DB_TRADESTYLE = '');
Total_DB_SIC_CODE := count(group, fein_base.DB_SIC_CODE = '');
end;

layout_dnb_new_counts := record
Total_Records := count(group);
Total_TAX_ID_NUMBER := count(group, fein_replace.TAX_ID_NUMBER = '');
Total_SOURCE_DUNS_NUMBER := count(group, fein_replace.SOURCE_DUNS_NUMBER = '');
Total_BUSINESS_NAME := count(group, fein_replace.BUSINESS_NAME = '');
Total_ADDRESS := count(group, fein_replace.ADDRESS = '');
Total_CITY := count(group, fein_replace.CITY = '');
Total_STATE := count(group, fein_replace.STATE = '');
Total_ZIP_CODE := count(group, fein_replace.ZIP_CODE = '');
Total_REFERENCE_NAME_OR_SOURCE := count(group, fein_replace.REFERENCE_NAME_OR_SOURCE = '');
Total_DATE_OF_INPUT_DATA := count(group, fein_replace.DATE_OF_INPUT_DATA = '');
Total_CASE_DUNS_NUMBER := count(group, fein_replace.CASE_DUNS_NUMBER = '');
Total_DB_PARENT_DUNS_NUMBER := count(group, fein_replace.DB_PARENT_DUNS_NUMBER = '');
Total_DB_HEADQUARTERS_DUNS_NUMBER := count(group, fein_replace.DB_HEADQUARTERS_DUNS_NUMBER = '');
Total_DB_TELEPHONE_NUMBER := count(group, fein_replace.DB_TELEPHONE_NUMBER = '');
Total_DB_CHIEF_EXECUTIVE_TITLE := count(group, fein_replace.DB_CHIEF_EXECUTIVE_TITLE = '');
Total_DB_COMPANY_NAME := count(group, fein_replace.DB_COMPANY_NAME = '');
Total_DB_TRADESTYLE := count(group, fein_replace.DB_TRADESTYLE = '');
Total_DB_SIC_CODE := count(group, fein_replace.DB_SIC_CODE = '');
end;


dnb_base_counts := table(fein_base, layout_dnb_base_counts);
dnb_replace_counts := table(FEIN_replace, layout_dnb_new_counts);


//output(dnb_base_counts) : success(output('dnb base counts'));
output(dnb_replace_counts) : success(output('dnb replace counts'));