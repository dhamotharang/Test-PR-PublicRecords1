Import Data_Services, doxie,FLAccidents, STD;
													
export Key_ECrash4 := index(mod_PrepEcrashFLAccidentPRKeys.flc4_allrecs
                            ,{string40 l_acc_nbr := accident_nbr}
							              ,{mod_PrepEcrashFLAccidentPRKeys.flc4_allrecs}
							              ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrash4_' + doxie.Version_SuperKey);							