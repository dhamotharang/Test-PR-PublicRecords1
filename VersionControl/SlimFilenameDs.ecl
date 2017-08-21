export SlimFilenameDs :=
module

	export fOldTemps(

		 dataset(layout_versions.builds)	pVersions

	) :=
	function
		
		layout_versions.NamesOld t2old(layout_versions.builds l) :=
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

		 dataset(layout_versions.builds)	pVersions
		,string														pReturnType

	) :=
	function
		//possibilites are:
		// 1. u want superfiles only(layout_names)
		// 2. u want templates only(layout_names) -- new naming convention
		// 3. u want logical filenames (layout_names)
		
		
		layout_names tNormSupers(layout_versions.builds l, layout_names r) :=
		transform
		
			self.name := r.name		;
		
		end;
		
		dSupers := normalize(pversions, left.dSuperfiles, tNormSupers(left,right));

		layout_names t2New(layout_versions.builds l) :=
		transform
		
			self.name := l.templatename		;
		
		end;

		dTemplatesNew := project(pversions, t2New(left));

		layout_names t2Logical(layout_versions.builds l) :=
		transform
		
			self.name := l.logicalname		;
		
		end;

		dLogicals := project(pversions, t2Logical(left));

		decision := map(	 pReturnType = 'S' => dSupers
											,pReturnType = 'T' => dTemplatesNew
											,pReturnType = 'L' => dLogicals
											,dataset([], layout_names)
								);
									
		
		return decision;

	end;
	
	export fInputs(

		 dataset(layout_versions.Inputs)	pVersions
		,string														pReturnType

	) :=
	function
		//possibilites are:
		// 1. u want superfiles only(layout_names)
		// 2. u want templates only(layout_names) -- new naming convention
		
		
		layout_names tNormSupers(layout_versions.Inputs l, layout_names r) :=
		transform
		
			self.name := r.name		;
		
		end;
		
		dSupers := normalize(pversions, left.dSuperfiles, tNormSupers(left,right));

		layout_names t2New(layout_versions.Inputs l) :=
		transform
		
			self.name := l.templatename		;
		
		end;

		dTemplatesNew := project(pversions, t2New(left));

		decision := map(	 pReturnType = 'S' => dSupers
											,pReturnType = 'T' => dTemplatesNew
											,dataset([], layout_names)
								);
									
		
		return decision;

	end;

end;