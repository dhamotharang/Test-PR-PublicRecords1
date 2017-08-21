import Business_Header, bbb2, strata;

export Out_Population_Stats :=
module

	export business_headers(pfilebuildversion, bus_out) := 
	macro
	
		strata.createAsBusinessHeaderStats(bbb2.fBBB_As_Business_Header(bbb2.Files.Base.Member.pfilebuildversion, bbb2.Files.Base.NonMember.pfilebuildversion), 
								   'BBB', 
								   'Data', 
								   bbb2.version, 
								   bbb2.Email_Notification_Lists.BuildCompletion, 
								   bus_out
								  );
	endmacro;

	//use qa version
	business_headers(qa, AsBusiness);
	
	export AsBusinessHeader := AsBusiness;

	export All :=
	sequential(
		 AsBusinessHeader
		,Strata_Member_Population_Stats
		,Strata_NonMember_Population_Stats
	);

end;
