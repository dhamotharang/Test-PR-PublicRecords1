IMPORT Std;

EXPORT Spray_IP_Metadata (string version, const varstring eclsourceip, string srcdir, string suffixF):= FUNCTION
	
	regex := '^(/\\w+)+/\\d{8}/$';
	root := '~thor_data400::in::ip_metadata_';

	sprayFile := std.File.SprayVariable(
		eclsourceip,
		srcdir + IF(REGEXFIND(regex,srcdir),'',version[1..8] + '/') + suffixF,,
		';',
		'\r\n',,
		STD.System.Thorlib.Group(),
		root + version,
		,
		,
		,
		true,
		false,
		true
	);

	addSuper := sequential(FileServices.StartSuperFileTransaction(),
	FileServices.RemoveOwnedSubFiles('~thor_data400::in::ip_metadata_raw', true),
	Fileservices.AddSuperfile('~thor_data400::in::ip_metadata_raw', root + version),
	FileServices.FinishSuperFileTransaction());

	RETURN SEQUENTIAL(sprayFile, addSuper);

END;
