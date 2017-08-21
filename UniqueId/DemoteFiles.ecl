import STD;
uniqueIdFileBase := '~thor::uniqueid::base';

superFileName(string level) := uniqueIdFileBase + '::' + level;

CreateSuperFiles := SEQUENTIAL(
		if (NOT STD.File.SuperFileExists(superFileName('delete')),
				STD.File.CreateSuperFile(superFileName('delete')));
		if (NOT STD.File.SuperFileExists(superFileName('grandfather')),
				STD.File.CreateSuperFile(superFileName('grandfather')));
		if (NOT STD.File.SuperFileExists(superFileName('father')),
				STD.File.CreateSuperFile(superFileName('father')));
		if (NOT STD.File.SuperFileExists(superFileName('current')),
				STD.File.CreateSuperFile(superFileName('current')));
);

CopySuperFile(string superFrom, string superTo, boolean clearFrom = false) := 

	If(NOTHOR(Exists(FileServices.SuperFileContents(superFrom))),
		SEQUENTIAL(
			FileServices.StartSuperFileTransaction( ),
			NOTHOR(apply(FileServices.SuperFileContents(superFrom),
				FileServices.AddSuperFile(superTo, '~'+name))),
			IF(clearFrom,NOTHOR(FileServices.ClearSuperFile(superFrom))),
			FileServices.FinishSuperFileTransaction( )
		)
	);
	
Move(string fromVersion, string toVersion) :=
	CopySuperFile(uniqueIdFileBase+'::'+fromVersion,
					uniqueIdFileBase+'::'+toVersion, true);
					
fullFileName(string version) := uniqueIdFileBase + '::file::' + version;
					
EXPORT DemoteFiles(DATASET(Layout_Flat) file, string version) := SEQUENTIAL(
	OUTPUT(file,,fullFileName(version),OVERWRITE);
	NOTHOR(CreateSuperfiles),
	Move('grandfather','delete'),	// move grandfather to delete
	Move('father','grandfather'),	// move father to grandfather
	Move('current','father'),	// move current to father
	// add new files to current
	FileServices.StartSuperFileTransaction( ),
		NOTHOR(FileServices.AddSuperFile(uniqueIdFileBase+'::current', fullFileName(version))),
	FileServices.FinishSuperFileTransaction( ),


);