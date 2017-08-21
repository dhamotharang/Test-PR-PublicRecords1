IMPORT HealthCareProvider;
// export In_HealthProvider := DATASET ('~thor::healthcare::provider::header::data',HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header,THOR);
// export In_HealthProvider := HealthCareProvider.Files.Provider_Header_DS;  //DATASET ('~temp::hcid::healthcareproviderheader::it32',HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header,THOR);
// export In_HealthProvider := DATASET ('~thor::temp',HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header,THOR);
export In_HealthProvider := HealthCareProvider.Files.Person_Salt_Output_DS; //DATASET ('~ thor::base::healthcareprovider::person::salt::output::w20140127-044459',HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header,THOR);
