import doxie, doxie_build,ut,RoxieKeybuild, hygenics_search;

export proc_build_DOC_punishment_key(string filedate) := function

prekey := if (nothor(fileservices.getsuperfilesubcount('~thor_data400::base::corrections_punishment_' + doxie_build.buildstate + '_BUILDING') > 0),
		output('Nothing Added to BUILDING superfile for Punishments'),
		sequential(
			fileservices.clearsuperfile('~thor_data400::base::corrections_punishment_' + doxie_build.buildstate + '_BUILDING'),
			fileservices.addsuperfile('~thor_data400::base::corrections_punishment_' + doxie_build.buildstate + '_BUILDING',
			'~thor_data400::base::corrections_punishment_' + doxie_build.buildstate,0,true)
		));

//Non-FCRA Build Key	
Roxiekeybuild.Mac_SK_BuildProcess_Local(hygenics_crim.key_prep_punishment(),
																				'~thor_data400::key::corrections_punishment::'+filedate+'::' + doxie_build.buildstate,
																				'~thor_data400::key::corrections_punishment_' + doxie_build.buildstate,
																				keyout,2);

//FCRA Build Key
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(hygenics_crim.key_prep_punishment(true),
																				'~thor_200::key::criminal_punishment::fcra::'+ doxie.Version_SuperKey + '::offender_key.punishment_type',
																				'~thor_200::key::criminal_punishment::fcra::'+filedate+'::offender_key.punishment_type',
																				fcrakeyout);

//Non-FCRA Key Move to Built
Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::corrections_punishment::'+filedate+'::' + doxie_build.buildstate,
																				'~thor_data400::key::corrections_punishment_' + doxie_build.buildstate,
																				mkeyout,2);

//FCRA Key Move to Built
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::criminal_punishment::fcra::@version@::offender_key.punishment_type',
																				'~thor_200::key::criminal_punishment::fcra::'+filedate+'::offender_key.punishment_type',
																				mfcrakeyout);

postkey := sequential(
		fileservices.clearsuperfile('~thor_Data400::base::corrections_punishment_' + doxie_build.buildstate + '_BUILT'),
		fileservices.addsuperfile('~thor_Data400::base::corrections_punishment_' + doxie_build.buildstate + '_BUILT','~thor_Data400::base::corrections_punishment_' + doxie_build.buildstate + '_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_Data400::base::corrections_punishment_' + doxie_build.buildstate + '_BUILDING')
		);

return if (nothor(fileservices.getsuperfilesubname('~thor_data400::base::corrections_punishment_' + doxie_build.buildstate + '_BUILT',1) = fileservices.getsuperfilesubname('~thor_data400::base::corrections_punishment_' + doxie_build.buildstate,1)),
			output('BUILT = BASE, nothing done for Punishments'),
			sequential(prekey,keyout,fcrakeyout,mkeyout,mfcrakeyout,postkey));
			
end;