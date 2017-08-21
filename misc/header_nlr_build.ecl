
import header,ut,RoxieKeyBuild;
import header_quick, experiancred;

// ut.mac_create_superkey_files('~thor_data400::key::header_nlr::did.rid');

string filedate:='20101209';

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(header.Key_nlr_payload,'~thor_data400::key::header_nlr::did.rid','~thor_data400::key::header_nlr::'+filedate+'::did.rid',build_nlr);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header_nlr::did.rid','~thor_data400::key::header_nlr::'+filedate+'::did.rid',move_tobuilt_nlr);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::header_nlr::did.rid','Q',move_toqa_nlr);
sequential(build_nlr, move_tobuilt_nlr, move_toqa_nlr);

/* temp stuff to rebuild test indexes follows: */

hdr_in 	:= Header.file_headers(did%10=1 and src in ['EQ','EN']);
eq_in 	:= header_quick.file_header_quick(did<>0 and did%10=1);
en_in 	:= Experiancred.files.base_file_out(did<>0 and did%10=1);
	
buildINDEX (hdr_in, {did}, {hdr_in},'~thor_data400::key::temp_hdr_in::did') ;
buildINDEX (eq_in, {did}, {eq_in},'~thor_data400::key::temp_eq_in::did');
buildINDEX (en_in, {did}, {en_in},'~thor_data400::key::temp_en_in::did');