IMPORT ut, VersionControl, lib_stringlib, lib_fileservices, _control, misc;

EXPORT rename_HeaderNonUpdating_keys(STRING version) := FUNCTION

all_packagekeys := DATASET([                                                                                                                                                                                                                              
{'~thor_data400::key::hdr_fname_ngram_qa','~thor_data400::key::header::'+version+'::fname_ngram'},                                                                                                                                                          
{'~thor_data400::key::hdr_lname_ngram_qa','~thor_data400::key::header::'+version+'::lname_ngram'},                                                                                                                                                          
{'~thor_data400::key::hdr_phonetic_fname_top10_qa','~thor_data400::key::header::'+version+'::phonetic_fname_top10'},                                                                                                                                        
{'~thor_data400::key::hdr_phonetic_lname_top10_qa','~thor_data400::key::header::'+version+'::phonetic_lname_top10'},                                                                                                                                        
{'~thor_data400::key::ri::name_frequency_qa','~thor_data400::key::ri::'+version+'::name_frequency'},                                                                                                                                                        
{'~thor_data400::key::sex_offender::geolink_qa','~thor_data400::key::'+version+'::sex_offender_geolink'}                                                                                                                                                   
// {'~thor_data400::key::vendor_src_info::vendor_source_qa','~thor_data400::key::vendor_src_info::'+version+'::vendor_source'}                                                                                                                                 
], ut.Layout_Superkeynames.inputlayout);

rename := ut.fLogicalKeyRenaming(all_packagekeys, false);
superfile := misc.vendor_src_superfile_contents;

vc := SEQUENTIAL(rename,superfile);
return vc;
end;
