import ut,doxie;

export rename_keys(string new_date) :=
function
all_keys := DATASET([
{'~thor_data400::key::inquiry_table::fcra::address_' + doxie.Version_SuperKey,  '~thor_data400::key::inquiry::fcra::'+new_date+'::address'},
{'~thor_data400::key::inquiry_table::fcra::did_' + doxie.Version_SuperKey,  '~thor_data400::key::inquiry::fcra::'+new_date+'::did'},
{'~thor_data400::key::inquiry_table::fcra::phone_' + doxie.Version_SuperKey,  '~thor_data400::key::inquiry::fcra::'+new_date+'::phone'},
{'~thor_data400::key::inquiry_table::fcra::ssn_' + doxie.Version_SuperKey,  '~thor_data400::key::inquiry::fcra::'+new_date+'::ssn'}

], ut.Layout_Superkeynames.inputlayout);

return_this := nothor(ut.fLogicalKeyRenaming(all_keys, false));

return return_this;

end;
