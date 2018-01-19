import Data_Services, doxie;
f_neustar_hist := File_Neustar_History;
export key_neustar_phone_history := index(f_neustar_hist
                                  ,{phone}
																	,{f_neustar_hist}
																	,Data_Services.Data_location.Prefix()+'thor_data400::key::neustar_phone_history_'+doxie.Version_SuperKey);