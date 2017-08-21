import strata, ut, versioncontrol;

export Strata_Pop_Base(

	 string													pVersion
	,dataset(LAYOUT.Employment_Out) pBase								= files().base.built
	,boolean												pOverwrite					= false
	,boolean												pShouldSendToStrata	= true

) := function

dsBin := pBase;
 

rPopulationStats_PAW
 :=
  record
    integer countGroup 								:= count(group);
	dsBin.Source;
    contact_id_CountNonZero                         := sum(group,if(dsBin.contact_id<>0,1,0));
    did_CountNonZero                                := sum(group,if(dsBin.did<>0,1,0));
    bdid_CountNonZero                               := sum(group,if(dsBin.bdid<>0,1,0));
    ssn_CountNonZero                                := sum(group,if((integer)dsBin.ssn<>0,1,0));
    High_score                                      := sum(group,if((integer)dsBin.score>6,1,0));
    company_name_CountNonZero                       := sum(group,if(dsBin.company_name<>'',1,0));
    company_prim_range_CountNonZero                 := sum(group,if(dsBin.company_prim_range<>'',1,0));
    company_predir_CountNonZero                     := sum(group,if(dsBin.company_predir<>'',1,0));
    company_prim_name_CountNonZero                  := sum(group,if(dsBin.company_prim_name<>'',1,0));
    company_addr_suffix_CountNonZero                := sum(group,if(dsBin.company_addr_suffix<>'',1,0));
    company_postdir_CountNonZero                    := sum(group,if(dsBin.company_postdir<>'',1,0));
    company_unit_desig_CountNonZero                 := sum(group,if(dsBin.company_unit_desig<>'',1,0));
    company_sec_range_CountNonZero                  := sum(group,if(dsBin.company_sec_range<>'',1,0));
    company_city_CountNonZero                       := sum(group,if(dsBin.company_city<>'',1,0));
    company_state_CountNonZero                      := sum(group,if(dsBin.company_state<>'',1,0));
    company_zip_CountNonZero                        := sum(group,if(dsBin.company_zip<>'',1,0));
    company_zip4_CountNonZero                       := sum(group,if(dsBin.company_zip4<>'',1,0));
    company_title_CountNonZero                      := sum(group,if(dsBin.company_title<>'',1,0));
    company_department_CountNonZero                 := sum(group,if(dsBin.company_department<>'',1,0));
    company_phone_CountNonZero                      := sum(group,if(dsBin.company_phone<>'',1,0));
    company_fein_CountNonZero                       := sum(group,if(dsBin.company_fein<>'',1,0));
    title_CountNonZero                              := sum(group,if(dsBin.title<>'',1,0));
    fname_CountNonZero                              := sum(group,if(dsBin.fname<>'',1,0));
    mname_CountNonZero                              := sum(group,if(dsBin.mname<>'',1,0));
    lname_CountNonZero                              := sum(group,if(dsBin.lname<>'',1,0));
    name_suffix_CountNonZero                        := sum(group,if(dsBin.name_suffix<>'',1,0));
    prim_range_CountNonZero                         := sum(group,if(dsBin.prim_range<>'',1,0));
    predir_CountNonZero                             := sum(group,if(dsBin.predir<>'',1,0));
    prim_name_CountNonZero                          := sum(group,if(dsBin.prim_name<>'',1,0));
    addr_suffix_CountNonZero                        := sum(group,if(dsBin.addr_suffix<>'',1,0));
    postdir_CountNonZero                            := sum(group,if(dsBin.postdir<>'',1,0));
    unit_desig_CountNonZero                         := sum(group,if(dsBin.unit_desig<>'',1,0));
    sec_range_CountNonZero                          := sum(group,if(dsBin.sec_range<>'',1,0));
    city_CountNonZero                               := sum(group,if(dsBin.city<>'',1,0));
    state_CountNonZero                              := sum(group,if(dsBin.state<>'',1,0));
    zip_CountNonZero                                := sum(group,if(dsBin.zip<>'',1,0));
    zip4_CountNonZero                               := sum(group,if(dsBin.zip4<>'',1,0));
    county_CountNonZero                             := sum(group,if(dsBin.county<>'',1,0));
    msa_CountNonZero                                := sum(group,if(dsBin.msa<>'',1,0));
    geo_lat_CountNonZero                            := sum(group,if(dsBin.geo_lat<>'',1,0));
    geo_long_CountNonZero                           := sum(group,if(dsBin.geo_long<>'',1,0));
    phone_CountNonZero                              := sum(group,if(dsBin.phone<>'',1,0));
    email_address_CountNonZero                      := sum(group,if(dsBin.email_address<>'',1,0));
    dt_first_seen_CountNonZero                      := sum(group,if(dsBin.dt_first_seen<>'',1,0));
    dt_last_seen_CountNonZero                       := sum(group,if(dsBin.dt_last_seen<>'',1,0));
    record_type_CountNonZero                        := sum(group,if(dsBin.record_type<>'',1,0));
    active_phone_flag_CountNonZero                  := sum(group,if(dsBin.active_phone_flag<>'',1,0));
    GLB_CountNonZero                                := sum(group,if(dsBin.GLB<>'',1,0));
    source_CountNonZero                             := sum(group,if(dsBin.source<>'',1,0));
    DPPA_State_CountNonZero                         := sum(group,if(dsBin.DPPA_State<>'',1,0));
    old_score_CountNonZero                          := sum(group,if(dsBin.old_score<>'',1,0));
    source_count_CountNonZero                       := sum(group,if(dsBin.source_count<>0,1,0));
    dead_flag_CountNonZero                          := sum(group,if(dsBin.dead_flag<>0,1,0));
    company_status_CountNonZero                     := sum(group,if(dsBin.company_status<>'',1,0));
  end;

	dPopulationStats_DSB := table(distribute(dsBin,hash( source))
	                                  ,rPopulationStats_PAW,source,few,local);

	outputpaw := sequential(
	
		  output('PAW_CONTACT_Population_View')
		 ,output(dPopulationStats_DSB	,all)
	
	);

	STRATA.createXMLStats(dPopulationStats_DSB
	                     ,'PAW'
						 ,'CONTACT'
						 ,pVersion
						 ,''
						 ,zBusinessStats
						 ,'view'
						 ,'Population');

	hasPawStrataBeenRun := VersionControl.fHasStrataBeenRun('PAW', 'CONTACT', pversion, 'view', 'Population');

	result := map(
		 (not hasPawStrataBeenRun or pOverwrite) and			pShouldSendToStrata => zBusinessStats
		,(not hasPawStrataBeenRun or pOverwrite) and not	pShouldSendToStrata => outputpaw
		,output('PawV2 Strata Stats have been run for version ' + pversion)
		);

	return result; 

end;