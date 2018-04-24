﻿IMPORT BIPV2,Business_Credit,BusinessCredit_Services,SBFE_Archive_Testing; 
 
EXPORT Layouts := 
  MODULE
    
    //==================  input file layout  ========================
    EXPORT CustInputRec := 
      RECORD
        STRING account;
        STRING bizName;
        STRING BizStreetAddress;
        STRING p_city_name;
        STRING st;
        STRING BizZip;
        STRING BizPhone;
        STRING FEIN; 
        STRING BizIpAddr;
        STRING FirstName;
        STRING MiddleName;
        STRING LastName;
        STRING NameSuffix;
        STRING StreetAddress;
        STRING City;
        STRING State;
        STRING Zip;
        STRING SSN; 
        STRING DateOfBirth;
        STRING age;
        STRING dlNum;
        STRING dlState;  
        STRING HomePhone;
        STRING emailAddr;
        STRING FormerLastName;
        STRING NewHistory;
      END;	
     
    EXPORT Batch_InputRec := 
      RECORD
        UNSIGNED2 groupNumber;
        STRING20	acctno;
        BIPV2.IDlayouts.l_key_ids_bare;
        STRING120 comp_name;
        STRING10 prim_range;
        STRING2 predir;
        STRING28 prim_name;
        STRING4 addr_suffix;
        STRING2 postdir;
        STRING10 unit_desig;
        STRING8 sec_range;
        STRING25 p_city_name;
        STRING2 st;
        STRING5 z5;
        STRING4 zip4;
        STRING18 county_name;
        STRING3 mileradius;
        STRING16 workphone;
        STRING9 fein;	
      END; 

    EXPORT BatchParent_InputRec := RECORD
      UNSIGNED2 ParentGroupNumber;
      DATASET(Batch_InputRec) BatchRecs;
    END;
  
    EXPORT Layout_BatchInput := 
      RECORD
        UNSIGNED5 Max_Search_Results_Per_Acct;
        UNSIGNED5 Max_Results_Per_Acct;
        STRING BIPFetchLevel;
        STRING DataPermissionMask;
        STRING Include_BusHeader;
        STRING GLBPurpose;
        STRING DPPAPurpose;
        DATASET(Batch_InputRec) Batch_In;
      END;
    
    EXPORT outputLayout := RECORD
        BusinessCredit_Services.Batch_layouts.Batch_Output_Final;
        Layout_BatchInput;
        STRING200 ErrorCode := '';
    END;   
    
    EXPORT FinalLayout := 
      RECORD
        STRING20 acctno;
        STRING transaction_id;
        STRING8 HistoryDate;
        BIPV2.IDlayouts.l_key_ids_bare.powid;
        BIPV2.IDlayouts.l_key_ids_bare.proxid;
        BIPV2.IDlayouts.l_key_ids_bare.seleid;
        BIPV2.IDlayouts.l_key_ids_bare.orgid;
        BIPV2.IDlayouts.l_key_ids_bare.ultid;
        STRING120 best_bus_name;                    
        STRING60 best_bus_streetaddress1;                 
        STRING60 best_bus_streetaddress2;                 
        STRING25 best_bus_city;                           
        STRING2 best_bus_state;                          
        STRING5 best_bus_zip;                            
        STRING11 best_bus_fein;
        STRING10 best_bus_phone10;                        
        STRING AccountID; 
        STRING12 AmountOutstanding;
        STRING AccountComments1;
        STRING ChargeOffAmount;
        STRING CurrentCreditLimit;
        STRING HiCreditOrOrigLoanAmount;
        STRING AccountTypeReportedCode;
        STRING12 OriginalAmount; 
        STRING12 PastDueAmount;
        STRING8 AccountOpenDate;
        STRING30 AccountStatus;
        STRING8 ChargeOffDate;
        STRING ChargeOffRecoveryAmount;
        STRING ChargeOffType;
        STRING8 AccountClosureDate;
        STRING GovernmentGuaranteed;
        STRING50 GovernmentGuaranteedCategory;
        STRING2 NumberOfGuarantors;
        STRING12 LastPaymentAmount;
        STRING8 LastPaymentDate;
        STRING PaymentStatus;
        STRING12 PaymentHistory12MonthsText;
        STRING100 AccountClosureReason;
        STRING20 PaymentFrequency;
        STRING8 ReportedDate;
        STRING9 CollateralIndicator;
        STRING AmtPastDueCycle1;
        STRING AmtPastDueCycle2;
        STRING AmtPastDueCycle3;
        STRING AmtPastDueCycle4;
        STRING AmtPastDueCycle5;
        STRING AmtPastDueCycle6;
        STRING AmtPastDueCycle7;
        STRING12 PaymentAmountScheduled;
        STRING8 AccountExpirationDate;
        STRING12 PaymentHistory24MonthsText;
        STRING30 Contributor;
        STRING AccountComments2; 
        STRING120 bus_name_1;
        STRING60 bus_streetaddress_1;
        STRING25 bus_city_1;
        STRING2 bus_state_1;
        STRING5 bus_zip_1;
        STRING11 bus_fein_1;
        STRING10 bus_phone10_1;
        STRING120 bus_name_2;
        STRING60 bus_streetaddress_2;
        STRING25 bus_city_2;
        STRING2 bus_state_2;
        STRING5 bus_zip_2;
        STRING11 bus_fein_2;
        STRING10 bus_phone10_2;
        STRING120 bus_name_3;
        STRING60 bus_streetaddress_3;
        STRING25 bus_city_3;
        STRING2 bus_state_3;
        STRING5 bus_zip_3;
        STRING11 bus_fein_3;
        STRING10 bus_phone10_3;
        STRING120 bus_name_4;
        STRING60 bus_streetaddress_4;
        STRING25 bus_city_4;
        STRING2 bus_state_4;
        STRING5 bus_zip_4;
        STRING11 bus_fein_4;
        STRING10 bus_phone10_4;
        STRING120 bus_name_5;
        STRING60 bus_streetaddress_5;
        STRING25 bus_city_5;
        STRING2 bus_state_5;
        STRING5 bus_zip_5;
        STRING11 bus_fein_5;
        STRING10 bus_phone10_5;
        STRING120 bus_name_6;
        STRING60 bus_streetaddress_6;
        STRING25 bus_city_6;
        STRING2 bus_state_6;
        STRING5 bus_zip_6;
        STRING11 bus_fein_6;
        STRING10 bus_phone10_6;
        STRING120 bus_name_7;
        STRING60 bus_streetaddress_7;
        STRING25 bus_city_7;
        STRING2 bus_state_7;
        STRING5 bus_zip_7;
        STRING11 bus_fein_7;
        STRING10 bus_phone10_7;
        STRING120 bus_name_8;
        STRING60 bus_streetaddress_8;
        STRING25 bus_city_8;
        STRING2 bus_state_8;
        STRING5 bus_zip_8;
        STRING11 bus_fein_8;
        STRING10 bus_phone10_8;
        STRING120 bus_name_9;
        STRING60 bus_streetaddress_9;
        STRING25 bus_city_9;
        STRING2 bus_state_9;
        STRING5 bus_zip_9;
        STRING11 bus_fein_9;
        STRING10 bus_phone10_9;
      END;
    
    EXPORT nameAddrVarLayout :=
      RECORD
        BIPV2.IDlayouts.l_key_ids_bare.seleid;
        BIPV2.IDlayouts.l_key_ids_bare.orgid;
        BIPV2.IDlayouts.l_key_ids_bare.ultid;
        UNSIGNED1 sortField := 5;
        STRING120 company_name; 
        STRING120 cnp_name;
        STRING2 predir;
        STRING10 prim_range;
        STRING28 prim_name;
        STRING4 addr_suffix;
        STRING2 postdir;
        STRING10 unit_desig;
        STRING8 sec_range;
        STRING25 v_city_name;                            
        STRING2 st;                          
        STRING5 zip;                            
        STRING11 company_fein;
        STRING10 company_phone;
        BOOLEAN current := FALSE;
        BOOLEAN isBest := FALSE;
        STRING company_name_type_derived;
        INTEGER dt_last_seen;
        INTEGER dt_first_seen;
        INTEGER1 seq := 0;
        STRING120 bus_name_1;
        STRING60 bus_streetaddress_1;
        STRING25 bus_city_1;
        STRING2 bus_state_1;
        STRING5 bus_zip_1;
        STRING11 bus_fein_1;
        STRING10 bus_phone10_1;
        STRING120 bus_name_2;
        STRING60 bus_streetaddress_2;
        STRING25 bus_city_2;
        STRING2 bus_state_2;
        STRING5 bus_zip_2;
        STRING11 bus_fein_2;
        STRING10 bus_phone10_2;
        STRING120 bus_name_3;
        STRING60 bus_streetaddress_3;
        STRING25 bus_city_3;
        STRING2 bus_state_3;
        STRING5 bus_zip_3;
        STRING11 bus_fein_3;
        STRING10 bus_phone10_3;
        STRING120 bus_name_4;
        STRING60 bus_streetaddress_4;
        STRING25 bus_city_4;
        STRING2 bus_state_4;
        STRING5 bus_zip_4;
        STRING11 bus_fein_4;
        STRING10 bus_phone10_4;
        STRING120 bus_name_5;
        STRING60 bus_streetaddress_5;
        STRING25 bus_city_5;
        STRING2 bus_state_5;
        STRING5 bus_zip_5;
        STRING11 bus_fein_5;
        STRING10 bus_phone10_5;
        STRING120 bus_name_6;
        STRING60 bus_streetaddress_6;
        STRING25 bus_city_6;
        STRING2 bus_state_6;
        STRING5 bus_zip_6;
        STRING11 bus_fein_6;
        STRING10 bus_phone10_6;
        STRING120 bus_name_7;
        STRING60 bus_streetaddress_7;
        STRING25 bus_city_7;
        STRING2 bus_state_7;
        STRING5 bus_zip_7;
        STRING11 bus_fein_7;
        STRING10 bus_phone10_7;
        STRING120 bus_name_8;
        STRING60 bus_streetaddress_8;
        STRING25 bus_city_8;
        STRING2 bus_state_8;
        STRING5 bus_zip_8;
        STRING11 bus_fein_8;
        STRING10 bus_phone10_8;
        STRING120 bus_name_9;
        STRING60 bus_streetaddress_9;
        STRING25 bus_city_9;
        STRING2 bus_state_9;
        STRING5 bus_zip_9;
        STRING11 bus_fein_9;
        STRING10 bus_phone10_9;
      END;
      
    EXPORT combinedLayout :=
      RECORD
        CustInputRec;
        FinalLayout;
        STRING10  best_prim_range;
        STRING28  best_prim_name;
        UNSIGNED4	dt_vendor_last_reported;
        Business_Credit.Layouts.AccountBaseSegment.payment_status_category;
        Business_Credit.Layouts.AccountBaseSegment.Account_Type_Reported;
        Business_Credit.Layouts.AccountBaseSegment.Remaining_Balance;
        Business_Credit.Layouts.AccountBaseSegment.Date_Account_Opened;
        Business_Credit.Layouts.AccountBaseSegment.Account_Status_1; 
        Business_Credit.Layouts.SBFEAccountLayout.Sbfe_Contributor_Number;
        Business_Credit.Layouts.SBFEAccountLayout.Contract_Account_Number;
        Business_Credit.Layouts.SBFEAccountLayout.Cycle_End_Date; 
        Business_Credit.Layouts.AccountBaseSegment.Date_Account_Closed; 
        Business_Credit.Layouts.AccountBaseSegment.Account_Closure_Basis; 
        Business_Credit.Layouts.AccountBaseSegment.Account_Status_2; 
        Business_Credit.Layouts.AccountBaseSegment.charge_off_type_indicator;
        Business_Credit.Layouts.AccountBaseSegment.payment_interval;
        Business_Credit.Layouts.rReleasedate.version;
      END;
    
    EXPORT custInputPlusCounterRec :=
      RECORD
        CustInputRec;
        INTEGER RecCounter;
      END;
    
  END;