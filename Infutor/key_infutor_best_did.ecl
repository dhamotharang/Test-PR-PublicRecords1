import Data_Services, infutor,doxie,ut;

file_best := Infutor.file_infutor_best(did > 0);

export Key_infutor_best_DID := 
       index(file_best,{did},{file_best},
ut.Data_Location.Person_header + 'thor_data400::key::infutor::best.did_' + doxie.Version_SuperKey);