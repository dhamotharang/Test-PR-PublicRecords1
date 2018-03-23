import roxiekeybuild,autokey,doxie,marriage_divorce_v2;

export proc_build_keys(string filedate) := function

SuperKeyName 					:= '~thor_data400::key::mar_div::';
SuperKeyName_fcra			:= '~thor_data400::key::mar_div::fcra::';
BaseKeyName  					:= SuperKeyName+filedate;
BaseKeyName_fcra			:= SuperKeyName_fcra+filedate;	


RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(marriage_divorce_v2.key_mar_div_did(),       SuperKeyName+'did',       BaseKeyName+'::did',       mar_div_did_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(marriage_divorce_v2.key_mar_div_filing_nbr,	SuperKeyName+'filing_nbr',BaseKeyName+'::filing_nbr',mar_div_filing_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(marriage_divorce_v2.key_mar_div_id_main(),   SuperKeyName+'id_main',   BaseKeyName+'::id_main',   mar_div_main_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(marriage_divorce_v2.key_mar_div_id_search(), SuperKeyName+'id_search', BaseKeyName+'::id_search', mar_div_search_key);

Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName+'@version@::did',				BaseKeyName+'::did',       mv_mar_div_did_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName+'@version@::filing_nbr',	BaseKeyName+'::filing_nbr',mv_mar_div_filing_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName+'@version@::id_main',   	BaseKeyName+'::id_main',   mv_mar_div_main_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName+'@version@::id_search', 	BaseKeyName+'::id_search', mv_mar_div_search_key);

// Build FCRA keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(marriage_divorce_v2.key_mar_div_did(true),       SuperKeyName_fcra+'did',       BaseKeyName_fcra+'::did',       mar_div_did_key_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(marriage_divorce_v2.key_mar_div_id_main(true),   SuperKeyName_fcra+'id_main',   BaseKeyName_fcra+'::id_main',   mar_div_main_key_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(marriage_divorce_v2.key_mar_div_id_search(true), SuperKeyName_fcra+'id_search', BaseKeyName_fcra+'::id_search', mar_div_search_key_fcra);

// Move FCRA keys
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName_fcra+'@version@::did',					BaseKeyName_fcra+'::did',       mv_mar_div_did_key_fcra);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName_fcra+'@version@::id_main',   	BaseKeyName_fcra+'::id_main',   mv_mar_div_main_key_fcra);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName_fcra+'@version@::id_search', 	BaseKeyName_fcra+'::id_search', mv_mar_div_search_key_fcra);

//Move to QA
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName+'@version@::did',       'Q',mv_mar_div_did_key_qa);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName+'@version@::filing_nbr','Q',mv_mar_div_filing_key_qa);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName+'@version@::id_main',   'Q',mv_mar_div_main_key_qa);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName+'@version@::id_search', 'Q',mv_mar_div_search_key_qa);

Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName_fcra+'@version@::did',       'Q',mv_mar_div_did_key_qa_fcra);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName_fcra+'@version@::id_main',   'Q',mv_mar_div_main_key_qa_fcra);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName_fcra+'@version@::id_search', 'Q',mv_mar_div_search_key_qa_fcra);

build_keys := sequential(											
													parallel(mar_div_did_key, mar_div_filing_key,	mar_div_main_key,	mar_div_search_key),
													parallel(mv_mar_div_did_key,	mv_mar_div_filing_key,	mv_mar_div_main_key,	mv_mar_div_search_key),
													parallel(mar_div_did_key_fcra,	mar_div_main_key_fcra,	 mar_div_search_key_fcra),
													parallel(mv_mar_div_did_key_fcra,	mv_mar_div_main_key_fcra,	mv_mar_div_search_key_fcra),
													parallel(mv_mar_div_did_key_qa,	mv_mar_div_filing_key_qa,	mv_mar_div_main_key_qa,	mv_mar_div_search_key_qa),
													parallel(mv_mar_div_did_key_qa_fcra,	mv_mar_div_main_key_qa_fcra,	mv_mar_div_search_key_qa_fcra)
													);

build_autokeys := marriage_divorce_v2.proc_build_autokeys(filedate);

return sequential(build_keys,build_autokeys);

end;

