
IMPORT doxie_cbrs, codes, corp2, corp2_services;

doxie_cbrs.mac_Selection_Declare()

EXPORT profile_records(DATASET(doxie_cbrs.layout_references) bdids) := MODULE

  SHARED incl_company_profile := Include_CompanyProfile_val;
  SHARED max_corp_filings := Max_CorporationFilings_val;
  SHARED CURRENT := 'C';
  
  // Obtaining corp filing records by bdid does not ensure that the system will return the most current
  // record for that business. To do this, we need to obtain records by corp_key.
  SHARED corp_keys := Corp2_services.corp2_raw.get_corpkeys_from_bdids(bdids)(incl_company_profile);

  SHARED pr_raw :=
    JOIN(
      corp_keys, corp2.Key_Corp_corpkey,
      KEYED(RIGHT.corp_key = LEFT.corp_key),
      TRANSFORM(RIGHT),
      INNER,
      KEEP(10000)
    );

  // Sort to the top those records whose type is Current and disposition is Legal. This will
  // ensure the most recent record gets returned at the highest position. (These are the same
  // dedup-sort criteria used in Corp2_services.corp2_report_recs).
  SHARED pr_raw_sorted :=
    SORT(
      DEDUP(pr_raw, RECORD, EXCEPT corp_process_date, ALL),
      corp_key,
      -(UNSIGNED1)(record_type = CURRENT),
      -(UNSIGNED1)(corp_ln_name_type_desc = 'LEGAL'),
      -corp_process_date,
      RECORD
      );
      
  SHARED profile_info :=
    PROJECT(
      pr_raw_sorted,
      TRANSFORM( doxie_cbrs.layouts.profile_record,
        SELF.record_date := codes.corp2.corp_record_date(LEFT.record_type),
        SELF := LEFT
      )
    );

  EXPORT records := CHOOSEN(profile_info, max_corp_filings);
  EXPORT records_count := COUNT(profile_info);

END;
