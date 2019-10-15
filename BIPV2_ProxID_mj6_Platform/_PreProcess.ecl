import bipv2,BIPV2_ProxID,tools,wk_ut,std;

EXPORT _PreProcess(

   string                           pversion      = bipv2.KeySuffix   
  ,string                           pDotFilename  = BIPV2_Proxid.filenames().base.built
  ,dataset(_layouts.DOT_Base_orig)  pDataset      = BIPV2_Proxid.files().base.built


) :=
function
	
  pre := if(pDotFilename != '',BIPV2_ProxID_mj6_PlatForm._Promote(,'base',pOddFilename := pDotFilename).odd2built);

  ds_Slim := project(pDataset,BIPV2_ProxID_mj6_PlatForm.layout_DOT_Base);
  
  writefile   := tools.macf_writefile(BIPV2_ProxID_mj6_PlatForm._filenames(pversion).base.logical,ds_Slim,poverwrite := true,pDescription := 'BIPV2_ProxID_mj6_PlatForm.Preprocess slim down dataset');
  promotefile := BIPV2_ProxID_mj6_PlatForm._promote(pversion).new2built;
  
  return sequential(
     pre
    ,BIPV2_ProxID_mj6_PlatForm._PreProcess_Strata(pDataset,pversion)
    ,writefile
    ,promotefile
    ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := '~' + nothor(std.file.superfilecontents(pDotFilename)[1].name)  ,pDeleteSourceFile  := true))  //copy orig file to storage thor
  );
  
end;
