Import Data_Services, doxie, FLAccidents, STD;

export Key_ECrash0 := index(mod_PrepEcrashFLAccidentPRKeys.flc0_allrecs
                            ,{string40 l_acc_nbr :=accident_nbr}
							              ,{mod_PrepEcrashFLAccidentPRKeys.flc0_allrecs}
							              ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrash0_' + doxie.Version_SuperKey);
						 	 