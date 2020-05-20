import header, ut;

pre1 := ut.SF_MaintBuilding('~thor_data400::base::did_statedeath_master');

ut.MAC_SK_BuildProcess(header.key_statedeath_master_did,
                       '~thor_data400::key::did_statedeath_master',
									     '~thor_data400::key::did_statedeath_master', a, '2')

post1 := ut.SF_MaintBuilt('~thor_data400::base::did_statedeath_master');


full1 := if (fileservices.getsuperfilesubname('~thor_data400::base::did_statedeath_master',1)
           = fileservices.getsuperfilesubname('~thor_data400::base::did_statedeath_master_built',1),
		       output('main file BASE = BUILT, Nothing done.'), a);

ut.MAC_SK_Move('~thor_data400::key::did_statedeath_master', 'Q', move1);

export proc_statedeathmaster_buildkey := sequential(pre1, full1, post1, move1);
