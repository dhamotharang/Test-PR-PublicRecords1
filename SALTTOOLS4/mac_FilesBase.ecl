////////////////////////////////////////////////////////////////////////////////////////////
// -- mac_FilesBase macro/module
// -- Parameters:
// -- 		pfilenameversions	-- result of call to NamingConventionUtilities.mod_FilenamesBuild  Example follows
// --		pLayout				-- Record layout of build file
// --		pOutput				-- Output parameter
// --
// -- This module will give you access to all versions of a build file(base or key)
// -- i.e., the following code:
// --
// -- 		export BaseFilenames	:= SALTTOOLS4.mod_FilenamesBuild('~thor_data400::base::BBB::@version@::Member',	'20060328');
// -- 		SALTTOOLS4.mBuildFileVersions(BaseFilenames,	bbb2.Layouts_Files.Base.Member, BaseFiles);
// --
// -- This gives you access to:
// -- BaseFiles.Building	 = dataset('~thor_data400::base::BBB::Building::Member'		, bbb2.Layouts_Files.Base.Member, flat);
// -- BaseFiles.Built		 = dataset('~thor_data400::base::BBB::Built::Member'		, bbb2.Layouts_Files.Base.Member, flat);
// -- BaseFiles.QA			 = dataset('~thor_data400::Base::BBB::QA::Member'			, bbb2.Layouts_Files.Base.Member, flat);
// -- BaseFiles.Prod		 = dataset('~thor_data400::Base::BBB::Prod::Member'			, bbb2.Layouts_Files.Base.Member, flat);
// -- BaseFiles.Father		 = dataset('~thor_data400::Base::BBB::Father::Member'		, bbb2.Layouts_Files.Base.Member, flat);
// -- BaseFiles.Grandfather	 = dataset('~thor_data400::Base::BBB::Grandfather::Member'	, bbb2.Layouts_Files.Base.Member, flat);
// -- BaseFiles.Delete		 = dataset('~thor_data400::Base::BBB::Delete::Member'		, bbb2.Layouts_Files.Base.Member, flat);
// -- BaseFiles.New			 = dataset('~thor_data400::Base::BBB::20060328::Member'		, bbb2.Layouts_Files.Base.Member, flat);
// -- BaseFiles.Keybuild	 = dataset('~thor_data400::base::BBB::QA::Member'			, bbb2.Layouts_Files.Base.Member, flat);
// --							it adds the fileposition to the QA version for use in keybuilding
////////////////////////////////////////////////////////////////////////////////////////////
import lib_stringlib;
export mac_FilesBase( pfilenameversions
														,pLayout
														,pOutput
														,pKeybuildVersion		= 'built'
														,pUseKeybuild				= 'true'
														,pMaxLength					= 4096
														,pUseMaxLength			= false
														,pUseOld						= 'false'
														,pOpt								= 'false'				// file exists optional?
) :=
macro
	
	export pOutput := 
	module
		#if(pUseKeybuild = true)
			shared layout_keybuild :=
		#if(pUseMaxLength = true)
			record, maxlength(pMaxLength)
		#else
			record
		#end
				pLayout;
				unsigned integer8 __filepos { virtual(fileposition)};
			end;
		#end
		
		shared fDataset(string name)			:= dataset(name, pLayout,			thor #if(pOpt) ,opt #end);
		
		#if(pUseKeybuild = true)
			shared fDatasetKeybuild(string name)	:= dataset(name, layout_keybuild,	thor #if(pOpt) ,opt #end);
		#end
		
		export Root						:= fDataset(pfilenameversions.root					);
		export Building				:= fDataset(pfilenameversions.building			);
		export Built					:= fDataset(pfilenameversions.built					);
		export QA							:= fDataset(pfilenameversions.qa						);
		export Prod						:= fDataset(pfilenameversions.prod					);
		export Father					:= fDataset(pfilenameversions.father				);
		export Grandfather		:= fDataset(pfilenameversions.grandfather		);
		export Delete					:= fDataset(pfilenameversions.delete				);
		export BusinessHeader	:= fDataset(pfilenameversions.BusinessHeader);
		export PeopleHeader		:= fDataset(pfilenameversions.PeopleHeader	);
		export New						:= fDataset(pfilenameversions.New						);
		export Logical				:= fDataset(pfilenameversions.New						);
		#if(pUseOld = true)
		export Old						:= fDataset(pfilenameversions.Old						);
		#end
		#if(pUseKeybuild = true)
			export Keybuild			:= fDatasetKeybuild(pfilenameversions.pKeybuildVersion);
		#end
	end;
endmacro;
