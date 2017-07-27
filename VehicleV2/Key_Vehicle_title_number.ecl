import VehicleV2, VehLic, Doxie, ut;

get_recs	:= VehicleV2.file_VehicleV2_Party;

slim_party := table(get_recs(ttl_number != ''), {ttl_number, Vehicle_Key, Iteration_Key, Sequence_Key, state_origin});

export Key_Vehicle_title_number := index(slim_party, {ttl_number, state_origin}, {Vehicle_Key,Iteration_Key,Sequence_Key},
'~thor_data400::key::VehicleV2::title_number_'+ doxie.Version_SuperKey);



