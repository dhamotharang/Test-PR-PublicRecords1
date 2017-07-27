import VehicleV2, VehLic, Doxie, ut;

get_recs	:= VehicleV2.file_VehicleV2_Party_Clean_Sequence_Key_bid;

slim_party := table(get_recs(Append_BDID != 0), {Append_BDID, Vehicle_Key, Iteration_Key, Sequence_Key});

slim_dedup := dedup(slim_party, all);

export Key_Vehicle_BID := index(slim_dedup, {Append_BDID}, {Vehicle_Key,Iteration_Key,Sequence_Key},
       '~thor_data400::key::VehicleV2::BID_'+ doxie.Version_SuperKey);

