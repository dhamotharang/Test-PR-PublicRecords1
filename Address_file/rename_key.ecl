import ut;

export rename_key(string new_date) :=
function

all_addresstypekeys := DATASET([
{'~thor_data400::key::address::qa::address_type','~thor_data400::key::address::'+new_date+'::address_type'}
], ut.Layout_Superkeynames.inputlayout);

return_this := ut.fLogicalKeyRenaming(all_addresstypekeys, false);

return return_this;

end;