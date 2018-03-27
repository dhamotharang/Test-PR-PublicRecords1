import STD, lib_stringlib, PRTE2_CODE_GENERATOR;
// This attempts to populate the Layouts attribute with layout definitions for each custom key
// and for the in files on the landing zone, assuming they are tab delimited with a header as the
// first line.
// modulename is the name of the new module.
// datasetname is the name of the dataset as it should look when part of a file name.
// dopskeyname is the name the set of keys is found under on the DOPS page.
// dopsFCRAkeyname is the name the FCRA set of keys is found under on the DOPS page.
// infileStub is part of the filname of the file or files that are on the landing zone.  This will
// be surrounded by wildcard characters to match similar filenames.  For example, 'faa' would match
// prte__base__faa__aircraft_reg_20141210.txt and prte__base__faa_airmen_20141210.txt. A layout would be 
// created for both files and placed in the Layout attribute.
// oldModName is the name of the production module or any other module that might hold layouts that can be used
// to identify data types for the fields use in the in file layouts.

EXPORT Build_Layouts_Attribute(	string modulename,
								string datasetname, 
								string dopskeyname, 
								string dopsFCRAkeyname ='', 
								string infileStub, 
								string oldModName, 
							Dataset(Layouts.superkeyrecs) KeyInfo,
							Dataset(Layouts.layout_list_rec) InLayouts) := FUNCTION

	prctSFRec := KeyInfo;//GetKeyInfo(dopskeyname,dopsFCRAkeyname);

	layouts_rec := record
		string layout_string;
		string layout_name;
	end;

	layouts_rec xform(prctSFRec l) := transform
		string step1 := regexreplace('(^RECORD|; RECORD)', l.layout, 'layout_' +regexreplace('key_', l.keyname, '') + ' := RECORD');
		string step4 := regexreplace('\\{ .+ \\};', step1, '');
		self.layout_string := 'EXPORT ' + step4;
		self.layout_name := 'layout_' +regexreplace('key_', l.keyname, '');	
	end;
	
	infileLayouts := InLayouts;//GetInFileLayouts(dopskeyname, oldModName, infileStub);

	setInfileLayouts := SET(infileLayouts, layout_concat);
	
	infileLayoutsCombined := STD.Str.CombineWords(setInfileLayouts, '\n');
	
	setlayouts := set(	project(prctSFRec(RegExFind('autokey',superkey,nocase) = FALSE AND keyedfields !=''), xform(LEFT)), 
						layout_string);
			
	layouts_combined := STD.str.CombineWords( setlayouts	, '\n');
	
	layouts_text := 
	'EXPORT Layouts := module\n\n' +
	'//Layouts are created for each custom key, but not for autokeys.  You will need to look at these\n ' +
	'//and find matching layouts in the production code that have all the same fields and then reference\n ' +
	'//the production keys instead of these.\n\n' +
	'//EXPORT Layout_Base := RECORD \n \n\n' +
	'//END;\n\n'+
	'//EXPORT Layout_Autokey := RECORD \n \n\n' +
	'//END;\n'+
	layouts_combined + '\n\n' +
	infileLayoutsCombined + '\n\n' +
	'END;';

	RETURN UpdateAttributeText(modulename, 'Layouts', layouts_text); 
	
END;