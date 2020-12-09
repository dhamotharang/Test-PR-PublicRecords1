Import Data_Services, doxie;

export key_Ecrash1 := index(mod_PrepEcrashFLAccidentPRKeys.flc1_ptotal
                            ,{string40 l_acc_nbr := accident_nbr}
							              ,{mod_PrepEcrashFLAccidentPRKeys.flc1_ptotal}
							              ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrash1_' + doxie.Version_SuperKey);