import STD;
	destinationIP := 'bctlpedata10.risk.regn.net';
	destinationpath := '/data/hds_3/uniqueid/output/';

EXPORT Unspray(integer i) :=
	
		STD.file.Despray('~thor::uniqueid::'+ Conversions.SourceCodeToFileName(SetOfLists[i]),
			destinationIP,
			destinationpath + Conversions.SourceCodeToFileName(SetOfLists[i]),
			allowoverwrite := true);