import ut,doxie_build,RoxieKeyBuild;
export proc_build_doc_offenses_key(string filedate) := 
function

prekey := if (fileservices.getsuperfilesubcount('~thor_Data400::base::corrections_offenses_' + doxie_build.buildstate + '_BUILDING') > 0,
		output('Nothing added to Offenses BUILDING file.'),
		fileservices.addsuperfile('~thor_data400::base::corrections_offenses_' + doxie_build.buildstate + '_BUILDING','~thor_data400::base::corrections_offenses_' + doxie_build.buildstate,0,true));
		
//ut.MAC_SK_BuildProcess(doxie_build.key_prep_offenses,'~thor_Data400::key::corrections_offenses_' + doxie_build.buildstate,'~thor_Data400::key::corrections_offenses_' + doxie_build.buildstate,key,2)
RoxieKeyBuild.MAC_SK_BuildProcess_Local(doxie_build.key_prep_offenses,'~thor_Data400::key::corrections_offenses::'+filedate+'::' + doxie_build.buildstate,'~thor_Data400::key::corrections_offenses_' + doxie_build.buildstate,key,2);

RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_Data400::key::corrections_offenses::'+filedate+'::' + doxie_build.buildstate,'~thor_Data400::key::corrections_offenses_' + doxie_build.buildstate,mkey,2);


postkey := sequential(
		fileservices.clearsuperfile('~thor_Data400::base::corrections_offenses_' + doxie_build.buildstate + '_BUILT'),
		fileservices.addsuperfile('~thor_Data400::base::corrections_offenses_' + doxie_build.buildstate + '_BUILT','~thor_Data400::base::corrections_offenses_' + doxie_build.buildstate + '_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_Data400::base::corrections_offenses_' + doxie_build.buildstate + '_BUILDING')
		);
		
return if(fileservices.getsuperfilesubname('~thor_Data400::base::corrections_offenses_' + doxie_build.buildstate + '_BUILT',1) = fileservices.getsuperfilesubname('~thor_Data400::base::corrections_offenses_' + doxie_build.buildstate,1),
			output('BASE = BUILT, nothing done for offenses'),
			sequential(prekey,key,mkey,postkey));
			
end;
			
