#workunit('name','Phonesplusv2/Qsent Build ' + Phonesplus.version)

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//PLEASE FOLLOW ALL BUILD INSTRUCTIONS IN GREEN TEXT BELOW

/*

1.
IN A SEPERATE BUILDER WINDOW run the following attribute for each files outside of the done folder 
These files can be found on edata14 : /load01/intrado

EX:
Phonesplus.spray_IntradoInputFiles('LL_I047_0100_20070203.EXR');
Phonesplus.spray_IntradoInputFiles('LL_I047_0101_20070203.EXB'); 
etc.. 

The above function sprays then adds the files to the appropriate superfile.  
Once this is done you will need to move Unix files into the "done" directory.
*/
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

import Cellphone,Phonesplus, lib_FileServices;

e_mail_success := FileServices.sendemail('qualityassurance@seisint.com;joseph.lezcano@lexisnexis.com','PHONESPLUS/QSENT WEEKLY SAMPLE READY','at ' + thorlib.WUID());
e_mail_failure := FileServices.sendemail('joseph.lezcano@lexisnexis.com','Phonesplus Build Failure',failmessage+'at ' + thorlib.WUID());
addHeaderKeyBuilding := if(fileservices.getsuperfilesubcount('~thor_data400::Base::HeaderKey_Building')>0,
							output('Nothing added to thor_data400::Base::HeaderKey_Building'),
							fileservices.addsuperfile('~thor_data400::Base::HeaderKey_Building','~thor_data400::Base::Header_prod',,true));
clearHeaderKeyBuilding := FileServices.ClearSuperFile('~thor_data400::Base::HeaderKey_Building');

export proc_phonesplus_build_all := sequential(
			Phonesplus.spray_NeustarInputFile(Phonesplus.version), 
			/*
			\\tapeload02b\k\cell_phones\passed_acquisition_evaluation\neustar
			This file is a Daily full file replacement you will want to enter the date of the last file received.
			IF this function stalls 
			you will have to ftp to Unix and spray to thor manually 
			*/
			
			addHeaderKeyBuilding,
			Phonesplus_v2.Proc_build_base,
			Phonesplus.proc_build_phonesplus_keys(Phonesplus.version), //F12 here to update version date to today's date

			Phonesplus.Qsent_DID,
			Phonesplus.proc_build_qsent_keys(Phonesplus.version),
			Phonesplus.proc_build_PersonHeaderLookupKey(Phonesplus.version),
	parallel(
			  Phonesplus.sample_PhonesplusBase,
			  Phonesplus.sample_QsentBase,
			  Phonesplus.strata_popFilePhonesplusBase,
			  Phonesplus.strata_popFileQsentBase,
			  phonesplus.proc_build_stats
			  ),clearHeaderKeyBuilding
			): 
				success(e_mail_success), 
				FAILURE(e_mail_failure);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/* Once all 3 key builds have completed you will receive email notification.  
Please update versions for 
Phonesplus Keys
Qsent Keys and 
Person Header Lookup Keys on the following page 
https://securedev.accurint.com/dops/  */
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////