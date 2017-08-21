/*
  pass in file to copy and cluster to copy it to
  what is does:
    copies file to cluster with a different name(such as append _copy) to it
    set description to copying wuid + optional parameter to add info to description
    clear source file from supers
    delete source file
    rename copied file
    add copied file to supers

// --
// -- Making copy of a file on same cluster

FilesToCopy := DATASET([

{ '~thor_data400::key::atf_firearms_didw20050425-095907',tools.fun_Groupname('20')}

], tools.Layout_fun_CopyFiles.SlimIn);

tools.fun_Copy_Diff_Cluster(FilesToCopy,false);
    
*/
#option ('globalAutoHoist', false);	// added because of bug 28526
import tools,_control,lib_fileservices;
export fun_Copy_Diff_Cluster(	

	 Dataset(Layout_fun_CopyFiles.SlimIn)	pCopyInformation
	,boolean													    pIsTesting						= true
	,boolean													    pShouldCompress				= true
  ,string                               pFileDescription      = workunit
  
) :=
function

	Layout_fun_CopyFiles.SlimOut2 twillcopy(Layout_fun_CopyFiles.SlimIn l) :=
	transform

		self.sourcefileexists := 			      fileservices.FileExists			(l.srclogicalname) 
                                    or 	fileservices.SuperFileExists(l.srclogicalname)
                                    ;
		self.templogicalname	:= l.srclogicalname + '::' + workunit;
		self.dSuperfilenames  := if(self.sourcefileexists
															,fileservices.LogicalFileSuperOwners(l.srclogicalname)
															,dataset([], lib_fileservices.FsLogicalFileNameRecord)
														);
  	
		self.willcopy	        := self.sourcefileexists ;
		self.willcompress	    := pShouldCompress;
    self.filedescription  := pFileDescription;

		self						:= l;
	
	end;
	
	CopyInfoOut := nothor(project(global(pCopyInformation,few), twillcopy(left)));
	
	
	AddSuperfile(dataset(Layout_Names) pSuperfilenames, string pLogicalfilename) :=
		apply(pSuperfilenames, sequential(
									 mod_Utilities.createsuper('~' + name)
									,fileservices.addsuperfile('~' + name, pLogicalfilename)
								)
			);
		
	CopyFiles := apply(CopyInfoOut(willcopy = true)
                    ,sequential(
                       fileservices.copy(
                         srclogicalname
                        ,destinationgroup 		
                        ,templogicalname
                        ,//srcdali//took out srcdali and it works, at least for copying within an environment	
                        ,
                        ,
                        ,
                        ,//pOverwrite
                        ,true
                        ,
                        ,pShouldCompress
                      )
                      ,fileservices.setfiledescription(templogicalname,pFileDescription)
                      ,sequential(Tools.fun_ClearfilesFromSupers(dataset([{srclogicalname}], Layout_Names), false),mod_Utilities.DeleteLogical(srclogicalname))
                      ,fileservices.RenameLogicalFile(templogicalname,	srclogicalname)
                      ,if(count(dSuperfilenames) > 0  ,AddSuperfile(dSuperfilenames, srclogicalname))
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
