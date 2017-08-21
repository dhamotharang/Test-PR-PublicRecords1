import _control, VersionControl;

export _Flags :=
module

	export IsTesting 							:= VersionControl._Flags.IsDataland;
	
	export UseStandardizePersists := not IsTesting;	// for bug 26170 -- Missing dependency from persist to stored
	
	export ExistCurrentMemberSprayed		:= count(nothor(fileservices.superfilecontents(filenames().input.Member.using			))) > 0;
	export ExistCurrentNonMemberSprayed	:= count(nothor(fileservices.superfilecontents(filenames().input.NonMember.using	))) > 0;

	export ExistMemberBaseFile		:= count(nothor(fileservices.superfilecontents(filenames().base.member.qa			))) > 0;
	export ExistNonMemberBaseFile	:= count(nothor(fileservices.superfilecontents(filenames().base.nonmember.qa	))) > 0;

	export UpdateMember 					:= ExistCurrentMemberSprayed		 and ExistMemberBaseFile		;
	export UpdateNonMember				:= ExistCurrentNonMemberSprayed	 and ExistNonMemberBaseFile	;
                                                                 
	export IsUpdateFullFile				:= true;	//Current/historical flag depends on this
	
	export ShouldFilter						:= true;
	
	export build_bid_keys					:= true;

end;