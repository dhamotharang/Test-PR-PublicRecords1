import VehicleV2, Doxie, data_services;

get_recs	:= VehicleV2.file_VehicleV2_Party;

slim_party := table(get_recs(Append_DID != 0), {Append_DID, Vehicle_Key, Iteration_Key, Sequence_Key});

slim_dedup := dedup(slim_party, all);

export Key_Vehicle_DID_FCRA := index(slim_dedup, {Append_DID}, {Vehicle_Key,Iteration_Key,Sequence_Key},
		data_services.data_location.prefix('Vehicle') + 'thor_data400::key::VehicleV2::fcra::DID_'+ doxie.Version_SuperKey);