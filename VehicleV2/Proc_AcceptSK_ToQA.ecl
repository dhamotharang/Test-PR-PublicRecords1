/*2014-03-18T22:45:47Z (Ayeesha Kayttala)
bug#147709
*/
import ut, autokey,doxie_build;

ut.mac_sk_move_v2('~thor_data400::key::vehiclev2::linkids','Q',mv_linkids,2);
ut.mac_sk_move_v2('~thor_data400::key::vehiclev2::MAIN_Key',  'Q', mv_main_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::vehiclev2::PARTY_Key', 'Q',mv_party_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::vehiclev2::DID', 'Q', mv_did_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::vehiclev2::BDID',  'Q',mv_bdid_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::vehiclev2::DL_Number',  'Q',mv_DL_number_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::vehiclev2::VIN', 'Q',mv_VIN_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::vehiclev2::Lic_Plate', 'Q',mv_lic_plate_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::vehiclev2::reverse_Lic_Plate', 'Q',mv_reverse_lic_plate_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::vehiclev2::Title_Number','Q',mv_title_number_key);
ut.mac_sk_move_v2('~thor_data400::key::vehiclev2::lic_plate_blur','Q',mv_lic_plate_blur_key);
ut.mac_sk_move_v2('~thor_data400::key::vehicleV2::bocashell_did','Q',mv_bocashell_did_key);
ut.MAC_SK_Move_v2('~thor_data400::key::vehiclev2::vehicles_address','Q',mv_vehicle_addr_key);
ut.mac_sk_move_v2('~thor_data400::key::vehiclev2::PARTY_Key::linkids', 'Q',mv_party_key_linkids, 2);
ut.mac_sk_move_v2('~thor_data400::key::vehiclev2::source_rec_id', 'Q',mv_source_rec_id_key, 2);
// Wildcard vehicle keys
//ut.mac_sk_move_v2('~thor_data400::wc_vehicle::keynameindex_'+doxie_build.buildstate,'Q',mv_name_key);
ut.mac_sk_move_v2('~thor_data400::wc_vehicle::keymodelindex_'+doxie_build.buildstate,'Q',mv_model_key);
ut.mac_sk_move_v2('~thor_data400::Key::wc_vehicle::make','Q',mv_make_key);
ut.mac_sk_move_v2('~thor_data400::key::wc_vehicle::bodystyle','Q',mv_bodystyle_key);

export Proc_AcceptSK_ToQA	:=	parallel( mv_linkids,
																				mv_main_key,mv_party_key, 
																				mv_did_key,mv_bdid_key,
																				mv_DL_number_key,
																				mv_VIN_key,
																				mv_lic_plate_key,
																				mv_reverse_lic_plate_key,
																				mv_title_number_key,
																				mv_lic_plate_blur_key,
																				mv_bocashell_did_key,
																				mv_vehicle_addr_key,
																				/*mv_name_key,*/mv_model_key,
																				mv_party_key_linkids,
																				mv_source_rec_id_key,
																				mv_make_key,
																				mv_bodystyle_key);