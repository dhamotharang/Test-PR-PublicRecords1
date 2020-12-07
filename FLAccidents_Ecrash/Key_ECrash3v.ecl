Import Data_Services, doxie;

export key_Ecrash3v := index(mod_PrepEcrashFLAccidentPRKeys.pflc3v
                            ,{string40 l_acc_nbr := accident_nbr}
							              ,{mod_PrepEcrashFLAccidentPRKeys.pflc3v}
							              ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrash3v_' + doxie.Version_SuperKey);