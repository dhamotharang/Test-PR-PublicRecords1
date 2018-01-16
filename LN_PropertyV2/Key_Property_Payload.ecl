import autokeyb2,doxie,Data_Services;
fakepf := LN_PropertyV2.file_search_autokey;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,bdid,Data_Services.Data_location.Prefix('Property')+'thor_data400::key::ln_propertyv2::autokey::payload',plk,'');

export Key_Property_Payload  := plk;