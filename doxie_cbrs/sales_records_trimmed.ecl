IMPORT doxie_cbrs;
EXPORT sales_records_trimmed(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

  doxie_cbrs.mac_Selection_Declare()

  sales_recs := doxie_cbrs.sales_records(bdids)(Include_Sales_val);

  sales_rec := doxie_cbrs.layouts.sales_record;

  sales_rec Recs_trimmed(sales_recs r) := TRANSFORM
    SELF := r;
  END;

  SHARED sales_slim := PROJECT(sales_recs,Recs_trimmed(LEFT));

  doxie_cbrs.mac_Selection_Declare()

  EXPORT records := CHOOSEN(sales_slim,Max_Sales_val);
  EXPORT records_count := COUNT(sales_slim);

END;
        
