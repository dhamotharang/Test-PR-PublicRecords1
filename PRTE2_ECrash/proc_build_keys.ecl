IMPORT $;
IMPORT ut,RoxieKeyBuild,AutoKeyB2,PRTE,_control, PRTE,PRTE2_Common, dops, orbit3, prte2;

EXPORT proc_build_keys(string version) := FUNCTION

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrash0,															Constants.KeyName_ecrash+ '::@version@::ecrash0', 	Constants.KeyName_ecrash+ '::' + version + '::ecrash0',	 build_key_ecrash0);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrash1,  														Constants.KeyName_ecrash+ '::@version@::ecrash1',		Constants.KeyName_ecrash+ '::' + version + '::ecrash1',	 build_key_ecrash1);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrash2v, 														Constants.KeyName_ecrash+ '::@version@::ecrash2v', 	Constants.KeyName_ecrash+ '::' + version + '::ecrash2v',	 build_key_ecrash2v);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrash3v, 														Constants.KeyName_ecrash+ '::@version@::ecrash3v',	Constants.KeyName_ecrash+ '::' + version + '::ecrash3v',  build_key_ecrash3v);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrash5,  														Constants.KeyName_ecrash+ '::@version@::ecrash5', 	Constants.KeyName_ecrash+ '::' + version + '::ecrash5',	 build_key_ecrash5);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrash6,  														Constants.KeyName_ecrash+ '::@version@::ecrash6', 	Constants.KeyName_ecrash+ '::' + version + '::ecrash6',	 build_key_ecrash6);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrash7,  														Constants.KeyName_ecrash+ '::@version@::ecrash7', 	Constants.KeyName_ecrash+ '::' + version + '::ecrash7', 	 build_key_ecrash7);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrash8,  														Constants.KeyName_ecrash+ '::@version@::ecrash8', 	Constants.KeyName_ecrash+ '::' + version + '::ecrash8', 	 build_key_ecrash8);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrashv2analytics_byagencyid, 				Constants.KeyName_ecrashv2+ '::@version@::analytics_byagencyid', 	    Constants.KeyName_ecrashv2 + '::'+ version + '::analytics_byagencyid', 			build_key_ecrashv2analytics_byagencyid);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrashv2analytics_bycollisiontype, 	Constants.KeyName_ecrashv2+ '::@version@::analytics_bycollisiontype', Constants.KeyName_ecrashv2 + '::'+ version + '::analytics_bycollisiontype', 	build_key_ecrashv2analytics_bycollisiontype);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrashv2analytics_bydow,  						Constants.KeyName_ecrashv2+ '::@version@::analytics_bydow',						Constants.KeyName_ecrashv2 + '::'+ version + '::analytics_bydow', 						build_key_ecrashv2analytics_bydow);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrashv2analytics_byhod,							Constants.KeyName_ecrashv2+ '::@version@::analytics_byhod',						Constants.KeyName_ecrashv2 + '::'+ version + '::analytics_byhod', 						build_key_ecrashv2analytics_byhod);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrashv2analytics_byinter, 					Constants.KeyName_ecrashv2+ '::@version@::analytics_byinter', 				Constants.KeyName_ecrashv2 + '::'+ version + '::analytics_byinter', 					build_key_ecrashv2analytics_byinter);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrashv2analytics_bymoy,							Constants.KeyName_ecrashv2+ '::@version@::analytics_bymoy',						Constants.KeyName_ecrashv2 + '::'+ version + '::analytics_bymoy', 						build_key_ecrashv2analytics_bymoy);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrashv2_accnbr,											Constants.KeyName_ecrashv2+ '::@version@::accnbr',										Constants.KeyName_ecrashv2 + '::'+ version + '::accnbr', 										build_key_ecrashv2_accnbr);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrashv2_accnbrv1,										Constants.KeyName_ecrashv2+ '::@version@::accnbrv1',									Constants.KeyName_ecrashv2 + '::'+ version + '::accnbrv1', 									build_key_ecrashv2_accnbrv1);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrashv2_agencyid_sentdate,					Constants.KeyName_ecrashv2+ '::@version@::agencyid_sentdate',					Constants.KeyName_ecrashv2 + '::'+ version + '::agencyid_sentdate', 					build_key_ecrashv2_agencyid_sentdate);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrashv2_bdid,												Constants.KeyName_ecrashv2+ '::@version@::bdid',											Constants.KeyName_ecrashv2 + '::'+ version + '::bdid', 											build_key_ecrashv2_bdid);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrashv2_did,												Constants.KeyName_ecrashv2+ '::@version@::did',												Constants.KeyName_ecrashv2 + '::'+ version + '::did', 												build_key_ecrashv2_did);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrashv2_dlnbr,											Constants.KeyName_ecrashv2+ '::@version@::dlnbr',											Constants.KeyName_ecrashv2 + '::'+ version + '::dlnbr', 											build_key_ecrashv2_dlnbr);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrashv2_dol,												Constants.KeyName_ecrashv2+ '::@version@::dol',												Constants.KeyName_ecrashv2 + '::'+ version + '::dol', 												build_key_ecrashv2_dol);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.Key_ecrashv2_LastName,										Constants.KeyName_ecrashv2+ '::@version@::lastname_state',						Constants.KeyName_ecrashv2 + '::'+ version + '::lastname_state', 						build_key_ecrashv2_lastname_state);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrashv2_photoid,										Constants.KeyName_ecrashv2+ '::@version@::photoid',										Constants.KeyName_ecrashv2 + '::'+ version + '::photoid', 										build_key_ecrashv2_photoid);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrashv2_prefname_state,							Constants.KeyName_ecrashv2+ '::@version@::prefname_state',						Constants.KeyName_ecrashv2 + '::'+ version + '::prefname_state', 						build_key_ecrashv2_prefname_state);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrashv2_reportid, 									Constants.KeyName_ecrashv2+ '::@version@::reportid', 									Constants.KeyName_ecrashv2 + '::'+ version + '::reportid', 									build_key_ecrashv2_reportid);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.Key_eCrashv2_reportlinkId, 							Constants.KeyName_ecrashv2+ '::@version@::reportlinkid', 							Constants.KeyName_ecrashv2 + '::'+ version + '::reportlinkid', 							build_key_ecrashv2_reportlinkid);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrashv2_standlocation,							Constants.KeyName_ecrashv2+ '::@version@::standlocation',  						Constants.KeyName_ecrashv2 + '::'+ version + '::standlocation', 							build_key_ecrashv2_standlocation);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrashv2_supplemental,								Constants.KeyName_ecrashv2+ '::@version@::supplemental',							Constants.KeyName_ecrashv2 + '::'+ version + '::supplemental', 							build_key_ecrashv2_supplemental);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrashv2_tagnbr,											Constants.KeyName_ecrashv2+ '::@version@::tagnbr',										Constants.KeyName_ecrashv2 + '::'+ version + '::tagnbr', 										build_key_ecrashv2_tagnbr);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ecrashv2_vin,												Constants.KeyName_ecrashv2+ '::@version@::vin',   										Constants.KeyName_ecrashv2 + '::'+ version + '::vin', 												build_key_ecrashv2_vin);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local( keys.key_LinkIds.Key,													Constants.KeyName_ecrashv2+ '::@version@::linkids', 									Constants.KeyName_ecrashv2 + '::'+ version + '::linkids',										build_key_ecrashv2_linkids);

//New Keys Buy Crash
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local( keys.key_ecrashV2_agency,											Constants.KeyName_ecrashv2+ '::@version@::agency', 										Constants.KeyName_ecrashv2 + '::'+ version + '::agency',											build_key_ecrashv2_agency);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local( keys.key_ecrashv2_DlnNbrDLState,							Constants.KeyName_ecrashv2+ '::@version@::dlnnbrdlstate', 						Constants.KeyName_ecrashv2 + '::'+ version + '::dlnnbrdlstate',							build_key_ecrashv2_dlnbrstate);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local( keys.key_ecrashv2_LicensePlateNbr,						Constants.KeyName_ecrashv2+ '::@version@::licenseplatenbr', 					Constants.KeyName_ecrashv2 + '::'+ version + '::licenseplatenbr',						build_key_ecrashv2_licplatenbr);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local( keys.key_ecrashv2_OfficerBadgeNbr,						Constants.KeyName_ecrashv2+ '::@version@::officerbadgenbr', 					Constants.KeyName_ecrashv2 + '::'+ version + '::officerbadgenbr',						build_key_ecrashv2_officebadgenbr);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local( keys.key_ecrashv2_VinNbr,											Constants.KeyName_ecrashv2+ '::@version@::vinnbr', 										Constants.KeyName_ecrashv2 + '::'+ version + '::vinnbr',											build_key_ecrashv2_vinnbr);

//New Key
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local( keys.key_ecrashv2_unrestrictive_accnbrv1,			Constants.KeyName_ecrashv2+ '::@version@::unrestricted_accnbrv1', 		Constants.KeyName_ecrashv2 + '::'+ version + '::unrestricted_accnbrv1',			build_key_ecrashv2_unrestricted_accnbrv1);

build_keys := sequential(	
													build_key_ecrash0, build_key_ecrash1, build_key_ecrash2v, build_key_ecrash3v, 
													build_key_ecrash5, build_key_ecrash6, build_key_ecrash7,build_key_ecrash8,
													build_key_ecrashv2analytics_byagencyid, build_key_ecrashv2analytics_bycollisiontype, 
													build_key_ecrashv2analytics_bydow,build_key_ecrashv2analytics_byhod, 
													build_key_ecrashv2analytics_byinter, build_key_ecrashv2analytics_bymoy, 
													build_key_ecrashv2_accnbrv1, build_key_ecrashv2_accnbr, 
													build_key_ecrashv2_agencyid_sentdate, build_key_ecrashv2_bdid, 
													build_key_ecrashv2_did, build_key_ecrashv2_dlnbr, 
													build_key_ecrashv2_dol, build_key_ecrashv2_lastname_state, 
													build_key_ecrashv2_photoid, build_key_ecrashv2_prefname_state, 
													build_key_ecrashv2_reportid, build_key_ecrashv2_reportlinkid,
													build_key_ecrashv2_standlocation, build_key_ecrashv2_supplemental, 
													build_key_ecrashv2_tagnbr, build_key_ecrashv2_vin, build_key_ecrashv2_linkids,
													build_key_ecrashv2_agency,build_key_ecrashv2_dlnbrstate,build_key_ecrashv2_licplatenbr,
													build_key_ecrashv2_officebadgenbr,build_key_ecrashv2_vinnbr,
													build_key_ecrashv2_unrestricted_accnbrv1
												);


//Move Keys to Built
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrash+ 'ecrash0', 	Constants.KeyName_ecrash +'::' + version + '::ecrash0', 	move_built_key_ecrash0);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrash+ 'ecrash1', 	Constants.KeyName_ecrash +'::' + version + '::ecrash1',	move_built_key_ecrash1);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrash+ 'ecrash2v', Constants.KeyName_ecrash +'::' + version + '::ecrash2v',	move_built_key_ecrash2v);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrash+ 'ecrash3v', Constants.KeyName_ecrash +'::' + version + '::ecrash3v', move_built_key_ecrash3v);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrash+ 'ecrash5', 	Constants.KeyName_ecrash +'::' + version + '::ecrash5',	move_built_key_ecrash5);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrash+ 'ecrash6', 	Constants.KeyName_ecrash +'::' + version + '::ecrash6',	move_built_key_ecrash6);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrash+ 'ecrash7', 	Constants.KeyName_ecrash +'::' + version + '::ecrash7',	move_built_key_ecrash7);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrash+ 'ecrash8', 	Constants.KeyName_ecrash +'::' + version + '::ecrash8',	move_built_key_ecrash8);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'analytics_byagencyid', 				Constants.KeyName_ecrashv2 +'::' + version + '::analytics_byagencyid',				move_built_key_ecrashv2analytics_byagencyid);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'analytics_bycollisiontype', 	Constants.KeyName_ecrashv2 +'::' + version + '::analytics_bycollisiontype',	move_built_key_ecrashv2analytics_bycollisiontype);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'analytics_bydow', 						Constants.KeyName_ecrashv2 +'::' + version + '::analytics_bydow',						move_built_key_ecrashv2analytics_bydow);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'analytics_byhod', 						Constants.KeyName_ecrashv2 +'::' + version + '::analytics_byhod', 						move_built_key_ecrashv2analytics_byhod);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'analytics_byinter', 					Constants.KeyName_ecrashv2 +'::' + version + '::analytics_byinter', 					move_built_key_ecrashv2analytics_byinter);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'analytics_bymoy', 						Constants.KeyName_ecrashv2 +'::' + version + '::analytics_bymoy', 						move_built_key_ecrashv2analytics_bymoy);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'accnbrv1', 						Constants.KeyName_ecrashv2 +'::' + version + '::accnbrv1', 					move_built_key_ecrashv2_accnbrv1);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'accnbr', 							Constants.KeyName_ecrashv2 +'::' + version + '::accnbr',							move_built_key_ecrashv2_accnbr);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'agencyid_sentdate', 	Constants.KeyName_ecrashv2 +'::' + version + '::agencyid_sentdate', 	move_built_key_ecrashv2_agencyid_sentdate);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'bdid', 								Constants.KeyName_ecrashv2 +'::' + version + '::bdid',								move_built_key_ecrashv2_bdid);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'did', 								Constants.KeyName_ecrashv2 +'::' + version + '::did', 								move_built_key_ecrashv2_did);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'dlnbr', 							Constants.KeyName_ecrashv2 +'::' + version + '::dlnbr', 							move_built_key_ecrashv2_dlnbr);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'dol',  								Constants.KeyName_ecrashv2 +'::' + version + '::dol', 								move_built_key_ecrashv2_dol);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'lastname_state',  		Constants.KeyName_ecrashv2 +'::' + version + '::lastname_state', 		move_built_key_ecrashv2_lastname_state);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'linkids',  						Constants.KeyName_ecrashv2 +'::' + version + '::linkids', 						move_built_key_ecrashv2_linkids);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'photoid', 						Constants.KeyName_ecrashv2 +'::' + version + '::photoid',						move_built_key_ecrashv2_photoid);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'prefname_state',  		Constants.KeyName_ecrashv2 +'::' + version + '::prefname_state', 		move_built_key_ecrashv2_prefname_state);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'reportid',  					Constants.KeyName_ecrashv2 +'::' + version + '::reportid',						move_built_key_ecrashv2_reportid);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'reportlinkid',  			Constants.KeyName_ecrashv2 +'::' + version + '::reportlinkid',				move_built_key_ecrashv2_reporlinktid);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'standlocation',  			Constants.KeyName_ecrashv2 +'::' + version + '::standlocation', 			move_built_key_ecrashv2_standlocation);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'supplemental',  			Constants.KeyName_ecrashv2 +'::' + version + '::supplemental', 			move_built_key_ecrashv2_supplemental);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'tagnbr',  						Constants.KeyName_ecrashv2 +'::' + version + '::tagnbr', 						move_built_key_ecrashv2_tagnbr);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'vin', 								Constants.KeyName_ecrashv2 +'::' + version + '::vin',  							move_built_key_ecrashv2_vin);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'agency', 							Constants.KeyName_ecrashv2 +'::' + version + '::agency',  						move_built_key_ecrashv2_agency);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'dlnnbrdlstate', 			Constants.KeyName_ecrashv2 +'::' + version + '::dlnnbrdlstate',  		move_built_key_ecrashv2_dlnbrstate);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'licenseplatenbr', 		Constants.KeyName_ecrashv2 +'::' + version + '::licenseplatenbr',  	move_built_key_ecrashv2_licplatenbr);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'officerbadgenbr', 		Constants.KeyName_ecrashv2 +'::' + version + '::officerbadgenbr',  	move_built_key_ecrashv2_officebadgenbr);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'vinnbr', 							Constants.KeyName_ecrashv2 +'::' + version + '::vinnbr',  						move_built_key_ecrashv2_vinnbr);

//New Keys
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.SuperKeyname_ecrashV2 + 'unrestricted_accnbrv1', Constants.KeyName_ecrashv2 +'::' + version + '::unrestricted_accnbrv1',	move_built_key_ecrashv2_unrestricted_accnbrv1);

Move_Keys := sequential(move_built_key_ecrash0, move_built_key_ecrash1, move_built_key_ecrash2v, move_built_key_ecrash3v, 
												move_built_key_ecrash5, move_built_key_ecrash6, move_built_key_ecrash7, move_built_key_ecrash8,
												move_built_key_ecrashv2analytics_byagencyid, move_built_key_ecrashv2analytics_bycollisiontype, 
												move_built_key_ecrashv2analytics_bydow, move_built_key_ecrashv2analytics_byhod, 
												move_built_key_ecrashv2analytics_byinter, move_built_key_ecrashv2analytics_bymoy, 
												move_built_key_ecrashv2_accnbrv1, move_built_key_ecrashv2_accnbr, 
												move_built_key_ecrashv2_agencyid_sentdate, move_built_key_ecrashv2_bdid, 
												move_built_key_ecrashv2_did, move_built_key_ecrashv2_dlnbr, move_built_key_ecrashv2_dol, 
												move_built_key_ecrashv2_lastname_state, move_built_key_ecrashv2_photoid, move_built_key_ecrashv2_prefname_state, 
												move_built_key_ecrashv2_reportid,	move_built_key_ecrashv2_reporlinktid, move_built_key_ecrashv2_standlocation, 
												move_built_key_ecrashv2_supplemental, move_built_key_ecrashv2_tagnbr, 
												move_built_key_ecrashv2_vin, move_built_key_ecrashv2_linkids,
												move_built_key_ecrashv2_agency,move_built_key_ecrashv2_dlnbrstate,
												move_built_key_ecrashv2_licplatenbr,move_built_key_ecrashv2_officebadgenbr,
												move_built_key_ecrashv2_vinnbr, move_built_key_ecrashv2_unrestricted_accnbrv1
												);
											

//Move to QA superkey
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrash+ 'ecrash0', 	'Q', 	move_qa_key_ecrash0);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrash+ 'ecrash1', 	'Q', 	move_qa_key_ecrash1);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrash+ 'ecrash2v',	'Q', 	move_qa_key_ecrash2v);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrash+ 'ecrash3v',	'Q', 	move_qa_key_ecrash3v);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrash+ 'ecrash5', 	'Q', 	move_qa_key_ecrash5);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrash+ 'ecrash6', 	'Q', 	move_qa_key_ecrash6);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrash+ 'ecrash7', 	'Q', 	move_qa_key_ecrash7);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrash+ 'ecrash8', 	'Q', 	move_qa_key_ecrash8);

RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'analytics_byagencyid', 			'Q', 	move_qa_key_ecrashv2analytics_byagencyid);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'analytics_bycollisiontype', 'Q', 	move_qa_key_ecrashv2analytics_bycollisiontype);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'analytics_bydow', 					'Q', 	move_qa_key_ecrashv2analytics_bydow);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'analytics_byhod', 					'Q', 	move_qa_key_ecrashv2analytics_byhod);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'analytics_byinter', 				'Q', 	move_qa_key_ecrashv2analytics_byinter);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'analytics_bymoy', 					'Q', 	move_qa_key_ecrashv2analytics_bymoy);

RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'accnbrv1', 									'Q', 	move_qa_key_ecrashv2_accnbrv1);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'accnbr', 										'Q', 	move_qa_key_ecrashv2_accnbr);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'agencyid_sentdate', 				'Q', 	move_qa_key_ecrashv2_agencyid_sentdate);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'bdid', 											'Q', 	move_qa_key_ecrashv2_bdid);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'did', 											'Q', 	move_qa_key_ecrashv2_did);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'dlnbr', 										'Q', 	move_qa_key_ecrashv2_dlnbr);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'dol', 											'Q', 	move_qa_key_ecrashv2_dol);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'lastname_state', 						'Q', 	move_qa_key_ecrashv2_lastname_state);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'photoid', 									'Q', 	move_qa_key_ecrashv2_photoid);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'prefname_state', 						'Q', 	move_qa_key_ecrashv2_prefname_state);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'reportid', 									'Q', 	move_qa_key_ecrashv2_reportid);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'reportlinkid', 							'Q', 	move_qa_key_ecrashv2_reportlinkid);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'standlocation', 						'Q', 	move_qa_key_ecrashv2_standlocation);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'supplemental', 							'Q', 	move_qa_key_ecrashv2_supplemental);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'tagnbr', 										'Q', 	move_qa_key_ecrashv2_tagnbr);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'vin', 											'Q', 	move_qa_key_ecrashv2_vin);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'linkids', 									'Q', 	move_qa_key_ecrashv2_linkids);

RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'agency', 										'Q', 	move_qa_key_ecrashv2_agency);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'dlnnbrdlstate', 						'Q', 	move_qa_key_ecrashv2_dlnbrstate);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'licenseplatenbr', 					'Q', 	move_qa_key_ecrashv2_licplatenbr);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'officerbadgenbr', 					'Q', 	move_qa_key_ecrashv2_officebadgenbr);
RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'vinnbr', 										'Q', 	move_qa_key_ecrashv2_vinnbr);

RoxieKeyBuild.MAC_SK_Move_v2(Constants.SuperKeyname_ecrashV2 + 'unrestricted_accnbrv1', 		'Q', 	move_qa_key_ecrashv2_unrestricted_accnbrv1);

To_QA := sequential(move_qa_key_ecrash0,move_qa_key_ecrash1, move_qa_key_ecrash2v, move_qa_key_ecrash3v, 
										move_qa_key_ecrash5, move_qa_key_ecrash6, move_qa_key_ecrash7, move_qa_key_ecrash8,
										move_qa_key_ecrashv2analytics_byagencyid, move_qa_key_ecrashv2analytics_bycollisiontype, 
										move_qa_key_ecrashv2analytics_bydow, move_qa_key_ecrashv2analytics_byhod, 
										move_qa_key_ecrashv2analytics_byinter, move_qa_key_ecrashv2analytics_bymoy, 
										move_qa_key_ecrashv2_accnbrv1, move_qa_key_ecrashv2_accnbr, 
										move_qa_key_ecrashv2_agencyid_sentdate, move_qa_key_ecrashv2_bdid, 
										move_qa_key_ecrashv2_did, move_qa_key_ecrashv2_dlnbr, move_qa_key_ecrashv2_dol, 
										move_qa_key_ecrashv2_lastname_state,  
										move_qa_key_ecrashv2_photoid, move_qa_key_ecrashv2_prefname_state, 
										move_qa_key_ecrashv2_reportid, move_qa_key_ecrashv2_reportlinkid,
										move_qa_key_ecrashv2_standlocation, move_qa_key_ecrashv2_supplemental, 
										move_qa_key_ecrashv2_tagnbr, move_qa_key_ecrashv2_vin, 
										move_qa_key_ecrashv2_linkids,	move_qa_key_ecrashv2_agency,
										move_qa_key_ecrashv2_dlnbrstate,move_qa_key_ecrashv2_licplatenbr,
										move_qa_key_ecrashv2_officebadgenbr,move_qa_key_ecrashv2_vinnbr,
										move_qa_key_ecrashv2_unrestricted_accnbrv1
										);

AutoKeyB2.MAC_Build (file_Autokey
										,fname,mname,lname
										,zero
										,zero
										,zero
										,prim_name,prim_range,st,v_city_name,zip5,sec_range
										,zero
										,zero,zero,zero
										,zero,zero,zero
										,zero,zero,zero
										,zero
										,DID
										,b_name
										,zero
										,zero
										,b_prim_name,b_prim_range,b_st,b_v_city_name,b_zip5,b_sec_range
										,b_did
										,constants.ak_keyname
										,constants.ak_logical(version)
										,outaction,false
										,constants.ak_skip_set,true,constants.ak_typeStr
										,true,,,zero);

AutoKeyB2.MAC_AcceptSK_to_QA(constants.ak_keyname, mymove,, constants.ak_skip_set);
retval := sequential(outaction,mymove);


// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION------  
is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
DOPS_Comment		 		:= OUTPUT('Skipping DOPS process');
updatedops   		 		:= PRTE.UpdateVersion(constants.dataset_name,version,_control.MyInfo.EmailAddressNormal,l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N'); 

//Updating IDOPS CT environment
update_idops				:= DOPS.UpdateVersion(constants.dataset_name,Version,_control.MyInfo.EmailAddressNormal,l_inloc := 'A',l_inenvment := 'T');                                                                       

PerformUpdateOrNot 	:= IF(is_running_in_prod,parallel(updatedops, update_idops),DOPS_Comment);
//---------------------------------------------------

//Key Validation
key_validation :=  output(dops.ValidatePRCTFileLayout(version, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,constants.dataset_name, 'N'), named(constants.dataset_name +'Validation'));

keybuild_process :=  sequential(
																build_keys
																,Move_Keys 
																,To_QA
																,proc_build_keys_addl(version)
																,retval		
																,key_validation
																,PerformUpdateOrNot
																): Success(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify, 'Ecrash Build Succeeded', workunit + ': Build completed.')),
																	 Failure(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify, 'Ecrash Build Build Failed', workunit + '\n' + FAILMESSAGE));

RETURN keybuild_process;		
			
                

END;
