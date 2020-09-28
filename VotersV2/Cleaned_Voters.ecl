/*2015-04-02T17:22:34Z (Metzmaier, AJ (RIS-DAY))
Bug 108818 - Code changes due to layout rework and/or additional validation.
*/
import _Validate, ut, lib_stringlib;

export Cleaned_Voters(string filedate) := function

//Barb O'Neill changed for DOPS-461
	In_Voters_File  := VotersV2.File_Voters_In();

	In_Voter_Layout := VotersV2.Layout_Voters_In;

	Layout_Clean_Voters := record
		VotersV2.Layouts_Voters.Layout_Voters_Common_new;
	end;

//DF-27577 Cleaned up this transform
	Layout_Clean_Voters getCleanVoters(In_Voters_File l) := transform		
		the_res_state          := ut.fnTrim2Upper(l.res_state);
		the_state_code         := ut.fnTrim2Upper(l.state_code);
		the_file_acquired_date := if(_Validate.Date.fIsValid(l.file_acquired_date) and
		                                _Validate.Date.fIsValid(l.file_acquired_date, _Validate.Date.Rules.DateInPast),
		                             l.file_acquired_date,
																 '');
		the_gender             := ut.fnTrim2Upper(l.gender);
		
		self.vtid                  := 0;
		self.file_acquired_date    := the_file_acquired_date;
		self.process_date		       := the_file_acquired_date;
		self.date_first_seen       := self.process_date;
		self.date_last_seen        := self.process_date;
		self.source                := 'EMERGES';
		self.file_id               := 'VOTE'; 
		self.vendor_id             := trim(l.EMID_number,left,right);
																			 
													
		self.source_code           := ut.fnTrim2Upper(l.source_code);
		self.prefix_title          := ut.fnTrim2Upper(l.prefix_title);
		self.last_name             := ut.fnTrim2Upper(l.last_name);
		self.first_name            := ut.fnTrim2Upper(l.first_name);
		self.middle_name           := ut.fnTrim2Upper(l.middle_name);
		self.maiden_prior          := ut.fnTrim2Upper(l.maiden_prior);
		self.name_suffix_in        := ut.fnTrim2Upper(l.name_suffix);
		self.voterfiller           := ''; // old
		self.source_voterId        := ut.fnTrim2Upper(l.source_voterId);
		// Allows 00 in MM and DD, but YYYY00DD is invalid, according to the utility
		self.dob                   := if(_Validate.Date.fIsValid(l.dob, , true, true),
		                                 l.dob,
																		 '');
		self.ageCat                := ut.fnTrim2Upper(l.ageCat);
		self.ageCat_exp            := '';
		self.headHousehold         := ut.fnTrim2Upper(l.headHousehold);
		self.place_of_birth        := ut.fnTrim2Upper(l.place_of_birth);
		self.occupation            := ut.fnTrim2Upper(l.occupation);
		self.maiden_name           := ''; // old
		self.motorVoterId          := ut.fnTrim2Upper(l.motorVoterId);
		self.regSource             := ut.fnTrim2Upper(l.regSource);
		// Allows 00 in MM and DD, but YYYY00DD is invalid, according to the utility
		self.regDate               := if(_Validate.Date.fIsValid(l.regDate, , true, true),
		                                 l.regDate,
																		 '');
		self.race                  := ut.fnTrim2Upper(l.race);
		self.race_exp              := '';
		self.gender                := if(the_gender in VotersV2._Flags.valid_gender,
		                                 the_gender,
																		 '');
		self.political_party       := ut.fnTrim2Upper(l.political_party);
		self.politicalparty_exp    := '';
		self.phone                 := StringLib.StringFilter(l.home_phone, '0123456789');
		self.work_phone            := StringLib.StringFilter(l.work_phone, '0123456789');
		self.other_phone           := ''; // old
		self.active_status         := ut.fnTrim2Upper(l.active_status);
		self.active_status_exp     := '';
		self.GenderSurNamGuess     := ut.fnTrim2Upper(l.GenderSurNamGuess);
		self.active_other          := ''; // old
		self.voter_status  		     := ut.fnTrim2Upper(l.voter_status);
		self.voter_status_exp      := '';
		self.res_Addr1             := ut.fnTrim2Upper(l.res_Addr1);
		self.res_Addr2             := ut.fnTrim2Upper(l.res_Addr2);
		self.res_city              := ut.fnTrim2Upper(l.res_city);
		self.res_state             := ut.fnTrim2Upper(l.res_state);
		self.res_zip               := StringLib.StringFilter(l.res_zip, '0123456789');
		self.res_county            := ut.fnTrim2Upper(l.res_county);
		self.mail_addr1            := ut.fnTrim2Upper(l.mail_Addr1);
		self.mail_addr2            := ut.fnTrim2Upper(l.mail_Addr2);
		self.mail_city             := ut.fnTrim2Upper(l.mail_city);
		self.mail_state            := ut.fnTrim2Upper(l.mail_state);
		self.mail_zip              := StringLib.StringFilter(l.mail_zip, '0123456789');
		self.mail_county           := ut.fnTrim2Upper(l.mail_county);
		self.addr_filler1          := ''; // old
		self.addr_filler2          := ''; // old
		self.city_filler           := ''; // old
		self.state_filler          := ''; // old
		self.zip_filler            := ''; // old		
		
		self.source_state          := if(the_state_code = '', the_res_state,
										                 the_state_code);	
																		 
		self.TimeZoneTbl           := ut.fnTrim2Upper(l.TimeZoneTbl);
		self.towncode              := ut.fnTrim2Upper(l.towncode);
		self.distcode              := ut.fnTrim2Upper(l.distcode);
		self.countycode            := ut.fnTrim2Upper(l.countycode);
		self.schoolcode            := ut.fnTrim2Upper(l.schoolcode);
		self.cityInOut             := ut.fnTrim2Upper(l.cityInOut);
		self.spec_dist1            := ''; // old
		self.spec_dist2            := ''; // old
		self.precinct1             := ''; // old
		self.precinct2             := ''; // old
		self.precinct3             := ''; // old
		self.villagePrecinct       := ut.fnTrim2Upper(l.villagePrecinct);
		self.schoolPrecinct        := ''; // old
		self.ward                  := ''; // old
		self.precinct_cityTown     := ut.fnTrim2Upper(l.precinct_cityTown);
		self.ANCSMDinDC            := ''; // old
		self.cityCouncilDist       := ''; // old
		self.countyCommDist        := ut.fnTrim2Upper(l.countyCommDist);
		self.stateHouse            := ut.fnTrim2Upper(l.stateHouse);
		self.stateSenate           := ut.fnTrim2Upper(l.stateSenate);
		self.USHouse               := ut.fnTrim2Upper(l.USHouse);
		self.elemSchoolDist        := ut.fnTrim2Upper(l.elemSchoolDist);
		self.schoolDist            := ''; // old
		self.schoolFiller          := ''; // old
		self.CommCollDist          := ut.fnTrim2Upper(l.CommCollDist);
		self.dist_filler           := ''; // old
		self.municipal             := ut.fnTrim2Upper(l.municipal);
		self.VillageDist           := ut.fnTrim2Upper(l.VillageDist);
		self.PoliceJury            := ut.fnTrim2Upper(l.PoliceJury);
		self.PoliceDist            := ''; // old
		self.PublicServComm        := ut.fnTrim2Upper(l.PublicServComm);
		self.Rescue                := ut.fnTrim2Upper(l.Rescue);
		self.Fire                  := ut.fnTrim2Upper(l.Fire);
		self.Sanitary              := ut.fnTrim2Upper(l.Sanitary);
		self.SewerDist             := ut.fnTrim2Upper(l.SewerDist);
		self.WaterDist             := ut.fnTrim2Upper(l.WaterDist);
		self.MosquitoDist          := ut.fnTrim2Upper(l.MosquitoDist);
		self.TaxDist               := ut.fnTrim2Upper(l.TaxDist);
		self.SupremeCourt          := ut.fnTrim2Upper(l.SupremeCourt);
		self.JusticeOfPeace        := ut.fnTrim2Upper(l.JusticeOfPeace);
		self.JudicialDist          := ''; // old
		self.SuperiorCtDist        := ut.fnTrim2Upper(l.SuperiorCtDist);
		self.AppealsCt             := ut.fnTrim2Upper(l.AppealsCt);
		self.CourtFIller           := ''; // old
		self.CassAddrTypTbl        := ut.fnTrim2Upper(l.CassAddrTypTbl);
		self.CassDelivPointCd      := ut.fnTrim2Upper(l.CassDelivPointCd);
		self.CassCarrierRteTbl     := ut.fnTrim2Upper(l.CassCarrierRteTbl);
		self.BlkGrpEnumDist        := ut.fnTrim2Upper(l.BlkGrpEnumDist);
		self.CongressionalDist     := ut.fnTrim2Upper(l.CongressionalDist);
		self.Lattitude             := ut.fnTrim2Upper(l.Lattitude);
		self.CountyFips            := ut.fnTrim2Upper(l.CountyFips);
		self.CensusTract           := ut.fnTrim2Upper(l.CensusTract);
		self.FipsStCountyCd        := ut.fnTrim2Upper(l.FipsStCountyCd);
		self.Longitude             := ut.fnTrim2Upper(l.Longitude);
		self.ContributorParty      := '';     // old base fields
		self.RecipientParty        := '';     // old base fields
		self.DateOfContr           := '';     // old base fields
		self.DollarAmt             := '';     // old base fields
		self.OfficeContTo          := '';     // old base fields
		self.CumulDollarAmt        := '';     // old base fields
		self.ContFiller1           := '';     // old base fields  
		self.ContFiller2           := '';     // old base fields
		self.ContType              := '';     // old base fields
		self.ContFiller4           := '';     // old base fields
    self.IDTypes               := ut.fnTrim2Upper(l.IDTypes);
    self.precinct              := ut.fnTrim2Upper(l.precinct);
    self.ward1                 := ut.fnTrim2Upper(l.ward1);
    self.IDCode                := ut.fnTrim2Upper(l.IDCode);
    self.PrecinctPartTextDesig := ut.fnTrim2Upper(l.PrecinctPartTextDesig);
    self.PrecinctPartTextName  := ut.fnTrim2Upper(l.PrecinctPartTextName);
    self.PrecinctTextDesig     := ut.fnTrim2Upper(l.PrecinctTextDesig);
    self.MarriedAppend         := ut.fnTrim2Upper(l.MarriedAppend);
    self.SupervisorDistrict    := ut.fnTrim2Upper(l.SupervisorDistrict);
    self.district              := ut.fnTrim2Upper(l.district);
    self.ward2                 := ut.fnTrim2Upper(l.ward2);
    self.CityCountyCouncil     := ut.fnTrim2Upper(l.CityCountyCouncil);
    self.CountyPrecinct        := ut.fnTrim2Upper(l.CountyPrecinct);
    self.CountyCommis          := ut.fnTrim2Upper(l.CountyCommis);
    self.SchoolBoard           := ut.fnTrim2Upper(l.SchoolBoard);
    self.ward3                 := ut.fnTrim2Upper(l.ward3);
    self.TownCityCouncil1      := ut.fnTrim2Upper(l.TownCityCouncil1);
    self.TownCityCouncil2      := ut.fnTrim2Upper(l.TownCityCouncil2);
    self.regents               := ut.fnTrim2Upper(l.regents);
    self.WaterShed             := ut.fnTrim2Upper(l.WaterShed);
    self.education             := ut.fnTrim2Upper(l.education);
    self.PoliceConstable       := ut.fnTrim2Upper(l.PoliceConstable);
    self.FreeHolder            := ut.fnTrim2Upper(l.FreeHolder);
    self.MuniCourt             := ut.fnTrim2Upper(l.MuniCourt);
		// Allows 00 in MM and DD, but YYYY00DD is invalid, according to the utility
    self.ChangeDate            := if(_Validate.Date.fIsValid(trim(l.ChangeDate, left, right), , true, true),
		                                 l.ChangeDate,
																		 '');
		self.MiscVoteHist          := ''; // old
		self.Primary2020           := ut.fnTrim2Upper(l.Primary2020);
		self.Special12020          := ut.fnTrim2Upper(l.Special12020);
		self.Other2020             := ut.fnTrim2Upper(l.Other2020);
		self.Special22020          := ut.fnTrim2Upper(l.Special22020);
		self.General2020           := ut.fnTrim2Upper(l.General2020);
		self.PresPrimary2020       := ut.fnTrim2Upper(l.PresPrimary2020);
		self.Primary2019           := ut.fnTrim2Upper(l.Primary2019);
		self.Special12019          := ut.fnTrim2Upper(l.Special12019);
		self.Other2019             := ut.fnTrim2Upper(l.Other2019);
		self.Special22019          := ut.fnTrim2Upper(l.Special22019);
		self.General2019           := ut.fnTrim2Upper(l.General2019);
		self.Primary2018           := ut.fnTrim2Upper(l.Primary2018);
		self.Special12018          := ut.fnTrim2Upper(l.Special12018);
		self.Other2018             := ut.fnTrim2Upper(l.Other2018);
		self.Special22018          := ut.fnTrim2Upper(l.Special22018);
		self.General2018           := ut.fnTrim2Upper(l.General2018);
		self.Primary2017           := ut.fnTrim2Upper(l.Primary2017);
		self.Special12017          := ut.fnTrim2Upper(l.Special12017);
		self.Other2017             := ut.fnTrim2Upper(l.Other2017);
		self.Special22017          := ut.fnTrim2Upper(l.Special22017);
		self.General2017           := ut.fnTrim2Upper(l.General2017);
		self.Primary2016           := ut.fnTrim2Upper(l.Primary2016);
		self.Special12016          := ut.fnTrim2Upper(l.Special12016);
		self.Other2016             := ut.fnTrim2Upper(l.Other2016);
		self.Special22016          := ut.fnTrim2Upper(l.Special22016);
		self.General2016           := ut.fnTrim2Upper(l.General2016);
		self.PresPrimary2016       := ut.fnTrim2Upper(l.PresPrimary2016);
		self.Primary2015           := ut.fnTrim2Upper(l.Primary2015);
		self.Special12015          := ut.fnTrim2Upper(l.Special12015);
		self.Other2015             := ut.fnTrim2Upper(l.Other2015);
		self.Special22015          := ut.fnTrim2Upper(l.Special22015);
		self.General2015           := ut.fnTrim2Upper(l.General2015);
		self.Primary2014           := ut.fnTrim2Upper(l.Primary2014);
		self.Special12014          := ut.fnTrim2Upper(l.Special12014);
		self.Other2014             := ut.fnTrim2Upper(l.Other2014);
		self.Special22014          := ut.fnTrim2Upper(l.Special22014);
		self.General2014           := ut.fnTrim2Upper(l.General2014);
		self.Primary2013           := ut.fnTrim2Upper(l.Primary2013);
		self.Special12013          := ut.fnTrim2Upper(l.Special12013);
		self.Other2013             := ut.fnTrim2Upper(l.Other2013);
		self.Special22013          := ut.fnTrim2Upper(l.Special22013);
		self.General2013           := ut.fnTrim2Upper(l.General2013);
		self.Primary2012           := ut.fnTrim2Upper(l.Primary2012);
		self.Special12012          := ut.fnTrim2Upper(l.Special12012);
		self.Other2012             := ut.fnTrim2Upper(l.Other2012);
		self.Special22012          := ut.fnTrim2Upper(l.Special22012);
		self.General2012           := ut.fnTrim2Upper(l.General2012);
		self.PresPrimary2012       := ut.fnTrim2Upper(l.PresPrimary2012);
		self.Primary2011           := ut.fnTrim2Upper(l.Primary2011);
		self.Special12011          := ut.fnTrim2Upper(l.Special12011);
		self.Other2011             := ut.fnTrim2Upper(l.Other2011);
		self.Special22011          := ut.fnTrim2Upper(l.Special22011);
		self.General2011           := ut.fnTrim2Upper(l.General2011);
		self.Primary2010           := ut.fnTrim2Upper(l.Primary2010);
		self.Special12010          := ut.fnTrim2Upper(l.Special12010);
		self.Other2010             := ut.fnTrim2Upper(l.Other2010);
		self.Special22010          := ut.fnTrim2Upper(l.Special22010);
		self.General2010           := ut.fnTrim2Upper(l.General2010);
		self.Primary2009           := ut.fnTrim2Upper(l.Primary2009);
		self.Special12009          := ut.fnTrim2Upper(l.Special12009);
		self.Other2009             := ut.fnTrim2Upper(l.Other2009);
		self.Special22009          := ut.fnTrim2Upper(l.Special22009);
		self.General2009           := ut.fnTrim2Upper(l.General2009);
		self.Primary2008           := ut.fnTrim2Upper(l.Primary2008);
		self.Special12008          := ut.fnTrim2Upper(l.Special12008);
		self.Other2008             := ut.fnTrim2Upper(l.Other2008);
		self.Special22008          := ut.fnTrim2Upper(l.Special22008);
		self.General2008           := ut.fnTrim2Upper(l.General2008);
		self.PresPrimary2008       := ut.fnTrim2Upper(l.PresPrimary2008);
		self.Primary2007           := ut.fnTrim2Upper(l.Primary2007);
		self.Special12007          := ut.fnTrim2Upper(l.Special12007);
		self.Other2007             := ut.fnTrim2Upper(l.Other2007);
		self.Special22007          := ut.fnTrim2Upper(l.Special22007);
		self.General2007           := ut.fnTrim2Upper(l.General2007);
		self.Primary2006           := ut.fnTrim2Upper(l.Primary2006);
		self.Special12006          := ut.fnTrim2Upper(l.Special12006);
		self.Other2006             := ut.fnTrim2Upper(l.Other2006);
		self.Special22006          := ut.fnTrim2Upper(l.Special22006);
		self.General2006           := ut.fnTrim2Upper(l.General2006);
		self.Primary2005           := ut.fnTrim2Upper(l.Primary2005);
		self.Special12005          := ut.fnTrim2Upper(l.Special12005);
		self.Other2005             := ut.fnTrim2Upper(l.Other2005);
		self.Special22005          := ut.fnTrim2Upper(l.Special22005);
		self.General2005           := ut.fnTrim2Upper(l.General2005);
		self.PresPrimary2004       := ut.fnTrim2Upper(l.PresPrimary2004);
		self.Primary2004           := ut.fnTrim2Upper(l.Primary2004);
		self.Special12004          := ut.fnTrim2Upper(l.Special12004);
		self.Other2004             := ut.fnTrim2Upper(l.Other2004);
		self.Special22004          := ut.fnTrim2Upper(l.Special22004);
		self.General2004           := ut.fnTrim2Upper(l.General2004);  
		self.Primary2003           := ''; // old
		self.Special12003          := ''; // old
		self.Other2003             := ''; // old
		self.Special22003          := ''; // old
		self.General2003           := ''; // old
		self.Primary2002           := ''; // old
		self.Special12002          := ''; // old
		self.Other2002             := ''; // old
		self.Special22002          := ''; // old
		self.General2002           := ''; // old
		self.Primary2001           := ''; //2008 - stringlib.StringToUpperCase(trim(l.Primary2001,left,right));
		self.Special2001           := '';     // old base fields
		self.Other2001             := '';     // old base fields
		self.Special22001          := '';     // old base fields
		self.General2001           := ''; //2008 - stringlib.StringToUpperCase(trim(l.General2001,left,right));
		self.PresPrimary2000       := ''; //2008 - stringlib.StringToUpperCase(trim(l.PresPrimary2000,left,right));
		self.Primary2000           := ''; //2008 - stringlib.StringToUpperCase(trim(l.Primary2000,left,right));
		self.Special2000           := '';     // old base fields
		self.Other2000             := '';     // old base fields
		self.Special22000          := '';     // old base fields
		self.General2000           := ''; //2008 - stringlib.StringToUpperCase(trim(l.General2000,left,right));
		self.Primary1999           := '';     // old base fields
		self.Special1999           := '';     // old base fields
		self.Other1999             := '';     // old base fields
		self.Special21999          := '';     // old base fields
		self.General1999           := '';     // old base fields
		self.Primary1998           := '';     // old base fields
		self.Special1998           := '';     // old base fields
		self.Other1998             := '';     // old base fields
		self.Special21998          := '';     // old base fields
		self.General1998           := '';     // old base fields
		self.Primary1997           := '';     // old base fields
		self.Special1997           := '';     // old base fields
		self.Other1997             := '';     // old base fields
		self.Special21997          := '';     // old base fields
		self.General1997           := '';     // old base fields
		self.PresPrimary1996       := '';     // old base fields
		self.Primary1996           := '';     // old base fields
		self.Special1996           := '';     // old base fields
		self.Other1996             := '';     // old base fields
		self.Special21996          := '';     // old base fields
		self.General1996           := '';     // old base fields
		// Validating year and month should be good enough for this field
		self.LastDateVote          := if(_Validate.Date.fIsValid(l.LastDateVote, _Validate.Date.Rules.MonthValid),
		                                 l.LastDateVote,
																		 '');
		self                       := l;
		self := [];
	end;

	Cleaned_Voters_File := project(In_Voters_File, getCleanVoters(left));
	
	return Cleaned_Voters_File;
	
end;