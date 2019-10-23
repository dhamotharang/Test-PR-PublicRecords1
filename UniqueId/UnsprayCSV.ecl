import STD, _Control;
	destinationIP := _Control.IPAddress.bctlpedata10;
	destinationpath := '/data/hds_3/uniqueid/output/';
	
EXPORT UnsprayCSV(string lfn) := 
		STD.file.Despray(lfn,
			destinationIP,
			destinationpath + REGEXFIND('([A-Za-z.]+)$', lfn, 1),
			allowoverwrite := true);