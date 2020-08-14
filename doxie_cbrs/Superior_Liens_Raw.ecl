IMPORT Liens_Superior;

key_bdid := Liens_Superior.key_bdid;
mybdids := doxie_cbrs.ds_subject_BDIDs;

liens_superior.Layout_Liens_Superior_LNI join_tran(key_bdid l):= TRANSFORM
  SELF := l;
END;

base_sup_recs := JOIN(mybdids, key_bdid,
        LEFT.bdid = RIGHT.bdid,
        join_tran(RIGHT));
        
EXPORT Superior_Liens_Raw := base_sup_recs;
