import ut, RoxieKeybuild, data_services, orbit3;

export Proc_BuildAll := function

#workunit('name','Yogurt:Case Connect - Accurint Acc Logs');
#workunit('priority','high');

// can run anywhere on 84 and 92. dailies are all high priority

//////// Are there new files in the logs thor super input file 

for_filelist := nothor(fileservices.superfilecontents('~thor_data400::in::accurint_acclogs_cc'));

newfiles := count(for_filelist) > 0;

//// Build the base and transactional files

update_base := output(accurint_acclogs.MapAccLogs_Combine.base,, '~thor_data400::out::accurint_acclogs_cc_' + version, overwrite, __compressed__);

update_trans := output(accurint_acclogs.MapAccLogs_Combine.transactions,, '~thor_data400::out::accurint_acclogs::transactions_' + version, overwrite, __compressed__);

//// Super swap. Delete final file after job is complete.

base_super := FileServices.PromoteSuperFileList(['~thor_data400::base::accurint_acclogs_cc',
												 '~thor_data400::base::accurint_acclogs_cc_father',
												 '~thor_data400::base::accurint_acclogs_cc_grandfather',
												 '~thor_data400::base::accurint_acclogs_cc_delete'], '~thor_data400::out::accurint_acclogs_cc_' + version);

trans_super := FileServices.PromoteSuperFileList(['~thor_data400::out::accurint_acclogs::transactions',
												 '~thor_data400::out::accurint_acclogs::transactions_father',
												 '~thor_data400::out::accurint_acclogs::transactions_grandfather',
												 '~thor_data400::out::accurint_acclogs::transactions_delete'], '~thor_data400::out::accurint_acclogs::transactions_' + version);

//// Build keys

super_keybuilding := 
	sequential(
		accurint_acclogs.Proc_BuildKeys,
		Accurint_AccLogs.Proc_AutokeyBuild,
		RoxieKeybuild.updateversion('CaseConnectKeys',trim(version, all),'john.freibaum@lexisnexisrisk.com, Fernando.Incarnacao@lexisnexisrisk.com, Sudhir.Kasavajjala@lexisnexisrisk.com, Darren.Knowles@lexisnexisrisk.com',,'N'));

//// Clear Supers

base_superclear := nothor(fileservices.clearsuperfile('~thor_data400::base::accurint_acclogs_cc_delete', true));

trans_superclear := nothor(fileservices.clearsuperfile('~thor_data400::out::accurint_acclogs::transactions_delete', true));

processed_filenames := nothor(table(WorkunitServices.WorkunitFilesRead(workunit), {name}));

//// Send Email

sendEmail := fileservices.sendemail('john.freibaum@lexisnexis.com', 'Case Connect: Accurint Acc Logs Complete', workunit);


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

stats := function

key_recordidNEW := index(Accurint_AccLogs.File_SearchAutokey,{record_id},{Accurint_AccLogs.File_SearchAutokey},
							Data_Services.Data_location.Prefix('Accurint_AccLogs') + 'thor_data400::key::acclogs::qa::recordid');

key_recordidOLD := index(Accurint_AccLogs.File_SearchAutokey,{record_id},{Accurint_AccLogs.File_SearchAutokey},
							Data_Services.Data_location.Prefix('Accurint_AccLogs') + 'thor_data400::key::acclogs::father::recordid');

key_recordidSamples := join(key_recordidNEW, key_recordidOLD, left.record_id = right.record_id, left only);

DIDNEW := dedup(dataset('~thor_data400::base::accurint_acclogs_cc', accurint_acclogs.Layout_AccLogs_Base.main, thor)(did > 0), did, all);

DIDOLD := dedup(dataset('~thor_data400::base::accurint_acclogs_cc_father', accurint_acclogs.Layout_AccLogs_Base.main, thor)(did > 0), all);

DIDSamples := join(DIDOLD, DIDNEW, left.did = right.did, 
		transform(recordof(didnew), self.did := right.did, self := right), right only)(did > 0);


return parallel(output(choosen(DIDSamples, 100), named('DID_Samples')), output(choosen(key_recordidSamples, 100), named('RecordID_Samples')));

end;

///////////////////////////////////////////////////////////////////////////////////
orbit_update := if ( ut.Weekday((integer) version)  not in [ 'SATURDAY','SUNDAY']  , Orbit3.proc_Orbit3_CreateBuild ('Case Connect',version) , Output('No_Orbit_Entry_needed') );

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// HeaderVer_New := ut.IsNewProdHeaderVersion('accurint_auditing');
// HeaderVer_Update := ut.PostDID_HeaderVer_Update('accurint_auditing');

// BHeaderVer_New := ut.IsNewProdHeaderVersion('accurint_auditing', 'bheader_file_version');
// BHeaderVer_Update := ut.PostDID_HeaderVer_Update('accurint_auditing', 'bheader_file_version');

build_acclogs := 
					if(~newfiles, output('No New Files'),
						sequential(
									output(version, named('Building_Version'));
									output(nothor(FileServices.SuperFileContents('~thor_data400::in::accurint_acclogs_cc')), named('Input_Files'));
									// output(nothor(FileServices.SuperFileContents('~thor_data400::in::accurint_acclogs_cc_preprocess')), named('Upcoming_Files'));
									ACCURINT_acclogs.File_Deconfliction.buildfile;
									update_base; update_trans;
									nothor(base_super); nothor(trans_super);
	/*                 // if(HeaderVer_New, HeaderVer_Update); // removed because the build kept failing */
	/*                 // if(BHeaderVer_New, BHeaderVer_Update); */
									super_keybuilding;
									orbit_update;
									Accurint_AccLogs.STRATA_CaseConnect(trim(version, all));
									output('Output Processed Files List for Logs Thor');								
									output(processed_filenames,,'~thor_data400::in::accurint_acclogs::processed',overwrite);
									sendEmail;
									parallel(base_superclear, trans_superclear);
									stats)
					)
					;
								
return build_acclogs;
end;