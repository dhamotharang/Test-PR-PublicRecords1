import watercraft;

base_file := watercraft.file_base_search_prod((unsigned6)did<>0);

export key_prep_watercraft_did := 
       index(base_file,
	       {l_did := (unsigned6)did},
		  {state_origin,watercraft_key},
            '~thor_data400::key::watercraft_did'+thorlib.wuid());