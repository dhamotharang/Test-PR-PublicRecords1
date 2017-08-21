import infutor,doxie,ut;

d := Infutor.File_Infutor_DID(did > 0);

export key_infutor_did := INDEX(d, {did},{boca_id}, 
              '~thor_data400::key::infutor::' + doxie.Version_SuperKey + '::tracker.did');


