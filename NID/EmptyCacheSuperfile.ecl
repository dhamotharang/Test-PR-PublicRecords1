EXPORT EmptyCacheSuperfile := SEQUENTIAL(
	FileServices.StartSuperFileTransaction( ),
		FileServices.ClearSuperFile(Nid.Common.filename_NameRepository_Cache, true),
	FileServices.FinishSuperFileTransaction( ),
);