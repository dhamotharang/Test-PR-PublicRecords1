import Data_Services, Doxie, Infutor;

file_best := Infutor.File_Infutor_Best_Keybuilding;

export Key_infutor_best_DID := 
       index(file_best,{did},{file_best},
					Data_Services.Data_Location.Person_header + 'thor_data400::key::infutor::best.did_' + doxie.Version_SuperKey);
