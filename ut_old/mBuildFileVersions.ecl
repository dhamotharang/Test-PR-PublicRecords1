////////////////////////////////////////////////////////////////////////////////////////////
// -- mBuildFileVersions macro/module
// -- Parameters:
// -- 		pfilenameversions	-- result of call to ut.mBuildFilenameVersions.  Example follows
// --		pLayout				-- Record layout of build file
// --		pOutput				-- Output parameter
// --
// -- This module will give you access to all versions of a build file(base or key)
// -- i.e., the following code:
// -- 		export BaseFilenames	:= ut.mBuildFilenameVersions('~thor_data400::base::BBB::@version@::Member',	'20060328');
// -- 		ut.mBuildFileVersions(BaseFilenames,	bbb2.Layouts_Files.Base.Member, BaseFiles);
// -- This gives you access to:
// -- BaseFiles.Building	 = dataset('~thor_data400::base::BBB::Building::Member', bbb2.Layouts_Files.Base.Member, flat);
// -- BaseFiles.Built		 = dataset('~thor_data400::base::BBB::Built::Member', bbb2.Layouts_Files.Base.Member, flat);
// -- BaseFiles.QA			 = dataset('~thor_data400::Base::BBB::QA::Member', bbb2.Layouts_Files.Base.Member, flat);
// -- BaseFiles.Prod		 = dataset('~thor_data400::Base::BBB::Prod::Member', bbb2.Layouts_Files.Base.Member, flat);
// -- BaseFiles.Father		 = dataset('~thor_data400::Base::BBB::Father::Member', bbb2.Layouts_Files.Base.Member, flat);
// -- BaseFiles.Grandfather	 = dataset('~thor_data400::Base::BBB::Grandfather::Member', bbb2.Layouts_Files.Base.Member, flat);
// -- BaseFiles.Delete		 = dataset('~thor_data400::Base::BBB::Delete::Member', bbb2.Layouts_Files.Base.Member, flat);
// -- BaseFiles.New			 = dataset('~thor_data400::Base::BBB::20060328::Member', bbb2.Layouts_Files.Base.Member, flat);
// -- BaseFiles.Keybuild	 = dataset('~thor_data400::base::BBB::QA::Member', bbb2.Layouts_Files.Base.Member, flat);
// --							it adds the fileposition to the QA version for use in keybuilding
////////////////////////////////////////////////////////////////////////////////////////////

export mBuildFileVersions(pfilenameversions, pLayout, pOutput) :=
macro
	
	export pOutput := 
	module
		shared layout_keybuild :=
		record
			pLayout;
			unsigned integer8 __filepos { virtual(fileposition)};
		end;
		
		shared fDataset(string name)			:= dataset(name, pLayout,			thor);
		shared fDatasetKeybuild(string name)	:= dataset(name, layout_keybuild,	thor);
		
		export Building		:= fDataset(pfilenameversions.building);
		export Built		:= fDataset(pfilenameversions.built);
		export QA			:= fDataset(pfilenameversions.qa);
		export Prod			:= fDataset(pfilenameversions.prod);
		export Father		:= fDataset(pfilenameversions.father);
		export Grandfather	:= fDataset(pfilenameversions.grandfather);
		export Delete		:= fDataset(pfilenameversions.delete);
		export New			:= fDataset(pfilenameversions.New);
		export Keybuild		:= fDatasetKeybuild(pfilenameversions.qa);
		export BusinessHeader	:= fDataset(pfilenameversions.BusinessHeader);
		export PeopleHeader		:= fDataset(pfilenameversions.PeopleHeader	);

	end;

endmacro;