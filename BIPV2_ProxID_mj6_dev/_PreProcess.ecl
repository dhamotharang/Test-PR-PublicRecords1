import bipv2,BIPV2_ProxID,tools;

EXPORT _PreProcess(

   string pversion                           = bipv2.KeySuffix   
  ,dataset(_layouts.DOT_Base_orig) pDataset  = BIPV2_Proxid.files().base.built

) :=
function
	
  ds_Slim := project(pDataset,BIPV2_ProxID_mj6_dev.layout_DOT_Base);
  
  writefile   := tools.macf_writefile(BIPV2_ProxID_mj6_dev._filenames(pversion).base.logical,ds_Slim,poverwrite := true,pDescription := 'BIPV2_ProxID_mj6_dev.Preprocess slim down dataset');
  promotefile := BIPV2_ProxID_mj6_dev._promote(pversion).new2built;
  
  return sequential(
     writefile
    ,promotefile
  );
  
end;
