import prof_licensev2,text_search,RoxieKeybuild;

export BWR_Proflic_Boolean_Build(string filedate) := function

info := Text_Search.FileName_Info_Instance('~THOR_DATA400', 'prolic', filedate);

ret := prof_licensev2.Convert_proflic_Func : persist('~thor_data400::persist::prolic::boolean');


inlkeyname := '~thor_data400::key::prolic::'+filedate+'::docref.seq';
inskeyname := '~thor_data400::key::prolic::qa::docref.seq';

Roxiekeybuild.Mac_SK_BuildProcess_v2_local(
												Prof_Licensev2.Key_Boolean_Map,
												'superkey',
												inlkeyname,
												build_key	
												);

retval := sequential(
									Text_Search.Build_From_DocSeg_Records(ret,info),
									build_key,
									Text_Search.Boolean_Move_To_QA(inskeyname,inlkeyname),
									fileservices.deletelogicalfile('~thor_data400::persist::prolic::boolean')
									
									);

return retval;

end;