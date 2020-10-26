import RoxieKeyBuild,Patriot;

export Proc_Build_Patriot_Keys(string filedate) := 
function

RoxieKeyBuild.MAC_SK_BuildProcess_Local(patriot.key_prep_patriot_file,'~thor_Data400::key::patriot::'+filedate+'::File_Full','~thor_Data400::key::patriot_File_Full',do4,2,true);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_Local(patriot.key_did_patriot_file,'~thor_data400::key::patriot_did_file','~thor_Data400::key::patriot::'+filedate+'::did_file',do5);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_Local(patriot.key_bdid_patriot_file,'~thor_data400::key::patriot_bdid_file','~thor_Data400::key::patriot::'+filedate+'::bdid_file',do6);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_Local(patriot.key_patriot_key,'~thor_data400::key::patriot_key','~thor_Data400::key::patriot::'+filedate+'::patriot_key',do6half,true);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_Local(patriot.Key_Phonetic_Name,'~thor_Data400::key::patriot_phoneticnames','~thor_Data400::key::patriot::'+filedate+'::phoneticnames',do7, true);

//DF-28226 Build Delta_Rid key for  thor_data400::in::patriot_file
RoxieKeyBuild.MAC_build_logical($.key_patriot_delta_rid(),$.data_key_patriot_delta_rid,'', '~thor_data400::key::patriot::'+filedate+'::file::delta_rid',do8);
RoxieKeyBuild.MAC_build_logical($.key_baddids_delta_rid(),$.data_key_baddids_delta_rid,'', '~thor_data400::key::patriot::'+filedate+'::baddids::delta_rid',do9);
RoxieKeyBuild.MAC_build_logical($.key_badnames_delta_rid(),$.data_key_badnames_delta_rid,'','~thor_data400::key::patriot::'+filedate+'::annotated_names::delta_rid',do10);

return parallel(do4,do5,do6,do6half,do7,do8,do9,do10);
	
end;
