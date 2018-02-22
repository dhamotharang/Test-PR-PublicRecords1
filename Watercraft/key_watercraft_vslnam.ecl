import doxie,ut, data_services;

in_sh := watercraft.File_Base_Search_Dev;
in_mn := watercraft.File_Base_Main_Dev;
in_cg := watercraft.File_Base_Coastguard_Dev;

in_sh_dst := distribute(in_sh, hash(state_origin,watercraft_key,sequence_key));
in_sh_srt := sort(in_sh_dst,state_origin,watercraft_key,sequence_key,local);
in_sh_dep := dedup(in_sh_srt,state_origin,watercraft_key,sequence_key,local);

vslnam_rec := record
	string50 vessel_name;
	string2 state_origin;
	string30	watercraft_key;
	string30	sequence_key;
end;

vslnam_rec slim_main(in_mn l) := transform
	self.vessel_name := l.watercraft_name;
	self := l;
end;

mn_slim := project(in_mn, slim_main(left));

vslnam_rec slim_coastguard(in_cg l) := transform
	self.vessel_name := l.name_of_vessel;
	self := l;
end;

cg_slim := project(in_cg, slim_coastguard(left));

vslnam_slim := mn_slim + cg_slim;

vslnam_slim_dst := distribute(vslnam_slim(vessel_name<>''), hash(vessel_name));
vslnam_slim_srt := sort(vslnam_slim_dst, record, local);
vslnam_slim_dep := dedup(vslnam_slim_srt, record, local);

vslnam_slim_dst2 := distribute(vslnam_slim_dep, hash(state_origin,watercraft_key,sequence_key));

vslnam_rec check_search(vslnam_slim_dst2 l) := transform
	self := l;
end;

vslnam_slim_vld := join(vslnam_slim_dst2, in_sh_dep,
                        left.state_origin=right.state_origin and
			         left.watercraft_key=right.watercraft_key and
	                   left.sequence_key=right.sequence_key, 
				    check_search(left),local);

export key_watercraft_vslnam := index(vslnam_slim_vld,
                                      {vessel_name},
                                      {state_origin,watercraft_key,sequence_key},
                                      data_services.data_location.prefix() + 'thor_data400::key::watercraft_vslnam_'+doxie.Version_SuperKey);