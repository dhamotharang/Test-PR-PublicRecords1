export boolean NameRepositoryExists := 
	IF(FileServices.SuperFileExists(NID.Common.filename_NameRepository),
		FileServices.GetSuperFileSubCount(NID.Common.filename_NameRepository) > 0,
		false);