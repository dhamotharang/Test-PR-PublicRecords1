Import Data_Services, doxie, FLAccidents, lib_stringlib, STD;

export key_Ecrash6 := index(mod_PrepEcrashFLAccidentPRKeys.flc6_ptotal
                            ,{string40 l_acc_nbr := accident_nbr}
							              ,{mod_PrepEcrashFLAccidentPRKeys.flc6_ptotal}
							              ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrash6_' + doxie.Version_SuperKey);