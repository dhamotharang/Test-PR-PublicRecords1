import property,ut,RoxieKeyBuild,Risk_Indicators;

export proc_build_forclosure_key_bid(string filedate) := 
function

//pre := ut.SF_MaintBuilding('~thor_data400::base::foreclosure');

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(property.Key_Foreclosures_FID_bid,'~thor_data400::key::foreclosure_bid_fid','~thor_data400::key::foreclosure::'+filedate+'::bid_fid',do1);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(property.Key_Foreclosures_BID,'~thor_data400::key::foreclosure_bid','~thor_data400::key::foreclosure::'+filedate+'::bid',do3);

// Move keys to built superfile
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::foreclosure_bid_fid','~thor_data400::key::foreclosure::'+filedate+'::bid_fid',do21);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::foreclosure_bid','~thor_data400::key::foreclosure::'+filedate+'::bid',do23);

// Move keys to QA superfile
ut.mac_sk_move_v2('~thor_data400::key::foreclosure_bid_fid','Q',do31,2);
ut.mac_sk_move_v2('~thor_data400::key::foreclosure_bid','Q',do33,2);

//post := ut.SF_MaintBuilt('~thor_Data400::base::foreclosure');

bldsucc := fileservices.sendemail(Property.Roxie_Email_List,
							  'Foreclosure Weekly Roxie BID Keybuild Succeeded - ' + filedate,
							  'Keys:	1) thor_data400::key::foreclosure_bid_fid_qa(thor_data400::key::foreclosure::'+filedate+'::bid_fid)\n' +
								'				2) thor_data400::key::foreclosure_bid_qa(thor_data400::key::foreclosure::'+filedate+'::bid)\n' +
							  '      have been built and ready to be deployed to QA.');

bldfail := fileservices.sendemail('kgummadi@seisint.com;vniemela@seisint.com',
							  'Foreclosure Weekly Roxie BID Keybuild Failed - ' + filedate,
							  failmessage);

// autokeys
ak := Property.Proc_Build_Autokeys_bid(filedate);

buildkey := sequential(
					parallel(do1,do3),
					parallel(do21,do23),
					parallel(do31,do33),
					ak) : 
			success(bldsucc),
			failure(bldfail);
					
return buildkey;

end;