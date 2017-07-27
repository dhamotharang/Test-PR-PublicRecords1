import VersionControl;

export Promote :=
module
	
	export Input := 
	module

		export Corp		:= Filename_Utilities.Input.Corp._Superfiles._Promote();
		export Cont		:= Filename_Utilities.Input.Cont._Superfiles._Promote();
		export Events	:= Filename_Utilities.Input.Events._Superfiles._Promote();
		export Stock	:= Filename_Utilities.Input.Stock._Superfiles._Promote();
		export AR		:= Filename_Utilities.Input.AR._Superfiles._Promote();
		                                       
		export Root2Sprayed(boolean pClearSprayed = false) :=
		parallel(

			 Corp.Root2Sprayed(pClearSprayed)
			,Cont.Root2Sprayed(pClearSprayed)
			,Events.Root2Sprayed(pClearSprayed)
			,Stock.Root2Sprayed(pClearSprayed)
			,AR.Root2Sprayed(pClearSprayed)

		);

		export Sprayed2Using :=
		parallel(

			 Corp.Sprayed2Using
			,Cont.Sprayed2Using
			,Events.Sprayed2Using
			,Stock.Sprayed2Using
			,AR.Sprayed2Using

		);

		export Using2Used :=
		parallel(

			 Corp.Using2Used
			,Cont.Using2Used
			,Events.Using2Used
			,Stock.Using2Used
			,AR.Using2Used

		);
	end;

	export Base := 
	module
		
		export Corp		:= Filename_Utilities.Base.Corp._Superfiles._Promote();
		export Cont		:= Filename_Utilities.Base.Cont._Superfiles._Promote();
		export Events	:= Filename_Utilities.Base.Events._Superfiles._Promote();
		export Stock	:= Filename_Utilities.Base.Stock._Superfiles._Promote();
		export AR		:= Filename_Utilities.Base.AR._Superfiles._Promote();

		export New2Building :=
		parallel(
			 Corp.New2Building
			,Cont.New2Building
			,Events.New2Building
			,Stock.New2Building
			,AR.New2Building

		);
		
		export New2Built :=
		parallel(
			 Corp.New2Built
			,Cont.New2Built
			,Events.New2Built
			,Stock.New2Built
			,AR.New2Built

		);

		export Building2Built :=
		parallel(
			 Corp.Building2Built
			,Cont.Building2Built
			,Events.Building2Built
			,Stock.Building2Built
			,AR.Building2Built

		);

		export Built2Qa2Delete :=
		parallel(
			 Corp.Built2Qa2Delete
			,Cont.Built2Qa2Delete
			,Events.Built2Qa2Delete
			,Stock.Built2Qa2Delete
			,AR.Built2Qa2Delete

		);

		export Built2QA2Father :=
		parallel(
			 Corp.Built2QA2Father
			,Cont.Built2QA2Father
			,Events.Built2QA2Father
			,Stock.Built2QA2Father
			,AR.Built2QA2Father

		);

		export QA2Prod :=
		parallel(
			 Corp.QA2Prod
			,Cont.QA2Prod
			,Events.QA2Prod
			,Stock.QA2Prod
			,AR.QA2Prod

		);
		
	end;

	export RoxieKeys := 
	module
		export Corp :=
		module
			
			export Bdid			:= Filename_Utilities.Roxiekeys.Corp.Bdid._Superfiles._Promote();
			export BdidPl		:= Filename_Utilities.Roxiekeys.Corp.BdidPl._Superfiles._Promote();
			export CorpKey		:= Filename_Utilities.Roxiekeys.Corp.CorpKey._Superfiles._Promote();
			export NameAddr		:= Filename_Utilities.Roxiekeys.Corp.NameAddr._Superfiles._Promote();
			export StCharter	:= Filename_Utilities.Roxiekeys.Corp.StCharter._Superfiles._Promote();
		                                              
			export New2Building :=
			parallel(
				 Bdid.New2Building
				,BdidPl.New2Building
				,CorpKey.New2Building
				,NameAddr.New2Building
				,StCharter.New2Building
               
			);

			export New2Built :=
			parallel(
				
					Bdid.New2Built
				,BdidPl.New2Built
				,CorpKey.New2Built
				,NameAddr.New2Built
				,StCharter.New2Built
               
			);

			export Building2Built :=
			parallel(
				 Bdid.Building2Built
				,BdidPl.Building2Built
				,CorpKey.Building2Built
				,NameAddr.Building2Built
				,StCharter.Building2Built
               
			);

			export Built2QA2Delete :=
			parallel(
				 Bdid.Built2QA2Delete
				,BdidPl.Built2QA2Delete
				,CorpKey.Built2QA2Delete
				,NameAddr.Built2QA2Delete
				,StCharter.Built2QA2Delete
               
			);

			export Built2QA2Father :=
			parallel(
				 Bdid.Built2QA2Father
				,BdidPl.Built2QA2Father
				,CorpKey.Built2QA2Father
				,NameAddr.Built2QA2Father
				,StCharter.Built2QA2Father
               
			);
		                                                             
			export QA2Prod :=
			parallel(
				 Bdid.QA2Prod
				,BdidPl.QA2Prod
				,CorpKey.QA2Prod
				,NameAddr.QA2Prod
				,StCharter.QA2Prod
               
			);

		end;
		
		export Cont :=
		module
			export Did			:= Filename_Utilities.Roxiekeys.Cont.Did._Superfiles._Promote();
			export Bdid			:= Filename_Utilities.Roxiekeys.Cont.Bdid._Superfiles._Promote();
			export CorpKey		:= Filename_Utilities.Roxiekeys.Cont.CorpKey._Superfiles._Promote();
			export NameAddr		:= Filename_Utilities.Roxiekeys.Cont.NameAddr._Superfiles._Promote();
		
			export New2Building :=
			parallel(
				 Bdid.New2Building
				,did.New2Building
				,CorpKey.New2Building
				,NameAddr.New2Building
               
			);

			export New2Built :=
			parallel(
				 Did.New2Built
				,Bdid.New2Built
				,CorpKey.New2Built
				,NameAddr.New2Built
               
			);

			export Building2Built :=
			parallel(
				 Did.Building2Built
				,Bdid.Building2Built
				,CorpKey.Building2Built
				,NameAddr.Building2Built
               
			);

			export Built2QA2Delete :=
			parallel(
				 did.Built2QA2Delete
				,Bdid.Built2QA2Delete
				,CorpKey.Built2QA2Delete
				,NameAddr.Built2QA2Delete
               
			);

			export Built2QA2Father :=
			parallel(
				 Did.Built2QA2Father
				,Bdid.Built2QA2Father
				,CorpKey.Built2QA2Father
				,NameAddr.Built2QA2Father
               
			);
		                                                             
			export QA2Prod :=
			parallel(
				 Did.QA2Prod
				,Bdid.QA2Prod
				,CorpKey.QA2Prod
				,NameAddr.QA2Prod
               
			);

		end;
		
		export Events :=
		module

			export Bdid			:= Filename_Utilities.Roxiekeys.Events.Bdid._Superfiles._Promote();
			export CorpKey		:= Filename_Utilities.Roxiekeys.Events.CorpKey._Superfiles._Promote();
		
			export New2Building :=
			parallel(
				 Bdid.New2Building
				,CorpKey.New2Building
               
			);

			export New2Built :=
			parallel(
				 Bdid.New2Built
				,CorpKey.New2Built
               
			);

			export Building2Built :=
			parallel(
				 Bdid.Building2Built
				,CorpKey.Building2Built
               
			);

			export Built2QA2Delete :=
			parallel(
				 Bdid.Built2QA2Delete
				,CorpKey.Built2QA2Delete
               
			);

			export Built2QA2Father :=
			parallel(
				 Bdid.Built2QA2Father
				,CorpKey.Built2QA2Father
               
			);
		                                                             
			export QA2Prod :=
			parallel(
				 Bdid.QA2Prod
				,CorpKey.QA2Prod
              
			);

		end;
		
		export Stock :=
		module
		
			export Bdid			:= Filename_Utilities.Roxiekeys.Stock.Bdid._Superfiles._Promote();
			export CorpKey		:= Filename_Utilities.Roxiekeys.Stock.CorpKey._Superfiles._Promote();

			export New2Building :=
			parallel(
				 Bdid.New2Building
				,CorpKey.New2Building
               
			);

			export New2Built :=
			parallel(
				 Bdid.New2Built
				,CorpKey.New2Built
               
			);

			export Building2Built :=
			parallel(
				 Bdid.Building2Built
				,CorpKey.Building2Built
               
			);

			export Built2QA2Delete :=
			parallel(
				 Bdid.Built2QA2Delete
				,CorpKey.Built2QA2Delete
               
			);

			export Built2QA2Father :=
			parallel(
				 Bdid.Built2QA2Father
				,CorpKey.Built2QA2Father
               
			);
		                                                             
			export QA2Prod :=
			parallel(
				 Bdid.QA2Prod
				,CorpKey.QA2Prod
              
			);
		                                                             
		end;
		
		export AR :=
		module

			export Bdid			:= Filename_Utilities.Roxiekeys.AR.Bdid._Superfiles._Promote();
			export CorpKey		:= Filename_Utilities.Roxiekeys.AR.CorpKey._Superfiles._Promote();
		

			export New2Building :=
			parallel(
				 Bdid.New2Building
				,CorpKey.New2Building
               
			);

			export New2Built :=
			parallel(
				 Bdid.New2Built
				,CorpKey.New2Built
               
			);

			export Building2Built :=
			parallel(
				 Bdid.Building2Built
				,CorpKey.Building2Built
               
			);

			export Built2QA2Delete :=
			parallel(
				 Bdid.Built2QA2Delete
				,CorpKey.Built2QA2Delete
               
			);

			export Built2QA2Father :=
			parallel(
				 Bdid.Built2QA2Father
				,CorpKey.Built2QA2Father
               
			);
		                                                             
			export QA2Prod :=
			parallel(
				 Bdid.QA2Prod
				,CorpKey.QA2Prod
              
			);
		                                                             
		end;
		
		export Autokeys :=
		module

			export Address		:= Filename_Utilities.Roxiekeys.Autokeys.Address._Superfiles._Promote();
			export CityStName	:= Filename_Utilities.Roxiekeys.Autokeys.CityStName._Superfiles._Promote();
			export Name			:= Filename_Utilities.Roxiekeys.Autokeys.Name._Superfiles._Promote();
			export Phone		:= Filename_Utilities.Roxiekeys.Autokeys.Phone._Superfiles._Promote();
			export SSN			:= Filename_Utilities.Roxiekeys.Autokeys.SSN._Superfiles._Promote();
			export StName		:= Filename_Utilities.Roxiekeys.Autokeys.StName._Superfiles._Promote();
			export Zip			:= Filename_Utilities.Roxiekeys.Autokeys.Zip._Superfiles._Promote();
			export Payload		:= Filename_Utilities.Roxiekeys.Autokeys.Payload._Superfiles._Promote();
			export AddressB		:= Filename_Utilities.Roxiekeys.Autokeys.AddressB._Superfiles._Promote();
			export CityStNameB	:= Filename_Utilities.Roxiekeys.Autokeys.CityStNameB._Superfiles._Promote();
			export NameB		:= Filename_Utilities.Roxiekeys.Autokeys.NameB._Superfiles._Promote();
			export NameWords	:= Filename_Utilities.Roxiekeys.Autokeys.NameWords._Superfiles._Promote();
			export PhoneB		:= Filename_Utilities.Roxiekeys.Autokeys.PhoneB._Superfiles._Promote();
			export FEIN			:= Filename_Utilities.Roxiekeys.Autokeys.FEIN._Superfiles._Promote();
			export StNameB		:= Filename_Utilities.Roxiekeys.Autokeys.StNameB._Superfiles._Promote();
			export ZipB			:= Filename_Utilities.Roxiekeys.Autokeys.ZipB._Superfiles._Promote();
	

			export New2Building :=
			parallel(
				 Address.New2Building
				,CityStName.New2Building
				,Name.New2Building
				,Phone.New2Building
				,SSN.New2Building
				,StName.New2Building
				,Zip.New2Building
				,Payload.New2Building
				,AddressB.New2Building
				,CityStNameB.New2Building
				,NameB.New2Building
				,NameWords.New2Building
				,PhoneB.New2Building
				,FEIN.New2Building
				,StNameB.New2Building
				,ZipB.New2Building
                 
			);

			export New2Built :=
			parallel(
				 Address.New2Built
				,CityStName.New2Built
				,Name.New2Built
				,Phone.New2Built
				,SSN.New2Built
				,StName.New2Built
				,Zip.New2Built
				,Payload.New2Built
				,AddressB.New2Built
				,CityStNameB.New2Built
				,NameB.New2Built
				,NameWords.New2Built
				,PhoneB.New2Built
				,FEIN.New2Built
				,StNameB.New2Built
				,ZipB.New2Built
               
			);

			export Building2Built :=
			parallel(
				 Address.New2Built
				,CityStName.New2Built
				,Name.New2Built
				,Phone.New2Built
				,SSN.New2Built
				,StName.New2Built
				,Zip.New2Built
				,Payload.New2Built
				,AddressB.New2Built
				,CityStNameB.New2Built
				,NameB.New2Built
				,NameWords.New2Built
				,PhoneB.New2Built
				,FEIN.New2Built
				,StNameB.New2Built
				,ZipB.New2Built
               
			);

			export Built2QA2Delete :=
			parallel(
				 Address.Built2QA2Delete
				,CityStName.Built2QA2Delete
				,Name.Built2QA2Delete
				,Phone.Built2QA2Delete
				,SSN.Built2QA2Delete
				,StName.Built2QA2Delete
				,Zip.Built2QA2Delete
				,Payload.Built2QA2Delete
				,AddressB.Built2QA2Delete
				,CityStNameB.Built2QA2Delete
				,NameB.Built2QA2Delete
				,NameWords.Built2QA2Delete
				,PhoneB.Built2QA2Delete
				,FEIN.Built2QA2Delete
				,StNameB.Built2QA2Delete
				,ZipB.Built2QA2Delete
               
			);

			export Built2QA2Father :=
			parallel(
				 Address.Built2QA2Father
				,CityStName.Built2QA2Father
				,Name.Built2QA2Father
				,Phone.Built2QA2Father
				,SSN.Built2QA2Father
				,StName.Built2QA2Father
				,Zip.Built2QA2Father
				,Payload.Built2QA2Father
				,AddressB.Built2QA2Father
				,CityStNameB.Built2QA2Father
				,NameB.Built2QA2Father
				,NameWords.Built2QA2Father
				,PhoneB.Built2QA2Father
				,FEIN.Built2QA2Father
				,StNameB.Built2QA2Father
				,ZipB.Built2QA2Father
               
			);
		                                                             
			export QA2Prod :=
			parallel(
				 Address.QA2Prod
				,CityStName.QA2Prod
				,Name.QA2Prod
				,Phone.QA2Prod
				,SSN.QA2Prod
				,StName.QA2Prod
				,Zip.QA2Prod
				,Payload.QA2Prod
				,AddressB.QA2Prod
				,CityStNameB.QA2Prod
				,NameB.QA2Prod
				,NameWords.QA2Prod
				,PhoneB.QA2Prod
				,FEIN.QA2Prod
				,StNameB.QA2Prod
				,ZipB.QA2Prod
              
			);
		                                                             
		end;


		export New2Built :=
		parallel(
			 Corp.New2Built
			,Cont.New2Built
			,Events.New2Built
			,Stock.New2Built
			,AR.New2Built
			,Autokeys.New2Built

		);

		export New2Building :=
		parallel(
			 Corp.New2Building
			,Cont.New2Building
			,Events.New2Building
			,Stock.New2Building
			,AR.New2Building
			,Autokeys.New2Building

		);

		export Building2Built :=
		parallel(
			 Corp.Building2Built
			,Cont.Building2Built
			,Events.Building2Built
			,Stock.Building2Built
			,AR.Building2Built
			,Autokeys.Building2Built

		);

		export Built2QA2Father :=
		parallel(
			 Corp.Built2QA2Father
			,Cont.Built2QA2Father
			,Events.Built2QA2Father
			,Stock.Built2QA2Father
			,AR.Built2QA2Father
			,Autokeys.Built2QA2Father

		);
	
		export Built2QA2Delete :=
		parallel(
			 Corp.Built2QA2Delete
			,Cont.Built2QA2Delete
			,Events.Built2QA2Delete
			,Stock.Built2QA2Delete
			,AR.Built2QA2Delete
			,Autokeys.Built2QA2Delete

		);

		export QA2Prod :=
		parallel(
			 Corp.QA2Prod
			,Cont.QA2Prod
			,Events.QA2Prod
			,Stock.QA2Prod
			,AR.QA2Prod
			,Autokeys.QA2Prod

		);

	end;
	
	export Built2Qa2Delete :=
	parallel(
		 Base.Built2Qa2Delete
		,Roxiekeys.Built2Qa2Delete

	);

	export Built2QA2Father :=
	parallel(
		 Base.Built2QA2Father
		,RoxieKeys.Built2QA2Father

	);

	export QA2Prod :=
	parallel(
		 Base.QA2Prod
		,RoxieKeys.QA2Prod

	);


end;
