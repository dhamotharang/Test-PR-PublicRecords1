import RoxieKeyBuild, prte2_sanctn_np,prte, dops, _control, PRTE2_Common;


EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo='') := function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn_np.Keys.bdid,										Constants.key_prefix+'bdid',							Constants.key_prefix+filedate+'::bdid',							key1);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn_np.Keys.did,										Constants.key_prefix+'did',								Constants.key_prefix+filedate+'::did',							key2);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn_np.Keys.incident,								Constants.key_prefix+'incident',					Constants.key_prefix+filedate+'::incident',					key3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn_np.Keys.incidentcode,						Constants.key_prefix+'incidentcode',			Constants.key_prefix+filedate+'::incidentcode',			key4);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn_np.Keys.incident,								Constants.key_prefix+'incidenttext',			Constants.key_prefix+filedate+'::incidenttext',			key5);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn_np.Keys.license_nbr,						Constants.key_prefix+'license_nbr',				Constants.key_prefix+filedate+'::license_nbr', 			key6);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn_np.Keys.license_midex,					Constants.key_prefix+'license_midex',			Constants.key_prefix+filedate+'::license_midex', 		key7);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn_np.Keys.incident_LinkIds.key,		Constants.key_prefix+'incident_linkids',	Constants.key_prefix+filedate+'::incident_linkids', key8);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn_np.Keys.party_LinkIds.key,			Constants.key_prefix+'party_linkids',	 		Constants.key_prefix+filedate+'::party_linkids', 		key9);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn_np.Keys.midex_rpt_nbr,					Constants.key_prefix+'midex_rpt_nbr',			Constants.key_prefix+filedate+'::midex_rpt_nbr',		key10);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn_np.Keys.nmls_id,								Constants.key_prefix+'nmls_id',			      Constants.key_prefix+filedate+'::nmls_id', 					key11);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn_np.Keys.nmls_midex,							Constants.key_prefix+'nmls_midex',			  Constants.key_prefix+filedate+'::nmls_midex', 			key12);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn_np.Keys.party,									Constants.key_prefix+'party',							Constants.key_prefix+filedate+'::party',						key13);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn_np.Keys.party_aka_dba,					Constants.key_prefix+'party_aka_dba',			Constants.key_prefix+filedate+'::party_aka_dba',		key14);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn_np.Keys.partytext,							Constants.key_prefix+'partytext',					Constants.key_prefix+filedate+'::partytext',				key15);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn_np.Keys.ssn4,										Constants.key_prefix+'ssn4',							Constants.key_prefix+filedate+'::ssn4',							key16);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn_np.Keys.tin,										Constants.key_prefix+'tin',								Constants.key_prefix+filedate+'::tin',							key17);

build_roxie_keys	:=	parallel(key1,key2,key3,key4,key5,key6,key7,key8,key9,key10,key11,key12,key13,key14,key15,key16,key17);


RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'bdid',											Constants.key_prefix+filedate+'::bdid',											mv1);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'did',												Constants.key_prefix+filedate+'::did',												mv2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'incident',							Constants.key_prefix+filedate+'::incident',							mv3);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'incidentcode',			Constants.key_prefix+filedate+'::incidentcode',			mv4);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'incidenttext',			Constants.key_prefix+filedate+'::incidenttext',			mv5);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'license_nbr',				Constants.key_prefix+filedate+'::license_nbr',				mv6);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'license_midex',		Constants.key_prefix+filedate+'::license_midex',		mv7);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'incident_linkids',	Constants.key_prefix+filedate+'::incident_linkids',	mv8);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'party_linkids',		Constants.key_prefix+filedate+'::party_linkids',		mv9);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName+'midex_rpt_nbr',		Constants.key_prefix+filedate+'::midex_rpt_nbr',		mv10);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'nmls_id',								Constants.key_prefix+filedate+'::nmls_id',								mv11);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'nmls_midex',					Constants.key_prefix+filedate+'::nmls_midex',		  	mv12);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'party',										Constants.key_prefix+filedate+'::party',										mv13);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'party_aka_dba',		Constants.key_prefix+filedate+'::party_aka_dba',		mv14);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'partytext',						Constants.key_prefix+filedate+'::partytext',						mv15);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'ssn4',											Constants.key_prefix+filedate+'::ssn4',											mv16);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'tin',												Constants.key_prefix+filedate+'::tin',					 						mv17);


Move_keys	:=	parallel(	mv1, mv2, mv3, mv4,mv5,	mv6,mv7,mv8,mv9,mv10,mv11,mv12,mv13,mv14,mv15,mv16,mv17);

//

RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'bdid',											'Q',mv1_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'did',												'Q',mv2_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'incident',							'Q',mv3_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'incidentcode',			'Q',mv4_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'incidenttext',			'Q',mv5_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'license_nbr',				'Q',mv6_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'license_midex',		'Q',mv7_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'incident_linkids','Q',mv8_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'party_linkids',		'Q',mv9_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'midex_rpt_nbr',		'Q',mv10_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'nmls_id',								'Q',mv11_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'nmls_midex',					'Q',mv12_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'party',										'Q',mv13_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'party_aka_dba',		'Q',mv14_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'partytext',						'Q',mv15_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'ssn4',											'Q',mv16_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'tin',												'Q',mv17_qa,2);

To_qa	:=	parallel(mv1_qa, mv2_qa, mv3_qa, mv4_qa, mv5_qa, mv6_qa,mv7_qa,mv8_qa,mv9_qa,mv10_qa,mv11_qa,mv12_qa,mv13_qa,mv14_qa,mv15_qa,mv16_qa, mv17_qa);

build_autokeys := prte2_sanctn_np.proc_build_autokeys(filedate);

//---------- making DOPS optional and only in PROD build -------------------------------													
		notifyEmail 				:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
		is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
		doDOPS 							:= is_running_in_prod AND NOT skipDOPS;
		NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');						
		updatedops   		 		:= PRTE.UpdateVersion('Sanctn_NPKeys',filedate,notifyEmail,'B','N','N');
		PerformUpdateOrNot 	:= IF(doDOPS,updatedops,NoUpdate);
//--------------------------------------------------------------------------------------

// -- Actions
buildKey	:=	sequential(
																					build_roxie_keys
																					,Move_keys
																					,to_qa
																					,build_autokeys
																					,PerformUpdateOrNot
																						);	

return	buildKey;

end;
