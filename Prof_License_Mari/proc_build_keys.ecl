import RoxieKeyBuild,autokey,ut,Prof_License_Mari,PRTE,strata,dops;


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

//DF-21891 Verify followings fields are cleared in thor_data400::key::proflic_mari::fcra::qa::did
cnt_mari_fcra := OUTPUT(strata.macf_pops(Prof_License_Mari.key_did(true),,,,,,FALSE,
																								 ['active_flag','addl_license_spec','addr_addr1_1','addr_addr2_1','addr_bus_ind',
																								  'addr_carrier_rte_1','addr_city_1','addr_cntry_1','addr_cnty_1','addr_delivery_pt_1',
																									'addr_id_1','addr_state_1','addr_zip4_1','addr_zip5_1','affil_key','affil_type_cd',
																									'agency_id','agency_status','append_busaceaid','append_busaddrfirst','append_busaddrlast',
																									'append_busrawaid','append_mailaddrfirst','append_mailaddrlast','birth_dte','bk_class',
																									'bk_class_desc','brkr_license_nbr','brkr_license_nbr_type','bus_ace_fips_st',
																									'bus_addr_suffix','bus_cart','bus_chk_digit','bus_county','bus_cr_sort_sz','bus_dpbc',
																									'bus_err_stat','bus_geo_blk','bus_geo_lat','bus_geo_long','bus_geo_match','bus_lot',
																									'bus_lot_order','bus_msa','bus_p_city_name','bus_postdir','bus_predir','bus_prim_name',
																									'bus_prim_range','bus_rec_type','bus_sec_range','bus_state','bus_unit_desig',
																									'bus_v_city_name','bus_zip4','bus_zip5','business_type','charter','cln_license_nbr',
																									'cmc_slpk','cont_education_ernd','cont_education_req','cont_education_term','credential',
																									'dba_flag','disp_type_cd','disp_type_desc','displinary_action','docket_id',
																									'domestic_off_nbr','email','fed_rssd','federal_regulator','foreign_nmls_id',
																									'foreign_off_nbr','gen_nbr','gender','genlink','hcr_location','hcr_rssd','hqtr_city',
																									'hqtr_name','inst_beg_dte','is_authorized_conduct','is_authorized_license','license_id',
																									'license_nbr_contact','location_type','match_id','mltreckey','name_company',
																									'name_company_dba','name_contact_first','name_contact_last','name_contact_mid',
																									'name_contact_nick','name_contact_prefx','name_contact_sufx','name_contact_ttl',
																									'name_dba','name_dba_orig','name_dba_prefx','name_dba_sufx','name_format',
																									'name_mari_dba','name_mari_org','name_nick','name_office','name_org','name_org_orig',
																									'name_org_prefx','name_org_sufx','name_type','off_license_nbr','off_license_nbr_type',
																									'office_parse','old_cmc_slpk','ooc_ind_1','ooc_ind_2','origin_cd','origin_cd_desc',
																									'pcmc_slpk','phn_contact','phn_contact_ext','phn_contact_fax','phn_fax_1','phn_fax_2',
																									'phn_mari_1','phn_mari_2','phn_mari_fax_1','phn_mari_fax_2','phn_phone_1','phn_phone_2',
																									'prev_cmc_slpk','prev_mltreckey','prev_pcmc_slpk','prev_primary_key','prov_stat',
																									'provnote_1','provnote_2','provnote_3','rec_key','reg_agent','regulator','research_ind',
																									'result_cd_1','result_cd_2','site_location','ssn_taxid_1','ssn_taxid_2','start_dte',
																									'std_prof_cd','store_nbr','store_nbr_dba','sud_key_1','sud_key_2','tax_type_1',
																									'tax_type_2','title','type_cd','url','violation_case_nbr','violation_desc','violation_dte']));

// -- Build Autokeys
build_autokeys := Prof_License_Mari.proc_build_autokeys(filedate);


// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION 
updatedops   		:= dops.updateversion('MARIKeys',filedate,'terri.hardy-george@lexisnexis.com',,'N',);
updatedops_fcra  := dops.updateversion('FCRA_MARIKeys',filedate,'terri.hardy-george@lexisnexis.com',,'F',);

// -- Build PRTE Keys
build_prte     := PRTE.Proc_Build_MARI_Keys(filedate);

// -- Actions
buildKey	:=	sequential(Keys
												,Move_keys
												,to_qa
												,cnt_mari_fcra
												,build_autokeys
												,parallel(updatedops,updatedops_fcra)
                        // ,build_prte
												);	

return	buildKey;

end;



 
 
 
 