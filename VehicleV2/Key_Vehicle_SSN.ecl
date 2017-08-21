import VehicleV2, VehLic, Doxie, ut;

get_recs	:= VehicleV2.file_VehicleV2_Party_Clean_Sequence_Key;

//slim_party := table(get_recs(orig_SSN <> '' or Append_SSN != ''), {orig_SSN, Append_SSN, Vehicle_Key, Iteration_Key, Sequence_Key});

slim_rec := record

string9 SSN;
string30 Vehicle_Key;
string15 Iteration_Key;
string15  Sequence_Key;

end;

slim_rec tnormalize(get_recs L, integer cnt) := transform

self.ssn := choose(cnt, L.orig_SSN, L.append_SSN);
self := L;

end;

party_norm  := normalize(get_recs(orig_SSN <> '' or Append_SSN != ''), 2, tnormalize(left, counter));

slim_dedup := dedup(party_norm(ssn <> ''), all);

export Key_Vehicle_SSN := index(slim_dedup, {SSN}, {Vehicle_Key,Iteration_Key,Sequence_Key},'~thor_data400::key::VehicleV2::SSN_'+ doxie.Version_SuperKey);
