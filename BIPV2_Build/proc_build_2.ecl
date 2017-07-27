import BIPV2_Build, BIPV2_DotID, BIPV2_ProxID, BIPV2_Entity, bipv2, ut,BizLinkFull,tools;

export proc_build_2(

   pversion               
  //booleans to control what runs in the build.  These allow for fine control over build without sandboxing.
  ,pSkipXlink             = 'false'
  ,pSkipCopyXlinkKeys     = 'false'
  ,pSkipXlinkSample       = 'false'
  ,pSkipWeeklyKeys        = 'false'
  ,pSkipBest              = 'false'
  ,pSkipIndustry          = 'false'
  ,pSkipMisckeys          = 'false'
  ,pSkipSegStats          = 'false'
  ,pSkipStrata            = 'false'
  ,pSkipSeleidRelative    = 'false'
   
) := 
functionmacro
    
    import BIPV2_Build, BIPV2_DotID, BIPV2_ProxID, BIPV2_Entity, bipv2, ut,BizLinkFull,tools;

    // keyversion  := if(pPromote2QA  ,'qa','built');    
		email       := BIPV2_Build.Send_Emails(pversion ,,not tools._constants.isdataland);    
    // UpdateDops  := email.BIPV2FullKeys.Roxie;
        
		doit := sequential(

       output(pversion, named('Build_Date'))
      // ,BIPV2_Build.proc_Watch_This_Workunit (pversion,workunit) //watch this workunit, in case it fails in some weird way it will still email me.
      ,if(pSkipXlink         = false ,BIPV2_Build.proc_xlink                (pversion ,false      )                                                                                        )
      ,if(pSkipCopyXlinkKeys = false ,BIPV2_Build.proc_copy_keys            (pversion ,'bizlinkfull','bizlinkfull','Xlink'    )                                                            ) //needs to run before weekly keys because the newly built xlink keys need to be in the "built" supers on the cluster to be used by the weekly keys
      ,if(pSkipXlinkSample   = false ,BIPV2_Build.proc_Xlink_Sample         (pversion             )                                                                                        )
      ,if(pSkipWeeklyKeys    = false ,BIPV2_Build.proc_weekly_keys          (pversion ,false      )                                                                                        )
      ,if(pSkipBest          = false ,BIPV2_Build.proc_best                 (pversion ,false      )                                                                                        ) //when lgid3 added, run this after that
      ,if(pSkipIndustry      = false ,BIPV2_Build.proc_industry_license     (pversion             )                                                                                        )
      ,if(pSkipMisckeys      = false ,BIPV2_Build.proc_misc_keys            (pversion             )                                                                                        )
      ,if(pSkipSegStats      = false ,BIPV2_Build.proc_segmentation         (pversion             )                                                                                        )
      ,if(pSkipStrata        = false ,BIPV2_Build.proc_Strata               (pversion             )                                                                                        )
      // ,if(pSkipRelative      = false ,BIPV2_Build.proc_relative             (pversion ,,false     )                                                                                        )
      ,if(pSkipSeleidRelative= false ,BIPV2_Build.proc_Seleid_relatives     (pversion ,false      )                                                                                        )

    )  
		:	FAILURE(email.BIPV2FullKeys.buildfailure);
						
   return doit;
   
endmacro;
