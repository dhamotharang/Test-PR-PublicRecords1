import VersionControl;

export Spray := module

export Input := DATASET([
 	{'edata14-bld.br.seisint.com'										
 	,'/load01/choicepoint_inbound/experian/incremental09/'// + version   //Location to be determined                  
 	,'*.dat'                           
 	,'1701'                                                             
 	,'~thor_dell400::in::experiancred::cpchf@version@'    
 	,[{'~thor_data400::in::experiancred'}]    
 	,'thor400_84'
	,version
                      
 	}

], VersionControl.Layout_Sprays.Info);


export Delete := DATASET([
 	{'edata14-bld.br.seisint.com'										
 	,'/load01/choicepoint_inbound/experian/incremental09/'// + version   //Location to be determined                  
 	,'*.del'                           
 	,'23'                                                             
 	,'~thor_dell400::in::experiancred_delete::cpchf@version@'    
 	,[{'~thor_data400::in::experiancred_delete'}]    
 	,'thor400_84'
	,version
 	}
], VersionControl.Layout_Sprays.Info);

end;