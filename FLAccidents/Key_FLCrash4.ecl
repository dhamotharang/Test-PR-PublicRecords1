Import Data_Services, doxie,ut;

flc4 := flc4_Keybuild;

export key_flcrash4 := index(flc4
                            ,{unsigned6 l_acc_nbr := (integer)accident_nbr}
							,{{flc4} - [ins_company_name,ins_policy_nbr]} 
							,Data_Services.Data_location.Prefix('FLAcc')+'thor_data400::key::flcrash4_'+doxie.Version_SuperKey);
