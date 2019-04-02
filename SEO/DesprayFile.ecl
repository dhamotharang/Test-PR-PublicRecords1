import STD, _Control;

destinationIP := _Control.IPAddress.bctlpedata12;

destination := '/data/projects/seo/';

EXPORT DesprayFile(string lfn, string version) := 
		STD.file.Despray(lfn,
			destinationIP,
			destination + 'seo' + version + 'csv',
			allowoverwrite := true);
