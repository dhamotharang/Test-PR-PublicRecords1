import std, _Control;
path := '/data/hds_3/WorldCompliance/test/';

EXPORT Unspray(string logicalname, string filename) :=
	STD.File.Despray(logicalname,
		_Control.IPAddress.bctlpedata10,
		path + filename,
		allowoverwrite := true);