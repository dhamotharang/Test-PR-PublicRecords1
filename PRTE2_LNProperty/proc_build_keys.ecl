IMPORT ut,RoxieKeyBuild,AutoKeyB2, PRTE2_LNProperty, doxie;

EXPORT proc_build_keys(string filedate) := FUNCTION

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


	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.key_search_fid_linkids,
		Constants.KeyName_ln_propertyv2 + '@version@::search.fid_linkids',
		Constants.KeyName_ln_propertyv2 + filedate + '::search.fid_linkids', build_key_ln_propertyv2_search_fid_linkids);

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

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( Constants.KeyName_ln_propertyv2 + '@version@::search.fid_linkids', 
		Constants.KeyName_ln_propertyv2 + filedate + '::search.fid_linkids',
		move_built_key_ln_propertyv2_search_fid_linkids);

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

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.KeyName_ln_propertyv2 + '@version@::search.fid_linkids', 
		'Q', 
		move_qa_key_ln_propertyv2_search_fid_linkids);

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
				build_key_ln_propertyv2_search_fid_linkids, 
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
				move_built_key_ln_propertyv2_search_fid_linkids, 
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
				move_qa_key_ln_propertyv2_search_fid_linkids, 
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
				move_qa_key_ln_propertyv2fcra_did_ownership_v4	
				,retval );

END;
