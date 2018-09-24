/*2011-05-02T22:11:45Z (Cecelie Guyton)
test 76599
*/
import doxie, RoxieKeyBuild, ut, header,infutor;

filedate := trim(Infutor._config.get_cversion_dev, all);

/* Build Keys */
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Infutor.Key_Header_Infutor_Knowx,'~thor_data400::key::header.adl.infutor.knowx','~thor_data400::key::header::'+filedate+'::adl.infutor.knowx',hdr_if_knowx);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Header.Key_Teaser_cnsmr_did,'~thor_data400::key::header.teaser_did','~thor_data400::key::header::'+filedate+'::teaser_did',teaser_did);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Header.Key_Teaser_cnsmr_search,'~thor_data400::key::header.teaser_search','~thor_data400::key::header::'+filedate+'::teaser_search',teaser_search);

/* Move Keys */
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.adl.infutor.knowx','~thor_data400::key::header::'+filedate+'::adl.infutor.knowx',mv_hdr_if_knowx);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.teaser_did','~thor_data400::key::header::'+filedate+'::teaser_did',mv_teaser_did);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.teaser_search','~thor_data400::key::header::'+filedate+'::teaser_search',mv_teaser_search);

ut.MAC_SK_Move_v2('~thor_data400::key::header.adl.infutor.knowx', 'Q', mv_hdr_if_knowx_qa);
ut.MAC_SK_Move_v2('~thor_data400::key::header.teaser_did', 'Q', mv_hdr_did_qa);
ut.MAC_SK_Move_v2('~thor_data400::key::header.teaser_search', 'Q', mv_hdr_search_qa);


export proc_build_key_knowx := sequential(
									parallel(hdr_if_knowx, teaser_did, teaser_search), 
									parallel(mv_hdr_if_knowx, mv_teaser_did, mv_teaser_search), 
									parallel(mv_hdr_if_knowx_qa, mv_hdr_did_qa, mv_hdr_search_qa),
									RoxieKeybuild.updateversion('InfutorKeys',filedate,'goulmi01@lexisnexisrisk.com',,'N|B')
									);
