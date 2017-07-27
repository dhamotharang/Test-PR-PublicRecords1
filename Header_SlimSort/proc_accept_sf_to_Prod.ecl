import ut;

ut.mac_SF_Move('~thor_data400::base::hss_name_address','P',do1)
ut.mac_sf_move('~thor_data400::base::hss_name_ssn','P',do2)
ut.mac_sf_move('~thor_data400::base::hss_name_phone','P',do3)
ut.mac_sf_move('~thor_Data400::base::hss_name_dayob','P',do4)
ut.mac_sf_move('~thor_Data400::base::hss_name_zip_age_ssn4','P',do5)
ut.mac_sf_move('~thor_data400::base::hss_household','P',do6)
ut.mac_sf_move('~thor_data400::base::did_ssn_glb','P',do7)
ut.mac_sf_move('~thor_data400::base::did_ssn_nonglb','P',do8)
ut.mac_sf_move('~thor_data400::base::did_ssn_nonglb_nonutil','P',do9)
ut.mac_sf_move('~thor_data400::base::did_ssn_nonutil','P',do10)

export proc_accept_sf_to_Prod := parallel(do1,do2,do3,do4,
								  do5,do6,do7,do8,
								  do9,do10);
								  