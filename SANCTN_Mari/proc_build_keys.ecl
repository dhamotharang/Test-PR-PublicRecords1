import	RoxieKeyBuild,ut,autokey,SANCTN_Mari,dops;

export	proc_build_keys(string	filedate)	:=	function

SuperKeyName 					:= '~thor_data400::key::sanctn::np::';
BaseKeyName  					:= SuperKeyName+filedate;

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN_Mari.Key_LinkIds_Party.Key,		SuperKeyName+'party_linkids',		BaseKeyName+'::party_linkids',	key1);																
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN_Mari.Key_LinkIds_Incident.Key,SuperKeyName+'incident_linkids',BaseKeyName+'::incident_linkids',key2);																
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN_Mari.Key_BDID,								SuperKeyName+'bdid',						BaseKeyName+'::bdid',						key3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN_Mari.Key_DID,									SuperKeyName+'did',							BaseKeyName+'::did',						key4);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN_Mari.Key_SSN4,								SuperKeyName+'ssn4',						BaseKeyName+'::ssn4',						key5);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN_Mari.Key_TIN,									SuperKeyName+'tin',							BaseKeyName+'::tin',						key6);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN_Mari.Key_Midex_RPT_NBR,				SuperKeyName+'midex_rpt_nbr',		BaseKeyName+'::midex_rpt_nbr',	key7);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN_Mari.Key_Midex_NP_codes,			SuperKeyName+'incidentcode',		BaseKeyName+'::incidentcode',		key8);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN_Mari.Key_Midex_NP_incident,		SuperKeyName+'incident',				BaseKeyName+'::incident',				key9);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN_Mari.Key_Midex_NP_party,			SuperKeyName+'party',						BaseKeyName+'::party',					key10);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN_Mari.key_Midex_NP_text,				SuperKeyName+'incidenttext',		BaseKeyName+'::incidenttext',		key11);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN_Mari.key_License_NBR,					SuperKeyName+'license_nbr',			BaseKeyName+'::license_nbr',		key12);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN_Mari.key_party_text,					SuperKeyName+'partytext',				BaseKeyName+'::partytext',			key13);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN_Mari.key_license_midex,				SuperKeyName+'license_midex',		BaseKeyName+'::license_midex',	key14);
//Added for key_nmls_id. 10/21/13
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN_Mari.key_nmls_id,							SuperKeyName+'nmls_id',					BaseKeyName+'::nmls_id',	key15);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN_Mari.key_nmls_midex,					SuperKeyName+'nmls_midex',			BaseKeyName+'::nmls_midex',	key16);
//Added for key_party_aka_dba.  08/12/14
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN_Mari.key_party_aka_dba,				SuperKeyName+'party_aka_dba',		BaseKeyName+'::party_aka_dba',	key17);


Keys	:=	parallel(key1,key2,key3,key4,key5,key6,key7,key8,key9,key10,key11,key12,key13,key14,key15,key16,key17);



//Move Keys
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::party_linkids',	BaseKeyName+'::party_linkids',	mv1);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::incident_linkids',BaseKeyName+'::incident_linkids',mv2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::bdid',						BaseKeyName+'::bdid',						mv3);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::did',						BaseKeyName+'::did',						mv4);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::ssn4',						BaseKeyName+'::ssn4',						mv5);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::tin',						BaseKeyName+'::tin',						mv6);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(SuperKeyName+'@version@::midex_rpt_nbr',	BaseKeyName+'::midex_rpt_nbr',	mv7);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::incidentcode',		BaseKeyName+'::incidentcode',		mv8);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::incident',				BaseKeyName+'::incident',				mv9);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::party',					BaseKeyName+'::party',					mv10);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::incidenttext',		BaseKeyName+'::incidenttext',		mv11);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::license_nbr',		BaseKeyName+'::license_nbr',		mv12);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::partytext',			BaseKeyName+'::partytext',			mv13);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::license_midex',	BaseKeyName+'::license_midex',	mv14);
//Added for key_nmls_id. 10/21/13
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::nmls_id',				BaseKeyName+'::nmls_id',				mv15);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::nmls_midex',			BaseKeyName+'::nmls_midex',			mv16);
//Added for key_party_aka_dba. 08/12/14
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::party_aka_dba',	BaseKeyName+'::party_aka_dba',	mv17);

Move_keys_orig	:=	parallel(mv1,mv2,mv3,mv4,mv5,mv6,mv7,mv8,mv9,mv10,mv11,mv12,mv13,mv14,mv15,mv16,mv17);
																

//Move Orig to QA
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::party_linkids',	'Q',mv1_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::incident_linkids','Q',mv2_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::bdid',					'Q',mv3_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::did',						'Q',mv4_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::ssn4',					'Q',mv5_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::tin',						'Q',mv6_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::midex_rpt_nbr',	'Q',mv7_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::incidentcode',	'Q',mv8_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::incident',			'Q',mv9_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::party',					'Q',mv10_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::incidenttext',	'Q',mv11_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::license_nbr',		'Q',mv12_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::partytext',			'Q',mv13_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::license_midex',	'Q',mv14_qa,2);
//Added for key_nmls_id. 10/21/13
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::nmls_id',				'Q',mv15_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::nmls_midex',		'Q',mv16_qa,2);
//Added for key_party_aka_dba. 08/12/14
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::party_aka_dba',	'Q',mv17_qa,2);

To_qa_orig	:=	parallel(mv1_qa,mv2_qa,mv3_qa,mv4_qa,mv5_qa,mv6_qa,mv7_qa,mv8_qa,mv9_qa,mv10_qa,mv11_qa,mv12_qa,mv13_qa,mv14_qa,mv15_qa,mv16_qa,mv17_qa);

// Build Autokeys
autokeys	:=	SANCTN_Mari.proc_build_autokeys(filedate);

update_dops	:=	dops.updateversion('SANCTN_NPKeys', filedate, 'terri.hardy-george@lexisnexis.com',,'N');

												

buildKey	:=	sequential(Keys
												,Move_keys_orig
												,to_qa_orig
												,autokeys
												,update_dops
												);	

return	buildKey;

end;