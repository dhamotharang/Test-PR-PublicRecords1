import watchdog,ut,demo_data_scrambler,lib_fileservices;

destinationip := 'edata12-bld.br.seisint.com';
volume_name := 'thor_back5/local_data/demo/watchdog';

ut.MAC_SF_BuildProcess(demo_data_scrambler.scramble_watchdog_best,
                       '~thor_data400::base::watchdog_best',glb, 2);

ut.MAC_SF_BuildProcess(demo_data_scrambler.scramble_watchdog_best,
                       '~thor_data400::base::watchdog_best_nonglb',nonglb, 2);

ut.MAC_SF_BuildProcess(demo_data_scrambler.scramble_watchdog_best,
                       '~thor_data400::base::watchdog_best_nonglb_nonutility',nonglb_nonutility, 2);
											 
ut.MAC_SF_BuildProcess(demo_data_scrambler.scramble_watchdog_best,
                       '~thor_data400::base::watchdog_best_nonutility',nonutility, 2);
											 
ut.MAC_SF_BuildProcess(demo_data_scrambler.scramble_watchdog_best,
                       '~thor_data400::base::watchdog_best_marketing',marketing, 2);

string_rec := record
	string12 old_did;
	string12 new_did;
end;

ds := dataset([{'1','1'},
{'1','1'},
{'1','1'},
{'1','1'},
{'1','1'},
{'1','1'}],
string_rec);

outds := output(ds,,'~thor::base::watchdog::demo::moxie_old_did.did',overwrite);

newstring_rec := record
		string12 old_did;
	string12 new_did;
	unsigned integer8 __filepos { virtual(fileposition)};
end;

getds := dataset('~thor::base::watchdog::demo::moxie_old_did.did',newstring_rec,flat);

buildoldnewindex := sequential(outds,BUILDINDEX(getds,,'~thor_data400::key::watchdog_moxie_old_did.did',overwrite,moxie));


result := sequential(glb,nonglb,nonglb_nonutility,nonutility,marketing,
								demo_data.proc_moxie_watchdog_delta_prep(''),
								demo_data.proc_moxie_watchdog_delta_prep('nonglb'),
								demo_data.proc_moxie_watchdog_delta_prep('nonutility'),
								demo_data.proc_moxie_watchdog_delta_prep('nonglb_nonutility'),
								proc_watchdog_moxie_prep(''),
								proc_watchdog_moxie_prep('nonglb'),
								proc_watchdog_moxie_prep('nonutility'),
								proc_watchdog_moxie_prep('nonglb_nonutility'),
								buildoldnewindex,
								lib_fileservices.FileServices.DKC('~thor_data400::key::watchdog_moxie.did',DestinationIP,'/'+volume_name+'/watchdog.match.key',,,,TRUE),
								lib_fileservices.FileServices.DKC('~thor_data400::key::watchdog_moxie_nonglb.did',DestinationIP,'/'+volume_name+'/watchdog_non_glb.match.key',,,,TRUE),
								lib_fileservices.FileServices.DKC('~thor_data400::key::watchdog_moxie_old_did.did',DestinationIP,'/'+volume_name+'/watchdog_old_new_did.match.key',,,,TRUE),
								lib_fileservices.FileServices.DKC('~thor_data400::key::watchdog_moxie_nonglb_nonutility.did',DestinationIP,'/'+volume_name+'/watchdog_non_glb_non_utility.match.key',,,,TRUE),
								lib_fileservices.FileServices.DKC('~thor_data400::key::watchdog_moxie_nonutility.did',DestinationIP,'/'+volume_name+'/watchdog_non_utility.match.key',,,,TRUE)
								);

export bwr_moxie_watchdog := result;