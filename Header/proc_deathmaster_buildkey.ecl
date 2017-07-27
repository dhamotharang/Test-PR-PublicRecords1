import header,codes,did_add,didville,ut,header_slimsort, watchdog, doxie_files;

pre1 := ut.SF_MaintBuilding('~thor_data400::base::did_death_master');

ut.MAC_SK_BuildProcess(header.key_death_master_did,'~thor_data400::key::did_death_master', 
									      '~thor_data400::key::did_death_master',a, '2')

post1 := ut.SF_MaintBuilt('~thor_data400::base::did_death_master');

full1 := if (fileservices.getsuperfilesubname('~thor_data400::base::did_death_master',1) = fileservices.getsuperfilesubname('~thor_data400::base::did_death_master_built',1),
		output('main file BASE = BUILT, Nothing done.'), a);
		
ut.MAC_SK_Move('~thor_data400::key::did_death_master', 'Q', move1);

export proc_deathmaster_buildkey := sequential(pre1,full1,post1,move1);