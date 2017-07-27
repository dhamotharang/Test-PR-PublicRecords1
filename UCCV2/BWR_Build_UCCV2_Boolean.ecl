import UCCV2,text_search,RoxieKeybuild;

export BWR_Build_UCCV2_Boolean(string filedate) := function

info := Text_Search.FileName_Info_Instance('~THOR_DATA400', 'UCCV2', filedate);

ret := uccv2.Convert_uccv2_Func : persist('~thor_data400::persist::uccv2::boolean');


inlkeyname := '~thor_data400::key::uccv2::'+filedate+'::docref.tmsid';
inskeyname := '~thor_data400::key::uccv2::qa::docref.tmsid';

Roxiekeybuild.Mac_SK_BuildProcess_v2_local(
												uccv2.Key_Boolean_Map,
												'superkey',
												inlkeyname,
												build_key	
												);

retval := sequential(
									Text_Search.Build_From_DocSeg_Records(ret,info),
									build_key,
									Text_Search.Boolean_Move_To_QA(inskeyname,inlkeyname),
									fileservices.deletelogicalfile('~thor_data400::persist::uccv2::boolean')
									
									);

return retval;

end;