import FCC,text_search,RoxieKeybuild;

export BWR_Build_FCC_Boolean(string filedate) := function

info := Text_Search.FileName_Info_Instance('~THOR_DATA400', 'FCC', filedate);

ret := FCC.Convert_FCC_Func : persist('~thor_data400::persist::FCC::boolean');


inlkeyname := '~thor_data400::key::FCC::'+filedate+'::docref';
inskeyname := '~thor_data400::key::FCC::qa::docref';

Roxiekeybuild.Mac_SK_BuildProcess_v2_local(
												FCC.Key_Boolean_Map,
												'superkey',
												inlkeyname,
												build_key	
												);

retval := sequential(
									Text_Search.Build_From_DocSeg_Records(ret,info),
									build_key,
									Text_Search.Boolean_Move_To_QA(inskeyname,inlkeyname),
									fileservices.deletelogicalfile('~thor_data400::persist::FCC::boolean')
									
									);

return retval;

end;