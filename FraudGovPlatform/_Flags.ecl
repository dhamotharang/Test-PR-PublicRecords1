import _control, tools, FraudShared, did_add, PromoteSupers;

export _Flags :=
module

	export IsTesting 						:= tools._Constants.IsDataland;
	
	export UseStandardizePersists := not IsTesting;	
	
	export FileExists := module
	
		export Input := module
			export IdentityData     := count(nothor(FileServices.SuperFileContents(Filenames().Input.IdentityData.Sprayed))) > 0;
			export KnownFraud     	:= count(nothor(FileServices.SuperFileContents(Filenames().Input.KnownFraud.Sprayed))) > 0;
		end;
					
		export Base := module
			export IdentityData     := count(nothor(FileServices.SuperFileContents(Filenames().Base.IdentityData             	.QA))) > 0;
			export KnownFraud     	:= count(nothor(FileServices.SuperFileContents(Filenames().Base.KnownFraud             		.QA))) > 0;
			export Main             := count(nothor(FileServices.SuperFileContents(FraudShared.Filenames().Base.Main  				.QA))) > 0;
		end;
	end;

// put the conditions when to update individual Base files. 

	export Update := module
		export IdentityData       := FileExists.Input.IdentityData and FileExists.Base.IdentityData;
		export KnownFraud       	:= FileExists.Input.KnownFraud and FileExists.Base.KnownFraud;
		export Main          			:= FileExists.Input.IdentityData and FileExists.Base.Main;
	end;
	export Skipped := module
		export IdentityData       := ~FileExists.Input.IdentityData ;
		export KnownFraud       	:= ~FileExists.Input.KnownFraud ;
	end;

	EXPORT HeaderInfo := module
		
		shared ProdVer	:= did_add.get_EnvVariable('header_build_version')[1..8] : INDEPENDENT;
		shared dsVer	:= dataset(filenames().OutputF.NewHeader,{string8 Prod_Ver},flat,opt);
		
		EXPORT IsNew 	:= if(nothor(fileservices.fileExists(filenames().OutputF.NewHeader)), ProdVer <> dsVer[1].Prod_Ver, true);
		
		PromoteSupers.MAC_SF_BuildProcess(dataset([{ProdVer}],{string8 Prod_Ver}), filenames().OutputF.NewHeader, PostNewHeader ,2,,true);
		EXPORT Post 	:= if(	IsNew
								,sequential(PostNewHeader, output('header_build_version Changed', named('HeaderInfoChanged')))
								,sequential(output('header_build_version Not Changed', named('HeaderInfoNotChanged'))));	
		
	END;

	EXPORT RefreshAddresses(string pVersion) := module
		
		shared dsVer 	:= dataset(filenames().OutputF.RefreshAddresses,{string8 pVersion},flat,opt);
		
		EXPORT IsTimeForRefresh	:= if(	nothor(fileservices.fileExists(filenames().OutputF.RefreshAddresses)), 
										(unsigned8) pVersion - (unsigned8) dsVer[1].pVersion >= Constants().RefreshAddresses, 
										true);
		
		PromoteSupers.MAC_SF_BuildProcess(dataset([{pVersion}],{string8 pVersion}), filenames().OutputF.RefreshAddresses, PostRefreshAddresses ,2,,true);
		EXPORT Post 	:= if(	 IsTimeForRefresh
								,sequential(PostRefreshAddresses, output('refresh_addresses_version Changed', named('RefreshAddressesChanged')))
								,sequential(output('refresh_addresses_version Not Changed', named('RefreshAddressesNotChanged'))));			
	END;
end;