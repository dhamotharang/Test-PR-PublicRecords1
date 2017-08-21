import STRATA;

dParty	:=	official_records.File_Moxie_Party_Dev;

rPopulationStats_dParty
 :=
  record
    CountGroup                                                     := count(group);
    process_date_CountNonBlank                                     := sum(group,if(dParty.process_date<>'',1,0));
    dParty.vendor;
    dParty.state_origin;
    county_name_CountNonBlank                                      := sum(group,if(dParty.county_name<>'',1,0));
    official_record_key_CountNonBlank                              := sum(group,if(dParty.official_record_key<>'',1,0));
    doc_instrument_or_clerk_filing_num_CountNonBlank               := sum(group,if(dParty.doc_instrument_or_clerk_filing_num<>'',1,0));
    doc_filed_dt_CountNonBlank                                     := sum(group,if(dParty.doc_filed_dt<>'',1,0));
    doc_type_desc_CountNonBlank                                    := sum(group,if(dParty.doc_type_desc<>'',1,0));
    entity_sequence_CountNonBlank                                  := sum(group,if(dParty.entity_sequence<>'',1,0));
    entity_type_cd_CountNonBlank                                   := sum(group,if(dParty.entity_type_cd<>'',1,0));
    entity_type_desc_CountNonBlank                                 := sum(group,if(dParty.entity_type_desc<>'',1,0));
    entity_nm_CountNonBlank                                        := sum(group,if(dParty.entity_nm<>'',1,0));
    entity_nm_format_CountNonBlank                                 := sum(group,if(dParty.entity_nm_format<>'',1,0));
    entity_dob_CountNonBlank                                       := sum(group,if(dParty.entity_dob<>'',1,0));
    entity_ssn_CountNonBlank                                       := sum(group,if(dParty.entity_ssn<>'',1,0));
    title1_CountNonBlank                                           := sum(group,if(dParty.title1<>'',1,0));
    fname1_CountNonBlank                                           := sum(group,if(dParty.fname1<>'',1,0));
    mname1_CountNonBlank                                           := sum(group,if(dParty.mname1<>'',1,0));
    lname1_CountNonBlank                                           := sum(group,if(dParty.lname1<>'',1,0));
    suffix1_CountNonBlank                                          := sum(group,if(dParty.suffix1<>'',1,0));
    pname1_score_CountNonBlank                                     := sum(group,if(dParty.pname1_score<>'',1,0));
    cname1_CountNonBlank                                           := sum(group,if(dParty.cname1<>'',1,0));
    title2_CountNonBlank                                           := sum(group,if(dParty.title2<>'',1,0));
    fname2_CountNonBlank                                           := sum(group,if(dParty.fname2<>'',1,0));
    mname2_CountNonBlank                                           := sum(group,if(dParty.mname2<>'',1,0));
    lname2_CountNonBlank                                           := sum(group,if(dParty.lname2<>'',1,0));
    suffix2_CountNonBlank                                          := sum(group,if(dParty.suffix2<>'',1,0));
    pname2_score_CountNonBlank                                     := sum(group,if(dParty.pname2_score<>'',1,0));
    cname2_CountNonBlank                                           := sum(group,if(dParty.cname2<>'',1,0));
    title3_CountNonBlank                                           := sum(group,if(dParty.title3<>'',1,0));
    fname3_CountNonBlank                                           := sum(group,if(dParty.fname3<>'',1,0));
    mname3_CountNonBlank                                           := sum(group,if(dParty.mname3<>'',1,0));
    lname3_CountNonBlank                                           := sum(group,if(dParty.lname3<>'',1,0));
    suffix3_CountNonBlank                                          := sum(group,if(dParty.suffix3<>'',1,0));
    pname3_score_CountNonBlank                                     := sum(group,if(dParty.pname3_score<>'',1,0));
    cname3_CountNonBlank                                           := sum(group,if(dParty.cname3<>'',1,0));
    title4_CountNonBlank                                           := sum(group,if(dParty.title4<>'',1,0));
    fname4_CountNonBlank                                           := sum(group,if(dParty.fname4<>'',1,0));
    mname4_CountNonBlank                                           := sum(group,if(dParty.mname4<>'',1,0));
    lname4_CountNonBlank                                           := sum(group,if(dParty.lname4<>'',1,0));
    suffix4_CountNonBlank                                          := sum(group,if(dParty.suffix4<>'',1,0));
    pname4_score_CountNonBlank                                     := sum(group,if(dParty.pname4_score<>'',1,0));
    cname4_CountNonBlank                                           := sum(group,if(dParty.cname4<>'',1,0));
    title5_CountNonBlank                                           := sum(group,if(dParty.title5<>'',1,0));
    fname5_CountNonBlank                                           := sum(group,if(dParty.fname5<>'',1,0));
    mname5_CountNonBlank                                           := sum(group,if(dParty.mname5<>'',1,0));
    lname5_CountNonBlank                                           := sum(group,if(dParty.lname5<>'',1,0));
    suffix5_CountNonBlank                                          := sum(group,if(dParty.suffix5<>'',1,0));
    pname5_score_CountNonBlank                                     := sum(group,if(dParty.pname5_score<>'',1,0));
    cname5_CountNonBlank                                           := sum(group,if(dParty.cname5<>'',1,0));
    master_party_type_cd_CountNonBlank                             := sum(group,if(dParty.master_party_type_cd<>'',1,0));
  end;

dPopulationStats_dParty	:= table(dParty,
								 rPopulationStats_dParty,
								 vendor,state_origin,
								 few
								);

STRATA.createXMLStats(dPopulationStats_dParty,
					  'OfficialRecords',
					  'Party',
					  official_records.Version_Development,
					  '',
					  zRunPartyStats,
					  'view',
					  'Population'
					 );

export Out_Moxie_Party_Dev_Stats	:=	zRunPartyStats;