import ut,_Control;
import header;
export IsNewProdHeaderVersion(string datasetname,string pkgvar='header_file_version',STRING roxie_ip=_Control.RoxieEnv.prod_batch_neutral,dataset(ut.Layout_PackageVariable) ds  = dataset([],ut.Layout_PackageVariable)) := 
	header.IsNewProdHeaderVersion (datasetname,pkgvar,roxie_ip,ds):DEPRECATED('Use header.IsNewProdHeaderVersion instead');
