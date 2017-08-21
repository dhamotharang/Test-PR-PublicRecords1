import lib_fileservices;

export DoAllFilesExist :=
module

	export fNames(

		  dataset(Layout_names)	pFiles
		 ,boolean 							pIncludeSupers	= false
		 ,boolean								pUseNothor			= true

	) :=
	function
		
		layout_exists :=
		record
			layout_names;
			boolean DoesFileExist;
		end;
		
		layout_exists tGetExistenceInfo(Layout_names l) :=
		transform
		
			DoesFileExist :=		fileservices.fileexists(l.name)
											or 	if(pIncludeSupers, fileservices.superfileexists(l.name), false)
											;
			
			self								:= l						;
			self.DoesFileExist	:= DoesFileExist;
		
		end;
		
		myproj := project(pFiles, tGetExistenceInfo(left));
		
		DoAllFilesExist := count(pFiles) = count(myproj(DoesFileExist));
		
		return if(pUseNothor
			,nothor(DoAllFilesExist)
			,DoAllFilesExist
		);

	end;

	export fNamesBuilds(

		  dataset(Layout_versions.builds)	pFiles
		 ,boolean 												pIncludeSupers	= false

	) :=
	function
	
		myproj := project(pFiles, transform(layout_names, self.name := left.logicalname));
		
		return nothor(fNames(myproj, pIncludeSupers,false));
	
	end;

end;