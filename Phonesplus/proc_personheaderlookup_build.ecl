// #workunit('name','PersonHeaderLookup '+ Phonesplus.version)

import Cellphone,Phonesplus, lib_FileServices, RoxieKeyBuild;

e_mail_success := FileServices.sendemail('qualityassurance@seisint.com', 'john.freibaum@lexisnexis.com','PersonHeaderLookup Success: Build '+ Phonesplus.version+' weekly sample available ','at ' + thorlib.WUID());
e_mail_failure := FileServices.sendemail('john.freibaum@lexisnexis.com','PersonHeaderLookup Build Failure',failmessage+'at ' + thorlib.WUID());

personheaderlookup_dops_update := sequential(RoxieKeybuild.updateversion('PersonHeaderLookupKeys',Phonesplus.version,'john.freibaum@lexisnexis.com',,'N'));
addHeaderKeyBuilding := if(fileservices.getsuperfilesubcount('~thor_data400::Base::HeaderKey_Building')>0,
							output('Nothing added to thor_data400::Base::HeaderKey_Building'),
							fileservices.addsuperfile('~thor_data400::Base::HeaderKey_Building','~thor_data400::Base::Header_prod',,true));
clearHeaderKeyBuilding := FileServices.ClearSuperFile('~thor_data400::Base::HeaderKey_Building');

export proc_personheaderlookup_build := sequential(addHeaderKeyBuilding,
			Phonesplus.proc_build_PersonHeaderLookupKey(Phonesplus.version),
			personheaderlookup_dops_update
			): 
				success(e_mail_success), 
				FAILURE(e_mail_failure);