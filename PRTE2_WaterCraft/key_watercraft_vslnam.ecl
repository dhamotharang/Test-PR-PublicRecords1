IMPORT doxie,ut,data_services;

in_sh 						:= _Datasets.Search;
in_mn 						:= _Datasets.Main;
in_cg 						:= _Datasets.Coastguard;

in_sh_dst 				:= DISTRIBUTE(in_sh, HASH(state_origin,watercraft_key,sequence_key));
in_sh_srt 				:= SORT(in_sh_dst,state_origin,watercraft_key,sequence_key,LOCAL);
in_sh_dep 				:= DEDUP(in_sh_srt,state_origin,watercraft_key,sequence_key,LOCAL);

vslnam_rec := RECORD
	STRING50 		vessel_name;
	STRING2 		state_origin;
	STRING30		watercraft_key;
	STRING30		sequence_key;
END;

vslnam_rec slim_main(in_mn l) := TRANSFORM
	SELF.vessel_name:= l.watercraft_name;
	SELF 						:= l;
end;

mn_slim 					:= PROJECT(in_mn, slim_main(left));

vslnam_rec slim_coastguard(in_cg l) := TRANSFORM
	SELF.vessel_name:= l.name_of_vessel;
	SELF 						:= l;
END;

cg_slim 					:= PROJECT(in_cg, slim_coastguard(left));

vslnam_slim 			:= mn_slim + cg_slim;

vslnam_slim_dst 	:= DISTRIBUTE(vslnam_slim(vessel_name<>''), HASH(vessel_name));
vslnam_slim_srt 	:= SORT(vslnam_slim_dst, record, LOCAL);
vslnam_slim_dep 	:= DEDUP(vslnam_slim_srt, record, LOCAL);

vslnam_slim_dst2 	:= DISTRIBUTE(vslnam_slim_dep, HASH(state_origin,watercraft_key,sequence_key));

vslnam_rec check_search(vslnam_slim_dst2 l) := TRANSFORM
	SELF 						:= l;
END;

vslnam_slim_vld 	:= JOIN(vslnam_slim_dst2, in_sh_dep,
                        LEFT.state_origin		=	RIGHT.state_origin AND
												LEFT.watercraft_key	=	RIGHT.watercraft_key AND
												LEFT.sequence_key		=	RIGHT.sequence_key, 
												check_search(LEFT),LOCAL);

EXPORT key_watercraft_vslnam(STRING IdxFile)  := INDEX(vslnam_slim_vld,
																												{vessel_name},
																												{state_origin,watercraft_key,sequence_key},
																												IdxFile);