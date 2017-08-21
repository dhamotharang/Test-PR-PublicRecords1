import ut, data_services;

#OPTION('allowedClusters', 'thor400_20,thor400_30')
#OPTION('AllowAutoSwitchQueue', true)

version := ut.getdate;

valid_state := ['blocked','compiled','submitted','running'];

wuname := 'Case Connect - Accurint Acc Logs';

d := sort(WorkunitServices.WorkunitList('',,,'','')(wuid <> thorlib.wuid() and job = wuname and state in valid_state), -wuid);
active_workunit :=  count(d) > 0;


base_exist := fileservices.fileexists('~thor_data400::out::accurint_acclogs_cc_'+version);

trans_exist := fileservices.fileexists('~thor_data400::out::accurint_acclogs::transactions_'+version);

output(active_workunit, named('Active_Workunit'));
output(base_exist, named('Base_File_Version_Exists')); 
output(trans_exist, named('Transactional_File_Version_Exists'));


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

stats := function

key_recordidNEW := index(Accurint_AccLogs.File_SearchAutokey,{record_id},{Accurint_AccLogs.File_SearchAutokey},
							Data_Services.Data_location.Prefix('Accurint_AccLogs') + 'thor_data400::key::acclogs::qa::recordid');

key_recordidOLD := index(Accurint_AccLogs.File_SearchAutokey,{record_id},{Accurint_AccLogs.File_SearchAutokey},
							Data_Services.Data_location.Prefix('Accurint_AccLogs') + 'thor_data400::key::acclogs::father::recordid');

key_recordidSamples := join(key_recordidNEW, key_recordidOLD, left.record_id = right.record_id, left only);

DIDNEW := dedup(dataset('~thor_data400::base::accurint_acclogs_cc', accurint_acclogs.Layout_AccLogs_Base.full_layout, thor)(did > 0), did, all);

DIDOLD := dedup(dataset('~thor_data400::base::accurint_acclogs_cc_father', accurint_acclogs.Layout_AccLogs_Base.full_layout, thor)(did > 0), all);

DIDSamples := join(DIDOLD, DIDNEW, left.did = right.did, 
																	transform(recordof(didnew), self.did := right.did, self := right), right only)(did > 0);


return parallel(output(choosen(DIDSamples, 100), named('DID_Samples')), output(choosen(key_recordidSamples, 100), named('RecordID_Samples')));
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if(active_workunit or (base_exist and trans_exist), output('No Build'), sequential(accurint_acclogs.Proc_BuildAll(version), stats));

/* this build takes 9 mins to run on the 200 way, 22 mins on the 400_92 */

