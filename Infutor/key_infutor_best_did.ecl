import Data_Services, infutor,doxie, data_services;

file_best := Infutor.file_infutor_best(did > 0);

export Key_infutor_best_DID := 
       index(file_best,
             {did},
             {file_best},
             Data_Services.Data_location.person_header + 'thor_data400::key::infutor::best.did_' + doxie.Version_SuperKey);