import Property,RoxieKeyBuild;

export proc_build_NOD_key(string filedate) := 
function

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Property.Key_NOD_FID,'~thor_data400::key::nod::@version@::fid','~thor_data400::key::nod::'+filedate+'::fid',do1);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Property.Key_NOD_DID,'~thor_data400::key::nod::@version@::did','~thor_data400::key::nod::'+filedate+'::did',do2);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Property.Key_NOD_BDID,'~thor_data400::key::nod::@version@::bdid','~thor_data400::key::nod::'+filedate+'::bdid',do3);

	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::nod::@version@::fid','~thor_data400::key::nod::'+filedate+'::fid',do22);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::nod::@version@::did','~thor_data400::key::nod::'+filedate+'::did',do21);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::nod::@version@::bdid','~thor_data400::key::nod::'+filedate+'::bdid',do23);

	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::nod::@version@::fid','Q',do31,3);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::nod::@version@::did','Q',do32,3);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::nod::@version@::bdid','Q',do33,3);

	bldsucc := fileservices.sendemail(Property.Roxie_Email_List,
																		'NOD Weekly Roxie Keybuild Succeeded - ' + filedate,
																		'Keys:	1) thor_data400::key::nod::qa::fid(thor_data400::key::nod::'+filedate+'::fid)\n' +
																		'				2) thor_data400::key::nod::qa::did(thor_data400::key::nod::'+filedate+'::did)\n' +
																		'				3) thor_data400::key::nod::qa::bdid(thor_data400::key::nod::'+filedate+'::bdid)\n' +
																		'      have been built and ready to be deployed to QA.');

	bldfail := fileservices.sendemail('kgummadi@seisint.com;vniemela@seisint.com',
																		'NOD Weekly Roxie Keybuild Failed - ' + filedate,
																		failmessage);

	ak := Property.Proc_Build_NOD_Autokeys(filedate);
	
	buildkey := sequential( parallel(do1,do2,do3),
													parallel(do21,do22,do23),
													parallel(do31,do32,do33),
													ak
												) : 
							success(bldsucc),
							failure(bldfail);
						
	return buildkey;

end;