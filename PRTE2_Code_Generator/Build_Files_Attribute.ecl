import STD, lib_stringlib, PRTE2_CODE_GENERATOR;
// Adds code to create datasets and projections required to build the keys.  An effort is made to generate
// a projection for each custom key that needs to be built.  There will also be a base file and in file for
// each base and infile specified in the parameters.
// modulename is the name of the new module.
// datasetname is the name of the dataset as it should look when part of a file name.
// dopskeyname is the name the set of keys is found under on the DOPS page.
// dopsFCRAkeyname is the name the FCRA set of keys is found under on the DOPS page.
// infiles is a string of names separated by commas. 
// basefiles is a string of names separated by commas.  

EXPORT Build_Files_Attribute(	string modulename,
								string datasetname, 
								string dopskeyname, 
								string dopsFCRAkeyname ='', 
								string infiles, 
								string basefiles, 
							Dataset(Layouts.superkeyrecs) KeyInfo) := FUNCTION

	prctSFRec := KeyInfo;//GetKeyInfo(dopskeyname,dopsFCRAkeyname);

	datasets_rec := record
		string dataset_string;
		string ds_name;
	end;

	datasets_rec xform(prctSFRec l) := transform
		SELF.ds_name 		:= 'DS_'+ regexreplace('key_', l.keyname, '');
		SELF.dataset_string := 'EXPORT '+ SELF.ds_name + '_base := PROJECT('+ l.best_file_match + ', Layouts.'+regexreplace('key_', l.keyname, '')+' );'
	end;

	setdatasets := set(project(prctSFRec(
		RegExFind('autokey',superkey,nocase) = FALSE AND keyedfields !=''),
		xform(LEFT)), dataset_string);
		
	datasets_combined := STD.str.CombineWords( setdatasets	, '\n');

	basefilesstring := regexreplace(',', basefiles,'\n');

	combined_basefile :=  regexreplace('(\\w+)',basefilesstring, 
		'EXPORT '+ datasetname + '_\\1 := DATASET(\'~PRTE::BASE::' + datasetname + '::\\1\', Layouts.Layout_Base, FLAT );\n');
	
	infilesstring := regexreplace(',',infiles,'\n');

	combined_infile :=  regexreplace('(\\w+)',infilesstring, 
		'EXPORT '+ datasetname + '_\\1_IN := DATASET(\'~PRTE::IN::' + datasetname + '::\\1\', Layouts.Layout_In, CSV(HEADING(1), SEPARATOR(\'\\\\t\'), TERMINATOR([\'\\\\n\',\'\\\\r\\\\n\']), QUOTE(\'"\')) );\n');


	files_text := 
	'EXPORT files := module\n\n' +
	'//Datasets and Projections are defined here.  Make sure there are no layouts or keys in this attribute.\n\n' +
	combined_basefile + '\n' +
	combined_infile + '\n' +
	'//These projections are created for each key in your keys file.  They are probably not based on the correct \n' +
	'//recordset or layout and they may be redundant.  \n\n' +
	datasets_combined + '\n\n' +
	'//This line will have to be edited to fix the dataset name that the autokey_file projection is based on.\n' +
	'EXPORT autokey_file := PROJECT('+ datasetname + '_base, Layouts.Layout_Autokey );\n\n' +
	'END;';

	RETURN UpdateAttributeText(modulename, 'Files', files_text); 
	
	END;