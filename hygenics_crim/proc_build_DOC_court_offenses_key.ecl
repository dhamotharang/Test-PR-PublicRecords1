import doxie, doxie_build,ut,RoxieKeyBuild;

export proc_build_DOC_court_offenses_key(string filedate) := 
function

prekey := if (nothor(fileservices.getsuperfilesubcount('~thor_data400::base::corrections_court_offenses_' + doxie_build.buildstate + '_BUILDING') > 0),
		output('Nothing added to BUILDING superfile for court offenses'),
		fileservices.addsuperfile('~thor_data400::base::corrections_court_offenses_' + doxie_build.buildstate + '_BUILDING','~thor_data400::base::corrections_court_offenses_' + doxie_build.buildstate,0,true)
		);

//Non-FCRA Build Key	
RoxieKeyBuild.Mac_SK_BuildProcess_Local(hygenics_crim.key_prep_courtoffenses(),
																						'~thor_data400::key::corrections_court_offenses::'+filedate+'::' + doxie_build.buildstate,
																						'~thor_data400::key::corrections_court_offenses_' + doxie_build.buildstate,key,2);

//FCRA Build Key	
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(hygenics_crim.key_prep_courtoffenses(true),
																				'~thor_200::key::criminal_court_offenses::fcra::' + doxie.Version_SuperKey + '::offender_key',
																				'~thor_200::key::criminal_court_offenses::fcra::'+filedate+'::offender_key',fcra_key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(hygenics_crim.key_prep_courtoffenses(true)
																						,'~thor_data400::key::corrections::fcra::court_offenses_'+ doxie_build.buildstate + '_' + doxie.Version_SuperKey
																						,'~thor_data400::key::life_eir::fcra::'+filedate+'::court_offenses'
																						,bk_court_offenses);
//Non-FCRA Key Move to Built
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::corrections_court_offenses::'+filedate+'::' + doxie_build.buildstate,
																						'~thor_data400::key::corrections_court_offenses_' + doxie_build.buildstate,mkey,2);

//FCRA Key Move to Built
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::criminal_court_offenses::fcra::@version@::offender_key',
																				'~thor_200::key::criminal_court_offenses::fcra::'+filedate+'::offender_key',mfcrakey);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::corrections::fcra::court_offenses_'+ doxie_build.buildstate
																						,'~thor_data400::key::life_eir::fcra::'+filedate+'::court_offenses'
																						,mv_court_offenses);

postkey := sequential(
			fileservices.clearsuperfile('~thor_data400::base::corrections_court_offenses_' + doxie_build.buildstate + '_BUILT'),
			fileservices.addsuperfile('~thor_data400::base::corrections_court_offenses_' + doxie_build.buildstate + '_BUILT','~thor_data400::base::corrections_court_offenses_' + doxie_build.buildstate + '_BUILDING',0,true),
			fileservices.clearsuperfile('~thor_data400::base::corrections_court_offenses_' + doxie_build.buildstate + '_BUILDING')
			);
			
return if (nothor(fileservices.getsuperfilesubname('~thor_data400::base::corrections_court_offenses_' + doxie_build.buildstate + '_BUILT',1) = fileservices.getsuperfilesubname('~thor_data400::base::corrections_court_offenses_' + doxie_build.buildstate,1)),
			output('BASE = BUILT, nothing done for court offenses.'),
			sequential(prekey,key,fcra_key,bk_court_offenses,mkey,mfcrakey,mv_court_offenses,postkey));
end;