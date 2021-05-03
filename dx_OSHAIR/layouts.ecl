IMPORT address, BIPV2, dx_common, standard;

EXPORT Layouts := MODULE
 
  //----------------------------------------------------------------------
  // Layout Key Delta RID
  //----------------------------------------------------------------------
  EXPORT Layout_Delta_Rid := RECORD
    dx_common.layout_metadata.record_sid;
    dx_common.layout_metadata.dt_effective_first;
    dx_common.layout_metadata.dt_effective_last;
  END;
  
  //----------------------------------------------------------------------
  // Layout BDID
  //----------------------------------------------------------------------
  EXPORT Layout_BDID := RECORD
    BIG_ENDIAN UNSIGNED4 Activity_Number;
    UNSIGNED6            bdid  := 0;
  END;
  
  //----------------------------------------------------------------------
  // Layout LinkIds
  //----------------------------------------------------------------------
  EXPORT Layout_LinkIds := RECORD
    bipv2.IDlayouts.l_key_ids;
    UNSIGNED8      source_rec_id := 0;
    STRING1        Continuation_Flag;
    STRING1        History_Flag;
    STRING20       History_Desc := '';
    BIG_ENDIAN UNSIGNED4 Last_Activity_Date;
    STRING1        Fed_State_Flag;
    STRING1        Previous_Activity_Type;
    STRING31       Prev_Activity_Type_Desc := '';
    BIG_ENDIAN UNSIGNED4 Previous_Activity_Number;
    BIG_ENDIAN UNSIGNED4 Activity_Number;
    STRING2        Region_Code;
    STRING3        Area_Code;
    STRING2        Office_Code;
    STRING5        Compliance_Officer_ID;
    STRING1        Compliance_Officer_Job_Title;
    STRING20       Compl_Officer_Job_Title_Desc := '';
    STRING4        Hist_Area;
    STRING5        Hist_Report_Number;
    STRING30       Inspected_Site_Name;
    STRING30       Inspected_Site_Street;
    STRING2        Inspected_Site_State;
    DECIMAL5       Inspected_Site_Zip;
    BIG_ENDIAN UNSIGNED2 Inspected_Site_City_Code;
    STRING30       Inspected_Site_City_Name := '';
    DECIMAL3       Inspected_Site_County_Code;
    BIG_ENDIAN UNSIGNED4 DUNS_Number;
    STRING17       Host_Establishment_key;
    STRING1        Owner_Type;
    STRING18       Own_Type_Desc := '';
    BIG_ENDIAN UNSIGNED2 Owner_Code;
    STRING1        Advance_Notice_Flag;
    BIG_ENDIAN UNSIGNED4 Inspection_Opening_Date;
    BIG_ENDIAN UNSIGNED4 Inspection_Close_Date;
    STRING1        Safety_Health_Flag;
    BIG_ENDIAN UNSIGNED2 SIC_Code;
    BIG_ENDIAN UNSIGNED2 SIC_Guide;
    BIG_ENDIAN UNSIGNED2 SIC_Inspected;
    STRING6        NAICS_Code;
    STRING6        NAICS_Secondary_Code;
    STRING6        NAIC_Inspected;
    STRING1        Inspection_Type;
    STRING27       Insp_Type_Desc := '';
    STRING1        Inspection_Scope;
    STRING13       Insp_Scope_Desc := '';
    DECIMAL5       Number_In_Establishment;
    DECIMAL5       Number_Covered;
    DECIMAL7       Number_Total_Employees;
    STRING1        Walk_Around_Flag;
    STRING1        Employees_Interviewed_Flag;
    STRING1        Union_Flag; 
    STRING1        Closed_Case_Flag;
    STRING1        Why_No_Inspection_Code;
    BIG_ENDIAN UNSIGNED4 Close_Case_Date;
    STRING1        Safety_PG_Manufacturing_Insp_Flag;
    STRING1        Safety_PG_Construction_Insp_Flag;
    STRING1        Safety_PG_Maritime_Insp_Flag;
    STRING1        Health_PG_Manufacturing_Insp_Flag;
    STRING1        Health_PG_Construction_Insp_Flag;
    STRING1        Health_PG_Maritime_Insp_Flag;
    STRING1        Migrant_Farm_Insp_Flag;
    STRING1        Antic_Served;
    BIG_ENDIAN UNSIGNED4 First_Denial_Date;
    BIG_ENDIAN UNSIGNED4 Last_Reenter_Date;
    DECIMAL5_2     bls_Loss_Workday_Injury_Rate;
    STRING1        Informal_SH_Program_Init_Flag;
    STRING1        Informal_Data_Required;
    BIG_ENDIAN UNSIGNED4 Penalties_Due_Date;
    BIG_ENDIAN UNSIGNED4 FTA_Due_Date;
    STRING1        Due_Date_Type;
    BIG_ENDIAN UNSIGNED2 PA_Prep_Time;
    BIG_ENDIAN UNSIGNED2 PA_Travel_Time;
    BIG_ENDIAN UNSIGNED2 PA_On_site_Time;
    BIG_ENDIAN UNSIGNED2 PA_Tech_supp_Time;
    BIG_ENDIAN UNSIGNED2 PA_Report_prep_Time;
    BIG_ENDIAN UNSIGNED2 PA_Other_conf_Time;
    BIG_ENDIAN UNSIGNED2 PA_Litigation_Time;
    BIG_ENDIAN UNSIGNED2 PA_Denial_Time;
    BIG_ENDIAN UNSIGNED4 PA_Sum_hours;
    BIG_ENDIAN UNSIGNED4 Earliest_Contest_Date;
    DECIMAL11_2    Remitted_Penalty_Amount;
    DECIMAL11_2    Remitted_FTA_Amount;
    DECIMAL11_2    Total_Penalties;
    DECIMAL11_2    Total_FTA;
    DECIMAL5       Total_Violations;
    DECIMAL5       Total_Serious_Violations;
    UNSIGNED2      Number_Program;
    UNSIGNED2      Number_Rel_Activity;
    UNSIGNED2      Number_Optional_Info;
    UNSIGNED2      Number_Debt;
    UNSIGNED2      Number_Violations;
    UNSIGNED2      Number_Event;
    UNSIGNED2      Number_Hazardous_Substance;
    UNSIGNED2      Number_Accident;
    UNSIGNED2      Number_Admin_Pay;
    STRING30       cname;
    UNSIGNED6      bdid  := 0;
    UNSIGNED2      BDID_score := 0;
    STRING9        FEIN_append  := '';
    Standard.L_Address.detailed;
    INTEGER1       fp := 0;
  END;  
 
  //----------------------------------------------------------------------
  // Layout Inspection Payload
  //----------------------------------------------------------------------  
  EXPORT Layout_Inspection := RECORD 
    unsigned4 dt_first_seen            := 0;
    unsigned4 dt_last_seen             := 0;
    unsigned4 dt_vendor_first_reported := 0;
    unsigned4 dt_vendor_last_reported  := 0;
    bipv2.IDlayouts.l_xlink_ids;
    UNSIGNED8      source_rec_id := 0;
    STRING1        Continuation_Flag;
    STRING1        History_Flag;
    STRING20       History_Desc := '';
    BIG_ENDIAN UNSIGNED4 Last_Activity_Date;
    STRING1        Fed_State_Flag;
    STRING1        Previous_Activity_Type;
    STRING31       Prev_Activity_Type_Desc := '';
    BIG_ENDIAN UNSIGNED4 Previous_Activity_Number;
    BIG_ENDIAN UNSIGNED4 Activity_Number;
    STRING2        Region_Code;
    STRING3        Area_Code;
    STRING2        Office_Code;
    STRING5        Compliance_Officer_ID;
    STRING1        Compliance_Officer_Job_Title;
    STRING20       Compl_Officer_Job_Title_Desc := '';
    STRING4        Hist_Area;
    STRING5        Hist_Report_Number;
    STRING30       Inspected_Site_Name;
    STRING30       Inspected_Site_Street;
    STRING2        Inspected_Site_State;
    DECIMAL5       Inspected_Site_Zip;
    BIG_ENDIAN UNSIGNED2 Inspected_Site_City_Code;
    STRING30       Inspected_Site_City_Name := '';
    DECIMAL3       Inspected_Site_County_Code;
    BIG_ENDIAN UNSIGNED4 DUNS_Number;
    STRING17       Host_Establishment_key;
    STRING1        Owner_Type;
    STRING18       Own_Type_Desc := '';
    BIG_ENDIAN UNSIGNED2 Owner_Code;
    STRING1        Advance_Notice_Flag;
    BIG_ENDIAN UNSIGNED4 Inspection_Opening_Date;
    BIG_ENDIAN UNSIGNED4 Inspection_Close_Date;
    STRING1        Safety_Health_Flag;
    BIG_ENDIAN UNSIGNED2 SIC_Code;
    BIG_ENDIAN UNSIGNED2 SIC_Guide;
    BIG_ENDIAN UNSIGNED2 SIC_Inspected;
    STRING6        NAICS_Code;
    STRING6        NAICS_Secondary_Code;
    STRING6        NAIC_Inspected;
    STRING1        Inspection_Type;
    STRING27       Insp_Type_Desc := '';
    STRING1        Inspection_Scope;
    STRING13       Insp_Scope_Desc := '';
    DECIMAL5       Number_In_Establishment;
    DECIMAL5       Number_Covered;
    DECIMAL7       Number_Total_Employees;
    STRING1        Walk_Around_Flag;
    STRING1        Employees_Interviewed_Flag;
    STRING1        Union_Flag;
    STRING1        Closed_Case_Flag;
    STRING1        Why_No_Inspection_Code;
    BIG_ENDIAN UNSIGNED4 Close_Case_Date;
    STRING1        Safety_PG_Manufacturing_Insp_Flag;
    STRING1        Safety_PG_Construction_Insp_Flag;
    STRING1        Safety_PG_Maritime_Insp_Flag;
    STRING1        Health_PG_Manufacturing_Insp_Flag;
    STRING1        Health_PG_Construction_Insp_Flag;
    STRING1        Health_PG_Maritime_Insp_Flag;
    STRING1        Migrant_Farm_Insp_Flag;
    STRING1        Antic_Served;
    BIG_ENDIAN UNSIGNED4 First_Denial_Date;
    BIG_ENDIAN UNSIGNED4 Last_Reenter_Date;
    DECIMAL5_2     bls_Loss_Workday_Injury_Rate;
    STRING1        Informal_SH_Program_Init_Flag;
    STRING1        Informal_Data_Required;
    BIG_ENDIAN UNSIGNED4 Penalties_Due_Date;
    BIG_ENDIAN UNSIGNED4 FTA_Due_Date;
    STRING1        Due_Date_Type;
    BIG_ENDIAN UNSIGNED2 PA_Prep_Time;
    BIG_ENDIAN UNSIGNED2 PA_Travel_Time;
    BIG_ENDIAN UNSIGNED2 PA_On_site_Time;
    BIG_ENDIAN UNSIGNED2 PA_Tech_supp_Time;
    BIG_ENDIAN UNSIGNED2 PA_Report_prep_Time;
    BIG_ENDIAN UNSIGNED2 PA_Other_conf_Time;
    BIG_ENDIAN UNSIGNED2 PA_Litigation_Time;
    BIG_ENDIAN UNSIGNED2 PA_Denial_Time;
    BIG_ENDIAN UNSIGNED4 PA_Sum_hours;
    BIG_ENDIAN UNSIGNED4 Earliest_Contest_Date;
    DECIMAL11_2    Remitted_Penalty_Amount;
    DECIMAL11_2    Remitted_FTA_Amount;
    DECIMAL11_2    Total_Penalties;
    DECIMAL11_2    Total_FTA;
    DECIMAL5       Total_Violations;
    DECIMAL5       Total_Serious_Violations;
    UNSIGNED2      Number_Program;
    UNSIGNED2      Number_Rel_Activity;
    UNSIGNED2      Number_Optional_Info;
    UNSIGNED2      Number_Debt;
    UNSIGNED2      Number_Violations;
    UNSIGNED2      Number_Event;
    UNSIGNED2      Number_Hazardous_Substance;
    UNSIGNED2      Number_Accident;
    UNSIGNED2      Number_Admin_Pay;
    STRING30       cname;
    UNSIGNED6      bdid  := 0;
    UNSIGNED2      BDID_score := 0;
    STRING9        FEIN_append  := '';
    Standard.L_Address.detailed;
    unsigned8       raw_aid := 0;
    unsigned8       ace_aid := 0;
    UNSIGNED8      record_sid := 0;
    UNSIGNED4      global_sid := 0;
    UNSIGNED4      dt_effective_first := 0;
    UNSIGNED4      dt_effective_last := 0;
    UNSIGNED1      delta_ind := 0;
  END;
 
  //----------------------------------------------------------------------
  // Layout Accident Payload
  //----------------------------------------------------------------------  
  EXPORT Layout_Accident := RECORD 
    BIG_ENDIAN UNSIGNED4 Activity_Number;
    STRING20             Name;
    big_endian unsigned4 Related_Inspection_Number;
    STRING1              Sex;
    unsigned1            Age;
    STRING1              Degree_of_Injury;
    STRING2              Nature_of_Injury;
    STRING2              Part_of_Body;
    STRING2              Source_of_Injury;
    STRING2              Event_Type;
    STRING2              Environmental_Factor;
    STRING2              Human_Factor;
    STRING1              Task_Assigned;
    STRING5              Hazardous_Substance;
    STRING3              Occupation_Code;
    Standard.Name        victim;
    STRING22             Deg_of_Injury_Desc := '';
    STRING20             Nat_of_Inj_Desc    := '';
    STRING10             Part_of_Body_Desc  := '';
    STRING20             Src_of_Inj_Desc    := '';
    STRING20             Event_Desc         := '';
    STRING30             Env_Factor_Desc    := '';
    STRING33             Human_Factor_Desc  := '';
    STRING39             Task_Assigned_Desc := '';
    STRING50             Hazardous_Sub_Desc := '';
    STRING50             Occupation_Desc    := '';
    UNSIGNED8            record_sid := 0;
    UNSIGNED4            global_sid := 0;
    UNSIGNED4            dt_effective_first := 0;
    UNSIGNED4            dt_effective_last := 0;
    UNSIGNED1            delta_ind := 0;
  END;

  //----------------------------------------------------------------------
  // Layout Hazardous Substance Payload
  //----------------------------------------------------------------------  
  EXPORT Layout_Hazardous_Substance := RECORD 
    BIG_ENDIAN UNSIGNED4 Activity_Number;
    STRING2    Citation_Number;
    STRING3    Item_Number;
    STRING2    Item_group;
    STRING4    Hazardous_Substance_1;
    STRING4    Hazardous_Substance_2;
    STRING4    Hazardous_Substance_3;
    STRING4    Hazardous_Substance_4;
    STRING4    Hazardous_Substance_5;
    STRING50   Hazardous_Sub_Desc_1 := '';
    STRING50   Hazardous_Sub_Desc_2 := '';
    STRING50   Hazardous_Sub_Desc_3 := '';
    STRING50   Hazardous_Sub_Desc_4 := '';
    STRING50   Hazardous_Sub_Desc_5 := '';
    UNSIGNED8  record_sid := 0;
    UNSIGNED4  global_sid := 0;
    UNSIGNED4  dt_effective_first := 0;
    UNSIGNED4  dt_effective_last := 0;
    UNSIGNED1  delta_ind := 0;  
  END;

  //----------------------------------------------------------------------
  // Layout Program Payload
  //----------------------------------------------------------------------  
  EXPORT Layout_Program := RECORD
    BIG_ENDIAN UNSIGNED4 Activity_Number;
    STRING1    Program_Type;
    STRING25   Program_Value;
    UNSIGNED8  record_sid := 0;
    UNSIGNED4  global_sid := 0;
    UNSIGNED4  dt_effective_first := 0;
    UNSIGNED4  dt_effective_last := 0;
    UNSIGNED1  delta_ind := 0;
  END;

  //----------------------------------------------------------------------
  // Layout Violations Payload
  //----------------------------------------------------------------------  
  EXPORT Layout_Violations := RECORD
    BIG_ENDIAN UNSIGNED4 Activity_Number;
    STRING1              Delete_Flag;
    BIG_ENDIAN UNSIGNED4 Issuance_Date;
    STRING2              Citation_Number;
    STRING3              Item_Number;
    STRING2              Item_group;
    STRING1              Emphasis;
    STRING2              Gravity;
    DECIMAL9_2           Current_Penalty;
    DECIMAL9_2           Initial_Penalty;
    STRING1              Violation_Type;
    STRING1              Initial_Violation_Type;
    STRING22             Fed_State_Standard;
    BIG_ENDIAN UNSIGNED4 Abatement_Date;
    DECIMAL5             Number_Instances;
    STRING1              Related_Event_Code;
    DECIMAL5             Number_Exposed;
    STRING1              Abatement_Complete;
    BIG_ENDIAN UNSIGNED4 Earliest_Contest_Date;
    STRING1              Violation_Contest;
    STRING1              Penalty_Contest;
    STRING1              Abatement_Employer_Contest;
    STRING1              Abatement_Employee_Contest;
    BIG_ENDIAN UNSIGNED4 Final_Order_Date;
    STRING1              Pet_To_Modify_Abatement;
    STRING1              Citation_Amended;
    STRING1              Informal_Settlement_Aggreement;
    STRING1              Disposition_Event;
    BIG_ENDIAN UNSIGNED4 FTA_Inspection_Number;
    DECIMAL9_2           FTA_Penalty;
    BIG_ENDIAN UNSIGNED4 FTA_Issuance_Date;
    BIG_ENDIAN UNSIGNED4 FTA_Contest_Date;
    STRING1              FTA_Ammended;
    STRING1              FTA_ISA;
    STRING1              FTA_Disposition_Event;
    BIG_ENDIAN UNSIGNED4 FTA_Final_Order_Date;
    STRING10             Hazard_Category;
    BIG_ENDIAN UNSIGNED4 Abatement_Verify_Date;
    STRING15             Violation_Desc := '';
    STRING20             Related_Event_Desc := '';
    STRING68             Abatement_Comp_Desc := '';
    STRING33             Disposition_Event_Desc := '';
    STRING40             FTA_Disposition_Event_Desc := '';
    UNSIGNED8            record_sid := 0;
    UNSIGNED4            global_sid := 0;
    UNSIGNED4            dt_effective_first := 0;
    UNSIGNED4            dt_effective_last := 0;
    UNSIGNED1            delta_ind := 0;
  END;

END;
