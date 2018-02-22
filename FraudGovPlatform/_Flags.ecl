import _control, tools, FraudShared;

export _Flags :=
module

	export IsTesting 						:= tools._Constants.IsDataland;
	
	export UseStandardizePersists := not IsTesting;	
	
	export FileExists := module
	
		export Input := module
			export IdentityData     := count(nothor(FileServices.SuperFileContents(Filenames().Input.IdentityData.Sprayed))) > 0;
			export KnownFraud     	:= count(nothor(FileServices.SuperFileContents(Filenames().Input.KnownFraud.Sprayed))) > 0;
			export InquiryLogs		:= count(nothor(FileServices.SuperFileContents(Filenames().Input.InquiryLogs.Sprayed))) > 0;
		end;
					
		export Base := module
			export IdentityData     := count(nothor(FileServices.SuperFileContents(Filenames().Base.IdentityData             	.QA))) > 0;
			export KnownFraud     	:= count(nothor(FileServices.SuperFileContents(Filenames().Base.KnownFraud             		.QA))) > 0;
			export InquiryLogs		:= count(nothor(FileServices.SuperFileContents(Filenames().Base.InquiryLogs             		.QA))) > 0;
			export Main             := count(nothor(FileServices.SuperFileContents(FraudShared.Filenames().Base.Main  				.QA))) > 0;
		end;
	end;

// put the conditions when to update individual Base files. 

  export Update := module
		export IdentityData       := FileExists.Input.IdentityData and FileExists.Base.IdentityData;
		export KnownFraud       	:= FileExists.Input.KnownFraud and FileExists.Base.KnownFraud;
		export InquiryLogs			:= FileExists.Input.InquiryLogs and FileExists.Base.InquiryLogs;
		export Main          			:= FileExists.Input.IdentityData and FileExists.Base.Main;
   
		end;
   export Skipped := module
	
		export IdentityData       := ~FileExists.Input.IdentityData ;
		export KnownFraud       	:= ~FileExists.Input.KnownFraud ;
		export InquiryLogs       := ~FileExists.Input.InquiryLogs ;
   
		end;

end;