import versionControl,_control;

export Spray(string ver) := module

export ip 		:= _control.IPAddress.bctlpedata11;
export path 	:= '/data/data_lib_2_hus2/Experian/non-fcra/in/' + ver;

export Input := DATASET([
               {ip                                                                                                                                                      
               ,path   //Location to be determined                  
                ,'*.dat'                           
                ,'1701'                                                             
                ,'~thor_dell400::in::experiancred::cpchf' + ver + '_' + ver    
                ,[{'~thor_data400::in::experiancred'}]    
                ,'thor400_44'
                ,ver
              ,'S[0-9]{3}'            //this regex pulls the S003 from the unix filename and replaces the @ver@ in the thor filename with it
                      
                }

], versionControl.Layout_Sprays.Info);


export Delete := DATASET([
								{ip										
								,path   //Location to be determined                               
								,'DPINS'                           
								,'101'                                                             
								,'~thor_dell400::in::experiancred_delete::cpchf' + ver    
								,[{'~thor_data400::in::experiancred_delete'}]    
								,'thor400_44'
								,ver
								}
							], versionControl.Layout_Sprays.Info);



export Deceased := DATASET([
									{ip										
									,path   //Location to be determined                               
									,'DEC'                           
									,'101'                                                             
									,'~thor_dell400::in::experiancred_deceased::cpchf' + ver
									,[{'~thor_data400::in::experiancred_deceased'}]    
									,'thor400_44'
									,ver
									}
								], versionControl.Layout_Sprays.Info);


end;