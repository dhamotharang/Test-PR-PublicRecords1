import ut;

export Proc_BuildAll(string version = ut.GetDate[1..8]) := function

//////// Are there new files in the logs thor super input file

newfiles := count(fileservices.superfilecontents(ut.foreign_logs + 'thor10_11::in::accurint_acclogs_cc')) > 0;

//////// Build the base and transactional files

update_base := output(accurint_acclogs.MapAccLogs_Combine.base,, '~thor400_92::out::accurint_acclogs_' + version, overwrite, __compressed__);

update_trans := output(accurint_acclogs.MapAccLogs_Combine.transactions,, '~thor400_92::out::accurint_acclogs::transactions_' + version, overwrite, __compressed__);

//////// Super swap. Delete final file after job is complete.

base_super := FileServices.PromoteSuperFileList(['~thor400_92::base::accurint_acclogs',
												 '~thor400_92::base::accurint_acclogs_father',
												 '~thor400_92::base::accurint_acclogs_grandfather',
												 '~thor400_92::base::accurint_acclogs_delete'], '~thor400_92::out::accurint_acclogs_' + version);

trans_super := FileServices.PromoteSuperFileList(['~thor400_92::out::accurint_acclogs::transactions',
												 '~thor400_92::out::accurint_acclogs::transactions_father',
												 '~thor400_92::out::accurint_acclogs::transactions_grandfather',
												 '~thor400_92::out::accurint_acclogs::transactions_delete'], '~thor400_92::out::accurint_acclogs::transactions_' + version);

//////// Build keys

super_keybuilding := parallel(
		accurint_acclogs.Proc_BuildKeys(version),
		Accurint_AccLogs.Proc_AutokeyBuild(version));

//////// Clear Supers

base_superclear := fileservices.clearsuperfile('~thor400_92::base::accurint_acclogs_delete', true);

trans_superclear := fileservices.clearsuperfile('~thor400_92::out::accurint_acclogs::transactions_delete', true);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

build_acclogs := if(newfiles,  
						sequential(
								output(FileServices.SuperFileContents(ut.foreign_logs + 'thor10_11::in::accurint_acclogs_cc'), named('Input_Files'));
								parallel(update_base, update_trans),
								parallel(base_super, trans_super),
								super_keybuilding,
								parallel(base_superclear, trans_superclear)), // super transfers at end to reduce build time
						output('No New Files')) : success(fileservices.sendemail('cguyton@seisint.com', 'Accurint Acc Logs Complete '+version, '')),
														failure(fileservices.sendemail('cguyton@seisint.com', 'Accurint Acc Logs Failed '+workunit, failmessage));

return build_acclogs;
end;