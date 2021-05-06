import ut, tools;

export _Flags :=
module

	export IsTesting := tools._Constants.IsDataland;
	
	export UseStandardizePersists := not IsTesting;	
	
	export	UseDemoData	:= true;
	
	export FileExists := module
	
		export Input := module
			export MBS := count(nothor(FileServices.SuperFileContents(Filenames().Input.MBS.Sprayed))) > 0;
			export MbsNewGcIdExclusion := count(nothor(FileServices.SuperFileContents(Filenames().Input.MbsNewGcIdExclusion.Sprayed))) > 0;
			export MbsIndTypeExclusion := count(nothor(FileServices.SuperFileContents(Filenames().Input.MbsIndTypeExclusion.Sprayed))) > 0;
			export MbsFdnMasterIDIndTypeInclusion := count(nothor(FileServices.SuperFileContents(Filenames().Input.MbsFdnMasterIDIndTypeInclusion.Sprayed))) > 0;
			export MbsProductInclude := count(nothor(FileServices.SuperFileContents(Filenames().Input.MbsProductInclude.Sprayed))) > 0;
			export MBSSourceGcExclusion := count(nothor(FileServices.SuperFileContents(Filenames().Input.MBSSourceGcExclusion.Sprayed))) > 0;
			export MBSmarketAppend := count(nothor(FileServices.SuperFileContents(Filenames().Input.MBSmarketAppend.Sprayed))) > 0;
			export MBSFdnIndType := count(nothor(FileServices.SuperFileContents(Filenames().Input.MBSFdnIndType.Sprayed))) > 0;
			export MBSFdnCCID := count(nothor(FileServices.SuperFileContents(Filenames().Input.MBSFdnCCID.Sprayed))) > 0;
			export MBSFdnHHID := count(nothor(FileServices.SuperFileContents(Filenames().Input.MBSFdnHHID.Sprayed))) > 0;
			export MBSTableCol := count(nothor(FileServices.SuperFileContents(Filenames().Input.MBSTableCol.Sprayed))) > 0;
			export MBSColValDesc := count(nothor(FileServices.SuperFileContents(Filenames().Input.MBSColValDesc.Sprayed))) > 0;
			
			export IdentityData := count(nothor(FileServices.SuperFileContents(Filenames().Input.IdentityData.Sprayed))) > 0;
			export KnownFraud := count(nothor(FileServices.SuperFileContents(Filenames().Input.KnownFraud.Sprayed))) > 0;
			export Deltabase := count(nothor(FileServices.SuperFileContents(Filenames().Input.Deltabase.Sprayed))) > 0;
		end;
					
		export Base := module
			export AddressCache := count(nothor(FileServices.SuperFileContents(Filenames().Base.AddressCache.Built))) > 0;
			export Main 	:= count(nothor(FileServices.SuperFileContents(Filenames().Base.Main.Built))) > 0;
			export MainQA := count(nothor(FileServices.SuperFileContents(Filenames().Base.Main.QA))) > 0;
			export MainOrig 	:= count(nothor(FileServices.SuperFileContents(FraudGovPlatform.Filenames().Base.Main_Orig.Built))) > 0;			
			export MainOrigQA := count(nothor(FileServices.SuperFileContents(FraudGovPlatform.Filenames().Base.Main_Orig.QA))) > 0;			
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