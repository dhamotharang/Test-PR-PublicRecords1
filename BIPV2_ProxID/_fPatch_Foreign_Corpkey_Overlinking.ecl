import bipv2,bipv2_files,BIPV2_ProxID,ut,salt26,tools,strata,bipv2_tools,wk_ut,std,tools;
EXPORT _fPatch_Foreign_Corpkey_Overlinking(
   dataset(layout_DOT_Base) pDataset   // = BIPV2_Files.files_dotid.DS_BASE
  ,string                   pversion   = bipv2.KeySuffix  
  ,string                   pFilename  = BIPV2_Files.files_dotid().FILE_BASE  //should be the filename from the above dataset
) :=
function
writefile   := tools.macf_writefile(BIPV2_ProxID.filenames(pversion).base.logical,BIPV2_ProxID._fPatch_Proxids(pDataset),poverwrite := true,pDescription := 'Default zero Proxids to Dotids');
promotefile := BIPV2_ProxID.promote(pversion).new2built;
return sequential(
   writefile
  ,BIPV2_ProxID._PreProcess_Strata(,BIPV2_ProxID._fPatch_Proxids(pDataset),tools.Get_Version(pversion))
  ,parallel(
     promotefile
    // ,outputuniques
    // ,dotintegrity 
    // ,proxintegrity
  )
  ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := '~' + nothor(std.file.superfilecontents(pFilename)[1].name)  ,pDeleteSourceFile  := true))  //copy orig file to storage thor
);
end;
