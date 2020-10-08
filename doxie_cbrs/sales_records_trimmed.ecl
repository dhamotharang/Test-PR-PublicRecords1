EXPORT sales_records_trimmed(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

doxie_cbrs.mac_Selection_Declare()

sales_recs := doxie_cbrs.sales_records(bdids)(Include_Sales_val);

sales_rec := RECORD
  sales_recs.sales;
  sales_recs.sales_desc;
  sales_recs.name;
  sales_recs.process_date;
  sales_recs.earnings;
  sales_recs.assets;
  sales_recs.liabilities;
  sales_recs.net_worth_;
END;

sales_rec Recs_trimmed(sales_recs r) := TRANSFORM
  SELF := r;
END;

SHARED sales_slim := PROJECT(sales_recs,Recs_trimmed(LEFT));

doxie_cbrs.mac_Selection_Declare()

EXPORT records := CHOOSEN(sales_slim,Max_Sales_val);
EXPORT records_count := COUNT(sales_slim);

END;
        
