import _control,tools;
export _Constants :=
module

  // ----------------------------------------------------------------------------------------
  // -- this should be changed to match your environments(1 prod, 1 dev environment assumed)
  // ----------------------------------------------------------------------------------------
  export prod_name          := 'Prod_Thor'                        ;
  export dev_name           := 'Dataland'                         ;

  export prod_dali          := 'prod_dali.br.seisint.com'         ;
  export dev_dali           := '10.241.12.201'                    ;

  export prod_hthor         := 'hthor'                            ;
  export dev_hthor          := 'hthor_dev'                        ;

  export ProdEsps           := ['10.173.84.202' ,'prod_esp.br.seisint.com' ,'10.173.85.202','10.241.20.202','10.241.30.202','10.173.84.205' ];
  export DevEsps            := ['10.241.12.207' ,'10.241.12.207'           ,'10.241.12.204'                                                 ];  
  
  export emailSender        := 'eclsystem@seisint.com'            ;
  export MailServer         := 'mailout.br.seisint.com'           ;
  export MailPort           := 25                                 ;
  export emailAddressNotify := _control.MyInfo.EmailAddressNotify ;

  export Groupname          := tools.fun_Groupname                ;  //this is a function to make it easier to get the groupname for different thors

 
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
  
/*  (
    
     string		pHint					= ''
    ,boolean	pForMacroUse	= false 
    
  ) :=
  function

    returnstring :=
    map( _Control.ThisEnvironment.name	 = 'Alpha_Dev' =>	
        map( pHint = '11'			  => if(not pForMacroUse	,'thor11'			              ,'\'thor11\''			            ) 
            ,pHint = '11_ctqa'	=> if(not pForMacroUse	,'thor11_ctqa'		          ,'\'thor11_ctqa\''		        )
            ,pHint = '11_prod'	=> if(not pForMacroUse	,'thor11_prod'              ,'\'thor11_prod\''	          )
            ,pHint = '11_scrub'	=> if(not pForMacroUse	,'thor11_scrub'	            ,'\'thor11_scrub\''	          )
            ,pHint = '11_test'  => if(not pForMacroUse	,'thor11_test_mysql_vip'		,'\'thor11_test_mysql_vip\''	)
            ,pHint = '21'		    => if(not pForMacroUse	,'thor21'	                  ,'\'thor21\''	                )
            ,pHint = '21_ctqa'	=> if(not pForMacroUse	,'thor21_ctqa'	            ,'\'thor21_ctqa\''	          )
            ,pHint = '21_prod'	=> if(not pForMacroUse	,'thor21_prod'	            ,'\'thor21_prod\''	          )
            ,pHint = '64'		    => if(not pForMacroUse	,'thor400_64_linking'	      ,'\'thor400_64_linking\''	    )
            ,pHint = '64_prod'	=> if(not pForMacroUse	,'thor400_64_prod_linking'	,'\'thor400_64_prod_linking\'')
            ,pHint = '72'		    => if(not pForMacroUse	,'thor400_72'	              ,'\'thor400_72\''	            )
            ,pHint = '72_ctqa'	=> if(not pForMacroUse	,'thor400_72_ctqa'	        ,'\'thor400_72_ctqa\''	      )
            ,pHint = '72_prod'	=> if(not pForMacroUse	,'thor400_72_prod'	        ,'\'thor400_72_prod\''	      )
            ,pHint = '50' 		  => if(not pForMacroUse	,'thor50_42'	              ,'\'thor50_42\''	            )
            ,										   if(not pForMacroUse	,'thor400_72'	              ,'\'thor400_72\''	            )
        )
      ,map( 
             pHint = '20'			          => if(not pForMacroUse	,'thor20_92_scrub'			    ,'\'thor20_92_scrub\''			  )																												
            ,pHint = '100_80_fcra'			=> if(not pForMacroUse	,'thor100_80_fcra'			    ,'\'thor100_80_fcra\''			  )
            ,pHint = '100_80_fcra_dev'	=> if(not pForMacroUse	,'thor100_80_fcra_dev'			,'\'thor100_80_fcra_dev\''		)																												
            ,pHint = '100_84_fcra'			=> if(not pForMacroUse	,'thor100_84_fcra'			    ,'\'thor100_84_fcra\''			  )																												
            ,pHint = '100_84_fcra_dev'	=> if(not pForMacroUse	,'thor100_84_fcra_dev'			,'\'thor100_84_fcra_dev\''		)																												
            ,pHint = '100_96'			    	=> if(not pForMacroUse	,'thor100_96'			          ,'\'thor100_96\''			        )																												
            ,pHint = '100_96b'			  	=> if(not pForMacroUse	,'thor100_96b'			        ,'\'thor100_96b\''			      )		
            ,pHint = '100_96_dev'				=> if(not pForMacroUse	,'thor100_96_dev'			      ,'\'thor100_96_dev\''			    )																												
            ,pHint = '100_96_qa'				=> if(not pForMacroUse	,'thor100_96_qa'			      ,'\'thor100_96_qa\''			    )																												
            ,pHint = '100_166_fcra'			=> if(not pForMacroUse	,'thor100_166_fcra'			    ,'\'thor100_166_fcra\''			  ) 																												
            ,pHint = '100_166_fcra_dev'	=> if(not pForMacroUse	,'thor100_166_fcra_dev'			,'\'thor100_166_fcra_dev\''		)	
            ,pHint = '400_198_a'				=> if(not pForMacroUse	,'thor400_198_a'			      ,'\'thor400_198_a\''			    )																												
            ,pHint = '400_198_linking'	=> if(not pForMacroUse	,'thor400_198_linking'			,'\'thor400_198_linking\''		)																												
            
            ,										           if(not pForMacroUse	,'thor400_198_linking'      ,'\'thor400_198_linking\''		)
        )
    );
                                                                              

    return returnstring;
        
  end;
  */
end;
