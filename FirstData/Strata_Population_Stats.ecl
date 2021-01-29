IMPORT Strata, tools;

EXPORT Strata_Population_Stats(
	STRING  pVersion,
	STRING  pContacts,
	BOOLEAN pIsTesting = FALSE,
	BOOLEAN pOverwrite = FALSE,
	DATASET(layout.base) pFirstdataBase = Files().file_base
) := MODULE
	Strata.mac_Pops(pFirstDataBase, dFirstDataBasePops);

	Strata.mac_CreateXMLStats(
		dFirstDataBasePops,
		_Dataset().pDatasetName,
		'Base',
		pVersion,
		pContacts,
		FirstDataBasePopsOut,
		'View',
		'Population',,
		pIsTesting,
		pOverwrite
	);


	EXPORT ALL := IF(tools.fun_IsValidVersion(pVersion),dFirstDataBasePopsOut);
END;
