Import Data_Services, doxie;

export key_ecrashV2_dlnbr := index(mod_PrepEcrashPRKeys().dep_dlnbr_base
                                   ,{l_dlnbr := driver_license_nbr}
								                   ,{accident_nbr,orig_accnbr}
							                     ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2_dlnbr_' + doxie.Version_SuperKey);

