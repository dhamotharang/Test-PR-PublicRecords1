EXPORT Key_EcrashV2_Vin := INDEX(mod_PrepEcrashPRKeys().VinBase,
                                 {l_Vin},
							                   {mod_PrepEcrashPRKeys().VINBase},
							                   Files_PR.FILE_KEY_VIN_SF);
