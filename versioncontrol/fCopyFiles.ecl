////////////////////////////////////////////////////////////////////////////////////////////////
// -- fCopyFiles() function
// --
// -- Example of copying one file from production to dataland(run on dataland)
// --
// -- FilesToCopy := DATASET([
// -- 
// -- { '~thor_data400::base::bbb::20060627::member'
// -- 	,'thor_dataland_linux'
// -- 	,'~thor_data400::temp::lbentley::copytest::20060627::bbb'
// -- 	,_Control.IPAddress.prod_thor_dali
// -- 	,[	 {'~thor_data400::temp::lbentley::copytest::sprayed::bbb'}
// -- 		,{'~thor_data400::temp::lbentley::copytest::using::bbb'	}
// -- 	 ]
// -- 	}
// -- 
// -- ], VersionControl.Layout_fCopyFiles.Input);
// -- 
// -- VersionControl.fCopyFiles(FilesToCopy);
//////////////////////////////////////////////////////////////////////////////////////////////////
// --
// -- FROM DATALAND TO PRODUCTION(run on production):
// -- 
// -- FilesToCopy := DATASET([
// -- 
// -- { '~thor_data400::base::bbb::20060627::member'
// -- 	,'thor_data400'
// -- 	,'~thor_data400::temp::lbentley::copytest::20060627::bbb'
// -- 	,_Control.IPAddress.dataland_dali
// -- 	,[	 {'~thor_data400::temp::lbentley::copytest::sprayed::bbb'}
// -- 		,{'~thor_data400::temp::lbentley::copytest::using::bbb'	}
// -- 	 ]
// -- 	},
// -- 
// -- { '~thor_data400::base::bbb::20060627::nonmember'
// -- 	,'thor_data400'
// -- 	,'~thor_data400::temp::lbentley::copytest::20060627::bbbnonmember'
// -- 	,_Control.IPAddress.dataland_dali
// -- 	,[	 {'~thor_data400::temp::lbentley::copytest::sprayed::bbbnonmember'}
// -- 		,{'~thor_data400::temp::lbentley::copytest::using::bbbnonmember'	}
// -- 	 ]
// -- 	}
// -- 
// -- ], VersionControl.Layout_fCopyFiles.Input);
// -- 
// -- VersionControl.fCopyFiles(FilesToCopy);
// -- 
// -- Limitation is that if the file is compressed, thor will fail to copy it. Bug #12306
////////////////////////////////////////////////////////////////////////////////////////////////
export fCopyFiles(	Dataset(Layout_fCopyFiles.Input)	pCopyInformation
					,string								pCopyRecordSuperfile	= ''
					,boolean							pClearSuperFirst		= true
					,boolean							pIsTesting				= false
				) :=
function


	AddSuperfile(dataset(Layout_Names) pSuperfilenames, string pLogicalfilename) :=
		apply(pSuperfilenames, sequential(
									mUtilities.createsuper(name)
									,if(pClearSuperFirst	, mUtilities.clear_add(name, pLogicalfilename)
													, fileservices.addsuperfile(name, pLogicalfilename)
								))
			);
		
	
	CopyFiles := apply(pCopyInformation, 
					sequential(
						if(not(	fileservices.FileExists(destinationlogicalname) 
							or 	fileservices.SuperFileExists(destinationlogicalname)
							),
							fileservices.copy(
							 srclogicalname
							,destinationgroup 		
							,destinationlogicalname
							,srcdali					
							)
							, output(destinationlogicalname + ' already exists, skipping copy.')),
						AddSuperfile(dSuperfilenames, destinationlogicalname)));




	return nothor(CopyFiles);

end;