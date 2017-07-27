////////////////////////////////////////////////////////////////////////////////////////////
// -- mInputFileVersions macro/module
// -- Parameters:
// -- 		pfilenameversions	-- result of call to ut.mBuildFilenameVersions.  Example follows
// --		pLayout				-- Record layout of build file
// --		pOutput				-- Output parameter
// --		pfiletype			-- Type of file(flat and Xml are currently supported)
// --								flat is the default.  If xml, pass in the beginning/ending tag.  Example below.
// --
// -- This module will give you access to all versions of an Input file
// -- i.e., the following code:
// -- 		export InputFilenames	:= ut.mInputFilenameVersions('~thor_data400::in_rolling::BBB::@version@::Member');
// -- 		ut.mInputFileVersions(InputFilenames,	bbb2.Layouts_Files.Input.Member, InputFiles, 'listings/listing');
// -- 
// -- This gives you access to six file versions:
// -- InputFiles.Root				= dataset('~thor_data400::in_rolling::BBB::Member', 			bbb2.Layouts_Files.Input.Member, xml('listings/listing'));
// -- InputFiles.Sprayed			= dataset('~thor_data400::in_rolling::BBB::Sprayed::Member',	bbb2.Layouts_Files.Input.Member, xml('listings/listing'));
// -- InputFiles.Using				= dataset('~thor_data400::in_rolling::BBB::Using::Member',		bbb2.Layouts_Files.Input.Member, xml('listings/listing'));
// -- InputFiles.Used				= dataset('~thor_data400::in_rolling::BBB::Used::Member',		bbb2.Layouts_Files.Input.Member, xml('listings/listing'));
// -- InputFiles.Delete				= dataset('~thor_data400::in_rolling::BBB::Delete::Member',		bbb2.Layouts_Files.Input.Member, xml('listings/listing'));
// -- InputFiles.New('20060328')	= dataset('~thor_data400::in_rolling::BBB::20060328::Member',	bbb2.Layouts_Files.Input.Member, xml('listings/listing'));
// --           
////////////////////////////////////////////////////////////////////////////////////////////

export mInputFileVersions(pfilenameversions, pLayout, pOutput, pfiletype = '\'Flat\'') :=
macro

#IF(pfiletype = 'Flat')
	export pOutput := 
	module
		
		shared fDataset(string name)				:= dataset(name, pLayout, flat);

		export Root									:= fDataset(pfilenameversions.Root);
		export Sprayed								:= fDataset(pfilenameversions.sprayed);
		export Using								:= fDataset(pfilenameversions.using);
		export Used									:= fDataset(pfilenameversions.used);
		export Delete								:= fDataset(pfilenameversions.delete);
		export New(string pdate, integer pcnt = 0)	:= fDataset(pfilenameversions.New(pdate, pcnt));
		

	end;
#else
	export pOutput := 
	module
		
		shared fDataset(string name)				:= dataset(name, pLayout, xml(pfiletype));

		export Root									:= fDataset(pfilenameversions.Root);
		export Sprayed								:= fDataset(pfilenameversions.sprayed);
		export Using								:= fDataset(pfilenameversions.using);
		export Used									:= fDataset(pfilenameversions.used);
		export Delete								:= fDataset(pfilenameversions.delete);
		export New(string pdate, integer pcnt = 0)	:= fDataset(pfilenameversions.New(pdate, pcnt));
		

	end;
#end

endmacro;
