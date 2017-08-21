import STD;
	destinationIP := 'bctlpedata10.risk.regn.net';
	destinationpath := '/data/hds_3/uniqueid/output/';
	
EXPORT UnsprayCSV(string lfn) := 
		STD.file.Despray(lfn,
			destinationIP,
			destinationpath + REGEXFIND('([A-Za-z.]+)$', lfn, 1),
			allowoverwrite := true);