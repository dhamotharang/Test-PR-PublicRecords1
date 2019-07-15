import tools, BIPV2;

export files_suppressions(string pversion = '', pUseOtherEnvironment = false) := module

	export Layout_Suppression := record
		BIPV2.CommonBase.Layout;
		string25  userid;
		unsigned4 dt_added;		
		boolean   suppressed;
	end;
	
	export Layout_Suppression_Key := record
		BIPV2.CommonBase.Layout.rcid;
		string25  userid;
		unsigned4 dt_added;		
		boolean   suppressed;
	end;
	
	export location := tools.Constants(
		 pDatasetName         := 'BIPV2_Suppressions'
		,pUseOtherEnvironment := pUseOtherEnvironment
		,pGroupname           := ''
		,pMaxRecordSize       := 4096
		,pIsTesting           := Tools._Constants.IsDataland
	);
   
  export prefix                  := location.prefix; 
  export sfFileName              := prefix + 'BIPV2_Suppressions::suppression_data::sf';  
  export sfKeyName               := '~thor_data400::key::bipv2_suppression::qa::rcid';  
  export filename                := prefix + 'BIPV2_Suppressions::suppression_data::'      + thorlib.wuid();
  export keyname(string version) := '~thor_data400::key::bipv2_suppression::' + version + '::rcid';  
    
  export ds_suppressions  := dataset(sfFileName, Layout_Suppression, thor, opt);
  
  export key_suppressions(
                          dataset(Layout_Suppression_Key) inData = dataset([],Layout_Suppression_Key)
                         ,string keyName                         = sfKeyName
					) := index(inData,{rcid,suppressed},{inData},keyName,opt);
           	
end;