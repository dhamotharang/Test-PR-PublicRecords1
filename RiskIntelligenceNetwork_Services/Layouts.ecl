IMPORT Advo_Services, BatchShare, BatchServices, BIPV2, CriminalRecords_BatchService, DidVille, DriversV2_Services,
 dx_PhonesInfo, FraudShared_Services, risk_indicators;

EXPORT Layouts := MODULE

 EXPORT BatchIn_rec := RECORD
  unsigned4 seq := 0;
  BatchShare.Layouts.ShareAcct;
  BatchShare.Layouts.SharePII;
  BatchShare.Layouts.ShareDID;
  BatchShare.Layouts.ShareName;    
  BatchShare.Layouts.ShareAddress; //physical or single address
  BatchShare.Layouts.SharePhone;
  string50 email_address;
  string25 ip_address;
  string50 device_id;
  string10 bank_routing_number;
  string30 bank_account_number; 
  string2 dl_state;
  string25 dl_number;
 END;

 EXPORT fragment_w_value_recs := RECORD
  BatchShare.Layouts.ShareAcct;
  STRING60 fragment;
  STRING100 fragment_value;
 END;

 EXPORT entity_uid_recs := RECORD
  fragment_w_value_recs;
  STRING70 entity_context_uid := '';
 END;

 EXPORT entity_uid_recs_w_risk := RECORD
  entity_uid_recs;
  boolean hasKnownRisk;
  string10 RiskLevel;
 END;

 EXPORT dids_recs := RECORD
  BatchShare.Layouts.ShareAcct;
  DidVille.Layout_Did_OutBatch;
  string30 RecordSource;
 END;
 
 EXPORT dl_layout := RECORD
  BatchShare.Layouts.ShareAcct;
  DriversV2_Services.layouts.result_narrow;
 END;
 
 EXPORT prepaid_phone_layout := RECORD
  BatchShare.Layouts.ShareAcct;
  dx_PhonesInfo.Layouts.Phones_Type_Main;
 END;

 EXPORT realtime_appends_rec := RECORD
  FraudShared_Services.Layouts.BatchInExtended_rec batchin_rec;
  DATASET(CriminalRecords_BatchService.Layouts.batch_out) crim_appends;
  DATASET(Advo_Services.Advo_Batch_Service_Layouts.Batch_Out) advo_appends;
  DATASET(DidVille.Layout_Did_OutBatch) pr_best_appends;
  DATASET(prepaid_phone_layout) prepaid_phone_appends;
  DATASET(dl_layout) dl_appends;
  DATASET(risk_indicators.Layout_Boca_Shell) boca_shell_appends;
  DATASET(BatchServices.IP_Metadata_Layouts.batch_out) ip_meta_data;
 END;

 EXPORT LOG_Deltabase_Layout_Record := Record
  STRING20 gc_id;
  string20 cust_transaction_id;
  STRING10 cust_transaction_date;
  STRING20 case_id;
  STRING20 client_uid;
  STRING20 program_name;
  STRING100 inquiry_reason;
  STRING100 inquiry_source;
  STRING3 customer_county_code;
  STRING2 customer_state;
  STRING1 customer_vertical_code;
  STRING10 ssn;
  STRING10 dob;
  UNSIGNED6 lex_id;
  STRING100 name_full;
  STRING3 name_prefix;
  STRING20 name_first;
  STRING20 name_middle;
  STRING20 name_last;
  STRING5 name_suffix;
  STRING150 full_address;
  STRING100 physical_address;
  STRING25 physical_city;
  STRING2 physical_state;
  STRING5 physical_zip;
  STRING3 physical_county;
  STRING100 mailing_address;
  STRING25 mailing_city;
  STRING2 mailing_state;
  STRING5 mailing_zip;
  STRING3 mailing_county;
  STRING10 phone;
  BIPV2.IDlayouts.l_xlink_ids.UltID;
  BIPV2.IDlayouts.l_xlink_ids.OrgID;
  BIPV2.IDlayouts.l_xlink_ids.SeleID;
  STRING10 tin;
  STRING50 email_address;
  UNSIGNED6 appendedproviderid;
  UNSIGNED6 lnpid;
  STRING10 npi;
  STRING25 ip_address;
  STRING50 device_id;
  STRING12 professional_id;
  STRING20 bank_routing_number;
  STRING20 bank_account_number;
  STRING2 dl_state;
  STRING25 dl_number;
  STRING10 geo_lat;
  STRING11 geo_long;
  STRING20 date_added;
  UNSIGNED3 file_type;
  STRING10 deceitful_confidence;
  STRING30 user_added;
  STRING250 reason_description;
  string75 event_type_1;
  STRING30 event_entity_1;
  STRING50 context_uid;
 END;
 
 EXPORT LOG_Deltabase_Layout := RECORD
  DATASET(LOG_Deltabase_Layout_Record) Records {XPATH('Records/Rec'), MAXCOUNT(1)};
 END;
 
 EXPORT BatchOut_Risk_Attributes := RECORD
  BatchShare.Layouts.ShareAcct;
  BatchShare.MAC_ExpandLayout.Generate({STRING200 Risk_Attribute_Reason_},'',15, true);
 END; 
 
 EXPORT BatchOut_Known_Risks := RECORD
  BatchShare.Layouts.ShareAcct;
  BatchShare.MAC_ExpandLayout.Generate({STRING200 Known_Risk_Reason_},'',12, true);
  BatchShare.MAC_ExpandLayout.Generate({STRING100 Known_Risk_Agency_},'',12, true);
 END;
 
 EXPORT BatchOut_rec := RECORD  // This is Final Batch Output.
  BatchShare.Layouts.ShareAcct;
  BatchShare.Layouts.ShareDID;
  BatchShare.Layouts.SharePII;
  BatchShare.Layouts.ShareName;    
  BatchShare.Layouts.ShareAddress;
  BatchShare.Layouts.SharePhone;
  STRING25 dl_number;
  STRING2 dl_state;
  STRING25 ip_address;
  STRING50 device_id;
  STRING30 bank_account_number; 
  STRING10 bank_routing_number;
  STRING50 email_address;
  STRING1 identity_resolved;
  STRING10 risk_level;
  STRING8 Most_Recent_Activity_Date;
  UNSIGNED2 Total_Number_Identity_Activities;
  UNSIGNED2 Risk_Attribute_Count;
  BatchOut_Risk_Attributes - [acctno];
  UNSIGNED2 Known_Risk_Count;
  BatchOut_Known_Risks - [acctno];
 END;
END;