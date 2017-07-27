import STRATA, MXD_MXDocket;

export out_STRATApopulation_stats(string pversion) := function

dDocketBase	:=	MXD_MXDocket.FilesBase.base;

rPopulationStats_MXD_MXDocket := record
	  dDocketBase.geography;  
    CountGroup																	 := count(group);
    rec_id_CountNonZero                          := sum(group,if(dDocketBase.rec_id<>0,1,0));
    geocode_CountNonBlank                        := sum(group,if(dDocketBase.geocode<>'',1,0));
    date_pub_CountNonZero                        := sum(group,if(dDocketBase.date_pub<>0,1,0));
    court_CountNonZero                           := sum(group,if(dDocketBase.court<>u'',1,0));
    court_local_CountNonZero                     := sum(group,if(dDocketBase.court_local<>u'',1,0));
    docket_CountNonZero                          := sum(group,if(dDocketBase.docket<>u'',1,0));
    docket_num_CountNonZero                      := sum(group,if(dDocketBase.docket_num<>u'',1,0));
    docket_year_CountNonZero                     := sum(group,if(dDocketBase.docket_year<>0,1,0));
    caption_CountNonZero                         := sum(group,if(dDocketBase.caption<>u'',1,0));
    nature_CountNonZero                          := sum(group,if(dDocketBase.nature<>u'',1,0));
    nature_type_CountNonZero                     := sum(group,if(dDocketBase.nature_type<>0,1,0));
    naturetypedesc_CountNonBlank                 := sum(group,if(dDocketBase.naturetypedesc<>'',1,0));
    comment_CountNonZero                         := sum(group,if(dDocketBase.comment<>u'',1,0));
    date_hearing_CountNonZero                    := sum(group,if(dDocketBase.date_hearing<>0,1,0));
    partyoriginal_CountNonZero                   := sum(group,if(dDocketBase.partyoriginal<>u'',1,0));
    partyname_CountNonZero                       := sum(group,if(dDocketBase.partyname<>u'',1,0));
    partyAlias_CountNonZero                       := sum(group,if(dDocketBase.partyAlias<>u'',1,0));
    partynumber_CountNonBlank                    := sum(group,if(dDocketBase.partynumber<>'',1,0));
    partyocc_CountNonBlank                       := sum(group,if(dDocketBase.partyocc<>'',1,0));
    partytype_CountNonZero                       := sum(group,if(dDocketBase.partytype<>0,1,0));
    partytypedesc_CountNonBlank                  := sum(group,if(dDocketBase.partytypedesc<>'',1,0));
    entity_id_CountNonZero                       := sum(group,if(dDocketBase.entity_id<>0,1,0));
    orgname_CountNonZero                         := sum(group,if(dDocketBase.orgname<>u'',1,0));
    person_id_CountNonZero                       := sum(group,if(dDocketBase.person_id<>0,1,0));
    firstname_CountNonZero                       := sum(group,if(dDocketBase.firstname<>u'',1,0));
    middlename1_CountNonZero                     := sum(group,if(dDocketBase.middlename1<>u'',1,0));
    middlename2_CountNonZero                     := sum(group,if(dDocketBase.middlename2<>u'',1,0));
    middlename3_CountNonZero                     := sum(group,if(dDocketBase.middlename3<>u'',1,0));
    middlename4_CountNonZero                     := sum(group,if(dDocketBase.middlename4<>u'',1,0));
    middlename5_CountNonZero                     := sum(group,if(dDocketBase.middlename5<>u'',1,0));
    lastname_CountNonZero                        := sum(group,if(dDocketBase.lastname<>u'',1,0));
    matronymic_CountNonZero                      := sum(group,if(dDocketBase.matronymic<>u'',1,0));
    husbandslastname_CountNonZero                := sum(group,if(dDocketBase.husbandslastname<>u'',1,0));
    patronymic_CountNonZero                      := sum(group,if(dDocketBase.patronymic<>u'',1,0));
    gender_CountNonBlank                         := sum(group,if(dDocketBase.gender<>'',1,0));
    full_name_CountNonZero                       := sum(group,if(dDocketBase.full_name<>u'',1,0));
    name_format_CountNonBlank                    := sum(group,if(dDocketBase.name_format<>'',1,0));
    ethnicity_CountNonZero                       := sum(group,if(dDocketBase.ethnicity<>0,1,0));
    ethnicitydesc_CountNonBlank                  := sum(group,if(dDocketBase.ethnicitydesc<>'',1,0));
    process_date_CountNonBlank                   := sum(group,if(dDocketBase.process_date<>'',1,0));
    dt_first_seen_CountNonBlank                  := sum(group,if(dDocketBase.dt_first_seen<>'',1,0));
    dt_last_seen_CountNonBlank                   := sum(group,if(dDocketBase.dt_last_seen<>'',1,0));
    
  end;

dPopulationStats_MXD_MXDocket := table(dDocketBase,rPopulationStats_MXD_MXDocket, geography, few);                                                               

STRATA.createXMLStats(dPopulationStats_MXD_MXDocket,
										'MXD_MXDocket','base',pversion,
										'',resultsOut,'view','population');
		 
 return resultsOut;
 
 end;
 