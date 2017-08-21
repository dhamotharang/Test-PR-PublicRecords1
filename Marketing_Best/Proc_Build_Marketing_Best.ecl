import ut, _control, roxiekeybuild, versioncontrol,mdr;

export Proc_Build_Marketing_best(

	 string 	pversion
	,boolean	pShouldPromote2QA			= true
	,boolean	pShouldSendToStrata		= true
	,boolean	pShouldSendRoxieEmail	= true

) :=
function

	//-----------------------------------------------------------------//
	// create Marketing Best Base file - no restrictions
	//-----------------------------------------------------------------//
	dcommonsubfile := Marketing_Best.make_Common_Subfile();
	
	bjoinAll := Marketing_Best.Base_Home_Based(dcommonsubfile,'all');

	bJoinAllComp := bjoinAll(salesSource <>'' or sicSource <>'' or emplcntsource <> '' or 
							taxlienamount <>'' or orgtypesource <>'' or bankrupt_flag <> '' or 
							home_based_flag <>'');

							
	//-----------------------------------------------------------------//
	// Call to create Marketing Best Base Restricted Sources
	//-----------------------------------------------------------------//
	restrictedCommon := dcommonsubfile(
		not (			MDR.sourceTools.SourceIsYellow_Pages					(stringlib.StringToUpperCase(SourceCode))
					or	MDR.sourceTools.SourceIsEBR										(stringlib.StringToUpperCase(SourceCode))
					or	MDR.sourceTools.SourceIsBusiness_Registration	(stringlib.StringToUpperCase(SourceCode))
					or	MDR.sourceTools.SourceIsDCA										(stringlib.StringToUpperCase(SourceCode))
					or	MDR.sourceTools.SourceIsINFOUSA_ABIUS_USABIZ	(stringlib.StringToUpperCase(SourceCode))
		)
	) : persist('~thor_data400::persist::Marketing_Best::Proc_Build_Marketing_Best.common_restricted');
							
	bjoinRestricted := Marketing_Best.Base_Home_Based(restrictedCommon,'restricted');

	bJoinRestrictedComp := bjoinRestricted(salesSource <>'' or sicSource <>'' or emplcntsource <> '' or 
											taxlienamount <>'' or orgtypesource <>'' or bankrupt_flag <> '' or 
											home_based_flag <>'');
											
	//-----------------------------------------------------------------//
	// Titles
	//-----------------------------------------------------------------//
	all_titles				:= Best_Marketing_Bus_Titles(Files(pversion).Best_all.new				,'All'				);
	restricted_titles := Best_Marketing_Bus_Titles(Files(pversion).Best_Restricted.new,'restricted'	);

	names := filenames(pversion);

	//-----------------------------------------------------------------//
	// Write output files
	//-----------------------------------------------------------------//
	VersionControl.macBuildNewLogicalFile( names.Best_All.new						,bjoinAllComp					,MB_all						);
	VersionControl.macBuildNewLogicalFile( names.Best_Restricted.new		,bjoinRestrictedComp	,MB_restricted		);
	VersionControl.macBuildNewLogicalFile( names.Titles_All.new					,all_titles						,Title_all				);
	VersionControl.macBuildNewLogicalFile( names.Titles_Restricted.new	,restricted_titles		,Title_restricted	);

	email_notify := sequential(
										 MB_all
										,MB_restricted
										,Title_all
										,Title_restricted
										,promote(pversion,'base').new2built
										,parallel(
											 Marketing_Best.Out_Mrkt_Base_Stats_Population_All				(pversion,,,pShouldSendToStrata	)
											,Marketing_Best.Out_Mrkt_Base_Stats_Population_Restricted	(pversion,,,pShouldSendToStrata	)
											,Marketing_Best.Out_Title_Base_Stats_Population_All				(pversion,,,pShouldSendToStrata	)
											,Marketing_Best.Out_Title_Base_Stats_Population_Restricted(pversion,,,pShouldSendToStrata	)
											,Marketing_Best.Proc_Build_Marketing_Best_Keys						(pversion												)
										)
										,if(pShouldPromote2QA,promote(pversion).built2qa)
								)
								:  	success(Send_Emails(pversion,,pShouldPromote2QA,pShouldSendRoxieEmail	).Roxie				)
								, 	failure(Send_Emails(pversion,,pShouldPromote2QA												).buildfailure);


	return email_notify;

end;