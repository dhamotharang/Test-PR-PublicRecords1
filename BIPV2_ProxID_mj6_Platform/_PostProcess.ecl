import bipv2,BIPV2_ProxID,tools,wk_ut,std;

EXPORT _PostProcess(

   string                           pversion     = bipv2.KeySuffix   
  ,dataset(_layouts.DOT_Base_orig ) pDatasetIn   = BIPV2_Proxid.files().base.built
  ,dataset(layout_DOT_Base        ) pDatasetOut  = BIPV2_ProxID_mj6_PlatForm._files().base.built
  ,string                           pSuperfileIn = BIPV2_Proxid.filenames().base.built   

) :=
function
	
  ds_joinback := join(pDatasetIn,pDatasetOut,left.rcid = right.rcid,transform(recordof(left),self := right,self := left),keep(1),hash);
  
  writefile   := tools.macf_writefile(BIPV2_ProxID_mj6_PlatForm._filenames(pversion).out.logical  ,ds_joinback  ,poverwrite := true,pDescription := 'BIPV2_ProxID_mj6_PlatForm.Postprocess join back to common layout');
  promotefile := BIPV2_ProxID_mj6_PlatForm._promote(pversion,'out').new2built;
  
  copy2storagethor := if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := '~' + nothor(std.file.superfilecontents(pSuperfileIn)[1].name)  ,pDeleteSourceFile  := true));

  return sequential(
     writefile
    ,promotefile
    ,copy2storagethor
  );
  
end;