import ut;

///////////////////////////////////////////////////////////////////////
// -- Promote Base Files from Built to Prod version
///////////////////////////////////////////////////////////////////////
ut.MAC_SF_Move_Standard(Filenames.Base.Member.Template,		'P', MemberBaseToProd);
ut.MAC_SF_Move_Standard(Filenames.Base.NonMember.Template,	'P', NonMemberBaseToProd);

PromoteBaseFiles := sequential(
	 MemberBaseToProd		
	,NonMemberBaseToProd		
);
	
///////////////////////////////////////////////////////////////////////
// -- Promote Keys from Built to Prod version
///////////////////////////////////////////////////////////////////////
ut.MAC_SK_Move_v2('~thor_data400::key::bbb_bdid',			'P',MemberBdidMove,		2);
ut.MAC_SK_Move_v2('~thor_data400::key::bbb_non_member_bdid','P',NonMemberBdidMove,	2);

//ut.MAC_SF_Move_Standard(Keynames.Member.Bdid.Template,		'P', MemberBdidMove);
//ut.MAC_SF_Move_Standard(Keynames.NonMember.Bdid.Template,	'P', NonMemberBdidMove);

PromoteKeys := sequential(
	 MemberBdidMove
	,NonMemberBdidMove
);


export Proc_Accept_to_Prod := sequential(
	 PromoteBaseFiles
	,PromoteKeys
);