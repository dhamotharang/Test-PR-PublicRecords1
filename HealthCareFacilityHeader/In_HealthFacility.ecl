IMPORT HealthCareFacility;
// EXPORT In_HealthFacility := DATASET ('~thor::facility::header::input',HealthCareFacility.Layout_HealthProvider.HealthCareProvider_Header,THOR);
// EXPORT In_HealthFacility := DATASET ('~temp::lnpid::healthcarefacilityheader::it37',HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header,THOR);
// EXPORT In_HealthFacility := HealthCareFacility.Files.facility_Salt_Output_DS; //  ('~thor::facility::header::input',HealthCareFacility.Layout_HealthProvider.HealthCareProvider_Header,THOR);
EXPORT In_HealthFacility := HealthCareFacility.Files.facility_Salt_Input_DS; //  ('~thor::facility::header::input',HealthCareFacility.Layout_HealthProvider.HealthCareProvider_Header,THOR);
