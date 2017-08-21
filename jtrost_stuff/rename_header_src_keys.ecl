import ut;

export rename_header_src_keys(string newdate) :=
function

all_src := DATASET([
{'~thor_data400::key::ak_src_index_qa',         '~thor_data400::key::header::20080301b::ak_src'},
{'~thor_data400::key::atf_src_index_qa',        '~thor_data400::key::header::20080301b::atf_src'},
{'~thor_data400::key::em_src_index_qa',         '~thor_data400::key::header::20080301b::em_src'},
{'~thor_data400::key::ms_src_index_qa',         '~thor_data400::key::header::20080301b::ms_src'},
{'~thor_data400::key::death_src_index_qa',      '~thor_data400::key::header::20080301b::death_src'},
{'~thor_data400::key::statedeath_src_index_qa', '~thor_data400::key::header::20080301b::statedeath_src'},
{'~thor_data400::key::prof_src_index_qa',       '~thor_data400::key::header::20080301b::prof_src'},
{'~thor_data400::key::propasses_src_index_qa',  '~thor_data400::key::header::20080301b::propasses_src'},
{'~thor_data400::key::propdeed_src_index_qa',   '~thor_data400::key::header::20080301b::propdeed_src'},
{'~thor_data400::key::util_src_index_qa',       '~thor_data400::key::header::20080301b::util_src'},
{'~thor_data400::key::airm_src_index_qa',       '~thor_data400::key::header::20080301b::airm_src'},
{'~thor_data400::key::for_src_index_qa',        '~thor_data400::key::header::20080301b::for_src'},
{'~thor_data400::key::dea_src_index_qa',        '~thor_data400::key::header::20080301b::dea_src'},
{'~thor_data400::key::water_src_index_qa',      '~thor_data400::key::header::20080301b::water_src'},
{'~thor_data400::key::airc_src_index_qa',       '~thor_data400::key::header::20080301b::airc_src'},
{'~thor_data400::key::eq_src_index_qa',         '~thor_data400::key::header::20080301b::eq_src'},
{'~thor_data400::key::boater_src_index_qa',     '~thor_data400::key::header::20080301b::boater_src'},
{'~thor_data400::key::header_rid_srid_qa',      '~thor_data400::key::header::20080301b::rid_srid'},
{'~thor_data400::key::lienv2_src_index_qa',     '~thor_data400::key::header::20080301b::lienv2_src'},
{'~thor_data400::key::targ_src_index_qa',       '~thor_data400::key::header::20080301b::targus_src'},
{'~thor_data400::key::bkv2_src_index_qa',       '~thor_data400::key::bkv2_src_index::20080301b::uid.src'},
{'~thor_data400::key::dlv2_src_index_qa',       '~thor_data400::key::header::20080301b::dlv2_src'},
{'~thor_data400::key::asl_src_index_qa',        '~thor_data400::key::header::20080301b::asl_src'},
{'~thor_data400::key::veh_v2_src_index_qa',     '~thor_data400::key::header::20080301b::veh_v2_src'},
{'~thor_data400::key::voters_src_index_qa',     '~thor_data400::key::header::20080301b::voters_src'}
], ut.Layout_Superkeynames.inputlayout);

return_this := ut.fLogicalKeyRenaming(all_src, false);

return return_this;

end;
