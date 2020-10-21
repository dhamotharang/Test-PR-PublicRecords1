/* This function adds withdrawn status data for debtors. Also processing FCRA Overides for withdraws here*/

IMPORT BankruptcyV3, Bankruptcyv3_services, FCRA;

EXPORT fn_add_withdrawn_status(DATASET(bankruptcyv3_services.layouts.layout_rollup) ds_in,
                                BOOLEAN isFCRA = FALSE,
                                BOOLEAN suppress_withdrawn = FALSE,
                                DATASET (FCRA.Layout_override_flag) ds_flagfile = FCRA.compliance.blank_flagfile
                                ) := FUNCTION
  
  withdraw_key := BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus(,,isFCRA);
  
  // get debtors child dataset
  debtor_rec := RECORD
   STRING50 tmsid;
   STRING12 caseid;
   BankruptcyV3_Services.layouts.layout_party;
  END;
  
  debtors_ds := NORMALIZE(ds_in, LEFT.debtors,
                          TRANSFORM(debtor_rec, SELF.caseid := LEFT.caseid, SELF.tmsid := LEFT.tmsid, SELF := RIGHT));
  
  debtor_rec add_withdraws (debtor_rec le, withdraw_key ri) := TRANSFORM
  //,SKIP(suppress_withdrawn AND ri.withdrawndate <> '')
    SELF.WithdrawnStatus.withdrawnid := ri.withdrawnid;
    SELF.WithdrawnStatus.withdrawndate := ri.withdrawndate;
    SELF.WithdrawnStatus.withdrawndisposition := ri.withdrawndisposition;
    SELF.WithdrawnStatus.withdrawndispositiondate := ri.withdrawndispositiondate;
    SELF := le;
  END;
  
  // join to withdrawnstatus key.
  withdraw_recs := JOIN(debtors_ds, withdraw_key,
                        KEYED(LEFT.tmsid = RIGHT.tmsid AND LEFT.caseID = RIGHT.caseID AND LEFT.DefendantID = RIGHT.DefendantID),
                        add_withdraws(LEFT,RIGHT),
                        LEFT OUTER,
                        KEEP(1), LIMIT(0));

  // currently there are no overrides for withdrawn status data
 
  recs_debtors := withdraw_recs;
 
  // now placing debtors back to child dataset
  BankruptcyV3_Services.layouts.layout_rollup denorm_debtors(
    BankruptcyV3_Services.layouts.layout_rollup le,
    DATASET(debtor_rec) ri) := TRANSFORM                                       
     SELF.debtors := PROJECT(ri, BankruptcyV3_Services.layouts.layout_party);
     SELF := le;
  END;

  bk_recs_plus_withdrawn := DENORMALIZE(ds_in, recs_debtors,
                             LEFT.tmsid = RIGHT.tmsid,
                             GROUP,
                             denorm_debtors(LEFT,ROWS(RIGHT)));

  BankruptcyV3_Services.layouts.layout_rollup xform_suppress_withdrawn (BankruptcyV3_Services.layouts.layout_rollup le) := TRANSFORM,
  SKIP(LE.matched_party.did <> '' AND EXISTS(LE.debtors(WithdrawnStatus.withdrawndate<>'' AND did = LE.matched_party.did)))
                                            SELF.debtors := LE.debtors(WithdrawnStatus.withdrawndate='');
                                            SELF:= LE;
                                        END;
  // now we need to take care of suppression for withdrawn bk if requested
  bk_recs_suppress_withdrawn := PROJECT(bk_recs_plus_withdrawn,
                                        xform_suppress_withdrawn(LEFT));
  
  // suppression is only for FCRA side
  ds_out := IF(isFCRA AND suppress_withdrawn, bk_recs_suppress_withdrawn, bk_recs_plus_withdrawn);
  
  RETURN ds_out;
  
END;
