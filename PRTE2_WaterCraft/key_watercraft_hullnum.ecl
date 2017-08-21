IMPORT doxie,ut,data_services;

in_sh 							:= _Datasets.Search;
in_mn 							:= _Datasets.Main;
in_cg 							:= _Datasets.Coastguard;

in_sh_dst 					:= DISTRIBUTE(in_sh, HASH(state_origin,watercraft_key,sequence_key));
in_sh_srt 					:= SORT(in_sh_dst,state_origin,watercraft_key,sequence_key,LOCAL);
in_sh_dep 					:= DEDUP(in_sh_srt,state_origin,watercraft_key,sequence_key,LOCAL);

hullnum_rec := RECORD
	STRING30  hull_number;
	STRING2  	state_origin;
	STRING30  watercraft_key;
	STRING30  sequence_key;
END;

hullnum_rec slim_main(in_mn l) := TRANSFORM
	SELF.hull_number	:= Stringlib.StringCleanSpaces(l.hull_number);
	SELF 							:= l;
END;

mn_slim 						:= PROJECT(in_mn, slim_main(LEFT));

hullnum_rec slim_coastguard(in_cg l) := TRANSFORM
	SELF.hull_number	:= Stringlib.StringCleanSpaces(l.hull_number);
	SELF 							:= l;
END;

cg_slim 						:= PROJECT(in_cg, slim_coastguard(LEFT));

hullnum_slim 				:= mn_slim + cg_slim;

hullnum_slim_dst 		:= DISTRIBUTE(hullnum_slim(hull_number<>''), HASH(hull_number));
hullnum_slim_srt 		:= SORT(hullnum_slim_dst, record, LOCAL);
hullnum_slim_dep 		:= DEDUP(hullnum_slim_srt, record, LOCAL);

hullnum_slim_dst2 	:= DISTRIBUTE(hullnum_slim_dep, HASH(state_origin,watercraft_key,sequence_key));

hullnum_rec check_search(hullnum_slim_dst2 l) := TRANSFORM
	SELF 							:= l;
END;
	
hullnum_slim_vld 		:= JOIN(hullnum_slim_dst2, in_sh_dep,
														LEFT.state_origin			= RIGHT.state_origin AND
														LEFT.watercraft_key		= RIGHT.watercraft_key AND
														LEFT.sequence_key			= RIGHT.sequence_key, 
														check_search(LEFT),LOCAL);

EXPORT key_watercraft_hullnum(STRING IdxFile) := INDEX(hullnum_slim_vld,
																												{hull_number},
																												{state_origin,watercraft_key,sequence_key},
																												IdxFile);