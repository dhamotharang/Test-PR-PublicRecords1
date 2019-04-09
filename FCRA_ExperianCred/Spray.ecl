import VersionControl,_Control,std;

export Spray(string ver) := module

export ip 		:= _Control.IPAddress.bctlpedata11;
export path 	:= '/data/data_lib_2_hus2/Experian/FCRA/in/' + ver;

export load := DATASET([
 	{ip
 	,path   //Location to be determined by operations                
 	,'D*LEXNEX*EXP*FCRA.dat'                           
 	,'3775'                                                             
 	,'~thor_data400::in::FCRA::ExperianCred_load_' + ver    
 	,[{'~thor_data400::in::FCRA::ExperianCred_load'}]    
 	,std.system.job.target()
	,ver
	,'S[0-9]{3}'
 	}
], VersionControl.Layout_Sprays.Info);

export Updates := DATASET([
 	{ip
 	,path   //Location to be determined by operations                
 	,'D*LEXNEX*FCRA.dat'                           
 	,'3775'                                                             
 	,'~thor_data400::in::FCRA::ExperianCred_updates_' + ver
 	,[{'~thor_data400::in::FCRA::ExperianCred_updates'}]    
 	,std.system.job.target()
	,ver
	,'S[0-9]{3}' 	}
], VersionControl.Layout_Sprays.Info);

export Deletes := DATASET([
 	{ip
 	,path   //Location to be determined by operations                
 	,'DPINS'                           
 	,'101'                                                             
 	,'~thor_data400::in::FCRA::ExperianCred_deletes_' + ver    
 	,[{'~thor_data400::in::FCRA::ExperianCred_deletes'}]    
 	,std.system.job.target()
	,ver
 	}
], VersionControl.Layout_Sprays.Info);

export Deceased := DATASET([
 	{ip
 	,path
 	,'DEC'                           
 	,'101'                                                             
 	,'~thor_data400::in::FCRA::ExperianCred_deceased_' + ver    
 	,[{'~thor_data400::in::FCRA::ExperianCred_deceased'}]    
 	,std.system.job.target()
	,ver
 	}
], VersionControl.Layout_Sprays.Info);

end;