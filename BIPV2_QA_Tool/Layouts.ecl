﻿EXPORT Layouts :=
module

  export iteration_stats        := {string ID ,string version ,string iteration ,string StatName  ,string StatValue ,string notes };
  export persistence_stats      := {string ID ,string version                   ,string StatName  ,real8  StatValue               };
  export entity_stats           := {string ID ,string version ,string src       ,string StatName  ,string StatValue               };
  export postlink_stats         := {string ID ,string version                   ,string StatName  ,real8  StatValue               };
  export ingest_stats_by_source := {string version,string src  ,unsigned cnt_old ,unsigned cnt_unchanged ,unsigned cnt_updated ,unsigned cnt_new };
  export ingest_overall_stats_raw   := {string9 ingest_status ,unsigned cnt };
  export ingest_overall_stats   := {string version,string9 ingest_status ,unsigned cnt };

  export strata_persistence_stats :=
  record
    string40  cluster_type;
    string60  stat_desc   ;
    unsigned6 stat_value  :=0;
  end;


  export SourceStatsByDates := 
  RECORD
    string version;
    string src;
    unsigned8 cnt;
    unsigned8 cntnew;
    unsigned8 cntdeleted;
    unsigned8 cntunchanged;
    unsigned8 cntupdated;
    unsigned8 cnp_name_added;
    unsigned8 cnp_name_removed;
    unsigned8 cnp_name_modified;
    unsigned8 cnp_name_newlyadded;
    real4 cnp_name_base_population;
    real4 cnp_name_new_population;
    unsigned8 vl_id_added;
    unsigned8 vl_id_removed;
    unsigned8 vl_id_modified;
    unsigned8 vl_id_newlyadded;
    real4 vl_id_base_population;
    real4 vl_id_new_population;
    unsigned8 sbfe_id_added;
    unsigned8 sbfe_id_removed;
    unsigned8 sbfe_id_modified;
    unsigned8 sbfe_id_newlyadded;
    real4 sbfe_id_base_population;
    real4 sbfe_id_new_population;
    unsigned8 company_fein_added;
    unsigned8 company_fein_removed;
    unsigned8 company_fein_modified;
    unsigned8 company_fein_newlyadded;
    real4 company_fein_base_population;
    real4 company_fein_new_population;
    unsigned8 active_duns_number_added;
    unsigned8 active_duns_number_removed;
    unsigned8 active_duns_number_modified;
    unsigned8 active_duns_number_newlyadded;
    real4 active_duns_number_base_population;
    real4 active_duns_number_new_population;
    unsigned8 active_enterprise_number_added;
    unsigned8 active_enterprise_number_removed;
    unsigned8 active_enterprise_number_modified;
    unsigned8 active_enterprise_number_newlyadded;
    real4 active_enterprise_number_base_population;
    real4 active_enterprise_number_new_population;
    unsigned8 active_domestic_corp_key_added;
    unsigned8 active_domestic_corp_key_removed;
    unsigned8 active_domestic_corp_key_modified;
    unsigned8 active_domestic_corp_key_newlyadded;
    real4 active_domestic_corp_key_base_population;
    real4 active_domestic_corp_key_new_population;
    unsigned8 company_inc_state_added;
    unsigned8 company_inc_state_removed;
    unsigned8 company_inc_state_modified;
    unsigned8 company_inc_state_newlyadded;
    real4 company_inc_state_base_population;
    real4 company_inc_state_new_population;
    unsigned8 company_charter_number_added;
    unsigned8 company_charter_number_removed;
    unsigned8 company_charter_number_modified;
    unsigned8 company_charter_number_newlyadded;
    real4 company_charter_number_base_population;
    real4 company_charter_number_new_population;
    unsigned8 foreign_corp_key_added;
    unsigned8 foreign_corp_key_removed;
    unsigned8 foreign_corp_key_modified;
    unsigned8 foreign_corp_key_newlyadded;
    real4 foreign_corp_key_base_population;
    real4 foreign_corp_key_new_population;
    unsigned8 company_foreign_domestic_added;
    unsigned8 company_foreign_domestic_removed;
    unsigned8 company_foreign_domestic_modified;
    unsigned8 company_foreign_domestic_newlyadded;
    real4 company_foreign_domestic_base_population;
    real4 company_foreign_domestic_new_population;
    unsigned8 prim_range_added;
    unsigned8 prim_range_removed;
    unsigned8 prim_range_modified;
    unsigned8 prim_range_newlyadded;
    real4 prim_range_base_population;
    real4 prim_range_new_population;
    unsigned8 prim_name_added;
    unsigned8 prim_name_removed;
    unsigned8 prim_name_modified;
    unsigned8 prim_name_newlyadded;
    real4 prim_name_base_population;
    real4 prim_name_new_population;
    unsigned8 sec_range_added;
    unsigned8 sec_range_removed;
    unsigned8 sec_range_modified;
    unsigned8 sec_range_newlyadded;
    real4 sec_range_base_population;
    real4 sec_range_new_population;
    unsigned8 v_city_name_added;
    unsigned8 v_city_name_removed;
    unsigned8 v_city_name_modified;
    unsigned8 v_city_name_newlyadded;
    real4 v_city_name_base_population;
    real4 v_city_name_new_population;
    unsigned8 st_added;
    unsigned8 st_removed;
    unsigned8 st_modified;
    unsigned8 st_newlyadded;
    real4 st_base_population;
    real4 st_new_population;
    unsigned8 zip_added;
    unsigned8 zip_removed;
    unsigned8 zip_modified;
    unsigned8 zip_newlyadded;
    real4 zip_base_population;
    real4 zip_new_population;
    unsigned8 company_phone_added;
    unsigned8 company_phone_removed;
    unsigned8 company_phone_modified;
    unsigned8 company_phone_newlyadded;
    real4 company_phone_base_population;
    real4 company_phone_new_population;
    unsigned8 fname_added;
    unsigned8 fname_removed;
    unsigned8 fname_modified;
    unsigned8 fname_newlyadded;
    real4 fname_base_population;
    real4 fname_new_population;
    unsigned8 mname_added;
    unsigned8 mname_removed;
    unsigned8 mname_modified;
    unsigned8 mname_newlyadded;
    real4 mname_base_population;
    real4 mname_new_population;
    unsigned8 lname_added;
    unsigned8 lname_removed;
    unsigned8 lname_modified;
    unsigned8 lname_newlyadded;
    real4 lname_base_population;
    real4 lname_new_population;
    unsigned8 new_dt_first_seen_future;
    unsigned8 new_dt_first_seen_current;
    unsigned8 new_dt_first_seen_3_months;
    unsigned8 new_dt_first_seen_6_months;
    unsigned8 new_dt_first_seen_12_months;
    unsigned8 new_dt_first_seen_24_months;
    unsigned8 new_dt_first_seen_older;
    unsigned8 change_dt_first_seen_from_zero;
    unsigned8 change_dt_first_seen_to_zero;
    unsigned8 change_dt_first_seen_modified_1_month;
    unsigned8 change_dt_first_seen_modified_3_months;
    unsigned8 change_dt_first_seen_modified_6_months;
    unsigned8 change_dt_first_seen_modified_12_months;
    unsigned8 change_dt_first_seen_modified_24_months;
    unsigned8 change_dt_first_seen_modified_longer;
    unsigned8 new_dt_last_seen_future;
    unsigned8 new_dt_last_seen_current;
    unsigned8 new_dt_last_seen_3_months;
    unsigned8 new_dt_last_seen_6_months;
    unsigned8 new_dt_last_seen_12_months;
    unsigned8 new_dt_last_seen_24_months;
    unsigned8 new_dt_last_seen_older;
    unsigned8 change_dt_last_seen_from_zero;
    unsigned8 change_dt_last_seen_to_zero;
    unsigned8 change_dt_last_seen_modified_1_month;
    unsigned8 change_dt_last_seen_modified_3_months;
    unsigned8 change_dt_last_seen_modified_6_months;
    unsigned8 change_dt_last_seen_modified_12_months;
    unsigned8 change_dt_last_seen_modified_24_months;
    unsigned8 change_dt_last_seen_modified_longer;
    unsigned8 new_dt_vendor_first_reported_future;
    unsigned8 new_dt_vendor_first_reported_current;
    unsigned8 new_dt_vendor_first_reported_3_months;
    unsigned8 new_dt_vendor_first_reported_6_months;
    unsigned8 new_dt_vendor_first_reported_12_months;
    unsigned8 new_dt_vendor_first_reported_24_months;
    unsigned8 new_dt_vendor_first_reported_older;
    unsigned8 change_dt_vendor_first_reported_from_zero;
    unsigned8 change_dt_vendor_first_reported_to_zero;
    unsigned8 change_dt_vendor_first_reported_modified_1_month;
    unsigned8 change_dt_vendor_first_reported_modified_3_months;
    unsigned8 change_dt_vendor_first_reported_modified_6_months;
    unsigned8 change_dt_vendor_first_reported_modified_12_months;
    unsigned8 change_dt_vendor_first_reported_modified_24_months;
    unsigned8 change_dt_vendor_first_reported_modified_longer;
    unsigned8 new_dt_vendor_last_reported_future;
    unsigned8 new_dt_vendor_last_reported_current;
    unsigned8 new_dt_vendor_last_reported_3_months;
    unsigned8 new_dt_vendor_last_reported_6_months;
    unsigned8 new_dt_vendor_last_reported_12_months;
    unsigned8 new_dt_vendor_last_reported_24_months;
    unsigned8 new_dt_vendor_last_reported_older;
    unsigned8 change_dt_vendor_last_reported_from_zero;
    unsigned8 change_dt_vendor_last_reported_to_zero;
    unsigned8 change_dt_vendor_last_reported_modified_1_month;
    unsigned8 change_dt_vendor_last_reported_modified_3_months;
    unsigned8 change_dt_vendor_last_reported_modified_6_months;
    unsigned8 change_dt_vendor_last_reported_modified_12_months;
    unsigned8 change_dt_vendor_last_reported_modified_24_months;
    unsigned8 change_dt_vendor_last_reported_modified_longer;
   END;


end;