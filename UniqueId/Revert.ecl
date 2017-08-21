uniqueIdFileBase := '~thor::uniqueid::base';
CopySuperFile(string superFrom, string superTo, boolean clearTo = false) := 

	If(NOTHOR(Exists(FileServices.SuperFileContents(superFrom))),
		SEQUENTIAL(
			FileServices.StartSuperFileTransaction( ),
			IF(clearTo,NOTHOR(FileServices.ClearSuperFile(superTo))),
			NOTHOR(apply(FileServices.SuperFileContents(superFrom),
				FileServices.AddSuperFile(superTo, '~'+name))),
			FileServices.FinishSuperFileTransaction( )
		)
	);
	
Move(string fromVersion, string toVersion) :=
	CopySuperFile(uniqueIdFileBase+'::'+fromVersion,
					uniqueIdFileBase+'::'+toVersion, true);
					
currnm := '~thor::in::uniqueid::entity';
					
EXPORT Revert(string version) := 

	SEQUENTIAL(
		Move('father','current'),	// move father to current
		FileServices.StartSuperFileTransaction( ),
			NOTHOR(FileServices.ClearSuperFile(currnm)),
			FileServices.AddSuperFile(currnm,currnm + '::'+version),
		FileServices.FinishSuperFileTransaction( )
	);
