/*
  -- Clusters are now different between workunits and files.  files require the extra '01', '02', etc to be appended to the cluster name.
  -- Workunits do not require this and will fail if they have it.
  -- This function is for workunits.  if you are interested in files, USE tools.fun_Clustername_DFU.
*/
import _control;
export fun_Groupname(
	
	 string		pHint					= ''
	,boolean	pForMacroUse	= false 
	
) :=
function

	returnstring :=
	map( _Control.ThisEnvironment.name	 = 'Dataland' =>	
																												map( pHint = '50'			=> if(not pForMacroUse	,'thor50_dev'		,'\'thor50_dev\''			)
																														,pHint = '02'			=> if(not pForMacroUse	,'thor50_dev02'		,'\'thor50_dev02\''		  )
																														,pHint = 'prod'		=> if(not pForMacroUse	,'thor400_prod' ,'\'thor400_prod\''	  )
																														,pHint = 'sta'    => if(not pForMacroUse	,'thor400_sta'	,'\'thor400_sta\''		)
																														,pHint = 'dev'		=> if(not pForMacroUse	,'thor400_dev'	,'\'thor400_dev\''	  )
																														,										 if(not pForMacroUse	,'thor400_dev'	,'\'thor400_dev\''  	)
																												)
		,																										map( pHint = '92'			=> if(not pForMacroUse	,'thor400_92'			,'\'thor400_92\''			)
																														,pHint = '20'			=> if(not pForMacroUse	,'thor400_20'			,'\'thor400_20\''			)																												
																														,pHint = '30'			=> if(not pForMacroUse	,'thor400_30'			,'\'thor400_30\''			)																												
																														,										 if(not pForMacroUse	,'thor400_30'			,'\'thor400_30\''			)
																												)
	);
                                                                            

	return returnstring;
	    
end;
