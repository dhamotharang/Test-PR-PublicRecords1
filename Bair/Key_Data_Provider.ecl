import data_services;

r := RECORD
  unsigned4 data_provider_id;
  string50 data_provider_ori;
  string200 data_provider_name;
  integer8 records_uploaded;
  integer8 records_approved;
  integer8 flagged_records;
  integer8 geocode_google;
  integer8 geocode_provider;
  string200 url;
  string20 phone_number;
  string50 contact_name;
  string25 last_upload;
  string25 first_date;
  string25 last_date;
  string200 custom_html;
  string1 uploadwarning;
  integer8 daysprovided;
  integer8 agencytypeid;
  real8 x_offset_min;
  real8 x_offset_max;
  real8 y_offset_min;
  real8 y_offset_max;
  string1 sheriff;
  string255 infowindowmessage;
  integer8 minzoomlevel;
  string1 offensemode;
  string1 cfsmode;
  string1 useinitialcfstype;
  integer8 max_sessions;
 END;

d:=dataset([],r);

EXPORT Key_Data_Provider(string v = 'qa', boolean isDelta = false) := 
													index(d,{data_provider_id},{d},data_services.Data_location.Prefix('BAIR')+
																						'thor_data400::key::bair::dataprovider::' + if(isDelta, 'delta::', '') + v + '::data_provider_id');
