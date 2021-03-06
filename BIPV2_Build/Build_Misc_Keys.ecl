import BIPV2, tools,riskwise,BIPV2_Company_Names,Address_Attributes;

EXPORT build_misc_keys(

   string   pversion
  ,boolean  pPromote2QA = true
  
) :=
module

  export BuildLinkIds       := tools.macf_writeindex('BIPV2.Key_BH_Linking_Ids.key              ,keynames(pversion).linkids.new'      );
  export BuildTranslations  := tools.macf_writeindex('BIPV2_Company_Names.files.TranslationsKey ,keynames(pversion).translations.new' );
  export BuildAML_Addr      := tools.macf_writeindex('Address_Attributes.key_AML_addr           ,keynames(pversion).aml_addr.new'     );
  export BuildStatus        := tools.macf_writeindex('BIPV2.key_Status.lkey(pversion).new'                                            );
  export BuildZipCitySt     := tools.macf_writeindex('keys(pversion).zipcityst.new'                                                   );
  
  shared keyfilt        := 'zipcityst|translations|business_header::.*?::linkids|status|bipv2_aml_addr';  //only promote these keys

  export promote2built  := promote(pversion,keyfilt).new2built;
  
  semail := Send_Emails(pversion,pBuildName := 'BIPV2 Build Misc Keys').BIPV2FullKeys;

  export buildall := 
  sequential(
     parallel(
       BuildLinkIds     
      ,BuildTranslations
      ,BuildAML_Addr    
      ,BuildStatus      
      ,BuildZipCitySt       
     )
    ,promote2built
    ,if(pPromote2QA = true  ,Promote(pversion,keyfilt).Built2QA)
    ,semail.BuildSuccess
  ) : failure(semail.BuildFailure)
  ;

end;

/*
Vern,

In sprint 13, I want to release a new index.  The ECL is in BIPV2.key_Status.

The build takes 5 minutes.  http://10.241.3.240:8010/?inner=../WsWorkunits/WUInfo%3FWuid%3DW20140301-075850 

Can you please:
Update the logical name to match our standard?
Add the index build to the BIP build?

Thanks,
Chad


https://bugzilla.seisint.com/show_bug.cgi?id=146880

*/