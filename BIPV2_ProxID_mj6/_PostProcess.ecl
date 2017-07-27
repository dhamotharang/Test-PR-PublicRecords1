import bipv2,BIPV2_ProxID,tools;

EXPORT _PostProcess(

   string                           pversion    = bipv2.KeySuffix   
  ,dataset(_layouts.DOT_Base_orig ) pDatasetIn  = BIPV2_Proxid.files().base.built
  ,dataset(layout_DOT_Base        ) pDatasetOut = BIPV2_ProxID_mj6._files().base.built

) :=
function
	
  ds_joinback := join(pDatasetIn,pDatasetOut,left.rcid = right.rcid,transform(recordof(left),self := right,self := left),keep(1),hash);
  
  writefile   := tools.macf_writefile(BIPV2_ProxID_mj6._filenames(pversion).out.logical  ,ds_joinback  ,poverwrite := true,pDescription := 'BIPV2_ProxID_mj6.Postprocess join back to common layout');
  promotefile := BIPV2_ProxID_mj6._promote(pversion,'out').new2built;
  
  return sequential(
     writefile
    ,promotefile
  );
  
end;