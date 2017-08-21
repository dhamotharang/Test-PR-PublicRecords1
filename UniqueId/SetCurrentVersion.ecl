currnm := '~thor::in::uniqueid::entity';

EXPORT SetCurrentVersion(string version) := SEQUENTIAL(
		FileServices.StartSuperFileTransaction( ),
			NOTHOR(FileServices.ClearSuperFile(currnm)),
			FileServices.AddSuperFile(currnm,currnm + '::'+version),
		FileServices.FinishSuperFileTransaction( )
);