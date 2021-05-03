import vehiclev2,text_search,RoxieKeybuild;

export BWR_Build_MV2_Boolean(string filedate) := function

info := Text_Search.FileName_Info_Instance('~THOR_DATA400', 'VEHICLEV2', filedate);

ret := vehiclev2.Convert_MV2_Func : persist('~thor_data400::persist::vehiclev2::boolean');


inlkeyname := '~thor_data400::key::vehiclev2::'+filedate+'::docref.vehkey';
inskeyname := '~thor_data400::key::vehiclev2::qa::docref.vehkey';

Roxiekeybuild.Mac_SK_BuildProcess_v2_local(
												vehiclev2.Key_Boolean_Map,
												'superkey',
												inlkeyname,
												build_key	
												);

retval := sequential(
									Text_Search.Build_From_DocSeg_Records(ret,info),
									//build_key,
									//Text_Search.Boolean_Move_To_QA(inskeyname,inlkeyname),
									fileservices.deletelogicalfile('~thor_data400::persist::vehiclev2::boolean')
									
									);

return retval;

end;