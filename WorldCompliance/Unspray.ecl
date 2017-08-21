import std;
path := '/data/hds_3/WorldCompliance/output/';

EXPORT Unspray(string logicalname, string filename) :=
	STD.File.Despray(logicalname,
		'bctlpedata10.risk.regn.net',
		path + filename,
		allowoverwrite := true);