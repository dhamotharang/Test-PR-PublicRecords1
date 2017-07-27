import lib_fileservices;

superfile := NID.Common.filename_NameRepository_Cache;	
//superfile := NID.Common.filename_NameRepository;
 
export AddToRepository(DATASET(NID.Layout_Repository) ds, string filename) := 
	SEQUENTIAL(
		OUTPUT(ds,,filename, COMPRESSED,OVERWRITE),
		IF(NOT FileServices.SuperFileExists(superfile),
			FileServices.CreateSuperFile(superfile)),

		FileServices.StartSuperfileTransaction(),
		IF(FileServices.FindSuperFileSubName(superfile, filename) > 0,
		FileServices.RemoveSuperFile(superfile, filename, false)), 
		FileServices.AddSuperFile(superfile, filename),
		FileServices.FinishSuperfileTransaction(),
		OUTPUT('Added ' + filename + ' to Name Repository'),
		SendMail('charles.salvo@lexisnexis.com','Name Repository Cache updated',
						'Added ' + filename + ' to Name Repository Cache')
	);
