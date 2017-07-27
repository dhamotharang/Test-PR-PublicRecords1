import BIPV2_Build, BIPV2_DotID, BIPV2_ProxID, BIPV2_Entity, bipv2, ut,BizLinkFull,tools;

export proc_Build_PostProcess(

   pversion               
  //booleans to control what runs in the build.  These allow for fine control over build without sandboxing.
  ,pSkipDOTSpecsPost      = 'false'
  ,pSkipSeleRelSpecsPost  = 'false'
   
) := 
functionmacro
    
    import BIPV2_Build, BIPV2_DotID, BIPV2_ProxID, BIPV2_Entity, bipv2, ut,BizLinkFull,tools;

		email       := BIPV2_Build.Send_Emails(pversion ,,not tools._constants.isdataland);    
        
		doit := sequential(

       output(pversion, named('Build_Date'))
      ,if(pSkipDOTSpecsPost     = false ,BIPV2_Build.proc_dotid().runSpecs()                                )
      ,if(pSkipSeleRelSpecsPost = false ,BIPV2_Build.proc_Seleid_relatives(pversion,true,false,false       )) 

    )  
		:	FAILURE(email.BIPV2FullKeys.buildfailure);
						
   return doit;
   
endmacro;
