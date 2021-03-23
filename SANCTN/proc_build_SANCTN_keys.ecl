import Address,doxie_files, ut, doxie, autokey,SANCTN, RoxieKeyBuild;

export proc_build_SANCTN_keys(string filedate) := FUNCTION

SuperKeyName 					:= '~thor_data400::key::sanctn::';
BaseKeyName  					:= SuperKeyName+filedate;

/////////////////////////////////////////////////////////////////////////////////
// -- Build Keys
/////////////////////////////////////////////////////////////////////////////////
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN.Key_SANCTN_casenum,			SuperKeyName+'casenum',						BaseKeyName+'::casenum',						key1);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN.Key_SANCTN_DID,					SuperKeyName+'did',								BaseKeyName+'::did',								key2);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN.Key_SSN4,								SuperKeyName+'ssn4',							BaseKeyName+'::ssn4',								key3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN.Key_SANCTN_incident,		SuperKeyName+'incident',					BaseKeyName+'::incident',						key4);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN.Key_Midex_RPT_NBR,			SuperKeyName+'midex_rpt_nbr',			BaseKeyName+'::midex_rpt_nbr',			key5);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN.Key_SANCTN_party,				SuperKeyName+'party',							BaseKeyName+'::party',							key6);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN.Key_SANCTN_BDID,				SuperKeyName+'bdid',							BaseKeyName+'::bdid',								key7);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN.Key_REBUTTAL_TEXT,			SuperKeyName+'rebuttal',					BaseKeyName+'::rebuttal',						key8);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN.Key_LICENSE_NBR,				SuperKeyName+'license_nbr',				BaseKeyName+'::license_nbr', 				key9);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN.Key_INCIDENT_MIDEX,			SuperKeyName+'incident_midex',		BaseKeyName+'::incident_midex', 		key10);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN.Key_LICENSE_MIDEX,			SuperKeyName+'license_midex',			BaseKeyName+'::license_midex', 			key11);
//Added for KEY_NMLS_ID 10/21/13
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN.Key_NMLS_ID,						SuperKeyName+'nmls_id',			      BaseKeyName+'::nmls_id', 						key12);
//Added for KEY_NMLS_MIDEX 10/22/13
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN.Key_NMLS_MIDEX,					SuperKeyName+'nmls_midex',			  BaseKeyName+'::nmls_midex', 				key13);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN.Key_SANCTN_LinkIds.Key,	SuperKeyName+'linkids',			  		BaseKeyName+'::linkids', 						key14);
//Added for PARTY 07/11/14
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(SANCTN.Key_PARTY_AKA_DBA,			SuperKeyName+'party_aka_dba',			BaseKeyName+'::party_aka_dba',			key15);

Keys	:=	parallel(key1,key2,key3,key4,key5,key6,key7,key8,key9,key10,key11,key12,key13,key14,key15);




/////////////////////////////////////////////////////////////////////////////////
// -- Move Keys to Built
/////////////////////////////////////////////////////////////////////////////////

RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'casenum',					BaseKeyName+'::casenum',				mv1);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'did',							BaseKeyName+'::did',						mv2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'ssn4',						BaseKeyName+'::ssn4',						mv3);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'incident',				BaseKeyName+'::incident',				mv4);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(SuperKeyName+'midex_rpt_nbr',		BaseKeyName+'::midex_rpt_nbr',	mv5);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'party',						BaseKeyName+'::party',					mv6);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'bdid',						BaseKeyName+'::bdid',						mv7);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'rebuttal',				BaseKeyName+'::rebuttal',				mv8);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'license_nbr',			BaseKeyName+'::license_nbr',		mv9);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'incident_midex',	BaseKeyName+'::incident_midex',	mv10);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'license_midex',		BaseKeyName+'::license_midex',	mv11);
//Added for NMLS_ID 10/21/13
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'nmls_id',					BaseKeyName+'::nmls_id',				mv12);
//Added for KEY_NMLS_MIDEX 10/22/13
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'nmls_midex',			BaseKeyName+'::nmls_midex',		  mv13);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'linkids',					BaseKeyName+'::linkids',			  mv14);
//Added for PARTY 07/11/14
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'party_aka_dba',		BaseKeyName+'::party_aka_dba',	mv15);


Move_keys_orig	:=	parallel(	mv1, mv2, mv3, mv4,mv5,	mv6,mv7,mv8,mv9,mv10,mv11,mv12,mv13,mv14,mv15);


/////////////////////////////////////////////////////////////////////////////////
// -- Move Keys to QA
/////////////////////////////////////////////////////////////////////////////////
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'casenum',				'Q',mv1_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'did',						'Q',mv2_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'ssn4',						'Q',mv3_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'incident',				'Q',mv4_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'midex_rpt_nbr',	'Q',mv5_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'party',					'Q',mv6_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'bdid',						'Q',mv7_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'rebuttal',				'Q',mv8_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'license_nbr',		'Q',mv9_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'incident_midex',	'Q',mv10_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'license_midex',	'Q',mv11_qa,2);
//Added for NMLS_ID 10/21/13
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'nmls_id',				'Q',mv12_qa,2);
//Added for KEY_NMLS_MIDEX 10/22/13
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'nmls_midex',			'Q',mv13_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'linkids',				'Q',mv14_qa,2);
//Added for PARTY 07/11/14
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'party_aka_dba',	'Q',mv15_qa,2);

To_qa_orig	:=	parallel(mv1_qa, mv2_qa, mv3_qa, mv4_qa, mv5_qa, mv6_qa,mv7_qa,mv8_qa,mv9_qa,mv10_qa,mv11_qa,mv12_qa,mv13_qa,mv14_qa,mv15_qa);




/////////////////////////////////////////////////////////////////////////////////
// -- Build Autokeys
/////////////////////////////////////////////////////////////////////////////////

build_autokeys := SANCTN.proc_build_autokeys(filedate);

/////////////////////////////////////////////////////////////////////////////////
// -- Build Boolean keys
/////////////////////////////////////////////////////////////////////////////////

build_boolean_keys := SANCTN.Proc_Build_Boolean_Keys(filedate);

/////////////////////////////////////////////////////////////////////////////////
// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION 
/////////////////////////////////////////////////////////////////////////////////

// emailN := fileservices.sendemail('ehamel@seisint.com'),

emailN := fileservices.sendemail('roxiebuilds@seisint.com;ehamel@seisint.com;tgibson@seisint.com',
								 
								'sanctn: BUILD SUCCESS '+ filedate ,
								'keys: 1) thor_data400::key::sanctn::qa::autokey::address(thor_data400::key::sanctn::' + filedate + '::autokey::address),\n' +
								'      2) thor_data400::key::sanctn::qa::autokey::citystname(thor_data400::key::sanctn::' + filedate + '::autokey::citystname),\n' +
								'      3) thor_data400::key::sanctn::qa::autokey::name(thor_data400::key::sanctn::' + filedate + '::autokey::name),\n' +
								'      4) thor_data400::key::sanctn::qa::autokey::payload(thor_data400::key::sanctn::'+ filedate + '::autokey::payload),\n' +
								'      5) thor_data400::key::sanctn::qa::autokey::zip(thor_data400::key::sanctn::' + filedate + '::autokey::zip),\n' +
								'      6) thor_data400::key::sanctn::qa::autokey::stname(thor_data400::key::sanctn::' + filedate + '::autokey::stname),\n' +
								'      7) thor_data400::key::sanctn::qa::autokey::addressb2(thor_data400::key::sanctn::' + filedate + '::autokey::addressb2),\n' +
								'      8) thor_data400::key::sanctn::qa::autokey::citystnameb2(thor_data400::key::sanctn::' + filedate + '::autokey::citystnameb2),\n' +
								'      9) thor_data400::key::sanctn::qa::autokey::nameb2(thor_data400::key::sanctn::' + filedate + '::autokey::nameb2),\n' +
								'     10) thor_data400::key::sanctn::qa::autokey::namewords2(thor_data400::key::sanctn::' + filedate + '::autokey::namewords2),\n' + 
								'     11) thor_data400::key::sanctn::qa::autokey::stnameb2(thor_data400::key::sanctn::' + filedate + '::autokey::stnameb2),\n' +
								'     12) thor_data400::key::sanctn::qa::autokey::zipb2(thor_data400::key::sanctn::' + filedate + '::autokey::zipb2),\n' +
								'     13) thor_data400::key::sanctn::casenum_qa(thor_data400::key::sanctn::' + filedate + '::casenum),\n' +
								'     14) thor_data400::key::sanctn::incident_qa(thor_data400::key::sanctn::' + filedate + '::incident),\n' +
								'	  	15) thor_data400::key::sanctn::party_qa(thor_data400::key::sanctn::' + filedate + '::party),\n' +
								'     16) thor_data400::key::sanctn::qa::docref.docref(thor_data400::key::sanctn::' + filedate + '::docref.docref),\n' +
								'     17) thor_data400::key::sanctn::qa::nidx(thor_data400::key::sanctn::' + filedate + '::nidx),\n' +
								'     18) thor_data400::key::sanctn::qa::xdstat(thor_data400::key::sanctn::' + filedate + '::xdstat),\n' +
								'     19) thor_data400::key::sanctn::qa::xseglist(thor_data400::key::sanctn::' + filedate + '::xseglist),\n' +
						        '         have been built and ready to be deployed to QA.'); 
			

/////////////////////////////////////////////////////////////////////////////////
// -- Actions
/////////////////////////////////////////////////////////////////////////////////

buildKey	:=	sequential(
												Keys
												,Move_keys_orig
												,to_qa_orig
												,build_autokeys
												,build_boolean_keys
												,emailN
	 											);	

return	buildKey;

end;