import STD;
	destinationIP := _Control.IPAddress.bctlpedata10;
	destinationpath := '/data/hds_3/uniqueid/output/';

EXPORT Unspray(integer i) :=
	
		STD.file.Despray('~thor::uniqueid::'+ Conversions.SourceCodeToFileName(SetOfLists[i]),
			destinationIP,
			destinationpath + Conversions.SourceCodeToFileName(SetOfLists[i]),
			allowoverwrite := true);