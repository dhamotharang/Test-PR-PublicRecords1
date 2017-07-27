import Address, ut, lib_stringlib;

export Cleaned_Voters(string source_state, string filedate) := function

	In_Voters_File  := VotersV2.File_Voters_In(source_state, filedate);

	In_Voter_Layout := VotersV2.Layout_Voters_In;

	Layout_Clean_Voters := record
		 VotersV2.Layouts_Voters.Layout_Voters_Common;
	end;

	Layout_Clean_Voters getCleanVoters(In_Voters_File l) := transform
		string73 tempName := stringlib.StringToUpperCase(if(trim(trim(l.first_name,left,right) + ' ' +
															trim(l.last_name,left,right),left,right) <> '',
															Address.CleanPersonFML73(trim(trim(l.first_name,left,right) + ' ' +
																						  trim(l.middle_name,left,right) + ' ' +
												                                          trim(l.last_name,left,right) + ' ' +
												       									  trim(l.name_suffix,left,right),left,right)),
															''));
																
		string73 tempMaidenPri := stringlib.StringToUpperCase(if(trim(l.maiden_prior,left,right) <> '',
																 Address.CleanPerson73(trim(l.maiden_prior,left,right)),''));
																														 
		string182 tempAddress := stringlib.StringToUpperCase(if(trim(l.res_Addr1,left,right) <> '' or 
																trim(l.res_Addr2,left,right) <> '' or
																trim(l.res_city,left,right)  <> '' or
																trim(l.res_state,left,right) <> '' or
																trim(l.res_zip,left,right)   <> '',
															    Address.CleanAddress182(trim(trim(l.res_Addr1,left,right) + ' ' + 
																							 trim(l.res_Addr2,left,right),left,right),
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
		self.title			      := tempName[1..5];
		self.fname			      := tempName[6..25];
		self.mname			      := tempName[26..45];
		self.lname			      := tempName[46..65];
		self.name_suffix	      := tempName[66..70];
		self.name_score			  := tempName[71..73];
		self.clean_maiden_pri     := tempMaidenPri[46..65];
		self.prim_range    		  := tempAddress[1..10];
		self.predir 	      	  := tempAddress[11..12];
		self.prim_name 	  		  := tempAddress[13..40];
		self.addr_suffix   		  := tempAddress[41..44];
		self.postdir 	    	  := tempAddress[45..46];
		self.unit_desig 	  	  := tempAddress[47..56];
		self.sec_range 	  		  := tempAddress[57..64];
		self.p_city_name	  	  := tempAddress[65..89];
		self.v_city_name	  	  := tempAddress[90..114];
		self.st 			      := if(tempAddress[115..116] = '',
									    ziplib.ZipToState2(tempAddress[117..121]),
										                   tempAddress[115..116]);
		self.zip 		      	  := tempAddress[117..121];
		self.zip4 		      	  := tempAddress[122..125];
		self.cart 		      	  := tempAddress[126..129];
		self.cr_sort_sz 	 	  := tempAddress[130];
		self.lot 		      	  := tempAddress[131..134];
		self.lot_order 	  		  := tempAddress[135];
		self.dpbc 		      	  := tempAddress[136..137];
		self.chk_digit 	  		  := tempAddress[138];
		self.rec_type		  	  := tempAddress[139..140];
		self.ace_fips_st	  	  := tempAddress[141..142];
		self.fips_county 	      := tempAddress[143..145];
		self.geo_lat 	    	  := tempAddress[146..155];
		self.geo_long 	    	  := tempAddress[156..166];
		self.msa 		      	  := tempAddress[167..170];
		self.geo_blk              := tempAddress[171..177];
		self.geo_match 	  	      := tempAddress[178];
		self.err_stat 	          := tempAddress[179..182];
		//self.county_name        := tempMailAddress[1..10];
		self.mail_prim_range      := tempMailAddress[1..10];
		self.mail_predir 	      := tempMailAddress[11..12];
		self.mail_prim_name 	  := tempMailAddress[13..40];
		self.mail_addr_suffix     := tempMailAddress[41..44];
		self.mail_postdir 	      := tempMailAddress[45..46];
		self.mail_unit_desig 	  := tempMailAddress[47..56];
		self.mail_sec_range 	  := tempMailAddress[57..64];
		self.mail_p_city_name	  := tempMailAddress[65..89];
		self.mail_v_city_name	  := tempMailAddress[90..114];
		self.mail_st 			  := if(tempMailAddress[115..116] = '',
									    ziplib.ZipToState2(tempMailAddress[117..121]),
										                   tempMailAddress[115..116]);
		self.mail_ace_zip 		  := tempMailAddress[117..121];
		self.mail_zip4 		      := tempMailAddress[122..125];
		self.mail_cart 		      := tempMailAddress[126..129];
		self.mail_cr_sort_sz 	  := tempMailAddress[130];
		self.mail_lot 		      := tempMailAddress[131..134];
		self.mail_lot_order 	  := tempMailAddress[135];
		self.mail_dpbc 		      := tempMailAddress[136..137];
		self.mail_chk_digit 	  := tempMailAddress[138];
		self.mail_rec_type		  := tempMailAddress[139..140];
		self.mail_ace_fips_st	  := tempMailAddress[141..142];
		self.mail_fips_county 	  := tempMailAddress[143..145];
		self.mail_geo_lat 	      := tempMailAddress[146..155];
		self.mail_geo_long 	      := tempMailAddress[156..166];
		self.mail_msa 		      := tempMailAddress[167..170];
		self.mail_geo_blk         := tempMailAddress[171..177];
		self.mail_geo_match 	  := tempMailAddress[178];
		self.mail_err_stat 	      := tempMailAddress[179..182];
		self.process_date		  := lib_stringlib.stringlib.stringfilter(l.file_acquired_date,'0123456789');
		self.date_first_seen      := self.process_date;
		self.date_last_seen       := self.process_date;
		self.source               := 'EMERGES';
		self.file_id              := 'VOTE'; 
		self.vendor_id            := trim(l.EMID_number,left,right);
		self.source_state         := if (trim(l.state_code,left,right) = '', 
										 stringlib.StringToUpperCase(trim(source_state, left, right)),
										 stringlib.StringToUpperCase(trim(l.state_code, left, right)));
		self.source_code          := stringlib.StringToUpperCase(trim(l.source_code,left,right));
		self.prefix_title         := stringlib.StringToUpperCase(trim(l.prefix_title,left,right));
		self.last_name            := stringlib.StringToUpperCase(trim(l.last_name,left,right));
		self.first_name           := stringlib.StringToUpperCase(trim(l.first_name,left,right));
		self.middle_name          := stringlib.StringToUpperCase(trim(l.middle_name,left,right));
		self.maiden_prior         := stringlib.StringToUpperCase(trim(l.maiden_prior,left,right));
		self.name_suffix_in       := stringlib.StringToUpperCase(trim(l.name_suffix,left,right));
		self.voterfiller          := stringlib.StringToUpperCase(trim(l.voterfiller,left,right));
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
		self.political_party      := stringlib.StringToUpperCase(trim(l.political_party,left,right));
		self.politicalparty_exp   := '';
		self.phone                := lib_stringlib.stringlib.stringfilter(l.home_phone,'0123456789');
		self.work_phone           := lib_stringlib.stringlib.stringfilter(l.work_phone,'0123456789');
		self.other_phone          := lib_stringlib.stringlib.stringfilter(l.other_phone,'0123456789');
		self.active_status        := stringlib.StringToUpperCase(trim(l.active_status,left,right));
		self.active_status_exp    := '';
		self.GenderSurNamGuess    := stringlib.StringToUpperCase(trim(l.GenderSurNamGuess,left,right));
		self.active_other         := stringlib.StringToUpperCase(trim(l.vfiller1,left,right));
		self.voter_status  		  := stringlib.StringToUpperCase(trim(l.voter_status,left,right));
		self.voter_status_exp     := '';
		self.res_Addr1            := stringlib.StringToUpperCase(trim(l.res_Addr1,left,right));
		self.res_Addr2            := stringlib.StringToUpperCase(trim(l.res_Addr2,left,right));
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
		self.addr_filler1         := stringlib.StringToUpperCase(trim(l.CassAddr1,left,right));
		self.addr_filler2         := stringlib.StringToUpperCase(trim(l.CassAddr2,left,right));
		self.city_filler          := stringlib.StringToUpperCase(trim(l.CassCity,left,right));
		self.state_filler         := stringlib.StringToUpperCase(trim(l.CassState,left,right));
		self.zip_filler           := trim(l.CassZip,left,right);
		self.TimeZoneTbl          := stringlib.StringToUpperCase(trim(l.TimeZoneTbl,left,right));
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
		self.CassAddrTypTbl       := stringlib.StringToUpperCase(trim(l.CassAddrTypTbl,left,right));
		self.CassDelivPointCd     := stringlib.StringToUpperCase(trim(l.CassDelivPointCd,left,right));
		self.CassCarrierRteTbl    := stringlib.StringToUpperCase(trim(l.CassCarrierRteTbl,left,right));
		self.BlkGrpEnumDist       := stringlib.StringToUpperCase(trim(l.BlkGrpEnumDist,left,right));
		self.CongressionalDist    := stringlib.StringToUpperCase(trim(l.CongressionalDist,left,right));
		self.Lattitude            := stringlib.StringToUpperCase(trim(l.Lattitude,left,right));
		self.CountyFips           := stringlib.StringToUpperCase(trim(l.CountyFips,left,right));
		self.CensusTract          := stringlib.StringToUpperCase(trim(l.CensusTract,left,right));
		self.FipsStCountyCd       := stringlib.StringToUpperCase(trim(l.FipsStCountyCd,left,right));
		self.Longitude            := stringlib.StringToUpperCase(trim(l.Longitude,left,right));
		self.ContributorParty     := '';     // old base fields
		self.RecipientParty       := '';     // old base fields
		self.DateOfContr          := '';     // old base fields
		self.DollarAmt            := '';     // old base fields
		self.OfficeContTo         := '';     // old base fields
		self.CumulDollarAmt       := '';     // old base fields
		self.ContFiller1          := '';     // old base fields  
		self.ContFiller2          := '';     // old base fields
		self.ContType             := '';     // old base fields
		self.ContFiller4          := '';     // old base fields
		self.PresPrimary2008      := stringlib.StringToUpperCase(trim(l.PresPrimary2008,left,right));
		self.Primary2007          := stringlib.StringToUpperCase(trim(l.Primary2007,left,right));
		self.Special12007         := stringlib.StringToUpperCase(trim(l.Special12007,left,right));
		self.Other2007            := stringlib.StringToUpperCase(trim(l.Other2007,left,right));
		self.Special22007         := stringlib.StringToUpperCase(trim(l.Special22007,left,right));
		self.General2007          := stringlib.StringToUpperCase(trim(l.General2007,left,right));
		self.Primary2006          := stringlib.StringToUpperCase(trim(l.Primary2006,left,right));
		self.Special12006         := stringlib.StringToUpperCase(trim(l.Special12006,left,right));
		self.Other2006            := stringlib.StringToUpperCase(trim(l.Other2006,left,right));
		self.Special22006         := stringlib.StringToUpperCase(trim(l.Special22006,left,right));
		self.General2006          := stringlib.StringToUpperCase(trim(l.General2006,left,right));
		self.Primary2005          := stringlib.StringToUpperCase(trim(l.Primary2005,left,right));
		self.Special12005         := stringlib.StringToUpperCase(trim(l.Special2005,left,right));
		self.Other2005            := stringlib.StringToUpperCase(trim(l.Other2005,left,right));
		self.Special22005         := stringlib.StringToUpperCase(trim(l.Special22005,left,right));
		self.General2005          := stringlib.StringToUpperCase(trim(l.General2005,left,right));
		self.PresPrimary2004      := stringlib.StringToUpperCase(trim(l.PresPrimary2004,left,right));
		self.Primary2004          := stringlib.StringToUpperCase(trim(l.Primary2004,left,right));
		self.Special12004         := stringlib.StringToUpperCase(trim(l.Special12004,left,right));
		self.Other2004            := stringlib.StringToUpperCase(trim(l.Other2004,left,right));
		self.Special22004         := stringlib.StringToUpperCase(trim(l.Special22004,left,right));
		self.General2004          := stringlib.StringToUpperCase(trim(l.General2004,left,right));  
		self.Primary2003          := stringlib.StringToUpperCase(trim(l.Primary2003,left,right));
		self.Special12003         := stringlib.StringToUpperCase(trim(l.Special12003,left,right));
		self.Other2003            := stringlib.StringToUpperCase(trim(l.Other2003,left,right));
		self.Special22003         := stringlib.StringToUpperCase(trim(l.Special22003,left,right));
		self.General2003          := stringlib.StringToUpperCase(trim(l.General2003,left,right));
		self.Primary2002          := stringlib.StringToUpperCase(trim(l.Primary2002,left,right));
		self.Special12002         := stringlib.StringToUpperCase(trim(l.Special2002,left,right));
		self.Other2002            := stringlib.StringToUpperCase(trim(l.Other2002,left,right));
		self.Special22002         := stringlib.StringToUpperCase(trim(l.Special22002,left,right));
		self.General2002          := stringlib.StringToUpperCase(trim(l.General2002,left,right));
		self.Primary2001          := stringlib.StringToUpperCase(trim(l.Primary2001,left,right));
		self.Special2001          := '';     // old base fields
		self.Other2001            := '';     // old base fields
		self.Special22001         := '';     // old base fields
		self.General2001          := stringlib.StringToUpperCase(trim(l.General2001,left,right));
		self.PresPrimary2000      := stringlib.StringToUpperCase(trim(l.PresPrimary2000,left,right));
		self.Primary2000          := stringlib.StringToUpperCase(trim(l.Primary2000,left,right));
		self.Special2000          := '';     // old base fields
		self.Other2000            := '';     // old base fields
		self.Special22000         := '';     // old base fields
		self.General2000          := stringlib.StringToUpperCase(trim(l.General2000,left,right));
		self.Primary1999          := '';     // old base fields
		self.Special1999          := '';     // old base fields
		self.Other1999            := '';     // old base fields
		self.Special21999         := '';     // old base fields
		self.General1999          := '';     // old base fields
		self.Primary1998          := '';     // old base fields
		self.Special1998          := '';     // old base fields
		self.Other1998            := '';     // old base fields
		self.Special21998         := '';     // old base fields
		self.General1998          := '';     // old base fields
		self.Primary1997          := '';     // old base fields
		self.Special1997          := '';     // old base fields
		self.Other1997            := '';     // old base fields
		self.Special21997         := '';     // old base fields
		self.General1997          := '';     // old base fields
		self.PresPrimary1996      := '';     // old base fields
		self.Primary1996          := '';     // old base fields
		self.Special1996          := '';     // old base fields
		self.Other1996            := '';     // old base fields
		self.Special21996         := '';     // old base fields
		self.General1996          := '';     // old base fields
		self.LastDateVote         := stringlib.StringToUpperCase(trim(l.LastDateVote,left,right));
		self                      := l;
	end;

	Cleaned_Voters_File := project(In_Voters_File, getCleanVoters(left));
	
	return Cleaned_Voters_File;
	
end;
