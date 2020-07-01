EXPORT Constants := MODULE
	IMPORT Data_Services, FraudGovPlatform, Tools;
	EXPORT KelEntityIdentifier := MODULE
		EXPORT STRING LEXID := '_01';
		EXPORT STRING PHYSICAL_ADDRESS := '_09';
		EXPORT STRING EVENT := '_11';
		EXPORT STRING SSN := '_15';
		EXPORT STRING PHONENO := '_16';
		EXPORT STRING EMAIL := '_17';
		EXPORT STRING IPADDRESS := '_18';
		EXPORT STRING BANKACCOUNT := '_19';
		EXPORT STRING DRIVER_LICENSE := '_20';
	END;	
	EXPORT KelEntityType := MODULE
		EXPORT STRING LEXID := '01';
		EXPORT STRING PHYSICAL_ADDRESS := '09';
		EXPORT STRING EVENT := '11';
		EXPORT STRING SSN := '15';
		EXPORT STRING PHONENO := '16';
		EXPORT STRING EMAIL := '17';
		EXPORT STRING IPADDRESS := '18';
		EXPORT STRING BANKACCOUNT := '19';
		EXPORT STRING DRIVER_LICENSE := '20';
	END;	
	EXPORT KelEntityTypeName := MODULE
		EXPORT STRING LEXID := 'ID';
		EXPORT STRING PHYSICAL_ADDRESS := 'ADDR';
		EXPORT STRING EVENT := 'ID';
		EXPORT STRING SSN := 'SSN';
		EXPORT STRING PHONENO := 'PH';
		EXPORT STRING EMAIL := 'EML';
		EXPORT STRING IPADDRESS := 'IP';
		EXPORT STRING BANKACCOUNT := 'BANK';
		EXPORT STRING DRIVER_LICENSE := 'DL';
		EXPORT STRING UNK := 'unk';
	END;
	EXPORT KelEntityDescription := MODULE
		EXPORT STRING LEXID := 'Identity';
		EXPORT STRING PHYSICAL_ADDRESS := 'Address';
		EXPORT STRING EVENT := 'Identity';
		EXPORT STRING SSN := 'SSN';
		EXPORT STRING PHONENO := 'Phone';
		EXPORT STRING EMAIL := 'Email';
		EXPORT STRING IPADDRESS := 'IP';
		EXPORT STRING BANKACCOUNT := 'Bank Account';
		EXPORT STRING DRIVER_LICENSE := 'Driver License';
		EXPORT STRING UNK := 'unk';
	END;	
	EXPORT RampsWebServices := MODULE
		isProd := ~Tools._Constants.IsDataland;
		useOtherEnvironmentDali(BOOLEAN useProdData) := NOT((isProd AND useProdData) OR (~isProd AND ~useProdData));
		EXPORT fileLocation(BOOLEAN useProdData)	:= IF(useProdData, data_services.foreign_prod, data_services.foreign_dataland);
		EXPORT fileScope						:= 'fraudgov::base::built::kel::';
		// EXPORT fileScope						:= 'fraudgov::base::20200625::kel::';
		// EXPORT fileScope						:= 'gov::otto::';
		// EXPORT fileScope						:= 'fraudgov::base::20191025::kel::';
		EXPORT fatherFileScope			:= 'fraudgov::base::father::kel::';
		EXPORT EncodedCredentials		:= 'Y2FybWlnang6THVrYTIwMjAhISE=';
		EXPORT DataBuildRampsCertCreds	:= 'ZGF0YWJ1aWxkcmFtcHNAbWJzOnc1R0o0aDRyVmk=';
		EXPORT DataBuildRampsCreds	:= 'ZGF0YWJ1aWxkcmFtcHNAbWJzOlAxOGI5QTE1ZQ==';
		EXPORT reqSource						:= 'batch';		
		EXPORT DspProd							:= 'dsp';
		EXPORT DspCert							:= 'dsp-cert';
		EXPORT DspQa								:= 'dsp-qa';
		EXPORT HpccConnectionProd		:= 'ramps_fraudgov';
		EXPORT HpccConnectionProdQa	:= 'ramps_prodthor_certroxie';
		EXPORT HpccConnectionQa			:= 'ramps_cert_fraudgov';
		EXPORT HpccConnectionQaDev	:= 'ramps_certthor_devroxie_fraudgov';
		EXPORT HpccConnectionDev		:= 'ramps_dev_fraudgov';
		EXPORT EclCompileStrategy		:= 'LOCAL';											
		EXPORT KeepEcl							:= 'FALSE';	
		EXPORT ForceRun							:= 'FALSE';
		// EXPORT ForceRun							:= 'TRUE';
    EXPORT DeleteOldIndexes     := 'TRUE';
		EXPORT FindLeads         		:= MODULE
			EXPORT VizServiceVersion								:= '1';
			EXPORT CompositionUuid									:= 'cf45de78-de9f-4c1f-81e4-934609562c58'; 	//Find Leads Composition ID
			EXPORT Filenames(BOOLEAN useProdData = FALSE):= MODULE
				// EXPORT InputEventPivot          := '~foreign::10.173.10.159::fraudgov::eventpivot';
				// EXPORT InputLogicalEntityStats	:= '~foreign::10.173.10.159::fraudgov::pivotentitystatsfilter';
				// EXPORT InputLogicalConfigFile	  := '~foreign::10.173.10.157::fraudgov::base::built::configattributes';
				EXPORT InputEventPivot				  := fileLocation(useProdData) + fileScope + 'entityprofile';
				EXPORT InputLogicalEntityStats  := fileLocation(useProdData) + fileScope + 'entityattributes';
				EXPORT InputLogicalConfigFile   := fileLocation(useProdData) + fileScope + 'configattributes';
			END;
		END;
		EXPORT Dashboard         		:= MODULE
			EXPORT VizServiceVersion								:= '1';
			EXPORT CompositionUuid									:= '3adb4bd6-9d48-41c0-bf6c-acab5d827646'; 	//Dashboard Composition ID
			EXPORT Filenames(BOOLEAN useProdData = FALSE):= MODULE
				// EXPORT InputEventPivot          := '~foreign::10.173.10.159::fraudgov::eventpivot';
				// EXPORT InputLogicalEntityStats	:= '~foreign::10.173.10.159::fraudgov::pivotentitystatsfilter';
				EXPORT InputEventPivot				  := fileLocation(useProdData) + fileScope + 'entityprofile';
				EXPORT InputLogicalEntityStats  := fileLocation(useProdData) + fileScope + 'entityattributes';
			END;
		END;
		EXPORT DetailsReport      := MODULE
			EXPORT VizServiceVersion								:= '1';
			EXPORT CompositionUuid									:= 'f44a200b-80f7-48eb-9328-b1767073d51b'; 	//Details Report Composition ID
			EXPORT Filenames(BOOLEAN useProdData = FALSE):= MODULE
				// EXPORT InputEventPivot          := '~foreign::10.173.10.159::fraudgov::eventpivot';
				// EXPORT InputLogicalEntityStats	:= '~foreign::10.173.10.159::fraudgov::pivotentitystatsfilter';
        // EXPORT InputLogicalEntityRules	:= '~foreign::10.173.10.159::fraudgov::entityrules';
        EXPORT InputEventPivot				  := fileLocation(useProdData) + fileScope + 'entityprofile';
				EXPORT InputLogicalEntityStats  := fileLocation(useProdData) + fileScope + 'entityattributes';
				EXPORT InputLogicalEntityRules  := fileLocation(useProdData) + fileScope + 'entityrules';
			END;
		END;
		EXPORT LinksChart      := MODULE
			EXPORT VizServiceVersion								:= '1';
			EXPORT CompositionUuid									:= '33e5b3de-4d45-4fe1-90d6-04b0c05ebd5d'; 	//Links Chart Composition ID
			EXPORT Filenames(BOOLEAN useProdData = FALSE):= MODULE
				// EXPORT InputLogicalGraphVertices:= '~foreign::10.173.10.159::fraudgov::rin2::graphpvertices';
				// EXPORT InputLogicalGraphEdges 	:= '~foreign::10.173.10.159::fraudgov::rin2::graphedges';
        EXPORT InputLogicalGraphVertices:= fileLocation(useProdData) + fileScope + 'graphvertices';
        EXPORT InputLogicalGraphEdges   := fileLocation(useProdData) + fileScope + 'graphedges';
			END;
		END;
		EXPORT CustomerDashboard 		:= MODULE
			EXPORT VizServiceVersion								:= '1';
			EXPORT CompositionUuid									:= '1d19c97e-2588-4b3f-9c8f-9c42536fde5b'; 	//Customer Dashboard Composition ID
			EXPORT Filenames(BOOLEAN useProdData = FALSE):= MODULE
				EXPORT InputLogicalGraph				:= fileLocation(useProdData) + fileScope + 'customerdashtopclustersandelements';
				EXPORT InputLogicalEntityStats	:= fileLocation(useProdData) + fileScope + 'customerdashtopentitystats';
			END;
		END;
		EXPORT CustomerDashboard1_1		:= MODULE
			EXPORT VizServiceVersion								:= '2';
			EXPORT CompositionUuid									:= '4dbbbb5c-e1d6-40ef-a8f9-51a33b35260a'; 	//Customer Dashboard 1.1 Composition ID
			EXPORT Filenames(BOOLEAN useProdData = FALSE):= MODULE
				EXPORT InputLogicalCluster								:= fileLocation(useProdData) + fileScope + 'customerdashtopclusters';
				EXPORT InputLogicalIdentitiesAndElements	:= fileLocation(useProdData) + fileScope + 'customerdashtopclustersandelements';
				EXPORT InputLogicalEntityStats						:= fileLocation(useProdData) + fileScope + 'entitystats';
			END;
		END;
		EXPORT HighRiskIdentityDashboard := MODULE
			EXPORT VizServiceVersion															:= '1';
			EXPORT CompositionUuid																:= 'd5d67f72-b428-4157-8f90-0b124f885c77'; 	//High Risk Identity Dashboard Composition ID		
			EXPORT Filenames(BOOLEAN useProdData = FALSE):= MODULE
				EXPORT InputLogicalPersonStats								:= fileLocation(useProdData) + fileScope + 'personstats';
				EXPORT InputLogicalEntityStats								:= fileLocation(useProdData) + fileScope + 'entitystats';
			END;
		END;
		EXPORT ClusterDetailsDashboard := MODULE
			EXPORT VizServiceVersion															:= '2';
			EXPORT CompositionUuid																:= 'aabc6b85-3457-46fd-bab5-12ef1a87c685'; 	//Cluster Details Dashboard Composition ID		
			EXPORT Filenames(BOOLEAN useProdData = FALSE):= MODULE
				EXPORT InputLogicalGraph											:= fileLocation(useProdData) + fileScope + 'fullgraph';
				EXPORT InputLogicalEntityStats								:= fileLocation(useProdData) + fileScope + 'entitystats';
				EXPORT InputLogicalPersonAssociationsStats		:= fileLocation(useProdData) + fileScope + 'person_associations_stats';
				EXPORT InputLogicalPersonAssociationsDetails	:= fileLocation(useProdData) + fileScope + 'person_associations_details';
			END;
		END;
		EXPORT PersonStatsDeltaDashboard := MODULE
			EXPORT VizServiceVersion															:= '1';
			EXPORT CompositionUuid																:= 'df7e9f5a-9340-499a-870d-56007be5d159'; 	//Fraudgov-PersonStatsDelta Dashboard Composition ID		
			EXPORT Filenames(BOOLEAN useProdData = FALSE):= MODULE
				EXPORT InputLogicalOldPersonStatsFilename	:= fileLocation(useProdData) + fatherFileScope + 'personstats';
				EXPORT InputLogicalNewPersonStatsFilename	:= fileLocation(useProdData) + fileScope + 'personstats';
			END;
		END;
		EXPORT NewClusterRecordsDashboard := MODULE
			EXPORT VizServiceVersion															:= '1';
			EXPORT CompositionUuid																:= 'b71416af-75ca-49d4-a630-ed80de1d341b'; 	//Fraudgov-NewClusterRecords Dashboard Composition ID		
			EXPORT Filenames(BOOLEAN useProdData = FALSE):= MODULE
				EXPORT InputLogicalOldClusterDetailsFilename	:= fileLocation(useProdData) + fatherFileScope + 'fullgraph';
				EXPORT InputLogicalNewClusterDetailsFilename	:= fileLocation(useProdData) + fileScope + 'fullgraph';
				EXPORT InputLogicalNewEntityStatsFilename			:= fileLocation(useProdData) + fileScope + 'entitystats';
			END;
		END;
	END;
END;