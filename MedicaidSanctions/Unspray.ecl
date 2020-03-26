import std, _Control;
path := '/data/hds_3/MedicaidSanctions/output/';

EXPORT Unspray(string logicalname, string filename) :=
	STD.File.Despray(logicalname,
		_Control.IPAddress.bctlpedata12,
		path + filename,
		allowoverwrite := true);