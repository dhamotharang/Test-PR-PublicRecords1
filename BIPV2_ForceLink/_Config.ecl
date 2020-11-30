import tools,LinkingTools;
export _Config(

	 boolean	pUseOtherEnvironment	= false
	,string		pDatasetname					= 'BIPV2_ForceLink'

) := module(
	tools.Constants(
		 pDatasetName					:= pDatasetname
		,pUseOtherEnvironment	:= pUseOtherEnvironment
		,pGroupname						:= ''
		,pMaxRecordSize				:= 4096
		,pIsTesting						:= Tools._Constants.IsDataland
	))
	
  export proxid_underlink_file_tools := LinkingTools.mac_Underlink_File_Management(proxid,'~BIPV2_ForceLink::proxid::underlink::');
  export lgid3_underlink_file_tools  := LinkingTools.mac_Underlink_File_Management(lgid3 ,'~BIPV2_ForceLink::lgid3::underlink::' );
  
end;
