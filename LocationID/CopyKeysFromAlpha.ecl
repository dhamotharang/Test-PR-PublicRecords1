import BIPV2,tools,BizLinkFull,wk_ut;

EXPORT CopyKeysFromAlpha(
   pversion             = ''
  ,pistesting           = 'false'
  ,pSkipSuperStuff      = 'true'
  ,pOverwrite           = 'true'
  ,pFilter 							= ''
  ,psuperversions       = '\'qa\'' //add them to these supers after copying
  ,pSrcDali             = '\'alpha_prod_thor_dali.risk.regn.net:7070\''
  ,pDestinationThor     = '\'thor400_dev\'' // thor400_dev for Boca Dev, thor400_36 for Boca Prod
) := functionmacro

  import BIPV2,tools,BizLinkFull,wk_ut,bipv2_build,BIPV2_Suppression;

  myfiles :=  LocationID.keynames(pversion).dall_filenames 
            + LocationID_xLink.keynames(pversion).dall_filenames 
            ;
  
	update_dopsV2  := dops.updateversion('LocationIDKeys',trim(pversion,left,right),LocationID_Build.email_list,,'N') : INDEPENDENT;
	orbitUpdate    := Orbit3.proc_Orbit3_CreateBuild('LocationIDKeys',trim(pversion,left,right),'N') : INDEPENDENT;	
	
  return sequential(

		tools.fun_CopyRename(
			 myfiles
			,true // pToDataland			 
			,[] //pReplaceSrcNames 
			,[] //pReplaceDestNames
			,pFilter					  
			,pSkipSuperStuff		
			,pOverwrite			  
			,true //pShouldCompress               
			,pDestinationThor	
			, //pRegexVersion			
			, //pDeleteSrcFiles
			, //pFileDescription
			,pIsTesting	
			,pSrcDali
		)
		 
		,tools.mod_PromoteBuild(
			 pversion
			,myfiles // pBuildFilenames
			,pFilter
			, // pDelete
			,pIsTesting
			,1 // pnGenerations
			, // pClearSuperFirst
			, // pOddFilename
			, // pMove2DeleteSuper
			, // pIncludeBuiltDelete
			, // pCleanupFilter
			, // pIsDeltaBuild
			, // pForceGenPromotion
		).new2qa

		,if(_Control.ThisEnvironment.Name = 'Prod_Thor',evaluate(update_dopsV2),output('Not a prod environment'))
	  ,if(_Control.ThisEnvironment.Name = 'Prod_Thor',evaluate(orbitUpdate),output('Not a prod environment'))

	); // end sequential

endmacro;
