import versioncontrol;
export Rename_Keys(

	  string	filedate
	 ,boolean pIsTesting = true

) :=
function

	all_superkeynames := DATASET([

		 {'~thor_data400::key::advo::qa::addr_search1', '~thor_data400::key::advo::@version@::addr_search1'}
		,{'~thor_data400::key::advo::qa::addr_search2', '~thor_data400::key::advo::@version@::addr_search2'}

	], versioncontrol.Layout_Superkeynames.InputLayout);

	rename_keys := versioncontrol.fLogicalKeyRenaming(all_superkeynames, pIsTesting, filedate);

	return rename_keys;
	
end;

