import STD,lib_stringlib, PRTE2_CODE_GENERATOR;
// Builds a module and related attributes for a PRCT dataset.  It's intended as a starter template
// and not as a complete solution.  
// modulename is the name of the new module to be created.  If it already exists nothing happens, but the contents
// of it may change.  Since everything is written in the sandbox though, everything can be rolled back if overwritten.
// datasetname is the name of the dataset as it should look when part of a file name.
// dopskeyname is the name the set of keys is found under on the DOPS page.
// dopsFCRAkeyname is the name the FCRA set of keys is found under on the DOPS page.
// infiles is a string of names separated by commas.  These are used to create the superfiles for 
// files being sprayed in. i.e. 'AIRMEN,AIRCRAFT' would create PRTE::IN::FAA::AIRMEN and PRTE::IN::FAA::AIRCRAFT.
// basefiles is a string of names separated by commas.  These are used to create versioned superfiles for 
// base files in the process. i.e. 'AIRMEN' would create the ECL code to create the following files.
// PRTE::BASE::FAA::AIRMEN_BUILT, PRTE::BASE::FAA::AIRMEN_FATHER, 
// PRTE::BASE::FAA::AIRMEN_GRANDFATHER, PRTE::BASE::FAA::AIRMEN_DELETE, and PRTE::BASE::FAA::AIRMEN
// infileStub is part of the filname of the file or files that are on the landing zone.  This will
// be surrounded by wildcard characters to match similar filenames.  For example, 'faa' would match
// prte__base__faa__aircraft_reg_20141210.txt and prte__base__faa_airmen_20141210.txt. A layout would be 
// created for both files and placed in the Layout attribute.
// oldModName is the name of the production module or any other module that might hold layouts that can be used
// to identify data types for the fields use in the in file layouts.

EXPORT Build_PRTE_Module (
								string modulename,
								string datasetname, 
								string dopskeyname, 
								string dopsFCRAkeyname ='',
								STRING infiles, 
								STRING basefiles, 
								STRING infileStub = '',
								STRING oldModName
													) := FUNCTION

	 CreateModule(modulename);
   shared Keys := GetKeyInfo(dopskeyname,dopsFCRAkeyname);
	 shared InLayouts := GetInFileLayouts(dopskeyname, oldModName, infileStub);
	 shared KeyInfo := MatchInFilesToKeys(InLayouts, Keys);
	 Build_BWR_Attribute(modulename,datasetname, dopskeyname,dopsFCRAkeyname, infiles, basefiles,KeyInfo);
	 
	 Build_Proc_Build_Keys(modulename,datasetname, dopskeyname,dopsFCRAkeyname,KeyInfo);
	 
	 Build_Keys_File(modulename,datasetname, dopskeyname,dopsFCRAkeyname,KeyInfo);
	 
	 Build_Files_Attribute(modulename,datasetname, dopskeyname,dopsFCRAkeyname,infiles, basefiles,KeyInfo);
	 
	 Build_Layouts_Attribute(modulename,datasetname, dopskeyname,dopsFCRAkeyname, infileStub,oldModName,KeyInfo,InLayouts);
	 
	 Build_Constants_Attribute(modulename,datasetname);
	 
	 Build_Proc_Build_Base(modulename,datasetname, infiles, basefiles);
	 
	 Build_FSpray(modulename,datasetname,infiles);
	 
	 //The following lines build the text for the PROC_BUILD_ALL attribute.
	 proc_build_text := 
	 'IMPORT ' + modulename + ';\n\n' +
	 'EXPORT proc_build_all(string filedate) := FUNCTION\n\n' +
	 '	build_base_file	:=	' + modulename + '.proc_build_base(filedate);\n\n' +					
	 '	build_keys :=	' + modulename + '.proc_build_keys(filedate);\n\n' +
	 '	return_val := 	sequential(	build_base_file, build_keys) ;\n\n' +
	 '	return return_val;\n\n' +
	 'END;';
	 
	 RETURN UpdateAttributeText(modulename, 'Proc_Build_All', proc_build_text); 

END;



