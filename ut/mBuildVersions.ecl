////////////////////////////////////////////////////////////////////////////////////////////
// -- mBuildVersions module
// -- Parameters:
// -- 		ptemplatename	--	template filename for your build(base filename, or keyname). 
// 								i.e. '~thor_data400::base::BBB::@version@::Member'
// 
// --		pdate			--	New build date, i.e. '20060328'
//  
// -- This module will give you access to all versions of a build filename(base or key)
// -- i.e., 
// -- export Bdid	:= ut.mBuildVersions('~thor_data400::base::BBB::@version@::Member',	'20060328');
// -- 
////////////////////////////////////////////////////////////////////////////////////////////
export mBuildVersions(string ptemplatename, string pdate) :=
module
	shared fVersion(string pversion) := regexreplace('@version@', ptemplatename, pversion); 
	
	shared lbuilding	:= 'building';
	shared lbuilt		:= 'built';
	shared lqa			:= 'qa';
	shared lprod		:= 'prod';
	shared lfather		:= 'father';
	shared lgrandfather	:= 'grandfather';
	shared ldelete		:= 'delete';

	export Building		:= fVersion(lbuilding);
	export Built		:= fVersion(lbuilt);
	export QA			:= fVersion(lqa);
	export Prod			:= fVersion(lprod);
	export Father		:= fVersion(lfather);
	export Grandfather	:= fVersion(lgrandfather);
	export Delete		:= fVersion(ldelete);
	export New			:= fVersion(pdate);
	export Template		:= ptemplatename;

	export dAll_superfilenames := 
	DATASET([

		 (Building)
		,(Built)
		,(QA)
		,(Prod)
		,(Father)
		,(Grandfather)
		,(Delete)

	], ut.Layout_Names);

	export dNew :=
	DATASET([

		 (New)

	], ut.Layout_Names);


end;
