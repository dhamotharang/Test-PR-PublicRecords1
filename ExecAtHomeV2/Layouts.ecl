IMPORT BIPV2, ExecAtHomeV2;

EXPORT Layouts := 
  MODULE

  EXPORT layoutBatchIn := 
    RECORD
      STRING20  acctno;
      STRING20  customer_id;
      STRING120 business_name;
      STRING120 business_address;
      STRING25  city;
      STRING2   st;
      STRING5   zip;
      STRING10	fein;
      STRING10  phone;
    END;
    
  EXPORT SearchSlimLayout := 
  RECORD
    layoutBatchIn.Acctno;
    BIPV2.IDlayouts.l_xlink_ids2;
    UNSIGNED6 weight;
	END;
    
  EXPORT layoutEahOutput :=
  RECORD
    STRING20  acctno;
    STRING20  customer_id;
    BIPV2.IDlayouts.l_key_ids_bare; 
    UNSIGNED6 did;
    UNSIGNED6 hhid;  
    STRING50  company_title;  
    STRING1   business_decision_maker_flag;    
    STRING1   business_owner_flag; 
    STRING20  person_best_fname;
    STRING20  person_best_mname;
    STRING20  person_best_lname;
    STRING5   person_best_name_suffix;
    STRING10  person_prim_range;
    STRING2   person_predir;
    STRING28  person_prim_name;
    STRING4   person_suffix;
    STRING2   person_postdir;
    STRING10  person_unit_desig;
    STRING8   person_sec_range;
    STRING25  person_best_city;
    STRING2   person_best_state;
    STRING5   person_best_zip;
    STRING4   person_best_zip4;
    STRING8   person_addr_dt_last_seen;
    STRING3   length_of_residence; 
    STRING10  person_best_phone; 
    STRING1   person_best_phone_active;  
    STRING82  emailAddress; 
    STRING1   do_not_call_flag;  
    STRING1   do_not_mail_flag;  
    STRING3   Age;
    STRING2   Gender;
    STRING2   MaritalStatus;
    STRING2	  dwelling_type;
    STRING2   household_Income_Identifier; // HHEstimatedIncomeRange;
    STRING2   estimated_home_income_predictor; // ProspectEstimatedIncomeRange;
    STRING3   HouseholdCount;  
    STRING3   HHTeenagerMmbrCnt;  
    STRING3   HHYoungAdultMmbrCnt;  
    STRING3   HHMiddleAgemmbrCnt;  
    STRING3   HHSeniorMmbrCnt;  
    STRING3   HHElderlyMmbrCnt;  
    STRING2   ProspectDeceased;
    STRING2	  ProspectCollegeAttended;
    STRING3   CrtRecCnt;
    STRING3   CrtRecCnt12Mo;
    STRING3   CrtRecLienJudgCnt;
    STRING3   CrtRecLienJudgCnt12Mo;
    STRING7		CrtRecLienJudgAmtTtl;  
    STRING3   CrtRecBkrptCnt;
    STRING3   CrtRecBkrptCnt12Mo;
    STRING2   OccProfLicense;
    STRING2   OccProfLicenseCategory;
    STRING2   OccBusinessAssociation;  
    STRING3   OccBusinessAssociationTime;
    STRING3   HHOccBusinessAssocMmbrCnt;
    STRING3   RaAOccBusinessAssocMmbrCnt;
    STRING120 business_best_company_name;
    STRING10  business_best_prim_range;
    STRING2   business_best_predir;
    STRING28  business_best_prim_name;
    STRING4   business_best_addr_suffix;
    STRING2   business_best_postdir;
    STRING10  business_best_unit_desig;
    STRING8   business_best_sec_range;
    STRING25  business_best_city;
    STRING2   business_best_state;
    STRING5   business_best_zip;
    STRING4   business_best_zip4;
    STRING10  business_best_phone;
    STRING10  business_best_fein;
    STRING10  business_best_sic_code;
    STRING12  Sales;  
    STRING9   EmployeeCnt;
    STRING3   ResCurrBusinessCnt;
    STRING3   ResInputBusinessCnt;
    STRING70  OrgType; 
  END;
    
  EXPORT expandedLayout :=
  RECORD
    layoutEahOutput;
    INTEGER executive_ind_order;
    STRING8 dob;
    STRING9 ssn;
    UNSIGNED6 bdid;
    STRING2 sourceCode;
    BOOLEAN executive_flag;
    STRING8 dt_last_seen;
    BOOLEAN watchdogPhone;
  END;
  
  EXPORT ExecutiveTitlesLayout := 
  RECORD
    STRING35 companyTitle;
    INTEGER  executive_ind_order;
  END;

END;