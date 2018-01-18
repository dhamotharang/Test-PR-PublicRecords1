import doxie, data_services;

f := InfoUSA.File_ABIUS_Company_Base(abi_number <> '');


export Key_ABIUS_Company_abi := index(f,
{abi_number},
{bdid,SUBSIDIARY_PARENT_NUM,ULTIMATE_PARENT_NUM},
data_services.data_location.prefix() + 'thor_data400::key::abius_company_abi_'+doxie.Version_SuperKey);
