import tools;
export Statnames :=
module
	//////////////////////////////////////////////////////////////////
	// -- Declaration of Value Types
	//////////////////////////////////////////////////////////////////
	shared lFilename_stats	:= Common_Segment_Declarations.StatsSuperFileRoot;

	shared lMember			:= Common_Segment_Declarations.Member;
	shared lNonMember		:= Common_Segment_Declarations.NonMember;

	shared lInput			:= Common_Segment_Declarations.Input;
	shared lBase			:= Common_Segment_Declarations.Base;

	//////////////////////////////////////////////////////////////////
	// -- Member Input Filenames
	//////////////////////////////////////////////////////////////////
	export MemberInput				:= lFilename_stats 					+ lMember		+ lInput;
	export MemberNewInput			:= lFilename_stats + '::' + version	+ lMember		+ lInput;

	//////////////////////////////////////////////////////////////////
	// -- Non-Member Input Filenames
	//////////////////////////////////////////////////////////////////
	export NonMemberInput			:= lFilename_stats 					+ lNonMember	+ lInput;
	export NonMemberNewInput		:= lFilename_stats + '::' + version	+ lNonMember	+ lInput;

	//////////////////////////////////////////////////////////////////
	// -- Member Base Filenames
	//////////////////////////////////////////////////////////////////
	export MemberBase				:= lFilename_stats 					+ lMember 		+ lBase;
	export MemberNewBase			:= lFilename_stats + '::' + version	+ lMember 		+ lBase;

	//////////////////////////////////////////////////////////////////
	// -- Non-Member Base Filenames
	//////////////////////////////////////////////////////////////////
	export NonMemberBase			:= lFilename_stats 					+ lNonMember 		+ lBase;
	export NonMemberNewBase			:= lFilename_stats + '::' + version	+ lNonMember 		+ lBase;

	export dAll_superfiles := DATASET([
		 (MemberInput),
		 (NonMemberInput),
		 (MemberBase),
		 (NonMemberBase)], tools.Layout_Names);


end;