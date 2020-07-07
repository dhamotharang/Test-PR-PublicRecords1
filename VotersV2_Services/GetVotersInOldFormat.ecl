// Returns voters in the old format; we will not need it after completely switching to new data
// An attribute is made as a separate one to have a cleaner main code in VotersV2_Services.raw
IMPORT emerges, VotersV2, ut;

// the only short way to tell the difference between "persons" in rollup at the end is to keep vtid, unfortunately.
layout_old_vtid := RECORD
  UNSIGNED6 vtid;
  layouts.LegacyOutput;
END;

EXPORT layouts.LegacyOutput GetVotersInOldFormat (DATASET (VotersV2.Layouts_Voters.Layout_Voters_base) voters) := FUNCTION

  layout_old_vtid VotersBackwards (VotersV2.Layouts_Voters.Layout_Voters_base L,
                                   VotersV2.Key_Voters_History_VTID R) := TRANSFORM

    SELF.vtid := L.vtid;

    SELF.score := (STRING) L.did_score;
    SELF.best_ssn := L.ssn;
    SELF.did_out := INTFORMAT (L.did, 12, 1);
    //SELF.did := (integer) L.did;
    SELF.did := INTFORMAT (L.did, 12, 1);

    SELF._use := L.use_code;
    SELF.title_in := L.prefix_title;
    SELF.lname_in := L.last_name;
    SELF.fname_in := L.first_name;

    SELF.mname_in := L.middle_name;
    SELF.votefiller := L.voterfiller;
    SELF.poliparty := L.political_party;
    SELF.poliparty_Mapped := L.politicalparty_exp;
// SELF.active_status_mapped := L.active_status_exp;
    active_stat := TRIM (L.active_status, LEFT, RIGHT);
    SELF.active_status_mapped := MAP (active_stat = 'A' => 'Active',
                                      active_stat = 'I' => 'Inactive', '');

    SELF.votefiller2 := L.GenderSurNamGuess;
    SELF.voterStatus := L.voter_status;
    SELF.voterStatus_Mapped := L.voter_status_exp;

    SELF.resAddr1 := L.res_Addr1;
    SELF.resAddr2 := L.res_Addr2;

    SELF.county_filler := L.TimeZoneTbl;
    SELF.RecptParty := L.RecipientParty;
    SELF.ContFiller3 := L.ContFiller4;

    SELF.LastDayVote := L.LastDateVote;

    SELF.score_on_input := L.name_score;
    SELF.suffix := L.addr_suffix;
    SELF.city_name := L.v_city_name;
    SELF.record_type := L.rec_type;
    SELF.county := L.fips_county;

    SELF.mail_record_type := L.mail_rec_type;
    SELF.mail_fipscounty := L.mail_fips_county;

    SELF.county_name := ''; //later
    SELF.source_voterId := '';
    SELF.motorVoterId := '';

    // Take normalized history data (unfolding it)
    SELF.Primary02 := IF (R.voted_year='2002', R.primary, '');
    SELF.Special02 := IF (R.voted_year='2002', R.special_1, '');
    SELF.Other02 := IF (R.voted_year='2002', R.other, '');
    SELF.Special202 := IF (R.voted_year='2002', R.special_2, '');
    SELF.General02 := IF (R.voted_year='2002', R.general, '');

    SELF.Primary01 := IF (R.voted_year='2001', R.primary, '');
    SELF.Special01 := IF (R.voted_year='2001', R.special_1, '');
    SELF.Other01 := IF (R.voted_year='2001', R.other, '');
    SELF.Special201 := IF (R.voted_year='2001', R.special_2, '');
    SELF.General01 := IF (R.voted_year='2001', R.general, '');

    SELF.Pres00 := IF (R.voted_year='2000', R.pres, '');
    SELF.Primary00 := IF (R.voted_year='2000', R.primary, '');
    SELF.Special00 := IF (R.voted_year='2000', R.special_1, '');
    SELF.Other00 := IF (R.voted_year='2000', R.other, '');
    SELF.Special200 := IF (R.voted_year='2000', R.special_2, '');
    SELF.General00 := IF (R.voted_year='2000', R.general, '');

    SELF.Primary99 := IF (R.voted_year='1999', R.primary, '');
    SELF.Special99 := IF (R.voted_year='1999', R.special_1, '');
    SELF.Other99 := IF (R.voted_year='1999', R.other, '');
    SELF.Special299 := IF (R.voted_year='1999', R.special_2, '');
    SELF.General99 := IF (R.voted_year='1999', R.general, '');

    SELF.Primary98 := IF (R.voted_year='1998', R.primary, '');
    SELF.Special98 := IF (R.voted_year='1998', R.special_1, '');
    SELF.Other98 := IF (R.voted_year='1998', R.other, '');
    SELF.Special298 := IF (R.voted_year='1998', R.special_2, '');
    SELF.General98 := IF (R.voted_year='1998', R.general, '');

    SELF.Primary97 := IF (R.voted_year='1997', R.primary, '');
    SELF.Special97 := IF (R.voted_year='1997', R.special_1, '');
    SELF.Other97 := IF (R.voted_year='1997', R.other, '');
    SELF.Special297 := IF (R.voted_year='1997', R.special_2, '');
    SELF.General97 := IF (R.voted_year='1997', R.general, '');

    SELF.Pres96 := IF (R.voted_year='1996', R.pres, '');
    SELF.Primary96 := IF (R.voted_year='1996', R.primary, '');
    SELF.Special96 := IF (R.voted_year='1996', R.special_1, '');
    SELF.Other96 := IF (R.voted_year='1996', R.other, '');
    SELF.Special296 := IF (R.voted_year='1996', R.special_2, '');
    SELF.General96 := IF (R.voted_year='1996', R.general, '');

    SELF.race_mapped := L.race_exp;

    SELF := L;
  END;

  // Join with history and project appropriately to the old format
  ds_old := JOIN (voters, VotersV2.Key_Voters_History_VTID,
                  KEYED (LEFT.vtid = RIGHT.vtid),
                  VotersBackwards (LEFT, RIGHT),
                  LEFT OUTER, LIMIT (ut.limits.VOTERS_HISTORY_MAX, SKIP));

  //Rollup to get voting history in one row (for each particular vtid):
  layout_old_vtid SetVotingHistory (layout_old_vtid L, layout_old_vtid R) := TRANSFORM
    SELF.Primary02 := IF (R.Primary02 != '', R.Primary02, L.Primary02);
    SELF.Special02 := IF (R.Special02 != '', R.Special02, L.Special02);
    SELF.Other02 := IF (R.Other02 != '', R.Other02, L.Other02);
    SELF.Special202 := IF (R.Special202 != '', R.Special202, L.Special202);
    SELF.General02 := IF (R.General02 != '', R.General02, L.General02);

    SELF.Primary01 := IF (R.Primary01 != '', R.Primary01, L.Primary01);
    SELF.Special01 := IF (R.Special01 != '', R.Special01, L.Special01);
    SELF.Other01 := IF (R.Other01 != '', R.Other01, L.Other01);
    SELF.Special201 := IF (R.Special201 != '', R.Special201, L.Special201);
    SELF.General01 := IF (R.General01 != '', R.General01, L.General01);

    SELF.Pres00 := IF (R.Pres00 != '', R.Pres00, L.Pres00);
    SELF.Primary00 := IF (R.Primary00 != '', R.Primary00, L.Primary00);
    SELF.Special00 := IF (R.Special00 != '', R.Special00, L.Special00);
    SELF.Other00 := IF (R.Other00 != '', R.Other00, L.Other00);
    SELF.Special200 := IF (R.Special200 != '', R.Special200, L.Special200);
    SELF.General00 := IF (R.General00 != '', R.General00, L.General00);

    SELF.Primary99 := IF (R.Primary99 != '', R.Primary99, L.Primary99);
    SELF.Special99 := IF (R.Special99 != '', R.Special99, L.Special99);
    SELF.Other99 := IF (R.Other99 != '', R.Other99, L.Other99);
    SELF.Special299 := IF (R.Special299 != '', R.Special299, L.Special299);
    SELF.General99 := IF (R.General99 != '', R.General99, L.General99);

    SELF.Primary98 := IF (R.Primary98 != '', R.Primary98, L.Primary98);
    SELF.Special98 := IF (R.Special98 != '', R.Special98, L.Special98);
    SELF.Other98 := IF (R.Other98 != '', R.Other98, L.Other98);
    SELF.Special298 := IF (R.Special298 != '', R.Special298, L.Special298);
    SELF.General98 := IF (R.General98 != '', R.General98, L.General98);

    SELF.Primary97 := IF (R.Primary97 != '', R.Primary97, L.Primary97);
    SELF.Special97 := IF (R.Special97 != '', R.Special97, L.Special97);
    SELF.Other97 := IF (R.Other97 != '', R.Other97, L.Other97);
    SELF.Special297 := IF (R.Special297 != '', R.Special297, L.Special297);
    SELF.General97 := IF (R.General97 != '', R.General97, L.General97);

    SELF.Pres96 := IF (R.Pres96 != '', R.Pres96, L.Pres96);
    SELF.Primary96 := IF (R.Primary96 != '', R.Primary96, L.Primary96);
    SELF.Special96 := IF (R.Special96 != '', R.Special96, L.Special96);
    SELF.Other96 := IF (R.Other96 != '', R.Other96, L.Other96);
    SELF.Special296 := IF (R.Special296 != '', R.Special296, L.Special296);
    SELF.General96 := IF (R.General96 != '', R.General96, L.General96);
    
    SELF := R;
  END;

  // here everything is the same for any given vtid, but history part
  ds_roll := ROLLUP (SORT (ds_old, vtid), LEFT.vtid = RIGHT.vtid, SetVotingHistory (LEFT, RIGHT));

  ds_res := PROJECT (ds_roll, layouts.LegacyOutput);
  RETURN ds_res;
END;
