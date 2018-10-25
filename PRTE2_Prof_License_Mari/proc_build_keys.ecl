import RoxieKeyBuild,PRTE, _control, PRTE2_Common;

export proc_build_keys(string filedate) := FUNCTION


// -- Build Keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(keys.key_BDID,							Constants.KEY_PREFIX+'bdid',									Constants.KEY_PREFIX+filedate+'::bdid',									key1);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(keys.key_DID(),						Constants.KEY_PREFIX+'did',										Constants.KEY_PREFIX+filedate+'::did',									key2);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(keys.key_license_nbr,			Constants.KEY_PREFIX+'license_nbr',						Constants.KEY_PREFIX+filedate+'::license_nbr',					key3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(keys.key_ssn_taxid,				Constants.KEY_PREFIX+'ssn_taxid',							Constants.KEY_PREFIX+filedate+'::ssn_taxid',						key4);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(keys.key_mari_payload,			Constants.KEY_PREFIX+'rid',										Constants.KEY_PREFIX+filedate+'::rid',									key5);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(keys.key_cmc_slpk,					Constants.KEY_PREFIX+'cmc_slpk',							Constants.KEY_PREFIX+filedate+'::cmc_slpk',							key6);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(keys.key_indv_detail,			Constants.KEY_PREFIX+'individual_detail',			Constants.KEY_PREFIX+filedate+'::individual_detail',		key7);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(keys.key_regulatory,				Constants.KEY_PREFIX+'regulatory_actions',		Constants.KEY_PREFIX+filedate+'::regulatory_actions',		key8);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(keys.key_disciplinary,			Constants.KEY_PREFIX+'disciplinary_actions',	Constants.KEY_PREFIX+filedate+'::disciplinary_actions',	key9);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(keys.key_nmls_id,					Constants.KEY_PREFIX+'nmls_id',								Constants.KEY_PREFIX+filedate+'::nmls_id',							key10);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(keys.key_linkIds.key,			Constants.KEY_PREFIX+'linkids',								Constants.KEY_PREFIX+filedate+'::linkids',							key11);

// Build FCRA Keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(keys.key_DID(true),				Constants.KEY_PREFIX+'did',								 		Constants.KEY_PREFIX_FCRA+filedate+'::did',						fcra_key1);

build_roxie_keys	:=	parallel(	key1, key2, key3, key4, key5, key6, key7, key8, key9, key10, key11, fcra_key1);


// -- Move Keys to Built
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'bdid',									Constants.KEY_PREFIX+filedate+'::bdid',								mv1);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'did',										Constants.KEY_PREFIX+filedate+'::did',								mv2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'license_nbr',						Constants.KEY_PREFIX+filedate+'::license_nbr',				mv3);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'ssn_taxid',							Constants.KEY_PREFIX+filedate+'::ssn_taxid',					mv4);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'rid',										Constants.KEY_PREFIX+filedate+'::rid',								mv5);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'cmc_slpk',							Constants.KEY_PREFIX+filedate+'::cmc_slpk',						mv6);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'individual_detail',			Constants.KEY_PREFIX+filedate+'::individual_detail',	mv7);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'regulatory_actions',		Constants.KEY_PREFIX+filedate+'::regulatory_actions',	mv8);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'disciplinary_actions',	Constants.KEY_PREFIX+filedate+'::disciplinary_actions',	mv9);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'nmls_id',								Constants.KEY_PREFIX+filedate+'::nmls_id',						mv10);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+'linkids',								Constants.KEY_PREFIX+filedate+'::linkids',						mv11);

// -- Move FCRA Keys to Built
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName_FCRA+'did',							Constants.KEY_PREFIX_FCRA+filedate+'::did',				mv1_fcra);


Move_keys	:=	parallel(	mv1, mv2, mv3, mv4, mv5,mv6, mv7, mv8, mv9, mv10, mv11, mv1_fcra);

// -- Move Keys to QA
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'bdid',									'Q',mv1_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'did',									'Q',mv2_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'license_nbr',					'Q',mv3_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'ssn_taxid',						'Q',mv4_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'rid',									'Q',mv5_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'cmc_slpk',							'Q',mv6_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'individual_detail',		'Q',mv7_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'regulatory_actions',		'Q',mv8_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'disciplinary_actions',	'Q',mv9_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'nmls_id',							'Q',mv10_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'linkids',							'Q',mv11_qa,2);

//-- Move FCRA Keys to QA
Roxiekeybuild.MAC_SK_Move_v2(Constants.SuperKeyName_fcra+'did',	'Q',mv1_qa_fcra,2);

To_qa	:=	parallel(mv1_qa, mv2_qa, mv3_qa, mv4_qa, mv5_qa, mv6_qa, mv7_qa, mv8_qa, mv9_qa, mv10_qa, mv11_qa, mv1_qa_fcra);


// -- Build Autokeys
build_autokeys := Keys.autokeys(filedate);

// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION 

is_running_in_prod := PRTE2_Common.Constants.is_running_in_prod;

 DOPS_Comment := OUTPUT('Skipping DOPS process');
 updatedops := PRTE.UpdateVersion('MARIKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','N','N');
 updatedops_fcra := PRTE.UpdateVersion('FCRA_MARIKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','F','N');

PerformUpdateOrNot := IF(is_running_in_prod,
 parallel(updatedops,updatedops_fcra),
 DOPS_Comment);

buildKey	:=	sequential(
												 build_roxie_keys
												,Move_keys
												,to_qa
												,build_autokeys);
												//,PerformUpdateOrNot);
												

return	buildKey;

end;