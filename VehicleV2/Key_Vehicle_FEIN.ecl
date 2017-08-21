import VehicleV2, VehLic, Doxie, ut;

get_recs	:= VehicleV2.file_VehicleV2_Party_Clean_Sequence_Key;

//slim_party := table(get_recs(Append_FEIN != ''), {orig_FEIN, Append_FEIN, Vehicle_Key, Iteration_Key, Sequence_Key});

slim_rec := record

string9 FEIN;
string30 Vehicle_Key;
string15 Iteration_Key;
string15  Sequence_Key;

end;

slim_rec tnormalize(get_recs L, integer cnt) := transform

self.FEIN := choose(cnt, L.orig_FEIN, L.append_FEIN);
self := L;

end;

party_norm  := normalize(get_recs(orig_FEIN <> '' or Append_FEIN != ''), 2, tnormalize(left, counter));
slim_dedup := dedup(party_norm(FEIN <> ''), all);

export Key_Vehicle_FEIN := index(slim_dedup, {FEIN}, {Vehicle_Key,Iteration_Key,Sequence_Key},
'~thor_data400::key::VehicleV2::FEIN_'+ doxie.Version_SuperKey);

