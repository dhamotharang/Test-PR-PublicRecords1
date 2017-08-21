// assumes files have been sprayed
// update VERSION before running
SEQUENTIAL(
	IF (NOT FileServices.SuperFileExists(EASI2010.Cluster + 'base::easi'),
				FileServices.CreateSuperFile(EASI2010.Cluster + 'base::easi')),
	EASI2010.proc_Build_Base,
	EASI2010.proc_BuildKeys
);
