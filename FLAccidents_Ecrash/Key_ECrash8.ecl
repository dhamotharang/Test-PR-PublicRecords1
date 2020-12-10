Import Data_Services, doxie;

export key_Ecrash8 := index(mod_PrepEcrashFLAccidentPRKeys.flc8_ptotal
                            ,{string40 l_acc_nbr := accident_nbr}
							              ,{mod_PrepEcrashFLAccidentPRKeys.flc8_ptotal}
							              ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrash8_' + doxie.Version_SuperKey);