import doxie,ut, data_services;

in_sh := watercraft.File_Base_Search_Dev;
in_cg := watercraft.File_Base_Coastguard_Dev;

in_sh_dst := distribute(in_sh, hash(state_origin,watercraft_key,sequence_key));
in_sh_srt := sort(in_sh_dst,state_origin,watercraft_key,sequence_key,local);
in_sh_dep := dedup(in_sh_srt,state_origin,watercraft_key,sequence_key,local);

cg_slim_rec := record
	in_cg.official_number;
	in_cg.state_origin;
	in_cg.watercraft_key;
	in_cg.sequence_key;
end;

cg_slim := table(in_cg, cg_slim_rec);

cg_slim_dst := distribute(cg_slim(official_number<>''), hash(official_number));
cg_slim_srt := sort(cg_slim_dst,record,local);
cg_slim_dep := dedup(cg_slim_srt,record,local);

cg_slim_dst2 := distribute(cg_slim_dep, hash(state_origin,watercraft_key,sequence_key));

cg_slim_rec check_search(cg_slim_dst2 l) := transform
	self := l;
end;

cg_slim_vld := join(cg_slim_dst2, in_sh_dep,
                    left.state_origin=right.state_origin and
				left.watercraft_key=right.watercraft_key and
	               left.sequence_key=right.sequence_key, 
				check_search(left),local);

export key_watercraft_offnum := 
       index(cg_slim_vld,
             {official_number},
             {state_origin,watercraft_key,sequence_key},
             data_services.data_location.prefix() + 'thor_data400::key::watercraft_offnum_'+doxie.Version_SuperKey);