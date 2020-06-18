IMPORT Std, IP_Metadata;

EXPORT Spray_IP_Metadata_ipv6 (string version, const varstring eclsourceip, string srcdir, string suffixF):= FUNCTION
	
	regex := '^(/\\w+)+/\\d{8}/$';
	root := IP_Metadata.File_IP_Metadata.in_path_ipv6;

	sprayFile := std.File.SprayVariable(
		eclsourceip,
		srcdir + IF(REGEXFIND(regex,srcdir),'',version[1..8] + '/') + suffixF,,
		';',
		'\r\n',,
		STD.System.Thorlib.Group(),
		root + '_' + version,
		,
		,
		,
		true,
		false,
		true
	);

	addSuper := sequential(FileServices.StartSuperFileTransaction(),
	FileServices.RemoveOwnedSubFiles(IP_Metadata.File_IP_Metadata.raw_path_ipv6, true),
	Fileservices.AddSuperfile(IP_Metadata.File_IP_Metadata.raw_path_ipv6, root + '_' + version),
	FileServices.FinishSuperFileTransaction());

	RETURN SEQUENTIAL(sprayFile, addSuper);

END;
