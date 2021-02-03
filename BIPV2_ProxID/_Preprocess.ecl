import bipv2,bipv2_files,BIPV2_ProxID,tools,bipv2_tools,wk_ut,std,mdr,corp2,paw,BIPV2_ForceLink,BIPV2_Field_Suppression;

lay_an_corpkeys := recordof(BIPV2_Files.tools_dotid().Solo_Assumed_Name_Corpkeys());

EXPORT _Preprocess(
   dataset(layouts.orig_DOT_Base                  )   pDataset          = BIPV2_Files.files_dotid().DS_BASE
  ,string                                             pversion          = bipv2.KeySuffix  
  ,string                                             pFilename         = BIPV2_Files.files_dotid().FILE_BASE  //should be the filename from the above dataset
  ,string                                             pStrataBuildStep  = ''
  ,boolean                                            pFilterMC         = false
  ,boolean                                            pDoStrata         = BIPV2_ProxID._Constants().doStrata
  ,boolean                                            pCopy2StorageThor = BIPV2_ProxID._Constants().copy2storagethor
  ,boolean                                            pPromoteFile      = true
) := 
function

  ds_slim           := project(pDataset,transform(BIPV2_ProxID.layout_DOT_Base 
    ,self.cnp_name_phonetic := left.cnp_name
    ,self.sbfe_id           := if(mdr.sourceTools.SourceIsBusiness_Credit(left.source) ,left.vl_id ,'')
    ,self.active_corp_key   := ''
    ,self.hist_corp_key     := ''
    ,self                   := left
  ));

  ds_pop_corpkeys := BIPV2_Tools.mac_Populate_Corpkeys(ds_slim);
  
  // -- Initialize zero proxids
  ds_patch_proxids    := BIPV2_Tools.initParentID(ds_pop_corpkeys,dotid,proxid) : persist('~persist::BIPV2_ProxID::_Preprocess::ds_patch_proxids');
  
  // -- patch Proxid underlinks outside of salt
  ds_patch_Underlinks := BIPV2_ForceLink.mac_ForceLink_Proxid(ds_patch_proxids);
  
  // -- Suppress & Explode overlinks
  ds_suppress := BIPV2_Field_Suppression.mac_Suppress(ds_patch_Underlinks);
  
  // -- only intialize zero proxids and patch underlinks once.  when called a second time in the process, skip that part.
  ds_use            := if(pStrataBuildStep = 'Proxid' ,ds_suppress ,ds_slim);

  // -- only use match candidates
  // ds_mc             := dataset('~temp::Proxid::BIPV2_ProxID::mc' ,recordof(BIPV2_ProxID.match_candidates(BIPV2_ProxID.in_DOT_Base).Annotated)  ,flat);
  // ds_get_only_mc    := join(ds_use ,table(ds_mc,{rcid}) ,left.rcid = right.rcid ,transform(left),hash);
  // -- only use match candidates
  
  // ds_out := if(pFilterMC = false ,ds_use  ,ds_get_only_mc);
  ds_out := project(ds_use  ,transform(recordof(left),self.company_inc_state := if(trim(left.active_corp_key) != '' ,left.company_inc_state ,'') ,self.company_charter_number := if(trim(left.active_corp_key) != '' ,left.company_charter_number ,'') ,self := left));
  
  writefile   := tools.macf_writefile(BIPV2_ProxID.filenames(pversion).base.logical ,ds_out ,poverwrite := true ,pDescription := 'BIPV2_ProxID._Preprocess');
  promotefile := BIPV2_ProxID.promote(pversion).new2built;

  kick_copy2_storage_thor  := BIPV2_Tools.Copy2_Storage_Thor('~' + nothor(std.file.superfilecontents(pFilename)[1].name) ,pversion ,'proxid_preprocess');
  copy2StorageThor         := if(not wk_ut._constants.IsDev and pCopy2StorageThor = true,output(kick_copy2_storage_thor ,named('copy2_Storage_Thor__html')));  //copy orig file to storage thor

  return sequential(
     writefile
    ,if(pStrataBuildStep = 'Proxid' ,BIPV2_Field_Suppression.Increment_Suppression_Counter()) // increment suppression file once.
    ,if(pDoStrata = true  ,BIPV2_ProxID._PreProcess_Strata(BIPV2_ProxID.files(pversion).base.logical,tools.Get_Version(pversion),pStrataBuildStep)) 
    ,if(pPromoteFile = true,
       promotefile
    )
    ,copy2StorageThor
  );
  
end;
