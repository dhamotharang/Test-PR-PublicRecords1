IMPORT paw_services;
EXPORT PAW_OutRecsLayout :=
  RECORD
    UNSIGNED __seq;
    paw_services.Layouts.rptPerson;
    UNSIGNED2 comp_prop_count := 0;
    UNSIGNED2 veh_cnt := 0;
    UNSIGNED2 dl_cnt := 0;
    UNSIGNED2 rel_count := 0;
    UNSIGNED2 assoc_count := 0;
    UNSIGNED2 prof_count := 0;
    UNSIGNED2 paw_count := 0;
    UNSIGNED2 vess_count := 0;
    UNSIGNED2 email_count := 0;
    UNSIGNED2 accident_count := 0;
    UNSIGNED2 phonesplus_count := 0;
  END;
