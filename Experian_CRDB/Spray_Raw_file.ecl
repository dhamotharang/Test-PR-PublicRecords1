import versioncontrol;
EXPORT Spray_Raw_file(string version) := module

export Input := DATASET([
 	{'uspr-edata11.risk.regn.net' //'edata12-bld.br.seisint.com'										
 	,'/data/hds_180/experian_CRDB/data/' + version                      
 	,'*.TXT'                           
 	,'4777'                                                             
 	,'~thor_data400::in::experian_CRDB::@version@'    
 	,[{'~thor_data400::in::Experian_CRDB::sprayed::data'}]
 	,Experian_CRDB._Dataset().Groupname											
	,version
                      
 	}

], VersionControl.Layout_Sprays.Info);

end;