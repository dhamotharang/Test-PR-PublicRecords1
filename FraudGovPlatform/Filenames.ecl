import tools;

export Filenames(

	 string		pversion = ''
	,boolean	pUseOtherEnvironment = false

) :=
module

	Shared FraudGov_Prefix (string pType):= FraudGovPlatform._Dataset(false).thor_cluster_Files + pType +'::' + FraudGovPlatform._Dataset(false).name + '::' ;

	//////////////////////////////////////////////////////////////////
	// -- Sprayed Filename Versions
	//////////////////////////////////////////////////////////////////
	export Sprayed := module
		export FileSprayed 	:= 	_Dataset().thor_cluster_Files +'in::'+_Dataset().Name;
		
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
		
	end;
	
	
	//////////////////////////////////////////////////////////////////
	// -- Input Filename Versions
	//////////////////////////////////////////////////////////////////
	export Input := module
	
		shared Template(string tag) := _Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		export IdentityData                  			:= tools.mod_FilenamesInput(Template('IdentityData'),pversion);
		export KnownFraud                  			:= tools.mod_FilenamesInput(Template('KnownFraud'),pversion);
		export Deltabase							:= tools.mod_FilenamesInput(Template('Deltabase'),pversion);
		export ByPassed_IdentityData						:= tools.mod_FilenamesInput(Template('ByPassed_IdentityData'),pversion);
		export ByPassed_KnownFraud							:= tools.mod_FilenamesInput(Template('ByPassed_KnownFraud'),pversion);
		export ByPassed_Deltabase							:= tools.mod_FilenamesInput(Template('ByPassed_Deltabase'),pversion);
		export AddressCache_IDDT								:= tools.mod_FilenamesInput(Template('AddressCache_IDDT'),pversion);
		export AddressCache_KNFD								:= tools.mod_FilenamesInput(Template('AddressCache_KNFD'),pversion);
		export AddressCache_Deltabase							:= tools.mod_FilenamesInput(Template('AddressCache_Deltabase'),pversion);
		
		export DemoData											:= tools.mod_FilenamesInput(Template('DemoData'),pversion);
		export SourcesToAnonymize						:= tools.mod_FilenamesInput(Template('SourcesToAnonymize'),pversion);
		export MBSInclusionDemoData					:= tools.mod_FilenamesInput(Template('MBSInclusionDemoData'),pversion);
		export MBSDemoData									:= tools.mod_FilenamesInput(Template('MBSDemoData'),pversion);
		
		export ConfigRiskLevel							:= tools.mod_FilenamesInput(Template('ConfigRiskLevel'),pversion);
		
		
		export dAll_filenames :=
			IdentityData.dAll_filenames +
			KnownFraud.dAll_filenames +
			Deltabase.dAll_filenames +
			ByPassed_IdentityData.dAll_filenames +
			ByPassed_KnownFraud.dAll_filenames + 
			ByPassed_Deltabase.dAll_filenames + 
			AddressCache_IDDT.dAll_filenames + 
			AddressCache_KNFD.dAll_filenames + 
			AddressCache_Deltabase.dAll_filenames;
			
	end;

	//////////////////////////////////////////////////////////////////
	// -- Output Filename Versions
	//////////////////////////////////////////////////////////////////
	export OutputF := module
		export NewHeader 			:= FraudGov_Prefix('out') + 'NewHeader_flag';
		export FraudgovInfoFn		:= FraudGov_Prefix('out') + 'NewFraudgov_flag';
		export RefreshAddresses 	:= FraudGov_Prefix('out') + 'RefreshAddresses_flag';	
		export Scrubs_FraudGov 		:= FraudGov_Prefix('out') + 'Scrubs_FraudGov';
		export mod_collisions_concat_srt 		:= FraudGov_Prefix('out') + 'mod_collisions::concat_srt';
		export mod_collisions_concat_ddp 		:= FraudGov_Prefix('out') + 'mod_collisions::concat_ddp';
	end;

	//////////////////////////////////////////////////////////////////
	// -- Base Filename Versions
	//////////////////////////////////////////////////////////////////
	export Base := module
	
		shared Template(string tag) := _Dataset(pUseOtherEnvironment).FileTemplate + tag;
		//Otto Files
		export IdentityData := tools.mod_FilenamesBuild(Template('IdentityData'),pversion);
		export KnownFraud 	:= tools.mod_FilenamesBuild(Template('KnownFraud'),pversion);
		export Deltabase 	:= tools.mod_FilenamesBuild(Template('Deltabase'),pversion);
		export AddressCache	:= tools.mod_FilenamesBuild(Template('AddressCache'),pversion);
		export Pii					:= tools.mod_FilenamesBuild(Template('Pii'),pversion);
		export CIID					:= tools.mod_FilenamesBuild(Template('CIID'),pversion);
		export Crim					:= tools.mod_FilenamesBuild(Template('Crim'),pversion);
		export Death				:= tools.mod_FilenamesBuild(Template('Death'),pversion);
		export FraudPoint		:= tools.mod_FilenamesBuild(Template('FraudPoint'),pversion);
		export IPMetaData		:= tools.mod_FilenamesBuild(Template('IPMetaData'),pversion);
		
		
		//Kel Files
		export kel_customeraddress	:= tools.mod_FilenamesBuild(Template('kel::customeraddress'),pversion);
		export kel_personstats			:= tools.mod_FilenamesBuild(Template('kel::personstats'),pversion);
		export kel_personevents		:= tools.mod_FilenamesBuild(Template('kel::personevents'),pversion);
		export kel_customerstats		:= tools.mod_FilenamesBuild(Template('kel::customerstats'),pversion);
		export kel_fullgraph			:= tools.mod_FilenamesBuild(Template('kel::fullgraph'),pversion);
		export kel_entitystats			:= tools.mod_FilenamesBuild(Template('kel::entitystats'),pversion);
		export kel_person_associations_stats		:= tools.mod_FilenamesBuild(Template('kel::person_associations_stats'),pversion);
		export kel_person_associations_details	:= tools.mod_FilenamesBuild(Template('kel::person_associations_details'),pversion);
		export kel_entity_scorebreakdown				:= tools.mod_FilenamesBuild(Template('kel::entity_scorebreakdown'),pversion);
		
		export Main_Orig	:= tools.mod_FilenamesBuild(Template('Main_Orig'),pversion);
		export Main_Anon	:= tools.mod_FilenamesBuild(Template('Main_anon'),pversion);

		//	soap appends original
		
		export CIID_Orig				:= tools.mod_FilenamesBuild(Template('CIID_Orig'),pversion);
		export Crim_Orig				:= tools.mod_FilenamesBuild(Template('Crim_Orig'),pversion);
		export Death_Orig				:= tools.mod_FilenamesBuild(Template('Death_Orig'),pversion);
			
		// DemoData Files - SOAP Appends
		export Pii_Demo					:= tools.mod_FilenamesBuild(Template('Pii_Demo'),pversion);
		export CIID_Demo				:= tools.mod_FilenamesBuild(Template('CIID_Demo'),pversion);
		export Crim_Demo				:= tools.mod_FilenamesBuild(Template('Crim_Demo'),pversion);
		export Death_Demo				:= tools.mod_FilenamesBuild(Template('Death_Demo'),pversion);
		export FraudPoint_Demo	:= tools.mod_FilenamesBuild(Template('FraudPoint_Demo'),pversion);
		Export IpMetaData_Demo	:= tools.mod_FilenamesBuild(Template('IpMetaData_Demo'),pversion);
			
		export dAll_filenames :=
			IdentityData.dAll_filenames +
			KnownFraud.dAll_filenames +
			Deltabase.dAll_filenames +
			AddressCache.dAll_filenames +
			Pii.dAll_filenames +
			CIID.dAll_filenames +
			Crim.dAll_filenames +
			Death.dAll_filenames +
			FraudPoint.dAll_filenames +
			kel_customeraddress.dAll_filenames +
			kel_personstats.dAll_filenames +
			kel_personevents.dAll_filenames + 
			kel_customerstats.dAll_filenames +
			kel_fullgraph.dAll_filenames +
			kel_entitystats.dAll_filenames + 			
			kel_person_associations_stats.dAll_filenames +
			kel_person_associations_details.dAll_filenames +
			kel_entity_scorebreakdown.dAll_filenames + 
 			Main_Orig.dAll_filenames + 
			Main_Anon.dAll_filenames + 
			Pii_Demo.dAll_filenames + 
			CIID_Demo.dAll_filenames + 
			Crim_Demo.dAll_filenames + 
			Death_Demo.dAll_filenames + 
			FraudPoint_Demo.dAll_filenames + 
			IpMetaData_Demo.dAll_filenames + 
			CIID_Orig.dAll_filenames +
			Crim_Orig.dAll_filenames +
			Death_Orig.dAll_filenames +
			IPMetaData.dAll_filenames;
			; 
	
	end;
	
	export dAll_filenames :=
		Base.dAll_filenames;
 
end;