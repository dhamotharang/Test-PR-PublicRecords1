import watercraft;

base_file := watercraft.File_Base_Coastguard_Prod;
       
export key_prep_watercraft_cid := 
       index(base_file,
	       {state_origin,watercraft_key,sequence_key},
		  {base_file},
            '~thor_data400::key::watercraft_cid'+thorlib.wuid());