IMPORT STD,FraudGovPlatform, FraudDefenseNetwork;
EXPORT Platform :=
MODULE
	
			EXPORT Source  			:= 'N':STORED('Platform');
			
			EXPORT InputTemplate(boolean	pUseOtherEnvironment = false) := 
				MAP ( Source = 'FraudGov' 	=>  FraudGovPlatform._Dataset(pUseOtherEnvironment).InputTemplate,
							ERROR('Invalid Platform') // Default
				);
			
			EXPORT thor_cluster_Persists(boolean	pUseOtherEnvironment = false) := 
				MAP ( Source = 'FraudGov' 	=>  FraudGovPlatform._Dataset(pUseOtherEnvironment).thor_cluster_Persists, 
							ERROR('Invalid Platform')// Default
				);			

			EXPORT name(boolean	pUseOtherEnvironment = false) := 
				MAP ( Source = 'FraudGov' 	=> FraudGovPlatform._Dataset(pUseOtherEnvironment).name, 
							ERROR('Invalid Platform')// Default
				);						
				
			EXPORT FileTemplate (boolean	pUseOtherEnvironment = false) := 
				MAP ( Source = 'FraudGov' 	=> FraudGovPlatform._Dataset(pUseOtherEnvironment).FileTemplate, 
							ERROR('Invalid Platform')// Default
				);			
				
			EXPORT groupname (boolean	pUseOtherEnvironment = false) := 
				MAP ( Source = 'FraudGov' 	=> FraudGovPlatform._Dataset(pUseOtherEnvironment).groupname, 
							ERROR('Invalid Platform')// Default
				);			
								
			EXPORT max_record_size (boolean	pUseOtherEnvironment = false) := 
				MAP ( Source = 'FraudGov' 	=> FraudGovPlatform._Dataset(pUseOtherEnvironment).max_record_size, 
							ERROR('Invalid Platform')// Default
				);										

			EXPORT KeyTemplate (boolean	pUseOtherEnvironment = false) := 
				MAP ( Source = 'FraudGov' 	=> FraudGovPlatform._Dataset(pUseOtherEnvironment).KeyTemplate, 
							ERROR('Invalid Platform')// Default
				);
			EXPORT autokeytemplate (boolean	pUseOtherEnvironment = false) := 
				MAP ( Source = 'FraudGov' 	=> FraudGovPlatform._Dataset(pUseOtherEnvironment).autokeytemplate, 
							ERROR('Invalid Platform')// Default
				);
				
			EXPORT autokey_buildskipset (boolean	pUseOtherEnvironment = false) := 
				MAP ( Source = 'FraudGov' 	=> FraudGovPlatform._Dataset(pUseOtherEnvironment).autokey_buildskipset, 
							[] //Default (Error will be handled with the autokey template)
				);
END;