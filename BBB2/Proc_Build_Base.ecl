import VersionControl;

export Proc_Build_Base(

	string pversion

) :=
module

	shared memberbase			:= bdid_member 			(pversion	,Files().Input.Member.Using		, Files().Base.Member.QA		);
	shared nonmemberbase	:= bdid_non_member	(pversion	,Files().Input.NonMember.Using, Files().Base.NonMember.QA	);
	
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).base.Member.new			,memberbase			,Build_Member_Base_File			);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).base.NonMember.new	,nonmemberbase	,Build_NonMember_Base_File	);

	export full_build :=
		 sequential(
			 Promote().Input.Sprayed2Using
			,Build_Member_Base_File		
			,Build_NonMember_Base_File
			,Promote().Input.Using2Used
			,Promote(pversion).Base.New2Built
		);

	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping bbb2.Proc_Build_Base attribute')
	);
		
end;