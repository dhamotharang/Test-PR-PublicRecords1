////////////////////////////////////////////////////////////////////////////////////////////////
// -- fCopyToAnotherCluster() function
// --
// -- Example of copying one file from production to dataland
/*
FilesToCopy := DATASET([

{ '~thor_data400::base::bbb::20060627::member'
	,'thor_data400'
	,'~thor_data400::temp::lbentley::copytest::20060627::bbb'
}

], VersionControl.Layout_fCopyFiles.SlimInput);

VersionControl.fCopyToAnotherCluster(
	 pCopyInformation	:= FilesToCopy
	,pClearSuperFirst	:= true
	,pIsTesting				:= false
	,pShouldCompress	:= true
	,pOverwrite				:= false
);
*/
// --
////////////////////////////////////////////////////////////////////////////////////////////////
#option ('globalAutoHoist', false)	// added because of bug 28526
import lib_fileservices;
export fCopyToAnotherCluster(	

	 Dataset(Layout_fCopyFiles.SlimInput)	pCopyInformation
	,boolean															pClearSuperFirst			= true
	,boolean															pIsTesting						= false
	,boolean															pShouldCompress				= true
	,boolean															pOverwrite						= false
	,boolean															pDeleteSourceFile			= true
	,boolean															pClearSuperOnce				= false

) :=
function

	Layout_fCopyFiles.SlimOut twillcopy(Layout_fCopyFiles.SlimInput l) :=
	transform

		self.sourcefileexists 		 	:= 			fileservices.FileExists			(l.srclogicalname) 
																		or 	fileservices.SuperFileExists(l.srclogicalname)
																		;
		self.destinationfileexists 	:= 			fileservices.FileExists			(l.destinationlogicalname) 
																		or 	fileservices.SuperFileExists(l.destinationlogicalname)
																		;
	
		self.NeedToRenameFirst	:= if(l.srclogicalname = l.destinationlogicalname
																,true
																,false
																);

		self.templogicalname	:= if(l.srclogicalname = l.destinationlogicalname
																,l.srclogicalname + '::' + workunit
																,l.srclogicalname
															);

		self.willcopy				 := 	self.sourcefileexists
															and (
																		not(self.destinationfileexists)	
																		or pOverwrite
																		or self.NeedToRenameFirst
																	);
																	
		self.willcompress		 := pShouldCompress;
		self.willoverwrite	 := pOverwrite;
		self.dSuperfilenames := if(self.sourcefileexists
															,fileservices.LogicalFileSuperOwners(l.srclogicalname)
															,dataset([], lib_fileservices.FsLogicalFileNameRecord)
														);
		
		
		self								:= l;
	
	end;
	
	CopyInfoOut := project(pCopyInformation, twillcopy(left)) : global;
	
	
	AddSuperfile(dataset(Layout_Names) pSuperfilenames, string pLogicalfilename) :=
		apply(pSuperfilenames, sequential(
									mUtilities.createsuper('~' + name)
									,if(pClearSuperFirst	, mUtilities.clear_add('~' + name, pLogicalfilename)
													, fileservices.addsuperfile('~' + name, pLogicalfilename)
								))
			);
		
	ClearSupers(dataset(Layout_Names) pSuperfilenames) :=
		apply(pSuperfilenames
			,sequential(
				 mUtilities.createsuper			('~' + name)
				,fileservices.clearsuperfile('~' + name)
			)
		);
		
		
	clearsupersfirst := apply(CopyInfoOut(willcopy = true) 
												,ClearSupers(dSuperfilenames)
											);
	
	CopyFiles := apply(CopyInfoOut(willcopy = true) 
								,sequential(
									VersionControl.fClearLogicalFileSupers(dataset([{srclogicalname}], Layout_Names), false)
									,if(destinationfileexists
										,VersionControl.fClearLogicalFileSupers(dataset([{destinationlogicalname}], Layout_Names), false))
									,if(NeedToRenameFirst, fileservices.RenameLogicalFile(srclogicalname,	templogicalname))
									,fileservices.copy(
										 templogicalname
										,destinationgroup 		
										,destinationlogicalname
										,	
										,
										,
										,
										,pOverwrite
										,
										,
										,pShouldCompress
									)
									,AddSuperfile(dSuperfilenames, destinationlogicalname)
									,if(pDeleteSourceFile, fileservices.deletelogicalfile(templogicalname))
								)
							);




	return 
		sequential(
			 output(CopyInfoOut)
			,if(not pIsTesting
						,sequential(
							 if(pClearSuperOnce,nothor(clearsupersfirst))
							,nothor(CopyFiles)
						)
			)
		);

end;