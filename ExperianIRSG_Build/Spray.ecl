import VersionControl;

export Spray := module

export Input := DATASET([
 	{'edata12-bld.br.seisint.com'										
 	,'/spray_mount' //+ version   //Location to be determined                  
 	,'*.dat'                           
 	,'801'                                                             
 	,'~thor_dell400::in::experianirsg_build::cpchf@version@'    
 	,[{'~thor_data400::in::experianirsg_build'}]    
 	,'thor400_88'
	,version
                      
 	}

], VersionControl.Layout_Sprays.Info);

end;