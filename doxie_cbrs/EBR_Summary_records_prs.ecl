IMPORT doxie_cbrs_Raw;
doxie_cbrs.mac_Selection_Declare()

EXPORT EBR_Summary_records_prs(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

raw := doxie_cbrs_Raw.EBR_Summary(bdids,Include_EBRSummary_val, Max_EBRSummary_val).records;

STRING DPP(STRING pp) := CASE(pp,
  'F' => 'Pays sooner than 50%',
  'L' => 'Pays slower than 70%',
  'S' => 'Pays the same',
  'H' => 'Pays slower than 50%',
  '');
  
STRING DPT(STRING pt) := CASE(pt,
  'S' => 'Stable',
  'L' => 'Increasingly late',
  'B' => 'Increasingly late, but better than industry',
  'I' => 'Improving',
  'P' => 'Improving, but slower than industry',
  'N' => 'No trend identifiable',
  '');

newrec := RECORD
   raw.level;
   raw.bdid;
   raw.process_date;
   raw.FILE_NUMBER;
   raw.SEGMENT_CODE;
   raw.SEQUENCE_NUMBER;
   raw.CURRENT_DBT;
   raw.PREDICTED_DBT;
   raw.CONF_PERCENT;
   raw.CONF_SLOPE;
   raw.orig_PREDICTED_DBT_DATE_MMDDYY;
   raw.AVERAGE_INDUSTRY_DBT;
   raw.AVERAGE_ALL_INDUSTRIES_DBT;
   raw.LOW_BALANCE;
   raw.HIGH_BALANCE;
   raw.CURRENT_ACCOUNT_BALANCE;
   raw.HIGH_CREDIT_EXTENDED;
   raw.MEDIAN_CREDIT_EXTENDED;
   raw.PAYMENT_PERFORMANCE;
   STRING20 PAYMENT_PERFORMANCE_DECODE := DPP(raw.PAYMENT_PERFORMANCE);
   raw.PAYMENT_TREND;
   STRING50 PAYMENT_TREND_DECODE := DPT(raw.PAYMENT_TREND);
   raw.INDUSTRY_DESCRIPTION;
   raw.predicted_dbt_date;
END;


RETURN table(raw, newrec);
END;
