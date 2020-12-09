Import Data_Services, doxie;

export key_Ecrash2v := index(mod_PrepEcrashFLAccidentPRKeys.flc2v_allrecs
                             ,{string40 l_acc_nbr := accident_nbr}
							               ,{mod_PrepEcrashFLAccidentPRKeys.flc2v_allrecs}
							               ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrash2v_' + doxie.Version_SuperKey);
							