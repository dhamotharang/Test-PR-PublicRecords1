EXPORT proc_Verify_Packages(

   string   pversion              = 'qa'
  ,boolean	pUseOtherEnvironment	= false

) := 
sequential(
   BIPV2FullKeys_Package  (pversion,pUseOtherEnvironment).outputpackage
  ,BIPV2WeeklyKeys_Package(pversion,pUseOtherEnvironment).outputpackage
);