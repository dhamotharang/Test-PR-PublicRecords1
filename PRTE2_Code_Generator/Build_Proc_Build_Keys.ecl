import STD,lib_stringlib, PRTE2_CODE_GENERATOR;
// Builds the Proc_Build_Keys attribute text.  
// modulename is the name of the new module.
// datasetname is the name of the dataset as it should look when part of a file name.
// dopskeyname is the name the set of keys is found under on the DOPS page.
// dopsFCRAkeyname is the name the FCRA set of keys is found under on the DOPS page.

EXPORT Build_Proc_Build_Keys(string modulename,string datasetname, string dopskeyname, string dopsFCRAkeyname ='', 
							Dataset(Layouts.superkeyrecs) KeyInfo) := FUNCTION
	
	prctSFRec := KeyInfo;//GetKeyInfo(dopskeyname, dopsFCRAkeyname);

	keyrec := record
		string buildkeyline;
		string macroOutlist;
	end;
	
	keyrec xformkey_build(prctSFRec l) := transform
		self.buildkeyline := 'RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( keys.' + l.keyname + 
				',\n\t\'' + l.superkey + '\',\n\t\'' + l.logicalkey + '\', build_' + l.keyname+ ');\n';
		self.macroOutlist := '\t\t\tbuild_' + l.keyname;
	end;
	
	keyrec xformkey_move1(prctSFRec l) := transform
		self.buildkeyline := 'RoxieKeyBuild.MAC_SK_Move_To_Built_V2( \'' + 
		l.superkey + '\', \n\t\'' + l.logicalkey + '\',\n\tmove_built_' + l.keyname+ ');\n';
		self.macroOutlist := '\t\t\tmove_built_' + l.keyname;
	end;
	
	keyrec xformkey_move2(prctSFRec l) := transform
		self.buildkeyline := 'RoxieKeyBuild.MAC_SK_Move_v2(\'' + 
		l.superkey + '\', \n\t\'Q\', \n\tmove_qa_' + l.keyname+ ');\n';
		self.macroOutlist := '\t\t\tmove_qa_' + l.keyname;
	end;
	
	keybuild := project(prctSFRec(
		RegExFind('autokey',superkey,nocase) = FALSE AND keyedfields !=''), 
		xformkey_build(LEFT));
	
	keymove1 := project(prctSFRec(
		RegExFind('autokey',superkey,nocase) = FALSE AND keyedfields !=''), 
		xformkey_move1(LEFT));
	
	keymove2 := project(prctSFRec(
		RegExFind('autokey',superkey,nocase) = FALSE AND keyedfields !=''), 
		xformkey_move2(LEFT));
	
	
	string outbuild := STD.str.CombineWords( SET(keybuild, buildkeyline)	, '\n');
	
	string outmove1 := STD.str.CombineWords( SET(keymove1, buildkeyline)	, '\n');
	
	string outmove2 := STD.str.CombineWords( SET(keymove2, buildkeyline)	, '\n');
	
	string macroOutString1 :=  STD.str.CombineWords( SET(keybuild, macroOutlist),', \n');
	
	string macroOutString2 :=  STD.str.CombineWords( SET(keymove1, macroOutlist),', \n');
	
	string macroOutString3 :=  STD.str.CombineWords( SET(keymove2, macroOutlist),', \n');
	
	string macroOutStringf := macroOutString1 + ', \n' + macroOutString2 + ', \n' + macroOutString3;
	
	proc_build_key_text := 
		'IMPORT ut,RoxieKeyBuild,AutoKeyB2,PRTE,_control, ' + modulename + ';\n\n' + 
		'EXPORT proc_build_keys(string filedate) := FUNCTION\n\n' +
		outbuild + '\n' +
		outmove1 + '\n' +
		outmove2 + '\n\n' +
		'//YOU MUST CHANGE THE AUTOKEY INPUT PARAMETERS TO MATCH YOUR DATASET!!\n'+
		'AutoKeyB2.MAC_Build (files.autokey_file,\n' +
		'					fname,mname,lname,\n' +
		'					best_ssn,\n' +
		'					zero,\n' +
		'					zero,\n' +
		'					prim_name,prim_range,st,v_city_name,zip,sec_range,\n' +
		'					zero,\n' +
		'					zero,zero,zero,\n' +
		'					zero,zero,zero,\n' +
		'					zero,zero,zero,\n' +
		'					zero,\n' +
		'					inDID,\n' +
		'					cname,\n' +
		'					zero,\n' +
		'					zero,\n' +
		'					cprim_name,cprim_range,cst,cv_city_name,czip,csec_range,\n' +
		'					inbdid,\n' +
		'					Constants.ak_keyname,\n' +
		'					Constants.ak_logical(filedate),\n' +
		'					outaction,false,\n' +
		'					constants.skip_set,true,constants.ak_typestr,,\n' +
		'					true,,,zero) \n\n' +
		'AutoKeyB2.MAC_AcceptSK_to_QA(constants.ak_keyname, mymove,, constants.skip_set) \n\n' +
		'retval := 	sequential(outaction,mymove); \n\n' +		
		'// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION  \n\n' +
		'//updatedops   		 := PRTE.UpdateVersion(\'' + dopskeyname + '\', filedate,_control.MyInfo.EmailAddressNormal,\'B\',\'N\',\'N\'); \n\n' +
		if (dopsFCRAkeyname != '','//updatedops_fcra  := PRTE.UpdateVersion(\'' + dopsFCRAkeyname + '\',filedate,_control.MyInfo.EmailAddressNormal,\'B\',\'F\',\'N\');\n\n','') +
		'RETURN 		sequential(' +macroOutStringf + ', retval \n' +
		'																							// ,parallel(updatedops,updatedops_fcra) \n' +
		'																							);\n\n' +
		'END;\n';

	RETURN UpdateAttributeText(modulename, 'proc_build_keys', proc_build_key_text);

END;