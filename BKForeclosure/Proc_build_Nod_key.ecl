import BKForeclosure,RoxieKeyBuild,ut;

EXPORT Proc_build_Nod_key(string filedate) := 
function

  SuperKeyName 					:= '~thor_data400::key::BKForeclosure_NOD::';
	SuperKeyName_fcra			:= '~thor_data400::key::BKForeclosure_NOD::FCRA::';
  BaseKeyName  					:= SuperKeyName      +  filedate;
  BaseKeyName_fcra			:= SuperKeyName_fcra +  filedate;

  // -- Build Keys
  RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(BKForeclosure.Key_NOD_DID(),         SuperKeyName + 'did',             BaseKeyName + '::did',              key_did);
  RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(BKForeclosure.Key_NOD_Linkids.Key,   SuperKeyName + 'linkids',         BaseKeyName + '::linkids',          key_linkids);
  RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(BKForeclosure.Key_NOD_FID(),         SuperKeyName + 'fid',             BaseKeyName + '::fid',               key_fid);
  RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(BKForeclosure.Key_NOD_FID_Linkids(), SuperKeyName + 'fid_linkids',     BaseKeyName + '::fid_linkids',      key_fid_linkids);
 
  // Build FCRA Keys
  RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(BKForeclosure.Key_NOD_DID(true),					SuperKeyName_fcra+'did',					BaseKeyName_fcra+'::did',						key_fcra_did);
  RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(BKForeclosure.Key_NOD_FID(true),					SuperKeyName_fcra+'fid',					BaseKeyName_fcra+'::fid',						key_fcra_fid);
  RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(BKForeclosure.Key_NOD_FID_Linkids(true),	SuperKeyName_fcra+'fid_linkids',	BaseKeyName_fcra+'::fid_linkids',		key_fcra_fid_linkids);
   
 
  Keys	    :=	PARALLEL(Key_did, Key_linkids, Key_fid, Key_fid_linkids, key_fcra_did, key_fcra_fid, key_fcra_fid_linkids);



  // -- Move Keys to Built
  RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'did',			        BaseKeyName+'::did',		          mv_did);
  RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'linkids',	        BaseKeyName+'::linkids',          mv_linkids);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'fid',	            BaseKeyName+'::fid',              mv_fid);
  RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'fid_linkids',	    BaseKeyName+'::fid_linkids',      mv_fid_linkids);
	
  // -- Move FCRA Keys to Built
  Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName_fcra+'did',				  BaseKeyName_fcra+'::did',				  mv_fcra_did);
  Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName_fcra+'fid',				  BaseKeyName_fcra+'::fid',				  mv_fcra_fid);
  Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName_fcra+'fid_linkids',  BaseKeyName_fcra+'::fid_linkids', mv_fcra_fid_linkids);

	
  Move_keys	:=	PARALLEL(mv_did,mv_linkids,mv_fid,mv_fid_linkids,mv_fcra_did,mv_fcra_fid,mv_fcra_fid_linkids);

	
  RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'did',							    'Q',  mv_did_qa,             2);
	RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'linkids',							'Q',  mv_linkids_qa,         2);
	RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'fid',							    'Q',  mv_fid_qa,             2);
  RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'fid_linkids',		      'Q',  mv_fid_linkids_qa,     2);

  //-- Move FCRA Keys to QA
  Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName_fcra+'did',			    'Q', mv_fcra_did_qa,         2);
  Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName_fcra+'fid',			    'Q', mv_fcra_fid_qa,         2);
	Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName_fcra+'fid_linkids', 'Q', mv_fcra_fid_linkids_qa, 2);

  To_qa	    :=	PARALLEL(mv_did_qa,mv_linkids_qa,mv_fid_qa,mv_fid_linkids_qa,mv_fcra_did_qa,mv_fcra_fid_qa, mv_fcra_fid_linkids_qa);
  
	bldsucc := fileservices.sendemail(BKForeclosure.Roxie_Email_List,
																		'BKForeclosure_NOD Weekly Roxie Keybuild Succeeded - ' + filedate,
																		'Keys:	1) thor_data400::key::bkforeclosure_nod::fid_qa(thor_data400::key::bkforeclosure_nod::'+filedate+'::fid)\n' +
																		'				2) thor_data400::key::bkforeclosure_nod::did_qa(thor_data400::key::bkforeclosure_nod::'+filedate+'::did)\n' +
																		'				3) thor_data400::key::bkforeclosure_nod::fid_linkids_qa(thor_data400::key::bkforeclosure_nod::'+filedate+'::fid_linkids)\n' +
																		'				4) thor_data400::key::bkforeclosure_nod::linkids_qa(thor_data400::key::bkforeclosure_nod::'+filedate+'::linkids)\n' +
																		'				5) thor_data400::key::bkforeclosure_nod::fcra::did_qa(thor_data400::key::bkforeclosure_nod::fcra'+filedate+'::did)\n' +
																		'				6) thor_data400::key::bkforeclosure_nod::fcra::did_qa(thor_data400::key::bkforeclosure_nod::fcra'+filedate+'::fid::linkids)\n' +
																		'				7) thor_data400::key::bkforeclosure_nod::fcra::fid::linkids_qa(thor_data400::key::bkforeclosure_nod::fcra'+filedate+'::linkids)\n' +																		
																		'      have been built and ready to be deployed to QA.');

	bldfail := fileservices.sendemail('xia.sheng@LexisNexis.com',
																		'BKForeclosure_NOD Weekly Roxie Keybuild Failed - ' + filedate,
																		failmessage);	
	
	ak := BKForeclosure.Proc_Build_NOD_Autokeys(filedate);
	
	buildkey := sequential( Keys
	                       ,Move_keys
												 ,To_qa
												 ,ak
												) : 
							success(bldsucc),
							failure(bldfail);
						
	RETURN buildkey;

end;