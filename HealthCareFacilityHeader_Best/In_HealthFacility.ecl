IMPORT HealthCareProvider;
// EXPORT In_HealthFacility := DATASET ('~thor::facility::header::input',HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header,THOR);
EXPORT In_HealthFacility := HealthCareProvider.Files.Person_Salt_Output_DS; // ('~temp::lnpid::healthcarefacilityheader::it36',HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header,THOR);

