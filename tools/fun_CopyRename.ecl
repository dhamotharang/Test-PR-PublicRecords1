/*
  fun_CopyRename: allows you to copy files within an environment, or across environments.  Key thing is, it allows you to rename the file(s) so they don't have to be the same name as the source file
                  especially important within an environment.
  always run on destination environment.  So if copy to dataland from prod, run on dataland

*/
import business_header, ut, tools, lib_fileservices, _control;

export fun_CopyRename(
 
	 dataset(tools.Layout_FilenameVersions.builds)	pFiles                                                                  // keynames(pversion).dAll_filenames
	,boolean	                                      pToDataland			  = true	                                              // Copying to Dataland, from prod?  If copying prod to prod, use true, dataland to dataland, use false
  ,set of string                                  pReplaceSrcNames  = []                                                  // first item, find string, second replacement string (for source logical names)                                     
  ,set of string                                  pReplaceDestNames = []                                                  // first item, find string, second replacement string (for destination names(logical and super))    
	,string		                                      pFilter					  = ''	                                                // regex to filter the files to be copied			
	,boolean	                                      pSkipSuperStuff		= false	                                              // If true, don't add to superfiles.  if false, add to supers
	,boolean	                                      pOverwrite			  = false	                                              // Should Overwrite existing files?
	,boolean	                                      pShouldCompress   = true	                                              // Should Compress Files?		
	,string		                                      pdestinationgroup	= tools.fun_Groupname('40')                           // destination group/cluster for files
	,string		                                      pRegexVersion			= '^(.*?_[qQ][aA]|.*?::qa::.*)$'		                  // regex to filter for the version of the superfiles to add to			
	,boolean	                                      pDeleteSrcFiles		= false	                                              // If true, delete source logical files.  False = Do not
  ,string                                         pFileDescription  = workunit                                            // set the destination files' descriptions to this
	,boolean	                                      pIsTesting			  = true	                                              // If true, just output dataset of what to do, false actually copy the files
  ,string                                         pSrcDali          = if(pToDataland	, 'prod_dali.br.seisint.com:7070'              //_Control.IPAddress.prod_thor_dali this didn't work
                                                                                      , _Control.IPAddress.dataland_dali
                                                                      )                          
  ,integer                                        ptransferbuffersize   = 100000000
  ,integer                                        pMaxConnections       = 400

) :=
function

	all_files_to_copy := pFiles ;
						
	filter		:= if(pFilter = ''	,true
																,regexfind(pFilter,all_files_to_copy.templatename,nocase)
							);
	
	tools.Layout_fun_CopyFiles.Input tgetsuperfiles(tools.Layout_FilenameVersions.builds l) :=
	transform
	
		self.srclogicalname					:= if(count(pReplaceSrcNames  ) = 2 ,regexreplace(pReplaceSrcNames[1] ,l.logicalname,pReplaceSrcNames[2]  ,nocase)  ,l.logicalname);
		self.destinationgroup 			:= pdestinationgroup;
		self.destinationlogicalname	:= if(count(pReplaceDestNames ) = 2 ,regexreplace(pReplaceDestNames[1],l.logicalname,pReplaceDestNames[2] ,nocase)  ,l.logicalname);	
		self.srcdali								:= pSrcDali;
		self.dSuperfilenames				:= project(l.dSuperfiles(regexfind(pRegexVersion, name)) ,transform(tools.Layout_Names,self.name := if(count(pReplaceDestNames) = 2 ,regexreplace(pReplaceDestNames[1],left.name,pReplaceDestNames[2],nocase)  ,left.name)));
																	
	end;
	
	passtofunction := project(all_files_to_copy(filter), tgetsuperfiles(left));
	
	whattodo := tools.fun_CopyFiles(passtofunction,,pIsTesting,pShouldCompress,pOverwrite,pDeleteSrcFiles,pSkipSuperStuff,pFileDescription,ptransferbuffersize,pMaxConnections);
	
	return whattodo;

end;
