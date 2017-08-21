import doxie,doxie_build,ut,RoxieKeyBuild, hygenics_search;

export proc_build_DOC_activity_key(string filedate) := function

prekey := if (nothor(fileservices.getsuperfilesubcount('~thor_Data400::base::corrections_activity_' + doxie_build.buildstate + '_BUILDING') > 0),
		output('Nothing added to BUILDING file for Activities'),
		fileservices.addsuperfile('~thor_Data400::base::corrections_activity_' + doxie_build.buildstate + '_BUILDING','~thor_Data400::base::corrections_activity_' + doxie_build.buildstate,0,true)
		);

//Non-FCRA Build Key
RoxieKeyBuild.Mac_SK_BuildProcess_Local(hygenics_crim.key_prep_activity(),
																			'~thor_data400::key::corrections_activity::'+filedate+'::' + doxie_build.buildstate,
																			'~thor_data400::key::corrections_activity_' + doxie_build.buildstate,
																			key,2);

//FCRA Build Key
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(hygenics_crim.key_prep_activity(true)
																			,'~thor_data400::key::corrections::fcra::activity_'+ doxie_build.buildstate + '_' + doxie.Version_SuperKey
																			,'~thor_data400::key::life_eir::fcra::'+filedate+'::court_activity'
																			,bk_activity);

//Non-FCRA Move Build Key
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::corrections_activity::'+filedate+'::' + doxie_build.buildstate,
																			'~thor_data400::key::corrections_activity_' + doxie_build.buildstate,
																			mkey,2);

//FCRA Move Build Key
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::corrections::fcra::activity_'+ doxie_build.buildstate 
																		 ,'~thor_data400::key::life_eir::fcra::'+filedate+'::court_activity'
																		 ,mv_bk_activity);

postkey := sequential(
			fileservices.clearsuperfile('~thor_data400::base::corrections_activity_' + doxie_build.buildstate + '_BUILT'),
			fileservices.addsuperfile('~thor_Data400::base::corrections_activity_' + doxie_build.buildstate + '_BUILT','~thor_Data400::base::corrections_activity_' + doxie_build.buildstate + '_BUILDING',0,true),
			fileservices.clearsuperfile('~thor_Data400::base::corrections_activity_' + doxie_build.buildstate + '_BUILDING')
			);			

return if (nothor(fileservices.getsuperfilesubname('~thor_Data400::base::corrections_activity_' + doxie_build.buildstate + '_BUILT',1) = fileservices.getsuperfilesubname('~thor_Data400::base::corrections_activity_' + doxie_build.buildstate,1)),
			output('BASE = BUILT, nothing done for activities'),
			sequential(prekey,key,bk_activity,mkey,mv_bk_activity,postkey));

end;
