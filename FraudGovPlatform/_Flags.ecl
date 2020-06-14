﻿import ut, tools, FraudShared;

export _Flags :=
module

	export IsTesting := tools._Constants.IsDataland;
	
	export UseStandardizePersists := not IsTesting;	
	
	export	UseDemoData	:= true;
	
	export FileExists := module
	
		export Input := module
			export IdentityData := count(nothor(FileServices.SuperFileContents(Filenames().Input.IdentityData.Sprayed))) > 0;
			export KnownFraud := count(nothor(FileServices.SuperFileContents(Filenames().Input.KnownFraud.Sprayed))) > 0;
			export Deltabase := count(nothor(FileServices.SuperFileContents(Filenames().Input.Deltabase.Sprayed))) > 0;
		end;
					
		export Base := module
			export AddressCache := count(nothor(FileServices.SuperFileContents(Filenames().Base.AddressCache.Built))) > 0;
			export Main 	:= count(nothor(FileServices.SuperFileContents(FraudShared.Filenames().Base.Main.Built))) > 0;
			export MainQA := count(nothor(FileServices.SuperFileContents(FraudShared.Filenames().Base.Main.QA))) > 0;
			export Pii := count(nothor(FileServices.SuperFileContents(Filenames().Base.Pii.Built))) > 0;
		end;
	end;

// put the conditions when to update individual Base files. 

	export Update := module
		export AddressCache := FileExists.Base.AddressCache;
		export Main := FileExists.Base.Main;
		export Pii := FileExists.Base.Pii;
	end;
	export Skipped := module
		export IdentityData := ~FileExists.Input.IdentityData ;
		export KnownFraud := ~FileExists.Input.KnownFraud ;
		export Deltabase := ~FileExists.Input.Deltabase ;
	end;

end;