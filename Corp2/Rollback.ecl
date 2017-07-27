import VersionControl;

export Rollback :=
module
	
	export Input := 
	module

		export Corp		:= Filename_Utilities.Input.Corp._Superfiles._Rollback();
		export Cont		:= Filename_Utilities.Input.Cont._Superfiles._Rollback();
		export Events	:= Filename_Utilities.Input.Events._Superfiles._Rollback();
		export Stock	:= Filename_Utilities.Input.Stock._Superfiles._Rollback();
		export AR		:= Filename_Utilities.Input.AR._Superfiles._Rollback();
		                                       
		export Sprayed2Root :=
		parallel(

			 Corp.Sprayed2Root
			,Cont.Sprayed2Root
			,Events.Sprayed2Root
			,Stock.Sprayed2Root
			,AR.Sprayed2Root

		);

		export Using2Sprayed :=
		parallel(

			 Corp.Using2Sprayed
			,Cont.Using2Sprayed
			,Events.Using2Sprayed
			,Stock.Using2Sprayed
			,AR.Using2Sprayed

		);

		export Used2Sprayed :=
		parallel(

			 Corp.Used2Sprayed
			,Cont.Used2Sprayed
			,Events.Used2Sprayed
			,Stock.Used2Sprayed
			,AR.Used2Sprayed

		);

		export Delete2Used :=
		parallel(

			 Corp.Delete2Used
			,Cont.Delete2Used
			,Events.Delete2Used
			,Stock.Delete2Used
			,AR.Used2Sprayed

		);

	end;

	export Base := 
	module
		
		export Corp		:= Filename_Utilities.Base.Corp._Superfiles._Rollback();
		export Cont		:= Filename_Utilities.Base.Cont._Superfiles._Rollback();
		export Events	:= Filename_Utilities.Base.Events._Superfiles._Rollback();
		export Stock	:= Filename_Utilities.Base.Stock._Superfiles._Rollback();
		export AR		:= Filename_Utilities.Base.AR._Superfiles._Rollback();

		export Father2Prod :=
		parallel(
			 Corp.Father2Prod
			,Cont.Father2Prod
			,Events.Father2Prod
			,Stock.Father2Prod
			,AR.Father2Prod

		);
		
		export Prod2QA :=
		parallel(
			 Corp.Prod2QA
			,Cont.Prod2QA
			,Events.Prod2QA
			,Stock.Prod2QA
			,AR.Prod2QA

		);

		export Father2QA :=
		parallel(
			 Corp.Father2QA
			,Cont.Father2QA
			,Events.Father2QA
			,Stock.Father2QA
			,AR.Father2QA

		);

		export QA2Built :=
		parallel(
			 Corp.QA2Built
			,Cont.QA2Built
			,Events.QA2Built
			,Stock.QA2Built
			,AR.QA2Built

		);

		export Built2Building :=
		parallel(
			 Corp.Built2Building
			,Cont.Built2Building
			,Events.Built2Building
			,Stock.Built2Building
			,AR.Built2Building

		);

		
	end;

	export RoxieKeys := 
	module
		export Corp :=
		module

			export Bdid			:= Filename_Utilities.Roxiekeys.Corp.Bdid._Superfiles._Rollback();
			export BdidPl		:= Filename_Utilities.Roxiekeys.Corp.BdidPl._Superfiles._Rollback();
			export CorpKey		:= Filename_Utilities.Roxiekeys.Corp.CorpKey._Superfiles._Rollback();
			export NameAddr		:= Filename_Utilities.Roxiekeys.Corp.NameAddr._Superfiles._Rollback();
			export StCharter	:= Filename_Utilities.Roxiekeys.Corp.StCharter._Superfiles._Rollback();
		                                              
			export Father2Prod :=
			parallel(
				 Bdid.Father2Prod
				,BdidPl.Father2Prod
				,CorpKey.Father2Prod
				,NameAddr.Father2Prod
				,StCharter.Father2Prod
               
			);

			export Prod2QA :=
			parallel(
				 Bdid.Prod2QA
				,BdidPl.Prod2QA
				,CorpKey.Prod2QA
				,NameAddr.Prod2QA
				,StCharter.Prod2QA
               
			);

			export Father2QA :=
			parallel(
				 Bdid.Father2QA
				,BdidPl.Father2QA
				,CorpKey.Father2QA
				,NameAddr.Father2QA
				,StCharter.Father2QA
               
			);

			export QA2Built :=
			parallel(
				 Bdid.QA2Built
				,BdidPl.QA2Built
				,CorpKey.QA2Built
				,NameAddr.QA2Built
				,StCharter.QA2Built
               
			);

			export Built2Building :=
			parallel(
				 Bdid.Built2Building
				,BdidPl.Built2Building
				,CorpKey.Built2Building
				,NameAddr.Built2Building
				,StCharter.Built2Building
               
			);
		                                                             

		end;
		
		export Cont :=
		module

			export Bdid			:= Filename_Utilities.Roxiekeys.Cont.Bdid._Superfiles._Rollback();
			export CorpKey		:= Filename_Utilities.Roxiekeys.Cont.CorpKey._Superfiles._Rollback();
			export NameAddr		:= Filename_Utilities.Roxiekeys.Cont.NameAddr._Superfiles._Rollback();
		
			export Father2Prod :=
			parallel(
				 Bdid.Father2Prod
				,CorpKey.Father2Prod
				,NameAddr.Father2Prod
               
			);

			export Prod2QA :=
			parallel(
				 Bdid.Prod2QA
				,CorpKey.Prod2QA
				,NameAddr.Prod2QA
               
			);

			export Father2QA :=
			parallel(
				 Bdid.Father2QA
				,CorpKey.Father2QA
				,NameAddr.Father2QA
               
			);

			export QA2Built :=
			parallel(
				 Bdid.QA2Built
				,CorpKey.QA2Built
				,NameAddr.QA2Built
               
			);

			export Built2Building :=
			parallel(
				 Bdid.Built2Building
				,CorpKey.Built2Building
				,NameAddr.Built2Building
               
			);
		                                                             

		end;
		
		export Events :=
		module

			export Bdid			:= Filename_Utilities.Roxiekeys.Events.Bdid._Superfiles._Rollback();
			export CorpKey		:= Filename_Utilities.Roxiekeys.Events.CorpKey._Superfiles._Rollback();
		
			export Father2Prod :=
			parallel(
				 Bdid.Father2Prod
				,CorpKey.Father2Prod
               
			);

			export Prod2QA :=
			parallel(
				 Bdid.Prod2QA
				,CorpKey.Prod2QA
               
			);

			export Father2QA :=
			parallel(
				 Bdid.Father2QA
				,CorpKey.Father2QA
               
			);

			export QA2Built :=
			parallel(
				 Bdid.QA2Built
				,CorpKey.QA2Built
               
			);

			export Built2Building :=
			parallel(
				 Bdid.Built2Building
				,CorpKey.Built2Building
               
			);
		                                                             

		end;
		
		export Stock :=
		module
		
			export Bdid			:= Filename_Utilities.Roxiekeys.Stock.Bdid._Superfiles._Rollback();
			export CorpKey		:= Filename_Utilities.Roxiekeys.Stock.CorpKey._Superfiles._Rollback();

			export Father2Prod :=
			parallel(
				 Bdid.Father2Prod
				,CorpKey.Father2Prod
               
			);

			export Prod2QA :=
			parallel(
				 Bdid.Prod2QA
				,CorpKey.Prod2QA
               
			);

			export Father2QA :=
			parallel(
				 Bdid.Father2QA
				,CorpKey.Father2QA
               
			);

			export QA2Built :=
			parallel(
				 Bdid.QA2Built
				,CorpKey.QA2Built
               
			);

			export Built2Building :=
			parallel(
				 Bdid.Built2Building
				,CorpKey.Built2Building
               
			);
		                                                             
		                                                             
		end;
		
		export AR :=
		module

			export Bdid			:= Filename_Utilities.Roxiekeys.AR.Bdid._Superfiles._Rollback();
			export CorpKey		:= Filename_Utilities.Roxiekeys.AR.CorpKey._Superfiles._Rollback();
		

			export Father2Prod :=
			parallel(
				 Bdid.Father2Prod
				,CorpKey.Father2Prod
               
			);

			export Prod2QA :=
			parallel(
				 Bdid.Prod2QA
				,CorpKey.Prod2QA
               
			);

			export Father2QA :=
			parallel(
				 Bdid.Father2QA
				,CorpKey.Father2QA
               
			);

			export QA2Built :=
			parallel(
				 Bdid.QA2Built
				,CorpKey.QA2Built
               
			);

			export Built2Building :=
			parallel(
				 Bdid.Built2Building
				,CorpKey.Built2Building
               
			);
		                                                             
		end;
		
		export Prod2QA :=
		parallel(
			 Corp.Prod2QA
			,Cont.Prod2QA
			,Events.Prod2QA
			,Stock.Prod2QA
			,AR.Prod2QA

		);

		export Father2Prod :=
		parallel(
			 Corp.Father2Prod
			,Cont.Father2Prod
			,Events.Father2Prod
			,Stock.Father2Prod
			,AR.Father2Prod

		);

		export Father2QA :=
		parallel(
			 Corp.Father2QA
			,Cont.Father2QA
			,Events.Father2QA
			,Stock.Father2QA
			,AR.Father2QA

		);

		export Built2Building :=
		parallel(
			 Corp.Built2Building
			,Cont.Built2Building
			,Events.Built2Building
			,Stock.Built2Building
			,AR.Built2Building

		);
	
		export QA2Built :=
		parallel(
			 Corp.QA2Built
			,Cont.QA2Built
			,Events.QA2Built
			,Stock.QA2Built
			,AR.QA2Built

		);


	end;

end;
