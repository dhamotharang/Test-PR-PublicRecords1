Import Data_Services, autokeyb2,doxie;

//filtering by [ln_fares_id[1] != 'R'] produces FCRA compliant data
fakepf := LN_PropertyV2.file_search_autokey(ln_fares_id[1] != 'R');

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,bdid,Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::ln_propertyv2::fcra::autokey::payload',plk,'');

export Key_Property_Payload_FCRA  := plk;

