import versioncontrol;

export Proc_Build_Keys(string pversion) :=
module

	VersionControl.macBuildNewLogicalKeyWithName(Key_BBB_BDID							,Keynames(pversion).Member.Bdid.New			,BuildMemberBdidKey			);
	VersionControl.macBuildNewLogicalKeyWithName(Key_BBB_Non_Member_BDID	,Keynames(pversion).NonMember.Bdid.New	,BuildNonMemberBdidKey	);	
	
	VersionControl.macBuildNewLogicalKeyWithName(Key_BBB_LinkIds.key							,Keynames(pversion).Member.Linkids.New			,BuildMemberLinkidsKey		);
	VersionControl.macBuildNewLogicalKeyWithName(Key_BBB_Non_Member_LinkIds.key		,Keynames(pversion).NonMember.Linkids.New		,BuildNonMemberLinkidsKey	);	
																		  
	export full_build :=
	sequential(
		 parallel(
			 BuildMemberBdidKey
			,BuildNonMemberBdidKey
			,BuildMemberLinkidsKey
			,BuildNonMemberLinkidsKey
		 )
		,Promote(pversion).RoxieKeys.New2Built
	);

	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping BBB2.Proc_Build_Keys atribute')
	);

end;