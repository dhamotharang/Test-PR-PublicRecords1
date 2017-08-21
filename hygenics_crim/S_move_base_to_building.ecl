prekey := if (fileservices.getsuperfilesubcount('~thor_Data400::base::corrections_offenders_' + doxie_build.buildstate + '_BUILDING') > 0,
		output('Nothing added to Offenders BUILDING file.'),
		fileservices.addsuperfile('~thor_data400::base::corrections_offenders_' + doxie_build.buildstate + '_BUILDING','~thor_data400::base::corrections_offenders_' + doxie_build.buildstate,0,true)
		);		

prekey2 := if (fileservices.getsuperfilesubcount('~thor_Data400::base::corrections_offenses_' + doxie_build.buildstate + '_BUILDING') > 0,
		output('Nothing added to Offenses BUILDING file.'),
		fileservices.addsuperfile('~thor_data400::base::corrections_offenses_' + doxie_build.buildstate + '_BUILDING','~thor_data400::base::corrections_offenses_' + doxie_build.buildstate,0,true));
		
prekey3 := if (fileservices.getsuperfilesubcount('~thor_data400::base::corrections_punishment_' + doxie_build.buildstate + '_BUILDING') > 0,
		output('Nothing Added to BUILDING superfile for Punishments'),
		sequential(
			fileservices.clearsuperfile('~thor_data400::base::corrections_punishment_' + doxie_build.buildstate + '_BUILDING'),
			fileservices.addsuperfile('~thor_data400::base::corrections_punishment_' + doxie_build.buildstate + '_BUILDING','~thor_data400::base::corrections_punishment_' + doxie_build.buildstate,0,true)
		));
	
prekey4 := if (fileservices.getsuperfilesubcount('~thor_Data400::base::corrections_activity_' + doxie_build.buildstate + '_BUILDING') > 0,
		output('Nothing added to BUILDING file for Activities'),
		fileservices.addsuperfile('~thor_Data400::base::corrections_activity_' + doxie_build.buildstate + '_BUILDING','~thor_Data400::base::corrections_activity_' + doxie_build.buildstate,0,true)
		);

prekey5 := if (fileservices.getsuperfilesubcount('~thor_data400::base::corrections_court_offenses_' + doxie_build.buildstate + '_BUILDING') > 0,
		output('Nothing added to BUILDING superfile for court offenses'),
		fileservices.addsuperfile('~thor_data400::base::corrections_court_offenses_' + doxie_build.buildstate + '_BUILDING','~thor_data400::base::corrections_court_offenses_' + doxie_build.buildstate,0,true)
		);
		
sequential(prekey1,prekey2,prekey3,prekey4,prekey5);	