//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Address,B_Address_1,B_Address_2,B_Address_3,B_Address_4,B_Address_5,B_Address_6,B_Aircraft_Owner_1,B_Aircraft_Owner_2,B_Aircraft_Owner_3,B_Bankruptcy,B_Bankruptcy_1,B_Bankruptcy_2,B_Bankruptcy_3,B_Bankruptcy_4,B_Bankruptcy_5,B_Bankruptcy_6,B_Bankruptcy_7,B_Bankruptcy_8,B_Business_Prox,B_Business_Prox_1,B_Business_Prox_2,B_Business_Prox_3,B_Business_Sele,B_Business_Sele_1,B_Business_Sele_10,B_Business_Sele_2,B_Business_Sele_3,B_Business_Sele_4,B_Business_Sele_5,B_Business_Sele_6,B_Business_Sele_7,B_Business_Sele_8,B_Business_Sele_9,B_Business_Sele_Overflow_1,B_Business_Sele_Overflow_2,B_Business_Sele_Overflow_3,B_Business_Sele_Overflow_4,B_Business_Sele_Overflow_5,B_Business_Sele_Overflow_6,B_Criminal_Offense,B_Criminal_Offense_1,B_Criminal_Offense_2,B_Criminal_Offense_3,B_Criminal_Offense_4,B_Criminal_Offense_5,B_Education,B_Education_1,B_Education_2,B_Education_3,B_Education_4,B_Education_5,B_Education_6,B_Education_7,B_Email,B_Email_1,B_Email_2,B_First_Degree_Relative,B_First_Degree_Relative_1,B_First_Degree_Relative_2,B_First_Degree_Relative_3,B_First_Degree_Relative_4,B_First_Degree_Relative_5,B_Input_B_I_I_1,B_Input_B_I_I_10,B_Input_B_I_I_2,B_Input_B_I_I_3,B_Input_B_I_I_4,B_Input_B_I_I_5,B_Input_B_I_I_6,B_Input_B_I_I_7,B_Input_B_I_I_8,B_Input_B_I_I_9,B_Input_P_I_I_1,B_Input_P_I_I_2,B_Input_P_I_I_3,B_Input_P_I_I_4,B_Input_P_I_I_5,B_Input_P_I_I_6,B_Input_P_I_I_7,B_Input_P_I_I_8,B_Input_P_I_I_9,B_Inquiry,B_Inquiry_1,B_Inquiry_10,B_Inquiry_11,B_Inquiry_2,B_Inquiry_3,B_Inquiry_4,B_Inquiry_5,B_Inquiry_6,B_Inquiry_7,B_Inquiry_8,B_Inquiry_9,B_Lien_Judgment,B_Lien_Judgment_1,B_Lien_Judgment_10,B_Lien_Judgment_11,B_Lien_Judgment_12,B_Lien_Judgment_13,B_Lien_Judgment_2,B_Lien_Judgment_3,B_Lien_Judgment_4,B_Lien_Judgment_5,B_Lien_Judgment_6,B_Lien_Judgment_7,B_Lien_Judgment_8,B_Lien_Judgment_9,B_Person,B_Person_1,B_Person_10,B_Person_11,B_Person_2,B_Person_3,B_Person_4,B_Person_5,B_Person_6,B_Person_7,B_Person_8,B_Person_9,B_Person_Accident_8,B_Person_Address_2,B_Person_Address_3,B_Person_Inquiry_3,B_Person_Inquiry_4,B_Person_Inquiry_5,B_Person_Inquiry_6,B_Person_Inquiry_7,B_Person_Inquiry_8,B_Person_Lien_Judgment_12,B_Person_Property_1,B_Person_Property_2,B_Person_Property_3,B_Person_Property_4,B_Person_Property_5,B_Person_Property_6,B_Person_Property_7,B_Person_Property_8,B_Person_S_S_N_1,B_Person_S_S_N_2,B_Person_S_S_N_3,B_Person_S_S_N_4,B_Person_S_S_N_5,B_Person_S_S_N_6,B_Person_Vehicle_1,B_Person_Vehicle_2,B_Person_Vehicle_3,B_Professional_License,B_Professional_License_1,B_Professional_License_2,B_Professional_License_3,B_Professional_License_4,B_Professional_License_5,B_Property,B_Property_1,B_Property_2,B_Property_3,B_Property_4,B_Property_5,B_Property_Event,B_Property_Event_1,B_Property_Event_2,B_Property_Event_3,B_Property_Event_4,B_Property_Event_5,B_Property_Event_6,B_Property_Event_7,B_Property_Event_8,B_Second_Degree_Associations,B_Sele_Address_1,B_Sele_Address_2,B_Sele_Address_3,B_Sele_Address_4,B_Sele_Address_5,B_Sele_Address_6,B_Sele_Lien_Judgment_11,B_Sele_Person_1,B_Sele_Person_2,B_Sele_Person_3,B_Sele_Person_4,B_Sele_Person_5,B_Sele_Person_6,B_Sele_Person_7,B_Sele_Phone_Number_3,B_Sele_Phone_Number_4,B_Sele_Phone_Number_5,B_Sele_Phone_Number_6,B_Sele_Property_1,B_Sele_Property_2,B_Sele_Property_3,B_Sele_Property_4,B_Sele_T_I_N_3,B_Sele_T_I_N_4,B_Sele_T_I_N_5,B_Sele_T_I_N_6,B_Sele_Tradeline_1,B_Sele_Tradeline_2,B_Sele_Tradeline_3,B_Sele_U_C_C_2,B_Sele_U_C_C_3,B_Sele_U_C_C_4,B_Sele_U_C_C_5,B_Sele_U_C_C_6,B_Sele_U_C_C_7,B_Sele_U_C_C_8,B_Sele_U_C_C_9,B_Sele_Vehicle_1,B_Sele_Vehicle_2,B_Sele_Vehicle_3,B_Tradeline,B_Tradeline_1,B_Tradeline_10,B_Tradeline_2,B_Tradeline_3,B_Tradeline_4,B_Tradeline_5,B_Tradeline_6,B_Tradeline_7,B_Tradeline_8,B_Tradeline_9,B_U_C_C,B_U_C_C_1,B_U_C_C_10,B_U_C_C_11,B_U_C_C_12,B_U_C_C_13,B_U_C_C_2,B_U_C_C_3,B_U_C_C_4,B_U_C_C_5,B_U_C_C_6,B_U_C_C_7,B_U_C_C_8,B_U_C_C_9,B_Watercraft_Owner_1,B_Watercraft_Owner_2,B_Watercraft_Owner_3,CFG_Compile,E_Accident,E_Address,E_Address_Inquiry,E_Address_Phone,E_Address_Property,E_Address_Property_Event,E_Aircraft,E_Aircraft_Owner,E_Bankruptcy,E_Business_Org,E_Business_Prox,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Criminal_Details,E_Criminal_Offender,E_Criminal_Offense,E_Criminal_Punishment,E_Drivers_License,E_E_B_R_Tradeline,E_Education,E_Email,E_Email_Inquiry,E_First_Degree_Associations,E_First_Degree_Relative,E_Geo_Link,E_House_Hold_Phone,E_Household,E_Household_Member,E_Input_B_I_I,E_Input_B_I_I_Input_P_I_I,E_Input_P_I_I,E_Inquiry,E_Lien_Judgment,E_Person,E_Person_Accident,E_Person_Address,E_Person_Bankruptcy,E_Person_Drivers_License,E_Person_Education,E_Person_Email,E_Person_Email_Phone_Address,E_Person_Inquiry,E_Person_Lien_Judgment,E_Person_Offender,E_Person_Offenses,E_Person_Phone,E_Person_Property,E_Person_Property_Event,E_Person_S_S_N,E_Person_Sex_Offender,E_Person_Vehicle,E_Phone,E_Phone_Inquiry,E_Professional_License,E_Professional_License_Person,E_Property,E_Property_Event,E_Prox_Address,E_Prox_Email,E_Prox_Person,E_Prox_Phone_Number,E_Prox_T_I_N,E_Prox_Utility,E_S_S_N_Address,E_S_S_N_Inquiry,E_Second_Degree_Associations,E_Sele_Address,E_Sele_Aircraft,E_Sele_Bankruptcy,E_Sele_E_B_R_Tradeline,E_Sele_Email,E_Sele_Inquiry,E_Sele_Lien_Judgment,E_Sele_Person,E_Sele_Phone_Number,E_Sele_Property,E_Sele_Property_Event,E_Sele_T_I_N,E_Sele_Tradeline,E_Sele_U_C_C,E_Sele_Utility,E_Sele_Vehicle,E_Sele_Watercraft,E_Sex_Offender,E_Social_Security_Number,E_Surname,E_T_I_N,E_T_I_N_Address,E_T_I_N_Inquiry,E_T_I_N_Phone_Number,E_Tradeline,E_U_C_C,E_Utility,E_Utility_Address,E_Utility_Person,E_Vehicle,E_Watercraft,E_Watercraft_Owner,E_Zip_Code,E_Zip_Code_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT Q_Index_Build_Association(KEL.typ.uid __PAddressUID, KEL.typ.uid __PBusinessProxUID, KEL.typ.uid __PBusinessSeleUID, KEL.typ.uid __PCriminalOffenderUID, KEL.typ.uid __PPersonUID, KEL.typ.uid __PHouseholdUID, KEL.typ.uid __PPhoneUID, KEL.typ.uid __PEmailUID, KEL.typ.uid __PGeoLink, KEL.typ.uid __PPropertyUID, KEL.typ.uid __PSexOffenderUID, KEL.typ.uid __PSocialSecurityNumberUID, KEL.typ.uid __PTINUID, KEL.typ.uid __PZipCodeUID, KEL.typ.kdate __PP_InpClnArchDt, DATA57 __PDPM) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PP_InpClnArchDt;
  END;
  SHARED E_Property_Filtered_5 := MODULE(E_Property(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PPropertyUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Address_Filtered_4 := MODULE(E_Address(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PAddressUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Business_Prox_Filtered_4 := MODULE(E_Business_Prox(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PBusinessProxUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Business_Sele_Filtered_4 := MODULE(E_Business_Sele(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PBusinessSeleUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Household_Filtered_4 := MODULE(E_Household(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PHouseholdUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Person_Filtered_4 := MODULE(E_Person(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PPersonUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Phone_Filtered_4 := MODULE(E_Phone(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PPhoneUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Property_Event_Filtered_4 := MODULE(E_Property_Event(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,JOIN(__ds,E_Property_Filtered_5.__PostFilter,__EEQP(LEFT.Prop_,RIGHT.UID),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Social_Security_Number_Filtered_4 := MODULE(E_Social_Security_Number(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PSocialSecurityNumberUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Zip_Code_Filtered_4 := MODULE(E_Zip_Code(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PZipCodeUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Household_Member_Filtered_3 := MODULE(E_Household_Member(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Household_Filtered_4.__PostFilter,__EEQP(LEFT.Household_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Address_Filtered_3 := MODULE(E_Person_Address(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_4.__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Phone_Filtered_3 := MODULE(E_Person_Phone(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Phone_Filtered_4.__PostFilter,__EEQP(LEFT.Phone_Number_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Property_Event_Filtered_3 := MODULE(E_Person_Property_Event(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Property_Event_Filtered_4.__PostFilter,__EEQP(LEFT.Event_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_S_S_N_Filtered_3 := MODULE(E_Person_S_S_N(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Social_Security_Number_Filtered_4.__PostFilter,__EEQP(LEFT.Social_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Prox_Person_Filtered_3 := MODULE(E_Prox_Person(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Prox_Filtered_4.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Address_Filtered_3 := MODULE(E_Sele_Address(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_4.__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Person_Filtered_3 := MODULE(E_Sele_Person(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_4.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Filtered_4.__PostFilter,__EEQP(LEFT.Contact_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Property_Event_Filtered_3 := MODULE(E_Sele_Property_Event(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Property_Event_Filtered_4.__PostFilter,__EEQP(LEFT.Event_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_T_I_N_Filtered_3 := MODULE(E_T_I_N(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PTINUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Zip_Code_Person_Filtered_3 := MODULE(E_Zip_Code_Person(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Zip_Code_Filtered_4.__PostFilter,__EEQP(LEFT.Zip_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Address_Phone_Filtered_2 := MODULE(E_Address_Phone(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Phone_Filtered_4.__PostFilter,__EEQP(LEFT.Phone_Number_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Address_Property_Filtered_2 := MODULE(E_Address_Property(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_4.__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Criminal_Offender_Filtered_2 := MODULE(E_Criminal_Offender(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PCriminalOffenderUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Email_Filtered_2 := MODULE(E_Email(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PEmailUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Household_Member_Filtered_2 := MODULE(E_Household_Member(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
      KEL.typ.bool __Link7 := FALSE;
      KEL.typ.bool __Link8 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Household_,RIGHT.Household_) AND __EEQP(LEFT.Version_,RIGHT.Version_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__T(__OP2(__g.Version_,=,__CN(1))))) AND EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__T(__OP2(__g.Version_,=,__CN(1))))) AND EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__T(__OP2(__g.Version_,=,__CN(1))))) AND EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__T(__OP2(__g.Version_,=,__CN(1))))) AND EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__T(__OP2(__g.Version_,=,__CN(1))))) AND EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__T(__OP2(__g.Version_,=,__CN(1))))) AND EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__T(__OP2(__g.Version_,=,__CN(1))))) AND EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__T(__OP2(__g.Version_,=,__CN(1))))) AND EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Address_Filtered_2 := MODULE(E_Person_Address(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
      KEL.typ.bool __Link7 := FALSE;
      KEL.typ.bool __Link8 := FALSE;
      KEL.typ.bool __Link9 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Filtered_4.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart9(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Address_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_) AND __EEQP(LEFT.Cart_,RIGHT.Cart_) AND __EEQP(LEFT.C_R_Sort_Sz_,RIGHT.C_R_Sort_Sz_) AND __EEQP(LEFT.Lot_,RIGHT.Lot_) AND __EEQP(LEFT.Lot_Order_,RIGHT.Lot_Order_) AND __EEQP(LEFT.D_P_B_C_,RIGHT.D_P_B_C_) AND __EEQP(LEFT.C_H_K_Digit_,RIGHT.C_H_K_Digit_) AND __EEQP(LEFT.Ace_Fips_St_,RIGHT.Ace_Fips_St_) AND __EEQP(LEFT.Ace_Fips_County_,RIGHT.Ace_Fips_County_) AND __EEQP(LEFT.M_S_A_,RIGHT.M_S_A_) AND __EEQP(LEFT.Verified_City_,RIGHT.Verified_City_),TRANSFORM(__InLayoutExtended,SELF.__Link9:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8)) OR EXISTS(__g(__g.__Link9));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart9(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Property_Filtered_2 := MODULE(E_Person_Property(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
      KEL.typ.bool __Link7 := FALSE;
      KEL.typ.bool __Link8 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Filtered_4.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Prox_Address_Filtered_2 := MODULE(E_Prox_Address(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Prox_Filtered_4.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_S_S_N_Address_Filtered_2 := MODULE(E_S_S_N_Address(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Social_Security_Number_Filtered_4.__PostFilter,__EEQP(LEFT.Social_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Address_Filtered_2 := MODULE(E_Sele_Address(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_3.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_4.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_4.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_3.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Address_Filtered_3.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Person_Filtered_2 := MODULE(E_Sele_Person(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_3.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_4.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_3.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Contact_,RIGHT.Contact_) AND __EEQP(LEFT.Ult_I_D_,RIGHT.Ult_I_D_) AND __EEQP(LEFT.Org_I_D_,RIGHT.Org_I_D_) AND __EEQP(LEFT.Sele_I_D_,RIGHT.Sele_I_D_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Property_Filtered_2 := MODULE(E_Sele_Property(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_4.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_T_I_N_Address_Filtered_2 := MODULE(E_T_I_N_Address(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_T_I_N_Filtered_3.__PostFilter,__EEQP(LEFT.Tax_I_D_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Address_Filtered_1 := MODULE(E_Address(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.UID,RIGHT.Location_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Address_Filtered_2.__PostFilter,__EEQP(LEFT.UID,RIGHT.Location_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Address_Filtered_2.__PostFilter,__EEQP(LEFT.UID,RIGHT.Location_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Address_Phone_Filtered_2.__PostFilter,__EEQP(LEFT.UID,RIGHT.Location_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_S_S_N_Address_Filtered_2.__PostFilter,__EEQP(LEFT.UID,RIGHT.Location_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_T_I_N_Address_Filtered_2.__PostFilter,__EEQP(LEFT.UID,RIGHT.Location_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PAddressUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Address_Inquiry_Filtered_1 := MODULE(E_Address_Inquiry(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Archive___Date_)),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_4.__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Location_,RIGHT.Location_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Address_Phone_Filtered_1 := MODULE(E_Address_Phone(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_4.__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Address_Phone_Filtered_2.__PostFilter,__EEQP(LEFT.Phone_Number_,RIGHT.Phone_Number_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_) AND __EEQP(LEFT.Z_I_P4_,RIGHT.Z_I_P4_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_) AND __EEQP(LEFT.Postal_City_,RIGHT.Postal_City_) AND __EEQP(LEFT.Verified_City_,RIGHT.Verified_City_) AND __EEQP(LEFT.State_,RIGHT.State_) AND __EEQP(LEFT.Latitude_,RIGHT.Latitude_) AND __EEQP(LEFT.Longitude_,RIGHT.Longitude_) AND __EEQP(LEFT.Geo_Blk_,RIGHT.Geo_Blk_) AND __EEQP(LEFT.Geo_Mmatch_,RIGHT.Geo_Mmatch_) AND __EEQP(LEFT.Cart_,RIGHT.Cart_) AND __EEQP(LEFT.C_R_Sort_Sz_,RIGHT.C_R_Sort_Sz_) AND __EEQP(LEFT.Lot_,RIGHT.Lot_) AND __EEQP(LEFT.Lot_Order_,RIGHT.Lot_Order_) AND __EEQP(LEFT.D_P_B_C_,RIGHT.D_P_B_C_) AND __EEQP(LEFT.C_H_K_Digit_,RIGHT.C_H_K_Digit_) AND __EEQP(LEFT.Ace_Fips_St_,RIGHT.Ace_Fips_St_) AND __EEQP(LEFT.Ace_Fips_County_,RIGHT.Ace_Fips_County_) AND __EEQP(LEFT.M_S_A_,RIGHT.M_S_A_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Phone_Number_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Address_Property_Filtered_1 := MODULE(E_Address_Property(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Property_Filtered_2.__PostFilter,__EEQP(LEFT.Prop_,RIGHT.Prop_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Prop_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Filtered_2.__PostFilter,__EEQP(LEFT.Prop_,RIGHT.Prop_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Filtered_2.__PostFilter,__EEQP(LEFT.Prop_,RIGHT.Prop_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Prop_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Address_Property_Filtered_2.__PostFilter,__EEQP(LEFT.Prop_,RIGHT.Prop_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Prop_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Address_Property_Event_Filtered_1 := MODULE(E_Address_Property_Event(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_4.__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Location_,RIGHT.Location_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Aircraft_Owner_Filtered_1 := MODULE(E_Aircraft_Owner(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4.__PostFilter,__EEQP(LEFT.Owner_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Business_Prox_Filtered_1 := MODULE(E_Business_Prox(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,JOIN(__ds,E_Business_Sele_Filtered_4.__PostFilter,__EEQP(LEFT.Prox_Sele_,RIGHT.UID),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PBusinessProxUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart0(__ds),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Business_Sele_Filtered_1 := MODULE(E_Business_Sele(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.UID,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_4.__PostFilter,__EEQP(LEFT.UID,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.UID,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_3.__PostFilter,__EEQP(LEFT.UID,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PBusinessSeleUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Criminal_Details_Filtered_1 := MODULE(E_Criminal_Details(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Criminal_Offender_Filtered_2.__PostFilter,__EEQP(LEFT.Offender_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Email_Inquiry_Filtered_1 := MODULE(E_Email_Inquiry(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Archive___Date_)),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Email_Filtered_2.__PostFilter,__EEQP(LEFT.Email_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_First_Degree_Associations_Filtered_1 := MODULE(E_First_Degree_Associations(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := JOIN(__UsingFitler(__AsofFitler(__ds)),E_Person_Filtered_4.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,KEEP(1));
  END;
  SHARED E_House_Hold_Phone_Filtered_1 := MODULE(E_House_Hold_Phone(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Household_Filtered_4.__PostFilter,__EEQP(LEFT.Household_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Household_Member_Filtered_1 := MODULE(E_Household_Member(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Household_Member_Filtered_2.__PostFilter,__EEQP(LEFT.Household_,RIGHT.Household_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Household_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Filtered_4.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Household_,RIGHT.Household_) AND __EEQP(LEFT.Version_,RIGHT.Version_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Accident_Filtered_1 := MODULE(E_Person_Accident(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
      KEL.typ.bool __Link7 := FALSE;
      KEL.typ.bool __Link8 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Filtered_4.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Bankruptcy_Filtered_1 := MODULE(E_Person_Bankruptcy(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
      KEL.typ.bool __Link7 := FALSE;
      KEL.typ.bool __Link8 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Filtered_4.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Drivers_License_Filtered_1 := MODULE(E_Person_Drivers_License(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Education_Filtered_1 := MODULE(E_Person_Education(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
      KEL.typ.bool __Link7 := FALSE;
      KEL.typ.bool __Link8 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Filtered_4.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Email_Filtered_1 := MODULE(E_Person_Email(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
      KEL.typ.bool __Link7 := FALSE;
      KEL.typ.bool __Link8 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Filtered_4.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Inquiry_Filtered_1 := MODULE(E_Person_Inquiry(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Archive___Date_)),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
      KEL.typ.bool __Link7 := FALSE;
      KEL.typ.bool __Link8 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Filtered_4.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Lien_Judgment_Filtered_1 := MODULE(E_Person_Lien_Judgment(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
      KEL.typ.bool __Link7 := FALSE;
      KEL.typ.bool __Link8 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Filtered_4.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Offender_Filtered_1 := MODULE(E_Person_Offender(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Offenses_Filtered_1 := MODULE(E_Person_Offenses(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
      KEL.typ.bool __Link7 := FALSE;
      KEL.typ.bool __Link8 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Filtered_4.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Phone_Filtered_1 := MODULE(E_Person_Phone(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Phone_Number_,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Property_Event_Filtered_1 := MODULE(E_Person_Property_Event(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
      KEL.typ.bool __Link7 := FALSE;
      KEL.typ.bool __Link8 := FALSE;
      KEL.typ.bool __Link9 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Filtered_4.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart9(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Event_,RIGHT.Event_) AND __EEQP(LEFT.L_N_Fares_I_D_,RIGHT.L_N_Fares_I_D_),TRANSFORM(__InLayoutExtended,SELF.__Link9:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8)) OR EXISTS(__g(__g.__Link9));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart9(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_S_S_N_Filtered_1 := MODULE(E_Person_S_S_N(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Social_,RIGHT.Social_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Sex_Offender_Filtered_1 := MODULE(E_Person_Sex_Offender(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Vehicle_Filtered_1 := MODULE(E_Person_Vehicle(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Phone_Inquiry_Filtered_1 := MODULE(E_Phone_Inquiry(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Archive___Date_)),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Phone_Filtered_4.__PostFilter,__EEQP(LEFT.Phone_Number_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Professional_License_Person_Filtered_1 := MODULE(E_Professional_License_Person(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
      KEL.typ.bool __Link7 := FALSE;
      KEL.typ.bool __Link8 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Filtered_4.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Prox_Address_Filtered_1 := MODULE(E_Prox_Address(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_4.__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Prox_Email_Filtered_1 := MODULE(E_Prox_Email(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Prox_Filtered_4.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Prox_Person_Filtered_1 := MODULE(E_Prox_Person(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4.__PostFilter,__EEQP(LEFT.Contact_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_) AND __EEQP(LEFT.Contact_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Prox_Phone_Number_Filtered_1 := MODULE(E_Prox_Phone_Number(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Prox_Filtered_4.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Prox_T_I_N_Filtered_1 := MODULE(E_Prox_T_I_N(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Prox_Filtered_4.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Prox_Utility_Filtered_1 := MODULE(E_Prox_Utility(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Prox_Filtered_4.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_S_S_N_Inquiry_Filtered_1 := MODULE(E_S_S_N_Inquiry(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Archive___Date_)),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Social_Security_Number_Filtered_4.__PostFilter,__EEQP(LEFT.S_S_N_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Aircraft_Filtered_1 := MODULE(E_Sele_Aircraft(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_4.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Bankruptcy_Filtered_1 := MODULE(E_Sele_Bankruptcy(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_4.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_4.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_3.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_E_B_R_Tradeline_Filtered_1 := MODULE(E_Sele_E_B_R_Tradeline(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_4.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Email_Filtered_1 := MODULE(E_Sele_Email(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_4.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Inquiry_Filtered_1 := MODULE(E_Sele_Inquiry(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Archive___Date_)),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_4.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Lien_Judgment_Filtered_1 := MODULE(E_Sele_Lien_Judgment(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Sele_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_4.__PostFilter,__EEQP(LEFT.Sele_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_4.__PostFilter,__EEQP(LEFT.Sele_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Sele_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_3.__PostFilter,__EEQP(LEFT.Sele_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Phone_Number_Filtered_1 := MODULE(E_Sele_Phone_Number(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_4.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Property_Filtered_1 := MODULE(E_Sele_Property(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_4.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_3.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Prop_,RIGHT.Prop_) AND __EEQP(LEFT.Ult_I_D_,RIGHT.Ult_I_D_) AND __EEQP(LEFT.Org_I_D_,RIGHT.Org_I_D_) AND __EEQP(LEFT.Sele_I_D_,RIGHT.Sele_I_D_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Property_Event_Filtered_1 := MODULE(E_Sele_Property_Event(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_4.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_4.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_3.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_3.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Event_,RIGHT.Event_) AND __EEQP(LEFT.Ult_I_D_,RIGHT.Ult_I_D_) AND __EEQP(LEFT.Org_I_D_,RIGHT.Org_I_D_) AND __EEQP(LEFT.Sele_I_D_,RIGHT.Sele_I_D_) AND __EEQP(LEFT.L_N_Fares_I_D_,RIGHT.L_N_Fares_I_D_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_T_I_N_Filtered_1 := MODULE(E_Sele_T_I_N(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_4.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Tradeline_Filtered_1 := MODULE(E_Sele_Tradeline(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_4.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_4.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_3.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_U_C_C_Filtered_1 := MODULE(E_Sele_U_C_C(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_4.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_4.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_3.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Utility_Filtered_1 := MODULE(E_Sele_Utility(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_4.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Vehicle_Filtered_1 := MODULE(E_Sele_Vehicle(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_4.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_4.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_3.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Watercraft_Filtered_1 := MODULE(E_Sele_Watercraft(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_4.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_T_I_N_Address_Filtered_1 := MODULE(E_T_I_N_Address(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_4.__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_T_I_N_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Tax_I_D_,RIGHT.Tax_I_D_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Tax_I_D_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_T_I_N_Inquiry_Filtered_1 := MODULE(E_T_I_N_Inquiry(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Archive___Date_)),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_T_I_N_Filtered_3.__PostFilter,__EEQP(LEFT.Tax_I_D_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_T_I_N_Phone_Number_Filtered_1 := MODULE(E_T_I_N_Phone_Number(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Phone_Filtered_4.__PostFilter,__EEQP(LEFT.Phone_Number_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_T_I_N_Filtered_3.__PostFilter,__EEQP(LEFT.Tax_I_D_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Utility_Address_Filtered_1 := MODULE(E_Utility_Address(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_4.__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Utility_Person_Filtered_1 := MODULE(E_Utility_Person(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Watercraft_Owner_Filtered_1 := MODULE(E_Watercraft_Owner(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4.__PostFilter,__EEQP(LEFT.Owner_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Zip_Code_Person_Filtered_1 := MODULE(E_Zip_Code_Person(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_3.__PostFilter,__EEQP(LEFT.Zip_,RIGHT.Zip_) AND __EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Zip_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Accident_Filtered := MODULE(E_Accident(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Accident_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Acc_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Address_Filtered := MODULE(E_Address(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Property_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Location_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Address_Filtered_2.__PostFilter,__EEQP(LEFT.UID,RIGHT.Location_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Address_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__T(__OP2(__g.Residential_Or_Business_Indicator_,IN,__CN(['B','D']))))) AND EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Address_Property_Event_Filtered := MODULE(E_Address_Property_Event(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.Event_,RIGHT.Event_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Event_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Address_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.Event_,RIGHT.Event_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.L_N_Fares_I_D_,RIGHT.L_N_Fares_I_D_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Event_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Aircraft_Filtered := MODULE(E_Aircraft(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Aircraft_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Plane_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Plane_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Aircraft_Owner_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Plane_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Plane_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Aircraft_Owner_Filtered := MODULE(E_Aircraft_Owner(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
      KEL.typ.bool __Link7 := FALSE;
      KEL.typ.bool __Link8 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_1.__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_1.__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_1.__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Aircraft_Owner_Filtered_1.__PostFilter,__EEQP(LEFT.Plane_,RIGHT.Plane_) AND __EEQP(LEFT.Owner_,RIGHT.Owner_) AND __EEQP(LEFT.Registrant_Type_,RIGHT.Registrant_Type_) AND __EEQP(LEFT.Certificate_Issue_Date_,RIGHT.Certificate_Issue_Date_) AND __EEQP(LEFT.Certification_,RIGHT.Certification_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Plane_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Bankruptcy_Filtered := MODULE(E_Bankruptcy(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Bankruptcy_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Bankrupt_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Bankrupt_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Bankruptcy_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Bankrupt_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Bankrupt_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Business_Prox_Filtered := MODULE(E_Business_Prox(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Prox_Address_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Business_Location_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Prox_Sele_,RIGHT.Legal_),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,JOIN(__ds,E_Business_Prox_Filtered_1.__PostFilter,__EEQP(LEFT.Prox_Sele_,RIGHT.Prox_Sele_),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Business_Location_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Prox_Sele_,RIGHT.Legal_),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,JOIN(__ds,E_Sele_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.Prox_Sele_,RIGHT.Legal_),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Business_Sele_Overflow_Filtered := MODULE(E_Business_Sele_Overflow(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Sele_Overflow_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Criminal_Offender_Filtered := MODULE(E_Criminal_Offender(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Offender_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Offender_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Offender_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PCriminalOffenderUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart0(__ds),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Criminal_Offense_Filtered := MODULE(E_Criminal_Offense(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Offenses_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Offense_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Offense_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Criminal_Details_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Offense_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Offense_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Criminal_Punishment_Filtered := MODULE(E_Criminal_Punishment(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Criminal_Details_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Punishment_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Drivers_License_Filtered := MODULE(E_Drivers_License(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Drivers_License_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.License_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_E_B_R_Tradeline_Filtered := MODULE(E_E_B_R_Tradeline(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_E_B_R_Tradeline_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Tradeline_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Education_Filtered := MODULE(E_Education(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Education_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Edu_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Email_Filtered := MODULE(E_Email(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Email_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Email_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Email_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Email_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Email_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Email_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Email_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Email_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Email_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PEmailUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_First_Degree_Associations_Filtered := MODULE(E_First_Degree_Associations(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Ult_I_D_),SELF:=LEFT),HASH,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_First_Degree_Associations_Filtered_1.InData,__EEQP(LEFT.Subject_,RIGHT.First_Degree_Association_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.First_Degree_Association_),SELF:=LEFT),HASH,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_First_Degree_Associations_Filtered_1.InData,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.First_Degree_Association_,RIGHT.First_Degree_Association_) AND __EEQP(LEFT.Title_,RIGHT.Title_) AND __EEQP(LEFT.Relationship_Type_,RIGHT.Relationship_Type_) AND __EEQP(LEFT.Relationship_Confidence_,RIGHT.Relationship_Confidence_) AND __EEQP(LEFT.Relationship_Score_,RIGHT.Relationship_Score_) AND __EEQP(LEFT.Generation_,RIGHT.Generation_) AND __EEQP(LEFT.Relationship_Date_First_Seen_,RIGHT.Relationship_Date_First_Seen_) AND __EEQP(LEFT.Relationship_Date_Last_Seen_,RIGHT.Relationship_Date_Last_Seen_) AND __EEQP(LEFT.Source_,RIGHT.Source_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,KEEP(1),LEFT OUTER);
    SHARED __SimpleFilter(DATASET(__InLayoutExtended) __ds) := __ds(__T(__OP2(__ds.Title_,>=,__CN(1))) AND __T(__OP2(__ds.Title_,<=,__CN(45))) AND __ds.__Link0 OR __ds.__Link1 OR __ds.__Link2);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := PROJECT(__SimpleFilter(__FilterPart2(__FilterPart1(__FilterPart0(__UsingFitler(__AsofFitler(__ds)))))),InLayout);
  END;
  SHARED E_Household_Filtered := MODULE(E_Household(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Household_Member_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Household_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Household_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PHouseholdUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart0(__ds),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Input_B_I_I_Filtered := MODULE(E_Input_B_I_I(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,JOIN(__ds,E_Business_Prox_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,JOIN(__ds,E_Sele_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Input_P_I_I_Filtered := MODULE(E_Input_P_I_I(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Inquiry_Filtered := MODULE(E_Inquiry(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Archive___Date_)),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Inquiry_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Transaction_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Transaction_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Inquiry_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Transaction_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Transaction_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Inquiry_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Transaction_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Transaction_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Email_Inquiry_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Transaction_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Transaction_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Phone_Inquiry_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Transaction_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Transaction_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_S_S_N_Inquiry_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Transaction_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Transaction_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_T_I_N_Inquiry_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Transaction_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Transaction_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Lien_Judgment_Filtered := MODULE(E_Lien_Judgment(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Lien_Judgment_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Lien_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Lien_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Lien_Judgment_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Lien_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Lien_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Filtered := MODULE(E_Person(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
      KEL.typ.bool __Link7 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_2.__PostFilter,__EEQP(LEFT.UID,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.UID,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PPersonUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Email_Filtered := MODULE(E_Person_Email(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Email_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Email_,RIGHT.Email_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Email_Phone_Address_Filtered := MODULE(E_Person_Email_Phone_Address(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_S_S_N_Filtered := MODULE(E_Person_S_S_N(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
      KEL.typ.bool __Link7 := FALSE;
      KEL.typ.bool __Link8 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Social_,RIGHT.Social_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Vehicle_Filtered := MODULE(E_Person_Vehicle(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
      KEL.typ.bool __Link7 := FALSE;
      KEL.typ.bool __Link8 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Vehicle_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Automobile_,RIGHT.Automobile_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Phone_Filtered := MODULE(E_Phone(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Phone_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Phone_Number_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Phone_Number_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Phone_Number_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Phone_Number_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Phone_Number_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_House_Hold_Phone_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Phone_Number_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Phone_Number_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_T_I_N_Phone_Number_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Phone_Number_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PPhoneUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Professional_License_Filtered := MODULE(E_Professional_License(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Professional_License_Person_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Prof_Lic_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Property_Filtered := MODULE(E_Property(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Property_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Prop_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Prop_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Filtered_2.__PostFilter,__EEQP(LEFT.UID,RIGHT.Prop_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prop_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Prop_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Prop_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PPropertyUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Property_Event_Filtered := MODULE(E_Property_Event(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Event_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Event_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Event_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Event_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,JOIN(__ds,E_Sele_Property_Filtered_1.__PostFilter,__EEQP(LEFT.Prop_,RIGHT.Prop_),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Event_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Event_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Property_Event_Filtered_4.__PostFilter,__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Prox_Address_Filtered := MODULE(E_Prox_Address(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Prox_Address_Filtered_1.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_1.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Address_Filtered_1.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Prox_Phone_Number_Filtered := MODULE(E_Prox_Phone_Number(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Prox_Address_Filtered_1.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_1.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Phone_Number_Filtered_1.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_) AND __EEQP(LEFT.Phone_Number_,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Prox_T_I_N_Filtered := MODULE(E_Prox_T_I_N(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Prox_Address_Filtered_1.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_1.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_T_I_N_Filtered_1.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_) AND __EEQP(LEFT.Tax_I_D_,RIGHT.Tax_I_D_) AND __EEQP(LEFT.Ult_I_D_,RIGHT.Ult_I_D_) AND __EEQP(LEFT.Org_I_D_,RIGHT.Org_I_D_) AND __EEQP(LEFT.Sele_I_D_,RIGHT.Sele_I_D_) AND __EEQP(LEFT.Prox_I_D_,RIGHT.Prox_I_D_) AND __EEQP(LEFT.Best_T_I_N_,RIGHT.Best_T_I_N_) AND __EEQP(LEFT.Best_T_I_N_Rank_,RIGHT.Best_T_I_N_Rank_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Aircraft_Filtered := MODULE(E_Sele_Aircraft(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Aircraft_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Plane_,RIGHT.Plane_) AND __EEQP(LEFT.Ult_I_D_,RIGHT.Ult_I_D_) AND __EEQP(LEFT.Org_I_D_,RIGHT.Org_I_D_) AND __EEQP(LEFT.Sele_I_D_,RIGHT.Sele_I_D_) AND __EEQP(LEFT.N_Number_,RIGHT.N_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Person_Filtered := MODULE(E_Sele_Person(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
      KEL.typ.bool __Link7 := FALSE;
      KEL.typ.bool __Link8 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Contact_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Contact_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Contact_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_1.__PostFilter,__EEQP(LEFT.Contact_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_1.__PostFilter,__EEQP(LEFT.Contact_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.Contact_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_1.__PostFilter,__EEQP(LEFT.Contact_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Contact_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Contact_,RIGHT.Contact_) AND __EEQP(LEFT.Ult_I_D_,RIGHT.Ult_I_D_) AND __EEQP(LEFT.Org_I_D_,RIGHT.Org_I_D_) AND __EEQP(LEFT.Sele_I_D_,RIGHT.Sele_I_D_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Phone_Number_Filtered := MODULE(E_Sele_Phone_Number(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Phone_Number_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Phone_Number_,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_T_I_N_Filtered := MODULE(E_Sele_T_I_N(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_T_I_N_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Tax_I_D_,RIGHT.Tax_I_D_) AND __EEQP(LEFT.Ult_I_D_,RIGHT.Ult_I_D_) AND __EEQP(LEFT.Org_I_D_,RIGHT.Org_I_D_) AND __EEQP(LEFT.Sele_I_D_,RIGHT.Sele_I_D_) AND __EEQP(LEFT.Best_T_I_N_,RIGHT.Best_T_I_N_) AND __EEQP(LEFT.Best_T_I_N_Rank_,RIGHT.Best_T_I_N_Rank_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Watercraft_Filtered := MODULE(E_Sele_Watercraft(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Watercraft_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.W_Craft_,RIGHT.W_Craft_) AND __EEQP(LEFT.Ult_I_D_,RIGHT.Ult_I_D_) AND __EEQP(LEFT.Org_I_D_,RIGHT.Org_I_D_) AND __EEQP(LEFT.Sele_I_D_,RIGHT.Sele_I_D_) AND __EEQP(LEFT.Watercraft_Key_,RIGHT.Watercraft_Key_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sex_Offender_Filtered := MODULE(E_Sex_Offender(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Sex_Offender_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Offender_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Social_Security_Number_Filtered := MODULE(E_Social_Security_Number(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Social_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Social_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PSocialSecurityNumberUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart0(__ds),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_T_I_N_Filtered := MODULE(E_T_I_N(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_T_I_N_Address_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Tax_I_D_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Tax_I_D_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_T_I_N_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Tax_I_D_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Tax_I_D_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_T_I_N_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Tax_I_D_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Tax_I_D_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_T_I_N_Phone_Number_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Tax_I_D_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Tax_I_D_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PTINUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Tradeline_Filtered := MODULE(E_Tradeline(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Tradeline_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Account_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_U_C_C_Filtered := MODULE(E_U_C_C(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_U_C_C_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Filing_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Utility_Filtered := MODULE(E_Utility(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Utility_Address_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Util_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Util_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Utility_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Util_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Util_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Utility_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Util_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Util_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Utility_Person_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Util_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Util_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Utility_Person_Filtered := MODULE(E_Utility_Person(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
      KEL.typ.bool __Link7 := FALSE;
      KEL.typ.bool __Link8 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Utility_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Util_,RIGHT.Util_) AND __EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Util_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Vehicle_Filtered := MODULE(E_Vehicle(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Vehicle_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Automobile_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Automobile_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Vehicle_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Automobile_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Automobile_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Watercraft_Filtered := MODULE(E_Watercraft(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Watercraft_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.W_Craft_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.W_Craft_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Watercraft_Owner_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.W_Craft_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.W_Craft_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Watercraft_Owner_Filtered := MODULE(E_Watercraft_Owner(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
      KEL.typ.bool __Link7 := FALSE;
      KEL.typ.bool __Link8 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_1.__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_1.__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_1.__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Watercraft_Owner_Filtered_1.__PostFilter,__EEQP(LEFT.W_Craft_,RIGHT.W_Craft_) AND __EEQP(LEFT.Owner_,RIGHT.Owner_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.W_Craft_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Zip_Code_Filtered := MODULE(E_Zip_Code(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Z_I_P5_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Z_I_P5_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Zip_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Zip_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PZipCodeUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Address_Inquiry_Filtered := E_Address_Inquiry_Filtered_1;
  SHARED E_Address_Phone_Filtered := E_Address_Phone_Filtered_1;
  SHARED E_Address_Property_Filtered := E_Address_Property_Filtered_1;
  SHARED E_Business_Sele_Filtered := E_Business_Sele_Filtered_1;
  SHARED E_Criminal_Details_Filtered := E_Criminal_Details_Filtered_1;
  SHARED E_Email_Inquiry_Filtered := E_Email_Inquiry_Filtered_1;
  SHARED E_First_Degree_Relative_Filtered := MODULE(E_First_Degree_Relative(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_House_Hold_Phone_Filtered := E_House_Hold_Phone_Filtered_1;
  SHARED E_Household_Member_Filtered := E_Household_Member_Filtered_1;
  SHARED E_Input_B_I_I_Input_P_I_I_Filtered := MODULE(E_Input_B_I_I_Input_P_I_I(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Accident_Filtered := E_Person_Accident_Filtered_1;
  SHARED E_Person_Address_Filtered := E_Person_Address_Filtered_2;
  SHARED E_Person_Bankruptcy_Filtered := E_Person_Bankruptcy_Filtered_1;
  SHARED E_Person_Drivers_License_Filtered := E_Person_Drivers_License_Filtered_1;
  SHARED E_Person_Education_Filtered := E_Person_Education_Filtered_1;
  SHARED E_Person_Inquiry_Filtered := E_Person_Inquiry_Filtered_1;
  SHARED E_Person_Lien_Judgment_Filtered := E_Person_Lien_Judgment_Filtered_1;
  SHARED E_Person_Offender_Filtered := E_Person_Offender_Filtered_1;
  SHARED E_Person_Offenses_Filtered := E_Person_Offenses_Filtered_1;
  SHARED E_Person_Phone_Filtered := E_Person_Phone_Filtered_1;
  SHARED E_Person_Property_Filtered := E_Person_Property_Filtered_2;
  SHARED E_Person_Property_Event_Filtered := E_Person_Property_Event_Filtered_1;
  SHARED E_Person_Sex_Offender_Filtered := E_Person_Sex_Offender_Filtered_1;
  SHARED E_Phone_Inquiry_Filtered := E_Phone_Inquiry_Filtered_1;
  SHARED E_Professional_License_Person_Filtered := E_Professional_License_Person_Filtered_1;
  SHARED E_Prox_Email_Filtered := E_Prox_Email_Filtered_1;
  SHARED E_Prox_Person_Filtered := E_Prox_Person_Filtered_1;
  SHARED E_Prox_Utility_Filtered := E_Prox_Utility_Filtered_1;
  SHARED E_S_S_N_Address_Filtered := E_S_S_N_Address_Filtered_2;
  SHARED E_S_S_N_Inquiry_Filtered := E_S_S_N_Inquiry_Filtered_1;
  SHARED E_Second_Degree_Associations_Filtered := MODULE(E_Second_Degree_Associations(__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Address_Filtered := E_Sele_Address_Filtered_2;
  SHARED E_Sele_Bankruptcy_Filtered := E_Sele_Bankruptcy_Filtered_1;
  SHARED E_Sele_E_B_R_Tradeline_Filtered := E_Sele_E_B_R_Tradeline_Filtered_1;
  SHARED E_Sele_Email_Filtered := E_Sele_Email_Filtered_1;
  SHARED E_Sele_Inquiry_Filtered := E_Sele_Inquiry_Filtered_1;
  SHARED E_Sele_Lien_Judgment_Filtered := E_Sele_Lien_Judgment_Filtered_1;
  SHARED E_Sele_Property_Filtered := E_Sele_Property_Filtered_1;
  SHARED E_Sele_Property_Event_Filtered := E_Sele_Property_Event_Filtered_1;
  SHARED E_Sele_Tradeline_Filtered := E_Sele_Tradeline_Filtered_1;
  SHARED E_Sele_U_C_C_Filtered := E_Sele_U_C_C_Filtered_1;
  SHARED E_Sele_Utility_Filtered := E_Sele_Utility_Filtered_1;
  SHARED E_Sele_Vehicle_Filtered := E_Sele_Vehicle_Filtered_1;
  SHARED E_T_I_N_Address_Filtered := E_T_I_N_Address_Filtered_1;
  SHARED E_T_I_N_Inquiry_Filtered := E_T_I_N_Inquiry_Filtered_1;
  SHARED E_T_I_N_Phone_Number_Filtered := E_T_I_N_Phone_Number_Filtered_1;
  SHARED E_Utility_Address_Filtered := E_Utility_Address_Filtered_1;
  SHARED E_Zip_Code_Person_Filtered := E_Zip_Code_Person_Filtered_1;
  SHARED B_Lien_Judgment_13_Local := MODULE(B_Lien_Judgment_13(__cfg_Local))
    SHARED TYPEOF(E_Lien_Judgment(__cfg_Local).__Result) __E_Lien_Judgment := E_Lien_Judgment_Filtered.__Result;
  END;
  SHARED B_U_C_C_13_Local := MODULE(B_U_C_C_13(__cfg_Local))
    SHARED TYPEOF(E_U_C_C(__cfg_Local).__Result) __E_U_C_C := E_U_C_C_Filtered.__Result;
  END;
  SHARED B_Lien_Judgment_12_Local := MODULE(B_Lien_Judgment_12(__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_13(__cfg_Local).__ENH_Lien_Judgment_13) __ENH_Lien_Judgment_13 := B_Lien_Judgment_13_Local.__ENH_Lien_Judgment_13;
  END;
  SHARED B_Person_Lien_Judgment_12_Local := MODULE(B_Person_Lien_Judgment_12(__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_13(__cfg_Local).__ENH_Lien_Judgment_13) __ENH_Lien_Judgment_13 := B_Lien_Judgment_13_Local.__ENH_Lien_Judgment_13;
    SHARED TYPEOF(E_Person_Lien_Judgment(__cfg_Local).__Result) __E_Person_Lien_Judgment := E_Person_Lien_Judgment_Filtered.__Result;
  END;
  SHARED B_U_C_C_12_Local := MODULE(B_U_C_C_12(__cfg_Local))
    SHARED TYPEOF(B_U_C_C_13(__cfg_Local).__ENH_U_C_C_13) __ENH_U_C_C_13 := B_U_C_C_13_Local.__ENH_U_C_C_13;
  END;
  SHARED B_Inquiry_11_Local := MODULE(B_Inquiry_11(__cfg_Local))
    SHARED TYPEOF(E_Inquiry(__cfg_Local).__Result) __E_Inquiry := E_Inquiry_Filtered.__Result;
  END;
  SHARED B_Lien_Judgment_11_Local := MODULE(B_Lien_Judgment_11(__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_12(__cfg_Local).__ENH_Lien_Judgment_12) __ENH_Lien_Judgment_12 := B_Lien_Judgment_12_Local.__ENH_Lien_Judgment_12;
  END;
  SHARED B_Person_11_Local := MODULE(B_Person_11(__cfg_Local))
    SHARED TYPEOF(E_Person(__cfg_Local).__Result) __E_Person := E_Person_Filtered.__Result;
    SHARED TYPEOF(B_Person_Lien_Judgment_12(__cfg_Local).__ENH_Person_Lien_Judgment_12) __ENH_Person_Lien_Judgment_12 := B_Person_Lien_Judgment_12_Local.__ENH_Person_Lien_Judgment_12;
  END;
  SHARED B_Sele_Lien_Judgment_11_Local := MODULE(B_Sele_Lien_Judgment_11(__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_12(__cfg_Local).__ENH_Lien_Judgment_12) __ENH_Lien_Judgment_12 := B_Lien_Judgment_12_Local.__ENH_Lien_Judgment_12;
    SHARED TYPEOF(E_Sele_Lien_Judgment(__cfg_Local).__Result) __E_Sele_Lien_Judgment := E_Sele_Lien_Judgment_Filtered.__Result;
  END;
  SHARED B_U_C_C_11_Local := MODULE(B_U_C_C_11(__cfg_Local))
    SHARED TYPEOF(B_U_C_C_12(__cfg_Local).__ENH_U_C_C_12) __ENH_U_C_C_12 := B_U_C_C_12_Local.__ENH_U_C_C_12;
  END;
  SHARED B_Business_Sele_10_Local := MODULE(B_Business_Sele_10(__cfg_Local))
    SHARED TYPEOF(E_Business_Sele(__cfg_Local).__Result) __E_Business_Sele := E_Business_Sele_Filtered.__Result;
    SHARED TYPEOF(E_Input_B_I_I(__cfg_Local).__Result) __E_Input_B_I_I := E_Input_B_I_I_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Lien_Judgment_11(__cfg_Local).__ENH_Sele_Lien_Judgment_11) __ENH_Sele_Lien_Judgment_11 := B_Sele_Lien_Judgment_11_Local.__ENH_Sele_Lien_Judgment_11;
  END;
  SHARED B_Input_B_I_I_10_Local := MODULE(B_Input_B_I_I_10(__cfg_Local))
    SHARED TYPEOF(E_Input_B_I_I(__cfg_Local).__Result) __E_Input_B_I_I := E_Input_B_I_I_Filtered.__Result;
  END;
  SHARED B_Inquiry_10_Local := MODULE(B_Inquiry_10(__cfg_Local))
    SHARED TYPEOF(B_Inquiry_11(__cfg_Local).__ENH_Inquiry_11) __ENH_Inquiry_11 := B_Inquiry_11_Local.__ENH_Inquiry_11;
  END;
  SHARED B_Lien_Judgment_10_Local := MODULE(B_Lien_Judgment_10(__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_11(__cfg_Local).__ENH_Lien_Judgment_11) __ENH_Lien_Judgment_11 := B_Lien_Judgment_11_Local.__ENH_Lien_Judgment_11;
  END;
  SHARED B_Person_10_Local := MODULE(B_Person_10(__cfg_Local))
    SHARED TYPEOF(B_Person_11(__cfg_Local).__ENH_Person_11) __ENH_Person_11 := B_Person_11_Local.__ENH_Person_11;
    SHARED TYPEOF(E_Person_Address(__cfg_Local).__Result) __E_Person_Address := E_Person_Address_Filtered.__Result;
  END;
  SHARED B_Tradeline_10_Local := MODULE(B_Tradeline_10(__cfg_Local))
    SHARED TYPEOF(E_Tradeline(__cfg_Local).__Result) __E_Tradeline := E_Tradeline_Filtered.__Result;
  END;
  SHARED B_U_C_C_10_Local := MODULE(B_U_C_C_10(__cfg_Local))
    SHARED TYPEOF(B_U_C_C_11(__cfg_Local).__ENH_U_C_C_11) __ENH_U_C_C_11 := B_U_C_C_11_Local.__ENH_U_C_C_11;
  END;
  SHARED B_Business_Sele_9_Local := MODULE(B_Business_Sele_9(__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_10(__cfg_Local).__ENH_Business_Sele_10) __ENH_Business_Sele_10 := B_Business_Sele_10_Local.__ENH_Business_Sele_10;
    SHARED TYPEOF(B_Input_B_I_I_10(__cfg_Local).__ENH_Input_B_I_I_10) __ENH_Input_B_I_I_10 := B_Input_B_I_I_10_Local.__ENH_Input_B_I_I_10;
  END;
  SHARED B_Input_B_I_I_9_Local := MODULE(B_Input_B_I_I_9(__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_10(__cfg_Local).__ENH_Input_B_I_I_10) __ENH_Input_B_I_I_10 := B_Input_B_I_I_10_Local.__ENH_Input_B_I_I_10;
  END;
  SHARED B_Input_P_I_I_9_Local := MODULE(B_Input_P_I_I_9(__cfg_Local))
    SHARED TYPEOF(E_Input_P_I_I(__cfg_Local).__Result) __E_Input_P_I_I := E_Input_P_I_I_Filtered.__Result;
  END;
  SHARED B_Inquiry_9_Local := MODULE(B_Inquiry_9(__cfg_Local))
    SHARED TYPEOF(B_Inquiry_10(__cfg_Local).__ENH_Inquiry_10) __ENH_Inquiry_10 := B_Inquiry_10_Local.__ENH_Inquiry_10;
  END;
  SHARED B_Lien_Judgment_9_Local := MODULE(B_Lien_Judgment_9(__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_10(__cfg_Local).__ENH_Lien_Judgment_10) __ENH_Lien_Judgment_10 := B_Lien_Judgment_10_Local.__ENH_Lien_Judgment_10;
  END;
  SHARED B_Person_9_Local := MODULE(B_Person_9(__cfg_Local))
    SHARED TYPEOF(E_Input_P_I_I(__cfg_Local).__Result) __E_Input_P_I_I := E_Input_P_I_I_Filtered.__Result;
    SHARED TYPEOF(B_Person_10(__cfg_Local).__ENH_Person_10) __ENH_Person_10 := B_Person_10_Local.__ENH_Person_10;
  END;
  SHARED B_Sele_U_C_C_9_Local := MODULE(B_Sele_U_C_C_9(__cfg_Local))
    SHARED TYPEOF(E_Sele_U_C_C(__cfg_Local).__Result) __E_Sele_U_C_C := E_Sele_U_C_C_Filtered.__Result;
  END;
  SHARED B_Tradeline_9_Local := MODULE(B_Tradeline_9(__cfg_Local))
    SHARED TYPEOF(B_Tradeline_10(__cfg_Local).__ENH_Tradeline_10) __ENH_Tradeline_10 := B_Tradeline_10_Local.__ENH_Tradeline_10;
  END;
  SHARED B_U_C_C_9_Local := MODULE(B_U_C_C_9(__cfg_Local))
    SHARED TYPEOF(B_U_C_C_10(__cfg_Local).__ENH_U_C_C_10) __ENH_U_C_C_10 := B_U_C_C_10_Local.__ENH_U_C_C_10;
  END;
  SHARED B_Bankruptcy_8_Local := MODULE(B_Bankruptcy_8(__cfg_Local))
    SHARED TYPEOF(E_Bankruptcy(__cfg_Local).__Result) __E_Bankruptcy := E_Bankruptcy_Filtered.__Result;
  END;
  SHARED B_Business_Sele_8_Local := MODULE(B_Business_Sele_8(__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_9(__cfg_Local).__ENH_Business_Sele_9) __ENH_Business_Sele_9 := B_Business_Sele_9_Local.__ENH_Business_Sele_9;
    SHARED TYPEOF(E_Sele_Address(__cfg_Local).__Result) __E_Sele_Address := E_Sele_Address_Filtered.__Result;
  END;
  SHARED B_Input_B_I_I_8_Local := MODULE(B_Input_B_I_I_8(__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_9(__cfg_Local).__ENH_Input_B_I_I_9) __ENH_Input_B_I_I_9 := B_Input_B_I_I_9_Local.__ENH_Input_B_I_I_9;
  END;
  SHARED B_Input_P_I_I_8_Local := MODULE(B_Input_P_I_I_8(__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_9(__cfg_Local).__ENH_Input_P_I_I_9) __ENH_Input_P_I_I_9 := B_Input_P_I_I_9_Local.__ENH_Input_P_I_I_9;
  END;
  SHARED B_Inquiry_8_Local := MODULE(B_Inquiry_8(__cfg_Local))
    SHARED TYPEOF(B_Inquiry_9(__cfg_Local).__ENH_Inquiry_9) __ENH_Inquiry_9 := B_Inquiry_9_Local.__ENH_Inquiry_9;
  END;
  SHARED B_Lien_Judgment_8_Local := MODULE(B_Lien_Judgment_8(__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_9(__cfg_Local).__ENH_Lien_Judgment_9) __ENH_Lien_Judgment_9 := B_Lien_Judgment_9_Local.__ENH_Lien_Judgment_9;
  END;
  SHARED B_Person_8_Local := MODULE(B_Person_8(__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_9(__cfg_Local).__ENH_Input_P_I_I_9) __ENH_Input_P_I_I_9 := B_Input_P_I_I_9_Local.__ENH_Input_P_I_I_9;
    SHARED TYPEOF(B_Person_9(__cfg_Local).__ENH_Person_9) __ENH_Person_9 := B_Person_9_Local.__ENH_Person_9;
  END;
  SHARED B_Person_Accident_8_Local := MODULE(B_Person_Accident_8(__cfg_Local))
    SHARED TYPEOF(E_Accident(__cfg_Local).__Result) __E_Accident := E_Accident_Filtered.__Result;
    SHARED TYPEOF(E_Person_Accident(__cfg_Local).__Result) __E_Person_Accident := E_Person_Accident_Filtered.__Result;
  END;
  SHARED B_Person_Inquiry_8_Local := MODULE(B_Person_Inquiry_8(__cfg_Local))
    SHARED TYPEOF(B_Inquiry_9(__cfg_Local).__ENH_Inquiry_9) __ENH_Inquiry_9 := B_Inquiry_9_Local.__ENH_Inquiry_9;
    SHARED TYPEOF(E_Person_Inquiry(__cfg_Local).__Result) __E_Person_Inquiry := E_Person_Inquiry_Filtered.__Result;
  END;
  SHARED B_Person_Property_8_Local := MODULE(B_Person_Property_8(__cfg_Local))
    SHARED TYPEOF(E_Person_Property(__cfg_Local).__Result) __E_Person_Property := E_Person_Property_Filtered.__Result;
    SHARED TYPEOF(E_Person_Property_Event(__cfg_Local).__Result) __E_Person_Property_Event := E_Person_Property_Event_Filtered.__Result;
    SHARED TYPEOF(E_Property_Event(__cfg_Local).__Result) __E_Property_Event := E_Property_Event_Filtered.__Result;
  END;
  SHARED B_Property_Event_8_Local := MODULE(B_Property_Event_8(__cfg_Local))
    SHARED TYPEOF(E_Property_Event(__cfg_Local).__Result) __E_Property_Event := E_Property_Event_Filtered.__Result;
  END;
  SHARED B_Sele_U_C_C_8_Local := MODULE(B_Sele_U_C_C_8(__cfg_Local))
    SHARED TYPEOF(B_Sele_U_C_C_9(__cfg_Local).__ENH_Sele_U_C_C_9) __ENH_Sele_U_C_C_9 := B_Sele_U_C_C_9_Local.__ENH_Sele_U_C_C_9;
    SHARED TYPEOF(B_U_C_C_9(__cfg_Local).__ENH_U_C_C_9) __ENH_U_C_C_9 := B_U_C_C_9_Local.__ENH_U_C_C_9;
  END;
  SHARED B_Tradeline_8_Local := MODULE(B_Tradeline_8(__cfg_Local))
    SHARED TYPEOF(B_Tradeline_9(__cfg_Local).__ENH_Tradeline_9) __ENH_Tradeline_9 := B_Tradeline_9_Local.__ENH_Tradeline_9;
  END;
  SHARED B_U_C_C_8_Local := MODULE(B_U_C_C_8(__cfg_Local))
    SHARED TYPEOF(B_U_C_C_9(__cfg_Local).__ENH_U_C_C_9) __ENH_U_C_C_9 := B_U_C_C_9_Local.__ENH_U_C_C_9;
  END;
  SHARED B_Bankruptcy_7_Local := MODULE(B_Bankruptcy_7(__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_8(__cfg_Local).__ENH_Bankruptcy_8) __ENH_Bankruptcy_8 := B_Bankruptcy_8_Local.__ENH_Bankruptcy_8;
  END;
  SHARED B_Business_Sele_7_Local := MODULE(B_Business_Sele_7(__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_8(__cfg_Local).__ENH_Business_Sele_8) __ENH_Business_Sele_8 := B_Business_Sele_8_Local.__ENH_Business_Sele_8;
    SHARED TYPEOF(B_Input_B_I_I_8(__cfg_Local).__ENH_Input_B_I_I_8) __ENH_Input_B_I_I_8 := B_Input_B_I_I_8_Local.__ENH_Input_B_I_I_8;
  END;
  SHARED B_Education_7_Local := MODULE(B_Education_7(__cfg_Local))
    SHARED TYPEOF(E_Education(__cfg_Local).__Result) __E_Education := E_Education_Filtered.__Result;
  END;
  SHARED B_Input_B_I_I_7_Local := MODULE(B_Input_B_I_I_7(__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_8(__cfg_Local).__ENH_Input_B_I_I_8) __ENH_Input_B_I_I_8 := B_Input_B_I_I_8_Local.__ENH_Input_B_I_I_8;
  END;
  SHARED B_Input_P_I_I_7_Local := MODULE(B_Input_P_I_I_7(__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_8(__cfg_Local).__ENH_Input_P_I_I_8) __ENH_Input_P_I_I_8 := B_Input_P_I_I_8_Local.__ENH_Input_P_I_I_8;
  END;
  SHARED B_Inquiry_7_Local := MODULE(B_Inquiry_7(__cfg_Local))
    SHARED TYPEOF(B_Inquiry_8(__cfg_Local).__ENH_Inquiry_8) __ENH_Inquiry_8 := B_Inquiry_8_Local.__ENH_Inquiry_8;
  END;
  SHARED B_Lien_Judgment_7_Local := MODULE(B_Lien_Judgment_7(__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_8(__cfg_Local).__ENH_Lien_Judgment_8) __ENH_Lien_Judgment_8 := B_Lien_Judgment_8_Local.__ENH_Lien_Judgment_8;
  END;
  SHARED B_Person_7_Local := MODULE(B_Person_7(__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_8(__cfg_Local).__ENH_Input_P_I_I_8) __ENH_Input_P_I_I_8 := B_Input_P_I_I_8_Local.__ENH_Input_P_I_I_8;
    SHARED TYPEOF(B_Person_8(__cfg_Local).__ENH_Person_8) __ENH_Person_8 := B_Person_8_Local.__ENH_Person_8;
    SHARED TYPEOF(B_Person_Accident_8(__cfg_Local).__ENH_Person_Accident_8) __ENH_Person_Accident_8 := B_Person_Accident_8_Local.__ENH_Person_Accident_8;
  END;
  SHARED B_Person_Inquiry_7_Local := MODULE(B_Person_Inquiry_7(__cfg_Local))
    SHARED TYPEOF(B_Person_Inquiry_8(__cfg_Local).__ENH_Person_Inquiry_8) __ENH_Person_Inquiry_8 := B_Person_Inquiry_8_Local.__ENH_Person_Inquiry_8;
  END;
  SHARED B_Person_Property_7_Local := MODULE(B_Person_Property_7(__cfg_Local))
    SHARED TYPEOF(B_Person_Property_8(__cfg_Local).__ENH_Person_Property_8) __ENH_Person_Property_8 := B_Person_Property_8_Local.__ENH_Person_Property_8;
    SHARED TYPEOF(E_Person_Property_Event(__cfg_Local).__Result) __E_Person_Property_Event := E_Person_Property_Event_Filtered.__Result;
    SHARED TYPEOF(B_Property_Event_8(__cfg_Local).__ENH_Property_Event_8) __ENH_Property_Event_8 := B_Property_Event_8_Local.__ENH_Property_Event_8;
  END;
  SHARED B_Property_Event_7_Local := MODULE(B_Property_Event_7(__cfg_Local))
    SHARED TYPEOF(B_Property_Event_8(__cfg_Local).__ENH_Property_Event_8) __ENH_Property_Event_8 := B_Property_Event_8_Local.__ENH_Property_Event_8;
  END;
  SHARED B_Sele_Person_7_Local := MODULE(B_Sele_Person_7(__cfg_Local))
    SHARED TYPEOF(E_Sele_Person(__cfg_Local).__Result) __E_Sele_Person := E_Sele_Person_Filtered.__Result;
  END;
  SHARED B_Sele_U_C_C_7_Local := MODULE(B_Sele_U_C_C_7(__cfg_Local))
    SHARED TYPEOF(B_Sele_U_C_C_8(__cfg_Local).__ENH_Sele_U_C_C_8) __ENH_Sele_U_C_C_8 := B_Sele_U_C_C_8_Local.__ENH_Sele_U_C_C_8;
  END;
  SHARED B_Tradeline_7_Local := MODULE(B_Tradeline_7(__cfg_Local))
    SHARED TYPEOF(B_Tradeline_8(__cfg_Local).__ENH_Tradeline_8) __ENH_Tradeline_8 := B_Tradeline_8_Local.__ENH_Tradeline_8;
  END;
  SHARED B_U_C_C_7_Local := MODULE(B_U_C_C_7(__cfg_Local))
    SHARED TYPEOF(B_U_C_C_8(__cfg_Local).__ENH_U_C_C_8) __ENH_U_C_C_8 := B_U_C_C_8_Local.__ENH_U_C_C_8;
  END;
  SHARED B_Address_6_Local := MODULE(B_Address_6(__cfg_Local))
    SHARED TYPEOF(E_Address(__cfg_Local).__Result) __E_Address := E_Address_Filtered.__Result;
  END;
  SHARED B_Bankruptcy_6_Local := MODULE(B_Bankruptcy_6(__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_7(__cfg_Local).__ENH_Bankruptcy_7) __ENH_Bankruptcy_7 := B_Bankruptcy_7_Local.__ENH_Bankruptcy_7;
  END;
  SHARED B_Business_Sele_6_Local := MODULE(B_Business_Sele_6(__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_7(__cfg_Local).__ENH_Business_Sele_7) __ENH_Business_Sele_7 := B_Business_Sele_7_Local.__ENH_Business_Sele_7;
    SHARED TYPEOF(E_Sele_Address(__cfg_Local).__Result) __E_Sele_Address := E_Sele_Address_Filtered.__Result;
    SHARED TYPEOF(E_Sele_Tradeline(__cfg_Local).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered.__Result;
    SHARED TYPEOF(B_Tradeline_7(__cfg_Local).__ENH_Tradeline_7) __ENH_Tradeline_7 := B_Tradeline_7_Local.__ENH_Tradeline_7;
  END;
  SHARED B_Business_Sele_Overflow_6_Local := MODULE(B_Business_Sele_Overflow_6(__cfg_Local))
    SHARED TYPEOF(E_Business_Sele_Overflow(__cfg_Local).__Result) __E_Business_Sele_Overflow := E_Business_Sele_Overflow_Filtered.__Result;
  END;
  SHARED B_Education_6_Local := MODULE(B_Education_6(__cfg_Local))
    SHARED TYPEOF(B_Education_7(__cfg_Local).__ENH_Education_7) __ENH_Education_7 := B_Education_7_Local.__ENH_Education_7;
  END;
  SHARED B_Input_B_I_I_6_Local := MODULE(B_Input_B_I_I_6(__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_7(__cfg_Local).__ENH_Input_B_I_I_7) __ENH_Input_B_I_I_7 := B_Input_B_I_I_7_Local.__ENH_Input_B_I_I_7;
  END;
  SHARED B_Input_P_I_I_6_Local := MODULE(B_Input_P_I_I_6(__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_7(__cfg_Local).__ENH_Input_P_I_I_7) __ENH_Input_P_I_I_7 := B_Input_P_I_I_7_Local.__ENH_Input_P_I_I_7;
  END;
  SHARED B_Inquiry_6_Local := MODULE(B_Inquiry_6(__cfg_Local))
    SHARED TYPEOF(B_Inquiry_7(__cfg_Local).__ENH_Inquiry_7) __ENH_Inquiry_7 := B_Inquiry_7_Local.__ENH_Inquiry_7;
  END;
  SHARED B_Lien_Judgment_6_Local := MODULE(B_Lien_Judgment_6(__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_7(__cfg_Local).__ENH_Lien_Judgment_7) __ENH_Lien_Judgment_7 := B_Lien_Judgment_7_Local.__ENH_Lien_Judgment_7;
  END;
  SHARED B_Person_6_Local := MODULE(B_Person_6(__cfg_Local))
    SHARED TYPEOF(E_Accident(__cfg_Local).__Result) __E_Accident := E_Accident_Filtered.__Result;
    SHARED TYPEOF(B_Education_7(__cfg_Local).__ENH_Education_7) __ENH_Education_7 := B_Education_7_Local.__ENH_Education_7;
    SHARED TYPEOF(B_Person_7(__cfg_Local).__ENH_Person_7) __ENH_Person_7 := B_Person_7_Local.__ENH_Person_7;
    SHARED TYPEOF(E_Person_Education(__cfg_Local).__Result) __E_Person_Education := E_Person_Education_Filtered.__Result;
  END;
  SHARED B_Person_Inquiry_6_Local := MODULE(B_Person_Inquiry_6(__cfg_Local))
    SHARED TYPEOF(B_Person_Inquiry_7(__cfg_Local).__ENH_Person_Inquiry_7) __ENH_Person_Inquiry_7 := B_Person_Inquiry_7_Local.__ENH_Person_Inquiry_7;
  END;
  SHARED B_Person_Property_6_Local := MODULE(B_Person_Property_6(__cfg_Local))
    SHARED TYPEOF(B_Person_Property_7(__cfg_Local).__ENH_Person_Property_7) __ENH_Person_Property_7 := B_Person_Property_7_Local.__ENH_Person_Property_7;
    SHARED TYPEOF(E_Person_Property_Event(__cfg_Local).__Result) __E_Person_Property_Event := E_Person_Property_Event_Filtered.__Result;
    SHARED TYPEOF(E_Property(__cfg_Local).__Result) __E_Property := E_Property_Filtered.__Result;
    SHARED TYPEOF(B_Property_Event_7(__cfg_Local).__ENH_Property_Event_7) __ENH_Property_Event_7 := B_Property_Event_7_Local.__ENH_Property_Event_7;
  END;
  SHARED B_Person_S_S_N_6_Local := MODULE(B_Person_S_S_N_6(__cfg_Local))
    SHARED TYPEOF(B_Person_7(__cfg_Local).__ENH_Person_7) __ENH_Person_7 := B_Person_7_Local.__ENH_Person_7;
    SHARED TYPEOF(E_Person_S_S_N(__cfg_Local).__Result) __E_Person_S_S_N := E_Person_S_S_N_Filtered.__Result;
  END;
  SHARED B_Property_Event_6_Local := MODULE(B_Property_Event_6(__cfg_Local))
    SHARED TYPEOF(B_Property_Event_7(__cfg_Local).__ENH_Property_Event_7) __ENH_Property_Event_7 := B_Property_Event_7_Local.__ENH_Property_Event_7;
  END;
  SHARED B_Sele_Address_6_Local := MODULE(B_Sele_Address_6(__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_7(__cfg_Local).__ENH_Business_Sele_7) __ENH_Business_Sele_7 := B_Business_Sele_7_Local.__ENH_Business_Sele_7;
    SHARED TYPEOF(E_Sele_Address(__cfg_Local).__Result) __E_Sele_Address := E_Sele_Address_Filtered.__Result;
  END;
  SHARED B_Sele_Person_6_Local := MODULE(B_Sele_Person_6(__cfg_Local))
    SHARED TYPEOF(B_Sele_Person_7(__cfg_Local).__ENH_Sele_Person_7) __ENH_Sele_Person_7 := B_Sele_Person_7_Local.__ENH_Sele_Person_7;
  END;
  SHARED B_Sele_Phone_Number_6_Local := MODULE(B_Sele_Phone_Number_6(__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_7(__cfg_Local).__ENH_Business_Sele_7) __ENH_Business_Sele_7 := B_Business_Sele_7_Local.__ENH_Business_Sele_7;
    SHARED TYPEOF(E_Sele_Phone_Number(__cfg_Local).__Result) __E_Sele_Phone_Number := E_Sele_Phone_Number_Filtered.__Result;
  END;
  SHARED B_Sele_T_I_N_6_Local := MODULE(B_Sele_T_I_N_6(__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_7(__cfg_Local).__ENH_Business_Sele_7) __ENH_Business_Sele_7 := B_Business_Sele_7_Local.__ENH_Business_Sele_7;
    SHARED TYPEOF(E_Sele_T_I_N(__cfg_Local).__Result) __E_Sele_T_I_N := E_Sele_T_I_N_Filtered.__Result;
  END;
  SHARED B_Sele_U_C_C_6_Local := MODULE(B_Sele_U_C_C_6(__cfg_Local))
    SHARED TYPEOF(B_Sele_U_C_C_7(__cfg_Local).__ENH_Sele_U_C_C_7) __ENH_Sele_U_C_C_7 := B_Sele_U_C_C_7_Local.__ENH_Sele_U_C_C_7;
  END;
  SHARED B_Tradeline_6_Local := MODULE(B_Tradeline_6(__cfg_Local))
    SHARED TYPEOF(B_Tradeline_7(__cfg_Local).__ENH_Tradeline_7) __ENH_Tradeline_7 := B_Tradeline_7_Local.__ENH_Tradeline_7;
  END;
  SHARED B_U_C_C_6_Local := MODULE(B_U_C_C_6(__cfg_Local))
    SHARED TYPEOF(B_U_C_C_7(__cfg_Local).__ENH_U_C_C_7) __ENH_U_C_C_7 := B_U_C_C_7_Local.__ENH_U_C_C_7;
  END;
  SHARED B_Address_5_Local := MODULE(B_Address_5(__cfg_Local))
    SHARED TYPEOF(B_Address_6(__cfg_Local).__ENH_Address_6) __ENH_Address_6 := B_Address_6_Local.__ENH_Address_6;
  END;
  SHARED B_Bankruptcy_5_Local := MODULE(B_Bankruptcy_5(__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_6(__cfg_Local).__ENH_Bankruptcy_6) __ENH_Bankruptcy_6 := B_Bankruptcy_6_Local.__ENH_Bankruptcy_6;
  END;
  SHARED B_Business_Sele_5_Local := MODULE(B_Business_Sele_5(__cfg_Local))
    SHARED TYPEOF(B_Address_6(__cfg_Local).__ENH_Address_6) __ENH_Address_6 := B_Address_6_Local.__ENH_Address_6;
    SHARED TYPEOF(B_Business_Sele_6(__cfg_Local).__ENH_Business_Sele_6) __ENH_Business_Sele_6 := B_Business_Sele_6_Local.__ENH_Business_Sele_6;
    SHARED TYPEOF(B_Sele_Address_6(__cfg_Local).__ENH_Sele_Address_6) __ENH_Sele_Address_6 := B_Sele_Address_6_Local.__ENH_Sele_Address_6;
    SHARED TYPEOF(B_Sele_Phone_Number_6(__cfg_Local).__ENH_Sele_Phone_Number_6) __ENH_Sele_Phone_Number_6 := B_Sele_Phone_Number_6_Local.__ENH_Sele_Phone_Number_6;
    SHARED TYPEOF(B_Sele_T_I_N_6(__cfg_Local).__ENH_Sele_T_I_N_6) __ENH_Sele_T_I_N_6 := B_Sele_T_I_N_6_Local.__ENH_Sele_T_I_N_6;
    SHARED TYPEOF(B_Sele_U_C_C_6(__cfg_Local).__ENH_Sele_U_C_C_6) __ENH_Sele_U_C_C_6 := B_Sele_U_C_C_6_Local.__ENH_Sele_U_C_C_6;
    SHARED TYPEOF(B_U_C_C_6(__cfg_Local).__ENH_U_C_C_6) __ENH_U_C_C_6 := B_U_C_C_6_Local.__ENH_U_C_C_6;
  END;
  SHARED B_Business_Sele_Overflow_5_Local := MODULE(B_Business_Sele_Overflow_5(__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_Overflow_6(__cfg_Local).__ENH_Business_Sele_Overflow_6) __ENH_Business_Sele_Overflow_6 := B_Business_Sele_Overflow_6_Local.__ENH_Business_Sele_Overflow_6;
  END;
  SHARED B_Criminal_Offense_5_Local := MODULE(B_Criminal_Offense_5(__cfg_Local))
    SHARED TYPEOF(E_Criminal_Offense(__cfg_Local).__Result) __E_Criminal_Offense := E_Criminal_Offense_Filtered.__Result;
  END;
  SHARED B_Education_5_Local := MODULE(B_Education_5(__cfg_Local))
    SHARED TYPEOF(B_Education_6(__cfg_Local).__ENH_Education_6) __ENH_Education_6 := B_Education_6_Local.__ENH_Education_6;
  END;
  SHARED B_First_Degree_Relative_5_Local := MODULE(B_First_Degree_Relative_5(__cfg_Local))
    SHARED TYPEOF(E_First_Degree_Associations(__cfg_Local).__Result) __E_First_Degree_Associations := E_First_Degree_Associations_Filtered.__Result;
  END;
  SHARED B_Input_B_I_I_5_Local := MODULE(B_Input_B_I_I_5(__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_6(__cfg_Local).__ENH_Input_B_I_I_6) __ENH_Input_B_I_I_6 := B_Input_B_I_I_6_Local.__ENH_Input_B_I_I_6;
  END;
  SHARED B_Input_P_I_I_5_Local := MODULE(B_Input_P_I_I_5(__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_6(__cfg_Local).__ENH_Input_P_I_I_6) __ENH_Input_P_I_I_6 := B_Input_P_I_I_6_Local.__ENH_Input_P_I_I_6;
  END;
  SHARED B_Inquiry_5_Local := MODULE(B_Inquiry_5(__cfg_Local))
    SHARED TYPEOF(B_Inquiry_6(__cfg_Local).__ENH_Inquiry_6) __ENH_Inquiry_6 := B_Inquiry_6_Local.__ENH_Inquiry_6;
  END;
  SHARED B_Lien_Judgment_5_Local := MODULE(B_Lien_Judgment_5(__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_6(__cfg_Local).__ENH_Lien_Judgment_6) __ENH_Lien_Judgment_6 := B_Lien_Judgment_6_Local.__ENH_Lien_Judgment_6;
  END;
  SHARED B_Person_5_Local := MODULE(B_Person_5(__cfg_Local))
    SHARED TYPEOF(B_Person_6(__cfg_Local).__ENH_Person_6) __ENH_Person_6 := B_Person_6_Local.__ENH_Person_6;
    SHARED TYPEOF(B_Person_S_S_N_6(__cfg_Local).__ENH_Person_S_S_N_6) __ENH_Person_S_S_N_6 := B_Person_S_S_N_6_Local.__ENH_Person_S_S_N_6;
  END;
  SHARED B_Person_Inquiry_5_Local := MODULE(B_Person_Inquiry_5(__cfg_Local))
    SHARED TYPEOF(B_Person_Inquiry_6(__cfg_Local).__ENH_Person_Inquiry_6) __ENH_Person_Inquiry_6 := B_Person_Inquiry_6_Local.__ENH_Person_Inquiry_6;
  END;
  SHARED B_Person_Property_5_Local := MODULE(B_Person_Property_5(__cfg_Local))
    SHARED TYPEOF(B_Person_Property_6(__cfg_Local).__ENH_Person_Property_6) __ENH_Person_Property_6 := B_Person_Property_6_Local.__ENH_Person_Property_6;
    SHARED TYPEOF(E_Person_Property_Event(__cfg_Local).__Result) __E_Person_Property_Event := E_Person_Property_Event_Filtered.__Result;
    SHARED TYPEOF(E_Property(__cfg_Local).__Result) __E_Property := E_Property_Filtered.__Result;
    SHARED TYPEOF(B_Property_Event_6(__cfg_Local).__ENH_Property_Event_6) __ENH_Property_Event_6 := B_Property_Event_6_Local.__ENH_Property_Event_6;
  END;
  SHARED B_Person_S_S_N_5_Local := MODULE(B_Person_S_S_N_5(__cfg_Local))
    SHARED TYPEOF(B_Person_S_S_N_6(__cfg_Local).__ENH_Person_S_S_N_6) __ENH_Person_S_S_N_6 := B_Person_S_S_N_6_Local.__ENH_Person_S_S_N_6;
  END;
  SHARED B_Professional_License_5_Local := MODULE(B_Professional_License_5(__cfg_Local))
    SHARED TYPEOF(E_Professional_License(__cfg_Local).__Result) __E_Professional_License := E_Professional_License_Filtered.__Result;
  END;
  SHARED B_Property_5_Local := MODULE(B_Property_5(__cfg_Local))
    SHARED TYPEOF(E_Property(__cfg_Local).__Result) __E_Property := E_Property_Filtered.__Result;
  END;
  SHARED B_Property_Event_5_Local := MODULE(B_Property_Event_5(__cfg_Local))
    SHARED TYPEOF(B_Property_Event_6(__cfg_Local).__ENH_Property_Event_6) __ENH_Property_Event_6 := B_Property_Event_6_Local.__ENH_Property_Event_6;
  END;
  SHARED B_Sele_Address_5_Local := MODULE(B_Sele_Address_5(__cfg_Local))
    SHARED TYPEOF(B_Sele_Address_6(__cfg_Local).__ENH_Sele_Address_6) __ENH_Sele_Address_6 := B_Sele_Address_6_Local.__ENH_Sele_Address_6;
  END;
  SHARED B_Sele_Person_5_Local := MODULE(B_Sele_Person_5(__cfg_Local))
    SHARED TYPEOF(B_Sele_Person_6(__cfg_Local).__ENH_Sele_Person_6) __ENH_Sele_Person_6 := B_Sele_Person_6_Local.__ENH_Sele_Person_6;
  END;
  SHARED B_Sele_Phone_Number_5_Local := MODULE(B_Sele_Phone_Number_5(__cfg_Local))
    SHARED TYPEOF(B_Sele_Phone_Number_6(__cfg_Local).__ENH_Sele_Phone_Number_6) __ENH_Sele_Phone_Number_6 := B_Sele_Phone_Number_6_Local.__ENH_Sele_Phone_Number_6;
  END;
  SHARED B_Sele_T_I_N_5_Local := MODULE(B_Sele_T_I_N_5(__cfg_Local))
    SHARED TYPEOF(B_Sele_T_I_N_6(__cfg_Local).__ENH_Sele_T_I_N_6) __ENH_Sele_T_I_N_6 := B_Sele_T_I_N_6_Local.__ENH_Sele_T_I_N_6;
  END;
  SHARED B_Sele_U_C_C_5_Local := MODULE(B_Sele_U_C_C_5(__cfg_Local))
    SHARED TYPEOF(B_Sele_U_C_C_6(__cfg_Local).__ENH_Sele_U_C_C_6) __ENH_Sele_U_C_C_6 := B_Sele_U_C_C_6_Local.__ENH_Sele_U_C_C_6;
  END;
  SHARED B_Tradeline_5_Local := MODULE(B_Tradeline_5(__cfg_Local))
    SHARED TYPEOF(B_Tradeline_6(__cfg_Local).__ENH_Tradeline_6) __ENH_Tradeline_6 := B_Tradeline_6_Local.__ENH_Tradeline_6;
  END;
  SHARED B_U_C_C_5_Local := MODULE(B_U_C_C_5(__cfg_Local))
    SHARED TYPEOF(B_U_C_C_6(__cfg_Local).__ENH_U_C_C_6) __ENH_U_C_C_6 := B_U_C_C_6_Local.__ENH_U_C_C_6;
  END;
  SHARED B_Address_4_Local := MODULE(B_Address_4(__cfg_Local))
    SHARED TYPEOF(B_Address_5(__cfg_Local).__ENH_Address_5) __ENH_Address_5 := B_Address_5_Local.__ENH_Address_5;
  END;
  SHARED B_Bankruptcy_4_Local := MODULE(B_Bankruptcy_4(__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_5(__cfg_Local).__ENH_Bankruptcy_5) __ENH_Bankruptcy_5 := B_Bankruptcy_5_Local.__ENH_Bankruptcy_5;
  END;
  SHARED B_Business_Sele_4_Local := MODULE(B_Business_Sele_4(__cfg_Local))
    SHARED TYPEOF(B_Address_5(__cfg_Local).__ENH_Address_5) __ENH_Address_5 := B_Address_5_Local.__ENH_Address_5;
    SHARED TYPEOF(B_Bankruptcy_5(__cfg_Local).__ENH_Bankruptcy_5) __ENH_Bankruptcy_5 := B_Bankruptcy_5_Local.__ENH_Bankruptcy_5;
    SHARED TYPEOF(B_Business_Sele_5(__cfg_Local).__ENH_Business_Sele_5) __ENH_Business_Sele_5 := B_Business_Sele_5_Local.__ENH_Business_Sele_5;
    SHARED TYPEOF(B_Sele_Address_5(__cfg_Local).__ENH_Sele_Address_5) __ENH_Sele_Address_5 := B_Sele_Address_5_Local.__ENH_Sele_Address_5;
    SHARED TYPEOF(E_Sele_Bankruptcy(__cfg_Local).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Person_5(__cfg_Local).__ENH_Sele_Person_5) __ENH_Sele_Person_5 := B_Sele_Person_5_Local.__ENH_Sele_Person_5;
    SHARED TYPEOF(E_Sele_Tradeline(__cfg_Local).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered.__Result;
    SHARED TYPEOF(B_Sele_U_C_C_5(__cfg_Local).__ENH_Sele_U_C_C_5) __ENH_Sele_U_C_C_5 := B_Sele_U_C_C_5_Local.__ENH_Sele_U_C_C_5;
    SHARED TYPEOF(B_Tradeline_5(__cfg_Local).__ENH_Tradeline_5) __ENH_Tradeline_5 := B_Tradeline_5_Local.__ENH_Tradeline_5;
    SHARED TYPEOF(B_U_C_C_5(__cfg_Local).__ENH_U_C_C_5) __ENH_U_C_C_5 := B_U_C_C_5_Local.__ENH_U_C_C_5;
  END;
  SHARED B_Business_Sele_Overflow_4_Local := MODULE(B_Business_Sele_Overflow_4(__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_Overflow_5(__cfg_Local).__ENH_Business_Sele_Overflow_5) __ENH_Business_Sele_Overflow_5 := B_Business_Sele_Overflow_5_Local.__ENH_Business_Sele_Overflow_5;
  END;
  SHARED B_Criminal_Offense_4_Local := MODULE(B_Criminal_Offense_4(__cfg_Local))
    SHARED TYPEOF(B_Criminal_Offense_5(__cfg_Local).__ENH_Criminal_Offense_5) __ENH_Criminal_Offense_5 := B_Criminal_Offense_5_Local.__ENH_Criminal_Offense_5;
  END;
  SHARED B_Education_4_Local := MODULE(B_Education_4(__cfg_Local))
    SHARED TYPEOF(B_Education_5(__cfg_Local).__ENH_Education_5) __ENH_Education_5 := B_Education_5_Local.__ENH_Education_5;
  END;
  SHARED B_First_Degree_Relative_4_Local := MODULE(B_First_Degree_Relative_4(__cfg_Local))
    SHARED TYPEOF(B_First_Degree_Relative_5(__cfg_Local).__ENH_First_Degree_Relative_5) __ENH_First_Degree_Relative_5 := B_First_Degree_Relative_5_Local.__ENH_First_Degree_Relative_5;
  END;
  SHARED B_Input_B_I_I_4_Local := MODULE(B_Input_B_I_I_4(__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_5(__cfg_Local).__ENH_Input_B_I_I_5) __ENH_Input_B_I_I_5 := B_Input_B_I_I_5_Local.__ENH_Input_B_I_I_5;
  END;
  SHARED B_Input_P_I_I_4_Local := MODULE(B_Input_P_I_I_4(__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_5(__cfg_Local).__ENH_Input_P_I_I_5) __ENH_Input_P_I_I_5 := B_Input_P_I_I_5_Local.__ENH_Input_P_I_I_5;
  END;
  SHARED B_Inquiry_4_Local := MODULE(B_Inquiry_4(__cfg_Local))
    SHARED TYPEOF(B_Inquiry_5(__cfg_Local).__ENH_Inquiry_5) __ENH_Inquiry_5 := B_Inquiry_5_Local.__ENH_Inquiry_5;
  END;
  SHARED B_Lien_Judgment_4_Local := MODULE(B_Lien_Judgment_4(__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_5(__cfg_Local).__ENH_Lien_Judgment_5) __ENH_Lien_Judgment_5 := B_Lien_Judgment_5_Local.__ENH_Lien_Judgment_5;
  END;
  SHARED B_Person_4_Local := MODULE(B_Person_4(__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_5(__cfg_Local).__ENH_Bankruptcy_5) __ENH_Bankruptcy_5 := B_Bankruptcy_5_Local.__ENH_Bankruptcy_5;
    SHARED TYPEOF(E_Household(__cfg_Local).__Result) __E_Household := E_Household_Filtered.__Result;
    SHARED TYPEOF(E_Household_Member(__cfg_Local).__Result) __E_Household_Member := E_Household_Member_Filtered.__Result;
    SHARED TYPEOF(B_Person_5(__cfg_Local).__ENH_Person_5) __ENH_Person_5 := B_Person_5_Local.__ENH_Person_5;
    SHARED TYPEOF(E_Person_Bankruptcy(__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(B_Person_Inquiry_5(__cfg_Local).__ENH_Person_Inquiry_5) __ENH_Person_Inquiry_5 := B_Person_Inquiry_5_Local.__ENH_Person_Inquiry_5;
    SHARED TYPEOF(B_Person_Property_5(__cfg_Local).__ENH_Person_Property_5) __ENH_Person_Property_5 := B_Person_Property_5_Local.__ENH_Person_Property_5;
    SHARED TYPEOF(E_Utility_Person(__cfg_Local).__Result) __E_Utility_Person := E_Utility_Person_Filtered.__Result;
  END;
  SHARED B_Person_Inquiry_4_Local := MODULE(B_Person_Inquiry_4(__cfg_Local))
    SHARED TYPEOF(B_Person_Inquiry_5(__cfg_Local).__ENH_Person_Inquiry_5) __ENH_Person_Inquiry_5 := B_Person_Inquiry_5_Local.__ENH_Person_Inquiry_5;
  END;
  SHARED B_Person_Property_4_Local := MODULE(B_Person_Property_4(__cfg_Local))
    SHARED TYPEOF(B_Person_Property_5(__cfg_Local).__ENH_Person_Property_5) __ENH_Person_Property_5 := B_Person_Property_5_Local.__ENH_Person_Property_5;
  END;
  SHARED B_Person_S_S_N_4_Local := MODULE(B_Person_S_S_N_4(__cfg_Local))
    SHARED TYPEOF(B_Person_S_S_N_5(__cfg_Local).__ENH_Person_S_S_N_5) __ENH_Person_S_S_N_5 := B_Person_S_S_N_5_Local.__ENH_Person_S_S_N_5;
  END;
  SHARED B_Professional_License_4_Local := MODULE(B_Professional_License_4(__cfg_Local))
    SHARED TYPEOF(B_Professional_License_5(__cfg_Local).__ENH_Professional_License_5) __ENH_Professional_License_5 := B_Professional_License_5_Local.__ENH_Professional_License_5;
  END;
  SHARED B_Property_4_Local := MODULE(B_Property_4(__cfg_Local))
    SHARED TYPEOF(B_Address_5(__cfg_Local).__ENH_Address_5) __ENH_Address_5 := B_Address_5_Local.__ENH_Address_5;
    SHARED TYPEOF(E_Address_Property(__cfg_Local).__Result) __E_Address_Property := E_Address_Property_Filtered.__Result;
    SHARED TYPEOF(B_Property_5(__cfg_Local).__ENH_Property_5) __ENH_Property_5 := B_Property_5_Local.__ENH_Property_5;
  END;
  SHARED B_Property_Event_4_Local := MODULE(B_Property_Event_4(__cfg_Local))
    SHARED TYPEOF(B_Property_Event_5(__cfg_Local).__ENH_Property_Event_5) __ENH_Property_Event_5 := B_Property_Event_5_Local.__ENH_Property_Event_5;
  END;
  SHARED B_Sele_Address_4_Local := MODULE(B_Sele_Address_4(__cfg_Local))
    SHARED TYPEOF(B_Sele_Address_5(__cfg_Local).__ENH_Sele_Address_5) __ENH_Sele_Address_5 := B_Sele_Address_5_Local.__ENH_Sele_Address_5;
  END;
  SHARED B_Sele_Person_4_Local := MODULE(B_Sele_Person_4(__cfg_Local))
    SHARED TYPEOF(B_First_Degree_Relative_5(__cfg_Local).__ENH_First_Degree_Relative_5) __ENH_First_Degree_Relative_5 := B_First_Degree_Relative_5_Local.__ENH_First_Degree_Relative_5;
    SHARED TYPEOF(B_Sele_Person_5(__cfg_Local).__ENH_Sele_Person_5) __ENH_Sele_Person_5 := B_Sele_Person_5_Local.__ENH_Sele_Person_5;
  END;
  SHARED B_Sele_Phone_Number_4_Local := MODULE(B_Sele_Phone_Number_4(__cfg_Local))
    SHARED TYPEOF(B_Sele_Phone_Number_5(__cfg_Local).__ENH_Sele_Phone_Number_5) __ENH_Sele_Phone_Number_5 := B_Sele_Phone_Number_5_Local.__ENH_Sele_Phone_Number_5;
  END;
  SHARED B_Sele_Property_4_Local := MODULE(B_Sele_Property_4(__cfg_Local))
    SHARED TYPEOF(B_Property_Event_5(__cfg_Local).__ENH_Property_Event_5) __ENH_Property_Event_5 := B_Property_Event_5_Local.__ENH_Property_Event_5;
    SHARED TYPEOF(E_Sele_Property(__cfg_Local).__Result) __E_Sele_Property := E_Sele_Property_Filtered.__Result;
    SHARED TYPEOF(E_Sele_Property_Event(__cfg_Local).__Result) __E_Sele_Property_Event := E_Sele_Property_Event_Filtered.__Result;
  END;
  SHARED B_Sele_T_I_N_4_Local := MODULE(B_Sele_T_I_N_4(__cfg_Local))
    SHARED TYPEOF(B_Sele_T_I_N_5(__cfg_Local).__ENH_Sele_T_I_N_5) __ENH_Sele_T_I_N_5 := B_Sele_T_I_N_5_Local.__ENH_Sele_T_I_N_5;
  END;
  SHARED B_Sele_U_C_C_4_Local := MODULE(B_Sele_U_C_C_4(__cfg_Local))
    SHARED TYPEOF(B_Sele_U_C_C_5(__cfg_Local).__ENH_Sele_U_C_C_5) __ENH_Sele_U_C_C_5 := B_Sele_U_C_C_5_Local.__ENH_Sele_U_C_C_5;
  END;
  SHARED B_Tradeline_4_Local := MODULE(B_Tradeline_4(__cfg_Local))
    SHARED TYPEOF(B_Tradeline_5(__cfg_Local).__ENH_Tradeline_5) __ENH_Tradeline_5 := B_Tradeline_5_Local.__ENH_Tradeline_5;
  END;
  SHARED B_U_C_C_4_Local := MODULE(B_U_C_C_4(__cfg_Local))
    SHARED TYPEOF(B_U_C_C_5(__cfg_Local).__ENH_U_C_C_5) __ENH_U_C_C_5 := B_U_C_C_5_Local.__ENH_U_C_C_5;
  END;
  SHARED B_Address_3_Local := MODULE(B_Address_3(__cfg_Local))
    SHARED TYPEOF(B_Address_4(__cfg_Local).__ENH_Address_4) __ENH_Address_4 := B_Address_4_Local.__ENH_Address_4;
  END;
  SHARED B_Aircraft_Owner_3_Local := MODULE(B_Aircraft_Owner_3(__cfg_Local))
    SHARED TYPEOF(E_Aircraft_Owner(__cfg_Local).__Result) __E_Aircraft_Owner := E_Aircraft_Owner_Filtered.__Result;
  END;
  SHARED B_Bankruptcy_3_Local := MODULE(B_Bankruptcy_3(__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_4(__cfg_Local).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4_Local.__ENH_Bankruptcy_4;
  END;
  SHARED B_Business_Prox_3_Local := MODULE(B_Business_Prox_3(__cfg_Local))
    SHARED TYPEOF(E_Business_Prox(__cfg_Local).__Result) __E_Business_Prox := E_Business_Prox_Filtered.__Result;
    SHARED TYPEOF(E_Prox_Address(__cfg_Local).__Result) __E_Prox_Address := E_Prox_Address_Filtered.__Result;
  END;
  SHARED B_Business_Sele_3_Local := MODULE(B_Business_Sele_3(__cfg_Local))
    SHARED TYPEOF(B_Address_4(__cfg_Local).__ENH_Address_4) __ENH_Address_4 := B_Address_4_Local.__ENH_Address_4;
    SHARED TYPEOF(E_Address_Property_Event(__cfg_Local).__Result) __E_Address_Property_Event := E_Address_Property_Event_Filtered.__Result;
    SHARED TYPEOF(B_Bankruptcy_4(__cfg_Local).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4_Local.__ENH_Bankruptcy_4;
    SHARED TYPEOF(B_Business_Sele_4(__cfg_Local).__ENH_Business_Sele_4) __ENH_Business_Sele_4 := B_Business_Sele_4_Local.__ENH_Business_Sele_4;
    SHARED TYPEOF(B_Business_Sele_Overflow_4(__cfg_Local).__ENH_Business_Sele_Overflow_4) __ENH_Business_Sele_Overflow_4 := B_Business_Sele_Overflow_4_Local.__ENH_Business_Sele_Overflow_4;
    SHARED TYPEOF(B_Property_Event_4(__cfg_Local).__ENH_Property_Event_4) __ENH_Property_Event_4 := B_Property_Event_4_Local.__ENH_Property_Event_4;
    SHARED TYPEOF(B_Sele_Address_4(__cfg_Local).__ENH_Sele_Address_4) __ENH_Sele_Address_4 := B_Sele_Address_4_Local.__ENH_Sele_Address_4;
    SHARED TYPEOF(E_Sele_Bankruptcy(__cfg_Local).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Person_4(__cfg_Local).__ENH_Sele_Person_4) __ENH_Sele_Person_4 := B_Sele_Person_4_Local.__ENH_Sele_Person_4;
    SHARED TYPEOF(B_Sele_Property_4(__cfg_Local).__ENH_Sele_Property_4) __ENH_Sele_Property_4 := B_Sele_Property_4_Local.__ENH_Sele_Property_4;
    SHARED TYPEOF(E_Sele_Tradeline(__cfg_Local).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered.__Result;
    SHARED TYPEOF(B_Sele_U_C_C_4(__cfg_Local).__ENH_Sele_U_C_C_4) __ENH_Sele_U_C_C_4 := B_Sele_U_C_C_4_Local.__ENH_Sele_U_C_C_4;
    SHARED TYPEOF(B_Tradeline_4(__cfg_Local).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local.__ENH_Tradeline_4;
    SHARED TYPEOF(B_U_C_C_4(__cfg_Local).__ENH_U_C_C_4) __ENH_U_C_C_4 := B_U_C_C_4_Local.__ENH_U_C_C_4;
    SHARED TYPEOF(E_Zip_Code(__cfg_Local).__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
  END;
  SHARED B_Business_Sele_Overflow_3_Local := MODULE(B_Business_Sele_Overflow_3(__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_Overflow_4(__cfg_Local).__ENH_Business_Sele_Overflow_4) __ENH_Business_Sele_Overflow_4 := B_Business_Sele_Overflow_4_Local.__ENH_Business_Sele_Overflow_4;
  END;
  SHARED B_Criminal_Offense_3_Local := MODULE(B_Criminal_Offense_3(__cfg_Local))
    SHARED TYPEOF(B_Criminal_Offense_4(__cfg_Local).__ENH_Criminal_Offense_4) __ENH_Criminal_Offense_4 := B_Criminal_Offense_4_Local.__ENH_Criminal_Offense_4;
  END;
  SHARED B_Education_3_Local := MODULE(B_Education_3(__cfg_Local))
    SHARED TYPEOF(B_Education_4(__cfg_Local).__ENH_Education_4) __ENH_Education_4 := B_Education_4_Local.__ENH_Education_4;
  END;
  SHARED B_First_Degree_Relative_3_Local := MODULE(B_First_Degree_Relative_3(__cfg_Local))
    SHARED TYPEOF(B_First_Degree_Relative_4(__cfg_Local).__ENH_First_Degree_Relative_4) __ENH_First_Degree_Relative_4 := B_First_Degree_Relative_4_Local.__ENH_First_Degree_Relative_4;
  END;
  SHARED B_Input_B_I_I_3_Local := MODULE(B_Input_B_I_I_3(__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_4(__cfg_Local).__ENH_Input_B_I_I_4) __ENH_Input_B_I_I_4 := B_Input_B_I_I_4_Local.__ENH_Input_B_I_I_4;
  END;
  SHARED B_Input_P_I_I_3_Local := MODULE(B_Input_P_I_I_3(__cfg_Local))
    SHARED TYPEOF(B_Address_4(__cfg_Local).__ENH_Address_4) __ENH_Address_4 := B_Address_4_Local.__ENH_Address_4;
    SHARED TYPEOF(E_Address_Inquiry(__cfg_Local).__Result) __E_Address_Inquiry := E_Address_Inquiry_Filtered.__Result;
    SHARED TYPEOF(B_Input_P_I_I_4(__cfg_Local).__ENH_Input_P_I_I_4) __ENH_Input_P_I_I_4 := B_Input_P_I_I_4_Local.__ENH_Input_P_I_I_4;
    SHARED TYPEOF(B_Inquiry_4(__cfg_Local).__ENH_Inquiry_4) __ENH_Inquiry_4 := B_Inquiry_4_Local.__ENH_Inquiry_4;
    SHARED TYPEOF(B_Property_4(__cfg_Local).__ENH_Property_4) __ENH_Property_4 := B_Property_4_Local.__ENH_Property_4;
  END;
  SHARED B_Inquiry_3_Local := MODULE(B_Inquiry_3(__cfg_Local))
    SHARED TYPEOF(B_Inquiry_4(__cfg_Local).__ENH_Inquiry_4) __ENH_Inquiry_4 := B_Inquiry_4_Local.__ENH_Inquiry_4;
  END;
  SHARED B_Lien_Judgment_3_Local := MODULE(B_Lien_Judgment_3(__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_4(__cfg_Local).__ENH_Lien_Judgment_4) __ENH_Lien_Judgment_4 := B_Lien_Judgment_4_Local.__ENH_Lien_Judgment_4;
  END;
  SHARED B_Person_3_Local := MODULE(B_Person_3(__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_4(__cfg_Local).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4_Local.__ENH_Bankruptcy_4;
    SHARED TYPEOF(B_Criminal_Offense_4(__cfg_Local).__ENH_Criminal_Offense_4) __ENH_Criminal_Offense_4 := B_Criminal_Offense_4_Local.__ENH_Criminal_Offense_4;
    SHARED TYPEOF(E_Household_Member(__cfg_Local).__Result) __E_Household_Member := E_Household_Member_Filtered.__Result;
    SHARED TYPEOF(B_Input_P_I_I_4(__cfg_Local).__ENH_Input_P_I_I_4) __ENH_Input_P_I_I_4 := B_Input_P_I_I_4_Local.__ENH_Input_P_I_I_4;
    SHARED TYPEOF(B_Inquiry_4(__cfg_Local).__ENH_Inquiry_4) __ENH_Inquiry_4 := B_Inquiry_4_Local.__ENH_Inquiry_4;
    SHARED TYPEOF(B_Person_4(__cfg_Local).__ENH_Person_4) __ENH_Person_4 := B_Person_4_Local.__ENH_Person_4;
    SHARED TYPEOF(E_Person_Bankruptcy(__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(B_Person_Inquiry_4(__cfg_Local).__ENH_Person_Inquiry_4) __ENH_Person_Inquiry_4 := B_Person_Inquiry_4_Local.__ENH_Person_Inquiry_4;
    SHARED TYPEOF(E_Person_Offenses(__cfg_Local).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
    SHARED TYPEOF(B_Person_Property_4(__cfg_Local).__ENH_Person_Property_4) __ENH_Person_Property_4 := B_Person_Property_4_Local.__ENH_Person_Property_4;
    SHARED TYPEOF(B_Professional_License_4(__cfg_Local).__ENH_Professional_License_4) __ENH_Professional_License_4 := B_Professional_License_4_Local.__ENH_Professional_License_4;
    SHARED TYPEOF(E_Professional_License_Person(__cfg_Local).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered.__Result;
  END;
  SHARED B_Person_Address_3_Local := MODULE(B_Person_Address_3(__cfg_Local))
    SHARED TYPEOF(B_Person_4(__cfg_Local).__ENH_Person_4) __ENH_Person_4 := B_Person_4_Local.__ENH_Person_4;
    SHARED TYPEOF(E_Person_Address(__cfg_Local).__Result) __E_Person_Address := E_Person_Address_Filtered.__Result;
  END;
  SHARED B_Person_Inquiry_3_Local := MODULE(B_Person_Inquiry_3(__cfg_Local))
    SHARED TYPEOF(B_Person_Inquiry_4(__cfg_Local).__ENH_Person_Inquiry_4) __ENH_Person_Inquiry_4 := B_Person_Inquiry_4_Local.__ENH_Person_Inquiry_4;
  END;
  SHARED B_Person_Property_3_Local := MODULE(B_Person_Property_3(__cfg_Local))
    SHARED TYPEOF(B_Person_Property_4(__cfg_Local).__ENH_Person_Property_4) __ENH_Person_Property_4 := B_Person_Property_4_Local.__ENH_Person_Property_4;
    SHARED TYPEOF(B_Property_4(__cfg_Local).__ENH_Property_4) __ENH_Property_4 := B_Property_4_Local.__ENH_Property_4;
  END;
  SHARED B_Person_S_S_N_3_Local := MODULE(B_Person_S_S_N_3(__cfg_Local))
    SHARED TYPEOF(B_Person_S_S_N_4(__cfg_Local).__ENH_Person_S_S_N_4) __ENH_Person_S_S_N_4 := B_Person_S_S_N_4_Local.__ENH_Person_S_S_N_4;
  END;
  SHARED B_Person_Vehicle_3_Local := MODULE(B_Person_Vehicle_3(__cfg_Local))
    SHARED TYPEOF(E_Person_Vehicle(__cfg_Local).__Result) __E_Person_Vehicle := E_Person_Vehicle_Filtered.__Result;
  END;
  SHARED B_Professional_License_3_Local := MODULE(B_Professional_License_3(__cfg_Local))
    SHARED TYPEOF(B_Professional_License_4(__cfg_Local).__ENH_Professional_License_4) __ENH_Professional_License_4 := B_Professional_License_4_Local.__ENH_Professional_License_4;
  END;
  SHARED B_Property_3_Local := MODULE(B_Property_3(__cfg_Local))
    SHARED TYPEOF(B_Property_4(__cfg_Local).__ENH_Property_4) __ENH_Property_4 := B_Property_4_Local.__ENH_Property_4;
  END;
  SHARED B_Property_Event_3_Local := MODULE(B_Property_Event_3(__cfg_Local))
    SHARED TYPEOF(B_Property_Event_4(__cfg_Local).__ENH_Property_Event_4) __ENH_Property_Event_4 := B_Property_Event_4_Local.__ENH_Property_Event_4;
  END;
  SHARED B_Sele_Address_3_Local := MODULE(B_Sele_Address_3(__cfg_Local))
    SHARED TYPEOF(B_Sele_Address_4(__cfg_Local).__ENH_Sele_Address_4) __ENH_Sele_Address_4 := B_Sele_Address_4_Local.__ENH_Sele_Address_4;
  END;
  SHARED B_Sele_Person_3_Local := MODULE(B_Sele_Person_3(__cfg_Local))
    SHARED TYPEOF(B_Sele_Person_4(__cfg_Local).__ENH_Sele_Person_4) __ENH_Sele_Person_4 := B_Sele_Person_4_Local.__ENH_Sele_Person_4;
  END;
  SHARED B_Sele_Phone_Number_3_Local := MODULE(B_Sele_Phone_Number_3(__cfg_Local))
    SHARED TYPEOF(B_Sele_Phone_Number_4(__cfg_Local).__ENH_Sele_Phone_Number_4) __ENH_Sele_Phone_Number_4 := B_Sele_Phone_Number_4_Local.__ENH_Sele_Phone_Number_4;
  END;
  SHARED B_Sele_Property_3_Local := MODULE(B_Sele_Property_3(__cfg_Local))
    SHARED TYPEOF(B_Sele_Property_4(__cfg_Local).__ENH_Sele_Property_4) __ENH_Sele_Property_4 := B_Sele_Property_4_Local.__ENH_Sele_Property_4;
  END;
  SHARED B_Sele_T_I_N_3_Local := MODULE(B_Sele_T_I_N_3(__cfg_Local))
    SHARED TYPEOF(B_Sele_T_I_N_4(__cfg_Local).__ENH_Sele_T_I_N_4) __ENH_Sele_T_I_N_4 := B_Sele_T_I_N_4_Local.__ENH_Sele_T_I_N_4;
  END;
  SHARED B_Sele_Tradeline_3_Local := MODULE(B_Sele_Tradeline_3(__cfg_Local))
    SHARED TYPEOF(E_Sele_Tradeline(__cfg_Local).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered.__Result;
    SHARED TYPEOF(B_Tradeline_4(__cfg_Local).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local.__ENH_Tradeline_4;
  END;
  SHARED B_Sele_U_C_C_3_Local := MODULE(B_Sele_U_C_C_3(__cfg_Local))
    SHARED TYPEOF(B_Sele_U_C_C_4(__cfg_Local).__ENH_Sele_U_C_C_4) __ENH_Sele_U_C_C_4 := B_Sele_U_C_C_4_Local.__ENH_Sele_U_C_C_4;
  END;
  SHARED B_Sele_Vehicle_3_Local := MODULE(B_Sele_Vehicle_3(__cfg_Local))
    SHARED TYPEOF(E_Sele_Vehicle(__cfg_Local).__Result) __E_Sele_Vehicle := E_Sele_Vehicle_Filtered.__Result;
  END;
  SHARED B_Tradeline_3_Local := MODULE(B_Tradeline_3(__cfg_Local))
    SHARED TYPEOF(B_Tradeline_4(__cfg_Local).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local.__ENH_Tradeline_4;
  END;
  SHARED B_U_C_C_3_Local := MODULE(B_U_C_C_3(__cfg_Local))
    SHARED TYPEOF(B_U_C_C_4(__cfg_Local).__ENH_U_C_C_4) __ENH_U_C_C_4 := B_U_C_C_4_Local.__ENH_U_C_C_4;
  END;
  SHARED B_Watercraft_Owner_3_Local := MODULE(B_Watercraft_Owner_3(__cfg_Local))
    SHARED TYPEOF(E_Watercraft_Owner(__cfg_Local).__Result) __E_Watercraft_Owner := E_Watercraft_Owner_Filtered.__Result;
  END;
  SHARED B_Address_2_Local := MODULE(B_Address_2(__cfg_Local))
    SHARED TYPEOF(B_Address_3(__cfg_Local).__ENH_Address_3) __ENH_Address_3 := B_Address_3_Local.__ENH_Address_3;
    SHARED TYPEOF(E_Zip_Code(__cfg_Local).__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
  END;
  SHARED B_Aircraft_Owner_2_Local := MODULE(B_Aircraft_Owner_2(__cfg_Local))
    SHARED TYPEOF(B_Aircraft_Owner_3(__cfg_Local).__ENH_Aircraft_Owner_3) __ENH_Aircraft_Owner_3 := B_Aircraft_Owner_3_Local.__ENH_Aircraft_Owner_3;
  END;
  SHARED B_Bankruptcy_2_Local := MODULE(B_Bankruptcy_2(__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_3(__cfg_Local).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local.__ENH_Bankruptcy_3;
  END;
  SHARED B_Business_Prox_2_Local := MODULE(B_Business_Prox_2(__cfg_Local))
    SHARED TYPEOF(B_Business_Prox_3(__cfg_Local).__ENH_Business_Prox_3) __ENH_Business_Prox_3 := B_Business_Prox_3_Local.__ENH_Business_Prox_3;
    SHARED TYPEOF(E_Prox_Phone_Number(__cfg_Local).__Result) __E_Prox_Phone_Number := E_Prox_Phone_Number_Filtered.__Result;
    SHARED TYPEOF(E_Prox_T_I_N(__cfg_Local).__Result) __E_Prox_T_I_N := E_Prox_T_I_N_Filtered.__Result;
  END;
  SHARED B_Business_Sele_2_Local := MODULE(B_Business_Sele_2(__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_3(__cfg_Local).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local.__ENH_Bankruptcy_3;
    SHARED TYPEOF(B_Business_Prox_3(__cfg_Local).__ENH_Business_Prox_3) __ENH_Business_Prox_3 := B_Business_Prox_3_Local.__ENH_Business_Prox_3;
    SHARED TYPEOF(B_Business_Sele_3(__cfg_Local).__ENH_Business_Sele_3) __ENH_Business_Sele_3 := B_Business_Sele_3_Local.__ENH_Business_Sele_3;
    SHARED TYPEOF(B_Business_Sele_Overflow_3(__cfg_Local).__ENH_Business_Sele_Overflow_3) __ENH_Business_Sele_Overflow_3 := B_Business_Sele_Overflow_3_Local.__ENH_Business_Sele_Overflow_3;
    SHARED TYPEOF(B_Input_B_I_I_3(__cfg_Local).__ENH_Input_B_I_I_3) __ENH_Input_B_I_I_3 := B_Input_B_I_I_3_Local.__ENH_Input_B_I_I_3;
    SHARED TYPEOF(B_Person_3(__cfg_Local).__ENH_Person_3) __ENH_Person_3 := B_Person_3_Local.__ENH_Person_3;
    SHARED TYPEOF(B_Sele_Address_3(__cfg_Local).__ENH_Sele_Address_3) __ENH_Sele_Address_3 := B_Sele_Address_3_Local.__ENH_Sele_Address_3;
    SHARED TYPEOF(E_Sele_Bankruptcy(__cfg_Local).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Person_3(__cfg_Local).__ENH_Sele_Person_3) __ENH_Sele_Person_3 := B_Sele_Person_3_Local.__ENH_Sele_Person_3;
    SHARED TYPEOF(B_Sele_Phone_Number_3(__cfg_Local).__ENH_Sele_Phone_Number_3) __ENH_Sele_Phone_Number_3 := B_Sele_Phone_Number_3_Local.__ENH_Sele_Phone_Number_3;
    SHARED TYPEOF(B_Sele_Property_3(__cfg_Local).__ENH_Sele_Property_3) __ENH_Sele_Property_3 := B_Sele_Property_3_Local.__ENH_Sele_Property_3;
    SHARED TYPEOF(B_Sele_T_I_N_3(__cfg_Local).__ENH_Sele_T_I_N_3) __ENH_Sele_T_I_N_3 := B_Sele_T_I_N_3_Local.__ENH_Sele_T_I_N_3;
    SHARED TYPEOF(B_Sele_Tradeline_3(__cfg_Local).__ENH_Sele_Tradeline_3) __ENH_Sele_Tradeline_3 := B_Sele_Tradeline_3_Local.__ENH_Sele_Tradeline_3;
    SHARED TYPEOF(B_Sele_U_C_C_3(__cfg_Local).__ENH_Sele_U_C_C_3) __ENH_Sele_U_C_C_3 := B_Sele_U_C_C_3_Local.__ENH_Sele_U_C_C_3;
    SHARED TYPEOF(B_Sele_Vehicle_3(__cfg_Local).__ENH_Sele_Vehicle_3) __ENH_Sele_Vehicle_3 := B_Sele_Vehicle_3_Local.__ENH_Sele_Vehicle_3;
    SHARED TYPEOF(B_Tradeline_3(__cfg_Local).__ENH_Tradeline_3) __ENH_Tradeline_3 := B_Tradeline_3_Local.__ENH_Tradeline_3;
    SHARED TYPEOF(B_U_C_C_3(__cfg_Local).__ENH_U_C_C_3) __ENH_U_C_C_3 := B_U_C_C_3_Local.__ENH_U_C_C_3;
    SHARED TYPEOF(E_Zip_Code(__cfg_Local).__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
  END;
  SHARED B_Business_Sele_Overflow_2_Local := MODULE(B_Business_Sele_Overflow_2(__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_Overflow_3(__cfg_Local).__ENH_Business_Sele_Overflow_3) __ENH_Business_Sele_Overflow_3 := B_Business_Sele_Overflow_3_Local.__ENH_Business_Sele_Overflow_3;
  END;
  SHARED B_Criminal_Offense_2_Local := MODULE(B_Criminal_Offense_2(__cfg_Local))
    SHARED TYPEOF(B_Criminal_Offense_3(__cfg_Local).__ENH_Criminal_Offense_3) __ENH_Criminal_Offense_3 := B_Criminal_Offense_3_Local.__ENH_Criminal_Offense_3;
  END;
  SHARED B_Education_2_Local := MODULE(B_Education_2(__cfg_Local))
    SHARED TYPEOF(B_Education_3(__cfg_Local).__ENH_Education_3) __ENH_Education_3 := B_Education_3_Local.__ENH_Education_3;
  END;
  SHARED B_Email_2_Local := MODULE(B_Email_2(__cfg_Local))
    SHARED TYPEOF(E_Email(__cfg_Local).__Result) __E_Email := E_Email_Filtered.__Result;
  END;
  SHARED B_First_Degree_Relative_2_Local := MODULE(B_First_Degree_Relative_2(__cfg_Local))
    SHARED TYPEOF(B_First_Degree_Relative_3(__cfg_Local).__ENH_First_Degree_Relative_3) __ENH_First_Degree_Relative_3 := B_First_Degree_Relative_3_Local.__ENH_First_Degree_Relative_3;
  END;
  SHARED B_Input_B_I_I_2_Local := MODULE(B_Input_B_I_I_2(__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_3(__cfg_Local).__ENH_Input_B_I_I_3) __ENH_Input_B_I_I_3 := B_Input_B_I_I_3_Local.__ENH_Input_B_I_I_3;
    SHARED TYPEOF(E_Input_B_I_I_Input_P_I_I(__cfg_Local).__Result) __E_Input_B_I_I_Input_P_I_I := E_Input_B_I_I_Input_P_I_I_Filtered.__Result;
    SHARED TYPEOF(B_Input_P_I_I_3(__cfg_Local).__ENH_Input_P_I_I_3) __ENH_Input_P_I_I_3 := B_Input_P_I_I_3_Local.__ENH_Input_P_I_I_3;
  END;
  SHARED B_Input_P_I_I_2_Local := MODULE(B_Input_P_I_I_2(__cfg_Local))
    SHARED TYPEOF(B_Address_3(__cfg_Local).__ENH_Address_3) __ENH_Address_3 := B_Address_3_Local.__ENH_Address_3;
    SHARED TYPEOF(E_Email_Inquiry(__cfg_Local).__Result) __E_Email_Inquiry := E_Email_Inquiry_Filtered.__Result;
    SHARED TYPEOF(B_Input_P_I_I_3(__cfg_Local).__ENH_Input_P_I_I_3) __ENH_Input_P_I_I_3 := B_Input_P_I_I_3_Local.__ENH_Input_P_I_I_3;
    SHARED TYPEOF(B_Inquiry_3(__cfg_Local).__ENH_Inquiry_3) __ENH_Inquiry_3 := B_Inquiry_3_Local.__ENH_Inquiry_3;
    SHARED TYPEOF(E_Phone_Inquiry(__cfg_Local).__Result) __E_Phone_Inquiry := E_Phone_Inquiry_Filtered.__Result;
    SHARED TYPEOF(E_S_S_N_Inquiry(__cfg_Local).__Result) __E_S_S_N_Inquiry := E_S_S_N_Inquiry_Filtered.__Result;
  END;
  SHARED B_Inquiry_2_Local := MODULE(B_Inquiry_2(__cfg_Local))
    SHARED TYPEOF(B_Inquiry_3(__cfg_Local).__ENH_Inquiry_3) __ENH_Inquiry_3 := B_Inquiry_3_Local.__ENH_Inquiry_3;
  END;
  SHARED B_Lien_Judgment_2_Local := MODULE(B_Lien_Judgment_2(__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_3(__cfg_Local).__ENH_Lien_Judgment_3) __ENH_Lien_Judgment_3 := B_Lien_Judgment_3_Local.__ENH_Lien_Judgment_3;
  END;
  SHARED B_Person_2_Local := MODULE(B_Person_2(__cfg_Local))
    SHARED TYPEOF(E_Address_Inquiry(__cfg_Local).__Result) __E_Address_Inquiry := E_Address_Inquiry_Filtered.__Result;
    SHARED TYPEOF(B_Aircraft_Owner_3(__cfg_Local).__ENH_Aircraft_Owner_3) __ENH_Aircraft_Owner_3 := B_Aircraft_Owner_3_Local.__ENH_Aircraft_Owner_3;
    SHARED TYPEOF(B_Bankruptcy_3(__cfg_Local).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local.__ENH_Bankruptcy_3;
    SHARED TYPEOF(B_Criminal_Offense_3(__cfg_Local).__ENH_Criminal_Offense_3) __ENH_Criminal_Offense_3 := B_Criminal_Offense_3_Local.__ENH_Criminal_Offense_3;
    SHARED TYPEOF(B_Education_3(__cfg_Local).__ENH_Education_3) __ENH_Education_3 := B_Education_3_Local.__ENH_Education_3;
    SHARED TYPEOF(B_Input_P_I_I_3(__cfg_Local).__ENH_Input_P_I_I_3) __ENH_Input_P_I_I_3 := B_Input_P_I_I_3_Local.__ENH_Input_P_I_I_3;
    SHARED TYPEOF(B_Inquiry_3(__cfg_Local).__ENH_Inquiry_3) __ENH_Inquiry_3 := B_Inquiry_3_Local.__ENH_Inquiry_3;
    SHARED TYPEOF(B_Person_3(__cfg_Local).__ENH_Person_3) __ENH_Person_3 := B_Person_3_Local.__ENH_Person_3;
    SHARED TYPEOF(B_Person_Address_3(__cfg_Local).__ENH_Person_Address_3) __ENH_Person_Address_3 := B_Person_Address_3_Local.__ENH_Person_Address_3;
    SHARED TYPEOF(E_Person_Bankruptcy(__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(E_Person_Education(__cfg_Local).__Result) __E_Person_Education := E_Person_Education_Filtered.__Result;
    SHARED TYPEOF(B_Person_Inquiry_3(__cfg_Local).__ENH_Person_Inquiry_3) __ENH_Person_Inquiry_3 := B_Person_Inquiry_3_Local.__ENH_Person_Inquiry_3;
    SHARED TYPEOF(E_Person_Offenses(__cfg_Local).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
    SHARED TYPEOF(B_Person_Property_3(__cfg_Local).__ENH_Person_Property_3) __ENH_Person_Property_3 := B_Person_Property_3_Local.__ENH_Person_Property_3;
    SHARED TYPEOF(B_Person_Vehicle_3(__cfg_Local).__ENH_Person_Vehicle_3) __ENH_Person_Vehicle_3 := B_Person_Vehicle_3_Local.__ENH_Person_Vehicle_3;
    SHARED TYPEOF(B_Professional_License_3(__cfg_Local).__ENH_Professional_License_3) __ENH_Professional_License_3 := B_Professional_License_3_Local.__ENH_Professional_License_3;
    SHARED TYPEOF(E_Professional_License_Person(__cfg_Local).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Person_3(__cfg_Local).__ENH_Sele_Person_3) __ENH_Sele_Person_3 := B_Sele_Person_3_Local.__ENH_Sele_Person_3;
    SHARED TYPEOF(E_Utility_Person(__cfg_Local).__Result) __E_Utility_Person := E_Utility_Person_Filtered.__Result;
    SHARED TYPEOF(B_Watercraft_Owner_3(__cfg_Local).__ENH_Watercraft_Owner_3) __ENH_Watercraft_Owner_3 := B_Watercraft_Owner_3_Local.__ENH_Watercraft_Owner_3;
  END;
  SHARED B_Person_Address_2_Local := MODULE(B_Person_Address_2(__cfg_Local))
    SHARED TYPEOF(B_Person_Address_3(__cfg_Local).__ENH_Person_Address_3) __ENH_Person_Address_3 := B_Person_Address_3_Local.__ENH_Person_Address_3;
  END;
  SHARED B_Person_Property_2_Local := MODULE(B_Person_Property_2(__cfg_Local))
    SHARED TYPEOF(B_Person_Property_3(__cfg_Local).__ENH_Person_Property_3) __ENH_Person_Property_3 := B_Person_Property_3_Local.__ENH_Person_Property_3;
    SHARED TYPEOF(E_Person_Property_Event(__cfg_Local).__Result) __E_Person_Property_Event := E_Person_Property_Event_Filtered.__Result;
    SHARED TYPEOF(B_Property_3(__cfg_Local).__ENH_Property_3) __ENH_Property_3 := B_Property_3_Local.__ENH_Property_3;
    SHARED TYPEOF(B_Property_Event_3(__cfg_Local).__ENH_Property_Event_3) __ENH_Property_Event_3 := B_Property_Event_3_Local.__ENH_Property_Event_3;
  END;
  SHARED B_Person_S_S_N_2_Local := MODULE(B_Person_S_S_N_2(__cfg_Local))
    SHARED TYPEOF(B_Person_S_S_N_3(__cfg_Local).__ENH_Person_S_S_N_3) __ENH_Person_S_S_N_3 := B_Person_S_S_N_3_Local.__ENH_Person_S_S_N_3;
  END;
  SHARED B_Person_Vehicle_2_Local := MODULE(B_Person_Vehicle_2(__cfg_Local))
    SHARED TYPEOF(B_Person_Vehicle_3(__cfg_Local).__ENH_Person_Vehicle_3) __ENH_Person_Vehicle_3 := B_Person_Vehicle_3_Local.__ENH_Person_Vehicle_3;
  END;
  SHARED B_Professional_License_2_Local := MODULE(B_Professional_License_2(__cfg_Local))
    SHARED TYPEOF(B_Professional_License_3(__cfg_Local).__ENH_Professional_License_3) __ENH_Professional_License_3 := B_Professional_License_3_Local.__ENH_Professional_License_3;
  END;
  SHARED B_Property_2_Local := MODULE(B_Property_2(__cfg_Local))
    SHARED TYPEOF(B_Property_3(__cfg_Local).__ENH_Property_3) __ENH_Property_3 := B_Property_3_Local.__ENH_Property_3;
  END;
  SHARED B_Property_Event_2_Local := MODULE(B_Property_Event_2(__cfg_Local))
    SHARED TYPEOF(B_Property_Event_3(__cfg_Local).__ENH_Property_Event_3) __ENH_Property_Event_3 := B_Property_Event_3_Local.__ENH_Property_Event_3;
  END;
  SHARED B_Sele_Address_2_Local := MODULE(B_Sele_Address_2(__cfg_Local))
    SHARED TYPEOF(B_Sele_Address_3(__cfg_Local).__ENH_Sele_Address_3) __ENH_Sele_Address_3 := B_Sele_Address_3_Local.__ENH_Sele_Address_3;
  END;
  SHARED B_Sele_Person_2_Local := MODULE(B_Sele_Person_2(__cfg_Local))
    SHARED TYPEOF(B_Sele_Person_3(__cfg_Local).__ENH_Sele_Person_3) __ENH_Sele_Person_3 := B_Sele_Person_3_Local.__ENH_Sele_Person_3;
  END;
  SHARED B_Sele_Property_2_Local := MODULE(B_Sele_Property_2(__cfg_Local))
    SHARED TYPEOF(B_Property_3(__cfg_Local).__ENH_Property_3) __ENH_Property_3 := B_Property_3_Local.__ENH_Property_3;
    SHARED TYPEOF(B_Property_Event_3(__cfg_Local).__ENH_Property_Event_3) __ENH_Property_Event_3 := B_Property_Event_3_Local.__ENH_Property_Event_3;
    SHARED TYPEOF(B_Sele_Property_3(__cfg_Local).__ENH_Sele_Property_3) __ENH_Sele_Property_3 := B_Sele_Property_3_Local.__ENH_Sele_Property_3;
    SHARED TYPEOF(E_Sele_Property_Event(__cfg_Local).__Result) __E_Sele_Property_Event := E_Sele_Property_Event_Filtered.__Result;
  END;
  SHARED B_Sele_Tradeline_2_Local := MODULE(B_Sele_Tradeline_2(__cfg_Local))
    SHARED TYPEOF(B_Sele_Tradeline_3(__cfg_Local).__ENH_Sele_Tradeline_3) __ENH_Sele_Tradeline_3 := B_Sele_Tradeline_3_Local.__ENH_Sele_Tradeline_3;
  END;
  SHARED B_Sele_U_C_C_2_Local := MODULE(B_Sele_U_C_C_2(__cfg_Local))
    SHARED TYPEOF(B_Sele_U_C_C_3(__cfg_Local).__ENH_Sele_U_C_C_3) __ENH_Sele_U_C_C_3 := B_Sele_U_C_C_3_Local.__ENH_Sele_U_C_C_3;
  END;
  SHARED B_Sele_Vehicle_2_Local := MODULE(B_Sele_Vehicle_2(__cfg_Local))
    SHARED TYPEOF(B_Sele_Vehicle_3(__cfg_Local).__ENH_Sele_Vehicle_3) __ENH_Sele_Vehicle_3 := B_Sele_Vehicle_3_Local.__ENH_Sele_Vehicle_3;
  END;
  SHARED B_Tradeline_2_Local := MODULE(B_Tradeline_2(__cfg_Local))
    SHARED TYPEOF(B_Tradeline_3(__cfg_Local).__ENH_Tradeline_3) __ENH_Tradeline_3 := B_Tradeline_3_Local.__ENH_Tradeline_3;
  END;
  SHARED B_U_C_C_2_Local := MODULE(B_U_C_C_2(__cfg_Local))
    SHARED TYPEOF(B_U_C_C_3(__cfg_Local).__ENH_U_C_C_3) __ENH_U_C_C_3 := B_U_C_C_3_Local.__ENH_U_C_C_3;
  END;
  SHARED B_Watercraft_Owner_2_Local := MODULE(B_Watercraft_Owner_2(__cfg_Local))
    SHARED TYPEOF(B_Watercraft_Owner_3(__cfg_Local).__ENH_Watercraft_Owner_3) __ENH_Watercraft_Owner_3 := B_Watercraft_Owner_3_Local.__ENH_Watercraft_Owner_3;
  END;
  SHARED B_Address_1_Local := MODULE(B_Address_1(__cfg_Local))
    SHARED TYPEOF(B_Address_2(__cfg_Local).__ENH_Address_2) __ENH_Address_2 := B_Address_2_Local.__ENH_Address_2;
  END;
  SHARED B_Aircraft_Owner_1_Local := MODULE(B_Aircraft_Owner_1(__cfg_Local))
    SHARED TYPEOF(B_Aircraft_Owner_2(__cfg_Local).__ENH_Aircraft_Owner_2) __ENH_Aircraft_Owner_2 := B_Aircraft_Owner_2_Local.__ENH_Aircraft_Owner_2;
  END;
  SHARED B_Bankruptcy_1_Local := MODULE(B_Bankruptcy_1(__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_2(__cfg_Local).__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local.__ENH_Bankruptcy_2;
  END;
  SHARED B_Business_Prox_1_Local := MODULE(B_Business_Prox_1(__cfg_Local))
    SHARED TYPEOF(B_Business_Prox_2(__cfg_Local).__ENH_Business_Prox_2) __ENH_Business_Prox_2 := B_Business_Prox_2_Local.__ENH_Business_Prox_2;
  END;
  SHARED B_Business_Sele_1_Local := MODULE(B_Business_Sele_1(__cfg_Local))
    SHARED TYPEOF(E_Address_Property_Event(__cfg_Local).__Result) __E_Address_Property_Event := E_Address_Property_Event_Filtered.__Result;
    SHARED TYPEOF(B_Bankruptcy_2(__cfg_Local).__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local.__ENH_Bankruptcy_2;
    SHARED TYPEOF(B_Business_Prox_2(__cfg_Local).__ENH_Business_Prox_2) __ENH_Business_Prox_2 := B_Business_Prox_2_Local.__ENH_Business_Prox_2;
    SHARED TYPEOF(B_Business_Sele_2(__cfg_Local).__ENH_Business_Sele_2) __ENH_Business_Sele_2 := B_Business_Sele_2_Local.__ENH_Business_Sele_2;
    SHARED TYPEOF(B_Business_Sele_Overflow_2(__cfg_Local).__ENH_Business_Sele_Overflow_2) __ENH_Business_Sele_Overflow_2 := B_Business_Sele_Overflow_2_Local.__ENH_Business_Sele_Overflow_2;
    SHARED TYPEOF(B_Input_B_I_I_2(__cfg_Local).__ENH_Input_B_I_I_2) __ENH_Input_B_I_I_2 := B_Input_B_I_I_2_Local.__ENH_Input_B_I_I_2;
    SHARED TYPEOF(B_Person_2(__cfg_Local).__ENH_Person_2) __ENH_Person_2 := B_Person_2_Local.__ENH_Person_2;
    SHARED TYPEOF(E_Person_Email(__cfg_Local).__Result) __E_Person_Email := E_Person_Email_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Address_2(__cfg_Local).__ENH_Sele_Address_2) __ENH_Sele_Address_2 := B_Sele_Address_2_Local.__ENH_Sele_Address_2;
    SHARED TYPEOF(E_Sele_Bankruptcy(__cfg_Local).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Person_2(__cfg_Local).__ENH_Sele_Person_2) __ENH_Sele_Person_2 := B_Sele_Person_2_Local.__ENH_Sele_Person_2;
    SHARED TYPEOF(B_Sele_Property_2(__cfg_Local).__ENH_Sele_Property_2) __ENH_Sele_Property_2 := B_Sele_Property_2_Local.__ENH_Sele_Property_2;
    SHARED TYPEOF(E_Sele_Property_Event(__cfg_Local).__Result) __E_Sele_Property_Event := E_Sele_Property_Event_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Tradeline_2(__cfg_Local).__ENH_Sele_Tradeline_2) __ENH_Sele_Tradeline_2 := B_Sele_Tradeline_2_Local.__ENH_Sele_Tradeline_2;
    SHARED TYPEOF(B_Sele_U_C_C_2(__cfg_Local).__ENH_Sele_U_C_C_2) __ENH_Sele_U_C_C_2 := B_Sele_U_C_C_2_Local.__ENH_Sele_U_C_C_2;
    SHARED TYPEOF(B_Sele_Vehicle_2(__cfg_Local).__ENH_Sele_Vehicle_2) __ENH_Sele_Vehicle_2 := B_Sele_Vehicle_2_Local.__ENH_Sele_Vehicle_2;
    SHARED TYPEOF(B_Tradeline_2(__cfg_Local).__ENH_Tradeline_2) __ENH_Tradeline_2 := B_Tradeline_2_Local.__ENH_Tradeline_2;
    SHARED TYPEOF(B_U_C_C_2(__cfg_Local).__ENH_U_C_C_2) __ENH_U_C_C_2 := B_U_C_C_2_Local.__ENH_U_C_C_2;
    SHARED TYPEOF(E_Zip_Code(__cfg_Local).__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
  END;
  SHARED B_Business_Sele_Overflow_1_Local := MODULE(B_Business_Sele_Overflow_1(__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_Overflow_2(__cfg_Local).__ENH_Business_Sele_Overflow_2) __ENH_Business_Sele_Overflow_2 := B_Business_Sele_Overflow_2_Local.__ENH_Business_Sele_Overflow_2;
  END;
  SHARED B_Criminal_Offense_1_Local := MODULE(B_Criminal_Offense_1(__cfg_Local))
    SHARED TYPEOF(B_Criminal_Offense_2(__cfg_Local).__ENH_Criminal_Offense_2) __ENH_Criminal_Offense_2 := B_Criminal_Offense_2_Local.__ENH_Criminal_Offense_2;
  END;
  SHARED B_Education_1_Local := MODULE(B_Education_1(__cfg_Local))
    SHARED TYPEOF(B_Education_2(__cfg_Local).__ENH_Education_2) __ENH_Education_2 := B_Education_2_Local.__ENH_Education_2;
  END;
  SHARED B_Email_1_Local := MODULE(B_Email_1(__cfg_Local))
    SHARED TYPEOF(B_Email_2(__cfg_Local).__ENH_Email_2) __ENH_Email_2 := B_Email_2_Local.__ENH_Email_2;
  END;
  SHARED B_First_Degree_Relative_1_Local := MODULE(B_First_Degree_Relative_1(__cfg_Local))
    SHARED TYPEOF(B_First_Degree_Relative_2(__cfg_Local).__ENH_First_Degree_Relative_2) __ENH_First_Degree_Relative_2 := B_First_Degree_Relative_2_Local.__ENH_First_Degree_Relative_2;
  END;
  SHARED B_Input_B_I_I_1_Local := MODULE(B_Input_B_I_I_1(__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_2(__cfg_Local).__ENH_Input_B_I_I_2) __ENH_Input_B_I_I_2 := B_Input_B_I_I_2_Local.__ENH_Input_B_I_I_2;
    SHARED TYPEOF(E_Input_B_I_I_Input_P_I_I(__cfg_Local).__Result) __E_Input_B_I_I_Input_P_I_I := E_Input_B_I_I_Input_P_I_I_Filtered.__Result;
    SHARED TYPEOF(B_Input_P_I_I_2(__cfg_Local).__ENH_Input_P_I_I_2) __ENH_Input_P_I_I_2 := B_Input_P_I_I_2_Local.__ENH_Input_P_I_I_2;
  END;
  SHARED B_Input_P_I_I_1_Local := MODULE(B_Input_P_I_I_1(__cfg_Local))
    SHARED TYPEOF(B_Address_2(__cfg_Local).__ENH_Address_2) __ENH_Address_2 := B_Address_2_Local.__ENH_Address_2;
    SHARED TYPEOF(B_Input_P_I_I_2(__cfg_Local).__ENH_Input_P_I_I_2) __ENH_Input_P_I_I_2 := B_Input_P_I_I_2_Local.__ENH_Input_P_I_I_2;
    SHARED TYPEOF(E_Social_Security_Number(__cfg_Local).__Result) __E_Social_Security_Number := E_Social_Security_Number_Filtered.__Result;
  END;
  SHARED B_Inquiry_1_Local := MODULE(B_Inquiry_1(__cfg_Local))
    SHARED TYPEOF(B_Inquiry_2(__cfg_Local).__ENH_Inquiry_2) __ENH_Inquiry_2 := B_Inquiry_2_Local.__ENH_Inquiry_2;
  END;
  SHARED B_Lien_Judgment_1_Local := MODULE(B_Lien_Judgment_1(__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_2(__cfg_Local).__ENH_Lien_Judgment_2) __ENH_Lien_Judgment_2 := B_Lien_Judgment_2_Local.__ENH_Lien_Judgment_2;
  END;
  SHARED B_Person_1_Local := MODULE(B_Person_1(__cfg_Local))
    SHARED TYPEOF(B_Address_2(__cfg_Local).__ENH_Address_2) __ENH_Address_2 := B_Address_2_Local.__ENH_Address_2;
    SHARED TYPEOF(B_Aircraft_Owner_2(__cfg_Local).__ENH_Aircraft_Owner_2) __ENH_Aircraft_Owner_2 := B_Aircraft_Owner_2_Local.__ENH_Aircraft_Owner_2;
    SHARED TYPEOF(B_Bankruptcy_2(__cfg_Local).__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local.__ENH_Bankruptcy_2;
    SHARED TYPEOF(B_Criminal_Offense_2(__cfg_Local).__ENH_Criminal_Offense_2) __ENH_Criminal_Offense_2 := B_Criminal_Offense_2_Local.__ENH_Criminal_Offense_2;
    SHARED TYPEOF(B_Education_2(__cfg_Local).__ENH_Education_2) __ENH_Education_2 := B_Education_2_Local.__ENH_Education_2;
    SHARED TYPEOF(B_Email_2(__cfg_Local).__ENH_Email_2) __ENH_Email_2 := B_Email_2_Local.__ENH_Email_2;
    SHARED TYPEOF(B_Input_P_I_I_2(__cfg_Local).__ENH_Input_P_I_I_2) __ENH_Input_P_I_I_2 := B_Input_P_I_I_2_Local.__ENH_Input_P_I_I_2;
    SHARED TYPEOF(B_Person_2(__cfg_Local).__ENH_Person_2) __ENH_Person_2 := B_Person_2_Local.__ENH_Person_2;
    SHARED TYPEOF(B_Person_Address_2(__cfg_Local).__ENH_Person_Address_2) __ENH_Person_Address_2 := B_Person_Address_2_Local.__ENH_Person_Address_2;
    SHARED TYPEOF(E_Person_Bankruptcy(__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(E_Person_Education(__cfg_Local).__Result) __E_Person_Education := E_Person_Education_Filtered.__Result;
    SHARED TYPEOF(E_Person_Email(__cfg_Local).__Result) __E_Person_Email := E_Person_Email_Filtered.__Result;
    SHARED TYPEOF(E_Person_Offenses(__cfg_Local).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
    SHARED TYPEOF(B_Person_Property_2(__cfg_Local).__ENH_Person_Property_2) __ENH_Person_Property_2 := B_Person_Property_2_Local.__ENH_Person_Property_2;
    SHARED TYPEOF(B_Person_S_S_N_2(__cfg_Local).__ENH_Person_S_S_N_2) __ENH_Person_S_S_N_2 := B_Person_S_S_N_2_Local.__ENH_Person_S_S_N_2;
    SHARED TYPEOF(B_Person_Vehicle_2(__cfg_Local).__ENH_Person_Vehicle_2) __ENH_Person_Vehicle_2 := B_Person_Vehicle_2_Local.__ENH_Person_Vehicle_2;
    SHARED TYPEOF(B_Professional_License_2(__cfg_Local).__ENH_Professional_License_2) __ENH_Professional_License_2 := B_Professional_License_2_Local.__ENH_Professional_License_2;
    SHARED TYPEOF(E_Professional_License_Person(__cfg_Local).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered.__Result;
    SHARED TYPEOF(B_Property_Event_2(__cfg_Local).__ENH_Property_Event_2) __ENH_Property_Event_2 := B_Property_Event_2_Local.__ENH_Property_Event_2;
    SHARED TYPEOF(B_Watercraft_Owner_2(__cfg_Local).__ENH_Watercraft_Owner_2) __ENH_Watercraft_Owner_2 := B_Watercraft_Owner_2_Local.__ENH_Watercraft_Owner_2;
  END;
  SHARED B_Person_Property_1_Local := MODULE(B_Person_Property_1(__cfg_Local))
    SHARED TYPEOF(B_Person_Property_2(__cfg_Local).__ENH_Person_Property_2) __ENH_Person_Property_2 := B_Person_Property_2_Local.__ENH_Person_Property_2;
    SHARED TYPEOF(B_Property_2(__cfg_Local).__ENH_Property_2) __ENH_Property_2 := B_Property_2_Local.__ENH_Property_2;
  END;
  SHARED B_Person_S_S_N_1_Local := MODULE(B_Person_S_S_N_1(__cfg_Local))
    SHARED TYPEOF(B_Person_S_S_N_2(__cfg_Local).__ENH_Person_S_S_N_2) __ENH_Person_S_S_N_2 := B_Person_S_S_N_2_Local.__ENH_Person_S_S_N_2;
  END;
  SHARED B_Person_Vehicle_1_Local := MODULE(B_Person_Vehicle_1(__cfg_Local))
    SHARED TYPEOF(B_Person_Vehicle_2(__cfg_Local).__ENH_Person_Vehicle_2) __ENH_Person_Vehicle_2 := B_Person_Vehicle_2_Local.__ENH_Person_Vehicle_2;
  END;
  SHARED B_Professional_License_1_Local := MODULE(B_Professional_License_1(__cfg_Local))
    SHARED TYPEOF(B_Professional_License_2(__cfg_Local).__ENH_Professional_License_2) __ENH_Professional_License_2 := B_Professional_License_2_Local.__ENH_Professional_License_2;
  END;
  SHARED B_Property_1_Local := MODULE(B_Property_1(__cfg_Local))
    SHARED TYPEOF(B_Property_2(__cfg_Local).__ENH_Property_2) __ENH_Property_2 := B_Property_2_Local.__ENH_Property_2;
  END;
  SHARED B_Property_Event_1_Local := MODULE(B_Property_Event_1(__cfg_Local))
    SHARED TYPEOF(B_Property_Event_2(__cfg_Local).__ENH_Property_Event_2) __ENH_Property_Event_2 := B_Property_Event_2_Local.__ENH_Property_Event_2;
  END;
  SHARED B_Sele_Address_1_Local := MODULE(B_Sele_Address_1(__cfg_Local))
    SHARED TYPEOF(B_Sele_Address_2(__cfg_Local).__ENH_Sele_Address_2) __ENH_Sele_Address_2 := B_Sele_Address_2_Local.__ENH_Sele_Address_2;
  END;
  SHARED B_Sele_Person_1_Local := MODULE(B_Sele_Person_1(__cfg_Local))
    SHARED TYPEOF(B_Sele_Person_2(__cfg_Local).__ENH_Sele_Person_2) __ENH_Sele_Person_2 := B_Sele_Person_2_Local.__ENH_Sele_Person_2;
  END;
  SHARED B_Sele_Property_1_Local := MODULE(B_Sele_Property_1(__cfg_Local))
    SHARED TYPEOF(B_Property_Event_2(__cfg_Local).__ENH_Property_Event_2) __ENH_Property_Event_2 := B_Property_Event_2_Local.__ENH_Property_Event_2;
    SHARED TYPEOF(B_Sele_Property_2(__cfg_Local).__ENH_Sele_Property_2) __ENH_Sele_Property_2 := B_Sele_Property_2_Local.__ENH_Sele_Property_2;
    SHARED TYPEOF(E_Sele_Property_Event(__cfg_Local).__Result) __E_Sele_Property_Event := E_Sele_Property_Event_Filtered.__Result;
  END;
  SHARED B_Sele_Tradeline_1_Local := MODULE(B_Sele_Tradeline_1(__cfg_Local))
    SHARED TYPEOF(B_Sele_Tradeline_2(__cfg_Local).__ENH_Sele_Tradeline_2) __ENH_Sele_Tradeline_2 := B_Sele_Tradeline_2_Local.__ENH_Sele_Tradeline_2;
  END;
  SHARED B_Sele_Vehicle_1_Local := MODULE(B_Sele_Vehicle_1(__cfg_Local))
    SHARED TYPEOF(B_Sele_Vehicle_2(__cfg_Local).__ENH_Sele_Vehicle_2) __ENH_Sele_Vehicle_2 := B_Sele_Vehicle_2_Local.__ENH_Sele_Vehicle_2;
  END;
  SHARED B_Tradeline_1_Local := MODULE(B_Tradeline_1(__cfg_Local))
    SHARED TYPEOF(B_Tradeline_2(__cfg_Local).__ENH_Tradeline_2) __ENH_Tradeline_2 := B_Tradeline_2_Local.__ENH_Tradeline_2;
  END;
  SHARED B_U_C_C_1_Local := MODULE(B_U_C_C_1(__cfg_Local))
    SHARED TYPEOF(B_U_C_C_2(__cfg_Local).__ENH_U_C_C_2) __ENH_U_C_C_2 := B_U_C_C_2_Local.__ENH_U_C_C_2;
  END;
  SHARED B_Watercraft_Owner_1_Local := MODULE(B_Watercraft_Owner_1(__cfg_Local))
    SHARED TYPEOF(B_Watercraft_Owner_2(__cfg_Local).__ENH_Watercraft_Owner_2) __ENH_Watercraft_Owner_2 := B_Watercraft_Owner_2_Local.__ENH_Watercraft_Owner_2;
  END;
  SHARED B_Address_Local := MODULE(B_Address(__cfg_Local))
    SHARED TYPEOF(B_Address_1(__cfg_Local).__ENH_Address_1) __ENH_Address_1 := B_Address_1_Local.__ENH_Address_1;
  END;
  SHARED B_Bankruptcy_Local := MODULE(B_Bankruptcy(__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_1(__cfg_Local).__ENH_Bankruptcy_1) __ENH_Bankruptcy_1 := B_Bankruptcy_1_Local.__ENH_Bankruptcy_1;
  END;
  SHARED B_Business_Prox_Local := MODULE(B_Business_Prox(__cfg_Local))
    SHARED TYPEOF(B_Business_Prox_1(__cfg_Local).__ENH_Business_Prox_1) __ENH_Business_Prox_1 := B_Business_Prox_1_Local.__ENH_Business_Prox_1;
  END;
  SHARED B_Business_Sele_Local := MODULE(B_Business_Sele(__cfg_Local))
    SHARED TYPEOF(B_Address_1(__cfg_Local).__ENH_Address_1) __ENH_Address_1 := B_Address_1_Local.__ENH_Address_1;
    SHARED TYPEOF(B_Bankruptcy_1(__cfg_Local).__ENH_Bankruptcy_1) __ENH_Bankruptcy_1 := B_Bankruptcy_1_Local.__ENH_Bankruptcy_1;
    SHARED TYPEOF(B_Business_Sele_1(__cfg_Local).__ENH_Business_Sele_1) __ENH_Business_Sele_1 := B_Business_Sele_1_Local.__ENH_Business_Sele_1;
    SHARED TYPEOF(B_Business_Sele_Overflow_1(__cfg_Local).__ENH_Business_Sele_Overflow_1) __ENH_Business_Sele_Overflow_1 := B_Business_Sele_Overflow_1_Local.__ENH_Business_Sele_Overflow_1;
    SHARED TYPEOF(B_Input_B_I_I_1(__cfg_Local).__ENH_Input_B_I_I_1) __ENH_Input_B_I_I_1 := B_Input_B_I_I_1_Local.__ENH_Input_B_I_I_1;
    SHARED TYPEOF(B_Sele_Address_1(__cfg_Local).__ENH_Sele_Address_1) __ENH_Sele_Address_1 := B_Sele_Address_1_Local.__ENH_Sele_Address_1;
    SHARED TYPEOF(E_Sele_Aircraft(__cfg_Local).__Result) __E_Sele_Aircraft := E_Sele_Aircraft_Filtered.__Result;
    SHARED TYPEOF(E_Sele_Bankruptcy(__cfg_Local).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Person_1(__cfg_Local).__ENH_Sele_Person_1) __ENH_Sele_Person_1 := B_Sele_Person_1_Local.__ENH_Sele_Person_1;
    SHARED TYPEOF(B_Sele_Property_1(__cfg_Local).__ENH_Sele_Property_1) __ENH_Sele_Property_1 := B_Sele_Property_1_Local.__ENH_Sele_Property_1;
    SHARED TYPEOF(B_Sele_Tradeline_1(__cfg_Local).__ENH_Sele_Tradeline_1) __ENH_Sele_Tradeline_1 := B_Sele_Tradeline_1_Local.__ENH_Sele_Tradeline_1;
    SHARED TYPEOF(B_Sele_Vehicle_1(__cfg_Local).__ENH_Sele_Vehicle_1) __ENH_Sele_Vehicle_1 := B_Sele_Vehicle_1_Local.__ENH_Sele_Vehicle_1;
    SHARED TYPEOF(E_Sele_Watercraft(__cfg_Local).__Result) __E_Sele_Watercraft := E_Sele_Watercraft_Filtered.__Result;
    SHARED TYPEOF(B_Tradeline_1(__cfg_Local).__ENH_Tradeline_1) __ENH_Tradeline_1 := B_Tradeline_1_Local.__ENH_Tradeline_1;
    SHARED TYPEOF(E_Vehicle(__cfg_Local).__Result) __E_Vehicle := E_Vehicle_Filtered.__Result;
    SHARED TYPEOF(E_Zip_Code(__cfg_Local).__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
  END;
  SHARED B_Criminal_Offense_Local := MODULE(B_Criminal_Offense(__cfg_Local))
    SHARED TYPEOF(B_Criminal_Offense_1(__cfg_Local).__ENH_Criminal_Offense_1) __ENH_Criminal_Offense_1 := B_Criminal_Offense_1_Local.__ENH_Criminal_Offense_1;
  END;
  SHARED B_Education_Local := MODULE(B_Education(__cfg_Local))
    SHARED TYPEOF(B_Education_1(__cfg_Local).__ENH_Education_1) __ENH_Education_1 := B_Education_1_Local.__ENH_Education_1;
  END;
  SHARED B_Email_Local := MODULE(B_Email(__cfg_Local))
    SHARED TYPEOF(B_Email_1(__cfg_Local).__ENH_Email_1) __ENH_Email_1 := B_Email_1_Local.__ENH_Email_1;
  END;
  SHARED B_First_Degree_Relative_Local := MODULE(B_First_Degree_Relative(__cfg_Local))
    SHARED TYPEOF(B_First_Degree_Relative_1(__cfg_Local).__ENH_First_Degree_Relative_1) __ENH_First_Degree_Relative_1 := B_First_Degree_Relative_1_Local.__ENH_First_Degree_Relative_1;
  END;
  SHARED B_Inquiry_Local := MODULE(B_Inquiry(__cfg_Local))
    SHARED TYPEOF(B_Inquiry_1(__cfg_Local).__ENH_Inquiry_1) __ENH_Inquiry_1 := B_Inquiry_1_Local.__ENH_Inquiry_1;
  END;
  SHARED B_Lien_Judgment_Local := MODULE(B_Lien_Judgment(__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_1(__cfg_Local).__ENH_Lien_Judgment_1) __ENH_Lien_Judgment_1 := B_Lien_Judgment_1_Local.__ENH_Lien_Judgment_1;
  END;
  SHARED B_Person_Local := MODULE(B_Person(__cfg_Local))
    SHARED TYPEOF(B_Aircraft_Owner_1(__cfg_Local).__ENH_Aircraft_Owner_1) __ENH_Aircraft_Owner_1 := B_Aircraft_Owner_1_Local.__ENH_Aircraft_Owner_1;
    SHARED TYPEOF(B_Bankruptcy_1(__cfg_Local).__ENH_Bankruptcy_1) __ENH_Bankruptcy_1 := B_Bankruptcy_1_Local.__ENH_Bankruptcy_1;
    SHARED TYPEOF(B_Criminal_Offense_1(__cfg_Local).__ENH_Criminal_Offense_1) __ENH_Criminal_Offense_1 := B_Criminal_Offense_1_Local.__ENH_Criminal_Offense_1;
    SHARED TYPEOF(B_Education_1(__cfg_Local).__ENH_Education_1) __ENH_Education_1 := B_Education_1_Local.__ENH_Education_1;
    SHARED TYPEOF(B_Input_P_I_I_1(__cfg_Local).__ENH_Input_P_I_I_1) __ENH_Input_P_I_I_1 := B_Input_P_I_I_1_Local.__ENH_Input_P_I_I_1;
    SHARED TYPEOF(B_Person_1(__cfg_Local).__ENH_Person_1) __ENH_Person_1 := B_Person_1_Local.__ENH_Person_1;
    SHARED TYPEOF(E_Person_Bankruptcy(__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(E_Person_Education(__cfg_Local).__Result) __E_Person_Education := E_Person_Education_Filtered.__Result;
    SHARED TYPEOF(E_Person_Offenses(__cfg_Local).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
    SHARED TYPEOF(B_Person_Property_1(__cfg_Local).__ENH_Person_Property_1) __ENH_Person_Property_1 := B_Person_Property_1_Local.__ENH_Person_Property_1;
    SHARED TYPEOF(B_Person_S_S_N_1(__cfg_Local).__ENH_Person_S_S_N_1) __ENH_Person_S_S_N_1 := B_Person_S_S_N_1_Local.__ENH_Person_S_S_N_1;
    SHARED TYPEOF(B_Person_Vehicle_1(__cfg_Local).__ENH_Person_Vehicle_1) __ENH_Person_Vehicle_1 := B_Person_Vehicle_1_Local.__ENH_Person_Vehicle_1;
    SHARED TYPEOF(B_Professional_License_1(__cfg_Local).__ENH_Professional_License_1) __ENH_Professional_License_1 := B_Professional_License_1_Local.__ENH_Professional_License_1;
    SHARED TYPEOF(E_Professional_License_Person(__cfg_Local).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered.__Result;
    SHARED TYPEOF(B_Property_Event_1(__cfg_Local).__ENH_Property_Event_1) __ENH_Property_Event_1 := B_Property_Event_1_Local.__ENH_Property_Event_1;
    SHARED TYPEOF(B_Watercraft_Owner_1(__cfg_Local).__ENH_Watercraft_Owner_1) __ENH_Watercraft_Owner_1 := B_Watercraft_Owner_1_Local.__ENH_Watercraft_Owner_1;
  END;
  SHARED B_Professional_License_Local := MODULE(B_Professional_License(__cfg_Local))
    SHARED TYPEOF(B_Professional_License_1(__cfg_Local).__ENH_Professional_License_1) __ENH_Professional_License_1 := B_Professional_License_1_Local.__ENH_Professional_License_1;
  END;
  SHARED B_Property_Local := MODULE(B_Property(__cfg_Local))
    SHARED TYPEOF(B_Property_1(__cfg_Local).__ENH_Property_1) __ENH_Property_1 := B_Property_1_Local.__ENH_Property_1;
  END;
  SHARED B_Property_Event_Local := MODULE(B_Property_Event(__cfg_Local))
    SHARED TYPEOF(B_Property_Event_1(__cfg_Local).__ENH_Property_Event_1) __ENH_Property_Event_1 := B_Property_Event_1_Local.__ENH_Property_Event_1;
  END;
  SHARED B_Second_Degree_Associations_Local := MODULE(B_Second_Degree_Associations(__cfg_Local))
    SHARED TYPEOF(E_First_Degree_Associations(__cfg_Local).__Result) __E_First_Degree_Associations := E_First_Degree_Associations_Filtered.__Result;
  END;
  SHARED B_Tradeline_Local := MODULE(B_Tradeline(__cfg_Local))
    SHARED TYPEOF(B_Tradeline_1(__cfg_Local).__ENH_Tradeline_1) __ENH_Tradeline_1 := B_Tradeline_1_Local.__ENH_Tradeline_1;
  END;
  SHARED B_U_C_C_Local := MODULE(B_U_C_C(__cfg_Local))
    SHARED TYPEOF(B_U_C_C_1(__cfg_Local).__ENH_U_C_C_1) __ENH_U_C_C_1 := B_U_C_C_1_Local.__ENH_U_C_C_1;
  END;
  SHARED TYPEOF(E_Accident(__cfg_Local).__Result) __E_Accident := E_Accident_Filtered.__Result;
  SHARED TYPEOF(B_Address(__cfg_Local).__ENH_Address) __ENH_Address := B_Address_Local.__ENH_Address;
  SHARED TYPEOF(E_Address(__cfg_Local).__Result) __E_Address := E_Address_Filtered.__Result;
  SHARED TYPEOF(E_Address_Inquiry(__cfg_Local).__Result) __E_Address_Inquiry := E_Address_Inquiry_Filtered.__Result;
  SHARED TYPEOF(E_Address_Phone(__cfg_Local).__Result) __E_Address_Phone := E_Address_Phone_Filtered.__Result;
  SHARED TYPEOF(E_Address_Property(__cfg_Local).__Result) __E_Address_Property := E_Address_Property_Filtered.__Result;
  SHARED TYPEOF(E_Address_Property_Event(__cfg_Local).__Result) __E_Address_Property_Event := E_Address_Property_Event_Filtered.__Result;
  SHARED TYPEOF(E_Aircraft(__cfg_Local).__Result) __E_Aircraft := E_Aircraft_Filtered.__Result;
  SHARED TYPEOF(E_Aircraft_Owner(__cfg_Local).__Result) __E_Aircraft_Owner := E_Aircraft_Owner_Filtered.__Result;
  SHARED TYPEOF(B_Bankruptcy(__cfg_Local).__ENH_Bankruptcy) __ENH_Bankruptcy := B_Bankruptcy_Local.__ENH_Bankruptcy;
  SHARED TYPEOF(E_Bankruptcy(__cfg_Local).__Result) __E_Bankruptcy := E_Bankruptcy_Filtered.__Result;
  SHARED TYPEOF(B_Business_Prox(__cfg_Local).__ENH_Business_Prox) __ENH_Business_Prox := B_Business_Prox_Local.__ENH_Business_Prox;
  SHARED TYPEOF(E_Business_Prox(__cfg_Local).__Result) __E_Business_Prox := E_Business_Prox_Filtered.__Result;
  SHARED TYPEOF(B_Business_Sele(__cfg_Local).__ENH_Business_Sele) __ENH_Business_Sele := B_Business_Sele_Local.__ENH_Business_Sele;
  SHARED TYPEOF(E_Business_Sele(__cfg_Local).__Result) __E_Business_Sele := E_Business_Sele_Filtered.__Result;
  SHARED TYPEOF(E_Criminal_Details(__cfg_Local).__Result) __E_Criminal_Details := E_Criminal_Details_Filtered.__Result;
  SHARED TYPEOF(E_Criminal_Offender(__cfg_Local).__Result) __E_Criminal_Offender := E_Criminal_Offender_Filtered.__Result;
  SHARED TYPEOF(B_Criminal_Offense(__cfg_Local).__ENH_Criminal_Offense) __ENH_Criminal_Offense := B_Criminal_Offense_Local.__ENH_Criminal_Offense;
  SHARED TYPEOF(E_Criminal_Offense(__cfg_Local).__Result) __E_Criminal_Offense := E_Criminal_Offense_Filtered.__Result;
  SHARED TYPEOF(E_Criminal_Punishment(__cfg_Local).__Result) __E_Criminal_Punishment := E_Criminal_Punishment_Filtered.__Result;
  SHARED TYPEOF(E_Drivers_License(__cfg_Local).__Result) __E_Drivers_License := E_Drivers_License_Filtered.__Result;
  SHARED TYPEOF(E_E_B_R_Tradeline(__cfg_Local).__Result) __E_E_B_R_Tradeline := E_E_B_R_Tradeline_Filtered.__Result;
  SHARED TYPEOF(B_Education(__cfg_Local).__ENH_Education) __ENH_Education := B_Education_Local.__ENH_Education;
  SHARED TYPEOF(E_Education(__cfg_Local).__Result) __E_Education := E_Education_Filtered.__Result;
  SHARED TYPEOF(B_Email(__cfg_Local).__ENH_Email) __ENH_Email := B_Email_Local.__ENH_Email;
  SHARED TYPEOF(E_Email(__cfg_Local).__Result) __E_Email := E_Email_Filtered.__Result;
  SHARED TYPEOF(E_Email_Inquiry(__cfg_Local).__Result) __E_Email_Inquiry := E_Email_Inquiry_Filtered.__Result;
  SHARED TYPEOF(E_First_Degree_Associations(__cfg_Local).__Result) __E_First_Degree_Associations := E_First_Degree_Associations_Filtered.__Result;
  SHARED TYPEOF(B_First_Degree_Relative(__cfg_Local).__ENH_First_Degree_Relative) __ENH_First_Degree_Relative := B_First_Degree_Relative_Local.__ENH_First_Degree_Relative;
  SHARED TYPEOF(E_First_Degree_Relative(__cfg_Local).__Result) __E_First_Degree_Relative := E_First_Degree_Relative_Filtered.__Result;
  SHARED TYPEOF(E_House_Hold_Phone(__cfg_Local).__Result) __E_House_Hold_Phone := E_House_Hold_Phone_Filtered.__Result;
  SHARED TYPEOF(E_Household(__cfg_Local).__Result) __E_Household := E_Household_Filtered.__Result;
  SHARED TYPEOF(E_Household_Member(__cfg_Local).__Result) __E_Household_Member := E_Household_Member_Filtered.__Result;
  SHARED TYPEOF(B_Inquiry(__cfg_Local).__ENH_Inquiry) __ENH_Inquiry := B_Inquiry_Local.__ENH_Inquiry;
  SHARED TYPEOF(B_Lien_Judgment(__cfg_Local).__ENH_Lien_Judgment) __ENH_Lien_Judgment := B_Lien_Judgment_Local.__ENH_Lien_Judgment;
  SHARED TYPEOF(E_Lien_Judgment(__cfg_Local).__Result) __E_Lien_Judgment := E_Lien_Judgment_Filtered.__Result;
  SHARED TYPEOF(B_Person(__cfg_Local).__ENH_Person) __ENH_Person := B_Person_Local.__ENH_Person;
  SHARED TYPEOF(E_Person(__cfg_Local).__Result) __E_Person := E_Person_Filtered.__Result;
  SHARED TYPEOF(E_Person_Accident(__cfg_Local).__Result) __E_Person_Accident := E_Person_Accident_Filtered.__Result;
  SHARED TYPEOF(E_Person_Address(__cfg_Local).__Result) __E_Person_Address := E_Person_Address_Filtered.__Result;
  SHARED TYPEOF(E_Person_Bankruptcy(__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
  SHARED TYPEOF(E_Person_Drivers_License(__cfg_Local).__Result) __E_Person_Drivers_License := E_Person_Drivers_License_Filtered.__Result;
  SHARED TYPEOF(E_Person_Education(__cfg_Local).__Result) __E_Person_Education := E_Person_Education_Filtered.__Result;
  SHARED TYPEOF(E_Person_Email(__cfg_Local).__Result) __E_Person_Email := E_Person_Email_Filtered.__Result;
  SHARED TYPEOF(E_Person_Email_Phone_Address(__cfg_Local).__Result) __E_Person_Email_Phone_Address := E_Person_Email_Phone_Address_Filtered.__Result;
  SHARED TYPEOF(E_Person_Inquiry(__cfg_Local).__Result) __E_Person_Inquiry := E_Person_Inquiry_Filtered.__Result;
  SHARED TYPEOF(E_Person_Lien_Judgment(__cfg_Local).__Result) __E_Person_Lien_Judgment := E_Person_Lien_Judgment_Filtered.__Result;
  SHARED TYPEOF(E_Person_Offender(__cfg_Local).__Result) __E_Person_Offender := E_Person_Offender_Filtered.__Result;
  SHARED TYPEOF(E_Person_Offenses(__cfg_Local).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
  SHARED TYPEOF(E_Person_Phone(__cfg_Local).__Result) __E_Person_Phone := E_Person_Phone_Filtered.__Result;
  SHARED TYPEOF(E_Person_Property(__cfg_Local).__Result) __E_Person_Property := E_Person_Property_Filtered.__Result;
  SHARED TYPEOF(E_Person_Property_Event(__cfg_Local).__Result) __E_Person_Property_Event := E_Person_Property_Event_Filtered.__Result;
  SHARED TYPEOF(E_Person_S_S_N(__cfg_Local).__Result) __E_Person_S_S_N := E_Person_S_S_N_Filtered.__Result;
  SHARED TYPEOF(E_Person_Sex_Offender(__cfg_Local).__Result) __E_Person_Sex_Offender := E_Person_Sex_Offender_Filtered.__Result;
  SHARED TYPEOF(E_Person_Vehicle(__cfg_Local).__Result) __E_Person_Vehicle := E_Person_Vehicle_Filtered.__Result;
  SHARED TYPEOF(E_Phone(__cfg_Local).__Result) __E_Phone := E_Phone_Filtered.__Result;
  SHARED TYPEOF(E_Phone_Inquiry(__cfg_Local).__Result) __E_Phone_Inquiry := E_Phone_Inquiry_Filtered.__Result;
  SHARED TYPEOF(B_Professional_License(__cfg_Local).__ENH_Professional_License) __ENH_Professional_License := B_Professional_License_Local.__ENH_Professional_License;
  SHARED TYPEOF(E_Professional_License(__cfg_Local).__Result) __E_Professional_License := E_Professional_License_Filtered.__Result;
  SHARED TYPEOF(E_Professional_License_Person(__cfg_Local).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered.__Result;
  SHARED TYPEOF(B_Property(__cfg_Local).__ENH_Property) __ENH_Property := B_Property_Local.__ENH_Property;
  SHARED TYPEOF(E_Property(__cfg_Local).__Result) __E_Property := E_Property_Filtered.__Result;
  SHARED TYPEOF(B_Property_Event(__cfg_Local).__ENH_Property_Event) __ENH_Property_Event := B_Property_Event_Local.__ENH_Property_Event;
  SHARED TYPEOF(E_Property_Event(__cfg_Local).__Result) __E_Property_Event := E_Property_Event_Filtered.__Result;
  SHARED TYPEOF(E_Prox_Address(__cfg_Local).__Result) __E_Prox_Address := E_Prox_Address_Filtered.__Result;
  SHARED TYPEOF(E_Prox_Email(__cfg_Local).__Result) __E_Prox_Email := E_Prox_Email_Filtered.__Result;
  SHARED TYPEOF(E_Prox_Person(__cfg_Local).__Result) __E_Prox_Person := E_Prox_Person_Filtered.__Result;
  SHARED TYPEOF(E_Prox_Phone_Number(__cfg_Local).__Result) __E_Prox_Phone_Number := E_Prox_Phone_Number_Filtered.__Result;
  SHARED TYPEOF(E_Prox_T_I_N(__cfg_Local).__Result) __E_Prox_T_I_N := E_Prox_T_I_N_Filtered.__Result;
  SHARED TYPEOF(E_Prox_Utility(__cfg_Local).__Result) __E_Prox_Utility := E_Prox_Utility_Filtered.__Result;
  SHARED TYPEOF(E_S_S_N_Address(__cfg_Local).__Result) __E_S_S_N_Address := E_S_S_N_Address_Filtered.__Result;
  SHARED TYPEOF(E_S_S_N_Inquiry(__cfg_Local).__Result) __E_S_S_N_Inquiry := E_S_S_N_Inquiry_Filtered.__Result;
  SHARED TYPEOF(B_Second_Degree_Associations(__cfg_Local).__ENH_Second_Degree_Associations) __ENH_Second_Degree_Associations := B_Second_Degree_Associations_Local.__ENH_Second_Degree_Associations;
  SHARED TYPEOF(E_Second_Degree_Associations(__cfg_Local).__Result) __E_Second_Degree_Associations := E_Second_Degree_Associations_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Address(__cfg_Local).__Result) __E_Sele_Address := E_Sele_Address_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Aircraft(__cfg_Local).__Result) __E_Sele_Aircraft := E_Sele_Aircraft_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Bankruptcy(__cfg_Local).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered.__Result;
  SHARED TYPEOF(E_Sele_E_B_R_Tradeline(__cfg_Local).__Result) __E_Sele_E_B_R_Tradeline := E_Sele_E_B_R_Tradeline_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Email(__cfg_Local).__Result) __E_Sele_Email := E_Sele_Email_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Inquiry(__cfg_Local).__Result) __E_Sele_Inquiry := E_Sele_Inquiry_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Lien_Judgment(__cfg_Local).__Result) __E_Sele_Lien_Judgment := E_Sele_Lien_Judgment_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Person(__cfg_Local).__Result) __E_Sele_Person := E_Sele_Person_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Phone_Number(__cfg_Local).__Result) __E_Sele_Phone_Number := E_Sele_Phone_Number_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Property(__cfg_Local).__Result) __E_Sele_Property := E_Sele_Property_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Property_Event(__cfg_Local).__Result) __E_Sele_Property_Event := E_Sele_Property_Event_Filtered.__Result;
  SHARED TYPEOF(E_Sele_T_I_N(__cfg_Local).__Result) __E_Sele_T_I_N := E_Sele_T_I_N_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Tradeline(__cfg_Local).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered.__Result;
  SHARED TYPEOF(E_Sele_U_C_C(__cfg_Local).__Result) __E_Sele_U_C_C := E_Sele_U_C_C_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Utility(__cfg_Local).__Result) __E_Sele_Utility := E_Sele_Utility_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Vehicle(__cfg_Local).__Result) __E_Sele_Vehicle := E_Sele_Vehicle_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Watercraft(__cfg_Local).__Result) __E_Sele_Watercraft := E_Sele_Watercraft_Filtered.__Result;
  SHARED TYPEOF(E_Sex_Offender(__cfg_Local).__Result) __E_Sex_Offender := E_Sex_Offender_Filtered.__Result;
  SHARED TYPEOF(E_Social_Security_Number(__cfg_Local).__Result) __E_Social_Security_Number := E_Social_Security_Number_Filtered.__Result;
  SHARED TYPEOF(E_T_I_N(__cfg_Local).__Result) __E_T_I_N := E_T_I_N_Filtered.__Result;
  SHARED TYPEOF(E_T_I_N_Address(__cfg_Local).__Result) __E_T_I_N_Address := E_T_I_N_Address_Filtered.__Result;
  SHARED TYPEOF(E_T_I_N_Inquiry(__cfg_Local).__Result) __E_T_I_N_Inquiry := E_T_I_N_Inquiry_Filtered.__Result;
  SHARED TYPEOF(E_T_I_N_Phone_Number(__cfg_Local).__Result) __E_T_I_N_Phone_Number := E_T_I_N_Phone_Number_Filtered.__Result;
  SHARED TYPEOF(B_Tradeline(__cfg_Local).__ENH_Tradeline) __ENH_Tradeline := B_Tradeline_Local.__ENH_Tradeline;
  SHARED TYPEOF(E_Tradeline(__cfg_Local).__Result) __E_Tradeline := E_Tradeline_Filtered.__Result;
  SHARED TYPEOF(B_U_C_C(__cfg_Local).__ENH_U_C_C) __ENH_U_C_C := B_U_C_C_Local.__ENH_U_C_C;
  SHARED TYPEOF(E_U_C_C(__cfg_Local).__Result) __E_U_C_C := E_U_C_C_Filtered.__Result;
  SHARED TYPEOF(E_Utility(__cfg_Local).__Result) __E_Utility := E_Utility_Filtered.__Result;
  SHARED TYPEOF(E_Utility_Address(__cfg_Local).__Result) __E_Utility_Address := E_Utility_Address_Filtered.__Result;
  SHARED TYPEOF(E_Utility_Person(__cfg_Local).__Result) __E_Utility_Person := E_Utility_Person_Filtered.__Result;
  SHARED TYPEOF(E_Vehicle(__cfg_Local).__Result) __E_Vehicle := E_Vehicle_Filtered.__Result;
  SHARED TYPEOF(E_Watercraft(__cfg_Local).__Result) __E_Watercraft := E_Watercraft_Filtered.__Result;
  SHARED TYPEOF(E_Watercraft_Owner(__cfg_Local).__Result) __E_Watercraft_Owner := E_Watercraft_Owner_Filtered.__Result;
  SHARED TYPEOF(E_Zip_Code(__cfg_Local).__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
  SHARED TYPEOF(E_Zip_Code_Person(__cfg_Local).__Result) __E_Zip_Code_Person := E_Zip_Code_Person_Filtered.__Result;
  SHARED __EE12880527 := __ENH_Inquiry;
  SHARED __EE5163468 := __E_Address_Inquiry;
  SHARED __EE12880993 := __EE5163468(__NN(__EE5163468.Location_) AND __NN(__EE5163468.Transaction_));
  SHARED __EE5163462 := __E_Address;
  SHARED __EE12881223 := __EE5163462(__T(__OP2(__EE5163462.UID,=,__CN(__PAddressUID))));
  __JC12881229(E_Address_Inquiry(__cfg_Local).Layout __EE12880993, E_Address(__cfg_Local).Layout __EE12881223) := __EEQP(__EE12881223.UID,__EE12880993.Location_);
  SHARED __EE12881245 := JOIN(__EE12880993,__EE12881223,__JC12881229(LEFT,RIGHT),TRANSFORM(E_Address_Inquiry(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC12881251(B_Inquiry(__cfg_Local).__ST157264_Layout __EE12880527, E_Address_Inquiry(__cfg_Local).Layout __EE12881245) := __EEQP(__EE12881245.Transaction_,__EE12880527.UID);
  SHARED __EE12881328 := JOIN(__EE12880527,__EE12881245,__JC12881251(LEFT,RIGHT),TRANSFORM(B_Inquiry(__cfg_Local).__ST157264_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE12881330 := __EE12881328;
  EXPORT Res0 := __UNWRAP(__EE12881330);
  SHARED __EE5163654 := __E_Phone;
  SHARED __EE5163644 := __E_Address_Phone;
  SHARED __EE12882095 := __EE5163644(__NN(__EE5163644.Location_) AND __NN(__EE5163644.Phone_Number_));
  SHARED __EE5163638 := __E_Address;
  SHARED __EE12882359 := __EE5163638(__T(__OP2(__EE5163638.UID,=,__CN(__PAddressUID))));
  __JC12882365(E_Address_Phone(__cfg_Local).Layout __EE12882095, E_Address(__cfg_Local).Layout __EE12882359) := __EEQP(__EE12882359.UID,__EE12882095.Location_);
  SHARED __EE12882410 := JOIN(__EE12882095,__EE12882359,__JC12882365(LEFT,RIGHT),TRANSFORM(E_Address_Phone(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC12882416(E_Phone(__cfg_Local).Layout __EE5163654, E_Address_Phone(__cfg_Local).Layout __EE12882410) := __EEQP(__EE12882410.Phone_Number_,__EE5163654.UID);
  SHARED __EE12882498 := JOIN(__EE5163654,__EE12882410,__JC12882416(LEFT,RIGHT),TRANSFORM(E_Phone(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE12882500 := __EE12882498;
  EXPORT Res1 := __UNWRAP(__EE12882500);
  SHARED __EE12882753 := __ENH_Property;
  SHARED __EE5163857 := __E_Address_Property;
  SHARED __EE12883119 := __EE5163857(__NN(__EE5163857.Location_) AND __NN(__EE5163857.Prop_));
  SHARED __EE5163851 := __E_Address;
  SHARED __EE12883318 := __EE5163851(__T(__OP2(__EE5163851.UID,=,__CN(__PAddressUID))));
  __JC12883324(E_Address_Property(__cfg_Local).Layout __EE12883119, E_Address(__cfg_Local).Layout __EE12883318) := __EEQP(__EE12883318.UID,__EE12883119.Location_);
  SHARED __EE12883348 := JOIN(__EE12883119,__EE12883318,__JC12883324(LEFT,RIGHT),TRANSFORM(E_Address_Property(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC12883354(B_Property(__cfg_Local).__ST172673_Layout __EE12882753, E_Address_Property(__cfg_Local).Layout __EE12883348) := __EEQP(__EE12883348.Prop_,__EE12882753.UID);
  SHARED __EE12883392 := JOIN(__EE12882753,__EE12883348,__JC12883354(LEFT,RIGHT),TRANSFORM(B_Property(__cfg_Local).__ST172673_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE12883394 := __EE12883392;
  EXPORT Res2 := __UNWRAP(__EE12883394);
  SHARED __EE12883517 := __ENH_Property_Event;
  SHARED __EE5164001 := __E_Address_Property_Event;
  SHARED __EE12884022 := __EE5164001(__NN(__EE5164001.Location_) AND __NN(__EE5164001.Event_));
  SHARED __EE5163995 := __E_Address;
  SHARED __EE12884249 := __EE5163995(__T(__OP2(__EE5163995.UID,=,__CN(__PAddressUID))));
  __JC12884255(E_Address_Property_Event(__cfg_Local).Layout __EE12884022, E_Address(__cfg_Local).Layout __EE12884249) := __EEQP(__EE12884249.UID,__EE12884022.Location_);
  SHARED __EE12884277 := JOIN(__EE12884022,__EE12884249,__JC12884255(LEFT,RIGHT),TRANSFORM(E_Address_Property_Event(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC12884283(B_Property_Event_6(__cfg_Local).__ST254782_Layout __EE12883517, E_Address_Property_Event(__cfg_Local).Layout __EE12884277) := __EEQP(__EE12884277.Event_,__EE12883517.UID);
  SHARED __EE12884351 := JOIN(__EE12883517,__EE12884277,__JC12884283(LEFT,RIGHT),TRANSFORM(B_Property_Event_6(__cfg_Local).__ST254782_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE12884353 := __EE12884351;
  EXPORT Res3 := __UNWRAP(__EE12884353);
  SHARED __EE12884532 := __ENH_Person;
  SHARED __EE5164170 := __E_Person_Address;
  SHARED __EE12891693 := __EE5164170(__NN(__EE5164170.Location_) AND __NN(__EE5164170.Subject_));
  SHARED __EE5164164 := __E_Address;
  SHARED __EE12893930 := __EE5164164(__T(__OP2(__EE5164164.UID,=,__CN(__PAddressUID))));
  __JC12893936(E_Person_Address(__cfg_Local).Layout __EE12891693, E_Address(__cfg_Local).Layout __EE12893930) := __EEQP(__EE12893930.UID,__EE12891693.Location_);
  SHARED __EE12893995 := JOIN(__EE12891693,__EE12893930,__JC12893936(LEFT,RIGHT),TRANSFORM(E_Person_Address(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC12894001(B_Person(__cfg_Local).__ST170352_Layout __EE12884532, E_Person_Address(__cfg_Local).Layout __EE12893995) := __EEQP(__EE12893995.Subject_,__EE12884532.UID);
  SHARED __EE12896042 := JOIN(__EE12884532,__EE12893995,__JC12894001(LEFT,RIGHT),TRANSFORM(B_Person(__cfg_Local).__ST170352_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE12896044 := __EE12896042;
  EXPORT Res4 := __UNWRAP(__EE12896044);
  SHARED __EE12900243 := __ENH_Business_Prox;
  SHARED __EE5166509 := __E_Prox_Address;
  SHARED __EE12901434 := __EE5166509(__NN(__EE5166509.Location_) AND __NN(__EE5166509.Business_Location_));
  SHARED __EE5166503 := __E_Address;
  SHARED __EE12901891 := __EE5166503(__T(__OP2(__EE5166503.UID,=,__CN(__PAddressUID))));
  __JC12901897(E_Prox_Address(__cfg_Local).Layout __EE12901434, E_Address(__cfg_Local).Layout __EE12901891) := __EEQP(__EE12901891.UID,__EE12901434.Location_);
  SHARED __EE12901953 := JOIN(__EE12901434,__EE12901891,__JC12901897(LEFT,RIGHT),TRANSFORM(E_Prox_Address(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC12901959(B_Business_Prox(__cfg_Local).__ST131603_Layout __EE12900243, E_Prox_Address(__cfg_Local).Layout __EE12901953) := __EEQP(__EE12901953.Business_Location_,__EE12900243.UID);
  SHARED __EE12902223 := JOIN(__EE12900243,__EE12901953,__JC12901959(LEFT,RIGHT),TRANSFORM(B_Business_Prox(__cfg_Local).__ST131603_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE12902225 := __EE12902223;
  EXPORT Res5 := __UNWRAP(__EE12902225);
  SHARED __EE12902864 := __ENH_Business_Sele;
  SHARED __EE5166939 := __E_Sele_Address;
  SHARED __EE12908216 := __EE5166939(__NN(__EE5166939.Location_) AND __NN(__EE5166939.Legal_));
  SHARED __EE5166933 := __E_Address;
  SHARED __EE12909810 := __EE5166933(__T(__OP2(__EE5166933.UID,=,__CN(__PAddressUID))));
  __JC12909816(E_Sele_Address(__cfg_Local).Layout __EE12908216, E_Address(__cfg_Local).Layout __EE12909810) := __EEQP(__EE12909810.UID,__EE12908216.Location_);
  SHARED __EE12909872 := JOIN(__EE12908216,__EE12909810,__JC12909816(LEFT,RIGHT),TRANSFORM(E_Sele_Address(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC12909878(B_Business_Sele(__cfg_Local).__ST149491_Layout __EE12902864, E_Sele_Address(__cfg_Local).Layout __EE12909872) := __EEQP(__EE12909872.Legal_,__EE12902864.UID);
  SHARED __EE12911279 := JOIN(__EE12902864,__EE12909872,__JC12909878(LEFT,RIGHT),TRANSFORM(B_Business_Sele(__cfg_Local).__ST149491_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE12911281 := __EE12911279;
  EXPORT Res6 := __UNWRAP(__EE12911281);
  SHARED __EE5168577 := __E_T_I_N;
  SHARED __EE5168567 := __E_T_I_N_Address;
  SHARED __EE12914401 := __EE5168567(__NN(__EE5168567.Location_) AND __NN(__EE5168567.Tax_I_D_));
  SHARED __EE5168561 := __E_Address;
  SHARED __EE12914557 := __EE5168561(__T(__OP2(__EE5168561.UID,=,__CN(__PAddressUID))));
  __JC12914563(E_T_I_N_Address(__cfg_Local).Layout __EE12914401, E_Address(__cfg_Local).Layout __EE12914557) := __EEQP(__EE12914557.UID,__EE12914401.Location_);
  SHARED __EE12914578 := JOIN(__EE12914401,__EE12914557,__JC12914563(LEFT,RIGHT),TRANSFORM(E_T_I_N_Address(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC12914584(E_T_I_N(__cfg_Local).Layout __EE5168577, E_T_I_N_Address(__cfg_Local).Layout __EE12914578) := __EEQP(__EE12914578.Tax_I_D_,__EE5168577.UID);
  SHARED __EE12914588 := JOIN(__EE5168577,__EE12914578,__JC12914584(LEFT,RIGHT),TRANSFORM(E_T_I_N(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE12914590 := __EE12914588;
  EXPORT Res7 := __UNWRAP(__EE12914590);
  SHARED __EE5168672 := __E_Utility;
  SHARED __EE5168662 := __E_Utility_Address;
  SHARED __EE12914878 := __EE5168662(__NN(__EE5168662.Location_) AND __NN(__EE5168662.Util_));
  SHARED __EE5168656 := __E_Address;
  SHARED __EE12915055 := __EE5168656(__T(__OP2(__EE5168656.UID,=,__CN(__PAddressUID))));
  __JC12915061(E_Utility_Address(__cfg_Local).Layout __EE12914878, E_Address(__cfg_Local).Layout __EE12915055) := __EEQP(__EE12915055.UID,__EE12914878.Location_);
  SHARED __EE12915075 := JOIN(__EE12914878,__EE12915055,__JC12915061(LEFT,RIGHT),TRANSFORM(E_Utility_Address(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC12915081(E_Utility(__cfg_Local).Layout __EE5168672, E_Utility_Address(__cfg_Local).Layout __EE12915075) := __EEQP(__EE12915075.Util_,__EE5168672.UID);
  SHARED __EE12915107 := JOIN(__EE5168672,__EE12915075,__JC12915081(LEFT,RIGHT),TRANSFORM(E_Utility(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE12915109 := __EE12915107;
  EXPORT Res8 := __UNWRAP(__EE12915109);
  SHARED __EE12915188 := __ENH_Address;
  SHARED __EE5168780 := __E_Prox_Address;
  SHARED __EE12916173 := __EE5168780(__NN(__EE5168780.Business_Location_) AND __NN(__EE5168780.Location_));
  SHARED __EE12915191 := __ENH_Business_Prox;
  SHARED __EE12916652 := __EE12915191(__T(__OP2(__EE12915191.UID,=,__CN(__PBusinessProxUID))));
  __JC12916658(E_Prox_Address(__cfg_Local).Layout __EE12916173, B_Business_Prox(__cfg_Local).__ST131603_Layout __EE12916652) := __EEQP(__EE12916652.UID,__EE12916173.Business_Location_);
  SHARED __EE12916714 := JOIN(__EE12916173,__EE12916652,__JC12916658(LEFT,RIGHT),TRANSFORM(E_Prox_Address(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC12916720(B_Address_1(__cfg_Local).__ST174206_Layout __EE12915188, E_Prox_Address(__cfg_Local).Layout __EE12916714) := __EEQP(__EE12916714.Location_,__EE12915188.UID);
  SHARED __EE12916878 := JOIN(__EE12915188,__EE12916714,__JC12916720(LEFT,RIGHT),TRANSFORM(B_Address_1(__cfg_Local).__ST174206_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE12916880 := __EE12916878;
  EXPORT Res9 := __UNWRAP(__EE12916880);
  SHARED __EE12917307 := __ENH_Person;
  SHARED __EE5169102 := __E_Prox_Person;
  SHARED __EE12924385 := __EE5169102(__NN(__EE5169102.Business_Location_) AND __NN(__EE5169102.Contact_));
  SHARED __EE12917310 := __ENH_Business_Prox;
  SHARED __EE12926719 := __EE12917310(__T(__OP2(__EE12917310.UID,=,__CN(__PBusinessProxUID))));
  __JC12926725(E_Prox_Person(__cfg_Local).Layout __EE12924385, B_Business_Prox(__cfg_Local).__ST131603_Layout __EE12926719) := __EEQP(__EE12926719.UID,__EE12924385.Business_Location_);
  SHARED __EE12926753 := JOIN(__EE12924385,__EE12926719,__JC12926725(LEFT,RIGHT),TRANSFORM(E_Prox_Person(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC12926759(B_Person(__cfg_Local).__ST170352_Layout __EE12917307, E_Prox_Person(__cfg_Local).Layout __EE12926753) := __EEQP(__EE12926753.Contact_,__EE12917307.UID);
  SHARED __EE12928800 := JOIN(__EE12917307,__EE12926753,__JC12926759(LEFT,RIGHT),TRANSFORM(B_Person(__cfg_Local).__ST170352_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE12928802 := __EE12928800;
  EXPORT Res10 := __UNWRAP(__EE12928802);
  SHARED __EE5171419 := __E_Phone;
  SHARED __EE5171409 := __E_Prox_Phone_Number;
  SHARED __EE12933603 := __EE5171409(__NN(__EE5171409.Business_Location_) AND __NN(__EE5171409.Phone_Number_));
  SHARED __EE12932939 := __ENH_Business_Prox;
  SHARED __EE12933987 := __EE12932939(__T(__OP2(__EE12932939.UID,=,__CN(__PBusinessProxUID))));
  __JC12933993(E_Prox_Phone_Number(__cfg_Local).Layout __EE12933603, B_Business_Prox(__cfg_Local).__ST131603_Layout __EE12933987) := __EEQP(__EE12933987.UID,__EE12933603.Business_Location_);
  SHARED __EE12934030 := JOIN(__EE12933603,__EE12933987,__JC12933993(LEFT,RIGHT),TRANSFORM(E_Prox_Phone_Number(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC12934036(E_Phone(__cfg_Local).Layout __EE5171419, E_Prox_Phone_Number(__cfg_Local).Layout __EE12934030) := __EEQP(__EE12934030.Phone_Number_,__EE5171419.UID);
  SHARED __EE12934118 := JOIN(__EE5171419,__EE12934030,__JC12934036(LEFT,RIGHT),TRANSFORM(E_Phone(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE12934120 := __EE12934118;
  EXPORT Res11 := __UNWRAP(__EE12934120);
  SHARED __EE5171627 := __E_T_I_N;
  SHARED __EE5171617 := __E_Prox_T_I_N;
  SHARED __EE12934644 := __EE5171617(__NN(__EE5171617.Business_Location_) AND __NN(__EE5171617.Tax_I_D_));
  SHARED __EE12934357 := __ENH_Business_Prox;
  SHARED __EE12934927 := __EE12934357(__T(__OP2(__EE12934357.UID,=,__CN(__PBusinessProxUID))));
  __JC12934933(E_Prox_T_I_N(__cfg_Local).Layout __EE12934644, B_Business_Prox(__cfg_Local).__ST131603_Layout __EE12934927) := __EEQP(__EE12934927.UID,__EE12934644.Business_Location_);
  SHARED __EE12934947 := JOIN(__EE12934644,__EE12934927,__JC12934933(LEFT,RIGHT),TRANSFORM(E_Prox_T_I_N(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC12934953(E_T_I_N(__cfg_Local).Layout __EE5171627, E_Prox_T_I_N(__cfg_Local).Layout __EE12934947) := __EEQP(__EE12934947.Tax_I_D_,__EE5171627.UID);
  SHARED __EE12934957 := JOIN(__EE5171627,__EE12934947,__JC12934953(LEFT,RIGHT),TRANSFORM(E_T_I_N(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE12934959 := __EE12934957;
  EXPORT Res12 := __UNWRAP(__EE12934959);
  SHARED __EE5171721 := __E_Utility;
  SHARED __EE5171711 := __E_Prox_Utility;
  SHARED __EE12935318 := __EE5171711(__NN(__EE5171711.Business_Location_) AND __NN(__EE5171711.Util_));
  SHARED __EE12934994 := __ENH_Business_Prox;
  SHARED __EE12935620 := __EE12934994(__T(__OP2(__EE12934994.UID,=,__CN(__PBusinessProxUID))));
  __JC12935626(E_Prox_Utility(__cfg_Local).Layout __EE12935318, B_Business_Prox(__cfg_Local).__ST131603_Layout __EE12935620) := __EEQP(__EE12935620.UID,__EE12935318.Business_Location_);
  SHARED __EE12935637 := JOIN(__EE12935318,__EE12935620,__JC12935626(LEFT,RIGHT),TRANSFORM(E_Prox_Utility(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC12935643(E_Utility(__cfg_Local).Layout __EE5171721, E_Prox_Utility(__cfg_Local).Layout __EE12935637) := __EEQP(__EE12935637.Util_,__EE5171721.UID);
  SHARED __EE12935669 := JOIN(__EE5171721,__EE12935637,__JC12935643(LEFT,RIGHT),TRANSFORM(E_Utility(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE12935671 := __EE12935669;
  EXPORT Res13 := __UNWRAP(__EE12935671);
  SHARED __EE12935744 := __ENH_Email;
  SHARED __EE5171827 := __E_Prox_Email;
  SHARED __EE12936163 := __EE5171827(__NN(__EE5171827.Business_Location_) AND __NN(__EE5171827.Email_));
  SHARED __EE12935747 := __ENH_Business_Prox;
  SHARED __EE12936483 := __EE12935747(__T(__OP2(__EE12935747.UID,=,__CN(__PBusinessProxUID))));
  __JC12936489(E_Prox_Email(__cfg_Local).Layout __EE12936163, B_Business_Prox(__cfg_Local).__ST131603_Layout __EE12936483) := __EEQP(__EE12936483.UID,__EE12936163.Business_Location_);
  SHARED __EE12936508 := JOIN(__EE12936163,__EE12936483,__JC12936489(LEFT,RIGHT),TRANSFORM(E_Prox_Email(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC12936514(B_Email_2(__cfg_Local).__ST209842_Layout __EE12935744, E_Prox_Email(__cfg_Local).Layout __EE12936508) := __EEQP(__EE12936508.Email_,__EE12935744.UID);
  SHARED __EE12936550 := JOIN(__EE12935744,__EE12936508,__JC12936514(LEFT,RIGHT),TRANSFORM(B_Email_2(__cfg_Local).__ST209842_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE12936552 := __EE12936550;
  EXPORT Res14 := __UNWRAP(__EE12936552);
  SHARED __EE12936661 := __ENH_Business_Sele;
  SHARED __EE12936664 := __ENH_Business_Prox;
  SHARED __EE12943700 := __EE12936664(__T(__AND(__OP2(__EE12936664.UID,=,__CN(__PBusinessProxUID)),__CN(__NN(__EE12936664.Prox_Sele_)))));
  __JC12943706(B_Business_Sele(__cfg_Local).__ST149491_Layout __EE12936661, B_Business_Prox(__cfg_Local).__ST131603_Layout __EE12943700) := __EEQP(__EE12943700.Prox_Sele_,__EE12936661.UID);
  SHARED __EE12945107 := JOIN(__EE12936661,__EE12943700,__JC12943706(LEFT,RIGHT),TRANSFORM(B_Business_Sele(__cfg_Local).__ST149491_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE12945109 := __EE12945107;
  EXPORT Res15 := __UNWRAP(__EE12945109);
  SHARED __EE5173517 := __E_E_B_R_Tradeline;
  SHARED __EE5173507 := __E_Sele_E_B_R_Tradeline;
  SHARED __EE12949830 := __EE5173507(__NN(__EE5173507.Legal_) AND __NN(__EE5173507.Tradeline_));
  SHARED __EE12947912 := __ENH_Business_Sele;
  SHARED __EE12951196 := __EE12947912(__T(__OP2(__EE12947912.UID,=,__CN(__PBusinessSeleUID))));
  __JC12951202(E_Sele_E_B_R_Tradeline(__cfg_Local).Layout __EE12949830, B_Business_Sele(__cfg_Local).__ST149491_Layout __EE12951196) := __EEQP(__EE12951196.UID,__EE12949830.Legal_);
  SHARED __EE12951214 := JOIN(__EE12949830,__EE12951196,__JC12951202(LEFT,RIGHT),TRANSFORM(E_Sele_E_B_R_Tradeline(__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC12951220(E_E_B_R_Tradeline(__cfg_Local).Layout __EE5173517, E_Sele_E_B_R_Tradeline(__cfg_Local).Layout __EE12951214) := __EEQP(__EE12951214.Tradeline_,__EE5173517.UID);
  SHARED __EE12951233 := JOIN(__EE5173517,__EE12951214,__JC12951220(LEFT,RIGHT),TRANSFORM(E_E_B_R_Tradeline(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE12951235 := __EE12951233;
  EXPORT Res16 := __UNWRAP(__EE12951235);
  SHARED __EE12951284 := __ENH_Email;
  SHARED __EE5173610 := __E_Sele_Email;
  SHARED __EE12953315 := __EE5173610(__NN(__EE5173610.Legal_) AND __NN(__EE5173610.Email_));
  SHARED __EE12951287 := __ENH_Business_Sele;
  SHARED __EE12954710 := __EE12951287(__T(__OP2(__EE12951287.UID,=,__CN(__PBusinessSeleUID))));
  __JC12954716(E_Sele_Email(__cfg_Local).Layout __EE12953315, B_Business_Sele(__cfg_Local).__ST149491_Layout __EE12954710) := __EEQP(__EE12954710.UID,__EE12953315.Legal_);
  SHARED __EE12954734 := JOIN(__EE12953315,__EE12954710,__JC12954716(LEFT,RIGHT),TRANSFORM(E_Sele_Email(__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC12954740(B_Email_2(__cfg_Local).__ST209842_Layout __EE12951284, E_Sele_Email(__cfg_Local).Layout __EE12954734) := __EEQP(__EE12954734.Email_,__EE12951284.UID);
  SHARED __EE12954776 := JOIN(__EE12951284,__EE12954734,__JC12954740(LEFT,RIGHT),TRANSFORM(B_Email_2(__cfg_Local).__ST209842_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE12954778 := __EE12954776;
  EXPORT Res17 := __UNWRAP(__EE12954778);
  SHARED __EE12954885 := __ENH_Address;
  SHARED __EE5173748 := __E_Sele_Address;
  SHARED __EE12957490 := __EE5173748(__NN(__EE5173748.Legal_) AND __NN(__EE5173748.Location_));
  SHARED __EE12954888 := __ENH_Business_Sele;
  SHARED __EE12959045 := __EE12954888(__T(__OP2(__EE12954888.UID,=,__CN(__PBusinessSeleUID))));
  __JC12959051(E_Sele_Address(__cfg_Local).Layout __EE12957490, B_Business_Sele(__cfg_Local).__ST149491_Layout __EE12959045) := __EEQP(__EE12959045.UID,__EE12957490.Legal_);
  SHARED __EE12959107 := JOIN(__EE12957490,__EE12959045,__JC12959051(LEFT,RIGHT),TRANSFORM(E_Sele_Address(__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC12959113(B_Address_1(__cfg_Local).__ST174206_Layout __EE12954885, E_Sele_Address(__cfg_Local).Layout __EE12959107) := __EEQP(__EE12959107.Location_,__EE12954885.UID);
  SHARED __EE12959271 := JOIN(__EE12954885,__EE12959107,__JC12959113(LEFT,RIGHT),TRANSFORM(B_Address_1(__cfg_Local).__ST174206_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE12959273 := __EE12959271;
  EXPORT Res18 := __UNWRAP(__EE12959273);
  SHARED __EE5174080 := __E_Aircraft;
  SHARED __EE5174070 := __E_Sele_Aircraft;
  SHARED __EE12961682 := __EE5174070(__NN(__EE5174070.Legal_) AND __NN(__EE5174070.Plane_));
  SHARED __EE12959700 := __ENH_Business_Sele;
  SHARED __EE12963063 := __EE12959700(__T(__OP2(__EE12959700.UID,=,__CN(__PBusinessSeleUID))));
  __JC12963069(E_Sele_Aircraft(__cfg_Local).Layout __EE12961682, B_Business_Sele(__cfg_Local).__ST149491_Layout __EE12963063) := __EEQP(__EE12963063.UID,__EE12961682.Legal_);
  SHARED __EE12963086 := JOIN(__EE12961682,__EE12963063,__JC12963069(LEFT,RIGHT),TRANSFORM(E_Sele_Aircraft(__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC12963092(E_Aircraft(__cfg_Local).Layout __EE5174080, E_Sele_Aircraft(__cfg_Local).Layout __EE12963086) := __EEQP(__EE12963086.Plane_,__EE5174080.UID);
  SHARED __EE12963115 := JOIN(__EE5174080,__EE12963086,__JC12963092(LEFT,RIGHT),TRANSFORM(E_Aircraft(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE12963117 := __EE12963115;
  EXPORT Res19 := __UNWRAP(__EE12963117);
  SHARED __EE12963196 := __ENH_Bankruptcy;
  SHARED __EE5174190 := __E_Sele_Bankruptcy;
  SHARED __EE12965329 := __EE5174190(__NN(__EE5174190.Legal_) AND __NN(__EE5174190.Bankrupt_));
  SHARED __EE12963199 := __ENH_Business_Sele;
  SHARED __EE12966766 := __EE12963199(__T(__OP2(__EE12963199.UID,=,__CN(__PBusinessSeleUID))));
  __JC12966772(E_Sele_Bankruptcy(__cfg_Local).Layout __EE12965329, B_Business_Sele(__cfg_Local).__ST149491_Layout __EE12966766) := __EEQP(__EE12966766.UID,__EE12965329.Legal_);
  SHARED __EE12966782 := JOIN(__EE12965329,__EE12966766,__JC12966772(LEFT,RIGHT),TRANSFORM(E_Sele_Bankruptcy(__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC12966788(B_Bankruptcy(__cfg_Local).__ST131119_Layout __EE12963196, E_Sele_Bankruptcy(__cfg_Local).Layout __EE12966782) := __EEQP(__EE12966782.Bankrupt_,__EE12963196.UID);
  SHARED __EE12966874 := JOIN(__EE12963196,__EE12966782,__JC12966788(LEFT,RIGHT),TRANSFORM(B_Bankruptcy(__cfg_Local).__ST131119_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE12966876 := __EE12966874;
  EXPORT Res20 := __UNWRAP(__EE12966876);
  SHARED __EE12967067 := __ENH_Lien_Judgment;
  SHARED __EE5174367 := __E_Sele_Lien_Judgment;
  SHARED __EE12969101 := __EE5174367(__NN(__EE5174367.Sele_) AND __NN(__EE5174367.Lien_));
  SHARED __EE12967070 := __ENH_Business_Sele;
  SHARED __EE12970497 := __EE12967070(__T(__OP2(__EE12967070.UID,=,__CN(__PBusinessSeleUID))));
  __JC12970503(E_Sele_Lien_Judgment(__cfg_Local).Layout __EE12969101, B_Business_Sele(__cfg_Local).__ST149491_Layout __EE12970497) := __EEQP(__EE12970497.UID,__EE12969101.Sele_);
  SHARED __EE12970519 := JOIN(__EE12969101,__EE12970497,__JC12970503(LEFT,RIGHT),TRANSFORM(E_Sele_Lien_Judgment(__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC12970525(B_Lien_Judgment_13(__cfg_Local).__ST265242_Layout __EE12967067, E_Sele_Lien_Judgment(__cfg_Local).Layout __EE12970519) := __EEQP(__EE12970519.Lien_,__EE12967067.UID);
  SHARED __EE12970564 := JOIN(__EE12967067,__EE12970519,__JC12970525(LEFT,RIGHT),TRANSFORM(B_Lien_Judgment_13(__cfg_Local).__ST265242_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE12970566 := __EE12970564;
  EXPORT Res21 := __UNWRAP(__EE12970566);
  SHARED __EE12970675 := __ENH_Person;
  SHARED __EE5174503 := __E_Sele_Person;
  SHARED __EE12979397 := __EE5174503(__NN(__EE5174503.Legal_) AND __NN(__EE5174503.Contact_));
  SHARED __EE12970678 := __ENH_Business_Sele;
  SHARED __EE12982810 := __EE12970678(__T(__OP2(__EE12970678.UID,=,__CN(__PBusinessSeleUID))));
  __JC12982816(E_Sele_Person(__cfg_Local).Layout __EE12979397, B_Business_Sele(__cfg_Local).__ST149491_Layout __EE12982810) := __EEQP(__EE12982810.UID,__EE12979397.Legal_);
  SHARED __EE12982847 := JOIN(__EE12979397,__EE12982810,__JC12982816(LEFT,RIGHT),TRANSFORM(E_Sele_Person(__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC12982853(B_Person(__cfg_Local).__ST170352_Layout __EE12970675, E_Sele_Person(__cfg_Local).Layout __EE12982847) := __EEQP(__EE12982847.Contact_,__EE12970675.UID);
  SHARED __EE12984894 := JOIN(__EE12970675,__EE12982847,__JC12982853(LEFT,RIGHT),TRANSFORM(B_Person(__cfg_Local).__ST170352_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE12984896 := __EE12984894;
  EXPORT Res22 := __UNWRAP(__EE12984896);
  SHARED __EE5176823 := __E_Phone;
  SHARED __EE5176813 := __E_Sele_Phone_Number;
  SHARED __EE12991323 := __EE5176813(__NN(__EE5176813.Legal_) AND __NN(__EE5176813.Phone_Number_));
  SHARED __EE12989039 := __ENH_Business_Sele;
  SHARED __EE12992783 := __EE12989039(__T(__OP2(__EE12989039.UID,=,__CN(__PBusinessSeleUID))));
  __JC12992789(E_Sele_Phone_Number(__cfg_Local).Layout __EE12991323, B_Business_Sele(__cfg_Local).__ST149491_Layout __EE12992783) := __EEQP(__EE12992783.UID,__EE12991323.Legal_);
  SHARED __EE12992826 := JOIN(__EE12991323,__EE12992783,__JC12992789(LEFT,RIGHT),TRANSFORM(E_Sele_Phone_Number(__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC12992832(E_Phone(__cfg_Local).Layout __EE5176823, E_Sele_Phone_Number(__cfg_Local).Layout __EE12992826) := __EEQP(__EE12992826.Phone_Number_,__EE5176823.UID);
  SHARED __EE12992914 := JOIN(__EE5176823,__EE12992826,__JC12992832(LEFT,RIGHT),TRANSFORM(E_Phone(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE12992916 := __EE12992914;
  EXPORT Res23 := __UNWRAP(__EE12992916);
  SHARED __EE12993153 := __ENH_Property;
  SHARED __EE5177021 := __E_Sele_Property;
  SHARED __EE12995251 := __EE5177021(__NN(__EE5177021.Legal_) AND __NN(__EE5177021.Prop_));
  SHARED __EE12993156 := __ENH_Business_Sele;
  SHARED __EE12996657 := __EE12993156(__T(__OP2(__EE12993156.UID,=,__CN(__PBusinessSeleUID))));
  __JC12996663(E_Sele_Property(__cfg_Local).Layout __EE12995251, B_Business_Sele(__cfg_Local).__ST149491_Layout __EE12996657) := __EEQP(__EE12996657.UID,__EE12995251.Legal_);
  SHARED __EE12996690 := JOIN(__EE12995251,__EE12996657,__JC12996663(LEFT,RIGHT),TRANSFORM(E_Sele_Property(__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC12996696(B_Property(__cfg_Local).__ST172673_Layout __EE12993153, E_Sele_Property(__cfg_Local).Layout __EE12996690) := __EEQP(__EE12996690.Prop_,__EE12993153.UID);
  SHARED __EE12996734 := JOIN(__EE12993153,__EE12996690,__JC12996696(LEFT,RIGHT),TRANSFORM(B_Property(__cfg_Local).__ST172673_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE12996736 := __EE12996734;
  EXPORT Res24 := __UNWRAP(__EE12996736);
  SHARED __EE12996865 := __ENH_Property_Event;
  SHARED __EE5177168 := __E_Sele_Property_Event;
  SHARED __EE12999064 := __EE5177168(__NN(__EE5177168.Legal_) AND __NN(__EE5177168.Event_));
  SHARED __EE12996868 := __ENH_Business_Sele;
  SHARED __EE13000495 := __EE12996868(__T(__OP2(__EE12996868.UID,=,__CN(__PBusinessSeleUID))));
  __JC13000501(E_Sele_Property_Event(__cfg_Local).Layout __EE12999064, B_Business_Sele(__cfg_Local).__ST149491_Layout __EE13000495) := __EEQP(__EE13000495.UID,__EE12999064.Legal_);
  SHARED __EE13000523 := JOIN(__EE12999064,__EE13000495,__JC13000501(LEFT,RIGHT),TRANSFORM(E_Sele_Property_Event(__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC13000529(B_Property_Event_6(__cfg_Local).__ST254782_Layout __EE12996865, E_Sele_Property_Event(__cfg_Local).Layout __EE13000523) := __EEQP(__EE13000523.Event_,__EE12996865.UID);
  SHARED __EE13000597 := JOIN(__EE12996865,__EE13000523,__JC13000529(LEFT,RIGHT),TRANSFORM(B_Property_Event_6(__cfg_Local).__ST254782_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13000599 := __EE13000597;
  EXPORT Res25 := __UNWRAP(__EE13000599);
  SHARED __EE5177348 := __E_T_I_N;
  SHARED __EE5177338 := __E_Sele_T_I_N;
  SHARED __EE13002677 := __EE5177338(__NN(__EE5177338.Legal_) AND __NN(__EE5177338.Tax_I_D_));
  SHARED __EE13000778 := __ENH_Business_Sele;
  SHARED __EE13004035 := __EE13000778(__T(__OP2(__EE13000778.UID,=,__CN(__PBusinessSeleUID))));
  __JC13004041(E_Sele_T_I_N(__cfg_Local).Layout __EE13002677, B_Business_Sele(__cfg_Local).__ST149491_Layout __EE13004035) := __EEQP(__EE13004035.UID,__EE13002677.Legal_);
  SHARED __EE13004054 := JOIN(__EE13002677,__EE13004035,__JC13004041(LEFT,RIGHT),TRANSFORM(E_Sele_T_I_N(__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC13004060(E_T_I_N(__cfg_Local).Layout __EE5177348, E_Sele_T_I_N(__cfg_Local).Layout __EE13004054) := __EEQP(__EE13004054.Tax_I_D_,__EE5177348.UID);
  SHARED __EE13004064 := JOIN(__EE5177348,__EE13004054,__JC13004060(LEFT,RIGHT),TRANSFORM(E_T_I_N(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13004066 := __EE13004064;
  EXPORT Res26 := __UNWRAP(__EE13004066);
  SHARED __EE13004099 := __ENH_Tradeline;
  SHARED __EE5177431 := __E_Sele_Tradeline;
  SHARED __EE13006179 := __EE5177431(__NN(__EE5177431.Legal_) AND __NN(__EE5177431.Account_));
  SHARED __EE13004102 := __ENH_Business_Sele;
  SHARED __EE13007598 := __EE13004102(__T(__OP2(__EE13004102.UID,=,__CN(__PBusinessSeleUID))));
  __JC13007604(E_Sele_Tradeline(__cfg_Local).Layout __EE13006179, B_Business_Sele(__cfg_Local).__ST149491_Layout __EE13007598) := __EEQP(__EE13007598.UID,__EE13006179.Legal_);
  SHARED __EE13007611 := JOIN(__EE13006179,__EE13007598,__JC13007604(LEFT,RIGHT),TRANSFORM(E_Sele_Tradeline(__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC13007617(B_Tradeline(__cfg_Local).__ST173880_Layout __EE13004099, E_Sele_Tradeline(__cfg_Local).Layout __EE13007611) := __EEQP(__EE13007611.Account_,__EE13004099.UID);
  SHARED __EE13007688 := JOIN(__EE13004099,__EE13007611,__JC13007617(LEFT,RIGHT),TRANSFORM(B_Tradeline(__cfg_Local).__ST173880_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13007690 := __EE13007688;
  EXPORT Res27 := __UNWRAP(__EE13007690);
  SHARED __EE13007845 := __ENH_U_C_C;
  SHARED __EE5177589 := __E_Sele_U_C_C;
  SHARED __EE13009922 := __EE5177589(__NN(__EE5177589.Legal_) AND __NN(__EE5177589.Filing_));
  SHARED __EE13007848 := __ENH_Business_Sele;
  SHARED __EE13011336 := __EE13007848(__T(__OP2(__EE13007848.UID,=,__CN(__PBusinessSeleUID))));
  __JC13011342(E_Sele_U_C_C(__cfg_Local).Layout __EE13009922, B_Business_Sele(__cfg_Local).__ST149491_Layout __EE13011336) := __EEQP(__EE13011336.UID,__EE13009922.Legal_);
  SHARED __EE13011357 := JOIN(__EE13009922,__EE13011336,__JC13011342(LEFT,RIGHT),TRANSFORM(E_Sele_U_C_C(__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC13011363(B_U_C_C(__cfg_Local).__ST174083_Layout __EE13007845, E_Sele_U_C_C(__cfg_Local).Layout __EE13011357) := __EEQP(__EE13011357.Filing_,__EE13007845.UID);
  SHARED __EE13011421 := JOIN(__EE13007845,__EE13011357,__JC13011363(LEFT,RIGHT),TRANSFORM(B_U_C_C(__cfg_Local).__ST174083_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13011423 := __EE13011421;
  EXPORT Res28 := __UNWRAP(__EE13011423);
  SHARED __EE5177754 := __E_Utility;
  SHARED __EE5177744 := __E_Sele_Utility;
  SHARED __EE13013512 := __EE5177744(__NN(__EE5177744.Legal_) AND __NN(__EE5177744.Util_));
  SHARED __EE13011568 := __ENH_Business_Sele;
  SHARED __EE13014890 := __EE13011568(__T(__OP2(__EE13011568.UID,=,__CN(__PBusinessSeleUID))));
  __JC13014896(E_Sele_Utility(__cfg_Local).Layout __EE13013512, B_Business_Sele(__cfg_Local).__ST149491_Layout __EE13014890) := __EEQP(__EE13014890.UID,__EE13013512.Legal_);
  SHARED __EE13014907 := JOIN(__EE13013512,__EE13014890,__JC13014896(LEFT,RIGHT),TRANSFORM(E_Sele_Utility(__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC13014913(E_Utility(__cfg_Local).Layout __EE5177754, E_Sele_Utility(__cfg_Local).Layout __EE13014907) := __EEQP(__EE13014907.Util_,__EE5177754.UID);
  SHARED __EE13014939 := JOIN(__EE5177754,__EE13014907,__JC13014913(LEFT,RIGHT),TRANSFORM(E_Utility(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13014941 := __EE13014939;
  EXPORT Res29 := __UNWRAP(__EE13014941);
  SHARED __EE5177870 := __E_Vehicle;
  SHARED __EE5177860 := __E_Sele_Vehicle;
  SHARED __EE13017520 := __EE5177860(__NN(__EE5177860.Legal_) AND __NN(__EE5177860.Automobile_));
  SHARED __EE13015014 := __ENH_Business_Sele;
  SHARED __EE13019022 := __EE13015014(__T(__OP2(__EE13015014.UID,=,__CN(__PBusinessSeleUID))));
  __JC13019028(E_Sele_Vehicle(__cfg_Local).Layout __EE13017520, B_Business_Sele(__cfg_Local).__ST149491_Layout __EE13019022) := __EEQP(__EE13019022.UID,__EE13017520.Legal_);
  SHARED __EE13019078 := JOIN(__EE13017520,__EE13019022,__JC13019028(LEFT,RIGHT),TRANSFORM(E_Sele_Vehicle(__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC13019084(E_Vehicle(__cfg_Local).Layout __EE5177870, E_Sele_Vehicle(__cfg_Local).Layout __EE13019078) := __EEQP(__EE13019078.Automobile_,__EE5177870.UID);
  SHARED __EE13019195 := JOIN(__EE5177870,__EE13019078,__JC13019084(LEFT,RIGHT),TRANSFORM(E_Vehicle(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13019197 := __EE13019195;
  EXPORT Res30 := __UNWRAP(__EE13019197);
  SHARED __EE13019518 := __ENH_Inquiry;
  SHARED __EE5178102 := __E_Sele_Inquiry;
  SHARED __EE13021652 := __EE5178102(__NN(__EE5178102.Legal_) AND __NN(__EE5178102.Transaction_));
  SHARED __EE13019521 := __ENH_Business_Sele;
  SHARED __EE13023082 := __EE13019521(__T(__OP2(__EE13019521.UID,=,__CN(__PBusinessSeleUID))));
  __JC13023088(E_Sele_Inquiry(__cfg_Local).Layout __EE13021652, B_Business_Sele(__cfg_Local).__ST149491_Layout __EE13023082) := __EEQP(__EE13023082.UID,__EE13021652.Legal_);
  SHARED __EE13023100 := JOIN(__EE13021652,__EE13023082,__JC13023088(LEFT,RIGHT),TRANSFORM(E_Sele_Inquiry(__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC13023106(B_Inquiry(__cfg_Local).__ST157264_Layout __EE13019518, E_Sele_Inquiry(__cfg_Local).Layout __EE13023100) := __EEQP(__EE13023100.Transaction_,__EE13019518.UID);
  SHARED __EE13023183 := JOIN(__EE13019518,__EE13023100,__JC13023106(LEFT,RIGHT),TRANSFORM(B_Inquiry(__cfg_Local).__ST157264_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13023185 := __EE13023183;
  EXPORT Res31 := __UNWRAP(__EE13023185);
  SHARED __EE5178284 := __E_Watercraft;
  SHARED __EE5178274 := __E_Sele_Watercraft;
  SHARED __EE13025270 := __EE5178274(__NN(__EE5178274.Legal_) AND __NN(__EE5178274.W_Craft_));
  SHARED __EE13023362 := __ENH_Business_Sele;
  SHARED __EE13026633 := __EE13023362(__T(__OP2(__EE13023362.UID,=,__CN(__PBusinessSeleUID))));
  __JC13026639(E_Sele_Watercraft(__cfg_Local).Layout __EE13025270, B_Business_Sele(__cfg_Local).__ST149491_Layout __EE13026633) := __EEQP(__EE13026633.UID,__EE13025270.Legal_);
  SHARED __EE13026650 := JOIN(__EE13025270,__EE13026633,__JC13026639(LEFT,RIGHT),TRANSFORM(E_Sele_Watercraft(__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC13026656(E_Watercraft(__cfg_Local).Layout __EE5178284, E_Sele_Watercraft(__cfg_Local).Layout __EE13026650) := __EEQP(__EE13026650.W_Craft_,__EE5178284.UID);
  SHARED __EE13026667 := JOIN(__EE5178284,__EE13026650,__JC13026656(LEFT,RIGHT),TRANSFORM(E_Watercraft(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13026669 := __EE13026667;
  EXPORT Res32 := __UNWRAP(__EE13026669);
  SHARED __EE13026712 := __ENH_Business_Prox;
  SHARED __EE13027277 := __EE13026712(__NN(__EE13026712.Prox_Sele_));
  SHARED __EE13026715 := __ENH_Business_Sele;
  SHARED __EE13030850 := __EE13026715(__T(__OP2(__EE13026715.UID,=,__CN(__PBusinessSeleUID))));
  __JC13030856(B_Business_Prox(__cfg_Local).__ST131603_Layout __EE13027277, B_Business_Sele(__cfg_Local).__ST149491_Layout __EE13030850) := __EEQP(__EE13030850.UID,__EE13027277.Prox_Sele_);
  SHARED __EE13031120 := JOIN(__EE13027277,__EE13030850,__JC13030856(LEFT,RIGHT),TRANSFORM(B_Business_Prox(__cfg_Local).__ST131603_Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __EE13031122 := __EE13031120;
  EXPORT Res33 := __UNWRAP(__EE13031122);
  SHARED __EE13031651 := __ENH_Criminal_Offense;
  SHARED __EE5178715 := __E_Criminal_Details;
  SHARED __EE13032066 := __EE5178715(__NN(__EE5178715.Offender_) AND __NN(__EE5178715.Offense_));
  SHARED __EE5178709 := __E_Criminal_Offender;
  SHARED __EE13032209 := __EE5178709(__T(__OP2(__EE5178709.UID,=,__CN(__PCriminalOffenderUID))));
  __JC13032215(E_Criminal_Details(__cfg_Local).Layout __EE13032066, E_Criminal_Offender(__cfg_Local).Layout __EE13032209) := __EEQP(__EE13032209.UID,__EE13032066.Offender_);
  SHARED __EE13032223 := JOIN(__EE13032066,__EE13032209,__JC13032215(LEFT,RIGHT),TRANSFORM(E_Criminal_Details(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13032229(B_Criminal_Offense(__cfg_Local).__ST150814_Layout __EE13031651, E_Criminal_Details(__cfg_Local).Layout __EE13032223) := __EEQP(__EE13032223.Offense_,__EE13031651.UID);
  SHARED __EE13032312 := JOIN(__EE13031651,__EE13032223,__JC13032229(LEFT,RIGHT),TRANSFORM(B_Criminal_Offense(__cfg_Local).__ST150814_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13032314 := __EE13032312;
  EXPORT Res34 := __UNWRAP(__EE13032314);
  SHARED __EE5178898 := __E_Criminal_Punishment;
  SHARED __EE5178888 := __E_Criminal_Details;
  SHARED __EE13032728 := __EE5178888(__NN(__EE5178888.Offender_) AND __NN(__EE5178888.Punishment_));
  SHARED __EE5178882 := __E_Criminal_Offender;
  SHARED __EE13032842 := __EE5178882(__T(__OP2(__EE5178882.UID,=,__CN(__PCriminalOffenderUID))));
  __JC13032848(E_Criminal_Details(__cfg_Local).Layout __EE13032728, E_Criminal_Offender(__cfg_Local).Layout __EE13032842) := __EEQP(__EE13032842.UID,__EE13032728.Offender_);
  SHARED __EE13032856 := JOIN(__EE13032728,__EE13032842,__JC13032848(LEFT,RIGHT),TRANSFORM(E_Criminal_Details(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13032862(E_Criminal_Punishment(__cfg_Local).Layout __EE5178898, E_Criminal_Details(__cfg_Local).Layout __EE13032856) := __EEQP(__EE13032856.Punishment_,__EE5178898.UID);
  SHARED __EE13032916 := JOIN(__EE5178898,__EE13032856,__JC13032862(LEFT,RIGHT),TRANSFORM(E_Criminal_Punishment(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13032918 := __EE13032916;
  EXPORT Res35 := __UNWRAP(__EE13032918);
  SHARED __EE13033041 := __ENH_Inquiry;
  SHARED __EE5179030 := __E_Email_Inquiry;
  SHARED __EE13033469 := __EE5179030(__NN(__EE5179030.Email_) AND __NN(__EE5179030.Transaction_));
  SHARED __EE13033044 := __ENH_Email;
  SHARED __EE13033614 := __EE13033044(__T(__OP2(__EE13033044.UID,=,__CN(__PEmailUID))));
  __JC13033620(E_Email_Inquiry(__cfg_Local).Layout __EE13033469, B_Email_2(__cfg_Local).__ST209842_Layout __EE13033614) := __EEQP(__EE13033614.UID,__EE13033469.Email_);
  SHARED __EE13033630 := JOIN(__EE13033469,__EE13033614,__JC13033620(LEFT,RIGHT),TRANSFORM(E_Email_Inquiry(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13033636(B_Inquiry(__cfg_Local).__ST157264_Layout __EE13033041, E_Email_Inquiry(__cfg_Local).Layout __EE13033630) := __EEQP(__EE13033630.Transaction_,__EE13033041.UID);
  SHARED __EE13033713 := JOIN(__EE13033041,__EE13033630,__JC13033636(LEFT,RIGHT),TRANSFORM(B_Inquiry(__cfg_Local).__ST157264_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13033715 := __EE13033713;
  EXPORT Res36 := __UNWRAP(__EE13033715);
  SHARED __EE5179200 := __E_First_Degree_Associations;
  SHARED __EE13033947 := __EE5179200(__NN(__EE5179200.Subject_));
  SHARED __EE13033888 := __ENH_Person;
  SHARED __EE13037431 := __EE13033888(__T(__OP2(__EE13033888.UID,=,__CN(__PPersonUID))));
  __JC13037437(E_First_Degree_Associations(__cfg_Local).Layout __EE13033947, B_Person(__cfg_Local).__ST170352_Layout __EE13037431) := __EEQP(__EE13037431.UID,__EE13033947.Subject_);
  SHARED __EE13037449 := JOIN(__EE13033947,__EE13037431,__JC13037437(LEFT,RIGHT),TRANSFORM(E_First_Degree_Associations(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13037451 := __EE13037449;
  EXPORT Res37 := __UNWRAP(__EE13037451);
  SHARED __EE13037476 := __ENH_First_Degree_Relative;
  SHARED __EE13037540 := __EE13037476(__NN(__EE13037476.Subject_));
  SHARED __EE13037479 := __ENH_Person;
  SHARED __EE13041024 := __EE13037479(__T(__OP2(__EE13037479.UID,=,__CN(__PPersonUID))));
  __JC13041030(B_First_Degree_Relative(__cfg_Local).__ST3708162_Layout __EE13037540, B_Person(__cfg_Local).__ST170352_Layout __EE13041024) := __EEQP(__EE13041024.UID,__EE13037540.Subject_);
  SHARED __EE13041042 := JOIN(__EE13037540,__EE13041024,__JC13041030(LEFT,RIGHT),TRANSFORM(B_First_Degree_Relative(__cfg_Local).__ST3708162_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13041044 := __EE13041042;
  EXPORT Res38 := __UNWRAP(__EE13041044);
  SHARED __EE5179334 := __E_Phone;
  SHARED __EE5179324 := __E_House_Hold_Phone;
  SHARED __EE13041441 := __EE5179324(__NN(__EE5179324.Household_) AND __NN(__EE5179324.Phone_Number_));
  SHARED __EE5179318 := __E_Household;
  SHARED __EE13041582 := __EE5179318(__T(__OP2(__EE5179318.UID,=,__CN(__PHouseholdUID))));
  __JC13041588(E_House_Hold_Phone(__cfg_Local).Layout __EE13041441, E_Household(__cfg_Local).Layout __EE13041582) := __EEQP(__EE13041582.UID,__EE13041441.Household_);
  SHARED __EE13041614 := JOIN(__EE13041441,__EE13041582,__JC13041588(LEFT,RIGHT),TRANSFORM(E_House_Hold_Phone(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13041620(E_Phone(__cfg_Local).Layout __EE5179334, E_House_Hold_Phone(__cfg_Local).Layout __EE13041614) := __EEQP(__EE13041614.Phone_Number_,__EE5179334.UID);
  SHARED __EE13041702 := JOIN(__EE5179334,__EE13041614,__JC13041620(LEFT,RIGHT),TRANSFORM(E_Phone(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13041704 := __EE13041702;
  EXPORT Res39 := __UNWRAP(__EE13041704);
  SHARED __EE13041919 := __ENH_Person;
  SHARED __EE5179516 := __E_Household_Member;
  SHARED __EE13048768 := __EE5179516(__NN(__EE5179516.Household_) AND __NN(__EE5179516.Subject_));
  SHARED __EE5179510 := __E_Household;
  SHARED __EE13050850 := __EE5179510(__T(__OP2(__EE5179510.UID,=,__CN(__PHouseholdUID))));
  __JC13050856(E_Household_Member(__cfg_Local).Layout __EE13048768, E_Household(__cfg_Local).Layout __EE13050850) := __EEQP(__EE13050850.UID,__EE13048768.Household_);
  SHARED __EE13050864 := JOIN(__EE13048768,__EE13050850,__JC13050856(LEFT,RIGHT),TRANSFORM(E_Household_Member(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13050870(B_Person(__cfg_Local).__ST170352_Layout __EE13041919, E_Household_Member(__cfg_Local).Layout __EE13050864) := __EEQP(__EE13050864.Subject_,__EE13041919.UID);
  SHARED __EE13052911 := JOIN(__EE13041919,__EE13050864,__JC13050870(LEFT,RIGHT),TRANSFORM(B_Person(__cfg_Local).__ST170352_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13052913 := __EE13052911;
  EXPORT Res40 := __UNWRAP(__EE13052913);
  SHARED __EE5181812 := __E_Aircraft;
  SHARED __EE5181802 := __E_Aircraft_Owner;
  SHARED __EE13058794 := __EE5181802(__NN(__EE5181802.Owner_) AND __NN(__EE5181802.Plane_));
  SHARED __EE13057010 := __ENH_Person;
  SHARED __EE13060736 := __EE13057010(__T(__OP2(__EE13057010.UID,=,__CN(__PPersonUID))));
  __JC13060742(E_Aircraft_Owner(__cfg_Local).Layout __EE13058794, B_Person(__cfg_Local).__ST170352_Layout __EE13060736) := __EEQP(__EE13060736.UID,__EE13058794.Owner_);
  SHARED __EE13060752 := JOIN(__EE13058794,__EE13060736,__JC13060742(LEFT,RIGHT),TRANSFORM(E_Aircraft_Owner(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13060758(E_Aircraft(__cfg_Local).Layout __EE5181812, E_Aircraft_Owner(__cfg_Local).Layout __EE13060752) := __EEQP(__EE13060752.Plane_,__EE5181812.UID);
  SHARED __EE13060781 := JOIN(__EE5181812,__EE13060752,__JC13060758(LEFT,RIGHT),TRANSFORM(E_Aircraft(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13060783 := __EE13060781;
  EXPORT Res41 := __UNWRAP(__EE13060783);
  SHARED __EE5181924 := __E_Household;
  SHARED __EE5181914 := __E_Household_Member;
  SHARED __EE13062555 := __EE5181914(__NN(__EE5181914.Subject_) AND __NN(__EE5181914.Household_));
  SHARED __EE13060848 := __ENH_Person;
  SHARED __EE13064478 := __EE13060848(__T(__OP2(__EE13060848.UID,=,__CN(__PPersonUID))));
  __JC13064484(E_Household_Member(__cfg_Local).Layout __EE13062555, B_Person(__cfg_Local).__ST170352_Layout __EE13064478) := __EEQP(__EE13064478.UID,__EE13062555.Subject_);
  SHARED __EE13064492 := JOIN(__EE13062555,__EE13064478,__JC13064484(LEFT,RIGHT),TRANSFORM(E_Household_Member(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13064498(E_Household(__cfg_Local).Layout __EE5181924, E_Household_Member(__cfg_Local).Layout __EE13064492) := __EEQP(__EE13064492.Household_,__EE5181924.UID);
  SHARED __EE13064504 := JOIN(__EE5181924,__EE13064492,__JC13064498(LEFT,RIGHT),TRANSFORM(E_Household(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13064506 := __EE13064504;
  EXPORT Res42 := __UNWRAP(__EE13064506);
  SHARED __EE5182015 := __E_Accident;
  SHARED __EE5182005 := __E_Person_Accident;
  SHARED __EE13066642 := __EE5182005(__NN(__EE5182005.Subject_) AND __NN(__EE5182005.Acc_));
  SHARED __EE13064533 := __ENH_Person;
  SHARED __EE13068627 := __EE13064533(__T(__OP2(__EE13064533.UID,=,__CN(__PPersonUID))));
  __JC13068633(E_Person_Accident(__cfg_Local).Layout __EE13066642, B_Person(__cfg_Local).__ST170352_Layout __EE13068627) := __EEQP(__EE13068627.UID,__EE13066642.Subject_);
  SHARED __EE13068681 := JOIN(__EE13066642,__EE13068627,__JC13068633(LEFT,RIGHT),TRANSFORM(E_Person_Accident(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13068687(E_Accident(__cfg_Local).Layout __EE5182015, E_Person_Accident(__cfg_Local).Layout __EE13068681) := __EEQP(__EE13068681.Acc_,__EE5182015.UID);
  SHARED __EE13068715 := JOIN(__EE5182015,__EE13068681,__JC13068687(LEFT,RIGHT),TRANSFORM(E_Accident(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13068717 := __EE13068715;
  EXPORT Res43 := __UNWRAP(__EE13068717);
  SHARED __EE13068868 := __ENH_Address;
  SHARED __EE5182160 := __E_Person_Address;
  SHARED __EE13071358 := __EE5182160(__NN(__EE5182160.Subject_) AND __NN(__EE5182160.Location_));
  SHARED __EE13068871 := __ENH_Person;
  SHARED __EE13073484 := __EE13068871(__T(__OP2(__EE13068871.UID,=,__CN(__PPersonUID))));
  __JC13073490(E_Person_Address(__cfg_Local).Layout __EE13071358, B_Person(__cfg_Local).__ST170352_Layout __EE13073484) := __EEQP(__EE13073484.UID,__EE13071358.Subject_);
  SHARED __EE13073549 := JOIN(__EE13071358,__EE13073484,__JC13073490(LEFT,RIGHT),TRANSFORM(E_Person_Address(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13073555(B_Address_1(__cfg_Local).__ST174206_Layout __EE13068868, E_Person_Address(__cfg_Local).Layout __EE13073549) := __EEQP(__EE13073549.Location_,__EE13068868.UID);
  SHARED __EE13073713 := JOIN(__EE13068868,__EE13073549,__JC13073555(LEFT,RIGHT),TRANSFORM(B_Address_1(__cfg_Local).__ST174206_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13073715 := __EE13073713;
  EXPORT Res44 := __UNWRAP(__EE13073715);
  SHARED __EE13074148 := __ENH_Bankruptcy;
  SHARED __EE5182481 := __E_Person_Bankruptcy;
  SHARED __EE13076097 := __EE5182481(__NN(__EE5182481.Subject_) AND __NN(__EE5182481.Bankrupt_));
  SHARED __EE13074151 := __ENH_Person;
  SHARED __EE13078099 := __EE13074151(__T(__OP2(__EE13074151.UID,=,__CN(__PPersonUID))));
  __JC13078105(E_Person_Bankruptcy(__cfg_Local).Layout __EE13076097, B_Person(__cfg_Local).__ST170352_Layout __EE13078099) := __EEQP(__EE13078099.UID,__EE13076097.Subject_);
  SHARED __EE13078112 := JOIN(__EE13076097,__EE13078099,__JC13078105(LEFT,RIGHT),TRANSFORM(E_Person_Bankruptcy(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13078118(B_Bankruptcy(__cfg_Local).__ST131119_Layout __EE13074148, E_Person_Bankruptcy(__cfg_Local).Layout __EE13078112) := __EEQP(__EE13078112.Bankrupt_,__EE13074148.UID);
  SHARED __EE13078204 := JOIN(__EE13074148,__EE13078112,__JC13078118(LEFT,RIGHT),TRANSFORM(B_Bankruptcy(__cfg_Local).__ST131119_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13078206 := __EE13078204;
  EXPORT Res45 := __UNWRAP(__EE13078206);
  SHARED __EE5182665 := __E_Drivers_License;
  SHARED __EE5182655 := __E_Person_Drivers_License;
  SHARED __EE13080270 := __EE5182655(__NN(__EE5182655.Subject_) AND __NN(__EE5182655.License_));
  SHARED __EE13078391 := __ENH_Person;
  SHARED __EE13082243 := __EE13078391(__T(__OP2(__EE13078391.UID,=,__CN(__PPersonUID))));
  __JC13082249(E_Person_Drivers_License(__cfg_Local).Layout __EE13080270, B_Person(__cfg_Local).__ST170352_Layout __EE13082243) := __EEQP(__EE13082243.UID,__EE13080270.Subject_);
  SHARED __EE13082256 := JOIN(__EE13080270,__EE13082243,__JC13082249(LEFT,RIGHT),TRANSFORM(E_Person_Drivers_License(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13082262(E_Drivers_License(__cfg_Local).Layout __EE5182665, E_Person_Drivers_License(__cfg_Local).Layout __EE13082256) := __EEQP(__EE13082256.License_,__EE5182665.UID);
  SHARED __EE13082319 := JOIN(__EE5182665,__EE13082256,__JC13082262(LEFT,RIGHT),TRANSFORM(E_Drivers_License(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13082321 := __EE13082319;
  EXPORT Res46 := __UNWRAP(__EE13082321);
  SHARED __EE13082448 := __ENH_Education;
  SHARED __EE5182799 := __E_Person_Education;
  SHARED __EE13084298 := __EE5182799(__NN(__EE5182799.Subject_) AND __NN(__EE5182799.Edu_));
  SHARED __EE13082451 := __ENH_Person;
  SHARED __EE13086248 := __EE13082451(__T(__OP2(__EE13082451.UID,=,__CN(__PPersonUID))));
  __JC13086254(E_Person_Education(__cfg_Local).Layout __EE13084298, B_Person(__cfg_Local).__ST170352_Layout __EE13086248) := __EEQP(__EE13086248.UID,__EE13084298.Subject_);
  SHARED __EE13086272 := JOIN(__EE13084298,__EE13086248,__JC13086254(LEFT,RIGHT),TRANSFORM(E_Person_Education(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13086278(B_Education_2(__cfg_Local).__ST209789_Layout __EE13082448, E_Person_Education(__cfg_Local).Layout __EE13086272) := __EEQP(__EE13086272.Edu_,__EE13082448.UID);
  SHARED __EE13086301 := JOIN(__EE13082448,__EE13086272,__JC13086278(LEFT,RIGHT),TRANSFORM(B_Education_2(__cfg_Local).__ST209789_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13086303 := __EE13086301;
  EXPORT Res47 := __UNWRAP(__EE13086303);
  SHARED __EE13086384 := __ENH_Email;
  SHARED __EE5182919 := __E_Person_Email;
  SHARED __EE13088191 := __EE5182919(__NN(__EE5182919.Subject_) AND __NN(__EE5182919.Email_));
  SHARED __EE13086387 := __ENH_Person;
  SHARED __EE13090143 := __EE13086387(__T(__OP2(__EE13086387.UID,=,__CN(__PPersonUID))));
  __JC13090149(E_Person_Email(__cfg_Local).Layout __EE13088191, B_Person(__cfg_Local).__ST170352_Layout __EE13090143) := __EEQP(__EE13090143.UID,__EE13088191.Subject_);
  SHARED __EE13090156 := JOIN(__EE13088191,__EE13090143,__JC13090149(LEFT,RIGHT),TRANSFORM(E_Person_Email(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13090162(B_Email_2(__cfg_Local).__ST209842_Layout __EE13086384, E_Person_Email(__cfg_Local).Layout __EE13090156) := __EEQP(__EE13090156.Email_,__EE13086384.UID);
  SHARED __EE13090198 := JOIN(__EE13086384,__EE13090156,__JC13090162(LEFT,RIGHT),TRANSFORM(B_Email_2(__cfg_Local).__ST209842_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13090200 := __EE13090198;
  EXPORT Res48 := __UNWRAP(__EE13090200);
  SHARED __EE13090285 := __ENH_Inquiry;
  SHARED __EE5183046 := __E_Person_Inquiry;
  SHARED __EE13092235 := __EE5183046(__NN(__EE5183046.Subject_) AND __NN(__EE5183046.Transaction_));
  SHARED __EE13090288 := __ENH_Person;
  SHARED __EE13094230 := __EE13090288(__T(__OP2(__EE13090288.UID,=,__CN(__PPersonUID))));
  __JC13094236(E_Person_Inquiry(__cfg_Local).Layout __EE13092235, B_Person(__cfg_Local).__ST170352_Layout __EE13094230) := __EEQP(__EE13094230.UID,__EE13092235.Subject_);
  SHARED __EE13094245 := JOIN(__EE13092235,__EE13094230,__JC13094236(LEFT,RIGHT),TRANSFORM(E_Person_Inquiry(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13094251(B_Inquiry(__cfg_Local).__ST157264_Layout __EE13090285, E_Person_Inquiry(__cfg_Local).Layout __EE13094245) := __EEQP(__EE13094245.Transaction_,__EE13090285.UID);
  SHARED __EE13094328 := JOIN(__EE13090285,__EE13094245,__JC13094251(LEFT,RIGHT),TRANSFORM(B_Inquiry(__cfg_Local).__ST157264_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13094330 := __EE13094328;
  EXPORT Res49 := __UNWRAP(__EE13094330);
  SHARED __EE13094501 := __ENH_Lien_Judgment;
  SHARED __EE5183215 := __E_Person_Lien_Judgment;
  SHARED __EE13096351 := __EE5183215(__NN(__EE5183215.Subject_) AND __NN(__EE5183215.Lien_));
  SHARED __EE13094504 := __ENH_Person;
  SHARED __EE13098312 := __EE13094504(__T(__OP2(__EE13094504.UID,=,__CN(__PPersonUID))));
  __JC13098318(E_Person_Lien_Judgment(__cfg_Local).Layout __EE13096351, B_Person(__cfg_Local).__ST170352_Layout __EE13098312) := __EEQP(__EE13098312.UID,__EE13096351.Subject_);
  SHARED __EE13098331 := JOIN(__EE13096351,__EE13098312,__JC13098318(LEFT,RIGHT),TRANSFORM(E_Person_Lien_Judgment(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13098337(B_Lien_Judgment_13(__cfg_Local).__ST265242_Layout __EE13094501, E_Person_Lien_Judgment(__cfg_Local).Layout __EE13098331) := __EEQP(__EE13098331.Lien_,__EE13094501.UID);
  SHARED __EE13098376 := JOIN(__EE13094501,__EE13098331,__JC13098337(LEFT,RIGHT),TRANSFORM(B_Lien_Judgment_13(__cfg_Local).__ST265242_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13098378 := __EE13098376;
  EXPORT Res50 := __UNWRAP(__EE13098378);
  SHARED __EE5183358 := __E_Criminal_Offender;
  SHARED __EE5183348 := __E_Person_Offender;
  SHARED __EE13100253 := __EE5183348(__NN(__EE5183348.Subject_) AND __NN(__EE5183348.Offender_));
  SHARED __EE13098481 := __ENH_Person;
  SHARED __EE13102197 := __EE13098481(__T(__OP2(__EE13098481.UID,=,__CN(__PPersonUID))));
  __JC13102203(E_Person_Offender(__cfg_Local).Layout __EE13100253, B_Person(__cfg_Local).__ST170352_Layout __EE13102197) := __EEQP(__EE13102197.UID,__EE13100253.Subject_);
  SHARED __EE13102210 := JOIN(__EE13100253,__EE13102197,__JC13102203(LEFT,RIGHT),TRANSFORM(E_Person_Offender(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13102216(E_Criminal_Offender(__cfg_Local).Layout __EE5183358, E_Person_Offender(__cfg_Local).Layout __EE13102210) := __EEQP(__EE13102210.Offender_,__EE5183358.UID);
  SHARED __EE13102244 := JOIN(__EE5183358,__EE13102210,__JC13102216(LEFT,RIGHT),TRANSFORM(E_Criminal_Offender(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13102246 := __EE13102244;
  EXPORT Res51 := __UNWRAP(__EE13102246);
  SHARED __EE13102315 := __ENH_Criminal_Offense;
  SHARED __EE5183463 := __E_Person_Offenses;
  SHARED __EE13104294 := __EE5183463(__NN(__EE5183463.Subject_) AND __NN(__EE5183463.Offense_));
  SHARED __EE13102318 := __ENH_Person;
  SHARED __EE13106293 := __EE13102318(__T(__OP2(__EE13102318.UID,=,__CN(__PPersonUID))));
  __JC13106299(E_Person_Offenses(__cfg_Local).Layout __EE13104294, B_Person(__cfg_Local).__ST170352_Layout __EE13106293) := __EEQP(__EE13106293.UID,__EE13104294.Subject_);
  SHARED __EE13106306 := JOIN(__EE13104294,__EE13106293,__JC13106299(LEFT,RIGHT),TRANSFORM(E_Person_Offenses(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13106312(B_Criminal_Offense(__cfg_Local).__ST150814_Layout __EE13102315, E_Person_Offenses(__cfg_Local).Layout __EE13106306) := __EEQP(__EE13106306.Offense_,__EE13102315.UID);
  SHARED __EE13106395 := JOIN(__EE13102315,__EE13106306,__JC13106312(LEFT,RIGHT),TRANSFORM(B_Criminal_Offense(__cfg_Local).__ST150814_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13106397 := __EE13106395;
  EXPORT Res52 := __UNWRAP(__EE13106397);
  SHARED __EE5183646 := __E_Phone;
  SHARED __EE5183636 := __E_Person_Phone;
  SHARED __EE13108685 := __EE5183636(__NN(__EE5183636.Subject_) AND __NN(__EE5183636.Phone_Number_));
  SHARED __EE13106576 := __ENH_Person;
  SHARED __EE13110710 := __EE13106576(__T(__OP2(__EE13106576.UID,=,__CN(__PPersonUID))));
  __JC13110716(E_Person_Phone(__cfg_Local).Layout __EE13108685, B_Person(__cfg_Local).__ST170352_Layout __EE13110710) := __EEQP(__EE13110710.UID,__EE13108685.Subject_);
  SHARED __EE13110750 := JOIN(__EE13108685,__EE13110710,__JC13110716(LEFT,RIGHT),TRANSFORM(E_Person_Phone(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13110756(E_Phone(__cfg_Local).Layout __EE5183646, E_Person_Phone(__cfg_Local).Layout __EE13110750) := __EEQP(__EE13110750.Phone_Number_,__EE5183646.UID);
  SHARED __EE13110838 := JOIN(__EE5183646,__EE13110750,__JC13110756(LEFT,RIGHT),TRANSFORM(E_Phone(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13110840 := __EE13110838;
  EXPORT Res53 := __UNWRAP(__EE13110840);
  SHARED __EE13111071 := __ENH_Property;
  SHARED __EE5183839 := __E_Person_Property;
  SHARED __EE13112985 := __EE5183839(__NN(__EE5183839.Subject_) AND __NN(__EE5183839.Prop_));
  SHARED __EE13111074 := __ENH_Person;
  SHARED __EE13114956 := __EE13111074(__T(__OP2(__EE13111074.UID,=,__CN(__PPersonUID))));
  __JC13114962(E_Person_Property(__cfg_Local).Layout __EE13112985, B_Person(__cfg_Local).__ST170352_Layout __EE13114956) := __EEQP(__EE13114956.UID,__EE13112985.Subject_);
  SHARED __EE13114986 := JOIN(__EE13112985,__EE13114956,__JC13114962(LEFT,RIGHT),TRANSFORM(E_Person_Property(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13114992(B_Property(__cfg_Local).__ST172673_Layout __EE13111071, E_Person_Property(__cfg_Local).Layout __EE13114986) := __EEQP(__EE13114986.Prop_,__EE13111071.UID);
  SHARED __EE13115030 := JOIN(__EE13111071,__EE13114986,__JC13114992(LEFT,RIGHT),TRANSFORM(B_Property(__cfg_Local).__ST172673_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13115032 := __EE13115030;
  EXPORT Res54 := __UNWRAP(__EE13115032);
  SHARED __EE13115155 := __ENH_Property_Event;
  SHARED __EE5183983 := __E_Person_Property_Event;
  SHARED __EE13117170 := __EE5183983(__NN(__EE5183983.Subject_) AND __NN(__EE5183983.Event_));
  SHARED __EE13115158 := __ENH_Person;
  SHARED __EE13119166 := __EE13115158(__T(__OP2(__EE13115158.UID,=,__CN(__PPersonUID))));
  __JC13119172(E_Person_Property_Event(__cfg_Local).Layout __EE13117170, B_Person(__cfg_Local).__ST170352_Layout __EE13119166) := __EEQP(__EE13119166.UID,__EE13117170.Subject_);
  SHARED __EE13119191 := JOIN(__EE13117170,__EE13119166,__JC13119172(LEFT,RIGHT),TRANSFORM(E_Person_Property_Event(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13119197(B_Property_Event_6(__cfg_Local).__ST254782_Layout __EE13115155, E_Person_Property_Event(__cfg_Local).Layout __EE13119191) := __EEQP(__EE13119191.Event_,__EE13115155.UID);
  SHARED __EE13119265 := JOIN(__EE13115155,__EE13119191,__JC13119197(LEFT,RIGHT),TRANSFORM(B_Property_Event_6(__cfg_Local).__ST254782_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13119267 := __EE13119265;
  EXPORT Res55 := __UNWRAP(__EE13119267);
  SHARED __EE5184160 := __E_Sex_Offender;
  SHARED __EE5184150 := __E_Person_Sex_Offender;
  SHARED __EE13121183 := __EE5184150(__NN(__EE5184150.Subject_) AND __NN(__EE5184150.Offender_));
  SHARED __EE13119440 := __ENH_Person;
  SHARED __EE13123111 := __EE13119440(__T(__OP2(__EE13119440.UID,=,__CN(__PPersonUID))));
  __JC13123117(E_Person_Sex_Offender(__cfg_Local).Layout __EE13121183, B_Person(__cfg_Local).__ST170352_Layout __EE13123111) := __EEQP(__EE13123111.UID,__EE13121183.Subject_);
  SHARED __EE13123129 := JOIN(__EE13121183,__EE13123111,__JC13123117(LEFT,RIGHT),TRANSFORM(E_Person_Sex_Offender(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13123135(E_Sex_Offender(__cfg_Local).Layout __EE5184160, E_Person_Sex_Offender(__cfg_Local).Layout __EE13123129) := __EEQP(__EE13123129.Offender_,__EE5184160.UID);
  SHARED __EE13123142 := JOIN(__EE5184160,__EE13123129,__JC13123135(LEFT,RIGHT),TRANSFORM(E_Sex_Offender(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13123144 := __EE13123142;
  EXPORT Res56 := __UNWRAP(__EE13123144);
  SHARED __EE5184256 := __E_Social_Security_Number;
  SHARED __EE5184246 := __E_Person_S_S_N;
  SHARED __EE13124942 := __EE5184246(__NN(__EE5184246.Subject_) AND __NN(__EE5184246.Social_));
  SHARED __EE13123181 := __ENH_Person;
  SHARED __EE13126879 := __EE13123181(__T(__OP2(__EE13123181.UID,=,__CN(__PPersonUID))));
  __JC13126885(E_Person_S_S_N(__cfg_Local).Layout __EE13124942, B_Person(__cfg_Local).__ST170352_Layout __EE13126879) := __EEQP(__EE13126879.UID,__EE13124942.Subject_);
  SHARED __EE13126898 := JOIN(__EE13124942,__EE13126879,__JC13126885(LEFT,RIGHT),TRANSFORM(E_Person_S_S_N(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13126904(E_Social_Security_Number(__cfg_Local).Layout __EE5184256, E_Person_S_S_N(__cfg_Local).Layout __EE13126898) := __EEQP(__EE13126898.Social_,__EE5184256.UID);
  SHARED __EE13126919 := JOIN(__EE5184256,__EE13126898,__JC13126904(LEFT,RIGHT),TRANSFORM(E_Social_Security_Number(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13126921 := __EE13126919;
  EXPORT Res57 := __UNWRAP(__EE13126921);
  SHARED __EE5184363 := __E_Vehicle;
  SHARED __EE5184353 := __E_Person_Vehicle;
  SHARED __EE13129275 := __EE5184353(__NN(__EE5184353.Subject_) AND __NN(__EE5184353.Automobile_));
  SHARED __EE13126976 := __ENH_Person;
  SHARED __EE13131338 := __EE13126976(__T(__OP2(__EE13126976.UID,=,__CN(__PPersonUID))));
  __JC13131344(E_Person_Vehicle(__cfg_Local).Layout __EE13129275, B_Person(__cfg_Local).__ST170352_Layout __EE13131338) := __EEQP(__EE13131338.UID,__EE13129275.Subject_);
  SHARED __EE13131387 := JOIN(__EE13129275,__EE13131338,__JC13131344(LEFT,RIGHT),TRANSFORM(E_Person_Vehicle(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13131393(E_Vehicle(__cfg_Local).Layout __EE5184363, E_Person_Vehicle(__cfg_Local).Layout __EE13131387) := __EEQP(__EE13131387.Automobile_,__EE5184363.UID);
  SHARED __EE13131504 := JOIN(__EE5184363,__EE13131387,__JC13131393(LEFT,RIGHT),TRANSFORM(E_Vehicle(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13131506 := __EE13131504;
  EXPORT Res58 := __UNWRAP(__EE13131506);
  SHARED __EE13131813 := __ENH_Professional_License;
  SHARED __EE5184587 := __E_Professional_License_Person;
  SHARED __EE13133650 := __EE5184587(__NN(__EE5184587.Subject_) AND __NN(__EE5184587.Prof_Lic_));
  SHARED __EE13131816 := __ENH_Person;
  SHARED __EE13135613 := __EE13131816(__T(__OP2(__EE13131816.UID,=,__CN(__PPersonUID))));
  __JC13135619(E_Professional_License_Person(__cfg_Local).Layout __EE13133650, B_Person(__cfg_Local).__ST170352_Layout __EE13135613) := __EEQP(__EE13135613.UID,__EE13133650.Subject_);
  SHARED __EE13135626 := JOIN(__EE13133650,__EE13135613,__JC13135619(LEFT,RIGHT),TRANSFORM(E_Professional_License_Person(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13135632(B_Professional_License_4(__cfg_Local).__ST243009_Layout __EE13131813, E_Professional_License_Person(__cfg_Local).Layout __EE13135626) := __EEQP(__EE13135626.Prof_Lic_,__EE13131813.UID);
  SHARED __EE13135679 := JOIN(__EE13131813,__EE13135626,__JC13135632(LEFT,RIGHT),TRANSFORM(B_Professional_License_4(__cfg_Local).__ST243009_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13135681 := __EE13135679;
  EXPORT Res59 := __UNWRAP(__EE13135681);
  SHARED __EE13135788 := __ENH_Business_Prox;
  SHARED __EE5184723 := __E_Prox_Person;
  SHARED __EE13138398 := __EE5184723(__NN(__EE5184723.Contact_) AND __NN(__EE5184723.Business_Location_));
  SHARED __EE13135791 := __ENH_Person;
  SHARED __EE13140599 := __EE13135791(__T(__OP2(__EE13135791.UID,=,__CN(__PPersonUID))));
  __JC13140605(E_Prox_Person(__cfg_Local).Layout __EE13138398, B_Person(__cfg_Local).__ST170352_Layout __EE13140599) := __EEQP(__EE13140599.UID,__EE13138398.Contact_);
  SHARED __EE13140633 := JOIN(__EE13138398,__EE13140599,__JC13140605(LEFT,RIGHT),TRANSFORM(E_Prox_Person(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13140639(B_Business_Prox(__cfg_Local).__ST131603_Layout __EE13135788, E_Prox_Person(__cfg_Local).Layout __EE13140633) := __EEQP(__EE13140633.Business_Location_,__EE13135788.UID);
  SHARED __EE13140903 := JOIN(__EE13135788,__EE13140633,__JC13140639(LEFT,RIGHT),TRANSFORM(B_Business_Prox(__cfg_Local).__ST131603_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13140905 := __EE13140903;
  EXPORT Res60 := __UNWRAP(__EE13140905);
  SHARED __EE13141488 := __ENH_Business_Sele;
  SHARED __EE5185120 := __E_Sele_Person;
  SHARED __EE13148283 := __EE5185120(__NN(__EE5185120.Contact_) AND __NN(__EE5185120.Legal_));
  SHARED __EE13141491 := __ENH_Person;
  SHARED __EE13151624 := __EE13141491(__T(__OP2(__EE13141491.UID,=,__CN(__PPersonUID))));
  __JC13151630(E_Sele_Person(__cfg_Local).Layout __EE13148283, B_Person(__cfg_Local).__ST170352_Layout __EE13151624) := __EEQP(__EE13151624.UID,__EE13148283.Contact_);
  SHARED __EE13151661 := JOIN(__EE13148283,__EE13151624,__JC13151630(LEFT,RIGHT),TRANSFORM(E_Sele_Person(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13151667(B_Business_Sele(__cfg_Local).__ST149491_Layout __EE13141488, E_Sele_Person(__cfg_Local).Layout __EE13151661) := __EEQP(__EE13151661.Legal_,__EE13141488.UID);
  SHARED __EE13153068 := JOIN(__EE13141488,__EE13151661,__JC13151667(LEFT,RIGHT),TRANSFORM(B_Business_Sele(__cfg_Local).__ST149491_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13153070 := __EE13153068;
  EXPORT Res61 := __UNWRAP(__EE13153070);
  SHARED __EE5186728 := __E_Utility;
  SHARED __EE5186718 := __E_Utility_Person;
  SHARED __EE13157697 := __EE5186718(__NN(__EE5186718.Subject_) AND __NN(__EE5186718.Util_));
  SHARED __EE13155933 := __ENH_Person;
  SHARED __EE13159639 := __EE13155933(__T(__OP2(__EE13155933.UID,=,__CN(__PPersonUID))));
  __JC13159645(E_Utility_Person(__cfg_Local).Layout __EE13157697, B_Person(__cfg_Local).__ST170352_Layout __EE13159639) := __EEQP(__EE13159639.UID,__EE13157697.Subject_);
  SHARED __EE13159652 := JOIN(__EE13157697,__EE13159639,__JC13159645(LEFT,RIGHT),TRANSFORM(E_Utility_Person(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13159658(E_Utility(__cfg_Local).Layout __EE5186728, E_Utility_Person(__cfg_Local).Layout __EE13159652) := __EEQP(__EE13159652.Util_,__EE5186728.UID);
  SHARED __EE13159684 := JOIN(__EE5186728,__EE13159652,__JC13159658(LEFT,RIGHT),TRANSFORM(E_Utility(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13159686 := __EE13159684;
  EXPORT Res62 := __UNWRAP(__EE13159686);
  SHARED __EE5186839 := __E_Watercraft;
  SHARED __EE5186829 := __E_Watercraft_Owner;
  SHARED __EE13161467 := __EE5186829(__NN(__EE5186829.Owner_) AND __NN(__EE5186829.W_Craft_));
  SHARED __EE13159751 := __ENH_Person;
  SHARED __EE13163394 := __EE13159751(__T(__OP2(__EE13159751.UID,=,__CN(__PPersonUID))));
  __JC13163400(E_Watercraft_Owner(__cfg_Local).Layout __EE13161467, B_Person(__cfg_Local).__ST170352_Layout __EE13163394) := __EEQP(__EE13163394.UID,__EE13161467.Owner_);
  SHARED __EE13163407 := JOIN(__EE13161467,__EE13163394,__JC13163400(LEFT,RIGHT),TRANSFORM(E_Watercraft_Owner(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13163413(E_Watercraft(__cfg_Local).Layout __EE5186839, E_Watercraft_Owner(__cfg_Local).Layout __EE13163407) := __EEQP(__EE13163407.W_Craft_,__EE5186839.UID);
  SHARED __EE13163424 := JOIN(__EE5186839,__EE13163407,__JC13163413(LEFT,RIGHT),TRANSFORM(E_Watercraft(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13163426 := __EE13163424;
  EXPORT Res63 := __UNWRAP(__EE13163426);
  SHARED __EE5186935 := __E_Zip_Code;
  SHARED __EE5186925 := __E_Zip_Code_Person;
  SHARED __EE13165185 := __EE5186925(__NN(__EE5186925.Subject_) AND __NN(__EE5186925.Zip_));
  SHARED __EE13163461 := __ENH_Person;
  SHARED __EE13167113 := __EE13163461(__T(__OP2(__EE13163461.UID,=,__CN(__PPersonUID))));
  __JC13167119(E_Zip_Code_Person(__cfg_Local).Layout __EE13165185, B_Person(__cfg_Local).__ST170352_Layout __EE13167113) := __EEQP(__EE13167113.UID,__EE13165185.Subject_);
  SHARED __EE13167127 := JOIN(__EE13165185,__EE13167113,__JC13167119(LEFT,RIGHT),TRANSFORM(E_Zip_Code_Person(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13167133(E_Zip_Code(__cfg_Local).Layout __EE5186935, E_Zip_Code_Person(__cfg_Local).Layout __EE13167127) := __EEQP(__EE13167127.Zip_,__EE5186935.UID);
  SHARED __EE13167144 := JOIN(__EE5186935,__EE13167127,__JC13167133(LEFT,RIGHT),TRANSFORM(E_Zip_Code(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13167146 := __EE13167144;
  EXPORT Res64 := __UNWRAP(__EE13167146);
  SHARED __EE5187021 := __E_Person_Email_Phone_Address;
  SHARED __EE13167258 := __EE5187021(__NN(__EE5187021.Subject_));
  SHARED __EE13167183 := __ENH_Person;
  SHARED __EE13170757 := __EE13167183(__T(__OP2(__EE13167183.UID,=,__CN(__PPersonUID))));
  __JC13170763(E_Person_Email_Phone_Address(__cfg_Local).Layout __EE13167258, B_Person(__cfg_Local).__ST170352_Layout __EE13170757) := __EEQP(__EE13170757.UID,__EE13167258.Subject_);
  SHARED __EE13170783 := JOIN(__EE13167258,__EE13170757,__JC13170763(LEFT,RIGHT),TRANSFORM(E_Person_Email_Phone_Address(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13170785 := __EE13170783;
  EXPORT Res65 := __UNWRAP(__EE13170785);
  SHARED __EE13170826 := __ENH_Address;
  SHARED __EE5187092 := __E_Address_Phone;
  SHARED __EE13171746 := __EE5187092(__NN(__EE5187092.Phone_Number_) AND __NN(__EE5187092.Location_));
  SHARED __EE5187086 := __E_Phone;
  SHARED __EE13172051 := __EE5187086(__T(__OP2(__EE5187086.UID,=,__CN(__PPhoneUID))));
  __JC13172057(E_Address_Phone(__cfg_Local).Layout __EE13171746, E_Phone(__cfg_Local).Layout __EE13172051) := __EEQP(__EE13172051.UID,__EE13171746.Phone_Number_);
  SHARED __EE13172102 := JOIN(__EE13171746,__EE13172051,__JC13172057(LEFT,RIGHT),TRANSFORM(E_Address_Phone(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13172108(B_Address_1(__cfg_Local).__ST174206_Layout __EE13170826, E_Address_Phone(__cfg_Local).Layout __EE13172102) := __EEQP(__EE13172102.Location_,__EE13170826.UID);
  SHARED __EE13172266 := JOIN(__EE13170826,__EE13172102,__JC13172108(LEFT,RIGHT),TRANSFORM(B_Address_1(__cfg_Local).__ST174206_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13172268 := __EE13172266;
  EXPORT Res66 := __UNWRAP(__EE13172268);
  SHARED __EE13172673 := __ENH_Person;
  SHARED __EE5187398 := __E_Person_Phone;
  SHARED __EE13179731 := __EE5187398(__NN(__EE5187398.Phone_Number_) AND __NN(__EE5187398.Subject_));
  SHARED __EE5187392 := __E_Phone;
  SHARED __EE13181908 := __EE5187392(__T(__OP2(__EE5187392.UID,=,__CN(__PPhoneUID))));
  __JC13181914(E_Person_Phone(__cfg_Local).Layout __EE13179731, E_Phone(__cfg_Local).Layout __EE13181908) := __EEQP(__EE13181908.UID,__EE13179731.Phone_Number_);
  SHARED __EE13181948 := JOIN(__EE13179731,__EE13181908,__JC13181914(LEFT,RIGHT),TRANSFORM(E_Person_Phone(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13181954(B_Person(__cfg_Local).__ST170352_Layout __EE13172673, E_Person_Phone(__cfg_Local).Layout __EE13181948) := __EEQP(__EE13181948.Subject_,__EE13172673.UID);
  SHARED __EE13183995 := JOIN(__EE13172673,__EE13181948,__JC13181954(LEFT,RIGHT),TRANSFORM(B_Person(__cfg_Local).__ST170352_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13183997 := __EE13183995;
  EXPORT Res67 := __UNWRAP(__EE13183997);
  SHARED __EE13188146 := __ENH_Inquiry;
  SHARED __EE5189712 := __E_Phone_Inquiry;
  SHARED __EE13188611 := __EE5189712(__NN(__EE5189712.Phone_Number_) AND __NN(__EE5189712.Transaction_));
  SHARED __EE5189706 := __E_Phone;
  SHARED __EE13188799 := __EE5189706(__T(__OP2(__EE5189706.UID,=,__CN(__PPhoneUID))));
  __JC13188805(E_Phone_Inquiry(__cfg_Local).Layout __EE13188611, E_Phone(__cfg_Local).Layout __EE13188799) := __EEQP(__EE13188799.UID,__EE13188611.Phone_Number_);
  SHARED __EE13188814 := JOIN(__EE13188611,__EE13188799,__JC13188805(LEFT,RIGHT),TRANSFORM(E_Phone_Inquiry(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13188820(B_Inquiry(__cfg_Local).__ST157264_Layout __EE13188146, E_Phone_Inquiry(__cfg_Local).Layout __EE13188814) := __EEQP(__EE13188814.Transaction_,__EE13188146.UID);
  SHARED __EE13188897 := JOIN(__EE13188146,__EE13188814,__JC13188820(LEFT,RIGHT),TRANSFORM(B_Inquiry(__cfg_Local).__ST157264_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13188899 := __EE13188897;
  EXPORT Res68 := __UNWRAP(__EE13188899);
  SHARED __EE5189890 := __E_T_I_N;
  SHARED __EE5189880 := __E_T_I_N_Phone_Number;
  SHARED __EE13189288 := __EE5189880(__NN(__EE5189880.Phone_Number_) AND __NN(__EE5189880.Tax_I_D_));
  SHARED __EE5189874 := __E_Phone;
  SHARED __EE13189405 := __EE5189874(__T(__OP2(__EE5189874.UID,=,__CN(__PPhoneUID))));
  __JC13189411(E_T_I_N_Phone_Number(__cfg_Local).Layout __EE13189288, E_Phone(__cfg_Local).Layout __EE13189405) := __EEQP(__EE13189405.UID,__EE13189288.Phone_Number_);
  SHARED __EE13189422 := JOIN(__EE13189288,__EE13189405,__JC13189411(LEFT,RIGHT),TRANSFORM(E_T_I_N_Phone_Number(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13189428(E_T_I_N(__cfg_Local).Layout __EE5189890, E_T_I_N_Phone_Number(__cfg_Local).Layout __EE13189422) := __EEQP(__EE13189422.Tax_I_D_,__EE5189890.UID);
  SHARED __EE13189432 := JOIN(__EE5189890,__EE13189422,__JC13189428(LEFT,RIGHT),TRANSFORM(E_T_I_N(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13189434 := __EE13189432;
  EXPORT Res69 := __UNWRAP(__EE13189434);
  SHARED __EE13189463 := __ENH_Second_Degree_Associations;
  SHARED __EE13189527 := __EE13189463(__NN(__EE13189463.First_Degree_Association_));
  SHARED __EE13189466 := __ENH_Person;
  SHARED __EE13193011 := __EE13189466(__T(__OP2(__EE13189466.UID,=,__CN(__PPersonUID))));
  __JC13193017(E_Second_Degree_Associations(__cfg_Local).Layout __EE13189527, B_Person(__cfg_Local).__ST170352_Layout __EE13193011) := __EEQP(__EE13193011.UID,__EE13189527.First_Degree_Association_);
  SHARED __EE13193029 := JOIN(__EE13189527,__EE13193011,__JC13193017(LEFT,RIGHT),TRANSFORM(E_Second_Degree_Associations(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13193031 := __EE13193029;
  EXPORT Res70 := __UNWRAP(__EE13193031);
  SHARED __EE13193056 := __ENH_Person;
  SHARED __EE5190045 := __E_Person_Property_Event;
  SHARED __EE13200280 := __EE5190045(__NN(__EE5190045.Event_) AND __NN(__EE5190045.Subject_));
  SHARED __EE13193059 := __ENH_Property_Event;
  SHARED __EE13197405 := __EE13193059(__NN(__EE13193059.Prop_));
  SHARED __EE13193062 := __ENH_Property;
  SHARED __EE13202621 := __EE13193062(__T(__OP2(__EE13193062.UID,=,__CN(__PPropertyUID))));
  __JC13202627(B_Property_Event_6(__cfg_Local).__ST254782_Layout __EE13197405, B_Property(__cfg_Local).__ST172673_Layout __EE13202621) := __EEQP(__EE13202621.UID,__EE13197405.Prop_);
  SHARED __EE13202695 := JOIN(__EE13197405,__EE13202621,__JC13202627(LEFT,RIGHT),TRANSFORM(B_Property_Event_6(__cfg_Local).__ST254782_Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13202701(E_Person_Property_Event(__cfg_Local).Layout __EE13200280, B_Property_Event_6(__cfg_Local).__ST254782_Layout __EE13202695) := __EEQP(__EE13202695.UID,__EE13200280.Event_);
  SHARED __EE13202720 := JOIN(__EE13200280,__EE13202695,__JC13202701(LEFT,RIGHT),TRANSFORM(E_Person_Property_Event(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13202726(B_Person(__cfg_Local).__ST170352_Layout __EE13193056, E_Person_Property_Event(__cfg_Local).Layout __EE13202720) := __EEQP(__EE13202720.Subject_,__EE13193056.UID);
  SHARED __EE13204767 := JOIN(__EE13193056,__EE13202720,__JC13202726(LEFT,RIGHT),TRANSFORM(B_Person(__cfg_Local).__ST170352_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13204769 := __EE13204767;
  EXPORT Res71 := __UNWRAP(__EE13204769);
  SHARED __EE13209022 := __ENH_Business_Sele;
  SHARED __EE5192437 := __E_Sele_Property_Event;
  SHARED __EE13214503 := __EE5192437(__NN(__EE5192437.Event_) AND __NN(__EE5192437.Legal_));
  SHARED __EE13209025 := __ENH_Property_Event;
  SHARED __EE13212097 := __EE13209025(__NN(__EE13209025.Prop_));
  SHARED __EE13209028 := __ENH_Property;
  SHARED __EE13216207 := __EE13209028(__T(__OP2(__EE13209028.UID,=,__CN(__PPropertyUID))));
  __JC13216213(B_Property_Event_6(__cfg_Local).__ST254782_Layout __EE13212097, B_Property(__cfg_Local).__ST172673_Layout __EE13216207) := __EEQP(__EE13216207.UID,__EE13212097.Prop_);
  SHARED __EE13216281 := JOIN(__EE13212097,__EE13216207,__JC13216213(LEFT,RIGHT),TRANSFORM(B_Property_Event_6(__cfg_Local).__ST254782_Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13216287(E_Sele_Property_Event(__cfg_Local).Layout __EE13214503, B_Property_Event_6(__cfg_Local).__ST254782_Layout __EE13216281) := __EEQP(__EE13216281.UID,__EE13214503.Event_);
  SHARED __EE13216309 := JOIN(__EE13214503,__EE13216281,__JC13216287(LEFT,RIGHT),TRANSFORM(E_Sele_Property_Event(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13216315(B_Business_Sele(__cfg_Local).__ST149491_Layout __EE13209022, E_Sele_Property_Event(__cfg_Local).Layout __EE13216309) := __EEQP(__EE13216309.Legal_,__EE13209022.UID);
  SHARED __EE13217716 := JOIN(__EE13209022,__EE13216309,__JC13216315(LEFT,RIGHT),TRANSFORM(B_Business_Sele(__cfg_Local).__ST149491_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13217718 := __EE13217716;
  EXPORT Res72 := __UNWRAP(__EE13217718);
  SHARED __EE13220697 := __ENH_Person;
  SHARED __EE5194109 := __E_Person_S_S_N;
  SHARED __EE13227575 := __EE5194109(__NN(__EE5194109.Social_) AND __NN(__EE5194109.Subject_));
  SHARED __EE5194103 := __E_Social_Security_Number;
  SHARED __EE13229670 := __EE5194103(__T(__OP2(__EE5194103.UID,=,__CN(__PSocialSecurityNumberUID))));
  __JC13229676(E_Person_S_S_N(__cfg_Local).Layout __EE13227575, E_Social_Security_Number(__cfg_Local).Layout __EE13229670) := __EEQP(__EE13229670.UID,__EE13227575.Social_);
  SHARED __EE13229689 := JOIN(__EE13227575,__EE13229670,__JC13229676(LEFT,RIGHT),TRANSFORM(E_Person_S_S_N(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13229695(B_Person(__cfg_Local).__ST170352_Layout __EE13220697, E_Person_S_S_N(__cfg_Local).Layout __EE13229689) := __EEQP(__EE13229689.Subject_,__EE13220697.UID);
  SHARED __EE13231736 := JOIN(__EE13220697,__EE13229689,__JC13229695(LEFT,RIGHT),TRANSFORM(B_Person(__cfg_Local).__ST170352_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13231738 := __EE13231736;
  EXPORT Res73 := __UNWRAP(__EE13231738);
  SHARED __EE13235845 := __ENH_Address;
  SHARED __EE5196400 := __E_S_S_N_Address;
  SHARED __EE13236502 := __EE5196400(__NN(__EE5196400.Social_) AND __NN(__EE5196400.Location_));
  SHARED __EE5196394 := __E_Social_Security_Number;
  SHARED __EE13236717 := __EE5196394(__T(__OP2(__EE5196394.UID,=,__CN(__PSocialSecurityNumberUID))));
  __JC13236723(E_S_S_N_Address(__cfg_Local).Layout __EE13236502, E_Social_Security_Number(__cfg_Local).Layout __EE13236717) := __EEQP(__EE13236717.UID,__EE13236502.Social_);
  SHARED __EE13236739 := JOIN(__EE13236502,__EE13236717,__JC13236723(LEFT,RIGHT),TRANSFORM(E_S_S_N_Address(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13236745(B_Address_1(__cfg_Local).__ST174206_Layout __EE13235845, E_S_S_N_Address(__cfg_Local).Layout __EE13236739) := __EEQP(__EE13236739.Location_,__EE13235845.UID);
  SHARED __EE13236903 := JOIN(__EE13235845,__EE13236739,__JC13236745(LEFT,RIGHT),TRANSFORM(B_Address_1(__cfg_Local).__ST174206_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13236905 := __EE13236903;
  EXPORT Res74 := __UNWRAP(__EE13236905);
  SHARED __EE13237252 := __ENH_Inquiry;
  SHARED __EE5196675 := __E_S_S_N_Inquiry;
  SHARED __EE13237621 := __EE5196675(__NN(__EE5196675.S_S_N_) AND __NN(__EE5196675.Transaction_));
  SHARED __EE5196669 := __E_Social_Security_Number;
  SHARED __EE13237748 := __EE5196669(__T(__OP2(__EE5196669.UID,=,__CN(__PSocialSecurityNumberUID))));
  __JC13237754(E_S_S_N_Inquiry(__cfg_Local).Layout __EE13237621, E_Social_Security_Number(__cfg_Local).Layout __EE13237748) := __EEQP(__EE13237748.UID,__EE13237621.S_S_N_);
  SHARED __EE13237763 := JOIN(__EE13237621,__EE13237748,__JC13237754(LEFT,RIGHT),TRANSFORM(E_S_S_N_Inquiry(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13237769(B_Inquiry(__cfg_Local).__ST157264_Layout __EE13237252, E_S_S_N_Inquiry(__cfg_Local).Layout __EE13237763) := __EEQP(__EE13237763.Transaction_,__EE13237252.UID);
  SHARED __EE13237846 := JOIN(__EE13237252,__EE13237763,__JC13237769(LEFT,RIGHT),TRANSFORM(B_Inquiry(__cfg_Local).__ST157264_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13237848 := __EE13237846;
  EXPORT Res75 := __UNWRAP(__EE13237848);
  SHARED __EE13238019 := __ENH_Inquiry;
  SHARED __EE5196843 := __E_T_I_N_Inquiry;
  SHARED __EE13238376 := __EE5196843(__NN(__EE5196843.Tax_I_D_) AND __NN(__EE5196843.Transaction_));
  SHARED __EE5196837 := __E_T_I_N;
  SHARED __EE13238494 := __EE5196837(__T(__OP2(__EE5196837.UID,=,__CN(__PTINUID))));
  __JC13238500(E_T_I_N_Inquiry(__cfg_Local).Layout __EE13238376, E_T_I_N(__cfg_Local).Layout __EE13238494) := __EEQP(__EE13238494.UID,__EE13238376.Tax_I_D_);
  SHARED __EE13238509 := JOIN(__EE13238376,__EE13238494,__JC13238500(LEFT,RIGHT),TRANSFORM(E_T_I_N_Inquiry(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13238515(B_Inquiry(__cfg_Local).__ST157264_Layout __EE13238019, E_T_I_N_Inquiry(__cfg_Local).Layout __EE13238509) := __EEQP(__EE13238509.Transaction_,__EE13238019.UID);
  SHARED __EE13238592 := JOIN(__EE13238019,__EE13238509,__JC13238515(LEFT,RIGHT),TRANSFORM(B_Inquiry(__cfg_Local).__ST157264_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13238594 := __EE13238592;
  EXPORT Res76 := __UNWRAP(__EE13238594);
  SHARED __EE13238765 := __ENH_Address;
  SHARED __EE5197011 := __E_T_I_N_Address;
  SHARED __EE13239406 := __EE5197011(__NN(__EE5197011.Tax_I_D_) AND __NN(__EE5197011.Location_));
  SHARED __EE5197005 := __E_T_I_N;
  SHARED __EE13239611 := __EE5197005(__T(__OP2(__EE5197005.UID,=,__CN(__PTINUID))));
  __JC13239617(E_T_I_N_Address(__cfg_Local).Layout __EE13239406, E_T_I_N(__cfg_Local).Layout __EE13239611) := __EEQP(__EE13239611.UID,__EE13239406.Tax_I_D_);
  SHARED __EE13239632 := JOIN(__EE13239406,__EE13239611,__JC13239617(LEFT,RIGHT),TRANSFORM(E_T_I_N_Address(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13239638(B_Address_1(__cfg_Local).__ST174206_Layout __EE13238765, E_T_I_N_Address(__cfg_Local).Layout __EE13239632) := __EEQP(__EE13239632.Location_,__EE13238765.UID);
  SHARED __EE13239796 := JOIN(__EE13238765,__EE13239632,__JC13239638(LEFT,RIGHT),TRANSFORM(B_Address_1(__cfg_Local).__ST174206_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13239798 := __EE13239796;
  EXPORT Res77 := __UNWRAP(__EE13239798);
  SHARED __EE5197295 := __E_Phone;
  SHARED __EE5197285 := __E_T_I_N_Phone_Number;
  SHARED __EE13240455 := __EE5197285(__NN(__EE5197285.Tax_I_D_) AND __NN(__EE5197285.Phone_Number_));
  SHARED __EE5197279 := __E_T_I_N;
  SHARED __EE13240580 := __EE5197279(__T(__OP2(__EE5197279.UID,=,__CN(__PTINUID))));
  __JC13240586(E_T_I_N_Phone_Number(__cfg_Local).Layout __EE13240455, E_T_I_N(__cfg_Local).Layout __EE13240580) := __EEQP(__EE13240580.UID,__EE13240455.Tax_I_D_);
  SHARED __EE13240597 := JOIN(__EE13240455,__EE13240580,__JC13240586(LEFT,RIGHT),TRANSFORM(E_T_I_N_Phone_Number(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13240603(E_Phone(__cfg_Local).Layout __EE5197295, E_T_I_N_Phone_Number(__cfg_Local).Layout __EE13240597) := __EEQP(__EE13240597.Phone_Number_,__EE5197295.UID);
  SHARED __EE13240685 := JOIN(__EE5197295,__EE13240597,__JC13240603(LEFT,RIGHT),TRANSFORM(E_Phone(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE13240687 := __EE13240685;
  EXPORT Res78 := __UNWRAP(__EE13240687);
  SHARED __EE13240872 := __ENH_Person;
  SHARED __EE5197462 := __E_Zip_Code_Person;
  SHARED __EE13247728 := __EE5197462(__NN(__EE5197462.Zip_) AND __NN(__EE5197462.Subject_));
  SHARED __EE5197456 := __E_Zip_Code;
  SHARED __EE13249815 := __EE5197456(__T(__OP2(__EE5197456.UID,=,__CN(__PZipCodeUID))));
  __JC13249821(E_Zip_Code_Person(__cfg_Local).Layout __EE13247728, E_Zip_Code(__cfg_Local).Layout __EE13249815) := __EEQP(__EE13249815.UID,__EE13247728.Zip_);
  SHARED __EE13249829 := JOIN(__EE13247728,__EE13249815,__JC13249821(LEFT,RIGHT),TRANSFORM(E_Zip_Code_Person(__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC13249835(B_Person(__cfg_Local).__ST170352_Layout __EE13240872, E_Zip_Code_Person(__cfg_Local).Layout __EE13249829) := __EEQP(__EE13249829.Subject_,__EE13240872.UID);
  SHARED __EE13251876 := JOIN(__EE13240872,__EE13249829,__JC13249835(LEFT,RIGHT),TRANSFORM(B_Person(__cfg_Local).__ST170352_Layout,SELF:=LEFT),SMART,KEEP(1));
  EXPORT Res79 := __UNWRAP(__EE13251876);
  EXPORT DBG_E_Accident_Result := __UNWRAP(E_Accident_Filtered.__Result);
  EXPORT DBG_E_Address_Result := __UNWRAP(E_Address_Filtered.__Result);
  EXPORT DBG_E_Address_Inquiry_Result := __UNWRAP(E_Address_Inquiry_Filtered.__Result);
  EXPORT DBG_E_Address_Phone_Result := __UNWRAP(E_Address_Phone_Filtered.__Result);
  EXPORT DBG_E_Address_Property_Result := __UNWRAP(E_Address_Property_Filtered.__Result);
  EXPORT DBG_E_Address_Property_Event_Result := __UNWRAP(E_Address_Property_Event_Filtered.__Result);
  EXPORT DBG_E_Aircraft_Result := __UNWRAP(E_Aircraft_Filtered.__Result);
  EXPORT DBG_E_Aircraft_Owner_Result := __UNWRAP(E_Aircraft_Owner_Filtered.__Result);
  EXPORT DBG_E_Bankruptcy_Result := __UNWRAP(E_Bankruptcy_Filtered.__Result);
  EXPORT DBG_E_Business_Prox_Result := __UNWRAP(E_Business_Prox_Filtered.__Result);
  EXPORT DBG_E_Business_Sele_Result := __UNWRAP(E_Business_Sele_Filtered.__Result);
  EXPORT DBG_E_Business_Sele_Overflow_Result := __UNWRAP(E_Business_Sele_Overflow_Filtered.__Result);
  EXPORT DBG_E_Criminal_Details_Result := __UNWRAP(E_Criminal_Details_Filtered.__Result);
  EXPORT DBG_E_Criminal_Offender_Result := __UNWRAP(E_Criminal_Offender_Filtered.__Result);
  EXPORT DBG_E_Criminal_Offense_Result := __UNWRAP(E_Criminal_Offense_Filtered.__Result);
  EXPORT DBG_E_Criminal_Punishment_Result := __UNWRAP(E_Criminal_Punishment_Filtered.__Result);
  EXPORT DBG_E_Drivers_License_Result := __UNWRAP(E_Drivers_License_Filtered.__Result);
  EXPORT DBG_E_E_B_R_Tradeline_Result := __UNWRAP(E_E_B_R_Tradeline_Filtered.__Result);
  EXPORT DBG_E_Education_Result := __UNWRAP(E_Education_Filtered.__Result);
  EXPORT DBG_E_Email_Result := __UNWRAP(E_Email_Filtered.__Result);
  EXPORT DBG_E_Email_Inquiry_Result := __UNWRAP(E_Email_Inquiry_Filtered.__Result);
  EXPORT DBG_E_First_Degree_Associations_Result := __UNWRAP(E_First_Degree_Associations_Filtered.__Result);
  EXPORT DBG_E_First_Degree_Relative_Result := __UNWRAP(E_First_Degree_Relative_Filtered.__Result);
  EXPORT DBG_E_House_Hold_Phone_Result := __UNWRAP(E_House_Hold_Phone_Filtered.__Result);
  EXPORT DBG_E_Household_Result := __UNWRAP(E_Household_Filtered.__Result);
  EXPORT DBG_E_Household_Member_Result := __UNWRAP(E_Household_Member_Filtered.__Result);
  EXPORT DBG_E_Input_B_I_I_Result := __UNWRAP(E_Input_B_I_I_Filtered.__Result);
  EXPORT DBG_E_Input_B_I_I_Input_P_I_I_Result := __UNWRAP(E_Input_B_I_I_Input_P_I_I_Filtered.__Result);
  EXPORT DBG_E_Input_P_I_I_Result := __UNWRAP(E_Input_P_I_I_Filtered.__Result);
  EXPORT DBG_E_Inquiry_Result := __UNWRAP(E_Inquiry_Filtered.__Result);
  EXPORT DBG_E_Lien_Judgment_Result := __UNWRAP(E_Lien_Judgment_Filtered.__Result);
  EXPORT DBG_E_Person_Result := __UNWRAP(E_Person_Filtered.__Result);
  EXPORT DBG_E_Person_Accident_Result := __UNWRAP(E_Person_Accident_Filtered.__Result);
  EXPORT DBG_E_Person_Address_Result := __UNWRAP(E_Person_Address_Filtered.__Result);
  EXPORT DBG_E_Person_Bankruptcy_Result := __UNWRAP(E_Person_Bankruptcy_Filtered.__Result);
  EXPORT DBG_E_Person_Drivers_License_Result := __UNWRAP(E_Person_Drivers_License_Filtered.__Result);
  EXPORT DBG_E_Person_Education_Result := __UNWRAP(E_Person_Education_Filtered.__Result);
  EXPORT DBG_E_Person_Email_Result := __UNWRAP(E_Person_Email_Filtered.__Result);
  EXPORT DBG_E_Person_Email_Phone_Address_Result := __UNWRAP(E_Person_Email_Phone_Address_Filtered.__Result);
  EXPORT DBG_E_Person_Inquiry_Result := __UNWRAP(E_Person_Inquiry_Filtered.__Result);
  EXPORT DBG_E_Person_Lien_Judgment_Result := __UNWRAP(E_Person_Lien_Judgment_Filtered.__Result);
  EXPORT DBG_E_Person_Offender_Result := __UNWRAP(E_Person_Offender_Filtered.__Result);
  EXPORT DBG_E_Person_Offenses_Result := __UNWRAP(E_Person_Offenses_Filtered.__Result);
  EXPORT DBG_E_Person_Phone_Result := __UNWRAP(E_Person_Phone_Filtered.__Result);
  EXPORT DBG_E_Person_Property_Result := __UNWRAP(E_Person_Property_Filtered.__Result);
  EXPORT DBG_E_Person_Property_Event_Result := __UNWRAP(E_Person_Property_Event_Filtered.__Result);
  EXPORT DBG_E_Person_S_S_N_Result := __UNWRAP(E_Person_S_S_N_Filtered.__Result);
  EXPORT DBG_E_Person_Sex_Offender_Result := __UNWRAP(E_Person_Sex_Offender_Filtered.__Result);
  EXPORT DBG_E_Person_Vehicle_Result := __UNWRAP(E_Person_Vehicle_Filtered.__Result);
  EXPORT DBG_E_Phone_Result := __UNWRAP(E_Phone_Filtered.__Result);
  EXPORT DBG_E_Phone_Inquiry_Result := __UNWRAP(E_Phone_Inquiry_Filtered.__Result);
  EXPORT DBG_E_Professional_License_Result := __UNWRAP(E_Professional_License_Filtered.__Result);
  EXPORT DBG_E_Professional_License_Person_Result := __UNWRAP(E_Professional_License_Person_Filtered.__Result);
  EXPORT DBG_E_Property_Result := __UNWRAP(E_Property_Filtered.__Result);
  EXPORT DBG_E_Property_Event_Result := __UNWRAP(E_Property_Event_Filtered.__Result);
  EXPORT DBG_E_Prox_Address_Result := __UNWRAP(E_Prox_Address_Filtered.__Result);
  EXPORT DBG_E_Prox_Email_Result := __UNWRAP(E_Prox_Email_Filtered.__Result);
  EXPORT DBG_E_Prox_Person_Result := __UNWRAP(E_Prox_Person_Filtered.__Result);
  EXPORT DBG_E_Prox_Phone_Number_Result := __UNWRAP(E_Prox_Phone_Number_Filtered.__Result);
  EXPORT DBG_E_Prox_T_I_N_Result := __UNWRAP(E_Prox_T_I_N_Filtered.__Result);
  EXPORT DBG_E_Prox_Utility_Result := __UNWRAP(E_Prox_Utility_Filtered.__Result);
  EXPORT DBG_E_S_S_N_Address_Result := __UNWRAP(E_S_S_N_Address_Filtered.__Result);
  EXPORT DBG_E_S_S_N_Inquiry_Result := __UNWRAP(E_S_S_N_Inquiry_Filtered.__Result);
  EXPORT DBG_E_Second_Degree_Associations_Result := __UNWRAP(E_Second_Degree_Associations_Filtered.__Result);
  EXPORT DBG_E_Sele_Address_Result := __UNWRAP(E_Sele_Address_Filtered.__Result);
  EXPORT DBG_E_Sele_Aircraft_Result := __UNWRAP(E_Sele_Aircraft_Filtered.__Result);
  EXPORT DBG_E_Sele_Bankruptcy_Result := __UNWRAP(E_Sele_Bankruptcy_Filtered.__Result);
  EXPORT DBG_E_Sele_E_B_R_Tradeline_Result := __UNWRAP(E_Sele_E_B_R_Tradeline_Filtered.__Result);
  EXPORT DBG_E_Sele_Email_Result := __UNWRAP(E_Sele_Email_Filtered.__Result);
  EXPORT DBG_E_Sele_Inquiry_Result := __UNWRAP(E_Sele_Inquiry_Filtered.__Result);
  EXPORT DBG_E_Sele_Lien_Judgment_Result := __UNWRAP(E_Sele_Lien_Judgment_Filtered.__Result);
  EXPORT DBG_E_Sele_Person_Result := __UNWRAP(E_Sele_Person_Filtered.__Result);
  EXPORT DBG_E_Sele_Phone_Number_Result := __UNWRAP(E_Sele_Phone_Number_Filtered.__Result);
  EXPORT DBG_E_Sele_Property_Result := __UNWRAP(E_Sele_Property_Filtered.__Result);
  EXPORT DBG_E_Sele_Property_Event_Result := __UNWRAP(E_Sele_Property_Event_Filtered.__Result);
  EXPORT DBG_E_Sele_T_I_N_Result := __UNWRAP(E_Sele_T_I_N_Filtered.__Result);
  EXPORT DBG_E_Sele_Tradeline_Result := __UNWRAP(E_Sele_Tradeline_Filtered.__Result);
  EXPORT DBG_E_Sele_U_C_C_Result := __UNWRAP(E_Sele_U_C_C_Filtered.__Result);
  EXPORT DBG_E_Sele_Utility_Result := __UNWRAP(E_Sele_Utility_Filtered.__Result);
  EXPORT DBG_E_Sele_Vehicle_Result := __UNWRAP(E_Sele_Vehicle_Filtered.__Result);
  EXPORT DBG_E_Sele_Watercraft_Result := __UNWRAP(E_Sele_Watercraft_Filtered.__Result);
  EXPORT DBG_E_Sex_Offender_Result := __UNWRAP(E_Sex_Offender_Filtered.__Result);
  EXPORT DBG_E_Social_Security_Number_Result := __UNWRAP(E_Social_Security_Number_Filtered.__Result);
  EXPORT DBG_E_T_I_N_Result := __UNWRAP(E_T_I_N_Filtered.__Result);
  EXPORT DBG_E_T_I_N_Address_Result := __UNWRAP(E_T_I_N_Address_Filtered.__Result);
  EXPORT DBG_E_T_I_N_Inquiry_Result := __UNWRAP(E_T_I_N_Inquiry_Filtered.__Result);
  EXPORT DBG_E_T_I_N_Phone_Number_Result := __UNWRAP(E_T_I_N_Phone_Number_Filtered.__Result);
  EXPORT DBG_E_Tradeline_Result := __UNWRAP(E_Tradeline_Filtered.__Result);
  EXPORT DBG_E_U_C_C_Result := __UNWRAP(E_U_C_C_Filtered.__Result);
  EXPORT DBG_E_Utility_Result := __UNWRAP(E_Utility_Filtered.__Result);
  EXPORT DBG_E_Utility_Address_Result := __UNWRAP(E_Utility_Address_Filtered.__Result);
  EXPORT DBG_E_Utility_Person_Result := __UNWRAP(E_Utility_Person_Filtered.__Result);
  EXPORT DBG_E_Vehicle_Result := __UNWRAP(E_Vehicle_Filtered.__Result);
  EXPORT DBG_E_Watercraft_Result := __UNWRAP(E_Watercraft_Filtered.__Result);
  EXPORT DBG_E_Watercraft_Owner_Result := __UNWRAP(E_Watercraft_Owner_Filtered.__Result);
  EXPORT DBG_E_Zip_Code_Result := __UNWRAP(E_Zip_Code_Filtered.__Result);
  EXPORT DBG_E_Zip_Code_Person_Result := __UNWRAP(E_Zip_Code_Person_Filtered.__Result);
  EXPORT DBG_E_Lien_Judgment_Intermediate_13 := __UNWRAP(B_Lien_Judgment_13_Local.__ENH_Lien_Judgment_13);
  EXPORT DBG_E_U_C_C_Intermediate_13 := __UNWRAP(B_U_C_C_13_Local.__ENH_U_C_C_13);
  EXPORT DBG_E_Lien_Judgment_Intermediate_12 := __UNWRAP(B_Lien_Judgment_12_Local.__ENH_Lien_Judgment_12);
  EXPORT DBG_E_Person_Lien_Judgment_Intermediate_12 := __UNWRAP(B_Person_Lien_Judgment_12_Local.__ENH_Person_Lien_Judgment_12);
  EXPORT DBG_E_U_C_C_Intermediate_12 := __UNWRAP(B_U_C_C_12_Local.__ENH_U_C_C_12);
  EXPORT DBG_E_Inquiry_Intermediate_11 := __UNWRAP(B_Inquiry_11_Local.__ENH_Inquiry_11);
  EXPORT DBG_E_Lien_Judgment_Intermediate_11 := __UNWRAP(B_Lien_Judgment_11_Local.__ENH_Lien_Judgment_11);
  EXPORT DBG_E_Person_Intermediate_11 := __UNWRAP(B_Person_11_Local.__ENH_Person_11);
  EXPORT DBG_E_Sele_Lien_Judgment_Intermediate_11 := __UNWRAP(B_Sele_Lien_Judgment_11_Local.__ENH_Sele_Lien_Judgment_11);
  EXPORT DBG_E_U_C_C_Intermediate_11 := __UNWRAP(B_U_C_C_11_Local.__ENH_U_C_C_11);
  EXPORT DBG_E_Business_Sele_Intermediate_10 := __UNWRAP(B_Business_Sele_10_Local.__ENH_Business_Sele_10);
  EXPORT DBG_E_Input_B_I_I_Intermediate_10 := __UNWRAP(B_Input_B_I_I_10_Local.__ENH_Input_B_I_I_10);
  EXPORT DBG_E_Inquiry_Intermediate_10 := __UNWRAP(B_Inquiry_10_Local.__ENH_Inquiry_10);
  EXPORT DBG_E_Lien_Judgment_Intermediate_10 := __UNWRAP(B_Lien_Judgment_10_Local.__ENH_Lien_Judgment_10);
  EXPORT DBG_E_Person_Intermediate_10 := __UNWRAP(B_Person_10_Local.__ENH_Person_10);
  EXPORT DBG_E_Tradeline_Intermediate_10 := __UNWRAP(B_Tradeline_10_Local.__ENH_Tradeline_10);
  EXPORT DBG_E_U_C_C_Intermediate_10 := __UNWRAP(B_U_C_C_10_Local.__ENH_U_C_C_10);
  EXPORT DBG_E_Business_Sele_Intermediate_9 := __UNWRAP(B_Business_Sele_9_Local.__ENH_Business_Sele_9);
  EXPORT DBG_E_Input_B_I_I_Intermediate_9 := __UNWRAP(B_Input_B_I_I_9_Local.__ENH_Input_B_I_I_9);
  EXPORT DBG_E_Input_P_I_I_Intermediate_9 := __UNWRAP(B_Input_P_I_I_9_Local.__ENH_Input_P_I_I_9);
  EXPORT DBG_E_Inquiry_Intermediate_9 := __UNWRAP(B_Inquiry_9_Local.__ENH_Inquiry_9);
  EXPORT DBG_E_Lien_Judgment_Intermediate_9 := __UNWRAP(B_Lien_Judgment_9_Local.__ENH_Lien_Judgment_9);
  EXPORT DBG_E_Person_Intermediate_9 := __UNWRAP(B_Person_9_Local.__ENH_Person_9);
  EXPORT DBG_E_Sele_U_C_C_Intermediate_9 := __UNWRAP(B_Sele_U_C_C_9_Local.__ENH_Sele_U_C_C_9);
  EXPORT DBG_E_Tradeline_Intermediate_9 := __UNWRAP(B_Tradeline_9_Local.__ENH_Tradeline_9);
  EXPORT DBG_E_U_C_C_Intermediate_9 := __UNWRAP(B_U_C_C_9_Local.__ENH_U_C_C_9);
  EXPORT DBG_E_Bankruptcy_Intermediate_8 := __UNWRAP(B_Bankruptcy_8_Local.__ENH_Bankruptcy_8);
  EXPORT DBG_E_Business_Sele_Intermediate_8 := __UNWRAP(B_Business_Sele_8_Local.__ENH_Business_Sele_8);
  EXPORT DBG_E_Input_B_I_I_Intermediate_8 := __UNWRAP(B_Input_B_I_I_8_Local.__ENH_Input_B_I_I_8);
  EXPORT DBG_E_Input_P_I_I_Intermediate_8 := __UNWRAP(B_Input_P_I_I_8_Local.__ENH_Input_P_I_I_8);
  EXPORT DBG_E_Inquiry_Intermediate_8 := __UNWRAP(B_Inquiry_8_Local.__ENH_Inquiry_8);
  EXPORT DBG_E_Lien_Judgment_Intermediate_8 := __UNWRAP(B_Lien_Judgment_8_Local.__ENH_Lien_Judgment_8);
  EXPORT DBG_E_Person_Intermediate_8 := __UNWRAP(B_Person_8_Local.__ENH_Person_8);
  EXPORT DBG_E_Person_Accident_Intermediate_8 := __UNWRAP(B_Person_Accident_8_Local.__ENH_Person_Accident_8);
  EXPORT DBG_E_Person_Inquiry_Intermediate_8 := __UNWRAP(B_Person_Inquiry_8_Local.__ENH_Person_Inquiry_8);
  EXPORT DBG_E_Person_Property_Intermediate_8 := __UNWRAP(B_Person_Property_8_Local.__ENH_Person_Property_8);
  EXPORT DBG_E_Property_Event_Intermediate_8 := __UNWRAP(B_Property_Event_8_Local.__ENH_Property_Event_8);
  EXPORT DBG_E_Sele_U_C_C_Intermediate_8 := __UNWRAP(B_Sele_U_C_C_8_Local.__ENH_Sele_U_C_C_8);
  EXPORT DBG_E_Tradeline_Intermediate_8 := __UNWRAP(B_Tradeline_8_Local.__ENH_Tradeline_8);
  EXPORT DBG_E_U_C_C_Intermediate_8 := __UNWRAP(B_U_C_C_8_Local.__ENH_U_C_C_8);
  EXPORT DBG_E_Bankruptcy_Intermediate_7 := __UNWRAP(B_Bankruptcy_7_Local.__ENH_Bankruptcy_7);
  EXPORT DBG_E_Business_Sele_Intermediate_7 := __UNWRAP(B_Business_Sele_7_Local.__ENH_Business_Sele_7);
  EXPORT DBG_E_Education_Intermediate_7 := __UNWRAP(B_Education_7_Local.__ENH_Education_7);
  EXPORT DBG_E_Input_B_I_I_Intermediate_7 := __UNWRAP(B_Input_B_I_I_7_Local.__ENH_Input_B_I_I_7);
  EXPORT DBG_E_Input_P_I_I_Intermediate_7 := __UNWRAP(B_Input_P_I_I_7_Local.__ENH_Input_P_I_I_7);
  EXPORT DBG_E_Inquiry_Intermediate_7 := __UNWRAP(B_Inquiry_7_Local.__ENH_Inquiry_7);
  EXPORT DBG_E_Lien_Judgment_Intermediate_7 := __UNWRAP(B_Lien_Judgment_7_Local.__ENH_Lien_Judgment_7);
  EXPORT DBG_E_Person_Intermediate_7 := __UNWRAP(B_Person_7_Local.__ENH_Person_7);
  EXPORT DBG_E_Person_Inquiry_Intermediate_7 := __UNWRAP(B_Person_Inquiry_7_Local.__ENH_Person_Inquiry_7);
  EXPORT DBG_E_Person_Property_Intermediate_7 := __UNWRAP(B_Person_Property_7_Local.__ENH_Person_Property_7);
  EXPORT DBG_E_Property_Event_Intermediate_7 := __UNWRAP(B_Property_Event_7_Local.__ENH_Property_Event_7);
  EXPORT DBG_E_Sele_Person_Intermediate_7 := __UNWRAP(B_Sele_Person_7_Local.__ENH_Sele_Person_7);
  EXPORT DBG_E_Sele_U_C_C_Intermediate_7 := __UNWRAP(B_Sele_U_C_C_7_Local.__ENH_Sele_U_C_C_7);
  EXPORT DBG_E_Tradeline_Intermediate_7 := __UNWRAP(B_Tradeline_7_Local.__ENH_Tradeline_7);
  EXPORT DBG_E_U_C_C_Intermediate_7 := __UNWRAP(B_U_C_C_7_Local.__ENH_U_C_C_7);
  EXPORT DBG_E_Address_Intermediate_6 := __UNWRAP(B_Address_6_Local.__ENH_Address_6);
  EXPORT DBG_E_Bankruptcy_Intermediate_6 := __UNWRAP(B_Bankruptcy_6_Local.__ENH_Bankruptcy_6);
  EXPORT DBG_E_Business_Sele_Intermediate_6 := __UNWRAP(B_Business_Sele_6_Local.__ENH_Business_Sele_6);
  EXPORT DBG_E_Business_Sele_Overflow_Intermediate_6 := __UNWRAP(B_Business_Sele_Overflow_6_Local.__ENH_Business_Sele_Overflow_6);
  EXPORT DBG_E_Education_Intermediate_6 := __UNWRAP(B_Education_6_Local.__ENH_Education_6);
  EXPORT DBG_E_Input_B_I_I_Intermediate_6 := __UNWRAP(B_Input_B_I_I_6_Local.__ENH_Input_B_I_I_6);
  EXPORT DBG_E_Input_P_I_I_Intermediate_6 := __UNWRAP(B_Input_P_I_I_6_Local.__ENH_Input_P_I_I_6);
  EXPORT DBG_E_Inquiry_Intermediate_6 := __UNWRAP(B_Inquiry_6_Local.__ENH_Inquiry_6);
  EXPORT DBG_E_Lien_Judgment_Intermediate_6 := __UNWRAP(B_Lien_Judgment_6_Local.__ENH_Lien_Judgment_6);
  EXPORT DBG_E_Person_Intermediate_6 := __UNWRAP(B_Person_6_Local.__ENH_Person_6);
  EXPORT DBG_E_Person_Inquiry_Intermediate_6 := __UNWRAP(B_Person_Inquiry_6_Local.__ENH_Person_Inquiry_6);
  EXPORT DBG_E_Person_Property_Intermediate_6 := __UNWRAP(B_Person_Property_6_Local.__ENH_Person_Property_6);
  EXPORT DBG_E_Person_S_S_N_Intermediate_6 := __UNWRAP(B_Person_S_S_N_6_Local.__ENH_Person_S_S_N_6);
  EXPORT DBG_E_Property_Event_Intermediate_6 := __UNWRAP(B_Property_Event_6_Local.__ENH_Property_Event_6);
  EXPORT DBG_E_Sele_Address_Intermediate_6 := __UNWRAP(B_Sele_Address_6_Local.__ENH_Sele_Address_6);
  EXPORT DBG_E_Sele_Person_Intermediate_6 := __UNWRAP(B_Sele_Person_6_Local.__ENH_Sele_Person_6);
  EXPORT DBG_E_Sele_Phone_Number_Intermediate_6 := __UNWRAP(B_Sele_Phone_Number_6_Local.__ENH_Sele_Phone_Number_6);
  EXPORT DBG_E_Sele_T_I_N_Intermediate_6 := __UNWRAP(B_Sele_T_I_N_6_Local.__ENH_Sele_T_I_N_6);
  EXPORT DBG_E_Sele_U_C_C_Intermediate_6 := __UNWRAP(B_Sele_U_C_C_6_Local.__ENH_Sele_U_C_C_6);
  EXPORT DBG_E_Tradeline_Intermediate_6 := __UNWRAP(B_Tradeline_6_Local.__ENH_Tradeline_6);
  EXPORT DBG_E_U_C_C_Intermediate_6 := __UNWRAP(B_U_C_C_6_Local.__ENH_U_C_C_6);
  EXPORT DBG_E_Address_Intermediate_5 := __UNWRAP(B_Address_5_Local.__ENH_Address_5);
  EXPORT DBG_E_Bankruptcy_Intermediate_5 := __UNWRAP(B_Bankruptcy_5_Local.__ENH_Bankruptcy_5);
  EXPORT DBG_E_Business_Sele_Intermediate_5 := __UNWRAP(B_Business_Sele_5_Local.__ENH_Business_Sele_5);
  EXPORT DBG_E_Business_Sele_Overflow_Intermediate_5 := __UNWRAP(B_Business_Sele_Overflow_5_Local.__ENH_Business_Sele_Overflow_5);
  EXPORT DBG_E_Criminal_Offense_Intermediate_5 := __UNWRAP(B_Criminal_Offense_5_Local.__ENH_Criminal_Offense_5);
  EXPORT DBG_E_Education_Intermediate_5 := __UNWRAP(B_Education_5_Local.__ENH_Education_5);
  EXPORT DBG_E_First_Degree_Relative_Intermediate_5 := __UNWRAP(B_First_Degree_Relative_5_Local.__ENH_First_Degree_Relative_5);
  EXPORT DBG_E_Input_B_I_I_Intermediate_5 := __UNWRAP(B_Input_B_I_I_5_Local.__ENH_Input_B_I_I_5);
  EXPORT DBG_E_Input_P_I_I_Intermediate_5 := __UNWRAP(B_Input_P_I_I_5_Local.__ENH_Input_P_I_I_5);
  EXPORT DBG_E_Inquiry_Intermediate_5 := __UNWRAP(B_Inquiry_5_Local.__ENH_Inquiry_5);
  EXPORT DBG_E_Lien_Judgment_Intermediate_5 := __UNWRAP(B_Lien_Judgment_5_Local.__ENH_Lien_Judgment_5);
  EXPORT DBG_E_Person_Intermediate_5 := __UNWRAP(B_Person_5_Local.__ENH_Person_5);
  EXPORT DBG_E_Person_Inquiry_Intermediate_5 := __UNWRAP(B_Person_Inquiry_5_Local.__ENH_Person_Inquiry_5);
  EXPORT DBG_E_Person_Property_Intermediate_5 := __UNWRAP(B_Person_Property_5_Local.__ENH_Person_Property_5);
  EXPORT DBG_E_Person_S_S_N_Intermediate_5 := __UNWRAP(B_Person_S_S_N_5_Local.__ENH_Person_S_S_N_5);
  EXPORT DBG_E_Professional_License_Intermediate_5 := __UNWRAP(B_Professional_License_5_Local.__ENH_Professional_License_5);
  EXPORT DBG_E_Property_Intermediate_5 := __UNWRAP(B_Property_5_Local.__ENH_Property_5);
  EXPORT DBG_E_Property_Event_Intermediate_5 := __UNWRAP(B_Property_Event_5_Local.__ENH_Property_Event_5);
  EXPORT DBG_E_Sele_Address_Intermediate_5 := __UNWRAP(B_Sele_Address_5_Local.__ENH_Sele_Address_5);
  EXPORT DBG_E_Sele_Person_Intermediate_5 := __UNWRAP(B_Sele_Person_5_Local.__ENH_Sele_Person_5);
  EXPORT DBG_E_Sele_Phone_Number_Intermediate_5 := __UNWRAP(B_Sele_Phone_Number_5_Local.__ENH_Sele_Phone_Number_5);
  EXPORT DBG_E_Sele_T_I_N_Intermediate_5 := __UNWRAP(B_Sele_T_I_N_5_Local.__ENH_Sele_T_I_N_5);
  EXPORT DBG_E_Sele_U_C_C_Intermediate_5 := __UNWRAP(B_Sele_U_C_C_5_Local.__ENH_Sele_U_C_C_5);
  EXPORT DBG_E_Tradeline_Intermediate_5 := __UNWRAP(B_Tradeline_5_Local.__ENH_Tradeline_5);
  EXPORT DBG_E_U_C_C_Intermediate_5 := __UNWRAP(B_U_C_C_5_Local.__ENH_U_C_C_5);
  EXPORT DBG_E_Address_Intermediate_4 := __UNWRAP(B_Address_4_Local.__ENH_Address_4);
  EXPORT DBG_E_Bankruptcy_Intermediate_4 := __UNWRAP(B_Bankruptcy_4_Local.__ENH_Bankruptcy_4);
  EXPORT DBG_E_Business_Sele_Intermediate_4 := __UNWRAP(B_Business_Sele_4_Local.__ENH_Business_Sele_4);
  EXPORT DBG_E_Business_Sele_Overflow_Intermediate_4 := __UNWRAP(B_Business_Sele_Overflow_4_Local.__ENH_Business_Sele_Overflow_4);
  EXPORT DBG_E_Criminal_Offense_Intermediate_4 := __UNWRAP(B_Criminal_Offense_4_Local.__ENH_Criminal_Offense_4);
  EXPORT DBG_E_Education_Intermediate_4 := __UNWRAP(B_Education_4_Local.__ENH_Education_4);
  EXPORT DBG_E_First_Degree_Relative_Intermediate_4 := __UNWRAP(B_First_Degree_Relative_4_Local.__ENH_First_Degree_Relative_4);
  EXPORT DBG_E_Input_B_I_I_Intermediate_4 := __UNWRAP(B_Input_B_I_I_4_Local.__ENH_Input_B_I_I_4);
  EXPORT DBG_E_Input_P_I_I_Intermediate_4 := __UNWRAP(B_Input_P_I_I_4_Local.__ENH_Input_P_I_I_4);
  EXPORT DBG_E_Inquiry_Intermediate_4 := __UNWRAP(B_Inquiry_4_Local.__ENH_Inquiry_4);
  EXPORT DBG_E_Lien_Judgment_Intermediate_4 := __UNWRAP(B_Lien_Judgment_4_Local.__ENH_Lien_Judgment_4);
  EXPORT DBG_E_Person_Intermediate_4 := __UNWRAP(B_Person_4_Local.__ENH_Person_4);
  EXPORT DBG_E_Person_Inquiry_Intermediate_4 := __UNWRAP(B_Person_Inquiry_4_Local.__ENH_Person_Inquiry_4);
  EXPORT DBG_E_Person_Property_Intermediate_4 := __UNWRAP(B_Person_Property_4_Local.__ENH_Person_Property_4);
  EXPORT DBG_E_Person_S_S_N_Intermediate_4 := __UNWRAP(B_Person_S_S_N_4_Local.__ENH_Person_S_S_N_4);
  EXPORT DBG_E_Professional_License_Intermediate_4 := __UNWRAP(B_Professional_License_4_Local.__ENH_Professional_License_4);
  EXPORT DBG_E_Property_Intermediate_4 := __UNWRAP(B_Property_4_Local.__ENH_Property_4);
  EXPORT DBG_E_Property_Event_Intermediate_4 := __UNWRAP(B_Property_Event_4_Local.__ENH_Property_Event_4);
  EXPORT DBG_E_Sele_Address_Intermediate_4 := __UNWRAP(B_Sele_Address_4_Local.__ENH_Sele_Address_4);
  EXPORT DBG_E_Sele_Person_Intermediate_4 := __UNWRAP(B_Sele_Person_4_Local.__ENH_Sele_Person_4);
  EXPORT DBG_E_Sele_Phone_Number_Intermediate_4 := __UNWRAP(B_Sele_Phone_Number_4_Local.__ENH_Sele_Phone_Number_4);
  EXPORT DBG_E_Sele_Property_Intermediate_4 := __UNWRAP(B_Sele_Property_4_Local.__ENH_Sele_Property_4);
  EXPORT DBG_E_Sele_T_I_N_Intermediate_4 := __UNWRAP(B_Sele_T_I_N_4_Local.__ENH_Sele_T_I_N_4);
  EXPORT DBG_E_Sele_U_C_C_Intermediate_4 := __UNWRAP(B_Sele_U_C_C_4_Local.__ENH_Sele_U_C_C_4);
  EXPORT DBG_E_Tradeline_Intermediate_4 := __UNWRAP(B_Tradeline_4_Local.__ENH_Tradeline_4);
  EXPORT DBG_E_U_C_C_Intermediate_4 := __UNWRAP(B_U_C_C_4_Local.__ENH_U_C_C_4);
  EXPORT DBG_E_Address_Intermediate_3 := __UNWRAP(B_Address_3_Local.__ENH_Address_3);
  EXPORT DBG_E_Aircraft_Owner_Intermediate_3 := __UNWRAP(B_Aircraft_Owner_3_Local.__ENH_Aircraft_Owner_3);
  EXPORT DBG_E_Bankruptcy_Intermediate_3 := __UNWRAP(B_Bankruptcy_3_Local.__ENH_Bankruptcy_3);
  EXPORT DBG_E_Business_Prox_Intermediate_3 := __UNWRAP(B_Business_Prox_3_Local.__ENH_Business_Prox_3);
  EXPORT DBG_E_Business_Sele_Intermediate_3 := __UNWRAP(B_Business_Sele_3_Local.__ENH_Business_Sele_3);
  EXPORT DBG_E_Business_Sele_Overflow_Intermediate_3 := __UNWRAP(B_Business_Sele_Overflow_3_Local.__ENH_Business_Sele_Overflow_3);
  EXPORT DBG_E_Criminal_Offense_Intermediate_3 := __UNWRAP(B_Criminal_Offense_3_Local.__ENH_Criminal_Offense_3);
  EXPORT DBG_E_Education_Intermediate_3 := __UNWRAP(B_Education_3_Local.__ENH_Education_3);
  EXPORT DBG_E_First_Degree_Relative_Intermediate_3 := __UNWRAP(B_First_Degree_Relative_3_Local.__ENH_First_Degree_Relative_3);
  EXPORT DBG_E_Input_B_I_I_Intermediate_3 := __UNWRAP(B_Input_B_I_I_3_Local.__ENH_Input_B_I_I_3);
  EXPORT DBG_E_Input_P_I_I_Intermediate_3 := __UNWRAP(B_Input_P_I_I_3_Local.__ENH_Input_P_I_I_3);
  EXPORT DBG_E_Inquiry_Intermediate_3 := __UNWRAP(B_Inquiry_3_Local.__ENH_Inquiry_3);
  EXPORT DBG_E_Lien_Judgment_Intermediate_3 := __UNWRAP(B_Lien_Judgment_3_Local.__ENH_Lien_Judgment_3);
  EXPORT DBG_E_Person_Intermediate_3 := __UNWRAP(B_Person_3_Local.__ENH_Person_3);
  EXPORT DBG_E_Person_Address_Intermediate_3 := __UNWRAP(B_Person_Address_3_Local.__ENH_Person_Address_3);
  EXPORT DBG_E_Person_Inquiry_Intermediate_3 := __UNWRAP(B_Person_Inquiry_3_Local.__ENH_Person_Inquiry_3);
  EXPORT DBG_E_Person_Property_Intermediate_3 := __UNWRAP(B_Person_Property_3_Local.__ENH_Person_Property_3);
  EXPORT DBG_E_Person_S_S_N_Intermediate_3 := __UNWRAP(B_Person_S_S_N_3_Local.__ENH_Person_S_S_N_3);
  EXPORT DBG_E_Person_Vehicle_Intermediate_3 := __UNWRAP(B_Person_Vehicle_3_Local.__ENH_Person_Vehicle_3);
  EXPORT DBG_E_Professional_License_Intermediate_3 := __UNWRAP(B_Professional_License_3_Local.__ENH_Professional_License_3);
  EXPORT DBG_E_Property_Intermediate_3 := __UNWRAP(B_Property_3_Local.__ENH_Property_3);
  EXPORT DBG_E_Property_Event_Intermediate_3 := __UNWRAP(B_Property_Event_3_Local.__ENH_Property_Event_3);
  EXPORT DBG_E_Sele_Address_Intermediate_3 := __UNWRAP(B_Sele_Address_3_Local.__ENH_Sele_Address_3);
  EXPORT DBG_E_Sele_Person_Intermediate_3 := __UNWRAP(B_Sele_Person_3_Local.__ENH_Sele_Person_3);
  EXPORT DBG_E_Sele_Phone_Number_Intermediate_3 := __UNWRAP(B_Sele_Phone_Number_3_Local.__ENH_Sele_Phone_Number_3);
  EXPORT DBG_E_Sele_Property_Intermediate_3 := __UNWRAP(B_Sele_Property_3_Local.__ENH_Sele_Property_3);
  EXPORT DBG_E_Sele_T_I_N_Intermediate_3 := __UNWRAP(B_Sele_T_I_N_3_Local.__ENH_Sele_T_I_N_3);
  EXPORT DBG_E_Sele_Tradeline_Intermediate_3 := __UNWRAP(B_Sele_Tradeline_3_Local.__ENH_Sele_Tradeline_3);
  EXPORT DBG_E_Sele_U_C_C_Intermediate_3 := __UNWRAP(B_Sele_U_C_C_3_Local.__ENH_Sele_U_C_C_3);
  EXPORT DBG_E_Sele_Vehicle_Intermediate_3 := __UNWRAP(B_Sele_Vehicle_3_Local.__ENH_Sele_Vehicle_3);
  EXPORT DBG_E_Tradeline_Intermediate_3 := __UNWRAP(B_Tradeline_3_Local.__ENH_Tradeline_3);
  EXPORT DBG_E_U_C_C_Intermediate_3 := __UNWRAP(B_U_C_C_3_Local.__ENH_U_C_C_3);
  EXPORT DBG_E_Watercraft_Owner_Intermediate_3 := __UNWRAP(B_Watercraft_Owner_3_Local.__ENH_Watercraft_Owner_3);
  EXPORT DBG_E_Address_Intermediate_2 := __UNWRAP(B_Address_2_Local.__ENH_Address_2);
  EXPORT DBG_E_Aircraft_Owner_Intermediate_2 := __UNWRAP(B_Aircraft_Owner_2_Local.__ENH_Aircraft_Owner_2);
  EXPORT DBG_E_Bankruptcy_Intermediate_2 := __UNWRAP(B_Bankruptcy_2_Local.__ENH_Bankruptcy_2);
  EXPORT DBG_E_Business_Prox_Intermediate_2 := __UNWRAP(B_Business_Prox_2_Local.__ENH_Business_Prox_2);
  EXPORT DBG_E_Business_Sele_Intermediate_2 := __UNWRAP(B_Business_Sele_2_Local.__ENH_Business_Sele_2);
  EXPORT DBG_E_Business_Sele_Overflow_Intermediate_2 := __UNWRAP(B_Business_Sele_Overflow_2_Local.__ENH_Business_Sele_Overflow_2);
  EXPORT DBG_E_Criminal_Offense_Intermediate_2 := __UNWRAP(B_Criminal_Offense_2_Local.__ENH_Criminal_Offense_2);
  EXPORT DBG_E_Education_Intermediate_2 := __UNWRAP(B_Education_2_Local.__ENH_Education_2);
  EXPORT DBG_E_Email_Intermediate_2 := __UNWRAP(B_Email_2_Local.__ENH_Email_2);
  EXPORT DBG_E_First_Degree_Relative_Intermediate_2 := __UNWRAP(B_First_Degree_Relative_2_Local.__ENH_First_Degree_Relative_2);
  EXPORT DBG_E_Input_B_I_I_Intermediate_2 := __UNWRAP(B_Input_B_I_I_2_Local.__ENH_Input_B_I_I_2);
  EXPORT DBG_E_Input_P_I_I_Intermediate_2 := __UNWRAP(B_Input_P_I_I_2_Local.__ENH_Input_P_I_I_2);
  EXPORT DBG_E_Inquiry_Intermediate_2 := __UNWRAP(B_Inquiry_2_Local.__ENH_Inquiry_2);
  EXPORT DBG_E_Lien_Judgment_Intermediate_2 := __UNWRAP(B_Lien_Judgment_2_Local.__ENH_Lien_Judgment_2);
  EXPORT DBG_E_Person_Intermediate_2 := __UNWRAP(B_Person_2_Local.__ENH_Person_2);
  EXPORT DBG_E_Person_Address_Intermediate_2 := __UNWRAP(B_Person_Address_2_Local.__ENH_Person_Address_2);
  EXPORT DBG_E_Person_Property_Intermediate_2 := __UNWRAP(B_Person_Property_2_Local.__ENH_Person_Property_2);
  EXPORT DBG_E_Person_S_S_N_Intermediate_2 := __UNWRAP(B_Person_S_S_N_2_Local.__ENH_Person_S_S_N_2);
  EXPORT DBG_E_Person_Vehicle_Intermediate_2 := __UNWRAP(B_Person_Vehicle_2_Local.__ENH_Person_Vehicle_2);
  EXPORT DBG_E_Professional_License_Intermediate_2 := __UNWRAP(B_Professional_License_2_Local.__ENH_Professional_License_2);
  EXPORT DBG_E_Property_Intermediate_2 := __UNWRAP(B_Property_2_Local.__ENH_Property_2);
  EXPORT DBG_E_Property_Event_Intermediate_2 := __UNWRAP(B_Property_Event_2_Local.__ENH_Property_Event_2);
  EXPORT DBG_E_Sele_Address_Intermediate_2 := __UNWRAP(B_Sele_Address_2_Local.__ENH_Sele_Address_2);
  EXPORT DBG_E_Sele_Person_Intermediate_2 := __UNWRAP(B_Sele_Person_2_Local.__ENH_Sele_Person_2);
  EXPORT DBG_E_Sele_Property_Intermediate_2 := __UNWRAP(B_Sele_Property_2_Local.__ENH_Sele_Property_2);
  EXPORT DBG_E_Sele_Tradeline_Intermediate_2 := __UNWRAP(B_Sele_Tradeline_2_Local.__ENH_Sele_Tradeline_2);
  EXPORT DBG_E_Sele_U_C_C_Intermediate_2 := __UNWRAP(B_Sele_U_C_C_2_Local.__ENH_Sele_U_C_C_2);
  EXPORT DBG_E_Sele_Vehicle_Intermediate_2 := __UNWRAP(B_Sele_Vehicle_2_Local.__ENH_Sele_Vehicle_2);
  EXPORT DBG_E_Tradeline_Intermediate_2 := __UNWRAP(B_Tradeline_2_Local.__ENH_Tradeline_2);
  EXPORT DBG_E_U_C_C_Intermediate_2 := __UNWRAP(B_U_C_C_2_Local.__ENH_U_C_C_2);
  EXPORT DBG_E_Watercraft_Owner_Intermediate_2 := __UNWRAP(B_Watercraft_Owner_2_Local.__ENH_Watercraft_Owner_2);
  EXPORT DBG_E_Address_Intermediate_1 := __UNWRAP(B_Address_1_Local.__ENH_Address_1);
  EXPORT DBG_E_Aircraft_Owner_Intermediate_1 := __UNWRAP(B_Aircraft_Owner_1_Local.__ENH_Aircraft_Owner_1);
  EXPORT DBG_E_Bankruptcy_Intermediate_1 := __UNWRAP(B_Bankruptcy_1_Local.__ENH_Bankruptcy_1);
  EXPORT DBG_E_Business_Prox_Intermediate_1 := __UNWRAP(B_Business_Prox_1_Local.__ENH_Business_Prox_1);
  EXPORT DBG_E_Business_Sele_Intermediate_1 := __UNWRAP(B_Business_Sele_1_Local.__ENH_Business_Sele_1);
  EXPORT DBG_E_Business_Sele_Overflow_Intermediate_1 := __UNWRAP(B_Business_Sele_Overflow_1_Local.__ENH_Business_Sele_Overflow_1);
  EXPORT DBG_E_Criminal_Offense_Intermediate_1 := __UNWRAP(B_Criminal_Offense_1_Local.__ENH_Criminal_Offense_1);
  EXPORT DBG_E_Education_Intermediate_1 := __UNWRAP(B_Education_1_Local.__ENH_Education_1);
  EXPORT DBG_E_Email_Intermediate_1 := __UNWRAP(B_Email_1_Local.__ENH_Email_1);
  EXPORT DBG_E_First_Degree_Relative_Intermediate_1 := __UNWRAP(B_First_Degree_Relative_1_Local.__ENH_First_Degree_Relative_1);
  EXPORT DBG_E_Input_B_I_I_Intermediate_1 := __UNWRAP(B_Input_B_I_I_1_Local.__ENH_Input_B_I_I_1);
  EXPORT DBG_E_Input_P_I_I_Intermediate_1 := __UNWRAP(B_Input_P_I_I_1_Local.__ENH_Input_P_I_I_1);
  EXPORT DBG_E_Inquiry_Intermediate_1 := __UNWRAP(B_Inquiry_1_Local.__ENH_Inquiry_1);
  EXPORT DBG_E_Lien_Judgment_Intermediate_1 := __UNWRAP(B_Lien_Judgment_1_Local.__ENH_Lien_Judgment_1);
  EXPORT DBG_E_Person_Intermediate_1 := __UNWRAP(B_Person_1_Local.__ENH_Person_1);
  EXPORT DBG_E_Person_Property_Intermediate_1 := __UNWRAP(B_Person_Property_1_Local.__ENH_Person_Property_1);
  EXPORT DBG_E_Person_S_S_N_Intermediate_1 := __UNWRAP(B_Person_S_S_N_1_Local.__ENH_Person_S_S_N_1);
  EXPORT DBG_E_Person_Vehicle_Intermediate_1 := __UNWRAP(B_Person_Vehicle_1_Local.__ENH_Person_Vehicle_1);
  EXPORT DBG_E_Professional_License_Intermediate_1 := __UNWRAP(B_Professional_License_1_Local.__ENH_Professional_License_1);
  EXPORT DBG_E_Property_Intermediate_1 := __UNWRAP(B_Property_1_Local.__ENH_Property_1);
  EXPORT DBG_E_Property_Event_Intermediate_1 := __UNWRAP(B_Property_Event_1_Local.__ENH_Property_Event_1);
  EXPORT DBG_E_Sele_Address_Intermediate_1 := __UNWRAP(B_Sele_Address_1_Local.__ENH_Sele_Address_1);
  EXPORT DBG_E_Sele_Person_Intermediate_1 := __UNWRAP(B_Sele_Person_1_Local.__ENH_Sele_Person_1);
  EXPORT DBG_E_Sele_Property_Intermediate_1 := __UNWRAP(B_Sele_Property_1_Local.__ENH_Sele_Property_1);
  EXPORT DBG_E_Sele_Tradeline_Intermediate_1 := __UNWRAP(B_Sele_Tradeline_1_Local.__ENH_Sele_Tradeline_1);
  EXPORT DBG_E_Sele_Vehicle_Intermediate_1 := __UNWRAP(B_Sele_Vehicle_1_Local.__ENH_Sele_Vehicle_1);
  EXPORT DBG_E_Tradeline_Intermediate_1 := __UNWRAP(B_Tradeline_1_Local.__ENH_Tradeline_1);
  EXPORT DBG_E_U_C_C_Intermediate_1 := __UNWRAP(B_U_C_C_1_Local.__ENH_U_C_C_1);
  EXPORT DBG_E_Watercraft_Owner_Intermediate_1 := __UNWRAP(B_Watercraft_Owner_1_Local.__ENH_Watercraft_Owner_1);
  EXPORT DBG_E_Address_Annotated := __UNWRAP(B_Address_Local.__ENH_Address);
  EXPORT DBG_E_Bankruptcy_Annotated := __UNWRAP(B_Bankruptcy_Local.__ENH_Bankruptcy);
  EXPORT DBG_E_Business_Prox_Annotated := __UNWRAP(B_Business_Prox_Local.__ENH_Business_Prox);
  EXPORT DBG_E_Business_Sele_Annotated := __UNWRAP(B_Business_Sele_Local.__ENH_Business_Sele);
  EXPORT DBG_E_Criminal_Offense_Annotated := __UNWRAP(B_Criminal_Offense_Local.__ENH_Criminal_Offense);
  EXPORT DBG_E_Education_Annotated := __UNWRAP(B_Education_Local.__ENH_Education);
  EXPORT DBG_E_Email_Annotated := __UNWRAP(B_Email_Local.__ENH_Email);
  EXPORT DBG_E_First_Degree_Relative_Annotated := __UNWRAP(B_First_Degree_Relative_Local.__ENH_First_Degree_Relative);
  EXPORT DBG_E_Inquiry_Annotated := __UNWRAP(B_Inquiry_Local.__ENH_Inquiry);
  EXPORT DBG_E_Lien_Judgment_Annotated := __UNWRAP(B_Lien_Judgment_Local.__ENH_Lien_Judgment);
  EXPORT DBG_E_Person_Annotated := __UNWRAP(B_Person_Local.__ENH_Person);
  EXPORT DBG_E_Professional_License_Annotated := __UNWRAP(B_Professional_License_Local.__ENH_Professional_License);
  EXPORT DBG_E_Property_Annotated := __UNWRAP(B_Property_Local.__ENH_Property);
  EXPORT DBG_E_Property_Event_Annotated := __UNWRAP(B_Property_Event_Local.__ENH_Property_Event);
  EXPORT DBG_E_Second_Degree_Associations_Annotated := __UNWRAP(B_Second_Degree_Associations_Local.__ENH_Second_Degree_Associations);
  EXPORT DBG_E_Tradeline_Annotated := __UNWRAP(B_Tradeline_Local.__ENH_Tradeline);
  EXPORT DBG_E_U_C_C_Annotated := __UNWRAP(B_U_C_C_Local.__ENH_U_C_C);
  EXPORT DBG_OutputAll := PARALLEL(
    OUTPUT(DBG_E_Accident_Result,NAMED('DBG_E_Accident_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Address_Result,NAMED('DBG_E_Address_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Address_Inquiry_Result,NAMED('DBG_E_Address_Inquiry_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Address_Phone_Result,NAMED('DBG_E_Address_Phone_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Address_Property_Result,NAMED('DBG_E_Address_Property_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Address_Property_Event_Result,NAMED('DBG_E_Address_Property_Event_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Aircraft_Result,NAMED('DBG_E_Aircraft_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Aircraft_Owner_Result,NAMED('DBG_E_Aircraft_Owner_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Bankruptcy_Result,NAMED('DBG_E_Bankruptcy_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Business_Prox_Result,NAMED('DBG_E_Business_Prox_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Business_Sele_Result,NAMED('DBG_E_Business_Sele_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Business_Sele_Overflow_Result,NAMED('DBG_E_Business_Sele_Overflow_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Criminal_Details_Result,NAMED('DBG_E_Criminal_Details_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Criminal_Offender_Result,NAMED('DBG_E_Criminal_Offender_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Criminal_Offense_Result,NAMED('DBG_E_Criminal_Offense_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Criminal_Punishment_Result,NAMED('DBG_E_Criminal_Punishment_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Drivers_License_Result,NAMED('DBG_E_Drivers_License_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_E_B_R_Tradeline_Result,NAMED('DBG_E_E_B_R_Tradeline_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Education_Result,NAMED('DBG_E_Education_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Email_Result,NAMED('DBG_E_Email_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Email_Inquiry_Result,NAMED('DBG_E_Email_Inquiry_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_First_Degree_Associations_Result,NAMED('DBG_E_First_Degree_Associations_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_First_Degree_Relative_Result,NAMED('DBG_E_First_Degree_Relative_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_House_Hold_Phone_Result,NAMED('DBG_E_House_Hold_Phone_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Household_Result,NAMED('DBG_E_Household_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Household_Member_Result,NAMED('DBG_E_Household_Member_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Input_B_I_I_Result,NAMED('DBG_E_Input_B_I_I_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Input_B_I_I_Input_P_I_I_Result,NAMED('DBG_E_Input_B_I_I_Input_P_I_I_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Input_P_I_I_Result,NAMED('DBG_E_Input_P_I_I_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Inquiry_Result,NAMED('DBG_E_Inquiry_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Lien_Judgment_Result,NAMED('DBG_E_Lien_Judgment_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Result,NAMED('DBG_E_Person_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Accident_Result,NAMED('DBG_E_Person_Accident_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Address_Result,NAMED('DBG_E_Person_Address_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Bankruptcy_Result,NAMED('DBG_E_Person_Bankruptcy_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Drivers_License_Result,NAMED('DBG_E_Person_Drivers_License_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Education_Result,NAMED('DBG_E_Person_Education_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Email_Result,NAMED('DBG_E_Person_Email_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Email_Phone_Address_Result,NAMED('DBG_E_Person_Email_Phone_Address_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Inquiry_Result,NAMED('DBG_E_Person_Inquiry_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Lien_Judgment_Result,NAMED('DBG_E_Person_Lien_Judgment_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Offender_Result,NAMED('DBG_E_Person_Offender_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Offenses_Result,NAMED('DBG_E_Person_Offenses_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Phone_Result,NAMED('DBG_E_Person_Phone_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Property_Result,NAMED('DBG_E_Person_Property_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Property_Event_Result,NAMED('DBG_E_Person_Property_Event_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_S_S_N_Result,NAMED('DBG_E_Person_S_S_N_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Sex_Offender_Result,NAMED('DBG_E_Person_Sex_Offender_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Vehicle_Result,NAMED('DBG_E_Person_Vehicle_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Phone_Result,NAMED('DBG_E_Phone_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Phone_Inquiry_Result,NAMED('DBG_E_Phone_Inquiry_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Professional_License_Result,NAMED('DBG_E_Professional_License_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Professional_License_Person_Result,NAMED('DBG_E_Professional_License_Person_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Property_Result,NAMED('DBG_E_Property_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Property_Event_Result,NAMED('DBG_E_Property_Event_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Prox_Address_Result,NAMED('DBG_E_Prox_Address_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Prox_Email_Result,NAMED('DBG_E_Prox_Email_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Prox_Person_Result,NAMED('DBG_E_Prox_Person_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Prox_Phone_Number_Result,NAMED('DBG_E_Prox_Phone_Number_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Prox_T_I_N_Result,NAMED('DBG_E_Prox_T_I_N_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Prox_Utility_Result,NAMED('DBG_E_Prox_Utility_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_S_S_N_Address_Result,NAMED('DBG_E_S_S_N_Address_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_S_S_N_Inquiry_Result,NAMED('DBG_E_S_S_N_Inquiry_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Second_Degree_Associations_Result,NAMED('DBG_E_Second_Degree_Associations_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Address_Result,NAMED('DBG_E_Sele_Address_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Aircraft_Result,NAMED('DBG_E_Sele_Aircraft_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Bankruptcy_Result,NAMED('DBG_E_Sele_Bankruptcy_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_E_B_R_Tradeline_Result,NAMED('DBG_E_Sele_E_B_R_Tradeline_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Email_Result,NAMED('DBG_E_Sele_Email_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Inquiry_Result,NAMED('DBG_E_Sele_Inquiry_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Lien_Judgment_Result,NAMED('DBG_E_Sele_Lien_Judgment_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Person_Result,NAMED('DBG_E_Sele_Person_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Phone_Number_Result,NAMED('DBG_E_Sele_Phone_Number_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Property_Result,NAMED('DBG_E_Sele_Property_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Property_Event_Result,NAMED('DBG_E_Sele_Property_Event_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_T_I_N_Result,NAMED('DBG_E_Sele_T_I_N_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Tradeline_Result,NAMED('DBG_E_Sele_Tradeline_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_U_C_C_Result,NAMED('DBG_E_Sele_U_C_C_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Utility_Result,NAMED('DBG_E_Sele_Utility_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Vehicle_Result,NAMED('DBG_E_Sele_Vehicle_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Watercraft_Result,NAMED('DBG_E_Sele_Watercraft_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sex_Offender_Result,NAMED('DBG_E_Sex_Offender_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Social_Security_Number_Result,NAMED('DBG_E_Social_Security_Number_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_T_I_N_Result,NAMED('DBG_E_T_I_N_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_T_I_N_Address_Result,NAMED('DBG_E_T_I_N_Address_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_T_I_N_Inquiry_Result,NAMED('DBG_E_T_I_N_Inquiry_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_T_I_N_Phone_Number_Result,NAMED('DBG_E_T_I_N_Phone_Number_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Tradeline_Result,NAMED('DBG_E_Tradeline_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_U_C_C_Result,NAMED('DBG_E_U_C_C_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Utility_Result,NAMED('DBG_E_Utility_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Utility_Address_Result,NAMED('DBG_E_Utility_Address_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Utility_Person_Result,NAMED('DBG_E_Utility_Person_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Vehicle_Result,NAMED('DBG_E_Vehicle_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Watercraft_Result,NAMED('DBG_E_Watercraft_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Watercraft_Owner_Result,NAMED('DBG_E_Watercraft_Owner_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Zip_Code_Result,NAMED('DBG_E_Zip_Code_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Zip_Code_Person_Result,NAMED('DBG_E_Zip_Code_Person_Result_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Lien_Judgment_Intermediate_13,NAMED('DBG_E_Lien_Judgment_Intermediate_13_Q_Index_Build_Association')),
    OUTPUT(DBG_E_U_C_C_Intermediate_13,NAMED('DBG_E_U_C_C_Intermediate_13_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Lien_Judgment_Intermediate_12,NAMED('DBG_E_Lien_Judgment_Intermediate_12_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Lien_Judgment_Intermediate_12,NAMED('DBG_E_Person_Lien_Judgment_Intermediate_12_Q_Index_Build_Association')),
    OUTPUT(DBG_E_U_C_C_Intermediate_12,NAMED('DBG_E_U_C_C_Intermediate_12_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Inquiry_Intermediate_11,NAMED('DBG_E_Inquiry_Intermediate_11_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Lien_Judgment_Intermediate_11,NAMED('DBG_E_Lien_Judgment_Intermediate_11_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Intermediate_11,NAMED('DBG_E_Person_Intermediate_11_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Lien_Judgment_Intermediate_11,NAMED('DBG_E_Sele_Lien_Judgment_Intermediate_11_Q_Index_Build_Association')),
    OUTPUT(DBG_E_U_C_C_Intermediate_11,NAMED('DBG_E_U_C_C_Intermediate_11_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Business_Sele_Intermediate_10,NAMED('DBG_E_Business_Sele_Intermediate_10_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_10,NAMED('DBG_E_Input_B_I_I_Intermediate_10_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Inquiry_Intermediate_10,NAMED('DBG_E_Inquiry_Intermediate_10_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Lien_Judgment_Intermediate_10,NAMED('DBG_E_Lien_Judgment_Intermediate_10_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Intermediate_10,NAMED('DBG_E_Person_Intermediate_10_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Tradeline_Intermediate_10,NAMED('DBG_E_Tradeline_Intermediate_10_Q_Index_Build_Association')),
    OUTPUT(DBG_E_U_C_C_Intermediate_10,NAMED('DBG_E_U_C_C_Intermediate_10_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Business_Sele_Intermediate_9,NAMED('DBG_E_Business_Sele_Intermediate_9_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_9,NAMED('DBG_E_Input_B_I_I_Intermediate_9_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_9,NAMED('DBG_E_Input_P_I_I_Intermediate_9_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Inquiry_Intermediate_9,NAMED('DBG_E_Inquiry_Intermediate_9_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Lien_Judgment_Intermediate_9,NAMED('DBG_E_Lien_Judgment_Intermediate_9_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Intermediate_9,NAMED('DBG_E_Person_Intermediate_9_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_U_C_C_Intermediate_9,NAMED('DBG_E_Sele_U_C_C_Intermediate_9_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Tradeline_Intermediate_9,NAMED('DBG_E_Tradeline_Intermediate_9_Q_Index_Build_Association')),
    OUTPUT(DBG_E_U_C_C_Intermediate_9,NAMED('DBG_E_U_C_C_Intermediate_9_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_8,NAMED('DBG_E_Bankruptcy_Intermediate_8_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Business_Sele_Intermediate_8,NAMED('DBG_E_Business_Sele_Intermediate_8_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_8,NAMED('DBG_E_Input_B_I_I_Intermediate_8_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_8,NAMED('DBG_E_Input_P_I_I_Intermediate_8_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Inquiry_Intermediate_8,NAMED('DBG_E_Inquiry_Intermediate_8_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Lien_Judgment_Intermediate_8,NAMED('DBG_E_Lien_Judgment_Intermediate_8_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Intermediate_8,NAMED('DBG_E_Person_Intermediate_8_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Accident_Intermediate_8,NAMED('DBG_E_Person_Accident_Intermediate_8_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_8,NAMED('DBG_E_Person_Inquiry_Intermediate_8_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Property_Intermediate_8,NAMED('DBG_E_Person_Property_Intermediate_8_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Property_Event_Intermediate_8,NAMED('DBG_E_Property_Event_Intermediate_8_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_U_C_C_Intermediate_8,NAMED('DBG_E_Sele_U_C_C_Intermediate_8_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Tradeline_Intermediate_8,NAMED('DBG_E_Tradeline_Intermediate_8_Q_Index_Build_Association')),
    OUTPUT(DBG_E_U_C_C_Intermediate_8,NAMED('DBG_E_U_C_C_Intermediate_8_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_7,NAMED('DBG_E_Bankruptcy_Intermediate_7_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Business_Sele_Intermediate_7,NAMED('DBG_E_Business_Sele_Intermediate_7_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Education_Intermediate_7,NAMED('DBG_E_Education_Intermediate_7_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_7,NAMED('DBG_E_Input_B_I_I_Intermediate_7_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_7,NAMED('DBG_E_Input_P_I_I_Intermediate_7_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Inquiry_Intermediate_7,NAMED('DBG_E_Inquiry_Intermediate_7_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Lien_Judgment_Intermediate_7,NAMED('DBG_E_Lien_Judgment_Intermediate_7_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Intermediate_7,NAMED('DBG_E_Person_Intermediate_7_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_7,NAMED('DBG_E_Person_Inquiry_Intermediate_7_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Property_Intermediate_7,NAMED('DBG_E_Person_Property_Intermediate_7_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Property_Event_Intermediate_7,NAMED('DBG_E_Property_Event_Intermediate_7_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Person_Intermediate_7,NAMED('DBG_E_Sele_Person_Intermediate_7_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_U_C_C_Intermediate_7,NAMED('DBG_E_Sele_U_C_C_Intermediate_7_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Tradeline_Intermediate_7,NAMED('DBG_E_Tradeline_Intermediate_7_Q_Index_Build_Association')),
    OUTPUT(DBG_E_U_C_C_Intermediate_7,NAMED('DBG_E_U_C_C_Intermediate_7_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Address_Intermediate_6,NAMED('DBG_E_Address_Intermediate_6_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_6,NAMED('DBG_E_Bankruptcy_Intermediate_6_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Business_Sele_Intermediate_6,NAMED('DBG_E_Business_Sele_Intermediate_6_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Business_Sele_Overflow_Intermediate_6,NAMED('DBG_E_Business_Sele_Overflow_Intermediate_6_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Education_Intermediate_6,NAMED('DBG_E_Education_Intermediate_6_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_6,NAMED('DBG_E_Input_B_I_I_Intermediate_6_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_6,NAMED('DBG_E_Input_P_I_I_Intermediate_6_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Inquiry_Intermediate_6,NAMED('DBG_E_Inquiry_Intermediate_6_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Lien_Judgment_Intermediate_6,NAMED('DBG_E_Lien_Judgment_Intermediate_6_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Intermediate_6,NAMED('DBG_E_Person_Intermediate_6_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_6,NAMED('DBG_E_Person_Inquiry_Intermediate_6_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Property_Intermediate_6,NAMED('DBG_E_Person_Property_Intermediate_6_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_S_S_N_Intermediate_6,NAMED('DBG_E_Person_S_S_N_Intermediate_6_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Property_Event_Intermediate_6,NAMED('DBG_E_Property_Event_Intermediate_6_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Address_Intermediate_6,NAMED('DBG_E_Sele_Address_Intermediate_6_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Person_Intermediate_6,NAMED('DBG_E_Sele_Person_Intermediate_6_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Phone_Number_Intermediate_6,NAMED('DBG_E_Sele_Phone_Number_Intermediate_6_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_T_I_N_Intermediate_6,NAMED('DBG_E_Sele_T_I_N_Intermediate_6_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_U_C_C_Intermediate_6,NAMED('DBG_E_Sele_U_C_C_Intermediate_6_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Tradeline_Intermediate_6,NAMED('DBG_E_Tradeline_Intermediate_6_Q_Index_Build_Association')),
    OUTPUT(DBG_E_U_C_C_Intermediate_6,NAMED('DBG_E_U_C_C_Intermediate_6_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Address_Intermediate_5,NAMED('DBG_E_Address_Intermediate_5_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_5,NAMED('DBG_E_Bankruptcy_Intermediate_5_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Business_Sele_Intermediate_5,NAMED('DBG_E_Business_Sele_Intermediate_5_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Business_Sele_Overflow_Intermediate_5,NAMED('DBG_E_Business_Sele_Overflow_Intermediate_5_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Criminal_Offense_Intermediate_5,NAMED('DBG_E_Criminal_Offense_Intermediate_5_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Education_Intermediate_5,NAMED('DBG_E_Education_Intermediate_5_Q_Index_Build_Association')),
    OUTPUT(DBG_E_First_Degree_Relative_Intermediate_5,NAMED('DBG_E_First_Degree_Relative_Intermediate_5_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_5,NAMED('DBG_E_Input_B_I_I_Intermediate_5_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_5,NAMED('DBG_E_Input_P_I_I_Intermediate_5_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Inquiry_Intermediate_5,NAMED('DBG_E_Inquiry_Intermediate_5_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Lien_Judgment_Intermediate_5,NAMED('DBG_E_Lien_Judgment_Intermediate_5_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Intermediate_5,NAMED('DBG_E_Person_Intermediate_5_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_5,NAMED('DBG_E_Person_Inquiry_Intermediate_5_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Property_Intermediate_5,NAMED('DBG_E_Person_Property_Intermediate_5_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_S_S_N_Intermediate_5,NAMED('DBG_E_Person_S_S_N_Intermediate_5_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Professional_License_Intermediate_5,NAMED('DBG_E_Professional_License_Intermediate_5_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Property_Intermediate_5,NAMED('DBG_E_Property_Intermediate_5_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Property_Event_Intermediate_5,NAMED('DBG_E_Property_Event_Intermediate_5_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Address_Intermediate_5,NAMED('DBG_E_Sele_Address_Intermediate_5_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Person_Intermediate_5,NAMED('DBG_E_Sele_Person_Intermediate_5_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Phone_Number_Intermediate_5,NAMED('DBG_E_Sele_Phone_Number_Intermediate_5_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_T_I_N_Intermediate_5,NAMED('DBG_E_Sele_T_I_N_Intermediate_5_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_U_C_C_Intermediate_5,NAMED('DBG_E_Sele_U_C_C_Intermediate_5_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Tradeline_Intermediate_5,NAMED('DBG_E_Tradeline_Intermediate_5_Q_Index_Build_Association')),
    OUTPUT(DBG_E_U_C_C_Intermediate_5,NAMED('DBG_E_U_C_C_Intermediate_5_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Address_Intermediate_4,NAMED('DBG_E_Address_Intermediate_4_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_4,NAMED('DBG_E_Bankruptcy_Intermediate_4_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Business_Sele_Intermediate_4,NAMED('DBG_E_Business_Sele_Intermediate_4_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Business_Sele_Overflow_Intermediate_4,NAMED('DBG_E_Business_Sele_Overflow_Intermediate_4_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Criminal_Offense_Intermediate_4,NAMED('DBG_E_Criminal_Offense_Intermediate_4_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Education_Intermediate_4,NAMED('DBG_E_Education_Intermediate_4_Q_Index_Build_Association')),
    OUTPUT(DBG_E_First_Degree_Relative_Intermediate_4,NAMED('DBG_E_First_Degree_Relative_Intermediate_4_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_4,NAMED('DBG_E_Input_B_I_I_Intermediate_4_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_4,NAMED('DBG_E_Input_P_I_I_Intermediate_4_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Inquiry_Intermediate_4,NAMED('DBG_E_Inquiry_Intermediate_4_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Lien_Judgment_Intermediate_4,NAMED('DBG_E_Lien_Judgment_Intermediate_4_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Intermediate_4,NAMED('DBG_E_Person_Intermediate_4_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_4,NAMED('DBG_E_Person_Inquiry_Intermediate_4_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Property_Intermediate_4,NAMED('DBG_E_Person_Property_Intermediate_4_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_S_S_N_Intermediate_4,NAMED('DBG_E_Person_S_S_N_Intermediate_4_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Professional_License_Intermediate_4,NAMED('DBG_E_Professional_License_Intermediate_4_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Property_Intermediate_4,NAMED('DBG_E_Property_Intermediate_4_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Property_Event_Intermediate_4,NAMED('DBG_E_Property_Event_Intermediate_4_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Address_Intermediate_4,NAMED('DBG_E_Sele_Address_Intermediate_4_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Person_Intermediate_4,NAMED('DBG_E_Sele_Person_Intermediate_4_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Phone_Number_Intermediate_4,NAMED('DBG_E_Sele_Phone_Number_Intermediate_4_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Property_Intermediate_4,NAMED('DBG_E_Sele_Property_Intermediate_4_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_T_I_N_Intermediate_4,NAMED('DBG_E_Sele_T_I_N_Intermediate_4_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_U_C_C_Intermediate_4,NAMED('DBG_E_Sele_U_C_C_Intermediate_4_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Tradeline_Intermediate_4,NAMED('DBG_E_Tradeline_Intermediate_4_Q_Index_Build_Association')),
    OUTPUT(DBG_E_U_C_C_Intermediate_4,NAMED('DBG_E_U_C_C_Intermediate_4_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Address_Intermediate_3,NAMED('DBG_E_Address_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Aircraft_Owner_Intermediate_3,NAMED('DBG_E_Aircraft_Owner_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_3,NAMED('DBG_E_Bankruptcy_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Business_Prox_Intermediate_3,NAMED('DBG_E_Business_Prox_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Business_Sele_Intermediate_3,NAMED('DBG_E_Business_Sele_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Business_Sele_Overflow_Intermediate_3,NAMED('DBG_E_Business_Sele_Overflow_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Criminal_Offense_Intermediate_3,NAMED('DBG_E_Criminal_Offense_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Education_Intermediate_3,NAMED('DBG_E_Education_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_First_Degree_Relative_Intermediate_3,NAMED('DBG_E_First_Degree_Relative_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_3,NAMED('DBG_E_Input_B_I_I_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_3,NAMED('DBG_E_Input_P_I_I_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Inquiry_Intermediate_3,NAMED('DBG_E_Inquiry_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Lien_Judgment_Intermediate_3,NAMED('DBG_E_Lien_Judgment_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Intermediate_3,NAMED('DBG_E_Person_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Address_Intermediate_3,NAMED('DBG_E_Person_Address_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_3,NAMED('DBG_E_Person_Inquiry_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Property_Intermediate_3,NAMED('DBG_E_Person_Property_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_S_S_N_Intermediate_3,NAMED('DBG_E_Person_S_S_N_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Vehicle_Intermediate_3,NAMED('DBG_E_Person_Vehicle_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Professional_License_Intermediate_3,NAMED('DBG_E_Professional_License_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Property_Intermediate_3,NAMED('DBG_E_Property_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Property_Event_Intermediate_3,NAMED('DBG_E_Property_Event_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Address_Intermediate_3,NAMED('DBG_E_Sele_Address_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Person_Intermediate_3,NAMED('DBG_E_Sele_Person_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Phone_Number_Intermediate_3,NAMED('DBG_E_Sele_Phone_Number_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Property_Intermediate_3,NAMED('DBG_E_Sele_Property_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_T_I_N_Intermediate_3,NAMED('DBG_E_Sele_T_I_N_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Tradeline_Intermediate_3,NAMED('DBG_E_Sele_Tradeline_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_U_C_C_Intermediate_3,NAMED('DBG_E_Sele_U_C_C_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Vehicle_Intermediate_3,NAMED('DBG_E_Sele_Vehicle_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Tradeline_Intermediate_3,NAMED('DBG_E_Tradeline_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_U_C_C_Intermediate_3,NAMED('DBG_E_U_C_C_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Watercraft_Owner_Intermediate_3,NAMED('DBG_E_Watercraft_Owner_Intermediate_3_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Address_Intermediate_2,NAMED('DBG_E_Address_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Aircraft_Owner_Intermediate_2,NAMED('DBG_E_Aircraft_Owner_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_2,NAMED('DBG_E_Bankruptcy_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Business_Prox_Intermediate_2,NAMED('DBG_E_Business_Prox_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Business_Sele_Intermediate_2,NAMED('DBG_E_Business_Sele_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Business_Sele_Overflow_Intermediate_2,NAMED('DBG_E_Business_Sele_Overflow_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Criminal_Offense_Intermediate_2,NAMED('DBG_E_Criminal_Offense_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Education_Intermediate_2,NAMED('DBG_E_Education_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Email_Intermediate_2,NAMED('DBG_E_Email_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_First_Degree_Relative_Intermediate_2,NAMED('DBG_E_First_Degree_Relative_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_2,NAMED('DBG_E_Input_B_I_I_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_2,NAMED('DBG_E_Input_P_I_I_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Inquiry_Intermediate_2,NAMED('DBG_E_Inquiry_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Lien_Judgment_Intermediate_2,NAMED('DBG_E_Lien_Judgment_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Intermediate_2,NAMED('DBG_E_Person_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Address_Intermediate_2,NAMED('DBG_E_Person_Address_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Property_Intermediate_2,NAMED('DBG_E_Person_Property_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_S_S_N_Intermediate_2,NAMED('DBG_E_Person_S_S_N_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Vehicle_Intermediate_2,NAMED('DBG_E_Person_Vehicle_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Professional_License_Intermediate_2,NAMED('DBG_E_Professional_License_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Property_Intermediate_2,NAMED('DBG_E_Property_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Property_Event_Intermediate_2,NAMED('DBG_E_Property_Event_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Address_Intermediate_2,NAMED('DBG_E_Sele_Address_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Person_Intermediate_2,NAMED('DBG_E_Sele_Person_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Property_Intermediate_2,NAMED('DBG_E_Sele_Property_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Tradeline_Intermediate_2,NAMED('DBG_E_Sele_Tradeline_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_U_C_C_Intermediate_2,NAMED('DBG_E_Sele_U_C_C_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Vehicle_Intermediate_2,NAMED('DBG_E_Sele_Vehicle_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Tradeline_Intermediate_2,NAMED('DBG_E_Tradeline_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_U_C_C_Intermediate_2,NAMED('DBG_E_U_C_C_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Watercraft_Owner_Intermediate_2,NAMED('DBG_E_Watercraft_Owner_Intermediate_2_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Address_Intermediate_1,NAMED('DBG_E_Address_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Aircraft_Owner_Intermediate_1,NAMED('DBG_E_Aircraft_Owner_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_1,NAMED('DBG_E_Bankruptcy_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Business_Prox_Intermediate_1,NAMED('DBG_E_Business_Prox_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Business_Sele_Intermediate_1,NAMED('DBG_E_Business_Sele_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Business_Sele_Overflow_Intermediate_1,NAMED('DBG_E_Business_Sele_Overflow_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Criminal_Offense_Intermediate_1,NAMED('DBG_E_Criminal_Offense_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Education_Intermediate_1,NAMED('DBG_E_Education_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Email_Intermediate_1,NAMED('DBG_E_Email_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_First_Degree_Relative_Intermediate_1,NAMED('DBG_E_First_Degree_Relative_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_1,NAMED('DBG_E_Input_B_I_I_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_1,NAMED('DBG_E_Input_P_I_I_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Inquiry_Intermediate_1,NAMED('DBG_E_Inquiry_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Lien_Judgment_Intermediate_1,NAMED('DBG_E_Lien_Judgment_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Intermediate_1,NAMED('DBG_E_Person_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Property_Intermediate_1,NAMED('DBG_E_Person_Property_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_S_S_N_Intermediate_1,NAMED('DBG_E_Person_S_S_N_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Vehicle_Intermediate_1,NAMED('DBG_E_Person_Vehicle_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Professional_License_Intermediate_1,NAMED('DBG_E_Professional_License_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Property_Intermediate_1,NAMED('DBG_E_Property_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Property_Event_Intermediate_1,NAMED('DBG_E_Property_Event_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Address_Intermediate_1,NAMED('DBG_E_Sele_Address_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Person_Intermediate_1,NAMED('DBG_E_Sele_Person_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Property_Intermediate_1,NAMED('DBG_E_Sele_Property_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Tradeline_Intermediate_1,NAMED('DBG_E_Sele_Tradeline_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Sele_Vehicle_Intermediate_1,NAMED('DBG_E_Sele_Vehicle_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Tradeline_Intermediate_1,NAMED('DBG_E_Tradeline_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_U_C_C_Intermediate_1,NAMED('DBG_E_U_C_C_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Watercraft_Owner_Intermediate_1,NAMED('DBG_E_Watercraft_Owner_Intermediate_1_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Address_Annotated,NAMED('DBG_E_Address_Annotated_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Bankruptcy_Annotated,NAMED('DBG_E_Bankruptcy_Annotated_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Business_Prox_Annotated,NAMED('DBG_E_Business_Prox_Annotated_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Business_Sele_Annotated,NAMED('DBG_E_Business_Sele_Annotated_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Criminal_Offense_Annotated,NAMED('DBG_E_Criminal_Offense_Annotated_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Education_Annotated,NAMED('DBG_E_Education_Annotated_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Email_Annotated,NAMED('DBG_E_Email_Annotated_Q_Index_Build_Association')),
    OUTPUT(DBG_E_First_Degree_Relative_Annotated,NAMED('DBG_E_First_Degree_Relative_Annotated_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Inquiry_Annotated,NAMED('DBG_E_Inquiry_Annotated_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Lien_Judgment_Annotated,NAMED('DBG_E_Lien_Judgment_Annotated_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Person_Annotated,NAMED('DBG_E_Person_Annotated_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Professional_License_Annotated,NAMED('DBG_E_Professional_License_Annotated_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Property_Annotated,NAMED('DBG_E_Property_Annotated_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Property_Event_Annotated,NAMED('DBG_E_Property_Event_Annotated_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Second_Degree_Associations_Annotated,NAMED('DBG_E_Second_Degree_Associations_Annotated_Q_Index_Build_Association')),
    OUTPUT(DBG_E_Tradeline_Annotated,NAMED('DBG_E_Tradeline_Annotated_Q_Index_Build_Association')),
    OUTPUT(DBG_E_U_C_C_Annotated,NAMED('DBG_E_U_C_C_Annotated_Q_Index_Build_Association'))
  );
  EXPORT DBG_Res0 := WHEN(Res0,DBG_OutputAll);
END;
