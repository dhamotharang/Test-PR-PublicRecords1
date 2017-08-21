import ut;

ds1 := Targus.File_consumer_base;
    
ut.mac_suppress_by_phonetype(ds1,phone_number,state,recs_out,true,did);

export File_targus_key_building := recs_out : PERSIST('~thor_data400::persist::targus_consumer_keybuild');