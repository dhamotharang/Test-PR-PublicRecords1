//HPCC Systems KEL Compiler Version 1.3.0
IMPORT KEL13 AS KEL;
IMPORT B_Address,B_Address_1,B_Address_2,B_Address_3,B_Address_4,B_Address_5,B_Address_6,B_Aircraft_Owner_1,B_Aircraft_Owner_2,B_Aircraft_Owner_3,B_Bankruptcy,B_Bankruptcy_1,B_Bankruptcy_2,B_Bankruptcy_3,B_Bankruptcy_4,B_Bankruptcy_5,B_Bankruptcy_6,B_Bankruptcy_7,B_Bankruptcy_8,B_Business_Prox,B_Business_Prox_1,B_Business_Prox_2,B_Business_Prox_3,B_Business_Sele,B_Business_Sele_1,B_Business_Sele_10,B_Business_Sele_2,B_Business_Sele_3,B_Business_Sele_4,B_Business_Sele_5,B_Business_Sele_6,B_Business_Sele_7,B_Business_Sele_8,B_Business_Sele_9,B_Criminal_Offense,B_Criminal_Offense_1,B_Criminal_Offense_2,B_Criminal_Offense_3,B_Criminal_Offense_4,B_Criminal_Offense_5,B_Education,B_Education_1,B_Education_2,B_Education_3,B_Education_4,B_Education_5,B_Education_6,B_Education_7,B_Email,B_Email_1,B_Email_2,B_First_Degree_Relative,B_First_Degree_Relative_1,B_First_Degree_Relative_2,B_First_Degree_Relative_3,B_First_Degree_Relative_4,B_First_Degree_Relative_5,B_Input_B_I_I_1,B_Input_B_I_I_10,B_Input_B_I_I_2,B_Input_B_I_I_3,B_Input_B_I_I_4,B_Input_B_I_I_5,B_Input_B_I_I_6,B_Input_B_I_I_7,B_Input_B_I_I_8,B_Input_B_I_I_9,B_Input_P_I_I_2,B_Input_P_I_I_3,B_Input_P_I_I_4,B_Input_P_I_I_5,B_Input_P_I_I_6,B_Input_P_I_I_7,B_Input_P_I_I_8,B_Input_P_I_I_9,B_Lien_Judgment,B_Lien_Judgment_1,B_Lien_Judgment_10,B_Lien_Judgment_11,B_Lien_Judgment_12,B_Lien_Judgment_2,B_Lien_Judgment_3,B_Lien_Judgment_4,B_Lien_Judgment_5,B_Lien_Judgment_6,B_Lien_Judgment_7,B_Lien_Judgment_8,B_Lien_Judgment_9,B_Person,B_Person_1,B_Person_10,B_Person_2,B_Person_3,B_Person_4,B_Person_5,B_Person_6,B_Person_7,B_Person_8,B_Person_9,B_Person_Address_2,B_Person_Address_3,B_Person_Lien_Judgment_8,B_Person_S_S_N_1,B_Person_S_S_N_2,B_Person_Vehicle_1,B_Person_Vehicle_2,B_Person_Vehicle_3,B_Professional_License,B_Professional_License_1,B_Professional_License_2,B_Professional_License_3,B_Professional_License_4,B_Professional_License_5,B_Property,B_Property_1,B_Property_2,B_Property_3,B_Property_4,B_Property_5,B_Property_Event,B_Property_Event_1,B_Property_Event_2,B_Property_Event_3,B_Property_Event_4,B_Property_Event_5,B_Second_Degree_Associations,B_Sele_Address_1,B_Sele_Address_2,B_Sele_Address_3,B_Sele_Address_4,B_Sele_Address_5,B_Sele_Address_6,B_Sele_Lien_Judgment_11,B_Sele_Person_1,B_Sele_Person_2,B_Sele_Person_3,B_Sele_Person_4,B_Sele_Person_5,B_Sele_Person_6,B_Sele_Person_7,B_Sele_Phone_Number_3,B_Sele_Phone_Number_4,B_Sele_Phone_Number_5,B_Sele_Phone_Number_6,B_Sele_Property_1,B_Sele_Property_2,B_Sele_Property_3,B_Sele_Property_4,B_Sele_T_I_N_3,B_Sele_T_I_N_4,B_Sele_T_I_N_5,B_Sele_T_I_N_6,B_Sele_Tradeline_1,B_Sele_Tradeline_2,B_Sele_Tradeline_3,B_Sele_U_C_C_2,B_Sele_U_C_C_3,B_Sele_U_C_C_4,B_Sele_U_C_C_5,B_Sele_U_C_C_6,B_Sele_U_C_C_7,B_Sele_U_C_C_8,B_Sele_U_C_C_9,B_Sele_Vehicle_1,B_Sele_Vehicle_2,B_Sele_Vehicle_3,B_Tradeline,B_Tradeline_1,B_Tradeline_10,B_Tradeline_2,B_Tradeline_3,B_Tradeline_4,B_Tradeline_5,B_Tradeline_6,B_Tradeline_7,B_Tradeline_8,B_Tradeline_9,B_U_C_C,B_U_C_C_1,B_U_C_C_10,B_U_C_C_11,B_U_C_C_12,B_U_C_C_13,B_U_C_C_2,B_U_C_C_3,B_U_C_C_4,B_U_C_C_5,B_U_C_C_6,B_U_C_C_7,B_U_C_C_8,B_U_C_C_9,B_Watercraft_Owner_1,B_Watercraft_Owner_2,B_Watercraft_Owner_3,CFG_Compile,E_Accident,E_Address,E_Address_Inquiry,E_Address_Phone,E_Address_Property,E_Address_Property_Event,E_Aircraft,E_Aircraft_Owner,E_Bankruptcy,E_Business_Org,E_Business_Prox,E_Business_Sele,E_Business_Ult,E_Criminal_Details,E_Criminal_Offender,E_Criminal_Offense,E_Criminal_Punishment,E_Drivers_License,E_E_B_R_Tradeline,E_Education,E_Email,E_Email_Inquiry,E_First_Degree_Associations,E_First_Degree_Relative,E_Geo_Link,E_House_Hold_Phone,E_Household,E_Household_Member,E_Input_B_I_I,E_Input_B_I_I_Input_P_I_I,E_Input_P_I_I,E_Inquiry,E_Lien_Judgment,E_Person,E_Person_Accident,E_Person_Address,E_Person_Bankruptcy,E_Person_Drivers_License,E_Person_Education,E_Person_Email,E_Person_Email_Phone_Address,E_Person_Inquiry,E_Person_Lien_Judgment,E_Person_Offender,E_Person_Offenses,E_Person_Phone,E_Person_Property,E_Person_Property_Event,E_Person_S_S_N,E_Person_Vehicle,E_Phone,E_Phone_Inquiry,E_Professional_License,E_Professional_License_Person,E_Property,E_Property_Event,E_Prox_Address,E_Prox_Email,E_Prox_Person,E_Prox_Phone_Number,E_Prox_T_I_N,E_Prox_Utility,E_S_S_N_Address,E_S_S_N_Inquiry,E_Second_Degree_Associations,E_Sele_Address,E_Sele_Aircraft,E_Sele_Bankruptcy,E_Sele_E_B_R_Tradeline,E_Sele_Email,E_Sele_Inquiry,E_Sele_Lien_Judgment,E_Sele_Person,E_Sele_Phone_Number,E_Sele_Property,E_Sele_Property_Event,E_Sele_T_I_N,E_Sele_Tradeline,E_Sele_U_C_C,E_Sele_Utility,E_Sele_Vehicle,E_Sele_Watercraft,E_Social_Security_Number,E_Surname,E_T_I_N,E_T_I_N_Address,E_T_I_N_Inquiry,E_T_I_N_Phone_Number,E_Tradeline,E_U_C_C,E_Utility,E_Utility_Address,E_Utility_Person,E_Vehicle,E_Watercraft,E_Watercraft_Owner,E_Zip_Code,E_Zip_Code_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT Q_Index_Build_Association(KEL.typ.uid __PAddressUID, KEL.typ.uid __PBusinessProxUID, KEL.typ.uid __PBusinessSeleUID, KEL.typ.uid __PCriminalOffenderUID, KEL.typ.uid __PPersonUID, KEL.typ.uid __PHouseholdUID, KEL.typ.uid __PPhoneUID, KEL.typ.uid __PEmailUID, KEL.typ.uid __PPropertyUID, KEL.typ.uid __PSocialSecurityNumberUID, KEL.typ.uid __PTINUID, KEL.typ.uid __PZipCodeUID, KEL.typ.kdate __PP_InpClnArchDt, DATA57 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PP_InpClnArchDt;
  END;
  SHARED E_Accident_Filtered := MODULE(E_Accident(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Address_Filtered := MODULE(E_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Address_Inquiry_Filtered := MODULE(E_Address_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Address_Phone_Filtered := MODULE(E_Address_Phone(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Address_Property_Filtered := MODULE(E_Address_Property(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Address_Property_Event_Filtered := MODULE(E_Address_Property_Event(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Aircraft_Filtered := MODULE(E_Aircraft(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Aircraft_Owner_Filtered := MODULE(E_Aircraft_Owner(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Bankruptcy_Filtered := MODULE(E_Bankruptcy(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Business_Prox_Filtered := MODULE(E_Business_Prox(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Business_Sele_Filtered := MODULE(E_Business_Sele(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Criminal_Details_Filtered := MODULE(E_Criminal_Details(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Criminal_Offender_Filtered := MODULE(E_Criminal_Offender(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Criminal_Offense_Filtered := MODULE(E_Criminal_Offense(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Criminal_Punishment_Filtered := MODULE(E_Criminal_Punishment(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Drivers_License_Filtered := MODULE(E_Drivers_License(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_E_B_R_Tradeline_Filtered := MODULE(E_E_B_R_Tradeline(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Education_Filtered := MODULE(E_Education(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Email_Filtered := MODULE(E_Email(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Email_Inquiry_Filtered := MODULE(E_Email_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_First_Degree_Associations_Filtered := MODULE(E_First_Degree_Associations(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_First_Degree_Relative_Filtered := MODULE(E_First_Degree_Relative(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_House_Hold_Phone_Filtered := MODULE(E_House_Hold_Phone(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Household_Filtered := MODULE(E_Household(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Household_Member_Filtered := MODULE(E_Household_Member(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Input_B_I_I_Filtered := MODULE(E_Input_B_I_I(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Input_B_I_I_Input_P_I_I_Filtered := MODULE(E_Input_B_I_I_Input_P_I_I(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Input_P_I_I_Filtered := MODULE(E_Input_P_I_I(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Inquiry_Filtered := MODULE(E_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Lien_Judgment_Filtered := MODULE(E_Lien_Judgment(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Filtered := MODULE(E_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Accident_Filtered := MODULE(E_Person_Accident(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Address_Filtered := MODULE(E_Person_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Bankruptcy_Filtered := MODULE(E_Person_Bankruptcy(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Drivers_License_Filtered := MODULE(E_Person_Drivers_License(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Education_Filtered := MODULE(E_Person_Education(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Email_Filtered := MODULE(E_Person_Email(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Email_Phone_Address_Filtered := MODULE(E_Person_Email_Phone_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Inquiry_Filtered := MODULE(E_Person_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Lien_Judgment_Filtered := MODULE(E_Person_Lien_Judgment(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Offender_Filtered := MODULE(E_Person_Offender(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Offenses_Filtered := MODULE(E_Person_Offenses(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Phone_Filtered := MODULE(E_Person_Phone(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Property_Filtered := MODULE(E_Person_Property(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Property_Event_Filtered := MODULE(E_Person_Property_Event(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_S_S_N_Filtered := MODULE(E_Person_S_S_N(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Vehicle_Filtered := MODULE(E_Person_Vehicle(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Phone_Filtered := MODULE(E_Phone(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Phone_Inquiry_Filtered := MODULE(E_Phone_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Professional_License_Filtered := MODULE(E_Professional_License(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Professional_License_Person_Filtered := MODULE(E_Professional_License_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Property_Filtered := MODULE(E_Property(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Property_Event_Filtered := MODULE(E_Property_Event(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Prox_Address_Filtered := MODULE(E_Prox_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Prox_Email_Filtered := MODULE(E_Prox_Email(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Prox_Person_Filtered := MODULE(E_Prox_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Prox_Phone_Number_Filtered := MODULE(E_Prox_Phone_Number(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Prox_T_I_N_Filtered := MODULE(E_Prox_T_I_N(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Prox_Utility_Filtered := MODULE(E_Prox_Utility(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_S_S_N_Address_Filtered := MODULE(E_S_S_N_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_S_S_N_Inquiry_Filtered := MODULE(E_S_S_N_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Second_Degree_Associations_Filtered := MODULE(E_Second_Degree_Associations(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Address_Filtered := MODULE(E_Sele_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Aircraft_Filtered := MODULE(E_Sele_Aircraft(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Bankruptcy_Filtered := MODULE(E_Sele_Bankruptcy(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_E_B_R_Tradeline_Filtered := MODULE(E_Sele_E_B_R_Tradeline(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Email_Filtered := MODULE(E_Sele_Email(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Inquiry_Filtered := MODULE(E_Sele_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Lien_Judgment_Filtered := MODULE(E_Sele_Lien_Judgment(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Person_Filtered := MODULE(E_Sele_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Phone_Number_Filtered := MODULE(E_Sele_Phone_Number(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Property_Filtered := MODULE(E_Sele_Property(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Property_Event_Filtered := MODULE(E_Sele_Property_Event(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_T_I_N_Filtered := MODULE(E_Sele_T_I_N(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Tradeline_Filtered := MODULE(E_Sele_Tradeline(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_U_C_C_Filtered := MODULE(E_Sele_U_C_C(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Utility_Filtered := MODULE(E_Sele_Utility(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Vehicle_Filtered := MODULE(E_Sele_Vehicle(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Watercraft_Filtered := MODULE(E_Sele_Watercraft(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Social_Security_Number_Filtered := MODULE(E_Social_Security_Number(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_T_I_N_Filtered := MODULE(E_T_I_N(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_T_I_N_Address_Filtered := MODULE(E_T_I_N_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_T_I_N_Inquiry_Filtered := MODULE(E_T_I_N_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_T_I_N_Phone_Number_Filtered := MODULE(E_T_I_N_Phone_Number(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Tradeline_Filtered := MODULE(E_Tradeline(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_U_C_C_Filtered := MODULE(E_U_C_C(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Utility_Filtered := MODULE(E_Utility(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Utility_Address_Filtered := MODULE(E_Utility_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Utility_Person_Filtered := MODULE(E_Utility_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Vehicle_Filtered := MODULE(E_Vehicle(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Watercraft_Filtered := MODULE(E_Watercraft(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Watercraft_Owner_Filtered := MODULE(E_Watercraft_Owner(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Zip_Code_Filtered := MODULE(E_Zip_Code(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Zip_Code_Person_Filtered := MODULE(E_Zip_Code_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED B_U_C_C_13_Local := MODULE(B_U_C_C_13(__in,__cfg_Local))
    SHARED TYPEOF(E_U_C_C(__in,__cfg_Local).__Result) __E_U_C_C := E_U_C_C_Filtered.__Result;
  END;
  SHARED B_Lien_Judgment_12_Local := MODULE(B_Lien_Judgment_12(__in,__cfg_Local))
    SHARED TYPEOF(E_Lien_Judgment(__in,__cfg_Local).__Result) __E_Lien_Judgment := E_Lien_Judgment_Filtered.__Result;
  END;
  SHARED B_U_C_C_12_Local := MODULE(B_U_C_C_12(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_13(__in,__cfg_Local).__ENH_U_C_C_13) __ENH_U_C_C_13 := B_U_C_C_13_Local.__ENH_U_C_C_13;
  END;
  SHARED B_Lien_Judgment_11_Local := MODULE(B_Lien_Judgment_11(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_12(__in,__cfg_Local).__ENH_Lien_Judgment_12) __ENH_Lien_Judgment_12 := B_Lien_Judgment_12_Local.__ENH_Lien_Judgment_12;
  END;
  SHARED B_Sele_Lien_Judgment_11_Local := MODULE(B_Sele_Lien_Judgment_11(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_12(__in,__cfg_Local).__ENH_Lien_Judgment_12) __ENH_Lien_Judgment_12 := B_Lien_Judgment_12_Local.__ENH_Lien_Judgment_12;
    SHARED TYPEOF(E_Sele_Lien_Judgment(__in,__cfg_Local).__Result) __E_Sele_Lien_Judgment := E_Sele_Lien_Judgment_Filtered.__Result;
  END;
  SHARED B_U_C_C_11_Local := MODULE(B_U_C_C_11(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_12(__in,__cfg_Local).__ENH_U_C_C_12) __ENH_U_C_C_12 := B_U_C_C_12_Local.__ENH_U_C_C_12;
  END;
  SHARED B_Business_Sele_10_Local := MODULE(B_Business_Sele_10(__in,__cfg_Local))
    SHARED TYPEOF(E_Business_Sele(__in,__cfg_Local).__Result) __E_Business_Sele := E_Business_Sele_Filtered.__Result;
    SHARED TYPEOF(E_Input_B_I_I(__in,__cfg_Local).__Result) __E_Input_B_I_I := E_Input_B_I_I_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Lien_Judgment_11(__in,__cfg_Local).__ENH_Sele_Lien_Judgment_11) __ENH_Sele_Lien_Judgment_11 := B_Sele_Lien_Judgment_11_Local.__ENH_Sele_Lien_Judgment_11;
  END;
  SHARED B_Input_B_I_I_10_Local := MODULE(B_Input_B_I_I_10(__in,__cfg_Local))
    SHARED TYPEOF(E_Input_B_I_I(__in,__cfg_Local).__Result) __E_Input_B_I_I := E_Input_B_I_I_Filtered.__Result;
  END;
  SHARED B_Lien_Judgment_10_Local := MODULE(B_Lien_Judgment_10(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_11(__in,__cfg_Local).__ENH_Lien_Judgment_11) __ENH_Lien_Judgment_11 := B_Lien_Judgment_11_Local.__ENH_Lien_Judgment_11;
  END;
  SHARED B_Person_10_Local := MODULE(B_Person_10(__in,__cfg_Local))
    SHARED TYPEOF(E_Person(__in,__cfg_Local).__Result) __E_Person := E_Person_Filtered.__Result;
    SHARED TYPEOF(E_Person_Address(__in,__cfg_Local).__Result) __E_Person_Address := E_Person_Address_Filtered.__Result;
  END;
  SHARED B_Tradeline_10_Local := MODULE(B_Tradeline_10(__in,__cfg_Local))
    SHARED TYPEOF(E_Tradeline(__in,__cfg_Local).__Result) __E_Tradeline := E_Tradeline_Filtered.__Result;
  END;
  SHARED B_U_C_C_10_Local := MODULE(B_U_C_C_10(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_11(__in,__cfg_Local).__ENH_U_C_C_11) __ENH_U_C_C_11 := B_U_C_C_11_Local.__ENH_U_C_C_11;
  END;
  SHARED B_Business_Sele_9_Local := MODULE(B_Business_Sele_9(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_10(__in,__cfg_Local).__ENH_Business_Sele_10) __ENH_Business_Sele_10 := B_Business_Sele_10_Local.__ENH_Business_Sele_10;
    SHARED TYPEOF(B_Input_B_I_I_10(__in,__cfg_Local).__ENH_Input_B_I_I_10) __ENH_Input_B_I_I_10 := B_Input_B_I_I_10_Local.__ENH_Input_B_I_I_10;
  END;
  SHARED B_Input_B_I_I_9_Local := MODULE(B_Input_B_I_I_9(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_10(__in,__cfg_Local).__ENH_Input_B_I_I_10) __ENH_Input_B_I_I_10 := B_Input_B_I_I_10_Local.__ENH_Input_B_I_I_10;
  END;
  SHARED B_Input_P_I_I_9_Local := MODULE(B_Input_P_I_I_9(__in,__cfg_Local))
    SHARED TYPEOF(E_Input_P_I_I(__in,__cfg_Local).__Result) __E_Input_P_I_I := E_Input_P_I_I_Filtered.__Result;
  END;
  SHARED B_Lien_Judgment_9_Local := MODULE(B_Lien_Judgment_9(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_10(__in,__cfg_Local).__ENH_Lien_Judgment_10) __ENH_Lien_Judgment_10 := B_Lien_Judgment_10_Local.__ENH_Lien_Judgment_10;
  END;
  SHARED B_Person_9_Local := MODULE(B_Person_9(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_10(__in,__cfg_Local).__ENH_Person_10) __ENH_Person_10 := B_Person_10_Local.__ENH_Person_10;
  END;
  SHARED B_Sele_U_C_C_9_Local := MODULE(B_Sele_U_C_C_9(__in,__cfg_Local))
    SHARED TYPEOF(E_Sele_U_C_C(__in,__cfg_Local).__Result) __E_Sele_U_C_C := E_Sele_U_C_C_Filtered.__Result;
  END;
  SHARED B_Tradeline_9_Local := MODULE(B_Tradeline_9(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_10(__in,__cfg_Local).__ENH_Tradeline_10) __ENH_Tradeline_10 := B_Tradeline_10_Local.__ENH_Tradeline_10;
  END;
  SHARED B_U_C_C_9_Local := MODULE(B_U_C_C_9(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_10(__in,__cfg_Local).__ENH_U_C_C_10) __ENH_U_C_C_10 := B_U_C_C_10_Local.__ENH_U_C_C_10;
  END;
  SHARED B_Bankruptcy_8_Local := MODULE(B_Bankruptcy_8(__in,__cfg_Local))
    SHARED TYPEOF(E_Bankruptcy(__in,__cfg_Local).__Result) __E_Bankruptcy := E_Bankruptcy_Filtered.__Result;
  END;
  SHARED B_Business_Sele_8_Local := MODULE(B_Business_Sele_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_9(__in,__cfg_Local).__ENH_Business_Sele_9) __ENH_Business_Sele_9 := B_Business_Sele_9_Local.__ENH_Business_Sele_9;
    SHARED TYPEOF(E_Sele_Address(__in,__cfg_Local).__Result) __E_Sele_Address := E_Sele_Address_Filtered.__Result;
  END;
  SHARED B_Input_B_I_I_8_Local := MODULE(B_Input_B_I_I_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_9(__in,__cfg_Local).__ENH_Input_B_I_I_9) __ENH_Input_B_I_I_9 := B_Input_B_I_I_9_Local.__ENH_Input_B_I_I_9;
  END;
  SHARED B_Input_P_I_I_8_Local := MODULE(B_Input_P_I_I_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_9(__in,__cfg_Local).__ENH_Input_P_I_I_9) __ENH_Input_P_I_I_9 := B_Input_P_I_I_9_Local.__ENH_Input_P_I_I_9;
  END;
  SHARED B_Lien_Judgment_8_Local := MODULE(B_Lien_Judgment_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_9(__in,__cfg_Local).__ENH_Lien_Judgment_9) __ENH_Lien_Judgment_9 := B_Lien_Judgment_9_Local.__ENH_Lien_Judgment_9;
  END;
  SHARED B_Person_8_Local := MODULE(B_Person_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_9(__in,__cfg_Local).__ENH_Person_9) __ENH_Person_9 := B_Person_9_Local.__ENH_Person_9;
  END;
  SHARED B_Person_Lien_Judgment_8_Local := MODULE(B_Person_Lien_Judgment_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_9(__in,__cfg_Local).__ENH_Lien_Judgment_9) __ENH_Lien_Judgment_9 := B_Lien_Judgment_9_Local.__ENH_Lien_Judgment_9;
    SHARED TYPEOF(E_Person_Lien_Judgment(__in,__cfg_Local).__Result) __E_Person_Lien_Judgment := E_Person_Lien_Judgment_Filtered.__Result;
  END;
  SHARED B_Sele_U_C_C_8_Local := MODULE(B_Sele_U_C_C_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_U_C_C_9(__in,__cfg_Local).__ENH_Sele_U_C_C_9) __ENH_Sele_U_C_C_9 := B_Sele_U_C_C_9_Local.__ENH_Sele_U_C_C_9;
    SHARED TYPEOF(B_U_C_C_9(__in,__cfg_Local).__ENH_U_C_C_9) __ENH_U_C_C_9 := B_U_C_C_9_Local.__ENH_U_C_C_9;
  END;
  SHARED B_Tradeline_8_Local := MODULE(B_Tradeline_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_9(__in,__cfg_Local).__ENH_Tradeline_9) __ENH_Tradeline_9 := B_Tradeline_9_Local.__ENH_Tradeline_9;
  END;
  SHARED B_U_C_C_8_Local := MODULE(B_U_C_C_8(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_9(__in,__cfg_Local).__ENH_U_C_C_9) __ENH_U_C_C_9 := B_U_C_C_9_Local.__ENH_U_C_C_9;
  END;
  SHARED B_Bankruptcy_7_Local := MODULE(B_Bankruptcy_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_8(__in,__cfg_Local).__ENH_Bankruptcy_8) __ENH_Bankruptcy_8 := B_Bankruptcy_8_Local.__ENH_Bankruptcy_8;
  END;
  SHARED B_Business_Sele_7_Local := MODULE(B_Business_Sele_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_8(__in,__cfg_Local).__ENH_Business_Sele_8) __ENH_Business_Sele_8 := B_Business_Sele_8_Local.__ENH_Business_Sele_8;
    SHARED TYPEOF(B_Input_B_I_I_8(__in,__cfg_Local).__ENH_Input_B_I_I_8) __ENH_Input_B_I_I_8 := B_Input_B_I_I_8_Local.__ENH_Input_B_I_I_8;
  END;
  SHARED B_Education_7_Local := MODULE(B_Education_7(__in,__cfg_Local))
    SHARED TYPEOF(E_Education(__in,__cfg_Local).__Result) __E_Education := E_Education_Filtered.__Result;
  END;
  SHARED B_Input_B_I_I_7_Local := MODULE(B_Input_B_I_I_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_8(__in,__cfg_Local).__ENH_Input_B_I_I_8) __ENH_Input_B_I_I_8 := B_Input_B_I_I_8_Local.__ENH_Input_B_I_I_8;
  END;
  SHARED B_Input_P_I_I_7_Local := MODULE(B_Input_P_I_I_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_8(__in,__cfg_Local).__ENH_Input_P_I_I_8) __ENH_Input_P_I_I_8 := B_Input_P_I_I_8_Local.__ENH_Input_P_I_I_8;
  END;
  SHARED B_Lien_Judgment_7_Local := MODULE(B_Lien_Judgment_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_8(__in,__cfg_Local).__ENH_Lien_Judgment_8) __ENH_Lien_Judgment_8 := B_Lien_Judgment_8_Local.__ENH_Lien_Judgment_8;
  END;
  SHARED B_Person_7_Local := MODULE(B_Person_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_8(__in,__cfg_Local).__ENH_Person_8) __ENH_Person_8 := B_Person_8_Local.__ENH_Person_8;
    SHARED TYPEOF(B_Person_Lien_Judgment_8(__in,__cfg_Local).__ENH_Person_Lien_Judgment_8) __ENH_Person_Lien_Judgment_8 := B_Person_Lien_Judgment_8_Local.__ENH_Person_Lien_Judgment_8;
  END;
  SHARED B_Sele_Person_7_Local := MODULE(B_Sele_Person_7(__in,__cfg_Local))
    SHARED TYPEOF(E_Sele_Person(__in,__cfg_Local).__Result) __E_Sele_Person := E_Sele_Person_Filtered.__Result;
  END;
  SHARED B_Sele_U_C_C_7_Local := MODULE(B_Sele_U_C_C_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_U_C_C_8(__in,__cfg_Local).__ENH_Sele_U_C_C_8) __ENH_Sele_U_C_C_8 := B_Sele_U_C_C_8_Local.__ENH_Sele_U_C_C_8;
  END;
  SHARED B_Tradeline_7_Local := MODULE(B_Tradeline_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_8(__in,__cfg_Local).__ENH_Tradeline_8) __ENH_Tradeline_8 := B_Tradeline_8_Local.__ENH_Tradeline_8;
  END;
  SHARED B_U_C_C_7_Local := MODULE(B_U_C_C_7(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_8(__in,__cfg_Local).__ENH_U_C_C_8) __ENH_U_C_C_8 := B_U_C_C_8_Local.__ENH_U_C_C_8;
  END;
  SHARED B_Address_6_Local := MODULE(B_Address_6(__in,__cfg_Local))
    SHARED TYPEOF(E_Address(__in,__cfg_Local).__Result) __E_Address := E_Address_Filtered.__Result;
  END;
  SHARED B_Bankruptcy_6_Local := MODULE(B_Bankruptcy_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_7(__in,__cfg_Local).__ENH_Bankruptcy_7) __ENH_Bankruptcy_7 := B_Bankruptcy_7_Local.__ENH_Bankruptcy_7;
  END;
  SHARED B_Business_Sele_6_Local := MODULE(B_Business_Sele_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_7(__in,__cfg_Local).__ENH_Business_Sele_7) __ENH_Business_Sele_7 := B_Business_Sele_7_Local.__ENH_Business_Sele_7;
    SHARED TYPEOF(E_Sele_Address(__in,__cfg_Local).__Result) __E_Sele_Address := E_Sele_Address_Filtered.__Result;
    SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg_Local).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered.__Result;
    SHARED TYPEOF(B_Tradeline_7(__in,__cfg_Local).__ENH_Tradeline_7) __ENH_Tradeline_7 := B_Tradeline_7_Local.__ENH_Tradeline_7;
  END;
  SHARED B_Education_6_Local := MODULE(B_Education_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_7(__in,__cfg_Local).__ENH_Education_7) __ENH_Education_7 := B_Education_7_Local.__ENH_Education_7;
  END;
  SHARED B_Input_B_I_I_6_Local := MODULE(B_Input_B_I_I_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_7(__in,__cfg_Local).__ENH_Input_B_I_I_7) __ENH_Input_B_I_I_7 := B_Input_B_I_I_7_Local.__ENH_Input_B_I_I_7;
  END;
  SHARED B_Input_P_I_I_6_Local := MODULE(B_Input_P_I_I_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_7(__in,__cfg_Local).__ENH_Input_P_I_I_7) __ENH_Input_P_I_I_7 := B_Input_P_I_I_7_Local.__ENH_Input_P_I_I_7;
  END;
  SHARED B_Lien_Judgment_6_Local := MODULE(B_Lien_Judgment_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_7(__in,__cfg_Local).__ENH_Lien_Judgment_7) __ENH_Lien_Judgment_7 := B_Lien_Judgment_7_Local.__ENH_Lien_Judgment_7;
  END;
  SHARED B_Person_6_Local := MODULE(B_Person_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_7(__in,__cfg_Local).__ENH_Education_7) __ENH_Education_7 := B_Education_7_Local.__ENH_Education_7;
    SHARED TYPEOF(B_Person_7(__in,__cfg_Local).__ENH_Person_7) __ENH_Person_7 := B_Person_7_Local.__ENH_Person_7;
    SHARED TYPEOF(E_Person_Education(__in,__cfg_Local).__Result) __E_Person_Education := E_Person_Education_Filtered.__Result;
  END;
  SHARED B_Sele_Address_6_Local := MODULE(B_Sele_Address_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_7(__in,__cfg_Local).__ENH_Business_Sele_7) __ENH_Business_Sele_7 := B_Business_Sele_7_Local.__ENH_Business_Sele_7;
    SHARED TYPEOF(E_Sele_Address(__in,__cfg_Local).__Result) __E_Sele_Address := E_Sele_Address_Filtered.__Result;
  END;
  SHARED B_Sele_Person_6_Local := MODULE(B_Sele_Person_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Person_7(__in,__cfg_Local).__ENH_Sele_Person_7) __ENH_Sele_Person_7 := B_Sele_Person_7_Local.__ENH_Sele_Person_7;
  END;
  SHARED B_Sele_Phone_Number_6_Local := MODULE(B_Sele_Phone_Number_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_7(__in,__cfg_Local).__ENH_Business_Sele_7) __ENH_Business_Sele_7 := B_Business_Sele_7_Local.__ENH_Business_Sele_7;
    SHARED TYPEOF(E_Sele_Phone_Number(__in,__cfg_Local).__Result) __E_Sele_Phone_Number := E_Sele_Phone_Number_Filtered.__Result;
  END;
  SHARED B_Sele_T_I_N_6_Local := MODULE(B_Sele_T_I_N_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_7(__in,__cfg_Local).__ENH_Business_Sele_7) __ENH_Business_Sele_7 := B_Business_Sele_7_Local.__ENH_Business_Sele_7;
    SHARED TYPEOF(E_Sele_T_I_N(__in,__cfg_Local).__Result) __E_Sele_T_I_N := E_Sele_T_I_N_Filtered.__Result;
  END;
  SHARED B_Sele_U_C_C_6_Local := MODULE(B_Sele_U_C_C_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_U_C_C_7(__in,__cfg_Local).__ENH_Sele_U_C_C_7) __ENH_Sele_U_C_C_7 := B_Sele_U_C_C_7_Local.__ENH_Sele_U_C_C_7;
  END;
  SHARED B_Tradeline_6_Local := MODULE(B_Tradeline_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_7(__in,__cfg_Local).__ENH_Tradeline_7) __ENH_Tradeline_7 := B_Tradeline_7_Local.__ENH_Tradeline_7;
  END;
  SHARED B_U_C_C_6_Local := MODULE(B_U_C_C_6(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_7(__in,__cfg_Local).__ENH_U_C_C_7) __ENH_U_C_C_7 := B_U_C_C_7_Local.__ENH_U_C_C_7;
  END;
  SHARED B_Address_5_Local := MODULE(B_Address_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_6(__in,__cfg_Local).__ENH_Address_6) __ENH_Address_6 := B_Address_6_Local.__ENH_Address_6;
  END;
  SHARED B_Bankruptcy_5_Local := MODULE(B_Bankruptcy_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_6(__in,__cfg_Local).__ENH_Bankruptcy_6) __ENH_Bankruptcy_6 := B_Bankruptcy_6_Local.__ENH_Bankruptcy_6;
  END;
  SHARED B_Business_Sele_5_Local := MODULE(B_Business_Sele_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_6(__in,__cfg_Local).__ENH_Address_6) __ENH_Address_6 := B_Address_6_Local.__ENH_Address_6;
    SHARED TYPEOF(B_Business_Sele_6(__in,__cfg_Local).__ENH_Business_Sele_6) __ENH_Business_Sele_6 := B_Business_Sele_6_Local.__ENH_Business_Sele_6;
    SHARED TYPEOF(B_Sele_Address_6(__in,__cfg_Local).__ENH_Sele_Address_6) __ENH_Sele_Address_6 := B_Sele_Address_6_Local.__ENH_Sele_Address_6;
    SHARED TYPEOF(B_Sele_Phone_Number_6(__in,__cfg_Local).__ENH_Sele_Phone_Number_6) __ENH_Sele_Phone_Number_6 := B_Sele_Phone_Number_6_Local.__ENH_Sele_Phone_Number_6;
    SHARED TYPEOF(B_Sele_T_I_N_6(__in,__cfg_Local).__ENH_Sele_T_I_N_6) __ENH_Sele_T_I_N_6 := B_Sele_T_I_N_6_Local.__ENH_Sele_T_I_N_6;
    SHARED TYPEOF(B_Sele_U_C_C_6(__in,__cfg_Local).__ENH_Sele_U_C_C_6) __ENH_Sele_U_C_C_6 := B_Sele_U_C_C_6_Local.__ENH_Sele_U_C_C_6;
    SHARED TYPEOF(B_U_C_C_6(__in,__cfg_Local).__ENH_U_C_C_6) __ENH_U_C_C_6 := B_U_C_C_6_Local.__ENH_U_C_C_6;
  END;
  SHARED B_Criminal_Offense_5_Local := MODULE(B_Criminal_Offense_5(__in,__cfg_Local))
    SHARED TYPEOF(E_Criminal_Offense(__in,__cfg_Local).__Result) __E_Criminal_Offense := E_Criminal_Offense_Filtered.__Result;
  END;
  SHARED B_Education_5_Local := MODULE(B_Education_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_6(__in,__cfg_Local).__ENH_Education_6) __ENH_Education_6 := B_Education_6_Local.__ENH_Education_6;
  END;
  SHARED B_First_Degree_Relative_5_Local := MODULE(B_First_Degree_Relative_5(__in,__cfg_Local))
    SHARED TYPEOF(E_First_Degree_Associations(__in,__cfg_Local).__Result) __E_First_Degree_Associations := E_First_Degree_Associations_Filtered.__Result;
  END;
  SHARED B_Input_B_I_I_5_Local := MODULE(B_Input_B_I_I_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_6(__in,__cfg_Local).__ENH_Input_B_I_I_6) __ENH_Input_B_I_I_6 := B_Input_B_I_I_6_Local.__ENH_Input_B_I_I_6;
  END;
  SHARED B_Input_P_I_I_5_Local := MODULE(B_Input_P_I_I_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_6(__in,__cfg_Local).__ENH_Input_P_I_I_6) __ENH_Input_P_I_I_6 := B_Input_P_I_I_6_Local.__ENH_Input_P_I_I_6;
  END;
  SHARED B_Lien_Judgment_5_Local := MODULE(B_Lien_Judgment_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_6(__in,__cfg_Local).__ENH_Lien_Judgment_6) __ENH_Lien_Judgment_6 := B_Lien_Judgment_6_Local.__ENH_Lien_Judgment_6;
  END;
  SHARED B_Person_5_Local := MODULE(B_Person_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_6(__in,__cfg_Local).__ENH_Person_6) __ENH_Person_6 := B_Person_6_Local.__ENH_Person_6;
  END;
  SHARED B_Professional_License_5_Local := MODULE(B_Professional_License_5(__in,__cfg_Local))
    SHARED TYPEOF(E_Professional_License(__in,__cfg_Local).__Result) __E_Professional_License := E_Professional_License_Filtered.__Result;
  END;
  SHARED B_Property_5_Local := MODULE(B_Property_5(__in,__cfg_Local))
    SHARED TYPEOF(E_Property(__in,__cfg_Local).__Result) __E_Property := E_Property_Filtered.__Result;
  END;
  SHARED B_Property_Event_5_Local := MODULE(B_Property_Event_5(__in,__cfg_Local))
    SHARED TYPEOF(E_Property_Event(__in,__cfg_Local).__Result) __E_Property_Event := E_Property_Event_Filtered.__Result;
  END;
  SHARED B_Sele_Address_5_Local := MODULE(B_Sele_Address_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Address_6(__in,__cfg_Local).__ENH_Sele_Address_6) __ENH_Sele_Address_6 := B_Sele_Address_6_Local.__ENH_Sele_Address_6;
  END;
  SHARED B_Sele_Person_5_Local := MODULE(B_Sele_Person_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Person_6(__in,__cfg_Local).__ENH_Sele_Person_6) __ENH_Sele_Person_6 := B_Sele_Person_6_Local.__ENH_Sele_Person_6;
  END;
  SHARED B_Sele_Phone_Number_5_Local := MODULE(B_Sele_Phone_Number_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Phone_Number_6(__in,__cfg_Local).__ENH_Sele_Phone_Number_6) __ENH_Sele_Phone_Number_6 := B_Sele_Phone_Number_6_Local.__ENH_Sele_Phone_Number_6;
  END;
  SHARED B_Sele_T_I_N_5_Local := MODULE(B_Sele_T_I_N_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_T_I_N_6(__in,__cfg_Local).__ENH_Sele_T_I_N_6) __ENH_Sele_T_I_N_6 := B_Sele_T_I_N_6_Local.__ENH_Sele_T_I_N_6;
  END;
  SHARED B_Sele_U_C_C_5_Local := MODULE(B_Sele_U_C_C_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_U_C_C_6(__in,__cfg_Local).__ENH_Sele_U_C_C_6) __ENH_Sele_U_C_C_6 := B_Sele_U_C_C_6_Local.__ENH_Sele_U_C_C_6;
  END;
  SHARED B_Tradeline_5_Local := MODULE(B_Tradeline_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_6(__in,__cfg_Local).__ENH_Tradeline_6) __ENH_Tradeline_6 := B_Tradeline_6_Local.__ENH_Tradeline_6;
  END;
  SHARED B_U_C_C_5_Local := MODULE(B_U_C_C_5(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_6(__in,__cfg_Local).__ENH_U_C_C_6) __ENH_U_C_C_6 := B_U_C_C_6_Local.__ENH_U_C_C_6;
  END;
  SHARED B_Address_4_Local := MODULE(B_Address_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_5(__in,__cfg_Local).__ENH_Address_5) __ENH_Address_5 := B_Address_5_Local.__ENH_Address_5;
  END;
  SHARED B_Bankruptcy_4_Local := MODULE(B_Bankruptcy_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_5(__in,__cfg_Local).__ENH_Bankruptcy_5) __ENH_Bankruptcy_5 := B_Bankruptcy_5_Local.__ENH_Bankruptcy_5;
  END;
  SHARED B_Business_Sele_4_Local := MODULE(B_Business_Sele_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_5(__in,__cfg_Local).__ENH_Address_5) __ENH_Address_5 := B_Address_5_Local.__ENH_Address_5;
    SHARED TYPEOF(B_Bankruptcy_5(__in,__cfg_Local).__ENH_Bankruptcy_5) __ENH_Bankruptcy_5 := B_Bankruptcy_5_Local.__ENH_Bankruptcy_5;
    SHARED TYPEOF(B_Business_Sele_5(__in,__cfg_Local).__ENH_Business_Sele_5) __ENH_Business_Sele_5 := B_Business_Sele_5_Local.__ENH_Business_Sele_5;
    SHARED TYPEOF(B_Sele_Address_5(__in,__cfg_Local).__ENH_Sele_Address_5) __ENH_Sele_Address_5 := B_Sele_Address_5_Local.__ENH_Sele_Address_5;
    SHARED TYPEOF(E_Sele_Bankruptcy(__in,__cfg_Local).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Person_5(__in,__cfg_Local).__ENH_Sele_Person_5) __ENH_Sele_Person_5 := B_Sele_Person_5_Local.__ENH_Sele_Person_5;
    SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg_Local).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered.__Result;
    SHARED TYPEOF(B_Sele_U_C_C_5(__in,__cfg_Local).__ENH_Sele_U_C_C_5) __ENH_Sele_U_C_C_5 := B_Sele_U_C_C_5_Local.__ENH_Sele_U_C_C_5;
    SHARED TYPEOF(B_Tradeline_5(__in,__cfg_Local).__ENH_Tradeline_5) __ENH_Tradeline_5 := B_Tradeline_5_Local.__ENH_Tradeline_5;
    SHARED TYPEOF(B_U_C_C_5(__in,__cfg_Local).__ENH_U_C_C_5) __ENH_U_C_C_5 := B_U_C_C_5_Local.__ENH_U_C_C_5;
  END;
  SHARED B_Criminal_Offense_4_Local := MODULE(B_Criminal_Offense_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Criminal_Offense_5(__in,__cfg_Local).__ENH_Criminal_Offense_5) __ENH_Criminal_Offense_5 := B_Criminal_Offense_5_Local.__ENH_Criminal_Offense_5;
  END;
  SHARED B_Education_4_Local := MODULE(B_Education_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_5(__in,__cfg_Local).__ENH_Education_5) __ENH_Education_5 := B_Education_5_Local.__ENH_Education_5;
  END;
  SHARED B_First_Degree_Relative_4_Local := MODULE(B_First_Degree_Relative_4(__in,__cfg_Local))
    SHARED TYPEOF(B_First_Degree_Relative_5(__in,__cfg_Local).__ENH_First_Degree_Relative_5) __ENH_First_Degree_Relative_5 := B_First_Degree_Relative_5_Local.__ENH_First_Degree_Relative_5;
  END;
  SHARED B_Input_B_I_I_4_Local := MODULE(B_Input_B_I_I_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_5(__in,__cfg_Local).__ENH_Input_B_I_I_5) __ENH_Input_B_I_I_5 := B_Input_B_I_I_5_Local.__ENH_Input_B_I_I_5;
  END;
  SHARED B_Input_P_I_I_4_Local := MODULE(B_Input_P_I_I_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_5(__in,__cfg_Local).__ENH_Input_P_I_I_5) __ENH_Input_P_I_I_5 := B_Input_P_I_I_5_Local.__ENH_Input_P_I_I_5;
  END;
  SHARED B_Lien_Judgment_4_Local := MODULE(B_Lien_Judgment_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_5(__in,__cfg_Local).__ENH_Lien_Judgment_5) __ENH_Lien_Judgment_5 := B_Lien_Judgment_5_Local.__ENH_Lien_Judgment_5;
  END;
  SHARED B_Person_4_Local := MODULE(B_Person_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_5(__in,__cfg_Local).__ENH_Person_5) __ENH_Person_5 := B_Person_5_Local.__ENH_Person_5;
    SHARED TYPEOF(E_Utility_Person(__in,__cfg_Local).__Result) __E_Utility_Person := E_Utility_Person_Filtered.__Result;
  END;
  SHARED B_Professional_License_4_Local := MODULE(B_Professional_License_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Professional_License_5(__in,__cfg_Local).__ENH_Professional_License_5) __ENH_Professional_License_5 := B_Professional_License_5_Local.__ENH_Professional_License_5;
  END;
  SHARED B_Property_4_Local := MODULE(B_Property_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_5(__in,__cfg_Local).__ENH_Property_5) __ENH_Property_5 := B_Property_5_Local.__ENH_Property_5;
  END;
  SHARED B_Property_Event_4_Local := MODULE(B_Property_Event_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_5(__in,__cfg_Local).__ENH_Property_Event_5) __ENH_Property_Event_5 := B_Property_Event_5_Local.__ENH_Property_Event_5;
  END;
  SHARED B_Sele_Address_4_Local := MODULE(B_Sele_Address_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Address_5(__in,__cfg_Local).__ENH_Sele_Address_5) __ENH_Sele_Address_5 := B_Sele_Address_5_Local.__ENH_Sele_Address_5;
  END;
  SHARED B_Sele_Person_4_Local := MODULE(B_Sele_Person_4(__in,__cfg_Local))
    SHARED TYPEOF(B_First_Degree_Relative_5(__in,__cfg_Local).__ENH_First_Degree_Relative_5) __ENH_First_Degree_Relative_5 := B_First_Degree_Relative_5_Local.__ENH_First_Degree_Relative_5;
    SHARED TYPEOF(B_Sele_Person_5(__in,__cfg_Local).__ENH_Sele_Person_5) __ENH_Sele_Person_5 := B_Sele_Person_5_Local.__ENH_Sele_Person_5;
  END;
  SHARED B_Sele_Phone_Number_4_Local := MODULE(B_Sele_Phone_Number_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Phone_Number_5(__in,__cfg_Local).__ENH_Sele_Phone_Number_5) __ENH_Sele_Phone_Number_5 := B_Sele_Phone_Number_5_Local.__ENH_Sele_Phone_Number_5;
  END;
  SHARED B_Sele_Property_4_Local := MODULE(B_Sele_Property_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_5(__in,__cfg_Local).__ENH_Property_Event_5) __ENH_Property_Event_5 := B_Property_Event_5_Local.__ENH_Property_Event_5;
    SHARED TYPEOF(E_Sele_Property(__in,__cfg_Local).__Result) __E_Sele_Property := E_Sele_Property_Filtered.__Result;
    SHARED TYPEOF(E_Sele_Property_Event(__in,__cfg_Local).__Result) __E_Sele_Property_Event := E_Sele_Property_Event_Filtered.__Result;
  END;
  SHARED B_Sele_T_I_N_4_Local := MODULE(B_Sele_T_I_N_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_T_I_N_5(__in,__cfg_Local).__ENH_Sele_T_I_N_5) __ENH_Sele_T_I_N_5 := B_Sele_T_I_N_5_Local.__ENH_Sele_T_I_N_5;
  END;
  SHARED B_Sele_U_C_C_4_Local := MODULE(B_Sele_U_C_C_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_U_C_C_5(__in,__cfg_Local).__ENH_Sele_U_C_C_5) __ENH_Sele_U_C_C_5 := B_Sele_U_C_C_5_Local.__ENH_Sele_U_C_C_5;
  END;
  SHARED B_Tradeline_4_Local := MODULE(B_Tradeline_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_5(__in,__cfg_Local).__ENH_Tradeline_5) __ENH_Tradeline_5 := B_Tradeline_5_Local.__ENH_Tradeline_5;
  END;
  SHARED B_U_C_C_4_Local := MODULE(B_U_C_C_4(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_5(__in,__cfg_Local).__ENH_U_C_C_5) __ENH_U_C_C_5 := B_U_C_C_5_Local.__ENH_U_C_C_5;
  END;
  SHARED B_Address_3_Local := MODULE(B_Address_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_4(__in,__cfg_Local).__ENH_Address_4) __ENH_Address_4 := B_Address_4_Local.__ENH_Address_4;
  END;
  SHARED B_Aircraft_Owner_3_Local := MODULE(B_Aircraft_Owner_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Aircraft_Owner(__in,__cfg_Local).__Result) __E_Aircraft_Owner := E_Aircraft_Owner_Filtered.__Result;
  END;
  SHARED B_Bankruptcy_3_Local := MODULE(B_Bankruptcy_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_4(__in,__cfg_Local).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4_Local.__ENH_Bankruptcy_4;
  END;
  SHARED B_Business_Prox_3_Local := MODULE(B_Business_Prox_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Business_Prox(__in,__cfg_Local).__Result) __E_Business_Prox := E_Business_Prox_Filtered.__Result;
    SHARED TYPEOF(E_Prox_Address(__in,__cfg_Local).__Result) __E_Prox_Address := E_Prox_Address_Filtered.__Result;
  END;
  SHARED B_Business_Sele_3_Local := MODULE(B_Business_Sele_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_4(__in,__cfg_Local).__ENH_Address_4) __ENH_Address_4 := B_Address_4_Local.__ENH_Address_4;
    SHARED TYPEOF(E_Address_Property_Event(__in,__cfg_Local).__Result) __E_Address_Property_Event := E_Address_Property_Event_Filtered.__Result;
    SHARED TYPEOF(B_Bankruptcy_4(__in,__cfg_Local).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4_Local.__ENH_Bankruptcy_4;
    SHARED TYPEOF(B_Business_Sele_4(__in,__cfg_Local).__ENH_Business_Sele_4) __ENH_Business_Sele_4 := B_Business_Sele_4_Local.__ENH_Business_Sele_4;
    SHARED TYPEOF(B_Property_Event_4(__in,__cfg_Local).__ENH_Property_Event_4) __ENH_Property_Event_4 := B_Property_Event_4_Local.__ENH_Property_Event_4;
    SHARED TYPEOF(B_Sele_Address_4(__in,__cfg_Local).__ENH_Sele_Address_4) __ENH_Sele_Address_4 := B_Sele_Address_4_Local.__ENH_Sele_Address_4;
    SHARED TYPEOF(E_Sele_Bankruptcy(__in,__cfg_Local).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Person_4(__in,__cfg_Local).__ENH_Sele_Person_4) __ENH_Sele_Person_4 := B_Sele_Person_4_Local.__ENH_Sele_Person_4;
    SHARED TYPEOF(B_Sele_Property_4(__in,__cfg_Local).__ENH_Sele_Property_4) __ENH_Sele_Property_4 := B_Sele_Property_4_Local.__ENH_Sele_Property_4;
    SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg_Local).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered.__Result;
    SHARED TYPEOF(B_Sele_U_C_C_4(__in,__cfg_Local).__ENH_Sele_U_C_C_4) __ENH_Sele_U_C_C_4 := B_Sele_U_C_C_4_Local.__ENH_Sele_U_C_C_4;
    SHARED TYPEOF(B_Tradeline_4(__in,__cfg_Local).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local.__ENH_Tradeline_4;
    SHARED TYPEOF(B_U_C_C_4(__in,__cfg_Local).__ENH_U_C_C_4) __ENH_U_C_C_4 := B_U_C_C_4_Local.__ENH_U_C_C_4;
    SHARED TYPEOF(E_Zip_Code(__in,__cfg_Local).__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
  END;
  SHARED B_Criminal_Offense_3_Local := MODULE(B_Criminal_Offense_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Criminal_Offense_4(__in,__cfg_Local).__ENH_Criminal_Offense_4) __ENH_Criminal_Offense_4 := B_Criminal_Offense_4_Local.__ENH_Criminal_Offense_4;
  END;
  SHARED B_Education_3_Local := MODULE(B_Education_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_4(__in,__cfg_Local).__ENH_Education_4) __ENH_Education_4 := B_Education_4_Local.__ENH_Education_4;
  END;
  SHARED B_First_Degree_Relative_3_Local := MODULE(B_First_Degree_Relative_3(__in,__cfg_Local))
    SHARED TYPEOF(B_First_Degree_Relative_4(__in,__cfg_Local).__ENH_First_Degree_Relative_4) __ENH_First_Degree_Relative_4 := B_First_Degree_Relative_4_Local.__ENH_First_Degree_Relative_4;
  END;
  SHARED B_Input_B_I_I_3_Local := MODULE(B_Input_B_I_I_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_4(__in,__cfg_Local).__ENH_Input_B_I_I_4) __ENH_Input_B_I_I_4 := B_Input_B_I_I_4_Local.__ENH_Input_B_I_I_4;
  END;
  SHARED B_Input_P_I_I_3_Local := MODULE(B_Input_P_I_I_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_4(__in,__cfg_Local).__ENH_Input_P_I_I_4) __ENH_Input_P_I_I_4 := B_Input_P_I_I_4_Local.__ENH_Input_P_I_I_4;
    SHARED TYPEOF(B_Property_4(__in,__cfg_Local).__ENH_Property_4) __ENH_Property_4 := B_Property_4_Local.__ENH_Property_4;
  END;
  SHARED B_Lien_Judgment_3_Local := MODULE(B_Lien_Judgment_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_4(__in,__cfg_Local).__ENH_Lien_Judgment_4) __ENH_Lien_Judgment_4 := B_Lien_Judgment_4_Local.__ENH_Lien_Judgment_4;
  END;
  SHARED B_Person_3_Local := MODULE(B_Person_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_4(__in,__cfg_Local).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4_Local.__ENH_Bankruptcy_4;
    SHARED TYPEOF(B_Criminal_Offense_4(__in,__cfg_Local).__ENH_Criminal_Offense_4) __ENH_Criminal_Offense_4 := B_Criminal_Offense_4_Local.__ENH_Criminal_Offense_4;
    SHARED TYPEOF(B_Person_4(__in,__cfg_Local).__ENH_Person_4) __ENH_Person_4 := B_Person_4_Local.__ENH_Person_4;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg_Local).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
    SHARED TYPEOF(B_Professional_License_4(__in,__cfg_Local).__ENH_Professional_License_4) __ENH_Professional_License_4 := B_Professional_License_4_Local.__ENH_Professional_License_4;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg_Local).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered.__Result;
  END;
  SHARED B_Person_Address_3_Local := MODULE(B_Person_Address_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_4(__in,__cfg_Local).__ENH_Person_4) __ENH_Person_4 := B_Person_4_Local.__ENH_Person_4;
    SHARED TYPEOF(E_Person_Address(__in,__cfg_Local).__Result) __E_Person_Address := E_Person_Address_Filtered.__Result;
  END;
  SHARED B_Person_Vehicle_3_Local := MODULE(B_Person_Vehicle_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Person_Vehicle(__in,__cfg_Local).__Result) __E_Person_Vehicle := E_Person_Vehicle_Filtered.__Result;
  END;
  SHARED B_Professional_License_3_Local := MODULE(B_Professional_License_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Professional_License_4(__in,__cfg_Local).__ENH_Professional_License_4) __ENH_Professional_License_4 := B_Professional_License_4_Local.__ENH_Professional_License_4;
  END;
  SHARED B_Property_3_Local := MODULE(B_Property_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_4(__in,__cfg_Local).__ENH_Property_4) __ENH_Property_4 := B_Property_4_Local.__ENH_Property_4;
  END;
  SHARED B_Property_Event_3_Local := MODULE(B_Property_Event_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_4(__in,__cfg_Local).__ENH_Property_Event_4) __ENH_Property_Event_4 := B_Property_Event_4_Local.__ENH_Property_Event_4;
  END;
  SHARED B_Sele_Address_3_Local := MODULE(B_Sele_Address_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Address_4(__in,__cfg_Local).__ENH_Sele_Address_4) __ENH_Sele_Address_4 := B_Sele_Address_4_Local.__ENH_Sele_Address_4;
  END;
  SHARED B_Sele_Person_3_Local := MODULE(B_Sele_Person_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Person_4(__in,__cfg_Local).__ENH_Sele_Person_4) __ENH_Sele_Person_4 := B_Sele_Person_4_Local.__ENH_Sele_Person_4;
  END;
  SHARED B_Sele_Phone_Number_3_Local := MODULE(B_Sele_Phone_Number_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Phone_Number_4(__in,__cfg_Local).__ENH_Sele_Phone_Number_4) __ENH_Sele_Phone_Number_4 := B_Sele_Phone_Number_4_Local.__ENH_Sele_Phone_Number_4;
  END;
  SHARED B_Sele_Property_3_Local := MODULE(B_Sele_Property_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Property_4(__in,__cfg_Local).__ENH_Sele_Property_4) __ENH_Sele_Property_4 := B_Sele_Property_4_Local.__ENH_Sele_Property_4;
  END;
  SHARED B_Sele_T_I_N_3_Local := MODULE(B_Sele_T_I_N_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_T_I_N_4(__in,__cfg_Local).__ENH_Sele_T_I_N_4) __ENH_Sele_T_I_N_4 := B_Sele_T_I_N_4_Local.__ENH_Sele_T_I_N_4;
  END;
  SHARED B_Sele_Tradeline_3_Local := MODULE(B_Sele_Tradeline_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg_Local).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered.__Result;
    SHARED TYPEOF(B_Tradeline_4(__in,__cfg_Local).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local.__ENH_Tradeline_4;
  END;
  SHARED B_Sele_U_C_C_3_Local := MODULE(B_Sele_U_C_C_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_U_C_C_4(__in,__cfg_Local).__ENH_Sele_U_C_C_4) __ENH_Sele_U_C_C_4 := B_Sele_U_C_C_4_Local.__ENH_Sele_U_C_C_4;
  END;
  SHARED B_Sele_Vehicle_3_Local := MODULE(B_Sele_Vehicle_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Sele_Vehicle(__in,__cfg_Local).__Result) __E_Sele_Vehicle := E_Sele_Vehicle_Filtered.__Result;
  END;
  SHARED B_Tradeline_3_Local := MODULE(B_Tradeline_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_4(__in,__cfg_Local).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local.__ENH_Tradeline_4;
  END;
  SHARED B_U_C_C_3_Local := MODULE(B_U_C_C_3(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_4(__in,__cfg_Local).__ENH_U_C_C_4) __ENH_U_C_C_4 := B_U_C_C_4_Local.__ENH_U_C_C_4;
  END;
  SHARED B_Watercraft_Owner_3_Local := MODULE(B_Watercraft_Owner_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Watercraft_Owner(__in,__cfg_Local).__Result) __E_Watercraft_Owner := E_Watercraft_Owner_Filtered.__Result;
  END;
  SHARED B_Address_2_Local := MODULE(B_Address_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_3(__in,__cfg_Local).__ENH_Address_3) __ENH_Address_3 := B_Address_3_Local.__ENH_Address_3;
    SHARED TYPEOF(E_Zip_Code(__in,__cfg_Local).__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
  END;
  SHARED B_Aircraft_Owner_2_Local := MODULE(B_Aircraft_Owner_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Aircraft_Owner_3(__in,__cfg_Local).__ENH_Aircraft_Owner_3) __ENH_Aircraft_Owner_3 := B_Aircraft_Owner_3_Local.__ENH_Aircraft_Owner_3;
  END;
  SHARED B_Bankruptcy_2_Local := MODULE(B_Bankruptcy_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_3(__in,__cfg_Local).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local.__ENH_Bankruptcy_3;
  END;
  SHARED B_Business_Prox_2_Local := MODULE(B_Business_Prox_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Prox_3(__in,__cfg_Local).__ENH_Business_Prox_3) __ENH_Business_Prox_3 := B_Business_Prox_3_Local.__ENH_Business_Prox_3;
    SHARED TYPEOF(E_Prox_Phone_Number(__in,__cfg_Local).__Result) __E_Prox_Phone_Number := E_Prox_Phone_Number_Filtered.__Result;
    SHARED TYPEOF(E_Prox_T_I_N(__in,__cfg_Local).__Result) __E_Prox_T_I_N := E_Prox_T_I_N_Filtered.__Result;
  END;
  SHARED B_Business_Sele_2_Local := MODULE(B_Business_Sele_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_3(__in,__cfg_Local).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local.__ENH_Bankruptcy_3;
    SHARED TYPEOF(B_Business_Prox_3(__in,__cfg_Local).__ENH_Business_Prox_3) __ENH_Business_Prox_3 := B_Business_Prox_3_Local.__ENH_Business_Prox_3;
    SHARED TYPEOF(B_Business_Sele_3(__in,__cfg_Local).__ENH_Business_Sele_3) __ENH_Business_Sele_3 := B_Business_Sele_3_Local.__ENH_Business_Sele_3;
    SHARED TYPEOF(B_Input_B_I_I_3(__in,__cfg_Local).__ENH_Input_B_I_I_3) __ENH_Input_B_I_I_3 := B_Input_B_I_I_3_Local.__ENH_Input_B_I_I_3;
    SHARED TYPEOF(B_Person_3(__in,__cfg_Local).__ENH_Person_3) __ENH_Person_3 := B_Person_3_Local.__ENH_Person_3;
    SHARED TYPEOF(B_Sele_Address_3(__in,__cfg_Local).__ENH_Sele_Address_3) __ENH_Sele_Address_3 := B_Sele_Address_3_Local.__ENH_Sele_Address_3;
    SHARED TYPEOF(E_Sele_Bankruptcy(__in,__cfg_Local).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Person_3(__in,__cfg_Local).__ENH_Sele_Person_3) __ENH_Sele_Person_3 := B_Sele_Person_3_Local.__ENH_Sele_Person_3;
    SHARED TYPEOF(B_Sele_Phone_Number_3(__in,__cfg_Local).__ENH_Sele_Phone_Number_3) __ENH_Sele_Phone_Number_3 := B_Sele_Phone_Number_3_Local.__ENH_Sele_Phone_Number_3;
    SHARED TYPEOF(B_Sele_Property_3(__in,__cfg_Local).__ENH_Sele_Property_3) __ENH_Sele_Property_3 := B_Sele_Property_3_Local.__ENH_Sele_Property_3;
    SHARED TYPEOF(B_Sele_T_I_N_3(__in,__cfg_Local).__ENH_Sele_T_I_N_3) __ENH_Sele_T_I_N_3 := B_Sele_T_I_N_3_Local.__ENH_Sele_T_I_N_3;
    SHARED TYPEOF(B_Sele_Tradeline_3(__in,__cfg_Local).__ENH_Sele_Tradeline_3) __ENH_Sele_Tradeline_3 := B_Sele_Tradeline_3_Local.__ENH_Sele_Tradeline_3;
    SHARED TYPEOF(B_Sele_U_C_C_3(__in,__cfg_Local).__ENH_Sele_U_C_C_3) __ENH_Sele_U_C_C_3 := B_Sele_U_C_C_3_Local.__ENH_Sele_U_C_C_3;
    SHARED TYPEOF(B_Sele_Vehicle_3(__in,__cfg_Local).__ENH_Sele_Vehicle_3) __ENH_Sele_Vehicle_3 := B_Sele_Vehicle_3_Local.__ENH_Sele_Vehicle_3;
    SHARED TYPEOF(B_Tradeline_3(__in,__cfg_Local).__ENH_Tradeline_3) __ENH_Tradeline_3 := B_Tradeline_3_Local.__ENH_Tradeline_3;
    SHARED TYPEOF(B_U_C_C_3(__in,__cfg_Local).__ENH_U_C_C_3) __ENH_U_C_C_3 := B_U_C_C_3_Local.__ENH_U_C_C_3;
    SHARED TYPEOF(E_Zip_Code(__in,__cfg_Local).__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
  END;
  SHARED B_Criminal_Offense_2_Local := MODULE(B_Criminal_Offense_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Criminal_Offense_3(__in,__cfg_Local).__ENH_Criminal_Offense_3) __ENH_Criminal_Offense_3 := B_Criminal_Offense_3_Local.__ENH_Criminal_Offense_3;
  END;
  SHARED B_Education_2_Local := MODULE(B_Education_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_3(__in,__cfg_Local).__ENH_Education_3) __ENH_Education_3 := B_Education_3_Local.__ENH_Education_3;
  END;
  SHARED B_Email_2_Local := MODULE(B_Email_2(__in,__cfg_Local))
    SHARED TYPEOF(E_Email(__in,__cfg_Local).__Result) __E_Email := E_Email_Filtered.__Result;
  END;
  SHARED B_First_Degree_Relative_2_Local := MODULE(B_First_Degree_Relative_2(__in,__cfg_Local))
    SHARED TYPEOF(B_First_Degree_Relative_3(__in,__cfg_Local).__ENH_First_Degree_Relative_3) __ENH_First_Degree_Relative_3 := B_First_Degree_Relative_3_Local.__ENH_First_Degree_Relative_3;
  END;
  SHARED B_Input_B_I_I_2_Local := MODULE(B_Input_B_I_I_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_3(__in,__cfg_Local).__ENH_Input_B_I_I_3) __ENH_Input_B_I_I_3 := B_Input_B_I_I_3_Local.__ENH_Input_B_I_I_3;
    SHARED TYPEOF(E_Input_B_I_I_Input_P_I_I(__in,__cfg_Local).__Result) __E_Input_B_I_I_Input_P_I_I := E_Input_B_I_I_Input_P_I_I_Filtered.__Result;
    SHARED TYPEOF(B_Input_P_I_I_3(__in,__cfg_Local).__ENH_Input_P_I_I_3) __ENH_Input_P_I_I_3 := B_Input_P_I_I_3_Local.__ENH_Input_P_I_I_3;
  END;
  SHARED B_Input_P_I_I_2_Local := MODULE(B_Input_P_I_I_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_3(__in,__cfg_Local).__ENH_Address_3) __ENH_Address_3 := B_Address_3_Local.__ENH_Address_3;
    SHARED TYPEOF(B_Input_P_I_I_3(__in,__cfg_Local).__ENH_Input_P_I_I_3) __ENH_Input_P_I_I_3 := B_Input_P_I_I_3_Local.__ENH_Input_P_I_I_3;
  END;
  SHARED B_Lien_Judgment_2_Local := MODULE(B_Lien_Judgment_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_3(__in,__cfg_Local).__ENH_Lien_Judgment_3) __ENH_Lien_Judgment_3 := B_Lien_Judgment_3_Local.__ENH_Lien_Judgment_3;
  END;
  SHARED B_Person_2_Local := MODULE(B_Person_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Aircraft_Owner_3(__in,__cfg_Local).__ENH_Aircraft_Owner_3) __ENH_Aircraft_Owner_3 := B_Aircraft_Owner_3_Local.__ENH_Aircraft_Owner_3;
    SHARED TYPEOF(B_Bankruptcy_3(__in,__cfg_Local).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local.__ENH_Bankruptcy_3;
    SHARED TYPEOF(B_Criminal_Offense_3(__in,__cfg_Local).__ENH_Criminal_Offense_3) __ENH_Criminal_Offense_3 := B_Criminal_Offense_3_Local.__ENH_Criminal_Offense_3;
    SHARED TYPEOF(B_Education_3(__in,__cfg_Local).__ENH_Education_3) __ENH_Education_3 := B_Education_3_Local.__ENH_Education_3;
    SHARED TYPEOF(B_Person_3(__in,__cfg_Local).__ENH_Person_3) __ENH_Person_3 := B_Person_3_Local.__ENH_Person_3;
    SHARED TYPEOF(B_Person_Address_3(__in,__cfg_Local).__ENH_Person_Address_3) __ENH_Person_Address_3 := B_Person_Address_3_Local.__ENH_Person_Address_3;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(E_Person_Education(__in,__cfg_Local).__Result) __E_Person_Education := E_Person_Education_Filtered.__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg_Local).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
    SHARED TYPEOF(B_Person_Vehicle_3(__in,__cfg_Local).__ENH_Person_Vehicle_3) __ENH_Person_Vehicle_3 := B_Person_Vehicle_3_Local.__ENH_Person_Vehicle_3;
    SHARED TYPEOF(B_Professional_License_3(__in,__cfg_Local).__ENH_Professional_License_3) __ENH_Professional_License_3 := B_Professional_License_3_Local.__ENH_Professional_License_3;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg_Local).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Person_3(__in,__cfg_Local).__ENH_Sele_Person_3) __ENH_Sele_Person_3 := B_Sele_Person_3_Local.__ENH_Sele_Person_3;
    SHARED TYPEOF(E_Utility_Person(__in,__cfg_Local).__Result) __E_Utility_Person := E_Utility_Person_Filtered.__Result;
    SHARED TYPEOF(B_Watercraft_Owner_3(__in,__cfg_Local).__ENH_Watercraft_Owner_3) __ENH_Watercraft_Owner_3 := B_Watercraft_Owner_3_Local.__ENH_Watercraft_Owner_3;
  END;
  SHARED B_Person_Address_2_Local := MODULE(B_Person_Address_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Address_3(__in,__cfg_Local).__ENH_Person_Address_3) __ENH_Person_Address_3 := B_Person_Address_3_Local.__ENH_Person_Address_3;
  END;
  SHARED B_Person_S_S_N_2_Local := MODULE(B_Person_S_S_N_2(__in,__cfg_Local))
    SHARED TYPEOF(E_Person_S_S_N(__in,__cfg_Local).__Result) __E_Person_S_S_N := E_Person_S_S_N_Filtered.__Result;
  END;
  SHARED B_Person_Vehicle_2_Local := MODULE(B_Person_Vehicle_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Vehicle_3(__in,__cfg_Local).__ENH_Person_Vehicle_3) __ENH_Person_Vehicle_3 := B_Person_Vehicle_3_Local.__ENH_Person_Vehicle_3;
  END;
  SHARED B_Professional_License_2_Local := MODULE(B_Professional_License_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Professional_License_3(__in,__cfg_Local).__ENH_Professional_License_3) __ENH_Professional_License_3 := B_Professional_License_3_Local.__ENH_Professional_License_3;
  END;
  SHARED B_Property_2_Local := MODULE(B_Property_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_3(__in,__cfg_Local).__ENH_Property_3) __ENH_Property_3 := B_Property_3_Local.__ENH_Property_3;
  END;
  SHARED B_Property_Event_2_Local := MODULE(B_Property_Event_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_3(__in,__cfg_Local).__ENH_Property_Event_3) __ENH_Property_Event_3 := B_Property_Event_3_Local.__ENH_Property_Event_3;
  END;
  SHARED B_Sele_Address_2_Local := MODULE(B_Sele_Address_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Address_3(__in,__cfg_Local).__ENH_Sele_Address_3) __ENH_Sele_Address_3 := B_Sele_Address_3_Local.__ENH_Sele_Address_3;
  END;
  SHARED B_Sele_Person_2_Local := MODULE(B_Sele_Person_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Person_3(__in,__cfg_Local).__ENH_Sele_Person_3) __ENH_Sele_Person_3 := B_Sele_Person_3_Local.__ENH_Sele_Person_3;
  END;
  SHARED B_Sele_Property_2_Local := MODULE(B_Sele_Property_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_3(__in,__cfg_Local).__ENH_Property_3) __ENH_Property_3 := B_Property_3_Local.__ENH_Property_3;
    SHARED TYPEOF(B_Property_Event_3(__in,__cfg_Local).__ENH_Property_Event_3) __ENH_Property_Event_3 := B_Property_Event_3_Local.__ENH_Property_Event_3;
    SHARED TYPEOF(B_Sele_Property_3(__in,__cfg_Local).__ENH_Sele_Property_3) __ENH_Sele_Property_3 := B_Sele_Property_3_Local.__ENH_Sele_Property_3;
    SHARED TYPEOF(E_Sele_Property_Event(__in,__cfg_Local).__Result) __E_Sele_Property_Event := E_Sele_Property_Event_Filtered.__Result;
  END;
  SHARED B_Sele_Tradeline_2_Local := MODULE(B_Sele_Tradeline_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Tradeline_3(__in,__cfg_Local).__ENH_Sele_Tradeline_3) __ENH_Sele_Tradeline_3 := B_Sele_Tradeline_3_Local.__ENH_Sele_Tradeline_3;
  END;
  SHARED B_Sele_U_C_C_2_Local := MODULE(B_Sele_U_C_C_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_U_C_C_3(__in,__cfg_Local).__ENH_Sele_U_C_C_3) __ENH_Sele_U_C_C_3 := B_Sele_U_C_C_3_Local.__ENH_Sele_U_C_C_3;
  END;
  SHARED B_Sele_Vehicle_2_Local := MODULE(B_Sele_Vehicle_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Vehicle_3(__in,__cfg_Local).__ENH_Sele_Vehicle_3) __ENH_Sele_Vehicle_3 := B_Sele_Vehicle_3_Local.__ENH_Sele_Vehicle_3;
  END;
  SHARED B_Tradeline_2_Local := MODULE(B_Tradeline_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_3(__in,__cfg_Local).__ENH_Tradeline_3) __ENH_Tradeline_3 := B_Tradeline_3_Local.__ENH_Tradeline_3;
  END;
  SHARED B_U_C_C_2_Local := MODULE(B_U_C_C_2(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_3(__in,__cfg_Local).__ENH_U_C_C_3) __ENH_U_C_C_3 := B_U_C_C_3_Local.__ENH_U_C_C_3;
  END;
  SHARED B_Watercraft_Owner_2_Local := MODULE(B_Watercraft_Owner_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Watercraft_Owner_3(__in,__cfg_Local).__ENH_Watercraft_Owner_3) __ENH_Watercraft_Owner_3 := B_Watercraft_Owner_3_Local.__ENH_Watercraft_Owner_3;
  END;
  SHARED B_Address_1_Local := MODULE(B_Address_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_2(__in,__cfg_Local).__ENH_Address_2) __ENH_Address_2 := B_Address_2_Local.__ENH_Address_2;
  END;
  SHARED B_Aircraft_Owner_1_Local := MODULE(B_Aircraft_Owner_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Aircraft_Owner_2(__in,__cfg_Local).__ENH_Aircraft_Owner_2) __ENH_Aircraft_Owner_2 := B_Aircraft_Owner_2_Local.__ENH_Aircraft_Owner_2;
  END;
  SHARED B_Bankruptcy_1_Local := MODULE(B_Bankruptcy_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_2(__in,__cfg_Local).__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local.__ENH_Bankruptcy_2;
  END;
  SHARED B_Business_Prox_1_Local := MODULE(B_Business_Prox_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Prox_2(__in,__cfg_Local).__ENH_Business_Prox_2) __ENH_Business_Prox_2 := B_Business_Prox_2_Local.__ENH_Business_Prox_2;
  END;
  SHARED B_Business_Sele_1_Local := MODULE(B_Business_Sele_1(__in,__cfg_Local))
    SHARED TYPEOF(E_Address_Property_Event(__in,__cfg_Local).__Result) __E_Address_Property_Event := E_Address_Property_Event_Filtered.__Result;
    SHARED TYPEOF(B_Bankruptcy_2(__in,__cfg_Local).__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local.__ENH_Bankruptcy_2;
    SHARED TYPEOF(B_Business_Prox_2(__in,__cfg_Local).__ENH_Business_Prox_2) __ENH_Business_Prox_2 := B_Business_Prox_2_Local.__ENH_Business_Prox_2;
    SHARED TYPEOF(B_Business_Sele_2(__in,__cfg_Local).__ENH_Business_Sele_2) __ENH_Business_Sele_2 := B_Business_Sele_2_Local.__ENH_Business_Sele_2;
    SHARED TYPEOF(B_Input_B_I_I_2(__in,__cfg_Local).__ENH_Input_B_I_I_2) __ENH_Input_B_I_I_2 := B_Input_B_I_I_2_Local.__ENH_Input_B_I_I_2;
    SHARED TYPEOF(B_Person_2(__in,__cfg_Local).__ENH_Person_2) __ENH_Person_2 := B_Person_2_Local.__ENH_Person_2;
    SHARED TYPEOF(E_Person_Email(__in,__cfg_Local).__Result) __E_Person_Email := E_Person_Email_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Address_2(__in,__cfg_Local).__ENH_Sele_Address_2) __ENH_Sele_Address_2 := B_Sele_Address_2_Local.__ENH_Sele_Address_2;
    SHARED TYPEOF(E_Sele_Bankruptcy(__in,__cfg_Local).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Person_2(__in,__cfg_Local).__ENH_Sele_Person_2) __ENH_Sele_Person_2 := B_Sele_Person_2_Local.__ENH_Sele_Person_2;
    SHARED TYPEOF(B_Sele_Property_2(__in,__cfg_Local).__ENH_Sele_Property_2) __ENH_Sele_Property_2 := B_Sele_Property_2_Local.__ENH_Sele_Property_2;
    SHARED TYPEOF(E_Sele_Property_Event(__in,__cfg_Local).__Result) __E_Sele_Property_Event := E_Sele_Property_Event_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Tradeline_2(__in,__cfg_Local).__ENH_Sele_Tradeline_2) __ENH_Sele_Tradeline_2 := B_Sele_Tradeline_2_Local.__ENH_Sele_Tradeline_2;
    SHARED TYPEOF(B_Sele_U_C_C_2(__in,__cfg_Local).__ENH_Sele_U_C_C_2) __ENH_Sele_U_C_C_2 := B_Sele_U_C_C_2_Local.__ENH_Sele_U_C_C_2;
    SHARED TYPEOF(B_Sele_Vehicle_2(__in,__cfg_Local).__ENH_Sele_Vehicle_2) __ENH_Sele_Vehicle_2 := B_Sele_Vehicle_2_Local.__ENH_Sele_Vehicle_2;
    SHARED TYPEOF(B_Tradeline_2(__in,__cfg_Local).__ENH_Tradeline_2) __ENH_Tradeline_2 := B_Tradeline_2_Local.__ENH_Tradeline_2;
    SHARED TYPEOF(B_U_C_C_2(__in,__cfg_Local).__ENH_U_C_C_2) __ENH_U_C_C_2 := B_U_C_C_2_Local.__ENH_U_C_C_2;
    SHARED TYPEOF(E_Zip_Code(__in,__cfg_Local).__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
  END;
  SHARED B_Criminal_Offense_1_Local := MODULE(B_Criminal_Offense_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Criminal_Offense_2(__in,__cfg_Local).__ENH_Criminal_Offense_2) __ENH_Criminal_Offense_2 := B_Criminal_Offense_2_Local.__ENH_Criminal_Offense_2;
  END;
  SHARED B_Education_1_Local := MODULE(B_Education_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_2(__in,__cfg_Local).__ENH_Education_2) __ENH_Education_2 := B_Education_2_Local.__ENH_Education_2;
  END;
  SHARED B_Email_1_Local := MODULE(B_Email_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Email_2(__in,__cfg_Local).__ENH_Email_2) __ENH_Email_2 := B_Email_2_Local.__ENH_Email_2;
  END;
  SHARED B_First_Degree_Relative_1_Local := MODULE(B_First_Degree_Relative_1(__in,__cfg_Local))
    SHARED TYPEOF(B_First_Degree_Relative_2(__in,__cfg_Local).__ENH_First_Degree_Relative_2) __ENH_First_Degree_Relative_2 := B_First_Degree_Relative_2_Local.__ENH_First_Degree_Relative_2;
  END;
  SHARED B_Input_B_I_I_1_Local := MODULE(B_Input_B_I_I_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_2(__in,__cfg_Local).__ENH_Input_B_I_I_2) __ENH_Input_B_I_I_2 := B_Input_B_I_I_2_Local.__ENH_Input_B_I_I_2;
    SHARED TYPEOF(E_Input_B_I_I_Input_P_I_I(__in,__cfg_Local).__Result) __E_Input_B_I_I_Input_P_I_I := E_Input_B_I_I_Input_P_I_I_Filtered.__Result;
    SHARED TYPEOF(B_Input_P_I_I_2(__in,__cfg_Local).__ENH_Input_P_I_I_2) __ENH_Input_P_I_I_2 := B_Input_P_I_I_2_Local.__ENH_Input_P_I_I_2;
  END;
  SHARED B_Lien_Judgment_1_Local := MODULE(B_Lien_Judgment_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_2(__in,__cfg_Local).__ENH_Lien_Judgment_2) __ENH_Lien_Judgment_2 := B_Lien_Judgment_2_Local.__ENH_Lien_Judgment_2;
  END;
  SHARED B_Person_1_Local := MODULE(B_Person_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_2(__in,__cfg_Local).__ENH_Address_2) __ENH_Address_2 := B_Address_2_Local.__ENH_Address_2;
    SHARED TYPEOF(B_Aircraft_Owner_2(__in,__cfg_Local).__ENH_Aircraft_Owner_2) __ENH_Aircraft_Owner_2 := B_Aircraft_Owner_2_Local.__ENH_Aircraft_Owner_2;
    SHARED TYPEOF(B_Bankruptcy_2(__in,__cfg_Local).__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local.__ENH_Bankruptcy_2;
    SHARED TYPEOF(B_Criminal_Offense_2(__in,__cfg_Local).__ENH_Criminal_Offense_2) __ENH_Criminal_Offense_2 := B_Criminal_Offense_2_Local.__ENH_Criminal_Offense_2;
    SHARED TYPEOF(B_Education_2(__in,__cfg_Local).__ENH_Education_2) __ENH_Education_2 := B_Education_2_Local.__ENH_Education_2;
    SHARED TYPEOF(B_Email_2(__in,__cfg_Local).__ENH_Email_2) __ENH_Email_2 := B_Email_2_Local.__ENH_Email_2;
    SHARED TYPEOF(B_Person_2(__in,__cfg_Local).__ENH_Person_2) __ENH_Person_2 := B_Person_2_Local.__ENH_Person_2;
    SHARED TYPEOF(B_Person_Address_2(__in,__cfg_Local).__ENH_Person_Address_2) __ENH_Person_Address_2 := B_Person_Address_2_Local.__ENH_Person_Address_2;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(E_Person_Education(__in,__cfg_Local).__Result) __E_Person_Education := E_Person_Education_Filtered.__Result;
    SHARED TYPEOF(E_Person_Email(__in,__cfg_Local).__Result) __E_Person_Email := E_Person_Email_Filtered.__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg_Local).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
    SHARED TYPEOF(B_Person_S_S_N_2(__in,__cfg_Local).__ENH_Person_S_S_N_2) __ENH_Person_S_S_N_2 := B_Person_S_S_N_2_Local.__ENH_Person_S_S_N_2;
    SHARED TYPEOF(B_Person_Vehicle_2(__in,__cfg_Local).__ENH_Person_Vehicle_2) __ENH_Person_Vehicle_2 := B_Person_Vehicle_2_Local.__ENH_Person_Vehicle_2;
    SHARED TYPEOF(B_Professional_License_2(__in,__cfg_Local).__ENH_Professional_License_2) __ENH_Professional_License_2 := B_Professional_License_2_Local.__ENH_Professional_License_2;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg_Local).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered.__Result;
    SHARED TYPEOF(B_Watercraft_Owner_2(__in,__cfg_Local).__ENH_Watercraft_Owner_2) __ENH_Watercraft_Owner_2 := B_Watercraft_Owner_2_Local.__ENH_Watercraft_Owner_2;
  END;
  SHARED B_Person_S_S_N_1_Local := MODULE(B_Person_S_S_N_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_S_S_N_2(__in,__cfg_Local).__ENH_Person_S_S_N_2) __ENH_Person_S_S_N_2 := B_Person_S_S_N_2_Local.__ENH_Person_S_S_N_2;
  END;
  SHARED B_Person_Vehicle_1_Local := MODULE(B_Person_Vehicle_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Vehicle_2(__in,__cfg_Local).__ENH_Person_Vehicle_2) __ENH_Person_Vehicle_2 := B_Person_Vehicle_2_Local.__ENH_Person_Vehicle_2;
  END;
  SHARED B_Professional_License_1_Local := MODULE(B_Professional_License_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Professional_License_2(__in,__cfg_Local).__ENH_Professional_License_2) __ENH_Professional_License_2 := B_Professional_License_2_Local.__ENH_Professional_License_2;
  END;
  SHARED B_Property_1_Local := MODULE(B_Property_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_2(__in,__cfg_Local).__ENH_Property_2) __ENH_Property_2 := B_Property_2_Local.__ENH_Property_2;
  END;
  SHARED B_Property_Event_1_Local := MODULE(B_Property_Event_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_2(__in,__cfg_Local).__ENH_Property_Event_2) __ENH_Property_Event_2 := B_Property_Event_2_Local.__ENH_Property_Event_2;
  END;
  SHARED B_Sele_Address_1_Local := MODULE(B_Sele_Address_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Address_2(__in,__cfg_Local).__ENH_Sele_Address_2) __ENH_Sele_Address_2 := B_Sele_Address_2_Local.__ENH_Sele_Address_2;
  END;
  SHARED B_Sele_Person_1_Local := MODULE(B_Sele_Person_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Person_2(__in,__cfg_Local).__ENH_Sele_Person_2) __ENH_Sele_Person_2 := B_Sele_Person_2_Local.__ENH_Sele_Person_2;
  END;
  SHARED B_Sele_Property_1_Local := MODULE(B_Sele_Property_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_2(__in,__cfg_Local).__ENH_Property_Event_2) __ENH_Property_Event_2 := B_Property_Event_2_Local.__ENH_Property_Event_2;
    SHARED TYPEOF(B_Sele_Property_2(__in,__cfg_Local).__ENH_Sele_Property_2) __ENH_Sele_Property_2 := B_Sele_Property_2_Local.__ENH_Sele_Property_2;
    SHARED TYPEOF(E_Sele_Property_Event(__in,__cfg_Local).__Result) __E_Sele_Property_Event := E_Sele_Property_Event_Filtered.__Result;
  END;
  SHARED B_Sele_Tradeline_1_Local := MODULE(B_Sele_Tradeline_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Tradeline_2(__in,__cfg_Local).__ENH_Sele_Tradeline_2) __ENH_Sele_Tradeline_2 := B_Sele_Tradeline_2_Local.__ENH_Sele_Tradeline_2;
  END;
  SHARED B_Sele_Vehicle_1_Local := MODULE(B_Sele_Vehicle_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Vehicle_2(__in,__cfg_Local).__ENH_Sele_Vehicle_2) __ENH_Sele_Vehicle_2 := B_Sele_Vehicle_2_Local.__ENH_Sele_Vehicle_2;
  END;
  SHARED B_Tradeline_1_Local := MODULE(B_Tradeline_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_2(__in,__cfg_Local).__ENH_Tradeline_2) __ENH_Tradeline_2 := B_Tradeline_2_Local.__ENH_Tradeline_2;
  END;
  SHARED B_U_C_C_1_Local := MODULE(B_U_C_C_1(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_2(__in,__cfg_Local).__ENH_U_C_C_2) __ENH_U_C_C_2 := B_U_C_C_2_Local.__ENH_U_C_C_2;
  END;
  SHARED B_Watercraft_Owner_1_Local := MODULE(B_Watercraft_Owner_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Watercraft_Owner_2(__in,__cfg_Local).__ENH_Watercraft_Owner_2) __ENH_Watercraft_Owner_2 := B_Watercraft_Owner_2_Local.__ENH_Watercraft_Owner_2;
  END;
  SHARED B_Address_Local := MODULE(B_Address(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_1(__in,__cfg_Local).__ENH_Address_1) __ENH_Address_1 := B_Address_1_Local.__ENH_Address_1;
  END;
  SHARED B_Bankruptcy_Local := MODULE(B_Bankruptcy(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_1(__in,__cfg_Local).__ENH_Bankruptcy_1) __ENH_Bankruptcy_1 := B_Bankruptcy_1_Local.__ENH_Bankruptcy_1;
  END;
  SHARED B_Business_Prox_Local := MODULE(B_Business_Prox(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Prox_1(__in,__cfg_Local).__ENH_Business_Prox_1) __ENH_Business_Prox_1 := B_Business_Prox_1_Local.__ENH_Business_Prox_1;
  END;
  SHARED B_Business_Sele_Local := MODULE(B_Business_Sele(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_1(__in,__cfg_Local).__ENH_Address_1) __ENH_Address_1 := B_Address_1_Local.__ENH_Address_1;
    SHARED TYPEOF(B_Bankruptcy_1(__in,__cfg_Local).__ENH_Bankruptcy_1) __ENH_Bankruptcy_1 := B_Bankruptcy_1_Local.__ENH_Bankruptcy_1;
    SHARED TYPEOF(B_Business_Sele_1(__in,__cfg_Local).__ENH_Business_Sele_1) __ENH_Business_Sele_1 := B_Business_Sele_1_Local.__ENH_Business_Sele_1;
    SHARED TYPEOF(B_Input_B_I_I_1(__in,__cfg_Local).__ENH_Input_B_I_I_1) __ENH_Input_B_I_I_1 := B_Input_B_I_I_1_Local.__ENH_Input_B_I_I_1;
    SHARED TYPEOF(B_Sele_Address_1(__in,__cfg_Local).__ENH_Sele_Address_1) __ENH_Sele_Address_1 := B_Sele_Address_1_Local.__ENH_Sele_Address_1;
    SHARED TYPEOF(E_Sele_Aircraft(__in,__cfg_Local).__Result) __E_Sele_Aircraft := E_Sele_Aircraft_Filtered.__Result;
    SHARED TYPEOF(E_Sele_Bankruptcy(__in,__cfg_Local).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Person_1(__in,__cfg_Local).__ENH_Sele_Person_1) __ENH_Sele_Person_1 := B_Sele_Person_1_Local.__ENH_Sele_Person_1;
    SHARED TYPEOF(B_Sele_Property_1(__in,__cfg_Local).__ENH_Sele_Property_1) __ENH_Sele_Property_1 := B_Sele_Property_1_Local.__ENH_Sele_Property_1;
    SHARED TYPEOF(B_Sele_Tradeline_1(__in,__cfg_Local).__ENH_Sele_Tradeline_1) __ENH_Sele_Tradeline_1 := B_Sele_Tradeline_1_Local.__ENH_Sele_Tradeline_1;
    SHARED TYPEOF(B_Sele_Vehicle_1(__in,__cfg_Local).__ENH_Sele_Vehicle_1) __ENH_Sele_Vehicle_1 := B_Sele_Vehicle_1_Local.__ENH_Sele_Vehicle_1;
    SHARED TYPEOF(E_Sele_Watercraft(__in,__cfg_Local).__Result) __E_Sele_Watercraft := E_Sele_Watercraft_Filtered.__Result;
    SHARED TYPEOF(B_Tradeline_1(__in,__cfg_Local).__ENH_Tradeline_1) __ENH_Tradeline_1 := B_Tradeline_1_Local.__ENH_Tradeline_1;
    SHARED TYPEOF(E_Vehicle(__in,__cfg_Local).__Result) __E_Vehicle := E_Vehicle_Filtered.__Result;
    SHARED TYPEOF(E_Zip_Code(__in,__cfg_Local).__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
  END;
  SHARED B_Criminal_Offense_Local := MODULE(B_Criminal_Offense(__in,__cfg_Local))
    SHARED TYPEOF(B_Criminal_Offense_1(__in,__cfg_Local).__ENH_Criminal_Offense_1) __ENH_Criminal_Offense_1 := B_Criminal_Offense_1_Local.__ENH_Criminal_Offense_1;
  END;
  SHARED B_Education_Local := MODULE(B_Education(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_1(__in,__cfg_Local).__ENH_Education_1) __ENH_Education_1 := B_Education_1_Local.__ENH_Education_1;
  END;
  SHARED B_Email_Local := MODULE(B_Email(__in,__cfg_Local))
    SHARED TYPEOF(B_Email_1(__in,__cfg_Local).__ENH_Email_1) __ENH_Email_1 := B_Email_1_Local.__ENH_Email_1;
  END;
  SHARED B_First_Degree_Relative_Local := MODULE(B_First_Degree_Relative(__in,__cfg_Local))
    SHARED TYPEOF(B_First_Degree_Relative_1(__in,__cfg_Local).__ENH_First_Degree_Relative_1) __ENH_First_Degree_Relative_1 := B_First_Degree_Relative_1_Local.__ENH_First_Degree_Relative_1;
  END;
  SHARED B_Lien_Judgment_Local := MODULE(B_Lien_Judgment(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_1(__in,__cfg_Local).__ENH_Lien_Judgment_1) __ENH_Lien_Judgment_1 := B_Lien_Judgment_1_Local.__ENH_Lien_Judgment_1;
  END;
  SHARED B_Person_Local := MODULE(B_Person(__in,__cfg_Local))
    SHARED TYPEOF(B_Aircraft_Owner_1(__in,__cfg_Local).__ENH_Aircraft_Owner_1) __ENH_Aircraft_Owner_1 := B_Aircraft_Owner_1_Local.__ENH_Aircraft_Owner_1;
    SHARED TYPEOF(B_Bankruptcy_1(__in,__cfg_Local).__ENH_Bankruptcy_1) __ENH_Bankruptcy_1 := B_Bankruptcy_1_Local.__ENH_Bankruptcy_1;
    SHARED TYPEOF(B_Criminal_Offense_1(__in,__cfg_Local).__ENH_Criminal_Offense_1) __ENH_Criminal_Offense_1 := B_Criminal_Offense_1_Local.__ENH_Criminal_Offense_1;
    SHARED TYPEOF(B_Education_1(__in,__cfg_Local).__ENH_Education_1) __ENH_Education_1 := B_Education_1_Local.__ENH_Education_1;
    SHARED TYPEOF(B_Person_1(__in,__cfg_Local).__ENH_Person_1) __ENH_Person_1 := B_Person_1_Local.__ENH_Person_1;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(E_Person_Education(__in,__cfg_Local).__Result) __E_Person_Education := E_Person_Education_Filtered.__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg_Local).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
    SHARED TYPEOF(B_Person_S_S_N_1(__in,__cfg_Local).__ENH_Person_S_S_N_1) __ENH_Person_S_S_N_1 := B_Person_S_S_N_1_Local.__ENH_Person_S_S_N_1;
    SHARED TYPEOF(B_Person_Vehicle_1(__in,__cfg_Local).__ENH_Person_Vehicle_1) __ENH_Person_Vehicle_1 := B_Person_Vehicle_1_Local.__ENH_Person_Vehicle_1;
    SHARED TYPEOF(B_Professional_License_1(__in,__cfg_Local).__ENH_Professional_License_1) __ENH_Professional_License_1 := B_Professional_License_1_Local.__ENH_Professional_License_1;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg_Local).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered.__Result;
    SHARED TYPEOF(B_Watercraft_Owner_1(__in,__cfg_Local).__ENH_Watercraft_Owner_1) __ENH_Watercraft_Owner_1 := B_Watercraft_Owner_1_Local.__ENH_Watercraft_Owner_1;
  END;
  SHARED B_Professional_License_Local := MODULE(B_Professional_License(__in,__cfg_Local))
    SHARED TYPEOF(B_Professional_License_1(__in,__cfg_Local).__ENH_Professional_License_1) __ENH_Professional_License_1 := B_Professional_License_1_Local.__ENH_Professional_License_1;
  END;
  SHARED B_Property_Local := MODULE(B_Property(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_1(__in,__cfg_Local).__ENH_Property_1) __ENH_Property_1 := B_Property_1_Local.__ENH_Property_1;
  END;
  SHARED B_Property_Event_Local := MODULE(B_Property_Event(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_1(__in,__cfg_Local).__ENH_Property_Event_1) __ENH_Property_Event_1 := B_Property_Event_1_Local.__ENH_Property_Event_1;
  END;
  SHARED B_Second_Degree_Associations_Local := MODULE(B_Second_Degree_Associations(__in,__cfg_Local))
    SHARED TYPEOF(E_First_Degree_Associations(__in,__cfg_Local).__Result) __E_First_Degree_Associations := E_First_Degree_Associations_Filtered.__Result;
  END;
  SHARED B_Tradeline_Local := MODULE(B_Tradeline(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_1(__in,__cfg_Local).__ENH_Tradeline_1) __ENH_Tradeline_1 := B_Tradeline_1_Local.__ENH_Tradeline_1;
  END;
  SHARED B_U_C_C_Local := MODULE(B_U_C_C(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_1(__in,__cfg_Local).__ENH_U_C_C_1) __ENH_U_C_C_1 := B_U_C_C_1_Local.__ENH_U_C_C_1;
  END;
  SHARED TYPEOF(E_Accident(__in,__cfg_Local).__Result) __E_Accident := E_Accident_Filtered.__Result;
  SHARED TYPEOF(B_Address(__in,__cfg_Local).__ENH_Address) __ENH_Address := B_Address_Local.__ENH_Address;
  SHARED TYPEOF(E_Address(__in,__cfg_Local).__Result) __E_Address := E_Address_Filtered.__Result;
  SHARED TYPEOF(E_Address_Inquiry(__in,__cfg_Local).__Result) __E_Address_Inquiry := E_Address_Inquiry_Filtered.__Result;
  SHARED TYPEOF(E_Address_Phone(__in,__cfg_Local).__Result) __E_Address_Phone := E_Address_Phone_Filtered.__Result;
  SHARED TYPEOF(E_Address_Property(__in,__cfg_Local).__Result) __E_Address_Property := E_Address_Property_Filtered.__Result;
  SHARED TYPEOF(E_Address_Property_Event(__in,__cfg_Local).__Result) __E_Address_Property_Event := E_Address_Property_Event_Filtered.__Result;
  SHARED TYPEOF(E_Aircraft(__in,__cfg_Local).__Result) __E_Aircraft := E_Aircraft_Filtered.__Result;
  SHARED TYPEOF(E_Aircraft_Owner(__in,__cfg_Local).__Result) __E_Aircraft_Owner := E_Aircraft_Owner_Filtered.__Result;
  SHARED TYPEOF(B_Bankruptcy(__in,__cfg_Local).__ENH_Bankruptcy) __ENH_Bankruptcy := B_Bankruptcy_Local.__ENH_Bankruptcy;
  SHARED TYPEOF(E_Bankruptcy(__in,__cfg_Local).__Result) __E_Bankruptcy := E_Bankruptcy_Filtered.__Result;
  SHARED TYPEOF(B_Business_Prox(__in,__cfg_Local).__ENH_Business_Prox) __ENH_Business_Prox := B_Business_Prox_Local.__ENH_Business_Prox;
  SHARED TYPEOF(E_Business_Prox(__in,__cfg_Local).__Result) __E_Business_Prox := E_Business_Prox_Filtered.__Result;
  SHARED TYPEOF(B_Business_Sele(__in,__cfg_Local).__ENH_Business_Sele) __ENH_Business_Sele := B_Business_Sele_Local.__ENH_Business_Sele;
  SHARED TYPEOF(E_Business_Sele(__in,__cfg_Local).__Result) __E_Business_Sele := E_Business_Sele_Filtered.__Result;
  SHARED TYPEOF(E_Criminal_Details(__in,__cfg_Local).__Result) __E_Criminal_Details := E_Criminal_Details_Filtered.__Result;
  SHARED TYPEOF(E_Criminal_Offender(__in,__cfg_Local).__Result) __E_Criminal_Offender := E_Criminal_Offender_Filtered.__Result;
  SHARED TYPEOF(B_Criminal_Offense(__in,__cfg_Local).__ENH_Criminal_Offense) __ENH_Criminal_Offense := B_Criminal_Offense_Local.__ENH_Criminal_Offense;
  SHARED TYPEOF(E_Criminal_Offense(__in,__cfg_Local).__Result) __E_Criminal_Offense := E_Criminal_Offense_Filtered.__Result;
  SHARED TYPEOF(E_Criminal_Punishment(__in,__cfg_Local).__Result) __E_Criminal_Punishment := E_Criminal_Punishment_Filtered.__Result;
  SHARED TYPEOF(E_Drivers_License(__in,__cfg_Local).__Result) __E_Drivers_License := E_Drivers_License_Filtered.__Result;
  SHARED TYPEOF(E_E_B_R_Tradeline(__in,__cfg_Local).__Result) __E_E_B_R_Tradeline := E_E_B_R_Tradeline_Filtered.__Result;
  SHARED TYPEOF(B_Education(__in,__cfg_Local).__ENH_Education) __ENH_Education := B_Education_Local.__ENH_Education;
  SHARED TYPEOF(E_Education(__in,__cfg_Local).__Result) __E_Education := E_Education_Filtered.__Result;
  SHARED TYPEOF(B_Email(__in,__cfg_Local).__ENH_Email) __ENH_Email := B_Email_Local.__ENH_Email;
  SHARED TYPEOF(E_Email(__in,__cfg_Local).__Result) __E_Email := E_Email_Filtered.__Result;
  SHARED TYPEOF(E_Email_Inquiry(__in,__cfg_Local).__Result) __E_Email_Inquiry := E_Email_Inquiry_Filtered.__Result;
  SHARED TYPEOF(E_First_Degree_Associations(__in,__cfg_Local).__Result) __E_First_Degree_Associations := E_First_Degree_Associations_Filtered.__Result;
  SHARED TYPEOF(B_First_Degree_Relative(__in,__cfg_Local).__ENH_First_Degree_Relative) __ENH_First_Degree_Relative := B_First_Degree_Relative_Local.__ENH_First_Degree_Relative;
  SHARED TYPEOF(E_First_Degree_Relative(__in,__cfg_Local).__Result) __E_First_Degree_Relative := E_First_Degree_Relative_Filtered.__Result;
  SHARED TYPEOF(E_House_Hold_Phone(__in,__cfg_Local).__Result) __E_House_Hold_Phone := E_House_Hold_Phone_Filtered.__Result;
  SHARED TYPEOF(E_Household(__in,__cfg_Local).__Result) __E_Household := E_Household_Filtered.__Result;
  SHARED TYPEOF(E_Household_Member(__in,__cfg_Local).__Result) __E_Household_Member := E_Household_Member_Filtered.__Result;
  SHARED TYPEOF(E_Inquiry(__in,__cfg_Local).__Result) __E_Inquiry := E_Inquiry_Filtered.__Result;
  SHARED TYPEOF(B_Lien_Judgment(__in,__cfg_Local).__ENH_Lien_Judgment) __ENH_Lien_Judgment := B_Lien_Judgment_Local.__ENH_Lien_Judgment;
  SHARED TYPEOF(E_Lien_Judgment(__in,__cfg_Local).__Result) __E_Lien_Judgment := E_Lien_Judgment_Filtered.__Result;
  SHARED TYPEOF(B_Person(__in,__cfg_Local).__ENH_Person) __ENH_Person := B_Person_Local.__ENH_Person;
  SHARED TYPEOF(E_Person(__in,__cfg_Local).__Result) __E_Person := E_Person_Filtered.__Result;
  SHARED TYPEOF(E_Person_Accident(__in,__cfg_Local).__Result) __E_Person_Accident := E_Person_Accident_Filtered.__Result;
  SHARED TYPEOF(E_Person_Address(__in,__cfg_Local).__Result) __E_Person_Address := E_Person_Address_Filtered.__Result;
  SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
  SHARED TYPEOF(E_Person_Drivers_License(__in,__cfg_Local).__Result) __E_Person_Drivers_License := E_Person_Drivers_License_Filtered.__Result;
  SHARED TYPEOF(E_Person_Education(__in,__cfg_Local).__Result) __E_Person_Education := E_Person_Education_Filtered.__Result;
  SHARED TYPEOF(E_Person_Email(__in,__cfg_Local).__Result) __E_Person_Email := E_Person_Email_Filtered.__Result;
  SHARED TYPEOF(E_Person_Email_Phone_Address(__in,__cfg_Local).__Result) __E_Person_Email_Phone_Address := E_Person_Email_Phone_Address_Filtered.__Result;
  SHARED TYPEOF(E_Person_Inquiry(__in,__cfg_Local).__Result) __E_Person_Inquiry := E_Person_Inquiry_Filtered.__Result;
  SHARED TYPEOF(E_Person_Lien_Judgment(__in,__cfg_Local).__Result) __E_Person_Lien_Judgment := E_Person_Lien_Judgment_Filtered.__Result;
  SHARED TYPEOF(E_Person_Offender(__in,__cfg_Local).__Result) __E_Person_Offender := E_Person_Offender_Filtered.__Result;
  SHARED TYPEOF(E_Person_Offenses(__in,__cfg_Local).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
  SHARED TYPEOF(E_Person_Phone(__in,__cfg_Local).__Result) __E_Person_Phone := E_Person_Phone_Filtered.__Result;
  SHARED TYPEOF(E_Person_Property(__in,__cfg_Local).__Result) __E_Person_Property := E_Person_Property_Filtered.__Result;
  SHARED TYPEOF(E_Person_Property_Event(__in,__cfg_Local).__Result) __E_Person_Property_Event := E_Person_Property_Event_Filtered.__Result;
  SHARED TYPEOF(E_Person_S_S_N(__in,__cfg_Local).__Result) __E_Person_S_S_N := E_Person_S_S_N_Filtered.__Result;
  SHARED TYPEOF(E_Person_Vehicle(__in,__cfg_Local).__Result) __E_Person_Vehicle := E_Person_Vehicle_Filtered.__Result;
  SHARED TYPEOF(E_Phone(__in,__cfg_Local).__Result) __E_Phone := E_Phone_Filtered.__Result;
  SHARED TYPEOF(E_Phone_Inquiry(__in,__cfg_Local).__Result) __E_Phone_Inquiry := E_Phone_Inquiry_Filtered.__Result;
  SHARED TYPEOF(B_Professional_License(__in,__cfg_Local).__ENH_Professional_License) __ENH_Professional_License := B_Professional_License_Local.__ENH_Professional_License;
  SHARED TYPEOF(E_Professional_License(__in,__cfg_Local).__Result) __E_Professional_License := E_Professional_License_Filtered.__Result;
  SHARED TYPEOF(E_Professional_License_Person(__in,__cfg_Local).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered.__Result;
  SHARED TYPEOF(B_Property(__in,__cfg_Local).__ENH_Property) __ENH_Property := B_Property_Local.__ENH_Property;
  SHARED TYPEOF(E_Property(__in,__cfg_Local).__Result) __E_Property := E_Property_Filtered.__Result;
  SHARED TYPEOF(B_Property_Event(__in,__cfg_Local).__ENH_Property_Event) __ENH_Property_Event := B_Property_Event_Local.__ENH_Property_Event;
  SHARED TYPEOF(E_Property_Event(__in,__cfg_Local).__Result) __E_Property_Event := E_Property_Event_Filtered.__Result;
  SHARED TYPEOF(E_Prox_Address(__in,__cfg_Local).__Result) __E_Prox_Address := E_Prox_Address_Filtered.__Result;
  SHARED TYPEOF(E_Prox_Email(__in,__cfg_Local).__Result) __E_Prox_Email := E_Prox_Email_Filtered.__Result;
  SHARED TYPEOF(E_Prox_Person(__in,__cfg_Local).__Result) __E_Prox_Person := E_Prox_Person_Filtered.__Result;
  SHARED TYPEOF(E_Prox_Phone_Number(__in,__cfg_Local).__Result) __E_Prox_Phone_Number := E_Prox_Phone_Number_Filtered.__Result;
  SHARED TYPEOF(E_Prox_T_I_N(__in,__cfg_Local).__Result) __E_Prox_T_I_N := E_Prox_T_I_N_Filtered.__Result;
  SHARED TYPEOF(E_Prox_Utility(__in,__cfg_Local).__Result) __E_Prox_Utility := E_Prox_Utility_Filtered.__Result;
  SHARED TYPEOF(E_S_S_N_Address(__in,__cfg_Local).__Result) __E_S_S_N_Address := E_S_S_N_Address_Filtered.__Result;
  SHARED TYPEOF(E_S_S_N_Inquiry(__in,__cfg_Local).__Result) __E_S_S_N_Inquiry := E_S_S_N_Inquiry_Filtered.__Result;
  SHARED TYPEOF(B_Second_Degree_Associations(__in,__cfg_Local).__ENH_Second_Degree_Associations) __ENH_Second_Degree_Associations := B_Second_Degree_Associations_Local.__ENH_Second_Degree_Associations;
  SHARED TYPEOF(E_Second_Degree_Associations(__in,__cfg_Local).__Result) __E_Second_Degree_Associations := E_Second_Degree_Associations_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Address(__in,__cfg_Local).__Result) __E_Sele_Address := E_Sele_Address_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Aircraft(__in,__cfg_Local).__Result) __E_Sele_Aircraft := E_Sele_Aircraft_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Bankruptcy(__in,__cfg_Local).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered.__Result;
  SHARED TYPEOF(E_Sele_E_B_R_Tradeline(__in,__cfg_Local).__Result) __E_Sele_E_B_R_Tradeline := E_Sele_E_B_R_Tradeline_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Email(__in,__cfg_Local).__Result) __E_Sele_Email := E_Sele_Email_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Inquiry(__in,__cfg_Local).__Result) __E_Sele_Inquiry := E_Sele_Inquiry_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Lien_Judgment(__in,__cfg_Local).__Result) __E_Sele_Lien_Judgment := E_Sele_Lien_Judgment_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Person(__in,__cfg_Local).__Result) __E_Sele_Person := E_Sele_Person_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Phone_Number(__in,__cfg_Local).__Result) __E_Sele_Phone_Number := E_Sele_Phone_Number_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Property(__in,__cfg_Local).__Result) __E_Sele_Property := E_Sele_Property_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Property_Event(__in,__cfg_Local).__Result) __E_Sele_Property_Event := E_Sele_Property_Event_Filtered.__Result;
  SHARED TYPEOF(E_Sele_T_I_N(__in,__cfg_Local).__Result) __E_Sele_T_I_N := E_Sele_T_I_N_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg_Local).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered.__Result;
  SHARED TYPEOF(E_Sele_U_C_C(__in,__cfg_Local).__Result) __E_Sele_U_C_C := E_Sele_U_C_C_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Utility(__in,__cfg_Local).__Result) __E_Sele_Utility := E_Sele_Utility_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Vehicle(__in,__cfg_Local).__Result) __E_Sele_Vehicle := E_Sele_Vehicle_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Watercraft(__in,__cfg_Local).__Result) __E_Sele_Watercraft := E_Sele_Watercraft_Filtered.__Result;
  SHARED TYPEOF(E_Social_Security_Number(__in,__cfg_Local).__Result) __E_Social_Security_Number := E_Social_Security_Number_Filtered.__Result;
  SHARED TYPEOF(E_T_I_N(__in,__cfg_Local).__Result) __E_T_I_N := E_T_I_N_Filtered.__Result;
  SHARED TYPEOF(E_T_I_N_Address(__in,__cfg_Local).__Result) __E_T_I_N_Address := E_T_I_N_Address_Filtered.__Result;
  SHARED TYPEOF(E_T_I_N_Inquiry(__in,__cfg_Local).__Result) __E_T_I_N_Inquiry := E_T_I_N_Inquiry_Filtered.__Result;
  SHARED TYPEOF(E_T_I_N_Phone_Number(__in,__cfg_Local).__Result) __E_T_I_N_Phone_Number := E_T_I_N_Phone_Number_Filtered.__Result;
  SHARED TYPEOF(B_Tradeline(__in,__cfg_Local).__ENH_Tradeline) __ENH_Tradeline := B_Tradeline_Local.__ENH_Tradeline;
  SHARED TYPEOF(E_Tradeline(__in,__cfg_Local).__Result) __E_Tradeline := E_Tradeline_Filtered.__Result;
  SHARED TYPEOF(B_U_C_C(__in,__cfg_Local).__ENH_U_C_C) __ENH_U_C_C := B_U_C_C_Local.__ENH_U_C_C;
  SHARED TYPEOF(E_U_C_C(__in,__cfg_Local).__Result) __E_U_C_C := E_U_C_C_Filtered.__Result;
  SHARED TYPEOF(E_Utility(__in,__cfg_Local).__Result) __E_Utility := E_Utility_Filtered.__Result;
  SHARED TYPEOF(E_Utility_Address(__in,__cfg_Local).__Result) __E_Utility_Address := E_Utility_Address_Filtered.__Result;
  SHARED TYPEOF(E_Utility_Person(__in,__cfg_Local).__Result) __E_Utility_Person := E_Utility_Person_Filtered.__Result;
  SHARED TYPEOF(E_Vehicle(__in,__cfg_Local).__Result) __E_Vehicle := E_Vehicle_Filtered.__Result;
  SHARED TYPEOF(E_Watercraft(__in,__cfg_Local).__Result) __E_Watercraft := E_Watercraft_Filtered.__Result;
  SHARED TYPEOF(E_Watercraft_Owner(__in,__cfg_Local).__Result) __E_Watercraft_Owner := E_Watercraft_Owner_Filtered.__Result;
  SHARED TYPEOF(E_Zip_Code(__in,__cfg_Local).__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
  SHARED TYPEOF(E_Zip_Code_Person(__in,__cfg_Local).__Result) __E_Zip_Code_Person := E_Zip_Code_Person_Filtered.__Result;
  SHARED __EE3458773 := __E_Inquiry;
  SHARED __EE3458763 := __E_Address_Inquiry;
  SHARED __EE6215095 := __EE3458763(__NN(__EE3458763.Location_) AND __NN(__EE3458763.Transaction_));
  SHARED __EE3458757 := __E_Address;
  SHARED __EE6215201 := __EE3458757(__T(__OP2(__EE3458757.UID,=,__CN(__PAddressUID))));
  __JC6215207(E_Address_Inquiry(__in,__cfg_Local).Layout __EE6215095, E_Address(__in,__cfg_Local).Layout __EE6215201) := __EEQP(__EE6215201.UID,__EE6215095.Location_);
  SHARED __EE6215223 := JOIN(__EE6215095,__EE6215201,__JC6215207(LEFT,RIGHT),TRANSFORM(E_Address_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6215229(E_Inquiry(__in,__cfg_Local).Layout __EE3458773, E_Address_Inquiry(__in,__cfg_Local).Layout __EE6215223) := __EEQP(__EE6215223.Transaction_,__EE3458773.UID);
  SHARED __EE6215289 := JOIN(__EE3458773,__EE6215223,__JC6215229(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6215291 := __EE6215289;
  EXPORT Res0 := __UNWRAP(__EE6215291);
  SHARED __EE3458931 := __E_Phone;
  SHARED __EE3458921 := __E_Address_Phone;
  SHARED __EE6215577 := __EE3458921(__NN(__EE3458921.Location_) AND __NN(__EE3458921.Phone_Number_));
  SHARED __EE3458915 := __E_Address;
  SHARED __EE6215688 := __EE3458915(__T(__OP2(__EE3458915.UID,=,__CN(__PAddressUID))));
  __JC6215694(E_Address_Phone(__in,__cfg_Local).Layout __EE6215577, E_Address(__in,__cfg_Local).Layout __EE6215688) := __EEQP(__EE6215688.UID,__EE6215577.Location_);
  SHARED __EE6215722 := JOIN(__EE6215577,__EE6215688,__JC6215694(LEFT,RIGHT),TRANSFORM(E_Address_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6215728(E_Phone(__in,__cfg_Local).Layout __EE3458931, E_Address_Phone(__in,__cfg_Local).Layout __EE6215722) := __EEQP(__EE6215722.Phone_Number_,__EE3458931.UID);
  SHARED __EE6215781 := JOIN(__EE3458931,__EE6215722,__JC6215728(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6215783 := __EE6215781;
  EXPORT Res1 := __UNWRAP(__EE6215783);
  SHARED __EE6215944 := __ENH_Property;
  SHARED __EE3459088 := __E_Address_Property;
  SHARED __EE6216106 := __EE3459088(__NN(__EE3459088.Location_) AND __NN(__EE3459088.Prop_));
  SHARED __EE3459082 := __E_Address;
  SHARED __EE6216197 := __EE3459082(__T(__OP2(__EE3459082.UID,=,__CN(__PAddressUID))));
  __JC6216203(E_Address_Property(__in,__cfg_Local).Layout __EE6216106, E_Address(__in,__cfg_Local).Layout __EE6216197) := __EEQP(__EE6216197.UID,__EE6216106.Location_);
  SHARED __EE6216227 := JOIN(__EE6216106,__EE6216197,__JC6216203(LEFT,RIGHT),TRANSFORM(E_Address_Property(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6216233(B_Property(__in,__cfg_Local).__ST132820_Layout __EE6215944, E_Address_Property(__in,__cfg_Local).Layout __EE6216227) := __EEQP(__EE6216227.Prop_,__EE6215944.UID);
  SHARED __EE6216270 := JOIN(__EE6215944,__EE6216227,__JC6216233(LEFT,RIGHT),TRANSFORM(B_Property(__in,__cfg_Local).__ST132820_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6216272 := __EE6216270;
  EXPORT Res2 := __UNWRAP(__EE6216272);
  SHARED __EE6216393 := __ENH_Property_Event;
  SHARED __EE3459231 := __E_Address_Property_Event;
  SHARED __EE6216613 := __EE3459231(__NN(__EE3459231.Location_) AND __NN(__EE3459231.Event_));
  SHARED __EE3459225 := __E_Address;
  SHARED __EE6216732 := __EE3459225(__T(__OP2(__EE3459225.UID,=,__CN(__PAddressUID))));
  __JC6216738(E_Address_Property_Event(__in,__cfg_Local).Layout __EE6216613, E_Address(__in,__cfg_Local).Layout __EE6216732) := __EEQP(__EE6216732.UID,__EE6216613.Location_);
  SHARED __EE6216760 := JOIN(__EE6216613,__EE6216732,__JC6216738(LEFT,RIGHT),TRANSFORM(E_Address_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6216766(B_Property_Event_4(__in,__cfg_Local).__ST191134_Layout __EE6216393, E_Address_Property_Event(__in,__cfg_Local).Layout __EE6216760) := __EEQP(__EE6216760.Event_,__EE6216393.UID);
  SHARED __EE6216833 := JOIN(__EE6216393,__EE6216760,__JC6216766(LEFT,RIGHT),TRANSFORM(B_Property_Event_4(__in,__cfg_Local).__ST191134_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6216835 := __EE6216833;
  EXPORT Res3 := __UNWRAP(__EE6216835);
  SHARED __EE6217012 := __ENH_Person;
  SHARED __EE3459399 := __E_Person_Address;
  SHARED __EE6219053 := __EE3459399(__NN(__EE3459399.Location_) AND __NN(__EE3459399.Subject_));
  SHARED __EE3459393 := __E_Address;
  SHARED __EE6220096 := __EE3459393(__T(__OP2(__EE3459393.UID,=,__CN(__PAddressUID))));
  __JC6220102(E_Person_Address(__in,__cfg_Local).Layout __EE6219053, E_Address(__in,__cfg_Local).Layout __EE6220096) := __EEQP(__EE6220096.UID,__EE6219053.Location_);
  SHARED __EE6220151 := JOIN(__EE6219053,__EE6220096,__JC6220102(LEFT,RIGHT),TRANSFORM(E_Person_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6220157(B_Person(__in,__cfg_Local).__ST131971_Layout __EE6217012, E_Person_Address(__in,__cfg_Local).Layout __EE6220151) := __EEQP(__EE6220151.Subject_,__EE6217012.UID);
  SHARED __EE6221121 := JOIN(__EE6217012,__EE6220151,__JC6220157(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST131971_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6221123 := __EE6221121;
  EXPORT Res4 := __UNWRAP(__EE6221123);
  SHARED __EE6223148 := __ENH_Business_Prox;
  SHARED __EE3460563 := __E_Prox_Address;
  SHARED __EE6223788 := __EE3460563(__NN(__EE3460563.Location_) AND __NN(__EE3460563.Business_Location_));
  SHARED __EE3460557 := __E_Address;
  SHARED __EE6224134 := __EE3460557(__T(__OP2(__EE3460557.UID,=,__CN(__PAddressUID))));
  __JC6224140(E_Prox_Address(__in,__cfg_Local).Layout __EE6223788, E_Address(__in,__cfg_Local).Layout __EE6224134) := __EEQP(__EE6224134.UID,__EE6223788.Location_);
  SHARED __EE6224196 := JOIN(__EE6223788,__EE6224134,__JC6224140(LEFT,RIGHT),TRANSFORM(E_Prox_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6224202(B_Business_Prox(__in,__cfg_Local).__ST100100_Layout __EE6223148, E_Prox_Address(__in,__cfg_Local).Layout __EE6224196) := __EEQP(__EE6224196.Business_Location_,__EE6223148.UID);
  SHARED __EE6224462 := JOIN(__EE6223148,__EE6224196,__JC6224202(LEFT,RIGHT),TRANSFORM(B_Business_Prox(__in,__cfg_Local).__ST100100_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6224464 := __EE6224462;
  EXPORT Res5 := __UNWRAP(__EE6224464);
  SHARED __EE6225095 := __ENH_Business_Sele;
  SHARED __EE3460988 := __E_Sele_Address;
  SHARED __EE6228241 := __EE3460988(__NN(__EE3460988.Location_) AND __NN(__EE3460988.Legal_));
  SHARED __EE3460982 := __E_Address;
  SHARED __EE6229840 := __EE3460982(__T(__OP2(__EE3460982.UID,=,__CN(__PAddressUID))));
  __JC6229846(E_Sele_Address(__in,__cfg_Local).Layout __EE6228241, E_Address(__in,__cfg_Local).Layout __EE6229840) := __EEQP(__EE6229840.UID,__EE6228241.Location_);
  SHARED __EE6229902 := JOIN(__EE6228241,__EE6229840,__JC6229846(LEFT,RIGHT),TRANSFORM(E_Sele_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6229908(B_Business_Sele(__in,__cfg_Local).__ST118126_Layout __EE6225095, E_Sele_Address(__in,__cfg_Local).Layout __EE6229902) := __EEQP(__EE6229902.Legal_,__EE6225095.UID);
  SHARED __EE6231421 := JOIN(__EE6225095,__EE6229902,__JC6229908(LEFT,RIGHT),TRANSFORM(B_Business_Sele(__in,__cfg_Local).__ST118126_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6231423 := __EE6231421;
  EXPORT Res6 := __UNWRAP(__EE6231423);
  SHARED __EE3462753 := __E_T_I_N;
  SHARED __EE3462743 := __E_T_I_N_Address;
  SHARED __EE6234633 := __EE3462743(__NN(__EE3462743.Location_) AND __NN(__EE3462743.Tax_I_D_));
  SHARED __EE3462737 := __E_Address;
  SHARED __EE6234682 := __EE3462737(__T(__OP2(__EE3462737.UID,=,__CN(__PAddressUID))));
  __JC6234688(E_T_I_N_Address(__in,__cfg_Local).Layout __EE6234633, E_Address(__in,__cfg_Local).Layout __EE6234682) := __EEQP(__EE6234682.UID,__EE6234633.Location_);
  SHARED __EE6234703 := JOIN(__EE6234633,__EE6234682,__JC6234688(LEFT,RIGHT),TRANSFORM(E_T_I_N_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6234709(E_T_I_N(__in,__cfg_Local).Layout __EE3462753, E_T_I_N_Address(__in,__cfg_Local).Layout __EE6234703) := __EEQP(__EE6234703.Tax_I_D_,__EE3462753.UID);
  SHARED __EE6234713 := JOIN(__EE3462753,__EE6234703,__JC6234709(LEFT,RIGHT),TRANSFORM(E_T_I_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6234715 := __EE6234713;
  EXPORT Res7 := __UNWRAP(__EE6234715);
  SHARED __EE3462848 := __E_Utility;
  SHARED __EE3462838 := __E_Utility_Address;
  SHARED __EE6234846 := __EE3462838(__NN(__EE3462838.Location_) AND __NN(__EE3462838.Util_));
  SHARED __EE3462832 := __E_Address;
  SHARED __EE6234916 := __EE3462832(__T(__OP2(__EE3462832.UID,=,__CN(__PAddressUID))));
  __JC6234922(E_Utility_Address(__in,__cfg_Local).Layout __EE6234846, E_Address(__in,__cfg_Local).Layout __EE6234916) := __EEQP(__EE6234916.UID,__EE6234846.Location_);
  SHARED __EE6234936 := JOIN(__EE6234846,__EE6234916,__JC6234922(LEFT,RIGHT),TRANSFORM(E_Utility_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6234942(E_Utility(__in,__cfg_Local).Layout __EE3462848, E_Utility_Address(__in,__cfg_Local).Layout __EE6234936) := __EEQP(__EE6234936.Util_,__EE3462848.UID);
  SHARED __EE6234968 := JOIN(__EE3462848,__EE6234936,__JC6234942(LEFT,RIGHT),TRANSFORM(E_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6234970 := __EE6234968;
  EXPORT Res8 := __UNWRAP(__EE6234970);
  SHARED __EE6235049 := __ENH_Address;
  SHARED __EE3462956 := __E_Prox_Address;
  SHARED __EE6235559 := __EE3462956(__NN(__EE3462956.Business_Location_) AND __NN(__EE3462956.Location_));
  SHARED __EE6235052 := __ENH_Business_Prox;
  SHARED __EE6235803 := __EE6235052(__T(__OP2(__EE6235052.UID,=,__CN(__PBusinessProxUID))));
  __JC6235809(E_Prox_Address(__in,__cfg_Local).Layout __EE6235559, B_Business_Prox(__in,__cfg_Local).__ST100100_Layout __EE6235803) := __EEQP(__EE6235803.UID,__EE6235559.Business_Location_);
  SHARED __EE6235865 := JOIN(__EE6235559,__EE6235803,__JC6235809(LEFT,RIGHT),TRANSFORM(E_Prox_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6235871(B_Address_1(__in,__cfg_Local).__ST134443_Layout __EE6235049, E_Prox_Address(__in,__cfg_Local).Layout __EE6235865) := __EEQP(__EE6235865.Location_,__EE6235049.UID);
  SHARED __EE6236029 := JOIN(__EE6235049,__EE6235865,__JC6235871(LEFT,RIGHT),TRANSFORM(B_Address_1(__in,__cfg_Local).__ST134443_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6236031 := __EE6236029;
  EXPORT Res9 := __UNWRAP(__EE6236031);
  SHARED __EE6236458 := __ENH_Person;
  SHARED __EE3463278 := __E_Prox_Person;
  SHARED __EE6238524 := __EE3463278(__NN(__EE3463278.Business_Location_) AND __NN(__EE3463278.Contact_));
  SHARED __EE6236461 := __ENH_Business_Prox;
  SHARED __EE6239546 := __EE6236461(__T(__OP2(__EE6236461.UID,=,__CN(__PBusinessProxUID))));
  __JC6239552(E_Prox_Person(__in,__cfg_Local).Layout __EE6238524, B_Business_Prox(__in,__cfg_Local).__ST100100_Layout __EE6239546) := __EEQP(__EE6239546.UID,__EE6238524.Business_Location_);
  SHARED __EE6239580 := JOIN(__EE6238524,__EE6239546,__JC6239552(LEFT,RIGHT),TRANSFORM(E_Prox_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6239586(B_Person(__in,__cfg_Local).__ST131971_Layout __EE6236458, E_Prox_Person(__in,__cfg_Local).Layout __EE6239580) := __EEQP(__EE6239580.Contact_,__EE6236458.UID);
  SHARED __EE6240550 := JOIN(__EE6236458,__EE6239580,__JC6239586(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST131971_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6240552 := __EE6240550;
  EXPORT Res10 := __UNWRAP(__EE6240552);
  SHARED __EE3464430 := __E_Phone;
  SHARED __EE3464420 := __E_Prox_Phone_Number;
  SHARED __EE6242792 := __EE3464420(__NN(__EE3464420.Business_Location_) AND __NN(__EE3464420.Phone_Number_));
  SHARED __EE6242535 := __ENH_Business_Prox;
  SHARED __EE6242912 := __EE6242535(__T(__OP2(__EE6242535.UID,=,__CN(__PBusinessProxUID))));
  __JC6242918(E_Prox_Phone_Number(__in,__cfg_Local).Layout __EE6242792, B_Business_Prox(__in,__cfg_Local).__ST100100_Layout __EE6242912) := __EEQP(__EE6242912.UID,__EE6242792.Business_Location_);
  SHARED __EE6242955 := JOIN(__EE6242792,__EE6242912,__JC6242918(LEFT,RIGHT),TRANSFORM(E_Prox_Phone_Number(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6242961(E_Phone(__in,__cfg_Local).Layout __EE3464430, E_Prox_Phone_Number(__in,__cfg_Local).Layout __EE6242955) := __EEQP(__EE6242955.Phone_Number_,__EE3464430.UID);
  SHARED __EE6243014 := JOIN(__EE3464430,__EE6242955,__JC6242961(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6243016 := __EE6243014;
  EXPORT Res11 := __UNWRAP(__EE6243016);
  SHARED __EE3464609 := __E_T_I_N;
  SHARED __EE3464599 := __E_Prox_T_I_N;
  SHARED __EE6243308 := __EE3464599(__NN(__EE3464599.Business_Location_) AND __NN(__EE3464599.Tax_I_D_));
  SHARED __EE6243195 := __ENH_Business_Prox;
  SHARED __EE6243356 := __EE6243195(__T(__OP2(__EE6243195.UID,=,__CN(__PBusinessProxUID))));
  __JC6243362(E_Prox_T_I_N(__in,__cfg_Local).Layout __EE6243308, B_Business_Prox(__in,__cfg_Local).__ST100100_Layout __EE6243356) := __EEQP(__EE6243356.UID,__EE6243308.Business_Location_);
  SHARED __EE6243376 := JOIN(__EE6243308,__EE6243356,__JC6243362(LEFT,RIGHT),TRANSFORM(E_Prox_T_I_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6243382(E_T_I_N(__in,__cfg_Local).Layout __EE3464609, E_Prox_T_I_N(__in,__cfg_Local).Layout __EE6243376) := __EEQP(__EE6243376.Tax_I_D_,__EE3464609.UID);
  SHARED __EE6243386 := JOIN(__EE3464609,__EE6243376,__JC6243382(LEFT,RIGHT),TRANSFORM(E_T_I_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6243388 := __EE6243386;
  EXPORT Res12 := __UNWRAP(__EE6243388);
  SHARED __EE3464703 := __E_Utility;
  SHARED __EE3464693 := __E_Prox_Utility;
  SHARED __EE6243574 := __EE3464693(__NN(__EE3464693.Business_Location_) AND __NN(__EE3464693.Util_));
  SHARED __EE6243423 := __ENH_Business_Prox;
  SHARED __EE6243641 := __EE6243423(__T(__OP2(__EE6243423.UID,=,__CN(__PBusinessProxUID))));
  __JC6243647(E_Prox_Utility(__in,__cfg_Local).Layout __EE6243574, B_Business_Prox(__in,__cfg_Local).__ST100100_Layout __EE6243641) := __EEQP(__EE6243641.UID,__EE6243574.Business_Location_);
  SHARED __EE6243658 := JOIN(__EE6243574,__EE6243641,__JC6243647(LEFT,RIGHT),TRANSFORM(E_Prox_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6243664(E_Utility(__in,__cfg_Local).Layout __EE3464703, E_Prox_Utility(__in,__cfg_Local).Layout __EE6243658) := __EEQP(__EE6243658.Util_,__EE3464703.UID);
  SHARED __EE6243690 := JOIN(__EE3464703,__EE6243658,__JC6243664(LEFT,RIGHT),TRANSFORM(E_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6243692 := __EE6243690;
  EXPORT Res13 := __UNWRAP(__EE6243692);
  SHARED __EE6243765 := __ENH_Email;
  SHARED __EE3464809 := __E_Prox_Email;
  SHARED __EE6243957 := __EE3464809(__NN(__EE3464809.Business_Location_) AND __NN(__EE3464809.Email_));
  SHARED __EE6243768 := __ENH_Business_Prox;
  SHARED __EE6244042 := __EE6243768(__T(__OP2(__EE6243768.UID,=,__CN(__PBusinessProxUID))));
  __JC6244048(E_Prox_Email(__in,__cfg_Local).Layout __EE6243957, B_Business_Prox(__in,__cfg_Local).__ST100100_Layout __EE6244042) := __EEQP(__EE6244042.UID,__EE6243957.Business_Location_);
  SHARED __EE6244067 := JOIN(__EE6243957,__EE6244042,__JC6244048(LEFT,RIGHT),TRANSFORM(E_Prox_Email(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6244073(B_Email_2(__in,__cfg_Local).__ST165242_Layout __EE6243765, E_Prox_Email(__in,__cfg_Local).Layout __EE6244067) := __EEQP(__EE6244067.Email_,__EE6243765.UID);
  SHARED __EE6244109 := JOIN(__EE6243765,__EE6244067,__JC6244073(LEFT,RIGHT),TRANSFORM(B_Email_2(__in,__cfg_Local).__ST165242_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6244111 := __EE6244109;
  EXPORT Res14 := __UNWRAP(__EE6244111);
  SHARED __EE6244220 := __ENH_Business_Sele;
  SHARED __EE6244223 := __ENH_Business_Prox;
  SHARED __EE6248838 := __EE6244223(__T(__AND(__OP2(__EE6244223.UID,=,__CN(__PBusinessProxUID)),__CN(__NN(__EE6244223.Prox_Sele_)))));
  __JC6248844(B_Business_Sele(__in,__cfg_Local).__ST118126_Layout __EE6244220, B_Business_Prox(__in,__cfg_Local).__ST100100_Layout __EE6248838) := __EEQP(__EE6248838.Prox_Sele_,__EE6244220.UID);
  SHARED __EE6250357 := JOIN(__EE6244220,__EE6248838,__JC6248844(LEFT,RIGHT),TRANSFORM(B_Business_Sele(__in,__cfg_Local).__ST118126_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6250359 := __EE6250357;
  EXPORT Res15 := __UNWRAP(__EE6250359);
  SHARED __EE3466626 := __E_E_B_R_Tradeline;
  SHARED __EE3466616 := __E_Sele_E_B_R_Tradeline;
  SHARED __EE6253511 := __EE3466616(__NN(__EE3466616.Legal_) AND __NN(__EE3466616.Tradeline_));
  SHARED __EE6253386 := __ENH_Business_Sele;
  SHARED __EE6253566 := __EE6253386(__T(__OP2(__EE6253386.UID,=,__CN(__PBusinessSeleUID))));
  __JC6253572(E_Sele_E_B_R_Tradeline(__in,__cfg_Local).Layout __EE6253511, B_Business_Sele(__in,__cfg_Local).__ST118126_Layout __EE6253566) := __EEQP(__EE6253566.UID,__EE6253511.Legal_);
  SHARED __EE6253584 := JOIN(__EE6253511,__EE6253566,__JC6253572(LEFT,RIGHT),TRANSFORM(E_Sele_E_B_R_Tradeline(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6253590(E_E_B_R_Tradeline(__in,__cfg_Local).Layout __EE3466626, E_Sele_E_B_R_Tradeline(__in,__cfg_Local).Layout __EE6253584) := __EEQP(__EE6253584.Tradeline_,__EE3466626.UID);
  SHARED __EE6253603 := JOIN(__EE3466626,__EE6253584,__JC6253590(LEFT,RIGHT),TRANSFORM(E_E_B_R_Tradeline(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6253605 := __EE6253603;
  EXPORT Res16 := __UNWRAP(__EE6253605);
  SHARED __EE6253654 := __ENH_Email;
  SHARED __EE3466719 := __E_Sele_Email;
  SHARED __EE6253842 := __EE3466719(__NN(__EE3466719.Legal_) AND __NN(__EE3466719.Email_));
  SHARED __EE6253657 := __ENH_Business_Sele;
  SHARED __EE6253926 := __EE6253657(__T(__OP2(__EE6253657.UID,=,__CN(__PBusinessSeleUID))));
  __JC6253932(E_Sele_Email(__in,__cfg_Local).Layout __EE6253842, B_Business_Sele(__in,__cfg_Local).__ST118126_Layout __EE6253926) := __EEQP(__EE6253926.UID,__EE6253842.Legal_);
  SHARED __EE6253950 := JOIN(__EE6253842,__EE6253926,__JC6253932(LEFT,RIGHT),TRANSFORM(E_Sele_Email(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6253956(B_Email_2(__in,__cfg_Local).__ST165242_Layout __EE6253654, E_Sele_Email(__in,__cfg_Local).Layout __EE6253950) := __EEQP(__EE6253950.Email_,__EE6253654.UID);
  SHARED __EE6253992 := JOIN(__EE6253654,__EE6253950,__JC6253956(LEFT,RIGHT),TRANSFORM(B_Email_2(__in,__cfg_Local).__ST165242_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6253994 := __EE6253992;
  EXPORT Res17 := __UNWRAP(__EE6253994);
  SHARED __EE6254101 := __ENH_Address;
  SHARED __EE3466857 := __E_Sele_Address;
  SHARED __EE6254609 := __EE3466857(__NN(__EE3466857.Legal_) AND __NN(__EE3466857.Location_));
  SHARED __EE6254104 := __ENH_Business_Sele;
  SHARED __EE6254853 := __EE6254104(__T(__OP2(__EE6254104.UID,=,__CN(__PBusinessSeleUID))));
  __JC6254859(E_Sele_Address(__in,__cfg_Local).Layout __EE6254609, B_Business_Sele(__in,__cfg_Local).__ST118126_Layout __EE6254853) := __EEQP(__EE6254853.UID,__EE6254609.Legal_);
  SHARED __EE6254915 := JOIN(__EE6254609,__EE6254853,__JC6254859(LEFT,RIGHT),TRANSFORM(E_Sele_Address(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6254921(B_Address_1(__in,__cfg_Local).__ST134443_Layout __EE6254101, E_Sele_Address(__in,__cfg_Local).Layout __EE6254915) := __EEQP(__EE6254915.Location_,__EE6254101.UID);
  SHARED __EE6255079 := JOIN(__EE6254101,__EE6254915,__JC6254921(LEFT,RIGHT),TRANSFORM(B_Address_1(__in,__cfg_Local).__ST134443_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6255081 := __EE6255079;
  EXPORT Res18 := __UNWRAP(__EE6255081);
  SHARED __EE3467189 := __E_Aircraft;
  SHARED __EE3467179 := __E_Sele_Aircraft;
  SHARED __EE6255663 := __EE3467179(__NN(__EE3467179.Legal_) AND __NN(__EE3467179.Plane_));
  SHARED __EE6255508 := __ENH_Business_Sele;
  SHARED __EE6255733 := __EE6255508(__T(__OP2(__EE6255508.UID,=,__CN(__PBusinessSeleUID))));
  __JC6255739(E_Sele_Aircraft(__in,__cfg_Local).Layout __EE6255663, B_Business_Sele(__in,__cfg_Local).__ST118126_Layout __EE6255733) := __EEQP(__EE6255733.UID,__EE6255663.Legal_);
  SHARED __EE6255756 := JOIN(__EE6255663,__EE6255733,__JC6255739(LEFT,RIGHT),TRANSFORM(E_Sele_Aircraft(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6255762(E_Aircraft(__in,__cfg_Local).Layout __EE3467189, E_Sele_Aircraft(__in,__cfg_Local).Layout __EE6255756) := __EEQP(__EE6255756.Plane_,__EE3467189.UID);
  SHARED __EE6255785 := JOIN(__EE3467189,__EE6255756,__JC6255762(LEFT,RIGHT),TRANSFORM(E_Aircraft(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6255787 := __EE6255785;
  EXPORT Res19 := __UNWRAP(__EE6255787);
  SHARED __EE6255866 := __ENH_Bankruptcy;
  SHARED __EE3467299 := __E_Sele_Bankruptcy;
  SHARED __EE6256138 := __EE3467299(__NN(__EE3467299.Legal_) AND __NN(__EE3467299.Bankrupt_));
  SHARED __EE6255869 := __ENH_Business_Sele;
  SHARED __EE6256264 := __EE6255869(__T(__OP2(__EE6255869.UID,=,__CN(__PBusinessSeleUID))));
  __JC6256270(E_Sele_Bankruptcy(__in,__cfg_Local).Layout __EE6256138, B_Business_Sele(__in,__cfg_Local).__ST118126_Layout __EE6256264) := __EEQP(__EE6256264.UID,__EE6256138.Legal_);
  SHARED __EE6256280 := JOIN(__EE6256138,__EE6256264,__JC6256270(LEFT,RIGHT),TRANSFORM(E_Sele_Bankruptcy(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6256286(B_Bankruptcy(__in,__cfg_Local).__ST99617_Layout __EE6255866, E_Sele_Bankruptcy(__in,__cfg_Local).Layout __EE6256280) := __EEQP(__EE6256280.Bankrupt_,__EE6255866.UID);
  SHARED __EE6256372 := JOIN(__EE6255866,__EE6256280,__JC6256286(LEFT,RIGHT),TRANSFORM(B_Bankruptcy(__in,__cfg_Local).__ST99617_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6256374 := __EE6256372;
  EXPORT Res20 := __UNWRAP(__EE6256374);
  SHARED __EE6256565 := __ENH_Lien_Judgment;
  SHARED __EE3467476 := __E_Sele_Lien_Judgment;
  SHARED __EE6256755 := __EE3467476(__NN(__EE3467476.Sele_) AND __NN(__EE3467476.Lien_));
  SHARED __EE6256568 := __ENH_Business_Sele;
  SHARED __EE6256840 := __EE6256568(__T(__OP2(__EE6256568.UID,=,__CN(__PBusinessSeleUID))));
  __JC6256846(E_Sele_Lien_Judgment(__in,__cfg_Local).Layout __EE6256755, B_Business_Sele(__in,__cfg_Local).__ST118126_Layout __EE6256840) := __EEQP(__EE6256840.UID,__EE6256755.Sele_);
  SHARED __EE6256862 := JOIN(__EE6256755,__EE6256840,__JC6256846(LEFT,RIGHT),TRANSFORM(E_Sele_Lien_Judgment(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6256868(B_Lien_Judgment_12(__in,__cfg_Local).__ST209199_Layout __EE6256565, E_Sele_Lien_Judgment(__in,__cfg_Local).Layout __EE6256862) := __EEQP(__EE6256862.Lien_,__EE6256565.UID);
  SHARED __EE6256907 := JOIN(__EE6256565,__EE6256862,__JC6256868(LEFT,RIGHT),TRANSFORM(B_Lien_Judgment_12(__in,__cfg_Local).__ST209199_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6256909 := __EE6256907;
  EXPORT Res21 := __UNWRAP(__EE6256909);
  SHARED __EE6257018 := __ENH_Person;
  SHARED __EE3467612 := __E_Sele_Person;
  SHARED __EE6259088 := __EE3467612(__NN(__EE3467612.Legal_) AND __NN(__EE3467612.Contact_));
  SHARED __EE6257021 := __ENH_Business_Sele;
  SHARED __EE6260113 := __EE6257021(__T(__OP2(__EE6257021.UID,=,__CN(__PBusinessSeleUID))));
  __JC6260119(E_Sele_Person(__in,__cfg_Local).Layout __EE6259088, B_Business_Sele(__in,__cfg_Local).__ST118126_Layout __EE6260113) := __EEQP(__EE6260113.UID,__EE6259088.Legal_);
  SHARED __EE6260150 := JOIN(__EE6259088,__EE6260113,__JC6260119(LEFT,RIGHT),TRANSFORM(E_Sele_Person(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6260156(B_Person(__in,__cfg_Local).__ST131971_Layout __EE6257018, E_Sele_Person(__in,__cfg_Local).Layout __EE6260150) := __EEQP(__EE6260150.Contact_,__EE6257018.UID);
  SHARED __EE6261120 := JOIN(__EE6257018,__EE6260150,__JC6260156(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST131971_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6261122 := __EE6261120;
  EXPORT Res22 := __UNWRAP(__EE6261122);
  SHARED __EE3468767 := __E_Phone;
  SHARED __EE3468757 := __E_Sele_Phone_Number;
  SHARED __EE6263366 := __EE3468757(__NN(__EE3468757.Legal_) AND __NN(__EE3468757.Phone_Number_));
  SHARED __EE6263111 := __ENH_Business_Sele;
  SHARED __EE6263486 := __EE6263111(__T(__OP2(__EE6263111.UID,=,__CN(__PBusinessSeleUID))));
  __JC6263492(E_Sele_Phone_Number(__in,__cfg_Local).Layout __EE6263366, B_Business_Sele(__in,__cfg_Local).__ST118126_Layout __EE6263486) := __EEQP(__EE6263486.UID,__EE6263366.Legal_);
  SHARED __EE6263529 := JOIN(__EE6263366,__EE6263486,__JC6263492(LEFT,RIGHT),TRANSFORM(E_Sele_Phone_Number(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6263535(E_Phone(__in,__cfg_Local).Layout __EE3468767, E_Sele_Phone_Number(__in,__cfg_Local).Layout __EE6263529) := __EEQP(__EE6263529.Phone_Number_,__EE3468767.UID);
  SHARED __EE6263588 := JOIN(__EE3468767,__EE6263529,__JC6263535(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6263590 := __EE6263588;
  EXPORT Res23 := __UNWRAP(__EE6263590);
  SHARED __EE6263769 := __ENH_Property;
  SHARED __EE3468936 := __E_Sele_Property;
  SHARED __EE6263977 := __EE3468936(__NN(__EE3468936.Legal_) AND __NN(__EE3468936.Prop_));
  SHARED __EE6263772 := __ENH_Business_Sele;
  SHARED __EE6264071 := __EE6263772(__T(__OP2(__EE6263772.UID,=,__CN(__PBusinessSeleUID))));
  __JC6264077(E_Sele_Property(__in,__cfg_Local).Layout __EE6263977, B_Business_Sele(__in,__cfg_Local).__ST118126_Layout __EE6264071) := __EEQP(__EE6264071.UID,__EE6263977.Legal_);
  SHARED __EE6264104 := JOIN(__EE6263977,__EE6264071,__JC6264077(LEFT,RIGHT),TRANSFORM(E_Sele_Property(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6264110(B_Property(__in,__cfg_Local).__ST132820_Layout __EE6263769, E_Sele_Property(__in,__cfg_Local).Layout __EE6264104) := __EEQP(__EE6264104.Prop_,__EE6263769.UID);
  SHARED __EE6264147 := JOIN(__EE6263769,__EE6264104,__JC6264110(LEFT,RIGHT),TRANSFORM(B_Property(__in,__cfg_Local).__ST132820_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6264149 := __EE6264147;
  EXPORT Res24 := __UNWRAP(__EE6264149);
  SHARED __EE6264276 := __ENH_Property_Event;
  SHARED __EE3469082 := __E_Sele_Property_Event;
  SHARED __EE6264534 := __EE3469082(__NN(__EE3469082.Legal_) AND __NN(__EE3469082.Event_));
  SHARED __EE6264279 := __ENH_Business_Sele;
  SHARED __EE6264653 := __EE6264279(__T(__OP2(__EE6264279.UID,=,__CN(__PBusinessSeleUID))));
  __JC6264659(E_Sele_Property_Event(__in,__cfg_Local).Layout __EE6264534, B_Business_Sele(__in,__cfg_Local).__ST118126_Layout __EE6264653) := __EEQP(__EE6264653.UID,__EE6264534.Legal_);
  SHARED __EE6264681 := JOIN(__EE6264534,__EE6264653,__JC6264659(LEFT,RIGHT),TRANSFORM(E_Sele_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6264687(B_Property_Event_4(__in,__cfg_Local).__ST191134_Layout __EE6264276, E_Sele_Property_Event(__in,__cfg_Local).Layout __EE6264681) := __EEQP(__EE6264681.Event_,__EE6264276.UID);
  SHARED __EE6264754 := JOIN(__EE6264276,__EE6264681,__JC6264687(LEFT,RIGHT),TRANSFORM(B_Property_Event_4(__in,__cfg_Local).__ST191134_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6264756 := __EE6264754;
  EXPORT Res25 := __UNWRAP(__EE6264756);
  SHARED __EE3469261 := __E_T_I_N;
  SHARED __EE3469251 := __E_Sele_T_I_N;
  SHARED __EE6265042 := __EE3469251(__NN(__EE3469251.Legal_) AND __NN(__EE3469251.Tax_I_D_));
  SHARED __EE6264933 := __ENH_Business_Sele;
  SHARED __EE6265089 := __EE6264933(__T(__OP2(__EE6264933.UID,=,__CN(__PBusinessSeleUID))));
  __JC6265095(E_Sele_T_I_N(__in,__cfg_Local).Layout __EE6265042, B_Business_Sele(__in,__cfg_Local).__ST118126_Layout __EE6265089) := __EEQP(__EE6265089.UID,__EE6265042.Legal_);
  SHARED __EE6265108 := JOIN(__EE6265042,__EE6265089,__JC6265095(LEFT,RIGHT),TRANSFORM(E_Sele_T_I_N(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6265114(E_T_I_N(__in,__cfg_Local).Layout __EE3469261, E_Sele_T_I_N(__in,__cfg_Local).Layout __EE6265108) := __EEQP(__EE6265108.Tax_I_D_,__EE3469261.UID);
  SHARED __EE6265118 := JOIN(__EE3469261,__EE6265108,__JC6265114(LEFT,RIGHT),TRANSFORM(E_T_I_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6265120 := __EE6265118;
  EXPORT Res26 := __UNWRAP(__EE6265120);
  SHARED __EE6265153 := __ENH_Tradeline;
  SHARED __EE3469344 := __E_Sele_Tradeline;
  SHARED __EE6265389 := __EE3469344(__NN(__EE3469344.Legal_) AND __NN(__EE3469344.Account_));
  SHARED __EE6265156 := __ENH_Business_Sele;
  SHARED __EE6265497 := __EE6265156(__T(__OP2(__EE6265156.UID,=,__CN(__PBusinessSeleUID))));
  __JC6265503(E_Sele_Tradeline(__in,__cfg_Local).Layout __EE6265389, B_Business_Sele(__in,__cfg_Local).__ST118126_Layout __EE6265497) := __EEQP(__EE6265497.UID,__EE6265389.Legal_);
  SHARED __EE6265510 := JOIN(__EE6265389,__EE6265497,__JC6265503(LEFT,RIGHT),TRANSFORM(E_Sele_Tradeline(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6265516(B_Tradeline(__in,__cfg_Local).__ST134117_Layout __EE6265153, E_Sele_Tradeline(__in,__cfg_Local).Layout __EE6265510) := __EEQP(__EE6265510.Account_,__EE6265153.UID);
  SHARED __EE6265587 := JOIN(__EE6265153,__EE6265510,__JC6265516(LEFT,RIGHT),TRANSFORM(B_Tradeline(__in,__cfg_Local).__ST134117_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6265589 := __EE6265587;
  EXPORT Res27 := __UNWRAP(__EE6265589);
  SHARED __EE6265744 := __ENH_U_C_C;
  SHARED __EE3469502 := __E_Sele_U_C_C;
  SHARED __EE6265970 := __EE3469502(__NN(__EE3469502.Legal_) AND __NN(__EE3469502.Filing_));
  SHARED __EE6265747 := __ENH_Business_Sele;
  SHARED __EE6266073 := __EE6265747(__T(__OP2(__EE6265747.UID,=,__CN(__PBusinessSeleUID))));
  __JC6266079(E_Sele_U_C_C(__in,__cfg_Local).Layout __EE6265970, B_Business_Sele(__in,__cfg_Local).__ST118126_Layout __EE6266073) := __EEQP(__EE6266073.UID,__EE6265970.Legal_);
  SHARED __EE6266094 := JOIN(__EE6265970,__EE6266073,__JC6266079(LEFT,RIGHT),TRANSFORM(E_Sele_U_C_C(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6266100(B_U_C_C(__in,__cfg_Local).__ST134320_Layout __EE6265744, E_Sele_U_C_C(__in,__cfg_Local).Layout __EE6266094) := __EEQP(__EE6266094.Filing_,__EE6265744.UID);
  SHARED __EE6266158 := JOIN(__EE6265744,__EE6266094,__JC6266100(LEFT,RIGHT),TRANSFORM(B_U_C_C(__in,__cfg_Local).__ST134320_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6266160 := __EE6266158;
  EXPORT Res28 := __UNWRAP(__EE6266160);
  SHARED __EE3469667 := __E_Utility;
  SHARED __EE3469657 := __E_Sele_Utility;
  SHARED __EE6266454 := __EE3469657(__NN(__EE3469657.Legal_) AND __NN(__EE3469657.Util_));
  SHARED __EE6266305 := __ENH_Business_Sele;
  SHARED __EE6266521 := __EE6266305(__T(__OP2(__EE6266305.UID,=,__CN(__PBusinessSeleUID))));
  __JC6266527(E_Sele_Utility(__in,__cfg_Local).Layout __EE6266454, B_Business_Sele(__in,__cfg_Local).__ST118126_Layout __EE6266521) := __EEQP(__EE6266521.UID,__EE6266454.Legal_);
  SHARED __EE6266538 := JOIN(__EE6266454,__EE6266521,__JC6266527(LEFT,RIGHT),TRANSFORM(E_Sele_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6266544(E_Utility(__in,__cfg_Local).Layout __EE3469667, E_Sele_Utility(__in,__cfg_Local).Layout __EE6266538) := __EEQP(__EE6266538.Util_,__EE3469667.UID);
  SHARED __EE6266570 := JOIN(__EE3469667,__EE6266538,__JC6266544(LEFT,RIGHT),TRANSFORM(E_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6266572 := __EE6266570;
  EXPORT Res29 := __UNWRAP(__EE6266572);
  SHARED __EE3469783 := __E_Vehicle;
  SHARED __EE3469773 := __E_Sele_Vehicle;
  SHARED __EE6267042 := __EE3469773(__NN(__EE3469773.Legal_) AND __NN(__EE3469773.Automobile_));
  SHARED __EE6266645 := __ENH_Business_Sele;
  SHARED __EE6267233 := __EE6266645(__T(__OP2(__EE6266645.UID,=,__CN(__PBusinessSeleUID))));
  __JC6267239(E_Sele_Vehicle(__in,__cfg_Local).Layout __EE6267042, B_Business_Sele(__in,__cfg_Local).__ST118126_Layout __EE6267233) := __EEQP(__EE6267233.UID,__EE6267042.Legal_);
  SHARED __EE6267289 := JOIN(__EE6267042,__EE6267233,__JC6267239(LEFT,RIGHT),TRANSFORM(E_Sele_Vehicle(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6267295(E_Vehicle(__in,__cfg_Local).Layout __EE3469783, E_Sele_Vehicle(__in,__cfg_Local).Layout __EE6267289) := __EEQP(__EE6267289.Automobile_,__EE3469783.UID);
  SHARED __EE6267406 := JOIN(__EE3469783,__EE6267289,__JC6267295(LEFT,RIGHT),TRANSFORM(E_Vehicle(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6267408 := __EE6267406;
  EXPORT Res30 := __UNWRAP(__EE6267408);
  SHARED __EE3470025 := __E_Inquiry;
  SHARED __EE3470015 := __E_Sele_Inquiry;
  SHARED __EE6267948 := __EE3470015(__NN(__EE3470015.Legal_) AND __NN(__EE3470015.Transaction_));
  SHARED __EE6267729 := __ENH_Business_Sele;
  SHARED __EE6268050 := __EE6267729(__T(__OP2(__EE6267729.UID,=,__CN(__PBusinessSeleUID))));
  __JC6268056(E_Sele_Inquiry(__in,__cfg_Local).Layout __EE6267948, B_Business_Sele(__in,__cfg_Local).__ST118126_Layout __EE6268050) := __EEQP(__EE6268050.UID,__EE6267948.Legal_);
  SHARED __EE6268068 := JOIN(__EE6267948,__EE6268050,__JC6268056(LEFT,RIGHT),TRANSFORM(E_Sele_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6268074(E_Inquiry(__in,__cfg_Local).Layout __EE3470025, E_Sele_Inquiry(__in,__cfg_Local).Layout __EE6268068) := __EEQP(__EE6268068.Transaction_,__EE3470025.UID);
  SHARED __EE6268134 := JOIN(__EE3470025,__EE6268068,__JC6268074(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6268136 := __EE6268134;
  EXPORT Res31 := __UNWRAP(__EE6268136);
  SHARED __EE3470179 := __E_Watercraft;
  SHARED __EE3470169 := __E_Sele_Watercraft;
  SHARED __EE6268398 := __EE3470169(__NN(__EE3470169.Legal_) AND __NN(__EE3470169.W_Craft_));
  SHARED __EE6268279 := __ENH_Business_Sele;
  SHARED __EE6268450 := __EE6268279(__T(__OP2(__EE6268279.UID,=,__CN(__PBusinessSeleUID))));
  __JC6268456(E_Sele_Watercraft(__in,__cfg_Local).Layout __EE6268398, B_Business_Sele(__in,__cfg_Local).__ST118126_Layout __EE6268450) := __EEQP(__EE6268450.UID,__EE6268398.Legal_);
  SHARED __EE6268467 := JOIN(__EE6268398,__EE6268450,__JC6268456(LEFT,RIGHT),TRANSFORM(E_Sele_Watercraft(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6268473(E_Watercraft(__in,__cfg_Local).Layout __EE3470179, E_Sele_Watercraft(__in,__cfg_Local).Layout __EE6268467) := __EEQP(__EE6268467.W_Craft_,__EE3470179.UID);
  SHARED __EE6268484 := JOIN(__EE3470179,__EE6268467,__JC6268473(LEFT,RIGHT),TRANSFORM(E_Watercraft(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6268486 := __EE6268484;
  EXPORT Res32 := __UNWRAP(__EE6268486);
  SHARED __EE6268529 := __ENH_Business_Prox;
  SHARED __EE6269086 := __EE6268529(__NN(__EE6268529.Prox_Sele_));
  SHARED __EE6268532 := __ENH_Business_Sele;
  SHARED __EE6269091 := __EE6268532(__T(__OP2(__EE6268532.UID,=,__CN(__PBusinessSeleUID))));
  __JC6269097(B_Business_Prox(__in,__cfg_Local).__ST100100_Layout __EE6269086, B_Business_Sele(__in,__cfg_Local).__ST118126_Layout __EE6269091) := __EEQP(__EE6269091.UID,__EE6269086.Prox_Sele_);
  SHARED __EE6269357 := JOIN(__EE6269086,__EE6269091,__JC6269097(LEFT,RIGHT),TRANSFORM(B_Business_Prox(__in,__cfg_Local).__ST100100_Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __EE6269359 := __EE6269357;
  EXPORT Res33 := __UNWRAP(__EE6269359);
  SHARED __EE6269880 := __ENH_Criminal_Offense;
  SHARED __EE3470605 := __E_Criminal_Details;
  SHARED __EE6270118 := __EE3470605(__NN(__EE3470605.Offender_) AND __NN(__EE3470605.Offense_));
  SHARED __EE3470599 := __E_Criminal_Offender;
  SHARED __EE6270239 := __EE3470599(__T(__OP2(__EE3470599.UID,=,__CN(__PCriminalOffenderUID))));
  __JC6270245(E_Criminal_Details(__in,__cfg_Local).Layout __EE6270118, E_Criminal_Offender(__in,__cfg_Local).Layout __EE6270239) := __EEQP(__EE6270239.UID,__EE6270118.Offender_);
  SHARED __EE6270253 := JOIN(__EE6270118,__EE6270239,__JC6270245(LEFT,RIGHT),TRANSFORM(E_Criminal_Details(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6270259(B_Criminal_Offense(__in,__cfg_Local).__ST119574_Layout __EE6269880, E_Criminal_Details(__in,__cfg_Local).Layout __EE6270253) := __EEQP(__EE6270253.Offense_,__EE6269880.UID);
  SHARED __EE6270342 := JOIN(__EE6269880,__EE6270253,__JC6270259(LEFT,RIGHT),TRANSFORM(B_Criminal_Offense(__in,__cfg_Local).__ST119574_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6270344 := __EE6270342;
  EXPORT Res34 := __UNWRAP(__EE6270344);
  SHARED __EE3470788 := __E_Criminal_Punishment;
  SHARED __EE3470778 := __E_Criminal_Details;
  SHARED __EE6270641 := __EE3470778(__NN(__EE3470778.Offender_) AND __NN(__EE3470778.Punishment_));
  SHARED __EE3470772 := __E_Criminal_Offender;
  SHARED __EE6270733 := __EE3470772(__T(__OP2(__EE3470772.UID,=,__CN(__PCriminalOffenderUID))));
  __JC6270739(E_Criminal_Details(__in,__cfg_Local).Layout __EE6270641, E_Criminal_Offender(__in,__cfg_Local).Layout __EE6270733) := __EEQP(__EE6270733.UID,__EE6270641.Offender_);
  SHARED __EE6270747 := JOIN(__EE6270641,__EE6270733,__JC6270739(LEFT,RIGHT),TRANSFORM(E_Criminal_Details(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6270753(E_Criminal_Punishment(__in,__cfg_Local).Layout __EE3470788, E_Criminal_Details(__in,__cfg_Local).Layout __EE6270747) := __EEQP(__EE6270747.Punishment_,__EE3470788.UID);
  SHARED __EE6270807 := JOIN(__EE3470788,__EE6270747,__JC6270753(LEFT,RIGHT),TRANSFORM(E_Criminal_Punishment(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6270809 := __EE6270807;
  EXPORT Res35 := __UNWRAP(__EE6270809);
  SHARED __EE3470930 := __E_Inquiry;
  SHARED __EE3470920 := __E_Email_Inquiry;
  SHARED __EE6271149 := __EE3470920(__NN(__EE3470920.Email_) AND __NN(__EE3470920.Transaction_));
  SHARED __EE6270932 := __ENH_Email;
  SHARED __EE6271249 := __EE6270932(__T(__OP2(__EE6270932.UID,=,__CN(__PEmailUID))));
  __JC6271255(E_Email_Inquiry(__in,__cfg_Local).Layout __EE6271149, B_Email_2(__in,__cfg_Local).__ST165242_Layout __EE6271249) := __EEQP(__EE6271249.UID,__EE6271149.Email_);
  SHARED __EE6271265 := JOIN(__EE6271149,__EE6271249,__JC6271255(LEFT,RIGHT),TRANSFORM(E_Email_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6271271(E_Inquiry(__in,__cfg_Local).Layout __EE3470930, E_Email_Inquiry(__in,__cfg_Local).Layout __EE6271265) := __EEQP(__EE6271265.Transaction_,__EE3470930.UID);
  SHARED __EE6271331 := JOIN(__EE3470930,__EE6271265,__JC6271271(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6271333 := __EE6271331;
  EXPORT Res36 := __UNWRAP(__EE6271333);
  SHARED __EE3471072 := __E_First_Degree_Associations;
  SHARED __EE6271531 := __EE3471072(__NN(__EE3471072.Subject_));
  SHARED __EE6271472 := __ENH_Person;
  SHARED __EE6271536 := __EE6271472(__T(__OP2(__EE6271472.UID,=,__CN(__PPersonUID))));
  __JC6271542(E_First_Degree_Associations(__in,__cfg_Local).Layout __EE6271531, B_Person(__in,__cfg_Local).__ST131971_Layout __EE6271536) := __EEQP(__EE6271536.UID,__EE6271531.Subject_);
  SHARED __EE6271554 := JOIN(__EE6271531,__EE6271536,__JC6271542(LEFT,RIGHT),TRANSFORM(E_First_Degree_Associations(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6271556 := __EE6271554;
  EXPORT Res37 := __UNWRAP(__EE6271556);
  SHARED __EE6271581 := __ENH_First_Degree_Relative;
  SHARED __EE6271645 := __EE6271581(__NN(__EE6271581.Subject_));
  SHARED __EE6271584 := __ENH_Person;
  SHARED __EE6271650 := __EE6271584(__T(__OP2(__EE6271584.UID,=,__CN(__PPersonUID))));
  __JC6271656(B_First_Degree_Relative(__in,__cfg_Local).__ST2967219_Layout __EE6271645, B_Person(__in,__cfg_Local).__ST131971_Layout __EE6271650) := __EEQP(__EE6271650.UID,__EE6271645.Subject_);
  SHARED __EE6271668 := JOIN(__EE6271645,__EE6271650,__JC6271656(LEFT,RIGHT),TRANSFORM(B_First_Degree_Relative(__in,__cfg_Local).__ST2967219_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6271670 := __EE6271668;
  EXPORT Res38 := __UNWRAP(__EE6271670);
  SHARED __EE3471206 := __E_Phone;
  SHARED __EE3471196 := __E_House_Hold_Phone;
  SHARED __EE6271828 := __EE3471196(__NN(__EE3471196.Household_) AND __NN(__EE3471196.Phone_Number_));
  SHARED __EE3471190 := __E_Household;
  SHARED __EE6271937 := __EE3471190(__T(__OP2(__EE3471190.UID,=,__CN(__PHouseholdUID))));
  __JC6271943(E_House_Hold_Phone(__in,__cfg_Local).Layout __EE6271828, E_Household(__in,__cfg_Local).Layout __EE6271937) := __EEQP(__EE6271937.UID,__EE6271828.Household_);
  SHARED __EE6271969 := JOIN(__EE6271828,__EE6271937,__JC6271943(LEFT,RIGHT),TRANSFORM(E_House_Hold_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6271975(E_Phone(__in,__cfg_Local).Layout __EE3471206, E_House_Hold_Phone(__in,__cfg_Local).Layout __EE6271969) := __EEQP(__EE6271969.Phone_Number_,__EE3471206.UID);
  SHARED __EE6272028 := JOIN(__EE3471206,__EE6271969,__JC6271975(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6272030 := __EE6272028;
  EXPORT Res39 := __UNWRAP(__EE6272030);
  SHARED __EE6272187 := __ENH_Person;
  SHARED __EE3471359 := __E_Household_Member;
  SHARED __EE6274187 := __EE3471359(__NN(__EE3471359.Household_) AND __NN(__EE3471359.Subject_));
  SHARED __EE3471353 := __E_Household;
  SHARED __EE6275189 := __EE3471353(__T(__OP2(__EE3471353.UID,=,__CN(__PHouseholdUID))));
  __JC6275195(E_Household_Member(__in,__cfg_Local).Layout __EE6274187, E_Household(__in,__cfg_Local).Layout __EE6275189) := __EEQP(__EE6275189.UID,__EE6274187.Household_);
  SHARED __EE6275203 := JOIN(__EE6274187,__EE6275189,__JC6275195(LEFT,RIGHT),TRANSFORM(E_Household_Member(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6275209(B_Person(__in,__cfg_Local).__ST131971_Layout __EE6272187, E_Household_Member(__in,__cfg_Local).Layout __EE6275203) := __EEQP(__EE6275203.Subject_,__EE6272187.UID);
  SHARED __EE6276173 := JOIN(__EE6272187,__EE6275203,__JC6275209(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST131971_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6276175 := __EE6276173;
  EXPORT Res40 := __UNWRAP(__EE6276175);
  SHARED __EE3472490 := __E_Aircraft;
  SHARED __EE3472480 := __E_Aircraft_Owner;
  SHARED __EE6278261 := __EE3472480(__NN(__EE3472480.Owner_) AND __NN(__EE3472480.Plane_));
  SHARED __EE6278118 := __ENH_Person;
  SHARED __EE6278324 := __EE6278118(__T(__OP2(__EE6278118.UID,=,__CN(__PPersonUID))));
  __JC6278330(E_Aircraft_Owner(__in,__cfg_Local).Layout __EE6278261, B_Person(__in,__cfg_Local).__ST131971_Layout __EE6278324) := __EEQP(__EE6278324.UID,__EE6278261.Owner_);
  SHARED __EE6278340 := JOIN(__EE6278261,__EE6278324,__JC6278330(LEFT,RIGHT),TRANSFORM(E_Aircraft_Owner(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6278346(E_Aircraft(__in,__cfg_Local).Layout __EE3472490, E_Aircraft_Owner(__in,__cfg_Local).Layout __EE6278340) := __EEQP(__EE6278340.Plane_,__EE3472490.UID);
  SHARED __EE6278369 := JOIN(__EE3472490,__EE6278340,__JC6278346(LEFT,RIGHT),TRANSFORM(E_Aircraft(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6278371 := __EE6278369;
  EXPORT Res41 := __UNWRAP(__EE6278371);
  SHARED __EE3472602 := __E_Household;
  SHARED __EE3472592 := __E_Household_Member;
  SHARED __EE6278541 := __EE3472592(__NN(__EE3472592.Subject_) AND __NN(__EE3472592.Household_));
  SHARED __EE6278436 := __ENH_Person;
  SHARED __EE6278585 := __EE6278436(__T(__OP2(__EE6278436.UID,=,__CN(__PPersonUID))));
  __JC6278591(E_Household_Member(__in,__cfg_Local).Layout __EE6278541, B_Person(__in,__cfg_Local).__ST131971_Layout __EE6278585) := __EEQP(__EE6278585.UID,__EE6278541.Subject_);
  SHARED __EE6278599 := JOIN(__EE6278541,__EE6278585,__JC6278591(LEFT,RIGHT),TRANSFORM(E_Household_Member(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6278605(E_Household(__in,__cfg_Local).Layout __EE3472602, E_Household_Member(__in,__cfg_Local).Layout __EE6278599) := __EEQP(__EE6278599.Household_,__EE3472602.UID);
  SHARED __EE6278611 := JOIN(__EE3472602,__EE6278599,__JC6278605(LEFT,RIGHT),TRANSFORM(E_Household(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6278613 := __EE6278611;
  EXPORT Res42 := __UNWRAP(__EE6278613);
  SHARED __EE3472693 := __E_Accident;
  SHARED __EE3472683 := __E_Person_Accident;
  SHARED __EE6278865 := __EE3472683(__NN(__EE3472683.Subject_) AND __NN(__EE3472683.Acc_));
  SHARED __EE6278640 := __ENH_Person;
  SHARED __EE6278969 := __EE6278640(__T(__OP2(__EE6278640.UID,=,__CN(__PPersonUID))));
  __JC6278975(E_Person_Accident(__in,__cfg_Local).Layout __EE6278865, B_Person(__in,__cfg_Local).__ST131971_Layout __EE6278969) := __EEQP(__EE6278969.UID,__EE6278865.Subject_);
  SHARED __EE6279023 := JOIN(__EE6278865,__EE6278969,__JC6278975(LEFT,RIGHT),TRANSFORM(E_Person_Accident(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6279029(E_Accident(__in,__cfg_Local).Layout __EE3472693, E_Person_Accident(__in,__cfg_Local).Layout __EE6279023) := __EEQP(__EE6279023.Acc_,__EE3472693.UID);
  SHARED __EE6279055 := JOIN(__EE3472693,__EE6279023,__JC6279029(LEFT,RIGHT),TRANSFORM(E_Accident(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6279057 := __EE6279055;
  EXPORT Res43 := __UNWRAP(__EE6279057);
  SHARED __EE6279204 := __ENH_Address;
  SHARED __EE3472835 := __E_Person_Address;
  SHARED __EE6279700 := __EE3472835(__NN(__EE3472835.Subject_) AND __NN(__EE3472835.Location_));
  SHARED __EE6279207 := __ENH_Person;
  SHARED __EE6279937 := __EE6279207(__T(__OP2(__EE6279207.UID,=,__CN(__PPersonUID))));
  __JC6279943(E_Person_Address(__in,__cfg_Local).Layout __EE6279700, B_Person(__in,__cfg_Local).__ST131971_Layout __EE6279937) := __EEQP(__EE6279937.UID,__EE6279700.Subject_);
  SHARED __EE6279992 := JOIN(__EE6279700,__EE6279937,__JC6279943(LEFT,RIGHT),TRANSFORM(E_Person_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6279998(B_Address_1(__in,__cfg_Local).__ST134443_Layout __EE6279204, E_Person_Address(__in,__cfg_Local).Layout __EE6279992) := __EEQP(__EE6279992.Location_,__EE6279204.UID);
  SHARED __EE6280156 := JOIN(__EE6279204,__EE6279992,__JC6279998(LEFT,RIGHT),TRANSFORM(B_Address_1(__in,__cfg_Local).__ST134443_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6280158 := __EE6280156;
  EXPORT Res44 := __UNWRAP(__EE6280158);
  SHARED __EE6280571 := __ENH_Bankruptcy;
  SHARED __EE3473146 := __E_Person_Bankruptcy;
  SHARED __EE6280839 := __EE3473146(__NN(__EE3473146.Subject_) AND __NN(__EE3473146.Bankrupt_));
  SHARED __EE6280574 := __ENH_Person;
  SHARED __EE6280962 := __EE6280574(__T(__OP2(__EE6280574.UID,=,__CN(__PPersonUID))));
  __JC6280968(E_Person_Bankruptcy(__in,__cfg_Local).Layout __EE6280839, B_Person(__in,__cfg_Local).__ST131971_Layout __EE6280962) := __EEQP(__EE6280962.UID,__EE6280839.Subject_);
  SHARED __EE6280975 := JOIN(__EE6280839,__EE6280962,__JC6280968(LEFT,RIGHT),TRANSFORM(E_Person_Bankruptcy(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6280981(B_Bankruptcy(__in,__cfg_Local).__ST99617_Layout __EE6280571, E_Person_Bankruptcy(__in,__cfg_Local).Layout __EE6280975) := __EEQP(__EE6280975.Bankrupt_,__EE6280571.UID);
  SHARED __EE6281067 := JOIN(__EE6280571,__EE6280975,__JC6280981(LEFT,RIGHT),TRANSFORM(B_Bankruptcy(__in,__cfg_Local).__ST99617_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6281069 := __EE6281067;
  EXPORT Res45 := __UNWRAP(__EE6281069);
  SHARED __EE3473330 := __E_Drivers_License;
  SHARED __EE3473320 := __E_Person_Drivers_License;
  SHARED __EE6281459 := __EE3473320(__NN(__EE3473320.Subject_) AND __NN(__EE3473320.License_));
  SHARED __EE6281254 := __ENH_Person;
  SHARED __EE6281553 := __EE6281254(__T(__OP2(__EE6281254.UID,=,__CN(__PPersonUID))));
  __JC6281559(E_Person_Drivers_License(__in,__cfg_Local).Layout __EE6281459, B_Person(__in,__cfg_Local).__ST131971_Layout __EE6281553) := __EEQP(__EE6281553.UID,__EE6281459.Subject_);
  SHARED __EE6281566 := JOIN(__EE6281459,__EE6281553,__JC6281559(LEFT,RIGHT),TRANSFORM(E_Person_Drivers_License(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6281572(E_Drivers_License(__in,__cfg_Local).Layout __EE3473330, E_Person_Drivers_License(__in,__cfg_Local).Layout __EE6281566) := __EEQP(__EE6281566.License_,__EE3473330.UID);
  SHARED __EE6281629 := JOIN(__EE3473330,__EE6281566,__JC6281572(LEFT,RIGHT),TRANSFORM(E_Drivers_License(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6281631 := __EE6281629;
  EXPORT Res46 := __UNWRAP(__EE6281631);
  SHARED __EE6281758 := __ENH_Education;
  SHARED __EE3473464 := __E_Person_Education;
  SHARED __EE6281922 := __EE3473464(__NN(__EE3473464.Subject_) AND __NN(__EE3473464.Edu_));
  SHARED __EE6281761 := __ENH_Person;
  SHARED __EE6281993 := __EE6281761(__T(__OP2(__EE6281761.UID,=,__CN(__PPersonUID))));
  __JC6281999(E_Person_Education(__in,__cfg_Local).Layout __EE6281922, B_Person(__in,__cfg_Local).__ST131971_Layout __EE6281993) := __EEQP(__EE6281993.UID,__EE6281922.Subject_);
  SHARED __EE6282017 := JOIN(__EE6281922,__EE6281993,__JC6281999(LEFT,RIGHT),TRANSFORM(E_Person_Education(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6282023(B_Education_2(__in,__cfg_Local).__ST165189_Layout __EE6281758, E_Person_Education(__in,__cfg_Local).Layout __EE6282017) := __EEQP(__EE6282017.Edu_,__EE6281758.UID);
  SHARED __EE6282046 := JOIN(__EE6281758,__EE6282017,__JC6282023(LEFT,RIGHT),TRANSFORM(B_Education_2(__in,__cfg_Local).__ST165189_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6282048 := __EE6282046;
  EXPORT Res47 := __UNWRAP(__EE6282048);
  SHARED __EE6282129 := __ENH_Email;
  SHARED __EE3473584 := __E_Person_Email;
  SHARED __EE6282297 := __EE3473584(__NN(__EE3473584.Subject_) AND __NN(__EE3473584.Email_));
  SHARED __EE6282132 := __ENH_Person;
  SHARED __EE6282370 := __EE6282132(__T(__OP2(__EE6282132.UID,=,__CN(__PPersonUID))));
  __JC6282376(E_Person_Email(__in,__cfg_Local).Layout __EE6282297, B_Person(__in,__cfg_Local).__ST131971_Layout __EE6282370) := __EEQP(__EE6282370.UID,__EE6282297.Subject_);
  SHARED __EE6282383 := JOIN(__EE6282297,__EE6282370,__JC6282376(LEFT,RIGHT),TRANSFORM(E_Person_Email(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6282389(B_Email_2(__in,__cfg_Local).__ST165242_Layout __EE6282129, E_Person_Email(__in,__cfg_Local).Layout __EE6282383) := __EEQP(__EE6282383.Email_,__EE6282129.UID);
  SHARED __EE6282425 := JOIN(__EE6282129,__EE6282383,__JC6282389(LEFT,RIGHT),TRANSFORM(B_Email_2(__in,__cfg_Local).__ST165242_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6282427 := __EE6282425;
  EXPORT Res48 := __UNWRAP(__EE6282427);
  SHARED __EE3473720 := __E_Inquiry;
  SHARED __EE3473710 := __E_Person_Inquiry;
  SHARED __EE6282727 := __EE3473710(__NN(__EE3473710.Subject_) AND __NN(__EE3473710.Transaction_));
  SHARED __EE6282512 := __ENH_Person;
  SHARED __EE6282826 := __EE6282512(__T(__OP2(__EE6282512.UID,=,__CN(__PPersonUID))));
  __JC6282832(E_Person_Inquiry(__in,__cfg_Local).Layout __EE6282727, B_Person(__in,__cfg_Local).__ST131971_Layout __EE6282826) := __EEQP(__EE6282826.UID,__EE6282727.Subject_);
  SHARED __EE6282841 := JOIN(__EE6282727,__EE6282826,__JC6282832(LEFT,RIGHT),TRANSFORM(E_Person_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6282847(E_Inquiry(__in,__cfg_Local).Layout __EE3473720, E_Person_Inquiry(__in,__cfg_Local).Layout __EE6282841) := __EEQP(__EE6282841.Transaction_,__EE3473720.UID);
  SHARED __EE6282907 := JOIN(__EE3473720,__EE6282841,__JC6282847(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6282909 := __EE6282907;
  EXPORT Res49 := __UNWRAP(__EE6282909);
  SHARED __EE6283046 := __ENH_Lien_Judgment;
  SHARED __EE3473861 := __E_Person_Lien_Judgment;
  SHARED __EE6283232 := __EE3473861(__NN(__EE3473861.Subject_) AND __NN(__EE3473861.Lien_));
  SHARED __EE6283049 := __ENH_Person;
  SHARED __EE6283314 := __EE6283049(__T(__OP2(__EE6283049.UID,=,__CN(__PPersonUID))));
  __JC6283320(E_Person_Lien_Judgment(__in,__cfg_Local).Layout __EE6283232, B_Person(__in,__cfg_Local).__ST131971_Layout __EE6283314) := __EEQP(__EE6283314.UID,__EE6283232.Subject_);
  SHARED __EE6283333 := JOIN(__EE6283232,__EE6283314,__JC6283320(LEFT,RIGHT),TRANSFORM(E_Person_Lien_Judgment(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6283339(B_Lien_Judgment_12(__in,__cfg_Local).__ST209199_Layout __EE6283046, E_Person_Lien_Judgment(__in,__cfg_Local).Layout __EE6283333) := __EEQP(__EE6283333.Lien_,__EE6283046.UID);
  SHARED __EE6283378 := JOIN(__EE6283046,__EE6283333,__JC6283339(LEFT,RIGHT),TRANSFORM(B_Lien_Judgment_12(__in,__cfg_Local).__ST209199_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6283380 := __EE6283378;
  EXPORT Res50 := __UNWRAP(__EE6283380);
  SHARED __EE3474004 := __E_Criminal_Offender;
  SHARED __EE3473994 := __E_Person_Offender;
  SHARED __EE6283630 := __EE3473994(__NN(__EE3473994.Subject_) AND __NN(__EE3473994.Offender_));
  SHARED __EE6283483 := __ENH_Person;
  SHARED __EE6283695 := __EE6283483(__T(__OP2(__EE6283483.UID,=,__CN(__PPersonUID))));
  __JC6283701(E_Person_Offender(__in,__cfg_Local).Layout __EE6283630, B_Person(__in,__cfg_Local).__ST131971_Layout __EE6283695) := __EEQP(__EE6283695.UID,__EE6283630.Subject_);
  SHARED __EE6283708 := JOIN(__EE6283630,__EE6283695,__JC6283701(LEFT,RIGHT),TRANSFORM(E_Person_Offender(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6283714(E_Criminal_Offender(__in,__cfg_Local).Layout __EE3474004, E_Person_Offender(__in,__cfg_Local).Layout __EE6283708) := __EEQP(__EE6283708.Offender_,__EE3474004.UID);
  SHARED __EE6283742 := JOIN(__EE3474004,__EE6283708,__JC6283714(LEFT,RIGHT),TRANSFORM(E_Criminal_Offender(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6283744 := __EE6283742;
  EXPORT Res51 := __UNWRAP(__EE6283744);
  SHARED __EE6283813 := __ENH_Criminal_Offense;
  SHARED __EE3474109 := __E_Person_Offenses;
  SHARED __EE6284075 := __EE3474109(__NN(__EE3474109.Subject_) AND __NN(__EE3474109.Offense_));
  SHARED __EE6283816 := __ENH_Person;
  SHARED __EE6284195 := __EE6283816(__T(__OP2(__EE6283816.UID,=,__CN(__PPersonUID))));
  __JC6284201(E_Person_Offenses(__in,__cfg_Local).Layout __EE6284075, B_Person(__in,__cfg_Local).__ST131971_Layout __EE6284195) := __EEQP(__EE6284195.UID,__EE6284075.Subject_);
  SHARED __EE6284208 := JOIN(__EE6284075,__EE6284195,__JC6284201(LEFT,RIGHT),TRANSFORM(E_Person_Offenses(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6284214(B_Criminal_Offense(__in,__cfg_Local).__ST119574_Layout __EE6283813, E_Person_Offenses(__in,__cfg_Local).Layout __EE6284208) := __EEQP(__EE6284208.Offense_,__EE6283813.UID);
  SHARED __EE6284297 := JOIN(__EE6283813,__EE6284208,__JC6284214(LEFT,RIGHT),TRANSFORM(B_Criminal_Offense(__in,__cfg_Local).__ST119574_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6284299 := __EE6284297;
  EXPORT Res52 := __UNWRAP(__EE6284299);
  SHARED __EE3474292 := __E_Phone;
  SHARED __EE3474282 := __E_Person_Phone;
  SHARED __EE6284729 := __EE3474282(__NN(__EE3474282.Subject_) AND __NN(__EE3474282.Phone_Number_));
  SHARED __EE6284478 := __ENH_Person;
  SHARED __EE6284846 := __EE6284478(__T(__OP2(__EE6284478.UID,=,__CN(__PPersonUID))));
  __JC6284852(E_Person_Phone(__in,__cfg_Local).Layout __EE6284729, B_Person(__in,__cfg_Local).__ST131971_Layout __EE6284846) := __EEQP(__EE6284846.UID,__EE6284729.Subject_);
  SHARED __EE6284886 := JOIN(__EE6284729,__EE6284846,__JC6284852(LEFT,RIGHT),TRANSFORM(E_Person_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6284892(E_Phone(__in,__cfg_Local).Layout __EE3474292, E_Person_Phone(__in,__cfg_Local).Layout __EE6284886) := __EEQP(__EE6284886.Phone_Number_,__EE3474292.UID);
  SHARED __EE6284945 := JOIN(__EE3474292,__EE6284886,__JC6284892(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6284947 := __EE6284945;
  EXPORT Res53 := __UNWRAP(__EE6284947);
  SHARED __EE6285120 := __ENH_Property;
  SHARED __EE3474456 := __E_Person_Property;
  SHARED __EE6285324 := __EE3474456(__NN(__EE3474456.Subject_) AND __NN(__EE3474456.Prop_));
  SHARED __EE6285123 := __ENH_Person;
  SHARED __EE6285415 := __EE6285123(__T(__OP2(__EE6285123.UID,=,__CN(__PPersonUID))));
  __JC6285421(E_Person_Property(__in,__cfg_Local).Layout __EE6285324, B_Person(__in,__cfg_Local).__ST131971_Layout __EE6285415) := __EEQP(__EE6285415.UID,__EE6285324.Subject_);
  SHARED __EE6285445 := JOIN(__EE6285324,__EE6285415,__JC6285421(LEFT,RIGHT),TRANSFORM(E_Person_Property(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6285451(B_Property(__in,__cfg_Local).__ST132820_Layout __EE6285120, E_Person_Property(__in,__cfg_Local).Layout __EE6285445) := __EEQP(__EE6285445.Prop_,__EE6285120.UID);
  SHARED __EE6285488 := JOIN(__EE6285120,__EE6285445,__JC6285451(LEFT,RIGHT),TRANSFORM(B_Property(__in,__cfg_Local).__ST132820_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6285490 := __EE6285488;
  EXPORT Res54 := __UNWRAP(__EE6285490);
  SHARED __EE6285611 := __ENH_Property_Event;
  SHARED __EE3474599 := __E_Person_Property_Event;
  SHARED __EE6285865 := __EE3474599(__NN(__EE3474599.Subject_) AND __NN(__EE3474599.Event_));
  SHARED __EE6285614 := __ENH_Person;
  SHARED __EE6285981 := __EE6285614(__T(__OP2(__EE6285614.UID,=,__CN(__PPersonUID))));
  __JC6285987(E_Person_Property_Event(__in,__cfg_Local).Layout __EE6285865, B_Person(__in,__cfg_Local).__ST131971_Layout __EE6285981) := __EEQP(__EE6285981.UID,__EE6285865.Subject_);
  SHARED __EE6286006 := JOIN(__EE6285865,__EE6285981,__JC6285987(LEFT,RIGHT),TRANSFORM(E_Person_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6286012(B_Property_Event_4(__in,__cfg_Local).__ST191134_Layout __EE6285611, E_Person_Property_Event(__in,__cfg_Local).Layout __EE6286006) := __EEQP(__EE6286006.Event_,__EE6285611.UID);
  SHARED __EE6286079 := JOIN(__EE6285611,__EE6286006,__JC6286012(LEFT,RIGHT),TRANSFORM(B_Property_Event_4(__in,__cfg_Local).__ST191134_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6286081 := __EE6286079;
  EXPORT Res55 := __UNWRAP(__EE6286081);
  SHARED __EE3474775 := __E_Social_Security_Number;
  SHARED __EE3474765 := __E_Person_S_S_N;
  SHARED __EE6286381 := __EE3474765(__NN(__EE3474765.Subject_) AND __NN(__EE3474765.Social_));
  SHARED __EE6286252 := __ENH_Person;
  SHARED __EE6286437 := __EE6286252(__T(__OP2(__EE6286252.UID,=,__CN(__PPersonUID))));
  __JC6286443(E_Person_S_S_N(__in,__cfg_Local).Layout __EE6286381, B_Person(__in,__cfg_Local).__ST131971_Layout __EE6286437) := __EEQP(__EE6286437.UID,__EE6286381.Subject_);
  SHARED __EE6286455 := JOIN(__EE6286381,__EE6286437,__JC6286443(LEFT,RIGHT),TRANSFORM(E_Person_S_S_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6286461(E_Social_Security_Number(__in,__cfg_Local).Layout __EE3474775, E_Person_S_S_N(__in,__cfg_Local).Layout __EE6286455) := __EEQP(__EE6286455.Social_,__EE3474775.UID);
  SHARED __EE6286475 := JOIN(__EE3474775,__EE6286455,__JC6286461(LEFT,RIGHT),TRANSFORM(E_Social_Security_Number(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6286477 := __EE6286475;
  EXPORT Res56 := __UNWRAP(__EE6286477);
  SHARED __EE3474880 := __E_Vehicle;
  SHARED __EE3474870 := __E_Person_Vehicle;
  SHARED __EE6286913 := __EE3474870(__NN(__EE3474870.Subject_) AND __NN(__EE3474870.Automobile_));
  SHARED __EE6286528 := __ENH_Person;
  SHARED __EE6287097 := __EE6286528(__T(__OP2(__EE6286528.UID,=,__CN(__PPersonUID))));
  __JC6287103(E_Person_Vehicle(__in,__cfg_Local).Layout __EE6286913, B_Person(__in,__cfg_Local).__ST131971_Layout __EE6287097) := __EEQP(__EE6287097.UID,__EE6286913.Subject_);
  SHARED __EE6287146 := JOIN(__EE6286913,__EE6287097,__JC6287103(LEFT,RIGHT),TRANSFORM(E_Person_Vehicle(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6287152(E_Vehicle(__in,__cfg_Local).Layout __EE3474880, E_Person_Vehicle(__in,__cfg_Local).Layout __EE6287146) := __EEQP(__EE6287146.Automobile_,__EE3474880.UID);
  SHARED __EE6287263 := JOIN(__EE3474880,__EE6287146,__JC6287152(LEFT,RIGHT),TRANSFORM(E_Vehicle(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6287265 := __EE6287263;
  EXPORT Res57 := __UNWRAP(__EE6287265);
  SHARED __EE6287572 := __ENH_Professional_License;
  SHARED __EE3475104 := __E_Professional_License_Person;
  SHARED __EE6287758 := __EE3475104(__NN(__EE3475104.Subject_) AND __NN(__EE3475104.Prof_Lic_));
  SHARED __EE6287575 := __ENH_Person;
  SHARED __EE6287840 := __EE6287575(__T(__OP2(__EE6287575.UID,=,__CN(__PPersonUID))));
  __JC6287846(E_Professional_License_Person(__in,__cfg_Local).Layout __EE6287758, B_Person(__in,__cfg_Local).__ST131971_Layout __EE6287840) := __EEQP(__EE6287840.UID,__EE6287758.Subject_);
  SHARED __EE6287853 := JOIN(__EE6287758,__EE6287840,__JC6287846(LEFT,RIGHT),TRANSFORM(E_Professional_License_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6287859(B_Professional_License_4(__in,__cfg_Local).__ST190936_Layout __EE6287572, E_Professional_License_Person(__in,__cfg_Local).Layout __EE6287853) := __EEQP(__EE6287853.Prof_Lic_,__EE6287572.UID);
  SHARED __EE6287904 := JOIN(__EE6287572,__EE6287853,__JC6287859(LEFT,RIGHT),TRANSFORM(B_Professional_License_4(__in,__cfg_Local).__ST190936_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6287906 := __EE6287904;
  EXPORT Res58 := __UNWRAP(__EE6287906);
  SHARED __EE6288009 := __ENH_Business_Prox;
  SHARED __EE3475238 := __E_Prox_Person;
  SHARED __EE6288667 := __EE3475238(__NN(__EE3475238.Contact_) AND __NN(__EE3475238.Business_Location_));
  SHARED __EE6288012 := __ENH_Person;
  SHARED __EE6288985 := __EE6288012(__T(__OP2(__EE6288012.UID,=,__CN(__PPersonUID))));
  __JC6288991(E_Prox_Person(__in,__cfg_Local).Layout __EE6288667, B_Person(__in,__cfg_Local).__ST131971_Layout __EE6288985) := __EEQP(__EE6288985.UID,__EE6288667.Contact_);
  SHARED __EE6289019 := JOIN(__EE6288667,__EE6288985,__JC6288991(LEFT,RIGHT),TRANSFORM(E_Prox_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6289025(B_Business_Prox(__in,__cfg_Local).__ST100100_Layout __EE6288009, E_Prox_Person(__in,__cfg_Local).Layout __EE6289019) := __EEQP(__EE6289019.Business_Location_,__EE6288009.UID);
  SHARED __EE6289285 := JOIN(__EE6288009,__EE6289019,__JC6289025(LEFT,RIGHT),TRANSFORM(B_Business_Prox(__in,__cfg_Local).__ST100100_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6289287 := __EE6289285;
  EXPORT Res59 := __UNWRAP(__EE6289287);
  SHARED __EE6289862 := __ENH_Business_Sele;
  SHARED __EE3475630 := __E_Sele_Person;
  SHARED __EE6293032 := __EE3475630(__NN(__EE3475630.Contact_) AND __NN(__EE3475630.Legal_));
  SHARED __EE6289865 := __ENH_Person;
  SHARED __EE6294606 := __EE6289865(__T(__OP2(__EE6289865.UID,=,__CN(__PPersonUID))));
  __JC6294612(E_Sele_Person(__in,__cfg_Local).Layout __EE6293032, B_Person(__in,__cfg_Local).__ST131971_Layout __EE6294606) := __EEQP(__EE6294606.UID,__EE6293032.Contact_);
  SHARED __EE6294643 := JOIN(__EE6293032,__EE6294606,__JC6294612(LEFT,RIGHT),TRANSFORM(E_Sele_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6294649(B_Business_Sele(__in,__cfg_Local).__ST118126_Layout __EE6289862, E_Sele_Person(__in,__cfg_Local).Layout __EE6294643) := __EEQP(__EE6294643.Legal_,__EE6289862.UID);
  SHARED __EE6296162 := JOIN(__EE6289862,__EE6294643,__JC6294649(LEFT,RIGHT),TRANSFORM(B_Business_Sele(__in,__cfg_Local).__ST118126_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6296164 := __EE6296162;
  EXPORT Res60 := __UNWRAP(__EE6296164);
  SHARED __EE3477365 := __E_Utility;
  SHARED __EE3477355 := __E_Utility_Person;
  SHARED __EE6299394 := __EE3477355(__NN(__EE3477355.Subject_) AND __NN(__EE3477355.Util_));
  SHARED __EE6299251 := __ENH_Person;
  SHARED __EE6299457 := __EE6299251(__T(__OP2(__EE6299251.UID,=,__CN(__PPersonUID))));
  __JC6299463(E_Utility_Person(__in,__cfg_Local).Layout __EE6299394, B_Person(__in,__cfg_Local).__ST131971_Layout __EE6299457) := __EEQP(__EE6299457.UID,__EE6299394.Subject_);
  SHARED __EE6299470 := JOIN(__EE6299394,__EE6299457,__JC6299463(LEFT,RIGHT),TRANSFORM(E_Utility_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6299476(E_Utility(__in,__cfg_Local).Layout __EE3477365, E_Utility_Person(__in,__cfg_Local).Layout __EE6299470) := __EEQP(__EE6299470.Util_,__EE3477365.UID);
  SHARED __EE6299502 := JOIN(__EE3477365,__EE6299470,__JC6299476(LEFT,RIGHT),TRANSFORM(E_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6299504 := __EE6299502;
  EXPORT Res61 := __UNWRAP(__EE6299504);
  SHARED __EE3477476 := __E_Watercraft;
  SHARED __EE3477466 := __E_Watercraft_Owner;
  SHARED __EE6299682 := __EE3477466(__NN(__EE3477466.Owner_) AND __NN(__EE3477466.W_Craft_));
  SHARED __EE6299569 := __ENH_Person;
  SHARED __EE6299730 := __EE6299569(__T(__OP2(__EE6299569.UID,=,__CN(__PPersonUID))));
  __JC6299736(E_Watercraft_Owner(__in,__cfg_Local).Layout __EE6299682, B_Person(__in,__cfg_Local).__ST131971_Layout __EE6299730) := __EEQP(__EE6299730.UID,__EE6299682.Owner_);
  SHARED __EE6299743 := JOIN(__EE6299682,__EE6299730,__JC6299736(LEFT,RIGHT),TRANSFORM(E_Watercraft_Owner(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6299749(E_Watercraft(__in,__cfg_Local).Layout __EE3477476, E_Watercraft_Owner(__in,__cfg_Local).Layout __EE6299743) := __EEQP(__EE6299743.W_Craft_,__EE3477476.UID);
  SHARED __EE6299760 := JOIN(__EE3477476,__EE6299743,__JC6299749(LEFT,RIGHT),TRANSFORM(E_Watercraft(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6299762 := __EE6299760;
  EXPORT Res62 := __UNWRAP(__EE6299762);
  SHARED __EE3477572 := __E_Zip_Code;
  SHARED __EE3477562 := __E_Zip_Code_Person;
  SHARED __EE6299912 := __EE3477562(__NN(__EE3477562.Subject_) AND __NN(__EE3477562.Zip_));
  SHARED __EE6299797 := __ENH_Person;
  SHARED __EE6299961 := __EE6299797(__T(__OP2(__EE6299797.UID,=,__CN(__PPersonUID))));
  __JC6299967(E_Zip_Code_Person(__in,__cfg_Local).Layout __EE6299912, B_Person(__in,__cfg_Local).__ST131971_Layout __EE6299961) := __EEQP(__EE6299961.UID,__EE6299912.Subject_);
  SHARED __EE6299975 := JOIN(__EE6299912,__EE6299961,__JC6299967(LEFT,RIGHT),TRANSFORM(E_Zip_Code_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6299981(E_Zip_Code(__in,__cfg_Local).Layout __EE3477572, E_Zip_Code_Person(__in,__cfg_Local).Layout __EE6299975) := __EEQP(__EE6299975.Zip_,__EE3477572.UID);
  SHARED __EE6299992 := JOIN(__EE3477572,__EE6299975,__JC6299981(LEFT,RIGHT),TRANSFORM(E_Zip_Code(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6299994 := __EE6299992;
  EXPORT Res63 := __UNWRAP(__EE6299994);
  SHARED __EE3477658 := __E_Person_Email_Phone_Address;
  SHARED __EE6300106 := __EE3477658(__NN(__EE3477658.Subject_));
  SHARED __EE6300031 := __ENH_Person;
  SHARED __EE6300111 := __EE6300031(__T(__OP2(__EE6300031.UID,=,__CN(__PPersonUID))));
  __JC6300117(E_Person_Email_Phone_Address(__in,__cfg_Local).Layout __EE6300106, B_Person(__in,__cfg_Local).__ST131971_Layout __EE6300111) := __EEQP(__EE6300111.UID,__EE6300106.Subject_);
  SHARED __EE6300137 := JOIN(__EE6300106,__EE6300111,__JC6300117(LEFT,RIGHT),TRANSFORM(E_Person_Email_Phone_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6300139 := __EE6300137;
  EXPORT Res64 := __UNWRAP(__EE6300139);
  SHARED __EE6300180 := __ENH_Address;
  SHARED __EE3477729 := __E_Address_Phone;
  SHARED __EE6300588 := __EE3477729(__NN(__EE3477729.Phone_Number_) AND __NN(__EE3477729.Location_));
  SHARED __EE3477723 := __E_Phone;
  SHARED __EE6300804 := __EE3477723(__T(__OP2(__EE3477723.UID,=,__CN(__PPhoneUID))));
  __JC6300810(E_Address_Phone(__in,__cfg_Local).Layout __EE6300588, E_Phone(__in,__cfg_Local).Layout __EE6300804) := __EEQP(__EE6300804.UID,__EE6300588.Phone_Number_);
  SHARED __EE6300838 := JOIN(__EE6300588,__EE6300804,__JC6300810(LEFT,RIGHT),TRANSFORM(E_Address_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6300844(B_Address_1(__in,__cfg_Local).__ST134443_Layout __EE6300180, E_Address_Phone(__in,__cfg_Local).Layout __EE6300838) := __EEQP(__EE6300838.Location_,__EE6300180.UID);
  SHARED __EE6301002 := JOIN(__EE6300180,__EE6300838,__JC6300844(LEFT,RIGHT),TRANSFORM(B_Address_1(__in,__cfg_Local).__ST134443_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6301004 := __EE6301002;
  EXPORT Res65 := __UNWRAP(__EE6301004);
  SHARED __EE6301375 := __ENH_Person;
  SHARED __EE3478018 := __E_Person_Phone;
  SHARED __EE6303401 := __EE3478018(__NN(__EE3478018.Phone_Number_) AND __NN(__EE3478018.Subject_));
  SHARED __EE3478012 := __E_Phone;
  SHARED __EE6304429 := __EE3478012(__T(__OP2(__EE3478012.UID,=,__CN(__PPhoneUID))));
  __JC6304435(E_Person_Phone(__in,__cfg_Local).Layout __EE6303401, E_Phone(__in,__cfg_Local).Layout __EE6304429) := __EEQP(__EE6304429.UID,__EE6303401.Phone_Number_);
  SHARED __EE6304469 := JOIN(__EE6303401,__EE6304429,__JC6304435(LEFT,RIGHT),TRANSFORM(E_Person_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6304475(B_Person(__in,__cfg_Local).__ST131971_Layout __EE6301375, E_Person_Phone(__in,__cfg_Local).Layout __EE6304469) := __EEQP(__EE6304469.Subject_,__EE6301375.UID);
  SHARED __EE6305439 := JOIN(__EE6301375,__EE6304469,__JC6304475(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST131971_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6305441 := __EE6305439;
  EXPORT Res66 := __UNWRAP(__EE6305441);
  SHARED __EE3479177 := __E_Inquiry;
  SHARED __EE3479167 := __E_Phone_Inquiry;
  SHARED __EE6307559 := __EE3479167(__NN(__EE3479167.Phone_Number_) AND __NN(__EE3479167.Transaction_));
  SHARED __EE3479161 := __E_Phone;
  SHARED __EE6307658 := __EE3479161(__T(__OP2(__EE3479161.UID,=,__CN(__PPhoneUID))));
  __JC6307664(E_Phone_Inquiry(__in,__cfg_Local).Layout __EE6307559, E_Phone(__in,__cfg_Local).Layout __EE6307658) := __EEQP(__EE6307658.UID,__EE6307559.Phone_Number_);
  SHARED __EE6307673 := JOIN(__EE6307559,__EE6307658,__JC6307664(LEFT,RIGHT),TRANSFORM(E_Phone_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6307679(E_Inquiry(__in,__cfg_Local).Layout __EE3479177, E_Phone_Inquiry(__in,__cfg_Local).Layout __EE6307673) := __EEQP(__EE6307673.Transaction_,__EE3479177.UID);
  SHARED __EE6307739 := JOIN(__EE3479177,__EE6307673,__JC6307679(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6307741 := __EE6307739;
  EXPORT Res67 := __UNWRAP(__EE6307741);
  SHARED __EE3479327 := __E_T_I_N;
  SHARED __EE3479317 := __E_T_I_N_Phone_Number;
  SHARED __EE6307947 := __EE3479317(__NN(__EE3479317.Phone_Number_) AND __NN(__EE3479317.Tax_I_D_));
  SHARED __EE3479311 := __E_Phone;
  SHARED __EE6307992 := __EE3479311(__T(__OP2(__EE3479311.UID,=,__CN(__PPhoneUID))));
  __JC6307998(E_T_I_N_Phone_Number(__in,__cfg_Local).Layout __EE6307947, E_Phone(__in,__cfg_Local).Layout __EE6307992) := __EEQP(__EE6307992.UID,__EE6307947.Phone_Number_);
  SHARED __EE6308009 := JOIN(__EE6307947,__EE6307992,__JC6307998(LEFT,RIGHT),TRANSFORM(E_T_I_N_Phone_Number(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6308015(E_T_I_N(__in,__cfg_Local).Layout __EE3479327, E_T_I_N_Phone_Number(__in,__cfg_Local).Layout __EE6308009) := __EEQP(__EE6308009.Tax_I_D_,__EE3479327.UID);
  SHARED __EE6308019 := JOIN(__EE3479327,__EE6308009,__JC6308015(LEFT,RIGHT),TRANSFORM(E_T_I_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6308021 := __EE6308019;
  EXPORT Res68 := __UNWRAP(__EE6308021);
  SHARED __EE6308050 := __ENH_Second_Degree_Associations;
  SHARED __EE6308114 := __EE6308050(__NN(__EE6308050.First_Degree_Association_));
  SHARED __EE6308053 := __ENH_Person;
  SHARED __EE6308119 := __EE6308053(__T(__OP2(__EE6308053.UID,=,__CN(__PPersonUID))));
  __JC6308125(E_Second_Degree_Associations(__in,__cfg_Local).Layout __EE6308114, B_Person(__in,__cfg_Local).__ST131971_Layout __EE6308119) := __EEQP(__EE6308119.UID,__EE6308114.First_Degree_Association_);
  SHARED __EE6308137 := JOIN(__EE6308114,__EE6308119,__JC6308125(LEFT,RIGHT),TRANSFORM(E_Second_Degree_Associations(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6308139 := __EE6308137;
  EXPORT Res69 := __UNWRAP(__EE6308139);
  SHARED __EE6308164 := __ENH_Person;
  SHARED __EE3479482 := __E_Person_Property_Event;
  SHARED __EE6310380 := __EE3479482(__NN(__EE3479482.Event_) AND __NN(__EE3479482.Subject_));
  SHARED __EE6308167 := __ENH_Property_Event;
  SHARED __EE6310357 := __EE6308167(__NN(__EE6308167.Prop_));
  SHARED __EE6308170 := __ENH_Property;
  SHARED __EE6311393 := __EE6308170(__T(__OP2(__EE6308170.UID,=,__CN(__PPropertyUID))));
  __JC6311399(B_Property_Event_4(__in,__cfg_Local).__ST191134_Layout __EE6310357, B_Property(__in,__cfg_Local).__ST132820_Layout __EE6311393) := __EEQP(__EE6311393.UID,__EE6310357.Prop_);
  SHARED __EE6311466 := JOIN(__EE6310357,__EE6311393,__JC6311399(LEFT,RIGHT),TRANSFORM(B_Property_Event_4(__in,__cfg_Local).__ST191134_Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6311472(E_Person_Property_Event(__in,__cfg_Local).Layout __EE6310380, B_Property_Event_4(__in,__cfg_Local).__ST191134_Layout __EE6311466) := __EEQP(__EE6311466.UID,__EE6310380.Event_);
  SHARED __EE6311491 := JOIN(__EE6310380,__EE6311466,__JC6311472(LEFT,RIGHT),TRANSFORM(E_Person_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6311497(B_Person(__in,__cfg_Local).__ST131971_Layout __EE6308164, E_Person_Property_Event(__in,__cfg_Local).Layout __EE6311491) := __EEQP(__EE6311491.Subject_,__EE6308164.UID);
  SHARED __EE6312461 := JOIN(__EE6308164,__EE6311491,__JC6311497(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST131971_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6312463 := __EE6312461;
  EXPORT Res70 := __UNWRAP(__EE6312463);
  SHARED __EE6314560 := __ENH_Business_Sele;
  SHARED __EE3480708 := __E_Sele_Property_Event;
  SHARED __EE6317880 := __EE3480708(__NN(__EE3480708.Event_) AND __NN(__EE3480708.Legal_));
  SHARED __EE6314563 := __ENH_Property_Event;
  SHARED __EE6317857 := __EE6314563(__NN(__EE6314563.Prop_));
  SHARED __EE6314566 := __ENH_Property;
  SHARED __EE6319445 := __EE6314566(__T(__OP2(__EE6314566.UID,=,__CN(__PPropertyUID))));
  __JC6319451(B_Property_Event_4(__in,__cfg_Local).__ST191134_Layout __EE6317857, B_Property(__in,__cfg_Local).__ST132820_Layout __EE6319445) := __EEQP(__EE6319445.UID,__EE6317857.Prop_);
  SHARED __EE6319518 := JOIN(__EE6317857,__EE6319445,__JC6319451(LEFT,RIGHT),TRANSFORM(B_Property_Event_4(__in,__cfg_Local).__ST191134_Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6319524(E_Sele_Property_Event(__in,__cfg_Local).Layout __EE6317880, B_Property_Event_4(__in,__cfg_Local).__ST191134_Layout __EE6319518) := __EEQP(__EE6319518.UID,__EE6317880.Event_);
  SHARED __EE6319546 := JOIN(__EE6317880,__EE6319518,__JC6319524(LEFT,RIGHT),TRANSFORM(E_Sele_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6319552(B_Business_Sele(__in,__cfg_Local).__ST118126_Layout __EE6314560, E_Sele_Property_Event(__in,__cfg_Local).Layout __EE6319546) := __EEQP(__EE6319546.Legal_,__EE6314560.UID);
  SHARED __EE6321065 := JOIN(__EE6314560,__EE6319546,__JC6319552(LEFT,RIGHT),TRANSFORM(B_Business_Sele(__in,__cfg_Local).__ST118126_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6321067 := __EE6321065;
  EXPORT Res71 := __UNWRAP(__EE6321067);
  SHARED __EE6324268 := __ENH_Person;
  SHARED __EE3482506 := __E_Person_S_S_N;
  SHARED __EE6326272 := __EE3482506(__NN(__EE3482506.Social_) AND __NN(__EE3482506.Subject_));
  SHARED __EE3482500 := __E_Social_Security_Number;
  SHARED __EE6327278 := __EE3482500(__T(__OP2(__EE3482500.UID,=,__CN(__PSocialSecurityNumberUID))));
  __JC6327284(E_Person_S_S_N(__in,__cfg_Local).Layout __EE6326272, E_Social_Security_Number(__in,__cfg_Local).Layout __EE6327278) := __EEQP(__EE6327278.UID,__EE6326272.Social_);
  SHARED __EE6327296 := JOIN(__EE6326272,__EE6327278,__JC6327284(LEFT,RIGHT),TRANSFORM(E_Person_S_S_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6327302(B_Person(__in,__cfg_Local).__ST131971_Layout __EE6324268, E_Person_S_S_N(__in,__cfg_Local).Layout __EE6327296) := __EEQP(__EE6327296.Subject_,__EE6324268.UID);
  SHARED __EE6328266 := JOIN(__EE6324268,__EE6327296,__JC6327302(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST131971_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6328268 := __EE6328266;
  EXPORT Res72 := __UNWRAP(__EE6328268);
  SHARED __EE6330219 := __ENH_Address;
  SHARED __EE3483631 := __E_S_S_N_Address;
  SHARED __EE6330615 := __EE3483631(__NN(__EE3483631.Social_) AND __NN(__EE3483631.Location_));
  SHARED __EE3483625 := __E_Social_Security_Number;
  SHARED __EE6330819 := __EE3483625(__T(__OP2(__EE3483625.UID,=,__CN(__PSocialSecurityNumberUID))));
  __JC6330825(E_S_S_N_Address(__in,__cfg_Local).Layout __EE6330615, E_Social_Security_Number(__in,__cfg_Local).Layout __EE6330819) := __EEQP(__EE6330819.UID,__EE6330615.Social_);
  SHARED __EE6330841 := JOIN(__EE6330615,__EE6330819,__JC6330825(LEFT,RIGHT),TRANSFORM(E_S_S_N_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6330847(B_Address_1(__in,__cfg_Local).__ST134443_Layout __EE6330219, E_S_S_N_Address(__in,__cfg_Local).Layout __EE6330841) := __EEQP(__EE6330841.Location_,__EE6330219.UID);
  SHARED __EE6331005 := JOIN(__EE6330219,__EE6330841,__JC6330847(LEFT,RIGHT),TRANSFORM(B_Address_1(__in,__cfg_Local).__ST134443_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6331007 := __EE6331005;
  EXPORT Res73 := __UNWRAP(__EE6331007);
  SHARED __EE3483916 := __E_Inquiry;
  SHARED __EE3483906 := __E_S_S_N_Inquiry;
  SHARED __EE6331477 := __EE3483906(__NN(__EE3483906.S_S_N_) AND __NN(__EE3483906.Transaction_));
  SHARED __EE3483900 := __E_Social_Security_Number;
  SHARED __EE6331576 := __EE3483900(__T(__OP2(__EE3483900.UID,=,__CN(__PSocialSecurityNumberUID))));
  __JC6331582(E_S_S_N_Inquiry(__in,__cfg_Local).Layout __EE6331477, E_Social_Security_Number(__in,__cfg_Local).Layout __EE6331576) := __EEQP(__EE6331576.UID,__EE6331477.S_S_N_);
  SHARED __EE6331591 := JOIN(__EE6331477,__EE6331576,__JC6331582(LEFT,RIGHT),TRANSFORM(E_S_S_N_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6331597(E_Inquiry(__in,__cfg_Local).Layout __EE3483916, E_S_S_N_Inquiry(__in,__cfg_Local).Layout __EE6331591) := __EEQP(__EE6331591.Transaction_,__EE3483916.UID);
  SHARED __EE6331657 := JOIN(__EE3483916,__EE6331591,__JC6331597(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6331659 := __EE6331657;
  EXPORT Res74 := __UNWRAP(__EE6331659);
  SHARED __EE3484066 := __E_Inquiry;
  SHARED __EE3484056 := __E_T_I_N_Inquiry;
  SHARED __EE6331919 := __EE3484056(__NN(__EE3484056.Tax_I_D_) AND __NN(__EE3484056.Transaction_));
  SHARED __EE3484050 := __E_T_I_N;
  SHARED __EE6332018 := __EE3484050(__T(__OP2(__EE3484050.UID,=,__CN(__PTINUID))));
  __JC6332024(E_T_I_N_Inquiry(__in,__cfg_Local).Layout __EE6331919, E_T_I_N(__in,__cfg_Local).Layout __EE6332018) := __EEQP(__EE6332018.UID,__EE6331919.Tax_I_D_);
  SHARED __EE6332033 := JOIN(__EE6331919,__EE6332018,__JC6332024(LEFT,RIGHT),TRANSFORM(E_T_I_N_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6332039(E_Inquiry(__in,__cfg_Local).Layout __EE3484066, E_T_I_N_Inquiry(__in,__cfg_Local).Layout __EE6332033) := __EEQP(__EE6332033.Transaction_,__EE3484066.UID);
  SHARED __EE6332099 := JOIN(__EE3484066,__EE6332033,__JC6332039(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6332101 := __EE6332099;
  EXPORT Res75 := __UNWRAP(__EE6332101);
  SHARED __EE6332238 := __ENH_Address;
  SHARED __EE3484206 := __E_T_I_N_Address;
  SHARED __EE6332633 := __EE3484206(__NN(__EE3484206.Tax_I_D_) AND __NN(__EE3484206.Location_));
  SHARED __EE3484200 := __E_T_I_N;
  SHARED __EE6332836 := __EE3484200(__T(__OP2(__EE3484200.UID,=,__CN(__PTINUID))));
  __JC6332842(E_T_I_N_Address(__in,__cfg_Local).Layout __EE6332633, E_T_I_N(__in,__cfg_Local).Layout __EE6332836) := __EEQP(__EE6332836.UID,__EE6332633.Tax_I_D_);
  SHARED __EE6332857 := JOIN(__EE6332633,__EE6332836,__JC6332842(LEFT,RIGHT),TRANSFORM(E_T_I_N_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6332863(B_Address_1(__in,__cfg_Local).__ST134443_Layout __EE6332238, E_T_I_N_Address(__in,__cfg_Local).Layout __EE6332857) := __EEQP(__EE6332857.Location_,__EE6332238.UID);
  SHARED __EE6333021 := JOIN(__EE6332238,__EE6332857,__JC6332863(LEFT,RIGHT),TRANSFORM(B_Address_1(__in,__cfg_Local).__ST134443_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6333023 := __EE6333021;
  EXPORT Res76 := __UNWRAP(__EE6333023);
  SHARED __EE3484490 := __E_Phone;
  SHARED __EE3484480 := __E_T_I_N_Phone_Number;
  SHARED __EE6333486 := __EE3484480(__NN(__EE3484480.Tax_I_D_) AND __NN(__EE3484480.Phone_Number_));
  SHARED __EE3484474 := __E_T_I_N;
  SHARED __EE6333580 := __EE3484474(__T(__OP2(__EE3484474.UID,=,__CN(__PTINUID))));
  __JC6333586(E_T_I_N_Phone_Number(__in,__cfg_Local).Layout __EE6333486, E_T_I_N(__in,__cfg_Local).Layout __EE6333580) := __EEQP(__EE6333580.UID,__EE6333486.Tax_I_D_);
  SHARED __EE6333597 := JOIN(__EE6333486,__EE6333580,__JC6333586(LEFT,RIGHT),TRANSFORM(E_T_I_N_Phone_Number(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6333603(E_Phone(__in,__cfg_Local).Layout __EE3484490, E_T_I_N_Phone_Number(__in,__cfg_Local).Layout __EE6333597) := __EEQP(__EE6333597.Phone_Number_,__EE3484490.UID);
  SHARED __EE6333656 := JOIN(__EE3484490,__EE6333597,__JC6333603(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6333658 := __EE6333656;
  EXPORT Res77 := __UNWRAP(__EE6333658);
  SHARED __EE6333785 := __ENH_Person;
  SHARED __EE3484628 := __E_Zip_Code_Person;
  SHARED __EE6335785 := __EE3484628(__NN(__EE3484628.Zip_) AND __NN(__EE3484628.Subject_));
  SHARED __EE3484622 := __E_Zip_Code;
  SHARED __EE6336787 := __EE3484622(__T(__OP2(__EE3484622.UID,=,__CN(__PZipCodeUID))));
  __JC6336793(E_Zip_Code_Person(__in,__cfg_Local).Layout __EE6335785, E_Zip_Code(__in,__cfg_Local).Layout __EE6336787) := __EEQP(__EE6336787.UID,__EE6335785.Zip_);
  SHARED __EE6336801 := JOIN(__EE6335785,__EE6336787,__JC6336793(LEFT,RIGHT),TRANSFORM(E_Zip_Code_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6336807(B_Person(__in,__cfg_Local).__ST131971_Layout __EE6333785, E_Zip_Code_Person(__in,__cfg_Local).Layout __EE6336801) := __EEQP(__EE6336801.Subject_,__EE6333785.UID);
  SHARED __EE6337771 := JOIN(__EE6333785,__EE6336801,__JC6336807(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST131971_Layout,SELF:=LEFT),SMART,KEEP(1));
  EXPORT Res78 := __UNWRAP(__EE6337771);
END;
