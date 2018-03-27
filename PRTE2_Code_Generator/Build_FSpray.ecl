IMPORT PRTE2_CODE_GENERATOR;
// Adds ECL code to the spray attribute to spray files to the cluster and move them to superfiles.
// modulename is the name of the new module.
// datasetname is the name of the dataset as it should look when part of a file name.
// infiles is a string of names separated by commas. 

EXPORT Build_FSpray (string modulename,string datasetname, string infiles) := FUNCTION

	infilesstring := regexreplace(',',infiles,'\n');

	combined_infile :=  regexreplace('(\\w+)',infilesstring, 'prte2.SprayFiles.Spray_Raw_Data(\'\\1\', \'\\1\', \'' + datasetname + '\');\n');

	string spray_text := 
	'IMPORT prte2;\n\n' +
	'EXPORT fSpray := FUNCTION\n\n' +
	'//Verify that the file names for the logical file, the second parameter, matches your IN superfile name.  It should be blank\n'+
	'//if you only have one input file to spray.\n\n'+
	'return ' +
	combined_infile + '\n' +							
	'END;';

	return UpdateAttributeText(modulename,'fSpray', spray_text);

END;