IMPORT _Control.IPAddress;

EXPORT Base_FirmographicsScore := DATASET('~thor400_36::BIPv2::base::firmo_models_results::qa', {
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  integer8 lnrs_modeled_marketing_revenue;
  string2 lnrs_modeled_marketing_revenue_code;
  integer8 lnrs_modeled_marketing_employee_count;
  string2 lnrs_modeled_marketing_employee_count_code;
  string2 lnrs_modeled_marketing_industry;
  string70 lnrs_modeled_marketing_industry_code_description;
}, CSV(HEADING(1)));