import bipv2,bipv2_files,BIPV2_ProxID_mj6,ut,salt26,tools,strata,bipv2_tools;
EXPORT _fPatch_Foreign_Corpkey_Overlinking(
  dataset(layout_DOT_Base) pDataset   // = BIPV2_Files.files_dotid.DS_BASE
  ,string pversion                    = bipv2.KeySuffix   
) :=
function

writefile   := tools.macf_writefile(BIPV2_ProxID_mj6.filenames(pversion).base.logical,BIPV2_ProxID_mj6._fPatch_Proxids(pDataset),poverwrite := true,pDescription := 'Default zero Proxids to Dotids');
promotefile := BIPV2_ProxID_mj6.promote(pversion).new2built;
return sequential(
   writefile
  ,parallel(
     promotefile
    // ,outputuniques
    // ,dotintegrity 
    // ,proxintegrity
  )
);
end;
