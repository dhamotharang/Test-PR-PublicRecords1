﻿Import Data_Services, doxie;

export key_Ecrash7 := index(mod_PrepEcrashFLAccidentPRKeys.flc7_ptotal
                            ,{string40 l_acc_nbr := accident_nbr}
							              ,{mod_PrepEcrashFLAccidentPRKeys.flc7_ptotal}
							              ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrash7_' + doxie.Version_SuperKey);