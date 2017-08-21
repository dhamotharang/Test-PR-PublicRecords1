

//run this one twice, once each for internetservices and whois superkeys
EXPORT Create_Superfiles (STRING KeyFilePath) := MODULE

		SHARED CreateVersion(STRING KeyName, STRING Version) := 
						IF (~FileServices.FileExists (KeyFilePath + Version + KeyName),
							FileServices.CreateSuperFile (KeyFilePath + Version + KeyName));
				
		// the macros seem to choke if the built super file isn't cleared
		SHARED ClearBuiltSFs(STRING KeyName, STRING Version) := 
								FileServices.ClearSuperFile(KeyFilePath + Version + KeyName);

		SHARED CreateAllVersions(STRING KeyName) := 
						SEQUENTIAL (CreateVersion(KeyName, 'grandfather::'),
												CreateVersion(KeyName, 'father::'),
												CreateVersion(KeyName, 'qa::'),
												CreateVersion(KeyName, 'built::')
												);

		EXPORT Do := 
						SEQUENTIAL ( CreateAllVersions('cbrs.addr_proflic')
						            ,CreateAllVersions('linkids')
												,CreateAllVersions('professional_license_type_lookup')
												,CreateAllVersions('proflic_bdid')      
												,CreateAllVersions('proflic_licensenum')  
												,CreateAllVersions('prolicense_did')  
												,CreateAllVersions('prolicense_lnpid')  
												,CreateAllVersions('prolic_id') 
													);
												
											
END;

createMainKeysAction := Create_SuperFiles('~prte::key::prolicv2::').Do;

//Sequential(createMainKeysAction);

EXPORT Create_FCRA_Superfiles (STRING KeyFilePath) := MODULE

		SHARED CreateVersion(STRING KeyName, STRING Version) := 
						IF (~FileServices.FileExists (KeyFilePath + Version + KeyName),
							FileServices.CreateSuperFile (KeyFilePath + Version + KeyName));
				
		// the macros seem to choke if the built super file isn't cleared
		SHARED ClearBuiltSFs(STRING KeyName, STRING Version) := 
								FileServices.ClearSuperFile(KeyFilePath + Version + KeyName);

		SHARED CreateAllVersions(STRING KeyName) := 
						SEQUENTIAL (CreateVersion(KeyName, 'grandfather::'),
												CreateVersion(KeyName, 'father::'),
												CreateVersion(KeyName, 'qa::'),
												CreateVersion(KeyName, 'built::')
												);

		EXPORT Do := 
						SEQUENTIAL ( CreateAllVersions('professional_license_type_lookup')
						            ,CreateAllVersions('prolicense_did')
																				
													);
										
											
END;

createFCRAMainKeysAction := Create_FCRA_SuperFiles('~prte::key::prolicv2::fcra::').Do;

//sequential(createFCRAMainKeysAction);

EXPORT Create_AutoKeys_SuperFiles (STRING AutokeyPath) := MODULE

		SHARED CreateVersion(STRING KeyName, STRING Version) := 
						IF (~FileServices.FileExists (AutokeyPath + Version + KeyName),
								FileServices.CreateSuperFile (AutokeyPath + Version + KeyName)
						);

		// the macros seem to choke if the built super file isn't cleared
		SHARED ClearBuiltSFs(STRING KeyName, STRING Version) := 
								FileServices.ClearSuperFile(AutokeyPath + Version + KeyName);
				

		SHARED CreateAllVersions(STRING KeyName) := 
						SEQUENTIAL (CreateVersion(KeyName, 'grandfather::'),
												CreateVersion(KeyName, 'father::'),
												CreateVersion(KeyName, 'qa::'),
												CreateVersion(KeyName, 'built::')
												);

		EXPORT Do := 
						SEQUENTIAL (CreateAllVersions('autokey::payload'),
												CreateAllVersions('autokey::address'),
												CreateAllVersions('autokey::citystname'),
												CreateAllVersions('autokey::name'),
												CreateAllVersions('autokey::ssn2'),
												CreateAllVersions('autokey::stname'),
												CreateAllVersions('autokey::zip'),
												CreateAllVersions('autokey::namewords2'),
												CreateAllVersions('autokey::stname'),
												CreateAllVersions('autokey::stnameb2'),
												CreateAllVersions('autokey::zipb2'),
												CreateAllVersions('autokey::addressb2'),
												CreateAllVersions('autokey::citystnameb2'),
												CreateAllVersions('autokey::nameb2'),
												CreateAllVersions('autokey::phoneb2')
												);
END;

createAutoKeysAction := Create_AutoKeys_SuperFiles('~prte::key::prolicv2::').Do;

//sequential(createAutoKeysAction);

fileservices.createsuperfile('~prte::base::prolicv2_built');
fileservices.createsuperfile('~prte::base::prolicv2_father');
fileservices.createsuperfile('~prte::base::prolicv2_grandfather');
fileservices.createsuperfile('~prte::base::prolicv2_delete');
fileservices.createsuperfile('~prte::base::prolicv2');
fileservices.createsuperfile('~prte::in::prolicv2');

