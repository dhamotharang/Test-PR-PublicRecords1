import Ingenix_natlprof,text_search,RoxieKeybuild;

export BWR_Build_Sanction_Boolean(string filedate) := function

info := Text_Search.FileName_Info_Instance('~THOR_DATA400', 'ingenix::sanctions', filedate);

ret := Ingenix_Natlprof.Convert_Ingenix_Func : persist('~thor_data400::persist::Ingenix::sanctions::boolean');


inlkeyname := '~thor_data400::key::Ingenix::'+filedate+'::docref.sancid';
inskeyname := '~thor_data400::key::Ingenix::qa::docref.sancid';

Roxiekeybuild.Mac_SK_BuildProcess_v2_local(
												Ingenix_NatlProf.Key_Boolean_Map,
												'superkey',
												inlkeyname,
												build_key	
												);

retval := sequential(
									Text_Search.Build_From_DocSeg_Records(ret,info),
									build_key,
									Text_Search.Boolean_Move_To_QA(inskeyname,inlkeyname),
									fileservices.deletelogicalfile('~thor_data400::persist::Ingenix::sanctions::boolean')
									
									);

return retval;

end;