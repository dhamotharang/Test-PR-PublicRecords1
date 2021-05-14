IMPORT ut,RoxieKeyBuild,AutoKeyB2, PRTE2_LNProperty, doxie, prte, strata, _control, prte2_common, prte2, dops, orbit3;

EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION

	is_running_in_prod 			:= PRTE2_Common.Constants.is_running_in_prod;
	doDOPS 									:= is_running_in_prod AND NOT skipDOPS;
		
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ownership_did2(FALSE),
		Constants.KeyName_ln_propertyv2 + '@version@::ownership.did',
		Constants.KeyName_ln_propertyv2 + filedate + '::ownership.did', build_key_ln_propertyv2_ownership_did2);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ownership_did(FALSE),
		Constants.KeyName_ln_propertyv2 + '@version@::ownership_did',
		Constants.KeyName_ln_propertyv2 + filedate + '::ownership_did', build_key_ln_propertyv2_ownership_did); 
		
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_addllegal(TRUE),
		Constants.FCRA_KeyName_ln_propertyv2 + '@version@::addllegal.fid',
		Constants.FCRA_KeyName_ln_propertyv2 + filedate + '::addllegal.fid', build_key_ln_propertyv2fcra_addllegal_fid);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_addllegal(FALSE),
		Constants.KeyName_ln_propertyv2 + '@version@::addllegal.fid',
		Constants.KeyName_ln_propertyv2 + filedate + '::addllegal.fid', build_key_ln_propertyv2_addllegal_fid);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_addlnames(TRUE),
		Constants.FCRA_KeyName_ln_propertyv2 + '@version@::addlnames.fid',
		Constants.FCRA_KeyName_ln_propertyv2 + filedate + '::addlnames.fid', build_key_ln_propertyv2fcra_addlnames_fid);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_addlnames(FALSE),
		Constants.KeyName_ln_propertyv2 + '@version@::addlnames.fid',
		Constants.KeyName_ln_propertyv2 + filedate + '::addlnames.fid', build_key_ln_propertyv2_addlnames_fid);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_addr_search(TRUE),
		Constants.FCRA_KeyName_ln_propertyv2 + '@version@::addr_search.fid',
		Constants.FCRA_KeyName_ln_propertyv2 + filedate + '::addr_search.fid', build_key_ln_propertyv2fcra_addr_search_fid);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_addr_search(FALSE),
		Constants.KeyName_ln_propertyv2 + '@version@::addr_search.fid',
		Constants.KeyName_ln_propertyv2 + filedate + '::addr_search.fid', build_key_ln_propertyv2_addr_search_fid);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_assessor(TRUE),
		Constants.FCRA_KeyName_ln_propertyv2 + '@version@::assessor.fid',
		Constants.FCRA_KeyName_ln_propertyv2 + filedate + '::assessor.fid', build_key_ln_propertyv2fcra_assessor_fid);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_assessor(FALSE),
		Constants.KeyName_ln_propertyv2 + '@version@::assessor.fid',
		Constants.KeyName_ln_propertyv2 + filedate + '::assessor.fid', build_key_ln_propertyv2_assessor_fid);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_deed(TRUE),
		Constants.FCRA_KeyName_ln_propertyv2 + '@version@::deed.fid',
		Constants.FCRA_KeyName_ln_propertyv2 + filedate + '::deed.fid', build_key_ln_propertyv2fcra_deed_fid);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_deed(FALSE),
		Constants.KeyName_ln_propertyv2 + '@version@::deed.fid',
		Constants.KeyName_ln_propertyv2 + filedate + '::deed.fid', build_key_ln_propertyv2_deed_fid);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_search_did(TRUE),
		Constants.FCRA_KeyName_ln_propertyv2 + '@version@::search.did',
		Constants.FCRA_KeyName_ln_propertyv2 + filedate + '::search.did', build_key_ln_propertyv2fcra_search_did);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_search_did(FALSE),
		Constants.KeyName_ln_propertyv2 + '@version@::search.did',
		Constants.KeyName_ln_propertyv2 + filedate + '::search.did', build_key_ln_propertyv2_search_did);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_search_fid(TRUE),
		Constants.FCRA_KeyName_ln_propertyv2 + '@version@::search.fid',
		Constants.FCRA_KeyName_ln_propertyv2 + filedate + '::search.fid', build_key_ln_propertyv2fcra_search_fid);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_search_fid(FALSE),
		Constants.KeyName_ln_propertyv2 + '@version@::search.fid',
		Constants.KeyName_ln_propertyv2 + filedate + '::search.fid', build_key_ln_propertyv2_search_fid);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_search_fid_county(TRUE),
		Constants.FCRA_KeyName_ln_propertyv2 + '@version@::search.fid_county',
		Constants.FCRA_KeyName_ln_propertyv2 + filedate + '::search.fid_county', build_key_ln_propertyv2fcra_search_fid_county);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_search_fid_county(FALSE),
		Constants.KeyName_ln_propertyv2 + '@version@::search.fid_county',
		Constants.KeyName_ln_propertyv2 + filedate + '::search.fid_county', build_key_ln_propertyv2_search_fid_county);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_addlfaresdeed_fid,
		Constants.KeyName_ln_propertyv2 + '@version@::addlfaresdeed.fid',
		Constants.KeyName_ln_propertyv2 + filedate + '::addlfaresdeed.fid', build_key_ln_propertyv2_addlfaresdeed_fid);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_addlfarestax_fid,
		Constants.KeyName_ln_propertyv2 + '@version@::addlfarestax.fid',
		Constants.KeyName_ln_propertyv2 + filedate + '::addlfarestax.fid', build_key_ln_propertyv2_addlfarestax_fid);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_assessor_parcelnum,
		Constants.KeyName_ln_propertyv2 + '@version@::assessor.parcelnum',
		Constants.KeyName_ln_propertyv2 + filedate + '::assessor.parcelnum', build_key_ln_propertyv2_assessor_parcelnum);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_deed_parcelnum,
		Constants.KeyName_ln_propertyv2 + '@version@::deed.parcelnum',
		Constants.KeyName_ln_propertyv2 + filedate + '::deed.parcelnum', build_key_ln_propertyv2_deed_parcelnum);


	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_deed_zip_loanamt,
		Constants.KeyName_ln_propertyv2 + '@version@::deed.zip_loanamt',
		Constants.KeyName_ln_propertyv2 + filedate + '::deed.zip_loanamt', build_key_ln_propertyv2_deed_zip_loanamt);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.Key_Search_BDID,
		Constants.KeyName_ln_propertyv2 + '@version@::search.bdid',
		Constants.KeyName_ln_propertyv2 + filedate + '::search.bdid', build_key_ln_propertyv2_search_bdid);


	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.Key_LinkIds.Key,
		Constants.KeyName_ln_propertyv2 + '@version@::search.linkids',
		Constants.KeyName_ln_propertyv2 + filedate + '::search.linkids', build_key_ln_propertyv2_search_linkids);


	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_addr_full_v4(false,false),
		Constants.KeyName_ln_propertyv2 + '@version@::addr.full_v4',
		Constants.KeyName_ln_propertyv2 + filedate + '::addr.full_v4', build_key_ln_propertyv2_addr_full_v4);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_addr_full_v4(true,false),
		Constants.FCRA_KeyName_ln_propertyv2 + '@version@::addr.full_v4',
		Constants.FCRA_KeyName_ln_propertyv2 + filedate + '::addr.full_v4', build_key_ln_propertyv2fcra_addr_full_v4);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_addr_full_v4(false,true),
		Constants.KeyName_ln_propertyv2 + '@version@::addr.full_v4_no_fares',
		Constants.KeyName_ln_propertyv2 + filedate + '::addr.full_v4_no_fares', build_key_ln_propertyv2_addr_full_v4_no_fares);


	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ln_propertyv2_deedzip_avg_sales_price,
		Constants.KeyName_ln_propertyv2 + '@version@::deed::zip_avg_sales_price',
		Constants.KeyName_ln_propertyv2 + filedate + '::deed::zip_avg_sales_price', build_key_ln_propertyv2_deedzip_avg_sales_price);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_did_ownership_v4(FALSE),
		Constants.KeyName_ln_propertyv2 + '@version@::did.ownership_v4',
		Constants.KeyName_ln_propertyv2 + filedate + '::did.ownership_v4', build_key_ln_propertyv2_did_ownership_v4);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_did_ownership_v4_fcra,
		Constants.FCRA_KeyName_ln_propertyv2 + '@version@::did.ownership_v4',
		Constants.FCRA_KeyName_ln_propertyv2 + filedate + '::did.ownership_v4', build_key_ln_propertyv2fcra_did_ownership_v4);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_did_ownership_v4(TRUE),
		Constants.KeyName_ln_propertyv2 + '@version@::did.ownership_v4_no_fares',
		Constants.KeyName_ln_propertyv2 + filedate + '::did.ownership_v4_no_fares', build_key_ln_propertyv2_did_ownership_v4_no_fares);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_ownership_addr,
		Constants.KeyName_ln_propertyv2 + '@version@::ownership_addr',
		Constants.KeyName_ln_propertyv2 + filedate + '::ownership_addr', build_key_ln_propertyv2_ownership_addr);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_tax_summary,
		Constants.KeyName_ln_propertyv2 + '@version@::tax_summary',
		Constants.KeyName_ln_propertyv2 + filedate + '::tax_summary', build_key_ln_propertyv2_tax_summary);


	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.FCRA_KeyName_ln_propertyv2 + '@version@::search.fid_county', 
		Constants.FCRA_KeyName_ln_propertyv2 + filedate + '::search.fid_county',
		move_built_key_ln_propertyv2fcra_search_fid_county);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.FCRA_KeyName_ln_propertyv2 + '@version@::addllegal.fid', 
		Constants.FCRA_KeyName_ln_propertyv2 + filedate + '::addllegal.fid',
		move_built_key_ln_propertyv2fcra_addllegal_fid);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.FCRA_KeyName_ln_propertyv2 + '@version@::addlnames.fid', 
		Constants.FCRA_KeyName_ln_propertyv2 + filedate + '::addlnames.fid',
		move_built_key_ln_propertyv2fcra_addlnames_fid);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.FCRA_KeyName_ln_propertyv2 + '@version@::addr_search.fid', 
		Constants.FCRA_KeyName_ln_propertyv2 + filedate + '::addr_search.fid',
		move_built_key_ln_propertyv2fcra_addr_search_fid);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.FCRA_KeyName_ln_propertyv2 + '@version@::assessor.fid', 
		Constants.FCRA_KeyName_ln_propertyv2 + filedate + '::assessor.fid',
		move_built_key_ln_propertyv2fcra_assessor_fid);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.FCRA_KeyName_ln_propertyv2 + '@version@::deed.fid', 
		Constants.FCRA_KeyName_ln_propertyv2 + filedate + '::deed.fid',
		move_built_key_ln_propertyv2fcra_deed_fid);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.FCRA_KeyName_ln_propertyv2 + '@version@::search.did', 
		Constants.FCRA_KeyName_ln_propertyv2 + filedate + '::search.did',
		move_built_key_ln_propertyv2fcra_search_did);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.FCRA_KeyName_ln_propertyv2 + '@version@::search.fid', 
		Constants.FCRA_KeyName_ln_propertyv2 + filedate + '::search.fid',
		move_built_key_ln_propertyv2fcra_search_fid);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_ln_propertyv2 + '@version@::addlfaresdeed.fid', 
		Constants.KeyName_ln_propertyv2 + filedate + '::addlfaresdeed.fid',
		move_built_key_ln_propertyv2_addlfaresdeed_fid);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_ln_propertyv2 + '@version@::addlfarestax.fid', 
		Constants.KeyName_ln_propertyv2 + filedate + '::addlfarestax.fid',
		move_built_key_ln_propertyv2_addlfarestax_fid);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_ln_propertyv2 + '@version@::addllegal.fid', 
		Constants.KeyName_ln_propertyv2 + filedate + '::addllegal.fid',
		move_built_key_ln_propertyv2_addllegal_fid);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_ln_propertyv2 + '@version@::addlnames.fid', 
		Constants.KeyName_ln_propertyv2 + filedate + '::addlnames.fid',
		move_built_key_ln_propertyv2_addlnames_fid);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_ln_propertyv2 + '@version@::addr_search.fid', 
		Constants.KeyName_ln_propertyv2 + filedate + '::addr_search.fid',
		move_built_key_ln_propertyv2_addr_search_fid);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_ln_propertyv2 + '@version@::assessor.fid', 
		Constants.KeyName_ln_propertyv2 + filedate + '::assessor.fid',
		move_built_key_ln_propertyv2_assessor_fid);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_ln_propertyv2 + '@version@::assessor.parcelnum', 
		Constants.KeyName_ln_propertyv2 + filedate + '::assessor.parcelnum',
		move_built_key_ln_propertyv2_assessor_parcelnum);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_ln_propertyv2 + '@version@::deed.fid', 
		Constants.KeyName_ln_propertyv2 + filedate + '::deed.fid',
		move_built_key_ln_propertyv2_deed_fid);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_ln_propertyv2 + '@version@::deed.parcelnum', 
		Constants.KeyName_ln_propertyv2 + filedate + '::deed.parcelnum',
		move_built_key_ln_propertyv2_deed_parcelnum);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_ln_propertyv2 + '@version@::deed.zip_loanamt', 
		Constants.KeyName_ln_propertyv2 + filedate + '::deed.zip_loanamt',
		move_built_key_ln_propertyv2_deed_zip_loanamt);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_ln_propertyv2 + '@version@::search.bdid', 
		Constants.KeyName_ln_propertyv2 + filedate + '::search.bdid',
		move_built_key_ln_propertyv2_search_bdid);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_ln_propertyv2 + '@version@::search.did', 
		Constants.KeyName_ln_propertyv2 + filedate + '::search.did',
		move_built_key_ln_propertyv2_search_did);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_ln_propertyv2 + '@version@::search.fid', 
		Constants.KeyName_ln_propertyv2 + filedate + '::search.fid',
		move_built_key_ln_propertyv2_search_fid);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_ln_propertyv2 + '@version@::search.fid_county', 
		Constants.KeyName_ln_propertyv2 + filedate + '::search.fid_county',
		move_built_key_ln_propertyv2_search_fid_county);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_ln_propertyv2 + '@version@::search.linkids', 
		Constants.KeyName_ln_propertyv2 + filedate + '::search.linkids',
		move_built_key_ln_propertyv2_search_linkids);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_ln_propertyv2 + '@version@::addr.full_v4', 
		Constants.KeyName_ln_propertyv2 + filedate + '::addr.full_v4',
		move_built_key_ln_propertyv2_addr_full_v4);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_ln_propertyv2 + '@version@::addr.full_v4_no_fares', 
		Constants.KeyName_ln_propertyv2 + filedate + '::addr.full_v4_no_fares',
		move_built_key_ln_propertyv2_addr_full_v4_no_fares);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_ln_propertyv2 + '@version@::deed::zip_avg_sales_price', 
		Constants.KeyName_ln_propertyv2 + filedate + '::deed::zip_avg_sales_price',
		move_built_key_ln_propertyv2_deedzip_avg_sales_price);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_ln_propertyv2 + '@version@::did.ownership_v4', 
		Constants.KeyName_ln_propertyv2 + filedate + '::did.ownership_v4',
		move_built_key_ln_propertyv2_did_ownership_v4);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_ln_propertyv2 + '@version@::did.ownership_v4_no_fares', 
		Constants.KeyName_ln_propertyv2 + filedate + '::did.ownership_v4_no_fares',
		move_built_key_ln_propertyv2_did_ownership_v4_no_fares);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_ln_propertyv2 + '@version@::ownership.did', 
		Constants.KeyName_ln_propertyv2 + filedate + '::ownership.did',
		move_built_key_ln_propertyv2_ownership_did2);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_ln_propertyv2 + '@version@::ownership_addr', 
		Constants.KeyName_ln_propertyv2 + filedate + '::ownership_addr',
		move_built_key_ln_propertyv2_ownership_addr);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_ln_propertyv2 + '@version@::ownership_did', 
		Constants.KeyName_ln_propertyv2 + filedate + '::ownership_did',
		move_built_key_ln_propertyv2_ownership_did);
		
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_ln_propertyv2 + '@version@::tax_summary', 
		Constants.KeyName_ln_propertyv2 + filedate + '::tax_summary',
		move_built_key_ln_propertyv2_tax_summary);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.FCRA_KeyName_ln_propertyv2 + '@version@::addr.full_v4', 
		Constants.FCRA_KeyName_ln_propertyv2 + filedate + '::addr.full_v4',
		move_built_key_ln_propertyv2fcra_addr_full_v4);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.FCRA_KeyName_ln_propertyv2 + '@version@::did.ownership_v4', 
		Constants.FCRA_KeyName_ln_propertyv2 + filedate + '::did.ownership_v4',
		move_built_key_ln_propertyv2fcra_did_ownership_v4);
		
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.FCRA_KeyName_ln_propertyv2 + '@version@::addllegal.fid', 
		'Q', 
		move_qa_key_ln_propertyv2fcra_addllegal_fid);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.FCRA_KeyName_ln_propertyv2 + '@version@::addlnames.fid', 
		'Q', 
		move_qa_key_ln_propertyv2fcra_addlnames_fid);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.FCRA_KeyName_ln_propertyv2 + '@version@::addr_search.fid', 
		'Q', 
		move_qa_key_ln_propertyv2fcra_addr_search_fid);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.FCRA_KeyName_ln_propertyv2 + '@version@::assessor.fid', 
		'Q', 
		move_qa_key_ln_propertyv2fcra_assessor_fid);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.FCRA_KeyName_ln_propertyv2 + '@version@::deed.fid', 
		'Q', 
		move_qa_key_ln_propertyv2fcra_deed_fid);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.FCRA_KeyName_ln_propertyv2 + '@version@::search.did', 
		'Q', 
		move_qa_key_ln_propertyv2fcra_search_did);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.FCRA_KeyName_ln_propertyv2 + '@version@::search.fid', 
		'Q', 
		move_qa_key_ln_propertyv2fcra_search_fid);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.FCRA_KeyName_ln_propertyv2 + '@version@::search.fid_county', 
		'Q', 
		move_qa_key_ln_propertyv2fcra_search_fid_county);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_ln_propertyv2 + '@version@::addlfaresdeed.fid', 
		'Q', 
		move_qa_key_ln_propertyv2_addlfaresdeed_fid);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_ln_propertyv2 + '@version@::addlfarestax.fid', 
		'Q', 
		move_qa_key_ln_propertyv2_addlfarestax_fid);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_ln_propertyv2 + '@version@::addllegal.fid', 
		'Q', 
		move_qa_key_ln_propertyv2_addllegal_fid);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_ln_propertyv2 + '@version@::addlnames.fid', 
		'Q', 
		move_qa_key_ln_propertyv2_addlnames_fid);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_ln_propertyv2 + '@version@::addr_search.fid', 
		'Q', 
		move_qa_key_ln_propertyv2_addr_search_fid);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_ln_propertyv2 + '@version@::assessor.fid', 
		'Q', 
		move_qa_key_ln_propertyv2_assessor_fid);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_ln_propertyv2 + '@version@::assessor.parcelnum', 
		'Q', 
		move_qa_key_ln_propertyv2_assessor_parcelnum);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_ln_propertyv2 + '@version@::deed.fid', 
		'Q', 
		move_qa_key_ln_propertyv2_deed_fid);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_ln_propertyv2 + '@version@::deed.parcelnum', 
		'Q', 
		move_qa_key_ln_propertyv2_deed_parcelnum);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_ln_propertyv2 + '@version@::deed.zip_loanamt', 
		'Q', 
		move_qa_key_ln_propertyv2_deed_zip_loanamt);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_ln_propertyv2 + '@version@::search.bdid', 
		'Q', 
		move_qa_key_ln_propertyv2_search_bdid);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_ln_propertyv2 + '@version@::search.did', 
		'Q', 
		move_qa_key_ln_propertyv2_search_did);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_ln_propertyv2 + '@version@::search.fid', 
		'Q', 
		move_qa_key_ln_propertyv2_search_fid);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_ln_propertyv2 + '@version@::search.fid_county', 
		'Q', 
		move_qa_key_ln_propertyv2_search_fid_county);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_ln_propertyv2 + '@version@::search.linkids', 
		'Q', 
		move_qa_key_ln_propertyv2_search_linkids);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_ln_propertyv2 + '@version@::addr.full_v4', 
		'Q', 
		move_qa_key_ln_propertyv2_addr_full_v4);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_ln_propertyv2 + '@version@::addr.full_v4_no_fares', 
		'Q', 
		move_qa_key_ln_propertyv2_addr_full_v4_no_fares);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_ln_propertyv2 + '@version@::deed::zip_avg_sales_price', 
		'Q', 
		move_qa_key_ln_propertyv2_deedzip_avg_sales_price);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_ln_propertyv2 + '@version@::did.ownership_v4', 
		'Q', 
		move_qa_key_ln_propertyv2_did_ownership_v4);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_ln_propertyv2 + '@version@::did.ownership_v4_no_fares', 
		'Q', 
		move_qa_key_ln_propertyv2_did_ownership_v4_no_fares);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_ln_propertyv2 + '@version@::ownership.did', 
		'Q', 
		move_qa_key_ln_propertyv2_ownership_did2);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_ln_propertyv2 + '@version@::ownership_addr', 
		'Q', 
		move_qa_key_ln_propertyv2_ownership_addr);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_ln_propertyv2 + '@version@::ownership_did', 
		'Q', 
		move_qa_key_ln_propertyv2_ownership_did);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_ln_propertyv2 + '@version@::tax_summary', 
		'Q', 
		move_qa_key_ln_propertyv2_tax_summary);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.FCRA_KeyName_ln_propertyv2 + '@version@::addr.full_v4', 
		'Q', 
		move_qa_key_ln_propertyv2fcra_addr_full_v4);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.FCRA_KeyName_ln_propertyv2 + '@version@::did.ownership_v4', 
		'Q', 
		move_qa_key_ln_propertyv2fcra_did_ownership_v4);
		
	AutoKeyB2.MAC_Build (Files.file_search_autokey,
						person_name.fname,person_name.mname,person_name.lname,
						app_SSN,
						zero,
						phone,
						person_addr.prim_name,person_addr.prim_range,person_addr.st,person_addr.v_city_name,person_addr.zip5,person_addr.sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						lookups,
						DID,
						cname,
						app_tax_id,
						bphone,
						company_addr.prim_name,company_addr.prim_range,company_addr.st,company_addr.v_city_name,company_addr.zip5,company_addr.sec_range,
						bdid,
						constants.ak_keyname,
						constants.ak_logical(filedate),
						outaction,false,
						constants.skip_set,true,constants.ak_typeStr,
						true,,,zero) 

	AutoKeyB2.MAC_AcceptSK_to_QA(constants.ak_keyname, mymove,, constants.skip_set) 

	retval := 	sequential(outaction,mymove); 
	
//Verifying FCRA Depreciation Keys	
cnt_assessor_fid := OUTPUT(strata.macf_pops(prte2_lnproperty.keys.key_assessor(false),,,,,,FALSE,
																								['air_conditioning_code','air_conditioning_type_code','amenities1_code','amenities2_code',
																									'amenities2_code1','amenities2_code2','amenities2_code3','amenities2_code4','amenities2_code5',
																									'amenities3_code','amenities4_code','amenities5_code','assessee_name_indicator',
																									'assessee_phone_number','basement_code','building_area4','building_area4_indicator',
																									'building_area5','building_area5_indicator','building_area6','building_area6_indicator',
																									'building_area7','building_area7_indicator','building_class_code','building_condition_code',
																									'building_quality_code','census_tract','certification_date','comments',
																									'condo_project_or_building_name','contract_owner','duplicate_apn_multiple_address_id',
																									'effective_year_built','elevator','exterior_walls_code','extra_features1_area',
																									'extra_features1_indicator','extra_features2_area','extra_features2_indicator',
																									'extra_features3_area','extra_features3_indicator','extra_features4_area',
																									'extra_features4_indicator','fireplace_indicator','fireplace_number','floor_cover_code',
																									'heating_code','heating_fuel_type_code','interior_walls_code','land_dimensions',
																									'land_square_footage','legal_assessor_map_ref','legal_block','legal_brief_description',
																									'legal_city_municipality_township','legal_district','legal_land_lot','legal_land_lot',
																									'legal_lot_code','legal_lot_code','legal_lot_number','legal_lot_number','legal_phase_number',
																									'legal_phase_number','legal_sec_twn_rng_mer','legal_sec_twn_rng_mer','legal_section',
																									'legal_section','legal_subdivision_name','legal_subdivision_name','legal_tract_number',
																									'legal_tract_number','legal_unit','legal_unit','lot_size_depth_feet','lot_size_frontage_feet',
																									'mail_care_of_name_indicator','mortgage_lender_type_code','mortgage_loan_amount',
																									'mortgage_loan_type_code','neighborhood_code','new_record_type_code','no_of_plumbing_fixtures',
																									'other_buildings1_code','other_buildings2_code','other_buildings3_code',
																									'other_buildings4_code','other_buildings5_code','other_impr_building_area1',
																									'other_impr_building_area2','other_impr_building_area3','other_impr_building_area4',
																									'other_impr_building_area5','other_impr_building1_indicator','other_impr_building2_indicator',
																									'other_impr_building3_indicator','other_impr_building4_indicator',
																									'other_impr_building5_indicator','other_rooms_indicator','ownership_type_code',
																									'parking_no_of_cars','prior_recording_date','prior_transfer_date','proc_date',
																									'property_address_code','record_type_code','sale_date','school_tax_district2',
																									'school_tax_district2_indicator','school_tax_district3','school_tax_district3_indicator',
																									'second_assessee_name_indicator','sewer_code','site_influence1_code','site_influence2_code',
																									'site_influence3_code','site_influence4_code','site_influence5_code','state_code',
																									'state_land_use_code','tax_delinquent_year','tax_exemption1_code','tax_exemption2_code',
																									'tax_exemption3_code','tax_exemption4_code','tax_rate_code_area','timeshare_code',
																									'topograpy_code','transfer_date','water_code']));
																									
	cnt_deed_fid := OUTPUT(strata.macf_pops(prte2_lnproperty.keys.key_deed(false),,,,,,FALSE,
																								['addendum_flag','adjustable_rate_index','adjustable_rate_rider','arm_reset_date','assumability_rider','balloon_rider','biweekly_payment_rider',
																									'change_index','city_transfer_tax','condominium_rider','county_transfer_tax','excise_tax_number','filler_except_hawaii','fixed_step_rate_rider',
																								 'graduated_payment_rider','hawaii_condo_cpr_code','hawaii_condo_name','hawaii_tct','legal_block','legal_city_municipality_township','legal_district',
																								 'legal_land_lot','legal_lot_code','legal_lot_number','legal_phase_number','legal_sec_twn_rng_mer','legal_section','legal_subdivision_name',
																								 'legal_tract_number','legal_unit','lender_address_citystatezip','lender_address_unit_number','lender_dba_aka_name','lender_full_street_address',
																								 'lender_name_id','loan_term_months','loan_term_years','mailing_address_cd','multi_apn_flag','one_four_family_rider','partial_interest_transferred',
																								 'planned_unit_development_rider','prepayment_rider','property_address_code','rate_improvement_rider','second_home_rider',
																								 'second_td_lender_type_code','second_td_loan_amount','seller_addendum_flag','tax_id_number','timeshare_flag','total_transfer_tax']));
	
cnt_fcra_assessor_fid := OUTPUT(strata.macf_pops(prte2_lnproperty.keys.key_assessor(true),,,,,,FALSE,
																								['air_conditioning_code','air_conditioning_type_code','amenities1_code','amenities2_code',
																									'amenities2_code1','amenities2_code2','amenities2_code3','amenities2_code4','amenities2_code5',
																									'amenities3_code','amenities4_code','amenities5_code','assessee_name_indicator',
																									'assessee_phone_number','basement_code','building_area4','building_area4_indicator',
																									'building_area5','building_area5_indicator','building_area6','building_area6_indicator',
																									'building_area7','building_area7_indicator','building_class_code','building_condition_code',
																									'building_quality_code','census_tract','certification_date','comments',
																									'condo_project_or_building_name','contract_owner','duplicate_apn_multiple_address_id',
																									'effective_year_built','elevator','exterior_walls_code','extra_features1_area',
																									'extra_features1_indicator','extra_features2_area','extra_features2_indicator',
																									'extra_features3_area','extra_features3_indicator','extra_features4_area',
																									'extra_features4_indicator','fireplace_indicator','fireplace_number','floor_cover_code',
																									'heating_code','heating_fuel_type_code','interior_walls_code','land_dimensions',
																									'land_square_footage','legal_assessor_map_ref','legal_block','legal_brief_description',
																									'legal_city_municipality_township','legal_district','legal_land_lot','legal_land_lot',
																									'legal_lot_code','legal_lot_code','legal_lot_number','legal_lot_number','legal_phase_number',
																									'legal_phase_number','legal_sec_twn_rng_mer','legal_sec_twn_rng_mer','legal_section',
																									'legal_section','legal_subdivision_name','legal_subdivision_name','legal_tract_number',
																									'legal_tract_number','legal_unit','legal_unit','lot_size_depth_feet','lot_size_frontage_feet',
																									'mail_care_of_name_indicator','mortgage_lender_type_code','mortgage_loan_amount',
																									'mortgage_loan_type_code','neighborhood_code','new_record_type_code','no_of_plumbing_fixtures',
																									'other_buildings1_code','other_buildings2_code','other_buildings3_code',
																									'other_buildings4_code','other_buildings5_code','other_impr_building_area1',
																									'other_impr_building_area2','other_impr_building_area3','other_impr_building_area4',
																									'other_impr_building_area5','other_impr_building1_indicator','other_impr_building2_indicator',
																									'other_impr_building3_indicator','other_impr_building4_indicator',
																									'other_impr_building5_indicator','other_rooms_indicator','ownership_type_code',
																									'parking_no_of_cars','prior_recording_date','prior_transfer_date','proc_date',
																									'property_address_code','record_type_code','sale_date','school_tax_district2',
																									'school_tax_district2_indicator','school_tax_district3','school_tax_district3_indicator',
																									'second_assessee_name_indicator','sewer_code','site_influence1_code','site_influence2_code',
																									'site_influence3_code','site_influence4_code','site_influence5_code','state_code',
																									'state_land_use_code','tax_delinquent_year','tax_exemption1_code','tax_exemption2_code',
																									'tax_exemption3_code','tax_exemption4_code','tax_rate_code_area','timeshare_code',
																									'topograpy_code','transfer_date','water_code']));
																									
	//DF-21968 Verify followings fields are cleared in thor_data400::key::ln_propertyv2::fcra::qa::deed.fid
	cnt_fcra_deed_fid := OUTPUT(strata.macf_pops(prte2_lnproperty.keys.key_deed(true),,,,,,FALSE,
																								['addendum_flag','adjustable_rate_index','adjustable_rate_rider','arm_reset_date','assumability_rider','balloon_rider','biweekly_payment_rider',
																									'change_index','city_transfer_tax','condominium_rider','county_transfer_tax','excise_tax_number','filler_except_hawaii','fixed_step_rate_rider',
																								 'graduated_payment_rider','hawaii_condo_cpr_code','hawaii_condo_name','hawaii_tct','legal_block','legal_city_municipality_township','legal_district',
																								 'legal_land_lot','legal_lot_code','legal_lot_number','legal_phase_number','legal_sec_twn_rng_mer','legal_section','legal_subdivision_name',
																								 'legal_tract_number','legal_unit','lender_address_citystatezip','lender_address_unit_number','lender_dba_aka_name','lender_full_street_address',
																								 'lender_name_id','loan_term_months','loan_term_years','mailing_address_cd','multi_apn_flag','one_four_family_rider','partial_interest_transferred',
																								 'planned_unit_development_rider','prepayment_rider','property_address_code','rate_improvement_rider','second_home_rider',
																								 'second_td_lender_type_code','second_td_loan_amount','seller_addendum_flag','tax_id_number','timeshare_flag','total_transfer_tax']));
	
	
	//---------- making DOPS optional and only in PROD build -------------------------------													
		notifyEmail 	 	 			:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
		NoUpdate 				 			:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');						
		updatedops   		 			:= PRTE.UpdateVersion('LNPropertyV2Keys',filedate,notifyEmail,l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
		updatedops_full	 			:= PRTE.UpdateVersion('LNPropertyV2FullKeys ',filedate,notifyEmail,l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
		updatedops_fcra  			:= PRTE.UpdateVersion('FCRA_LNPropertyV2Keys',filedate,notifyEmail,l_inloc:='B',l_inenvment:='F',l_includeboolean := 'N');
		updatedops_full_fcra  := PRTE.UpdateVersion('FCRA_LNPropertyV2FullKeys ',filedate,notifyEmail,l_inloc:='B',l_inenvment:='F',l_includeboolean := 'N');
		
		PerformUpdateOrNot := IF(doDOPS,parallel(updatedops,updatedops_full, updatedops_fcra,updatedops_full_fcra),NoUpdate);
		//--------------------------------------------------------------------------------------

	
	
	key_validations :=  parallel(output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,Constants.dops_name, 'N'), named(Constants.dops_name+'Validation')),
                   output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_fcra,Constants.fcra_dops_name, 'F'), named(Constants.fcra_dops_name+'Validation')));	

create_orbit_build := parallel(
																Orbit3.proc_Orbit3_CreateBuild('PRTE - LNPropertyV2', filedate, 'N', true, true, false,  _control.MyInfo.EmailAddressNormal),
																Orbit3.proc_Orbit3_CreateBuild('PRTE - LNPropertyV2', filedate, 'F', true, true, false,  _control.MyInfo.EmailAddressNormal),
															);	
	RETURN 		sequential(		
				build_key_ln_propertyv2fcra_addllegal_fid, 
				build_key_ln_propertyv2fcra_addlnames_fid, 
				build_key_ln_propertyv2fcra_addr_search_fid, 
				build_key_ln_propertyv2fcra_assessor_fid, 
				build_key_ln_propertyv2fcra_deed_fid, 
				build_key_ln_propertyv2fcra_search_did, 
				build_key_ln_propertyv2fcra_search_fid, 
				build_key_ln_propertyv2fcra_search_fid_county, 
				build_key_ln_propertyv2_addlfaresdeed_fid, 
				build_key_ln_propertyv2_addlfarestax_fid, 
				build_key_ln_propertyv2_addllegal_fid, 
				build_key_ln_propertyv2_addlnames_fid, 
				build_key_ln_propertyv2_addr_search_fid, 
				build_key_ln_propertyv2_assessor_fid, 
				build_key_ln_propertyv2_assessor_parcelnum, 
				build_key_ln_propertyv2_deed_fid, 
				build_key_ln_propertyv2_deed_parcelnum, 
				build_key_ln_propertyv2_deed_zip_loanamt, 
				build_key_ln_propertyv2_search_bdid, 
				build_key_ln_propertyv2_search_did, 
				build_key_ln_propertyv2_search_fid, 
				build_key_ln_propertyv2_search_fid_county, 
				build_key_ln_propertyv2_search_linkids, 
				build_key_ln_propertyv2_addr_full_v4, 
				build_key_ln_propertyv2_addr_full_v4_no_fares, 
				build_key_ln_propertyv2_deedzip_avg_sales_price, 
				build_key_ln_propertyv2_did_ownership_v4, 
				build_key_ln_propertyv2_did_ownership_v4_no_fares, 
				build_key_ln_propertyv2_ownership_did, 
				build_key_ln_propertyv2_ownership_addr, 
				build_key_ln_propertyv2_ownership_did2, 
				build_key_ln_propertyv2_tax_summary, 
				build_key_ln_propertyv2fcra_addr_full_v4, 
				build_key_ln_propertyv2fcra_did_ownership_v4,
				move_built_key_ln_propertyv2fcra_addllegal_fid, 
				move_built_key_ln_propertyv2fcra_addlnames_fid, 
				move_built_key_ln_propertyv2fcra_addr_search_fid, 
				move_built_key_ln_propertyv2fcra_assessor_fid, 
				move_built_key_ln_propertyv2fcra_deed_fid, 
				move_built_key_ln_propertyv2fcra_search_did, 
				move_built_key_ln_propertyv2fcra_search_fid, 
				move_built_key_ln_propertyv2fcra_search_fid_county, 
				move_built_key_ln_propertyv2_addlfaresdeed_fid, 
				move_built_key_ln_propertyv2_addlfarestax_fid, 
				move_built_key_ln_propertyv2_addllegal_fid, 
				move_built_key_ln_propertyv2_addlnames_fid, 
				move_built_key_ln_propertyv2_addr_search_fid, 
				move_built_key_ln_propertyv2_assessor_fid, 
				move_built_key_ln_propertyv2_assessor_parcelnum, 
				move_built_key_ln_propertyv2_deed_fid, 
				move_built_key_ln_propertyv2_deed_parcelnum, 
				move_built_key_ln_propertyv2_deed_zip_loanamt, 
				move_built_key_ln_propertyv2_search_bdid, 
				move_built_key_ln_propertyv2_search_did, 
				move_built_key_ln_propertyv2_search_fid, 
				move_built_key_ln_propertyv2_search_fid_county, 
			 	move_built_key_ln_propertyv2_search_linkids, 
				move_built_key_ln_propertyv2_addr_full_v4, 
				move_built_key_ln_propertyv2_addr_full_v4_no_fares, 
				move_built_key_ln_propertyv2_deedzip_avg_sales_price, 
				move_built_key_ln_propertyv2_did_ownership_v4, 
				move_built_key_ln_propertyv2_did_ownership_v4_no_fares, 
				move_built_key_ln_propertyv2_ownership_addr, 
				move_built_key_ln_propertyv2_ownership_did2, 
				move_built_key_ln_propertyv2_ownership_did,
				move_built_key_ln_propertyv2_tax_summary, 
				move_built_key_ln_propertyv2fcra_addr_full_v4, 
				move_built_key_ln_propertyv2fcra_did_ownership_v4, 
				move_built_key_ln_propertyv2_ownership_did2,
				move_built_key_ln_propertyv2_ownership_did,
				move_qa_key_ln_propertyv2fcra_search_did,
				move_qa_key_ln_propertyv2fcra_addllegal_fid, 
				move_qa_key_ln_propertyv2fcra_addlnames_fid, 
				move_qa_key_ln_propertyv2fcra_addr_search_fid, 
				move_qa_key_ln_propertyv2fcra_assessor_fid, 
				move_qa_key_ln_propertyv2fcra_deed_fid, 
				move_qa_key_ln_propertyv2fcra_search_did, 
				move_qa_key_ln_propertyv2fcra_search_fid, 
				move_qa_key_ln_propertyv2fcra_search_fid_county, 
				move_qa_key_ln_propertyv2_addlfaresdeed_fid, 
				move_qa_key_ln_propertyv2_addlfarestax_fid, 
				move_qa_key_ln_propertyv2_addllegal_fid, 
				move_qa_key_ln_propertyv2_addlnames_fid, 
				move_qa_key_ln_propertyv2_addr_search_fid, 
				move_qa_key_ln_propertyv2_assessor_fid, 
				move_qa_key_ln_propertyv2_assessor_parcelnum, 
				move_qa_key_ln_propertyv2_deed_fid, 
				move_qa_key_ln_propertyv2_deed_parcelnum, 
				move_qa_key_ln_propertyv2_deed_zip_loanamt, 
				move_qa_key_ln_propertyv2_search_bdid, 
				move_qa_key_ln_propertyv2_search_did, 
				move_qa_key_ln_propertyv2_search_fid, 
				move_qa_key_ln_propertyv2_search_fid_county, 
				move_qa_key_ln_propertyv2_search_linkids,
				move_qa_key_ln_propertyv2_addr_full_v4, 
				move_qa_key_ln_propertyv2_addr_full_v4_no_fares, 
				move_qa_key_ln_propertyv2_deedzip_avg_sales_price, 
				move_qa_key_ln_propertyv2_did_ownership_v4, 
				move_qa_key_ln_propertyv2_did_ownership_v4_no_fares, 
				move_qa_key_ln_propertyv2_ownership_did, 
				move_qa_key_ln_propertyv2_ownership_did2, 
				move_qa_key_ln_propertyv2_ownership_addr, 
				move_qa_key_ln_propertyv2_tax_summary, 
				move_qa_key_ln_propertyv2fcra_addr_full_v4, 
				move_qa_key_ln_propertyv2fcra_did_ownership_v4,	
				retval,
				parallel(cnt_assessor_fid, cnt_deed_fid, cnt_fcra_assessor_fid,cnt_fcra_deed_fid),
				PerformUpdateOrNot,
				key_validations,
				create_orbit_build
				);

END;
