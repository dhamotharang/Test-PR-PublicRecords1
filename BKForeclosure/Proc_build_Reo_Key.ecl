IMPORT ut,BKForeclosure,RoxieKeyBuild,Risk_Indicators,VersionControl,promotesupers;

EXPORT Proc_build_Reo_key(string filedate) := 
FUNCTION

  SuperKeyName 					:= '~thor_data400::key::BKForeclosure_REO::';
	SuperKeyName_fcra			:= '~thor_data400::key::BKForeclosure_REO::FCRA::';
  BaseKeyName  					:= SuperKeyName      +  filedate;
  BaseKeyName_fcra			:= SuperKeyName_fcra +  filedate;

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(BKForeclosure.Key_REO_DID(),           SuperKeyName + 'did',         BaseKeyName + '::did',            key_did);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(BKForeclosure.Key_REO_Addr(),          SuperKeyName + 'Addr',        BaseKeyName + '::Addr',           key_Addr);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(BKForeclosure.Key_REO_FID(),           SuperKeyName + 'fid',         BaseKeyName + '::fid',            key_fid);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(BKForeclosure.Key_REO_FID_Linkids(),   SuperKeyName + 'fid_linkids', BaseKeyName + '::fid_linkids',    key_fid_linkids);

// Build FCRA Keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(BKForeclosure.Key_REO_DID(true),					SuperKeyName_fcra+'did',					BaseKeyName_fcra+'::did',						key_fcra_did);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(BKForeclosure.Key_REO_Addr(true),     	  SuperKeyName_fcra+'Addr',	        BaseKeyName_fcra+'::Addr',		      key_fcra_addr);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(BKForeclosure.Key_REO_FID(true),					SuperKeyName_fcra+'fid',					BaseKeyName_fcra+'::fid',						key_fcra_fid);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(BKForeclosure.Key_REO_FID_Linkids(true),	SuperKeyName_fcra+'fid_linkids',	BaseKeyName_fcra+'::fid_linkids',		key_fcra_fid_linkids);

       
VersionControl.macBuildNewLogicalKeyWithName(BKForeclosure.Key_REO_Linkids.Key,	BaseKeyName + '::linkids', key_linkids);
	 
Keys	    :=	PARALLEL(Key_did, Key_addr, Key_fid, Key_fid_linkids, key_linkids, key_fcra_did, key_fcra_addr, key_fcra_fid, key_fcra_fid_linkids);
	 	 
// Move keys to built superfile
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(SuperKeyName+'did',			        BaseKeyName+'::did',		       mv_did);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(SuperKeyName+'addr',	          BaseKeyName+'::addr',          mv_addr);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(SuperKeyName+'fid',	            BaseKeyName+'::fid',           mv_fid);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(SuperKeyName+'fid_linkids',	    BaseKeyName+'::fid_linkids',   mv_fid_linkids);

// Move LinkIDS to built superfile
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(SuperKeyName+'linkids',	BaseKeyName+'::linkids',  mv_linkids);

// -- Move FCRA Keys to Built
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName_fcra+'did',				  BaseKeyName_fcra+'::did',				   mv_fcra_did);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName_fcra+'addr',         BaseKeyName_fcra+'::addr',         mv_fcra_addr);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName_fcra+'fid',				  BaseKeyName_fcra+'::fid',				   mv_fcra_fid);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName_fcra+'fid_linkids',  BaseKeyName_fcra+'::fid_linkids',  mv_fcra_fid_linkids);


Move_keys	:=	PARALLEL(mv_did, mv_addr, mv_fid, mv_fid_linkids, mv_linkids, mv_fcra_did, mv_fcra_addr, mv_fcra_fid, mv_fcra_fid_linkids);


// Move keys to QA superfile
promotesupers.Mac_SK_Move_v2(SuperKeyName+'did',					      'Q', mv_did_qa,             2);
promotesupers.Mac_SK_Move_v2(SuperKeyName+'addr',					      'Q', mv_addr_qa,            2);
promotesupers.Mac_SK_Move_v2(SuperKeyName+'fid',					      'Q', mv_fid_qa,             2);
promotesupers.Mac_SK_Move_v2(SuperKeyName+'fid_linkids',        'Q', mv_fid_linkids_qa,     2);

// Move LinkIDS to QA superfile
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'linkids',            'Q', mv_linkids_qa,         2);

//-- Move FCRA Keys to QA
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName_fcra+'did',			      'Q',mv_fcra_did_qa,         2);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName_fcra+'addr',          'Q',mv_fcra_addr_qa,        2);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName_fcra+'fid',			      'Q',mv_fcra_fid_qa,         2);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName_fcra+'fid_linkids',   'Q',mv_fcra_fid_linkids_qa, 2);


To_qa	    :=	PARALLEL(mv_did_qa, mv_addr_qa, mv_fid_qa, mv_fid_linkids_qa, mv_linkids_qa, mv_fcra_did_qa, mv_fcra_addr_qa, mv_fcra_fid_qa, mv_fcra_fid_linkids_qa);

bldsucc := fileservices.sendemail(BKForeclosure.Roxie_Email_List,
																		'bkforeclosure_reo Weekly Roxie Keybuild Succeeded - ' + filedate,
																		'Keys:	1) thor_data400::key::bkforeclosure_reo::did_qa(thor_data400::key::bkforeclosure_reo::'+filedate+'::did)\n' +
  																  '       2) thor_data400::key::bkforeclosure_reo::addr_qa(thor_data400::key::bkforeclosure_reo::'+filedate+'::addr)\n' +	
																		'				3) thor_data400::key::bkforeclosure_reo::fid_qa(thor_data400::key::bkforeclosure_reo::'+filedate+'::fid)\n' +
																  	'				4) thor_data400::key::bkforeclosure_reo::fid_linkids_qa(thor_data400::key::bkforeclosure_reo::'+filedate+'::fid_linkids)\n' +                                																	
																		'				5) thor_data400::key::bkforeclosure_reo::linkids_qa(thor_data400::key::bkforeclosure_reo::'+filedate+'::linkids)\n' +
																		'				6) thor_data400::key::bkforeclosure_reo::fcra::did_qa(thor_data400::key::bkforeclosure_reo::fcra'+filedate+'::did)\n' +
                                    '				7) thor_data400::key::bkforeclosure_reo::fcra::addr_qa(thor_data400::key::bkforeclosure_reo::fcra'+filedate+'::addr)\n' +																		
																		'				8) thor_data400::key::bkforeclosure_reo::fcra::fid_qa(thor_data400::key::bkforeclosure_reo::fcra'+filedate+'::fid)\n' +
																		'				9) thor_data400::key::bkforeclosure_reo::fcra::fid_linkids_qa(thor_data400::key::bkforeclosure_reo::fcra'+filedate+'fid_linkids)\n' +																		
																		'      have been built and ready to be deployed to QA.');

bldfail := fileservices.sendemail('xia.sheng@LexisNexis.com',
																		'bkforeclosure_reo Weekly Roxie Keybuild Failed - ' + filedate,
																		failmessage);	
	  
	
ak := BKForeclosure.Proc_Build_REO_Autokeys(filedate);

buildkey := SEQUENTIAL(
               Keys
					    ,Move_keys
							,To_qa
							,ak
							) : 
							success(bldsucc),
							failure(bldfail);
								
RETURN buildkey;

END;