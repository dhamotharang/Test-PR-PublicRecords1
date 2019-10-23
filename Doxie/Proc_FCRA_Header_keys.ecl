import header,address,lssi,doxie_build,ut,RoxieKeyBuild,business_risk,doxie_files,AddrFraud,aid_build;

export Proc_FCRA_Header_keys(string filedate) := function

//Build keys
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_FCRA_header,'~thor_data400::key::fcra::header','~thor_data400::key::fcra::header::'+filedate+'::data',fcra_head_data);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_FCRA_AptBuildings_pre(filedate), '~thor_data400::key::fcra::hdr_apt_bldgs','~thor_data400::key::fcra::header::'+filedate+'::apt_bldgs',fcra_apt_blg);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_FCRA_EN_AptBuildings_pre(filedate), '~thor_data400::key::fcra::en_hdr_apt_bldgs','~thor_data400::key::fcra::header::'+filedate+'::en_apt_bldgs',fcra_en_apt_blg);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_FCRA_Header_Address ,'~thor_data400::key::fcra::header_address','~thor_data400::key::fcra::header::'+filedate+'::address',fcra_address_payload);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_FCRA_max_dt_last_seen,'~thor_data400::key::fcra::max_dt_last_seen','~thor_data400::key::fcra::header::'+filedate+'::max_dt_last_seen',fcra_max_dt_last_seen);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_FCRA_legacy_ssn,'~thor_data400::key::fcra::header.legacy_ssn','~thor_data400::key::fcra::header::'+filedate+'::legacy_ssn',fcra_legacy_ssn);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_DID_SSN_Date(true), '~thor_data400::key::fcra::header.did.ssn.date','~thor_data400::key::fcra::header::'+filedate+'::did.ssn.date', fcra_ssn_date);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(header.key_addr_hist(TRUE)	,'~thor_data400::key::fcra::header::address_rank','~thor_data400::key::fcra::header::'+filedate+'::address_rank',fcra_address_rank);
//Move to Built
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::fcra::header','~thor_data400::key::fcra::header::'+filedate+'::data',mv_fcra_data);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::fcra::hdr_apt_bldgs','~thor_data400::key::fcra::header::'+filedate+'::apt_bldgs',mv_fcra_apt);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::fcra::en_hdr_apt_bldgs','~thor_data400::key::fcra::header::'+filedate+'::en_apt_bldgs',mv_fcra_en_apt);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::fcra::header_address','~thor_data400::key::fcra::header::'+filedate+'::address',mv_fcra_address_payload);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::fcra::max_dt_last_seen','~thor_data400::key::fcra::header::'+filedate+'::max_dt_last_seen',mv_fcra_max_dt_last_seen);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::fcra::header.legacy_ssn','~thor_data400::key::fcra::header::'+filedate+'::legacy_ssn',mv_fcra_legacy_ssn);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::fcra::header.did.ssn.date','~thor_data400::key::fcra::header::'+filedate+'::did.ssn.date',mv_fcra_did_ssn);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::fcra::header::address_rank','~thor_data400::key::fcra::header::'+filedate+'::address_rank',mv_fcra_address_rank);

header_key_builds := sequential(
																fcra_head_data
																,fcra_apt_blg
																,fcra_en_apt_blg
																,fcra_address_payload
																,fcra_max_dt_last_seen
																,fcra_legacy_ssn
																,fcra_ssn_date
                                ,fcra_address_rank
																,parallel(
																		mv_fcra_data
																		,mv_fcra_apt
																		,mv_fcra_en_apt
																		,mv_fcra_address_payload
																		,mv_fcra_max_dt_last_seen
																		,mv_fcra_legacy_ssn
																		,mv_fcra_did_ssn
                                    ,mv_fcra_address_rank
																		)
																);

return header_key_builds;

end;