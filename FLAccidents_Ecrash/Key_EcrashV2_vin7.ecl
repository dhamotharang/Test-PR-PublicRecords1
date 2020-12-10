Import Data_Services, doxie;

export Key_EcrashV2_vin7 := index(mod_PrepEcrashPRKeys().ecrash_vin_base_7
							                    ,{l_vin7}
							                    ,{l_vin,accident_nbr,orig_accnbr}
							                    ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2_vin7_' + doxie.Version_SuperKey);