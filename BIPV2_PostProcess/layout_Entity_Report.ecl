IMPORT BIPV2;

EXPORT layout_Entity_Report := Module

  SHARED header_layout := Bipv2.commonbase.layout;
  
  EXPORT base_rec := {
    String state;
    header_layout.sele_gold;
    header_layout.seleid_status_private;
    header_layout.seleid_status_private_score;
    header_layout.seleid_status_public;
    header_layout.source;
  };
 
  EXPORT slim_rec := {
    header_layout.rcid;
    header_layout.seleid;
    base_rec;
    header_layout.proxid;
    header_layout.company_fein;
    header_layout.company_phone;
    header_layout.duns_number;
    header_layout.active_enterprise_number;
    header_layout.company_charter_number;	
    header_layout.dt_first_seen;
    header_layout.dt_last_seen;
    header_layout.contact_did;
    header_layout.company_sic_code1;
    header_layout.company_sic_code2;
    header_layout.company_sic_code3;
    header_layout.company_sic_code4;
    header_layout.company_sic_code5;
    header_layout.company_naics_code1;
    header_layout.company_naics_code2;
    header_layout.company_naics_code3;
    header_layout.company_naics_code4;
    header_layout.company_naics_code5;
    header_layout.company_name;
    string address;
  };
 
  EXPORT prox_range_rec := {
    unsigned4 ProxId_1;
    unsigned4 ProxId_2;
    unsigned4 ProxId_3to4;
    unsigned4 ProxId_5to10;
    unsigned4 ProxId_11to25;
    unsigned4 ProxId_26to100;
    unsigned4 ProxId_101to500;
    unsigned4 ProxId_501to2000;
    unsigned4 ProxId_2001_Plus;
  };
 
  EXPORT fein_range_rec := {			
    unsigned4 FEIN_1;
    unsigned4 FEIN_2;
    unsigned4 FEIN_3to4;
    unsigned4 FEIN_5to10;
    unsigned4 FEIN_11to25;
    unsigned4 FEIN_26to100;
    unsigned4 FEIN_101to500;
    unsigned4 FEIN_501to2000;
    unsigned4 FEIN_2001_Plus;
  };
						
  EXPORT source_type_rec := {
    unsigned4 src_pub;
    unsigned4 src_bur;
    unsigned4 src_dir;
    unsigned4 src_pub_bur;
    unsigned4 src_pub_dir;
    unsigned4 src_bur_dir;
    unsigned4 src_pub_bur_dir;
    unsigned4 src_Tel_only;
    unsigned4 src_none;
		};
 
  EXPORT count_rec := {
    unsigned5 seleid_tot;
    unsigned5 seleid_cnt;
    unsigned5 proxid_tot;
    unsigned5 lexid_tot;
    unsigned5 lexid_cnt;
    unsigned5 private_active_cnt;		
    unsigned5 private_inactive_cnt;
    unsigned5 private_defunct_cnt;
    unsigned5 public_active_cnt;		
    unsigned5 public_inactive_cnt;
    unsigned5 public_defunct_cnt;
    unsigned4 gold_cnt;
    unsigned4 charter_number_cnt;			
    unsigned4 duns_number_cnt;
    unsigned4 enterprise_number_cnt;
    unsigned4 phone_cnt;
    unsigned4 nonprofit_cnt;
    unsigned4 cortera_cnt;
    unsigned4 sec_of_state_cnt;
    unsigned4 recent_0to6m_cnt;
    unsigned4 recent_6to12_cnt;
    unsigned4 recent_12to18m_cnt;
    unsigned4 recent_18to24m_cnt;
    unsigned4 recent_inactive_2to3y_cnt;
    unsigned4 recent_inactive_3to5y_cnt;
    unsigned4 recent_inactive_5y_plus_cnt;
    unsigned4 recent_defunct_2to3y_cnt;
    unsigned4 recent_defunct_3to5y_cnt;
    unsigned4 recent_defunct_5y_plus_cnt;
    unsigned4 recent_unknown_cnt;
    unsigned4 sbfe_cnt;
    unsigned4 contact_did_cnt;
    unsigned4 sic_cnt;
    unsigned4 naics_cnt;
    unsigned5 proxid_cnt;
    prox_range_rec;
    unsigned4 fein_cnt;
    fein_range_rec;
    source_type_rec;
  };
 
  EXPORT  tally_rec := record			
    header_layout.seleid;
    base_rec;
    count_rec;
    source_type_rec;
  end;
  
  EXPORT report_rec := record			
    string    State;
    unsigned5 records;	
    unsigned5 seleids;
    source_type_rec;
    real Recs_per_Sele;
    real Prox_per_Sele;
    real Lexid_per_Sele;
    unsigned5 Active_Public;		
    unsigned5 Inactive_Public;
    unsigned5 Defunct_Public;
 
    unsigned5 FEIN_cnt;
    unsigned4 Charter_Num;			
    unsigned4 Duns_Num;
    unsigned4 Enterprise_Num;
    unsigned4 Phone;
    unsigned4 LexId;
    unsigned4 SIC;
    unsigned4 NAICS;
    unsigned4 Sec_of_State;
    unsigned4 SBFE;
    unsigned4 Cortera;
    unsigned4 Non_Profit;
    unsigned5 proxid_cnt;
    prox_range_rec;			
    fein_range_rec;
    unsigned5 Active_Private;		
    unsigned5 Inactive_Private;
    unsigned5 Defunct_Private;
    unsigned4 recent_0to6m;
    unsigned4 recent_6to12;
    unsigned4 recent_12to18m;
    unsigned4 recent_18to24m;
    unsigned4 recent_inactive_2to3y;
    unsigned4 recent_inactive_3to5y;
    unsigned4 recent_inactive_5y_plus;	
    unsigned4 recent_defunct_2to3y;
    unsigned4 recent_defunct_3to5y;
    unsigned4 recent_defunct_5y_plus;
    unsigned4 recent_unknown;
  end;
 
  EXPORT  percent_rec := {				
    String3 State;
    unsigned5 Seleids;	
    real Active_Public;		
    real Inactive_Public;
    real Defunct_Public;
    real FEIN_Total;
    real Charter_Num;			
    real Duns_Num;
    real Enterprise_Num;
    real Phone;
    real LexId;
    real SIC;
    real NAICS;
    real Sec_of_State;
    real SBFE;
    real Cortera;
    real Non_Profit;
    real ProxID_1;
    real ProxID_2;
    real ProxID_3to4;
    real ProxID_5to10;
    real ProxID_11to25;
    real ProxID_26to100;
    real ProxID_101to500;
    real ProxID_501to2000;
    real ProxID_2001_Plus;
    real FEIN_1;
    real FEIN_2;
    real FEIN_3to4;
    real FEIN_5to10;
    real FEIN_11to25;
    real FEIN_26to100;
    real FEIN_101to500;
    real FEIN_501to2000;
    real FEIN_2001_Plus;
    real Active_Private;		
    real Inactive_Private;
    real Defunct_Private;
    real recent_0to6m;
    real recent_6to12;
    real recent_12to18m;
    real recent_18to24m;
    real recent_inactive_2to3y;
    real recent_inactive_3to5y;
    real recent_inactive_5y_plus;
    real recent_defunct_2to3y;
    real recent_defunct_3to5y;
    real recent_defunct_5y_plus;
    real recent_unknown;
  };
  
  EXPORT file_layout := {
    STRING10 version, 
    String20 workunitName, 
    UNSIGNED timestamp, 
    STRING20 reportType, 
    report_rec
  };
  
END;