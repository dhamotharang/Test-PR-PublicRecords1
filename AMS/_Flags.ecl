import _control, tools;

export _Flags :=
module

	export IsTesting 							:= tools._Constants.IsDataland;
	
	export UseStandardizePersists := not IsTesting;	// for bug 26170 -- Missing dependency from persist to stored
	
	export FileExists := module
		export Input := module
			export Xref                 := count(nothor(FileServices.SuperFileContents(Filenames().Input.Xref                .Sprayed))) > 0;
			export StateLicense         := count(nothor(FileServices.SuperFileContents(Filenames().Input.StateLicense        .Sprayed))) > 0;
			export Specialty            := count(nothor(FileServices.SuperFileContents(Filenames().Input.Specialty           .Sprayed))) > 0;
			export Merges               := count(nothor(FileServices.SuperFileContents(Filenames().Input.Merges              .Sprayed))) > 0;
			export Splits               := count(nothor(FileServices.SuperFileContents(Filenames().Input.Splits              .Sprayed))) > 0;
			export ProviderDemographics := count(nothor(FileServices.SuperFileContents(Filenames().Input.ProviderDemographics.Sprayed))) > 0;
			export Degree               := count(nothor(FileServices.SuperFileContents(Filenames().Input.Degree              .Sprayed))) > 0;
			export Credential           := count(nothor(FileServices.SuperFileContents(Filenames().Input.Credential          .Sprayed))) > 0;
			export ProviderAddress      := count(nothor(FileServices.SuperFileContents(Filenames().Input.ProviderAddress     .Sprayed))) > 0;
			export Code                 := count(nothor(FileServices.SuperFileContents(Filenames().Input.Code                .Sprayed))) > 0;
			export Affiliation          := count(nothor(FileServices.SuperFileContents(Filenames().Input.Affiliation         .Sprayed))) > 0;
			export AccountDemographics  := count(nothor(FileServices.SuperFileContents(Filenames().Input.AccountDemographics .Sprayed))) > 0;
			export AccountAddress       := count(nothor(FileServices.SuperFileContents(Filenames().Input.AccountAddress      .Sprayed))) > 0;
			export AccountMerges        := count(nothor(FileServices.SuperFileContents(Filenames().Input.AccountMerges       .Sprayed))) > 0;
			export AccountSplits        := count(nothor(FileServices.SuperFileContents(Filenames().Input.AccountSplits       .Sprayed))) > 0;
		end;
		export Base := module
			export Main                 := count(nothor(FileServices.SuperFileContents(Filenames().Base.Main                .QA))) > 0;
			export StateLicense         := count(nothor(FileServices.SuperFileContents(Filenames().Base.StateLicense        .QA))) > 0;
			export Specialty            := count(nothor(FileServices.SuperFileContents(Filenames().Base.Specialty           .QA))) > 0;
			export Degree               := count(nothor(FileServices.SuperFileContents(Filenames().Base.Degree              .QA))) > 0;
			export Credential           := count(nothor(FileServices.SuperFileContents(Filenames().Base.Credential          .QA))) > 0;
			export Affiliation          := count(nothor(FileServices.SuperFileContents(Filenames().Base.Affiliation         .QA))) > 0;
			export IDNumber             := count(nothor(FileServices.SuperFileContents(Filenames().Base.IDNumber            .QA))) > 0;
		end;
	end;

  export Update := module
	  export Main := (FileExists.Input.ProviderDemographics or FileExists.Input.AccountDemographics or
		                FileExists.Input.ProviderAddress or FileExists.Input.AccountAddress) and FileExists.Base.Main;
		export StateLicense := FileExists.Input.StateLicense and FileExists.Base.StateLicense;
		export Specialty := FileExists.Input.Specialty and FileExists.Base.Specialty;
		export Degree := FileExists.Input.Degree and FileExists.Base.Degree;
		export Credential := FileExists.Input.Credential and FileExists.Base.Credential;
		export Affiliation := FileExists.Input.Affiliation and FileExists.Base.Affiliation;
		export IDNumber := FileExists.Input.Xref and FileExists.Base.IDNumber;
	end;

end;