import VehicleV2, VehLic, Doxie, ut;

get_recs	:= VehicleV2.file_VehicleV2_Party;

//slim_party := table(get_recs(Append_DL_number != '' or Orig_DL_number != ''), {orig_DL_number, Append_DL_number, Vehicle_Key, Iteration_Key, Sequence_Key, state_origin});

slim_rec := record

string20 DL_number;
string30 Vehicle_Key;
string15 Iteration_Key;
string15 Sequence_Key;
string2  state_origin;
boolean is_minor;
end;

slim_rec tnormalize(get_recs L, integer cnt) := transform

self.DL_number := choose(cnt, L.orig_DL_number, L.Append_DL_number);
	age := ut.getage(l.orig_dob);
self.is_minor := if(age=0 or age>=18,FALSE,TRUE);
self := L;

end;

party_norm  := normalize(get_recs(Append_DL_number != '' or Orig_DL_number != ''), 2, tnormalize(left, counter));

party_dedup := dedup(party_norm(DL_number <> ''), all);

export Key_Vehicle_DL_number := index(party_dedup, {DL_number, state_origin,is_minor}, {Vehicle_Key,Iteration_Key,Sequence_Key},
'~thor_data400::key::VehicleV2::dl_number_'+ doxie.Version_SuperKey);

