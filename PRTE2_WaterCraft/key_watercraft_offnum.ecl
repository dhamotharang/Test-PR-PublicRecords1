IMPORT doxie,ut,data_services;

in_sh 							:= _Datasets.Search;
in_cg 							:= _Datasets.CoastGuard;

in_sh_dst 					:= DISTRIBUTE(in_sh, HASH(state_origin,watercraft_key,sequence_key));
in_sh_srt 					:= SORT(in_sh_dst,state_origin,watercraft_key,sequence_key,LOCAL);
in_sh_dep 					:= DEDUP(in_sh_srt,state_origin,watercraft_key,sequence_key,LOCAL);

cg_slim_rec 				:= RECORD
	in_cg.official_number;
	in_cg.state_origin;
	in_cg.watercraft_key;
	in_cg.sequence_key;
END;

cg_slim 						:= TABLE(in_cg, cg_slim_rec);

cg_slim_dst 				:= DISTRIBUTE(cg_slim(official_number<>''), HASH(official_number));
cg_slim_srt 				:= SORT(cg_slim_dst,record,LOCAL);
cg_slim_dep 				:= DEDUP(cg_slim_srt,record,LOCAL);

cg_slim_dst2 				:= DISTRIBUTE(cg_slim_dep, HASH(state_origin,watercraft_key,sequence_key));

cg_slim_rec check_search(cg_slim_dst2 l) := TRANSFORM
	SELF 							:= l;
END;

cg_slim_vld 				:= JOIN(cg_slim_dst2, in_sh_dep,
														LEFT.state_origin		= RIGHT.state_origin AND		
														LEFT.watercraft_key	=	RIGHT.watercraft_key AND
														LEFT.sequence_key		=	RIGHT.sequence_key, 
														check_search(LEFT),LOCAL);

EXPORT key_watercraft_offnum(STRING IdxFile) := INDEX(cg_slim_vld,
																												{official_number},
																												{state_origin,watercraft_key,sequence_key},
																												IdxFile);