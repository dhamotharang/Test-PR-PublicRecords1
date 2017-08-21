import UCCD;

build_keys	 := UCCD.Proc_Build_Keys;
Move_to_qa   := UCCD.Proc_AcceptSK_ToQA;
email_success := fileservices.sendemail('roxiedeployment@seisint.com;zhuang@seisint.com',
										'UCC Build Succeeded - ' + uccd.version_development,
										'keys: 1) thor_data400::key::ucc_bdid_qa(thor_data400::key::ucc::'+uccd.version_development+'::bdid),\n' + 
										'	   2) thor_data400::key::ucc_did_qa(thor_data400::key::ucc::'+uccd.version_development+'::did),\n' + 
										'      3) thor_data400::key::ucc_ucc_key_qa(thor_data400::key::ucc::'+uccd.version_development+'::ucc_key),\n' +
										'      have been built and ready to be deployed to QA.');
													
													

export Proc_Build_Roxie := sequential( build_keys,Move_to_qa ,email_success);