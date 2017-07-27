import Gong_v2,Data_Services, doxie, ut;

file := Gong_Platinum.fn_phone_scoring_attributes(Gong_v2.File_GongMaster(current_record_flag = 'Y'));

EXPORT Key_GongScoringAttributes := index(file,
              {phone10, fsn},
						    {file},
								/*Data_Services.Data_location.Prefix('Gong') + */'~thor_data400::key::gong_scoring_' + doxie.Version_SuperKey);
								
								
	