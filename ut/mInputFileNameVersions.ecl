////////////////////////////////////////////////////////////////////////////////////////////
// -- mInputFileNameVersions module
// -- Parameters:
// -- 		ptemplatename	--	template filename for your Input. 
// 								i.e. '~thor_data400::in_rolling::BBB::@version@::Member'
// 
// -- This module will give you access to all versions of an Input filename.
// -- i.e., 
// -- export Input	:= mInputFileNameVersions('~thor_data400::in_rolling::BBB::@version@::Member');
// -- Then,
// -- Input.Root			= '~thor_data400::in_rolling::BBB::Member'
// -- Input.Sprayed			= '~thor_data400::in_rolling::BBB::Sprayed::Member'
// -- Input.Using			= '~thor_data400::in_rolling::BBB::Using::Member'
// -- Input.Used			= '~thor_data400::in_rolling::BBB::Used::Member'
// -- Input.Delete	 		= '~thor_data400::in_rolling::BBB::Delete::Member'
// -- Input.Template		= '~thor_data400::in_rolling::BBB::@version@::Member'
// -- Input.New('20060328') = '~thor_data400::in_rolling::BBB::20060328::Member'
// -- 
// -- Input.dAll_superfilenames	= all of the above filenames(except the template and new) conveniently in a dataset
// --								for your pleasure(for use in apply, etc)
// -- Input.dNew			= The Input.New filename in a dataset
////////////////////////////////////////////////////////////////////////////////////////////
export mInputFileNameVersions(string ptemplatename) :=
module

	shared fVersion(string pversion) := regexreplace('@version@', ptemplatename, pversion); 
	
	shared lsprayed		:= 'sprayed';
	shared lusing		:= 'using';
	shared lused		:= 'used';
	shared ldelete		:= 'delete';

	export Root									:= regexreplace('::@version@', ptemplatename, '');
	export Sprayed								:= fVersion(lsprayed);
	export Using								:= fVersion(lusing);
	export Used									:= fVersion(lused);
	export Delete								:= fVersion(ldelete);
	export Template								:= ptemplatename;
	export New(string pdate, integer pcnt = 0)	:= if(pcnt = 0, fVersion(pdate), fVersion(pdate) + '_' + (string) pcnt);

	export dAll_superfilenames := 
	DATASET([

		 (Root)
		,(Sprayed)
		,(Using)
		,(Used)
		,(Delete)

	], ut.Layout_Names);
	
	export dNew(string pdate, integer pcnt = 0) :=
	DATASET([

		 (New(pdate, pcnt))

	], ut.Layout_Names);

end;