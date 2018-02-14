/*
  -- Clusters are now different between workunits and files.  files require the extra '01', '02', etc to be appended to the cluster name.
  -- Workunits do not require this and will fail if they have it.
  -- This function is for files(spray,copy, etc)  if you are interested in workunits, use tools.fun_Groupname
*/

import _control;
export fun_Clustername_DFU(
	
	 string		pHint					= ''
	,boolean	pForMacroUse	= false 
	
) :=
function

	returnstring :=
	map( _Control.ThisEnvironment.name	 = 'Dataland' =>	
																												map( pHint = '50'			    => if(not pForMacroUse	,'thor50_dev01_2'		,'\'thor50_dev01_2\''	  )
																														,pHint = 'dev02'			=> if(not pForMacroUse	,'thor50_dev05_2'		,'\'thor50_dev05_2\''		)
                                                            ,pHint = 'dev05'      => if(not pForMacroUse  ,'thor50_dev05_2'   ,'\'thor50_dev05_2\''   )
                                                            ,pHint = 'dev08'      => if(not pForMacroUse  ,'thor50_dev05_2'   ,'\'thor50_dev05_2\''   )
																																																												
																														,pHint = 'sta'        => if(not pForMacroUse	,'thor400_sta01_2'	,'\'thor400_sta01_2\''	)
                                                            
																														,pHint = 'dev'		    => if(not pForMacroUse	,'thor400_dev01_2'	,'\'thor400_dev01_2\''	)
																														,										     if(not pForMacroUse	,'thor400_dev01_2'	,'\'thor400_dev01_2\''  )
																												)
		,																										map( pHint = '60'			=> if(not pForMacroUse	,'thor400_60'			,'\'thor400_60\''			)
																														,pHint = '44'			=> if(not pForMacroUse	,'thor400_44'			,'\'thor400_44\''			)	
																														,										 if(not pForMacroUse	,'thor400_44'			,'\'thor400_44\''			) 
																												)
	);
                                                                            

	return returnstring;
	    
end;