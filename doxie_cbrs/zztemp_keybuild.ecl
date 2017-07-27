import ut, doxie_files, doxie_build;
/*
I ALSO HAD TO BUILD:
key::corp_base_corpkey
key::whois_bdid
*/

ut.MAC_SK_BuildProcess(doxie_cbrs.key_addr_bdid,'~thor_data400::key::cbrs.addr.bdid','~thor_data400::key::cbrs.addr.bdid',kab)
ut.MAC_SK_BuildProcess(doxie_cbrs.key_bdid_bankruptcy,'~thor_data400::key::cbrs.bdid.bankruptcy','~thor_data400::key::cbrs.bdid.bankruptcy',kbb)
ut.MAC_SK_BuildProcess(doxie_cbrs.key_addr_vehseqno, '~thor_data400::key::cbrs.addr_vehseqno', '~thor_data400::key::cbrs.addr_vehseqno', kav)

ut.MAC_SK_Move('~thor_data400::key::cbrs.addr.bdid','Q',kab2);
ut.mac_SK_Move('~thor_data400::key::cbrs.bdid.bankruptcy','Q',kbb2);
ut.MAC_SK_Move('~thor_data400::key::cbrs.addr_vehseqno','Q',kav2)

sequential(
	parallel(
		kab,
		kbb,
		kav
		),
	parallel(
		kab2,
		kbb2,
		kav2
		)
	);
	
//prs
ut.MAC_SK_BuildProcess(doxie_cbrs.key_addr_proflic,'~thor_data400::key::cbrs.addr_proflic','~thor_data400::key::cbrs.addr_proflic',kap)
ut.MAC_SK_BuildProcess(doxie_cbrs.key_phone_gong, '~thor_data400::key::cbrs.phone10_gong', '~thor_data400::key::cbrs.phone10_gong', kpg)

ut.MAC_SK_Move('~thor_data400::key::cbrs.addr_proflic','Q', kap2);
ut.MAC_SK_Move('~thor_data400::key::cbrs.phone10_gong','Q', kpg2);

sequential(
	parallel(
		sequential(
			ut.SF_MaintBuilding('~thor_data400::base::prof_licenses'),
			kap,
			ut.SF_MaintBuilt('~thor_data400::base::prof_licenses')
			),
		kpg
		),
	parallel(
		kap2,
		kpg2
		)
	);