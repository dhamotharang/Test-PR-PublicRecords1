import watercraft, data_services;

base_file := watercraft.file_base_main_prod;
       
export key_prep_watercraft_wid := 
      index(base_file,
      {state_origin,watercraft_key,sequence_key},
      {base_file},
      data_services.data_location.prefix() + 'thor_data400::key::watercraft_wid'+thorlib.wuid());