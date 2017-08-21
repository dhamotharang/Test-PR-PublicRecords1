import infutor,doxie,ut;

d := Infutor.File_Infutor_keybuild;

export key_infutor_id := INDEX(d,{boca_id},{d}, 
              '~thor_data400::key::infutor::' + doxie.Version_SuperKey + '::tracker.id');


