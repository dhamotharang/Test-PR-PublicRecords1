import ut,doxie;

export rename_keys(string new_date) :=
function

all_fraudkeys := DATASET([


{'~thor_data400::key::instantid_archiving::autokey::qa::zip', '~thor_data400::key::instantid_archiving::'+new_date+'::autokey_zip'},
{'~thor_data400::key::instantid_archiving::autokey::qa::stname', '~thor_data400::key::instantid_archiving::'+new_date+'::autokey_stname'},
{'~thor_data400::key::instantid_archiving::autokey::qa::ssn2', '~thor_data400::key::instantid_archiving::'+new_date+'::autokey_ssn2'},
{'~thor_data400::key::instantid_archiving::autokey::qa::phone2','~thor_data400::key::instantid_archiving::'+new_date+'::autokey_phone2'}, 
{'~thor_data400::key::instantid_archiving::autokey::qa::name', '~thor_data400::key::instantid_archiving::'+new_date+'::autokey_name'},
{'~thor_data400::key::instantid_archiving::autokey::qa::citystname', '~thor_data400::key::instantid_archiving::'+new_date+'::autokey_citystname'},
{'~thor_data400::key::instantid_archiving::autokey::qa::address', '~thor_data400::key::instantid_archiving::'+new_date+'::autokey_address'},
{'~thor_data400::key::instantid_archiving::qa::autokey_payload','~thor_data400::key::instantid_archiving::'+new_date+'::autokey_payload'},
{'~thor_data400::key::instantid_archiving::qa::dateadded', '~thor_data400::key::instantid_archiving::'+new_date+'::dateadded'},
{'~thor_data400::key::instantid_archiving::qa::payload', '~thor_data400::key::instantid_archiving::'+new_date+'::payload'},
{'~thor_data400::key::instantid_archiving::qa::modelrisk','~thor_data400::key::instantid_archiving::'+new_date+'::modelrisk'},
{'~thor_data400::key::instantid_archiving::qa::risk', '~thor_data400::key::instantid_archiving::'+new_date+'::risk'},
{'~thor_data400::key::instantid_archiving::qa::index', '~thor_data400::key::instantid_archiving::'+new_date+'::index'},
{'~thor_data400::key::instantid_archiving::qa::redflags', '~thor_data400::key::instantid_archiving::'+new_date+'::redflags'},
{'~thor_data400::key::instantid_archiving::qa::model', '~thor_data400::key::instantid_archiving::'+new_date+'::model'},
{'~thor_data400::key::instantid_archiving::qa::verification', '~thor_data400::key::instantid_archiving::'+new_date+'::verification'},
{'~thor_data400::key::instantid_archiving::qa::report', '~thor_data400::key::instantid_archiving::'+new_date+'::report'},
{'~thor_data400::key::instantid_archiving::qa::report1', '~thor_data400::key::instantid_archiving::'+new_date+'::report1'},
{'~thor_data400::key::instantid_archiving::qa::report2', '~thor_data400::key::instantid_archiving::'+new_date+'::report2'},
{'~thor_data400::key::instantid_archiving::qa::report3', '~thor_data400::key::instantid_archiving::'+new_date+'::report3'},
{'~thor_data400::key::instantid_archiving::qa::report4', '~thor_data400::key::instantid_archiving::'+new_date+'::report4'},
{'~thor_data400::key::instantid_archiving::qa::report5', '~thor_data400::key::instantid_archiving::'+new_date+'::report5'},
{'~thor_data400::key::instantid_archiving::qa::report6', '~thor_data400::key::instantid_archiving::'+new_date+'::report6'}


], ut.Layout_Superkeynames.inputlayout);

return_this := nothor(ut.fLogicalKeyRenaming(all_fraudkeys, false));

return return_this;

end;
