import VehicleV2, Doxie, data_services;

get_recs	:= VehicleV2.file_VehicleV2_main;

//main_dist   := distribute(get_recs, hash(Vehicle_Key, iteration_key));

export Key_Vehicle_Main_Key := index(get_recs, {Vehicle_Key, iteration_key}, {get_recs},
data_services.data_location.prefix('Vehicle') + 'thor_data400::key::vehicleV2::main_Key_'+ doxie.Version_SuperKey);



