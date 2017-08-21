/********************************************************************************************************** 
			Name: 			Create_AutoKeys_SuperFiles
			Created On: 09/5/2013
			By: 				ssivasubramanian reduced by BAP down to email autokey needs and altered to email naming.
			Desc: 			Creates the super files required for creating auto keys. Call it this way with the path where
									the file has to be created.
										Create_AutoKeys_SuperFiles('~MyThor::key::MyApp::autokey::').Do
		***********************************************************************************************************/
IMPORT PRTE2_Email_Data;

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
												CreateVersion(KeyName, 'built::'),
												ClearBuiltSFs(KeyName, 'built::'));

		EXPORT Do := 
						SEQUENTIAL (CreateAllVersions('payload'),
												CreateAllVersions('address'),
												CreateAllVersions('citystname'),
												CreateAllVersions('name'),
												CreateAllVersions('ssn2'),
												CreateAllVersions('stname'),
												CreateAllVersions('zip')
												);
END;
