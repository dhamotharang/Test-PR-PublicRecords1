import doxie_build,ut,RoxieKeyBuild;
export proc_build_DOC_court_offenses_key(string filedate) := 
function

prekey := if (fileservices.getsuperfilesubcount('~thor_data400::base::corrections_court_offenses_' + doxie_build.buildstate + '_BUILDING') > 0,
		output('Nothing added to BUILDING superfile for court offenses'),
		fileservices.addsuperfile('~thor_data400::base::corrections_court_offenses_' + doxie_build.buildstate + '_BUILDING','~thor_data400::base::corrections_court_offenses_' + doxie_build.buildstate,0,true)
		);
		
//ut.MAC_SK_BuildProcess(doxie_build.key_prep_courtoffenses,'~thor_data400::key::corrections_court_offenses_' + doxie_build.buildstate,'~thor_data400::key::corrections_court_offenses_' + doxie_build.buildstate,key,2)
RoxieKeyBuild.Mac_SK_BuildProcess_Local(doxie_build.key_prep_courtoffenses,'~thor_data400::key::corrections_court_offenses::'+filedate+'::' + doxie_build.buildstate,'~thor_data400::key::corrections_court_offenses_' + doxie_build.buildstate,key,2);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::corrections_court_offenses::'+filedate+'::' + doxie_build.buildstate,'~thor_data400::key::corrections_court_offenses_' + doxie_build.buildstate,mkey,2);

postkey := sequential(
			fileservices.clearsuperfile('~thor_data400::base::corrections_court_offenses_' + doxie_build.buildstate + '_BUILT'),
			fileservices.addsuperfile('~thor_data400::base::corrections_court_offenses_' + doxie_build.buildstate + '_BUILT','~thor_data400::base::corrections_court_offenses_' + doxie_build.buildstate + '_BUILDING',0,true),
			fileservices.clearsuperfile('~thor_data400::base::corrections_court_offenses_' + doxie_build.buildstate + '_BUILDING')
			);
			
return if (fileservices.getsuperfilesubname('~thor_data400::base::corrections_court_offenses_' + doxie_build.buildstate + '_BUILT',1) = fileservices.getsuperfilesubname('~thor_data400::base::corrections_court_offenses_' + doxie_build.buildstate,1),
			output('BASE = BUILT, nothing done for court offenses.'),
			sequential(prekey,key,mkey,postkey));
end;