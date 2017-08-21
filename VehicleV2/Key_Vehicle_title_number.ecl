import VehicleV2, VehLic, Doxie, ut;

get_recs	:= VehicleV2.file_VehicleV2_Party_Clean_Sequence_Key;

slim_rec := record

string20		Ttl_Number;
string2     state_origin;
string30    Vehicle_Key;
string15    Iteration_Key;
string15    Sequence_Key;

end;

slim_rec tnormalize(get_Recs L, integer cnt) := transform

self.state_origin := choose(cnt, L.state_origin, L.append_clean_address.st);
self := L;
end;

party_norm := normalize(get_recs, 2, tnormalize(left, counter));

party_dedup := dedup(party_norm(ttl_number <> '' and state_origin <> ''), all);

export Key_Vehicle_title_number := index(party_dedup, {ttl_number, state_origin}, {Vehicle_Key,Iteration_Key,Sequence_Key},
'~thor_data400::key::VehicleV2::title_number_'+ doxie.Version_SuperKey);



