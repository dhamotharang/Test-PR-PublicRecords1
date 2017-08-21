import STD;

superfile := NID.Common.filename_NameRepository_Cache;
 
export AddToCache(DATASET(Layout_Repository) ds, string lfn) := 
	IF(NOT STD.File.FileExists(lfn, true),
	SEQUENTIAL(
		OUTPUT(ds,,lfn, COMPRESSED,OVERWRITE),

		IF (STD.File.FileExists(lfn, true) AND STD.File.FindSuperFileSubName(superfile, lfn) = 0,
			STD.File.AddSuperFile(superfile, lfn),
			OUTPUT('Cannot add ' + lfn + ' to Cache')),
		OUTPUT('Added ' + lfn + ' to Name Repository Cache')
		//SendMail('charles.salvo@lexisnexis.com','Name Repository Cache updated',
		//				'Added ' + lfn + ' to Name Repository Cache')
	),
	OUTPUT(lfn + ' already exists'));