IMPORT NaturalDisaster_Readiness,ut,iesp, std;
/* Attribute to return information if a company is certified to assist during natural disasters */
  
doxie_cbrs.mac_Selection_Declare()
  
EXPORT natural_disaster_records(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

  natdis_work_rec := RECORD
    UNSIGNED6 bdid;
    STRING3 Total_No_Liaisons;
    STRING3 Total_No_Liaisons_A;
    STRING3 Total_No_Liaisons_B;
    STRING1 Total_No_Liaisons_C;
    STRING iso_reference;
    STRING iso_title;
    STRING iso_type;
  END;

  // Get data by bdid key file join.
  natdis_recs :=
    JOIN(bdids, NaturalDisaster_Readiness.Key_BDID,
      KEYED(LEFT.bdid = RIGHT.bdid),
      TRANSFORM(RIGHT),
      INNER,
      LIMIT(ut.limits.default, SKIP)
    );
  
  natdis_recs_dedup := DEDUP(SORT(natdis_recs, bdid, -date_lastseen, -date_updated), bdid);
    
  /* The reference,title and type are currently strung together delimited by a ;, we want these seperated
          and in child records. The process will split each reference,title and type into records via the normalize
          function and then roll up the records into children via a group Rollup. */
              
  natdis_work_rec xfm_iso_recs(RECORDOF(natdis_recs_dedup) l, INTEGER cnt) := TRANSFORM
    IReference := DATASET(Std.Str.SplitWords(l.ISO_Committee_Reference, ';'), {STRING iso_ref});
    ITitle := DATASET(Std.Str.SplitWords(l.ISO_Committee_Title, ';'), {STRING iso_title});
    IType := DATASET(Std.Str.SplitWords(l.ISO_Committee_Type, ';'), {STRING iso_type});
    SELF.iso_reference := IReference[cnt].iso_ref;
    SELF.iso_title := ITitle[cnt].iso_title;
    SELF.iso_type := IType[cnt].iso_type;
    SELF := l;
    SELF := [];
  END;

  norm_recs := GROUP(NORMALIZE(natdis_recs_dedup,(INTEGER)LEFT.Total_No_Liaisons,xfm_iso_recs(LEFT,COUNTER)),bdid);
  
  iesp.naturalDisaster.t_NaturalDisasterRecord roll_recs(natdis_work_rec l, DATASET(natdis_work_rec) allRows) := TRANSFORM
    SELF.LiaisonsTotals.Total := (INTEGER) l.Total_No_Liaisons;
    SELF.LiaisonsTotals.TotalA := (INTEGER) l.Total_No_Liaisons_A;
    SELF.LiaisonsTotals.TotalB := (INTEGER) l.Total_No_Liaisons_B;
    SELF.LiaisonsTotals.TotalC := (INTEGER) l.Total_No_Liaisons_C;
    SELF.ISOCommittees := PROJECT(CHOOSEN(allRows,iesp.constants.NATURAL_DISASTER.MaxISOCommittees),
      TRANSFORM(iesp.naturalDisaster.t_NatDisISOCommittee,
        SELF.Reference := LEFT.iso_reference,
        SELF.Title := LEFT.iso_title,
        SELF._Type := LEFT.iso_type));
  END;
  
  out_recs := ROLLUP(norm_recs, GROUP, roll_recs(LEFT,ROWS(LEFT)));
  ndrDedup := DEDUP(SORT(out_recs ,RECORD), RECORD);
  SHARED ndr_out := CHOOSEN(ndrDedup(Include_NatDisReady_val), iesp.constants.NATURAL_DISASTER.MaxNaturalDisaster);
  
  EXPORT records := CHOOSEN(ndr_out, Max_NatDisReady_val);
  EXPORT records_count := COUNT(ndr_out);

END;

