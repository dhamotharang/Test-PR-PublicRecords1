import business_header, ut, tools, lib_fileservices, _control,bipv2;

export Copy_BIPV2FullKeys(
 
	 string		                                      pversion								                              // version date of files to copy
  ,string                                         psuperversions    = 'built'                           //add them to these supers after copying
	,boolean	                                      pToDataland			  = true	                            // Copying to Dataland, from prod?  If copying prod to prod, use true, dataland to dataland, use false
  ,set of string                                  pReplaceSrcNames  = []                                // first item, find string, second replacement string (for source logical names)                                     
  ,set of string                                  pReplaceDestNames = []                                // first item, find string, second replacement string (for destination names(logical and super))                                     
	,string		                                      pFilter					  = ''	                              // regex to filter the files to be copied			
	,boolean	                                      pSkipSuperStuff		= false	                            // If true, don't add to superfiles.  if false, add to supers
	,boolean	                                      pOverwrite			  = false	                            // Should Overwrite existing files?
	,boolean	                                      pShouldCompress   = true	                            // Should Compress Files?		
	,dataset(tools.Layout_FilenameVersions.builds)	pFiles            = keynames(pversion).BIPV2FullKeys + keynames(pversion).BIPV2WeeklyKeys + BIPV2.Filenames(pversion).Common_Base.dall_filenames
	,string		                                      pdestinationgroup	= if(Tools._Constants.isdataland = false,tools.fun_Clustername_DFU('66')  ,tools.fun_Clustername_DFU(''))
	,string		                                      pRegexVersion			= '^(.*?_'+ psuperversions + '|.*?::' + psuperversions + '::.*)$'					
	,boolean	                                      pDeleteSrcFiles		= false	                            // If true, delete source logical files.  False = Do not
	,boolean	                                      pIsTesting			  = true	                            // If true, just output dataset of what to do, false actually copy the files

) :=

tools.fun_CopyRename(
   pFiles
  ,pToDataland			 
  ,pReplaceSrcNames 
  ,pReplaceDestNames
  ,pFilter					  
  ,pSkipSuperStuff		
  ,pOverwrite			  
  ,pShouldCompress               
  ,pdestinationgroup	
  ,pRegexVersion			
  ,pDeleteSrcFiles
  ,
  ,pIsTesting			  
);
