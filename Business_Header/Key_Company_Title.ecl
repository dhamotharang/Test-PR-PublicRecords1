import doxie;

c := business_header.File_Business_Contacts;

d := business_header.format_CompanyTitle(c);

export Key_Company_Title := index(d,
{company_title},
{decode_company_title},
'~thor_data400::key::company_title_' + doxie.Version_SuperKey);