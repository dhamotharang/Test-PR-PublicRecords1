import VersionControl;
export Spray := DATASET([
 	{'edata12-bld.br.seisint.com'										
 	,'/hds_1/advo/' + version                      
 	,'ELF_BASE_*.dat'                           
 	,'302'                                                             
 	,'~thor_data400::in::advo::@version@'    
 	,[{'~thor_data400::in::advo'}]    
 	,'thor400_84'
                                
 	}

], VersionControl.Layout_Sprays.Info);