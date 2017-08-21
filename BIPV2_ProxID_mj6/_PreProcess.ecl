import bipv2,BIPV2_ProxID,tools,wk_ut,std;

EXPORT _PreProcess(

   string                           pversion      = bipv2.KeySuffix   
  ,string                           pDotFilename  = BIPV2_Proxid.filenames().out.built
  ,dataset(_layouts.DOT_Base_orig)  pDataset      = BIPV2_Proxid.files().out.built


) :=
function
	
  pre := if(pDotFilename != '',BIPV2_ProxID_mj6._Promote(,'base',pOddFilename := pDotFilename).odd2built);

  ds_Slim := project(pDataset,BIPV2_ProxID_mj6.layout_DOT_Base);
  
  writefile   := tools.macf_writefile(BIPV2_ProxID_mj6._filenames(pversion).base.logical,ds_Slim,poverwrite := true,pDescription := 'BIPV2_ProxID_mj6.Preprocess slim down dataset');
  promotefile := BIPV2_ProxID_mj6._promote(pversion).new2built;
  
  return sequential(
     pre
    ,BIPV2_ProxID_mj6._PreProcess_Strata(pDataset,pversion)
    ,writefile
    ,promotefile
    // ,if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := '~' + nothor(std.file.superfilecontents(pDotFilename)[1].name)  ,pDeleteSourceFile  := true))  //copy orig file to storage thor
  );
  
end;
