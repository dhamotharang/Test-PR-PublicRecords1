EXPORT bwr_one_time_code := 'todo';

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
						SEQUENTIAL ( CreateAllVersions('did')
						            ,CreateAllVersions('bdid')
												,CreateAllVersions('domain')
												//,CreateAllVersions('id'),       //uncomment for internetservices superkeys
												//,CreateAllVersions('linkids')   //uncomment for internetservices superkeys
												);
END;

createMainKeysAction := Create_SuperFiles('~prte::key::whois::').Do;

//sequential(createMainKeysAction);


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
												CreateAllVersions('autokey::nameb2')
												);
END;

createAutoKeysAction := Create_AutoKeys_SuperFiles('~prte::key::internetservices::').Do;

//sequential(createAutoKeysAction);

fileservices.createsuperfile('~prte::base::whois_built');
fileservices.createsuperfile('~prte::base::whois_father');
fileservices.createsuperfile('~prte::base::whois_grandfather');
fileservices.createsuperfile('~prte::base::whois_delete');
fileservices.createsuperfile('~prte::base::whois');
fileservices.createsuperfile('~prte::in::whois');