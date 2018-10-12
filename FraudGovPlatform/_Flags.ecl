import _control, tools, FraudShared;

export _Flags :=
module

	export IsTesting 						:= tools._Constants.IsDataland;
	
	export UseStandardizePersists := not IsTesting;	
	
	export	UseDemoData	:= true;
	
	export FileExists := module
	
		export Input := module
			export IdentityData     := count(nothor(FileServices.SuperFileContents(Filenames().Input.IdentityData.Sprayed))) > 0;
			export KnownFraud     	:= count(nothor(FileServices.SuperFileContents(Filenames().Input.KnownFraud.Sprayed))) > 0;
		end;
					
		export Base := module
			export IdentityData     := count(nothor(FileServices.SuperFileContents(Filenames().Base.IdentityData             	.QA))) > 0;
			export KnownFraud     	:= count(nothor(FileServices.SuperFileContents(Filenames().Base.KnownFraud             		.QA))) > 0;
			export Main             := count(nothor(FileServices.SuperFileContents(FraudShared.Filenames().Base.Main  				.QA))) > 0;
			export Pii	            := count(nothor(FileServices.SuperFileContents(Filenames().Base.Pii  											.QA))) > 0;
		end;
	end;

// put the conditions when to update individual Base files. 

	export Update := module
		export IdentityData       := FileExists.Input.IdentityData and FileExists.Base.IdentityData;
		export KnownFraud       	:= FileExists.Input.KnownFraud and FileExists.Base.KnownFraud;
		export Main          			:= FileExists.Input.IdentityData and FileExists.Base.Main;
		export Pii          			:= FileExists.Base.Main and FileExists.Base.Pii;
	end;
	export Skipped := module
		export IdentityData       := ~FileExists.Input.IdentityData ;
		export KnownFraud       	:= ~FileExists.Input.KnownFraud ;
	end;

end;