import vehiclev2,data_services;
EXPORT Infutor_Vin_In_VehicleV2 := VehicleV2.Files.In.Infutor_Vin.PreppedBldg;
// EXPORT Infutor_Vin_In_VehicleV2 := dataset(data_services.foreign_prod + 'thor_data400::in::vehiclev2::inf_nondppa::vin_20161010',VehicleV2.Layout_Infutor_Vin.Prepped,thor);