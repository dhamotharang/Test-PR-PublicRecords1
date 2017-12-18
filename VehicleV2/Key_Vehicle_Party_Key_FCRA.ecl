import VehicleV2, Doxie, data_services;

get_recs	:= VehicleV2.file_VehicleV2_Party_Clean_Sequence_Key;

export Key_Vehicle_Party_Key_FCRA := index(get_recs, {Vehicle_Key, iteration_key, sequence_key}, {get_recs},
						data_services.data_location.prefix('Vehicle') + 'thor_data400::key::vehicleV2::fcra::party_Key_'+ doxie.Version_SuperKey);