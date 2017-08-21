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
						SEQUENTIAL ( CreateAllVersions('did')
						            ,CreateAllVersions('bdid')
									,CreateAllVersions('lnpid')
									,CreateAllVersions('reg_num')     
									,CreateAllVersions('linkids')   
												);
END;

createMainKeysAction := Create_SuperFiles('~prte::key::dea::').Do;

sequential(createMainKeysAction);


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
						SEQUENTIAL (			
												CreateAllVersions('autokey::payload'),
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
												CreateAllVersions('autokey::nameb2')
												);
END;

createAutoKeysAction := Create_AutoKeys_SuperFiles('~prte::key::dea::').Do;

sequential(createAutoKeysAction);

fileservices.createsuperfile('~prte::base::dea_built');
fileservices.createsuperfile('~prte::base::dea_father');
fileservices.createsuperfile('~prte::base::dea_grandfather');
fileservices.createsuperfile('~prte::base::dea_delete');
fileservices.createsuperfile('~prte::base::dea');
fileservices.createsuperfile('~prte::in::dea');
