import RoxieKeyBuild, prte2_business_credit, PRTE2_Common,_control,PRTE, dops, prte2, orbit3,_control,PRTE2_BIPV2_SBFE; 

EXPORT proc_build_keys(string pversion, boolean skipDOPS=FALSE, string emailTo= '') := function


// Build Roxie Keys
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(prte2_business_credit.keys.BusinessClassification, prte2_business_credit.Constants.SuperKeyName + 'businessindustryclassification',	prte2_business_credit.Constants.KEY_PREFIX + pversion + '::businessindustryclassification', key1);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(prte2_business_credit.keys.BusinessInfo, 					prte2_business_credit.Constants.SuperKeyName + 'businessinformation',							prte2_business_credit.Constants.KEY_PREFIX + pversion + '::businessinformation', key2);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(prte2_business_credit.keys.BusinessOwner, 					prte2_business_credit.Constants.SuperKeyName + 'businessowner', 									prte2_business_credit.Constants.KEY_PREFIX + pversion + '::businessowner', key3);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(prte2_business_credit.keys.Collateral, 						prte2_business_credit.Constants.SuperKeyName + 'collateral', 			                prte2_business_credit.Constants.KEY_PREFIX + pversion + '::collateral', key4);
	
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(prte2_business_credit.keys.History, 								prte2_business_credit.Constants.SuperKeyName + 'history',			 	                  prte2_business_credit.Constants.KEY_PREFIX + pversion + '::history', key5);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(prte2_business_credit.keys.IndvOwner, 							prte2_business_credit.Constants.SuperKeyName + 'individualowner',	                prte2_business_credit.Constants.KEY_PREFIX + pversion + '::individualowner', key6);
  RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(prte2_business_credit.keys.IOInformation, 					prte2_business_credit.Constants.SuperKeyName + 'individualownerinformation',      prte2_business_credit.Constants.KEY_PREFIX + pversion + '::individualownerinformation', key7);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(prte2_business_credit.keys.MasterAccount, 					prte2_business_credit.Constants.SuperKeyName + 'masteraccount', 			            prte2_business_credit.Constants.KEY_PREFIX + pversion + '::masteraccount', key8);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(prte2_business_credit.keys.MemberSpecific, 				prte2_business_credit.Constants.SuperKeyName + 'memberspecific',                  prte2_business_credit.Constants.KEY_PREFIX + pversion + '::memberspecific', key9);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(prte2_business_credit.keys.ReleaseDates, 					prte2_business_credit.Constants.SuperKeyName + 'releasedate',                     prte2_business_credit.Constants.KEY_PREFIX + pversion + '::releasedate', key10);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(prte2_business_credit.keys.Tradeline, 							prte2_business_credit.Constants.SuperKeyName + 'tradeline',                       prte2_business_credit.Constants.KEY_PREFIX + pversion + '::tradeline', key11);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(prte2_business_credit.keys.BusinessOwnerInfo, 			prte2_business_credit.Constants.SuperKeyName + 'businessownerinformation',        prte2_business_credit.Constants.KEY_PREFIX + pversion + '::businessownerinformation', key12);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(prte2_business_credit.keys.TradelineGuarantor, 		prte2_business_credit.Constants.SuperKeyName + 'tradelineguarantor',              prte2_business_credit.Constants.KEY_PREFIX + pversion + '::tradelineguarantor', key13);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(prte2_business_credit.keys.LINKIDS.key, 					  prte2_business_credit.Constants.SuperKeyName + 'linkids', 												prte2_business_credit.Constants.KEY_PREFIX + pversion + '::linkids', key14);

//SBFE Scoring Key	
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(prte2_business_credit.keys.Key_Scoring, 						prte2_business_credit.Constants.SuperKeyName_scoring + 'scoringindex',            prte2_business_credit.Constants.KEY_PREFIX_scoring + pversion + '::scoringindex', key15);

//SBFE Best Key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_BIPV2_SBFE.Key_Linkids(pversion).Key,									prte2_business_credit.Constants.SuperKeyName + 'bipv2_best::linkids',             prte2_business_credit.Constants.KEY_PREFIX + pversion + '::bipv2_best::linkids', key16);

	build_roxie_keys := parallel(key1, key2, key3, key4, key5, key6, key7, key8, key9, key10, key11, key12, key13, key14, key15, key16);
	

// Move roxie keys to build
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(prte2_business_credit.Constants.SuperKeyName + 'businessindustryclassification',prte2_business_credit.Constants.KEY_PREFIX + pversion + '::businessindustryclassification', mv_key1);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(prte2_business_credit.Constants.SuperKeyName + 'businessinformation',						prte2_business_credit.Constants.KEY_PREFIX + pversion + '::businessinformation', mv_key2);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(prte2_business_credit.Constants.SuperKeyName + 'businessowner', 								prte2_business_credit.Constants.KEY_PREFIX + pversion + '::businessowner', mv_key3);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(prte2_business_credit.Constants.SuperKeyName + 'collateral', 			              prte2_business_credit.Constants.KEY_PREFIX + pversion + '::collateral', mv_key4);
	
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(prte2_business_credit.Constants.SuperKeyName + 'history',			 	                prte2_business_credit.Constants.KEY_PREFIX + pversion + '::history', mv_key5);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(prte2_business_credit.Constants.SuperKeyName + 'individualowner',	              prte2_business_credit.Constants.KEY_PREFIX + pversion + '::individualowner', mv_key6);
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2(prte2_business_credit.Constants.SuperKeyName + 'individualownerinformation',    prte2_business_credit.Constants.KEY_PREFIX + pversion + '::individualownerinformation', mv_key7);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(prte2_business_credit.Constants.SuperKeyName + 'masteraccount', 			          prte2_business_credit.Constants.KEY_PREFIX + pversion + '::masteraccount', mv_key8);

	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(prte2_business_credit.Constants.SuperKeyName + 'memberspecific',                prte2_business_credit.Constants.KEY_PREFIX + pversion + '::memberspecific', mv_key9);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(prte2_business_credit.Constants.SuperKeyName + 'releasedate',                   prte2_business_credit.Constants.KEY_PREFIX + pversion + '::releasedate', mv_key10);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(prte2_business_credit.Constants.SuperKeyName + 'tradeline',                     prte2_business_credit.Constants.KEY_PREFIX + pversion + '::tradeline', mv_key11);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(prte2_business_credit.Constants.SuperKeyName + 'businessownerinformation',      prte2_business_credit.Constants.KEY_PREFIX + pversion + '::businessownerinformation', mv_key12);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(prte2_business_credit.Constants.SuperKeyName + 'tradelineguarantor',            prte2_business_credit.Constants.KEY_PREFIX + pversion + '::tradelineguarantor', mv_key13);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(prte2_business_credit.Constants.SuperKeyName + 'linkids', 											prte2_business_credit.Constants.KEY_PREFIX + pversion + '::linkids', mv_key14);

//SBFE Scoring Key	
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(prte2_business_credit.Constants.SuperKeyName_scoring + 'scoringindex',          prte2_business_credit.Constants.KEY_PREFIX_scoring + pversion + '::scoringindex', mv_key15);

//SBFE Best Key
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(prte2_business_credit.Constants.SuperKeyName + 'bipv2_best::linkids',           prte2_business_credit.Constants.KEY_PREFIX + pversion + '::bipv2_best::linkids', mv_key16);
	
	Move_keys := parallel(mv_key1, mv_key2, mv_key3, mv_key4, 
											  mv_key5, mv_key6, mv_key7, mv_key8, 
												mv_key9, mv_key10, mv_key11,mv_key12,
												mv_key13, mv_key14, mv_key15, mv_key16
												);
												
	// Move roxie keys to QA
	RoxieKeyBuild.Mac_SK_Move_v2(prte2_business_credit.Constants.SuperKeyName + 'businessindustryclassification', 'Q', mv_key1_qa);
	RoxieKeyBuild.Mac_SK_Move_v2(prte2_business_credit.Constants.SuperKeyName + 'businessinformation',						'Q', mv_key2_qa);
	RoxieKeyBuild.Mac_SK_Move_v2(prte2_business_credit.Constants.SuperKeyName + 'businessowner', 									'Q', mv_key3_qa);
	RoxieKeyBuild.Mac_SK_Move_v2(prte2_business_credit.Constants.SuperKeyName + 'collateral', 			             	'Q', mv_key4_qa);
	RoxieKeyBuild.Mac_SK_Move_v2(prte2_business_credit.Constants.SuperKeyName + 'history',			 	                'Q', mv_key5_qa);
	RoxieKeyBuild.Mac_SK_Move_v2(prte2_business_credit.Constants.SuperKeyName + 'individualowner',	              'Q', mv_key6_qa);
  RoxieKeyBuild.Mac_SK_Move_v2(prte2_business_credit.Constants.SuperKeyName + 'individualownerinformation',    	'Q', mv_key7_qa);
	RoxieKeyBuild.Mac_SK_Move_v2(prte2_business_credit.Constants.SuperKeyName + 'masteraccount', 			          	'Q', mv_key8_qa);
	RoxieKeyBuild.Mac_SK_Move_v2(prte2_business_credit.Constants.SuperKeyName + 'memberspecific',                	'Q', mv_key9_qa);
	RoxieKeyBuild.Mac_SK_Move_v2(prte2_business_credit.Constants.SuperKeyName + 'releasedate',                   	'Q', mv_key10_qa);
	RoxieKeyBuild.Mac_SK_Move_v2(prte2_business_credit.Constants.SuperKeyName + 'tradeline',                     	'Q', mv_key11_qa);
	RoxieKeyBuild.Mac_SK_Move_v2(prte2_business_credit.Constants.SuperKeyName + 'businessownerinformation',      	'Q', mv_key12_qa);
	RoxieKeyBuild.Mac_SK_Move_v2(prte2_business_credit.Constants.SuperKeyName + 'tradelineguarantor',            	'Q', mv_key13_qa);
	RoxieKeyBuild.Mac_SK_Move_v2(prte2_business_credit.Constants.SuperKeyName + 'linkids', 												'Q', mv_key14_qa);
	
	RoxieKeyBuild.Mac_SK_Move_v2(prte2_business_credit.Constants.SuperKeyName_scoring + 'scoringindex',          	'Q', mv_key15_qa);
	
	RoxieKeyBuild.Mac_SK_Move_v2(prte2_business_credit.Constants.SuperKeyName + 'bipv2_best::linkids',           	'Q', mv_key16_qa);

	To_qa	:= parallel(mv_key1_qa, mv_key2_qa, mv_key3_qa, mv_key4_qa, 
										mv_key5_qa, mv_key6_qa, mv_key7_qa, mv_key8_qa, 
										mv_key9_qa, mv_key10_qa, mv_key11_qa, mv_key12_qa, 
										mv_key13_qa, mv_key14_qa, mv_key15_qa, mv_key16_qa
										);

//---------- making DOPS optional -------------------------------
	is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
	doDOPS 							:= is_running_in_prod AND NOT skipDOPS;
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops					:= PRTE.UpdateVersion(constants.dataset_name, pversion, notifyEmail,l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
	updatedops_scoring	:= PRTE.UpdateVersion(constants.dataset_name_scoring, pversion, notifyEmail,l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
	PerformUpdateOrNot	:= IF(doDOPS,parallel(updatedops, updatedops_scoring),NoUpdate);
	//----------------------------------------------------------------

	//Key Validation
	key_validation 					:=  output(dops.ValidatePRCTFileLayout(pversion, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,constants.dataset_name, 'N'), named(constants.dataset_name+'Validation'));
	key_validation_scoring 	:=  output(dops.ValidatePRCTFileLayout(pversion, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,constants.dataset_name_scoring, 'N'), named(constants.dataset_name_scoring+'Validation'));
	
	//Orbit Build
	create_orbit_build					:= Orbit3.proc_Orbit3_CreateBuild('PRTE - SBFE', pVersion, 'N', true, true, false,  _control.MyInfo.EmailAddressNormal);
	create_orbit_build_scoring	:= Orbit3.proc_Orbit3_CreateBuild('PRTE - SBFE SCORING', pVersion, 'N', true, true, false,  _control.MyInfo.EmailAddressNormal);

  Keys := SEQUENTIAL(build_roxie_keys
										 ,move_keys
										 ,to_qa
										 ,PerformUpdateOrNot
										 ,parallel(key_validation,key_validation_scoring)
										 // ,parallel(create_orbit_build,create_orbit_build_scoring)
										 );
	RETURN Keys;

END;

