import dea,text_search,RoxieKeybuild;

export BWR_dea_build_Boolean(string filedate) := function

info := Text_Search.FileName_Info_Instance('~THOR_DATA400', 'dea', filedate);

ret := dea.Convert_dea_Func : persist('~thor_data400::persist::dea::boolean');


inlkeyname := '~thor_data400::key::dea::'+filedate+'::docref.regnumber';
inskeyname := '~thor_data400::key::dea::qa::docref.regnumber';

Roxiekeybuild.Mac_SK_BuildProcess_v2_local(
												dea.Key_Boolean_Map,
												'superkey',
												inlkeyname,
												build_key	
												);

retval := sequential(
									Text_Search.Build_From_DocSeg_Records(ret,info),
									//build_key,
									//Text_Search.Boolean_Move_To_QA(inskeyname,inlkeyname),
									fileservices.deletelogicalfile('~thor_data400::persist::dea::boolean')
									
									);

return retval;

end;