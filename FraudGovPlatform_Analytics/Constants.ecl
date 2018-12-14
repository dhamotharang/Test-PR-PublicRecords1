EXPORT Constants := MODULE
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
		EXPORT EncodedCredentials	:= 'Y2FybWlnang6Q2Fzc2l1czIwMTg=';
		EXPORT reqSource					:= 'batch';		
		EXPORT DspProd						:= 'dsp';
		EXPORT DspQa							:= 'dsp-qa';
		EXPORT HpccConnectionProd	:= 'ramps';
		EXPORT HpccConnectionQa		:= 'ramps_cert';
		EXPORT EclCompileStrategy	:= 'REMOTE';											
		EXPORT KeepEcl						:= 'FALSE';	
		EXPORT CustomerDashboard 	:= MODULE
			EXPORT CompositionUuid									:= '92db8d0a-075f-4dad-a9bd-65b7633f06ce'; 	//Customer Dashboard Composition ID
			EXPORT InputLogicalGraphFilename 				:= 'gov::otto::customerdashtopclusters';
			EXPORT InputLogicalEntityStatsFilename	:= 'gov::otto::customerdashtopentitystats';
		END;
		EXPORT ClusterDetailsDashboard := MODULE
			EXPORT CompositionUuid																:= '38635781-fb5e-4ee7-9952-e0963bd0a875'; 	//Cluster Details Dashboard Composition ID		
			EXPORT InputLogicalGraphFilename											:= 'gov::otto::fullgraph';
			EXPORT InputLogicalEntityStatsFilename								:= 'gov::otto::entitystats';
			EXPORT InputLogicalPersonEventsFilename								:= 'gov::otto::personevents';
			EXPORT InputLogicalPersonAssociationsStatsFilename 		:= 'gov::otto::person_associations_stats';
			EXPORT InputLogicalPersonAssociationsDetailsFilename	:= 'gov::otto::person_associations_details';
		END;
	END;
END;