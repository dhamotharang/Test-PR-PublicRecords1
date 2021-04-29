import tools;

export Filenames(

	 string		pversion = ''
	,boolean	pUseOtherEnvironment = false

) :=
module

	Shared FraudGov_Prefix (string pType):= FraudGovPlatform._Dataset(false).thor_cluster_Files + pType +'::';

	//////////////////////////////////////////////////////////////////
	// -- Sprayed Filename Versions
	//////////////////////////////////////////////////////////////////
	export Sprayed := module
		export FileSprayed 	:= 	_Dataset().thor_cluster_Files +'in';
		
		export _IdentityDataPassed := FileSprayed+'::Passed::IdentityData';
		export _IdentityDataRejected := FileSprayed+'::Rejected::IdentityData';
		export _IdentityDataDelete := FileSprayed+'::Delete::IdentityData';
		export IdentityData	:= _IdentityDataPassed;
		
		export _KnownFraudPassed := FileSprayed+'::Passed::KnownFraud';  
		export _KnownFraudRejected := FileSprayed+'::Rejected::KnownFraud';
		export _KnownFraudDelete := FileSprayed+'::Delete::KnownFraud';
		export KnownFraud	:= _KnownFraudPassed;

		export _SafeListPassed := _KnownFraudPassed;  
		export _SafeListRejected := _KnownFraudRejected;
		export _SafeListDelete := _KnownFraudDelete;
		export SafeList	:= _SafeListPassed;
		
		export _DeltabasePassed := FileSprayed+'::Passed::Deltabase';  
		export _DeltabaseRejected := FileSprayed+'::Rejected::Deltabase';
		export _DeltabaseDelete := FileSprayed+'::Delete::Deltabase';
		export Deltabase := _DeltabasePassed;	
		
		export _NACPassed := FileSprayed+'::Passed::NAC';  
		export _NACRejected := FileSprayed+'::Rejected::NAC';
		export _NACDelete := FileSprayed+'::Delete::NAC';
		export NAC := _NACPassed;	
		
		export _InquiryLogsPassed := FileSprayed+'::Passed::InquiryLogs';  
		export _InquiryLogsRejected := FileSprayed+'::Rejected::InquiryLogs';
		export _InquiryLogsDelete := FileSprayed+'::Delete::InquiryLogs';
		export InquiryLogs := _InquiryLogsPassed;		
		
		export _RDPPassed := FileSprayed+'::Passed::RDP';  
		export _RDPRejected := FileSprayed+'::Rejected::RDP';
		export _RDPDelete := FileSprayed+'::Delete::RDP';
		export RDP := _RDPPassed;		

		export _DisposableEmailDomainsPassed := FileSprayed+'::Passed::DisposableEmailDomains';  
		export _DisposableEmailDomainsRejected := FileSprayed+'::Rejected::DisposableEmailDomains';
		export _DisposableEmailDomainsDelete := FileSprayed+'::Delete::DisposableEmailDomains';
		export DisposableEmailDomains := _DisposableEmailDomainsPassed;		
	end;
	
	
	//////////////////////////////////////////////////////////////////
	// -- Input Filename Versions
	//////////////////////////////////////////////////////////////////
	export Input := module
	
		shared Template(string tag) := _Dataset(pUseOtherEnvironment).InputTemplate + tag;

		export MBS	:= tools.mod_FilenamesInput(Template('mbs'),pversion);
		export MbsNewGcIdExclusion	:= tools.mod_FilenamesInput(Template('MbsNewGcIdExclusion'),pversion); //In this new file gcid is replaced by exclusion_id and exclusion_type
		export MbsIndTypeExclusion	:= tools.mod_FilenamesInput(Template('MbsIndTypeExclusion'),pversion);
		export MbsProductInclude	:= tools.mod_FilenamesInput(Template('MbsProductInclude'),pversion);
		export MBSSourceGcExclusion	:= tools.mod_FilenamesInput(Template('MBSSourceGcExclusion'),pversion);
		export MBSFdnIndType	:= tools.mod_FilenamesInput(Template('MBSFdnIndType'),pversion);
		export MBSFdnCCID	:= tools.mod_FilenamesInput(Template('MBSFdnCCID'),pversion);
		export MBSFdnHHID	:= tools.mod_FilenamesInput(Template('MBSFdnHHID'),pversion);
		export MBSTableCol	:= tools.mod_FilenamesInput(Template('MBSTableCol'),pversion);
		export MBSColValDesc	:= tools.mod_FilenamesInput(Template('MBSColValDesc'),pversion);
		export MBSmarketAppend	:= tools.mod_FilenamesInput(Template('MBSmarketAppend'),pversion);
		export MbsFdnMasterIDIndTypeInclusion:= tools.mod_FilenamesInput(Template('MbsFdnMasterIDIndTypeInclusion'),pversion);


		export IdentityData	:= tools.mod_FilenamesInput(Template('IdentityData'),pversion);
		export KnownFraud	:= tools.mod_FilenamesInput(Template('KnownFraud'),pversion);
		export Deltabase	:= tools.mod_FilenamesInput(Template('Deltabase'),pversion);
		export DisposableEmailDomains	:= tools.mod_FilenamesInput(Template('DisposableEmailDomains'),pversion); 

		export ByPassed_IdentityData	:= tools.mod_FilenamesInput(Template('ByPassed_IdentityData'),pversion);
		export ByPassed_KnownFraud	:= tools.mod_FilenamesInput(Template('ByPassed_KnownFraud'),pversion);
		export ByPassed_Deltabase	:= tools.mod_FilenamesInput(Template('ByPassed_Deltabase'),pversion);
		export ByPassed_DisposableEmailDomains	:= tools.mod_FilenamesInput(Template('ByPassed_DisposableEmailDomains'),pversion);
		
		export DemoData	:= tools.mod_FilenamesInput(Template('DemoData'),pversion);
		export MBSInclusionDemoData	:= tools.mod_FilenamesInput(Template('MBSInclusionDemoData'),pversion);
		export MBSDemoData	:= tools.mod_FilenamesInput(Template('MBSDemoData'),pversion);
		
		export ConfigRiskLevel	:= tools.mod_FilenamesInput(Template('ConfigRiskLevel'),pversion);
		export ConfigAttributes	:= tools.mod_FilenamesInput(Template('ConfigAttributes'),pversion);
		export ConfigRules	:= tools.mod_FilenamesInput(Template('ConfigRules'),pversion);

		export dAll_filenames :=
			IdentityData.dAll_filenames +
			KnownFraud.dAll_filenames +
			Deltabase.dAll_filenames +
			DisposableEmailDomains.dAll_filenames +
			ByPassed_IdentityData.dAll_filenames +
			ByPassed_KnownFraud.dAll_filenames + 
			ByPassed_Deltabase.dAll_filenames +
			ByPassed_DisposableEmailDomains.dAll_filenames;

		export dMbs_filenames	:= MBS.dAll_filenames +
			MbsNewGcIdExclusion.dAll_filenames +
			MbsIndTypeExclusion.dAll_filenames +
			MbsProductInclude.dAll_filenames +
			MBSSourceGcExclusion.dAll_filenames +
			MBSFdnIndType.dAll_filenames +
			MBSFdnCCID.dAll_filenames +
			MBSFdnHHID.dAll_filenames +
			MBSTableCol.dAll_filenames +
			MBSColValDesc.dAll_filenames +
			MBSmarketAppend.dAll_filenames +
			MbsFdnMasterIDIndTypeInclusion.dAll_filenames;	

			
	end;

	//////////////////////////////////////////////////////////////////
	// -- Config Filenames
	//////////////////////////////////////////////////////////////////
	export CustomerSettings := FraudGov_Prefix('config') + 'CustomerSettings';
	export CustomerMappings := FraudGov_Prefix('config') + 'CustomerMappings';
	export CustomerDashboard := FraudGov_Prefix('config') + 'kel::customerdashboard';
	export CustomerDashboard1_1 := FraudGov_Prefix('config') + 'kel::customerdashboard1_1';
	export HighRiskIdentity := FraudGov_Prefix('config') + 'kel::HighRiskIdentity';
	export ClusterDetails := FraudGov_Prefix('config') + 'kel::clusterdetails';
	export ProdDashboardVersion := FraudGov_Prefix('config') + 'kel::ProdDashboardVersion';
	export FindLeads := FraudGov_Prefix('config') + 'kel::FindLeads';
	export Dashboard := FraudGov_Prefix('config') + 'kel::Dashboard';
	export LinksChart := FraudGov_Prefix('config') + 'kel::LinksChart';
	export DetailsReport := FraudGov_Prefix('config') + 'kel::DetailsReport';
	export Flags := module
		export NewHeader := FraudGov_Prefix('flags') + 'NewHeader_flag';
		export FraudgovInfoFn := FraudGov_Prefix('flags') + 'NewFraudgov_flag';
		export RefreshAddresses := FraudGov_Prefix('flags') + 'RefreshAddresses_flag';	
		export SkipModules := FraudGov_Prefix('flags') + 'SkipModules_flag';
		export CustomerActiveSprays := FraudGov_Prefix('flags') + 'CustomerActiveSprays_flag';
		
	end;
	//////////////////////////////////////////////////////////////////
	// -- Output Filename Versions
	//////////////////////////////////////////////////////////////////
	export OutputF := module
		export Scrubs_MBS := FraudGov_Prefix('out') + 'Scrubs_MBS';
		export Scrubs_FraudGov := FraudGov_Prefix('out') + 'Scrubs_FraudGov';
		export mod_collisions_concat_srt := FraudGov_Prefix('out') + 'mod_collisions::concat_srt';
		export mod_collisions_concat_ddp := FraudGov_Prefix('out') + 'mod_collisions::concat_ddp';
	end;

	//////////////////////////////////////////////////////////////////
	// -- Base Filename Versions
	//////////////////////////////////////////////////////////////////
	export Base := module
		shared Template(string tag) := _Dataset(pUseOtherEnvironment).FileTemplate + tag;
		//Otto Files
		export Main	:= tools.mod_FilenamesBuild(Template('Main'),pversion);
		export AddressCache	:= tools.mod_FilenamesBuild(Template('AddressCache'),pversion);
		export Pii := tools.mod_FilenamesBuild(Template('Pii'),pversion);
		export Crim := tools.mod_FilenamesBuild(Template('Crim'),pversion);
		export Death := tools.mod_FilenamesBuild(Template('Death'),pversion);
		export IPMetaData := tools.mod_FilenamesBuild(Template('IPMetaData'),pversion);
		export Advo := tools.mod_FilenamesBuild(Template('Advo'),pversion);
		export DLHistory := tools.mod_FilenamesBuild(Template('DLHistory'),pversion);
		export BestInfo := tools.mod_FilenamesBuild(Template('BestInfo'),pversion);
		export CoverageDates := tools.mod_FilenamesBuild(Template('CoverageDates'),pversion);
		export PrepaidPhone	:= tools.mod_FilenamesBuild(Template('PrepaidPhone'),pversion);
		export BocaShell := tools.mod_FilenamesBuild(Template('BocaShell'),pversion);
		export AgencyActivityDate := tools.mod_FilenamesBuild(Template('AgencyActivityDate'),pversion);
		export BaseUnitTests := tools.mod_FilenamesBuild(Template('BaseUnitTests'),pversion);
		export KeysUnitTests := tools.mod_FilenamesBuild(Template('KeysUnitTests'),pversion);

		export DisposableEmailDomains := tools.mod_FilenamesBuild(Template('DisposableEmailDomains'),pversion);

		//Kel Files
		export kel_EntityProfile := tools.mod_FilenamesBuild(Template('kel::EntityProfile'),pversion);
		export kel_ConfigAttributes := tools.mod_FilenamesBuild(Template('kel::ConfigAttributes'),pversion);
		export kel_EntityRules := tools.mod_FilenamesBuild(Template('kel::EntityRules'),pversion);
		export kel_EntityAttributes := tools.mod_FilenamesBuild(Template('kel::EntityAttributes'),pversion);
		export kel_GraphEdges := tools.mod_FilenamesBuild(Template('kel::GraphEdges'),pversion);
		export kel_GraphVertices := tools.mod_FilenamesBuild(Template('kel::GraphVertices'),pversion);
		
		export Main_Orig := tools.mod_FilenamesBuild(Template('Main_Orig'),pversion);
		export Main_Anon := tools.mod_FilenamesBuild(Template('Main_anon'),pversion);

		//	soap appends original
		
		export Crim_Orig := tools.mod_FilenamesBuild(Template('Crim_Orig'),pversion);
		export Death_Orig := tools.mod_FilenamesBuild(Template('Death_Orig'),pversion);
			
		// DemoData Files - SOAP Appends
		export Pii_Demo := tools.mod_FilenamesBuild(Template('Pii_Demo'),pversion);
		export Crim_Demo := tools.mod_FilenamesBuild(Template('Crim_Demo'),pversion);
		export Death_Demo := tools.mod_FilenamesBuild(Template('Death_Demo'),pversion);
		export IpMetaData_Demo := tools.mod_FilenamesBuild(Template('IpMetaData_Demo'),pversion);
		export Advo_Demo := tools.mod_FilenamesBuild(Template('Advo_Demo'),pversion);
			
		export dAll_filenames :=
			Main.dAll_filenames +
			AddressCache.dAll_filenames +
			Pii.dAll_filenames +
			Crim.dAll_filenames +
			Death.dAll_filenames +
			DLHistory.dAll_filenames +
			BestInfo.dAll_filenames +
			CoverageDates.dAll_filenames +
			PrepaidPhone.dAll_filenames +
			BocaShell.dAll_filenames +
			AgencyActivityDate.dAll_filenames +
			BaseUnitTests.dAll_filenames +
			KeysUnitTests.dAll_filenames +
			//kel base
			kel_EntityProfile.dAll_filenames + 
			kel_ConfigAttributes.dAll_filenames + 
			kel_EntityRules.dAll_filenames + 
			kel_EntityAttributes.dAll_filenames + 
			kel_GraphEdges.dAll_filenames + 
			kel_GraphVertices.dAll_filenames + 
			
 			Main_Orig.dAll_filenames + 
			Main_Anon.dAll_filenames + 
			Pii_Demo.dAll_filenames + 
			Crim_Demo.dAll_filenames + 
			Death_Demo.dAll_filenames + 
			IpMetaData_Demo.dAll_filenames + 
			Crim_Orig.dAll_filenames +
			Death_Orig.dAll_filenames +
			IPMetaData.dAll_filenames + 
			Advo.dAll_filenames +
			Advo_Demo.dAll_filenames +
			DisposableEmailDomains.dAll_filenames
			; 
	
	end;
	
	export dAll_filenames :=
		Base.dAll_filenames;
 
end;