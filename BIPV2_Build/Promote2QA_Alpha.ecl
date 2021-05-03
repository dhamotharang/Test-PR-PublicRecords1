import bipv2;


// -- promote all files and keys to qa versions
// -- only keep 1 version of the keys in alpharetta(pnGenerations := 1 in the promote call at the bottom of this attribute).
export Promote2QA_Alpha(
   pversion             = 'Bipv2.KeySuffix'
  ,pPerformCleanup      = 'true'
  ,pShouldCheckKeys     = 'true'
  ,pShouldUpdateDOPS    = 'true'
  ,pkeyfilter2AlphaProd = '\'(bizlinkfull|segmentation_linkids|seleprox|bipv2_best|contact_title_linkids|strnbrname|zipcityst|strnbrname)\''              // copy everything in BIPV2FullKeys package
) :=
functionmacro

  import bipv2_build,tools,BIPV2_Suppression,std;

  suppresssuper := std.file.superfilecontents(BIPV2_Suppression.FileNames.Keyseleprox)[1].name ;
  suppressversion := nothor(regexfind('[[:digit:]]{8}[[:alpha:]]?',suppresssuper,0));

  email                           := BIPV2_Build.Send_Emails(pversion         ,,pShouldUpdateDOPS); //don't try to update dops in alpharetta.  this package doesn't exist there
  email_Suppression               := BIPV2_Build.Send_Emails(suppressversion  ,,pShouldUpdateDOPS); //don't try to update dops in alpharetta.  this package doesn't exist there

  CheckBIPV2FullKeys_Alpha        := email            .BIPV2FullKeys_Alpha       .Roxie;
  CheckBIPV2SuppressionKeys_Alpha := email_Suppression.BIPV2SuppressionKeys_Alpha.Roxie;

  outputAlpha_keys      := BIPV2_Build.AlphaProdKeys_Package(suppressversion,pversion,false).outputpackage;

  myfiles :=(  BIPV2_Build.keynames(pversion        ).BIPV2FullKeys_Alpha 
             + BIPV2_Build.keynames(suppressversion ).BIPV2SuppressionKeys_Alpha
            )
            (~regexfind('ext_data',logicalname,nocase)) //remove external xlink keys because they are not in this package
            ;
  
  myfiles_suppress := BIPV2_Build.keynames(suppressversion).BIPV2SuppressionKeys_Alpha
            ;

  
  Update_Orbit_BIPV2FullKeys_Alpha        := email            .BIPV2FullKeys_Alpha       .updateOrbit;
  Update_Orbit_BIPV2SuppressionKeys_Alpha := email_Suppression.BIPV2SuppressionKeys_Alpha.updateOrbit;

  
  return 
     sequential(
       outputAlpha_keys //check to make sure all keys are built and match the code first before promoting them to qa
      ,BIPV2_Build.Promote(pversion         ,pkeyfilter2AlphaProd   ,,,myfiles          ).new2Built  //just in case they weren't added to built
      ,BIPV2_Build.Promote(suppressversion  ,                       ,,,myfiles_suppress ).new2Built  //just in case they weren't added to built
      ,BIPV2_Build.Promote(                 ,pkeyfilter2AlphaProd   ,,,myfiles          ,pnGenerations := 1).built2qa
      ,CheckBIPV2FullKeys_Alpha
      ,CheckBIPV2SuppressionKeys_Alpha
      ,Update_Orbit_BIPV2FullKeys_Alpha       
      ,Update_Orbit_BIPV2SuppressionKeys_Alpha
      ,iff(pPerformCleanup = true  ,BIPV2_Build.Promote(,pkeyfilter2AlphaProd,true,,myfiles,pnGenerations := 1).Cleanup  )
    );

endmacro;