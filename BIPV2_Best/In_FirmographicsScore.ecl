IMPORT BIPV2_Best;

EXPORT In_FirmographicsScore := PROJECT(BIPV2_Best.Base_FirmographicsScore, TRANSFORM({UNSIGNED6 ultid, UNSIGNED6 orgid, UNSIGNED6 seleid, INTEGER lnrs_modeled_marketing_revenue, STRING2 lnrs_modeled_marketing_revenue_code, INTEGER lnrs_modeled_marketing_employee_count, STRING2 lnrs_modeled_marketing_employee_count_code, STRING2 lnrs_modeled_marketing_industry},
  SELF.lnrs_modeled_marketing_industry := (STRING2) LEFT.lnrs_modeled_marketing_industry;
  SELF := LEFT;
  SELF := [];
));