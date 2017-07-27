import doxie, tools, corp2_services;

export Proc_Build_Roxie_Keys(const string pversion) :=
module
	
	export Corp :=
	module
  
		export BuildBdidKey			 := tools.macf_WriteIndex('Keys(pversion).Corp.Bdid.New'			);
		export BuildBdidPlKey		 := tools.macf_WriteIndex('Keys(pversion).Corp.BdidPl.New'		);	
		export BuildCorpKey			 := tools.macf_WriteIndex('Keys(pversion).Corp.CorpKey.New'	  );	
		export BuildNameAddrKey	 := tools.macf_WriteIndex('Keys(pversion).Corp.NameAddr.New'	);	
		export BuildStCharterKey := tools.macf_WriteIndex('Keys(pversion).Corp.StCharter.New' );
		export BuildLinkIdsKey   := tools.macf_WriteIndex('corp2.Key_LinkIds.corp.Key,	corp2.keynames(pversion).Corp.LinkIds.New');	
		
		export Build_All :=
		parallel(
			
			 BuildBdidKey
			,BuildBdidPlKey
			,BuildCorpKey
			,BuildNameAddrKey
			,BuildStCharterKey
			,BuildLinkIdsKey	
		);
			
	end;

	export Cont :=
	module

		export BuildBdidKey			 := tools.macf_WriteIndex('Keys(pversion).Cont.Bdid.New'		);
		export BuildCorpKey			 := tools.macf_WriteIndex('Keys(pversion).Cont.CorpKey.New'	);	
		export BuildNameAddrKey	 := tools.macf_WriteIndex('Keys(pversion).Cont.NameAddr.New');
		export BuildDidKey 			 := tools.macf_WriteIndex('Keys(pversion).cont.Did.New'			);
		export BuildLinkIdsKey   := tools.macf_WriteIndex('corp2.Key_LinkIds.cont.Key,	corp2.keynames(pversion).Cont.LinkIds.New');	

                                                                              
		export Build_All :=
		parallel(
			
			 BuildBdidKey
			,BuildCorpKey
			,BuildNameAddrKey
			,BuildDidKey
			,BuildLinkIdsKey
		);

	end;

	export Events :=
	module

		export BuildBdidKey := tools.macf_WriteIndex('Keys(pversion).Events.Bdid.New'			);
		export BuildCorpKey := tools.macf_WriteIndex('Keys(pversion).Events.CorpKey.New'	);
		
		export Build_All :=
		parallel(
			
			 BuildBdidKey
			,BuildCorpKey
		);

	end;

	export Stock :=
	module

		export BuildBdidKey := tools.macf_WriteIndex('Keys(pversion).Stock.Bdid.New'		);
		export BuildCorpKey := tools.macf_WriteIndex('Keys(pversion).Stock.CorpKey.New'	);
		                                                                             
		export Build_All :=
		parallel(
			
			 BuildBdidKey
			,BuildCorpKey
		);
                            
	end;

	export AR :=
	module

		export BuildBdidKey := tools.macf_WriteIndex('Keys(pversion).AR.Bdid.New'			);
		export BuildCorpKey := tools.macf_WriteIndex('Keys(pversion).AR.CorpKey.New'	);
                                                                            
		export Build_All :=
		parallel(
			
			 BuildBdidKey
			,BuildCorpKey
		);
	end;

	export Build_All :=
	sequential(
		parallel(
			 Corp.Build_All
			,Cont.Build_All
		),
		parallel(
			 Events.Build_All
			,Stock.Build_All
			,Ar.Build_All
		)
		,tools.mod_Utilities.createsupers(Keynames().dall_filenames)
		,corp2_services.BWR_buildautokeyB(pversion)
		,Promote(pversion,'key').buildfiles.New2Built
	);

end;