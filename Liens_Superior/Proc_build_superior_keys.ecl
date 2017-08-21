import ut,roxiekeybuild;

export proc_build_superior_keys(string filedate) := function
	Roxiekeybuild.Mac_SK_BuildProcess_v2_local(key_did,'~thor_data400::key::superior_liens_did','~thor_data400::key::superior_liens::'+filedate+'::did',didkey);
	Roxiekeybuild.Mac_SK_BuildProcess_v2_local(key_bdid,'~thor_data400::key::superior_liens_bdid','~thor_data400::key::superior_liens::'+filedate+'::bdid',bdidkey);

	Roxiekeybuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::superior_liens_did','~thor_data400::key::superior_liens::'+filedate+'::did',mvdidkey);
	Roxiekeybuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::superior_liens_bdid','~thor_data400::key::superior_liens::'+filedate+'::bdid',mvbdidkey);

	ut.MAC_SK_Move('~thor_data400::key::superior_liens_did','Q',didqa);
	ut.MAC_SK_Move('~thor_data400::key::superior_liens_bdid','Q',bdidqa);

	e_mail_success := fileservices.sendemail(
														'roxiebuilds@seisint.com;kgummadi@seisint.com',
														'Superior Liens Roxie Build Succeeded ' + filedate,
														'keys: 1) thor_data400::key::superior_liens_did_qa(thor_data400::key::superior_liens::'+filedate+'::did),\n' + 
														'	   2) thor_data400::key::superior_liens_bdid_qa(thor_data400::key::superior_liens::'+filedate+'::bdid),\n' + 
														'      have been built and ready to be deployed to QA.');
								
	e_mail_fail := fileservices.sendemail(
														'kgummadi@seisint.com',
														'Superior Liens Roxie Build FAILED',
														failmessage);
														
	e_mail_notify := sequential(liens_superior.did_superior_liens,
								parallel(didkey,bdidkey),parallel(mvdidkey,mvbdidkey),
								parallel(didqa,bdidqa)) 
								: success(e_mail_success), failure(e_mail_fail);

	return e_mail_notify;
end;