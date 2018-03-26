import STD, PRTE2_CODE_GENERATOR;
// Builds the Proc_Build_Base attribute text.  
// modulename is the name of the new module.
// datasetname is the name of the dataset as it should look when part of a file name.
// infiles is a string of names separated by commas. 
// basefiles is a string of names separated by commas. 

EXPORT Build_Proc_Build_Base (string modulename,string datasetname, string infiles, string basefiles) := FUNCTION

	basefilesstring := regexreplace(',', basefiles,'\n');

	combined_basefile :=  regexreplace('(\\w+)',basefilesstring, 
		'PromoteSupers.MAC_SF_BuildProcess(df?,\'~PRTE::BASE::' + datasetname + '::\\1\', writefile_\\1);\n');

	base_set_out := regexfindset('writefile_\\w*',combined_basefile,nocase);
	
	base_out := STD.str.CombineWords( base_set_out, ',');
	
	infilesstring := regexreplace(',',infiles,'\n');

	combined_infile :=  regexreplace(	'(\\w+)',
										infilesstring, 
										'df_\\1 := PROJECT(Files.DS_'+datasetname+'_\\1_IN, layouts.Layout_Base);\n');
		
	STRING Build_Base := 
		'IMPORT  ' + modulename + ',PromoteSupers;\n\n' +
		'EXPORT PROC_BUILD_BASE(String filedate) := FUNCTION\n\n'+
		combined_infile + '\n' +
		combined_basefile + '\n' +		
		'sequential('+base_out+');\n\n' +		
		'Return \'success\';\n' +
		'END;';
			  
	RETURN UpdateAttributeText(modulename, 'Proc_Build_Base', Build_Base);
	
END;