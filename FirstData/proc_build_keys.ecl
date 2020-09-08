import dx_FirstData,Orbit3,RoxieKeyBuild,FirstData;
EXPORT proc_build_keys (STRING	pVersion, boolean isDelta):=function

	FCRAprefix := '~thor_data400::key::FirstData::FCRA::' + pVersion + '::';
	prefix := '~thor_data400::key::FirstData::' + pVersion + '::';
	
	name_did := FCRAprefix + 'did';
	name_driverslicense:= prefix + 'driverslicense';

	RoxieKeybuild.MAC_build_logical(dx_FirstData.key_DID(),FirstData.data_key_did_fcra(pversion),dx_FirstData.names('').i_did_FCRA,name_did,fcra_first_data_key);
	
	RoxieKeybuild.MAC_build_logical(dx_FirstData.key_driverslicense(),FirstData.data_key_driverslicense(pversion),dx_FirstData.names('').i_driverslicense,name_driverslicense,first_data_driverslicense_key);
	
	RoxieKeyBuild.Mac_SK_Move_v3('~thor_data400::key::FirstData::FCRA::@version@::did','D',ma_fcra_first_data_key_to_qa,pVersion,2);
	RoxieKeyBuild.Mac_SK_Move_v3('~thor_data400::key::FirstData::@version@::driverslicense','D',ma_first_data_driverslicense_key_to_qa,pVersion,2);

	
	build_keys := sequential(
																parallel(
                                                                    fcra_first_data_key,
                                                                    first_data_driverslicense_key),
                                                                //isDelta is false on mondays and means that a full build is necessary,
                                                                    //on all other days keys are simply added to superfile
                                                                if(isDelta, 
                                                                    parallel(
                                                                        fileservices.addsuperfile(dx_FirstData.names().i_did_FCRA,	name_did),
                                                                        fileservices.addsuperfile(dx_FirstData.names().i_driverslicense, name_driverslicense)
                                                                        ),
                                                                    parallel(
                                                                        ma_fcra_first_data_key_to_qa,
                                                                        ma_first_data_driverslicense_key_to_qa
                                                                        )
                                                                    )
																);
																
return build_keys;
end;