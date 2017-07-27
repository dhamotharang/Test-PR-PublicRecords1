import watercraft;

base_file := watercraft.File_Base_Search_Prod;
       
export key_prep_watercraft_sid := 
       index(base_file,
	       {state_origin,watercraft_key, sequence_key},
		  {base_file},
            '~thor_data400::key::watercraft_sid'+thorlib.wuid());