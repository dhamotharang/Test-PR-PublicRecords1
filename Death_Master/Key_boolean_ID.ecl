import data_services;


id_rec := RECORD

  unsigned integer2 src;
  unsigned integer6 doc;
  string16 state_death_id;
  unsigned integer8 __filepos;


 END;


id_table := dataset([],id_rec);

export key_boolean_id := index(id_table,
                               {src,doc,state_death_id,__filepos},
                               data_services.data_location.prefix() + 'thor_data400::key::death_master::qa::docref.state_death_id');


