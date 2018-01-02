import doxie, data_services;

f := InfoUSA.File_ABIUS_Company_Base(bdid <> 0);

export Key_ABIUS_Company_BDID := index(f,{bdid},{f},data_services.data_location.prefix() + 'thor_data400::key::abius_company_bdid_'+doxie.Version_SuperKey);