import doxie, data_services;

c:= business_header.File_Prep_Business_Contacts_Plus;

d := business_header.format_CompanyTitle(c);

export Key_Company_Title := index(d,
{company_title},
{decode_company_title},
data_services.data_location.prefix() + 'thor_data400::key::company_title_' + doxie.Version_SuperKey);