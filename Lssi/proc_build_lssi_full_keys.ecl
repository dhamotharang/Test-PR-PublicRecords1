import ut;

pre1 := ut.SF_MaintBuilding('~thor_data400::base::lssi_main');

ut.MAC_SK_BuildProcess(lssi.key_did,'~thor_data400::key::lssi_did', 
						      '~thor_data400::key::lssi_did_key',bk1,4)
ut.MAC_SK_BuildProcess(lssi.key_hhid,'~thor_data400::key::lssi_hhid',
						       '~thor_data400::key::lssi_hhid_key',bk2,4)

post1 := ut.SF_MaintBuilt('~thor_data400::base::lssi_main');

full1 := if (fileservices.getsuperfilesubname('~thor_data400::base::lssi_main',1) = 
             fileservices.getsuperfilesubname('~thor_data400::base::lssi_main_built',1),
		output('main file BASE = BUILT, Nothing done.'),parallel(bk1,bk2));

ut.mac_sk_move('~thor_data400::key::lssi_did_key','Q',out1)
ut.mac_sk_move('~thor_data400::key::lssi_hhid_key','Q',out2)

move1 := parallel(out1, out2);

export proc_build_lssi_full_keys := sequential(pre1,full1,post1,move1);