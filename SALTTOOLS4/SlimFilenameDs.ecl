export SlimFilenameDs :=
module
	export fOldTemps(
		 dataset(Layout_FilenameVersions.builds)	pVersions
	) :=
	function
		
		Layout_FilenameVersions.NamesOld t2old(Layout_FilenameVersions.builds l) :=
		transform
		
			self.OldTemplateName	:= l.templatename			;
			self.NewTemplateName	:= l.templatenameNew	;
			self.version					:= l.logicalversion		;
			self.IsNewNamingConvention := l.IsNewNamingConvention;
		
		end;
		dTemplatesOld := project(pversions, t2old(left));
		return dTemplatesOld;
	end;
	export fOther(
		 dataset(Layout_FilenameVersions.builds)	pVersions
		,string														pReturnType
	) :=
	function
		//possibilites are:
		// 1. u want superfiles only(Layout_Names)
		// 2. u want templates only(Layout_Names) -- new naming convention
		// 3. u want logical filenames (Layout_Names)
		
		
		Layout_Names tNormSupers(Layout_FilenameVersions.builds l, Layout_Names r) :=
		transform
		
			self.name := r.name		;
		
		end;
		
		dSupers := normalize(pversions, left.dSuperfiles, tNormSupers(left,right));
		Layout_Names t2New(Layout_FilenameVersions.builds l) :=
		transform
		
			self.name := l.templatename		;
		
		end;
		dTemplatesNew := project(pversions, t2New(left));
		Layout_Names t2Logical(Layout_FilenameVersions.builds l) :=
		transform
		
			self.name := l.logicalname		;
		
		end;
		dLogicals := project(pversions, t2Logical(left));
		decision := map(	 pReturnType = 'S' => dSupers
											,pReturnType = 'T' => dTemplatesNew
											,pReturnType = 'L' => dLogicals
											,dataset([], Layout_Names)
								);
									
		
		return decision;
	end;
	
	export fInputs(
		 dataset(Layout_FilenameVersions.Inputs)	pVersions
		,string														pReturnType
	) :=
	function
		//possibilites are:
		// 1. u want superfiles only(Layout_Names)
		// 2. u want templates only(Layout_Names) -- new naming convention
		
		
		Layout_Names tNormSupers(Layout_FilenameVersions.Inputs l, Layout_Names r) :=
		transform
		
			self.name := r.name		;
		
		end;
		
		dSupers := normalize(pversions, left.dSuperfiles, tNormSupers(left,right));
		Layout_Names t2New(Layout_FilenameVersions.Inputs l) :=
		transform
		
			self.name := l.templatename		;
		
		end;
		dTemplatesNew := project(pversions, t2New(left));
		decision := map(	 pReturnType = 'S' => dSupers
											,pReturnType = 'T' => dTemplatesNew
											,dataset([], Layout_Names)
								);
									
		
		return decision;
	end;
end;
