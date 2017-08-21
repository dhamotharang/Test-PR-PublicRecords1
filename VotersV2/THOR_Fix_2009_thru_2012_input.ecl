// We need to take cleaned input files from 2009-2012, take the voting data in the various
//   years and put them in the correct position.  Input files are placed in a superfile to hold all
//   old input files, while the new input is put into the appropriate state superfile.
// For voting that happened after 9/23/2011, the non-voting year fields changed and we need to fill
//   in the new fields in the base file, which means the matching old fields will be blank.  For
//   example voterfiller changes to IDTypes, so before 9/23/2011 voterfiller can be populated and
//   IDTypes will be blank and after 9/23/2011 IDTypes can be populated and voterfiller will be
//   blank.
// NOTE: For input and output file names, you MUST have the ~ in the name
IMPORT _Validate, VotersV2, ut;

EXPORT THOR_Fix_2009_thru_2012_input(STRING in_file,
                                     STRING out_file,
																		 STRING source_state) := MODULE

  old_layout := VotersV2.Layouts_Voters.Layout_Voters_Common;
	current_layout := VotersV2.Layouts_Voters.Layout_Voters_Common_new;

	ds_in := DATASET(in_file, old_layout, THOR);

	/*
	2009 - in same position for all years, 2002 becomes 2009
	2010 - in same position for 10, 11, 12... 2003 becomes 2010
	2011 - in same position for 11, 12... 2004 becomes 2011, except pres primary 2004 is left alone
	2012 - 2005 becomes 2012 and pres primary 2004 becomes pres primary 2012
	*/
	year2009 := ['2009', '2010', '2011', '2012'];
	year2010 := ['2010', '2011', '2012'];
	year2011 := ['2011', '2012'];
	year2012 := ['2012'];

	current_layout fix_vote_history(old_layout L) := TRANSFORM
	  is_before_change_date := (UNSIGNED)L.file_acquired_date < 20110923 OR
		                            (UNSIGNED)L.process_date < 20110923;
		the_file_acquired_date := IF(_Validate.Date.fIsValid(L.file_acquired_date) AND
																    _Validate.Date.fIsValid(L.file_acquired_date, _Validate.Date.Rules.DateInPast),
																 L.file_acquired_date,
																 '');
		acquired_year := the_file_acquired_date[1..4];

		SELF.process_date		    := the_file_acquired_date;
		SELF.date_first_seen    := the_file_acquired_date;
		SELF.date_last_seen     := the_file_acquired_date;
		// Allows 00 in MM and DD, but YYYY00DD is invalid, according to the utility
		SELF.dob                := IF(_Validate.Date.fIsValid(L.dob, , TRUE, TRUE),
																	L.dob,
																	'');
		// Allows 00 in MM and DD, but YYYY00DD is invalid, according to the utility
		SELF.regDate            := IF(_Validate.Date.fIsValid(L.regDate, , TRUE, TRUE),
																	L.regDate,
																	'');
		// Validating year and month should be good enough for this field
		SELF.LastDateVote       := IF(_Validate.Date.fIsValid(L.LastDateVote, _Validate.Date.Rules.MonthValid),
																	L.LastDateVote,
																	'');
		SELF.gender             := IF(L.gender IN VotersV2._Flags.valid_gender,
		                              L.gender,
																	'');

    // old fields
    SELF.voterfiller     := IF(is_before_change_date, L.voterfiller, '');
    SELF.maiden_name     := IF(is_before_change_date, L.maiden_name, '');
    SELF.other_phone     := IF(is_before_change_date, L.other_phone, '');
    SELF.active_other    := IF(is_before_change_date, L.active_other, '');
    SELF.addr_filler1    := IF(is_before_change_date, L.addr_filler1, '');
    SELF.addr_filler2    := IF(is_before_change_date, L.addr_filler2, '');
    SELF.city_filler     := IF(is_before_change_date, L.city_filler, '');
    SELF.state_filler    := IF(is_before_change_date, L.state_filler, '');
    SELF.zip_filler      := IF(is_before_change_date, L.zip_filler, '');
    SELF.spec_dist1      := IF(is_before_change_date, L.spec_dist1, '');
    SELF.spec_dist2      := IF(is_before_change_date, L.spec_dist2, '');
    SELF.precinct1       := IF(is_before_change_date, L.precinct1, '');
    SELF.precinct2       := IF(is_before_change_date, L.precinct2, '');
    SELF.precinct3       := IF(is_before_change_date, L.precinct3, '');
    SELF.schoolPrecinct  := IF(is_before_change_date, L.schoolPrecinct, '');
    SELF.ward            := IF(is_before_change_date, L.ward, '');
    SELF.ANCSMDinDC      := IF(is_before_change_date, L.ANCSMDinDC, '');
    SELF.cityCouncilDist := IF(is_before_change_date, L.cityCouncilDist, '');
    SELF.schoolDist      := IF(is_before_change_date, L.schoolDist, '');
    SELF.schoolFiller    := IF(is_before_change_date, L.schoolFiller, '');
    SELF.dist_filler     := IF(is_before_change_date, L.dist_filler, '');
    SELF.PoliceDist      := IF(is_before_change_date, L.PoliceDist, '');
    SELF.JudicialDist    := IF(is_before_change_date, L.JudicialDist, '');
    SELF.CourtFIller     := IF(is_before_change_date, L.CourtFIller, '');
    SELF.MiscVoteHist    := IF(is_before_change_date, L.MiscVoteHist, '');

    // new fields
    SELF.IDTypes               := IF(NOT(is_before_change_date), L.voterfiller, '');
    SELF.precinct              := IF(NOT(is_before_change_date), L.maiden_name, '');
    SELF.ward1                 := IF(NOT(is_before_change_date), L.other_phone, '');
    SELF.IDCode                := IF(NOT(is_before_change_date), L.active_other, '');
    SELF.PrecinctPartTextDesig := IF(NOT(is_before_change_date), L.addr_filler1, '');
    SELF.PrecinctPartTextName  := IF(NOT(is_before_change_date), L.addr_filler2, '');
    SELF.PrecinctTextDesig     := IF(NOT(is_before_change_date), L.city_filler, '');
    SELF.MarriedAppend         := IF(NOT(is_before_change_date), L.state_filler, '');
    SELF.SupervisorDistrict    := IF(NOT(is_before_change_date), L.zip_filler, '');
    SELF.district              := IF(NOT(is_before_change_date), L.spec_dist1, '');
    SELF.ward2                 := IF(NOT(is_before_change_date), L.spec_dist2, '');
    SELF.CityCountyCouncil     := IF(NOT(is_before_change_date), L.precinct1, '');
    SELF.CountyPrecinct        := IF(NOT(is_before_change_date), L.precinct2, '');
    SELF.CountyCommis          := IF(NOT(is_before_change_date), L.precinct3, '');
    SELF.SchoolBoard           := IF(NOT(is_before_change_date), L.schoolPrecinct, '');
    SELF.ward3                 := IF(NOT(is_before_change_date), L.ward, '');
    SELF.TownCityCouncil1      := IF(NOT(is_before_change_date), L.ANCSMDinDC, '');
    SELF.TownCityCouncil2      := IF(NOT(is_before_change_date), L.cityCouncilDist, '');
    SELF.regents               := IF(NOT(is_before_change_date), L.schoolDist, '');
    SELF.WaterShed             := IF(NOT(is_before_change_date), L.schoolFiller, '');
    SELF.education             := IF(NOT(is_before_change_date), L.dist_filler, '');
    SELF.PoliceConstable       := IF(NOT(is_before_change_date), L.PoliceDist, '');
    SELF.FreeHolder            := IF(NOT(is_before_change_date), L.JudicialDist, '');
    SELF.MuniCourt             := IF(NOT(is_before_change_date), L.CourtFIller, '');
		// Allows 00 in MM and DD, but YYYY00DD is invalid, according to the utility
    SELF.ChangeDate            := IF(NOT(is_before_change_date),
		                                 IF(_Validate.Date.fIsValid(TRIM(L.MiscVoteHist, LEFT, RIGHT), , TRUE, TRUE),
		                                    L.MiscVoteHist,
																				''),
																		 '');

    // years to fix
		SELF.primary2009      := IF(acquired_year IN year2009,
		                            L.Primary2002,
														    '');
		SELF.Special12009     := IF(acquired_year IN year2009,
		                            L.Special12002,
														    '');
		SELF.Other2009        := IF(acquired_year IN year2009,
		                            L.Other2002,
														    '');
		SELF.Special22009     := IF(acquired_year IN year2009,
		                            L.Special22002,
														    '');
		SELF.General2009      := IF(acquired_year IN year2009,
		                            L.General2002,
														    '');

		SELF.primary2010      := IF(acquired_year IN year2010,
		                            L.Primary2003,
														    '');
		SELF.Special12010     := IF(acquired_year IN year2010,
		                            L.Special12003,
														    '');
		SELF.Other2010        := IF(acquired_year IN year2010,
		                            L.Other2003,
														    '');
		SELF.Special22010     := IF(acquired_year IN year2010,
		                            L.Special22003,
														    '');
		SELF.General2010      := IF(acquired_year IN year2010,
		                            L.General2003,
														    '');

		SELF.primary2011      := IF(acquired_year IN year2011,
		                            L.Primary2004,
														    '');
		SELF.Special12011     := IF(acquired_year IN year2011,
		                            L.Special12004,
														    '');
		SELF.Other2011        := IF(acquired_year IN year2011,
		                            L.Other2004,
														    '');
		SELF.Special22011     := IF(acquired_year IN year2011,
		                            L.Special22004,
														    '');
		SELF.General2011      := IF(acquired_year IN year2011,
		                            L.General2004,
														    '');

		SELF.primary2012      := IF(acquired_year IN year2012,
		                            L.Primary2005,
														    '');
		SELF.Special12012     := IF(acquired_year IN year2012,
                                L.Special12005,
														    '');
		SELF.Other2012        := IF(acquired_year IN year2012,
		                            L.Other2005,
														    '');
		SELF.Special22012     := IF(acquired_year IN year2012,
		                            L.Special22005,
														    '');
		SELF.General2012      := IF(acquired_year IN year2012,
		                            L.General2005,
														    '');
		SELF.PresPrimary2012  := IF(acquired_year IN year2012,
		                            L.PresPrimary2004,
														    '');

    // years to blank out for above fixing situation
		SELF.Primary2002      := IF(acquired_year IN year2009,
		                            '',
		                            L.Primary2002);
		SELF.Special12002     := IF(acquired_year IN year2009,
		                            '',
		                            L.Special12002);
		SELF.Other2002        := IF(acquired_year IN year2009,
		                            '',
		                            L.Other2002);
		SELF.Special22002     := IF(acquired_year IN year2009,
		                            '',
		                            L.Special22002);
		SELF.General2002      := IF(acquired_year IN year2009,
		                            '',
		                            L.General2002);

		SELF.Primary2003      := IF(acquired_year IN year2010,
		                            '',
		                            L.Primary2003);
		SELF.Special12003     := IF(acquired_year IN year2010,
		                            '',
		                            L.Special12003);
		SELF.Other2003        := IF(acquired_year IN year2010,
		                            '',
		                            L.Other2003);
		SELF.Special22003     := IF(acquired_year IN year2010,
		                            '',
		                            L.Special22003);
		SELF.General2003      := IF(acquired_year IN year2010,
		                            '',
		                            L.General2003);

		SELF.Primary2004      := IF(acquired_year IN year2011,
		                            '',
		                            L.Primary2004);
		SELF.Special12004     := IF(acquired_year IN year2011,
		                            '',
		                            L.Special12004);
		SELF.Other2004        := IF(acquired_year IN year2011,
		                            '',
		                            L.Other2004);
		SELF.Special22004     := IF(acquired_year IN year2011,
		                            '',
		                            L.Special22004);
		SELF.General2004      := IF(acquired_year IN year2011,
		                            '',
		                            L.General2004);

		SELF.Primary2005      := IF(acquired_year IN year2012,
		                            '',
		                            L.Primary2005);
		SELF.Special12005     := IF(acquired_year IN year2012,
                                '',
                                L.Special12005);
		SELF.Other2005        := IF(acquired_year IN year2012,
		                            '',
		                            L.Other2005);
		SELF.Special22005     := IF(acquired_year IN year2012,
		                            '',
		                            L.Special22005);
		SELF.General2005      := IF(acquired_year IN year2012,
		                            '',
		                            L.General2005);
		SELF.PresPrimary2004  := IF(acquired_year IN year2012,
		                            '',
		                            L.PresPrimary2004);

		SELF := L;
		SELF := [];
	END;

	Fixed_Voters_VoteHistory_mapping := PROJECT(ds_in, fix_vote_history(LEFT));

  EXPORT All :=
	  SEQUENTIAL(OUTPUT(Fixed_Voters_VoteHistory_mapping, , out_file, OVERWRITE),
	             FileServices.StartSuperFileTransaction(),
							 FileServices.AddSuperFile('~thor_data400::in::voters::main::old_2009_onward::superfile',
							                           in_file),
							 FileServices.AddSuperFile('~thor_data400::in::Voters::' + source_state + '::Superfile', 
																				 out_file),
							 FileServices.FinishSuperFileTransaction());

END;
