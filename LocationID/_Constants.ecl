import tools;
export _Constants(
	 boolean	pUseOtherEnvironment	= false
	,string		pDatasetname					= 'LocationID') := module(
	
   tools.Constants(
     pDatasetName				:= pDatasetname
    ,pUseOtherEnvironment	:= pUseOtherEnvironment
    ,pGroupname				:= '198' 
    ,pMaxRecordSize			:= 4096
    ,pIsTesting				:= Tools._Constants.IsAlpha_dev
    ,pAdd_Eclcc            := true
	))
	
end;