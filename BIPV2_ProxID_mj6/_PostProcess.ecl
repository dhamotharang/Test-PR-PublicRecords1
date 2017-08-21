import bipv2,BIPV2_ProxID,tools,wk_ut,std,BIPV2_Tools;

EXPORT _PostProcess(

   string                           pversion     = bipv2.KeySuffix   
  ,dataset(_layouts.DOT_Base_orig ) pDatasetIn   = BIPV2_Proxid.files().out.built
  ,dataset(layout_DOT_Base        ) pDatasetOut  = BIPV2_ProxID_mj6._files().base.built
  ,string                           pSuperfileIn = BIPV2_Proxid.filenames().out.built   

) :=
function
	
  ds_joinback := join(pDatasetIn,table(pDatasetOut,{rcid,dotid,proxid,lgid3,orgid,ultid}),left.rcid = right.rcid,transform(recordof(left),self := right,self := left),keep(1),hash);
  
  writefile   := tools.macf_writefile(BIPV2_ProxID_mj6._filenames(pversion).out.logical  ,ds_joinback  ,poverwrite := true,pDescription := 'BIPV2_ProxID_mj6.Postprocess join back to common layout');
  promotefile := BIPV2_ProxID_mj6._promote(pversion,'out').new2built;
  
  kick_copy2_storage_thor  := BIPV2_Tools.Copy2_Storage_Thor('~' + nothor(std.file.superfilecontents(pSuperfileIn)[1].name) ,pversion ,'proxid_mj6_postprocess');
  copy2StorageThor         := if(not wk_ut._constants.IsDev,output(kick_copy2_storage_thor ,named('copy2_Storage_Thor__html')));  //copy orig file to storage thor

  // copy2storagethor := if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := '~' + nothor(std.file.superfilecontents(pSuperfileIn)[1].name)  ,pDeleteSourceFile  := true));

  return sequential(
     writefile
    ,promotefile
    ,copy2storagethor
  );
  
end;