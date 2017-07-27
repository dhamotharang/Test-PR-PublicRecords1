import RoxieKeyBuild,Patriot;

export Proc_Build_Patriot_Keys(string filedate) := 
function

RoxieKeyBuild.MAC_SK_BuildProcess_Local(patriot.key_prep_patriot_file,'~thor_Data400::key::patriot::'+filedate+'::File_Full','~thor_Data400::key::patriot_File_Full',do4,2,true);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_Local(patriot.key_did_patriot_file,'~thor_data400::key::patriot_did_file','~thor_Data400::key::patriot::'+filedate+'::did_file',do5);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_Local(patriot.key_bdid_patriot_file,'~thor_data400::key::patriot_bdid_file','~thor_Data400::key::patriot::'+filedate+'::bdid_file',do6);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_Local(patriot.key_patriot_key,'~thor_data400::key::patriot_key','~thor_Data400::key::patriot::'+filedate+'::patriot_key',do6half,true);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_Local(patriot.Key_Phonetic_Name,'~thor_Data400::key::patriot_phoneticnames','~thor_Data400::key::patriot::'+filedate+'::phoneticnames',do7, true);

return parallel(do4,do5,do6,do6half,do7);
	
end;
