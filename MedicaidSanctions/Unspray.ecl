import std, _Control;
path := '/data/projects/MedicaidSanctions/';

EXPORT Unspray(string logicalname, string filename) :=
	STD.File.Despray(logicalname,
		_Control.IPAddress.bctlpedata12,
		path + filename,
		allowoverwrite := true);