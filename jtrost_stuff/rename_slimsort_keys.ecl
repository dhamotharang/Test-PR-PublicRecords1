import ut;

export rename_slimsort_keys(string new_date) :=
function

all_slimsortkeys := DATASET([
{'~thor_data400::key::hhid_qa',                   '~thor_data400::key::header::'+new_date+'::hhid'},
{'~thor_data400::key::file_name_addr_qa',         '~thor_data400::key::header_slimsort::'+new_date+'::name_addr'},
{'~thor_data400::key::file_name_address_st_qa',   '~thor_data400::key::header_slimsort::'+new_date+'::name_address_st'},
{'~thor_data400::key::file_name_addr_nn_qa',      '~thor_data400::key::header_slimsort::'+new_date+'::name_addr_nn'},
{'~thor_data400::key::file_name_zip_qa',          '~thor_data400::key::header_slimsort::'+new_date+'::name_zip'},
{'~thor_data400::key::file_name_phone_qa',        '~thor_data400::key::header_slimsort::'+new_date+'::name_phone'},
{'~thor_data400::key::file_name_ssn_qa',          '~thor_data400::key::header_slimsort::'+new_date+'::name_ssn'},
{'~thor_data400::key::file_name_dayob_qa',        '~thor_data400::key::header_slimsort::'+new_date+'::name_dayob'},
{'~thor_data400::key::file_name_dob_qa',          '~thor_data400::key::header_slimsort::'+new_date+'::name_dob'},
{'~thor_data400::key::key_nazs4_age_qa',          '~thor_data400::key::header_slimsort::'+new_date+'::nazs4_age'},
{'~thor_data400::key::key_nazs4_ssn4_qa',         '~thor_data400::key::header_slimsort::'+new_date+'::nazs4_ssn4'},
{'~thor_data400::key::key_nazs4_zip_qa',          '~thor_data400::key::header_slimsort::'+new_date+'::nazs4_zip'},
{'~thor_data400::key::did_ssn_glb_qa',            '~thor_data400::key::header_slimsort::'+new_date+'::did_ssn_glb'},
{'~thor_data400::key::did_ssn_nonglb_qa',         '~thor_data400::key::header_slimsort::'+new_date+'::did_ssn_nonglb'},
{'~thor_data400::key::did_ssn_nonutil_qa',        '~thor_data400::key::header_slimsort::'+new_date+'::did_ssn_nonutil'},
{'~thor_data400::key::did_ssn_nonglb_nonutil_qa', '~thor_data400::key::header_slimsort::'+new_date+'::did_ssn_nonglb_nonutil'},
{'~thor_data400::key::header::ssn4_zip_yob_fi_qa','~thor_data400::key::header::'+new_date+'::ssn4_zip_yob_fi'}
], ut.Layout_Superkeynames.inputlayout);

return_this := ut.fLogicalKeyRenaming(all_slimsortkeys, false);

return return_this;

end;


