import tools;

export Files(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	export Input := module
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.Xref                ,Layouts.Input.Xref                ,Xref                ,'CSV',pTerminator := ['\\n','\\r\\n'],pSeparator := '|',pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.StateLicense        ,Layouts.Input.StateLicense        ,StateLicense        ,'CSV',pTerminator := ['\\n','\\r\\n'],pSeparator := '|',pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.Specialty           ,Layouts.Input.Specialty           ,Specialty           ,'CSV',pTerminator := ['\\n','\\r\\n'],pSeparator := '|',pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.Merges              ,Layouts.Input.MergeAndSplit       ,Merges              ,'CSV',pTerminator := ['\\n','\\r\\n'],pSeparator := '|',pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.Splits              ,Layouts.Input.MergeAndSplit       ,Splits              ,'CSV',pTerminator := ['\\n','\\r\\n'],pSeparator := '|',pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.ProviderDemographics,Layouts.Input.ProviderDemographics,ProviderDemographics,'CSV',pTerminator := ['\\n','\\r\\n'],pSeparator := '|',pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.Degree              ,Layouts.Input.Degree              ,Degree              ,'CSV',pTerminator := ['\\n','\\r\\n'],pSeparator := '|',pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.Credential          ,Layouts.Input.Credential          ,Credential          ,'CSV',pTerminator := ['\\n','\\r\\n'],pSeparator := '|',pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.ProviderAddress     ,Layouts.Input.ProviderAddress     ,ProviderAddress     ,'CSV',pTerminator := ['\\n','\\r\\n'],pSeparator := '|',pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.Code                ,Layouts.Input.Code                ,Code                ,'CSV',pTerminator := ['\\n','\\r\\n'],pSeparator := '|',pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.Affiliation         ,Layouts.Input.Affiliation         ,Affiliation         ,'CSV',pTerminator := ['\\n','\\r\\n'],pSeparator := '|',pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.AccountDemographics ,Layouts.Input.AccountDemographics ,AccountDemographics ,'CSV',pTerminator := ['\\n','\\r\\n'],pSeparator := '|',pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.AccountAddress      ,Layouts.Input.AccountAddress      ,AccountAddress      ,'CSV',pTerminator := ['\\n','\\r\\n'],pSeparator := '|',pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.AccountMerges       ,Layouts.Input.AccountMergeAndSplit,AccountMerges       ,'CSV',pTerminator := ['\\n','\\r\\n'],pSeparator := '|',pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.AccountSplits       ,Layouts.Input.AccountMergeAndSplit,AccountSplits       ,'CSV',pTerminator := ['\\n','\\r\\n'],pSeparator := '|',pHeading := 1);
	end;
	
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	export Base := module
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Main                ,Layouts.Base.Main                ,Main                );
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.StateLicense        ,Layouts.Base.StateLicense        ,StateLicense        );
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Specialty           ,Layouts.Base.Specialty           ,Specialty           );
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.IDNumber						,Layouts.Base.IDNumber						,IDNumber						 );
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Degree              ,Layouts.Base.Degree              ,Degree              );
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Credential          ,Layouts.Base.Credential          ,Credential          );
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Affiliation         ,Layouts.Base.Affiliation         ,Affiliation         );
	end;

end;