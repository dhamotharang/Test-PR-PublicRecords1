import tools, FraudShared, NAC, Inquiry_AccLogs;
export Files(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	//////////////////////////////////////////////////////////////////
	// -- Sprayed Files
	//////////////////////////////////////////////////////////////////
	export Sprayed := module

		 
		export IdentityData := dataset(Filenames().Sprayed.IdentityData, 
											{string75 fn { virtual(logicalfilename)},Layouts.Sprayed.IdentityData},
											CSV(heading(1),separator(['~|~']),quote(''),terminator('~<EOL>~')));
		export KnownFraud := dataset(Filenames().Sprayed.KnownFraud,
											{string75 fn { virtual(logicalfilename)},Layouts.Sprayed.KnownFraud},
											CSV(heading(1),separator(['~|~']),quote(''),terminator('~<EOL>~')));		
		export Deltabase := dataset(Filenames().Sprayed.Deltabase,
											{string75 fn { virtual(logicalfilename)},Layouts.Sprayed.Deltabase},
											CSV(separator(['|\t|']),quote(''),terminator('|\n')));	
		export NAC := dataset(Filenames().Sprayed.NAC,
											{string75 fn { virtual(logicalfilename)},NAC.Layouts.MSH},
											FLAT, OPT);		
		export InquiryLogs := dataset(Filenames().Sprayed.InquiryLogs,
											{string75 fn { virtual(logicalfilename)},Inquiry_AccLogs.Layout.Common_ThorAdditions},
											CSV(separator(['~|~']),quote(''),terminator('~<EOL>~')));												
		export RDP := dataset(Filenames().Sprayed.RDP,
											{string75 fn { virtual(logicalfilename)},Layouts.Sprayed.RDP},
											CSV(heading(1),SEPARATOR([',','\t']),quote(['"','&quot;','\'']),TERMINATOR(['\n','\r\n','\n\r'])));																																
	end;
	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	export Input := module
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.IdentityData,Layouts.Input.IdentityData,IdentityData);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.ByPassed_IdentityData,Layouts.Input.IdentityData,ByPassed_IdentityData);

		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.KnownFraud,Layouts.Input.KnownFraud,KnownFraud);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.ByPassed_KnownFraud,Layouts.Input.KnownFraud,ByPassed_KnownFraud);
		
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.Deltabase,Layouts.Input.Deltabase,Deltabase);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.ByPassed_Deltabase,Layouts.Input.Deltabase,ByPassed_Deltabase);

		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.DemoData,FraudShared.Layouts.Base.Main,DemoData);
		
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.ConfigRiskLevel,Layouts.Input.ConfigRiskLevel,ConfigRiskLevel,'CSV',,'\r\n',',',true);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.ConfigAttributes,Layouts.Input.ConfigAttributes,ConfigAttributes,'CSV',,'\r\n',',',true);		
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.ConfigRules,Layouts.Input.ConfigRules,ConfigRules,'CSV',,'\r\n',',',true);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.DisposableEmailDomains,Layouts.Input.DisposableEmailDomains,DisposableEmailDomains,'CSV',,'\r\n',',',true,pUnicode:= false, pHeading:=0);

		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.MBSInclusionDemoData,FraudShared.Layouts.Input.MbsFdnMasterIDIndTypeInclusion,MBSInclusionDemoData,'CSV',,'|\n','|\t|');
		
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.MBSDemoData,FraudShared.Layouts.Input.Mbs,MBSDemoData,'CSV',,'|\n','|\t|');
		
	
	end;
	
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	export Base := module
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.AddressCache,Layouts.Base.AddressCache,AddressCache);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Pii,Layouts.Pii,Pii);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Crim,Layouts.Crim,Crim);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Death,Layouts.Death,Death);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.DLHistory,Layouts.DLHistory,DLHistory);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.BestInfo,Layouts.BestInfo,BestInfo);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.CoverageDates,Layouts.CoverageDates,CoverageDates);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.PrepaidPhone,Layouts.PrepaidPhone,PrepaidPhone);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.BocaShell,Layouts.BocaShell,BocaShell);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.AgencyActivityDate,Layouts.AgencyActivityDate,AgencyActivityDate);
		
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Main_Orig,FraudShared.Layouts.Base.Main,Main_Orig);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Main_Anon,FraudShared.Layouts.Base.Main,Main_Anon);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Pii_Demo,Layouts.Pii,Pii_Demo);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Crim_Demo,Layouts.Crim,Crim_Demo);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Death_Demo,Layouts.Death,Death_Demo);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.IPMetaData_Demo,Layouts.IPMetaData,IPMetaData_Demo);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Crim_Orig,Layouts.Crim,Crim_Orig,,,,,,true);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Death_Orig,Layouts.Death,Death_Orig,,,,,,true);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.IPMetaData,Layouts.IPMetaData,IPMetaData,,,,,,true);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Advo,Layouts.Advo,Advo,,,,,,true);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Advo_Demo,Layouts.Advo,Advo_Demo,,,,,,true);
		//KEL Files
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.kel_EntityProfile,Layouts.EntityProfile, kel_EntityProfile);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.kel_ConfigAttributes,Layouts.ConfigAttributes, kel_ConfigAttributes);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.kel_EntityRules,Layouts.EntityRules, kel_EntityRules);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.kel_EntityAttributes,Layouts.EntityAttributes, kel_EntityAttributes);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.kel_GraphEdges,Layouts.GraphEdges, kel_GraphEdges);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.kel_GraphVertices,Layouts.GraphVertices, kel_GraphVertices);
	end;

	export CustomerSettings := dataset(Filenames().CustomerSettings,Layouts.CustomerSettings,thor,opt);
	export CustomerMappings := dataset(Filenames().CustomerMappings,Layouts.CustomerMappings,thor,opt);
	export CustomerDashboard := dataset(Filenames().CustomerDashboard,Layouts.DashboardResponse,thor,opt);
	export CustomerDashboard1_1 := dataset(Filenames().CustomerDashboard1_1,Layouts.DashboardResponse,thor,opt);
	export ClusterDetails := dataset(Filenames().ClusterDetails,Layouts.DashboardResponse,thor,opt);
	export ProdDashboardVersion := dataset(Filenames().ProdDashboardVersion,Layouts.ProdDashboardVersion,thor,opt);
	export FindLeads 				:= dataset(Filenames().FindLeads,Layouts.DashboardResponse,thor,opt);
	export Dashboard 				:= dataset(Filenames().Dashboard,Layouts.DashboardResponse,thor,opt);
	export LinksChart 			:= dataset(Filenames().LinksChart,Layouts.DashboardResponse,thor,opt);
	export DetailsReport 		:= dataset(Filenames().DetailsReport,Layouts.DashboardResponse,thor,opt);

	export Flags := module
		export FraudgovInfoFile	:= dataset(Filenames().Flags.FraudgovInfoFn,Layouts.Flags.FraudgovInfoRec,thor,opt);
		export SkipModules	:= dataset(Filenames().Flags.SkipModules,Layouts.Flags.SkipModules,thor,opt); 
		export RefreshProdDashVersion	:= dataset(Filenames().Flags.RefreshProdDashVersion,Layouts.Flags.RefreshProdDashVersion,thor,opt); 
		export CustomerActiveSprays := dataset(Filenames().Flags.CustomerActiveSprays,Layouts.Flags.CustomerActiveSprays,thor,opt);
	end;

	
end;