import watercraft,header;

wc_uid := watercraft.Create_Watercraft_file('20070406b');

// UID key build

uid_rec := RECORD
  string30 watercraft_key;
  string30 sequence_key;
  string2 state_origin;
  unsigned integer6 uid;
 END;


uid_table := dataset([],uid_rec);

export key_boolean_uid := index(uid_table,{uid},{watercraft_key,sequence_key,state_origin},'~thor_data400::key::watercraft::qa::uid_map');



