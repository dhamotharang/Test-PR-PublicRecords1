import versioncontrol;
EXPORT Spray(string version) := module

export Input := DATASET([
 	{'edata12-bld.br.seisint.com'										
 	,'/hds_180/experian_fein/data/' + version                      
 	,'*.TXT'                           
 	,'291'                                                             
 	,'~thor_data400::in::experian_fein::@version@'    
 	,[{'~thor_data400::in::experian_fein::sprayed::data'}]
 	,'thor400_20'
	,version
                      
 	}

], VersionControl.Layout_Sprays.Info);

end;