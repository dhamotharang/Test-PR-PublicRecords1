IMPORT doxie, ut, fcra,data_services;

EXPORT key_watercraft_did (STRING IdxFile, BOOLEAN isFCRA = FALSE) := FUNCTION

  base_file 					:= _Datasets.Search((UNSIGNED6)did<>0);

  base_slim 					:= TABLE (base_file, {did,state_origin,watercraft_key,sequence_key});

  // fcra-restricted states:
  states 							:= fcra.compliance.watercrafts.restricted_states;

  base_srt 						:= SORT(base_slim(~isFCRA OR state_origin NOT IN states),RECORD);
  base_dep 						:= DEDUP(base_srt, RECORD);

  RETURN INDEX(base_dep,
							{l_did := (UNSIGNED6) did}, 
							{state_origin, watercraft_key,sequence_key},
              IdxFile);
END;