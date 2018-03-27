import STD, PRTE2_CODE_GENERATOR;
// Builds the attribute that has one time code that creates the superfiles and superkeys.
// modulename is the name of the new module.
// datasetname is the name of the dataset as it should look when part of a file name.
// dopskeyname is the name the set of keys is found under on the DOPS page.
// dopsFCRAkeyname is the name the FCRA set of keys is found under on the DOPS page.
// infiles is a string of names separated by commas.  These are used to create the superfiles for 
// files being sprayed in. i.e. 'AIRMEN,AIRCRAFT' would create PRTE::IN::FAA::AIRMEN and PRTE::IN::FAA::AIRCRAFT.
// basefiles is a string of names separated by commas.  These are used to create versioned superfiles for 
// base files in the process. i.e. 'AIRMEN' would create the ECL code to create the following files.
// PRTE::BASE::FAA::AIRMEN_BUILT, PRTE::BASE::FAA::AIRMEN_FATHER, 
// PRTE::BASE::FAA::AIRMEN_GRANDFATHER, PRTE::BASE::FAA::AIRMEN_DELETE, and PRTE::BASE::FAA::AIRMEN

EXPORT Build_BWR_Attribute(	string modulename,
							string datasetname, 
							string dopskeyname, 
							string dopsFCRAkeyname ='', 
							string infiles, 
							string basefiles, 
							Dataset(Layouts.superkeyrecs) KeyInfo) := FUNCTION
   
	prctSFRec := KeyInfo;//GetKeyInfo(dopskeyname,dopsFCRAkeyname);
	
	combined_qa := STD.str.CombineWords( SET(prctSFRec(keyedfields !=''), qa_key_create_sf), '\n');
	
	basefilesstring := regexreplace(',', basefiles,'\n');

	combined_basefile :=  regexreplace('(\\w+)',basefilesstring, 'MakeSuperFiles (\'~PRTE::BASE::' + datasetname + '::\\1@version@\');\n');
	
	infilesstring := regexreplace(',',infiles,'\n');

	combined_infile :=  regexreplace('(\\w+)',infilesstring, 'FileServices.CreateSuperFile (\'~PRTE::IN::' + datasetname + '::\\1\');\n');
	
	string bwrtext := 
	'//This file was generated as a starting point only.  \n' +
    '//You must check and customize this process BEFORE running it.\n\n\n'+
	'EXPORT BWR_ONE_TIME_CODE := MODULE\n\n' + 
	
	'SHARED MakeSuperKeys(string name) := FUNCTION\n' +
	'	FileServices.CreateSuperFile (RegExReplace(\'@version@\', name, \'qa\'));\n' +
	'	FileServices.CreateSuperFile (RegExReplace(\'@version@\', name, \'father\'));\n' +
	'	FileServices.CreateSuperFile (RegExReplace(\'@version@\', name, \'grandfather\'));\n' +
	'	FileServices.CreateSuperFile (RegExReplace(\'@version@\', name, \'delete\'));\n' +
	'	RETURN \'SUCCESS\';\n' +
	'END;\n\n' +

	'SHARED MakeSuperFiles(string name) := FUNCTION\n' +
	'	FileServices.CreateSuperFile (RegExReplace(\'@version@\', name, \'_built\'));\n' +
	'	FileServices.CreateSuperFile (RegExReplace(\'@version@\', name, \'_father\'));\n' +
	'	FileServices.CreateSuperFile (RegExReplace(\'@version@\', name, \'_grandfather\'));\n' +
	'	FileServices.CreateSuperFile (RegExReplace(\'@version@\', name, \'_delete\'));\n' +
	'	FileServices.CreateSuperFile (RegExReplace(\'@version@\', name, \'\'));\n' +
	'	RETURN \'SUCCESS\';\n' +
	'END;\n\n' +

	'EXPORT DO := FUNCTION\n\n' +
	
	combined_qa + '\n\n\n' +

	combined_basefile + '\n' +
	
	combined_infile	+ '\n' +
	
	'RETURN \'SUCCESS\';\n'+
	'\nEnd;\n' +
	'\nEnd;';

	return UpdateAttributeText(modulename,'bwr_one_time_code', bwrtext);

END;
