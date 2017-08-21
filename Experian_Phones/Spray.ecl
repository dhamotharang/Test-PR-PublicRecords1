import versioncontrol;
EXPORT Spray(string version) := module

export Input := DATASET([
 	{'bctlpedata11.risk.regn.net'										
 	,'/data/hds_180/experian_index_phone/' + version   //Location to be determined                  
 	,'*.txt'                           
 	,'82'                                                             
 	,'~thor_data400::in::experian_phone::@version@'    
 	,[{'~thor_data400::in::experian_phones'}]    
 	,'thor400_44'
	,version
                      
 	}

], VersionControl.Layout_Sprays.Info);

end;