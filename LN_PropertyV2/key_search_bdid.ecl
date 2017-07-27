Import Data_Services, LN_Property, doxie,ut;

df := LN_PropertyV2.file_search_building((integer)bdid != 0);

export Key_Search_BDID := 
index(df,
{unsigned6 s_bid := (integer)bdid},
{df},
Data_Services.Data_location.Prefix('Property')+'thor_data400::key::ln_propertyv2::' + doxie.Version_SuperKey + '::search.bdid');

