import bipv2,bipv2_files,BIPV2_ProxID,ut,salt26,tools,strata,bipv2_tools,wk_ut,std,tools;
EXPORT _Preprocess(
   dataset(layouts.orig_DOT_Base) pDataset          = BIPV2_Files.files_dotid().DS_BASE
  ,string                         pversion          = bipv2.KeySuffix  
  ,string                         pFilename         = BIPV2_Files.files_dotid().FILE_BASE  //should be the filename from the above dataset
  ,string                         pStrataBuildStep  = ''
  ,boolean                        pFilterMC         = false
  ,boolean                        pDoStrata         = BIPV2_ProxID._Constants().doStrata
  ,boolean                        pCopy2StorageThor = BIPV2_ProxID._Constants().copy2storagethor
) := 
function

  ds_slim           := project(pDataset,BIPV2_ProxID.layout_DOT_Base);
  ds_patch_proxids  := BIPV2_ProxID._fPatch_Proxids(ds_slim);
  ds_use            := if(pStrataBuildStep = 'Proxid' ,ds_patch_proxids ,ds_slim);

  // -- only use match candidates
  // ds_mc             := dataset('~temp::Proxid::BIPV2_ProxID::mc' ,recordof(BIPV2_ProxID.match_candidates(BIPV2_ProxID.in_DOT_Base).Annotated)  ,flat);
  // ds_get_only_mc    := join(ds_use ,table(ds_mc,{rcid}) ,left.rcid = right.rcid ,transform(left),hash);
  // -- only use match candidates
  
  // ds_out := if(pFilterMC = false ,ds_use  ,ds_get_only_mc);
  ds_out := ds_use;
  
  writefile   := tools.macf_writefile(BIPV2_ProxID.filenames(pversion).base.logical ,ds_out ,poverwrite := true ,pDescription := 'BIPV2_ProxID._Preprocess');
  promotefile := BIPV2_ProxID.promote(pversion).new2built;

  kick_copy2_storage_thor  := BIPV2_Tools.Copy2_Storage_Thor('~' + nothor(std.file.superfilecontents(pFilename)[1].name) ,pversion ,'proxid_preprocess');
  copy2StorageThor         := if(not wk_ut._constants.IsDev and pCopy2StorageThor = true,output(kick_copy2_storage_thor ,named('copy2_Storage_Thor__html')));  //copy orig file to storage thor

  return sequential(
     writefile
    ,if(pDoStrata = true  ,BIPV2_ProxID._PreProcess_Strata(BIPV2_ProxID.files(pversion).base.logical,tools.Get_Version(pversion),pStrataBuildStep)) 
    ,parallel(
       promotefile
    )
    ,copy2StorageThor
    // ,if(not wk_ut._constants.IsDev and pCopy2StorageThor = true,tools.Copy2_Storage_Thor(filename := '~' + nothor(std.file.superfilecontents(pFilename)[1].name)  ,pDeleteSourceFile  := true))  //copy orig file to storage thor
  );
  
end;
