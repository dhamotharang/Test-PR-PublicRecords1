import roxiekeybuild,autokey,doxie,marriage_divorce_v2, DOPSGrowthCheck, dops;

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

GetDops := dops.GetDeployedDatasets('P', 'B', 'F');
OnlyMDV2:=GetDops(datasetname='FCRA_MDV2Keys');

father_filedate :=  OnlyMDV2[1].buildversion;																		
set of string InputSet_MDV2_id_main := ['record_id','dt_first_seen','dt_vendor_first_reported','filing_type','filing_subtype','vendor','source_file','state_origin','number_of_children','marriage_filing_dt','marriage_dt','marriage_city','marriage_county','place_of_marriage','type_of_ceremony','marriage_filing_number','marriage_docket_volume','divorce_filing_dt','divorce_dt','divorce_docket_volume','divorce_filing_number','divorce_city','divorce_county','grounds_for_divorce','marriage_duration_cd','marriage_duration','persistent_record_id'];
set of string InputSet_MDV2_id_search := ['record_id','which_party','did','dt_first_seen','dt_vendor_first_reported','vendor','party_type','name_sequence','title','fname','mname','lname','name_suffix','nameasis_name_format','nameasis','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','dob','age','birth_state','race','party_county','previous_marital_status','how_marriage_ended','times_married','last_marriage_end_dt','persistent_record_id'];

set of string Persistent_ID_MDV2 := ['filing_subtype','state_origin','party1_name','party1_alias','party1_dob','party1_birth_state','party1_age','party1_race','party1_addr1','party1_csz','party1_county','party1_previous_marital_status','party1_how_marriage_ended','party1_times_married','party1_last_marriage_end_dt','party2_name','party2_alias','party2_dob','party2_birth_state','party2_age','party2_race','party2_addr1','party2_csz','party2_county','party2_previous_marital_status','party2_how_marriage_ended','party2_times_married','party2_last_marriage_end_dt','number_of_children','marriage_filing_dt','marriage_dt','marriage_city','marriage_county','place_of_marriage','type_of_ceremony','marriage_filing_number','marriage_docket_volume','divorce_filing_dt','divorce_dt','divorce_docket_volume','divorce_filing_number','divorce_city','divorce_county','grounds_for_divorce','marriage_duration_cd','marriage_duration'	];	
DeltaCommands:=sequential(
DOPSGrowthCheck.CalculateStats(	'FCRA_MDV2Keys','marriage_divorce_v2.key_mar_div_id_main(true)','key_MDV2_main_FCRA','~thor_data400::key::mar_div::fcra::'+filedate+'::id_main','record_id','persistent_record_id','','','','',filedate,father_filedate,true,true),
DOPSGrowthCheck.CalculateStats(	'FCRA_MDV2Keys','marriage_divorce_v2.key_mar_div_id_search(true)','key_MDV2_search_FCRA','~thor_data400::key::mar_div::fcra::'+filedate+'::id_search','record_id,which_party','persistent_record_id','','','','',filedate,father_filedate,true,true),
DOPSGrowthCheck.DeltaCommand('~thor_data400::key::mar_div::fcra::'+filedate+'::id_main', '~thor_data400::key::mar_div::fcra::'+father_filedate+'::id_main', 'FCRA_MDV2Keys', 'key_MDV2_main_FCRA', 'marriage_divorce_v2.key_mar_div_id_main(true)', 'persistent_record_id', filedate, father_filedate, InputSet_MDV2_id_main,true,true),
DOPSGrowthCheck.DeltaCommand('~thor_data400::key::mar_div::fcra::'+filedate+'::id_search', '~thor_data400::key::mar_div::fcra::'+father_filedate+'::id_search', 'FCRA_MDV2Keys', 'key_MDV2_search_FCRA', 'marriage_divorce_v2.key_mar_div_id_search(true)', 'persistent_record_id', filedate, father_filedate, InputSet_MDV2_id_search,true,true),
DOPSGrowthCheck.ChangesByField('~thor_data400::key::mar_div::fcra::'+filedate+'::id_main','~thor_data400::key::mar_div::fcra::'+father_filedate+'::id_main','FCRA_MDV2Keys','key_MDV2_main_FCRA','marriage_divorce_v2.key_mar_div_id_main(true)','persistent_record_id','',filedate,father_filedate,true,true),
DOPSGrowthCheck.ChangesByField('~thor_data400::key::mar_div::fcra::'+filedate+'::id_search','~thor_data400::key::mar_div::fcra::'+father_filedate+'::id_search','FCRA_MDV2Keys','key_MDV2_search_FCRA','marriage_divorce_v2.key_mar_div_id_search(true)','persistent_record_id','',filedate,father_filedate,true,true),
DOPSGrowthCheck.PersistenceCheck('~thor_data400::base::mar_div::base',  '~thor_data400::base::mar_div::base_father',  'FCRA_MDV2Keys',  'key_MDV2_main_FCRA',  'marriage_divorce_v2.layout_mar_div_base',  'persistent_record_id',  Persistent_ID_MDV2,  Persistent_ID_MDV2,  filedate,  father_filedate,true,  false),
DOPSGrowthCheck.PersistenceCheck('~thor_data400::base::mar_div::base',  '~thor_data400::base::mar_div::base_father',  'FCRA_MDV2Keys',  'key_MDV2_search_FCRA',  'marriage_divorce_v2.layout_mar_div_base',  'persistent_record_id',  Persistent_ID_MDV2,  Persistent_ID_MDV2,  filedate,  father_filedate,true,  false)
);

return sequential(build_keys,build_autokeys,DeltaCommands);

end;

