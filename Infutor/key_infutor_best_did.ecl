import Data_Services, infutor,doxie,ut;

file_best := PROJECT(Infutor.file_infutor_best(did > 0), infutor.layout_best.lbest - name_suffix);

export Key_infutor_best_DID := 
       index(file_best,{did},{file_best},
ut.Data_Location.Person_header + 'thor_data400::key::infutor::best.did_' + doxie.Version_SuperKey);
