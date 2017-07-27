import ut, doxie_files, doxie_build;
/*
I ALSO HAD TO BUILD:
key::corp_base_corpkey
key::whois_bdid
*/

ut.MAC_SK_BuildProcess_v2(doxie_cbrs.key_addr_bdid,'~thor_data400::key::cbrs.addr.bdid',kab)
ut.MAC_SK_BuildProcess_v2(doxie_cbrs.key_addr_proflic,'~thor_data400::key::cbrs.addr_proflic',kap)
ut.MAC_SK_BuildProcess_v2(doxie_cbrs.key_phone_gong, '~thor_data400::key::cbrs.phone10_gong', kpg)
ut.MAC_SK_BuildProcess_v2(Doxie_cbrs.key_BDID_NameVariations, '~thor_data400::key::cbrs.bdid_NameVariations', knv)


export proc_keybuild := 
	parallel(
		sequential(
			ut.SF_MaintBuilding('~thor_data400::base::prof_licenses'),
			kap,
			ut.SF_MaintBuilt('~thor_data400::base::prof_licenses')
			),
		kpg,
		kab,
		knv
		);