//HPCC Systems KEL Compiler Version 1.3.0beta5
IMPORT KEL13 AS KEL;
IMPORT B_Address,B_Address_1,B_Address_2,B_Address_3,B_Address_4,B_Address_5,B_Address_6,B_Aircraft_Owner_1,B_Aircraft_Owner_2,B_Aircraft_Owner_3,B_Bankruptcy,B_Bankruptcy_1,B_Bankruptcy_2,B_Bankruptcy_3,B_Bankruptcy_4,B_Bankruptcy_5,B_Bankruptcy_6,B_Bankruptcy_7,B_Bankruptcy_8,B_Business_Prox,B_Business_Prox_1,B_Business_Prox_2,B_Business_Prox_3,B_Business_Sele,B_Business_Sele_1,B_Business_Sele_10,B_Business_Sele_2,B_Business_Sele_3,B_Business_Sele_4,B_Business_Sele_5,B_Business_Sele_6,B_Business_Sele_7,B_Business_Sele_8,B_Business_Sele_9,B_Criminal_Offense,B_Criminal_Offense_1,B_Criminal_Offense_2,B_Criminal_Offense_3,B_Criminal_Offense_4,B_Criminal_Offense_5,B_Education,B_Education_1,B_Education_2,B_Education_3,B_Education_4,B_Education_5,B_Education_6,B_Education_7,B_First_Degree_Relative,B_First_Degree_Relative_1,B_First_Degree_Relative_2,B_First_Degree_Relative_3,B_First_Degree_Relative_4,B_First_Degree_Relative_5,B_Input_B_I_I_1,B_Input_B_I_I_10,B_Input_B_I_I_2,B_Input_B_I_I_3,B_Input_B_I_I_4,B_Input_B_I_I_5,B_Input_B_I_I_6,B_Input_B_I_I_7,B_Input_B_I_I_8,B_Input_B_I_I_9,B_Input_P_I_I_2,B_Input_P_I_I_3,B_Input_P_I_I_4,B_Input_P_I_I_5,B_Input_P_I_I_6,B_Input_P_I_I_7,B_Input_P_I_I_8,B_Input_P_I_I_9,B_Lien_Judgment,B_Lien_Judgment_1,B_Lien_Judgment_10,B_Lien_Judgment_11,B_Lien_Judgment_12,B_Lien_Judgment_2,B_Lien_Judgment_3,B_Lien_Judgment_4,B_Lien_Judgment_5,B_Lien_Judgment_6,B_Lien_Judgment_7,B_Lien_Judgment_8,B_Lien_Judgment_9,B_Person,B_Person_1,B_Person_2,B_Person_3,B_Person_4,B_Person_5,B_Person_6,B_Person_7,B_Person_8,B_Person_Address_2,B_Person_Address_3,B_Person_Lien_Judgment_8,B_Person_Vehicle_1,B_Person_Vehicle_2,B_Person_Vehicle_3,B_Professional_License,B_Professional_License_1,B_Professional_License_2,B_Professional_License_3,B_Professional_License_4,B_Professional_License_5,B_Property,B_Property_1,B_Property_2,B_Property_3,B_Property_4,B_Property_5,B_Property_Event,B_Property_Event_1,B_Property_Event_2,B_Property_Event_3,B_Property_Event_4,B_Property_Event_5,B_Second_Degree_Associations,B_Sele_Address_1,B_Sele_Address_2,B_Sele_Address_3,B_Sele_Address_4,B_Sele_Address_5,B_Sele_Address_6,B_Sele_Lien_Judgment_11,B_Sele_Person_1,B_Sele_Person_2,B_Sele_Person_3,B_Sele_Person_4,B_Sele_Person_5,B_Sele_Person_6,B_Sele_Person_7,B_Sele_Phone_Number_3,B_Sele_Phone_Number_4,B_Sele_Phone_Number_5,B_Sele_Phone_Number_6,B_Sele_Property_1,B_Sele_Property_2,B_Sele_Property_3,B_Sele_Property_4,B_Sele_T_I_N_3,B_Sele_T_I_N_4,B_Sele_T_I_N_5,B_Sele_T_I_N_6,B_Sele_Tradeline_1,B_Sele_Tradeline_2,B_Sele_Tradeline_3,B_Sele_U_C_C_2,B_Sele_U_C_C_3,B_Sele_U_C_C_4,B_Sele_U_C_C_5,B_Sele_U_C_C_6,B_Sele_U_C_C_7,B_Sele_U_C_C_8,B_Sele_U_C_C_9,B_Sele_Vehicle_1,B_Sele_Vehicle_2,B_Sele_Vehicle_3,B_Tradeline,B_Tradeline_1,B_Tradeline_10,B_Tradeline_2,B_Tradeline_3,B_Tradeline_4,B_Tradeline_5,B_Tradeline_6,B_Tradeline_7,B_Tradeline_8,B_Tradeline_9,B_U_C_C,B_U_C_C_1,B_U_C_C_10,B_U_C_C_11,B_U_C_C_12,B_U_C_C_13,B_U_C_C_2,B_U_C_C_3,B_U_C_C_4,B_U_C_C_5,B_U_C_C_6,B_U_C_C_7,B_U_C_C_8,B_U_C_C_9,B_Watercraft_Owner_1,B_Watercraft_Owner_2,B_Watercraft_Owner_3,CFG_Compile,E_Accident,E_Address,E_Address_Inquiry,E_Address_Phone,E_Address_Property,E_Address_Property_Event,E_Aircraft,E_Aircraft_Owner,E_Bankruptcy,E_Business_Org,E_Business_Prox,E_Business_Sele,E_Business_Ult,E_Criminal_Details,E_Criminal_Offender,E_Criminal_Offense,E_Criminal_Punishment,E_Drivers_License,E_E_B_R_Tradeline,E_Education,E_Email,E_Email_Inquiry,E_First_Degree_Associations,E_First_Degree_Relative,E_Geo_Link,E_House_Hold_Phone,E_Household,E_Household_Member,E_Input_B_I_I,E_Input_B_I_I_Input_P_I_I,E_Input_P_I_I,E_Inquiry,E_Lien_Judgment,E_Person,E_Person_Accident,E_Person_Address,E_Person_Bankruptcy,E_Person_Drivers_License,E_Person_Education,E_Person_Email,E_Person_Email_Phone_Address,E_Person_Inquiry,E_Person_Lien_Judgment,E_Person_Offender,E_Person_Offenses,E_Person_Phone,E_Person_Property,E_Person_Property_Event,E_Person_S_S_N,E_Person_U_C_C,E_Person_Vehicle,E_Phone,E_Phone_Inquiry,E_Professional_License,E_Professional_License_Person,E_Property,E_Property_Event,E_Prox_Address,E_Prox_Email,E_Prox_Person,E_Prox_Phone_Number,E_Prox_T_I_N,E_Prox_Utility,E_S_S_N_Address,E_S_S_N_Inquiry,E_Second_Degree_Associations,E_Sele_Address,E_Sele_Aircraft,E_Sele_Bankruptcy,E_Sele_E_B_R_Tradeline,E_Sele_Email,E_Sele_Inquiry,E_Sele_Lien_Judgment,E_Sele_Person,E_Sele_Phone_Number,E_Sele_Property,E_Sele_Property_Event,E_Sele_T_I_N,E_Sele_Tradeline,E_Sele_U_C_C,E_Sele_Utility,E_Sele_Vehicle,E_Sele_Watercraft,E_Social_Security_Number,E_Surname,E_T_I_N,E_T_I_N_Address,E_T_I_N_Inquiry,E_T_I_N_Phone_Number,E_Tradeline,E_U_C_C,E_Utility,E_Utility_Address,E_Utility_Person,E_Vehicle,E_Watercraft,E_Watercraft_Owner,E_Zip_Code,E_Zip_Code_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT Q_Index_Build_Association(KEL.typ.uid __PAddressUID, KEL.typ.uid __PBusinessProxUID, KEL.typ.uid __PBusinessSeleUID, KEL.typ.uid __PCriminalOffenderUID, KEL.typ.uid __PPersonUID, KEL.typ.uid __PHouseholdUID, KEL.typ.uid __PPhoneUID, KEL.typ.uid __PEmailUID, KEL.typ.uid __PPropertyUID, KEL.typ.uid __PSocialSecurityNumberUID, KEL.typ.uid __PTINUID, KEL.typ.uid __PZipCodeUID, KEL.typ.kdate __PP_InpClnArchDt, DATA100 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
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
  SHARED E_Person_U_C_C_Filtered := MODULE(E_Person_U_C_C(__in,__cfg_Local))
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
    SHARED TYPEOF(E_Person(__in,__cfg_Local).__Result) __E_Person := E_Person_Filtered.__Result;
    SHARED TYPEOF(E_Person_Address(__in,__cfg_Local).__Result) __E_Person_Address := E_Person_Address_Filtered.__Result;
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
    SHARED TYPEOF(B_Address_3(__in,__cfg_Local).__ENH_Address_3) __ENH_Address_3 := B_Address_3_Local.__ENH_Address_3;
    SHARED TYPEOF(E_Address_Property_Event(__in,__cfg_Local).__Result) __E_Address_Property_Event := E_Address_Property_Event_Filtered.__Result;
    SHARED TYPEOF(B_Bankruptcy_3(__in,__cfg_Local).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local.__ENH_Bankruptcy_3;
    SHARED TYPEOF(B_Business_Prox_3(__in,__cfg_Local).__ENH_Business_Prox_3) __ENH_Business_Prox_3 := B_Business_Prox_3_Local.__ENH_Business_Prox_3;
    SHARED TYPEOF(B_Business_Sele_3(__in,__cfg_Local).__ENH_Business_Sele_3) __ENH_Business_Sele_3 := B_Business_Sele_3_Local.__ENH_Business_Sele_3;
    SHARED TYPEOF(B_Input_B_I_I_3(__in,__cfg_Local).__ENH_Input_B_I_I_3) __ENH_Input_B_I_I_3 := B_Input_B_I_I_3_Local.__ENH_Input_B_I_I_3;
    SHARED TYPEOF(B_Person_3(__in,__cfg_Local).__ENH_Person_3) __ENH_Person_3 := B_Person_3_Local.__ENH_Person_3;
    SHARED TYPEOF(B_Property_Event_3(__in,__cfg_Local).__ENH_Property_Event_3) __ENH_Property_Event_3 := B_Property_Event_3_Local.__ENH_Property_Event_3;
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
    SHARED TYPEOF(B_Watercraft_Owner_3(__in,__cfg_Local).__ENH_Watercraft_Owner_3) __ENH_Watercraft_Owner_3 := B_Watercraft_Owner_3_Local.__ENH_Watercraft_Owner_3;
  END;
  SHARED B_Person_Address_2_Local := MODULE(B_Person_Address_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Address_3(__in,__cfg_Local).__ENH_Person_Address_3) __ENH_Person_Address_3 := B_Person_Address_3_Local.__ENH_Person_Address_3;
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
    SHARED TYPEOF(B_Address_2(__in,__cfg_Local).__ENH_Address_2) __ENH_Address_2 := B_Address_2_Local.__ENH_Address_2;
    SHARED TYPEOF(E_Address_Property_Event(__in,__cfg_Local).__Result) __E_Address_Property_Event := E_Address_Property_Event_Filtered.__Result;
    SHARED TYPEOF(B_Bankruptcy_2(__in,__cfg_Local).__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local.__ENH_Bankruptcy_2;
    SHARED TYPEOF(B_Business_Prox_2(__in,__cfg_Local).__ENH_Business_Prox_2) __ENH_Business_Prox_2 := B_Business_Prox_2_Local.__ENH_Business_Prox_2;
    SHARED TYPEOF(B_Business_Sele_2(__in,__cfg_Local).__ENH_Business_Sele_2) __ENH_Business_Sele_2 := B_Business_Sele_2_Local.__ENH_Business_Sele_2;
    SHARED TYPEOF(B_Input_B_I_I_2(__in,__cfg_Local).__ENH_Input_B_I_I_2) __ENH_Input_B_I_I_2 := B_Input_B_I_I_2_Local.__ENH_Input_B_I_I_2;
    SHARED TYPEOF(B_Person_2(__in,__cfg_Local).__ENH_Person_2) __ENH_Person_2 := B_Person_2_Local.__ENH_Person_2;
    SHARED TYPEOF(E_Person_Email(__in,__cfg_Local).__Result) __E_Person_Email := E_Person_Email_Filtered.__Result;
    SHARED TYPEOF(B_Property_Event_2(__in,__cfg_Local).__ENH_Property_Event_2) __ENH_Property_Event_2 := B_Property_Event_2_Local.__ENH_Property_Event_2;
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
  SHARED B_First_Degree_Relative_1_Local := MODULE(B_First_Degree_Relative_1(__in,__cfg_Local))
    SHARED TYPEOF(B_First_Degree_Relative_2(__in,__cfg_Local).__ENH_First_Degree_Relative_2) __ENH_First_Degree_Relative_2 := B_First_Degree_Relative_2_Local.__ENH_First_Degree_Relative_2;
  END;
  SHARED B_Input_B_I_I_1_Local := MODULE(B_Input_B_I_I_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_2(__in,__cfg_Local).__ENH_Input_B_I_I_2) __ENH_Input_B_I_I_2 := B_Input_B_I_I_2_Local.__ENH_Input_B_I_I_2;
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
    SHARED TYPEOF(B_Person_2(__in,__cfg_Local).__ENH_Person_2) __ENH_Person_2 := B_Person_2_Local.__ENH_Person_2;
    SHARED TYPEOF(B_Person_Address_2(__in,__cfg_Local).__ENH_Person_Address_2) __ENH_Person_Address_2 := B_Person_Address_2_Local.__ENH_Person_Address_2;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(E_Person_Education(__in,__cfg_Local).__Result) __E_Person_Education := E_Person_Education_Filtered.__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg_Local).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
    SHARED TYPEOF(B_Person_Vehicle_2(__in,__cfg_Local).__ENH_Person_Vehicle_2) __ENH_Person_Vehicle_2 := B_Person_Vehicle_2_Local.__ENH_Person_Vehicle_2;
    SHARED TYPEOF(B_Professional_License_2(__in,__cfg_Local).__ENH_Professional_License_2) __ENH_Professional_License_2 := B_Professional_License_2_Local.__ENH_Professional_License_2;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg_Local).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered.__Result;
    SHARED TYPEOF(B_Watercraft_Owner_2(__in,__cfg_Local).__ENH_Watercraft_Owner_2) __ENH_Watercraft_Owner_2 := B_Watercraft_Owner_2_Local.__ENH_Watercraft_Owner_2;
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
    SHARED TYPEOF(B_Property_Event_1(__in,__cfg_Local).__ENH_Property_Event_1) __ENH_Property_Event_1 := B_Property_Event_1_Local.__ENH_Property_Event_1;
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
  SHARED TYPEOF(E_Person_U_C_C(__in,__cfg_Local).__Result) __E_Person_U_C_C := E_Person_U_C_C_Filtered.__Result;
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
  SHARED __EE3466134 := __E_Inquiry;
  SHARED __EE3466124 := __E_Address_Inquiry;
  SHARED __EE6453135 := __EE3466124(__NN(__EE3466124.Location_) AND __NN(__EE3466124.Transaction_));
  SHARED __EE3466118 := __E_Address;
  SHARED __EE6453241 := __EE3466118(__T(__OP2(__EE3466118.UID,=,__CN(__PAddressUID))));
  __JC6453247(E_Address_Inquiry(__in,__cfg_Local).Layout __EE6453135, E_Address(__in,__cfg_Local).Layout __EE6453241) := __EEQP(__EE6453241.UID,__EE6453135.Location_);
  SHARED __EE6453263 := JOIN(__EE6453135,__EE6453241,__JC6453247(LEFT,RIGHT),TRANSFORM(E_Address_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6453269(E_Inquiry(__in,__cfg_Local).Layout __EE3466134, E_Address_Inquiry(__in,__cfg_Local).Layout __EE6453263) := __EEQP(__EE6453263.Transaction_,__EE3466134.UID);
  SHARED __EE6453329 := JOIN(__EE3466134,__EE6453263,__JC6453269(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6453331 := __EE6453329;
  EXPORT Res0 := __UNWRAP(__EE6453331);
  SHARED __EE3466292 := __E_Phone;
  SHARED __EE3466282 := __E_Address_Phone;
  SHARED __EE6453617 := __EE3466282(__NN(__EE3466282.Location_) AND __NN(__EE3466282.Phone_Number_));
  SHARED __EE3466276 := __E_Address;
  SHARED __EE6453728 := __EE3466276(__T(__OP2(__EE3466276.UID,=,__CN(__PAddressUID))));
  __JC6453734(E_Address_Phone(__in,__cfg_Local).Layout __EE6453617, E_Address(__in,__cfg_Local).Layout __EE6453728) := __EEQP(__EE6453728.UID,__EE6453617.Location_);
  SHARED __EE6453762 := JOIN(__EE6453617,__EE6453728,__JC6453734(LEFT,RIGHT),TRANSFORM(E_Address_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6453768(E_Phone(__in,__cfg_Local).Layout __EE3466292, E_Address_Phone(__in,__cfg_Local).Layout __EE6453762) := __EEQP(__EE6453762.Phone_Number_,__EE3466292.UID);
  SHARED __EE6453821 := JOIN(__EE3466292,__EE6453762,__JC6453768(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6453823 := __EE6453821;
  EXPORT Res1 := __UNWRAP(__EE6453823);
  SHARED __EE6453984 := __ENH_Property;
  SHARED __EE3466449 := __E_Address_Property;
  SHARED __EE6454147 := __EE3466449(__NN(__EE3466449.Location_) AND __NN(__EE3466449.Prop_));
  SHARED __EE3466443 := __E_Address;
  SHARED __EE6454239 := __EE3466443(__T(__OP2(__EE3466443.UID,=,__CN(__PAddressUID))));
  __JC6454245(E_Address_Property(__in,__cfg_Local).Layout __EE6454147, E_Address(__in,__cfg_Local).Layout __EE6454239) := __EEQP(__EE6454239.UID,__EE6454147.Location_);
  SHARED __EE6454270 := JOIN(__EE6454147,__EE6454239,__JC6454245(LEFT,RIGHT),TRANSFORM(E_Address_Property(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6454276(B_Property(__in,__cfg_Local).__ST126787_Layout __EE6453984, E_Address_Property(__in,__cfg_Local).Layout __EE6454270) := __EEQP(__EE6454270.Prop_,__EE6453984.UID);
  SHARED __EE6454313 := JOIN(__EE6453984,__EE6454270,__JC6454276(LEFT,RIGHT),TRANSFORM(B_Property(__in,__cfg_Local).__ST126787_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6454315 := __EE6454313;
  EXPORT Res2 := __UNWRAP(__EE6454315);
  SHARED __EE6454438 := __ENH_Property_Event;
  SHARED __EE3466593 := __E_Address_Property_Event;
  SHARED __EE6455131 := __EE3466593(__NN(__EE3466593.Location_) AND __NN(__EE3466593.Event_));
  SHARED __EE3466587 := __E_Address;
  SHARED __EE6455488 := __EE3466587(__T(__OP2(__EE3466587.UID,=,__CN(__PAddressUID))));
  __JC6455494(E_Address_Property_Event(__in,__cfg_Local).Layout __EE6455131, E_Address(__in,__cfg_Local).Layout __EE6455488) := __EEQP(__EE6455488.UID,__EE6455131.Location_);
  SHARED __EE6455519 := JOIN(__EE6455131,__EE6455488,__JC6455494(LEFT,RIGHT),TRANSFORM(E_Address_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6455525(B_Property_Event_3(__in,__cfg_Local).__ST173128_Layout __EE6454438, E_Address_Property_Event(__in,__cfg_Local).Layout __EE6455519) := __EEQP(__EE6455519.Event_,__EE6454438.UID);
  SHARED __EE6455827 := JOIN(__EE6454438,__EE6455519,__JC6455525(LEFT,RIGHT),TRANSFORM(B_Property_Event_3(__in,__cfg_Local).__ST173128_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6455829 := __EE6455827;
  EXPORT Res3 := __UNWRAP(__EE6455829);
  SHARED __EE6456482 := __ENH_Person;
  SHARED __EE3467000 := __E_Person_Address;
  SHARED __EE6458258 := __EE3467000(__NN(__EE3467000.Location_) AND __NN(__EE3467000.Subject_));
  SHARED __EE3466994 := __E_Address;
  SHARED __EE6459168 := __EE3466994(__T(__OP2(__EE3466994.UID,=,__CN(__PAddressUID))));
  __JC6459174(E_Person_Address(__in,__cfg_Local).Layout __EE6458258, E_Address(__in,__cfg_Local).Layout __EE6459168) := __EEQP(__EE6459168.UID,__EE6458258.Location_);
  SHARED __EE6459222 := JOIN(__EE6458258,__EE6459168,__JC6459174(LEFT,RIGHT),TRANSFORM(E_Person_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6459228(B_Person(__in,__cfg_Local).__ST126252_Layout __EE6456482, E_Person_Address(__in,__cfg_Local).Layout __EE6459222) := __EEQP(__EE6459222.Subject_,__EE6456482.UID);
  SHARED __EE6460060 := JOIN(__EE6456482,__EE6459222,__JC6459228(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST126252_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6460062 := __EE6460060;
  EXPORT Res4 := __UNWRAP(__EE6460062);
  SHARED __EE6461821 := __ENH_Business_Prox;
  SHARED __EE3468023 := __E_Prox_Address;
  SHARED __EE6462461 := __EE3468023(__NN(__EE3468023.Location_) AND __NN(__EE3468023.Business_Location_));
  SHARED __EE3468017 := __E_Address;
  SHARED __EE6462807 := __EE3468017(__T(__OP2(__EE3468017.UID,=,__CN(__PAddressUID))));
  __JC6462813(E_Prox_Address(__in,__cfg_Local).Layout __EE6462461, E_Address(__in,__cfg_Local).Layout __EE6462807) := __EEQP(__EE6462807.UID,__EE6462461.Location_);
  SHARED __EE6462869 := JOIN(__EE6462461,__EE6462807,__JC6462813(LEFT,RIGHT),TRANSFORM(E_Prox_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6462875(B_Business_Prox(__in,__cfg_Local).__ST95570_Layout __EE6461821, E_Prox_Address(__in,__cfg_Local).Layout __EE6462869) := __EEQP(__EE6462869.Business_Location_,__EE6461821.UID);
  SHARED __EE6463135 := JOIN(__EE6461821,__EE6462869,__JC6462875(LEFT,RIGHT),TRANSFORM(B_Business_Prox(__in,__cfg_Local).__ST95570_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6463137 := __EE6463135;
  EXPORT Res5 := __UNWRAP(__EE6463137);
  SHARED __EE6463768 := __ENH_Business_Sele;
  SHARED __EE3468448 := __E_Sele_Address;
  SHARED __EE6466916 := __EE3468448(__NN(__EE3468448.Location_) AND __NN(__EE3468448.Legal_));
  SHARED __EE3468442 := __E_Address;
  SHARED __EE6468516 := __EE3468442(__T(__OP2(__EE3468442.UID,=,__CN(__PAddressUID))));
  __JC6468522(E_Sele_Address(__in,__cfg_Local).Layout __EE6466916, E_Address(__in,__cfg_Local).Layout __EE6468516) := __EEQP(__EE6468516.UID,__EE6466916.Location_);
  SHARED __EE6468578 := JOIN(__EE6466916,__EE6468516,__JC6468522(LEFT,RIGHT),TRANSFORM(E_Sele_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6468584(B_Business_Sele(__in,__cfg_Local).__ST113627_Layout __EE6463768, E_Sele_Address(__in,__cfg_Local).Layout __EE6468578) := __EEQP(__EE6468578.Legal_,__EE6463768.UID);
  SHARED __EE6470098 := JOIN(__EE6463768,__EE6468578,__JC6468584(LEFT,RIGHT),TRANSFORM(B_Business_Sele(__in,__cfg_Local).__ST113627_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6470100 := __EE6470098;
  EXPORT Res6 := __UNWRAP(__EE6470100);
  SHARED __EE3470215 := __E_T_I_N;
  SHARED __EE3470205 := __E_T_I_N_Address;
  SHARED __EE6473312 := __EE3470205(__NN(__EE3470205.Location_) AND __NN(__EE3470205.Tax_I_D_));
  SHARED __EE3470199 := __E_Address;
  SHARED __EE6473361 := __EE3470199(__T(__OP2(__EE3470199.UID,=,__CN(__PAddressUID))));
  __JC6473367(E_T_I_N_Address(__in,__cfg_Local).Layout __EE6473312, E_Address(__in,__cfg_Local).Layout __EE6473361) := __EEQP(__EE6473361.UID,__EE6473312.Location_);
  SHARED __EE6473382 := JOIN(__EE6473312,__EE6473361,__JC6473367(LEFT,RIGHT),TRANSFORM(E_T_I_N_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6473388(E_T_I_N(__in,__cfg_Local).Layout __EE3470215, E_T_I_N_Address(__in,__cfg_Local).Layout __EE6473382) := __EEQP(__EE6473382.Tax_I_D_,__EE3470215.UID);
  SHARED __EE6473392 := JOIN(__EE3470215,__EE6473382,__JC6473388(LEFT,RIGHT),TRANSFORM(E_T_I_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6473394 := __EE6473392;
  EXPORT Res7 := __UNWRAP(__EE6473394);
  SHARED __EE3470310 := __E_Utility;
  SHARED __EE3470300 := __E_Utility_Address;
  SHARED __EE6473525 := __EE3470300(__NN(__EE3470300.Location_) AND __NN(__EE3470300.Util_));
  SHARED __EE3470294 := __E_Address;
  SHARED __EE6473595 := __EE3470294(__T(__OP2(__EE3470294.UID,=,__CN(__PAddressUID))));
  __JC6473601(E_Utility_Address(__in,__cfg_Local).Layout __EE6473525, E_Address(__in,__cfg_Local).Layout __EE6473595) := __EEQP(__EE6473595.UID,__EE6473525.Location_);
  SHARED __EE6473615 := JOIN(__EE6473525,__EE6473595,__JC6473601(LEFT,RIGHT),TRANSFORM(E_Utility_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6473621(E_Utility(__in,__cfg_Local).Layout __EE3470310, E_Utility_Address(__in,__cfg_Local).Layout __EE6473615) := __EEQP(__EE6473615.Util_,__EE3470310.UID);
  SHARED __EE6473647 := JOIN(__EE3470310,__EE6473615,__JC6473621(LEFT,RIGHT),TRANSFORM(E_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6473649 := __EE6473647;
  EXPORT Res8 := __UNWRAP(__EE6473649);
  SHARED __EE6473728 := __ENH_Address;
  SHARED __EE3470418 := __E_Prox_Address;
  SHARED __EE6474238 := __EE3470418(__NN(__EE3470418.Business_Location_) AND __NN(__EE3470418.Location_));
  SHARED __EE6473731 := __ENH_Business_Prox;
  SHARED __EE6474482 := __EE6473731(__T(__OP2(__EE6473731.UID,=,__CN(__PBusinessProxUID))));
  __JC6474488(E_Prox_Address(__in,__cfg_Local).Layout __EE6474238, B_Business_Prox(__in,__cfg_Local).__ST95570_Layout __EE6474482) := __EEQP(__EE6474482.UID,__EE6474238.Business_Location_);
  SHARED __EE6474544 := JOIN(__EE6474238,__EE6474482,__JC6474488(LEFT,RIGHT),TRANSFORM(E_Prox_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6474550(B_Address_1(__in,__cfg_Local).__ST128087_Layout __EE6473728, E_Prox_Address(__in,__cfg_Local).Layout __EE6474544) := __EEQP(__EE6474544.Location_,__EE6473728.UID);
  SHARED __EE6474708 := JOIN(__EE6473728,__EE6474544,__JC6474550(LEFT,RIGHT),TRANSFORM(B_Address_1(__in,__cfg_Local).__ST128087_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6474710 := __EE6474708;
  EXPORT Res9 := __UNWRAP(__EE6474710);
  SHARED __EE6475137 := __ENH_Person;
  SHARED __EE3470740 := __E_Prox_Person;
  SHARED __EE6476939 := __EE3470740(__NN(__EE3470740.Business_Location_) AND __NN(__EE3470740.Contact_));
  SHARED __EE6475140 := __ENH_Business_Prox;
  SHARED __EE6477829 := __EE6475140(__T(__OP2(__EE6475140.UID,=,__CN(__PBusinessProxUID))));
  __JC6477835(E_Prox_Person(__in,__cfg_Local).Layout __EE6476939, B_Business_Prox(__in,__cfg_Local).__ST95570_Layout __EE6477829) := __EEQP(__EE6477829.UID,__EE6476939.Business_Location_);
  SHARED __EE6477863 := JOIN(__EE6476939,__EE6477829,__JC6477835(LEFT,RIGHT),TRANSFORM(E_Prox_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6477869(B_Person(__in,__cfg_Local).__ST126252_Layout __EE6475137, E_Prox_Person(__in,__cfg_Local).Layout __EE6477863) := __EEQP(__EE6477863.Contact_,__EE6475137.UID);
  SHARED __EE6478701 := JOIN(__EE6475137,__EE6477863,__JC6477869(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST126252_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6478703 := __EE6478701;
  EXPORT Res10 := __UNWRAP(__EE6478703);
  SHARED __EE3471752 := __E_Phone;
  SHARED __EE3471742 := __E_Prox_Phone_Number;
  SHARED __EE6480679 := __EE3471742(__NN(__EE3471742.Business_Location_) AND __NN(__EE3471742.Phone_Number_));
  SHARED __EE6480422 := __ENH_Business_Prox;
  SHARED __EE6480799 := __EE6480422(__T(__OP2(__EE6480422.UID,=,__CN(__PBusinessProxUID))));
  __JC6480805(E_Prox_Phone_Number(__in,__cfg_Local).Layout __EE6480679, B_Business_Prox(__in,__cfg_Local).__ST95570_Layout __EE6480799) := __EEQP(__EE6480799.UID,__EE6480679.Business_Location_);
  SHARED __EE6480842 := JOIN(__EE6480679,__EE6480799,__JC6480805(LEFT,RIGHT),TRANSFORM(E_Prox_Phone_Number(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6480848(E_Phone(__in,__cfg_Local).Layout __EE3471752, E_Prox_Phone_Number(__in,__cfg_Local).Layout __EE6480842) := __EEQP(__EE6480842.Phone_Number_,__EE3471752.UID);
  SHARED __EE6480901 := JOIN(__EE3471752,__EE6480842,__JC6480848(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6480903 := __EE6480901;
  EXPORT Res11 := __UNWRAP(__EE6480903);
  SHARED __EE3471931 := __E_T_I_N;
  SHARED __EE3471921 := __E_Prox_T_I_N;
  SHARED __EE6481195 := __EE3471921(__NN(__EE3471921.Business_Location_) AND __NN(__EE3471921.Tax_I_D_));
  SHARED __EE6481082 := __ENH_Business_Prox;
  SHARED __EE6481243 := __EE6481082(__T(__OP2(__EE6481082.UID,=,__CN(__PBusinessProxUID))));
  __JC6481249(E_Prox_T_I_N(__in,__cfg_Local).Layout __EE6481195, B_Business_Prox(__in,__cfg_Local).__ST95570_Layout __EE6481243) := __EEQP(__EE6481243.UID,__EE6481195.Business_Location_);
  SHARED __EE6481263 := JOIN(__EE6481195,__EE6481243,__JC6481249(LEFT,RIGHT),TRANSFORM(E_Prox_T_I_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6481269(E_T_I_N(__in,__cfg_Local).Layout __EE3471931, E_Prox_T_I_N(__in,__cfg_Local).Layout __EE6481263) := __EEQP(__EE6481263.Tax_I_D_,__EE3471931.UID);
  SHARED __EE6481273 := JOIN(__EE3471931,__EE6481263,__JC6481269(LEFT,RIGHT),TRANSFORM(E_T_I_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6481275 := __EE6481273;
  EXPORT Res12 := __UNWRAP(__EE6481275);
  SHARED __EE3472025 := __E_Utility;
  SHARED __EE3472015 := __E_Prox_Utility;
  SHARED __EE6481461 := __EE3472015(__NN(__EE3472015.Business_Location_) AND __NN(__EE3472015.Util_));
  SHARED __EE6481310 := __ENH_Business_Prox;
  SHARED __EE6481528 := __EE6481310(__T(__OP2(__EE6481310.UID,=,__CN(__PBusinessProxUID))));
  __JC6481534(E_Prox_Utility(__in,__cfg_Local).Layout __EE6481461, B_Business_Prox(__in,__cfg_Local).__ST95570_Layout __EE6481528) := __EEQP(__EE6481528.UID,__EE6481461.Business_Location_);
  SHARED __EE6481545 := JOIN(__EE6481461,__EE6481528,__JC6481534(LEFT,RIGHT),TRANSFORM(E_Prox_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6481551(E_Utility(__in,__cfg_Local).Layout __EE3472025, E_Prox_Utility(__in,__cfg_Local).Layout __EE6481545) := __EEQP(__EE6481545.Util_,__EE3472025.UID);
  SHARED __EE6481577 := JOIN(__EE3472025,__EE6481545,__JC6481551(LEFT,RIGHT),TRANSFORM(E_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6481579 := __EE6481577;
  EXPORT Res13 := __UNWRAP(__EE6481579);
  SHARED __EE3472141 := __E_Email;
  SHARED __EE3472131 := __E_Prox_Email;
  SHARED __EE6481837 := __EE3472131(__NN(__EE3472131.Business_Location_) AND __NN(__EE3472131.Email_));
  SHARED __EE6481652 := __ENH_Business_Prox;
  SHARED __EE6481921 := __EE6481652(__T(__OP2(__EE6481652.UID,=,__CN(__PBusinessProxUID))));
  __JC6481927(E_Prox_Email(__in,__cfg_Local).Layout __EE6481837, B_Business_Prox(__in,__cfg_Local).__ST95570_Layout __EE6481921) := __EEQP(__EE6481921.UID,__EE6481837.Business_Location_);
  SHARED __EE6481946 := JOIN(__EE6481837,__EE6481921,__JC6481927(LEFT,RIGHT),TRANSFORM(E_Prox_Email(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6481952(E_Email(__in,__cfg_Local).Layout __EE3472141, E_Prox_Email(__in,__cfg_Local).Layout __EE6481946) := __EEQP(__EE6481946.Email_,__EE3472141.UID);
  SHARED __EE6481987 := JOIN(__EE3472141,__EE6481946,__JC6481952(LEFT,RIGHT),TRANSFORM(E_Email(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6481989 := __EE6481987;
  EXPORT Res14 := __UNWRAP(__EE6481989);
  SHARED __EE6482096 := __ENH_Business_Sele;
  SHARED __EE6482099 := __ENH_Business_Prox;
  SHARED __EE6486717 := __EE6482099(__T(__AND(__OP2(__EE6482099.UID,=,__CN(__PBusinessProxUID)),__CN(__NN(__EE6482099.Prox_Sele_)))));
  __JC6486723(B_Business_Sele(__in,__cfg_Local).__ST113627_Layout __EE6482096, B_Business_Prox(__in,__cfg_Local).__ST95570_Layout __EE6486717) := __EEQP(__EE6486717.Prox_Sele_,__EE6482096.UID);
  SHARED __EE6488237 := JOIN(__EE6482096,__EE6486717,__JC6486723(LEFT,RIGHT),TRANSFORM(B_Business_Sele(__in,__cfg_Local).__ST113627_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6488239 := __EE6488237;
  EXPORT Res15 := __UNWRAP(__EE6488239);
  SHARED __EE3473948 := __E_E_B_R_Tradeline;
  SHARED __EE3473938 := __E_Sele_E_B_R_Tradeline;
  SHARED __EE6491393 := __EE3473938(__NN(__EE3473938.Legal_) AND __NN(__EE3473938.Tradeline_));
  SHARED __EE6491268 := __ENH_Business_Sele;
  SHARED __EE6491448 := __EE6491268(__T(__OP2(__EE6491268.UID,=,__CN(__PBusinessSeleUID))));
  __JC6491454(E_Sele_E_B_R_Tradeline(__in,__cfg_Local).Layout __EE6491393, B_Business_Sele(__in,__cfg_Local).__ST113627_Layout __EE6491448) := __EEQP(__EE6491448.UID,__EE6491393.Legal_);
  SHARED __EE6491466 := JOIN(__EE6491393,__EE6491448,__JC6491454(LEFT,RIGHT),TRANSFORM(E_Sele_E_B_R_Tradeline(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6491472(E_E_B_R_Tradeline(__in,__cfg_Local).Layout __EE3473948, E_Sele_E_B_R_Tradeline(__in,__cfg_Local).Layout __EE6491466) := __EEQP(__EE6491466.Tradeline_,__EE3473948.UID);
  SHARED __EE6491485 := JOIN(__EE3473948,__EE6491466,__JC6491472(LEFT,RIGHT),TRANSFORM(E_E_B_R_Tradeline(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6491487 := __EE6491485;
  EXPORT Res16 := __UNWRAP(__EE6491487);
  SHARED __EE3474051 := __E_Email;
  SHARED __EE3474041 := __E_Sele_Email;
  SHARED __EE6491717 := __EE3474041(__NN(__EE3474041.Legal_) AND __NN(__EE3474041.Email_));
  SHARED __EE6491536 := __ENH_Business_Sele;
  SHARED __EE6491800 := __EE6491536(__T(__OP2(__EE6491536.UID,=,__CN(__PBusinessSeleUID))));
  __JC6491806(E_Sele_Email(__in,__cfg_Local).Layout __EE6491717, B_Business_Sele(__in,__cfg_Local).__ST113627_Layout __EE6491800) := __EEQP(__EE6491800.UID,__EE6491717.Legal_);
  SHARED __EE6491824 := JOIN(__EE6491717,__EE6491800,__JC6491806(LEFT,RIGHT),TRANSFORM(E_Sele_Email(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6491830(E_Email(__in,__cfg_Local).Layout __EE3474051, E_Sele_Email(__in,__cfg_Local).Layout __EE6491824) := __EEQP(__EE6491824.Email_,__EE3474051.UID);
  SHARED __EE6491865 := JOIN(__EE3474051,__EE6491824,__JC6491830(LEFT,RIGHT),TRANSFORM(E_Email(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6491867 := __EE6491865;
  EXPORT Res17 := __UNWRAP(__EE6491867);
  SHARED __EE6491972 := __ENH_Address;
  SHARED __EE3474177 := __E_Sele_Address;
  SHARED __EE6492480 := __EE3474177(__NN(__EE3474177.Legal_) AND __NN(__EE3474177.Location_));
  SHARED __EE6491975 := __ENH_Business_Sele;
  SHARED __EE6492724 := __EE6491975(__T(__OP2(__EE6491975.UID,=,__CN(__PBusinessSeleUID))));
  __JC6492730(E_Sele_Address(__in,__cfg_Local).Layout __EE6492480, B_Business_Sele(__in,__cfg_Local).__ST113627_Layout __EE6492724) := __EEQP(__EE6492724.UID,__EE6492480.Legal_);
  SHARED __EE6492786 := JOIN(__EE6492480,__EE6492724,__JC6492730(LEFT,RIGHT),TRANSFORM(E_Sele_Address(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6492792(B_Address_1(__in,__cfg_Local).__ST128087_Layout __EE6491972, E_Sele_Address(__in,__cfg_Local).Layout __EE6492786) := __EEQP(__EE6492786.Location_,__EE6491972.UID);
  SHARED __EE6492950 := JOIN(__EE6491972,__EE6492786,__JC6492792(LEFT,RIGHT),TRANSFORM(B_Address_1(__in,__cfg_Local).__ST128087_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6492952 := __EE6492950;
  EXPORT Res18 := __UNWRAP(__EE6492952);
  SHARED __EE3474509 := __E_Aircraft;
  SHARED __EE3474499 := __E_Sele_Aircraft;
  SHARED __EE6493534 := __EE3474499(__NN(__EE3474499.Legal_) AND __NN(__EE3474499.Plane_));
  SHARED __EE6493379 := __ENH_Business_Sele;
  SHARED __EE6493604 := __EE6493379(__T(__OP2(__EE6493379.UID,=,__CN(__PBusinessSeleUID))));
  __JC6493610(E_Sele_Aircraft(__in,__cfg_Local).Layout __EE6493534, B_Business_Sele(__in,__cfg_Local).__ST113627_Layout __EE6493604) := __EEQP(__EE6493604.UID,__EE6493534.Legal_);
  SHARED __EE6493627 := JOIN(__EE6493534,__EE6493604,__JC6493610(LEFT,RIGHT),TRANSFORM(E_Sele_Aircraft(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6493633(E_Aircraft(__in,__cfg_Local).Layout __EE3474509, E_Sele_Aircraft(__in,__cfg_Local).Layout __EE6493627) := __EEQP(__EE6493627.Plane_,__EE3474509.UID);
  SHARED __EE6493656 := JOIN(__EE3474509,__EE6493627,__JC6493633(LEFT,RIGHT),TRANSFORM(E_Aircraft(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6493658 := __EE6493656;
  EXPORT Res19 := __UNWRAP(__EE6493658);
  SHARED __EE6493737 := __ENH_Bankruptcy;
  SHARED __EE3474619 := __E_Sele_Bankruptcy;
  SHARED __EE6494009 := __EE3474619(__NN(__EE3474619.Legal_) AND __NN(__EE3474619.Bankrupt_));
  SHARED __EE6493740 := __ENH_Business_Sele;
  SHARED __EE6494135 := __EE6493740(__T(__OP2(__EE6493740.UID,=,__CN(__PBusinessSeleUID))));
  __JC6494141(E_Sele_Bankruptcy(__in,__cfg_Local).Layout __EE6494009, B_Business_Sele(__in,__cfg_Local).__ST113627_Layout __EE6494135) := __EEQP(__EE6494135.UID,__EE6494009.Legal_);
  SHARED __EE6494151 := JOIN(__EE6494009,__EE6494135,__JC6494141(LEFT,RIGHT),TRANSFORM(E_Sele_Bankruptcy(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6494157(B_Bankruptcy(__in,__cfg_Local).__ST95087_Layout __EE6493737, E_Sele_Bankruptcy(__in,__cfg_Local).Layout __EE6494151) := __EEQP(__EE6494151.Bankrupt_,__EE6493737.UID);
  SHARED __EE6494243 := JOIN(__EE6493737,__EE6494151,__JC6494157(LEFT,RIGHT),TRANSFORM(B_Bankruptcy(__in,__cfg_Local).__ST95087_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6494245 := __EE6494243;
  EXPORT Res20 := __UNWRAP(__EE6494245);
  SHARED __EE6494436 := __ENH_Lien_Judgment;
  SHARED __EE3474796 := __E_Sele_Lien_Judgment;
  SHARED __EE6494626 := __EE3474796(__NN(__EE3474796.Sele_) AND __NN(__EE3474796.Lien_));
  SHARED __EE6494439 := __ENH_Business_Sele;
  SHARED __EE6494711 := __EE6494439(__T(__OP2(__EE6494439.UID,=,__CN(__PBusinessSeleUID))));
  __JC6494717(E_Sele_Lien_Judgment(__in,__cfg_Local).Layout __EE6494626, B_Business_Sele(__in,__cfg_Local).__ST113627_Layout __EE6494711) := __EEQP(__EE6494711.UID,__EE6494626.Sele_);
  SHARED __EE6494733 := JOIN(__EE6494626,__EE6494711,__JC6494717(LEFT,RIGHT),TRANSFORM(E_Sele_Lien_Judgment(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6494739(B_Lien_Judgment_12(__in,__cfg_Local).__ST199785_Layout __EE6494436, E_Sele_Lien_Judgment(__in,__cfg_Local).Layout __EE6494733) := __EEQP(__EE6494733.Lien_,__EE6494436.UID);
  SHARED __EE6494778 := JOIN(__EE6494436,__EE6494733,__JC6494739(LEFT,RIGHT),TRANSFORM(B_Lien_Judgment_12(__in,__cfg_Local).__ST199785_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6494780 := __EE6494778;
  EXPORT Res21 := __UNWRAP(__EE6494780);
  SHARED __EE6494889 := __ENH_Person;
  SHARED __EE3474932 := __E_Sele_Person;
  SHARED __EE6496695 := __EE3474932(__NN(__EE3474932.Legal_) AND __NN(__EE3474932.Contact_));
  SHARED __EE6494892 := __ENH_Business_Sele;
  SHARED __EE6497588 := __EE6494892(__T(__OP2(__EE6494892.UID,=,__CN(__PBusinessSeleUID))));
  __JC6497594(E_Sele_Person(__in,__cfg_Local).Layout __EE6496695, B_Business_Sele(__in,__cfg_Local).__ST113627_Layout __EE6497588) := __EEQP(__EE6497588.UID,__EE6496695.Legal_);
  SHARED __EE6497625 := JOIN(__EE6496695,__EE6497588,__JC6497594(LEFT,RIGHT),TRANSFORM(E_Sele_Person(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6497631(B_Person(__in,__cfg_Local).__ST126252_Layout __EE6494889, E_Sele_Person(__in,__cfg_Local).Layout __EE6497625) := __EEQP(__EE6497625.Contact_,__EE6494889.UID);
  SHARED __EE6498463 := JOIN(__EE6494889,__EE6497625,__JC6497631(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST126252_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6498465 := __EE6498463;
  EXPORT Res22 := __UNWRAP(__EE6498465);
  SHARED __EE3475947 := __E_Phone;
  SHARED __EE3475937 := __E_Sele_Phone_Number;
  SHARED __EE6500445 := __EE3475937(__NN(__EE3475937.Legal_) AND __NN(__EE3475937.Phone_Number_));
  SHARED __EE6500190 := __ENH_Business_Sele;
  SHARED __EE6500565 := __EE6500190(__T(__OP2(__EE6500190.UID,=,__CN(__PBusinessSeleUID))));
  __JC6500571(E_Sele_Phone_Number(__in,__cfg_Local).Layout __EE6500445, B_Business_Sele(__in,__cfg_Local).__ST113627_Layout __EE6500565) := __EEQP(__EE6500565.UID,__EE6500445.Legal_);
  SHARED __EE6500608 := JOIN(__EE6500445,__EE6500565,__JC6500571(LEFT,RIGHT),TRANSFORM(E_Sele_Phone_Number(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6500614(E_Phone(__in,__cfg_Local).Layout __EE3475947, E_Sele_Phone_Number(__in,__cfg_Local).Layout __EE6500608) := __EEQP(__EE6500608.Phone_Number_,__EE3475947.UID);
  SHARED __EE6500667 := JOIN(__EE3475947,__EE6500608,__JC6500614(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6500669 := __EE6500667;
  EXPORT Res23 := __UNWRAP(__EE6500669);
  SHARED __EE6500848 := __ENH_Property;
  SHARED __EE3476116 := __E_Sele_Property;
  SHARED __EE6501058 := __EE3476116(__NN(__EE3476116.Legal_) AND __NN(__EE3476116.Prop_));
  SHARED __EE6500851 := __ENH_Business_Sele;
  SHARED __EE6501153 := __EE6500851(__T(__OP2(__EE6500851.UID,=,__CN(__PBusinessSeleUID))));
  __JC6501159(E_Sele_Property(__in,__cfg_Local).Layout __EE6501058, B_Business_Sele(__in,__cfg_Local).__ST113627_Layout __EE6501153) := __EEQP(__EE6501153.UID,__EE6501058.Legal_);
  SHARED __EE6501187 := JOIN(__EE6501058,__EE6501153,__JC6501159(LEFT,RIGHT),TRANSFORM(E_Sele_Property(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6501193(B_Property(__in,__cfg_Local).__ST126787_Layout __EE6500848, E_Sele_Property(__in,__cfg_Local).Layout __EE6501187) := __EEQP(__EE6501187.Prop_,__EE6500848.UID);
  SHARED __EE6501230 := JOIN(__EE6500848,__EE6501187,__JC6501193(LEFT,RIGHT),TRANSFORM(B_Property(__in,__cfg_Local).__ST126787_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6501232 := __EE6501230;
  EXPORT Res24 := __UNWRAP(__EE6501232);
  SHARED __EE6501361 := __ENH_Property_Event;
  SHARED __EE3476263 := __E_Sele_Property_Event;
  SHARED __EE6502091 := __EE3476263(__NN(__EE3476263.Legal_) AND __NN(__EE3476263.Event_));
  SHARED __EE6501364 := __ENH_Business_Sele;
  SHARED __EE6502446 := __EE6501364(__T(__OP2(__EE6501364.UID,=,__CN(__PBusinessSeleUID))));
  __JC6502452(E_Sele_Property_Event(__in,__cfg_Local).Layout __EE6502091, B_Business_Sele(__in,__cfg_Local).__ST113627_Layout __EE6502446) := __EEQP(__EE6502446.UID,__EE6502091.Legal_);
  SHARED __EE6502475 := JOIN(__EE6502091,__EE6502446,__JC6502452(LEFT,RIGHT),TRANSFORM(E_Sele_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6502481(B_Property_Event_3(__in,__cfg_Local).__ST173128_Layout __EE6501361, E_Sele_Property_Event(__in,__cfg_Local).Layout __EE6502475) := __EEQP(__EE6502475.Event_,__EE6501361.UID);
  SHARED __EE6502783 := JOIN(__EE6501361,__EE6502475,__JC6502481(LEFT,RIGHT),TRANSFORM(B_Property_Event_3(__in,__cfg_Local).__ST173128_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6502785 := __EE6502783;
  EXPORT Res25 := __UNWRAP(__EE6502785);
  SHARED __EE3476678 := __E_T_I_N;
  SHARED __EE3476668 := __E_Sele_T_I_N;
  SHARED __EE6503543 := __EE3476668(__NN(__EE3476668.Legal_) AND __NN(__EE3476668.Tax_I_D_));
  SHARED __EE6503434 := __ENH_Business_Sele;
  SHARED __EE6503590 := __EE6503434(__T(__OP2(__EE6503434.UID,=,__CN(__PBusinessSeleUID))));
  __JC6503596(E_Sele_T_I_N(__in,__cfg_Local).Layout __EE6503543, B_Business_Sele(__in,__cfg_Local).__ST113627_Layout __EE6503590) := __EEQP(__EE6503590.UID,__EE6503543.Legal_);
  SHARED __EE6503609 := JOIN(__EE6503543,__EE6503590,__JC6503596(LEFT,RIGHT),TRANSFORM(E_Sele_T_I_N(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6503615(E_T_I_N(__in,__cfg_Local).Layout __EE3476678, E_Sele_T_I_N(__in,__cfg_Local).Layout __EE6503609) := __EEQP(__EE6503609.Tax_I_D_,__EE3476678.UID);
  SHARED __EE6503619 := JOIN(__EE3476678,__EE6503609,__JC6503615(LEFT,RIGHT),TRANSFORM(E_T_I_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6503621 := __EE6503619;
  EXPORT Res26 := __UNWRAP(__EE6503621);
  SHARED __EE6503654 := __ENH_Tradeline;
  SHARED __EE3476761 := __E_Sele_Tradeline;
  SHARED __EE6503890 := __EE3476761(__NN(__EE3476761.Legal_) AND __NN(__EE3476761.Account_));
  SHARED __EE6503657 := __ENH_Business_Sele;
  SHARED __EE6503998 := __EE6503657(__T(__OP2(__EE6503657.UID,=,__CN(__PBusinessSeleUID))));
  __JC6504004(E_Sele_Tradeline(__in,__cfg_Local).Layout __EE6503890, B_Business_Sele(__in,__cfg_Local).__ST113627_Layout __EE6503998) := __EEQP(__EE6503998.UID,__EE6503890.Legal_);
  SHARED __EE6504011 := JOIN(__EE6503890,__EE6503998,__JC6504004(LEFT,RIGHT),TRANSFORM(E_Sele_Tradeline(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6504017(B_Tradeline(__in,__cfg_Local).__ST127761_Layout __EE6503654, E_Sele_Tradeline(__in,__cfg_Local).Layout __EE6504011) := __EEQP(__EE6504011.Account_,__EE6503654.UID);
  SHARED __EE6504088 := JOIN(__EE6503654,__EE6504011,__JC6504017(LEFT,RIGHT),TRANSFORM(B_Tradeline(__in,__cfg_Local).__ST127761_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6504090 := __EE6504088;
  EXPORT Res27 := __UNWRAP(__EE6504090);
  SHARED __EE6504245 := __ENH_U_C_C;
  SHARED __EE3476919 := __E_Sele_U_C_C;
  SHARED __EE6504471 := __EE3476919(__NN(__EE3476919.Legal_) AND __NN(__EE3476919.Filing_));
  SHARED __EE6504248 := __ENH_Business_Sele;
  SHARED __EE6504574 := __EE6504248(__T(__OP2(__EE6504248.UID,=,__CN(__PBusinessSeleUID))));
  __JC6504580(E_Sele_U_C_C(__in,__cfg_Local).Layout __EE6504471, B_Business_Sele(__in,__cfg_Local).__ST113627_Layout __EE6504574) := __EEQP(__EE6504574.UID,__EE6504471.Legal_);
  SHARED __EE6504595 := JOIN(__EE6504471,__EE6504574,__JC6504580(LEFT,RIGHT),TRANSFORM(E_Sele_U_C_C(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6504601(B_U_C_C(__in,__cfg_Local).__ST127964_Layout __EE6504245, E_Sele_U_C_C(__in,__cfg_Local).Layout __EE6504595) := __EEQP(__EE6504595.Filing_,__EE6504245.UID);
  SHARED __EE6504659 := JOIN(__EE6504245,__EE6504595,__JC6504601(LEFT,RIGHT),TRANSFORM(B_U_C_C(__in,__cfg_Local).__ST127964_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6504661 := __EE6504659;
  EXPORT Res28 := __UNWRAP(__EE6504661);
  SHARED __EE3477084 := __E_Utility;
  SHARED __EE3477074 := __E_Sele_Utility;
  SHARED __EE6504955 := __EE3477074(__NN(__EE3477074.Legal_) AND __NN(__EE3477074.Util_));
  SHARED __EE6504806 := __ENH_Business_Sele;
  SHARED __EE6505022 := __EE6504806(__T(__OP2(__EE6504806.UID,=,__CN(__PBusinessSeleUID))));
  __JC6505028(E_Sele_Utility(__in,__cfg_Local).Layout __EE6504955, B_Business_Sele(__in,__cfg_Local).__ST113627_Layout __EE6505022) := __EEQP(__EE6505022.UID,__EE6504955.Legal_);
  SHARED __EE6505039 := JOIN(__EE6504955,__EE6505022,__JC6505028(LEFT,RIGHT),TRANSFORM(E_Sele_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6505045(E_Utility(__in,__cfg_Local).Layout __EE3477084, E_Sele_Utility(__in,__cfg_Local).Layout __EE6505039) := __EEQP(__EE6505039.Util_,__EE3477084.UID);
  SHARED __EE6505071 := JOIN(__EE3477084,__EE6505039,__JC6505045(LEFT,RIGHT),TRANSFORM(E_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6505073 := __EE6505071;
  EXPORT Res29 := __UNWRAP(__EE6505073);
  SHARED __EE3477200 := __E_Vehicle;
  SHARED __EE3477190 := __E_Sele_Vehicle;
  SHARED __EE6505543 := __EE3477190(__NN(__EE3477190.Legal_) AND __NN(__EE3477190.Automobile_));
  SHARED __EE6505146 := __ENH_Business_Sele;
  SHARED __EE6505734 := __EE6505146(__T(__OP2(__EE6505146.UID,=,__CN(__PBusinessSeleUID))));
  __JC6505740(E_Sele_Vehicle(__in,__cfg_Local).Layout __EE6505543, B_Business_Sele(__in,__cfg_Local).__ST113627_Layout __EE6505734) := __EEQP(__EE6505734.UID,__EE6505543.Legal_);
  SHARED __EE6505790 := JOIN(__EE6505543,__EE6505734,__JC6505740(LEFT,RIGHT),TRANSFORM(E_Sele_Vehicle(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6505796(E_Vehicle(__in,__cfg_Local).Layout __EE3477200, E_Sele_Vehicle(__in,__cfg_Local).Layout __EE6505790) := __EEQP(__EE6505790.Automobile_,__EE3477200.UID);
  SHARED __EE6505907 := JOIN(__EE3477200,__EE6505790,__JC6505796(LEFT,RIGHT),TRANSFORM(E_Vehicle(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6505909 := __EE6505907;
  EXPORT Res30 := __UNWRAP(__EE6505909);
  SHARED __EE3477442 := __E_Inquiry;
  SHARED __EE3477432 := __E_Sele_Inquiry;
  SHARED __EE6506449 := __EE3477432(__NN(__EE3477432.Legal_) AND __NN(__EE3477432.Transaction_));
  SHARED __EE6506230 := __ENH_Business_Sele;
  SHARED __EE6506551 := __EE6506230(__T(__OP2(__EE6506230.UID,=,__CN(__PBusinessSeleUID))));
  __JC6506557(E_Sele_Inquiry(__in,__cfg_Local).Layout __EE6506449, B_Business_Sele(__in,__cfg_Local).__ST113627_Layout __EE6506551) := __EEQP(__EE6506551.UID,__EE6506449.Legal_);
  SHARED __EE6506569 := JOIN(__EE6506449,__EE6506551,__JC6506557(LEFT,RIGHT),TRANSFORM(E_Sele_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6506575(E_Inquiry(__in,__cfg_Local).Layout __EE3477442, E_Sele_Inquiry(__in,__cfg_Local).Layout __EE6506569) := __EEQP(__EE6506569.Transaction_,__EE3477442.UID);
  SHARED __EE6506635 := JOIN(__EE3477442,__EE6506569,__JC6506575(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6506637 := __EE6506635;
  EXPORT Res31 := __UNWRAP(__EE6506637);
  SHARED __EE3477596 := __E_Watercraft;
  SHARED __EE3477586 := __E_Sele_Watercraft;
  SHARED __EE6506899 := __EE3477586(__NN(__EE3477586.Legal_) AND __NN(__EE3477586.W_Craft_));
  SHARED __EE6506780 := __ENH_Business_Sele;
  SHARED __EE6506951 := __EE6506780(__T(__OP2(__EE6506780.UID,=,__CN(__PBusinessSeleUID))));
  __JC6506957(E_Sele_Watercraft(__in,__cfg_Local).Layout __EE6506899, B_Business_Sele(__in,__cfg_Local).__ST113627_Layout __EE6506951) := __EEQP(__EE6506951.UID,__EE6506899.Legal_);
  SHARED __EE6506968 := JOIN(__EE6506899,__EE6506951,__JC6506957(LEFT,RIGHT),TRANSFORM(E_Sele_Watercraft(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6506974(E_Watercraft(__in,__cfg_Local).Layout __EE3477596, E_Sele_Watercraft(__in,__cfg_Local).Layout __EE6506968) := __EEQP(__EE6506968.W_Craft_,__EE3477596.UID);
  SHARED __EE6506985 := JOIN(__EE3477596,__EE6506968,__JC6506974(LEFT,RIGHT),TRANSFORM(E_Watercraft(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6506987 := __EE6506985;
  EXPORT Res32 := __UNWRAP(__EE6506987);
  SHARED __EE6507030 := __ENH_Business_Prox;
  SHARED __EE6507587 := __EE6507030(__NN(__EE6507030.Prox_Sele_));
  SHARED __EE6507033 := __ENH_Business_Sele;
  SHARED __EE6507592 := __EE6507033(__T(__OP2(__EE6507033.UID,=,__CN(__PBusinessSeleUID))));
  __JC6507598(B_Business_Prox(__in,__cfg_Local).__ST95570_Layout __EE6507587, B_Business_Sele(__in,__cfg_Local).__ST113627_Layout __EE6507592) := __EEQP(__EE6507592.UID,__EE6507587.Prox_Sele_);
  SHARED __EE6507858 := JOIN(__EE6507587,__EE6507592,__JC6507598(LEFT,RIGHT),TRANSFORM(B_Business_Prox(__in,__cfg_Local).__ST95570_Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __EE6507860 := __EE6507858;
  EXPORT Res33 := __UNWRAP(__EE6507860);
  SHARED __EE6508381 := __ENH_Criminal_Offense;
  SHARED __EE3478022 := __E_Criminal_Details;
  SHARED __EE6508619 := __EE3478022(__NN(__EE3478022.Offender_) AND __NN(__EE3478022.Offense_));
  SHARED __EE3478016 := __E_Criminal_Offender;
  SHARED __EE6508740 := __EE3478016(__T(__OP2(__EE3478016.UID,=,__CN(__PCriminalOffenderUID))));
  __JC6508746(E_Criminal_Details(__in,__cfg_Local).Layout __EE6508619, E_Criminal_Offender(__in,__cfg_Local).Layout __EE6508740) := __EEQP(__EE6508740.UID,__EE6508619.Offender_);
  SHARED __EE6508754 := JOIN(__EE6508619,__EE6508740,__JC6508746(LEFT,RIGHT),TRANSFORM(E_Criminal_Details(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6508760(B_Criminal_Offense(__in,__cfg_Local).__ST115066_Layout __EE6508381, E_Criminal_Details(__in,__cfg_Local).Layout __EE6508754) := __EEQP(__EE6508754.Offense_,__EE6508381.UID);
  SHARED __EE6508843 := JOIN(__EE6508381,__EE6508754,__JC6508760(LEFT,RIGHT),TRANSFORM(B_Criminal_Offense(__in,__cfg_Local).__ST115066_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6508845 := __EE6508843;
  EXPORT Res34 := __UNWRAP(__EE6508845);
  SHARED __EE3478205 := __E_Criminal_Punishment;
  SHARED __EE3478195 := __E_Criminal_Details;
  SHARED __EE6509142 := __EE3478195(__NN(__EE3478195.Offender_) AND __NN(__EE3478195.Punishment_));
  SHARED __EE3478189 := __E_Criminal_Offender;
  SHARED __EE6509234 := __EE3478189(__T(__OP2(__EE3478189.UID,=,__CN(__PCriminalOffenderUID))));
  __JC6509240(E_Criminal_Details(__in,__cfg_Local).Layout __EE6509142, E_Criminal_Offender(__in,__cfg_Local).Layout __EE6509234) := __EEQP(__EE6509234.UID,__EE6509142.Offender_);
  SHARED __EE6509248 := JOIN(__EE6509142,__EE6509234,__JC6509240(LEFT,RIGHT),TRANSFORM(E_Criminal_Details(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6509254(E_Criminal_Punishment(__in,__cfg_Local).Layout __EE3478205, E_Criminal_Details(__in,__cfg_Local).Layout __EE6509248) := __EEQP(__EE6509248.Punishment_,__EE3478205.UID);
  SHARED __EE6509308 := JOIN(__EE3478205,__EE6509248,__JC6509254(LEFT,RIGHT),TRANSFORM(E_Criminal_Punishment(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6509310 := __EE6509308;
  EXPORT Res35 := __UNWRAP(__EE6509310);
  SHARED __EE3478346 := __E_Inquiry;
  SHARED __EE3478336 := __E_Email_Inquiry;
  SHARED __EE6509557 := __EE3478336(__NN(__EE3478336.Email_) AND __NN(__EE3478336.Transaction_));
  SHARED __EE3478330 := __E_Email;
  SHARED __EE6509657 := __EE3478330(__T(__OP2(__EE3478330.UID,=,__CN(__PEmailUID))));
  __JC6509663(E_Email_Inquiry(__in,__cfg_Local).Layout __EE6509557, E_Email(__in,__cfg_Local).Layout __EE6509657) := __EEQP(__EE6509657.UID,__EE6509557.Email_);
  SHARED __EE6509673 := JOIN(__EE6509557,__EE6509657,__JC6509663(LEFT,RIGHT),TRANSFORM(E_Email_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6509679(E_Inquiry(__in,__cfg_Local).Layout __EE3478346, E_Email_Inquiry(__in,__cfg_Local).Layout __EE6509673) := __EEQP(__EE6509673.Transaction_,__EE3478346.UID);
  SHARED __EE6509739 := JOIN(__EE3478346,__EE6509673,__JC6509679(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6509741 := __EE6509739;
  EXPORT Res36 := __UNWRAP(__EE6509741);
  SHARED __EE3478488 := __E_First_Degree_Associations;
  SHARED __EE6509939 := __EE3478488(__NN(__EE3478488.Subject_));
  SHARED __EE6509880 := __ENH_Person;
  SHARED __EE6509944 := __EE6509880(__T(__OP2(__EE6509880.UID,=,__CN(__PPersonUID))));
  __JC6509950(E_First_Degree_Associations(__in,__cfg_Local).Layout __EE6509939, B_Person(__in,__cfg_Local).__ST126252_Layout __EE6509944) := __EEQP(__EE6509944.UID,__EE6509939.Subject_);
  SHARED __EE6509962 := JOIN(__EE6509939,__EE6509944,__JC6509950(LEFT,RIGHT),TRANSFORM(E_First_Degree_Associations(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6509964 := __EE6509962;
  EXPORT Res37 := __UNWRAP(__EE6509964);
  SHARED __EE6509989 := __ENH_First_Degree_Relative;
  SHARED __EE6510053 := __EE6509989(__NN(__EE6509989.Subject_));
  SHARED __EE6509992 := __ENH_Person;
  SHARED __EE6510058 := __EE6509992(__T(__OP2(__EE6509992.UID,=,__CN(__PPersonUID))));
  __JC6510064(B_First_Degree_Relative(__in,__cfg_Local).__ST3060931_Layout __EE6510053, B_Person(__in,__cfg_Local).__ST126252_Layout __EE6510058) := __EEQP(__EE6510058.UID,__EE6510053.Subject_);
  SHARED __EE6510076 := JOIN(__EE6510053,__EE6510058,__JC6510064(LEFT,RIGHT),TRANSFORM(B_First_Degree_Relative(__in,__cfg_Local).__ST3060931_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6510078 := __EE6510076;
  EXPORT Res38 := __UNWRAP(__EE6510078);
  SHARED __EE3478622 := __E_Phone;
  SHARED __EE3478612 := __E_House_Hold_Phone;
  SHARED __EE6510236 := __EE3478612(__NN(__EE3478612.Household_) AND __NN(__EE3478612.Phone_Number_));
  SHARED __EE3478606 := __E_Household;
  SHARED __EE6510345 := __EE3478606(__T(__OP2(__EE3478606.UID,=,__CN(__PHouseholdUID))));
  __JC6510351(E_House_Hold_Phone(__in,__cfg_Local).Layout __EE6510236, E_Household(__in,__cfg_Local).Layout __EE6510345) := __EEQP(__EE6510345.UID,__EE6510236.Household_);
  SHARED __EE6510377 := JOIN(__EE6510236,__EE6510345,__JC6510351(LEFT,RIGHT),TRANSFORM(E_House_Hold_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6510383(E_Phone(__in,__cfg_Local).Layout __EE3478622, E_House_Hold_Phone(__in,__cfg_Local).Layout __EE6510377) := __EEQP(__EE6510377.Phone_Number_,__EE3478622.UID);
  SHARED __EE6510436 := JOIN(__EE3478622,__EE6510377,__JC6510383(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6510438 := __EE6510436;
  EXPORT Res39 := __UNWRAP(__EE6510438);
  SHARED __EE6510595 := __ENH_Person;
  SHARED __EE3478775 := __E_Household_Member;
  SHARED __EE6512331 := __EE3478775(__NN(__EE3478775.Household_) AND __NN(__EE3478775.Subject_));
  SHARED __EE3478769 := __E_Household;
  SHARED __EE6513201 := __EE3478769(__T(__OP2(__EE3478769.UID,=,__CN(__PHouseholdUID))));
  __JC6513207(E_Household_Member(__in,__cfg_Local).Layout __EE6512331, E_Household(__in,__cfg_Local).Layout __EE6513201) := __EEQP(__EE6513201.UID,__EE6512331.Household_);
  SHARED __EE6513215 := JOIN(__EE6512331,__EE6513201,__JC6513207(LEFT,RIGHT),TRANSFORM(E_Household_Member(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6513221(B_Person(__in,__cfg_Local).__ST126252_Layout __EE6510595, E_Household_Member(__in,__cfg_Local).Layout __EE6513215) := __EEQP(__EE6513215.Subject_,__EE6510595.UID);
  SHARED __EE6514053 := JOIN(__EE6510595,__EE6513215,__JC6513221(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST126252_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6514055 := __EE6514053;
  EXPORT Res40 := __UNWRAP(__EE6514055);
  SHARED __EE3479766 := __E_Aircraft;
  SHARED __EE3479756 := __E_Aircraft_Owner;
  SHARED __EE6515877 := __EE3479756(__NN(__EE3479756.Owner_) AND __NN(__EE3479756.Plane_));
  SHARED __EE6515734 := __ENH_Person;
  SHARED __EE6515940 := __EE6515734(__T(__OP2(__EE6515734.UID,=,__CN(__PPersonUID))));
  __JC6515946(E_Aircraft_Owner(__in,__cfg_Local).Layout __EE6515877, B_Person(__in,__cfg_Local).__ST126252_Layout __EE6515940) := __EEQP(__EE6515940.UID,__EE6515877.Owner_);
  SHARED __EE6515956 := JOIN(__EE6515877,__EE6515940,__JC6515946(LEFT,RIGHT),TRANSFORM(E_Aircraft_Owner(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6515962(E_Aircraft(__in,__cfg_Local).Layout __EE3479766, E_Aircraft_Owner(__in,__cfg_Local).Layout __EE6515956) := __EEQP(__EE6515956.Plane_,__EE3479766.UID);
  SHARED __EE6515985 := JOIN(__EE3479766,__EE6515956,__JC6515962(LEFT,RIGHT),TRANSFORM(E_Aircraft(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6515987 := __EE6515985;
  EXPORT Res41 := __UNWRAP(__EE6515987);
  SHARED __EE3479878 := __E_Household;
  SHARED __EE3479868 := __E_Household_Member;
  SHARED __EE6516157 := __EE3479868(__NN(__EE3479868.Subject_) AND __NN(__EE3479868.Household_));
  SHARED __EE6516052 := __ENH_Person;
  SHARED __EE6516201 := __EE6516052(__T(__OP2(__EE6516052.UID,=,__CN(__PPersonUID))));
  __JC6516207(E_Household_Member(__in,__cfg_Local).Layout __EE6516157, B_Person(__in,__cfg_Local).__ST126252_Layout __EE6516201) := __EEQP(__EE6516201.UID,__EE6516157.Subject_);
  SHARED __EE6516215 := JOIN(__EE6516157,__EE6516201,__JC6516207(LEFT,RIGHT),TRANSFORM(E_Household_Member(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6516221(E_Household(__in,__cfg_Local).Layout __EE3479878, E_Household_Member(__in,__cfg_Local).Layout __EE6516215) := __EEQP(__EE6516215.Household_,__EE3479878.UID);
  SHARED __EE6516227 := JOIN(__EE3479878,__EE6516215,__JC6516221(LEFT,RIGHT),TRANSFORM(E_Household(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6516229 := __EE6516227;
  EXPORT Res42 := __UNWRAP(__EE6516229);
  SHARED __EE3479969 := __E_Accident;
  SHARED __EE3479959 := __E_Person_Accident;
  SHARED __EE6516481 := __EE3479959(__NN(__EE3479959.Subject_) AND __NN(__EE3479959.Acc_));
  SHARED __EE6516256 := __ENH_Person;
  SHARED __EE6516585 := __EE6516256(__T(__OP2(__EE6516256.UID,=,__CN(__PPersonUID))));
  __JC6516591(E_Person_Accident(__in,__cfg_Local).Layout __EE6516481, B_Person(__in,__cfg_Local).__ST126252_Layout __EE6516585) := __EEQP(__EE6516585.UID,__EE6516481.Subject_);
  SHARED __EE6516639 := JOIN(__EE6516481,__EE6516585,__JC6516591(LEFT,RIGHT),TRANSFORM(E_Person_Accident(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6516645(E_Accident(__in,__cfg_Local).Layout __EE3479969, E_Person_Accident(__in,__cfg_Local).Layout __EE6516639) := __EEQP(__EE6516639.Acc_,__EE3479969.UID);
  SHARED __EE6516671 := JOIN(__EE3479969,__EE6516639,__JC6516645(LEFT,RIGHT),TRANSFORM(E_Accident(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6516673 := __EE6516671;
  EXPORT Res43 := __UNWRAP(__EE6516673);
  SHARED __EE6516820 := __ENH_Address;
  SHARED __EE3480111 := __E_Person_Address;
  SHARED __EE6517314 := __EE3480111(__NN(__EE3480111.Subject_) AND __NN(__EE3480111.Location_));
  SHARED __EE6516823 := __ENH_Person;
  SHARED __EE6517550 := __EE6516823(__T(__OP2(__EE6516823.UID,=,__CN(__PPersonUID))));
  __JC6517556(E_Person_Address(__in,__cfg_Local).Layout __EE6517314, B_Person(__in,__cfg_Local).__ST126252_Layout __EE6517550) := __EEQP(__EE6517550.UID,__EE6517314.Subject_);
  SHARED __EE6517604 := JOIN(__EE6517314,__EE6517550,__JC6517556(LEFT,RIGHT),TRANSFORM(E_Person_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6517610(B_Address_1(__in,__cfg_Local).__ST128087_Layout __EE6516820, E_Person_Address(__in,__cfg_Local).Layout __EE6517604) := __EEQP(__EE6517604.Location_,__EE6516820.UID);
  SHARED __EE6517768 := JOIN(__EE6516820,__EE6517604,__JC6517610(LEFT,RIGHT),TRANSFORM(B_Address_1(__in,__cfg_Local).__ST128087_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6517770 := __EE6517768;
  EXPORT Res44 := __UNWRAP(__EE6517770);
  SHARED __EE6518181 := __ENH_Bankruptcy;
  SHARED __EE3480421 := __E_Person_Bankruptcy;
  SHARED __EE6518449 := __EE3480421(__NN(__EE3480421.Subject_) AND __NN(__EE3480421.Bankrupt_));
  SHARED __EE6518184 := __ENH_Person;
  SHARED __EE6518572 := __EE6518184(__T(__OP2(__EE6518184.UID,=,__CN(__PPersonUID))));
  __JC6518578(E_Person_Bankruptcy(__in,__cfg_Local).Layout __EE6518449, B_Person(__in,__cfg_Local).__ST126252_Layout __EE6518572) := __EEQP(__EE6518572.UID,__EE6518449.Subject_);
  SHARED __EE6518585 := JOIN(__EE6518449,__EE6518572,__JC6518578(LEFT,RIGHT),TRANSFORM(E_Person_Bankruptcy(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6518591(B_Bankruptcy(__in,__cfg_Local).__ST95087_Layout __EE6518181, E_Person_Bankruptcy(__in,__cfg_Local).Layout __EE6518585) := __EEQP(__EE6518585.Bankrupt_,__EE6518181.UID);
  SHARED __EE6518677 := JOIN(__EE6518181,__EE6518585,__JC6518591(LEFT,RIGHT),TRANSFORM(B_Bankruptcy(__in,__cfg_Local).__ST95087_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6518679 := __EE6518677;
  EXPORT Res45 := __UNWRAP(__EE6518679);
  SHARED __EE3480605 := __E_Drivers_License;
  SHARED __EE3480595 := __E_Person_Drivers_License;
  SHARED __EE6519069 := __EE3480595(__NN(__EE3480595.Subject_) AND __NN(__EE3480595.License_));
  SHARED __EE6518864 := __ENH_Person;
  SHARED __EE6519163 := __EE6518864(__T(__OP2(__EE6518864.UID,=,__CN(__PPersonUID))));
  __JC6519169(E_Person_Drivers_License(__in,__cfg_Local).Layout __EE6519069, B_Person(__in,__cfg_Local).__ST126252_Layout __EE6519163) := __EEQP(__EE6519163.UID,__EE6519069.Subject_);
  SHARED __EE6519176 := JOIN(__EE6519069,__EE6519163,__JC6519169(LEFT,RIGHT),TRANSFORM(E_Person_Drivers_License(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6519182(E_Drivers_License(__in,__cfg_Local).Layout __EE3480605, E_Person_Drivers_License(__in,__cfg_Local).Layout __EE6519176) := __EEQP(__EE6519176.License_,__EE3480605.UID);
  SHARED __EE6519239 := JOIN(__EE3480605,__EE6519176,__JC6519182(LEFT,RIGHT),TRANSFORM(E_Drivers_License(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6519241 := __EE6519239;
  EXPORT Res46 := __UNWRAP(__EE6519241);
  SHARED __EE6519368 := __ENH_Education;
  SHARED __EE3480739 := __E_Person_Education;
  SHARED __EE6519532 := __EE3480739(__NN(__EE3480739.Subject_) AND __NN(__EE3480739.Edu_));
  SHARED __EE6519371 := __ENH_Person;
  SHARED __EE6519603 := __EE6519371(__T(__OP2(__EE6519371.UID,=,__CN(__PPersonUID))));
  __JC6519609(E_Person_Education(__in,__cfg_Local).Layout __EE6519532, B_Person(__in,__cfg_Local).__ST126252_Layout __EE6519603) := __EEQP(__EE6519603.UID,__EE6519532.Subject_);
  SHARED __EE6519627 := JOIN(__EE6519532,__EE6519603,__JC6519609(LEFT,RIGHT),TRANSFORM(E_Person_Education(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6519633(B_Education_2(__in,__cfg_Local).__ST157502_Layout __EE6519368, E_Person_Education(__in,__cfg_Local).Layout __EE6519627) := __EEQP(__EE6519627.Edu_,__EE6519368.UID);
  SHARED __EE6519656 := JOIN(__EE6519368,__EE6519627,__JC6519633(LEFT,RIGHT),TRANSFORM(B_Education_2(__in,__cfg_Local).__ST157502_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6519658 := __EE6519656;
  EXPORT Res47 := __UNWRAP(__EE6519658);
  SHARED __EE3480869 := __E_Email;
  SHARED __EE3480859 := __E_Person_Email;
  SHARED __EE6519900 := __EE3480859(__NN(__EE3480859.Subject_) AND __NN(__EE3480859.Email_));
  SHARED __EE6519739 := __ENH_Person;
  SHARED __EE6519972 := __EE6519739(__T(__OP2(__EE6519739.UID,=,__CN(__PPersonUID))));
  __JC6519978(E_Person_Email(__in,__cfg_Local).Layout __EE6519900, B_Person(__in,__cfg_Local).__ST126252_Layout __EE6519972) := __EEQP(__EE6519972.UID,__EE6519900.Subject_);
  SHARED __EE6519985 := JOIN(__EE6519900,__EE6519972,__JC6519978(LEFT,RIGHT),TRANSFORM(E_Person_Email(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6519991(E_Email(__in,__cfg_Local).Layout __EE3480869, E_Person_Email(__in,__cfg_Local).Layout __EE6519985) := __EEQP(__EE6519985.Email_,__EE3480869.UID);
  SHARED __EE6520026 := JOIN(__EE3480869,__EE6519985,__JC6519991(LEFT,RIGHT),TRANSFORM(E_Email(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6520028 := __EE6520026;
  EXPORT Res48 := __UNWRAP(__EE6520028);
  SHARED __EE3480993 := __E_Inquiry;
  SHARED __EE3480983 := __E_Person_Inquiry;
  SHARED __EE6520326 := __EE3480983(__NN(__EE3480983.Subject_) AND __NN(__EE3480983.Transaction_));
  SHARED __EE6520111 := __ENH_Person;
  SHARED __EE6520425 := __EE6520111(__T(__OP2(__EE6520111.UID,=,__CN(__PPersonUID))));
  __JC6520431(E_Person_Inquiry(__in,__cfg_Local).Layout __EE6520326, B_Person(__in,__cfg_Local).__ST126252_Layout __EE6520425) := __EEQP(__EE6520425.UID,__EE6520326.Subject_);
  SHARED __EE6520440 := JOIN(__EE6520326,__EE6520425,__JC6520431(LEFT,RIGHT),TRANSFORM(E_Person_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6520446(E_Inquiry(__in,__cfg_Local).Layout __EE3480993, E_Person_Inquiry(__in,__cfg_Local).Layout __EE6520440) := __EEQP(__EE6520440.Transaction_,__EE3480993.UID);
  SHARED __EE6520506 := JOIN(__EE3480993,__EE6520440,__JC6520446(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6520508 := __EE6520506;
  EXPORT Res49 := __UNWRAP(__EE6520508);
  SHARED __EE6520645 := __ENH_Lien_Judgment;
  SHARED __EE3481134 := __E_Person_Lien_Judgment;
  SHARED __EE6520831 := __EE3481134(__NN(__EE3481134.Subject_) AND __NN(__EE3481134.Lien_));
  SHARED __EE6520648 := __ENH_Person;
  SHARED __EE6520913 := __EE6520648(__T(__OP2(__EE6520648.UID,=,__CN(__PPersonUID))));
  __JC6520919(E_Person_Lien_Judgment(__in,__cfg_Local).Layout __EE6520831, B_Person(__in,__cfg_Local).__ST126252_Layout __EE6520913) := __EEQP(__EE6520913.UID,__EE6520831.Subject_);
  SHARED __EE6520932 := JOIN(__EE6520831,__EE6520913,__JC6520919(LEFT,RIGHT),TRANSFORM(E_Person_Lien_Judgment(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6520938(B_Lien_Judgment_12(__in,__cfg_Local).__ST199785_Layout __EE6520645, E_Person_Lien_Judgment(__in,__cfg_Local).Layout __EE6520932) := __EEQP(__EE6520932.Lien_,__EE6520645.UID);
  SHARED __EE6520977 := JOIN(__EE6520645,__EE6520932,__JC6520938(LEFT,RIGHT),TRANSFORM(B_Lien_Judgment_12(__in,__cfg_Local).__ST199785_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6520979 := __EE6520977;
  EXPORT Res50 := __UNWRAP(__EE6520979);
  SHARED __EE3481277 := __E_Criminal_Offender;
  SHARED __EE3481267 := __E_Person_Offender;
  SHARED __EE6521229 := __EE3481267(__NN(__EE3481267.Subject_) AND __NN(__EE3481267.Offender_));
  SHARED __EE6521082 := __ENH_Person;
  SHARED __EE6521294 := __EE6521082(__T(__OP2(__EE6521082.UID,=,__CN(__PPersonUID))));
  __JC6521300(E_Person_Offender(__in,__cfg_Local).Layout __EE6521229, B_Person(__in,__cfg_Local).__ST126252_Layout __EE6521294) := __EEQP(__EE6521294.UID,__EE6521229.Subject_);
  SHARED __EE6521307 := JOIN(__EE6521229,__EE6521294,__JC6521300(LEFT,RIGHT),TRANSFORM(E_Person_Offender(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6521313(E_Criminal_Offender(__in,__cfg_Local).Layout __EE3481277, E_Person_Offender(__in,__cfg_Local).Layout __EE6521307) := __EEQP(__EE6521307.Offender_,__EE3481277.UID);
  SHARED __EE6521341 := JOIN(__EE3481277,__EE6521307,__JC6521313(LEFT,RIGHT),TRANSFORM(E_Criminal_Offender(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6521343 := __EE6521341;
  EXPORT Res51 := __UNWRAP(__EE6521343);
  SHARED __EE6521412 := __ENH_Criminal_Offense;
  SHARED __EE3481382 := __E_Person_Offenses;
  SHARED __EE6521674 := __EE3481382(__NN(__EE3481382.Subject_) AND __NN(__EE3481382.Offense_));
  SHARED __EE6521415 := __ENH_Person;
  SHARED __EE6521794 := __EE6521415(__T(__OP2(__EE6521415.UID,=,__CN(__PPersonUID))));
  __JC6521800(E_Person_Offenses(__in,__cfg_Local).Layout __EE6521674, B_Person(__in,__cfg_Local).__ST126252_Layout __EE6521794) := __EEQP(__EE6521794.UID,__EE6521674.Subject_);
  SHARED __EE6521807 := JOIN(__EE6521674,__EE6521794,__JC6521800(LEFT,RIGHT),TRANSFORM(E_Person_Offenses(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6521813(B_Criminal_Offense(__in,__cfg_Local).__ST115066_Layout __EE6521412, E_Person_Offenses(__in,__cfg_Local).Layout __EE6521807) := __EEQP(__EE6521807.Offense_,__EE6521412.UID);
  SHARED __EE6521896 := JOIN(__EE6521412,__EE6521807,__JC6521813(LEFT,RIGHT),TRANSFORM(B_Criminal_Offense(__in,__cfg_Local).__ST115066_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6521898 := __EE6521896;
  EXPORT Res52 := __UNWRAP(__EE6521898);
  SHARED __EE3481565 := __E_Phone;
  SHARED __EE3481555 := __E_Person_Phone;
  SHARED __EE6522328 := __EE3481555(__NN(__EE3481555.Subject_) AND __NN(__EE3481555.Phone_Number_));
  SHARED __EE6522077 := __ENH_Person;
  SHARED __EE6522445 := __EE6522077(__T(__OP2(__EE6522077.UID,=,__CN(__PPersonUID))));
  __JC6522451(E_Person_Phone(__in,__cfg_Local).Layout __EE6522328, B_Person(__in,__cfg_Local).__ST126252_Layout __EE6522445) := __EEQP(__EE6522445.UID,__EE6522328.Subject_);
  SHARED __EE6522485 := JOIN(__EE6522328,__EE6522445,__JC6522451(LEFT,RIGHT),TRANSFORM(E_Person_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6522491(E_Phone(__in,__cfg_Local).Layout __EE3481565, E_Person_Phone(__in,__cfg_Local).Layout __EE6522485) := __EEQP(__EE6522485.Phone_Number_,__EE3481565.UID);
  SHARED __EE6522544 := JOIN(__EE3481565,__EE6522485,__JC6522491(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6522546 := __EE6522544;
  EXPORT Res53 := __UNWRAP(__EE6522546);
  SHARED __EE6522719 := __ENH_Property;
  SHARED __EE3481729 := __E_Person_Property;
  SHARED __EE6522925 := __EE3481729(__NN(__EE3481729.Subject_) AND __NN(__EE3481729.Prop_));
  SHARED __EE6522722 := __ENH_Person;
  SHARED __EE6523017 := __EE6522722(__T(__OP2(__EE6522722.UID,=,__CN(__PPersonUID))));
  __JC6523023(E_Person_Property(__in,__cfg_Local).Layout __EE6522925, B_Person(__in,__cfg_Local).__ST126252_Layout __EE6523017) := __EEQP(__EE6523017.UID,__EE6522925.Subject_);
  SHARED __EE6523048 := JOIN(__EE6522925,__EE6523017,__JC6523023(LEFT,RIGHT),TRANSFORM(E_Person_Property(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6523054(B_Property(__in,__cfg_Local).__ST126787_Layout __EE6522719, E_Person_Property(__in,__cfg_Local).Layout __EE6523048) := __EEQP(__EE6523048.Prop_,__EE6522719.UID);
  SHARED __EE6523091 := JOIN(__EE6522719,__EE6523048,__JC6523054(LEFT,RIGHT),TRANSFORM(B_Property(__in,__cfg_Local).__ST126787_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6523093 := __EE6523091;
  EXPORT Res54 := __UNWRAP(__EE6523093);
  SHARED __EE6523216 := __ENH_Property_Event;
  SHARED __EE3481873 := __E_Person_Property_Event;
  SHARED __EE6523942 := __EE3481873(__NN(__EE3481873.Subject_) AND __NN(__EE3481873.Event_));
  SHARED __EE6523219 := __ENH_Person;
  SHARED __EE6524294 := __EE6523219(__T(__OP2(__EE6523219.UID,=,__CN(__PPersonUID))));
  __JC6524300(E_Person_Property_Event(__in,__cfg_Local).Layout __EE6523942, B_Person(__in,__cfg_Local).__ST126252_Layout __EE6524294) := __EEQP(__EE6524294.UID,__EE6523942.Subject_);
  SHARED __EE6524320 := JOIN(__EE6523942,__EE6524294,__JC6524300(LEFT,RIGHT),TRANSFORM(E_Person_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6524326(B_Property_Event_3(__in,__cfg_Local).__ST173128_Layout __EE6523216, E_Person_Property_Event(__in,__cfg_Local).Layout __EE6524320) := __EEQP(__EE6524320.Event_,__EE6523216.UID);
  SHARED __EE6524628 := JOIN(__EE6523216,__EE6524320,__JC6524326(LEFT,RIGHT),TRANSFORM(B_Property_Event_3(__in,__cfg_Local).__ST173128_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6524630 := __EE6524628;
  EXPORT Res55 := __UNWRAP(__EE6524630);
  SHARED __EE3482285 := __E_Social_Security_Number;
  SHARED __EE3482275 := __E_Person_S_S_N;
  SHARED __EE6525402 := __EE3482275(__NN(__EE3482275.Subject_) AND __NN(__EE3482275.Social_));
  SHARED __EE6525273 := __ENH_Person;
  SHARED __EE6525458 := __EE6525273(__T(__OP2(__EE6525273.UID,=,__CN(__PPersonUID))));
  __JC6525464(E_Person_S_S_N(__in,__cfg_Local).Layout __EE6525402, B_Person(__in,__cfg_Local).__ST126252_Layout __EE6525458) := __EEQP(__EE6525458.UID,__EE6525402.Subject_);
  SHARED __EE6525476 := JOIN(__EE6525402,__EE6525458,__JC6525464(LEFT,RIGHT),TRANSFORM(E_Person_S_S_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6525482(E_Social_Security_Number(__in,__cfg_Local).Layout __EE3482285, E_Person_S_S_N(__in,__cfg_Local).Layout __EE6525476) := __EEQP(__EE6525476.Social_,__EE3482285.UID);
  SHARED __EE6525496 := JOIN(__EE3482285,__EE6525476,__JC6525482(LEFT,RIGHT),TRANSFORM(E_Social_Security_Number(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6525498 := __EE6525496;
  EXPORT Res56 := __UNWRAP(__EE6525498);
  SHARED __EE6525549 := __ENH_U_C_C;
  SHARED __EE3482380 := __E_Person_U_C_C;
  SHARED __EE6525771 := __EE3482380(__NN(__EE3482380.Subject_) AND __NN(__EE3482380.Filing_));
  SHARED __EE6525552 := __ENH_Person;
  SHARED __EE6525871 := __EE6525552(__T(__OP2(__EE6525552.UID,=,__CN(__PPersonUID))));
  __JC6525877(E_Person_U_C_C(__in,__cfg_Local).Layout __EE6525771, B_Person(__in,__cfg_Local).__ST126252_Layout __EE6525871) := __EEQP(__EE6525871.UID,__EE6525771.Subject_);
  SHARED __EE6525889 := JOIN(__EE6525771,__EE6525871,__JC6525877(LEFT,RIGHT),TRANSFORM(E_Person_U_C_C(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6525895(B_U_C_C(__in,__cfg_Local).__ST127964_Layout __EE6525549, E_Person_U_C_C(__in,__cfg_Local).Layout __EE6525889) := __EEQP(__EE6525889.Filing_,__EE6525549.UID);
  SHARED __EE6525953 := JOIN(__EE6525549,__EE6525889,__JC6525895(LEFT,RIGHT),TRANSFORM(B_U_C_C(__in,__cfg_Local).__ST127964_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6525955 := __EE6525953;
  EXPORT Res57 := __UNWRAP(__EE6525955);
  SHARED __EE3482542 := __E_Vehicle;
  SHARED __EE3482532 := __E_Person_Vehicle;
  SHARED __EE6526479 := __EE3482532(__NN(__EE3482532.Subject_) AND __NN(__EE3482532.Automobile_));
  SHARED __EE6526094 := __ENH_Person;
  SHARED __EE6526663 := __EE6526094(__T(__OP2(__EE6526094.UID,=,__CN(__PPersonUID))));
  __JC6526669(E_Person_Vehicle(__in,__cfg_Local).Layout __EE6526479, B_Person(__in,__cfg_Local).__ST126252_Layout __EE6526663) := __EEQP(__EE6526663.UID,__EE6526479.Subject_);
  SHARED __EE6526712 := JOIN(__EE6526479,__EE6526663,__JC6526669(LEFT,RIGHT),TRANSFORM(E_Person_Vehicle(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6526718(E_Vehicle(__in,__cfg_Local).Layout __EE3482542, E_Person_Vehicle(__in,__cfg_Local).Layout __EE6526712) := __EEQP(__EE6526712.Automobile_,__EE3482542.UID);
  SHARED __EE6526829 := JOIN(__EE3482542,__EE6526712,__JC6526718(LEFT,RIGHT),TRANSFORM(E_Vehicle(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6526831 := __EE6526829;
  EXPORT Res58 := __UNWRAP(__EE6526831);
  SHARED __EE6527138 := __ENH_Professional_License;
  SHARED __EE3482766 := __E_Professional_License_Person;
  SHARED __EE6527324 := __EE3482766(__NN(__EE3482766.Subject_) AND __NN(__EE3482766.Prof_Lic_));
  SHARED __EE6527141 := __ENH_Person;
  SHARED __EE6527406 := __EE6527141(__T(__OP2(__EE6527141.UID,=,__CN(__PPersonUID))));
  __JC6527412(E_Professional_License_Person(__in,__cfg_Local).Layout __EE6527324, B_Person(__in,__cfg_Local).__ST126252_Layout __EE6527406) := __EEQP(__EE6527406.UID,__EE6527324.Subject_);
  SHARED __EE6527419 := JOIN(__EE6527324,__EE6527406,__JC6527412(LEFT,RIGHT),TRANSFORM(E_Professional_License_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6527425(B_Professional_License_4(__in,__cfg_Local).__ST182069_Layout __EE6527138, E_Professional_License_Person(__in,__cfg_Local).Layout __EE6527419) := __EEQP(__EE6527419.Prof_Lic_,__EE6527138.UID);
  SHARED __EE6527470 := JOIN(__EE6527138,__EE6527419,__JC6527425(LEFT,RIGHT),TRANSFORM(B_Professional_License_4(__in,__cfg_Local).__ST182069_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6527472 := __EE6527470;
  EXPORT Res59 := __UNWRAP(__EE6527472);
  SHARED __EE6527575 := __ENH_Business_Prox;
  SHARED __EE3482900 := __E_Prox_Person;
  SHARED __EE6528233 := __EE3482900(__NN(__EE3482900.Contact_) AND __NN(__EE3482900.Business_Location_));
  SHARED __EE6527578 := __ENH_Person;
  SHARED __EE6528551 := __EE6527578(__T(__OP2(__EE6527578.UID,=,__CN(__PPersonUID))));
  __JC6528557(E_Prox_Person(__in,__cfg_Local).Layout __EE6528233, B_Person(__in,__cfg_Local).__ST126252_Layout __EE6528551) := __EEQP(__EE6528551.UID,__EE6528233.Contact_);
  SHARED __EE6528585 := JOIN(__EE6528233,__EE6528551,__JC6528557(LEFT,RIGHT),TRANSFORM(E_Prox_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6528591(B_Business_Prox(__in,__cfg_Local).__ST95570_Layout __EE6527575, E_Prox_Person(__in,__cfg_Local).Layout __EE6528585) := __EEQP(__EE6528585.Business_Location_,__EE6527575.UID);
  SHARED __EE6528851 := JOIN(__EE6527575,__EE6528585,__JC6528591(LEFT,RIGHT),TRANSFORM(B_Business_Prox(__in,__cfg_Local).__ST95570_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6528853 := __EE6528851;
  EXPORT Res60 := __UNWRAP(__EE6528853);
  SHARED __EE6529428 := __ENH_Business_Sele;
  SHARED __EE3483292 := __E_Sele_Person;
  SHARED __EE6532600 := __EE3483292(__NN(__EE3483292.Contact_) AND __NN(__EE3483292.Legal_));
  SHARED __EE6529431 := __ENH_Person;
  SHARED __EE6534175 := __EE6529431(__T(__OP2(__EE6529431.UID,=,__CN(__PPersonUID))));
  __JC6534181(E_Sele_Person(__in,__cfg_Local).Layout __EE6532600, B_Person(__in,__cfg_Local).__ST126252_Layout __EE6534175) := __EEQP(__EE6534175.UID,__EE6532600.Contact_);
  SHARED __EE6534212 := JOIN(__EE6532600,__EE6534175,__JC6534181(LEFT,RIGHT),TRANSFORM(E_Sele_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6534218(B_Business_Sele(__in,__cfg_Local).__ST113627_Layout __EE6529428, E_Sele_Person(__in,__cfg_Local).Layout __EE6534212) := __EEQP(__EE6534212.Legal_,__EE6529428.UID);
  SHARED __EE6535732 := JOIN(__EE6529428,__EE6534212,__JC6534218(LEFT,RIGHT),TRANSFORM(B_Business_Sele(__in,__cfg_Local).__ST113627_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6535734 := __EE6535732;
  EXPORT Res61 := __UNWRAP(__EE6535734);
  SHARED __EE3485029 := __E_Utility;
  SHARED __EE3485019 := __E_Utility_Person;
  SHARED __EE6538966 := __EE3485019(__NN(__EE3485019.Subject_) AND __NN(__EE3485019.Util_));
  SHARED __EE6538823 := __ENH_Person;
  SHARED __EE6539029 := __EE6538823(__T(__OP2(__EE6538823.UID,=,__CN(__PPersonUID))));
  __JC6539035(E_Utility_Person(__in,__cfg_Local).Layout __EE6538966, B_Person(__in,__cfg_Local).__ST126252_Layout __EE6539029) := __EEQP(__EE6539029.UID,__EE6538966.Subject_);
  SHARED __EE6539042 := JOIN(__EE6538966,__EE6539029,__JC6539035(LEFT,RIGHT),TRANSFORM(E_Utility_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6539048(E_Utility(__in,__cfg_Local).Layout __EE3485029, E_Utility_Person(__in,__cfg_Local).Layout __EE6539042) := __EEQP(__EE6539042.Util_,__EE3485029.UID);
  SHARED __EE6539074 := JOIN(__EE3485029,__EE6539042,__JC6539048(LEFT,RIGHT),TRANSFORM(E_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6539076 := __EE6539074;
  EXPORT Res62 := __UNWRAP(__EE6539076);
  SHARED __EE3485140 := __E_Watercraft;
  SHARED __EE3485130 := __E_Watercraft_Owner;
  SHARED __EE6539254 := __EE3485130(__NN(__EE3485130.Owner_) AND __NN(__EE3485130.W_Craft_));
  SHARED __EE6539141 := __ENH_Person;
  SHARED __EE6539302 := __EE6539141(__T(__OP2(__EE6539141.UID,=,__CN(__PPersonUID))));
  __JC6539308(E_Watercraft_Owner(__in,__cfg_Local).Layout __EE6539254, B_Person(__in,__cfg_Local).__ST126252_Layout __EE6539302) := __EEQP(__EE6539302.UID,__EE6539254.Owner_);
  SHARED __EE6539315 := JOIN(__EE6539254,__EE6539302,__JC6539308(LEFT,RIGHT),TRANSFORM(E_Watercraft_Owner(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6539321(E_Watercraft(__in,__cfg_Local).Layout __EE3485140, E_Watercraft_Owner(__in,__cfg_Local).Layout __EE6539315) := __EEQP(__EE6539315.W_Craft_,__EE3485140.UID);
  SHARED __EE6539332 := JOIN(__EE3485140,__EE6539315,__JC6539321(LEFT,RIGHT),TRANSFORM(E_Watercraft(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6539334 := __EE6539332;
  EXPORT Res63 := __UNWRAP(__EE6539334);
  SHARED __EE3485236 := __E_Zip_Code;
  SHARED __EE3485226 := __E_Zip_Code_Person;
  SHARED __EE6539484 := __EE3485226(__NN(__EE3485226.Subject_) AND __NN(__EE3485226.Zip_));
  SHARED __EE6539369 := __ENH_Person;
  SHARED __EE6539533 := __EE6539369(__T(__OP2(__EE6539369.UID,=,__CN(__PPersonUID))));
  __JC6539539(E_Zip_Code_Person(__in,__cfg_Local).Layout __EE6539484, B_Person(__in,__cfg_Local).__ST126252_Layout __EE6539533) := __EEQP(__EE6539533.UID,__EE6539484.Subject_);
  SHARED __EE6539547 := JOIN(__EE6539484,__EE6539533,__JC6539539(LEFT,RIGHT),TRANSFORM(E_Zip_Code_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6539553(E_Zip_Code(__in,__cfg_Local).Layout __EE3485236, E_Zip_Code_Person(__in,__cfg_Local).Layout __EE6539547) := __EEQP(__EE6539547.Zip_,__EE3485236.UID);
  SHARED __EE6539564 := JOIN(__EE3485236,__EE6539547,__JC6539553(LEFT,RIGHT),TRANSFORM(E_Zip_Code(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6539566 := __EE6539564;
  EXPORT Res64 := __UNWRAP(__EE6539566);
  SHARED __EE3485322 := __E_Person_Email_Phone_Address;
  SHARED __EE6539678 := __EE3485322(__NN(__EE3485322.Subject_));
  SHARED __EE6539603 := __ENH_Person;
  SHARED __EE6539683 := __EE6539603(__T(__OP2(__EE6539603.UID,=,__CN(__PPersonUID))));
  __JC6539689(E_Person_Email_Phone_Address(__in,__cfg_Local).Layout __EE6539678, B_Person(__in,__cfg_Local).__ST126252_Layout __EE6539683) := __EEQP(__EE6539683.UID,__EE6539678.Subject_);
  SHARED __EE6539709 := JOIN(__EE6539678,__EE6539683,__JC6539689(LEFT,RIGHT),TRANSFORM(E_Person_Email_Phone_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6539711 := __EE6539709;
  EXPORT Res65 := __UNWRAP(__EE6539711);
  SHARED __EE6539752 := __ENH_Address;
  SHARED __EE3485393 := __E_Address_Phone;
  SHARED __EE6540160 := __EE3485393(__NN(__EE3485393.Phone_Number_) AND __NN(__EE3485393.Location_));
  SHARED __EE3485387 := __E_Phone;
  SHARED __EE6540376 := __EE3485387(__T(__OP2(__EE3485387.UID,=,__CN(__PPhoneUID))));
  __JC6540382(E_Address_Phone(__in,__cfg_Local).Layout __EE6540160, E_Phone(__in,__cfg_Local).Layout __EE6540376) := __EEQP(__EE6540376.UID,__EE6540160.Phone_Number_);
  SHARED __EE6540410 := JOIN(__EE6540160,__EE6540376,__JC6540382(LEFT,RIGHT),TRANSFORM(E_Address_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6540416(B_Address_1(__in,__cfg_Local).__ST128087_Layout __EE6539752, E_Address_Phone(__in,__cfg_Local).Layout __EE6540410) := __EEQP(__EE6540410.Location_,__EE6539752.UID);
  SHARED __EE6540574 := JOIN(__EE6539752,__EE6540410,__JC6540416(LEFT,RIGHT),TRANSFORM(B_Address_1(__in,__cfg_Local).__ST128087_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6540576 := __EE6540574;
  EXPORT Res66 := __UNWRAP(__EE6540576);
  SHARED __EE6540947 := __ENH_Person;
  SHARED __EE3485682 := __E_Person_Phone;
  SHARED __EE6542709 := __EE3485682(__NN(__EE3485682.Phone_Number_) AND __NN(__EE3485682.Subject_));
  SHARED __EE3485676 := __E_Phone;
  SHARED __EE6543605 := __EE3485676(__T(__OP2(__EE3485676.UID,=,__CN(__PPhoneUID))));
  __JC6543611(E_Person_Phone(__in,__cfg_Local).Layout __EE6542709, E_Phone(__in,__cfg_Local).Layout __EE6543605) := __EEQP(__EE6543605.UID,__EE6542709.Phone_Number_);
  SHARED __EE6543645 := JOIN(__EE6542709,__EE6543605,__JC6543611(LEFT,RIGHT),TRANSFORM(E_Person_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6543651(B_Person(__in,__cfg_Local).__ST126252_Layout __EE6540947, E_Person_Phone(__in,__cfg_Local).Layout __EE6543645) := __EEQP(__EE6543645.Subject_,__EE6540947.UID);
  SHARED __EE6544483 := JOIN(__EE6540947,__EE6543645,__JC6543651(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST126252_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6544485 := __EE6544483;
  EXPORT Res67 := __UNWRAP(__EE6544485);
  SHARED __EE3486701 := __E_Inquiry;
  SHARED __EE3486691 := __E_Phone_Inquiry;
  SHARED __EE6546339 := __EE3486691(__NN(__EE3486691.Phone_Number_) AND __NN(__EE3486691.Transaction_));
  SHARED __EE3486685 := __E_Phone;
  SHARED __EE6546438 := __EE3486685(__T(__OP2(__EE3486685.UID,=,__CN(__PPhoneUID))));
  __JC6546444(E_Phone_Inquiry(__in,__cfg_Local).Layout __EE6546339, E_Phone(__in,__cfg_Local).Layout __EE6546438) := __EEQP(__EE6546438.UID,__EE6546339.Phone_Number_);
  SHARED __EE6546453 := JOIN(__EE6546339,__EE6546438,__JC6546444(LEFT,RIGHT),TRANSFORM(E_Phone_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6546459(E_Inquiry(__in,__cfg_Local).Layout __EE3486701, E_Phone_Inquiry(__in,__cfg_Local).Layout __EE6546453) := __EEQP(__EE6546453.Transaction_,__EE3486701.UID);
  SHARED __EE6546519 := JOIN(__EE3486701,__EE6546453,__JC6546459(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6546521 := __EE6546519;
  EXPORT Res68 := __UNWRAP(__EE6546521);
  SHARED __EE3486851 := __E_T_I_N;
  SHARED __EE3486841 := __E_T_I_N_Phone_Number;
  SHARED __EE6546727 := __EE3486841(__NN(__EE3486841.Phone_Number_) AND __NN(__EE3486841.Tax_I_D_));
  SHARED __EE3486835 := __E_Phone;
  SHARED __EE6546772 := __EE3486835(__T(__OP2(__EE3486835.UID,=,__CN(__PPhoneUID))));
  __JC6546778(E_T_I_N_Phone_Number(__in,__cfg_Local).Layout __EE6546727, E_Phone(__in,__cfg_Local).Layout __EE6546772) := __EEQP(__EE6546772.UID,__EE6546727.Phone_Number_);
  SHARED __EE6546789 := JOIN(__EE6546727,__EE6546772,__JC6546778(LEFT,RIGHT),TRANSFORM(E_T_I_N_Phone_Number(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6546795(E_T_I_N(__in,__cfg_Local).Layout __EE3486851, E_T_I_N_Phone_Number(__in,__cfg_Local).Layout __EE6546789) := __EEQP(__EE6546789.Tax_I_D_,__EE3486851.UID);
  SHARED __EE6546799 := JOIN(__EE3486851,__EE6546789,__JC6546795(LEFT,RIGHT),TRANSFORM(E_T_I_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6546801 := __EE6546799;
  EXPORT Res69 := __UNWRAP(__EE6546801);
  SHARED __EE6546830 := __ENH_Second_Degree_Associations;
  SHARED __EE6546894 := __EE6546830(__NN(__EE6546830.First_Degree_Association_));
  SHARED __EE6546833 := __ENH_Person;
  SHARED __EE6546899 := __EE6546833(__T(__OP2(__EE6546833.UID,=,__CN(__PPersonUID))));
  __JC6546905(E_Second_Degree_Associations(__in,__cfg_Local).Layout __EE6546894, B_Person(__in,__cfg_Local).__ST126252_Layout __EE6546899) := __EEQP(__EE6546899.UID,__EE6546894.First_Degree_Association_);
  SHARED __EE6546917 := JOIN(__EE6546894,__EE6546899,__JC6546905(LEFT,RIGHT),TRANSFORM(E_Second_Degree_Associations(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6546919 := __EE6546917;
  EXPORT Res70 := __UNWRAP(__EE6546919);
  SHARED __EE6546944 := __ENH_Person;
  SHARED __EE3487006 := __E_Person_Property_Event;
  SHARED __EE6549368 := __EE3487006(__NN(__EE3487006.Event_) AND __NN(__EE3487006.Subject_));
  SHARED __EE6546947 := __ENH_Property_Event;
  SHARED __EE6549345 := __EE6546947(__NN(__EE6546947.Prop_));
  SHARED __EE6546950 := __ENH_Property;
  SHARED __EE6550250 := __EE6546950(__T(__OP2(__EE6546950.UID,=,__CN(__PPropertyUID))));
  __JC6550256(B_Property_Event_3(__in,__cfg_Local).__ST173128_Layout __EE6549345, B_Property(__in,__cfg_Local).__ST126787_Layout __EE6550250) := __EEQP(__EE6550250.UID,__EE6549345.Prop_);
  SHARED __EE6550558 := JOIN(__EE6549345,__EE6550250,__JC6550256(LEFT,RIGHT),TRANSFORM(B_Property_Event_3(__in,__cfg_Local).__ST173128_Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6550564(E_Person_Property_Event(__in,__cfg_Local).Layout __EE6549368, B_Property_Event_3(__in,__cfg_Local).__ST173128_Layout __EE6550558) := __EEQP(__EE6550558.UID,__EE6549368.Event_);
  SHARED __EE6550584 := JOIN(__EE6549368,__EE6550558,__JC6550564(LEFT,RIGHT),TRANSFORM(E_Person_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6550590(B_Person(__in,__cfg_Local).__ST126252_Layout __EE6546944, E_Person_Property_Event(__in,__cfg_Local).Layout __EE6550584) := __EEQP(__EE6550584.Subject_,__EE6546944.UID);
  SHARED __EE6551422 := JOIN(__EE6546944,__EE6550584,__JC6550590(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST126252_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6551424 := __EE6551422;
  EXPORT Res71 := __UNWRAP(__EE6551424);
  SHARED __EE6553729 := __ENH_Business_Sele;
  SHARED __EE3488328 := __E_Sele_Property_Event;
  SHARED __EE6557523 := __EE3488328(__NN(__EE3488328.Event_) AND __NN(__EE3488328.Legal_));
  SHARED __EE6553732 := __ENH_Property_Event;
  SHARED __EE6557500 := __EE6553732(__NN(__EE6553732.Prop_));
  SHARED __EE6553735 := __ENH_Property;
  SHARED __EE6559090 := __EE6553735(__T(__OP2(__EE6553735.UID,=,__CN(__PPropertyUID))));
  __JC6559096(B_Property_Event_3(__in,__cfg_Local).__ST173128_Layout __EE6557500, B_Property(__in,__cfg_Local).__ST126787_Layout __EE6559090) := __EEQP(__EE6559090.UID,__EE6557500.Prop_);
  SHARED __EE6559398 := JOIN(__EE6557500,__EE6559090,__JC6559096(LEFT,RIGHT),TRANSFORM(B_Property_Event_3(__in,__cfg_Local).__ST173128_Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6559404(E_Sele_Property_Event(__in,__cfg_Local).Layout __EE6557523, B_Property_Event_3(__in,__cfg_Local).__ST173128_Layout __EE6559398) := __EEQP(__EE6559398.UID,__EE6557523.Event_);
  SHARED __EE6559427 := JOIN(__EE6557523,__EE6559398,__JC6559404(LEFT,RIGHT),TRANSFORM(E_Sele_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6559433(B_Business_Sele(__in,__cfg_Local).__ST113627_Layout __EE6553729, E_Sele_Property_Event(__in,__cfg_Local).Layout __EE6559427) := __EEQP(__EE6559427.Legal_,__EE6553729.UID);
  SHARED __EE6560947 := JOIN(__EE6553729,__EE6559427,__JC6559433(LEFT,RIGHT),TRANSFORM(B_Business_Sele(__in,__cfg_Local).__ST113627_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6560949 := __EE6560947;
  EXPORT Res72 := __UNWRAP(__EE6560949);
  SHARED __EE6564624 := __ENH_Person;
  SHARED __EE3490364 := __E_Person_S_S_N;
  SHARED __EE6566364 := __EE3490364(__NN(__EE3490364.Social_) AND __NN(__EE3490364.Subject_));
  SHARED __EE3490358 := __E_Social_Security_Number;
  SHARED __EE6567238 := __EE3490358(__T(__OP2(__EE3490358.UID,=,__CN(__PSocialSecurityNumberUID))));
  __JC6567244(E_Person_S_S_N(__in,__cfg_Local).Layout __EE6566364, E_Social_Security_Number(__in,__cfg_Local).Layout __EE6567238) := __EEQP(__EE6567238.UID,__EE6566364.Social_);
  SHARED __EE6567256 := JOIN(__EE6566364,__EE6567238,__JC6567244(LEFT,RIGHT),TRANSFORM(E_Person_S_S_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6567262(B_Person(__in,__cfg_Local).__ST126252_Layout __EE6564624, E_Person_S_S_N(__in,__cfg_Local).Layout __EE6567256) := __EEQP(__EE6567256.Subject_,__EE6564624.UID);
  SHARED __EE6568094 := JOIN(__EE6564624,__EE6567256,__JC6567262(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST126252_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6568096 := __EE6568094;
  EXPORT Res73 := __UNWRAP(__EE6568096);
  SHARED __EE6569783 := __ENH_Address;
  SHARED __EE3491349 := __E_S_S_N_Address;
  SHARED __EE6570179 := __EE3491349(__NN(__EE3491349.Social_) AND __NN(__EE3491349.Location_));
  SHARED __EE3491343 := __E_Social_Security_Number;
  SHARED __EE6570383 := __EE3491343(__T(__OP2(__EE3491343.UID,=,__CN(__PSocialSecurityNumberUID))));
  __JC6570389(E_S_S_N_Address(__in,__cfg_Local).Layout __EE6570179, E_Social_Security_Number(__in,__cfg_Local).Layout __EE6570383) := __EEQP(__EE6570383.UID,__EE6570179.Social_);
  SHARED __EE6570405 := JOIN(__EE6570179,__EE6570383,__JC6570389(LEFT,RIGHT),TRANSFORM(E_S_S_N_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6570411(B_Address_1(__in,__cfg_Local).__ST128087_Layout __EE6569783, E_S_S_N_Address(__in,__cfg_Local).Layout __EE6570405) := __EEQP(__EE6570405.Location_,__EE6569783.UID);
  SHARED __EE6570569 := JOIN(__EE6569783,__EE6570405,__JC6570411(LEFT,RIGHT),TRANSFORM(B_Address_1(__in,__cfg_Local).__ST128087_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6570571 := __EE6570569;
  EXPORT Res74 := __UNWRAP(__EE6570571);
  SHARED __EE3491634 := __E_Inquiry;
  SHARED __EE3491624 := __E_S_S_N_Inquiry;
  SHARED __EE6571041 := __EE3491624(__NN(__EE3491624.S_S_N_) AND __NN(__EE3491624.Transaction_));
  SHARED __EE3491618 := __E_Social_Security_Number;
  SHARED __EE6571140 := __EE3491618(__T(__OP2(__EE3491618.UID,=,__CN(__PSocialSecurityNumberUID))));
  __JC6571146(E_S_S_N_Inquiry(__in,__cfg_Local).Layout __EE6571041, E_Social_Security_Number(__in,__cfg_Local).Layout __EE6571140) := __EEQP(__EE6571140.UID,__EE6571041.S_S_N_);
  SHARED __EE6571155 := JOIN(__EE6571041,__EE6571140,__JC6571146(LEFT,RIGHT),TRANSFORM(E_S_S_N_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6571161(E_Inquiry(__in,__cfg_Local).Layout __EE3491634, E_S_S_N_Inquiry(__in,__cfg_Local).Layout __EE6571155) := __EEQP(__EE6571155.Transaction_,__EE3491634.UID);
  SHARED __EE6571221 := JOIN(__EE3491634,__EE6571155,__JC6571161(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6571223 := __EE6571221;
  EXPORT Res75 := __UNWRAP(__EE6571223);
  SHARED __EE3491784 := __E_Inquiry;
  SHARED __EE3491774 := __E_T_I_N_Inquiry;
  SHARED __EE6571483 := __EE3491774(__NN(__EE3491774.Tax_I_D_) AND __NN(__EE3491774.Transaction_));
  SHARED __EE3491768 := __E_T_I_N;
  SHARED __EE6571582 := __EE3491768(__T(__OP2(__EE3491768.UID,=,__CN(__PTINUID))));
  __JC6571588(E_T_I_N_Inquiry(__in,__cfg_Local).Layout __EE6571483, E_T_I_N(__in,__cfg_Local).Layout __EE6571582) := __EEQP(__EE6571582.UID,__EE6571483.Tax_I_D_);
  SHARED __EE6571597 := JOIN(__EE6571483,__EE6571582,__JC6571588(LEFT,RIGHT),TRANSFORM(E_T_I_N_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6571603(E_Inquiry(__in,__cfg_Local).Layout __EE3491784, E_T_I_N_Inquiry(__in,__cfg_Local).Layout __EE6571597) := __EEQP(__EE6571597.Transaction_,__EE3491784.UID);
  SHARED __EE6571663 := JOIN(__EE3491784,__EE6571597,__JC6571603(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6571665 := __EE6571663;
  EXPORT Res76 := __UNWRAP(__EE6571665);
  SHARED __EE6571802 := __ENH_Address;
  SHARED __EE3491924 := __E_T_I_N_Address;
  SHARED __EE6572197 := __EE3491924(__NN(__EE3491924.Tax_I_D_) AND __NN(__EE3491924.Location_));
  SHARED __EE3491918 := __E_T_I_N;
  SHARED __EE6572400 := __EE3491918(__T(__OP2(__EE3491918.UID,=,__CN(__PTINUID))));
  __JC6572406(E_T_I_N_Address(__in,__cfg_Local).Layout __EE6572197, E_T_I_N(__in,__cfg_Local).Layout __EE6572400) := __EEQP(__EE6572400.UID,__EE6572197.Tax_I_D_);
  SHARED __EE6572421 := JOIN(__EE6572197,__EE6572400,__JC6572406(LEFT,RIGHT),TRANSFORM(E_T_I_N_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6572427(B_Address_1(__in,__cfg_Local).__ST128087_Layout __EE6571802, E_T_I_N_Address(__in,__cfg_Local).Layout __EE6572421) := __EEQP(__EE6572421.Location_,__EE6571802.UID);
  SHARED __EE6572585 := JOIN(__EE6571802,__EE6572421,__JC6572427(LEFT,RIGHT),TRANSFORM(B_Address_1(__in,__cfg_Local).__ST128087_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6572587 := __EE6572585;
  EXPORT Res77 := __UNWRAP(__EE6572587);
  SHARED __EE3492208 := __E_Phone;
  SHARED __EE3492198 := __E_T_I_N_Phone_Number;
  SHARED __EE6573050 := __EE3492198(__NN(__EE3492198.Tax_I_D_) AND __NN(__EE3492198.Phone_Number_));
  SHARED __EE3492192 := __E_T_I_N;
  SHARED __EE6573144 := __EE3492192(__T(__OP2(__EE3492192.UID,=,__CN(__PTINUID))));
  __JC6573150(E_T_I_N_Phone_Number(__in,__cfg_Local).Layout __EE6573050, E_T_I_N(__in,__cfg_Local).Layout __EE6573144) := __EEQP(__EE6573144.UID,__EE6573050.Tax_I_D_);
  SHARED __EE6573161 := JOIN(__EE6573050,__EE6573144,__JC6573150(LEFT,RIGHT),TRANSFORM(E_T_I_N_Phone_Number(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6573167(E_Phone(__in,__cfg_Local).Layout __EE3492208, E_T_I_N_Phone_Number(__in,__cfg_Local).Layout __EE6573161) := __EEQP(__EE6573161.Phone_Number_,__EE3492208.UID);
  SHARED __EE6573220 := JOIN(__EE3492208,__EE6573161,__JC6573167(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6573222 := __EE6573220;
  EXPORT Res78 := __UNWRAP(__EE6573222);
  SHARED __EE6573349 := __ENH_Person;
  SHARED __EE3492346 := __E_Zip_Code_Person;
  SHARED __EE6575085 := __EE3492346(__NN(__EE3492346.Zip_) AND __NN(__EE3492346.Subject_));
  SHARED __EE3492340 := __E_Zip_Code;
  SHARED __EE6575955 := __EE3492340(__T(__OP2(__EE3492340.UID,=,__CN(__PZipCodeUID))));
  __JC6575961(E_Zip_Code_Person(__in,__cfg_Local).Layout __EE6575085, E_Zip_Code(__in,__cfg_Local).Layout __EE6575955) := __EEQP(__EE6575955.UID,__EE6575085.Zip_);
  SHARED __EE6575969 := JOIN(__EE6575085,__EE6575955,__JC6575961(LEFT,RIGHT),TRANSFORM(E_Zip_Code_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6575975(B_Person(__in,__cfg_Local).__ST126252_Layout __EE6573349, E_Zip_Code_Person(__in,__cfg_Local).Layout __EE6575969) := __EEQP(__EE6575969.Subject_,__EE6573349.UID);
  SHARED __EE6576807 := JOIN(__EE6573349,__EE6575969,__JC6575975(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST126252_Layout,SELF:=LEFT),SMART,KEEP(1));
  EXPORT Res79 := __UNWRAP(__EE6576807);
END;
