EXPORT Copy_Suppression_DID_To_AlphaProd(
  pversion             
  ,pistesting           = 'false'
  ,pSkipSuperStuff      = 'true'
  ,pOverwrite           = 'false'    
  ,pSrcDali             = '\'uspr-prod-thor-dali.risk.regn.net:7070\''
  // ,pDestinationThor     = '\'thor400_112\'') := FUNCTIONMACRO
  ,pDestinationThor     = '\'thor400_198\'') := FUNCTIONMACRO
  IMPORT STD ;

  pToDataland	:= false;		 
  pReplaceSrcNames := [];
  pReplaceDestNames := [];
  pFilter := '';
  pShouldCompress := true;
  // environment := STD.Str.ToUpperCase(_Control.ThisEnvironment.Name);
  // pdestinationgroup := IF(environment = 'ALPHA_DEV', 'thor400_198', 'thor400_112');
  pRegexVersion :=  ''; 
  pDeleteSrcFiles := false;  

  prefix := '~thor_data400::key::suppression';
  suffix := 'link_type_did';
  pFiles := tools.mod_FilenamesBuild(prefix + '::@version@::' + suffix,pversion).dall_filenames;

  copyKey := tools.fun_CopyRename(
   pFiles
  ,pToDataland			 
  ,pReplaceSrcNames 
  ,pReplaceDestNames
  ,pFilter					  
  ,pSkipSuperStuff		
  ,pOverwrite			  
  ,pShouldCompress               
  ,pDestinationThor	
  ,pRegexVersion			
  ,pDeleteSrcFiles
  ,
  ,pIsTesting	
  ,pSrcDali
);

  boolean							pDelete					    := 	false;
	boolean              pMove2DeleteSuper   := false; //used for when moving a logical file into the built superfile(mod_Promote.fNew2Built). will place previous logical file into delete superfile.
  boolean              pIncludeBuiltDelete := false;
	string								pCleanupFilter			:= '';
	unsigned1            pnGenerations			  := 3;
  promoteMod := tools.mod_PromoteBuild(pversion,pFiles,pFilter,pDelete,pIsTesting,pnGenerations,,,pMove2DeleteSuper,pIncludeBuiltDelete,pCleanupFilter);
    
  /* Promote */
  key_qa        := prefix + '::' + 'qa' + '::' + suffix;	
  key_father    := prefix + '::' + 'father' + '::' + suffix;	
  key_grandfather  := prefix + '::' + 'grandfather' + '::' + suffix;	
  
  return sequential(    
    copyKey,
    // IF (NOT pIsTesting, 
    // IF( NOT STD.File.SuperFileExists(key_qa),
    //   STD.File.CreateSuperFile(key_qa)));
    // IF (NOT pIsTesting, IF( NOT STD.File.SuperFileExists(key_father),
	  //   STD.File.CreateSuperFile(key_father)));
    // IF (NOT pIsTesting, IF( NOT STD.File.SuperFileExists(key_grandfather),
	  //   STD.File.CreateSuperFile(key_grandfather)));
    // IF (NOT pIsTesting, STD.File.PromoteSuperFileList([key_qa, key_father, key_grandfather], pFiles[1].logicalname, true));
     
	  promoteMod.new2built;
    promoteMod.built2qa;
    output('copy key'), 
    output('promote to dops')
  );
  
ENDMACRO;