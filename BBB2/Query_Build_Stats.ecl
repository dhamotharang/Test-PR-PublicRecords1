
///////////////////////////////////////////////////////////////////////////////
// -- Create the Stat Tables
///////////////////////////////////////////////////////////////////////////////
MemberInputStats	:= table(Files().Input.Member.Used,		Layout_Stat_Tables.MemberInputTable,	few);
NonMemberInputStats	:= table(Files().Input.NonMember.Used,	Layout_Stat_Tables.NonMemberInputTable,	few);
MemberBaseStats		:= table(Files().Base.Member.QA,			Layout_Stat_Tables.MemberBaseTable,		few);
NonMemberBaseStats	:= table(Files().Base.NonMember.QA,		Layout_Stat_Tables.NonMemberBaseTable,	few);

///////////////////////////////////////////////////////////////////////////////
// -- Get unique counts for BBB_ID and BDID fields
///////////////////////////////////////////////////////////////////////////////
MemberInputStatsBBBId		:= count(table(Files().Input.Member.Used,		Layout_Stat_Tables.MemberInputTableUniqueBBBId,		bbb_id));
NonMemberInputStatsBBBId	:= count(table(Files().Input.NonMember.Used,	Layout_Stat_Tables.NonMemberInputTableUniqueBBBId,	bbb_id));

MemberBaseStatsBBBId		:= count(table(Files().Base.Member.QA,				Layout_Stat_Tables.MemberBaseTableUniqueBBBId,		bbb_id));
MemberBaseStatsBDID			:= count(table(Files().Base.Member.QA(bdid != 0),		Layout_Stat_Tables.MemberBaseTableUniqueBDID,		bdid));
NonMemberBaseStatsBBBId		:= count(table(Files().Base.NonMember.QA,				Layout_Stat_Tables.NonMemberBaseTableUniqueBBBId,	bbb_id));
NonMemberBaseStatsBDID		:= count(table(Files().Base.NonMember.QA(bdid != 0),	Layout_Stat_Tables.NonMemberBaseTableUniqueBDID,	bdid));

///////////////////////////////////////////////////////////////////////////////
// -- Add Unique Counts to Stat Tables
///////////////////////////////////////////////////////////////////////////////
layout_stat_layouts.memberInput		tAddbbbidMemberInput(MemberInputStats l) :=
transform
	self.Unique_bbb_ids := MemberInputStatsBBBId;
	self				:= l;
end;

layout_stat_layouts.NonmemberInput	tAddbbbidNonMemberInput(NonMemberInputStats l) :=
transform
	self.Unique_bbb_ids := NonMemberInputStatsBBBId;
	self				:= l;
end;

layout_stat_layouts.memberBase		tAddbbbidMemberBase(MemberBaseStats l) :=
transform
	self.Unique_bbb_ids := MemberBaseStatsBBBId;
	self.Unique_bdids 	:= MemberBaseStatsBDId;
	self				:= l;
end;

layout_stat_layouts.NonmemberBase	tAddbbbidNonMemberBase(NonMemberBaseStats l) :=
transform
	self.Unique_bbb_ids := NonMemberBaseStatsBBBId;
	self.Unique_bdids 	:= NonMemberBaseStatsBDId;
	self				:= l;
end;

MemberInputStatsUniquesAdded	:= project(MemberInputStats,	tAddbbbidMemberInput(left));
NonMemberInputStatsUniquesAdded	:= project(NonMemberInputStats,	tAddbbbidNonMemberInput(left));
MemberBaseStatsUniquesAdded		:= project(MemberBaseStats,		tAddbbbidMemberBase(left));
NonMemberBaseStatsUniquesAdded	:= project(NonMemberBaseStats,	tAddbbbidNonMemberBase(left));

///////////////////////////////////////////////////////////////////////////////
// -- Output the Stat Tables
///////////////////////////////////////////////////////////////////////////////
MemberInputStatsOutputFile		:= output(MemberInputStatsUniquesAdded,,		Statnames.MemberNewInput, overwrite);
NonMemberInputStatsOutputFile	:= output(NonMemberInputStatsUniquesAdded,,	Statnames.NonMemberNewInput, overwrite);
MemberBaseStatsOutputFile		:= output(MemberBaseStatsUniquesAdded,,		Statnames.MemberNewBase, overwrite);
NonMemberBaseStatsOutputFile	:= output(NonMemberBaseStatsUniquesAdded,,		Statnames.NonMemberNewBase, overwrite);

Output_Stat_Tables := parallel(
	 MemberInputStatsOutputFile		
	,NonMemberInputStatsOutputFile	
	,MemberBaseStatsOutputFile		
	,NonMemberBaseStatsOutputFile
);
	
///////////////////////////////////////////////////////////////////////////////
// -- Add them to the Stat Superfiles
///////////////////////////////////////////////////////////////////////////////
MemberInputSuperfileADD		:= fileservices.addsuperfile(Statnames.MemberInput,		Statnames.MemberNewInput);
NonMemberInputSuperfileADD	:= fileservices.addsuperfile(Statnames.NonMemberInput,	Statnames.NonMemberNewInput);
MemberBaseSuperfileADD		:= fileservices.addsuperfile(Statnames.MemberBase,		Statnames.MemberNewBase);
NonMemberBaseSuperfileADD	:= fileservices.addsuperfile(Statnames.NonMemberBase,	Statnames.NonMemberNewBase);

Add_To_Superfiles := sequential(
	 MemberInputSuperfileADD		
	,NonMemberInputSuperfileADD	
	,MemberBaseSuperfileADD		
	,NonMemberBaseSuperfileADD
);

///////////////////////////////////////////////////////////////////////////////
// -- Output to workunit contents of Stat superfiles
///////////////////////////////////////////////////////////////////////////////
MemberInputStatsWorkunitOutput		:= output(Datasets.Stats.Input.Member(Statnames.MemberInput),			named('MemberInputStats'),		all);
NonMemberInputStatsWorkunitOutput	:= output(Datasets.Stats.Input.NonMember(Statnames.NonMemberInput),	named('NonMemberInputStats'),	all);
MemberBaseStatsWorkunitOutput		:= output(Datasets.Stats.Base.Member(Statnames.MemberBase),			named('MemberBaseStats'),		all);
NonMemberBaseStatsWorkunitOutput	:= output(Datasets.Stats.Base.NonMember(Statnames.NonMemberBase),		named('NonMemberBaseStats'),	all);

Workunit_Output := parallel(
	 MemberInputStatsWorkunitOutput		
	,NonMemberInputStatsWorkunitOutput	
	,MemberBaseStatsWorkunitOutput		
	,NonMemberBaseStatsWorkunitOutput	
);


export Query_Build_Stats := sequential(
	 Output_Stat_Tables
	,Add_To_Superfiles
	,Workunit_Output
);
	