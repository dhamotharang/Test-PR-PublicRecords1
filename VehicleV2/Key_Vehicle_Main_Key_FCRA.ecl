import VehicleV2, Doxie, data_services;

get_recs	:= VehicleV2.file_VehicleV2_main;

export Key_Vehicle_Main_Key_FCRA := index(get_recs, {Vehicle_Key, iteration_key}, {get_recs},
							data_services.data_location.prefix('Vehicle') + 'thor_data400::key::vehicleV2::fcra::main_Key_'+ doxie.Version_SuperKey);

