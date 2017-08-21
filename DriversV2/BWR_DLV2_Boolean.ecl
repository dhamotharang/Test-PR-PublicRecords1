import Text_Search,Driversv2,RoxieKeybuild;

export BWR_DLV2_Boolean(string filedate) := function

info := Text_Search.FileName_Info_Instance('~THOR_DATA400', 'DLV2', filedate);

ret := driversv2.Convert_DLV2_Func : persist('~thor_data400::persist::dlv2::boolean');

inlkeyname := '~thor_data400::key::dlv2::'+filedate+'::docref.dlseq';
inskeyname := '~thor_data400::key::dlv2::qa::docref.dlseq';

Roxiekeybuild.Mac_SK_BuildProcess_v2_local(
												driversv2.Key_Boolean_Map,
												'superkey',
												inlkeyname,
												build_key	
												);

retval := sequential(
									Text_Search.Build_From_DocSeg_Records(ret,info),
									build_key,
									Text_Search.Boolean_Move_To_QA(inskeyname,inlkeyname),
									fileservices.deletelogicalfile('~thor_data400::persist::dlv2::boolean')
									);

return retval;

end;