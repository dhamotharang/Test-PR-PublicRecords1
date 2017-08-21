

EXPORT Create_Superfiles (STRING KeyFilePath) := MODULE

		SHARED CreateVersion(STRING KeyName, STRING Version) := 
						IF (~FileServices.FileExists (KeyFilePath + Version + KeyName),
							FileServices.CreateSuperFile (KeyFilePath + Version + KeyName));
				
		// the macros seem to choke if the built super file isn't cleared
		SHARED ClearBuiltSFs(STRING KeyName, STRING Version) := 
								FileServices.ClearSuperFile(KeyFilePath + Version + KeyName);

		SHARED CreateAllVersions(STRING KeyName) := 
						SEQUENTIAL (			CreateVersion('_grandfather',KeyName,),
												CreateVersion('_father', KeyName),
												CreateVersion('_qa',KeyName ),
												CreateVersion('_built',KeyName )
												);

		EXPORT Do := 
						SEQUENTIAL ( CreateAllVersions('death_id_death_supplemental')
									,CreateAllVersions('dod_death_masterV2')
									,CreateAllVersions('did_death_masterV2')   
									,CreateAllVersions('death_id_death_masterV2') 
									,CreateAllVersions('dob_death_masterV2') 
									,CreateAllVersions('death_master::ssn') 
									,CreateAllVersions('fcra::death_master::ssn') 
									,CreateAllVersions('fcra::did_death_masterV2')
							
						            ,CreateAllVersions('death_id_death_supplemental_ssa')
									,CreateAllVersions('dod_death_masterV2_ssa')
									,CreateAllVersions('did_death_masterV2_ssa')   
									,CreateAllVersions('death_id_death_masterV2_ssa') 
									,CreateAllVersions('dob_death_masterV2_ssa') 
									,CreateAllVersions('death_master_ssa::ssn') 
									,CreateAllVersions('fcra::death_master_ssa::ssn') 
									,CreateAllVersions('fcra::did_death_masterV2_ssa') 
									);
END;

createMainKeysAction := Create_SuperFiles('~prte::key::').Do;

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
						SEQUENTIAL (			CreateVersion(KeyName, 'grandfather::'),
												CreateVersion(KeyName, 'father::'),
												CreateVersion(KeyName, 'qa::' ),
												CreateVersion(KeyName, 'built::' )
												);

		EXPORT Do := 
						SEQUENTIAL 			   (CreateAllVersions('autokey::payload'),
												CreateAllVersions('autokey::address'),
												CreateAllVersions('autokey::citystname'),
												CreateAllVersions('autokey::name'),
												CreateAllVersions('autokey::ssn2'),
												CreateAllVersions('autokey::stname'),
												CreateAllVersions('autokey::zip'),
												CreateAllVersions('autokey::namewords2'),
												CreateAllVersions('autokey::stname')
												CreateAllVersions('autokey::stnameb2'),
												CreateAllVersions('autokey::zipb2'),
												CreateAllVersions('autokey::addressb2'),
												CreateAllVersions('autokey::citystnameb2'),
												CreateAllVersions('autokey::nameb2')
												);
END;

createAutoKeysAction := Create_AutoKeys_SuperFiles('~prte::key::death_masterv2::').Do;
createAutoKeysAction2 := Create_AutoKeys_SuperFiles('~prte::key::death_masterv2_ssa::').Do;
sequential(createAutoKeysAction,createAutoKeysAction2);

fileservices.createsuperfile('~prte::base::death_master_plus_built');
fileservices.createsuperfile('~prte::base::death_master_plus_father');
fileservices.createsuperfile('~prte::base::death_master_plus_grandfather');
fileservices.createsuperfile('~prte::base::death_master_plus_delete');
fileservices.createsuperfile('~prte::base::death_master_plus');
fileservices.createsuperfile('~prte::in::death_master_plus');