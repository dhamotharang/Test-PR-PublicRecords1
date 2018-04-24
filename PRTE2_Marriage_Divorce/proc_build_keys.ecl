IMPORT PRTE2_Marriage_Divorce, PRTE, PRTE2_Common, roxiekeybuild, ut, promotesupers, _control, AutoKeyB2,strata;

EXPORT proc_build_keys (string filedate) := FUNCTION

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.key_mar_div_did(),       Constants.KEY_PREFIX + 'did',       Constants.KEY_PREFIX + filedate + '::did',       mar_div_did_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.key_mar_div_filing_nbr,	 Constants.KEY_PREFIX + 'filing_nbr',Constants.KEY_PREFIX + filedate + '::filing_nbr',mar_div_filing_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.key_mar_div_id_main(),   Constants.KEY_PREFIX + 'id_main',   Constants.KEY_PREFIX + filedate + '::id_main',   mar_div_main_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.key_mar_div_id_search(), Constants.KEY_PREFIX + 'id_search', Constants.KEY_PREFIX + filedate + '::id_search', mar_div_search_key);

Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::did',				Constants.KEY_PREFIX + filedate + '::did',       mv_mar_div_did_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::filing_nbr',	Constants.KEY_PREFIX + filedate + '::filing_nbr',mv_mar_div_filing_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::id_main',   	Constants.KEY_PREFIX + filedate + '::id_main',   mv_mar_div_main_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::id_search', 	Constants.KEY_PREFIX + filedate + '::id_search', mv_mar_div_search_key);

// Build FCRA keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.key_mar_div_did(true),       Constants.KEY_PREFIX + 'fcra::did',       Constants.KEY_PREFIX + 'fcra::' + filedate + '::did',       mar_div_did_key_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.key_mar_div_id_main(true),   Constants.KEY_PREFIX + 'fcra::id_main',   Constants.KEY_PREFIX + 'fcra::' + filedate + '::id_main',   mar_div_main_key_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.key_mar_div_id_search(true), Constants.KEY_PREFIX + 'fcra::id_search', Constants.KEY_PREFIX + 'fcra::' + filedate + '::id_search', mar_div_search_key_fcra);

// Move FCRA keys
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::did',				Constants.KEY_PREFIX + 'fcra::' + filedate + '::did',       mv_mar_div_did_key_fcra);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::id_main',   	Constants.KEY_PREFIX + 'fcra::' + filedate + '::id_main',   mv_mar_div_main_key_fcra);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::id_search', 	Constants.KEY_PREFIX + 'fcra::' + filedate + '::id_search', mv_mar_div_search_key_fcra);

//Move to QA
Roxiekeybuild.MAC_SK_Move_v2(Constants.KEY_PREFIX + '@version@::did',       'Q',mv_mar_div_did_key_qa);
Roxiekeybuild.MAC_SK_Move_v2(Constants.KEY_PREFIX + '@version@::filing_nbr','Q',mv_mar_div_filing_key_qa);
Roxiekeybuild.MAC_SK_Move_v2(Constants.KEY_PREFIX + '@version@::id_main',   'Q',mv_mar_div_main_key_qa);
Roxiekeybuild.MAC_SK_Move_v2(Constants.KEY_PREFIX + '@version@::id_search', 'Q',mv_mar_div_search_key_qa);

Roxiekeybuild.MAC_SK_Move_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::did',       'Q',mv_mar_div_did_key_qa_fcra);
Roxiekeybuild.MAC_SK_Move_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::id_main',   'Q',mv_mar_div_main_key_qa_fcra);
Roxiekeybuild.MAC_SK_Move_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::id_search', 'Q',mv_mar_div_search_key_qa_fcra);

//DF-21803:FCRA Consumer Data Fields Depreciation
cnt_mdv2_id_main_fcra := OUTPUT(strata.macf_pops(Keys.key_mar_div_id_main(true),,,,,,FALSE,
																																['divorce_docket_volume','divorce_filing_dt',
																																	'filing_subtype','grounds_for_divorce','marriage_docket_volume','marriage_duration','marriage_duration_cd',
																																	'marriage_filing_dt','number_of_children','place_of_marriage','type_of_ceremony'
																																	]
																																	));
cnt_mdv2_id_search_fcra := OUTPUT(strata.macf_pops(Keys.key_mar_div_id_search(true),,,,,,FALSE,
																																		['age','birth_state','how_marriage_ended','last_marriage_end_dt','party_county','previous_marital_status','race','times_married','title']
																																		));


build_keys := sequential(											
													parallel(mar_div_did_key, mar_div_filing_key,	mar_div_main_key,	mar_div_search_key),
													parallel(mv_mar_div_did_key,	mv_mar_div_filing_key,	mv_mar_div_main_key,	mv_mar_div_search_key),
													parallel(mar_div_did_key_fcra,	mar_div_main_key_fcra,	 mar_div_search_key_fcra),
													parallel(mv_mar_div_did_key_fcra,	mv_mar_div_main_key_fcra,	mv_mar_div_search_key_fcra),
													parallel(mv_mar_div_did_key_qa,	mv_mar_div_filing_key_qa,	mv_mar_div_main_key_qa,	mv_mar_div_search_key_qa),
													parallel(mv_mar_div_did_key_qa_fcra,	mv_mar_div_main_key_qa_fcra,	mv_mar_div_search_key_qa_fcra)
													);

	//Build Autokeys
		AutoKeyB2.MAC_Build(PRTE2_Marriage_Divorce.Files.SearchAutokey,name.fname,name.mname,name.lname,
						zero,
						party_dob,
						zero,
						addr.prim_name,addr.prim_range,addr.st,addr.v_city_name,addr.zip5,addr.sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						lookups,
						DID,
						blank,
						zero,
						zero,
						blank,blank,blank,blank,blank,blank,
						zero,
						Constants.ak_keyname,
						Constants.ak_logical(filedate),
						outaction,false,
						Constants.ak_skipSet,true,Constants.ak_typeStr,
						true,,,zero); 

		AutoKeyB2.MAC_AcceptSK_to_QA(Constants.ak_keyname, mymove)

		build_autokeys := sequential(outaction,mymove);

//---------- making DOPS optional and only in PROD build -------------------------------
	is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
	updatedops   		 		:= PRTE.UpdateVersion('MDV2Keys',filedate,_control.MyInfo.EmailAddressNormal,'B','N','N');
	updatedops_fcra  		:= PRTE.UpdateVersion('FCRA_MDV2Keys',filedate,_control.MyInfo.EmailAddressNormal,'B','F','N');
	PerformUpdateOrNot	:= IF(is_running_in_prod,parallel(updatedops,updatedops_fcra),NoUpdate);

RETURN sequential(build_keys
									,build_autokeys
									,PerformUpdateOrNot
									,parallel(cnt_mdv2_id_main_fcra,cnt_mdv2_id_search_fcra)
									);

END;