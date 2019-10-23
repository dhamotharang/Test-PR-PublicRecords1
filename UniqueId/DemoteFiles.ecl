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

					
fullFileName(string version) := uniqueIdFileBase + '::file::' + version;

					
EXPORT DemoteFiles(DATASET(Layout_Flat) file, string version) := SEQUENTIAL(
	OUTPUT(file,,fullFileName(version),compressed,OVERWRITE);
STD.File.PromoteSuperFileList([
'~thor::uniqueid::base::current',
'~thor::uniqueid::base::father',
'~thor::uniqueid::base::grandfather',
'~thor::uniqueid::base::delete'], fullFileName(version), true);

);