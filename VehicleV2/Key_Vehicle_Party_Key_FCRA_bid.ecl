import VehicleV2, Doxie, ut;

get_recs	:= VehicleV2.file_VehicleV2_Party_Clean_Sequence_Key_bid;

export Key_Vehicle_Party_Key_FCRA_bid := index(get_recs, {Vehicle_Key, iteration_key, sequence_key}, {get_recs},
						'~thor_data400::key::vehicleV2::fcra::party_Key_bid_'+ doxie.Version_SuperKey);