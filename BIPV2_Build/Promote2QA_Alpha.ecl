import bipv2;


// -- promote all files and keys to qa versions
export Promote2QA_Alpha(
   pversion          = 'Bipv2.KeySuffix'
  ,pPerformCleanup   = 'true'
  ,pShouldCheckKeys  = 'true'
) :=
functionmacro

  import bipv2_build,tools;

  email                 := BIPV2_Build.Send_Emails(pversion ,,not tools._constants.isdataland/* and pShouldUpdateDOPS*/);
  CheckAlphaKeys        := email.BIPV2AlphaKeys.Roxie;
  outputAlpha_keys      := BIPV2_Build.AlphaProdKeys_Package(pversion,false).outputpackage;
    
  return 
     sequential(
       outputAlpha_keys //check to make sure all keys are built and match the code first before promoting them to qa
      ,BIPV2_Build.Promote(pversion,'bizlinkfull').new2Built  //just in case they weren't added to built
      ,BIPV2_Build.Promote(,'bizlinkfull').Built2QA
      ,CheckAlphaKeys
      ,iff(pPerformCleanup = true  ,BIPV2_Build.Promote(,'bizlinkfull',pDelete := true).Cleanup  )
    );

endmacro;