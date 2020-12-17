IMPORT dx_common, dx_oshair, OSHAIR, standard, ut;
EXPORT layouts := MODULE

  EXPORT id := RECORD
    unsigned4 activity_number;
    string30 acctno := ''; //for batch purposes
  END;

  EXPORT search_ids := RECORD (id)
    boolean isDeepDive := false;
  END;

  shared AddressTranslated := RECORD
    standard.L_Address.base;
    standard.L_Address.translated;
  end;

  // slimmed version of dx_OSHAIR.layouts.Layout_Accident - dx_Common.layout_metadata & activity_number
  EXPORT Violation := RECORD
    string1              Delete_Flag;
    big_endian unsigned4 Issuance_Date;
    string5 id_number;
    string2              Citation_Number;
    string3              Item_Number;
    decimal9_2           Current_Penalty;
    decimal9_2           Initial_Penalty;
    string1              Violation_Type;
    string1              Initial_Violation_Type;
    string22             Fed_State_Standard;
    big_endian unsigned4 Abatement_Date;
    string1              Abatement_Complete;
    string1              Violation_Contest;
    big_endian unsigned4 Final_Order_Date;
    string1              Disposition_Event;
    decimal9_2           FTA_Penalty;
    big_endian unsigned4 FTA_Issuance_Date;
    big_endian unsigned4 Abatement_Verify_Date;
    // descriptions
    string3              Violation_Contest_Desc; // YES or NO
    string15             Violation_Desc;             // Derived
    string20             Related_Event_Desc;         // Derived
    string68             Abatement_Comp_Desc;        // Derived
    string33             Disposition_Event_Desc;     // Derived
    string40             FTA_Disposition_Event_Desc; // Derived
  END;

  EXPORT hsubstance := RECORD
    string4 code;
    string50 description;
  END;

  EXPORT Hazardous_Substance := RECORD
    string5 id_number;
    string2 Citation_Number;
    string3 Item_Number;
    string2 Item_group;
    DATASET (hsubstance) substance {MAXCOUNT (5)};
  END;

  EXPORT Accident := RECORD
    dx_OSHAIR.layouts.Layout_Accident AND NOT activity_number AND NOT dx_common.layout_metadata;
    string7 sex_desc; // 7: maybe we will need 'UNKNOWN' later
  END;

  export naics_codes := RECORD
    string9 name; //"primary", "secondary", "inspected"
    string6 code;
    string120 description := '';
  END;

  // this layout is only for "naming" different industry classifications; always 1 record
  export industry_class := RECORD
    unsigned4 DUNS_Number;
    unsigned2 sic_code;  // 4-digit code; can be prepended with '0'.
    unsigned2 secondary_sic;
    string120 sic_code_desc;
    string120 secondary_sic_desc;
    DATASET (naics_codes) naics {MAXCOUNT (3)};
  end;

  // this is shared between Embedded and Search layout
  EXPORT ReportSearchShared := RECORD //(taken from oshair_Inspection_rec)
    // NB: penalty is a minimum among penalties calculated using "unpacked" contact child dataset (l-, f-names are there).
    unsigned2 penalt := 0;
    string10 Activity_Number;
    string7 report_id;

    big_endian unsigned4 Last_Activity_Date;
    big_endian unsigned4 Previous_Activity_Number;
    string1              Previous_Activity_Type;
    string31             Prev_Activity_Type_Desc; // Derived
    string30             Inspected_Site_Name; // Searchable
    string30             Inspected_Site_Street;
    string2              Inspected_Site_State;
    decimal5             Inspected_Site_Zip;
    big_endian unsigned2 Inspected_Site_City_Code;
  	string30             Inspected_Site_City_Name; // Derived, but not used at a client end
    decimal3             Inspected_Site_County_Code;
    string17             Host_Establishment_key;
    string1              Owner_Type;
    string18             Own_Type_Desc; // Derived
    industry_class  industry_codes;
    unsigned6	           bdid := 0;
    unsigned2            BDID_score := 0;
    string9              FEIN_append  := '';
    AddressTranslated address;// clean
  END;

  EXPORT PlanningGuides := RECORD
    // "HEALTH PLANNING GUIDE - MANUFACTURING INSPECTION" = 48 -- the longest in main rec
    // "NATIONAL SPECIAL EMPHASIS PROGRAM: " + 25 chars in key_program = 60
    string60 description;
  END;

  EXPORT InspectionTime := RECORD
    string category {MAXLENGTH (20)};  //"ABATEMENT ASSISTANCE"
    unsigned2 hours;
  END;

  EXPORT Inspection := RECORD
    string10 Activity_Number;
    big_endian unsigned4 Last_Activity_Date;
    string1              Previous_Activity_Type;
    string31             Prev_Activity_Type_Desc; // Derived
    big_endian unsigned4 Previous_Activity_Number;
    string7 report_id;
    string5              Compliance_Officer_ID;
    string1              Compliance_Officer_Job_Title;
    string20             Compl_Officer_Job_Title_Desc; // Derived
    string30             Inspected_Site_Name; // Searchable
    string30             Inspected_Site_Street;
    string2              Inspected_Site_State;
    decimal5             Inspected_Site_Zip;
    big_endian unsigned2 Inspected_Site_City_Code;
    string30             Inspected_Site_City_Name; // Derived
    decimal3             Inspected_Site_County_Code;
    // big_endian unsigned4 DUNS_Number;
    string17             Host_Establishment_key;
    string1              Owner_Type;
    string18             Own_Type_Desc; // Derived
    big_endian unsigned2 Owner_Code;
    string1              Advance_Notice_Flag;
    string3              Advance_Notice_Desc;  //Derived
    big_endian unsigned4 Inspection_Opening_Date;
    big_endian unsigned4 Inspection_Close_Date;
    string1              Safety_Health_Flag;
    string6              Safety_Health_Desc; // Derived
    industry_class  industry_codes;
    // unsigned2            sic_code;
    // unsigned2            SIC_Guide_Flag;
    // string6              NAICS_Code;
    // string6              NAICS_Secondary_Code;
    // string6              NAIC_Inspected;
    string1              Inspection_Type;
    string27             Insp_Type_Desc; // Derived
    string1              Inspection_Scope;
    string13             Insp_Scope_Desc; // Derived
    decimal5             Number_In_Establishment;
    decimal5             Number_Covered;
    decimal7             Number_Total_Employees;
    string1              Walk_Around_Flag;
    string3              Walk_Around_desc;
//    string1              Employees_Interviewed_Flag;
    string3              Employees_Interviewed_desc;
    string1              Union_Flag;
    string3              Union_Flag_desc; // derived: YES, NO, blank
    string1              Closed_Case_Flag;
    string1              Why_No_Inspection_Code;
    string42             Why_No_Insp_Desc; // Derived
    big_endian unsigned4 Close_Case_Date;
    DATASET (PlanningGuides) classification {MAXCOUNT (20)}; // 1 in main record + up to 12 programms
//    string48 planning_guide_desc;
    string1              Antic_Served;
    big_endian unsigned4 First_Denial_Date;
    big_endian unsigned4 Last_Reenter_Date;
    decimal5_2           bls_Loss_Workday_Injury_Rate;
    // string1              Due_Date_Type;
    // string60             Due_Date_Desc := ''; // Derived
    DATASET (InspectionTime) inspection_hours {MAXCOUNT (9)};

    // decimal11_2          Total_Penalties;
    // decimal11_2          Total_FTA;
    // decimal5             Total_Violations;
    // decimal5             Total_Serious_Violations;
    // Cleaned
    string30             cname;
    unsigned6	           bdid	:= 0;
    unsigned2            BDID_score := 0;
    string9              FEIN_append  := '';
    AddressTranslated address;
  END;

  // output for SEARCH service
  EXPORT SearchOutput := RECORD (ReportSearchShared)
  END;

  // SUBREPORT (as part of CRS, for instanse) //so far is same as SearchOutput, but shall be different
  EXPORT EmbeddedOutput := RECORD (ReportSearchShared)
  END;

  // Complete stand-alone SOURCE/REPORT service
  EXPORT SourceOutput := RECORD
    Inspection;
    DATASET (Violation) violations {MAXCOUNT (Constants.VIOLATION_MAX)}; // from other key
    DATASET (Hazardous_Substance) substances {MAXCOUNT (Constants.SUBSTANCE_MAX)}; // from other key
    DATASET (Accident) accidents {MAXCOUNT (Constants.ACCIDENT_MAX)}; // from other key
  END;

END;
