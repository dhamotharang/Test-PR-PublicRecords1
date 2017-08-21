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
// -- export Base	:= ut.mBuildFilenameVersions('~thor_data400::base::BBB_Member',	'20060328', '~thor_data400::base::BBB::@version@::Member');
// -- Then,
// -- Base.Building		= '~thor_data400::base::BBB_Member_Building'
// -- Base.Built		= '~thor_data400::base::BBB_Member_Built'
// -- Base.QA			= '~thor_data400::base::BBB_Member_QA'
// -- Base.Prod			= '~thor_data400::base::BBB_Member_Prod'
// -- Base.Father		= '~thor_data400::base::BBB_Member_Father'
// -- Base.Grandfather	= '~thor_data400::base::BBB_Member_Grandfather'
// -- Base.Delete		= '~thor_data400::base::BBB_Member_Delete'
// -- Base.New			= '~thor_data400::base::BBB::20060328::Member'
// -- Base.Template		= '~thor_data400::base::BBB_Member'
// -- Base.dAll_superfilenames	= all of the above filenames(except the template and new) conveniently in a dataset
// --								for your pleasure(apply, etc)
// -- Base.dNew			= The Base.New filename in a dataset
// -- Base.dBoth		= all filenames(super and logical) in a dataset
////////////////////////////////////////////////////////////////////////////////////////////
export mBuildFilenameVersionsOld(string ptemplatename, string pdate = '', string pNewTemplatefilename = '', unsigned1 pnGenerations = 3) :=
module

	shared fVersion		(string pversion) := ptemplatename + '_' + pversion;
	shared fVersionNew(string pversion) := regexreplace('@version@', pNewTemplatefilename, pversion); 
	
	shared lbuilding				:= 'building'									;
	shared lbuilt						:= 'built'										;
	shared lqa							:= 'qa'												;
	shared lprod						:= 'prod'											;
	shared lfather					:= 'father'										;
	shared lgrandfather			:= 'grandfather'							;
	shared ldelete					:= 'delete'										;
	shared lBusinessHeader	:= 'Using_In_Business_Header'	;
	shared lPeopleHeader		:= 'Using_In_People_Header'		;

	export Building				:= fVersion		(lbuilding				);
	export Built					:= fVersion		(lbuilt						);
	export QA							:= fVersion		(lqa							);
	export Prod						:= fVersion		(lprod						);
	export Father					:= fVersion		(lfather					);
	export Grandfather		:= fVersion		(lgrandfather			);
	export Delete					:= fVersion		(ldelete					);
	export BusinessHeader	:= fVersion		(lBusinessHeader	);
	export PeopleHeader		:= fVersion		(lPeopleHeader		);
	export New						:= fVersionNew(pdate						);
	export Old						:= fVersion		(pdate						);
	export Template				:= ptemplatename						;
	export TemplateNew		:= pNewTemplatefilename			;
	export Root						:= ptemplatename						;

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

	], Layout_Names);

	export dNew :=
	DATASET([

		 (New)

	], Layout_Names);

	export dBoth :=
	dataset([
	
		{(New), (dAll_superfilenames), (Template), (pNewTemplatefilename), (pdate),(pnGenerations), false}
	
	], layout_versions.builds);

	export dAll_filenames := dBoth;
	
end;

