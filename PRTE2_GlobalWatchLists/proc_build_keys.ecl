IMPORT $,ut,RoxieKeyBuild,AutoKeyB2,PRTE,_control,STD, dops,PRTE2_Common, prte2;

EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo=''  ) := FUNCTION

  //filedate2 (filedate + 'A') is used for version conrol of same name logicals within V1 and V2
    filedate2 :=filedate + 'A';
 
 
 //build_key_globalwatchlistsseq
   RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_globalwatchlistsseq,
   constants.KeyName_gwl + 'seq_@version@',
   constants.KeyName_gwl + filedate2 + '::seq', build_key_globalwatchlistsseq);
  
   RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_gwl + 'seq_@version@', 
 	 constants.KeyName_gwl + filedate2 + '::seq',
   move_built_key_globalwatchlistsseq);
	
	 RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_gwl + 'seq_@version@', 
	 'Q', 
	 move_qa_key_globalwatchlistsseq);
	
	//build_key_globalwatchlistsglobalwatchlists_key
	  RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_globalwatchlistsglobalwatchlists_key,
	  constants.KeyName_gwl + 'globalwatchlists_key_@version@',
	  constants.KeyName_gwl + filedate2 + '::globalwatchlists_key', build_key_globalwatchlistsglobalwatchlists_key);
	
	  RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_gwl + 'globalwatchlists_key_@version@', 
	  constants.KeyName_gwl + filedate2 + '::globalwatchlists_key',
	  move_built_key_globalwatchlistsglobalwatchlists_key);
	 
	  RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_gwl + 'globalwatchlists_key_@version@', 
	  'Q', 
	  move_qa_key_globalwatchlistsglobalwatchlists_key);

  //build_key_globalwatchlistscountries
    RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_globalwatchlistscountries,
	  constants.KeyName_gwl + 'countries_@version@',
	  constants.KeyName_gwl + filedate2 + '::countries', build_key_globalwatchlistscountries);
	
	  RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_gwl + 'countries_@version@', 
	  constants.KeyName_gwl + filedate2 + '::countries',
	  move_built_key_globalwatchlistscountries);
	 
	  RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_gwl + 'countries_@version@', 
	  'Q', 
	  move_qa_key_globalwatchlistscountries);

  //GlobalWatchListV2Keys using "filedate"
	
  //build_key_globalwatchlists_entities
   RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_globalwatchlists_entities,
   constants.KeyName_gwl + '@version@::entities',
	 constants.KeyName_gwl + filedate + '::entities', build_key_globalwatchlists_entities);
	
   RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.KeyName_GWL +'@version@::entities', 
	 constants.KeyName_gwl +  filedate + '::entities',
	 move_built_key_globalwatchlists_entities);
	
   RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_gwl + '@version@::entities', 
	 'Q', 
	 move_qa_key_globalwatchlists_entities);

  //build_key_globalwatchlists_addlinfo
    RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_globalwatchlists_addlinfo,
	  constants.KeyName_gwl +'@version@::addlinfo',
	  constants.KeyName_gwl + filedate + '::addlinfo', build_key_globalwatchlists_addlinfo);
	
   RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_gwl + '@version@::addlinfo', 
	 constants.KeyName_gwl + filedate + '::addlinfo',
	 move_built_key_globalwatchlists_addlinfo);
	
	 RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_gwl + '@version@::addlinfo', 
	 'Q', 
	 move_qa_key_globalwatchlists_addlinfo);
	
	//build_key_globalwatchlists_address
	 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_globalwatchlists_address,
	 constants.KeyName_gwl + '@version@::address',
	 constants.KeyName_gwl + filedate + '::address', build_key_globalwatchlists_address);
	
	 RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_gwl + '@version@::address', 
	 constants.KeyName_gwl + filedate + '::address',
	 move_built_key_globalwatchlists_address);
	
	 RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_gwl + '@version@::address', 
	 'Q', 
	 move_qa_key_globalwatchlists_address);
	
	//build_key_globalwatchlists_countries2
	//**Sub File Name had to be changed to countries2 from countries beacuse countries already exists above
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_globalwatchlists_countries2,
	constants.KeyName_gwl + '@version@::countries',
	constants.KeyName_gwl + filedate + '::countries', build_key_globalwatchlists_countries2);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_gwl + '@version@::countries', 
	constants.KeyName_gwl + filedate + '::countries',
	move_built_key_globalwatchlists_countries2);
	
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_gwl + '@version@::countries', 
	'Q', 
	move_qa_key_globalwatchlists_countries2);
	
	//build_key_globalwatchlists_country_aka
	 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_globalwatchlists_country_aka,
	 constants.KeyName_gwl  + '@version@::country_aka',
	 constants.KeyName_gwl + filedate + '::country_aka', build_key_globalwatchlists_country_aka);
	
	 RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.KeyName_gwl + '@version@::country_aka', 
	 constants.KeyName_gwl + filedate + '::country_aka',
	 move_built_key_globalwatchlists_country_aka);
	
	 RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_gwl + '@version@::country_aka', 
	 'Q', 
	 move_qa_key_globalwatchlists_country_aka);
	
	//build_key_globalwatchlists_country_index
	 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_globalwatchlists_country_index,
	 constants.KeyName_gwl + '@version@::country_index',
	 constants.KeyName_gwl + filedate + '::country_index', build_key_globalwatchlists_country_index);
	
   RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_gwl + '@version@::country_index', 
	 constants.KeyName_gwl +  filedate + '::country_index',
	 move_built_key_globalwatchlists_country_index);
	
	 RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_gwl + '@version@::country_index', 
	 'Q', 
	 move_qa_key_globalwatchlists_country_index);
	
	//build_key_globalwatchlists_id_numbers
	 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_globalwatchlists_id_numbers,
	 constants.KeyName_gwl + '@version@::id_numbers',
	 constants.KeyName_gwl + filedate + '::id_numbers', build_key_globalwatchlists_id_numbers);
	
	 RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.KeyName_gwl + '@version@::id_numbers', 
	 constants.KeyName_gwl + filedate + '::id_numbers',
	 move_built_key_globalwatchlists_id_numbers);
	
	 RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_gwl + '@version@::id_numbers', 
	 'Q', 
	 move_qa_key_globalwatchlists_id_numbers);
	
	//build_key_globalwatchlists_name_index
	 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_globalwatchlists_name_index,
	 constants.KeyName_gwl + '@version@::name_index',
	 constants.KeyName_gwl + filedate + '::name_index', build_key_globalwatchlists_name_index);
	
	 RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.KeyName_gwl + '@version@::name_index', 
	 constants.KeyName_gwl +  filedate + '::name_index',
	 move_built_key_globalwatchlists_name_index);
	
	 RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_gwl + '@version@::name_index', 
	 'Q', 
	 move_qa_key_globalwatchlists_name_index);
	
	//build_key_globalwatchlists_names
	 RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_globalwatchlists_names,
	 constants.KeyName_gwl + '@version@::names',
	 constants.KeyName_gwl + filedate + '::names', build_key_globalwatchlists_names);
	
	 RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.KeyName_gwl + '@version@::names', 
	 constants.KeyName_gwl + filedate + '::names',
	 move_built_key_globalwatchlists_names);
	
	 RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_gwl + '@version@::names', 
	 'Q', 
	 move_qa_key_globalwatchlists_names);
	
	 RoxieKeyBuild.Mac_SF_BuildProcess_V2(Files.GWL_CountryTokens,constants.Base_GWL_Tokens,'country_tokens',FileDate,writefile_GWL_CT,,,true);
	
   RoxieKeyBuild.Mac_SF_BuildProcess_V2(files.GWL_NameTokens,constants.Base_GWL_Tokens,'name_tokens',FileDate,writefile_GWL_NT,,,true);


//PATRIOTS

//build_key_patriot_file_full
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_patriot_file_full,
   constants.KeyName_Patriot_File + '@version@',
		constants.KeyName_patriot + filedate + '::file_full', build_key_patriot_file_full);
		
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.KeyName_Patriot_File + '@version@', 
		constants.KeyName_patriot + filedate + '::file_full',
		move_built_key_patriot_file_full);
	
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_Patriot_File + '@version@', 
		'Q', 
	move_qa_key_patriot_file_full);

// build_key_baddids
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_baddids,
  constants.KeyName_Baddids + '@version@',
	constants.KeyName_patriot + filedate + '::baddids', build_key_baddids);
	
RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_Baddids + '@version@', 
	constants.KeyName_patriot + filedate + '::baddids',
	move_built_key_baddids);

RoxieKeyBuild.MAC_SK_Move_v2( constants.KeyName_Baddids + '@version@', 
	'Q', 
	move_qa_key_baddids);

//build_key_patriot_bdid_file
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_patriot_bdid_file,
   constants.KeyName_bdid_File + '@version@',
	constants.KeyName_patriot + filedate + '::bdid_file', build_key_patriot_bdid_file);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(  constants.KeyName_bdid_File + '@version@', 
	constants.KeyName_patriot + filedate + '::bdid_file',
	move_built_key_patriot_bdid_file);
	
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_bdid_File + '@version@', 
	'Q', 
	move_qa_key_patriot_bdid_file);
	
	//build_key_patriot_did_file
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_patriot_did_file,
	 constants.KeyName_did_File + '@version@',
	constants.KeyName_patriot + filedate + '::did_file', build_key_patriot_did_file);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_did_File + '@version@', 
	constants.KeyName_patriot + filedate + '::did_file',
	move_built_key_patriot_did_file);
	
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_did_File + '@version@', 
	'Q', 
	move_qa_key_patriot_did_file);
	
	//build_key_annotated_names
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_annotated_names,
	constants.KeyName_annotated + '@version@',
	constants.KeyName_patriot + filedate + '::annotated_names', build_key_annotated_names);

 RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_annotated + '@version@', 
	constants.KeyName_patriot + filedate + '::annotated_names',
	move_built_key_annotated_names);
	
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_annotated + '@version@', 
	'Q', 
	move_qa_key_annotated_names);
	
	//build_key_patriotbaddies_with_name
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_patriotbaddies_with_name,
	constants.KeyName_Baddies + '@version@',
	constants.KeyName_patriot + filedate + '::baddies_with_name', build_key_patriotbaddies_with_name);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.KeyName_Baddies + '@version@', 
	constants.KeyName_patriot + filedate + '::baddies_with_name',
	move_built_key_patriotbaddies_with_name);
	
	RoxieKeyBuild.MAC_SK_Move_v2(	constants.KeyName_Baddies + '@version@', 
	'Q', 
	move_qa_key_patriotbaddies_with_name);
	
//Build Cloud Keys
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_patriot_file_delta,
																							constants.Keyname_Patriot_file_delta + '@version@',
																							constants.KeyName_patriot + filedate + '::file::delta_rid', build_key_patriot_file_delta);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_patriot_baddids_delta,
																							constants.Keyname_Patriot_baddids_delta + '@version@',
																							constants.KeyName_patriot + filedate + '::baddids::delta_rid', build_key_patriotbaddies_delta);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_patriot_annotated_names_delta,
																							constants.Keyname_Patriot_annotated_names_delta + '@version@',
																							constants.KeyName_patriot + filedate + '::annotated_names::delta_rid', build_key_patriot_anontated_name_delta);
	
	build_cloud_keys := parallel(build_key_patriot_file_delta, build_key_patriotbaddies_delta, build_key_patriot_anontated_name_delta);
	
//Move Cloud Keys to Built
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.Keyname_Patriot_file_delta + '@version@', constants.KeyName_patriot + filedate + '::file::delta_rid',
																				mv_key_patriot_file_delta);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.Keyname_Patriot_baddids_delta + '@version@', 	constants.KeyName_patriot + filedate + '::baddids::delta_rid',
																					mv_key_patriotbaddids_delta);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( constants.Keyname_Patriot_annotated_names_delta + '@version@', 	constants.KeyName_patriot + filedate + '::annotated_names::delta_rid',
																				 mv_key_annotated_names_delta);
	
	mv_cloud_keys := parallel(mv_key_patriot_file_delta, mv_key_patriotbaddids_delta, mv_key_annotated_names_delta);
	
//Move Cloud Key to QA	
	RoxieKeyBuild.MAC_SK_Move_v2(constants.Keyname_Patriot_file_delta + '@version@', 	'Q', 	mv_key_patriot_file_delta_qa);
		
	RoxieKeyBuild.MAC_SK_Move_v2( constants.Keyname_Patriot_baddids_delta + '@version@',	'Q', 	mv_key_patriotbaddids_delta_qa);

	RoxieKeyBuild.MAC_SK_Move_v2(constants.Keyname_Patriot_annotated_names_delta + '@version@', 'Q', 	mv_key_annotated_names_delta_qa);
	
	qa_cloud_keys := parallel(mv_key_patriot_file_delta_qa, mv_key_patriotbaddids_delta_qa, mv_key_annotated_names_delta_qa);  
	
// DOPS Updated
		//---------- making DOPS optional and only in PROD build -------------------------------
		is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
		doDOPS 							:= is_running_in_prod AND NOT skipDOPS;
		notifyEmail 				:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
		NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');						
		PerformUpdate_gwl 	:= PRTE.UpdateVersion(constants.dataset_name_gwl,		//	Package name
																							filedate,											//	Package version
																							notifyEmail,									//	Who to email with specifics
																							l_inloc:='B',									//	B = Boca, A = Alpharetta
																							l_inenvment:='N',							//	N = Non-FCRA, F = FCRA
																							l_includeboolean :='N'		  	//	N = Do not also include boolean, Y = Include boolean, too
																							);
		
		PerformUpdate_patriot	:= PRTE.UpdateVersion(constants.dataset_name_patriot,	//	Package name
																							filedate,													//	Package version
																							notifyEmail,											//	Who to email with specifics
																							l_inloc:='B',											//	B = Boca, A = Alpharetta
																							l_inenvment:='N',									//	N = Non-FCRA, F = FCRA
																							l_includeboolean :='N'		  			//	N = Do not also include boolean, Y = Include boolean, too
																							);
		PerformUpdateOrNot := IF(doDOPS,parallel(PerformUpdate_gwl,PerformUpdate_patriot), NoUpdate);
		//--------------------------------------------------------------------------------------

		//Validate Keys
		key_validation_gwl 		 :=  output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, 
																																	prte2.Constants.ipaddr_roxie_nonfcra,
																																	constants.dataset_name_gwl, 'N'), 
																																	named(constants.dataset_name_gwl +'Validation'));
		key_validation_patriot :=  output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, 
																																	prte2.Constants.ipaddr_roxie_nonfcra,
																																	constants.dataset_name_patriot, 'N'), 
																																	named(constants.dataset_name_patriot +'Validation'));
		build_keys_process := sequential(
																		 Parallel(
																							// writefile_GWL_CT,writefile_GWL_NT,
																							build_key_globalwatchlistscountries, build_key_globalwatchlistsglobalwatchlists_key, 
																							build_key_globalwatchlistsseq, 
																					//Obsolete Keys		
																							// build_key_globalwatchlists_entities, 
																							// build_key_globalwatchlists_addlinfo,
																							// build_key_globalwatchlists_address, 
																							// build_key_globalwatchlists_countries2, 
																							// build_key_globalwatchlists_country_aka,
																							// build_key_globalwatchlists_country_index,
																							// build_key_globalwatchlists_id_numbers,
																							// build_key_globalwatchlists_name_index,
																							// build_key_globalwatchlists_names,
																						//Patriot Keys	
																							build_key_patriot_file_full,
																							build_key_baddids,
																							build_key_patriot_bdid_file,
																							build_key_patriot_did_file,
																							build_key_annotated_names,
																							build_key_patriotbaddies_with_name,
																							build_cloud_keys
																							),
																	 parallel(move_built_key_globalwatchlistscountries, 
																		  		  move_built_key_globalwatchlistsglobalwatchlists_key, 
																					  move_built_key_globalwatchlistsseq, 
																					//Obsolete Keys	 
																						 // move_built_key_globalwatchlists_entities, 
																						 // move_built_key_globalwatchlists_addlinfo, 
																						 // move_built_key_globalwatchlists_address, 
																						 // move_built_key_globalwatchlists_countries2,
																						 // move_built_key_globalwatchlists_country_aka,
																						 // move_built_key_globalwatchlists_country_index,
																						 // move_built_key_globalwatchlists_id_numbers,
																						 // move_built_key_globalwatchlists_name_index,
																						 // move_built_key_globalwatchlists_names,
																					//Patriot Keys Move	 
																						 move_built_key_patriot_file_full,
																						 move_built_key_baddids,
																						 move_built_key_patriot_bdid_file,
																						 move_built_key_patriot_did_file,
																					   move_built_key_annotated_names,
																						 move_built_key_patriotbaddies_with_name,
																						 mv_cloud_keys
																						 ),
																	Parallel(	
																					move_qa_key_globalwatchlistscountries, 
																					move_qa_key_globalwatchlistsglobalwatchlists_key, 
																					move_qa_key_globalwatchlistsseq,
																				//Obsolete Keys	 
																					 // move_qa_key_globalwatchlists_entities, 
																					 // move_qa_key_globalwatchlists_addlinfo, 
																					 // move_qa_key_globalwatchlists_address,
																					 // move_qa_key_globalwatchlists_countries2,
			                                     // move_qa_key_globalwatchlists_country_aka,
																					 // move_qa_key_globalwatchlists_country_index,
																					 // move_qa_key_globalwatchlists_id_numbers,
			                                     // move_qa_key_globalwatchlists_name_index,
																					 // move_qa_key_globalwatchlists_names,
																				//Patriot Keys QA		 
			                                     move_qa_key_patriot_file_full,
																					 move_qa_key_baddids,
			                                     move_qa_key_patriot_bdid_file,
			                                     move_qa_key_patriot_did_file,
			                                     move_qa_key_annotated_names,
			                                     move_qa_key_patriotbaddies_with_name,
																	  			 qa_cloud_keys
																				 ), 
																					parallel(key_validation_gwl,key_validation_patriot);
																					PerformUpdateOrNot
																				 );
			

	
RETURN build_keys_process;
																					
END;
