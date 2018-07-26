/*
  -- Clusters are now different between workunits and files.  files require the extra '01', '02', etc to be appended to the cluster name.
  -- Workunits do not require this and will fail if they have it.
  -- This function is for workunits.  if you are interested in files, USE tools.fun_Clustername_DFU.
  -- this is true on dataland for now, doesn't seem to be true on prod yet...
*/
import _control;
export fun_Groupname(
	
	 string		pHint					= ''
	,boolean	pForMacroUse	= false 
	,boolean  pUseGit       = false
) :=
function

  addeclcc := if(pUseGit = true ,'_eclcc','');

	returnstring :=
	map( _Control.ThisEnvironment.name	 = 'Dataland' =>	
																												map( pHint = '50'			=> if(not pForMacroUse	,'thor50_dev'		+ addeclcc  ,'\'thor50_dev' + addeclcc + '\''			)
																														,pHint = '02'			=> if(not pForMacroUse	,'thor50_dev02'	+ addeclcc  ,'\'thor50_dev02' + addeclcc + '\''	  )
																														,pHint = 'prod'		=> if(not pForMacroUse	,'thor400_prod' + addeclcc  ,'\'thor400_prod' + addeclcc + '\''	  )
																														,pHint = 'sta'    => if(not pForMacroUse	,'thor400_sta'	+ addeclcc  ,'\'thor400_sta' + addeclcc + '\''		)
																														,pHint = 'dev'		=> if(not pForMacroUse	,'thor400_dev'	+ addeclcc  ,'\'thor400_dev' + addeclcc + '\''	  )
																														,										 if(not pForMacroUse	,'thor400_dev'	+ addeclcc  ,'\'thor400_dev' + addeclcc + '\''  	)
																												) 
    ,																										map( pHint = '66'			  => if(not pForMacroUse	,'thor400_66'			    + addeclcc  ,'\'thor400_66'         + addeclcc + '\''	)																												
                                                            ,pHint = '44'			  => if(not pForMacroUse	,'thor400_44'			    + addeclcc  ,'\'thor400_44'         + addeclcc + '\''	)																												
                                                            ,pHint = 'scoring'  => if(not pForMacroUse	,'thor400_44_scoring'	+ addeclcc  ,'\'thor400_44_scoring' + addeclcc + '\'' )																												
                                                            ,pHint = 'sla'			=> if(not pForMacroUse	,'thor400_44_sla'			+ addeclcc  ,'\'thor400_44_sla'     + addeclcc + '\''	)																												
                                                            ,										   if(not pForMacroUse	,'thor400_44'			    + addeclcc  ,'\'thor400_44'         + addeclcc + '\''	)
																												)
	);
                                                                            

	return returnstring;
	    
end;



