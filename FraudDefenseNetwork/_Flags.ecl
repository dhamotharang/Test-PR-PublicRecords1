import _control, tools;

export _Flags :=
module

	export IsTesting 							:= tools._Constants.IsDataland;
	
	export UseStandardizePersists := not IsTesting;	
	
	export FileExists := module
	
		export Input := module
			export SuspectIP            := count(nothor(FileServices.SuperFileContents(Filenames().Input.SuspectIP          .Sprayed))) > 0;
			export Glb5                 := count(nothor(FileServices.SuperFileContents(Filenames().Input.Glb5                .Sprayed))) > 0;
			export Tiger                := count(nothor(FileServices.SuperFileContents(Filenames().Input.tiger        .Sprayed))) > 0;
			export CFNA                 := count(nothor(FileServices.SuperFileContents(Filenames().Input.CFNA        .Sprayed))) > 0;
			export AInspection          := count(nothor(FileServices.SuperFileContents(Filenames().Input.AInspection        .Sprayed))) > 0;
			export MBS                  := count(nothor(FileServices.SuperFileContents(Filenames().Input.MBS        .Sprayed))) > 0;
      export MbsGcIdExclusion     := count(nothor(FileServices.SuperFileContents(Filenames().Input.MbsGcIdExclusion    .Sprayed))) > 0;
      export MbsNewGcIdExclusion  := count(nothor(FileServices.SuperFileContents(Filenames().Input.MbsNewGcIdExclusion  .Sprayed))) > 0;
      export MbsIndTypeExclusion  := count(nothor(FileServices.SuperFileContents(Filenames().Input.MbsIndTypeExclusion        .Sprayed))) > 0;
      export MbsProductInclude    := count(nothor(FileServices.SuperFileContents(Filenames().Input.MbsProductInclude        .Sprayed))) > 0;
      export MBSSourceGcExclusion := count(nothor(FileServices.SuperFileContents(Filenames().Input.MBSSourceGcExclusion       .Sprayed))) > 0;
      export MBSmarketAppend      := count(nothor(FileServices.SuperFileContents(Filenames().Input.MBSmarketAppend       .Sprayed))) > 0;
      export MBSFdnIndType        := count(nothor(FileServices.SuperFileContents(Filenames().Input.MBSFdnIndType       .Sprayed))) > 0;
      export MBSFdnCCID           := count(nothor(FileServices.SuperFileContents(Filenames().Input.MBSFdnCCID       .Sprayed))) > 0;
      export MBSFdnHHID           := count(nothor(FileServices.SuperFileContents(Filenames().Input.MBSFdnHHID       .Sprayed))) > 0;
      export MBSTableCol          := count(nothor(FileServices.SuperFileContents(Filenames().Input.MBSTableCol       .Sprayed))) > 0;
      export MBSColValDesc        := count(nothor(FileServices.SuperFileContents(Filenames().Input.MBSColValDesc       .Sprayed))) > 0;

		end;
					
		export Base := module
			export Main                 := count(nothor(FileServices.SuperFileContents(Filenames().Base.Main                 .QA))) > 0;
			export SuspectIP            := count(nothor(FileServices.SuperFileContents(Filenames().Base.SuspectIP            .QA))) > 0;
			export Glb5                 := count(nothor(FileServices.SuperFileContents(Filenames().Base.GLB5                  .QA))) > 0;
			export Tiger                := count(nothor(FileServices.SuperFileContents(Filenames().Base.Tiger                .QA))) > 0;
			export CFNA                 := count(nothor(FileServices.SuperFileContents(Filenames().Base.CFNA                 .QA))) > 0;
			export AInspection          := count(nothor(FileServices.SuperFileContents(Filenames().Base.AInspection          .QA))) > 0;
		  export TextMinedCrim        := count(nothor(FileServices.SuperFileContents(Filenames().Base.TextMinedCrim        .QA))) > 0;
			export OIG                  := count(nothor(FileServices.SuperFileContents(Filenames().Base.OIG                  .QA))) > 0;

			end;
	end;

// put the conditions when to update individual Base files. 

  export Update := module
	
	  export Main          := (FileExists.Input.Glb5 or FileExists.Input.tiger or FileExists.Input.CFNA or FileExists.Input.AInspection or FileExists.Input.SuspectIP) and FileExists.Base.Main;
		export SuspectIP     := FileExists.Input.SuspectIP and FileExists.Base.SuspectIP;
		export Glb5          := FileExists.Input.Glb5 and FileExists.Base.Glb5;
		export Tiger         := FileExists.Input.tiger and FileExists.Base.tiger;
		export CFNA          := FileExists.Input.CFNA and FileExists.Base.CFNA;
		export AInspection   := FileExists.Input.AInspection and FileExists.Base.AInspection;
		export TextMinedCrim := FileExists.Base.TextMinedCrim;  // inputs are picked direclty from Boca thor and gets updated twice week
		export OIG           := FileExists.Base.OIG;  // inputs are picked direclty from Boca thor and gets updated once a month
   
		end;
   export Skipped := module
	
		export SuspectIP     := ~FileExists.Input.SuspectIP ;
		export Glb5          := ~FileExists.Input.Glb5 ;
		export Tiger         := ~FileExists.Input.tiger;
		export CFNA          := ~FileExists.Input.CFNA ;
		export AInspection   := ~FileExists.Input.AInspection ;
	  export TextMinedCrim := FileExists.Base.TextMinedCrim;  // inputs are picked direclty from Boca thor and gets updated twice week
		export OIG           := FileExists.Base.OIG;  // inputs are picked direclty from Boca thor and gets updated once a month
   
		end;
		
end;