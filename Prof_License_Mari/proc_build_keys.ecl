import RoxieKeyBuild,autokey,ut,Prof_License_Mari,PRTE;


export proc_build_keys(string filedate) := FUNCTION

SuperKeyName 					:= '~thor_data400::key::proflic_mari::';
SuperKeyName_fcra			:= '~thor_data400::key::proflic_mari::fcra::';
BaseKeyName  					:= SuperKeyName+filedate;
BaseKeyName_fcra			:= SuperKeyName_fcra+filedate;	

// -- Build Keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Prof_License_Mari.key_BDID,							SuperKeyName+'bdid',									BaseKeyName+'::bdid',										key1);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Prof_License_Mari.key_DID(),							SuperKeyName+'did',										BaseKeyName+'::did',										key2);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Prof_License_Mari.key_license_nbr,				SuperKeyName+'license_nbr',						BaseKeyName+'::license_nbr',						key3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Prof_License_Mari.key_ssn_taxid,					SuperKeyName+'ssn_taxid',							BaseKeyName+'::ssn_taxid',							key4);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Prof_License_Mari.key_mari_payload,			SuperKeyName+'rid',										BaseKeyName+'::rid',										key5);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Prof_License_Mari.key_cmc_slpk,					SuperKeyName+'cmc_slpk',							BaseKeyName+'::cmc_slpk',								key6);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Prof_License_Mari.key_indv_detail,				SuperKeyName+'individual_detail',			BaseKeyName+'::individual_detail',			key7);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Prof_License_Mari.key_regulatory,				SuperKeyName+'regulatory_actions',		BaseKeyName+'::regulatory_actions',			key8);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Prof_License_Mari.key_disciplinary,			SuperKeyName+'disciplinary_actions',	BaseKeyName+'::disciplinary_actions',		key9);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Prof_License_Mari.key_nmls_id,						SuperKeyName+'nmls_id',								BaseKeyName+'::nmls_id',								key10);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Prof_License_Mari.key_linkIds.key,				SuperKeyName+'linkids',								BaseKeyName+'::linkids',								key11);

// Build FCRA Keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Prof_License_Mari.key_DID(true),					SuperKeyName_fcra+'did',					BaseKeyName_fcra+'::did',						fcra_key1);

Keys	:=	parallel(	key1, key2, key3, key4, key5, key6, key7, key8, key9, key10, key11, fcra_key1);


// -- Move Keys to Built
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::bdid',									BaseKeyName+'::bdid',								mv1);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::did',									BaseKeyName+'::did',								mv2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::license_nbr',					BaseKeyName+'::license_nbr',				mv3);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::ssn_taxid',						BaseKeyName+'::ssn_taxid',					mv4);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::rid',									BaseKeyName+'::rid',								mv5);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::cmc_slpk',							BaseKeyName+'::cmc_slpk',						mv6);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::individual_detail',		BaseKeyName+'::individual_detail',	mv7);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::regulatory_actions',		BaseKeyName+'::regulatory_actions',	mv8);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::disciplinary_actions',	BaseKeyName+'::disciplinary_actions',	mv9);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::nmls_id',							BaseKeyName+'::nmls_id',						mv10);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::linkids',							BaseKeyName+'::linkids',						mv11);

// -- Move FCRA Keys to Built
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName_fcra+'@version@::did',				BaseKeyName_fcra+'::did',				mv1_fcra);


Move_keys	:=	parallel(	mv1, mv2, mv3, mv4, mv5,mv6, mv7, mv8, mv9, mv10, mv11, mv1_fcra);

// -- Move Keys to QA
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::bdid',								'Q',mv1_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::did',									'Q',mv2_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::license_nbr',					'Q',mv3_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::ssn_taxid',						'Q',mv4_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::rid',									'Q',mv5_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::cmc_slpk',						'Q',mv6_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::individual_detail',		'Q',mv7_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::regulatory_actions',	'Q',mv8_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::disciplinary_actions','Q',mv9_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::nmls_id',							'Q',mv10_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::linkids',							'Q',mv11_qa,2);

//-- Move FCRA Keys to QA
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName_fcra+'@version@::did',			'Q',mv1_qa_fcra,2);

To_qa	:=	parallel(mv1_qa, mv2_qa, mv3_qa, mv4_qa, mv5_qa, mv6_qa, mv7_qa, mv8_qa, mv9_qa, mv10_qa, mv11_qa, mv1_qa_fcra);


// -- Build Autokeys
build_autokeys := Prof_License_Mari.proc_build_autokeys(filedate);


// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION 
updatedops   		:= RoxieKeyBuild.updateversion('MARIKeys',filedate,'terri.hardy-george@lexisnexis.com',,'N',);
updatedops_fcra  := RoxieKeyBuild.updateversion('FCRA_MARIKeys',filedate,'terri.hardy-george@lexisnexis.com',,'F',);

// -- Build PRTE Keys
build_prte     := PRTE.Proc_Build_MARI_Keys(filedate);

// -- Actions
buildKey	:=	sequential(Keys
												,Move_keys
												,to_qa
												,build_autokeys
												,parallel(updatedops,updatedops_fcra)
                        // ,build_prte
												);	

return	buildKey;

end;



 
 
 
 