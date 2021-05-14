import txbus,text_search,RoxieKeybuild;

export BWR_Build_Txbus_Boolean(string filedate) := function

info := Text_Search.FileName_Info_Instance('~THOR_DATA400', 'TXBUS', filedate);

ret := txbus.Convert_txbus_Func : persist('~thor_data400::persist::txbus::boolean');

/* DF-28348
inlkeyname := '~thor_data400::key::txbus::'+filedate+'::docref.taxpayernumber';
inskeyname := '~thor_data400::key::txbus::qa::docref.taxpayernumber';

Roxiekeybuild.Mac_SK_BuildProcess_v2_local(
												txbus.Key_Boolean_Map,
												'superkey',
												inlkeyname,
												build_key	
												);
*/
retval := sequential(
									Text_Search.Build_From_DocSeg_Records(ret,info),
									//build_key, //DF-28348
									//Text_Search.Boolean_Move_To_QA(inskeyname,inlkeyname),
									fileservices.deletelogicalfile('~thor_data400::persist::txbus::boolean')
									
									);

return retval;

end;