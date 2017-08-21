import Property,RoxieKeyBuild;

export proc_build_NOD_key_bid(string filedate) := 
function

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Property.Key_NOD_FID_bid,'~thor_data400::key::nod::@version@::bid::fid','~thor_data400::key::nod::'+filedate+'::bid::fid',do1);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Property.Key_NOD_BID,'~thor_data400::key::nod::@version@::bid','~thor_data400::key::nod::'+filedate+'::bid',do3);

	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::nod::@version@::bid::fid','~thor_data400::key::nod::'+filedate+'::bid::fid',do22);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::nod::@version@::bid','~thor_data400::key::nod::'+filedate+'::bid',do23);

	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::nod::@version@::bid::fid','Q',do31,3);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::nod::@version@::bid','Q',do33,3);

	bldsucc := fileservices.sendemail(Property.Roxie_Email_List,
																		'NOD Weekly Roxie BID Keybuild Succeeded - ' + filedate,
																		'Keys:	1) thor_data400::key::nod::qa::bid::fid(thor_data400::key::nod::'+filedate+'::bid::fid)\n' +
																		'				2) thor_data400::key::nod::qa::bid(thor_data400::key::nod::'+filedate+'::bid)\n' +
																		'      have been built and ready to be deployed to QA.');

	bldfail := fileservices.sendemail('kgummadi@seisint.com;vniemela@seisint.com',
																		'NOD Weekly Roxie BID Keybuild Failed - ' + filedate,
																		failmessage);

	ak := Property.Proc_Build_NOD_Autokeys_bid(filedate);
	
	buildkey := sequential( parallel(do1,do3),
													parallel(do22,do23),
													parallel(do31,do33),
													ak
												) : 
							success(bldsucc),
							failure(bldfail);
						
	return buildkey;

end;