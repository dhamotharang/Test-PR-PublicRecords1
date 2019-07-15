import RoxieKeyBuild, prte2_sanctn,prte, dops, _control, PRTE2_COMMON;


EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo='') := function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn.Keys.casenum,									Constants.key_prefix+'casenum',									Constants.key_prefix+filedate+'::casenum',								key1);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn.Keys.did,											Constants.key_prefix+'did',													Constants.key_prefix+filedate+'::did',												key2);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn.Keys.ssn4,										Constants.key_prefix+'ssn4',												Constants.key_prefix+filedate+'::ssn4',											key3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn.Keys.incident,								Constants.key_prefix+'incident',								Constants.key_prefix+filedate+'::incident',							key4);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn.Keys.midex_rpt_nbr,						Constants.key_prefix+'midex_rpt_nbr',			Constants.key_prefix+filedate+'::midex_rpt_nbr',		key5);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn.Keys.party,										Constants.key_prefix+'party',											Constants.key_prefix+filedate+'::party',										key6);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn.Keys.bdid,										Constants.key_prefix+'bdid',												Constants.key_prefix+filedate+'::bdid',											key7);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn.Keys.rebuttal_text,						Constants.key_prefix+'rebuttal',								Constants.key_prefix+filedate+'::rebuttal',							key8);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn.Keys.license_nbr,							Constants.key_prefix+'license_nbr',					Constants.key_prefix+filedate+'::license_nbr', 			key9);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn.Keys.incident_midex,					Constants.key_prefix+'incident_midex',		Constants.key_prefix+filedate+'::incident_midex', key10);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn.Keys.license_midex,						Constants.key_prefix+'license_midex',			Constants.key_prefix+filedate+'::license_midex', 	key11);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn.Keys.nmls_id,									Constants.key_prefix+'nmls_id',			      Constants.key_prefix+filedate+'::nmls_id', 							key12);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn.Keys.nmls_midex,							Constants.key_prefix+'nmls_midex',			  	Constants.key_prefix+filedate+'::nmls_midex', 				key13);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn.Keys.linkids.key,									Constants.key_prefix+'linkids',			  				Constants.key_prefix+filedate+'::linkids', 							key14);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_sanctn.Keys.party_aka_dba,						Constants.key_prefix+'party_aka_dba',			Constants.key_prefix+filedate+'::party_aka_dba',			key15);

build_roxie_keys	:=	parallel(key1,key2,key3,key4,key5,key6,key7,key8,key9,key10,key11,key12,key13,key14,key15);


RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'casenum',								Constants.key_prefix+filedate+'::casenum',								mv1);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'did',												Constants.key_prefix+filedate+'::did',												mv2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'ssn4',											Constants.key_prefix+filedate+'::ssn4',											mv3);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'incident',							Constants.key_prefix+filedate+'::incident',							mv4);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName+'midex_rpt_nbr',		Constants.key_prefix+filedate+'::midex_rpt_nbr',		mv5);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'party',										Constants.key_prefix+filedate+'::party',										mv6);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'bdid',											Constants.key_prefix+filedate+'::bdid',											mv7);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'rebuttal',							Constants.key_prefix+filedate+'::rebuttal',							mv8);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'license_nbr',				Constants.key_prefix+filedate+'::license_nbr',				mv9);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'incident_midex',	Constants.key_prefix+filedate+'::incident_midex',	mv10);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'license_midex',		Constants.key_prefix+filedate+'::license_midex',		mv11);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'nmls_id',								Constants.key_prefix+filedate+'::nmls_id',								mv12);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'nmls_midex',					Constants.key_prefix+filedate+'::nmls_midex',		  	mv13);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'linkids',								Constants.key_prefix+filedate+'::linkids',			  			mv14);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'party_aka_dba',		Constants.key_prefix+filedate+'::party_aka_dba',		mv15);


Move_keys	:=	parallel(	mv1, mv2, mv3, mv4,mv5,	mv6,mv7,mv8,mv9,mv10,mv11,mv12,mv13,mv14,mv15);


/////////////////////////////////////////////////////////////////////////////////
// -- Move Keys to QA
/////////////////////////////////////////////////////////////////////////////////
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'casenum',								'Q',mv1_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'did',												'Q',mv2_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'ssn4',											'Q',mv3_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'incident',							'Q',mv4_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'midex_rpt_nbr',		'Q',mv5_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'party',										'Q',mv6_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'bdid',											'Q',mv7_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'rebuttal',							'Q',mv8_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'license_nbr',				'Q',mv9_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'incident_midex',	'Q',mv10_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'license_midex',		'Q',mv11_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'nmls_id',								'Q',mv12_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'nmls_midex',					'Q',mv13_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'linkids',								'Q',mv14_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'party_aka_dba',		'Q',mv15_qa,2);

To_qa	:=	parallel(mv1_qa, mv2_qa, mv3_qa, mv4_qa, mv5_qa, mv6_qa,mv7_qa,mv8_qa,mv9_qa,mv10_qa,mv11_qa,mv12_qa,mv13_qa,mv14_qa,mv15_qa);

autokeys := proc_build_autokeys(filedate);

//---------- making DOPS optional and only in PROD build -------------------------------													
		notifyEmail 				:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
		is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
		doDOPS 							:= is_running_in_prod AND NOT skipDOPS;
		NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');						
		updatedops   		 		:= PRTE.UpdateVersion('SanctnKeys',filedate,notifyEmail,'B','N','N');
		PerformUpdateOrNot 	:= IF(doDOPS,updatedops,NoUpdate);
//--------------------------------------------------------------------------------------

// -- Actions
buildKey	:=	sequential( build_roxie_keys
													,Move_keys
													,to_qa
													,autokeys
													,PerformUpdateOrNot
											  );	

return	buildKey;

end;
