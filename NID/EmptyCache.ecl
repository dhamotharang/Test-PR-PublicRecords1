import STD;
EXPORT EmptyCache := 
SEQUENTIAL(
	STD.File.StartSuperFileTransaction( ),
		STD.File.ClearSuperFile(Nid.Common.filename_NameRepository_Cache, true),
	STD.File.FinishSuperFileTransaction( ),
	STD.System.Email.SendEmail ('charles.salvo@lexisnexisrisk.com', 'Clear Nid Cache', 
													'NID Cache Cleared\r\n' + workunit )
);
