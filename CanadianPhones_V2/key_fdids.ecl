IMPORT Data_Services, doxie;

EXPORT key_fdids := index(file_cwp_with_fdid,{fdid},{file_cwp_with_fdid},
                          Data_Services.Data_location.Prefix('CP_Ver2')+'thor_data400::key::canadianwp_v2::fdids_' + doxie.Version_SuperKey);
													
													
