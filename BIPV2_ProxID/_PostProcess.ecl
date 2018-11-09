import bipv2,BIPV2_ProxID,tools,wk_ut,std,BIPV2_ProxID_mj6,BIPV2_Files,BIPV2_Tools;

EXPORT _PostProcess(

   string                           pversion          = bipv2.KeySuffix   
  ,dataset(layouts.orig_DOT_Base  ) pDatasetIn        = BIPV2_Files.files_dotid().DS_BASE  //BIPV2_ProxID_mj6._files().out.built
  ,string                           pSuperfileIn      = BIPV2_Files.files_dotid().FILE_BASE//BIPV2_ProxID_mj6._filenames().out.built   
  ,dataset(layout_DOT_Base        ) pDatasetOut       = BIPV2_ProxID.files().base.built    
  ,boolean                          pCopy2StorageThor = BIPV2_ProxID._Constants().copy2storagethor

) :=
function

  ds_joinback := join(pDatasetIn,table(pDatasetOut,{rcid,dotid,proxid,lgid3,orgid,ultid}),left.rcid = right.rcid,transform(recordof(left),self := right,self := left),keep(1),hash);
  
  writefile   := tools.macf_writefile(BIPV2_ProxID.filenames(pversion).out.logical  ,ds_joinback  ,poverwrite := true,pDescription := 'BIPV2_ProxID._PostProcess join back to common layout');
  promotefile := BIPV2_ProxID.promote(pversion,'out').new2built;
  
  kick_copy2_storage_thor  := BIPV2_Tools.Copy2_Storage_Thor('~' + nothor(std.file.superfilecontents(pSuperfileIn)[1].name) ,pversion ,'proxid_postprocess');
  copy2StorageThor         := if(not wk_ut._constants.IsDev and pCopy2StorageThor = true,output(kick_copy2_storage_thor ,named('copy2_Storage_Thor__html')));  //copy orig file to storage thor

  // copy2storagethor := if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := '~' + nothor(std.file.superfilecontents(pSuperfileIn)[1].name)  ,pDeleteSourceFile  := true));

  return sequential(
     writefile
    ,promotefile
    ,copy2StorageThor
  );
  
end;