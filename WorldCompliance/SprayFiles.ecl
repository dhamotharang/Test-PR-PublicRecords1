﻿import std, _control;
srcdir := '/data/hds_3/WorldCompliance/input/';

sprayFile(string version, string filename, string outname) := 

		std.File.SprayVariable(_control.IPAddress.bctlpedata10,
							srcdir + version + '/' + filename,
							8192,'|',,'\t',						// pipe delimited, no quote character
							'thor400_44',
							root + outname,
							,,,true,true,false
						);
						
sfEntity 					:= root + 'entity'; 
sfAddress 				:= root + 'addresses'; 
sfRelationship 		:= root + 'relationships'; 
sfWhiteListEntity := root + 'whitelistentity';
sfSanctionsDOB 		:= root + 'SanctionsDOB';


CreateSuperfiles := SEQUENTIAL(
		if (NOT STD.File.SuperFileExists(sfEntity),
				STD.File.CreateSuperFile(sfEntity));
		if (NOT STD.File.SuperFileExists(sfAddress),
				STD.File.CreateSuperFile(sfAddress));
		if (NOT STD.File.SuperFileExists(sfRelationship),
				STD.File.CreateSuperFile(sfRelationship));
		if (NOT STD.File.SuperFileExists(sfWhiteListEntity),
				STD.File.CreateSuperFile(sfWhiteListEntity));
		if (NOT STD.File.SuperFileExists(sfSanctionsDOB),
				STD.File.CreateSuperFile(sfSanctionsDOB));
);

EXPORT SprayFiles(string version) := SEQUENTIAL
(	
	CreateSuperFiles,
	FileServices.StartSuperFileTransaction( ),
		FileServices.ClearSuperFile(sfEntity, false),
		FileServices.ClearSuperFile(sfAddress, false),
		FileServices.ClearSuperFile(sfRelationship, false),
		FileServices.ClearSuperFile(sfWhiteListEntity, false),
		FileServices.ClearSuperFile(sfSanctionsDOB, false),
	FileServices.FinishSuperFileTransaction( ),
	PARALLEL(
			sprayFile(version, 'Entities.txt', 'entities' + '::' + version),
			sprayFile(version, 'EntitiesAddresses.txt', 'addresses' + '::' + version),
			sprayFile(version, 'EntitiesRelationships.txt', 'relationships' + '::' + version),
			sprayFile(version, 'EntitiesSources.txt', 'sources'),
			sprayFile(version, 'EntitiesCountries.txt', 'countries'),
			sprayFile(version, 'EntitiesCategories.txt', 'categories'),
			sprayFile(version, 'EntitiesSubCategories.txt', 'subcategories'),
			sprayFile(version, 'EntitiesRelDefs.txt', 'reldefs'),
			sprayFile(version, 'WhiteListEntities.txt', 'WhiteListEntities' + '::' + version),
			sprayFile(version, 'SanctionsDOB.txt', 'SanctionsDOB' + '::' + version),
	),
	FileServices.StartSuperFileTransaction( ),
		FileServices.AddSuperFile(sfEntity, root + 'entities' + '::' + version),
		FileServices.AddSuperFile(sfAddress, root + 'addresses' + '::' + version),
		FileServices.AddSuperFile(sfRelationship, root + 'relationships' + '::' + version),
		FileServices.AddSuperFile(sfWhiteListEntity, root + 'WhiteListEntities' + '::' + version),
		FileServices.AddSuperFile(sfSanctionsDOB, root + 'SanctionsDOB' + '::' + version),
	FileServices.FinishSuperFileTransaction( )
);