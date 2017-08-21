import Data_Services, doxie;

export Key_SurnameCount := INDEX(ds_surname_cnts,{name_last},{st,cnt},
								Data_Services.Data_location.Prefix('Gong_History') + 'thor_data400::key::gong_surnamecnt_' + doxie.Version_SuperKey);
