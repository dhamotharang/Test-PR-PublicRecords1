import doxie,ut,data_services;

in_sh := watercraft.File_Base_Search_Dev;
in_mn := watercraft.File_Base_Main_Dev;
in_cg := watercraft.File_Base_Coastguard_Dev;

in_sh_dst := distribute(in_sh, hash(state_origin,watercraft_key,sequence_key));
in_sh_srt := sort(in_sh_dst,state_origin,watercraft_key,sequence_key,local);
in_sh_dep := dedup(in_sh_srt,state_origin,watercraft_key,sequence_key,local);

hullnum_rec := record
	string30  hull_number;
	string2  state_origin;
	string30  watercraft_key;
	string30  sequence_key;
end;

hullnum_rec slim_main(in_mn l) := transform
     self.hull_number := Stringlib.StringCleanSpaces(l.hull_number);
	self := l;
end;

mn_slim := project(in_mn, slim_main(left));

hullnum_rec slim_coastguard(in_cg l) := transform
     self.hull_number := Stringlib.StringCleanSpaces(l.hull_number);
	self := l;
end;

cg_slim := project(in_cg, slim_coastguard(left));

hullnum_slim := mn_slim + cg_slim;

hullnum_slim_dst := distribute(hullnum_slim(hull_number<>''), hash(hull_number));
hullnum_slim_srt := sort(hullnum_slim_dst, record, local);
hullnum_slim_dep := dedup(hullnum_slim_srt, record, local);

hullnum_slim_dst2 := distribute(hullnum_slim_dep, hash(state_origin,watercraft_key,sequence_key));

hullnum_rec check_search(hullnum_slim_dst2 l) := transform
	self := l;
end;

hullnum_slim_vld := join(hullnum_slim_dst2, in_sh_dep,
                         left.state_origin=right.state_origin and
					left.watercraft_key=right.watercraft_key and
	                    left.sequence_key=right.sequence_key, 
					check_search(left),local);

export key_watercraft_hullnum := index(hullnum_slim_vld,
            {hull_number},{state_origin,watercraft_key,sequence_key},
            data_services.data_location.prefix('watercraft')+'thor_data400::key::watercraft_hullnum_'+doxie.Version_SuperKey);