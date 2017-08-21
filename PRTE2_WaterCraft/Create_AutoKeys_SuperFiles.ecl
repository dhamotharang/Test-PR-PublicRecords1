/********************************************************************************************************** 
	Name: 			Create_AutoKeys_SuperFiles
	Created On: 09/3/2013
	By: 				ssivasubramanian
	Desc: 			Creates the super files required for creating auto keys. Call it this way with the path where
							the file has to be created.
								Create_AutoKeys_SuperFiles('~MyThor::key::MyApp::autokey::').Do
***********************************************************************************************************/

EXPORT Create_AutoKeys_SuperFiles(STRING AutokeyPath) := MODULE

SHARED CreateVersion(STRING KeyName, STRING Version) := 
				IF (~FileServices.FileExists (AutokeyPath + KeyName + '_' + Version),
					FileServices.CreateSuperFile (AutokeyPath + KeyName + '_' + Version));
		

SHARED CreateAllVersions(STRING KeyName) := 
				SEQUENTIAL (CreateVersion(KeyName, 'grandfather'),
										CreateVersion(KeyName, 'father'),
										CreateVersion(KeyName, 'qa'),
										CreateVersion(KeyName, 'built'));

EXPORT Do := 
				SEQUENTIAL (CreateAllVersions('payload'),
										CreateAllVersions('address'),
										CreateAllVersions('citystname'),
										CreateAllVersions('name'),
										CreateAllVersions('phone2'),
										CreateAllVersions('ssn2'),
										CreateAllVersions('stname'),
										CreateAllVersions('zip'),
										CreateAllVersions('addressb2'),
										CreateAllVersions('citystnameb2'),
										CreateAllVersions('nameb2'),
										CreateAllVersions('namewords2'),
										CreateAllVersions('phoneb2'),
										CreateAllVersions('fein2'),
										CreateAllVersions('stnameb2'),
										CreateAllVersions('zipb2'));
END;

