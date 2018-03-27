import STD,lib_stringlib, PRTE2_CODE_GENERATOR;
// Builds the ECL code for the Keys attribute.  Should create an export index statement for each custom key used by 
// the dataset. 
// modulename is the name of the new module.
// datasetname is the name of the dataset as it should look when part of a file name.
// dopskeyname is the name the set of keys is found under on the DOPS page.
// dopsFCRAkeyname is the name the FCRA set of keys is found under on the DOPS page.

EXPORT Build_Keys_File(string modulename,string datasetname, string dopskeyname, string dopsFCRAkeyname ='', 
							Dataset(Layouts.superkeyrecs) KeyInfo) := FUNCTION

	prctSFRec := KeyInfo;//GetKeyInfo(dopskeyname, dopsFCRAkeyname);

	keyrec := record
		string buildkeyline;
		string macroOutlist;
	end;
	
	keyrec xformkey_build(prctSFRec l) := transform
	    string superkeyname := '\'' + regexreplace('@version@', l.superkey, '\'+doxie.Version_SuperKey + \'') + '\'';
		self.buildkeyline := 'EXPORT ' + l.keyname + ' := INDEX(\n\tFILES.'
							+ 'DS_'+ regexreplace('key_', l.keyname, '') + ', \n\t' +
                             ' {'+l.keyedfields+'}, \n\t' +
							 ' {'+l.full_layout+'}, \n\t' +
				             superkeyname + ');' ;
						   
		self.macroOutlist := '';
	end;
	
	keybuild := project(prctSFRec(
		RegExFind('autokey',superkey,nocase) = FALSE AND keyedfields !=''), 
		xformkey_build(LEFT));
		
	string outbuild := STD.str.CombineWords( SET(keybuild, buildkeyline)	, '\n');
	
	key_text := 
	'IMPORT  doxie,mdr, ' + modulename + ';\n\n' + 
	'EXPORT keys := MODULE\n\n' +
	'//The keys in this file show all the "payload" fields that are found in the production key instead of just\n' +
	'//listing the dataset name as the payload parameter.  This is done to help you figure out what fields have to \n' +
	'//be included in the layout and dataset parameters.  You will need to fix the payload parameter.\n\n' +
	outbuild + '\n\n' +
	'END;\n';
					  
	RETURN UpdateAttributeText(modulename, 'Keys', key_text);

END;