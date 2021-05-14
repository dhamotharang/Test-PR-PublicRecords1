import BIPV2, tools,riskwise,BIPV2_Company_Names,Address_Attributes, BIPV2_Segmentation,BIPV2_Statuses,BIPV2_PostProcess, BIPV2_Best;
import dx_BIPV2;

EXPORT build_misc_keys(

   string                           pversion
  ,boolean                          pPromote2QA       = true
  ,dataset(bipv2.commonbase.layout) pDs_Clean         = BIPV2.CommonBase.DS_Clean
  ,string                           pversion_current  = BIPV2.KeySuffix   // this has to be a real date.  used to date compare against for segmentation
                                                                          // so if the above pversion has other extra stuff, 20200624a_xxxx, make sure this date is a real date
) :=
module

	shared SegKeyLayout     := record
	     BIPV2_Segmentation.Layouts.SegmentationLayout.seleid;
	     BIPV2_Segmentation.Layouts.SegmentationLayout.category;
	     BIPV2_Segmentation.Layouts.SegmentationLayout.subcategory;
	end;

	shared headerRecs     := BIPV2_Statuses.mac_Calculate_Gold(pDs_Clean);
	shared header_clean   := distribute(headerRecs, hash32(seleid));
	shared seg            := project(BIPV2_PostProcess.segmentation_category.perSeleid(header_clean, pversion_current ,true), SegKeyLayout);

  export BuildLinkIds       := tools.macf_writeindex('BIPV2.Key_BH_Linking_Ids.key                 ,keynames(pversion).linkids.new'                        );
  export BuildLinkIds_hidden:= tools.macf_writeindex('BIPV2.Key_BH_Linking_Ids.Key_hidden          ,keynames(pversion).linkids_hidden.new'                 );
  export BuildTranslations  := tools.macf_writeindex('BIPV2_Company_Names.files.TranslationsKey    ,keynames(pversion).translations.new'                   );
  export BuildAML_Addr      := tools.macf_writeindex('Address_Attributes.key_AML_addr              ,keynames(pversion).aml_addr.new'                       );
  export BuildStatus        := tools.macf_writeindex('BIPV2.key_Status.lkey(pversion).new'                                                                 );
  export BuildZipCitySt     := tools.macf_writeindex('keys(pversion).zipcityst.new'                                                                        );
  export BuildSegKey        := tools.macf_writeindex('BIPV2_Segmentation.Key_LinkIds(pversion).Key ,seg ,BIPV2_Segmentation.keynames(pversion).seg_linkids.new' );

  export BuildFirmoKey      := tools.macf_writeindex('dx_BIPV2.key_FirmographicsScore.Key, BIPV2_Best.In_FirmographicsScore, dx_BIPV2.Keynames(pVersion).FirmographicsScore.new');
  export BuildLocid         := tools.macf_writeindex('dx_BIPV2.key_Locid.Key, BIPV2.In_Locid(), dx_BIPV2.Keynames(pVersion).Locid.new');

  shared keyfilt        := 'zipcityst|translations|business_header::.*?::linkids|status|bipv2_aml_addr|segmentation_linkids|locid|firmo';  //only promote these keys

  export promote2built  := promote(pversion,keyfilt).new2built;
  
  semail := Send_Emails(pversion,pBuildName := 'BIPV2 Build Misc Keys').BIPV2FullKeys;

  export buildall := 
  sequential(
     parallel(
       BuildLinkIds     
			,BuildLinkIds_hidden
      ,BuildTranslations
      ,BuildAML_Addr    
      ,BuildStatus      
      ,BuildZipCitySt       
      ,BuildSegKey       
      ,BuildLocid
      ,BuildFirmoKey
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