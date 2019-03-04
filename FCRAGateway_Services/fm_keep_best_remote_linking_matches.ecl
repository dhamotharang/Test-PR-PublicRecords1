//This FM will apply logic to remote linking matches in a batch environment.
//The reasoning is we can have multiple matches per single input. Only 1 best_lexID
//value per request should be considered a match.
//This takes the highest conf score per acctno, and keeps that as well as any other
//matches with the same best_lexID. Additionally it will remove records which have
//two or more results with matching conf scores, but different best_lexID values.

//Requires the fields: acctno, best_lexID, and conf.
//Doesn't take "match" field into account, which is a field that remote linking returns.
//when the conf score is high enough to be an FCRA compliant match.
EXPORT fm_keep_best_remote_linking_matches(__ds_in) := FUNCTIONMACRO
  rec := RECORDOF(__ds_in);

  //Separate the highest scoring lexIDs.
  ds_hi_score_lexIDs := DEDUP(SORT(__ds_in, acctno, best_lexid, -conf), acctno, best_lexid);

  //Sort and Group by acctno to have subsequent operations run on each individual acctno.
  ds_hi_score_lexIDs_grouped := GROUP(SORT(ds_hi_score_lexIDs, acctno, -conf), acctno);

  //Only keep records with a single highest conf score per account.
  //This removes the ambigous matches where we have 2 of the same conf scores with differing lexID values.
  rec Roll_Remove_Ambiguous(rec L, DATASET(rec) grouped_recs) := transform
    max_score := MAX(grouped_recs, conf);
    keep_rec := COUNT(grouped_recs(conf >= max_score)) = 1;
    SELF.acctno := IF(keep_rec, L.acctno, SKIP);
    SELF := L;
  END;

  dl_hi_score_ambig_removed := ROLLUP(ds_hi_score_lexIDs_grouped, GROUP, Roll_Remove_Ambiguous(LEFT, ROWS(LEFT)));

  //Now add back records with matching lexID which were deduped.
  //In the case of lexID = 0, we only add other matching ones back that have the same conf score.
  dl_all_best_lexIDs := JOIN(__ds_in, dl_hi_score_ambig_removed, LEFT.acctno = RIGHT.acctno AND
    LEFT.best_lexID = RIGHT.best_lexID AND (LEFT.best_lexID <> 0 OR LEFT.conf = RIGHT.conf),
    TRANSFORM(LEFT), KEEP(1), LIMIT(0));

  RETURN dl_all_best_lexIDs;

ENDMACRO;