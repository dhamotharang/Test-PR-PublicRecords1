Import Data_Services;

d := DATASET([],SexOffender.layout_LatLong);

export Key_latlong := INDEX(d, {d}, Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::sexoffender::autokey::latlong_qa');