import doxie, ut;
export Proc_Rename_AutoKeys(string keydate) := function

//Change date to build date to rename these keys.
all_superkeynames := DATASET([{'~thor_data400::key::txbus::autokey::qa::fein2','~thor_data400::key::txbus::autokey::'+keydate+'::fein2'},
											{'~thor_data400::key::txbus::autokey::qa::phone2','~thor_data400::key::txbus::autokey::'+keydate+'::phone2'},
											{'~thor_data400::key::txbus::autokey::qa::ssn2','~thor_data400::key::txbus::autokey::'+keydate+'::ssn2'}
], ut.Layout_Superkeynames.inputlayout);

//ut.fLogicalKeyRenaming(all_superkeynames);                  // just outputs a dataset, no renaming

retval := ut.fLogicalKeyRenaming(all_superkeynames, false);         // renames the keys

return retval;
end;