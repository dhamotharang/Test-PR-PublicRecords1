import tools,BIPV2;

EXPORT Build_Clean_Commonbase(

   pversion   = 'BIPV2.KeySuffix'
  ,pBase      = 'BIPV2.CommonBase.Ds_Built'

) :=
functionmacro

  import tools,BIPV2,BIPV2_Strata;
  
  ds_clean := BIPV2.CommonBase.clean(pBase);
  
  output_file := tools.macf_WriteFile(BIPV2.Filenames(pversion).Clean_Common_Base.logical ,ds_clean ,pOverwrite := true);

  return sequential(
     output_file
    ,BIPV2_Build.Promote(pversion,,true/*delete*/,false,BIPV2.Filenames(pversion).Clean_Common_Base.dall_filenames,pIncludeBuiltDelete := true).new2built //cleans up after itself.  only need one version of this, the current version.  all others can be derived if needed.
    ,BIPV2_Strata.mac_Quick_Gold_Stats(pversion,pBase)
  );

endmacro;