import doxie,Data_Services;

df := property.File_Fares_Search_DID((integer)bdid != 0);

export Key_Search_BDID := index(df,{unsigned6 bd := (integer)bdid},{df},Data_Services.Data_location.Prefix()+'thor_data400::key::property_bdid_' + doxie.Version_SuperKey);
