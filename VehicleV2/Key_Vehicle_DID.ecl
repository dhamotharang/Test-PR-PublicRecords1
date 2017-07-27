import VehicleV2, VehLic, Doxie, ut;

get_recs	:= VehicleV2.file_VehicleV2_Party;

slim_party := table(get_recs(Append_DID != 0), {Append_DID, Vehicle_Key, Iteration_Key, Sequence_Key,orig_dob});

rec := record
	string30 Vehicle_Key;
	string15 Iteration_Key;
	string15 Sequence_Key;
	unsigned6	Append_DID;	
	boolean is_minor;
end;

rec get_minor(slim_party l):=transform
	age := ut.getage(l.orig_dob);
	self.is_minor := if(age=0 or age>=18,FALSE,TRUE);
	self := l;
end;

slim_dedup := dedup(project(slim_party,get_minor(left)), all);

export Key_Vehicle_DID := index(slim_dedup, {Append_DID, is_minor}, {Vehicle_Key,Iteration_Key,Sequence_Key},
'~thor_data400::key::VehicleV2::DID_'+ doxie.Version_SuperKey);
