import ut, STRATA,versioncontrol;

export Out_Title_Base_Stats_Population_Restricted(
	
	 string														pversion
	,dataset(Layout_Marketing_Title)	pMarketing_Title_Restricted = Files().Titles_Restricted.built
	,boolean													pOverwrite									= false
	,boolean													pShouldSendToStrata					= true

) :=
function

rPopulationStats_Marketing_Best__File_Marketing_Title_Restricted
 :=
  record
	  string3  grouping                               := 'ALL';
    CountGroup                                      := count(group);
    bdid_CountNonZero                               := sum(group,if(pMarketing_Title_Restricted.bdid<>0,1,0));
    did_CountNonZero                                := sum(group,if(pMarketing_Title_Restricted.did<>0,1,0));
    dt_last_seen_CountNonZero                       := sum(group,if(pMarketing_Title_Restricted.dt_last_seen<>0,1,0));
    company_title_CountNonBlank                     := sum(group,if(pMarketing_Title_Restricted.company_title<>'',1,0));
    title_CountNonBlank                             := sum(group,if(pMarketing_Title_Restricted.title<>'',1,0));
    fname_CountNonBlank                             := sum(group,if(pMarketing_Title_Restricted.fname<>'',1,0));
    mname_CountNonBlank                             := sum(group,if(pMarketing_Title_Restricted.mname<>'',1,0));
    lname_CountNonBlank                             := sum(group,if(pMarketing_Title_Restricted.lname<>'',1,0));
    name_suffix_CountNonBlank                       := sum(group,if(pMarketing_Title_Restricted.name_suffix<>'',1,0));
    source_CountNonBlank                            := sum(group,if(pMarketing_Title_Restricted.source<>'',1,0));
    decision_maker_flag_CountNonBlank               := sum(group,if(pMarketing_Title_Restricted.decision_maker_flag<>'',1,0));
  end;
 
dPopulationStats_Marketing_Best__File_Marketing_Title_Restricted := table(pMarketing_Title_Restricted,
																	rPopulationStats_Marketing_Best__File_Marketing_Title_Restricted,
																	few
									                             );

outputTitleRestricted := sequential(

		output('Marketing Best Title Restricted Strata Stats')
	 ,output(dPopulationStats_Marketing_Best__File_Marketing_Title_Restricted	,all)

);

STRATA.createXMLStats(dPopulationStats_Marketing_Best__File_Marketing_Title_Restricted,
                      'Marketing_Title',
					  'restricted',
					  pversion,
					  '',
					  resultsOut
					  );
					 
hasTitleRestrictedStrataBeenRun := VersionControl.fHasStrataBeenRun('Marketing_Title', 'restricted', pversion);

result := map(
	 (not hasTitleRestrictedStrataBeenRun or pOverwrite) and			pShouldSendToStrata => resultsOut
	,(not hasTitleRestrictedStrataBeenRun or pOverwrite) and not	pShouldSendToStrata => outputTitleRestricted
	,output('Marketing Best Title Restricted Strata Stats have been run for version ' + pversion)
	);
					 
return result;

end;
