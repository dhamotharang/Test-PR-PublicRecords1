import VersionControl,_control;

export Spray := module

// export Input := DATASET([
 	// {'edata11-bld.br.seisint.com'										
 	// ,'/data_lib_2_hus2/Experian/non-fcra/' + version   //Location to be determined                  
 	// ,'*.dat'                           
 	// ,'1701'                                                             
 	// ,'~thor_dell400::in::experiancred::cpchf@version@'    
 	// ,[{'~thor_data400::in::experiancred'}]    
 	// ,'thor400_30'
	// ,version
                      
 	// }
	
export ip 		:= _control.IPAddress.bctlpedata11;
export path 	:= '/data/data_lib_2_hus2/Experian/non-fcra/in/' + version;

export Input := DATASET([
               {ip                                                                                                                                                      
               ,path   //Location to be determined                  
                ,'*.dat'                           
                ,'1701'                                                             
                ,'~thor_dell400::in::experiancred::cpchf' + version + '_@version@'    
                ,[{'~thor_data400::in::experiancred'}]    
                ,'thor400_44'
                ,version
              ,'S[0-9]{3}'            //this regex pulls the S003 from the unix filename and replaces the @version@ in the thor filename with it
                      
                }

], VersionControl.Layout_Sprays.Info);


export Delete := DATASET([
								{ip										
								,path   //Location to be determined                               
								,'DPINS'                           
								,'101'                                                             
								,'~thor_dell400::in::experiancred_delete::cpchf@version@'    
								,[{'~thor_data400::in::experiancred_delete'}]    
								,'thor400_44'
								,version
								}
							], VersionControl.Layout_Sprays.Info);



export Deceased := DATASET([
									{ip										
									,path   //Location to be determined                               
									,'DEC'                           
									,'101'                                                             
									,'~thor_dell400::in::experiancred_deceased::cpchf@version@'    
									,[{'~thor_data400::in::experiancred_deceased'}]    
									,'thor400_44'
									,version
									}
								], VersionControl.Layout_Sprays.Info);


end;