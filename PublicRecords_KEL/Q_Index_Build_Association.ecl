//HPCC Systems KEL Compiler Version 1.3.0
IMPORT KEL13 AS KEL;
IMPORT B_Address,B_Address_1,B_Address_2,B_Address_3,B_Address_4,B_Address_5,B_Address_6,B_Aircraft_Owner_1,B_Aircraft_Owner_2,B_Aircraft_Owner_3,B_Bankruptcy,B_Bankruptcy_1,B_Bankruptcy_2,B_Bankruptcy_3,B_Bankruptcy_4,B_Bankruptcy_5,B_Bankruptcy_6,B_Bankruptcy_7,B_Bankruptcy_8,B_Business_Prox,B_Business_Prox_1,B_Business_Prox_2,B_Business_Prox_3,B_Business_Sele,B_Business_Sele_1,B_Business_Sele_10,B_Business_Sele_2,B_Business_Sele_3,B_Business_Sele_4,B_Business_Sele_5,B_Business_Sele_6,B_Business_Sele_7,B_Business_Sele_8,B_Business_Sele_9,B_Criminal_Offense,B_Criminal_Offense_1,B_Criminal_Offense_2,B_Criminal_Offense_3,B_Criminal_Offense_4,B_Criminal_Offense_5,B_Education,B_Education_1,B_Education_2,B_Education_3,B_Education_4,B_Education_5,B_Education_6,B_Education_7,B_Email,B_Email_1,B_Email_2,B_First_Degree_Relative,B_First_Degree_Relative_1,B_First_Degree_Relative_2,B_First_Degree_Relative_3,B_First_Degree_Relative_4,B_First_Degree_Relative_5,B_Input_B_I_I_1,B_Input_B_I_I_10,B_Input_B_I_I_2,B_Input_B_I_I_3,B_Input_B_I_I_4,B_Input_B_I_I_5,B_Input_B_I_I_6,B_Input_B_I_I_7,B_Input_B_I_I_8,B_Input_B_I_I_9,B_Input_P_I_I_2,B_Input_P_I_I_3,B_Input_P_I_I_4,B_Input_P_I_I_5,B_Input_P_I_I_6,B_Input_P_I_I_7,B_Input_P_I_I_8,B_Input_P_I_I_9,B_Lien_Judgment,B_Lien_Judgment_1,B_Lien_Judgment_10,B_Lien_Judgment_11,B_Lien_Judgment_12,B_Lien_Judgment_2,B_Lien_Judgment_3,B_Lien_Judgment_4,B_Lien_Judgment_5,B_Lien_Judgment_6,B_Lien_Judgment_7,B_Lien_Judgment_8,B_Lien_Judgment_9,B_Person,B_Person_1,B_Person_10,B_Person_2,B_Person_3,B_Person_4,B_Person_5,B_Person_6,B_Person_7,B_Person_8,B_Person_9,B_Person_Address_2,B_Person_Address_3,B_Person_Lien_Judgment_8,B_Person_S_S_N_1,B_Person_S_S_N_2,B_Person_Vehicle_1,B_Person_Vehicle_2,B_Person_Vehicle_3,B_Professional_License,B_Professional_License_1,B_Professional_License_2,B_Professional_License_3,B_Professional_License_4,B_Professional_License_5,B_Property,B_Property_1,B_Property_2,B_Property_3,B_Property_4,B_Property_5,B_Property_Event,B_Property_Event_1,B_Property_Event_2,B_Property_Event_3,B_Property_Event_4,B_Property_Event_5,B_Second_Degree_Associations,B_Sele_Address_1,B_Sele_Address_2,B_Sele_Address_3,B_Sele_Address_4,B_Sele_Address_5,B_Sele_Address_6,B_Sele_Lien_Judgment_11,B_Sele_Person_1,B_Sele_Person_2,B_Sele_Person_3,B_Sele_Person_4,B_Sele_Person_5,B_Sele_Person_6,B_Sele_Person_7,B_Sele_Phone_Number_3,B_Sele_Phone_Number_4,B_Sele_Phone_Number_5,B_Sele_Phone_Number_6,B_Sele_Property_1,B_Sele_Property_2,B_Sele_Property_3,B_Sele_Property_4,B_Sele_T_I_N_3,B_Sele_T_I_N_4,B_Sele_T_I_N_5,B_Sele_T_I_N_6,B_Sele_Tradeline_1,B_Sele_Tradeline_2,B_Sele_Tradeline_3,B_Sele_U_C_C_2,B_Sele_U_C_C_3,B_Sele_U_C_C_4,B_Sele_U_C_C_5,B_Sele_U_C_C_6,B_Sele_U_C_C_7,B_Sele_U_C_C_8,B_Sele_U_C_C_9,B_Sele_Vehicle_1,B_Sele_Vehicle_2,B_Sele_Vehicle_3,B_Tradeline,B_Tradeline_1,B_Tradeline_10,B_Tradeline_2,B_Tradeline_3,B_Tradeline_4,B_Tradeline_5,B_Tradeline_6,B_Tradeline_7,B_Tradeline_8,B_Tradeline_9,B_U_C_C,B_U_C_C_1,B_U_C_C_10,B_U_C_C_11,B_U_C_C_12,B_U_C_C_13,B_U_C_C_2,B_U_C_C_3,B_U_C_C_4,B_U_C_C_5,B_U_C_C_6,B_U_C_C_7,B_U_C_C_8,B_U_C_C_9,B_Watercraft_Owner_1,B_Watercraft_Owner_2,B_Watercraft_Owner_3,CFG_Compile,E_Accident,E_Address,E_Address_Inquiry,E_Address_Phone,E_Address_Property,E_Address_Property_Event,E_Aircraft,E_Aircraft_Owner,E_Bankruptcy,E_Business_Org,E_Business_Prox,E_Business_Sele,E_Business_Ult,E_Criminal_Details,E_Criminal_Offender,E_Criminal_Offense,E_Criminal_Punishment,E_Drivers_License,E_E_B_R_Tradeline,E_Education,E_Email,E_Email_Inquiry,E_First_Degree_Associations,E_First_Degree_Relative,E_Geo_Link,E_House_Hold_Phone,E_Household,E_Household_Member,E_Input_B_I_I,E_Input_B_I_I_Input_P_I_I,E_Input_P_I_I,E_Inquiry,E_Lien_Judgment,E_Person,E_Person_Accident,E_Person_Address,E_Person_Bankruptcy,E_Person_Drivers_License,E_Person_Education,E_Person_Email,E_Person_Email_Phone_Address,E_Person_Inquiry,E_Person_Lien_Judgment,E_Person_Offender,E_Person_Offenses,E_Person_Phone,E_Person_Property,E_Person_Property_Event,E_Person_S_S_N,E_Person_Sex_Offender,E_Person_Vehicle,E_Phone,E_Phone_Inquiry,E_Professional_License,E_Professional_License_Person,E_Property,E_Property_Event,E_Prox_Address,E_Prox_Email,E_Prox_Person,E_Prox_Phone_Number,E_Prox_T_I_N,E_Prox_Utility,E_S_S_N_Address,E_S_S_N_Inquiry,E_Second_Degree_Associations,E_Sele_Address,E_Sele_Aircraft,E_Sele_Bankruptcy,E_Sele_E_B_R_Tradeline,E_Sele_Email,E_Sele_Inquiry,E_Sele_Lien_Judgment,E_Sele_Person,E_Sele_Phone_Number,E_Sele_Property,E_Sele_Property_Event,E_Sele_T_I_N,E_Sele_Tradeline,E_Sele_U_C_C,E_Sele_Utility,E_Sele_Vehicle,E_Sele_Watercraft,E_Sex_Offender,E_Social_Security_Number,E_Surname,E_T_I_N,E_T_I_N_Address,E_T_I_N_Inquiry,E_T_I_N_Phone_Number,E_Tradeline,E_U_C_C,E_Utility,E_Utility_Address,E_Utility_Person,E_Vehicle,E_Watercraft,E_Watercraft_Owner,E_Zip_Code,E_Zip_Code_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT Q_Index_Build_Association(KEL.typ.uid __PAddressUID, KEL.typ.uid __PBusinessProxUID, KEL.typ.uid __PBusinessSeleUID, KEL.typ.uid __PCriminalOffenderUID, KEL.typ.uid __PPersonUID, KEL.typ.uid __PHouseholdUID, KEL.typ.uid __PPhoneUID, KEL.typ.uid __PEmailUID, KEL.typ.uid __PPropertyUID, KEL.typ.uid __PSexOffenderUID, KEL.typ.uid __PSocialSecurityNumberUID, KEL.typ.uid __PTINUID, KEL.typ.uid __PZipCodeUID, KEL.typ.kdate __PP_InpClnArchDt, DATA57 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
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
  SHARED E_Person_Sex_Offender_Filtered := MODULE(E_Person_Sex_Offender(__in,__cfg_Local))
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
  SHARED E_Sex_Offender_Filtered := MODULE(E_Sex_Offender(__in,__cfg_Local))
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
  SHARED TYPEOF(E_Person_Sex_Offender(__in,__cfg_Local).__Result) __E_Person_Sex_Offender := E_Person_Sex_Offender_Filtered.__Result;
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
  SHARED TYPEOF(E_Sex_Offender(__in,__cfg_Local).__Result) __E_Sex_Offender := E_Sex_Offender_Filtered.__Result;
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
  SHARED __EE3470276 := __E_Inquiry;
  SHARED __EE3470266 := __E_Address_Inquiry;
  SHARED __EE6238007 := __EE3470266(__NN(__EE3470266.Location_) AND __NN(__EE3470266.Transaction_));
  SHARED __EE3470260 := __E_Address;
  SHARED __EE6238113 := __EE3470260(__T(__OP2(__EE3470260.UID,=,__CN(__PAddressUID))));
  __JC6238119(E_Address_Inquiry(__in,__cfg_Local).Layout __EE6238007, E_Address(__in,__cfg_Local).Layout __EE6238113) := __EEQP(__EE6238113.UID,__EE6238007.Location_);
  SHARED __EE6238135 := JOIN(__EE6238007,__EE6238113,__JC6238119(LEFT,RIGHT),TRANSFORM(E_Address_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6238141(E_Inquiry(__in,__cfg_Local).Layout __EE3470276, E_Address_Inquiry(__in,__cfg_Local).Layout __EE6238135) := __EEQP(__EE6238135.Transaction_,__EE3470276.UID);
  SHARED __EE6238201 := JOIN(__EE3470276,__EE6238135,__JC6238141(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6238203 := __EE6238201;
  EXPORT Res0 := __UNWRAP(__EE6238203);
  SHARED __EE3470434 := __E_Phone;
  SHARED __EE3470424 := __E_Address_Phone;
  SHARED __EE6238489 := __EE3470424(__NN(__EE3470424.Location_) AND __NN(__EE3470424.Phone_Number_));
  SHARED __EE3470418 := __E_Address;
  SHARED __EE6238600 := __EE3470418(__T(__OP2(__EE3470418.UID,=,__CN(__PAddressUID))));
  __JC6238606(E_Address_Phone(__in,__cfg_Local).Layout __EE6238489, E_Address(__in,__cfg_Local).Layout __EE6238600) := __EEQP(__EE6238600.UID,__EE6238489.Location_);
  SHARED __EE6238634 := JOIN(__EE6238489,__EE6238600,__JC6238606(LEFT,RIGHT),TRANSFORM(E_Address_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6238640(E_Phone(__in,__cfg_Local).Layout __EE3470434, E_Address_Phone(__in,__cfg_Local).Layout __EE6238634) := __EEQP(__EE6238634.Phone_Number_,__EE3470434.UID);
  SHARED __EE6238693 := JOIN(__EE3470434,__EE6238634,__JC6238640(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6238695 := __EE6238693;
  EXPORT Res1 := __UNWRAP(__EE6238695);
  SHARED __EE6238856 := __ENH_Property;
  SHARED __EE3470591 := __E_Address_Property;
  SHARED __EE6239018 := __EE3470591(__NN(__EE3470591.Location_) AND __NN(__EE3470591.Prop_));
  SHARED __EE3470585 := __E_Address;
  SHARED __EE6239109 := __EE3470585(__T(__OP2(__EE3470585.UID,=,__CN(__PAddressUID))));
  __JC6239115(E_Address_Property(__in,__cfg_Local).Layout __EE6239018, E_Address(__in,__cfg_Local).Layout __EE6239109) := __EEQP(__EE6239109.UID,__EE6239018.Location_);
  SHARED __EE6239139 := JOIN(__EE6239018,__EE6239109,__JC6239115(LEFT,RIGHT),TRANSFORM(E_Address_Property(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6239145(B_Property(__in,__cfg_Local).__ST134807_Layout __EE6238856, E_Address_Property(__in,__cfg_Local).Layout __EE6239139) := __EEQP(__EE6239139.Prop_,__EE6238856.UID);
  SHARED __EE6239182 := JOIN(__EE6238856,__EE6239139,__JC6239145(LEFT,RIGHT),TRANSFORM(B_Property(__in,__cfg_Local).__ST134807_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6239184 := __EE6239182;
  EXPORT Res2 := __UNWRAP(__EE6239184);
  SHARED __EE6239305 := __ENH_Property_Event;
  SHARED __EE3470734 := __E_Address_Property_Event;
  SHARED __EE6239525 := __EE3470734(__NN(__EE3470734.Location_) AND __NN(__EE3470734.Event_));
  SHARED __EE3470728 := __E_Address;
  SHARED __EE6239644 := __EE3470728(__T(__OP2(__EE3470728.UID,=,__CN(__PAddressUID))));
  __JC6239650(E_Address_Property_Event(__in,__cfg_Local).Layout __EE6239525, E_Address(__in,__cfg_Local).Layout __EE6239644) := __EEQP(__EE6239644.UID,__EE6239525.Location_);
  SHARED __EE6239672 := JOIN(__EE6239525,__EE6239644,__JC6239650(LEFT,RIGHT),TRANSFORM(E_Address_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6239678(B_Property_Event_4(__in,__cfg_Local).__ST193799_Layout __EE6239305, E_Address_Property_Event(__in,__cfg_Local).Layout __EE6239672) := __EEQP(__EE6239672.Event_,__EE6239305.UID);
  SHARED __EE6239745 := JOIN(__EE6239305,__EE6239672,__JC6239678(LEFT,RIGHT),TRANSFORM(B_Property_Event_4(__in,__cfg_Local).__ST193799_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6239747 := __EE6239745;
  EXPORT Res3 := __UNWRAP(__EE6239747);
  SHARED __EE6239924 := __ENH_Person;
  SHARED __EE3470902 := __E_Person_Address;
  SHARED __EE6241967 := __EE3470902(__NN(__EE3470902.Location_) AND __NN(__EE3470902.Subject_));
  SHARED __EE3470896 := __E_Address;
  SHARED __EE6243011 := __EE3470896(__T(__OP2(__EE3470896.UID,=,__CN(__PAddressUID))));
  __JC6243017(E_Person_Address(__in,__cfg_Local).Layout __EE6241967, E_Address(__in,__cfg_Local).Layout __EE6243011) := __EEQP(__EE6243011.UID,__EE6241967.Location_);
  SHARED __EE6243066 := JOIN(__EE6241967,__EE6243011,__JC6243017(LEFT,RIGHT),TRANSFORM(E_Person_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6243072(B_Person(__in,__cfg_Local).__ST133569_Layout __EE6239924, E_Person_Address(__in,__cfg_Local).Layout __EE6243066) := __EEQP(__EE6243066.Subject_,__EE6239924.UID);
  SHARED __EE6244037 := JOIN(__EE6239924,__EE6243066,__JC6243072(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST133569_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6244039 := __EE6244037;
  EXPORT Res4 := __UNWRAP(__EE6244039);
  SHARED __EE6246066 := __ENH_Business_Prox;
  SHARED __EE3472067 := __E_Prox_Address;
  SHARED __EE6246706 := __EE3472067(__NN(__EE3472067.Location_) AND __NN(__EE3472067.Business_Location_));
  SHARED __EE3472061 := __E_Address;
  SHARED __EE6247052 := __EE3472061(__T(__OP2(__EE3472061.UID,=,__CN(__PAddressUID))));
  __JC6247058(E_Prox_Address(__in,__cfg_Local).Layout __EE6246706, E_Address(__in,__cfg_Local).Layout __EE6247052) := __EEQP(__EE6247052.UID,__EE6246706.Location_);
  SHARED __EE6247114 := JOIN(__EE6246706,__EE6247052,__JC6247058(LEFT,RIGHT),TRANSFORM(E_Prox_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6247120(B_Business_Prox(__in,__cfg_Local).__ST101615_Layout __EE6246066, E_Prox_Address(__in,__cfg_Local).Layout __EE6247114) := __EEQP(__EE6247114.Business_Location_,__EE6246066.UID);
  SHARED __EE6247380 := JOIN(__EE6246066,__EE6247114,__JC6247120(LEFT,RIGHT),TRANSFORM(B_Business_Prox(__in,__cfg_Local).__ST101615_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6247382 := __EE6247380;
  EXPORT Res5 := __UNWRAP(__EE6247382);
  SHARED __EE6248013 := __ENH_Business_Sele;
  SHARED __EE3472492 := __E_Sele_Address;
  SHARED __EE6251159 := __EE3472492(__NN(__EE3472492.Location_) AND __NN(__EE3472492.Legal_));
  SHARED __EE3472486 := __E_Address;
  SHARED __EE6252758 := __EE3472486(__T(__OP2(__EE3472486.UID,=,__CN(__PAddressUID))));
  __JC6252764(E_Sele_Address(__in,__cfg_Local).Layout __EE6251159, E_Address(__in,__cfg_Local).Layout __EE6252758) := __EEQP(__EE6252758.UID,__EE6251159.Location_);
  SHARED __EE6252820 := JOIN(__EE6251159,__EE6252758,__JC6252764(LEFT,RIGHT),TRANSFORM(E_Sele_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6252826(B_Business_Sele(__in,__cfg_Local).__ST119645_Layout __EE6248013, E_Sele_Address(__in,__cfg_Local).Layout __EE6252820) := __EEQP(__EE6252820.Legal_,__EE6248013.UID);
  SHARED __EE6254339 := JOIN(__EE6248013,__EE6252820,__JC6252826(LEFT,RIGHT),TRANSFORM(B_Business_Sele(__in,__cfg_Local).__ST119645_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6254341 := __EE6254339;
  EXPORT Res6 := __UNWRAP(__EE6254341);
  SHARED __EE3474257 := __E_T_I_N;
  SHARED __EE3474247 := __E_T_I_N_Address;
  SHARED __EE6257551 := __EE3474247(__NN(__EE3474247.Location_) AND __NN(__EE3474247.Tax_I_D_));
  SHARED __EE3474241 := __E_Address;
  SHARED __EE6257600 := __EE3474241(__T(__OP2(__EE3474241.UID,=,__CN(__PAddressUID))));
  __JC6257606(E_T_I_N_Address(__in,__cfg_Local).Layout __EE6257551, E_Address(__in,__cfg_Local).Layout __EE6257600) := __EEQP(__EE6257600.UID,__EE6257551.Location_);
  SHARED __EE6257621 := JOIN(__EE6257551,__EE6257600,__JC6257606(LEFT,RIGHT),TRANSFORM(E_T_I_N_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6257627(E_T_I_N(__in,__cfg_Local).Layout __EE3474257, E_T_I_N_Address(__in,__cfg_Local).Layout __EE6257621) := __EEQP(__EE6257621.Tax_I_D_,__EE3474257.UID);
  SHARED __EE6257631 := JOIN(__EE3474257,__EE6257621,__JC6257627(LEFT,RIGHT),TRANSFORM(E_T_I_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6257633 := __EE6257631;
  EXPORT Res7 := __UNWRAP(__EE6257633);
  SHARED __EE3474352 := __E_Utility;
  SHARED __EE3474342 := __E_Utility_Address;
  SHARED __EE6257764 := __EE3474342(__NN(__EE3474342.Location_) AND __NN(__EE3474342.Util_));
  SHARED __EE3474336 := __E_Address;
  SHARED __EE6257834 := __EE3474336(__T(__OP2(__EE3474336.UID,=,__CN(__PAddressUID))));
  __JC6257840(E_Utility_Address(__in,__cfg_Local).Layout __EE6257764, E_Address(__in,__cfg_Local).Layout __EE6257834) := __EEQP(__EE6257834.UID,__EE6257764.Location_);
  SHARED __EE6257854 := JOIN(__EE6257764,__EE6257834,__JC6257840(LEFT,RIGHT),TRANSFORM(E_Utility_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6257860(E_Utility(__in,__cfg_Local).Layout __EE3474352, E_Utility_Address(__in,__cfg_Local).Layout __EE6257854) := __EEQP(__EE6257854.Util_,__EE3474352.UID);
  SHARED __EE6257886 := JOIN(__EE3474352,__EE6257854,__JC6257860(LEFT,RIGHT),TRANSFORM(E_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6257888 := __EE6257886;
  EXPORT Res8 := __UNWRAP(__EE6257888);
  SHARED __EE6257967 := __ENH_Address;
  SHARED __EE3474460 := __E_Prox_Address;
  SHARED __EE6258477 := __EE3474460(__NN(__EE3474460.Business_Location_) AND __NN(__EE3474460.Location_));
  SHARED __EE6257970 := __ENH_Business_Prox;
  SHARED __EE6258721 := __EE6257970(__T(__OP2(__EE6257970.UID,=,__CN(__PBusinessProxUID))));
  __JC6258727(E_Prox_Address(__in,__cfg_Local).Layout __EE6258477, B_Business_Prox(__in,__cfg_Local).__ST101615_Layout __EE6258721) := __EEQP(__EE6258721.UID,__EE6258477.Business_Location_);
  SHARED __EE6258783 := JOIN(__EE6258477,__EE6258721,__JC6258727(LEFT,RIGHT),TRANSFORM(E_Prox_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6258789(B_Address_1(__in,__cfg_Local).__ST136323_Layout __EE6257967, E_Prox_Address(__in,__cfg_Local).Layout __EE6258783) := __EEQP(__EE6258783.Location_,__EE6257967.UID);
  SHARED __EE6258947 := JOIN(__EE6257967,__EE6258783,__JC6258789(LEFT,RIGHT),TRANSFORM(B_Address_1(__in,__cfg_Local).__ST136323_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6258949 := __EE6258947;
  EXPORT Res9 := __UNWRAP(__EE6258949);
  SHARED __EE6259376 := __ENH_Person;
  SHARED __EE3474782 := __E_Prox_Person;
  SHARED __EE6261444 := __EE3474782(__NN(__EE3474782.Business_Location_) AND __NN(__EE3474782.Contact_));
  SHARED __EE6259379 := __ENH_Business_Prox;
  SHARED __EE6262467 := __EE6259379(__T(__OP2(__EE6259379.UID,=,__CN(__PBusinessProxUID))));
  __JC6262473(E_Prox_Person(__in,__cfg_Local).Layout __EE6261444, B_Business_Prox(__in,__cfg_Local).__ST101615_Layout __EE6262467) := __EEQP(__EE6262467.UID,__EE6261444.Business_Location_);
  SHARED __EE6262501 := JOIN(__EE6261444,__EE6262467,__JC6262473(LEFT,RIGHT),TRANSFORM(E_Prox_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6262507(B_Person(__in,__cfg_Local).__ST133569_Layout __EE6259376, E_Prox_Person(__in,__cfg_Local).Layout __EE6262501) := __EEQP(__EE6262501.Contact_,__EE6259376.UID);
  SHARED __EE6263472 := JOIN(__EE6259376,__EE6262501,__JC6262507(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST133569_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6263474 := __EE6263472;
  EXPORT Res10 := __UNWRAP(__EE6263474);
  SHARED __EE3475935 := __E_Phone;
  SHARED __EE3475925 := __E_Prox_Phone_Number;
  SHARED __EE6265716 := __EE3475925(__NN(__EE3475925.Business_Location_) AND __NN(__EE3475925.Phone_Number_));
  SHARED __EE6265459 := __ENH_Business_Prox;
  SHARED __EE6265836 := __EE6265459(__T(__OP2(__EE6265459.UID,=,__CN(__PBusinessProxUID))));
  __JC6265842(E_Prox_Phone_Number(__in,__cfg_Local).Layout __EE6265716, B_Business_Prox(__in,__cfg_Local).__ST101615_Layout __EE6265836) := __EEQP(__EE6265836.UID,__EE6265716.Business_Location_);
  SHARED __EE6265879 := JOIN(__EE6265716,__EE6265836,__JC6265842(LEFT,RIGHT),TRANSFORM(E_Prox_Phone_Number(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6265885(E_Phone(__in,__cfg_Local).Layout __EE3475935, E_Prox_Phone_Number(__in,__cfg_Local).Layout __EE6265879) := __EEQP(__EE6265879.Phone_Number_,__EE3475935.UID);
  SHARED __EE6265938 := JOIN(__EE3475935,__EE6265879,__JC6265885(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6265940 := __EE6265938;
  EXPORT Res11 := __UNWRAP(__EE6265940);
  SHARED __EE3476114 := __E_T_I_N;
  SHARED __EE3476104 := __E_Prox_T_I_N;
  SHARED __EE6266232 := __EE3476104(__NN(__EE3476104.Business_Location_) AND __NN(__EE3476104.Tax_I_D_));
  SHARED __EE6266119 := __ENH_Business_Prox;
  SHARED __EE6266280 := __EE6266119(__T(__OP2(__EE6266119.UID,=,__CN(__PBusinessProxUID))));
  __JC6266286(E_Prox_T_I_N(__in,__cfg_Local).Layout __EE6266232, B_Business_Prox(__in,__cfg_Local).__ST101615_Layout __EE6266280) := __EEQP(__EE6266280.UID,__EE6266232.Business_Location_);
  SHARED __EE6266300 := JOIN(__EE6266232,__EE6266280,__JC6266286(LEFT,RIGHT),TRANSFORM(E_Prox_T_I_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6266306(E_T_I_N(__in,__cfg_Local).Layout __EE3476114, E_Prox_T_I_N(__in,__cfg_Local).Layout __EE6266300) := __EEQP(__EE6266300.Tax_I_D_,__EE3476114.UID);
  SHARED __EE6266310 := JOIN(__EE3476114,__EE6266300,__JC6266306(LEFT,RIGHT),TRANSFORM(E_T_I_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6266312 := __EE6266310;
  EXPORT Res12 := __UNWRAP(__EE6266312);
  SHARED __EE3476208 := __E_Utility;
  SHARED __EE3476198 := __E_Prox_Utility;
  SHARED __EE6266498 := __EE3476198(__NN(__EE3476198.Business_Location_) AND __NN(__EE3476198.Util_));
  SHARED __EE6266347 := __ENH_Business_Prox;
  SHARED __EE6266565 := __EE6266347(__T(__OP2(__EE6266347.UID,=,__CN(__PBusinessProxUID))));
  __JC6266571(E_Prox_Utility(__in,__cfg_Local).Layout __EE6266498, B_Business_Prox(__in,__cfg_Local).__ST101615_Layout __EE6266565) := __EEQP(__EE6266565.UID,__EE6266498.Business_Location_);
  SHARED __EE6266582 := JOIN(__EE6266498,__EE6266565,__JC6266571(LEFT,RIGHT),TRANSFORM(E_Prox_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6266588(E_Utility(__in,__cfg_Local).Layout __EE3476208, E_Prox_Utility(__in,__cfg_Local).Layout __EE6266582) := __EEQP(__EE6266582.Util_,__EE3476208.UID);
  SHARED __EE6266614 := JOIN(__EE3476208,__EE6266582,__JC6266588(LEFT,RIGHT),TRANSFORM(E_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6266616 := __EE6266614;
  EXPORT Res13 := __UNWRAP(__EE6266616);
  SHARED __EE6266689 := __ENH_Email;
  SHARED __EE3476314 := __E_Prox_Email;
  SHARED __EE6266881 := __EE3476314(__NN(__EE3476314.Business_Location_) AND __NN(__EE3476314.Email_));
  SHARED __EE6266692 := __ENH_Business_Prox;
  SHARED __EE6266966 := __EE6266692(__T(__OP2(__EE6266692.UID,=,__CN(__PBusinessProxUID))));
  __JC6266972(E_Prox_Email(__in,__cfg_Local).Layout __EE6266881, B_Business_Prox(__in,__cfg_Local).__ST101615_Layout __EE6266966) := __EEQP(__EE6266966.UID,__EE6266881.Business_Location_);
  SHARED __EE6266991 := JOIN(__EE6266881,__EE6266966,__JC6266972(LEFT,RIGHT),TRANSFORM(E_Prox_Email(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6266997(B_Email_2(__in,__cfg_Local).__ST167525_Layout __EE6266689, E_Prox_Email(__in,__cfg_Local).Layout __EE6266991) := __EEQP(__EE6266991.Email_,__EE6266689.UID);
  SHARED __EE6267033 := JOIN(__EE6266689,__EE6266991,__JC6266997(LEFT,RIGHT),TRANSFORM(B_Email_2(__in,__cfg_Local).__ST167525_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6267035 := __EE6267033;
  EXPORT Res14 := __UNWRAP(__EE6267035);
  SHARED __EE6267144 := __ENH_Business_Sele;
  SHARED __EE6267147 := __ENH_Business_Prox;
  SHARED __EE6271762 := __EE6267147(__T(__AND(__OP2(__EE6267147.UID,=,__CN(__PBusinessProxUID)),__CN(__NN(__EE6267147.Prox_Sele_)))));
  __JC6271768(B_Business_Sele(__in,__cfg_Local).__ST119645_Layout __EE6267144, B_Business_Prox(__in,__cfg_Local).__ST101615_Layout __EE6271762) := __EEQP(__EE6271762.Prox_Sele_,__EE6267144.UID);
  SHARED __EE6273281 := JOIN(__EE6267144,__EE6271762,__JC6271768(LEFT,RIGHT),TRANSFORM(B_Business_Sele(__in,__cfg_Local).__ST119645_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6273283 := __EE6273281;
  EXPORT Res15 := __UNWRAP(__EE6273283);
  SHARED __EE3478131 := __E_E_B_R_Tradeline;
  SHARED __EE3478121 := __E_Sele_E_B_R_Tradeline;
  SHARED __EE6276435 := __EE3478121(__NN(__EE3478121.Legal_) AND __NN(__EE3478121.Tradeline_));
  SHARED __EE6276310 := __ENH_Business_Sele;
  SHARED __EE6276490 := __EE6276310(__T(__OP2(__EE6276310.UID,=,__CN(__PBusinessSeleUID))));
  __JC6276496(E_Sele_E_B_R_Tradeline(__in,__cfg_Local).Layout __EE6276435, B_Business_Sele(__in,__cfg_Local).__ST119645_Layout __EE6276490) := __EEQP(__EE6276490.UID,__EE6276435.Legal_);
  SHARED __EE6276508 := JOIN(__EE6276435,__EE6276490,__JC6276496(LEFT,RIGHT),TRANSFORM(E_Sele_E_B_R_Tradeline(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6276514(E_E_B_R_Tradeline(__in,__cfg_Local).Layout __EE3478131, E_Sele_E_B_R_Tradeline(__in,__cfg_Local).Layout __EE6276508) := __EEQP(__EE6276508.Tradeline_,__EE3478131.UID);
  SHARED __EE6276527 := JOIN(__EE3478131,__EE6276508,__JC6276514(LEFT,RIGHT),TRANSFORM(E_E_B_R_Tradeline(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6276529 := __EE6276527;
  EXPORT Res16 := __UNWRAP(__EE6276529);
  SHARED __EE6276578 := __ENH_Email;
  SHARED __EE3478224 := __E_Sele_Email;
  SHARED __EE6276766 := __EE3478224(__NN(__EE3478224.Legal_) AND __NN(__EE3478224.Email_));
  SHARED __EE6276581 := __ENH_Business_Sele;
  SHARED __EE6276850 := __EE6276581(__T(__OP2(__EE6276581.UID,=,__CN(__PBusinessSeleUID))));
  __JC6276856(E_Sele_Email(__in,__cfg_Local).Layout __EE6276766, B_Business_Sele(__in,__cfg_Local).__ST119645_Layout __EE6276850) := __EEQP(__EE6276850.UID,__EE6276766.Legal_);
  SHARED __EE6276874 := JOIN(__EE6276766,__EE6276850,__JC6276856(LEFT,RIGHT),TRANSFORM(E_Sele_Email(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6276880(B_Email_2(__in,__cfg_Local).__ST167525_Layout __EE6276578, E_Sele_Email(__in,__cfg_Local).Layout __EE6276874) := __EEQP(__EE6276874.Email_,__EE6276578.UID);
  SHARED __EE6276916 := JOIN(__EE6276578,__EE6276874,__JC6276880(LEFT,RIGHT),TRANSFORM(B_Email_2(__in,__cfg_Local).__ST167525_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6276918 := __EE6276916;
  EXPORT Res17 := __UNWRAP(__EE6276918);
  SHARED __EE6277025 := __ENH_Address;
  SHARED __EE3478362 := __E_Sele_Address;
  SHARED __EE6277533 := __EE3478362(__NN(__EE3478362.Legal_) AND __NN(__EE3478362.Location_));
  SHARED __EE6277028 := __ENH_Business_Sele;
  SHARED __EE6277777 := __EE6277028(__T(__OP2(__EE6277028.UID,=,__CN(__PBusinessSeleUID))));
  __JC6277783(E_Sele_Address(__in,__cfg_Local).Layout __EE6277533, B_Business_Sele(__in,__cfg_Local).__ST119645_Layout __EE6277777) := __EEQP(__EE6277777.UID,__EE6277533.Legal_);
  SHARED __EE6277839 := JOIN(__EE6277533,__EE6277777,__JC6277783(LEFT,RIGHT),TRANSFORM(E_Sele_Address(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6277845(B_Address_1(__in,__cfg_Local).__ST136323_Layout __EE6277025, E_Sele_Address(__in,__cfg_Local).Layout __EE6277839) := __EEQP(__EE6277839.Location_,__EE6277025.UID);
  SHARED __EE6278003 := JOIN(__EE6277025,__EE6277839,__JC6277845(LEFT,RIGHT),TRANSFORM(B_Address_1(__in,__cfg_Local).__ST136323_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6278005 := __EE6278003;
  EXPORT Res18 := __UNWRAP(__EE6278005);
  SHARED __EE3478694 := __E_Aircraft;
  SHARED __EE3478684 := __E_Sele_Aircraft;
  SHARED __EE6278587 := __EE3478684(__NN(__EE3478684.Legal_) AND __NN(__EE3478684.Plane_));
  SHARED __EE6278432 := __ENH_Business_Sele;
  SHARED __EE6278657 := __EE6278432(__T(__OP2(__EE6278432.UID,=,__CN(__PBusinessSeleUID))));
  __JC6278663(E_Sele_Aircraft(__in,__cfg_Local).Layout __EE6278587, B_Business_Sele(__in,__cfg_Local).__ST119645_Layout __EE6278657) := __EEQP(__EE6278657.UID,__EE6278587.Legal_);
  SHARED __EE6278680 := JOIN(__EE6278587,__EE6278657,__JC6278663(LEFT,RIGHT),TRANSFORM(E_Sele_Aircraft(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6278686(E_Aircraft(__in,__cfg_Local).Layout __EE3478694, E_Sele_Aircraft(__in,__cfg_Local).Layout __EE6278680) := __EEQP(__EE6278680.Plane_,__EE3478694.UID);
  SHARED __EE6278709 := JOIN(__EE3478694,__EE6278680,__JC6278686(LEFT,RIGHT),TRANSFORM(E_Aircraft(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6278711 := __EE6278709;
  EXPORT Res19 := __UNWRAP(__EE6278711);
  SHARED __EE6278790 := __ENH_Bankruptcy;
  SHARED __EE3478804 := __E_Sele_Bankruptcy;
  SHARED __EE6279062 := __EE3478804(__NN(__EE3478804.Legal_) AND __NN(__EE3478804.Bankrupt_));
  SHARED __EE6278793 := __ENH_Business_Sele;
  SHARED __EE6279188 := __EE6278793(__T(__OP2(__EE6278793.UID,=,__CN(__PBusinessSeleUID))));
  __JC6279194(E_Sele_Bankruptcy(__in,__cfg_Local).Layout __EE6279062, B_Business_Sele(__in,__cfg_Local).__ST119645_Layout __EE6279188) := __EEQP(__EE6279188.UID,__EE6279062.Legal_);
  SHARED __EE6279204 := JOIN(__EE6279062,__EE6279188,__JC6279194(LEFT,RIGHT),TRANSFORM(E_Sele_Bankruptcy(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6279210(B_Bankruptcy(__in,__cfg_Local).__ST101132_Layout __EE6278790, E_Sele_Bankruptcy(__in,__cfg_Local).Layout __EE6279204) := __EEQP(__EE6279204.Bankrupt_,__EE6278790.UID);
  SHARED __EE6279296 := JOIN(__EE6278790,__EE6279204,__JC6279210(LEFT,RIGHT),TRANSFORM(B_Bankruptcy(__in,__cfg_Local).__ST101132_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6279298 := __EE6279296;
  EXPORT Res20 := __UNWRAP(__EE6279298);
  SHARED __EE6279489 := __ENH_Lien_Judgment;
  SHARED __EE3478981 := __E_Sele_Lien_Judgment;
  SHARED __EE6279679 := __EE3478981(__NN(__EE3478981.Sele_) AND __NN(__EE3478981.Lien_));
  SHARED __EE6279492 := __ENH_Business_Sele;
  SHARED __EE6279764 := __EE6279492(__T(__OP2(__EE6279492.UID,=,__CN(__PBusinessSeleUID))));
  __JC6279770(E_Sele_Lien_Judgment(__in,__cfg_Local).Layout __EE6279679, B_Business_Sele(__in,__cfg_Local).__ST119645_Layout __EE6279764) := __EEQP(__EE6279764.UID,__EE6279679.Sele_);
  SHARED __EE6279786 := JOIN(__EE6279679,__EE6279764,__JC6279770(LEFT,RIGHT),TRANSFORM(E_Sele_Lien_Judgment(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6279792(B_Lien_Judgment_12(__in,__cfg_Local).__ST211934_Layout __EE6279489, E_Sele_Lien_Judgment(__in,__cfg_Local).Layout __EE6279786) := __EEQP(__EE6279786.Lien_,__EE6279489.UID);
  SHARED __EE6279831 := JOIN(__EE6279489,__EE6279786,__JC6279792(LEFT,RIGHT),TRANSFORM(B_Lien_Judgment_12(__in,__cfg_Local).__ST211934_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6279833 := __EE6279831;
  EXPORT Res21 := __UNWRAP(__EE6279833);
  SHARED __EE6279942 := __ENH_Person;
  SHARED __EE3479117 := __E_Sele_Person;
  SHARED __EE6282014 := __EE3479117(__NN(__EE3479117.Legal_) AND __NN(__EE3479117.Contact_));
  SHARED __EE6279945 := __ENH_Business_Sele;
  SHARED __EE6283040 := __EE6279945(__T(__OP2(__EE6279945.UID,=,__CN(__PBusinessSeleUID))));
  __JC6283046(E_Sele_Person(__in,__cfg_Local).Layout __EE6282014, B_Business_Sele(__in,__cfg_Local).__ST119645_Layout __EE6283040) := __EEQP(__EE6283040.UID,__EE6282014.Legal_);
  SHARED __EE6283077 := JOIN(__EE6282014,__EE6283040,__JC6283046(LEFT,RIGHT),TRANSFORM(E_Sele_Person(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6283083(B_Person(__in,__cfg_Local).__ST133569_Layout __EE6279942, E_Sele_Person(__in,__cfg_Local).Layout __EE6283077) := __EEQP(__EE6283077.Contact_,__EE6279942.UID);
  SHARED __EE6284048 := JOIN(__EE6279942,__EE6283077,__JC6283083(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST133569_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6284050 := __EE6284048;
  EXPORT Res22 := __UNWRAP(__EE6284050);
  SHARED __EE3480273 := __E_Phone;
  SHARED __EE3480263 := __E_Sele_Phone_Number;
  SHARED __EE6286296 := __EE3480263(__NN(__EE3480263.Legal_) AND __NN(__EE3480263.Phone_Number_));
  SHARED __EE6286041 := __ENH_Business_Sele;
  SHARED __EE6286416 := __EE6286041(__T(__OP2(__EE6286041.UID,=,__CN(__PBusinessSeleUID))));
  __JC6286422(E_Sele_Phone_Number(__in,__cfg_Local).Layout __EE6286296, B_Business_Sele(__in,__cfg_Local).__ST119645_Layout __EE6286416) := __EEQP(__EE6286416.UID,__EE6286296.Legal_);
  SHARED __EE6286459 := JOIN(__EE6286296,__EE6286416,__JC6286422(LEFT,RIGHT),TRANSFORM(E_Sele_Phone_Number(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6286465(E_Phone(__in,__cfg_Local).Layout __EE3480273, E_Sele_Phone_Number(__in,__cfg_Local).Layout __EE6286459) := __EEQP(__EE6286459.Phone_Number_,__EE3480273.UID);
  SHARED __EE6286518 := JOIN(__EE3480273,__EE6286459,__JC6286465(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6286520 := __EE6286518;
  EXPORT Res23 := __UNWRAP(__EE6286520);
  SHARED __EE6286699 := __ENH_Property;
  SHARED __EE3480442 := __E_Sele_Property;
  SHARED __EE6286907 := __EE3480442(__NN(__EE3480442.Legal_) AND __NN(__EE3480442.Prop_));
  SHARED __EE6286702 := __ENH_Business_Sele;
  SHARED __EE6287001 := __EE6286702(__T(__OP2(__EE6286702.UID,=,__CN(__PBusinessSeleUID))));
  __JC6287007(E_Sele_Property(__in,__cfg_Local).Layout __EE6286907, B_Business_Sele(__in,__cfg_Local).__ST119645_Layout __EE6287001) := __EEQP(__EE6287001.UID,__EE6286907.Legal_);
  SHARED __EE6287034 := JOIN(__EE6286907,__EE6287001,__JC6287007(LEFT,RIGHT),TRANSFORM(E_Sele_Property(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6287040(B_Property(__in,__cfg_Local).__ST134807_Layout __EE6286699, E_Sele_Property(__in,__cfg_Local).Layout __EE6287034) := __EEQP(__EE6287034.Prop_,__EE6286699.UID);
  SHARED __EE6287077 := JOIN(__EE6286699,__EE6287034,__JC6287040(LEFT,RIGHT),TRANSFORM(B_Property(__in,__cfg_Local).__ST134807_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6287079 := __EE6287077;
  EXPORT Res24 := __UNWRAP(__EE6287079);
  SHARED __EE6287206 := __ENH_Property_Event;
  SHARED __EE3480588 := __E_Sele_Property_Event;
  SHARED __EE6287464 := __EE3480588(__NN(__EE3480588.Legal_) AND __NN(__EE3480588.Event_));
  SHARED __EE6287209 := __ENH_Business_Sele;
  SHARED __EE6287583 := __EE6287209(__T(__OP2(__EE6287209.UID,=,__CN(__PBusinessSeleUID))));
  __JC6287589(E_Sele_Property_Event(__in,__cfg_Local).Layout __EE6287464, B_Business_Sele(__in,__cfg_Local).__ST119645_Layout __EE6287583) := __EEQP(__EE6287583.UID,__EE6287464.Legal_);
  SHARED __EE6287611 := JOIN(__EE6287464,__EE6287583,__JC6287589(LEFT,RIGHT),TRANSFORM(E_Sele_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6287617(B_Property_Event_4(__in,__cfg_Local).__ST193799_Layout __EE6287206, E_Sele_Property_Event(__in,__cfg_Local).Layout __EE6287611) := __EEQP(__EE6287611.Event_,__EE6287206.UID);
  SHARED __EE6287684 := JOIN(__EE6287206,__EE6287611,__JC6287617(LEFT,RIGHT),TRANSFORM(B_Property_Event_4(__in,__cfg_Local).__ST193799_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6287686 := __EE6287684;
  EXPORT Res25 := __UNWRAP(__EE6287686);
  SHARED __EE3480767 := __E_T_I_N;
  SHARED __EE3480757 := __E_Sele_T_I_N;
  SHARED __EE6287972 := __EE3480757(__NN(__EE3480757.Legal_) AND __NN(__EE3480757.Tax_I_D_));
  SHARED __EE6287863 := __ENH_Business_Sele;
  SHARED __EE6288019 := __EE6287863(__T(__OP2(__EE6287863.UID,=,__CN(__PBusinessSeleUID))));
  __JC6288025(E_Sele_T_I_N(__in,__cfg_Local).Layout __EE6287972, B_Business_Sele(__in,__cfg_Local).__ST119645_Layout __EE6288019) := __EEQP(__EE6288019.UID,__EE6287972.Legal_);
  SHARED __EE6288038 := JOIN(__EE6287972,__EE6288019,__JC6288025(LEFT,RIGHT),TRANSFORM(E_Sele_T_I_N(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6288044(E_T_I_N(__in,__cfg_Local).Layout __EE3480767, E_Sele_T_I_N(__in,__cfg_Local).Layout __EE6288038) := __EEQP(__EE6288038.Tax_I_D_,__EE3480767.UID);
  SHARED __EE6288048 := JOIN(__EE3480767,__EE6288038,__JC6288044(LEFT,RIGHT),TRANSFORM(E_T_I_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6288050 := __EE6288048;
  EXPORT Res26 := __UNWRAP(__EE6288050);
  SHARED __EE6288083 := __ENH_Tradeline;
  SHARED __EE3480850 := __E_Sele_Tradeline;
  SHARED __EE6288319 := __EE3480850(__NN(__EE3480850.Legal_) AND __NN(__EE3480850.Account_));
  SHARED __EE6288086 := __ENH_Business_Sele;
  SHARED __EE6288427 := __EE6288086(__T(__OP2(__EE6288086.UID,=,__CN(__PBusinessSeleUID))));
  __JC6288433(E_Sele_Tradeline(__in,__cfg_Local).Layout __EE6288319, B_Business_Sele(__in,__cfg_Local).__ST119645_Layout __EE6288427) := __EEQP(__EE6288427.UID,__EE6288319.Legal_);
  SHARED __EE6288440 := JOIN(__EE6288319,__EE6288427,__JC6288433(LEFT,RIGHT),TRANSFORM(E_Sele_Tradeline(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6288446(B_Tradeline(__in,__cfg_Local).__ST135997_Layout __EE6288083, E_Sele_Tradeline(__in,__cfg_Local).Layout __EE6288440) := __EEQP(__EE6288440.Account_,__EE6288083.UID);
  SHARED __EE6288517 := JOIN(__EE6288083,__EE6288440,__JC6288446(LEFT,RIGHT),TRANSFORM(B_Tradeline(__in,__cfg_Local).__ST135997_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6288519 := __EE6288517;
  EXPORT Res27 := __UNWRAP(__EE6288519);
  SHARED __EE6288674 := __ENH_U_C_C;
  SHARED __EE3481008 := __E_Sele_U_C_C;
  SHARED __EE6288900 := __EE3481008(__NN(__EE3481008.Legal_) AND __NN(__EE3481008.Filing_));
  SHARED __EE6288677 := __ENH_Business_Sele;
  SHARED __EE6289003 := __EE6288677(__T(__OP2(__EE6288677.UID,=,__CN(__PBusinessSeleUID))));
  __JC6289009(E_Sele_U_C_C(__in,__cfg_Local).Layout __EE6288900, B_Business_Sele(__in,__cfg_Local).__ST119645_Layout __EE6289003) := __EEQP(__EE6289003.UID,__EE6288900.Legal_);
  SHARED __EE6289024 := JOIN(__EE6288900,__EE6289003,__JC6289009(LEFT,RIGHT),TRANSFORM(E_Sele_U_C_C(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6289030(B_U_C_C(__in,__cfg_Local).__ST136200_Layout __EE6288674, E_Sele_U_C_C(__in,__cfg_Local).Layout __EE6289024) := __EEQP(__EE6289024.Filing_,__EE6288674.UID);
  SHARED __EE6289088 := JOIN(__EE6288674,__EE6289024,__JC6289030(LEFT,RIGHT),TRANSFORM(B_U_C_C(__in,__cfg_Local).__ST136200_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6289090 := __EE6289088;
  EXPORT Res28 := __UNWRAP(__EE6289090);
  SHARED __EE3481173 := __E_Utility;
  SHARED __EE3481163 := __E_Sele_Utility;
  SHARED __EE6289384 := __EE3481163(__NN(__EE3481163.Legal_) AND __NN(__EE3481163.Util_));
  SHARED __EE6289235 := __ENH_Business_Sele;
  SHARED __EE6289451 := __EE6289235(__T(__OP2(__EE6289235.UID,=,__CN(__PBusinessSeleUID))));
  __JC6289457(E_Sele_Utility(__in,__cfg_Local).Layout __EE6289384, B_Business_Sele(__in,__cfg_Local).__ST119645_Layout __EE6289451) := __EEQP(__EE6289451.UID,__EE6289384.Legal_);
  SHARED __EE6289468 := JOIN(__EE6289384,__EE6289451,__JC6289457(LEFT,RIGHT),TRANSFORM(E_Sele_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6289474(E_Utility(__in,__cfg_Local).Layout __EE3481173, E_Sele_Utility(__in,__cfg_Local).Layout __EE6289468) := __EEQP(__EE6289468.Util_,__EE3481173.UID);
  SHARED __EE6289500 := JOIN(__EE3481173,__EE6289468,__JC6289474(LEFT,RIGHT),TRANSFORM(E_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6289502 := __EE6289500;
  EXPORT Res29 := __UNWRAP(__EE6289502);
  SHARED __EE3481289 := __E_Vehicle;
  SHARED __EE3481279 := __E_Sele_Vehicle;
  SHARED __EE6289972 := __EE3481279(__NN(__EE3481279.Legal_) AND __NN(__EE3481279.Automobile_));
  SHARED __EE6289575 := __ENH_Business_Sele;
  SHARED __EE6290163 := __EE6289575(__T(__OP2(__EE6289575.UID,=,__CN(__PBusinessSeleUID))));
  __JC6290169(E_Sele_Vehicle(__in,__cfg_Local).Layout __EE6289972, B_Business_Sele(__in,__cfg_Local).__ST119645_Layout __EE6290163) := __EEQP(__EE6290163.UID,__EE6289972.Legal_);
  SHARED __EE6290219 := JOIN(__EE6289972,__EE6290163,__JC6290169(LEFT,RIGHT),TRANSFORM(E_Sele_Vehicle(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6290225(E_Vehicle(__in,__cfg_Local).Layout __EE3481289, E_Sele_Vehicle(__in,__cfg_Local).Layout __EE6290219) := __EEQP(__EE6290219.Automobile_,__EE3481289.UID);
  SHARED __EE6290336 := JOIN(__EE3481289,__EE6290219,__JC6290225(LEFT,RIGHT),TRANSFORM(E_Vehicle(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6290338 := __EE6290336;
  EXPORT Res30 := __UNWRAP(__EE6290338);
  SHARED __EE3481531 := __E_Inquiry;
  SHARED __EE3481521 := __E_Sele_Inquiry;
  SHARED __EE6290878 := __EE3481521(__NN(__EE3481521.Legal_) AND __NN(__EE3481521.Transaction_));
  SHARED __EE6290659 := __ENH_Business_Sele;
  SHARED __EE6290980 := __EE6290659(__T(__OP2(__EE6290659.UID,=,__CN(__PBusinessSeleUID))));
  __JC6290986(E_Sele_Inquiry(__in,__cfg_Local).Layout __EE6290878, B_Business_Sele(__in,__cfg_Local).__ST119645_Layout __EE6290980) := __EEQP(__EE6290980.UID,__EE6290878.Legal_);
  SHARED __EE6290998 := JOIN(__EE6290878,__EE6290980,__JC6290986(LEFT,RIGHT),TRANSFORM(E_Sele_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6291004(E_Inquiry(__in,__cfg_Local).Layout __EE3481531, E_Sele_Inquiry(__in,__cfg_Local).Layout __EE6290998) := __EEQP(__EE6290998.Transaction_,__EE3481531.UID);
  SHARED __EE6291064 := JOIN(__EE3481531,__EE6290998,__JC6291004(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6291066 := __EE6291064;
  EXPORT Res31 := __UNWRAP(__EE6291066);
  SHARED __EE3481685 := __E_Watercraft;
  SHARED __EE3481675 := __E_Sele_Watercraft;
  SHARED __EE6291328 := __EE3481675(__NN(__EE3481675.Legal_) AND __NN(__EE3481675.W_Craft_));
  SHARED __EE6291209 := __ENH_Business_Sele;
  SHARED __EE6291380 := __EE6291209(__T(__OP2(__EE6291209.UID,=,__CN(__PBusinessSeleUID))));
  __JC6291386(E_Sele_Watercraft(__in,__cfg_Local).Layout __EE6291328, B_Business_Sele(__in,__cfg_Local).__ST119645_Layout __EE6291380) := __EEQP(__EE6291380.UID,__EE6291328.Legal_);
  SHARED __EE6291397 := JOIN(__EE6291328,__EE6291380,__JC6291386(LEFT,RIGHT),TRANSFORM(E_Sele_Watercraft(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC6291403(E_Watercraft(__in,__cfg_Local).Layout __EE3481685, E_Sele_Watercraft(__in,__cfg_Local).Layout __EE6291397) := __EEQP(__EE6291397.W_Craft_,__EE3481685.UID);
  SHARED __EE6291414 := JOIN(__EE3481685,__EE6291397,__JC6291403(LEFT,RIGHT),TRANSFORM(E_Watercraft(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6291416 := __EE6291414;
  EXPORT Res32 := __UNWRAP(__EE6291416);
  SHARED __EE6291459 := __ENH_Business_Prox;
  SHARED __EE6292016 := __EE6291459(__NN(__EE6291459.Prox_Sele_));
  SHARED __EE6291462 := __ENH_Business_Sele;
  SHARED __EE6292021 := __EE6291462(__T(__OP2(__EE6291462.UID,=,__CN(__PBusinessSeleUID))));
  __JC6292027(B_Business_Prox(__in,__cfg_Local).__ST101615_Layout __EE6292016, B_Business_Sele(__in,__cfg_Local).__ST119645_Layout __EE6292021) := __EEQP(__EE6292021.UID,__EE6292016.Prox_Sele_);
  SHARED __EE6292287 := JOIN(__EE6292016,__EE6292021,__JC6292027(LEFT,RIGHT),TRANSFORM(B_Business_Prox(__in,__cfg_Local).__ST101615_Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __EE6292289 := __EE6292287;
  EXPORT Res33 := __UNWRAP(__EE6292289);
  SHARED __EE6292810 := __ENH_Criminal_Offense;
  SHARED __EE3482111 := __E_Criminal_Details;
  SHARED __EE6293048 := __EE3482111(__NN(__EE3482111.Offender_) AND __NN(__EE3482111.Offense_));
  SHARED __EE3482105 := __E_Criminal_Offender;
  SHARED __EE6293169 := __EE3482105(__T(__OP2(__EE3482105.UID,=,__CN(__PCriminalOffenderUID))));
  __JC6293175(E_Criminal_Details(__in,__cfg_Local).Layout __EE6293048, E_Criminal_Offender(__in,__cfg_Local).Layout __EE6293169) := __EEQP(__EE6293169.UID,__EE6293048.Offender_);
  SHARED __EE6293183 := JOIN(__EE6293048,__EE6293169,__JC6293175(LEFT,RIGHT),TRANSFORM(E_Criminal_Details(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6293189(B_Criminal_Offense(__in,__cfg_Local).__ST121093_Layout __EE6292810, E_Criminal_Details(__in,__cfg_Local).Layout __EE6293183) := __EEQP(__EE6293183.Offense_,__EE6292810.UID);
  SHARED __EE6293272 := JOIN(__EE6292810,__EE6293183,__JC6293189(LEFT,RIGHT),TRANSFORM(B_Criminal_Offense(__in,__cfg_Local).__ST121093_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6293274 := __EE6293272;
  EXPORT Res34 := __UNWRAP(__EE6293274);
  SHARED __EE3482294 := __E_Criminal_Punishment;
  SHARED __EE3482284 := __E_Criminal_Details;
  SHARED __EE6293571 := __EE3482284(__NN(__EE3482284.Offender_) AND __NN(__EE3482284.Punishment_));
  SHARED __EE3482278 := __E_Criminal_Offender;
  SHARED __EE6293663 := __EE3482278(__T(__OP2(__EE3482278.UID,=,__CN(__PCriminalOffenderUID))));
  __JC6293669(E_Criminal_Details(__in,__cfg_Local).Layout __EE6293571, E_Criminal_Offender(__in,__cfg_Local).Layout __EE6293663) := __EEQP(__EE6293663.UID,__EE6293571.Offender_);
  SHARED __EE6293677 := JOIN(__EE6293571,__EE6293663,__JC6293669(LEFT,RIGHT),TRANSFORM(E_Criminal_Details(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6293683(E_Criminal_Punishment(__in,__cfg_Local).Layout __EE3482294, E_Criminal_Details(__in,__cfg_Local).Layout __EE6293677) := __EEQP(__EE6293677.Punishment_,__EE3482294.UID);
  SHARED __EE6293737 := JOIN(__EE3482294,__EE6293677,__JC6293683(LEFT,RIGHT),TRANSFORM(E_Criminal_Punishment(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6293739 := __EE6293737;
  EXPORT Res35 := __UNWRAP(__EE6293739);
  SHARED __EE3482436 := __E_Inquiry;
  SHARED __EE3482426 := __E_Email_Inquiry;
  SHARED __EE6294079 := __EE3482426(__NN(__EE3482426.Email_) AND __NN(__EE3482426.Transaction_));
  SHARED __EE6293862 := __ENH_Email;
  SHARED __EE6294179 := __EE6293862(__T(__OP2(__EE6293862.UID,=,__CN(__PEmailUID))));
  __JC6294185(E_Email_Inquiry(__in,__cfg_Local).Layout __EE6294079, B_Email_2(__in,__cfg_Local).__ST167525_Layout __EE6294179) := __EEQP(__EE6294179.UID,__EE6294079.Email_);
  SHARED __EE6294195 := JOIN(__EE6294079,__EE6294179,__JC6294185(LEFT,RIGHT),TRANSFORM(E_Email_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6294201(E_Inquiry(__in,__cfg_Local).Layout __EE3482436, E_Email_Inquiry(__in,__cfg_Local).Layout __EE6294195) := __EEQP(__EE6294195.Transaction_,__EE3482436.UID);
  SHARED __EE6294261 := JOIN(__EE3482436,__EE6294195,__JC6294201(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6294263 := __EE6294261;
  EXPORT Res36 := __UNWRAP(__EE6294263);
  SHARED __EE3482578 := __E_First_Degree_Associations;
  SHARED __EE6294461 := __EE3482578(__NN(__EE3482578.Subject_));
  SHARED __EE6294402 := __ENH_Person;
  SHARED __EE6294466 := __EE6294402(__T(__OP2(__EE6294402.UID,=,__CN(__PPersonUID))));
  __JC6294472(E_First_Degree_Associations(__in,__cfg_Local).Layout __EE6294461, B_Person(__in,__cfg_Local).__ST133569_Layout __EE6294466) := __EEQP(__EE6294466.UID,__EE6294461.Subject_);
  SHARED __EE6294484 := JOIN(__EE6294461,__EE6294466,__JC6294472(LEFT,RIGHT),TRANSFORM(E_First_Degree_Associations(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6294486 := __EE6294484;
  EXPORT Res37 := __UNWRAP(__EE6294486);
  SHARED __EE6294511 := __ENH_First_Degree_Relative;
  SHARED __EE6294575 := __EE6294511(__NN(__EE6294511.Subject_));
  SHARED __EE6294514 := __ENH_Person;
  SHARED __EE6294580 := __EE6294514(__T(__OP2(__EE6294514.UID,=,__CN(__PPersonUID))));
  __JC6294586(B_First_Degree_Relative(__in,__cfg_Local).__ST2980311_Layout __EE6294575, B_Person(__in,__cfg_Local).__ST133569_Layout __EE6294580) := __EEQP(__EE6294580.UID,__EE6294575.Subject_);
  SHARED __EE6294598 := JOIN(__EE6294575,__EE6294580,__JC6294586(LEFT,RIGHT),TRANSFORM(B_First_Degree_Relative(__in,__cfg_Local).__ST2980311_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6294600 := __EE6294598;
  EXPORT Res38 := __UNWRAP(__EE6294600);
  SHARED __EE3482712 := __E_Phone;
  SHARED __EE3482702 := __E_House_Hold_Phone;
  SHARED __EE6294758 := __EE3482702(__NN(__EE3482702.Household_) AND __NN(__EE3482702.Phone_Number_));
  SHARED __EE3482696 := __E_Household;
  SHARED __EE6294867 := __EE3482696(__T(__OP2(__EE3482696.UID,=,__CN(__PHouseholdUID))));
  __JC6294873(E_House_Hold_Phone(__in,__cfg_Local).Layout __EE6294758, E_Household(__in,__cfg_Local).Layout __EE6294867) := __EEQP(__EE6294867.UID,__EE6294758.Household_);
  SHARED __EE6294899 := JOIN(__EE6294758,__EE6294867,__JC6294873(LEFT,RIGHT),TRANSFORM(E_House_Hold_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6294905(E_Phone(__in,__cfg_Local).Layout __EE3482712, E_House_Hold_Phone(__in,__cfg_Local).Layout __EE6294899) := __EEQP(__EE6294899.Phone_Number_,__EE3482712.UID);
  SHARED __EE6294958 := JOIN(__EE3482712,__EE6294899,__JC6294905(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6294960 := __EE6294958;
  EXPORT Res39 := __UNWRAP(__EE6294960);
  SHARED __EE6295117 := __ENH_Person;
  SHARED __EE3482865 := __E_Household_Member;
  SHARED __EE6297119 := __EE3482865(__NN(__EE3482865.Household_) AND __NN(__EE3482865.Subject_));
  SHARED __EE3482859 := __E_Household;
  SHARED __EE6298122 := __EE3482859(__T(__OP2(__EE3482859.UID,=,__CN(__PHouseholdUID))));
  __JC6298128(E_Household_Member(__in,__cfg_Local).Layout __EE6297119, E_Household(__in,__cfg_Local).Layout __EE6298122) := __EEQP(__EE6298122.UID,__EE6297119.Household_);
  SHARED __EE6298136 := JOIN(__EE6297119,__EE6298122,__JC6298128(LEFT,RIGHT),TRANSFORM(E_Household_Member(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6298142(B_Person(__in,__cfg_Local).__ST133569_Layout __EE6295117, E_Household_Member(__in,__cfg_Local).Layout __EE6298136) := __EEQP(__EE6298136.Subject_,__EE6295117.UID);
  SHARED __EE6299107 := JOIN(__EE6295117,__EE6298136,__JC6298142(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST133569_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6299109 := __EE6299107;
  EXPORT Res40 := __UNWRAP(__EE6299109);
  SHARED __EE3483997 := __E_Aircraft;
  SHARED __EE3483987 := __E_Aircraft_Owner;
  SHARED __EE6301197 := __EE3483987(__NN(__EE3483987.Owner_) AND __NN(__EE3483987.Plane_));
  SHARED __EE6301054 := __ENH_Person;
  SHARED __EE6301260 := __EE6301054(__T(__OP2(__EE6301054.UID,=,__CN(__PPersonUID))));
  __JC6301266(E_Aircraft_Owner(__in,__cfg_Local).Layout __EE6301197, B_Person(__in,__cfg_Local).__ST133569_Layout __EE6301260) := __EEQP(__EE6301260.UID,__EE6301197.Owner_);
  SHARED __EE6301276 := JOIN(__EE6301197,__EE6301260,__JC6301266(LEFT,RIGHT),TRANSFORM(E_Aircraft_Owner(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6301282(E_Aircraft(__in,__cfg_Local).Layout __EE3483997, E_Aircraft_Owner(__in,__cfg_Local).Layout __EE6301276) := __EEQP(__EE6301276.Plane_,__EE3483997.UID);
  SHARED __EE6301305 := JOIN(__EE3483997,__EE6301276,__JC6301282(LEFT,RIGHT),TRANSFORM(E_Aircraft(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6301307 := __EE6301305;
  EXPORT Res41 := __UNWRAP(__EE6301307);
  SHARED __EE3484109 := __E_Household;
  SHARED __EE3484099 := __E_Household_Member;
  SHARED __EE6301477 := __EE3484099(__NN(__EE3484099.Subject_) AND __NN(__EE3484099.Household_));
  SHARED __EE6301372 := __ENH_Person;
  SHARED __EE6301521 := __EE6301372(__T(__OP2(__EE6301372.UID,=,__CN(__PPersonUID))));
  __JC6301527(E_Household_Member(__in,__cfg_Local).Layout __EE6301477, B_Person(__in,__cfg_Local).__ST133569_Layout __EE6301521) := __EEQP(__EE6301521.UID,__EE6301477.Subject_);
  SHARED __EE6301535 := JOIN(__EE6301477,__EE6301521,__JC6301527(LEFT,RIGHT),TRANSFORM(E_Household_Member(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6301541(E_Household(__in,__cfg_Local).Layout __EE3484109, E_Household_Member(__in,__cfg_Local).Layout __EE6301535) := __EEQP(__EE6301535.Household_,__EE3484109.UID);
  SHARED __EE6301547 := JOIN(__EE3484109,__EE6301535,__JC6301541(LEFT,RIGHT),TRANSFORM(E_Household(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6301549 := __EE6301547;
  EXPORT Res42 := __UNWRAP(__EE6301549);
  SHARED __EE3484200 := __E_Accident;
  SHARED __EE3484190 := __E_Person_Accident;
  SHARED __EE6301801 := __EE3484190(__NN(__EE3484190.Subject_) AND __NN(__EE3484190.Acc_));
  SHARED __EE6301576 := __ENH_Person;
  SHARED __EE6301905 := __EE6301576(__T(__OP2(__EE6301576.UID,=,__CN(__PPersonUID))));
  __JC6301911(E_Person_Accident(__in,__cfg_Local).Layout __EE6301801, B_Person(__in,__cfg_Local).__ST133569_Layout __EE6301905) := __EEQP(__EE6301905.UID,__EE6301801.Subject_);
  SHARED __EE6301959 := JOIN(__EE6301801,__EE6301905,__JC6301911(LEFT,RIGHT),TRANSFORM(E_Person_Accident(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6301965(E_Accident(__in,__cfg_Local).Layout __EE3484200, E_Person_Accident(__in,__cfg_Local).Layout __EE6301959) := __EEQP(__EE6301959.Acc_,__EE3484200.UID);
  SHARED __EE6301991 := JOIN(__EE3484200,__EE6301959,__JC6301965(LEFT,RIGHT),TRANSFORM(E_Accident(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6301993 := __EE6301991;
  EXPORT Res43 := __UNWRAP(__EE6301993);
  SHARED __EE6302140 := __ENH_Address;
  SHARED __EE3484342 := __E_Person_Address;
  SHARED __EE6302636 := __EE3484342(__NN(__EE3484342.Subject_) AND __NN(__EE3484342.Location_));
  SHARED __EE6302143 := __ENH_Person;
  SHARED __EE6302873 := __EE6302143(__T(__OP2(__EE6302143.UID,=,__CN(__PPersonUID))));
  __JC6302879(E_Person_Address(__in,__cfg_Local).Layout __EE6302636, B_Person(__in,__cfg_Local).__ST133569_Layout __EE6302873) := __EEQP(__EE6302873.UID,__EE6302636.Subject_);
  SHARED __EE6302928 := JOIN(__EE6302636,__EE6302873,__JC6302879(LEFT,RIGHT),TRANSFORM(E_Person_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6302934(B_Address_1(__in,__cfg_Local).__ST136323_Layout __EE6302140, E_Person_Address(__in,__cfg_Local).Layout __EE6302928) := __EEQP(__EE6302928.Location_,__EE6302140.UID);
  SHARED __EE6303092 := JOIN(__EE6302140,__EE6302928,__JC6302934(LEFT,RIGHT),TRANSFORM(B_Address_1(__in,__cfg_Local).__ST136323_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6303094 := __EE6303092;
  EXPORT Res44 := __UNWRAP(__EE6303094);
  SHARED __EE6303507 := __ENH_Bankruptcy;
  SHARED __EE3484653 := __E_Person_Bankruptcy;
  SHARED __EE6303775 := __EE3484653(__NN(__EE3484653.Subject_) AND __NN(__EE3484653.Bankrupt_));
  SHARED __EE6303510 := __ENH_Person;
  SHARED __EE6303898 := __EE6303510(__T(__OP2(__EE6303510.UID,=,__CN(__PPersonUID))));
  __JC6303904(E_Person_Bankruptcy(__in,__cfg_Local).Layout __EE6303775, B_Person(__in,__cfg_Local).__ST133569_Layout __EE6303898) := __EEQP(__EE6303898.UID,__EE6303775.Subject_);
  SHARED __EE6303911 := JOIN(__EE6303775,__EE6303898,__JC6303904(LEFT,RIGHT),TRANSFORM(E_Person_Bankruptcy(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6303917(B_Bankruptcy(__in,__cfg_Local).__ST101132_Layout __EE6303507, E_Person_Bankruptcy(__in,__cfg_Local).Layout __EE6303911) := __EEQP(__EE6303911.Bankrupt_,__EE6303507.UID);
  SHARED __EE6304003 := JOIN(__EE6303507,__EE6303911,__JC6303917(LEFT,RIGHT),TRANSFORM(B_Bankruptcy(__in,__cfg_Local).__ST101132_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6304005 := __EE6304003;
  EXPORT Res45 := __UNWRAP(__EE6304005);
  SHARED __EE3484837 := __E_Drivers_License;
  SHARED __EE3484827 := __E_Person_Drivers_License;
  SHARED __EE6304395 := __EE3484827(__NN(__EE3484827.Subject_) AND __NN(__EE3484827.License_));
  SHARED __EE6304190 := __ENH_Person;
  SHARED __EE6304489 := __EE6304190(__T(__OP2(__EE6304190.UID,=,__CN(__PPersonUID))));
  __JC6304495(E_Person_Drivers_License(__in,__cfg_Local).Layout __EE6304395, B_Person(__in,__cfg_Local).__ST133569_Layout __EE6304489) := __EEQP(__EE6304489.UID,__EE6304395.Subject_);
  SHARED __EE6304502 := JOIN(__EE6304395,__EE6304489,__JC6304495(LEFT,RIGHT),TRANSFORM(E_Person_Drivers_License(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6304508(E_Drivers_License(__in,__cfg_Local).Layout __EE3484837, E_Person_Drivers_License(__in,__cfg_Local).Layout __EE6304502) := __EEQP(__EE6304502.License_,__EE3484837.UID);
  SHARED __EE6304565 := JOIN(__EE3484837,__EE6304502,__JC6304508(LEFT,RIGHT),TRANSFORM(E_Drivers_License(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6304567 := __EE6304565;
  EXPORT Res46 := __UNWRAP(__EE6304567);
  SHARED __EE6304694 := __ENH_Education;
  SHARED __EE3484971 := __E_Person_Education;
  SHARED __EE6304858 := __EE3484971(__NN(__EE3484971.Subject_) AND __NN(__EE3484971.Edu_));
  SHARED __EE6304697 := __ENH_Person;
  SHARED __EE6304929 := __EE6304697(__T(__OP2(__EE6304697.UID,=,__CN(__PPersonUID))));
  __JC6304935(E_Person_Education(__in,__cfg_Local).Layout __EE6304858, B_Person(__in,__cfg_Local).__ST133569_Layout __EE6304929) := __EEQP(__EE6304929.UID,__EE6304858.Subject_);
  SHARED __EE6304953 := JOIN(__EE6304858,__EE6304929,__JC6304935(LEFT,RIGHT),TRANSFORM(E_Person_Education(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6304959(B_Education_2(__in,__cfg_Local).__ST167472_Layout __EE6304694, E_Person_Education(__in,__cfg_Local).Layout __EE6304953) := __EEQP(__EE6304953.Edu_,__EE6304694.UID);
  SHARED __EE6304982 := JOIN(__EE6304694,__EE6304953,__JC6304959(LEFT,RIGHT),TRANSFORM(B_Education_2(__in,__cfg_Local).__ST167472_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6304984 := __EE6304982;
  EXPORT Res47 := __UNWRAP(__EE6304984);
  SHARED __EE6305065 := __ENH_Email;
  SHARED __EE3485091 := __E_Person_Email;
  SHARED __EE6305233 := __EE3485091(__NN(__EE3485091.Subject_) AND __NN(__EE3485091.Email_));
  SHARED __EE6305068 := __ENH_Person;
  SHARED __EE6305306 := __EE6305068(__T(__OP2(__EE6305068.UID,=,__CN(__PPersonUID))));
  __JC6305312(E_Person_Email(__in,__cfg_Local).Layout __EE6305233, B_Person(__in,__cfg_Local).__ST133569_Layout __EE6305306) := __EEQP(__EE6305306.UID,__EE6305233.Subject_);
  SHARED __EE6305319 := JOIN(__EE6305233,__EE6305306,__JC6305312(LEFT,RIGHT),TRANSFORM(E_Person_Email(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6305325(B_Email_2(__in,__cfg_Local).__ST167525_Layout __EE6305065, E_Person_Email(__in,__cfg_Local).Layout __EE6305319) := __EEQP(__EE6305319.Email_,__EE6305065.UID);
  SHARED __EE6305361 := JOIN(__EE6305065,__EE6305319,__JC6305325(LEFT,RIGHT),TRANSFORM(B_Email_2(__in,__cfg_Local).__ST167525_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6305363 := __EE6305361;
  EXPORT Res48 := __UNWRAP(__EE6305363);
  SHARED __EE3485227 := __E_Inquiry;
  SHARED __EE3485217 := __E_Person_Inquiry;
  SHARED __EE6305663 := __EE3485217(__NN(__EE3485217.Subject_) AND __NN(__EE3485217.Transaction_));
  SHARED __EE6305448 := __ENH_Person;
  SHARED __EE6305762 := __EE6305448(__T(__OP2(__EE6305448.UID,=,__CN(__PPersonUID))));
  __JC6305768(E_Person_Inquiry(__in,__cfg_Local).Layout __EE6305663, B_Person(__in,__cfg_Local).__ST133569_Layout __EE6305762) := __EEQP(__EE6305762.UID,__EE6305663.Subject_);
  SHARED __EE6305777 := JOIN(__EE6305663,__EE6305762,__JC6305768(LEFT,RIGHT),TRANSFORM(E_Person_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6305783(E_Inquiry(__in,__cfg_Local).Layout __EE3485227, E_Person_Inquiry(__in,__cfg_Local).Layout __EE6305777) := __EEQP(__EE6305777.Transaction_,__EE3485227.UID);
  SHARED __EE6305843 := JOIN(__EE3485227,__EE6305777,__JC6305783(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6305845 := __EE6305843;
  EXPORT Res49 := __UNWRAP(__EE6305845);
  SHARED __EE6305982 := __ENH_Lien_Judgment;
  SHARED __EE3485368 := __E_Person_Lien_Judgment;
  SHARED __EE6306168 := __EE3485368(__NN(__EE3485368.Subject_) AND __NN(__EE3485368.Lien_));
  SHARED __EE6305985 := __ENH_Person;
  SHARED __EE6306250 := __EE6305985(__T(__OP2(__EE6305985.UID,=,__CN(__PPersonUID))));
  __JC6306256(E_Person_Lien_Judgment(__in,__cfg_Local).Layout __EE6306168, B_Person(__in,__cfg_Local).__ST133569_Layout __EE6306250) := __EEQP(__EE6306250.UID,__EE6306168.Subject_);
  SHARED __EE6306269 := JOIN(__EE6306168,__EE6306250,__JC6306256(LEFT,RIGHT),TRANSFORM(E_Person_Lien_Judgment(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6306275(B_Lien_Judgment_12(__in,__cfg_Local).__ST211934_Layout __EE6305982, E_Person_Lien_Judgment(__in,__cfg_Local).Layout __EE6306269) := __EEQP(__EE6306269.Lien_,__EE6305982.UID);
  SHARED __EE6306314 := JOIN(__EE6305982,__EE6306269,__JC6306275(LEFT,RIGHT),TRANSFORM(B_Lien_Judgment_12(__in,__cfg_Local).__ST211934_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6306316 := __EE6306314;
  EXPORT Res50 := __UNWRAP(__EE6306316);
  SHARED __EE3485511 := __E_Criminal_Offender;
  SHARED __EE3485501 := __E_Person_Offender;
  SHARED __EE6306566 := __EE3485501(__NN(__EE3485501.Subject_) AND __NN(__EE3485501.Offender_));
  SHARED __EE6306419 := __ENH_Person;
  SHARED __EE6306631 := __EE6306419(__T(__OP2(__EE6306419.UID,=,__CN(__PPersonUID))));
  __JC6306637(E_Person_Offender(__in,__cfg_Local).Layout __EE6306566, B_Person(__in,__cfg_Local).__ST133569_Layout __EE6306631) := __EEQP(__EE6306631.UID,__EE6306566.Subject_);
  SHARED __EE6306644 := JOIN(__EE6306566,__EE6306631,__JC6306637(LEFT,RIGHT),TRANSFORM(E_Person_Offender(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6306650(E_Criminal_Offender(__in,__cfg_Local).Layout __EE3485511, E_Person_Offender(__in,__cfg_Local).Layout __EE6306644) := __EEQP(__EE6306644.Offender_,__EE3485511.UID);
  SHARED __EE6306678 := JOIN(__EE3485511,__EE6306644,__JC6306650(LEFT,RIGHT),TRANSFORM(E_Criminal_Offender(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6306680 := __EE6306678;
  EXPORT Res51 := __UNWRAP(__EE6306680);
  SHARED __EE6306749 := __ENH_Criminal_Offense;
  SHARED __EE3485616 := __E_Person_Offenses;
  SHARED __EE6307011 := __EE3485616(__NN(__EE3485616.Subject_) AND __NN(__EE3485616.Offense_));
  SHARED __EE6306752 := __ENH_Person;
  SHARED __EE6307131 := __EE6306752(__T(__OP2(__EE6306752.UID,=,__CN(__PPersonUID))));
  __JC6307137(E_Person_Offenses(__in,__cfg_Local).Layout __EE6307011, B_Person(__in,__cfg_Local).__ST133569_Layout __EE6307131) := __EEQP(__EE6307131.UID,__EE6307011.Subject_);
  SHARED __EE6307144 := JOIN(__EE6307011,__EE6307131,__JC6307137(LEFT,RIGHT),TRANSFORM(E_Person_Offenses(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6307150(B_Criminal_Offense(__in,__cfg_Local).__ST121093_Layout __EE6306749, E_Person_Offenses(__in,__cfg_Local).Layout __EE6307144) := __EEQP(__EE6307144.Offense_,__EE6306749.UID);
  SHARED __EE6307233 := JOIN(__EE6306749,__EE6307144,__JC6307150(LEFT,RIGHT),TRANSFORM(B_Criminal_Offense(__in,__cfg_Local).__ST121093_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6307235 := __EE6307233;
  EXPORT Res52 := __UNWRAP(__EE6307235);
  SHARED __EE3485799 := __E_Phone;
  SHARED __EE3485789 := __E_Person_Phone;
  SHARED __EE6307665 := __EE3485789(__NN(__EE3485789.Subject_) AND __NN(__EE3485789.Phone_Number_));
  SHARED __EE6307414 := __ENH_Person;
  SHARED __EE6307782 := __EE6307414(__T(__OP2(__EE6307414.UID,=,__CN(__PPersonUID))));
  __JC6307788(E_Person_Phone(__in,__cfg_Local).Layout __EE6307665, B_Person(__in,__cfg_Local).__ST133569_Layout __EE6307782) := __EEQP(__EE6307782.UID,__EE6307665.Subject_);
  SHARED __EE6307822 := JOIN(__EE6307665,__EE6307782,__JC6307788(LEFT,RIGHT),TRANSFORM(E_Person_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6307828(E_Phone(__in,__cfg_Local).Layout __EE3485799, E_Person_Phone(__in,__cfg_Local).Layout __EE6307822) := __EEQP(__EE6307822.Phone_Number_,__EE3485799.UID);
  SHARED __EE6307881 := JOIN(__EE3485799,__EE6307822,__JC6307828(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6307883 := __EE6307881;
  EXPORT Res53 := __UNWRAP(__EE6307883);
  SHARED __EE6308056 := __ENH_Property;
  SHARED __EE3485963 := __E_Person_Property;
  SHARED __EE6308260 := __EE3485963(__NN(__EE3485963.Subject_) AND __NN(__EE3485963.Prop_));
  SHARED __EE6308059 := __ENH_Person;
  SHARED __EE6308351 := __EE6308059(__T(__OP2(__EE6308059.UID,=,__CN(__PPersonUID))));
  __JC6308357(E_Person_Property(__in,__cfg_Local).Layout __EE6308260, B_Person(__in,__cfg_Local).__ST133569_Layout __EE6308351) := __EEQP(__EE6308351.UID,__EE6308260.Subject_);
  SHARED __EE6308381 := JOIN(__EE6308260,__EE6308351,__JC6308357(LEFT,RIGHT),TRANSFORM(E_Person_Property(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6308387(B_Property(__in,__cfg_Local).__ST134807_Layout __EE6308056, E_Person_Property(__in,__cfg_Local).Layout __EE6308381) := __EEQP(__EE6308381.Prop_,__EE6308056.UID);
  SHARED __EE6308424 := JOIN(__EE6308056,__EE6308381,__JC6308387(LEFT,RIGHT),TRANSFORM(B_Property(__in,__cfg_Local).__ST134807_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6308426 := __EE6308424;
  EXPORT Res54 := __UNWRAP(__EE6308426);
  SHARED __EE6308547 := __ENH_Property_Event;
  SHARED __EE3486106 := __E_Person_Property_Event;
  SHARED __EE6308801 := __EE3486106(__NN(__EE3486106.Subject_) AND __NN(__EE3486106.Event_));
  SHARED __EE6308550 := __ENH_Person;
  SHARED __EE6308917 := __EE6308550(__T(__OP2(__EE6308550.UID,=,__CN(__PPersonUID))));
  __JC6308923(E_Person_Property_Event(__in,__cfg_Local).Layout __EE6308801, B_Person(__in,__cfg_Local).__ST133569_Layout __EE6308917) := __EEQP(__EE6308917.UID,__EE6308801.Subject_);
  SHARED __EE6308942 := JOIN(__EE6308801,__EE6308917,__JC6308923(LEFT,RIGHT),TRANSFORM(E_Person_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6308948(B_Property_Event_4(__in,__cfg_Local).__ST193799_Layout __EE6308547, E_Person_Property_Event(__in,__cfg_Local).Layout __EE6308942) := __EEQP(__EE6308942.Event_,__EE6308547.UID);
  SHARED __EE6309015 := JOIN(__EE6308547,__EE6308942,__JC6308948(LEFT,RIGHT),TRANSFORM(B_Property_Event_4(__in,__cfg_Local).__ST193799_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6309017 := __EE6309015;
  EXPORT Res55 := __UNWRAP(__EE6309017);
  SHARED __EE3486282 := __E_Sex_Offender;
  SHARED __EE3486272 := __E_Person_Sex_Offender;
  SHARED __EE6309303 := __EE3486272(__NN(__EE3486272.Subject_) AND __NN(__EE3486272.Offender_));
  SHARED __EE6309188 := __ENH_Person;
  SHARED __EE6309352 := __EE6309188(__T(__OP2(__EE6309188.UID,=,__CN(__PPersonUID))));
  __JC6309358(E_Person_Sex_Offender(__in,__cfg_Local).Layout __EE6309303, B_Person(__in,__cfg_Local).__ST133569_Layout __EE6309352) := __EEQP(__EE6309352.UID,__EE6309303.Subject_);
  SHARED __EE6309370 := JOIN(__EE6309303,__EE6309352,__JC6309358(LEFT,RIGHT),TRANSFORM(E_Person_Sex_Offender(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6309376(E_Sex_Offender(__in,__cfg_Local).Layout __EE3486282, E_Person_Sex_Offender(__in,__cfg_Local).Layout __EE6309370) := __EEQP(__EE6309370.Offender_,__EE3486282.UID);
  SHARED __EE6309383 := JOIN(__EE3486282,__EE6309370,__JC6309376(LEFT,RIGHT),TRANSFORM(E_Sex_Offender(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6309385 := __EE6309383;
  EXPORT Res56 := __UNWRAP(__EE6309385);
  SHARED __EE3486378 := __E_Social_Security_Number;
  SHARED __EE3486368 := __E_Person_S_S_N;
  SHARED __EE6309551 := __EE3486368(__NN(__EE3486368.Subject_) AND __NN(__EE3486368.Social_));
  SHARED __EE6309422 := __ENH_Person;
  SHARED __EE6309607 := __EE6309422(__T(__OP2(__EE6309422.UID,=,__CN(__PPersonUID))));
  __JC6309613(E_Person_S_S_N(__in,__cfg_Local).Layout __EE6309551, B_Person(__in,__cfg_Local).__ST133569_Layout __EE6309607) := __EEQP(__EE6309607.UID,__EE6309551.Subject_);
  SHARED __EE6309625 := JOIN(__EE6309551,__EE6309607,__JC6309613(LEFT,RIGHT),TRANSFORM(E_Person_S_S_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6309631(E_Social_Security_Number(__in,__cfg_Local).Layout __EE3486378, E_Person_S_S_N(__in,__cfg_Local).Layout __EE6309625) := __EEQP(__EE6309625.Social_,__EE3486378.UID);
  SHARED __EE6309645 := JOIN(__EE3486378,__EE6309625,__JC6309631(LEFT,RIGHT),TRANSFORM(E_Social_Security_Number(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6309647 := __EE6309645;
  EXPORT Res57 := __UNWRAP(__EE6309647);
  SHARED __EE3486483 := __E_Vehicle;
  SHARED __EE3486473 := __E_Person_Vehicle;
  SHARED __EE6310083 := __EE3486473(__NN(__EE3486473.Subject_) AND __NN(__EE3486473.Automobile_));
  SHARED __EE6309698 := __ENH_Person;
  SHARED __EE6310267 := __EE6309698(__T(__OP2(__EE6309698.UID,=,__CN(__PPersonUID))));
  __JC6310273(E_Person_Vehicle(__in,__cfg_Local).Layout __EE6310083, B_Person(__in,__cfg_Local).__ST133569_Layout __EE6310267) := __EEQP(__EE6310267.UID,__EE6310083.Subject_);
  SHARED __EE6310316 := JOIN(__EE6310083,__EE6310267,__JC6310273(LEFT,RIGHT),TRANSFORM(E_Person_Vehicle(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6310322(E_Vehicle(__in,__cfg_Local).Layout __EE3486483, E_Person_Vehicle(__in,__cfg_Local).Layout __EE6310316) := __EEQP(__EE6310316.Automobile_,__EE3486483.UID);
  SHARED __EE6310433 := JOIN(__EE3486483,__EE6310316,__JC6310322(LEFT,RIGHT),TRANSFORM(E_Vehicle(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6310435 := __EE6310433;
  EXPORT Res58 := __UNWRAP(__EE6310435);
  SHARED __EE6310742 := __ENH_Professional_License;
  SHARED __EE3486707 := __E_Professional_License_Person;
  SHARED __EE6310928 := __EE3486707(__NN(__EE3486707.Subject_) AND __NN(__EE3486707.Prof_Lic_));
  SHARED __EE6310745 := __ENH_Person;
  SHARED __EE6311010 := __EE6310745(__T(__OP2(__EE6310745.UID,=,__CN(__PPersonUID))));
  __JC6311016(E_Professional_License_Person(__in,__cfg_Local).Layout __EE6310928, B_Person(__in,__cfg_Local).__ST133569_Layout __EE6311010) := __EEQP(__EE6311010.UID,__EE6310928.Subject_);
  SHARED __EE6311023 := JOIN(__EE6310928,__EE6311010,__JC6311016(LEFT,RIGHT),TRANSFORM(E_Professional_License_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6311029(B_Professional_License_4(__in,__cfg_Local).__ST193601_Layout __EE6310742, E_Professional_License_Person(__in,__cfg_Local).Layout __EE6311023) := __EEQP(__EE6311023.Prof_Lic_,__EE6310742.UID);
  SHARED __EE6311074 := JOIN(__EE6310742,__EE6311023,__JC6311029(LEFT,RIGHT),TRANSFORM(B_Professional_License_4(__in,__cfg_Local).__ST193601_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6311076 := __EE6311074;
  EXPORT Res59 := __UNWRAP(__EE6311076);
  SHARED __EE6311179 := __ENH_Business_Prox;
  SHARED __EE3486841 := __E_Prox_Person;
  SHARED __EE6311837 := __EE3486841(__NN(__EE3486841.Contact_) AND __NN(__EE3486841.Business_Location_));
  SHARED __EE6311182 := __ENH_Person;
  SHARED __EE6312155 := __EE6311182(__T(__OP2(__EE6311182.UID,=,__CN(__PPersonUID))));
  __JC6312161(E_Prox_Person(__in,__cfg_Local).Layout __EE6311837, B_Person(__in,__cfg_Local).__ST133569_Layout __EE6312155) := __EEQP(__EE6312155.UID,__EE6311837.Contact_);
  SHARED __EE6312189 := JOIN(__EE6311837,__EE6312155,__JC6312161(LEFT,RIGHT),TRANSFORM(E_Prox_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6312195(B_Business_Prox(__in,__cfg_Local).__ST101615_Layout __EE6311179, E_Prox_Person(__in,__cfg_Local).Layout __EE6312189) := __EEQP(__EE6312189.Business_Location_,__EE6311179.UID);
  SHARED __EE6312455 := JOIN(__EE6311179,__EE6312189,__JC6312195(LEFT,RIGHT),TRANSFORM(B_Business_Prox(__in,__cfg_Local).__ST101615_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6312457 := __EE6312455;
  EXPORT Res60 := __UNWRAP(__EE6312457);
  SHARED __EE6313032 := __ENH_Business_Sele;
  SHARED __EE3487233 := __E_Sele_Person;
  SHARED __EE6316202 := __EE3487233(__NN(__EE3487233.Contact_) AND __NN(__EE3487233.Legal_));
  SHARED __EE6313035 := __ENH_Person;
  SHARED __EE6317776 := __EE6313035(__T(__OP2(__EE6313035.UID,=,__CN(__PPersonUID))));
  __JC6317782(E_Sele_Person(__in,__cfg_Local).Layout __EE6316202, B_Person(__in,__cfg_Local).__ST133569_Layout __EE6317776) := __EEQP(__EE6317776.UID,__EE6316202.Contact_);
  SHARED __EE6317813 := JOIN(__EE6316202,__EE6317776,__JC6317782(LEFT,RIGHT),TRANSFORM(E_Sele_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6317819(B_Business_Sele(__in,__cfg_Local).__ST119645_Layout __EE6313032, E_Sele_Person(__in,__cfg_Local).Layout __EE6317813) := __EEQP(__EE6317813.Legal_,__EE6313032.UID);
  SHARED __EE6319332 := JOIN(__EE6313032,__EE6317813,__JC6317819(LEFT,RIGHT),TRANSFORM(B_Business_Sele(__in,__cfg_Local).__ST119645_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6319334 := __EE6319332;
  EXPORT Res61 := __UNWRAP(__EE6319334);
  SHARED __EE3488968 := __E_Utility;
  SHARED __EE3488958 := __E_Utility_Person;
  SHARED __EE6322564 := __EE3488958(__NN(__EE3488958.Subject_) AND __NN(__EE3488958.Util_));
  SHARED __EE6322421 := __ENH_Person;
  SHARED __EE6322627 := __EE6322421(__T(__OP2(__EE6322421.UID,=,__CN(__PPersonUID))));
  __JC6322633(E_Utility_Person(__in,__cfg_Local).Layout __EE6322564, B_Person(__in,__cfg_Local).__ST133569_Layout __EE6322627) := __EEQP(__EE6322627.UID,__EE6322564.Subject_);
  SHARED __EE6322640 := JOIN(__EE6322564,__EE6322627,__JC6322633(LEFT,RIGHT),TRANSFORM(E_Utility_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6322646(E_Utility(__in,__cfg_Local).Layout __EE3488968, E_Utility_Person(__in,__cfg_Local).Layout __EE6322640) := __EEQP(__EE6322640.Util_,__EE3488968.UID);
  SHARED __EE6322672 := JOIN(__EE3488968,__EE6322640,__JC6322646(LEFT,RIGHT),TRANSFORM(E_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6322674 := __EE6322672;
  EXPORT Res62 := __UNWRAP(__EE6322674);
  SHARED __EE3489079 := __E_Watercraft;
  SHARED __EE3489069 := __E_Watercraft_Owner;
  SHARED __EE6322852 := __EE3489069(__NN(__EE3489069.Owner_) AND __NN(__EE3489069.W_Craft_));
  SHARED __EE6322739 := __ENH_Person;
  SHARED __EE6322900 := __EE6322739(__T(__OP2(__EE6322739.UID,=,__CN(__PPersonUID))));
  __JC6322906(E_Watercraft_Owner(__in,__cfg_Local).Layout __EE6322852, B_Person(__in,__cfg_Local).__ST133569_Layout __EE6322900) := __EEQP(__EE6322900.UID,__EE6322852.Owner_);
  SHARED __EE6322913 := JOIN(__EE6322852,__EE6322900,__JC6322906(LEFT,RIGHT),TRANSFORM(E_Watercraft_Owner(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6322919(E_Watercraft(__in,__cfg_Local).Layout __EE3489079, E_Watercraft_Owner(__in,__cfg_Local).Layout __EE6322913) := __EEQP(__EE6322913.W_Craft_,__EE3489079.UID);
  SHARED __EE6322930 := JOIN(__EE3489079,__EE6322913,__JC6322919(LEFT,RIGHT),TRANSFORM(E_Watercraft(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6322932 := __EE6322930;
  EXPORT Res63 := __UNWRAP(__EE6322932);
  SHARED __EE3489175 := __E_Zip_Code;
  SHARED __EE3489165 := __E_Zip_Code_Person;
  SHARED __EE6323082 := __EE3489165(__NN(__EE3489165.Subject_) AND __NN(__EE3489165.Zip_));
  SHARED __EE6322967 := __ENH_Person;
  SHARED __EE6323131 := __EE6322967(__T(__OP2(__EE6322967.UID,=,__CN(__PPersonUID))));
  __JC6323137(E_Zip_Code_Person(__in,__cfg_Local).Layout __EE6323082, B_Person(__in,__cfg_Local).__ST133569_Layout __EE6323131) := __EEQP(__EE6323131.UID,__EE6323082.Subject_);
  SHARED __EE6323145 := JOIN(__EE6323082,__EE6323131,__JC6323137(LEFT,RIGHT),TRANSFORM(E_Zip_Code_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6323151(E_Zip_Code(__in,__cfg_Local).Layout __EE3489175, E_Zip_Code_Person(__in,__cfg_Local).Layout __EE6323145) := __EEQP(__EE6323145.Zip_,__EE3489175.UID);
  SHARED __EE6323162 := JOIN(__EE3489175,__EE6323145,__JC6323151(LEFT,RIGHT),TRANSFORM(E_Zip_Code(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6323164 := __EE6323162;
  EXPORT Res64 := __UNWRAP(__EE6323164);
  SHARED __EE3489261 := __E_Person_Email_Phone_Address;
  SHARED __EE6323276 := __EE3489261(__NN(__EE3489261.Subject_));
  SHARED __EE6323201 := __ENH_Person;
  SHARED __EE6323281 := __EE6323201(__T(__OP2(__EE6323201.UID,=,__CN(__PPersonUID))));
  __JC6323287(E_Person_Email_Phone_Address(__in,__cfg_Local).Layout __EE6323276, B_Person(__in,__cfg_Local).__ST133569_Layout __EE6323281) := __EEQP(__EE6323281.UID,__EE6323276.Subject_);
  SHARED __EE6323307 := JOIN(__EE6323276,__EE6323281,__JC6323287(LEFT,RIGHT),TRANSFORM(E_Person_Email_Phone_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6323309 := __EE6323307;
  EXPORT Res65 := __UNWRAP(__EE6323309);
  SHARED __EE6323350 := __ENH_Address;
  SHARED __EE3489332 := __E_Address_Phone;
  SHARED __EE6323758 := __EE3489332(__NN(__EE3489332.Phone_Number_) AND __NN(__EE3489332.Location_));
  SHARED __EE3489326 := __E_Phone;
  SHARED __EE6323974 := __EE3489326(__T(__OP2(__EE3489326.UID,=,__CN(__PPhoneUID))));
  __JC6323980(E_Address_Phone(__in,__cfg_Local).Layout __EE6323758, E_Phone(__in,__cfg_Local).Layout __EE6323974) := __EEQP(__EE6323974.UID,__EE6323758.Phone_Number_);
  SHARED __EE6324008 := JOIN(__EE6323758,__EE6323974,__JC6323980(LEFT,RIGHT),TRANSFORM(E_Address_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6324014(B_Address_1(__in,__cfg_Local).__ST136323_Layout __EE6323350, E_Address_Phone(__in,__cfg_Local).Layout __EE6324008) := __EEQP(__EE6324008.Location_,__EE6323350.UID);
  SHARED __EE6324172 := JOIN(__EE6323350,__EE6324008,__JC6324014(LEFT,RIGHT),TRANSFORM(B_Address_1(__in,__cfg_Local).__ST136323_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6324174 := __EE6324172;
  EXPORT Res66 := __UNWRAP(__EE6324174);
  SHARED __EE6324545 := __ENH_Person;
  SHARED __EE3489621 := __E_Person_Phone;
  SHARED __EE6326573 := __EE3489621(__NN(__EE3489621.Phone_Number_) AND __NN(__EE3489621.Subject_));
  SHARED __EE3489615 := __E_Phone;
  SHARED __EE6327602 := __EE3489615(__T(__OP2(__EE3489615.UID,=,__CN(__PPhoneUID))));
  __JC6327608(E_Person_Phone(__in,__cfg_Local).Layout __EE6326573, E_Phone(__in,__cfg_Local).Layout __EE6327602) := __EEQP(__EE6327602.UID,__EE6326573.Phone_Number_);
  SHARED __EE6327642 := JOIN(__EE6326573,__EE6327602,__JC6327608(LEFT,RIGHT),TRANSFORM(E_Person_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6327648(B_Person(__in,__cfg_Local).__ST133569_Layout __EE6324545, E_Person_Phone(__in,__cfg_Local).Layout __EE6327642) := __EEQP(__EE6327642.Subject_,__EE6324545.UID);
  SHARED __EE6328613 := JOIN(__EE6324545,__EE6327642,__JC6327648(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST133569_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6328615 := __EE6328613;
  EXPORT Res67 := __UNWRAP(__EE6328615);
  SHARED __EE3490781 := __E_Inquiry;
  SHARED __EE3490771 := __E_Phone_Inquiry;
  SHARED __EE6330735 := __EE3490771(__NN(__EE3490771.Phone_Number_) AND __NN(__EE3490771.Transaction_));
  SHARED __EE3490765 := __E_Phone;
  SHARED __EE6330834 := __EE3490765(__T(__OP2(__EE3490765.UID,=,__CN(__PPhoneUID))));
  __JC6330840(E_Phone_Inquiry(__in,__cfg_Local).Layout __EE6330735, E_Phone(__in,__cfg_Local).Layout __EE6330834) := __EEQP(__EE6330834.UID,__EE6330735.Phone_Number_);
  SHARED __EE6330849 := JOIN(__EE6330735,__EE6330834,__JC6330840(LEFT,RIGHT),TRANSFORM(E_Phone_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6330855(E_Inquiry(__in,__cfg_Local).Layout __EE3490781, E_Phone_Inquiry(__in,__cfg_Local).Layout __EE6330849) := __EEQP(__EE6330849.Transaction_,__EE3490781.UID);
  SHARED __EE6330915 := JOIN(__EE3490781,__EE6330849,__JC6330855(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6330917 := __EE6330915;
  EXPORT Res68 := __UNWRAP(__EE6330917);
  SHARED __EE3490931 := __E_T_I_N;
  SHARED __EE3490921 := __E_T_I_N_Phone_Number;
  SHARED __EE6331123 := __EE3490921(__NN(__EE3490921.Phone_Number_) AND __NN(__EE3490921.Tax_I_D_));
  SHARED __EE3490915 := __E_Phone;
  SHARED __EE6331168 := __EE3490915(__T(__OP2(__EE3490915.UID,=,__CN(__PPhoneUID))));
  __JC6331174(E_T_I_N_Phone_Number(__in,__cfg_Local).Layout __EE6331123, E_Phone(__in,__cfg_Local).Layout __EE6331168) := __EEQP(__EE6331168.UID,__EE6331123.Phone_Number_);
  SHARED __EE6331185 := JOIN(__EE6331123,__EE6331168,__JC6331174(LEFT,RIGHT),TRANSFORM(E_T_I_N_Phone_Number(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6331191(E_T_I_N(__in,__cfg_Local).Layout __EE3490931, E_T_I_N_Phone_Number(__in,__cfg_Local).Layout __EE6331185) := __EEQP(__EE6331185.Tax_I_D_,__EE3490931.UID);
  SHARED __EE6331195 := JOIN(__EE3490931,__EE6331185,__JC6331191(LEFT,RIGHT),TRANSFORM(E_T_I_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6331197 := __EE6331195;
  EXPORT Res69 := __UNWRAP(__EE6331197);
  SHARED __EE6331226 := __ENH_Second_Degree_Associations;
  SHARED __EE6331290 := __EE6331226(__NN(__EE6331226.First_Degree_Association_));
  SHARED __EE6331229 := __ENH_Person;
  SHARED __EE6331295 := __EE6331229(__T(__OP2(__EE6331229.UID,=,__CN(__PPersonUID))));
  __JC6331301(E_Second_Degree_Associations(__in,__cfg_Local).Layout __EE6331290, B_Person(__in,__cfg_Local).__ST133569_Layout __EE6331295) := __EEQP(__EE6331295.UID,__EE6331290.First_Degree_Association_);
  SHARED __EE6331313 := JOIN(__EE6331290,__EE6331295,__JC6331301(LEFT,RIGHT),TRANSFORM(E_Second_Degree_Associations(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6331315 := __EE6331313;
  EXPORT Res70 := __UNWRAP(__EE6331315);
  SHARED __EE6331340 := __ENH_Person;
  SHARED __EE3491086 := __E_Person_Property_Event;
  SHARED __EE6333558 := __EE3491086(__NN(__EE3491086.Event_) AND __NN(__EE3491086.Subject_));
  SHARED __EE6331343 := __ENH_Property_Event;
  SHARED __EE6333535 := __EE6331343(__NN(__EE6331343.Prop_));
  SHARED __EE6331346 := __ENH_Property;
  SHARED __EE6334572 := __EE6331346(__T(__OP2(__EE6331346.UID,=,__CN(__PPropertyUID))));
  __JC6334578(B_Property_Event_4(__in,__cfg_Local).__ST193799_Layout __EE6333535, B_Property(__in,__cfg_Local).__ST134807_Layout __EE6334572) := __EEQP(__EE6334572.UID,__EE6333535.Prop_);
  SHARED __EE6334645 := JOIN(__EE6333535,__EE6334572,__JC6334578(LEFT,RIGHT),TRANSFORM(B_Property_Event_4(__in,__cfg_Local).__ST193799_Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6334651(E_Person_Property_Event(__in,__cfg_Local).Layout __EE6333558, B_Property_Event_4(__in,__cfg_Local).__ST193799_Layout __EE6334645) := __EEQP(__EE6334645.UID,__EE6333558.Event_);
  SHARED __EE6334670 := JOIN(__EE6333558,__EE6334645,__JC6334651(LEFT,RIGHT),TRANSFORM(E_Person_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6334676(B_Person(__in,__cfg_Local).__ST133569_Layout __EE6331340, E_Person_Property_Event(__in,__cfg_Local).Layout __EE6334670) := __EEQP(__EE6334670.Subject_,__EE6331340.UID);
  SHARED __EE6335641 := JOIN(__EE6331340,__EE6334670,__JC6334676(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST133569_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6335643 := __EE6335641;
  EXPORT Res71 := __UNWRAP(__EE6335643);
  SHARED __EE6337742 := __ENH_Business_Sele;
  SHARED __EE3492313 := __E_Sele_Property_Event;
  SHARED __EE6341062 := __EE3492313(__NN(__EE3492313.Event_) AND __NN(__EE3492313.Legal_));
  SHARED __EE6337745 := __ENH_Property_Event;
  SHARED __EE6341039 := __EE6337745(__NN(__EE6337745.Prop_));
  SHARED __EE6337748 := __ENH_Property;
  SHARED __EE6342627 := __EE6337748(__T(__OP2(__EE6337748.UID,=,__CN(__PPropertyUID))));
  __JC6342633(B_Property_Event_4(__in,__cfg_Local).__ST193799_Layout __EE6341039, B_Property(__in,__cfg_Local).__ST134807_Layout __EE6342627) := __EEQP(__EE6342627.UID,__EE6341039.Prop_);
  SHARED __EE6342700 := JOIN(__EE6341039,__EE6342627,__JC6342633(LEFT,RIGHT),TRANSFORM(B_Property_Event_4(__in,__cfg_Local).__ST193799_Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6342706(E_Sele_Property_Event(__in,__cfg_Local).Layout __EE6341062, B_Property_Event_4(__in,__cfg_Local).__ST193799_Layout __EE6342700) := __EEQP(__EE6342700.UID,__EE6341062.Event_);
  SHARED __EE6342728 := JOIN(__EE6341062,__EE6342700,__JC6342706(LEFT,RIGHT),TRANSFORM(E_Sele_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6342734(B_Business_Sele(__in,__cfg_Local).__ST119645_Layout __EE6337742, E_Sele_Property_Event(__in,__cfg_Local).Layout __EE6342728) := __EEQP(__EE6342728.Legal_,__EE6337742.UID);
  SHARED __EE6344247 := JOIN(__EE6337742,__EE6342728,__JC6342734(LEFT,RIGHT),TRANSFORM(B_Business_Sele(__in,__cfg_Local).__ST119645_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6344249 := __EE6344247;
  EXPORT Res72 := __UNWRAP(__EE6344249);
  SHARED __EE6347450 := __ENH_Person;
  SHARED __EE3494111 := __E_Person_S_S_N;
  SHARED __EE6349456 := __EE3494111(__NN(__EE3494111.Social_) AND __NN(__EE3494111.Subject_));
  SHARED __EE3494105 := __E_Social_Security_Number;
  SHARED __EE6350463 := __EE3494105(__T(__OP2(__EE3494105.UID,=,__CN(__PSocialSecurityNumberUID))));
  __JC6350469(E_Person_S_S_N(__in,__cfg_Local).Layout __EE6349456, E_Social_Security_Number(__in,__cfg_Local).Layout __EE6350463) := __EEQP(__EE6350463.UID,__EE6349456.Social_);
  SHARED __EE6350481 := JOIN(__EE6349456,__EE6350463,__JC6350469(LEFT,RIGHT),TRANSFORM(E_Person_S_S_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6350487(B_Person(__in,__cfg_Local).__ST133569_Layout __EE6347450, E_Person_S_S_N(__in,__cfg_Local).Layout __EE6350481) := __EEQP(__EE6350481.Subject_,__EE6347450.UID);
  SHARED __EE6351452 := JOIN(__EE6347450,__EE6350481,__JC6350487(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST133569_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6351454 := __EE6351452;
  EXPORT Res73 := __UNWRAP(__EE6351454);
  SHARED __EE6353407 := __ENH_Address;
  SHARED __EE3495237 := __E_S_S_N_Address;
  SHARED __EE6353803 := __EE3495237(__NN(__EE3495237.Social_) AND __NN(__EE3495237.Location_));
  SHARED __EE3495231 := __E_Social_Security_Number;
  SHARED __EE6354007 := __EE3495231(__T(__OP2(__EE3495231.UID,=,__CN(__PSocialSecurityNumberUID))));
  __JC6354013(E_S_S_N_Address(__in,__cfg_Local).Layout __EE6353803, E_Social_Security_Number(__in,__cfg_Local).Layout __EE6354007) := __EEQP(__EE6354007.UID,__EE6353803.Social_);
  SHARED __EE6354029 := JOIN(__EE6353803,__EE6354007,__JC6354013(LEFT,RIGHT),TRANSFORM(E_S_S_N_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6354035(B_Address_1(__in,__cfg_Local).__ST136323_Layout __EE6353407, E_S_S_N_Address(__in,__cfg_Local).Layout __EE6354029) := __EEQP(__EE6354029.Location_,__EE6353407.UID);
  SHARED __EE6354193 := JOIN(__EE6353407,__EE6354029,__JC6354035(LEFT,RIGHT),TRANSFORM(B_Address_1(__in,__cfg_Local).__ST136323_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6354195 := __EE6354193;
  EXPORT Res74 := __UNWRAP(__EE6354195);
  SHARED __EE3495522 := __E_Inquiry;
  SHARED __EE3495512 := __E_S_S_N_Inquiry;
  SHARED __EE6354665 := __EE3495512(__NN(__EE3495512.S_S_N_) AND __NN(__EE3495512.Transaction_));
  SHARED __EE3495506 := __E_Social_Security_Number;
  SHARED __EE6354764 := __EE3495506(__T(__OP2(__EE3495506.UID,=,__CN(__PSocialSecurityNumberUID))));
  __JC6354770(E_S_S_N_Inquiry(__in,__cfg_Local).Layout __EE6354665, E_Social_Security_Number(__in,__cfg_Local).Layout __EE6354764) := __EEQP(__EE6354764.UID,__EE6354665.S_S_N_);
  SHARED __EE6354779 := JOIN(__EE6354665,__EE6354764,__JC6354770(LEFT,RIGHT),TRANSFORM(E_S_S_N_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6354785(E_Inquiry(__in,__cfg_Local).Layout __EE3495522, E_S_S_N_Inquiry(__in,__cfg_Local).Layout __EE6354779) := __EEQP(__EE6354779.Transaction_,__EE3495522.UID);
  SHARED __EE6354845 := JOIN(__EE3495522,__EE6354779,__JC6354785(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6354847 := __EE6354845;
  EXPORT Res75 := __UNWRAP(__EE6354847);
  SHARED __EE3495672 := __E_Inquiry;
  SHARED __EE3495662 := __E_T_I_N_Inquiry;
  SHARED __EE6355107 := __EE3495662(__NN(__EE3495662.Tax_I_D_) AND __NN(__EE3495662.Transaction_));
  SHARED __EE3495656 := __E_T_I_N;
  SHARED __EE6355206 := __EE3495656(__T(__OP2(__EE3495656.UID,=,__CN(__PTINUID))));
  __JC6355212(E_T_I_N_Inquiry(__in,__cfg_Local).Layout __EE6355107, E_T_I_N(__in,__cfg_Local).Layout __EE6355206) := __EEQP(__EE6355206.UID,__EE6355107.Tax_I_D_);
  SHARED __EE6355221 := JOIN(__EE6355107,__EE6355206,__JC6355212(LEFT,RIGHT),TRANSFORM(E_T_I_N_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6355227(E_Inquiry(__in,__cfg_Local).Layout __EE3495672, E_T_I_N_Inquiry(__in,__cfg_Local).Layout __EE6355221) := __EEQP(__EE6355221.Transaction_,__EE3495672.UID);
  SHARED __EE6355287 := JOIN(__EE3495672,__EE6355221,__JC6355227(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6355289 := __EE6355287;
  EXPORT Res76 := __UNWRAP(__EE6355289);
  SHARED __EE6355426 := __ENH_Address;
  SHARED __EE3495812 := __E_T_I_N_Address;
  SHARED __EE6355821 := __EE3495812(__NN(__EE3495812.Tax_I_D_) AND __NN(__EE3495812.Location_));
  SHARED __EE3495806 := __E_T_I_N;
  SHARED __EE6356024 := __EE3495806(__T(__OP2(__EE3495806.UID,=,__CN(__PTINUID))));
  __JC6356030(E_T_I_N_Address(__in,__cfg_Local).Layout __EE6355821, E_T_I_N(__in,__cfg_Local).Layout __EE6356024) := __EEQP(__EE6356024.UID,__EE6355821.Tax_I_D_);
  SHARED __EE6356045 := JOIN(__EE6355821,__EE6356024,__JC6356030(LEFT,RIGHT),TRANSFORM(E_T_I_N_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6356051(B_Address_1(__in,__cfg_Local).__ST136323_Layout __EE6355426, E_T_I_N_Address(__in,__cfg_Local).Layout __EE6356045) := __EEQP(__EE6356045.Location_,__EE6355426.UID);
  SHARED __EE6356209 := JOIN(__EE6355426,__EE6356045,__JC6356051(LEFT,RIGHT),TRANSFORM(B_Address_1(__in,__cfg_Local).__ST136323_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6356211 := __EE6356209;
  EXPORT Res77 := __UNWRAP(__EE6356211);
  SHARED __EE3496096 := __E_Phone;
  SHARED __EE3496086 := __E_T_I_N_Phone_Number;
  SHARED __EE6356674 := __EE3496086(__NN(__EE3496086.Tax_I_D_) AND __NN(__EE3496086.Phone_Number_));
  SHARED __EE3496080 := __E_T_I_N;
  SHARED __EE6356768 := __EE3496080(__T(__OP2(__EE3496080.UID,=,__CN(__PTINUID))));
  __JC6356774(E_T_I_N_Phone_Number(__in,__cfg_Local).Layout __EE6356674, E_T_I_N(__in,__cfg_Local).Layout __EE6356768) := __EEQP(__EE6356768.UID,__EE6356674.Tax_I_D_);
  SHARED __EE6356785 := JOIN(__EE6356674,__EE6356768,__JC6356774(LEFT,RIGHT),TRANSFORM(E_T_I_N_Phone_Number(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6356791(E_Phone(__in,__cfg_Local).Layout __EE3496096, E_T_I_N_Phone_Number(__in,__cfg_Local).Layout __EE6356785) := __EEQP(__EE6356785.Phone_Number_,__EE3496096.UID);
  SHARED __EE6356844 := JOIN(__EE3496096,__EE6356785,__JC6356791(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE6356846 := __EE6356844;
  EXPORT Res78 := __UNWRAP(__EE6356846);
  SHARED __EE6356973 := __ENH_Person;
  SHARED __EE3496234 := __E_Zip_Code_Person;
  SHARED __EE6358975 := __EE3496234(__NN(__EE3496234.Zip_) AND __NN(__EE3496234.Subject_));
  SHARED __EE3496228 := __E_Zip_Code;
  SHARED __EE6359978 := __EE3496228(__T(__OP2(__EE3496228.UID,=,__CN(__PZipCodeUID))));
  __JC6359984(E_Zip_Code_Person(__in,__cfg_Local).Layout __EE6358975, E_Zip_Code(__in,__cfg_Local).Layout __EE6359978) := __EEQP(__EE6359978.UID,__EE6358975.Zip_);
  SHARED __EE6359992 := JOIN(__EE6358975,__EE6359978,__JC6359984(LEFT,RIGHT),TRANSFORM(E_Zip_Code_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC6359998(B_Person(__in,__cfg_Local).__ST133569_Layout __EE6356973, E_Zip_Code_Person(__in,__cfg_Local).Layout __EE6359992) := __EEQP(__EE6359992.Subject_,__EE6356973.UID);
  SHARED __EE6360963 := JOIN(__EE6356973,__EE6359992,__JC6359998(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST133569_Layout,SELF:=LEFT),SMART,KEEP(1));
  EXPORT Res79 := __UNWRAP(__EE6360963);
END;
