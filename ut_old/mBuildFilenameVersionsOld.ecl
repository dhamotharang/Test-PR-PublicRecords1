////////////////////////////////////////////////////////////////////////////////////////////
// -- mBuildFilenameVersionsOld module
// -- Parameters:
// -- 		ptemplatename	--	template filename for your build(base filename, or keyname). 
// 								i.e. '~thor_data400::base::BBB_Member'
// 
// --		pdate			--	New build date, i.e. '20060328'
//  
// -- This module will give you access to all versions of a build filename(base or key)
// -- i.e., 
// -- export Base	:= ut.mBuildFilenameVersions('~thor_data400::base::BBB_Member',	'20060328');
// -- Then,
// -- Base.Building		= '~thor_data400::base::BBB_Member_Building'
// -- Base.Built		= '~thor_data400::base::BBB_Member_Built'
// -- Base.QA			= '~thor_data400::base::BBB_Member_QA'
// -- Base.Prod			= '~thor_data400::base::BBB_Member_Prod'
// -- Base.Father		= '~thor_data400::base::BBB_Member_Father'
// -- Base.Grandfather	= '~thor_data400::base::BBB_Member_Grandfather'
// -- Base.Delete		= '~thor_data400::base::BBB_Member_Delete'
// -- Base.New			= '~thor_data400::base::BBB_Member_20060328'
// -- Base.Template		= '~thor_data400::base::BBB_Member'
// -- Base.dAll_superfilenames	= all of the above filenames(except the template and new) conveniently in a dataset
// --								for your pleasure(apply, etc)
// -- Base.dNew			= The Base.New filename in a dataset
////////////////////////////////////////////////////////////////////////////////////////////
export mBuildFilenameVersionsOld(string ptemplatename, string pdate) :=
module
	shared fVersion(string pversion) := ptemplatename + pversion;
	
	shared lbuilding	:= '_building';
	shared lbuilt		:= '_built';
	shared lqa			:= '_qa';
	shared lprod		:= '_prod';
	shared lfather		:= '_father';
	shared lgrandfather	:= '_grandfather';
	shared ldelete		:= '_delete';

	export Building		:= fVersion(lbuilding);
	export Built		:= fVersion(lbuilt);
	export QA			:= fVersion(lqa);
	export Prod			:= fVersion(lprod);
	export Father		:= fVersion(lfather);
	export Grandfather	:= fVersion(lgrandfather);
	export Delete		:= fVersion(ldelete);
	export New			:= fVersion('_' + pdate);
	export Template		:= ptemplatename;
	export Root			:= ptemplatename;

	export dAll_superfilenames := 
	DATASET([

		 (Building)
		,(Built)
		,(QA)
		,(Prod)
		,(Father)
		,(Grandfather)
		,(Delete)
		,(Template)

	], ut.Layout_Names);

	export dNew :=
	DATASET([

		 (New)

	], ut.Layout_Names);


end;

