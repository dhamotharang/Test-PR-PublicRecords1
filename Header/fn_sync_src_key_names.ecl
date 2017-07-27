import ut;

export fn_sync_src_key_names(string new_date) := function

all_personheaderkeys := DATASET([

{'~thor_data400::key::airc_src_index_qa','~thor_data400::key::header::'+new_date+'::airc_src'}
,{'~thor_data400::key::airm_src_index_qa','~thor_data400::key::header::'+new_date+'::airm_src'}
,{'~thor_data400::key::ak_src_index_qa','~thor_data400::key::header::'+new_date+'::ak_src'}
,{'~thor_data400::key::atf_src_index_qa','~thor_data400::key::header::'+new_date+'::atf_src'}
,{'~thor_data400::key::boater_src_index_qa','~thor_data400::key::header::'+new_date+'::boater_src'}
,{'~thor_data400::key::death_src_index_qa','~thor_data400::key::header::'+new_date+'::death_src'}
,{'~thor_data400::key::dea_src_index_qa','~thor_data400::key::header::'+new_date+'::dea_src'}
,{'~thor_data400::key::em_src_index_qa','~thor_data400::key::header::'+new_date+'::em_src'}
,{'~thor_data400::key::for_src_index_qa','~thor_data400::key::header::'+new_date+'::for_src'}
,{'~thor_data400::key::ms_src_index_qa','~thor_data400::key::header::'+new_date+'::ms_src'}
,{'~thor_data400::key::nod_src_index_qa','~thor_data400::key::header::'+new_date+'::nod_src'}
,{'~thor_data400::key::prof_src_index_qa','~thor_data400::key::header::'+new_date+'::prof_src'}
,{'~thor_data400::key::statedeath_src_index_qa','~thor_data400::key::header::'+new_date+'::statedeath_src'}
,{'~thor_data400::key::targ_src_index_qa','~thor_data400::key::header::'+new_date+'::targus_src'}
,{'~thor_data400::key::util_src_index_qa','~thor_data400::key::header::'+new_date+'::util_src'}
,{'~thor_data400::key::voters_src_index_qa','~thor_data400::key::header::'+new_date+'::voters_src'}
,{'~thor_data400::key::water_src_index_qa','~thor_data400::key::header::'+new_date+'::water_src'}
,{'~thor_data400::key::asl_src_index_qa','~thor_data400::key::header::'+new_date+'::asl_src'}
,{'~thor_data400::key::certegy_src_index_qa','~thor_data400::key::header::'+new_date+'::certegy_src'}
,{'~thor_data400::key::exprnph_src_index_qa','~thor_data400::key::header::'+new_date+'::exprnph_src'}

], ut.Layout_Superkeynames.inputlayout);

return_this := ut.fLogicalKeyRenaming(all_personheaderkeys, false);

return return_this;

end;