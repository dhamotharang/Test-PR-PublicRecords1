import Data_Services, doxie, ut;

file := fn_phone_scoring_attributes(File_Master(current_record_flag = 'Y'));

EXPORT Key_GongScoringAttributes := index(file,
              {phone10, fsn},
						    {file},
								/*Data_Services.Data_location.Prefix('Gong') + */'~thor_data400::key::gong_scoring_' + doxie.Version_SuperKey);
								
								
	