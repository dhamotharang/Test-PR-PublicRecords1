import _control;
export Groupname(
	
	 string		pHint					= ''
	,boolean	pForMacroUse	= false 
	
) :=
function

	returnstring :=
	map( pHint = '50'				and _Control.ThisEnvironment.name	 = 'Dataland' =>	if(not pForMacroUse, 'thor_data50'				, '\'thor_data50\''					)
			,pHint = '200'			and _Control.ThisEnvironment.name	!= 'Dataland' =>	if(not pForMacroUse, 'thor_200'						, '\'thor_200\''						)
			,pHint = 'dell'			and _Control.ThisEnvironment.name	!= 'Dataland' =>	if(not pForMacroUse, 'thor_dell400'       , '\'thor_dell400\''				)
			,pHint = 'staging'	and _Control.ThisEnvironment.name	 = 'Dataland' =>	if(not pForMacroUse, 'thor400_88'					, '\'thor400_88\''					)
			,pHint = 'dev'			and _Control.ThisEnvironment.name	 = 'Dataland' =>	if(not pForMacroUse, 'thor400_88_dev'     , '\'thor400_88_dev\''			)
			,												_Control.ThisEnvironment.name	 = 'Dataland' =>	if(not pForMacroUse, 'thor400_88'					, '\'thor400_88\''					)
			,																																				if(not pForMacroUse, 'thor400_84'					, '\'thor400_84\''					)
	);                                                                                                        
	
	return returnstring;
	    
end;