Import Data_Services, doxie;

export key_Ecrash5 := index(mod_PrepEcrashFLAccidentPRKeys.flc5_ptotal
                            ,{string40 l_acc_nbr := accident_nbr}
							              ,{mod_PrepEcrashFLAccidentPRKeys.flc5_ptotal}
							              ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrash5_' + doxie.Version_SuperKey);