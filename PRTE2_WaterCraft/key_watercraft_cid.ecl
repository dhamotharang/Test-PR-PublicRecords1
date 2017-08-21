IMPORT doxie, ut, fcra,data_services;

EXPORT key_watercraft_cid (STRING IdxFile, BOOLEAN IsFCRA = FALSE) := FUNCTION

  // fcra-restricted states:
  states 					:= fcra.compliance.watercrafts.restricted_states;

  base_file 			:= _Datasets.CoastGuard(~IsFCRA OR state_origin NOT IN states);
       
  RETURN INDEX (base_file, 
								{state_origin,watercraft_key,sequence_key}, 
								{base_file},
                IdxFile);
END;  
