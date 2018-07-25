import data_services,tools,BIPV2_ProxID, tools;

export files_suppressions(string pversion = '', pUseOtherEnvironment = false) := module

	export location := tools.Constants(
		 pDatasetName					:= 'BIPV2_Suppressions'
		,pUseOtherEnvironment	:= pUseOtherEnvironment
		,pGroupname						:= ''
		,pMaxRecordSize				:= 4096
		,pIsTesting						:= Tools._Constants.IsDataland
	);
   
  export prefix     := location.prefix; 
  export sfFileName := prefix + 'BIPV2_Suppressions::suppression_data::sf';  
  export filename   := prefix + 'BIPV2_Suppressions::suppression_data::' + thorlib.wuid();
           	
end;