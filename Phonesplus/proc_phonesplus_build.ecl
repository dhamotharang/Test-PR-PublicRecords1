#workunit('name','Phonesplus v2: '+ Phonesplus.version+': Phonesplus / Qsent')


import Cellphone,Phonesplus, lib_FileServices, RoxieKeyBuild,infutorcid, phonesplus_v2;

e_mail_success := FileServices.sendemail('jason.allerdings@lexisnexisrisk.com;fernando.henao@lexisnexisrisk.com;julie.gardner@lexisnexisrisk.com;qualityassurance@seisint.com;joseph.lezcano@lexisnexisrisk.com;charleen.thompson@lexisnexisrisk.com;aherzberg@lexisnexis.com','PHONESPLUS/QSENT '+ Phonesplus.version+' weekly sample available ','at ' + thorlib.WUID());
e_mail_failure := FileServices.sendemail('jason.allerdings@lexisnexisrisk.com;fernando.henao@lexisnexisrisk.com;julie.gardner@lexisnexisrisk.com;joseph.lezcano@lexisnexisrisk.com;charleen.thompson@lexisnexisrisk.com; aherzberg@lexisnexis.com','Phonesplus/Qsent Build Failure',failmessage+'at ' + thorlib.WUID());

phonesplus_dops_update := sequential(RoxieKeybuild.updateversion('PhonesPlusKeys',Phonesplus.version,'jlezcano@seisint.com;jason.allerdings@lexisnexisrisk.com',,'N'),
																													 RoxieKeybuild.updateversion('QsentKeys',Phonesplus.version,'jlezcano@seisint.com',,'N'));

addHeaderKeyBuilding := if(fileservices.getsuperfilesubcount('~thor_data400::Base::HeaderKey_Building')>0,
							output('Nothing added to thor_data400::Base::HeaderKey_Building'),
							fileservices.addsuperfile('~thor_data400::Base::HeaderKey_Building','~thor_data400::Base::Header_prod',,true));
clearHeaderKeyBuilding := FileServices.ClearSuperFile('~thor_data400::Base::HeaderKey_Building');

export proc_phonesplus_build := sequential(
			// infutorcid.Proc_Build_All(Phonesplus.version), Running Infutor_CID Separately 
			Phonesplus_v2.Spray_Telcordia(Phonesplus_v2.Version_Telcordia);
			Phonesplus.spray_NeustarInputFile(Phonesplus.version), 
			addHeaderKeyBuilding,
			Phonesplus_v2.Proc_build_base,
			Phonesplus.proc_build_phonesplus_keys(Phonesplus.version),
			Phonesplus.proc_create_phonesplus_relationships(Phonesplus.version),
			Phonesplus.Qsent_DID,
			phonesplus_v2.Proc_build_Promonitor_extract,
	parallel(
			  Phonesplus.sample_PhonesplusBase,
			  Phonesplus.strata_popFilePhonesplusBase,
				Phonesplus.proc_build_qsent_keys(Phonesplus.version),
				Phonesplus.sample_QsentBase,
			  Phonesplus.strata_popFileQsentBase
			  ,phonesplus.proc_build_stats
			  ),clearHeaderKeyBuilding,
				phonesplus_dops_update
			): 
				success(e_mail_success), 
				FAILURE(e_mail_failure);