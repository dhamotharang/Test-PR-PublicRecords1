import	STD, _Control;
	destinationIP := _Control.IPAddress.bctlpedata10;
	destinationpath := '/data/hds_3/uniqueid/output/';

EXPORT  UnsprayGeo(integer i) :=
	
		STD.file.Despray('~thor::uniqueid::'+ Conversions.SourceCodeToFileName(UniqueId.SetOfGeoLists[i]),
			destinationIP,
			destinationpath + Conversions.SourceCodeToFileName(UniqueId.SetOfGeoLists[i]),
			allowoverwrite := true);
