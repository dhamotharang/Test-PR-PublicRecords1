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
																												map( pHint = '50'			=> if(not pForMacroUse	,'thor50_dev01'		,'\'thor50_dev01\''			)
																														,pHint = '02'			=> if(not pForMacroUse	,'thor50_dev02'		,'\'thor50_dev02\''		)
																														,pHint = 'prod'		=> if(not pForMacroUse	,'thor400_prod'   ,'\'thor400_prod\''	  )
																														,pHint = 'sta'    => if(not pForMacroUse	,'thor400_sta01'	,'\'thor400_sta01\''		)
																														,pHint = 'dev'		=> if(not pForMacroUse	,'thor400_dev01'	,'\'thor400_dev01\''	  )
																														,										 if(not pForMacroUse	,'thor400_dev01'	,'\'thor400_dev01\''  	)
																												)
		,																										map( pHint = '66'			=> if(not pForMacroUse	,'thor400_66'			,'\'thor400_66\''			)
																														,pHint = '44'			=> if(not pForMacroUse	,'thor400_44'			,'\'thor400_44\''			)	
																														,										 if(not pForMacroUse	,'thor400_44'			,'\'thor400_44\''			) 
																												)
	);
                                                                            

	return returnstring;
	    
end;
