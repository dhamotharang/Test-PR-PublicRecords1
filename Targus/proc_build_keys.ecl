import ut, roxiekeybuild;

export proc_build_Keys(string versionDate) := function

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(targus.Key_Targus_DID,'','~thor_data400::key::targus::'+versionDate+'::did',Key_did);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(targus.Key_Targus_phone,'','~thor_data400::key::targus::'+versionDate+'::p7.p3.st',Key_phone);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(targus.Key_Targus_address,'','~thor_data400::key::targus::'+versionDate+'::address',Key_addr);
	//RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(targus.Key_Targus_fcra_DID,'','~thor_data400::key::targus::fcra::'+versionDate+'::did',Key_fcra_did);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(targus.Key_Targus_fcra_phone,'','~thor_data400::key::targus::fcra::'+versionDate+'::p7.p3.st',Key_fcra_phone);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(targus.Key_Targus_fcra_address,'','~thor_data400::key::targus::fcra::'+versionDate+'::address',Key_fcra_addr);

	keyShuffle := sequential(
		fileservices.startsuperfiletransaction(),
		fileservices.clearsuperfile('~thor_data400::key::targus::qa::p7.p3.st'),
		fileservices.addsuperfile('~thor_data400::key::targus::qa::p7.p3.st','~thor_data400::key::targus::'+versionDate+'::p7.p3.st'),
		fileservices.clearsuperfile('~thor_data400::key::targus::qa::address'),
		fileservices.addsuperfile('~thor_data400::key::targus::qa::address','~thor_data400::key::targus::'+versionDate+'::address'),
		fileservices.clearsuperfile('~thor_data400::key::targus::qa::did'),
		fileservices.addsuperfile('~thor_data400::key::targus::qa::did','~thor_data400::key::targus::'+versionDate+'::did'),
		fileservices.clearsuperfile('~thor_data400::key::targus::fcra::qa::p7.p3.st'),
		fileservices.addsuperfile('~thor_data400::key::targus::fcra::qa::p7.p3.st','~thor_data400::key::targus::fcra::'+versionDate+'::p7.p3.st'),
		fileservices.clearsuperfile('~thor_data400::key::targus::fcra::qa::address'),
		fileservices.addsuperfile('~thor_data400::key::targus::fcra::qa::address','~thor_data400::key::targus::fcra::'+versionDate+'::address'),
		//fileservices.clearsuperfile('~thor_data400::key::targus::fcra::qa::did'),
		//fileservices.addsuperfile('~thor_data400::key::targus::fcra::qa::did','~thor_data400::key::targus::fcra::'+versionDate+'::did'),
		fileservices.finishsuperfiletransaction()
		);

	updateDOPS := roxiekeybuild.updateversion('TargusKeys',versionDate,'kgummadi@seisint.com, harry.gist@lexisnexisrisk.com, Abednego.Escobal@lexisnexisrisk.com',,'N');
	update_FCRA_DOPS := roxiekeybuild.updateversion('FCRA_TargusKeys',versionDate,'kgummadi@seisint.com, harry.gist@lexisnexisrisk.com, Abednego.Escobal@lexisnexisrisk.com',,'F');
	
	/* **ROXIE KEY NOTIFICATION EMAIL********************************************************************************************************** */	
	email := fileservices.sendemail('RoxieBuilds@seisint.com;kgummadi@seisint.com',
									'TARGUS: BUILD SUCCESS '+ versionDate ,
									'keys: 1) thor_data400::key::targus_did_qa(thor_data400::key::targus::'+versionDate+'::did),\n' +
									'      2) thor_data400::key::targus_p7.p3.st_qa(thor_data400::key::targus::'+versionDate+'::p7.p3.st),\n' +
									'      3) thor_data400::key::targus_address_qa(thor_data400::key::targus::'+versionDate+'::address),\n' +
									'         have been built and ready to be deployed to QA.'); 
	/* ***************************************************************************************************************************************** */					 
	
	return sequential(	Key_did,
						Key_addr,
						Key_phone,
						/*Key_fcra_did,*/
						Key_fcra_addr,
						Key_fcra_phone,
						keyShuffle,
						updateDOPS,
						update_FCRA_DOPS,
						email);

end;