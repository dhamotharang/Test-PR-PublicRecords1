import doxie_build,ut,RoxieKeybuild;
export proc_build_DOC_punishment_key(string filedate) := 
function

prekey := if (fileservices.getsuperfilesubcount('~thor_data400::base::corrections_punishment_' + doxie_build.buildstate + '_BUILDING') > 0,
		output('Nothing Added to BUILDING superfile for Punishments'),
		sequential(
			fileservices.clearsuperfile('~thor_data400::base::corrections_punishment_' + doxie_build.buildstate + '_BUILDING'),
			fileservices.addsuperfile('~thor_data400::base::corrections_punishment_' + doxie_build.buildstate + '_BUILDING','~thor_data400::base::corrections_punishment_' + doxie_build.buildstate,0,true)
		));
	
//ut.MAC_SK_BuildProcess(doxie_build.key_prep_punishment,'~thor_data400::key::corrections_punishment_' + doxie_build.buildstate,'~thor_data400::key::corrections_punishment_' + doxie_build.buildstate,keyout,2)
Roxiekeybuild.Mac_SK_BuildProcess_Local(doxie_build.key_prep_punishment,'~thor_data400::key::corrections_punishment::'+filedate+'::' + doxie_build.buildstate,'~thor_data400::key::corrections_punishment_' + doxie_build.buildstate,keyout,2);
Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::corrections_punishment::'+filedate+'::' + doxie_build.buildstate,'~thor_data400::key::corrections_punishment_' + doxie_build.buildstate,mkeyout,2);

postkey := sequential(
		fileservices.clearsuperfile('~thor_Data400::base::corrections_punishment_' + doxie_build.buildstate + '_BUILT'),
		fileservices.addsuperfile('~thor_Data400::base::corrections_punishment_' + doxie_build.buildstate + '_BUILT','~thor_Data400::base::corrections_punishment_' + doxie_build.buildstate + '_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_Data400::base::corrections_punishment_' + doxie_build.buildstate + '_BUILDING')
		);

return if (fileservices.getsuperfilesubname('~thor_data400::base::corrections_punishment_' + doxie_build.buildstate + '_BUILT',1) = fileservices.getsuperfilesubname('~thor_data400::base::corrections_punishment_' + doxie_build.buildstate,1),
			output('BUILT = BASE, nothing done for Punishments'),
			sequential(prekey,keyout,mkeyout,postkey));
			
end;