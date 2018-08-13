import RoxieKeyBuild,PRTE, _control, STD,prte2,tools, PRTE2_Common, PRTE, strata;

export proc_build_keys(string filedate) := FUNCTION

// Non FCRA
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(keys.key_certifications(),			Constants.KEY_PREFIX+'airmen_certs',  		Constants.KEY_PREFIX+filedate+'::airmen_certs',	k1);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_Local(keys.key_airmen_did(),	 				Constants.KEY_PREFIX+'airmen_did',    		Constants.KEY_PREFIX+filedate+'::airmen_did',	k2);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(keys.key_airmen_rid(),					Constants.KEY_PREFIX+'airmen_rid',    		Constants.KEY_PREFIX+filedate+'::airmen_rid',	k3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(keys.key_airmen_id,						Constants.KEY_PREFIX+'airmen_id',     		Constants.KEY_PREFIX+filedate+'::airmen_id',	k4);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(keys.key_aircraft_id(),				Constants.KEY_PREFIX+'aircraft_id',     	Constants.KEY_PREFIX+filedate+'::aircraft_id',k5);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_Local(keys.key_aircraft_did(),				Constants.KEY_PREFIX+'aircraft_reg_did',	Constants.KEY_PREFIX+filedate+'::aircraft_reg_did',	k6);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(keys.key_aircraft_reg_bdid,		Constants.KEY_PREFIX+'aircraft_reg_bdid',	Constants.KEY_PREFIX+filedate+'::aircraft_reg_bdid',k7);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(keys.key_aircraft_reg_nnum,		Constants.KEY_PREFIX+'aircraft_reg_nnum',	Constants.KEY_PREFIX+filedate+'::aircraft_reg_nnum',k8);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(keys.key_aircraft_linkids.Key,	Constants.KEY_PREFIX+'aircraft_linkids',	Constants.KEY_PREFIX+filedate+'::aircraft_linkids',	k9);

//Copying Reference Keys
// DF-21779: Copying Prod Keys which should be depreciated.
key_aircraft_info	:= 	STD.File.copy(Constants.thor_cluster_Files+	'key::faa_aircraft_info_qa',tools.fun_Clustername_DFU(), Constants.KEY_PREFIX+filedate+'::aircraft_info',,,,,true,,,true);
key_engine_info  	:= 	STD.File.copy(Constants.thor_cluster_Files+	'key::faa_engine_info_qa',tools.fun_Clustername_DFU('02'), Constants.KEY_PREFIX+filedate+'::engine_info',,,,,true,,,true);


//FCRA	
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(keys.key_certifications(true),	Constants.KEY_PREFIX_FCRA+'airmen_certs',  		Constants.KEY_PREFIX_FCRA+filedate+'::airmen_certs',fcra_k1);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_Local(keys.key_airmen_did(true),	 		Constants.KEY_PREFIX_FCRA+'airmen_did',    		Constants.KEY_PREFIX_FCRA+filedate+'::airmen_did', fcra_k2);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(keys.key_airmen_rid(true),			Constants.KEY_PREFIX_FCRA+'airmen_rid',    		Constants.KEY_PREFIX_FCRA+filedate+'::airmen_rid', fcra_k3);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(keys.key_aircraft_id(true),		Constants.KEY_PREFIX_FCRA+'aircraft_id',     	Constants.KEY_PREFIX_FCRA+filedate+'::aircraft_id',	fcra_k4);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_Local(keys.key_aircraft_did(true),		Constants.KEY_PREFIX_FCRA+'aircraftreg_did',	Constants.KEY_PREFIX_FCRA+filedate+'::aircraftreg_did',	fcra_k5);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(keys.key_aircraft_did_FCRA,		Constants.KEY_PREFIX_FCRA+'aircraft_reg_did',	Constants.KEY_PREFIX_FCRA+filedate+'::aircraft_reg_did',fcra_k6);


//Copying Reference Keys
key_aircraft_info_fcra	:= 	STD.File.copy(Constants.thor_cluster_Files+	'key::faa::fcra::aircraft_info_qa',tools.fun_Clustername_DFU('02'), Constants.KEY_PREFIX_FCRA+filedate+'::aircraft_info',,,,,true,,,true);
key_engine_info_fcra  	:= 	STD.File.copy(Constants.thor_cluster_Files+	'key::faa::fcra::engine_info_qa',tools.fun_Clustername_DFU('02'), Constants.KEY_PREFIX_FCRA+filedate+'::engine_info',,,,,true,,,true);


build_roxie_keys	:=	parallel(	k1, k2, k3, k4, k5, k6, k7, k8, k9, key_aircraft_info, key_engine_info, fcra_k1, fcra_k2, fcra_k3, fcra_k4, fcra_k5, fcra_k6, key_aircraft_info_fcra, key_engine_info_fcra);



// -- Move Keys to Built
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'airmen_certs',			Constants.KEY_PREFIX+filedate+'::airmen_certs',				mv1);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'airmen_did',				Constants.KEY_PREFIX+filedate+'::airmen_did',					mv2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'airmen_rid',				Constants.KEY_PREFIX+filedate+'::airmen_rid',					mv3);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'airmen_id',     		Constants.KEY_PREFIX+filedate+'::airmen_id',					mv4);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'aircraft_id',				Constants.KEY_PREFIX+filedate+'::aircraft_id',				mv5);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'aircraft_reg_did',	Constants.KEY_PREFIX+filedate+'::aircraft_reg_did',		mv6);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'aircraft_reg_bdid',	Constants.KEY_PREFIX+filedate+'::aircraft_reg_bdid',	mv7);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'aircraft_reg_nnum',	Constants.KEY_PREFIX+filedate+'::aircraft_reg_nnum',	mv8);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'aircraft_linkids',	Constants.KEY_PREFIX+filedate+'::aircraft_linkids',		mv9);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'aircraft_info',			Constants.KEY_PREFIX+filedate+'::aircraft_info',			mv10);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'engine_info',				Constants.KEY_PREFIX+filedate+'::engine_info',				mv11);


// -- Move FCRA Keys to Built
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName_FCRA+'airmen_certs',			Constants.KEY_PREFIX_FCRA+filedate+'::airmen_certs',		fcra_mv1);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName_FCRA+'airmen_did',				Constants.KEY_PREFIX_FCRA+filedate+'::airmen_did',			fcra_mv2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName_FCRA+'airmen_rid',				Constants.KEY_PREFIX_FCRA+filedate+'::airmen_rid',			fcra_mv3);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName_FCRA+'aircraft_id',			Constants.KEY_PREFIX_FCRA+filedate+'::aircraft_id',			fcra_mv4);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName_FCRA+'aircraftreg_did',	Constants.KEY_PREFIX_FCRA+filedate+'::aircraftreg_did',	fcra_mv5);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName_FCRA+'aircraft_reg_did',	Constants.KEY_PREFIX_FCRA+filedate+'::aircraft_reg_did',fcra_mv6);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName_FCRA+'aircraft_info',		Constants.KEY_PREFIX_FCRA+filedate+'::aircraft_info',		fcra_mv7);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName_FCRA+'engine_info',			Constants.KEY_PREFIX_FCRA+filedate+'::engine_info',			fcra_mv8);




Move_keys	:=	parallel(	mv1, mv2, mv3, mv4, mv5,mv6, mv7, mv8, mv9, mv10, mv11, fcra_mv1, fcra_mv2, fcra_mv3, fcra_mv4, fcra_mv5, fcra_mv6, fcra_mv7, fcra_mv8);


// -- Move Keys to QA
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'aircraft_info',		'Q',mv1_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'engine_info',			'Q',mv2_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'airmen_certs',			'Q',mv3_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'airmen_did',				'Q',mv4_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'airmen_rid',				'Q',mv5_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'airmen_id',				'Q',mv6_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'aircraft_id',			'Q',mv7_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'aircraft_reg_did',	'Q',mv8_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'aircraft_reg_bdid','Q',mv9_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'aircraft_reg_nnum','Q',mv10_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'aircraft_linkids',	'Q',mv11_qa,2);


//-- Move FCRA Keys to QA
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName_fcra+'aircraft_info',		'Q',fcra_mv1_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName_fcra+'engine_info',			'Q',fcra_mv2_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName_fcra+'airmen_certs',		'Q',fcra_mv3_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName_fcra+'airmen_did',			'Q',fcra_mv4_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName_fcra+'airmen_rid',			'Q',fcra_mv5_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName_fcra+'aircraft_id',			'Q',fcra_mv6_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName_fcra+'aircraftreg_did',	'Q',fcra_mv7_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName_fcra+'aircraft_reg_did','Q',fcra_mv8_qa,2);


To_qa	:=	parallel(mv1_qa, mv2_qa, mv3_qa, mv4_qa, mv5_qa, mv6_qa, mv7_qa, mv8_qa, mv9_qa, mv10_qa, mv11_qa, 
									 fcra_mv1_qa, fcra_mv2_qa, fcra_mv3_qa, fcra_mv4_qa, fcra_mv5_qa, fcra_mv6_qa, fcra_mv7_qa, fcra_mv8_qa);


//DF-21803:FCRA Consumer Data Fields Depreciation
cnt_faa_airmen_cert_fcra := OUTPUT(strata.macf_pops(Keys.key_Certifications(true),,,,,,FALSE,['ratings']), named('cnt_faa_airmen_cert_fcra'));
cnt_faa_airmen_did_fcra 	:= OUTPUT(strata.macf_pops(Keys.key_airmen_did(true),,,,,,FALSE,['ace_fips_st','country','region','title']), named('cnt_faa_airmen_did_fcra'));
cnt_faa_aircraft_id_fcra := OUTPUT(strata.macf_pops(Keys.key_aircraft_id(true),,,,,,FALSE,
																																		['ace_fips_st','certification','compname','country','fract_owner',
																																		'last_action_date','lf','orig_county','region','status_code','title',
																																		'type_registrant']),named('cnt_faa_aircraft_id_fcra'));
																																		


// -- Build Autokeys
build_autokeys_common := Keys.autokeys(filedate);
build_autokeys_airmen	:= Keys.autokeys_airmen(filedate);


// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION 
is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
DOPS_Comment		 					:= OUTPUT('Skipping DOPS process');
updatedops   		 				:= PRTE.UpdateVersion('FAAKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','N','N');
updatedops_fcra  			:= PRTE.UpdateVersion('FCRA_FAAKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','F','N');



// -- Actions
buildKey	:=	sequential(
													build_roxie_keys
												,Move_keys
												,to_qa
												,build_autokeys_common
												,build_autokeys_airmen
												,if(is_running_in_prod, parallel(updatedops,updatedops_fcra),DOPS_Comment) 
												,parallel(cnt_faa_airmen_cert_fcra,cnt_faa_airmen_did_fcra,cnt_faa_aircraft_id_fcra)
												);	

return	buildKey;

end;
