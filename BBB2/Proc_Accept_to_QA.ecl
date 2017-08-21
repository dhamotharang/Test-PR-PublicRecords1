import tools, promotesupers;

///////////////////////////////////////////////////////////////////////
// -- Promote Base Files from Built to QA version
///////////////////////////////////////////////////////////////////////
MemberBaseToQA    := tools.MAC_SF_Move_Standard(Filenames().Base.Member.Template,		'Q');
NonMemberBaseToQA := tools.MAC_SF_Move_Standard(Filenames().Base.NonMember.Template,	'Q');

PromoteBaseFiles := sequential(
	 MemberBaseToQA		
	,NonMemberBaseToQA		
);
	
///////////////////////////////////////////////////////////////////////
// -- Promote Keys from Built to QA version
///////////////////////////////////////////////////////////////////////
promotesupers.MAC_SK_Move_v2('~thor_data400::key::bbb_bdid',			'Q',MemberBdidMove,		2);
promotesupers.MAC_SK_Move_v2('~thor_data400::key::bbb_non_member_bdid','Q',NonMemberBdidMove,	2);

//ut.MAC_SF_Move_Standard(Keynames.Member.Bdid.Template,		'Q', MemberBdidMove);
//ut.MAC_SF_Move_Standard(Keynames.NonMember.Bdid.Template,	'Q', NonMemberBdidMove);

PromoteKeys := sequential(
	 MemberBdidMove
	,NonMemberBdidMove
);


export Proc_Accept_to_QA := sequential(
	 PromoteBaseFiles
	,PromoteKeys
);