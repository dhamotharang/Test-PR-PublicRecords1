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
												CreateVersion(KeyName, 'built::'),
												ClearBuiltSFs(KeyName, 'built::'));

		EXPORT Do := 
						SEQUENTIAL (CreateAllVersions('did'),
												CreateAllVersions('email_addresses')
												);
END;
