import tools,LinkingTools;
export _Config(

	 boolean	pUseOtherEnvironment	= false
	,string		pDatasetname					= 'BIPV2_Field_Suppression'

) := module(
	tools.Constants(
		 pDatasetName					:= pDatasetname
		,pUseOtherEnvironment	:= pUseOtherEnvironment
		,pGroupname						:= ''
		,pMaxRecordSize				:= 4096
		,pIsTesting						:= Tools._Constants.IsDataland
	))
	
  export Suppression_File           := LinkingTools.mac_Suppression_File_Management('~BIPV2_Field_Suppression::'        );  //for proxid and lgid3 suppression
  export Hierarchy_Suppression_File := LinkingTools.mac_Suppression_File_Management('~BIPV2_Field_Suppression::hrchy::' );  //for suppression of hierarchy
  
end;
