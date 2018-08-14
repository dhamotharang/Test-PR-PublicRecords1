import ut, header_slimsort;

cluster_66_name  := '~' + header_slimsort.cluster.cluster_66 + '::';
cluster_44_name  := '~' + header_slimsort.cluster.cluster_44 + '::';
cluster_36_name  := '~' + header_slimsort.cluster.cluster_36 + '::';

ut.mac_SF_Move(cluster_66_name + 'base::hss_name_address','P',do1)
ut.mac_sf_move(cluster_66_name + 'base::hss_name_ssn','P',do2)
ut.mac_sf_move(cluster_66_name + 'base::hss_name_phone','P',do3)
ut.mac_sf_move(cluster_66_name + 'base::hss_name_dayob','P',do4)
ut.mac_sf_move(cluster_66_name + 'base::hss_name_zip_age_ssn4','P',do5)
ut.mac_sf_move(cluster_66_name + 'base::hss_household','P',do6)
ut.mac_sf_move(cluster_66_name + 'base::hss_name_source','P',do11)

ut.mac_sf_move('~thor_data400::base::did_ssn_glb','P',do7)
ut.mac_sf_move('~thor_data400::base::did_ssn_nonglb','P',do8)
ut.mac_sf_move('~thor_data400::base::did_ssn_nonglb_nonutil','P',do9)
ut.mac_sf_move('~thor_data400::base::did_ssn_nonutil','P',do10)

ut.mac_SF_Move(cluster_44_name + 'base::hss_name_address','P',do1_44)
ut.mac_sf_move(cluster_44_name + 'base::hss_name_ssn','P',do2_44)
ut.mac_sf_move(cluster_44_name + 'base::hss_name_phone','P',do3_44)
ut.mac_sf_move(cluster_44_name + 'base::hss_name_dayob','P',do4_44)
ut.mac_sf_move(cluster_44_name + 'base::hss_name_zip_age_ssn4','P',do5_44)
ut.mac_sf_move(cluster_44_name + 'base::hss_household','P',do6_44)
ut.mac_sf_move(cluster_44_name + 'base::hss_name_source','P',do11_44)

ut.mac_SF_Move(cluster_36_name + 'base::hss_name_address','P',do1_36)
ut.mac_sf_move(cluster_36_name + 'base::hss_name_ssn','P',do2_36)
ut.mac_sf_move(cluster_36_name + 'base::hss_name_phone','P',do3_36)
ut.mac_sf_move(cluster_36_name + 'base::hss_name_dayob','P',do4_36)
ut.mac_sf_move(cluster_36_name + 'base::hss_name_zip_age_ssn4','P',do5_36)
ut.mac_sf_move(cluster_36_name + 'base::hss_household','P',do6_36)
ut.mac_sf_move(cluster_36_name + 'base::hss_name_source','P',do11_36)


export proc_accept_sf_to_Prod := parallel(
																				do1,do2,do3,do4,do5,do6, do7,do8,do9,do10, do11
																				,do1_44,do2_44,do3_44,do4_44,do5_44,do6_44,do11_44
																				,do1_36,do2_36,do3_36,do4_36,do5_36,do6_36,do11_36
																				);
