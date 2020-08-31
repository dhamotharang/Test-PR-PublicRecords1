IMPORT Liens_Superior;

EXPORT Superior_Liens_records_prs :=
MODULE

  supl := doxie_cbrs.Superior_Liens_Raw;

  liens_superior.Layout_Liens_Superior_LNI tran(supl l) :=
  TRANSFORM
    SELF := l;
  END;
  SHARED p := PROJECT(supl, tran(LEFT));

  EXPORT records := p;
  EXPORT records_count := COUNT(p);

END;
