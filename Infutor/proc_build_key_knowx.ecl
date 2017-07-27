

/* //Build Keys - Index syntax taken from doxie.key_header */
Key_indexed := INDEX(infutor_header, {unsigned6 s_did := did}, {srtcmbFILE}, '~thor_data400::key::header.adl.infutor.knowx_' + doxie.version_superkey, OPT);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_indexed,'','~thor_data400::key::header::'+Infutor.version_dev+'::adl.infutor.knowx',hdr_if_knowx);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.adl.infutor.knowx','~thor_data400::key::header::'+Infutor.version_dev+'::adl.infutor.knowx',mv_hdr_if_knowx);

ut.MAC_SK_Move_v2('~thor_data400::key::header.adl.infutor.knowx', 'Q', mv_hdr_if_knowx_qa);

release := RoxieKeybuild.updateversion('InfutorKeys',Infutor.version_dev,'cguyton@seisint.com');

export proc_build_key_knowx := sequential(hdr_if_knowx,mv_hdr_if_knowx,mv_hdr_if_knowx_qa, release);
