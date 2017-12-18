import VehicleV2, data_services;

get_recs	:= VehicleV2.file_VehicleV2_Party;

//party_dist   := distribute(get_recs, hash(Vehicle_Key, iteration_key, sequence_key));

export Key_Vehicle_Party_Key1 := index(get_recs, {Vehicle_Key, iteration_key, sequence_key}, {get_recs},
data_services.data_location.prefix('Vehicle') + 'thor_data400::key::vehicleV2::party_Key_father');

