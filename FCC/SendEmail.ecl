import _Control;
export SendEmail(string filedate) := module

export RoxieSuccess_email := fileservices.sendemail(
										'RoxieBuilds@seisint.com;'+_control.MyInfo.EmailAddressNotify,								 
										'FCCKey: BUILD SUCCESS '+ filedate ,					
										'Keys :    1) thor_data400::key::fcc::qa::bdid (thor_data400::key::fcc::'+filedate+'::bdid),\n' +
										'	2) thor_data400::key::fcc::qa::did (thor_data400::key::fcc::'+filedate+'::did),\n' +
										'	3) thor_data400::key::fcc::qa::seq (thor_data400::key::fcc::'+filedate+'::seq),\n' +
										'	4) thor_data400::key::fcc::qa::autokey::stname (thor_data400::key::fcc::'+filedate+'::autokey::stname),\n' +
										'	5) thor_data400::key::fcc::qa::autokey::address (thor_data400::key::fcc::'+filedate+'::autokey::address),\n' +
										'	6) thor_data400::key::fcc::qa::autokey::name (thor_data400::key::fcc::'+filedate+'::autokey::name),\n' +
										'	7) thor_data400::key::fcc::qa::autokey::phone2 (thor_data400::key::fcc::'+filedate+'::autokey::phone2),\n' +
										'	8) thor_data400::key::fcc::qa::autokey::citystname (thor_data400::key::fcc::'+filedate+'::autokey::citystname),\n' +
										'	9) thor_data400::key::fcc::qa::autokey::zip (thor_data400::key::fcc::'+filedate+'::autokey::zip),\n' +
										'	10) thor_data400::key::fcc::qa::autokey::payload (thor_data400::key::fcc::'+filedate+'::autokey::payload),\n' +
										'	11) thor_data400::key::fcc::qa::autokey::citystnameb2 (thor_data400::key::fcc::'+filedate+'::autokey::citystnameb2),\n' +
										'	12) thor_data400::key::fcc::qa::autokey::zipb2 (thor_data400::key::fcc::'+filedate+'::autokey::zipb2),\n' +
										'	13) thor_data400::key::fcc::qa::autokey::addressb2 (thor_data400::key::fcc::'+filedate+'::autokey::addressb2),\n' +
										'	14) thor_data400::key::fcc::qa::autokey::namewords2 (thor_data400::key::fcc::'+filedate+'::autokey::namewords2),\n' +
										'	15) thor_data400::key::fcc::qa::autokey::stnameb2 (thor_data400::key::fcc::'+filedate+'::autokey::stnameb2),\n' +
										'	16) thor_data400::key::fcc::qa::autokey::nameb2 (thor_data400::key::fcc::'+filedate+'::autokey::nameb2),\n' +
										'	17) thor_data400::key::fcc::qa::autokey::phoneb2 (thor_data400::key::fcc::'+filedate+'::autokey::phoneb2),\n' +
										'	have been built and ready to be deployed to QA.'); 
										
export build_success := fileservices.sendemail(
										_control.MyInfo.EmailAddressNotify + 'qualityassurance@seisint.com',
										'FCC Roxie Key Build Succeeded ' + filedate,
										'Sample records are in WUID:' + workunit);

export build_failure := fileservices.sendemail(
										_control.MyInfo.EmailAddressNotify,
										'FCC Roxie Key Build FAILED'+filedate,
										workunit);	
end;										