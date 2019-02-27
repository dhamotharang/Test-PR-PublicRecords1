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
		EXPORT EncodedCredentials		:= 'Y2FybWlnang6THVrYTIwMTk=';
		EXPORT reqSource						:= 'batch';		
		EXPORT DspProd							:= 'dsp';
		EXPORT DspQa								:= 'dsp-qa';
		EXPORT HpccConnectionProd		:= 'ramps';
		EXPORT HpccConnectionProdQa	:= 'ramps_prodthor_certroxie';
		EXPORT HpccConnectionQa			:= 'ramps_cert_fraudgov';
		EXPORT HpccConnectionQaDev	:= 'ramps_certthor_devroxie_fraudgov';
		EXPORT EclCompileStrategy		:= 'REMOTE';											
		EXPORT KeepEcl							:= 'FALSE';	
		EXPORT CustomerDashboard 		:= MODULE
			EXPORT CompositionUuid									:= '1d19c97e-2588-4b3f-9c8f-9c42536fde5b'; 	//Customer Dashboard Composition ID
			EXPORT Filenames(BOOLEAN useProdData = FALSE):= MODULE
				EXPORT InputLogicalGraph				:= fileLocation(useProdData) + fileScope + 'customerdashtopclustersandelements';
				EXPORT InputLogicalEntityStats	:= fileLocation(useProdData) + fileScope + 'customerdashtopentitystats';
			END;
		END;
		EXPORT ClusterDetailsDashboard := MODULE
			EXPORT CompositionUuid																:= 'aabc6b85-3457-46fd-bab5-12ef1a87c685'; 	//Cluster Details Dashboard Composition ID		
			EXPORT Filenames(BOOLEAN useProdData = FALSE):= MODULE
				EXPORT InputLogicalGraph											:= fileLocation(useProdData) + fileScope + 'fullgraph';
				EXPORT InputLogicalEntityStats								:= fileLocation(useProdData) + fileScope + 'entitystats';
				EXPORT InputLogicalPersonEvents								:= fileLocation(useProdData) + fileScope + 'personevents';
				EXPORT InputLogicalPersonAssociationsStats		:= fileLocation(useProdData) + fileScope + 'person_associations_stats';
				EXPORT InputLogicalPersonAssociationsDetails	:= fileLocation(useProdData) + fileScope + 'person_associations_details';
			END;
		END;
	END;
END;