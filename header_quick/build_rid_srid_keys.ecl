import header,doxie,RoxieKeyBuild,dx_Header;
export build_rid_srid_keys(string filedate='00000000') := function

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_Header_rid(true,false),'~thor_data400::key::header.rid_fheader','~thor_data400::key::header::'+filedate+'::rid_fheader',rid_only);
RoxieKeybuild.MAC_build_logical (dx_Header.key_Rid_SrcID(0, TRUE, FALSE),header.data_key_rid_SrcID (TRUE, FALSE),'~thor_data400::key::header_rid_srid_fheader','~thor_data400::key::header::'+filedate+'::rid_srid_fheader',bld_rid_srid_key);

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