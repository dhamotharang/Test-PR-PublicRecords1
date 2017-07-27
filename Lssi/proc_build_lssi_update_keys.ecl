import ut, doxie;

pre1 := ut.SF_MaintBuilding('~thor_data400::base::lssi_add');
pre2 := ut.SF_MaintBuilding('~thor_data400::base::lssi_remove');

bk1 := sequential(
	  buildindex(doxie.key_lssi_did_add,'~thor_data400::key::lssi_did_add' + thorlib.WUID(),overwrite),
	  FileServices.AddSuperFile('~thor_data400::key::lssi_did_add_father', 
						   '~thor_data400::key::lssi_did_add_built',, true),
	  FileServices.ClearSuperFile('~thor_data400::key::lssi_did_add_built'),
	  FileServices.AddSuperFile('~thor_data400::key::lssi_did_add_built', 
						   '~thor_data400::key::lssi_did_add' + thorlib.WUID()));

bk2 := sequential(
       buildindex(doxie.key_lssi_hhid_add,'~thor_data400::key::lssi_hhid_add' + thorlib.WUID(),overwrite),
  	  FileServices.AddSuperFile('~thor_data400::key::lssi_hhid_add_father', 
	  					   '~thor_data400::key::lssi_hhid_add_built',, true),
	  FileServices.ClearSuperFile('~thor_data400::key::lssi_hhid_add_built'),
	  FileServices.AddSuperFile('~thor_data400::key::lssi_hhid_add_built', 
						   '~thor_data400::key::lssi_hhid_add' + thorlib.WUID()));

bk3 := sequential(
       buildindex(doxie.key_lssi_remove,'~thor_data400::key::lssi_remove' + thorlib.WUID(),overwrite,few),
	  FileServices.AddSuperFile('~thor_data400::key::lssi_remove_father', 
						   '~thor_data400::key::lssi_remove_built',, true),
       FileServices.ClearSuperFile('~thor_data400::key::lssi_remove_built'),
	  FileServices.AddSuperFile('~thor_data400::key::lssi_remove_built', 
						   '~thor_data400::key::lssi_remove' + thorlib.WUID()));

post1 := ut.SF_MaintBuilt('~thor_data400::base::lssi_add');
post2 := ut.SF_MaintBuilt('~thor_data400::base::lssi_remove');

full1 := if (fileservices.getsuperfilesubname('~thor_data400::base::lssi_add',1) = 
             fileservices.getsuperfilesubname('~thor_data400::base::lssi_add_built',1),
		output('main file BASE = BUILT, Nothing done.'),parallel(bk1,bk2));
full2 := if (fileservices.getsuperfilesubname('~thor_data400::base::lssi_remove',1) = 
             fileservices.getsuperfilesubname('~thor_data400::base::lssi_remove_built',1),
		output('main file BASE = BUILT, Nothing done.'),bk3);

ut.mac_sk_move('~thor_data400::key::lssi_did_add','Q',out1)
ut.mac_sk_move('~thor_data400::key::lssi_hhid_add','Q',out2)
ut.mac_sk_move('~thor_data400::key::lssi_remove','Q',out3)

move1 := parallel(out1, out2, out3);

export proc_build_lssi_update_keys := sequential(pre1,pre2,full1,full2,post1,post2,move1);