export Datasets :=
module
	
	export Builds :=
	module

		export Input :=
		module
		
			export Member(string pFilename)		:= dataset(pFilename, Layouts_Files.Input.Member,		XML('listings/listing'));
			export NonMember(string pFilename)	:= dataset(pFilename, Layouts_Files.Input.NonMember,	XML('listings/listing'));
			
		end;
		
		export Base :=
		module
		
			export Member(string pFilename)		:= dataset(pFilename, Layouts_Files.Base.Member,	flat);
			export NonMember(string pFilename)	:= dataset(pFilename, Layouts_Files.Base.NonMember,	flat);
		
		end;
	
	end;
	
	export Stats :=
	module
	
		export Input :=
		module
		
			export Member(string pFilename)		:= dataset(pFilename, Layout_Stat_Layouts.MemberInput,		flat);
			export NonMember(string pFilename)	:= dataset(pFilename, Layout_Stat_Layouts.NonMemberInput,	flat);
		
		end;
		
		export Base :=
		module
			export Member(string pFilename)		:= dataset(pFilename, Layout_Stat_Layouts.MemberBase,		flat);
			export NonMember(string pFilename)	:= dataset(pFilename, Layout_Stat_Layouts.NonMemberBase,	flat);
		
		end;
	end;

end;