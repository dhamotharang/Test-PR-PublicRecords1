Import Data_Services, doxie, PRTE2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
c := PRTE2_Business_Header.File_Prep_Business_Contacts_Plus;
#ELSE
c := Business_Header.File_Prep_Business_Contacts_Plus;
#END;

d := business_header.format_CompanyTitle(c);

export Key_Company_Title := index(d,
{company_title},
{decode_company_title},
'~thor_data400::key::company_title_' + doxie.Version_SuperKey);