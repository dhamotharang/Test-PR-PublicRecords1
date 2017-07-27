import emerges, Address, ut, lib_stringlib;

Old_base := VotersV2.File_Voters_Old_Base;

Layout_Clean_Voters := record
   VotersV2.Layouts_Voters.Layout_Voters_Common;
end;

Layout_Clean_Voters getCleanVoters(Old_base l) := transform
  string73 tempName := stringlib.StringToUpperCase(if(trim(trim(l.fname_in,left,right) + ' ' +
        											       trim(l.lname_in,left,right),left,right) <> '',
													  Address.CleanPersonFML73(trim(trim(l.fname_in,left,right) + ' ' +
														                            trim(l.mname_in,left,right) + ' ' +
																			        trim(l.lname_in,left,right) + ' ' +
																				    trim(l.name_suffix_in,left,right),left,right)),
												      ''));
															
  string73 tempMaidenPri := stringlib.StringToUpperCase(if(trim(l.maiden_prior,left,right) <> '',
                                                           Address.CleanPerson73(trim(l.maiden_prior,left,right)),''));
	
  string182 tempAddress := stringlib.StringToUpperCase(if(trim(l.resAddr1,left,right)  <> '' or 
	                                                      trim(l.resAddr2,left,right)  <> '' or
														  trim(l.res_city,left,right)  <> '' or
														  trim(l.res_state,left,right) <> '' or
														  trim(l.res_zip,left,right)   <> '',
														  Address.CleanAddress182(trim(trim(l.resAddr1,left,right) + ' ' + 
														                               trim(l.resAddr2,left,right),left,right),
														                          trim(trim(l.res_city,left,right) + ', ' +
															                           trim(l.res_state,left,right) + ' ' +
																				       lib_stringlib.stringlib.stringfilter(l.res_zip,'0123456789'),left,right)),
														  ''));

  string182 tempMailAddress := stringlib.StringToUpperCase(if(trim(l.mail_addr1,left,right) <> '' or 
	                                                          trim(l.mail_addr2,left,right) <> '' or
															  trim(l.mail_city,left,right)  <> '' or
															  trim(l.mail_state,left,right) <> '' or
															  trim(l.mail_zip,left,right)   <> '',
														      Address.CleanAddress182(trim(trim(l.mail_addr1,left,right) + ' ' + 
														                                   trim(l.mail_addr2,left,right),left,right),
														                              trim(trim(l.mail_city,left,right) + ', ' +
																			               trim(l.mail_state,left,right) + ' ' +
																				           lib_stringlib.stringlib.stringfilter(l.mail_zip,'0123456789'),left,right)),
															  ''));
	
  self.vtid                 := 0;
  self.title                := tempName[1..5];
  self.fname                := tempName[6..25];
  self.mname                := tempName[26..45];
  self.lname                := tempName[46..65];
  self.name_suffix          := tempName[66..70];
  self.name_score           := tempName[71..73];
  self.clean_maiden_pri     := tempMaidenPri[46..65];
  self.prim_range           := tempAddress[1..10];
  self.predir               := tempAddress[11..12];
  self.prim_name            := tempAddress[13..40];
  self.addr_suffix          := tempAddress[41..44];
  self.postdir              := tempAddress[45..46];
  self.unit_desig           := tempAddress[47..56];
  self.sec_range            := tempAddress[57..64];
  self.p_city_name          := tempAddress[65..89];
  self.v_city_name          := tempAddress[90..114];
  self.st                   := if(tempAddress[115..116] = '',
                                  ziplib.ZipToState2(tempAddress[117..121]),
                                                     tempAddress[115..116]);
  self.zip                  := tempAddress[117..121];
  self.zip4                 := tempAddress[122..125];
  self.cart                 := tempAddress[126..129];
  self.cr_sort_sz           := tempAddress[130];
  self.lot                  := tempAddress[131..134];
  self.lot_order            := tempAddress[135];
  self.dpbc                 := tempAddress[136..137];
  self.chk_digit            := tempAddress[138];
  self.rec_type             := tempAddress[139..140];
  self.ace_fips_st          := tempAddress[141..142];
  self.fips_county          := tempAddress[143..145];
  self.geo_lat              := tempAddress[146..155];
  self.geo_long             := tempAddress[156..166];
  self.msa                  := tempAddress[167..170];
  self.geo_blk              := tempAddress[171..177];
  self.geo_match            := tempAddress[178];
  self.err_stat             := tempAddress[179..182];
  //self.county_name          := '';
  self.mail_prim_range      := tempMailAddress[1..10];
  self.mail_predir          := tempMailAddress[11..12];
  self.mail_prim_name       := tempMailAddress[13..40];
  self.mail_addr_suffix     := tempMailAddress[41..44];
  self.mail_postdir         := tempMailAddress[45..46];
  self.mail_unit_desig      := tempMailAddress[47..56];
  self.mail_sec_range       := tempMailAddress[57..64];
  self.mail_p_city_name     := tempMailAddress[65..89];
  self.mail_v_city_name     := tempMailAddress[90..114];
  self.mail_st              := if(tempMailAddress[115..116] = '',
                                   ziplib.ZipToState2(tempMailAddress[117..121]),
                                   tempMailAddress[115..116]);
  self.mail_ace_zip         := tempMailAddress[117..121];
  self.mail_zip4            := tempMailAddress[122..125];
  self.mail_cart            := tempMailAddress[126..129];
  self.mail_cr_sort_sz      := tempMailAddress[130];
  self.mail_lot             := tempMailAddress[131..134];
  self.mail_lot_order       := tempMailAddress[135];
  self.mail_dpbc            := tempMailAddress[136..137];
  self.mail_chk_digit       := tempMailAddress[138];
  self.mail_rec_type        := tempMailAddress[139..140];
  self.mail_ace_fips_st     := tempMailAddress[141..142];
  self.mail_fips_county     := tempMailAddress[143..145];
  self.mail_geo_lat         := tempMailAddress[146..155];
  self.mail_geo_long        := tempMailAddress[156..166];
  self.mail_msa             := tempMailAddress[167..170];
  self.mail_geo_blk         := tempMailAddress[171..177];
  self.mail_geo_match       := tempMailAddress[178];
  self.mail_err_stat        := tempMailAddress[179..182];
  self.process_date         := lib_stringlib.stringlib.stringfilter(l.file_acquired_date,'0123456789');
  self.date_first_seen      := lib_stringlib.stringlib.stringfilter(l.date_first_seen,'0123456789');
  self.date_last_seen       := lib_stringlib.stringlib.stringfilter(l.date_last_seen,'0123456789');
  //self.score                := '0';
  //self.best_ssn             := '0';
  //self.did_out              := '0';
  self.source               := 'EMERGES';
  self.file_id              := 'VOTE'; 
  self.vendor_id            := trim(l.vendor_id,left,right);
  self.source_state         := stringlib.StringToUpperCase(trim(l.source_state,left,right));
  self.source_code          := stringlib.StringToUpperCase(trim(l.source_code,left,right));
  self.use_code             := l._use;
  self.prefix_title         := stringlib.StringToUpperCase(trim(l.title_in,left,right));
  self.last_name            := stringlib.StringToUpperCase(trim(l.lname_in,left,right));
  self.first_name           := stringlib.StringToUpperCase(trim(l.fname_in,left,right));
  self.middle_name          := stringlib.StringToUpperCase(trim(l.mname_in,left,right));
  self.maiden_prior         := stringlib.StringToUpperCase(trim(l.maiden_prior,left,right));
  self.name_suffix_in       := stringlib.StringToUpperCase(trim(l.name_suffix_in,left,right));
  self.voterfiller          := stringlib.StringToUpperCase(trim(l.votefiller,left,right));
  self.source_voterId       := stringlib.StringToUpperCase(trim(l.source_voterId,left,right));
  self.dob                  := lib_stringlib.stringlib.stringfilter(l.dob,'0123456789');
  self.ageCat               := stringlib.StringToUpperCase(trim(l.ageCat,left,right));
  self.ageCat_exp           := '';
  self.headHousehold        := stringlib.StringToUpperCase(trim(l.headHousehold,left,right));
  self.place_of_birth       := stringlib.StringToUpperCase(trim(l.place_of_birth,left,right));
  self.occupation           := stringlib.StringToUpperCase(trim(l.occupation,left,right));
  self.maiden_name          := stringlib.StringToUpperCase(trim(l.maiden_name,left,right));
  self.motorVoterId         := stringlib.StringToUpperCase(trim(l.motorVoterId,left,right));
  self.regSource            := stringlib.StringToUpperCase(trim(l.regSource,left,right));
  self.regDate              := stringlib.StringToUpperCase(trim(l.regDate,left,right));
  self.race                 := stringlib.StringToUpperCase(trim(l.race,left,right));
  self.race_exp             := '';
  self.gender               := stringlib.StringToUpperCase(trim(l.gender,left,right));
  self.political_party      := stringlib.StringToUpperCase(trim(l.poliparty,left,right));
  self.politicalparty_exp   := '';
  self.phone                := lib_stringlib.stringlib.stringfilter(l.phone,'0123456789');
  self.work_phone           := lib_stringlib.stringlib.stringfilter(l.work_phone,'0123456789');
  self.other_phone          := lib_stringlib.stringlib.stringfilter(l.other_phone,'0123456789');
  self.active_status        := stringlib.StringToUpperCase(trim(l.active_status,left,right));
  self.active_status_exp    := '';
  self.GenderSurNamGuess    := stringlib.StringToUpperCase(trim(l.votefiller2,left,right));
  self.active_other         := stringlib.StringToUpperCase(trim(l.active_other,left,right));
  self.voter_status         := stringlib.StringToUpperCase(trim(l.voterStatus,left,right));
  self.voter_status_exp     := '';
  self.res_Addr1            := stringlib.StringToUpperCase(trim(l.resAddr1,left,right));
  self.res_Addr2            := stringlib.StringToUpperCase(trim(l.resAddr2,left,right));
  self.res_city             := stringlib.StringToUpperCase(trim(l.res_city,left,right));
  self.res_state            := stringlib.StringToUpperCase(trim(l.res_state,left,right));
  self.res_zip              := lib_stringlib.stringlib.stringfilter(l.res_zip,'0123456789');
  self.res_county           := stringlib.StringToUpperCase(trim(l.res_county,left,right));
  self.mail_addr1           := stringlib.StringToUpperCase(trim(l.mail_addr1,left,right));
  self.mail_addr2           := stringlib.StringToUpperCase(trim(l.mail_addr2,left,right));
  self.mail_city            := stringlib.StringToUpperCase(trim(l.mail_city,left,right));
  self.mail_state           := stringlib.StringToUpperCase(trim(l.mail_state,left,right));
  self.mail_zip             := lib_stringlib.stringlib.stringfilter(l.mail_zip,'0123456789');
  self.mail_county          := stringlib.StringToUpperCase(trim(l.mail_county,left,right));
  self.addr_filler1         := stringlib.StringToUpperCase(trim(l.addr_filler1,left,right));
  self.addr_filler2         := stringlib.StringToUpperCase(trim(l.addr_filler2,left,right));
  self.city_filler          := stringlib.StringToUpperCase(trim(l.city_filler,left,right));
  self.state_filler         := stringlib.StringToUpperCase(trim(l.state_filler,left,right));
  self.zip_filler           := trim(l.zip_filler,left,right);
  self.TimeZoneTbl          := stringlib.StringToUpperCase(trim(l.county_filler,left,right));
  self.towncode             := stringlib.StringToUpperCase(trim(l.towncode,left,right));
  self.distcode             := stringlib.StringToUpperCase(trim(l.distcode,left,right));
  self.countycode           := stringlib.StringToUpperCase(trim(l.countycode,left,right));
  self.schoolcode           := stringlib.StringToUpperCase(trim(l.schoolcode,left,right));
  self.cityInOut            := stringlib.StringToUpperCase(trim(l.cityInOut,left,right));
  self.spec_dist1           := stringlib.StringToUpperCase(trim(l.spec_dist1,left,right));
  self.spec_dist2           := stringlib.StringToUpperCase(trim(l.spec_dist2,left,right));
  self.precinct1            := stringlib.StringToUpperCase(trim(l.precinct1,left,right));
  self.precinct2            := stringlib.StringToUpperCase(trim(l.precinct2,left,right));
  self.precinct3            := stringlib.StringToUpperCase(trim(l.precinct3,left,right));
  self.villagePrecinct      := stringlib.StringToUpperCase(trim(l.villagePrecinct,left,right));
  self.schoolPrecinct       := stringlib.StringToUpperCase(trim(l.schoolPrecinct,left,right));
  self.ward                 := stringlib.StringToUpperCase(trim(l.ward,left,right));
  self.precinct_cityTown    := stringlib.StringToUpperCase(trim(l.precinct_cityTown,left,right));
  self.ANCSMDinDC           := stringlib.StringToUpperCase(trim(l.ANCSMDinDC,left,right));
  self.cityCouncilDist      := stringlib.StringToUpperCase(trim(l.cityCouncilDist,left,right));
  self.countyCommDist       := stringlib.StringToUpperCase(trim(l.countyCommDist,left,right));
  self.stateHouse           := stringlib.StringToUpperCase(trim(l.stateHouse,left,right));
  self.stateSenate          := stringlib.StringToUpperCase(trim(l.stateSenate,left,right));
  self.USHouse              := stringlib.StringToUpperCase(trim(l.USHouse,left,right));
  self.elemSchoolDist       := stringlib.StringToUpperCase(trim(l.elemSchoolDist,left,right));
  self.schoolDist           := stringlib.StringToUpperCase(trim(l.schoolDist,left,right));
  self.schoolFiller         := stringlib.StringToUpperCase(trim(l.schoolFiller,left,right));
  self.CommCollDist         := stringlib.StringToUpperCase(trim(l.CommCollDist,left,right));
  self.dist_filler          := stringlib.StringToUpperCase(trim(l.dist_filler,left,right));
  self.municipal            := stringlib.StringToUpperCase(trim(l.municipal,left,right));
  self.VillageDist          := stringlib.StringToUpperCase(trim(l.VillageDist,left,right));
  self.PoliceJury           := stringlib.StringToUpperCase(trim(l.PoliceJury,left,right));
  self.PoliceDist           := stringlib.StringToUpperCase(trim(l.PoliceDist,left,right));
  self.PublicServComm       := stringlib.StringToUpperCase(trim(l.PublicServComm,left,right));
  self.Rescue               := stringlib.StringToUpperCase(trim(l.Rescue,left,right));
  self.Fire                 := stringlib.StringToUpperCase(trim(l.Fire,left,right));
  self.Sanitary             := stringlib.StringToUpperCase(trim(l.Sanitary,left,right));
  self.SewerDist            := stringlib.StringToUpperCase(trim(l.SewerDist,left,right));
  self.WaterDist            := stringlib.StringToUpperCase(trim(l.WaterDist,left,right));
  self.MosquitoDist         := stringlib.StringToUpperCase(trim(l.MosquitoDist,left,right));
  self.TaxDist              := stringlib.StringToUpperCase(trim(l.TaxDist,left,right));
  self.SupremeCourt         := stringlib.StringToUpperCase(trim(l.SupremeCourt,left,right));
  self.JusticeOfPeace       := stringlib.StringToUpperCase(trim(l.JusticeOfPeace,left,right));
  self.JudicialDist         := stringlib.StringToUpperCase(trim(l.JudicialDist,left,right));
  self.SuperiorCtDist       := stringlib.StringToUpperCase(trim(l.SuperiorCtDist,left,right));
  self.AppealsCt            := stringlib.StringToUpperCase(trim(l.AppealsCt,left,right));
  self.CourtFIller          := stringlib.StringToUpperCase(trim(l.CourtFIller,left,right));  
  self.CassAddrTypTbl       := '';
  self.CassDelivPointCd     := '';
  self.CassCarrierRteTbl    := '';
  self.BlkGrpEnumDist       := '';
  self.CongressionalDist    := '';
  self.Lattitude            := '';
  self.CountyFips           := '';
  self.CensusTract          := '';
  self.FipsStCountyCd       := '';
  self.Longitude            := '';  
  self.ContributorParty     := stringlib.StringToUpperCase(trim(l.ContributorParty,left,right));
  self.RecipientParty       := stringlib.StringToUpperCase(trim(l.RecptParty,left,right));
  self.DateOfContr          := stringlib.StringToUpperCase(trim(l.DateOfContr,left,right));
  self.DollarAmt            := stringlib.StringToUpperCase(trim(l.DollarAmt,left,right));
  self.OfficeContTo         := stringlib.StringToUpperCase(trim(l.OfficeContTo,left,right));
  self.CumulDollarAmt       := stringlib.StringToUpperCase(trim(l.CumulDollarAmt,left,right));
  self.ContFiller1          := stringlib.StringToUpperCase(trim(l.ContFiller1,left,right));
  self.ContFiller2          := stringlib.StringToUpperCase(trim(l.ContFiller2,left,right));
  self.ContType             := stringlib.StringToUpperCase(trim(l.ContType,left,right));
  self.ContFiller4          := stringlib.StringToUpperCase(trim(l.ContFiller3,left,right));
  self.PresPrimary2008      := ''; 
  self.Primary2007          := ''; 
  self.Special12007         := ''; 
  self.Other2007            := ''; 
  self.Special22007         := ''; 
  self.General2007          := ''; 
  self.Primary2006          := ''; 
  self.Special12006         := ''; 
  self.Other2006            := ''; 
  self.Special22006         := ''; 
  self.General2006          := ''; 
  self.Primary2005          := ''; 
  self.Special12005         := ''; 
  self.Other2005            := ''; 
  self.Special22005         := ''; 
  self.General2005          := ''; 
  self.Primary2004          := ''; 
  self.Special12004         := ''; 
  self.Other2004            := ''; 
  self.Special22004         := ''; 
  self.General2004          := ''; 
  self.PresPrimary2004      := ''; 
  self.Primary2003          := ''; 
  self.Special12003         := ''; 
  self.Other2003            := ''; 
  self.Special22003         := ''; 
  self.General2003          := '';  
  self.Primary2002          := stringlib.StringToUpperCase(trim(l.Primary02,left,right));
  self.Special12002         := stringlib.StringToUpperCase(trim(l.Special02,left,right));
  self.Other2002            := stringlib.StringToUpperCase(trim(l.Other02,left,right));
  self.Special22002         := stringlib.StringToUpperCase(trim(l.Special202,left,right));
  self.General2002          := stringlib.StringToUpperCase(trim(l.General02,left,right));
  self.Primary2001          := stringlib.StringToUpperCase(trim(l.Primary01,left,right));
  self.Special2001          := stringlib.StringToUpperCase(trim(l.Special01,left,right));
  self.Other2001            := stringlib.StringToUpperCase(trim(l.Other01,left,right));
  self.Special22001         := stringlib.StringToUpperCase(trim(l.Special201,left,right));
  self.General2001          := stringlib.StringToUpperCase(trim(l.General01,left,right));
  self.PresPrimary2000      := stringlib.StringToUpperCase(trim(l.Pres00,left,right));  
  self.Primary2000          := stringlib.StringToUpperCase(trim(l.Primary00,left,right));
  self.Special2000          := stringlib.StringToUpperCase(trim(l.Special00,left,right));
  self.Other2000            := stringlib.StringToUpperCase(trim(l.Other00,left,right));
  self.Special22000         := stringlib.StringToUpperCase(trim(l.Special200,left,right));
  self.General2000          := stringlib.StringToUpperCase(trim(l.General00,left,right));    
  self.Primary1999          := stringlib.StringToUpperCase(trim(l.Primary99,left,right));
  self.Special1999          := stringlib.StringToUpperCase(trim(l.Special99,left,right));
  self.Other1999            := stringlib.StringToUpperCase(trim(l.Other99,left,right));
  self.Special21999         := stringlib.StringToUpperCase(trim(l.Special299,left,right));
  self.General1999          := stringlib.StringToUpperCase(trim(l.General99,left,right));
  self.Primary1998          := stringlib.StringToUpperCase(trim(l.Primary98,left,right));
  self.Special1998          := stringlib.StringToUpperCase(trim(l.Special98,left,right));
  self.Other1998            := stringlib.StringToUpperCase(trim(l.Other98,left,right));
  self.Special21998         := stringlib.StringToUpperCase(trim(l.Special298,left,right));
  self.General1998          := stringlib.StringToUpperCase(trim(l.General98,left,right));
  self.Primary1997          := stringlib.StringToUpperCase(trim(l.Primary97,left,right));
  self.Special1997          := stringlib.StringToUpperCase(trim(l.Special97,left,right));
  self.Other1997            := stringlib.StringToUpperCase(trim(l.Other97,left,right));
  self.Special21997         := stringlib.StringToUpperCase(trim(l.Special297,left,right));
  self.General1997          := stringlib.StringToUpperCase(trim(l.General97,left,right));
  self.PresPrimary1996      := stringlib.StringToUpperCase(trim(l.Pres96,left,right));
  self.Primary1996          := stringlib.StringToUpperCase(trim(l.Primary96,left,right));
  self.Special1996          := stringlib.StringToUpperCase(trim(l.Special96,left,right));
  self.Other1996            := stringlib.StringToUpperCase(trim(l.Other96,left,right));
  self.Special21996         := stringlib.StringToUpperCase(trim(l.Special296,left,right));
  self.General1996          := stringlib.StringToUpperCase(trim(l.General96,left,right));
  self.LastDateVote         := stringlib.StringToUpperCase(trim(l.LastDayVote,left,right));
  self.MiscVoteHist         := '';
  self := l;
end;

Cleaned_Old_Base := project(Old_base, getCleanVoters(left),local);

export Cleaned_Voters_Old_Base := Cleaned_Old_Base;// : persist(VotersV2.Cluster+'voters::cleaned_old_base');