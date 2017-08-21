import ut, STRATA,versioncontrol;

export Out_Title_Base_Stats_Population_All(
	
	 string														pversion
	,dataset(Layout_Marketing_Title)	pMarketing_Title_all	= Files().Titles_All.built
	,boolean													pOverwrite						= false
	,boolean													pShouldSendToStrata		= true


) :=
function


rPopulationStats_Marketing_Best__File_Marketing_Title_All
 :=
  record
	  string3  grouping                               := 'ALL';
    CountGroup                                      := count(group);
    bdid_CountNonZero                               := sum(group,if(pMarketing_Title_all.bdid<>0,1,0));
    did_CountNonZero                                := sum(group,if(pMarketing_Title_all.did<>0,1,0));
    dt_last_seen_CountNonZero                       := sum(group,if(pMarketing_Title_all.dt_last_seen<>0,1,0));
    company_title_CountNonBlank                     := sum(group,if(pMarketing_Title_all.company_title<>'',1,0));
    title_CountNonBlank                             := sum(group,if(pMarketing_Title_all.title<>'',1,0));
    fname_CountNonBlank                             := sum(group,if(pMarketing_Title_all.fname<>'',1,0));
    mname_CountNonBlank                             := sum(group,if(pMarketing_Title_all.mname<>'',1,0));
    lname_CountNonBlank                             := sum(group,if(pMarketing_Title_all.lname<>'',1,0));
    name_suffix_CountNonBlank                       := sum(group,if(pMarketing_Title_all.name_suffix<>'',1,0));
    source_CountNonBlank                            := sum(group,if(pMarketing_Title_all.source<>'',1,0));
    decision_maker_flag_CountNonBlank               := sum(group,if(pMarketing_Title_all.decision_maker_flag<>'',1,0));
  end;
 
dPopulationStats_Marketing_Best__File_Marketing_Title_All := table(pMarketing_Title_all,
																	rPopulationStats_Marketing_Best__File_Marketing_Title_All,
																	few
									                             );

outputTitleAll := sequential(

		output('Marketing Title All Strata Stats')
	 ,output(dPopulationStats_Marketing_Best__File_Marketing_Title_All	,all)

);

STRATA.createXMLStats(dPopulationStats_Marketing_Best__File_Marketing_Title_All,
                      'Marketing_Title',
					  'all',
					  pversion,
					  '',
					  resultsOut
					  );

hasTitleAllStrataBeenRun := VersionControl.fHasStrataBeenRun('Marketing_Title', 'all', pversion);

result := map(
	 (not hasTitleAllStrataBeenRun or pOverwrite) and			pShouldSendToStrata => resultsOut
	,(not hasTitleAllStrataBeenRun or pOverwrite) and not	pShouldSendToStrata => outputTitleAll
	,output('Marketing Best Title All Strata Stats have been run for version ' + pversion)
	);
					 
return result;

end;
