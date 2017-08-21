export proc_create_repository_superfiles := 
	SEQUENTIAL(
	IF(NOT FileServices.SuperFileExists(NID.Common.filename_NameRepository),
		FileServices.CreateSuperFile( NID.Common.filename_NameRepository)),
	IF(NOT FileServices.SuperFileExists(NID.Common.filename_NameRepository_Base+'::prod'),
		FileServices.CreateSuperFile( NID.Common.filename_NameRepository_Base+'::prod')),
	IF(NOT FileServices.SuperFileExists(NID.Common.filename_NameRepository_Base+'::qa'),
		FileServices.CreateSuperFile( NID.Common.filename_NameRepository_Base+'::qa')),
	IF(NOT FileServices.SuperFileExists(NID.Common.filename_NameRepository_Base+'::built'),
		FileServices.CreateSuperFile( NID.Common.filename_NameRepository_Base+'::built')),
	IF(NOT FileServices.SuperFileExists(NID.Common.filename_NameRepository_Base+'::father'),
		FileServices.CreateSuperFile( NID.Common.filename_NameRepository_Base+'::father')),
	IF(NOT FileServices.SuperFileExists(NID.Common.filename_NameRepository_Base+'::delete'),
		FileServices.CreateSuperFile( NID.Common.filename_NameRepository_Base+'::delete')),
	IF(NOT FileServices.SuperFileExists(NID.Common.filename_NameRepository_Base+'::grandfather'),
		FileServices.CreateSuperFile( NID.Common.filename_NameRepository_Base+'::grandfather')),
	IF(NOT FileServices.SuperFileExists(NID.Common.filename_NameRepository_Base+'::cache'),
		FileServices.CreateSuperFile( NID.Common.filename_NameRepository_Base+'::cache'))
	
	);