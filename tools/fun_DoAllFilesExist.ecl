import lib_fileservices;
export fun_DoAllFilesExist :=
module
	export fNames(
		  dataset(Layout_Names)	pFiles
		 ,boolean 							pIncludeSupers	= false
		 ,boolean								pUseNothor			= true
	) :=
	function
		
		layout_exists :=
		record
			Layout_Names;
			boolean DoesFileExist;
		end;
		
		layout_exists tGetExistenceInfo(Layout_Names l) :=
		transform
		
			DoesFileExist :=		fileservices.fileexists(l.name)
											or 	if(pIncludeSupers, fileservices.superfileexists(l.name), false)
											;
			
			self								:= l						;
			self.DoesFileExist	:= DoesFileExist;
		
		end;
		
		myproj := project(pFiles, tGetExistenceInfo(left));
		
		fun_DoAllFilesExist := count(pFiles) = count(myproj(DoesFileExist));
		
		return if(pUseNothor
			,nothor(fun_DoAllFilesExist)
			,fun_DoAllFilesExist
		);
	end;
	export fNamesBuilds(
		  dataset(Layout_FilenameVersions.builds)	pFiles
		 ,boolean 												pIncludeSupers	= false
	) :=
	function
	
		myproj := project(pFiles, transform(Layout_Names, self.name := left.logicalname));
		
		return nothor(fNames(myproj, pIncludeSupers,false));
	
	end;
end;
