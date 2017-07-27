IMPORT ut, Business_Header, Business_Header_SS, did_add;

#workunit('name', 'Corporate Base Creation ' + corporate.Corp4_Build_Date);

//************************************************************
// Project Corp4 Temp file to Corp Base format
//************************************************************

Corporate.Layout_Corporate_Base FormatCorp4Base(Corporate.Layout_Corp4_Temp L) := TRANSFORM
SELF.bdid := 0;
SELF.sos_ter_nbr := L.sos_charter_nbr;
SELF.orig_sos_ter_nbr := L.orig_sos_charter_nbr;
SELF.prior_city := L.orig_prior_city;
SELF.prior_state := L.orig_prior_state;
SELF.prior_st := L.prior_state;
SELF := L;
END;

Corp4_Base_Init := PROJECT(Corporate.Corp4_Temp, FormatCorp4Base(LEFT));
COUNT(Corp4_Base_Init);

//************************************************************
// Rollup to set Date First Seen and Last Seen
//************************************************************

// Date First Seen and Date Last Seen have been initialized to Extract Date
Corporate.Layout_Corporate_Base RollupCorp(Corporate.Layout_Corporate_Base L, Corporate.Layout_Corporate_Base R) := TRANSFORM
SELF.dt_first_seen := IF(L.dt_first_seen < R.dt_first_seen, L.dt_first_seen, R.dt_first_seen);
SELF := L;
END;

Corp4_Base_Init_Dist := DISTRIBUTE(Corp4_Base_Init, HASH(state_origin, sos_ter_nbr));
Corp4_Base_Init_Sort := SORT(Corp4_Base_Init_Dist, state_origin, sos_ter_nbr, abbrev_legal_name,
                               zip5, prim_name, prim_range, sec_range, address_ind, -dt_last_seen, LOCAL);
Corp4_Base_Init_Rollup := ROLLUP(Corp4_Base_Init_Sort,
                                 LEFT.state_origin = RIGHT.state_origin AND
                                   LEFT.sos_ter_nbr = RIGHT.sos_ter_nbr AND
                                   LEFT.abbrev_legal_name = RIGHT.abbrev_legal_name AND
                                   LEFT.zip5 = RIGHT.zip5 AND
                                   LEFT.prim_name = RIGHT.prim_name AND
                                   LEFT.prim_range = RIGHT.prim_range AND
                                   LEFT.sec_range = RIGHT.sec_range AND
                                   LEFT.address_ind = RIGHT.address_ind,
                                 RollupCorp(LEFT, RIGHT),
                                 LOCAL);

COUNT(Corp4_Base_Init_Rollup);

//************************************************************
// Group and Iterate to Set Current/Historical Indicator
//************************************************************

// Record Type has been initialized to historical 'H'
Corp4_Rollup_Sort := SORT(Corp4_Base_Init_Rollup, state_origin, sos_ter_nbr, LOCAL);
Corp4_Rollup_Grpd := GROUP(Corp4_Rollup_Sort, state_origin, sos_ter_nbr, LOCAL);
Corp4_Rollup_Grpd_Sort := SORT(Corp4_Rollup_Grpd, -dt_last_seen);

Corporate.Layout_Corporate_Base SetRecordType(Corporate.Layout_Corporate_Base L, Corporate.Layout_Corporate_Base R) := TRANSFORM
SELF.record_type := IF(L.record_type = '', 'C', R.record_type);
SELF.status := IF(L.status = '', R.status, L.status);
SELF.status_descp := IF(L.status_descp = '', R.status_descp, L.status_descp);
SELF := R;
END;

Corp4_Base := GROUP(ITERATE(Corp4_Rollup_Grpd_Sort, SetRecordType(LEFT, RIGHT)));
COUNT(Corp4_Base);

//************************************************************
// BDID the Corporate Records
//************************************************************

Corporate.MAC_BDID_Corp(Corp4_Base, Corp4_Base_BDID)

Corp4_Base_BDID_Out := Corp4_Base_BDID;

OUTPUT(Corp4_Base_BDID_Out,,'BASE::Corp4_' + Corporate.Corp4_Build_Date, OVERWRITE);