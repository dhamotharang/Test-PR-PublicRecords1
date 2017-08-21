import busreg, strata, tools, versioncontrol;

export Strata_Population_Stats(

	 string																				pversion
	,boolean																			pIsTesting							= tools._Constants.IsDataland	
	,boolean																			pOverwrite		 					= false
	,boolean																			pUseOtherEnviron				= VersionControl._Flags.IsDataland
	,string																				pfileversion						= 'built'	
	,dataset(busreg.Layouts.Base.AID)							pBaseAIDBuilt						= busreg.Files().Base.AID.Built

) :=
module

  ds_base := project(pBaseAIDBuilt,transform(recordof(left),self.rawfields.state_code := left.clean_location_address.st,self := left ));

	Strata.mac_Pops(ds_base,	dBaseAIDPops, 'rawfields.state_code'); 
	
	Strata.mac_CreateXMLStats(dBaseAIDPops,	_Dataset().Name	,	'base_V1',	pversion,	Email_Notification_Lists.Stats	,dBaseAIDPopsOut	,'View'		,'Population'	,,pIsTesting,pOverwrite);
	
	export all := 
	if(tools.fun_IsValidVersion(pversion),
			sequential(dBaseAIDPopsOut),
			output('No Valid version parameter passed, skipping BUSREG.Strata_Population_Stats')			
		);

end;