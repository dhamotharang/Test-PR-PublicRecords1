IMPORT STD, versioncontrol;

EXPORT Spray(
	STRING  hostname,
	STRING  absolutePath,
	STRING  glob,
	INTEGER recordsize,
	STRING  version,
	STRING  cluster = 'Thor400_44'
) := MODULE

	EXPORT Input := DATASET([{
		hostname,
		IF(STD.Str.EndsWith('absolutePath','/'), absolutePath + '/', absolutePath),
		glob,
		recordsize,
		'~thor_data400::in::experian_fein::@version@',
		[{'~thor_data400::in::experian_fein::sprayed::data'}],
		cluster,
		version
	}], VersionControl.Layout_Sprays.Info);

END;
