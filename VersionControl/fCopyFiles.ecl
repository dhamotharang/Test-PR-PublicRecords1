////////////////////////////////////////////////////////////////////////////////////////////////
// -- fCopyFiles() function
// --
// -- Example of copying one file from production to dataland
// -- Run it on the destination server
// --
// -- FilesToCopy := DATASET([
// -- 
// -- { '~thor_data400::base::bbb::20060627::member'										//srclogicalname;
// -- 	,'thor_data400'                                                 //destinationgroup 				:= '\'thor_dataland_linux\'';
// -- 	,'~thor_data400::temp::lbentley::copytest::20060627::bbb'       //destinationlogicalname;					
// -- 	,'10.173.29.161'                                                //srcdali									:= _Control.IPAddress.prod_thor_dali;
// -- 	,[	 {'~thor_data400::temp::lbentley::copytest::sprayed::bbb'}	//superfiles to add copied file to after copying
// -- 		,{'~thor_data400::temp::lbentley::copytest::using::bbb'	}
// -- 	 ]
// -- 	}
// -- 
// -- ], VersionControl.Layout_fCopyFiles.Input);
// -- 
// -- VersionControl.fCopyFiles(FilesToCopy);
// --
// -- Limitation is that if the file is compressed, thor will fail to copy it. Bug #12306
// -- I think that bug has been fixed.  Tried to copy a compressed file on 20080303, and it worked
////////////////////////////////////////////////////////////////////////////////////////////////
#option ('globalAutoHoist', false)	// added because of bug 28526
export fCopyFiles(	

	 Dataset(Layout_fCopyFiles.Input)	pCopyInformation
	,boolean													pClearSuperFirst			= true
	,boolean													pIsTesting						= false
	,boolean													pShouldCompress				= true
	,boolean													pOverwrite						= false

) :=
function

	Layout_fCopyFiles.Out twillcopy(Layout_fCopyFiles.Input l) :=
	transform

		self.fileexists := 			fileservices.FileExists			(l.destinationlogicalname) 
												or 	fileservices.SuperFileExists(l.destinationlogicalname)
												;
	
		self.willcopy	:= 	not(self.fileexists)	
												or pOverwrite;
		self.willcompress	:= pShouldCompress;
		self.willoverwrite	:= pOverwrite;
		self						:= l;
	
	end;
	
	CopyInfoOut := project(pCopyInformation, twillcopy(left));
	
	
	AddSuperfile(dataset(Layout_Names) pSuperfilenames, string pLogicalfilename) :=
		apply(pSuperfilenames, sequential(
									mUtilities.createsuper(name)
									,if(pClearSuperFirst	, mUtilities.clear_add(name, pLogicalfilename)
													, fileservices.addsuperfile(name, pLogicalfilename)
								))
			);
		
	
	CopyFiles := apply(CopyInfoOut(willcopy = true) 
								,sequential(
									if(FileExists
										,VersionControl.fClearLogicalFileSupers(dataset([{destinationlogicalname}], Layout_Names), false))
									,fileservices.copy(
										 srclogicalname
										,destinationgroup 		
										,destinationlogicalname
										,srcdali	
										,
										,
										,
										,pOverwrite
										,
										,
										,pShouldCompress
									)
									,AddSuperfile(dSuperfilenames, destinationlogicalname)));




	return 
		sequential(
			 output(CopyInfoOut)
			,if(not pIsTesting
						,nothor(CopyFiles)
			)
		);

end;