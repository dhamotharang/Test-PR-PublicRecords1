/*
  _Control.Config
    This attribute should be checked into each environment with its own values, like _Control.ThisEnvironment.
    
*/
EXPORT Config :=
module

  // ----------------------------------------------------------------------------------------
  // -- these attributes should be changed to match your environments(1 prod, 1 dev environment assumed)
  // ----------------------------------------------------------------------------------------
  export prod_name          := 'Prod_Thor'                        ; //should match what _Control.ThisEnvironment.Name is in your dev and prod environments
  export dev_name           := 'Dataland'                         ;

  export prod_dali          := 'prod_dali.br.seisint.com'         ;
  export dev_dali           := '10.241.12.201'                    ; //dataland_dali.br.seisint.com

  export prod_hthor         := 'hthor'                            ;
  export dev_hthor          := 'hthor_dev'                        ;

  export ProdEsps           := ['prod_esp.br.seisint.com'     ,'10.173.84.202'  ,'10.173.85.202'  ,'10.241.20.202','10.241.30.202','10.173.84.205' ];
  export DevEsps            := ['10.241.12.207','dataland_esp.br.seisint.com'  ,'10.241.12.204'                                 ];  
  
  export emailSender        := 'eclsystem@seisint.com'            ;
  export MailServer         := 'mailout.br.seisint.com'           ;
  export MailPort           := 25                                 ;
  export emailAddressNotify := _control.MyInfo.EmailAddressNotify ;

  /*
    -- Clusters are now different between workunits and files.  files require the extra '01', '02', etc to be appended to the cluster name.
    -- Workunits do not require this and will fail if they have it.
    -- This function is for workunits.  if you are interested in files, USE tools.fun_Clustername_DFU.
    -- this is true on boca dataland for now, doesn't seem to be true on prod yet...
  */
  export Groupname(
    
     string		pHint					= ''
    ,boolean	pForMacroUse	= false 
    
  ) :=
  function

    returnstring :=
    map( _Control.ThisEnvironment.name	 = 'Dataland' =>	
                                                          map( pHint = '50'			=> if(not pForMacroUse	,'thor50_dev'		,'\'thor50_dev\''			)
                                                              ,pHint = '02'			=> if(not pForMacroUse	,'thor50_dev02'	,'\'thor50_dev02\''	  )
                                                              ,pHint = 'prod'		=> if(not pForMacroUse	,'thor400_prod' ,'\'thor400_prod\''	  )
                                                              ,pHint = 'sta'    => if(not pForMacroUse	,'thor400_sta'	,'\'thor400_sta\''		)
                                                              ,pHint = 'dev'		=> if(not pForMacroUse	,'thor400_dev'	,'\'thor400_dev\''	  )
                                                              ,										 if(not pForMacroUse	,'thor400_dev'	,'\'thor400_dev\''  	)
                                                          )
      ,																										map( pHint = '20'			  => if(not pForMacroUse	,'thor400_20'			    ,'\'thor400_20\''			    )																												
                                                              ,pHint = '60'			  => if(not pForMacroUse	,'thor400_60'			    ,'\'thor400_60\''			    )																												
                                                              ,pHint = '44'			  => if(not pForMacroUse	,'thor400_44'			    ,'\'thor400_44\''			    )																												
                                                              ,pHint = 'scoring'  => if(not pForMacroUse	,'thor400_44_scoring'	,'\'thor400_44_scoring\'' )																												
                                                              ,pHint = 'sla'			=> if(not pForMacroUse	,'thor400_44_sla'			,'\'thor400_44_sla\''			)																												
                                                              ,										   if(not pForMacroUse	,'thor400_20'			    ,'\'thor400_20\''			    )
                                                          )
    );

    return returnstring;
        
  end;  

  // ----------------------------------------------------------------------------------------
  // -- the following should not need to be changed for a new environment
  // ----------------------------------------------------------------------------------------

	export IsDev                  := if(regexfind(dev_name, _Control.ThisEnvironment.Name, nocase)  ,true ,false	);
  
  export DevEsp                 := DevEsps[1];
  export ProdEsp                := ProdEsps[1];

  export LocalEsp               := if(IsDev  ,DevEsp  ,ProdEsp   );
  export LocalEsps              := if(IsDev  ,DevEsps ,ProdEsps  );
  
  export Esp2Hthor(string pEsp) := if(pEsp in DevEsps ,dev_hthor  ,prod_hthor   );
  export Esp2Name (string pEsp) := if(pEsp in DevEsps ,dev_name   ,prod_name    );
  
  export LocalHthor             := Esp2Hthor(LocalEsp);
  export LocalENV               := Esp2Name (LocalEsp);
    
  export foreign_prod           := '~foreign::' + prod_dali + '::';
  export foreign_dev            := '~foreign::' + dev_dali  + '::';
  
  export foreign_env(string pRemoteEsp) := map( pRemoteEsp in DevEsps  and not IsDev  => foreign_dev
                                               ,pRemoteEsp in ProdEsps and IsDev      => foreign_prod
                                               ,                                         ''
  );
  
end;