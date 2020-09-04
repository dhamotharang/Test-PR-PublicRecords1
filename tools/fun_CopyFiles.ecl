////////////////////////////////////////////////////////////////////////////////////////////////
// -- fun_CopyFiles() function
// --
// -- Example of copying one file from production to dataland
// -- Run it on the destination server
// --
// -- FilesToCopy := DATASET([
// -- 
// -- { '~thor_data400::base::bbb::20060627::member'										//srclogicalname;
// -- 	,'~thor_data400::temp::lbentley::copytest::20060627::bbb'       //destinationlogicalname;					
// -- 	,'thor_data400'                                                 //destinationgroup 				:= '\'thor_dataland_linux\'';
// -- 	,'10.173.29.161'                                                //srcdali									:= _Control.IPAddress.prod_thor_dali;
// -- 	,[	 {'~thor_data400::temp::lbentley::copytest::sprayed::bbb'}	//superfiles to add copied file to after copying
// -- 		,{'~thor_data400::temp::lbentley::copytest::using::bbb'	}
// -- 	 ]
// -- 	}
// -- 
// -- ], Tools.Layout_fun_CopyFiles.Input);
// -- 
// -- Tools.fun_CopyFiles(FilesToCopy);
// --
// -- Making copy of a file on same cluster
// -- FilesToCopy := DATASET([
// -- 
// -- { '~thor_data400::base::bbb::20060627::member'										//srclogicalname;
// -- 	,'~thor_data400::temp::lbentley::copytest::20060627::bbb'       //destinationlogicalname;					
// -- 	}
// -- 
// -- ], Tools.Layout_fun_CopyFiles.Input);
// -- 
// -- Tools.fun_CopyFiles(FilesToCopy);																			

// -- Limitation is that if the file is compressed, thor will fail to copy it. Bug #12306
// -- I think that bug has been fixed.  Tried to copy a compressed file on 20080303, and it worked
////////////////////////////////////////////////////////////////////////////////////////////////
#option ('globalAutoHoist', false);	// added because of bug 28526
import tools,_control;
export fun_CopyFiles(	
	 Dataset(Layout_fun_CopyFiles.Input)	pCopyInformation
	,boolean													pClearSuperFirst			= true
	,boolean													pIsTesting						= false
	,boolean													pShouldCompress				= true
	,boolean													pOverwrite						= false
	,boolean													pDeleteSrcFiles		    = false
	,boolean													pSkipSuperfileStuff	  = false
  ,string                           pFileDescription      = workunit
  ,integer                          ptransferbuffersize   = 100000000
  ,integer                          pMaxConnections       = 400
) :=
function
	Layout_fun_CopyFiles.Out twillcopy(Layout_fun_CopyFiles.Input l) :=
	transform
    srcfile := '~foreign::' + l.srcdali + '::' + if(l.srclogicalname[1] = '~',l.srclogicalname[2..],l.srclogicalname);

		self.sourcefileexists := 			      fileservices.FileExists			(srcfile) 
                                    or 	fileservices.SuperFileExists(srcfile)
                                    ;
	
		self.destinationfileexists := 			fileservices.FileExists			(l.destinationlogicalname) 
                                    or 	fileservices.SuperFileExists(l.destinationlogicalname)
                                    ;

		self.willcopy	:= 	self.sourcefileexists
                      and (not(self.destinationfileexists)	
                            or pOverwrite
                          );
		self.willcompress	:= pShouldCompress;
		self.willoverwrite	:= pOverwrite;
    self.filedescription  := pFileDescription;
    self.IsALocalCopy     := if(   (tools._Constants.IsDataland and l.srcdali = _Control.IPAddress.dataland_dali  )
                                or (tools._Constants.IsBocaProd and l.srcdali = 'prod_dali.br.seisint.com:7070'              ) //_Control.IPAddress.prod_thor_dali this didn't work
                                , true              
                                , false
                             );

		self						:= l;
	
	end;
	
	CopyInfoOut := nothor(project(global(pCopyInformation,few), twillcopy(left)));
	
	
	AddSuperfile(dataset(Layout_Names) pSuperfilenames, string pLogicalfilename) :=
		apply(pSuperfilenames, sequential(
									mod_Utilities.createsuper(name)
									,if(pClearSuperFirst	, mod_Utilities.clear_add(name, pLogicalfilename)
													, fileservices.addsuperfile(name, pLogicalfilename)
								))
			);
		
	CopyFiles := apply(CopyInfoOut(willcopy = true)
								,sequential(
                  if(willcopy
                    ,sequential(
                       if(destinationfileexists  ,Tools.fun_ClearfilesFromSupers(dataset([{destinationlogicalname}], Layout_Names), false))
                      ,fileservices.copy(
                         srclogicalname
                        ,destinationgroup 		
                        ,destinationlogicalname
                        ,if(IsALocalCopy = true ,'',srcdali)//srcdali//took out srcdali and it works, at least for copying within an environment	
                        ,
                        ,
                        ,pMaxConnections
                        ,pOverwrite
                        ,true
                        ,
                        ,pShouldCompress
                        ,
                        ,ptransferbuffersize
                      )
                      ,if(pDeleteSrcFiles = true  ,sequential(Tools.fun_ClearfilesFromSupers(dataset([{srclogicalname}], Layout_Names), false),mod_Utilities.DeleteLogical(srclogicalname)))
                      ,fileservices.setfiledescription(destinationlogicalname,pFileDescription)
                    )
                  )
                  ,if(count(dSuperfilenames) > 0  and (willcopy or destinationfileexists) and pSkipSuperfileStuff = false,AddSuperfile(dSuperfilenames, destinationlogicalname))
                 )
               );
	return 
		sequential(
			 output(CopyInfoOut)
			,if(not pIsTesting
						,nothor(CopyFiles)
			)
		);
end;
