import Ingenix_natlprof,text_search,RoxieKeybuild;

export BWR_build_provider_Boolean(string filedate) := function

info := Text_Search.FileName_Info_Instance('~THOR_DATA400', 'ingenix::provider', filedate);

ret := Ingenix_Natlprof.Convert_Ingenix_Providers_Func : persist('~thor_data400::persist::Ingenix::provider::boolean');



inlkeyname := '~thor_data400::key::Ingenix::'+filedate+'::docref.providerid';
inskeyname := '~thor_data400::key::Ingenix::qa::docref.providerid';



Roxiekeybuild.Mac_SK_BuildProcess_v2_local(
												Ingenix_NatlProf.Key_Boolean_provider_Map,
												'superkey',
												inlkeyname,
												build_key	
												);


retval := sequential(
									Text_Search.Build_From_DocSeg_Records(ret,info),
									build_key,
									Text_Search.Boolean_Move_To_QA(inskeyname,inlkeyname),
									fileservices.deletelogicalfile('~thor_data400::persist::Ingenix::provider::boolean')
									
									);

return retval;

end;