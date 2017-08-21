import	STD;
	destinationIP := 'bctlpedata10.risk.regn.net';
	destinationpath := '/data/hds_3/uniqueid/output/';

EXPORT  UnsprayGeo(integer i) :=
	
		STD.file.Despray('~thor::uniqueid::'+ Conversions.SourceCodeToFileName(UniqueId.SetOfGeoLists[i]),
			destinationIP,
			destinationpath + Conversions.SourceCodeToFileName(UniqueId.SetOfGeoLists[i]),
			allowoverwrite := true);
