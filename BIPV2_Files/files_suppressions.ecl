import tools, BIPV2;

export files_suppressions(string pversion = '', pUseOtherEnvironment = false) := module

	export Layout_Suppression := record
		BIPV2.CommonBase.Layout;
		string25  userid;
		unsigned4 dt_added;		
		boolean   suppressed;
	end;
	
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
  
  export ds_suppressions := dataset(sfFileName, Layout_Suppression, thor, opt);
           	
end;