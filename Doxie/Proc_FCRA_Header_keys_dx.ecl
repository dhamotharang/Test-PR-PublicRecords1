IMPORT dx_Header, header, RoxieKeyBuild, data_services;

//this procedure is for FCRA only:
unsigned1 data_class := data_services.data_env.iFCRA;

EXPORT Proc_FCRA_Header_keys_dx(string filedate) := FUNCTION

dsname := dx_Header.Constants.DataSetName;
// prefix := '~thor_data400::key::' + dsname + '::fcra::header::' + filedate + '::';
prefix := '~thor_data400::key::fcra::header::'+ filedate + '::';

//logical file names
name_header := prefix + 'data';
name_aptbuildings := prefix + 'apt_bldgs';
name_aptbuildings_en := prefix + 'en_apt_bldgs';
name_header_address := prefix + 'address';
name_max_dt_last_seen := prefix + 'max_dt_last_seen';
name_legacy_ssn := prefix + 'legacy_ssn';
name_did_ssn := prefix + 'did.ssn.date';
name_addr_hist := prefix + 'address_rank';
name_ssn := '~thor_data400::key::fcra::header_wild::'+ filedate + '::ssn.did';

//Build keys
RoxieKeybuild.MAC_build_logical(dx_Header.key_header(data_class), header.data_key_header_fcra, dx_Header.names('').i_header_fcra, name_header, fcra_head_data);
RoxieKeybuild.MAC_build_logical(dx_Header.key_AptBuildings(data_class), header.data_key_AptBuildings_fcra(filedate), dx_Header.names('').i_aptbuildings_fcra, name_aptbuildings, fcra_apt_blg);
RoxieKeybuild.MAC_build_logical(dx_Header.key_AptBuildings_EN(data_class), header.data_key_AptBuildings_fcra_en(filedate), dx_Header.names('').i_aptbuildings_fcra_en, name_aptbuildings_en, fcra_en_apt_blg);
RoxieKeybuild.MAC_build_logical(dx_Header.key_header_address(data_class), header.data_key_header_address_fcra, dx_Header.names('').i_header_address_fcra, name_header_address, fcra_address_payload);
RoxieKeybuild.MAC_build_logical(dx_Header.key_max_dt_last_seen(data_class), header.data_key_max_dt_last_seen_fcra, dx_Header.names('').i_max_date_fcra, name_max_dt_last_seen, fcra_max_dt_last_seen);
RoxieKeybuild.MAC_build_logical(dx_Header.key_legacy_ssn(data_class), header.data_key_legacy_ssn_fcra, dx_Header.names('').i_legacy_ssn_fcra, name_legacy_ssn, fcra_legacy_ssn);
RoxieKeybuild.MAC_build_logical(dx_Header.key_DID_SSN_date(data_class), header.data_key_DID_SSN_date(data_class), dx_Header.names('').i_did_ssn_date_fcra, name_did_ssn, fcra_ssn_date);
RoxieKeybuild.MAC_build_logical(dx_Header.key_addr_hist(data_class), header.data_key_addr_hist(data_class), dx_Header.names('').i_addr_hist_fcra, name_addr_hist, fcra_address_rank);
RoxieKeybuild.MAC_build_logical(dx_Header.key_wild_ssn(data_class), header.data_key_wild_SSN(data_class), dx_Header.names('').i_wild_ssn_fcra, name_ssn, fcra_ssn);

//Move to Built
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(dx_Header.names('').i_header_fcra, name_header, mv_fcra_data);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(dx_Header.names('').i_aptbuildings_fcra, name_aptbuildings, mv_fcra_apt);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(dx_Header.names('').i_aptbuildings_fcra_en, name_aptbuildings_en, mv_fcra_en_apt);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(dx_Header.names('').i_header_address_fcra, name_header_address, mv_fcra_address_payload);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(dx_Header.names('').i_max_date_fcra, name_max_dt_last_seen, mv_fcra_max_dt_last_seen);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(dx_Header.names('').i_legacy_ssn_fcra, name_legacy_ssn, mv_fcra_legacy_ssn);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(dx_Header.names('').i_did_ssn_date_fcra, name_did_ssn, mv_fcra_did_ssn);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(dx_Header.names('').i_addr_hist_fcra, name_addr_hist, mv_fcra_address_rank);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(dx_Header.names('').i_wild_ssn_fcra, name_ssn, mv_fcra_ssn);

header_key_builds := SEQUENTIAL(
						fcra_head_data
						,fcra_apt_blg
						,fcra_en_apt_blg
						,fcra_address_payload
						,fcra_max_dt_last_seen
						,fcra_legacy_ssn
						,fcra_ssn_date
                    	,fcra_address_rank
						,fcra_ssn
						,PARALLEL(
							mv_fcra_data
							,mv_fcra_apt
							,mv_fcra_en_apt
							,mv_fcra_address_payload
							,mv_fcra_max_dt_last_seen
							,mv_fcra_legacy_ssn
							,mv_fcra_did_ssn
							,mv_fcra_address_rank
							,mv_fcra_ssn
							)
						);

RETURN header_key_builds;

END;
