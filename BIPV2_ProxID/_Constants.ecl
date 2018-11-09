import tools,bipv2_build;
export _Constants(
	 boolean	pUseOtherEnvironment	= false
	,string		pDatasetname					= 'BIPV2_ProxID'
) := module(
	tools.Constants(
		 pDatasetName					:= pDatasetname
		,pUseOtherEnvironment	:= pUseOtherEnvironment
		,pGroupname						:= ''
		,pMaxRecordSize				:= 4096
		,pIsTesting						:= Tools._Constants.IsDataland
	))
	
  export doStrata         := true;
  export copy2storagethor := true;
  export doTraceBackFiles := true;
  export RunPostProcess   := true;
  export Add2WorkmanSuper := true;
  export EmailList        := BIPV2_Build.mod_email.emailList;
  
end;
