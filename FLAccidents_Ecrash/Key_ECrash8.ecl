export key_Ecrash8 := index(mod_PrepEcrashFLAccidentPRKeys.flc8_ptotal
                            ,{l_acc_nbr}
							              ,{mod_PrepEcrashFLAccidentPRKeys.flc8_ptotal}
							              ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrash8_' + doxie.Version_SuperKey);