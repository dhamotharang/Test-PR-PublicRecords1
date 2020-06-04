import bipv2;


// -- promote all files and keys to qa versions
export Promote2QA_Alpha(
   pversion          = 'Bipv2.KeySuffix'
  ,pPerformCleanup   = 'true'
  ,pShouldCheckKeys  = 'true'
) :=
functionmacro

  import bipv2_build,tools,BIPV2_Suppression;

  email                 := BIPV2_Build.Send_Emails(pversion ,,false); //don't try to update dops in alpharetta.  this package doesn't exist there
  CheckAlphaKeys        := email.BIPV2AlphaKeys.Roxie;
  outputAlpha_keys      := BIPV2_Build.AlphaProdKeys_Package(pversion,false).outputpackage;

  myfiles :=  BIPV2_Build.keynames(pversion).BIPV2FullKeys 
            + BIPV2_Build.keynames(pversion).BIPV2WeeklyKeys 
            + BIPV2_Suppression.FileNames.key_sele_prox_names(pversion).dall_filenames
            ;
    
  return 
     sequential(
       outputAlpha_keys //check to make sure all keys are built and match the code first before promoting them to qa
      ,BIPV2_Build.Promote(pversion ,'bizlinkfull',,,myfiles).new2Built  //just in case they weren't added to built
      ,BIPV2_Build.Promote(         ,'bizlinkfull',,,myfiles).Built2QA
      ,CheckAlphaKeys
      ,iff(pPerformCleanup = true  ,BIPV2_Build.Promote(,'bizlinkfull',true,,myfiles).Cleanup  )
    );

endmacro;