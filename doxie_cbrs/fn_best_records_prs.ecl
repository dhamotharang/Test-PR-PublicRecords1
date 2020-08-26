IMPORT ut, doxie_cbrs;

EXPORT fn_best_records_prs(
  DATASET(doxie_cbrs.layout_supergroup) thegroupids,
  BOOLEAN in_use_supergroup
) :=
FUNCTION
  bes := doxie_cbrs.fn_best_records(thegroupids,in_use_supergroup);
  
  outrec := RECORD
    doxie_cbrs.layout_best_records_prs;
    UNSIGNED6 group_id;
  END;
  ut.MAC_Slim_Back(bes, outrec, wla)
  
  RETURN wla;
END;
