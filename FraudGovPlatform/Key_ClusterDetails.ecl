Import data_services,doxie;
flagsrec := RECORD
   string indicator;
   string value;
  END;

r	:=RECORD
  integer8 customer_id_;
  integer8 industry_type_;
  string100 entity_context_uid_;
  string100 tree_uid_;
  unsigned8 source_customer_;
  unsigned1 __source_customer__flags;
  unsigned1 __customer_id__flags;
  unsigned1 __industry_type__flags;
  unsigned1 __tree_uid__flags;
  unsigned1 __entity_context_uid__flags;
  unsigned2 date_first_seen_;
  unsigned2 date_last_seen_;
  integer8 __recordcount;
  integer8 entity_type_;
  string label_;
  unsigned1 __label__flags;
  integer8 score_;
  unsigned1 __score__flags;
  integer8 cluster_score_;
  unsigned1 __cluster_score__flags;
  integer8 cl_event_count_;
  integer8 cl_identity_count_;
  integer8 cl_address_count_;
  integer8 deceased_match_;
  integer8 death_prior_to_all_events_;
  integer8 nas9_flag_;
  integer8 nap3_flag_;
  DATASET(RECORD
   string entity_context_uid_;
   unsigned1 __entity_context_uid__flags;
   unsigned2 date_first_seen_;
   unsigned2 date_last_seen_;
   integer8 __recordcount;
  END) exp1_;
  unsigned1 __exp1__flags;
  real8 latitude_;
  unsigned1 __latitude__flags;
  real8 longitude_;
  unsigned1 __longitude__flags;
  string street_address_;
  unsigned1 __street_address__flags;
  string vanity_city_;
  unsigned1 __vanity_city__flags;
  string state_;
  unsigned1 __state__flags;
  integer8 zip_;
  unsigned1 __zip__flags;
  integer8 person_count_;
  integer8 high_frequency_flag_;
  integer8 high_risk_death_prior_to_all_events_percent_flag_;
  integer8 all_high_risk_death_prior_to_all_events_person_percent_flag_;
  integer8 deceased_person_count_;
  DATASET(flagsrec) flags;
  unsigned8 __internal_fpos__;
 END;

d	:=dataset([],r);

EXPORT Key_ClusterDetails	:= Index(d,{customer_id_,industry_type_,entity_context_uid_,tree_uid_},{d},
																									 data_services.Data_location.Prefix('FraudGov') + 'thor_data400::key::fraudgov::' 
																									 + doxie.Version_SuperKey +'::kel::clusterdetails');

