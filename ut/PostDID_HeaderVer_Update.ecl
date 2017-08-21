import did_add,_Control,header;
export PostDID_HeaderVer_Update(string datasetname,string pkgvar='header_file_version',STRING roxie_ip=_Control.RoxieEnv.prod_batch_neutral) :=
	header.PostDID_HeaderVer_Update(datasetname,pkgvar,roxie_ip):DEPRECATED('Use header.PostDID_HeaderVer_Update instead');
