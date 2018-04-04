import _control, tools;

export _Flags :=
module

	export IsTesting 							:= tools._Constants.IsDataland;
	
	export UseStandardizePersists := not IsTesting;	
	
	export FileExists := module
	
		export Input := module
			export MBS                  						:= count(nothor(FileServices.SuperFileContents(Filenames().Input.MBS        										.Sprayed))) > 0;
      export MbsNewGcIdExclusion  						:= count(nothor(FileServices.SuperFileContents(Filenames().Input.MbsNewGcIdExclusion  					.Sprayed))) > 0;
      export MbsIndTypeExclusion  						:= count(nothor(FileServices.SuperFileContents(Filenames().Input.MbsIndTypeExclusion  					.Sprayed))) > 0;
			export MbsFdnMasterIDIndTypeInclusion		:= count(nothor(FileServices.SuperFileContents(Filenames().Input.MbsFdnMasterIDIndTypeInclusion .Sprayed))) > 0;
      export MbsProductInclude    						:= count(nothor(FileServices.SuperFileContents(Filenames().Input.MbsProductInclude        			.Sprayed))) > 0;
      export MBSSourceGcExclusion 						:= count(nothor(FileServices.SuperFileContents(Filenames().Input.MBSSourceGcExclusion       		.Sprayed))) > 0;
      export MBSmarketAppend      						:= count(nothor(FileServices.SuperFileContents(Filenames().Input.MBSmarketAppend       					.Sprayed))) > 0;
      export MBSFdnIndType        						:= count(nothor(FileServices.SuperFileContents(Filenames().Input.MBSFdnIndType       						.Sprayed))) > 0;
      export MBSFdnCCID           						:= count(nothor(FileServices.SuperFileContents(Filenames().Input.MBSFdnCCID       							.Sprayed))) > 0;
      export MBSFdnHHID           						:= count(nothor(FileServices.SuperFileContents(Filenames().Input.MBSFdnHHID       							.Sprayed))) > 0;
      export MBSTableCol          						:= count(nothor(FileServices.SuperFileContents(Filenames().Input.MBSTableCol       							.Sprayed))) > 0;
      export MBSColValDesc        						:= count(nothor(FileServices.SuperFileContents(Filenames().Input.MBSColValDesc       						.Sprayed))) > 0;
			export MbsVelocityRules      						:= count(nothor(FileServices.SuperFileContents(Filenames().Input.MbsVelocityRules   						.Sprayed))) > 0;
		end;
					

	end;



end;