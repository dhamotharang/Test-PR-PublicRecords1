import strata, VersionControl;

export Strata_Population_Stats(

	string pversion

) :=
module
	
	dAsbus := fBBB_As_Business_Header	(files().base.member.qa,files().base.nonmember.qa);
	
	Strata.createAsBusinessStats.Header	(dAsbus	,_dataset().name	,'data'	,pversion	,Email_Notification_Lists.stats	,Business_headers		);
	
	export all := if(VersionControl.IsValidVersion(pversion),
	sequential(
		 business_headers
		,Strata_Member_Population_Stats		(pversion)
		,Strata_NonMember_Population_Stats(pversion)
	));

end;