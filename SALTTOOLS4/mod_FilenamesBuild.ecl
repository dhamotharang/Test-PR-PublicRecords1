////////////////////////////////////////////////////////////////////////////////////////////
// -- mod_FilenamesBuild module
// -- Parameters:
// -- 		ptemplatename	--	template filename for your build(base filename, or keyname). 
// 								i.e. '~thor_data400::base::BBB::@version@::Member'
// 
// --		pdate			--	New build date, i.e. '20060328'
//  
// -- This module will give you access to all versions of a build filename(base or key)
// -- i.e., 
// -- export Base	:= ut.mod_FilenamesBuild('~thor_data400::base::BBB::@version@::Member',	'20060328');
// -- Then,
// -- Base.Building		 = '~thor_data400::base::BBB::Building::Member'
// -- Base.Built		 = '~thor_data400::base::BBB::Built::Member'
// -- Base.QA			 = '~thor_data400::base::BBB::QA::Member'
// -- Base.Prod			 = '~thor_data400::base::BBB::Prod::Member'
// -- Base.Father		 = '~thor_data400::base::BBB::Father::Member'
// -- Base.Grandfather	 = '~thor_data400::base::BBB::Grandfather::Member'
// -- Base.Delete		 = '~thor_data400::base::BBB::Delete::Member'
// -- Base.New			 = '~thor_data400::base::BBB::20060328::Member'
// -- Base.Template		 = '~thor_data400::base::BBB::@version@::Member'
// -- Base.dAll_superfilenames	= all of the above filenames(except the template and new) conveniently in a dataset
// --								for your pleasure(apply, etc)
// -- Base.dNew			= The Base.New filename in a dataset
// -- Base.dBoth		= all filenames(super and logical) in a dataset so you can tie them together
////////////////////////////////////////////////////////////////////////////////////////////
export mod_FilenamesBuild(
	 string			pTemplatefilename
	,string			pdate									= ''
	,unsigned1	pnGenerations					= 3
) :=
module
	shared fSuperVersion		(string pversion) := if(regexfind('@version@', pTemplatefilename,nocase)
																						,regexreplace('@version@', pTemplatefilename, pversion,nocase)
																						,pTemplatefilename + if(pversion != '', '_' + pversion,'')
																					);
	shared fLogicalVersion	(string pversion) := regexreplace('@version@', pTemplatefilename, pversion,nocase);
	
	export fVersion	(string pversion) := 	if(regexfind('^[[:alpha:]_]*$',pversion,nocase)
																					,fSuperVersion	(pversion)	// if version is all alpha chars('built','qa',etc) use old naming convention
																					,fLogicalVersion(pversion)	// else, assume logical file(new naming convention)
																				);
	
	shared GetLogicalSubFile	(string pversion) := 
	function
		filename := fVersion(pversion);
		return 
		map( (not fileservices.superfileexists		(filename))
				  and fileservices.fileexists					(filename)					=> filename
				,			fileservices.superfileexists		(filename)
				 and	fileservices.GetSuperFileSubName(filename,1) != ''	=> '~' + fileservices.GetSuperFileSubName(filename,1)
				,																														 ''
		);
	end;
	
	shared GetVersion			(string filename) := regexfind('[[:digit:]]{8}[[:alpha:]]?',filename,0);
	
	shared GetFileVersion(string pfilename) := GetVersion(GetLogicalSubFile(pfilename));									
	shared lbuilding					:= 'building'									;
	shared lbuilt							:= 'built'										;
	shared lqa								:= 'qa'												;
	shared lprod							:= 'prod'											;
	shared lfather						:= 'father'										;
	shared lgrandfather				:= 'grandfather'							;
	shared lgreatgrandfather	:= 'greatgrandfather'					;
	shared ldelete						:= 'delete'										;
	shared lBusinessHeader		:= 'Using_In_Business_Header'	;
	shared lPeopleHeader			:= 'Using_In_People_Header'		;
	// Superfiles, logical files
	export Building					:= fSuperVersion(lbuilding					);
	export Built						:= fSuperVersion(lbuilt							);
	export QA								:= fSuperVersion(lqa								);
	export Prod							:= fSuperVersion(lprod							);
	export Father						:= fSuperVersion(lfather						);
	export Grandfather			:= fSuperVersion(lgrandfather				);
	export GreatGrandfather	:= fSuperVersion(lgreatgrandfather	);
	export Delete						:= fSuperVersion(ldelete						);
	export BusinessHeader		:= fSuperVersion(lBusinessHeader		);
	export PeopleHeader			:= fSuperVersion(lPeopleHeader			);
	export New							:= fLogicalVersion(pdate						);
	export Logical					:= fLogicalVersion(pdate						);
	export Old							:= fVersion				(pdate						);
	export Template					:= pTemplatefilename									;
	export Root							:= pTemplatefilename									;
	// new naming convention superfiles
	export NewBuilding					:= fLogicalVersion(lbuilding					);
	export NewBuilt							:= fLogicalVersion(lbuilt							);
	export NewQA								:= fLogicalVersion(lqa								);
	export NewProd							:= fLogicalVersion(lprod							);
	export NewFather						:= fLogicalVersion(lfather						);
	export NewGrandfather				:= fLogicalVersion(lgrandfather				);
	export NewGreatGrandfather	:= fLogicalVersion(lgreatgrandfather	);
	export NewDelete						:= fLogicalVersion(ldelete						);
	export NewBusinessHeader		:= fLogicalVersion(lBusinessHeader		);
	export NewPeopleHeader			:= fLogicalVersion(lPeopleHeader			);
	// Returns subfilenames of the superfiles
	export Sub									:= GetLogicalSubFile(pdate							);
	export BuildingSub					:= GetLogicalSubFile(lbuilding					);
	export BuiltSub							:= GetLogicalSubFile(lbuilt							);
	export QASub								:= GetLogicalSubFile(lqa								);
	export ProdSub							:= GetLogicalSubFile(lprod							);
	export FatherSub						:= GetLogicalSubFile(lfather						);
	export GrandfatherSub				:= GetLogicalSubFile(lgrandfather				);
	export GreatGrandfatherSub	:= GetLogicalSubFile(lgreatgrandfather	);
	export DeleteSub						:= GetLogicalSubFile(ldelete						);
	export BusinessHeaderSub		:= GetLogicalSubFile(lBusinessHeader		);
	export PeopleHeaderSub			:= GetLogicalSubFile(lPeopleHeader			);
	// Returns versions of subfilenames of the superfiles
	export Version									:= GetFileVersion(pdate							);
	export BuildingVersion					:= GetFileVersion(lbuilding					);
	export BuiltVersion							:= GetFileVersion(lbuilt						);
	export QAVersion								:= GetFileVersion(lqa								);
	export ProdVersion							:= GetFileVersion(lprod							);
	export FatherVersion						:= GetFileVersion(lfather						);
	export GrandfatherVersion				:= GetFileVersion(lgrandfather			);
	export GreatGrandfatherVersion	:= GetFileVersion(lgreatgrandfather	);
	export DeleteVersion						:= GetFileVersion(ldelete						);
	export BusinessHeaderVersion		:= GetFileVersion(lBusinessHeader		);
	export PeopleHeaderVersion			:= GetFileVersion(lPeopleHeader			);
	export setBuilt 			:= [Built];
	export setQA		 			:= [QA];
	export setBuiltQAEtc	:= [Built,QA,Father,Grandfather,Delete];
	export setBuiltQA			:= [Built,QA];
	export setQAProdEtc		:= [QA,Prod,Father,Grandfather,Delete];
	export dBuilt 			:= DATASET([(Built 				)], Layout_Names);
	export dQA 					:= DATASET([(QA 					)], Layout_Names);
	export dFather 			:= DATASET([(Father 			)], Layout_Names);
	export dGrandfather := DATASET([(Grandfather 	)], Layout_Names);
	export dBuiltQA := 
	DATASET([
		 (Built)
		,(QA)
	], Layout_Names);
	export dBuiltQAEtc := 
	DATASET([
		 (Built)
		,(QA)
		,(Prod)
		,(Father)
		,(Grandfather)
	], Layout_Names);
	export dQAProdEtc := 
	DATASET([
		 (QA)
		,(Prod)
		,(Father)
		,(Grandfather)
	], Layout_Names);
	export dAll_superfilenames := 
	DATASET([
		 (Building)
		,(Built)
		,(QA)
		,(Prod)
		,(Father)
		,(Grandfather)
		,(Delete)
      
	], Layout_Names);
	export dAll_newsuperfilenames := 
	DATASET([
		 (NewBuilding)
		,(NewBuilt)
		,(NewQA)
		,(NewProd)
		,(NewFather)
		,(NewGrandfather)
		,(NewDelete)
      
	], Layout_Names);
	export dAll_BothSuperfilenames := 
			dAll_superfilenames(name != '')
		+ dAll_newsuperfilenames
		;
		
	export dAll_superfilenames_child := 
	DATASET([{
		 (New)
		,(Building)
		,(Built)
		,(QA)
		,(Prod)
		,(Father)
		,(Grandfather)
		,(Delete)
		,(Template)
}
	], Layout_FilenameVersions.all_versions);
	export dNew :=
	DATASET([
		 (New)
	], Layout_Names);
	
	export dTemplate :=
	DATASET([
		 (Template)
	], Layout_Names);
	export dBoth :=
	dataset([
	
		{(New), (dAll_superfilenames(name != ''))
		,(Template), '', (pdate), (pnGenerations),regexfind('@version@', pTemplatefilename,nocase)}
	
	], Layout_FilenameVersions.builds);
		
	export dAll_filenames := dBoth;
end;
