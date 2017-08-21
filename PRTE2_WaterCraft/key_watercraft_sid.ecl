IMPORT doxie, ut, fcra,data_services;

EXPORT key_watercraft_sid (STRING IdxFile, BOOLEAN IsFCRA = FALSE) := FUNCTION

  base_file 				:= _Datasets.Search_Ph_Supressed_bdid;

  // fcra-restricted states:
  states 						:= fcra.compliance.watercrafts.restricted_states;

  base 							:= base_file (~IsFCRA OR state_origin NOT IN states);

  RETURN INDEX(base, 
							{state_origin, watercraft_key, sequence_key}, 
							{base_file}-{_Layouts.Exclusions},
              IdxFile);

end;