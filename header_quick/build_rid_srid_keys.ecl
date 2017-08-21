import header,doxie,RoxieKeyBuild;
export build_rid_srid_keys(string filedate='00000000') := function

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_Header_rid(true,false),'~thor_data400::key::header.rid_fheader','~thor_data400::key::header::'+filedate+'::rid_fheader',rid_only);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(header.Key_Rid_SrcID_Prep(true,false),'~thor_data400::key::header_rid_srid_fheader','~thor_data400::key::header::'+filedate+'::rid_srid_fheader',bld_rid_srid_key);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.rid_fheader','~thor_data400::key::header::'+filedate+'::rid_fheader',mv_rid);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header_rid_srid_fheader','~thor_data400::key::header::'+filedate+'::rid_srid_fheader',mv_rid_srid_key);

header_key_builds := sequential(
																parallel(
																		rid_only
																		,bld_rid_srid_key
																		)
																,parallel(
																		mv_rid
																		,mv_rid_srid_key
																		)
																);

return header_key_builds;

end;