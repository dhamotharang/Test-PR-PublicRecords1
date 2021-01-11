IMPORT doxie_cbrs;
EXPORT layout_report_src := MODULE
  EXPORT source_counts := RECORD
    doxie_cbrs.layout_source_counts; // doxie_cbrs.count_records_prs_dayton 
    UNSIGNED3 Name_Variations_Section := 0;
    UNSIGNED3 Address_Variations_Section := 0;
    UNSIGNED3 Phone_Variations_Section := 0;
    UNSIGNED3 Parent_Company_Section := 0;
    UNSIGNED3 Sales_Section := 0;
    UNSIGNED3 Industry_Information_Section := 0;
    UNSIGNED3 ID_Numbers_Section := 0;
    UNSIGNED3 Bankruptcy_Section := 0;
    UNSIGNED3 Bankruptcy_Section_v2 := 0;
    UNSIGNED3 Liens_Judgments_Section := 0;
    UNSIGNED3 Liens_Judgments_Section_v2 := 0;
    UNSIGNED3 Profile_Information_Section := 0;
    UNSIGNED3 Profile_Information_Section_v2 := 0;
    UNSIGNED3 Business_Registration_Section := 0;
    UNSIGNED3 Registered_Agents_Section := 0;
    UNSIGNED3 Contacts_Section := 0;
    UNSIGNED3 Executives_Section := 0;
    UNSIGNED3 Property_Section := 0;
    UNSIGNED3 Property_Section_v2 := 0;
    UNSIGNED3 MotorVehicle_Section := 0; // GCL - 20051026
    UNSIGNED3 MotorVehicle_Section_v2 := 0;
    UNSIGNED3 Watercraft_Section := 0; // GCL - 20051026
    UNSIGNED3 Aircraft_Section := 0; // GCL - 20051026
    UNSIGNED3 Internet_Section := 0;
    UNSIGNED3 Professional_Licenses_Section := 0;
    UNSIGNED3 Superior_Liens_Section := 0;
    UNSIGNED3 Business_Associates_Section := 0;
    UNSIGNED3 Experian_Business_Reports_Section := 0;
    UNSIGNED3 IRS5500_Section := 0;
    UNSIGNED3 DNB_Section := 0;
    UNSIGNED3 DiversityCertification_Section := 0;
    UNSIGNED3 RiskMetrics_Section := 0;
    UNSIGNED3 LaborActionWHD_Section := 0;
    UNSIGNED3 NaturalDisaster_Section := 0;
    UNSIGNED3 LNCAFirmographics_Section := 0;
    UNSIGNED3 EquifaxBusinessReport_Section := 0; // a place holder for external callers
  END;

  EXPORT source_counts_more := RECORD
    BOOLEAN Name_Variations_Section_more := FALSE;
    BOOLEAN Address_Variations_Section_more := FALSE;
    BOOLEAN Phone_Variations_Section_more := FALSE;
    BOOLEAN Parent_Company_Section_more := FALSE;
    BOOLEAN Sales_Section_more := FALSE;
    BOOLEAN Industry_Information_Section_more := FALSE;
    BOOLEAN ID_Numbers_Section_more := FALSE;
    BOOLEAN Bankruptcy_Section_more := FALSE;
    BOOLEAN Bankruptcy_Section_v2_more := FALSE;
    BOOLEAN Liens_Judgments_Section_more := FALSE;
    BOOLEAN Liens_Judgments_Section_v2_more := FALSE;
    BOOLEAN Profile_Information_Section_more := FALSE;
    BOOLEAN Profile_Information_Section_v2_more := FALSE;
    BOOLEAN Business_Registration_Section_more := FALSE;
    BOOLEAN Registered_Agents_Section_more := FALSE;
    BOOLEAN Contacts_Section_more := FALSE;
    BOOLEAN Executives_Section_more := FALSE;
    BOOLEAN Property_Section_more := FALSE;
    BOOLEAN Property_Section_v2_more := FALSE;
    BOOLEAN MotorVehicle_Section_more := FALSE;
    BOOLEAN MotorVehicle_Section_v2_more := FALSE;
    BOOLEAN Watercraft_Section_more := FALSE;
    BOOLEAN Aircraft_Section_more := FALSE;
    BOOLEAN Internet_Section_more := FALSE;
    BOOLEAN Professional_Licenses_Section_more := FALSE;
    BOOLEAN Superior_Liens_Section_more := FALSE;
    BOOLEAN Business_Associates_Section_more := FALSE;
    BOOLEAN Experian_Business_Reports_Section_more := FALSE;
    BOOLEAN IRS5500_Section_more := FALSE;
    BOOLEAN DNB_Section_more := FALSE;
    BOOLEAN DiversityCertification_Section_more := FALSE;
    BOOLEAN RiskMetrics_Section_more := FALSE;
    BOOLEAN LaborActionWHD_Section_more := FALSE;
    BOOLEAN NaturalDisaster_Section_more := FALSE;
    BOOLEAN LNCAFirmographics_Section_more := FALSE;
    BOOLEAN EquifaxBusinessReport_Section_more := FALSE;
  END;

  EXPORT source_flags := RECORD
    STRING field_present;
  END;
END;
