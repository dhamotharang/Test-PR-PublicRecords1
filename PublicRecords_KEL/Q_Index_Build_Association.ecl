//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT B_Address,B_Address_1,B_Address_2,B_Address_Property_Event_3,B_Address_Property_Event_4,B_Address_Property_Event_5,B_Aircraft_Owner_1,B_Aircraft_Owner_2,B_Aircraft_Owner_3,B_Bankruptcy,B_Bankruptcy_1,B_Bankruptcy_2,B_Bankruptcy_3,B_Bankruptcy_4,B_Bankruptcy_5,B_Bankruptcy_6,B_Bankruptcy_7,B_Bankruptcy_8,B_Business_Prox,B_Business_Prox_1,B_Business_Prox_2,B_Business_Prox_3,B_Business_Sele,B_Business_Sele_1,B_Business_Sele_10,B_Business_Sele_2,B_Business_Sele_3,B_Business_Sele_4,B_Business_Sele_5,B_Business_Sele_6,B_Business_Sele_7,B_Business_Sele_8,B_Business_Sele_9,B_Criminal_Offense,B_Criminal_Offense_1,B_Criminal_Offense_2,B_Criminal_Offense_3,B_Criminal_Offense_4,B_Criminal_Offense_5,B_Education,B_Education_1,B_Education_2,B_Education_3,B_Education_4,B_Education_5,B_Education_6,B_Education_7,B_First_Degree_Relative,B_First_Degree_Relative_5,B_Input_B_I_I_1,B_Input_B_I_I_10,B_Input_B_I_I_2,B_Input_B_I_I_3,B_Input_B_I_I_4,B_Input_B_I_I_5,B_Input_B_I_I_6,B_Input_B_I_I_7,B_Input_B_I_I_8,B_Input_B_I_I_9,B_Input_P_I_I_2,B_Input_P_I_I_3,B_Input_P_I_I_4,B_Input_P_I_I_5,B_Input_P_I_I_6,B_Input_P_I_I_7,B_Lien_Judgment,B_Lien_Judgment_1,B_Lien_Judgment_10,B_Lien_Judgment_11,B_Lien_Judgment_12,B_Lien_Judgment_2,B_Lien_Judgment_3,B_Lien_Judgment_4,B_Lien_Judgment_5,B_Lien_Judgment_6,B_Lien_Judgment_7,B_Lien_Judgment_8,B_Lien_Judgment_9,B_Person,B_Person_1,B_Person_2,B_Person_3,B_Person_4,B_Person_5,B_Person_6,B_Person_7,B_Person_Lien_Judgment_8,B_Person_Vehicle_1,B_Person_Vehicle_2,B_Person_Vehicle_3,B_Professional_License,B_Professional_License_1,B_Professional_License_2,B_Professional_License_3,B_Professional_License_4,B_Professional_License_5,B_Property_Event,B_Property_Event_1,B_Property_Event_2,B_Property_Event_3,B_Property_Event_4,B_Property_Event_5,B_Second_Degree_Associations,B_Sele_Address_1,B_Sele_Address_2,B_Sele_Address_3,B_Sele_Address_4,B_Sele_Address_5,B_Sele_Address_6,B_Sele_Address_7,B_Sele_Lien_Judgment_11,B_Sele_Person_1,B_Sele_Person_2,B_Sele_Person_3,B_Sele_Person_4,B_Sele_Person_5,B_Sele_Person_6,B_Sele_Person_7,B_Sele_Phone_Number_3,B_Sele_Phone_Number_4,B_Sele_Phone_Number_5,B_Sele_Phone_Number_6,B_Sele_Property_1,B_Sele_Property_2,B_Sele_Property_3,B_Sele_Property_4,B_Sele_Property_Event_2,B_Sele_Property_Event_3,B_Sele_T_I_N_3,B_Sele_T_I_N_4,B_Sele_T_I_N_5,B_Sele_T_I_N_6,B_Sele_Tradeline_1,B_Sele_Tradeline_2,B_Sele_Tradeline_3,B_Sele_U_C_C_2,B_Sele_U_C_C_3,B_Sele_U_C_C_4,B_Sele_U_C_C_5,B_Sele_U_C_C_6,B_Sele_U_C_C_7,B_Sele_U_C_C_8,B_Sele_U_C_C_9,B_Sele_Vehicle_1,B_Sele_Vehicle_2,B_Sele_Vehicle_3,B_Tradeline,B_Tradeline_1,B_Tradeline_10,B_Tradeline_2,B_Tradeline_3,B_Tradeline_4,B_Tradeline_5,B_Tradeline_6,B_Tradeline_7,B_Tradeline_8,B_Tradeline_9,B_U_C_C,B_U_C_C_1,B_U_C_C_10,B_U_C_C_11,B_U_C_C_12,B_U_C_C_13,B_U_C_C_2,B_U_C_C_3,B_U_C_C_4,B_U_C_C_5,B_U_C_C_6,B_U_C_C_7,B_U_C_C_8,B_U_C_C_9,B_Watercraft_Owner_1,B_Watercraft_Owner_2,B_Watercraft_Owner_3,CFG_Compile,E_Accident,E_Address,E_Address_Inquiry,E_Address_Phone,E_Address_Property,E_Address_Property_Event,E_Aircraft,E_Aircraft_Owner,E_Bankruptcy,E_Business_Org,E_Business_Prox,E_Business_Sele,E_Business_Ult,E_Criminal_Details,E_Criminal_Offender,E_Criminal_Offense,E_Criminal_Punishment,E_Drivers_License,E_Education,E_Email,E_Employment,E_Employment_Person,E_First_Degree_Associations,E_First_Degree_Relative,E_Geo_Link,E_House_Hold_Phone,E_Household,E_Household_Member,E_Input_B_I_I,E_Input_B_I_I_Input_P_I_I,E_Input_P_I_I,E_Inquiry,E_Lien_Judgment,E_Person,E_Person_Accident,E_Person_Address,E_Person_Bankruptcy,E_Person_Drivers_License,E_Person_Education,E_Person_Email,E_Person_Email_Phone_Address,E_Person_Inquiry,E_Person_Lien_Judgment,E_Person_Offender,E_Person_Offenses,E_Person_Phone,E_Person_Property,E_Person_Property_Event,E_Person_S_S_N,E_Person_U_C_C,E_Person_Vehicle,E_Phone,E_Phone_Inquiry,E_Professional_License,E_Professional_License_Person,E_Property,E_Property_Event,E_Prox_Address,E_Prox_Email,E_Prox_Person,E_Prox_Phone_Number,E_Prox_T_I_N,E_Prox_Utility,E_S_S_N_Address,E_S_S_N_Inquiry,E_Second_Degree_Associations,E_Sele_Address,E_Sele_Aircraft,E_Sele_Bankruptcy,E_Sele_Email,E_Sele_Lien_Judgment,E_Sele_Person,E_Sele_Phone_Number,E_Sele_Property,E_Sele_Property_Event,E_Sele_T_I_N,E_Sele_Tradeline,E_Sele_U_C_C,E_Sele_Utility,E_Sele_Vehicle,E_Sele_Watercraft,E_Social_Security_Number,E_Surname,E_T_I_N,E_T_I_N_Address,E_T_I_N_Phone_Number,E_Tradeline,E_U_C_C,E_Utility,E_Utility_Address,E_Utility_Person,E_Vehicle,E_Watercraft,E_Watercraft_Owner,E_Zip_Code,E_Zip_Code_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT Q_Index_Build_Association(KEL.typ.uid __PAddressUID, KEL.typ.uid __PBusinessProxUID, KEL.typ.uid __PBusinessSeleUID, KEL.typ.uid __PCriminalOffenderUID, KEL.typ.uid __PPersonUID, KEL.typ.uid __PHouseholdUID, KEL.typ.uid __PPhoneUID, KEL.typ.uid __PPropertyUID, KEL.typ.uid __PSocialSecurityNumberUID, KEL.typ.uid __PTINUID, KEL.typ.uid __PZipCodeUID, KEL.typ.kdate __PP_InpClnArchDt, UNSIGNED8 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PP_InpClnArchDt;
  END;
  SHARED E_Property_Filtered_10 := MODULE(E_Property(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PPropertyUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Address_Filtered_9 := MODULE(E_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PAddressUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Person_Filtered_9 := MODULE(E_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PPersonUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Property_Event_Filtered_9 := MODULE(E_Property_Event(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,JOIN(__ds,E_Property_Filtered_10.__PostFilter,__EEQP(LEFT.Prop_,RIGHT.UID),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Business_Prox_Filtered_8 := MODULE(E_Business_Prox(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PBusinessProxUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Business_Sele_Filtered_8 := MODULE(E_Business_Sele(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PBusinessSeleUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Sele_Address_Filtered_8 := MODULE(E_Sele_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_9.__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Person_Filtered_8 := MODULE(E_Sele_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_9.__PostFilter,__EEQP(LEFT.Contact_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Property_Event_Filtered_8 := MODULE(E_Sele_Property_Event(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Property_Event_Filtered_9.__PostFilter,__EEQP(LEFT.Event_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Address_Filtered_7 := MODULE(E_Sele_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Address_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Address_Property_Event_Filtered_6 := MODULE(E_Address_Property_Event(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_7.__PostFilter,__EEQP(LEFT.Location_,RIGHT.Location_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Address_Property_Event_Filtered_5 := MODULE(E_Address_Property_Event(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Property_Event_Filtered_6.__PostFilter,__EEQP(LEFT.Event_,RIGHT.Event_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Event_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Address_Property_Event_Filtered_6.__PostFilter,__EEQP(LEFT.Event_,RIGHT.Event_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.L_N_Fares_I_D_,RIGHT.L_N_Fares_I_D_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Event_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Address_Filtered_4 := MODULE(E_Sele_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Property_Event_Filtered_5.__PostFilter,__EEQP(LEFT.Location_,RIGHT.Location_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Address_Filtered_7.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Household_Filtered_3 := MODULE(E_Household(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PHouseholdUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Phone_Filtered_3 := MODULE(E_Phone(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PPhoneUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Sele_Address_Filtered_3 := MODULE(E_Sele_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_4.__PostFilter,__EEQP(LEFT.Location_,RIGHT.Location_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Address_Filtered_4.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Address_Filtered_4.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Social_Security_Number_Filtered_3 := MODULE(E_Social_Security_Number(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PSocialSecurityNumberUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_T_I_N_Filtered_3 := MODULE(E_T_I_N(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SimpleFilter(DATASET(InLayout) __ds) := __ds(__T(__OP2(__ds.UID,=,__CN(__PTINUID))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __SimpleFilter(__UsingFitler(__AsofFitler(__ds)));
  END;
  SHARED E_Zip_Code_Filtered_3 := MODULE(E_Zip_Code(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PZipCodeUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Address_Phone_Filtered_2 := MODULE(E_Address_Phone(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Phone_Filtered_3.__PostFilter,__EEQP(LEFT.Phone_Number_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Criminal_Offender_Filtered_2 := MODULE(E_Criminal_Offender(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PCriminalOffenderUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Household_Member_Filtered_2 := MODULE(E_Household_Member(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Household_Filtered_3.__PostFilter,__EEQP(LEFT.Household_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Input_B_I_I_Filtered_2 := MODULE(E_Input_B_I_I(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,JOIN(__ds,E_Sele_Address_Filtered_3.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,JOIN(__ds,E_Business_Prox_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,JOIN(__ds,E_Business_Sele_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,JOIN(__ds,E_Sele_Person_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,JOIN(__ds,E_Sele_Property_Event_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Address_Filtered_2 := MODULE(E_Person_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_9.__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Filtered_9.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Phone_Filtered_2 := MODULE(E_Person_Phone(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Phone_Filtered_3.__PostFilter,__EEQP(LEFT.Phone_Number_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Property_Event_Filtered_2 := MODULE(E_Person_Property_Event(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Property_Event_Filtered_9.__PostFilter,__EEQP(LEFT.Event_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_S_S_N_Filtered_2 := MODULE(E_Person_S_S_N(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Social_Security_Number_Filtered_3.__PostFilter,__EEQP(LEFT.Social_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Prox_Address_Filtered_2 := MODULE(E_Prox_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Prox_Filtered_8.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Prox_Person_Filtered_2 := MODULE(E_Prox_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Prox_Filtered_8.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_S_S_N_Address_Filtered_2 := MODULE(E_S_S_N_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Social_Security_Number_Filtered_3.__PostFilter,__EEQP(LEFT.Social_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Address_Filtered_2 := MODULE(E_Sele_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_3.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Address_Filtered_3.__PostFilter,__EEQP(LEFT.Location_,RIGHT.Location_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Address_Filtered_3.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Person_Filtered_2 := MODULE(E_Sele_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
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
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Contact_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Property_Filtered_2 := MODULE(E_Sele_Property(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_3.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_T_I_N_Address_Filtered_2 := MODULE(E_T_I_N_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_T_I_N_Filtered_3.InData,__EEQP(LEFT.Tax_I_D_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Zip_Code_Person_Filtered_2 := MODULE(E_Zip_Code_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Zip_Code_Filtered_3.__PostFilter,__EEQP(LEFT.Zip_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Address_Filtered_1 := MODULE(E_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
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
  SHARED E_Address_Inquiry_Filtered_1 := MODULE(E_Address_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_9.__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Address_Phone_Filtered_1 := MODULE(E_Address_Phone(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_9.__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Address_Phone_Filtered_2.__PostFilter,__EEQP(LEFT.Phone_Number_,RIGHT.Phone_Number_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Phone_Number_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Address_Property_Filtered_1 := MODULE(E_Address_Property(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_9.__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Address_Property_Event_Filtered_1 := MODULE(E_Address_Property_Event(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_9.__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Address_Property_Event_Filtered_5.__PostFilter,__EEQP(LEFT.Event_,RIGHT.Event_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.L_N_Fares_I_D_,RIGHT.L_N_Fares_I_D_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Event_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Aircraft_Owner_Filtered_1 := MODULE(E_Aircraft_Owner(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_9.__PostFilter,__EEQP(LEFT.Owner_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Business_Prox_Filtered_1 := MODULE(E_Business_Prox(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Prox_Sele_,RIGHT.Legal_),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,JOIN(__ds,E_Business_Prox_Filtered_8.__PostFilter,__EEQP(LEFT.Prox_Sele_,RIGHT.Prox_Sele_),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,JOIN(__ds,E_Business_Sele_Filtered_8.__PostFilter,__EEQP(LEFT.Prox_Sele_,RIGHT.UID),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Prox_Sele_,RIGHT.Legal_),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,JOIN(__ds,E_Sele_Property_Event_Filtered_8.__PostFilter,__EEQP(LEFT.Prox_Sele_,RIGHT.Legal_),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PBusinessProxUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Criminal_Details_Filtered_1 := MODULE(E_Criminal_Details(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Criminal_Offender_Filtered_2.__PostFilter,__EEQP(LEFT.Offender_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Employment_Person_Filtered_1 := MODULE(E_Employment_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_9.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_First_Degree_Associations_Filtered_1 := MODULE(E_First_Degree_Associations(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := JOIN(__UsingFitler(__AsofFitler(__ds)),E_Person_Filtered_9.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,KEEP(1));
  END;
  SHARED E_House_Hold_Phone_Filtered_1 := MODULE(E_House_Hold_Phone(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Household_Filtered_3.__PostFilter,__EEQP(LEFT.Household_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Household_Member_Filtered_1 := MODULE(E_Household_Member(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_9.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Household_,RIGHT.Household_) AND __EEQP(LEFT.Version_,RIGHT.Version_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Input_B_I_I_Input_P_I_I_Filtered_1 := MODULE(E_Input_B_I_I_Input_P_I_I(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := JOIN(__UsingFitler(__AsofFitler(__ds)),E_Input_B_I_I_Filtered_2.__PostFilter,__EEQP(LEFT.B_I_I_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,KEEP(1));
  END;
  SHARED E_Person_Accident_Filtered_1 := MODULE(E_Person_Accident(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_9.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Bankruptcy_Filtered_1 := MODULE(E_Person_Bankruptcy(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
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
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Filtered_9.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Drivers_License_Filtered_1 := MODULE(E_Person_Drivers_License(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_9.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Education_Filtered_1 := MODULE(E_Person_Education(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
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
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Filtered_9.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Email_Filtered_1 := MODULE(E_Person_Email(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_9.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Inquiry_Filtered_1 := MODULE(E_Person_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_9.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Lien_Judgment_Filtered_1 := MODULE(E_Person_Lien_Judgment(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
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
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Filtered_9.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Offender_Filtered_1 := MODULE(E_Person_Offender(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_9.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Offenses_Filtered_1 := MODULE(E_Person_Offenses(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
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
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Filtered_9.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Phone_Filtered_1 := MODULE(E_Person_Phone(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_9.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Phone_Number_,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Property_Filtered_1 := MODULE(E_Person_Property(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_9.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Property_Event_Filtered_1 := MODULE(E_Person_Property_Event(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_9.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Event_,RIGHT.Event_) AND __EEQP(LEFT.L_N_Fares_I_D_,RIGHT.L_N_Fares_I_D_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_S_S_N_Filtered_1 := MODULE(E_Person_S_S_N(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_9.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Social_,RIGHT.Social_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_U_C_C_Filtered_1 := MODULE(E_Person_U_C_C(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_9.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Vehicle_Filtered_1 := MODULE(E_Person_Vehicle(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_9.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Phone_Inquiry_Filtered_1 := MODULE(E_Phone_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Phone_Filtered_3.__PostFilter,__EEQP(LEFT.Phone_Number_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Professional_License_Person_Filtered_1 := MODULE(E_Professional_License_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
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
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Filtered_9.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Property_Event_Filtered_1 := MODULE(E_Property_Event(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,JOIN(__ds,E_Sele_Property_Filtered_2.__PostFilter,__EEQP(LEFT.Prop_,RIGHT.Prop_),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Property_Event_Filtered_9.__PostFilter,__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Prox_Address_Filtered_1 := MODULE(E_Prox_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_9.__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Prox_Email_Filtered_1 := MODULE(E_Prox_Email(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Prox_Filtered_8.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Prox_Person_Filtered_1 := MODULE(E_Prox_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_9.__PostFilter,__EEQP(LEFT.Contact_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_) AND __EEQP(LEFT.Contact_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Prox_Phone_Number_Filtered_1 := MODULE(E_Prox_Phone_Number(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Prox_Filtered_8.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Prox_Utility_Filtered_1 := MODULE(E_Prox_Utility(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Prox_Filtered_8.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_S_S_N_Inquiry_Filtered_1 := MODULE(E_S_S_N_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Social_Security_Number_Filtered_3.__PostFilter,__EEQP(LEFT.S_S_N_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Aircraft_Filtered_1 := MODULE(E_Sele_Aircraft(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Bankruptcy_Filtered_1 := MODULE(E_Sele_Bankruptcy(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Email_Filtered_1 := MODULE(E_Sele_Email(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Lien_Judgment_Filtered_1 := MODULE(E_Sele_Lien_Judgment(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Sele_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_8.__PostFilter,__EEQP(LEFT.Sele_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_8.__PostFilter,__EEQP(LEFT.Sele_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Sele_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_8.__PostFilter,__EEQP(LEFT.Sele_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Person_Filtered_1 := MODULE(E_Sele_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Contact_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Phone_Number_Filtered_1 := MODULE(E_Sele_Phone_Number(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Property_Filtered_1 := MODULE(E_Sele_Property(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Prop_,RIGHT.Prop_) AND __EEQP(LEFT.Ult_I_D_,RIGHT.Ult_I_D_) AND __EEQP(LEFT.Org_I_D_,RIGHT.Org_I_D_) AND __EEQP(LEFT.Sele_I_D_,RIGHT.Sele_I_D_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Property_Event_Filtered_1 := MODULE(E_Sele_Property_Event(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
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
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Event_,RIGHT.Event_) AND __EEQP(LEFT.Ult_I_D_,RIGHT.Ult_I_D_) AND __EEQP(LEFT.Org_I_D_,RIGHT.Org_I_D_) AND __EEQP(LEFT.Sele_I_D_,RIGHT.Sele_I_D_) AND __EEQP(LEFT.L_N_Fares_I_D_,RIGHT.L_N_Fares_I_D_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Tradeline_Filtered_1 := MODULE(E_Sele_Tradeline(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_U_C_C_Filtered_1 := MODULE(E_Sele_U_C_C(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Utility_Filtered_1 := MODULE(E_Sele_Utility(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Vehicle_Filtered_1 := MODULE(E_Sele_Vehicle(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Watercraft_Filtered_1 := MODULE(E_Sele_Watercraft(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_T_I_N_Phone_Number_Filtered_1 := MODULE(E_T_I_N_Phone_Number(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_T_I_N_Filtered_3.InData,__EEQP(LEFT.Tax_I_D_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Utility_Address_Filtered_1 := MODULE(E_Utility_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_9.__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Utility_Person_Filtered_1 := MODULE(E_Utility_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_9.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Watercraft_Owner_Filtered_1 := MODULE(E_Watercraft_Owner(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_9.__PostFilter,__EEQP(LEFT.Owner_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Zip_Code_Person_Filtered_1 := MODULE(E_Zip_Code_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_9.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_2.__PostFilter,__EEQP(LEFT.Zip_,RIGHT.Zip_) AND __EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Zip_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Accident_Filtered := MODULE(E_Accident(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Accident_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Acc_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Address_Filtered := MODULE(E_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Location_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Address_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Address_Property_Event_Filtered := MODULE(E_Address_Property_Event(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.Location_,RIGHT.Location_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Location_,RIGHT.Location_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Address_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.Event_,RIGHT.Event_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.L_N_Fares_I_D_,RIGHT.L_N_Fares_I_D_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Event_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Aircraft_Filtered := MODULE(E_Aircraft(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
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
  SHARED E_Aircraft_Owner_Filtered := MODULE(E_Aircraft_Owner(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
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
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
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
  SHARED E_Bankruptcy_Filtered := MODULE(E_Bankruptcy(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
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
  SHARED E_Business_Prox_Filtered := MODULE(E_Business_Prox(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Prox_Address_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Business_Location_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Business_Location_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Business_Sele_Filtered := MODULE(E_Business_Sele(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.UID,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PBusinessSeleUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Criminal_Offender_Filtered := MODULE(E_Criminal_Offender(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Offender_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Offender_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Offender_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PCriminalOffenderUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart0(__ds),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Criminal_Offense_Filtered := MODULE(E_Criminal_Offense(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
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
  SHARED E_Criminal_Punishment_Filtered := MODULE(E_Criminal_Punishment(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Criminal_Details_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Punishment_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Drivers_License_Filtered := MODULE(E_Drivers_License(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Drivers_License_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.License_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Education_Filtered := MODULE(E_Education(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Education_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Edu_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Email_Filtered := MODULE(E_Email(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Prox_Email_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Email_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Email_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Email_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Email_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Email_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Email_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Email_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Email_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Employment_Filtered := MODULE(E_Employment(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Employment_Person_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Emp_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_First_Degree_Associations_Filtered := MODULE(E_First_Degree_Associations(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_First_Degree_Associations_Filtered_1.InData,__EEQP(LEFT.Subject_,RIGHT.First_Degree_Association_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.First_Degree_Association_),SELF:=LEFT),HASH,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_First_Degree_Associations_Filtered_1.InData,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.First_Degree_Association_,RIGHT.First_Degree_Association_) AND __EEQP(LEFT.Title_,RIGHT.Title_) AND __EEQP(LEFT.Relationship_Type_,RIGHT.Relationship_Type_) AND __EEQP(LEFT.Relationship_Confidence_,RIGHT.Relationship_Confidence_) AND __EEQP(LEFT.Relationship_Score_,RIGHT.Relationship_Score_) AND __EEQP(LEFT.Generation_,RIGHT.Generation_) AND __EEQP(LEFT.Relationship_Date_First_Seen_,RIGHT.Relationship_Date_First_Seen_) AND __EEQP(LEFT.Relationship_Date_Last_Seen_,RIGHT.Relationship_Date_Last_Seen_) AND __EEQP(LEFT.Source_,RIGHT.Source_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,KEEP(1),LEFT OUTER);
    SHARED __SimpleFilter(DATASET(__InLayoutExtended) __ds) := __ds(__T(__OP2(__ds.Title_,>=,__CN(1))) AND __T(__OP2(__ds.Title_,<=,__CN(45))) AND __ds.__Link0 OR __ds.__Link1 OR __ds.__Link2);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := PROJECT(__SimpleFilter(__FilterPart2(__FilterPart1(__FilterPart0(__UsingFitler(__AsofFitler(__ds)))))),InLayout);
  END;
  SHARED E_First_Degree_Relative_Filtered := MODULE(E_First_Degree_Relative(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := JOIN(__UsingFitler(__AsofFitler(__ds)),E_Person_Filtered_9.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,KEEP(1));
  END;
  SHARED E_Household_Filtered := MODULE(E_Household(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Household_Member_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Household_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Household_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PHouseholdUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart0(__ds),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Input_B_I_I_Filtered := MODULE(E_Input_B_I_I(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Input_B_I_I_Filtered_2.__PostFilter,__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Input_P_I_I_Filtered := MODULE(E_Input_P_I_I(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Input_B_I_I_Input_P_I_I_Filtered_1.InData,__EEQP(LEFT.UID,RIGHT.P_I_I_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Inquiry_Filtered := MODULE(E_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Inquiry_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Inquiry_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Inquiry_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Inquiry_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Inquiry_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Inquiry_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Phone_Inquiry_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Inquiry_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Inquiry_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_S_S_N_Inquiry_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Inquiry_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Inquiry_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Lien_Judgment_Filtered := MODULE(E_Lien_Judgment(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
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
  SHARED E_Person_Filtered := MODULE(E_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
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
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
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
  SHARED E_Person_Address_Filtered := MODULE(E_Person_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
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
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Email_Filtered := MODULE(E_Person_Email(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Email_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Email_,RIGHT.Email_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Email_Phone_Address_Filtered := MODULE(E_Person_Email_Phone_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_9.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Vehicle_Filtered := MODULE(E_Person_Vehicle(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
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
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
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
  SHARED E_Phone_Filtered := MODULE(E_Phone(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
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
  SHARED E_Professional_License_Filtered := MODULE(E_Professional_License(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Professional_License_Person_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Prof_Lic_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Property_Filtered := MODULE(E_Property(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Property_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Prop_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Prop_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Prop_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prop_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Prop_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Prop_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PPropertyUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Property_Event_Filtered := MODULE(E_Property_Event(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Event_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Event_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Event_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Event_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,JOIN(__ds,E_Sele_Property_Filtered_1.__PostFilter,__EEQP(LEFT.Prop_,RIGHT.Prop_),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Event_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Event_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Prox_Address_Filtered := MODULE(E_Prox_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
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
  SHARED E_Prox_Phone_Number_Filtered := MODULE(E_Prox_Phone_Number(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
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
  SHARED E_Prox_T_I_N_Filtered := MODULE(E_Prox_T_I_N(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Prox_Address_Filtered_1.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_1.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Address_Filtered := MODULE(E_Sele_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Aircraft_Filtered := MODULE(E_Sele_Aircraft(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
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
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Aircraft_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Plane_,RIGHT.Plane_) AND __EEQP(LEFT.Ult_I_D_,RIGHT.Ult_I_D_) AND __EEQP(LEFT.Org_I_D_,RIGHT.Org_I_D_) AND __EEQP(LEFT.Sele_I_D_,RIGHT.Sele_I_D_) AND __EEQP(LEFT.N_Number_,RIGHT.N_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Person_Filtered := MODULE(E_Sele_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Contact_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Phone_Number_Filtered := MODULE(E_Sele_Phone_Number(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
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
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Phone_Number_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Phone_Number_,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Property_Filtered := MODULE(E_Sele_Property(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Prop_,RIGHT.Prop_) AND __EEQP(LEFT.Ult_I_D_,RIGHT.Ult_I_D_) AND __EEQP(LEFT.Org_I_D_,RIGHT.Org_I_D_) AND __EEQP(LEFT.Sele_I_D_,RIGHT.Sele_I_D_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Property_Event_Filtered := MODULE(E_Sele_Property_Event(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.Event_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Address_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.Event_,RIGHT.Event_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Event_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Event_,RIGHT.Event_) AND __EEQP(LEFT.Ult_I_D_,RIGHT.Ult_I_D_) AND __EEQP(LEFT.Org_I_D_,RIGHT.Org_I_D_) AND __EEQP(LEFT.Sele_I_D_,RIGHT.Sele_I_D_) AND __EEQP(LEFT.L_N_Fares_I_D_,RIGHT.L_N_Fares_I_D_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_T_I_N_Filtered := MODULE(E_Sele_T_I_N(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
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
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_8.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Vehicle_Filtered := MODULE(E_Sele_Vehicle(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Vehicle_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Automobile_,RIGHT.Automobile_) AND __EEQP(LEFT.Ult_I_D_,RIGHT.Ult_I_D_) AND __EEQP(LEFT.Org_I_D_,RIGHT.Org_I_D_) AND __EEQP(LEFT.Sele_I_D_,RIGHT.Sele_I_D_) AND __EEQP(LEFT.Vehicle_Key_,RIGHT.Vehicle_Key_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Watercraft_Filtered := MODULE(E_Sele_Watercraft(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
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
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Watercraft_Filtered_1.__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.W_Craft_,RIGHT.W_Craft_) AND __EEQP(LEFT.Ult_I_D_,RIGHT.Ult_I_D_) AND __EEQP(LEFT.Org_I_D_,RIGHT.Org_I_D_) AND __EEQP(LEFT.Sele_I_D_,RIGHT.Sele_I_D_) AND __EEQP(LEFT.Watercraft_Key_,RIGHT.Watercraft_Key_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Social_Security_Number_Filtered := MODULE(E_Social_Security_Number(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Social_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Social_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PSocialSecurityNumberUID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart0(__ds),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_T_I_N_Address_Filtered := MODULE(E_T_I_N_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_1.__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_T_I_N_Address_Filtered_2.__PostFilter,__EEQP(LEFT.Tax_I_D_,RIGHT.Tax_I_D_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Tax_I_D_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_T_I_N_Phone_Number_Filtered := MODULE(E_T_I_N_Phone_Number(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Phone_Filtered_3.__PostFilter,__EEQP(LEFT.Phone_Number_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_T_I_N_Phone_Number_Filtered_1.__PostFilter,__EEQP(LEFT.Phone_Number_,RIGHT.Phone_Number_) AND __EEQP(LEFT.Tax_I_D_,RIGHT.Tax_I_D_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Phone_Number_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Tradeline_Filtered := MODULE(E_Tradeline(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Tradeline_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Account_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_U_C_C_Filtered := MODULE(E_U_C_C(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_U_C_C_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Filing_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Ult_I_D_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_U_C_C_Filtered_1.__PostFilter,__EEQP(LEFT.UID,RIGHT.Filing_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Filing_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Utility_Filtered := MODULE(E_Utility(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
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
  SHARED E_Vehicle_Filtered := MODULE(E_Vehicle(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
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
  SHARED E_Watercraft_Filtered := MODULE(E_Watercraft(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
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
  SHARED E_Watercraft_Owner_Filtered := MODULE(E_Watercraft_Owner(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
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
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1.__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
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
  SHARED E_Zip_Code_Filtered := MODULE(E_Zip_Code(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
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
  SHARED E_Criminal_Details_Filtered := E_Criminal_Details_Filtered_1;
  SHARED E_Employment_Person_Filtered := E_Employment_Person_Filtered_1;
  SHARED E_House_Hold_Phone_Filtered := E_House_Hold_Phone_Filtered_1;
  SHARED E_Household_Member_Filtered := E_Household_Member_Filtered_1;
  SHARED E_Input_B_I_I_Input_P_I_I_Filtered := E_Input_B_I_I_Input_P_I_I_Filtered_1;
  SHARED E_Person_Accident_Filtered := E_Person_Accident_Filtered_1;
  SHARED E_Person_Bankruptcy_Filtered := E_Person_Bankruptcy_Filtered_1;
  SHARED E_Person_Drivers_License_Filtered := E_Person_Drivers_License_Filtered_1;
  SHARED E_Person_Education_Filtered := E_Person_Education_Filtered_1;
  SHARED E_Person_Inquiry_Filtered := E_Person_Inquiry_Filtered_1;
  SHARED E_Person_Lien_Judgment_Filtered := E_Person_Lien_Judgment_Filtered_1;
  SHARED E_Person_Offender_Filtered := E_Person_Offender_Filtered_1;
  SHARED E_Person_Offenses_Filtered := E_Person_Offenses_Filtered_1;
  SHARED E_Person_Phone_Filtered := E_Person_Phone_Filtered_1;
  SHARED E_Person_Property_Filtered := E_Person_Property_Filtered_1;
  SHARED E_Person_Property_Event_Filtered := E_Person_Property_Event_Filtered_1;
  SHARED E_Person_S_S_N_Filtered := E_Person_S_S_N_Filtered_1;
  SHARED E_Person_U_C_C_Filtered := E_Person_U_C_C_Filtered_1;
  SHARED E_Phone_Inquiry_Filtered := E_Phone_Inquiry_Filtered_1;
  SHARED E_Professional_License_Person_Filtered := E_Professional_License_Person_Filtered_1;
  SHARED E_Prox_Email_Filtered := E_Prox_Email_Filtered_1;
  SHARED E_Prox_Person_Filtered := E_Prox_Person_Filtered_1;
  SHARED E_Prox_Utility_Filtered := E_Prox_Utility_Filtered_1;
  SHARED E_S_S_N_Address_Filtered := E_S_S_N_Address_Filtered_2;
  SHARED E_S_S_N_Inquiry_Filtered := E_S_S_N_Inquiry_Filtered_1;
  SHARED E_Second_Degree_Associations_Filtered := MODULE(E_Second_Degree_Associations(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Bankruptcy_Filtered := E_Sele_Bankruptcy_Filtered_1;
  SHARED E_Sele_Email_Filtered := E_Sele_Email_Filtered_1;
  SHARED E_Sele_Lien_Judgment_Filtered := E_Sele_Lien_Judgment_Filtered_1;
  SHARED E_Sele_Tradeline_Filtered := E_Sele_Tradeline_Filtered_1;
  SHARED E_Sele_U_C_C_Filtered := E_Sele_U_C_C_Filtered_1;
  SHARED E_Sele_Utility_Filtered := E_Sele_Utility_Filtered_1;
  SHARED E_T_I_N_Filtered := E_T_I_N_Filtered_3;
  SHARED E_Utility_Address_Filtered := E_Utility_Address_Filtered_1;
  SHARED E_Utility_Person_Filtered := E_Utility_Person_Filtered_1;
  SHARED E_Zip_Code_Person_Filtered := E_Zip_Code_Person_Filtered_1;
  SHARED B_U_C_C_13_Local := MODULE(B_U_C_C_13(__in,__cfg_Local))
    SHARED TYPEOF(E_U_C_C().__Result) __E_U_C_C := E_U_C_C_Filtered.__Result;
  END;
  SHARED B_Lien_Judgment_12_Local := MODULE(B_Lien_Judgment_12(__in,__cfg_Local))
    SHARED TYPEOF(E_Lien_Judgment().__Result) __E_Lien_Judgment := E_Lien_Judgment_Filtered.__Result;
  END;
  SHARED B_U_C_C_12_Local := MODULE(B_U_C_C_12(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_13().__ENH_U_C_C_13) __ENH_U_C_C_13 := B_U_C_C_13_Local.__ENH_U_C_C_13;
  END;
  SHARED B_Lien_Judgment_11_Local := MODULE(B_Lien_Judgment_11(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_12().__ENH_Lien_Judgment_12) __ENH_Lien_Judgment_12 := B_Lien_Judgment_12_Local.__ENH_Lien_Judgment_12;
  END;
  SHARED B_Sele_Lien_Judgment_11_Local := MODULE(B_Sele_Lien_Judgment_11(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_12().__ENH_Lien_Judgment_12) __ENH_Lien_Judgment_12 := B_Lien_Judgment_12_Local.__ENH_Lien_Judgment_12;
    SHARED TYPEOF(E_Sele_Lien_Judgment().__Result) __E_Sele_Lien_Judgment := E_Sele_Lien_Judgment_Filtered.__Result;
  END;
  SHARED B_U_C_C_11_Local := MODULE(B_U_C_C_11(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_12().__ENH_U_C_C_12) __ENH_U_C_C_12 := B_U_C_C_12_Local.__ENH_U_C_C_12;
  END;
  SHARED B_Business_Sele_10_Local := MODULE(B_Business_Sele_10(__in,__cfg_Local))
    SHARED TYPEOF(E_Business_Sele().__Result) __E_Business_Sele := E_Business_Sele_Filtered.__Result;
    SHARED TYPEOF(E_Input_B_I_I().__Result) __E_Input_B_I_I := E_Input_B_I_I_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Lien_Judgment_11().__ENH_Sele_Lien_Judgment_11) __ENH_Sele_Lien_Judgment_11 := B_Sele_Lien_Judgment_11_Local.__ENH_Sele_Lien_Judgment_11;
  END;
  SHARED B_Input_B_I_I_10_Local := MODULE(B_Input_B_I_I_10(__in,__cfg_Local))
    SHARED TYPEOF(E_Input_B_I_I().__Result) __E_Input_B_I_I := E_Input_B_I_I_Filtered.__Result;
  END;
  SHARED B_Lien_Judgment_10_Local := MODULE(B_Lien_Judgment_10(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_11().__ENH_Lien_Judgment_11) __ENH_Lien_Judgment_11 := B_Lien_Judgment_11_Local.__ENH_Lien_Judgment_11;
  END;
  SHARED B_Tradeline_10_Local := MODULE(B_Tradeline_10(__in,__cfg_Local))
    SHARED TYPEOF(E_Tradeline().__Result) __E_Tradeline := E_Tradeline_Filtered.__Result;
  END;
  SHARED B_U_C_C_10_Local := MODULE(B_U_C_C_10(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_11().__ENH_U_C_C_11) __ENH_U_C_C_11 := B_U_C_C_11_Local.__ENH_U_C_C_11;
  END;
  SHARED B_Business_Sele_9_Local := MODULE(B_Business_Sele_9(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_10().__ENH_Business_Sele_10) __ENH_Business_Sele_10 := B_Business_Sele_10_Local.__ENH_Business_Sele_10;
    SHARED TYPEOF(B_Input_B_I_I_10().__ENH_Input_B_I_I_10) __ENH_Input_B_I_I_10 := B_Input_B_I_I_10_Local.__ENH_Input_B_I_I_10;
    SHARED TYPEOF(E_Sele_Address().__Result) __E_Sele_Address := E_Sele_Address_Filtered.__Result;
  END;
  SHARED B_Input_B_I_I_9_Local := MODULE(B_Input_B_I_I_9(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_10().__ENH_Input_B_I_I_10) __ENH_Input_B_I_I_10 := B_Input_B_I_I_10_Local.__ENH_Input_B_I_I_10;
  END;
  SHARED B_Lien_Judgment_9_Local := MODULE(B_Lien_Judgment_9(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_10().__ENH_Lien_Judgment_10) __ENH_Lien_Judgment_10 := B_Lien_Judgment_10_Local.__ENH_Lien_Judgment_10;
  END;
  SHARED B_Sele_U_C_C_9_Local := MODULE(B_Sele_U_C_C_9(__in,__cfg_Local))
    SHARED TYPEOF(E_Sele_U_C_C().__Result) __E_Sele_U_C_C := E_Sele_U_C_C_Filtered.__Result;
  END;
  SHARED B_Tradeline_9_Local := MODULE(B_Tradeline_9(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_10().__ENH_Tradeline_10) __ENH_Tradeline_10 := B_Tradeline_10_Local.__ENH_Tradeline_10;
  END;
  SHARED B_U_C_C_9_Local := MODULE(B_U_C_C_9(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_10().__ENH_U_C_C_10) __ENH_U_C_C_10 := B_U_C_C_10_Local.__ENH_U_C_C_10;
  END;
  SHARED B_Bankruptcy_8_Local := MODULE(B_Bankruptcy_8(__in,__cfg_Local))
    SHARED TYPEOF(E_Bankruptcy().__Result) __E_Bankruptcy := E_Bankruptcy_Filtered.__Result;
  END;
  SHARED B_Business_Sele_8_Local := MODULE(B_Business_Sele_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_9().__ENH_Business_Sele_9) __ENH_Business_Sele_9 := B_Business_Sele_9_Local.__ENH_Business_Sele_9;
  END;
  SHARED B_Input_B_I_I_8_Local := MODULE(B_Input_B_I_I_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_9().__ENH_Input_B_I_I_9) __ENH_Input_B_I_I_9 := B_Input_B_I_I_9_Local.__ENH_Input_B_I_I_9;
  END;
  SHARED B_Lien_Judgment_8_Local := MODULE(B_Lien_Judgment_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_9().__ENH_Lien_Judgment_9) __ENH_Lien_Judgment_9 := B_Lien_Judgment_9_Local.__ENH_Lien_Judgment_9;
  END;
  SHARED B_Person_Lien_Judgment_8_Local := MODULE(B_Person_Lien_Judgment_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_9().__ENH_Lien_Judgment_9) __ENH_Lien_Judgment_9 := B_Lien_Judgment_9_Local.__ENH_Lien_Judgment_9;
    SHARED TYPEOF(E_Person_Lien_Judgment().__Result) __E_Person_Lien_Judgment := E_Person_Lien_Judgment_Filtered.__Result;
  END;
  SHARED B_Sele_U_C_C_8_Local := MODULE(B_Sele_U_C_C_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_U_C_C_9().__ENH_Sele_U_C_C_9) __ENH_Sele_U_C_C_9 := B_Sele_U_C_C_9_Local.__ENH_Sele_U_C_C_9;
    SHARED TYPEOF(B_U_C_C_9().__ENH_U_C_C_9) __ENH_U_C_C_9 := B_U_C_C_9_Local.__ENH_U_C_C_9;
  END;
  SHARED B_Tradeline_8_Local := MODULE(B_Tradeline_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_9().__ENH_Tradeline_9) __ENH_Tradeline_9 := B_Tradeline_9_Local.__ENH_Tradeline_9;
  END;
  SHARED B_U_C_C_8_Local := MODULE(B_U_C_C_8(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_9().__ENH_U_C_C_9) __ENH_U_C_C_9 := B_U_C_C_9_Local.__ENH_U_C_C_9;
  END;
  SHARED B_Bankruptcy_7_Local := MODULE(B_Bankruptcy_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_8().__ENH_Bankruptcy_8) __ENH_Bankruptcy_8 := B_Bankruptcy_8_Local.__ENH_Bankruptcy_8;
  END;
  SHARED B_Business_Sele_7_Local := MODULE(B_Business_Sele_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_8().__ENH_Business_Sele_8) __ENH_Business_Sele_8 := B_Business_Sele_8_Local.__ENH_Business_Sele_8;
    SHARED TYPEOF(B_Input_B_I_I_8().__ENH_Input_B_I_I_8) __ENH_Input_B_I_I_8 := B_Input_B_I_I_8_Local.__ENH_Input_B_I_I_8;
  END;
  SHARED B_Education_7_Local := MODULE(B_Education_7(__in,__cfg_Local))
    SHARED TYPEOF(E_Education().__Result) __E_Education := E_Education_Filtered.__Result;
  END;
  SHARED B_Input_B_I_I_7_Local := MODULE(B_Input_B_I_I_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_8().__ENH_Input_B_I_I_8) __ENH_Input_B_I_I_8 := B_Input_B_I_I_8_Local.__ENH_Input_B_I_I_8;
  END;
  SHARED B_Input_P_I_I_7_Local := MODULE(B_Input_P_I_I_7(__in,__cfg_Local))
    SHARED TYPEOF(E_Input_P_I_I().__Result) __E_Input_P_I_I := E_Input_P_I_I_Filtered.__Result;
  END;
  SHARED B_Lien_Judgment_7_Local := MODULE(B_Lien_Judgment_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_8().__ENH_Lien_Judgment_8) __ENH_Lien_Judgment_8 := B_Lien_Judgment_8_Local.__ENH_Lien_Judgment_8;
  END;
  SHARED B_Person_7_Local := MODULE(B_Person_7(__in,__cfg_Local))
    SHARED TYPEOF(E_Person().__Result) __E_Person := E_Person_Filtered.__Result;
    SHARED TYPEOF(E_Person_Address().__Result) __E_Person_Address := E_Person_Address_Filtered.__Result;
    SHARED TYPEOF(B_Person_Lien_Judgment_8().__ENH_Person_Lien_Judgment_8) __ENH_Person_Lien_Judgment_8 := B_Person_Lien_Judgment_8_Local.__ENH_Person_Lien_Judgment_8;
  END;
  SHARED B_Sele_Address_7_Local := MODULE(B_Sele_Address_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_8().__ENH_Business_Sele_8) __ENH_Business_Sele_8 := B_Business_Sele_8_Local.__ENH_Business_Sele_8;
    SHARED TYPEOF(E_Sele_Address().__Result) __E_Sele_Address := E_Sele_Address_Filtered.__Result;
  END;
  SHARED B_Sele_Person_7_Local := MODULE(B_Sele_Person_7(__in,__cfg_Local))
    SHARED TYPEOF(E_Sele_Person().__Result) __E_Sele_Person := E_Sele_Person_Filtered.__Result;
  END;
  SHARED B_Sele_U_C_C_7_Local := MODULE(B_Sele_U_C_C_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_U_C_C_8().__ENH_Sele_U_C_C_8) __ENH_Sele_U_C_C_8 := B_Sele_U_C_C_8_Local.__ENH_Sele_U_C_C_8;
  END;
  SHARED B_Tradeline_7_Local := MODULE(B_Tradeline_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_8().__ENH_Tradeline_8) __ENH_Tradeline_8 := B_Tradeline_8_Local.__ENH_Tradeline_8;
  END;
  SHARED B_U_C_C_7_Local := MODULE(B_U_C_C_7(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_8().__ENH_U_C_C_8) __ENH_U_C_C_8 := B_U_C_C_8_Local.__ENH_U_C_C_8;
  END;
  SHARED B_Bankruptcy_6_Local := MODULE(B_Bankruptcy_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_7().__ENH_Bankruptcy_7) __ENH_Bankruptcy_7 := B_Bankruptcy_7_Local.__ENH_Bankruptcy_7;
  END;
  SHARED B_Business_Sele_6_Local := MODULE(B_Business_Sele_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_7().__ENH_Business_Sele_7) __ENH_Business_Sele_7 := B_Business_Sele_7_Local.__ENH_Business_Sele_7;
    SHARED TYPEOF(B_Sele_Address_7().__ENH_Sele_Address_7) __ENH_Sele_Address_7 := B_Sele_Address_7_Local.__ENH_Sele_Address_7;
    SHARED TYPEOF(E_Sele_Tradeline().__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered.__Result;
    SHARED TYPEOF(B_Tradeline_7().__ENH_Tradeline_7) __ENH_Tradeline_7 := B_Tradeline_7_Local.__ENH_Tradeline_7;
  END;
  SHARED B_Education_6_Local := MODULE(B_Education_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_7().__ENH_Education_7) __ENH_Education_7 := B_Education_7_Local.__ENH_Education_7;
  END;
  SHARED B_Input_B_I_I_6_Local := MODULE(B_Input_B_I_I_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_7().__ENH_Input_B_I_I_7) __ENH_Input_B_I_I_7 := B_Input_B_I_I_7_Local.__ENH_Input_B_I_I_7;
  END;
  SHARED B_Input_P_I_I_6_Local := MODULE(B_Input_P_I_I_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_7().__ENH_Input_P_I_I_7) __ENH_Input_P_I_I_7 := B_Input_P_I_I_7_Local.__ENH_Input_P_I_I_7;
  END;
  SHARED B_Lien_Judgment_6_Local := MODULE(B_Lien_Judgment_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_7().__ENH_Lien_Judgment_7) __ENH_Lien_Judgment_7 := B_Lien_Judgment_7_Local.__ENH_Lien_Judgment_7;
  END;
  SHARED B_Person_6_Local := MODULE(B_Person_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_7().__ENH_Education_7) __ENH_Education_7 := B_Education_7_Local.__ENH_Education_7;
    SHARED TYPEOF(B_Person_7().__ENH_Person_7) __ENH_Person_7 := B_Person_7_Local.__ENH_Person_7;
    SHARED TYPEOF(E_Person_Education().__Result) __E_Person_Education := E_Person_Education_Filtered.__Result;
  END;
  SHARED B_Sele_Address_6_Local := MODULE(B_Sele_Address_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_7().__ENH_Business_Sele_7) __ENH_Business_Sele_7 := B_Business_Sele_7_Local.__ENH_Business_Sele_7;
    SHARED TYPEOF(B_Sele_Address_7().__ENH_Sele_Address_7) __ENH_Sele_Address_7 := B_Sele_Address_7_Local.__ENH_Sele_Address_7;
  END;
  SHARED B_Sele_Person_6_Local := MODULE(B_Sele_Person_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Person_7().__ENH_Sele_Person_7) __ENH_Sele_Person_7 := B_Sele_Person_7_Local.__ENH_Sele_Person_7;
  END;
  SHARED B_Sele_Phone_Number_6_Local := MODULE(B_Sele_Phone_Number_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_7().__ENH_Business_Sele_7) __ENH_Business_Sele_7 := B_Business_Sele_7_Local.__ENH_Business_Sele_7;
    SHARED TYPEOF(E_Sele_Phone_Number().__Result) __E_Sele_Phone_Number := E_Sele_Phone_Number_Filtered.__Result;
  END;
  SHARED B_Sele_T_I_N_6_Local := MODULE(B_Sele_T_I_N_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_7().__ENH_Business_Sele_7) __ENH_Business_Sele_7 := B_Business_Sele_7_Local.__ENH_Business_Sele_7;
    SHARED TYPEOF(E_Sele_T_I_N().__Result) __E_Sele_T_I_N := E_Sele_T_I_N_Filtered.__Result;
  END;
  SHARED B_Sele_U_C_C_6_Local := MODULE(B_Sele_U_C_C_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_U_C_C_7().__ENH_Sele_U_C_C_7) __ENH_Sele_U_C_C_7 := B_Sele_U_C_C_7_Local.__ENH_Sele_U_C_C_7;
  END;
  SHARED B_Tradeline_6_Local := MODULE(B_Tradeline_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_7().__ENH_Tradeline_7) __ENH_Tradeline_7 := B_Tradeline_7_Local.__ENH_Tradeline_7;
  END;
  SHARED B_U_C_C_6_Local := MODULE(B_U_C_C_6(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_7().__ENH_U_C_C_7) __ENH_U_C_C_7 := B_U_C_C_7_Local.__ENH_U_C_C_7;
  END;
  SHARED B_Address_Property_Event_5_Local := MODULE(B_Address_Property_Event_5(__in,__cfg_Local))
    SHARED TYPEOF(E_Address_Property_Event().__Result) __E_Address_Property_Event := E_Address_Property_Event_Filtered.__Result;
  END;
  SHARED B_Bankruptcy_5_Local := MODULE(B_Bankruptcy_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_6().__ENH_Bankruptcy_6) __ENH_Bankruptcy_6 := B_Bankruptcy_6_Local.__ENH_Bankruptcy_6;
  END;
  SHARED B_Business_Sele_5_Local := MODULE(B_Business_Sele_5(__in,__cfg_Local))
    SHARED TYPEOF(E_Address().__Result) __E_Address := E_Address_Filtered.__Result;
    SHARED TYPEOF(B_Business_Sele_6().__ENH_Business_Sele_6) __ENH_Business_Sele_6 := B_Business_Sele_6_Local.__ENH_Business_Sele_6;
    SHARED TYPEOF(B_Sele_Address_6().__ENH_Sele_Address_6) __ENH_Sele_Address_6 := B_Sele_Address_6_Local.__ENH_Sele_Address_6;
    SHARED TYPEOF(B_Sele_Phone_Number_6().__ENH_Sele_Phone_Number_6) __ENH_Sele_Phone_Number_6 := B_Sele_Phone_Number_6_Local.__ENH_Sele_Phone_Number_6;
    SHARED TYPEOF(B_Sele_T_I_N_6().__ENH_Sele_T_I_N_6) __ENH_Sele_T_I_N_6 := B_Sele_T_I_N_6_Local.__ENH_Sele_T_I_N_6;
    SHARED TYPEOF(B_Sele_U_C_C_6().__ENH_Sele_U_C_C_6) __ENH_Sele_U_C_C_6 := B_Sele_U_C_C_6_Local.__ENH_Sele_U_C_C_6;
    SHARED TYPEOF(B_U_C_C_6().__ENH_U_C_C_6) __ENH_U_C_C_6 := B_U_C_C_6_Local.__ENH_U_C_C_6;
  END;
  SHARED B_Criminal_Offense_5_Local := MODULE(B_Criminal_Offense_5(__in,__cfg_Local))
    SHARED TYPEOF(E_Criminal_Offense().__Result) __E_Criminal_Offense := E_Criminal_Offense_Filtered.__Result;
  END;
  SHARED B_Education_5_Local := MODULE(B_Education_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_6().__ENH_Education_6) __ENH_Education_6 := B_Education_6_Local.__ENH_Education_6;
  END;
  SHARED B_First_Degree_Relative_5_Local := MODULE(B_First_Degree_Relative_5(__in,__cfg_Local))
    SHARED TYPEOF(E_First_Degree_Associations().__Result) __E_First_Degree_Associations := E_First_Degree_Associations_Filtered.__Result;
  END;
  SHARED B_Input_B_I_I_5_Local := MODULE(B_Input_B_I_I_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_6().__ENH_Input_B_I_I_6) __ENH_Input_B_I_I_6 := B_Input_B_I_I_6_Local.__ENH_Input_B_I_I_6;
  END;
  SHARED B_Input_P_I_I_5_Local := MODULE(B_Input_P_I_I_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_6().__ENH_Input_P_I_I_6) __ENH_Input_P_I_I_6 := B_Input_P_I_I_6_Local.__ENH_Input_P_I_I_6;
  END;
  SHARED B_Lien_Judgment_5_Local := MODULE(B_Lien_Judgment_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_6().__ENH_Lien_Judgment_6) __ENH_Lien_Judgment_6 := B_Lien_Judgment_6_Local.__ENH_Lien_Judgment_6;
  END;
  SHARED B_Person_5_Local := MODULE(B_Person_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_6().__ENH_Person_6) __ENH_Person_6 := B_Person_6_Local.__ENH_Person_6;
  END;
  SHARED B_Professional_License_5_Local := MODULE(B_Professional_License_5(__in,__cfg_Local))
    SHARED TYPEOF(E_Professional_License().__Result) __E_Professional_License := E_Professional_License_Filtered.__Result;
  END;
  SHARED B_Property_Event_5_Local := MODULE(B_Property_Event_5(__in,__cfg_Local))
    SHARED TYPEOF(E_Property_Event().__Result) __E_Property_Event := E_Property_Event_Filtered.__Result;
  END;
  SHARED B_Sele_Address_5_Local := MODULE(B_Sele_Address_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Address_6().__ENH_Sele_Address_6) __ENH_Sele_Address_6 := B_Sele_Address_6_Local.__ENH_Sele_Address_6;
  END;
  SHARED B_Sele_Person_5_Local := MODULE(B_Sele_Person_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Person_6().__ENH_Sele_Person_6) __ENH_Sele_Person_6 := B_Sele_Person_6_Local.__ENH_Sele_Person_6;
  END;
  SHARED B_Sele_Phone_Number_5_Local := MODULE(B_Sele_Phone_Number_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Phone_Number_6().__ENH_Sele_Phone_Number_6) __ENH_Sele_Phone_Number_6 := B_Sele_Phone_Number_6_Local.__ENH_Sele_Phone_Number_6;
  END;
  SHARED B_Sele_T_I_N_5_Local := MODULE(B_Sele_T_I_N_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_T_I_N_6().__ENH_Sele_T_I_N_6) __ENH_Sele_T_I_N_6 := B_Sele_T_I_N_6_Local.__ENH_Sele_T_I_N_6;
  END;
  SHARED B_Sele_U_C_C_5_Local := MODULE(B_Sele_U_C_C_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_U_C_C_6().__ENH_Sele_U_C_C_6) __ENH_Sele_U_C_C_6 := B_Sele_U_C_C_6_Local.__ENH_Sele_U_C_C_6;
  END;
  SHARED B_Tradeline_5_Local := MODULE(B_Tradeline_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_6().__ENH_Tradeline_6) __ENH_Tradeline_6 := B_Tradeline_6_Local.__ENH_Tradeline_6;
  END;
  SHARED B_U_C_C_5_Local := MODULE(B_U_C_C_5(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_6().__ENH_U_C_C_6) __ENH_U_C_C_6 := B_U_C_C_6_Local.__ENH_U_C_C_6;
  END;
  SHARED B_Address_Property_Event_4_Local := MODULE(B_Address_Property_Event_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_Property_Event_5().__ENH_Address_Property_Event_5) __ENH_Address_Property_Event_5 := B_Address_Property_Event_5_Local.__ENH_Address_Property_Event_5;
  END;
  SHARED B_Bankruptcy_4_Local := MODULE(B_Bankruptcy_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_5().__ENH_Bankruptcy_5) __ENH_Bankruptcy_5 := B_Bankruptcy_5_Local.__ENH_Bankruptcy_5;
  END;
  SHARED B_Business_Sele_4_Local := MODULE(B_Business_Sele_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_5().__ENH_Bankruptcy_5) __ENH_Bankruptcy_5 := B_Bankruptcy_5_Local.__ENH_Bankruptcy_5;
    SHARED TYPEOF(B_Business_Sele_5().__ENH_Business_Sele_5) __ENH_Business_Sele_5 := B_Business_Sele_5_Local.__ENH_Business_Sele_5;
    SHARED TYPEOF(B_Sele_Address_5().__ENH_Sele_Address_5) __ENH_Sele_Address_5 := B_Sele_Address_5_Local.__ENH_Sele_Address_5;
    SHARED TYPEOF(E_Sele_Bankruptcy().__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Person_5().__ENH_Sele_Person_5) __ENH_Sele_Person_5 := B_Sele_Person_5_Local.__ENH_Sele_Person_5;
    SHARED TYPEOF(E_Sele_Tradeline().__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered.__Result;
    SHARED TYPEOF(B_Sele_U_C_C_5().__ENH_Sele_U_C_C_5) __ENH_Sele_U_C_C_5 := B_Sele_U_C_C_5_Local.__ENH_Sele_U_C_C_5;
    SHARED TYPEOF(B_Tradeline_5().__ENH_Tradeline_5) __ENH_Tradeline_5 := B_Tradeline_5_Local.__ENH_Tradeline_5;
    SHARED TYPEOF(B_U_C_C_5().__ENH_U_C_C_5) __ENH_U_C_C_5 := B_U_C_C_5_Local.__ENH_U_C_C_5;
  END;
  SHARED B_Criminal_Offense_4_Local := MODULE(B_Criminal_Offense_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Criminal_Offense_5().__ENH_Criminal_Offense_5) __ENH_Criminal_Offense_5 := B_Criminal_Offense_5_Local.__ENH_Criminal_Offense_5;
  END;
  SHARED B_Education_4_Local := MODULE(B_Education_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_5().__ENH_Education_5) __ENH_Education_5 := B_Education_5_Local.__ENH_Education_5;
  END;
  SHARED B_Input_B_I_I_4_Local := MODULE(B_Input_B_I_I_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_5().__ENH_Input_B_I_I_5) __ENH_Input_B_I_I_5 := B_Input_B_I_I_5_Local.__ENH_Input_B_I_I_5;
  END;
  SHARED B_Input_P_I_I_4_Local := MODULE(B_Input_P_I_I_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_5().__ENH_Input_P_I_I_5) __ENH_Input_P_I_I_5 := B_Input_P_I_I_5_Local.__ENH_Input_P_I_I_5;
  END;
  SHARED B_Lien_Judgment_4_Local := MODULE(B_Lien_Judgment_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_5().__ENH_Lien_Judgment_5) __ENH_Lien_Judgment_5 := B_Lien_Judgment_5_Local.__ENH_Lien_Judgment_5;
  END;
  SHARED B_Person_4_Local := MODULE(B_Person_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_5().__ENH_Person_5) __ENH_Person_5 := B_Person_5_Local.__ENH_Person_5;
  END;
  SHARED B_Professional_License_4_Local := MODULE(B_Professional_License_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Professional_License_5().__ENH_Professional_License_5) __ENH_Professional_License_5 := B_Professional_License_5_Local.__ENH_Professional_License_5;
  END;
  SHARED B_Property_Event_4_Local := MODULE(B_Property_Event_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_5().__ENH_Property_Event_5) __ENH_Property_Event_5 := B_Property_Event_5_Local.__ENH_Property_Event_5;
  END;
  SHARED B_Sele_Address_4_Local := MODULE(B_Sele_Address_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Address_5().__ENH_Sele_Address_5) __ENH_Sele_Address_5 := B_Sele_Address_5_Local.__ENH_Sele_Address_5;
  END;
  SHARED B_Sele_Person_4_Local := MODULE(B_Sele_Person_4(__in,__cfg_Local))
    SHARED TYPEOF(B_First_Degree_Relative_5().__ENH_First_Degree_Relative_5) __ENH_First_Degree_Relative_5 := B_First_Degree_Relative_5_Local.__ENH_First_Degree_Relative_5;
    SHARED TYPEOF(B_Sele_Person_5().__ENH_Sele_Person_5) __ENH_Sele_Person_5 := B_Sele_Person_5_Local.__ENH_Sele_Person_5;
  END;
  SHARED B_Sele_Phone_Number_4_Local := MODULE(B_Sele_Phone_Number_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Phone_Number_5().__ENH_Sele_Phone_Number_5) __ENH_Sele_Phone_Number_5 := B_Sele_Phone_Number_5_Local.__ENH_Sele_Phone_Number_5;
  END;
  SHARED B_Sele_Property_4_Local := MODULE(B_Sele_Property_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_5().__ENH_Property_Event_5) __ENH_Property_Event_5 := B_Property_Event_5_Local.__ENH_Property_Event_5;
    SHARED TYPEOF(E_Sele_Property().__Result) __E_Sele_Property := E_Sele_Property_Filtered.__Result;
    SHARED TYPEOF(E_Sele_Property_Event().__Result) __E_Sele_Property_Event := E_Sele_Property_Event_Filtered.__Result;
  END;
  SHARED B_Sele_T_I_N_4_Local := MODULE(B_Sele_T_I_N_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_T_I_N_5().__ENH_Sele_T_I_N_5) __ENH_Sele_T_I_N_5 := B_Sele_T_I_N_5_Local.__ENH_Sele_T_I_N_5;
  END;
  SHARED B_Sele_U_C_C_4_Local := MODULE(B_Sele_U_C_C_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_U_C_C_5().__ENH_Sele_U_C_C_5) __ENH_Sele_U_C_C_5 := B_Sele_U_C_C_5_Local.__ENH_Sele_U_C_C_5;
  END;
  SHARED B_Tradeline_4_Local := MODULE(B_Tradeline_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_5().__ENH_Tradeline_5) __ENH_Tradeline_5 := B_Tradeline_5_Local.__ENH_Tradeline_5;
  END;
  SHARED B_U_C_C_4_Local := MODULE(B_U_C_C_4(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_5().__ENH_U_C_C_5) __ENH_U_C_C_5 := B_U_C_C_5_Local.__ENH_U_C_C_5;
  END;
  SHARED B_Address_Property_Event_3_Local := MODULE(B_Address_Property_Event_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_Property_Event_4().__ENH_Address_Property_Event_4) __ENH_Address_Property_Event_4 := B_Address_Property_Event_4_Local.__ENH_Address_Property_Event_4;
  END;
  SHARED B_Aircraft_Owner_3_Local := MODULE(B_Aircraft_Owner_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Aircraft_Owner().__Result) __E_Aircraft_Owner := E_Aircraft_Owner_Filtered.__Result;
  END;
  SHARED B_Bankruptcy_3_Local := MODULE(B_Bankruptcy_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_4().__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4_Local.__ENH_Bankruptcy_4;
  END;
  SHARED B_Business_Prox_3_Local := MODULE(B_Business_Prox_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Business_Prox().__Result) __E_Business_Prox := E_Business_Prox_Filtered.__Result;
    SHARED TYPEOF(E_Prox_Address().__Result) __E_Prox_Address := E_Prox_Address_Filtered.__Result;
  END;
  SHARED B_Business_Sele_3_Local := MODULE(B_Business_Sele_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Address().__Result) __E_Address := E_Address_Filtered.__Result;
    SHARED TYPEOF(B_Address_Property_Event_4().__ENH_Address_Property_Event_4) __ENH_Address_Property_Event_4 := B_Address_Property_Event_4_Local.__ENH_Address_Property_Event_4;
    SHARED TYPEOF(B_Bankruptcy_4().__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4_Local.__ENH_Bankruptcy_4;
    SHARED TYPEOF(B_Business_Sele_4().__ENH_Business_Sele_4) __ENH_Business_Sele_4 := B_Business_Sele_4_Local.__ENH_Business_Sele_4;
    SHARED TYPEOF(B_Sele_Address_4().__ENH_Sele_Address_4) __ENH_Sele_Address_4 := B_Sele_Address_4_Local.__ENH_Sele_Address_4;
    SHARED TYPEOF(E_Sele_Bankruptcy().__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Person_4().__ENH_Sele_Person_4) __ENH_Sele_Person_4 := B_Sele_Person_4_Local.__ENH_Sele_Person_4;
    SHARED TYPEOF(B_Sele_Property_4().__ENH_Sele_Property_4) __ENH_Sele_Property_4 := B_Sele_Property_4_Local.__ENH_Sele_Property_4;
    SHARED TYPEOF(E_Sele_Tradeline().__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered.__Result;
    SHARED TYPEOF(B_Sele_U_C_C_4().__ENH_Sele_U_C_C_4) __ENH_Sele_U_C_C_4 := B_Sele_U_C_C_4_Local.__ENH_Sele_U_C_C_4;
    SHARED TYPEOF(B_Tradeline_4().__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local.__ENH_Tradeline_4;
    SHARED TYPEOF(B_U_C_C_4().__ENH_U_C_C_4) __ENH_U_C_C_4 := B_U_C_C_4_Local.__ENH_U_C_C_4;
    SHARED TYPEOF(E_Zip_Code().__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
  END;
  SHARED B_Criminal_Offense_3_Local := MODULE(B_Criminal_Offense_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Criminal_Offense_4().__ENH_Criminal_Offense_4) __ENH_Criminal_Offense_4 := B_Criminal_Offense_4_Local.__ENH_Criminal_Offense_4;
  END;
  SHARED B_Education_3_Local := MODULE(B_Education_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_4().__ENH_Education_4) __ENH_Education_4 := B_Education_4_Local.__ENH_Education_4;
  END;
  SHARED B_Input_B_I_I_3_Local := MODULE(B_Input_B_I_I_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_4().__ENH_Input_B_I_I_4) __ENH_Input_B_I_I_4 := B_Input_B_I_I_4_Local.__ENH_Input_B_I_I_4;
  END;
  SHARED B_Input_P_I_I_3_Local := MODULE(B_Input_P_I_I_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_4().__ENH_Input_P_I_I_4) __ENH_Input_P_I_I_4 := B_Input_P_I_I_4_Local.__ENH_Input_P_I_I_4;
  END;
  SHARED B_Lien_Judgment_3_Local := MODULE(B_Lien_Judgment_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_4().__ENH_Lien_Judgment_4) __ENH_Lien_Judgment_4 := B_Lien_Judgment_4_Local.__ENH_Lien_Judgment_4;
  END;
  SHARED B_Person_3_Local := MODULE(B_Person_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_4().__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4_Local.__ENH_Bankruptcy_4;
    SHARED TYPEOF(B_Criminal_Offense_4().__ENH_Criminal_Offense_4) __ENH_Criminal_Offense_4 := B_Criminal_Offense_4_Local.__ENH_Criminal_Offense_4;
    SHARED TYPEOF(B_Person_4().__ENH_Person_4) __ENH_Person_4 := B_Person_4_Local.__ENH_Person_4;
    SHARED TYPEOF(E_Person_Bankruptcy().__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(E_Person_Offenses().__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
    SHARED TYPEOF(B_Professional_License_4().__ENH_Professional_License_4) __ENH_Professional_License_4 := B_Professional_License_4_Local.__ENH_Professional_License_4;
    SHARED TYPEOF(E_Professional_License_Person().__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered.__Result;
  END;
  SHARED B_Person_Vehicle_3_Local := MODULE(B_Person_Vehicle_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Person_Vehicle().__Result) __E_Person_Vehicle := E_Person_Vehicle_Filtered.__Result;
  END;
  SHARED B_Professional_License_3_Local := MODULE(B_Professional_License_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Professional_License_4().__ENH_Professional_License_4) __ENH_Professional_License_4 := B_Professional_License_4_Local.__ENH_Professional_License_4;
  END;
  SHARED B_Property_Event_3_Local := MODULE(B_Property_Event_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_4().__ENH_Property_Event_4) __ENH_Property_Event_4 := B_Property_Event_4_Local.__ENH_Property_Event_4;
  END;
  SHARED B_Sele_Address_3_Local := MODULE(B_Sele_Address_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Address_4().__ENH_Sele_Address_4) __ENH_Sele_Address_4 := B_Sele_Address_4_Local.__ENH_Sele_Address_4;
  END;
  SHARED B_Sele_Person_3_Local := MODULE(B_Sele_Person_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Person_4().__ENH_Sele_Person_4) __ENH_Sele_Person_4 := B_Sele_Person_4_Local.__ENH_Sele_Person_4;
  END;
  SHARED B_Sele_Phone_Number_3_Local := MODULE(B_Sele_Phone_Number_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Phone_Number_4().__ENH_Sele_Phone_Number_4) __ENH_Sele_Phone_Number_4 := B_Sele_Phone_Number_4_Local.__ENH_Sele_Phone_Number_4;
  END;
  SHARED B_Sele_Property_3_Local := MODULE(B_Sele_Property_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Property_4().__ENH_Sele_Property_4) __ENH_Sele_Property_4 := B_Sele_Property_4_Local.__ENH_Sele_Property_4;
  END;
  SHARED B_Sele_Property_Event_3_Local := MODULE(B_Sele_Property_Event_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Sele_Property_Event().__Result) __E_Sele_Property_Event := E_Sele_Property_Event_Filtered.__Result;
  END;
  SHARED B_Sele_T_I_N_3_Local := MODULE(B_Sele_T_I_N_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_T_I_N_4().__ENH_Sele_T_I_N_4) __ENH_Sele_T_I_N_4 := B_Sele_T_I_N_4_Local.__ENH_Sele_T_I_N_4;
  END;
  SHARED B_Sele_Tradeline_3_Local := MODULE(B_Sele_Tradeline_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Sele_Tradeline().__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered.__Result;
    SHARED TYPEOF(B_Tradeline_4().__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local.__ENH_Tradeline_4;
  END;
  SHARED B_Sele_U_C_C_3_Local := MODULE(B_Sele_U_C_C_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_U_C_C_4().__ENH_Sele_U_C_C_4) __ENH_Sele_U_C_C_4 := B_Sele_U_C_C_4_Local.__ENH_Sele_U_C_C_4;
  END;
  SHARED B_Sele_Vehicle_3_Local := MODULE(B_Sele_Vehicle_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Sele_Vehicle().__Result) __E_Sele_Vehicle := E_Sele_Vehicle_Filtered.__Result;
  END;
  SHARED B_Tradeline_3_Local := MODULE(B_Tradeline_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_4().__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local.__ENH_Tradeline_4;
  END;
  SHARED B_U_C_C_3_Local := MODULE(B_U_C_C_3(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_4().__ENH_U_C_C_4) __ENH_U_C_C_4 := B_U_C_C_4_Local.__ENH_U_C_C_4;
  END;
  SHARED B_Watercraft_Owner_3_Local := MODULE(B_Watercraft_Owner_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Watercraft_Owner().__Result) __E_Watercraft_Owner := E_Watercraft_Owner_Filtered.__Result;
  END;
  SHARED B_Address_2_Local := MODULE(B_Address_2(__in,__cfg_Local))
    SHARED TYPEOF(E_Address().__Result) __E_Address := E_Address_Filtered.__Result;
    SHARED TYPEOF(E_Zip_Code().__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
  END;
  SHARED B_Aircraft_Owner_2_Local := MODULE(B_Aircraft_Owner_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Aircraft_Owner_3().__ENH_Aircraft_Owner_3) __ENH_Aircraft_Owner_3 := B_Aircraft_Owner_3_Local.__ENH_Aircraft_Owner_3;
  END;
  SHARED B_Bankruptcy_2_Local := MODULE(B_Bankruptcy_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_3().__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local.__ENH_Bankruptcy_3;
  END;
  SHARED B_Business_Prox_2_Local := MODULE(B_Business_Prox_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Prox_3().__ENH_Business_Prox_3) __ENH_Business_Prox_3 := B_Business_Prox_3_Local.__ENH_Business_Prox_3;
    SHARED TYPEOF(E_Prox_Phone_Number().__Result) __E_Prox_Phone_Number := E_Prox_Phone_Number_Filtered.__Result;
    SHARED TYPEOF(E_Prox_T_I_N().__Result) __E_Prox_T_I_N := E_Prox_T_I_N_Filtered.__Result;
  END;
  SHARED B_Business_Sele_2_Local := MODULE(B_Business_Sele_2(__in,__cfg_Local))
    SHARED TYPEOF(E_Address().__Result) __E_Address := E_Address_Filtered.__Result;
    SHARED TYPEOF(B_Address_Property_Event_3().__ENH_Address_Property_Event_3) __ENH_Address_Property_Event_3 := B_Address_Property_Event_3_Local.__ENH_Address_Property_Event_3;
    SHARED TYPEOF(B_Bankruptcy_3().__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local.__ENH_Bankruptcy_3;
    SHARED TYPEOF(B_Business_Prox_3().__ENH_Business_Prox_3) __ENH_Business_Prox_3 := B_Business_Prox_3_Local.__ENH_Business_Prox_3;
    SHARED TYPEOF(B_Business_Sele_3().__ENH_Business_Sele_3) __ENH_Business_Sele_3 := B_Business_Sele_3_Local.__ENH_Business_Sele_3;
    SHARED TYPEOF(B_Input_B_I_I_3().__ENH_Input_B_I_I_3) __ENH_Input_B_I_I_3 := B_Input_B_I_I_3_Local.__ENH_Input_B_I_I_3;
    SHARED TYPEOF(B_Person_3().__ENH_Person_3) __ENH_Person_3 := B_Person_3_Local.__ENH_Person_3;
    SHARED TYPEOF(E_Sele_Bankruptcy().__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Person_3().__ENH_Sele_Person_3) __ENH_Sele_Person_3 := B_Sele_Person_3_Local.__ENH_Sele_Person_3;
    SHARED TYPEOF(B_Sele_Phone_Number_3().__ENH_Sele_Phone_Number_3) __ENH_Sele_Phone_Number_3 := B_Sele_Phone_Number_3_Local.__ENH_Sele_Phone_Number_3;
    SHARED TYPEOF(B_Sele_Property_3().__ENH_Sele_Property_3) __ENH_Sele_Property_3 := B_Sele_Property_3_Local.__ENH_Sele_Property_3;
    SHARED TYPEOF(B_Sele_T_I_N_3().__ENH_Sele_T_I_N_3) __ENH_Sele_T_I_N_3 := B_Sele_T_I_N_3_Local.__ENH_Sele_T_I_N_3;
    SHARED TYPEOF(B_Sele_Tradeline_3().__ENH_Sele_Tradeline_3) __ENH_Sele_Tradeline_3 := B_Sele_Tradeline_3_Local.__ENH_Sele_Tradeline_3;
    SHARED TYPEOF(B_Sele_U_C_C_3().__ENH_Sele_U_C_C_3) __ENH_Sele_U_C_C_3 := B_Sele_U_C_C_3_Local.__ENH_Sele_U_C_C_3;
    SHARED TYPEOF(B_Sele_Vehicle_3().__ENH_Sele_Vehicle_3) __ENH_Sele_Vehicle_3 := B_Sele_Vehicle_3_Local.__ENH_Sele_Vehicle_3;
    SHARED TYPEOF(B_Tradeline_3().__ENH_Tradeline_3) __ENH_Tradeline_3 := B_Tradeline_3_Local.__ENH_Tradeline_3;
    SHARED TYPEOF(B_U_C_C_3().__ENH_U_C_C_3) __ENH_U_C_C_3 := B_U_C_C_3_Local.__ENH_U_C_C_3;
    SHARED TYPEOF(E_Zip_Code().__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
  END;
  SHARED B_Criminal_Offense_2_Local := MODULE(B_Criminal_Offense_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Criminal_Offense_3().__ENH_Criminal_Offense_3) __ENH_Criminal_Offense_3 := B_Criminal_Offense_3_Local.__ENH_Criminal_Offense_3;
  END;
  SHARED B_Education_2_Local := MODULE(B_Education_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_3().__ENH_Education_3) __ENH_Education_3 := B_Education_3_Local.__ENH_Education_3;
  END;
  SHARED B_Input_B_I_I_2_Local := MODULE(B_Input_B_I_I_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_3().__ENH_Input_B_I_I_3) __ENH_Input_B_I_I_3 := B_Input_B_I_I_3_Local.__ENH_Input_B_I_I_3;
    SHARED TYPEOF(E_Input_B_I_I_Input_P_I_I().__Result) __E_Input_B_I_I_Input_P_I_I := E_Input_B_I_I_Input_P_I_I_Filtered.__Result;
    SHARED TYPEOF(B_Input_P_I_I_3().__ENH_Input_P_I_I_3) __ENH_Input_P_I_I_3 := B_Input_P_I_I_3_Local.__ENH_Input_P_I_I_3;
  END;
  SHARED B_Input_P_I_I_2_Local := MODULE(B_Input_P_I_I_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_3().__ENH_Input_P_I_I_3) __ENH_Input_P_I_I_3 := B_Input_P_I_I_3_Local.__ENH_Input_P_I_I_3;
  END;
  SHARED B_Lien_Judgment_2_Local := MODULE(B_Lien_Judgment_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_3().__ENH_Lien_Judgment_3) __ENH_Lien_Judgment_3 := B_Lien_Judgment_3_Local.__ENH_Lien_Judgment_3;
  END;
  SHARED B_Person_2_Local := MODULE(B_Person_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Aircraft_Owner_3().__ENH_Aircraft_Owner_3) __ENH_Aircraft_Owner_3 := B_Aircraft_Owner_3_Local.__ENH_Aircraft_Owner_3;
    SHARED TYPEOF(B_Bankruptcy_3().__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local.__ENH_Bankruptcy_3;
    SHARED TYPEOF(B_Criminal_Offense_3().__ENH_Criminal_Offense_3) __ENH_Criminal_Offense_3 := B_Criminal_Offense_3_Local.__ENH_Criminal_Offense_3;
    SHARED TYPEOF(B_Education_3().__ENH_Education_3) __ENH_Education_3 := B_Education_3_Local.__ENH_Education_3;
    SHARED TYPEOF(B_Person_3().__ENH_Person_3) __ENH_Person_3 := B_Person_3_Local.__ENH_Person_3;
    SHARED TYPEOF(E_Person_Address().__Result) __E_Person_Address := E_Person_Address_Filtered.__Result;
    SHARED TYPEOF(E_Person_Bankruptcy().__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(E_Person_Education().__Result) __E_Person_Education := E_Person_Education_Filtered.__Result;
    SHARED TYPEOF(E_Person_Offenses().__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
    SHARED TYPEOF(B_Person_Vehicle_3().__ENH_Person_Vehicle_3) __ENH_Person_Vehicle_3 := B_Person_Vehicle_3_Local.__ENH_Person_Vehicle_3;
    SHARED TYPEOF(B_Professional_License_3().__ENH_Professional_License_3) __ENH_Professional_License_3 := B_Professional_License_3_Local.__ENH_Professional_License_3;
    SHARED TYPEOF(E_Professional_License_Person().__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered.__Result;
    SHARED TYPEOF(B_Watercraft_Owner_3().__ENH_Watercraft_Owner_3) __ENH_Watercraft_Owner_3 := B_Watercraft_Owner_3_Local.__ENH_Watercraft_Owner_3;
  END;
  SHARED B_Person_Vehicle_2_Local := MODULE(B_Person_Vehicle_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Vehicle_3().__ENH_Person_Vehicle_3) __ENH_Person_Vehicle_3 := B_Person_Vehicle_3_Local.__ENH_Person_Vehicle_3;
  END;
  SHARED B_Professional_License_2_Local := MODULE(B_Professional_License_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Professional_License_3().__ENH_Professional_License_3) __ENH_Professional_License_3 := B_Professional_License_3_Local.__ENH_Professional_License_3;
  END;
  SHARED B_Property_Event_2_Local := MODULE(B_Property_Event_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_3().__ENH_Property_Event_3) __ENH_Property_Event_3 := B_Property_Event_3_Local.__ENH_Property_Event_3;
  END;
  SHARED B_Sele_Address_2_Local := MODULE(B_Sele_Address_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Address_3().__ENH_Sele_Address_3) __ENH_Sele_Address_3 := B_Sele_Address_3_Local.__ENH_Sele_Address_3;
  END;
  SHARED B_Sele_Person_2_Local := MODULE(B_Sele_Person_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Person_3().__ENH_Sele_Person_3) __ENH_Sele_Person_3 := B_Sele_Person_3_Local.__ENH_Sele_Person_3;
  END;
  SHARED B_Sele_Property_2_Local := MODULE(B_Sele_Property_2(__in,__cfg_Local))
    SHARED TYPEOF(E_Property().__Result) __E_Property := E_Property_Filtered.__Result;
    SHARED TYPEOF(B_Property_Event_3().__ENH_Property_Event_3) __ENH_Property_Event_3 := B_Property_Event_3_Local.__ENH_Property_Event_3;
    SHARED TYPEOF(B_Sele_Property_3().__ENH_Sele_Property_3) __ENH_Sele_Property_3 := B_Sele_Property_3_Local.__ENH_Sele_Property_3;
    SHARED TYPEOF(B_Sele_Property_Event_3().__ENH_Sele_Property_Event_3) __ENH_Sele_Property_Event_3 := B_Sele_Property_Event_3_Local.__ENH_Sele_Property_Event_3;
  END;
  SHARED B_Sele_Property_Event_2_Local := MODULE(B_Sele_Property_Event_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Property_Event_3().__ENH_Sele_Property_Event_3) __ENH_Sele_Property_Event_3 := B_Sele_Property_Event_3_Local.__ENH_Sele_Property_Event_3;
  END;
  SHARED B_Sele_Tradeline_2_Local := MODULE(B_Sele_Tradeline_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Tradeline_3().__ENH_Sele_Tradeline_3) __ENH_Sele_Tradeline_3 := B_Sele_Tradeline_3_Local.__ENH_Sele_Tradeline_3;
  END;
  SHARED B_Sele_U_C_C_2_Local := MODULE(B_Sele_U_C_C_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_U_C_C_3().__ENH_Sele_U_C_C_3) __ENH_Sele_U_C_C_3 := B_Sele_U_C_C_3_Local.__ENH_Sele_U_C_C_3;
  END;
  SHARED B_Sele_Vehicle_2_Local := MODULE(B_Sele_Vehicle_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Vehicle_3().__ENH_Sele_Vehicle_3) __ENH_Sele_Vehicle_3 := B_Sele_Vehicle_3_Local.__ENH_Sele_Vehicle_3;
  END;
  SHARED B_Tradeline_2_Local := MODULE(B_Tradeline_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_3().__ENH_Tradeline_3) __ENH_Tradeline_3 := B_Tradeline_3_Local.__ENH_Tradeline_3;
  END;
  SHARED B_U_C_C_2_Local := MODULE(B_U_C_C_2(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_3().__ENH_U_C_C_3) __ENH_U_C_C_3 := B_U_C_C_3_Local.__ENH_U_C_C_3;
  END;
  SHARED B_Watercraft_Owner_2_Local := MODULE(B_Watercraft_Owner_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Watercraft_Owner_3().__ENH_Watercraft_Owner_3) __ENH_Watercraft_Owner_3 := B_Watercraft_Owner_3_Local.__ENH_Watercraft_Owner_3;
  END;
  SHARED B_Address_1_Local := MODULE(B_Address_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_2().__ENH_Address_2) __ENH_Address_2 := B_Address_2_Local.__ENH_Address_2;
  END;
  SHARED B_Aircraft_Owner_1_Local := MODULE(B_Aircraft_Owner_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Aircraft_Owner_2().__ENH_Aircraft_Owner_2) __ENH_Aircraft_Owner_2 := B_Aircraft_Owner_2_Local.__ENH_Aircraft_Owner_2;
  END;
  SHARED B_Bankruptcy_1_Local := MODULE(B_Bankruptcy_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_2().__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local.__ENH_Bankruptcy_2;
  END;
  SHARED B_Business_Prox_1_Local := MODULE(B_Business_Prox_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Prox_2().__ENH_Business_Prox_2) __ENH_Business_Prox_2 := B_Business_Prox_2_Local.__ENH_Business_Prox_2;
  END;
  SHARED B_Business_Sele_1_Local := MODULE(B_Business_Sele_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_2().__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local.__ENH_Bankruptcy_2;
    SHARED TYPEOF(B_Business_Prox_2().__ENH_Business_Prox_2) __ENH_Business_Prox_2 := B_Business_Prox_2_Local.__ENH_Business_Prox_2;
    SHARED TYPEOF(B_Business_Sele_2().__ENH_Business_Sele_2) __ENH_Business_Sele_2 := B_Business_Sele_2_Local.__ENH_Business_Sele_2;
    SHARED TYPEOF(B_Input_B_I_I_2().__ENH_Input_B_I_I_2) __ENH_Input_B_I_I_2 := B_Input_B_I_I_2_Local.__ENH_Input_B_I_I_2;
    SHARED TYPEOF(B_Person_2().__ENH_Person_2) __ENH_Person_2 := B_Person_2_Local.__ENH_Person_2;
    SHARED TYPEOF(E_Person_Email().__Result) __E_Person_Email := E_Person_Email_Filtered.__Result;
    SHARED TYPEOF(B_Property_Event_2().__ENH_Property_Event_2) __ENH_Property_Event_2 := B_Property_Event_2_Local.__ENH_Property_Event_2;
    SHARED TYPEOF(B_Sele_Address_2().__ENH_Sele_Address_2) __ENH_Sele_Address_2 := B_Sele_Address_2_Local.__ENH_Sele_Address_2;
    SHARED TYPEOF(E_Sele_Bankruptcy().__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Person_2().__ENH_Sele_Person_2) __ENH_Sele_Person_2 := B_Sele_Person_2_Local.__ENH_Sele_Person_2;
    SHARED TYPEOF(B_Sele_Property_2().__ENH_Sele_Property_2) __ENH_Sele_Property_2 := B_Sele_Property_2_Local.__ENH_Sele_Property_2;
    SHARED TYPEOF(B_Sele_Property_Event_2().__ENH_Sele_Property_Event_2) __ENH_Sele_Property_Event_2 := B_Sele_Property_Event_2_Local.__ENH_Sele_Property_Event_2;
    SHARED TYPEOF(B_Sele_Tradeline_2().__ENH_Sele_Tradeline_2) __ENH_Sele_Tradeline_2 := B_Sele_Tradeline_2_Local.__ENH_Sele_Tradeline_2;
    SHARED TYPEOF(B_Sele_U_C_C_2().__ENH_Sele_U_C_C_2) __ENH_Sele_U_C_C_2 := B_Sele_U_C_C_2_Local.__ENH_Sele_U_C_C_2;
    SHARED TYPEOF(B_Sele_Vehicle_2().__ENH_Sele_Vehicle_2) __ENH_Sele_Vehicle_2 := B_Sele_Vehicle_2_Local.__ENH_Sele_Vehicle_2;
    SHARED TYPEOF(B_Tradeline_2().__ENH_Tradeline_2) __ENH_Tradeline_2 := B_Tradeline_2_Local.__ENH_Tradeline_2;
    SHARED TYPEOF(B_U_C_C_2().__ENH_U_C_C_2) __ENH_U_C_C_2 := B_U_C_C_2_Local.__ENH_U_C_C_2;
    SHARED TYPEOF(E_Zip_Code().__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
  END;
  SHARED B_Criminal_Offense_1_Local := MODULE(B_Criminal_Offense_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Criminal_Offense_2().__ENH_Criminal_Offense_2) __ENH_Criminal_Offense_2 := B_Criminal_Offense_2_Local.__ENH_Criminal_Offense_2;
  END;
  SHARED B_Education_1_Local := MODULE(B_Education_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_2().__ENH_Education_2) __ENH_Education_2 := B_Education_2_Local.__ENH_Education_2;
  END;
  SHARED B_Input_B_I_I_1_Local := MODULE(B_Input_B_I_I_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_2().__ENH_Input_B_I_I_2) __ENH_Input_B_I_I_2 := B_Input_B_I_I_2_Local.__ENH_Input_B_I_I_2;
    SHARED TYPEOF(B_Input_P_I_I_2().__ENH_Input_P_I_I_2) __ENH_Input_P_I_I_2 := B_Input_P_I_I_2_Local.__ENH_Input_P_I_I_2;
  END;
  SHARED B_Lien_Judgment_1_Local := MODULE(B_Lien_Judgment_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_2().__ENH_Lien_Judgment_2) __ENH_Lien_Judgment_2 := B_Lien_Judgment_2_Local.__ENH_Lien_Judgment_2;
  END;
  SHARED B_Person_1_Local := MODULE(B_Person_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Aircraft_Owner_2().__ENH_Aircraft_Owner_2) __ENH_Aircraft_Owner_2 := B_Aircraft_Owner_2_Local.__ENH_Aircraft_Owner_2;
    SHARED TYPEOF(B_Bankruptcy_2().__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local.__ENH_Bankruptcy_2;
    SHARED TYPEOF(B_Criminal_Offense_2().__ENH_Criminal_Offense_2) __ENH_Criminal_Offense_2 := B_Criminal_Offense_2_Local.__ENH_Criminal_Offense_2;
    SHARED TYPEOF(B_Education_2().__ENH_Education_2) __ENH_Education_2 := B_Education_2_Local.__ENH_Education_2;
    SHARED TYPEOF(B_Person_2().__ENH_Person_2) __ENH_Person_2 := B_Person_2_Local.__ENH_Person_2;
    SHARED TYPEOF(E_Person_Bankruptcy().__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(E_Person_Education().__Result) __E_Person_Education := E_Person_Education_Filtered.__Result;
    SHARED TYPEOF(E_Person_Offenses().__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
    SHARED TYPEOF(B_Person_Vehicle_2().__ENH_Person_Vehicle_2) __ENH_Person_Vehicle_2 := B_Person_Vehicle_2_Local.__ENH_Person_Vehicle_2;
    SHARED TYPEOF(B_Professional_License_2().__ENH_Professional_License_2) __ENH_Professional_License_2 := B_Professional_License_2_Local.__ENH_Professional_License_2;
    SHARED TYPEOF(E_Professional_License_Person().__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered.__Result;
    SHARED TYPEOF(B_Watercraft_Owner_2().__ENH_Watercraft_Owner_2) __ENH_Watercraft_Owner_2 := B_Watercraft_Owner_2_Local.__ENH_Watercraft_Owner_2;
  END;
  SHARED B_Person_Vehicle_1_Local := MODULE(B_Person_Vehicle_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Vehicle_2().__ENH_Person_Vehicle_2) __ENH_Person_Vehicle_2 := B_Person_Vehicle_2_Local.__ENH_Person_Vehicle_2;
  END;
  SHARED B_Professional_License_1_Local := MODULE(B_Professional_License_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Professional_License_2().__ENH_Professional_License_2) __ENH_Professional_License_2 := B_Professional_License_2_Local.__ENH_Professional_License_2;
  END;
  SHARED B_Property_Event_1_Local := MODULE(B_Property_Event_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_2().__ENH_Property_Event_2) __ENH_Property_Event_2 := B_Property_Event_2_Local.__ENH_Property_Event_2;
  END;
  SHARED B_Sele_Address_1_Local := MODULE(B_Sele_Address_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Address_2().__ENH_Sele_Address_2) __ENH_Sele_Address_2 := B_Sele_Address_2_Local.__ENH_Sele_Address_2;
  END;
  SHARED B_Sele_Person_1_Local := MODULE(B_Sele_Person_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Person_2().__ENH_Sele_Person_2) __ENH_Sele_Person_2 := B_Sele_Person_2_Local.__ENH_Sele_Person_2;
  END;
  SHARED B_Sele_Property_1_Local := MODULE(B_Sele_Property_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_2().__ENH_Property_Event_2) __ENH_Property_Event_2 := B_Property_Event_2_Local.__ENH_Property_Event_2;
    SHARED TYPEOF(B_Sele_Property_2().__ENH_Sele_Property_2) __ENH_Sele_Property_2 := B_Sele_Property_2_Local.__ENH_Sele_Property_2;
    SHARED TYPEOF(B_Sele_Property_Event_2().__ENH_Sele_Property_Event_2) __ENH_Sele_Property_Event_2 := B_Sele_Property_Event_2_Local.__ENH_Sele_Property_Event_2;
  END;
  SHARED B_Sele_Tradeline_1_Local := MODULE(B_Sele_Tradeline_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Tradeline_2().__ENH_Sele_Tradeline_2) __ENH_Sele_Tradeline_2 := B_Sele_Tradeline_2_Local.__ENH_Sele_Tradeline_2;
  END;
  SHARED B_Sele_Vehicle_1_Local := MODULE(B_Sele_Vehicle_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Vehicle_2().__ENH_Sele_Vehicle_2) __ENH_Sele_Vehicle_2 := B_Sele_Vehicle_2_Local.__ENH_Sele_Vehicle_2;
  END;
  SHARED B_Tradeline_1_Local := MODULE(B_Tradeline_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_2().__ENH_Tradeline_2) __ENH_Tradeline_2 := B_Tradeline_2_Local.__ENH_Tradeline_2;
  END;
  SHARED B_U_C_C_1_Local := MODULE(B_U_C_C_1(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_2().__ENH_U_C_C_2) __ENH_U_C_C_2 := B_U_C_C_2_Local.__ENH_U_C_C_2;
  END;
  SHARED B_Watercraft_Owner_1_Local := MODULE(B_Watercraft_Owner_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Watercraft_Owner_2().__ENH_Watercraft_Owner_2) __ENH_Watercraft_Owner_2 := B_Watercraft_Owner_2_Local.__ENH_Watercraft_Owner_2;
  END;
  SHARED B_Address_Local := MODULE(B_Address(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_1().__ENH_Address_1) __ENH_Address_1 := B_Address_1_Local.__ENH_Address_1;
  END;
  SHARED B_Bankruptcy_Local := MODULE(B_Bankruptcy(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_1().__ENH_Bankruptcy_1) __ENH_Bankruptcy_1 := B_Bankruptcy_1_Local.__ENH_Bankruptcy_1;
  END;
  SHARED B_Business_Prox_Local := MODULE(B_Business_Prox(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Prox_1().__ENH_Business_Prox_1) __ENH_Business_Prox_1 := B_Business_Prox_1_Local.__ENH_Business_Prox_1;
  END;
  SHARED B_Business_Sele_Local := MODULE(B_Business_Sele(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_1().__ENH_Address_1) __ENH_Address_1 := B_Address_1_Local.__ENH_Address_1;
    SHARED TYPEOF(B_Bankruptcy_1().__ENH_Bankruptcy_1) __ENH_Bankruptcy_1 := B_Bankruptcy_1_Local.__ENH_Bankruptcy_1;
    SHARED TYPEOF(B_Business_Sele_1().__ENH_Business_Sele_1) __ENH_Business_Sele_1 := B_Business_Sele_1_Local.__ENH_Business_Sele_1;
    SHARED TYPEOF(B_Input_B_I_I_1().__ENH_Input_B_I_I_1) __ENH_Input_B_I_I_1 := B_Input_B_I_I_1_Local.__ENH_Input_B_I_I_1;
    SHARED TYPEOF(B_Property_Event_1().__ENH_Property_Event_1) __ENH_Property_Event_1 := B_Property_Event_1_Local.__ENH_Property_Event_1;
    SHARED TYPEOF(B_Sele_Address_1().__ENH_Sele_Address_1) __ENH_Sele_Address_1 := B_Sele_Address_1_Local.__ENH_Sele_Address_1;
    SHARED TYPEOF(E_Sele_Aircraft().__Result) __E_Sele_Aircraft := E_Sele_Aircraft_Filtered.__Result;
    SHARED TYPEOF(E_Sele_Bankruptcy().__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Person_1().__ENH_Sele_Person_1) __ENH_Sele_Person_1 := B_Sele_Person_1_Local.__ENH_Sele_Person_1;
    SHARED TYPEOF(B_Sele_Property_1().__ENH_Sele_Property_1) __ENH_Sele_Property_1 := B_Sele_Property_1_Local.__ENH_Sele_Property_1;
    SHARED TYPEOF(B_Sele_Tradeline_1().__ENH_Sele_Tradeline_1) __ENH_Sele_Tradeline_1 := B_Sele_Tradeline_1_Local.__ENH_Sele_Tradeline_1;
    SHARED TYPEOF(B_Sele_Vehicle_1().__ENH_Sele_Vehicle_1) __ENH_Sele_Vehicle_1 := B_Sele_Vehicle_1_Local.__ENH_Sele_Vehicle_1;
    SHARED TYPEOF(E_Sele_Watercraft().__Result) __E_Sele_Watercraft := E_Sele_Watercraft_Filtered.__Result;
    SHARED TYPEOF(B_Tradeline_1().__ENH_Tradeline_1) __ENH_Tradeline_1 := B_Tradeline_1_Local.__ENH_Tradeline_1;
    SHARED TYPEOF(E_Vehicle().__Result) __E_Vehicle := E_Vehicle_Filtered.__Result;
    SHARED TYPEOF(E_Zip_Code().__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
  END;
  SHARED B_Criminal_Offense_Local := MODULE(B_Criminal_Offense(__in,__cfg_Local))
    SHARED TYPEOF(B_Criminal_Offense_1().__ENH_Criminal_Offense_1) __ENH_Criminal_Offense_1 := B_Criminal_Offense_1_Local.__ENH_Criminal_Offense_1;
  END;
  SHARED B_Education_Local := MODULE(B_Education(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_1().__ENH_Education_1) __ENH_Education_1 := B_Education_1_Local.__ENH_Education_1;
  END;
  SHARED B_First_Degree_Relative_Local := MODULE(B_First_Degree_Relative(__in,__cfg_Local))
    SHARED TYPEOF(E_First_Degree_Relative().__Result) __E_First_Degree_Relative := E_First_Degree_Relative_Filtered.__Result;
  END;
  SHARED B_Lien_Judgment_Local := MODULE(B_Lien_Judgment(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_1().__ENH_Lien_Judgment_1) __ENH_Lien_Judgment_1 := B_Lien_Judgment_1_Local.__ENH_Lien_Judgment_1;
  END;
  SHARED B_Person_Local := MODULE(B_Person(__in,__cfg_Local))
    SHARED TYPEOF(B_Aircraft_Owner_1().__ENH_Aircraft_Owner_1) __ENH_Aircraft_Owner_1 := B_Aircraft_Owner_1_Local.__ENH_Aircraft_Owner_1;
    SHARED TYPEOF(B_Bankruptcy_1().__ENH_Bankruptcy_1) __ENH_Bankruptcy_1 := B_Bankruptcy_1_Local.__ENH_Bankruptcy_1;
    SHARED TYPEOF(B_Criminal_Offense_1().__ENH_Criminal_Offense_1) __ENH_Criminal_Offense_1 := B_Criminal_Offense_1_Local.__ENH_Criminal_Offense_1;
    SHARED TYPEOF(B_Education_1().__ENH_Education_1) __ENH_Education_1 := B_Education_1_Local.__ENH_Education_1;
    SHARED TYPEOF(B_Person_1().__ENH_Person_1) __ENH_Person_1 := B_Person_1_Local.__ENH_Person_1;
    SHARED TYPEOF(E_Person_Bankruptcy().__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(E_Person_Education().__Result) __E_Person_Education := E_Person_Education_Filtered.__Result;
    SHARED TYPEOF(E_Person_Offenses().__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
    SHARED TYPEOF(B_Person_Vehicle_1().__ENH_Person_Vehicle_1) __ENH_Person_Vehicle_1 := B_Person_Vehicle_1_Local.__ENH_Person_Vehicle_1;
    SHARED TYPEOF(B_Professional_License_1().__ENH_Professional_License_1) __ENH_Professional_License_1 := B_Professional_License_1_Local.__ENH_Professional_License_1;
    SHARED TYPEOF(E_Professional_License_Person().__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered.__Result;
    SHARED TYPEOF(B_Watercraft_Owner_1().__ENH_Watercraft_Owner_1) __ENH_Watercraft_Owner_1 := B_Watercraft_Owner_1_Local.__ENH_Watercraft_Owner_1;
  END;
  SHARED B_Professional_License_Local := MODULE(B_Professional_License(__in,__cfg_Local))
    SHARED TYPEOF(B_Professional_License_1().__ENH_Professional_License_1) __ENH_Professional_License_1 := B_Professional_License_1_Local.__ENH_Professional_License_1;
  END;
  SHARED B_Property_Event_Local := MODULE(B_Property_Event(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_1().__ENH_Property_Event_1) __ENH_Property_Event_1 := B_Property_Event_1_Local.__ENH_Property_Event_1;
  END;
  SHARED B_Second_Degree_Associations_Local := MODULE(B_Second_Degree_Associations(__in,__cfg_Local))
    SHARED TYPEOF(E_First_Degree_Associations().__Result) __E_First_Degree_Associations := E_First_Degree_Associations_Filtered.__Result;
  END;
  SHARED B_Tradeline_Local := MODULE(B_Tradeline(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_1().__ENH_Tradeline_1) __ENH_Tradeline_1 := B_Tradeline_1_Local.__ENH_Tradeline_1;
  END;
  SHARED B_U_C_C_Local := MODULE(B_U_C_C(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_1().__ENH_U_C_C_1) __ENH_U_C_C_1 := B_U_C_C_1_Local.__ENH_U_C_C_1;
  END;
  SHARED TYPEOF(E_Accident().__Result) __E_Accident := E_Accident_Filtered.__Result;
  SHARED TYPEOF(B_Address().__ENH_Address) __ENH_Address := B_Address_Local.__ENH_Address;
  SHARED TYPEOF(E_Address().__Result) __E_Address := E_Address_Filtered.__Result;
  SHARED TYPEOF(E_Address_Inquiry().__Result) __E_Address_Inquiry := E_Address_Inquiry_Filtered.__Result;
  SHARED TYPEOF(E_Address_Phone().__Result) __E_Address_Phone := E_Address_Phone_Filtered.__Result;
  SHARED TYPEOF(E_Address_Property().__Result) __E_Address_Property := E_Address_Property_Filtered.__Result;
  SHARED TYPEOF(E_Address_Property_Event().__Result) __E_Address_Property_Event := E_Address_Property_Event_Filtered.__Result;
  SHARED TYPEOF(E_Aircraft().__Result) __E_Aircraft := E_Aircraft_Filtered.__Result;
  SHARED TYPEOF(E_Aircraft_Owner().__Result) __E_Aircraft_Owner := E_Aircraft_Owner_Filtered.__Result;
  SHARED TYPEOF(B_Bankruptcy().__ENH_Bankruptcy) __ENH_Bankruptcy := B_Bankruptcy_Local.__ENH_Bankruptcy;
  SHARED TYPEOF(E_Bankruptcy().__Result) __E_Bankruptcy := E_Bankruptcy_Filtered.__Result;
  SHARED TYPEOF(B_Business_Prox().__ENH_Business_Prox) __ENH_Business_Prox := B_Business_Prox_Local.__ENH_Business_Prox;
  SHARED TYPEOF(E_Business_Prox().__Result) __E_Business_Prox := E_Business_Prox_Filtered.__Result;
  SHARED TYPEOF(B_Business_Sele().__ENH_Business_Sele) __ENH_Business_Sele := B_Business_Sele_Local.__ENH_Business_Sele;
  SHARED TYPEOF(E_Business_Sele().__Result) __E_Business_Sele := E_Business_Sele_Filtered.__Result;
  SHARED TYPEOF(E_Criminal_Details().__Result) __E_Criminal_Details := E_Criminal_Details_Filtered.__Result;
  SHARED TYPEOF(E_Criminal_Offender().__Result) __E_Criminal_Offender := E_Criminal_Offender_Filtered.__Result;
  SHARED TYPEOF(B_Criminal_Offense().__ENH_Criminal_Offense) __ENH_Criminal_Offense := B_Criminal_Offense_Local.__ENH_Criminal_Offense;
  SHARED TYPEOF(E_Criminal_Offense().__Result) __E_Criminal_Offense := E_Criminal_Offense_Filtered.__Result;
  SHARED TYPEOF(E_Criminal_Punishment().__Result) __E_Criminal_Punishment := E_Criminal_Punishment_Filtered.__Result;
  SHARED TYPEOF(E_Drivers_License().__Result) __E_Drivers_License := E_Drivers_License_Filtered.__Result;
  SHARED TYPEOF(B_Education().__ENH_Education) __ENH_Education := B_Education_Local.__ENH_Education;
  SHARED TYPEOF(E_Education().__Result) __E_Education := E_Education_Filtered.__Result;
  SHARED TYPEOF(E_Email().__Result) __E_Email := E_Email_Filtered.__Result;
  SHARED TYPEOF(E_Employment().__Result) __E_Employment := E_Employment_Filtered.__Result;
  SHARED TYPEOF(E_Employment_Person().__Result) __E_Employment_Person := E_Employment_Person_Filtered.__Result;
  SHARED TYPEOF(E_First_Degree_Associations().__Result) __E_First_Degree_Associations := E_First_Degree_Associations_Filtered.__Result;
  SHARED TYPEOF(B_First_Degree_Relative().__ENH_First_Degree_Relative) __ENH_First_Degree_Relative := B_First_Degree_Relative_Local.__ENH_First_Degree_Relative;
  SHARED TYPEOF(E_First_Degree_Relative().__Result) __E_First_Degree_Relative := E_First_Degree_Relative_Filtered.__Result;
  SHARED TYPEOF(E_House_Hold_Phone().__Result) __E_House_Hold_Phone := E_House_Hold_Phone_Filtered.__Result;
  SHARED TYPEOF(E_Household().__Result) __E_Household := E_Household_Filtered.__Result;
  SHARED TYPEOF(E_Household_Member().__Result) __E_Household_Member := E_Household_Member_Filtered.__Result;
  SHARED TYPEOF(E_Inquiry().__Result) __E_Inquiry := E_Inquiry_Filtered.__Result;
  SHARED TYPEOF(B_Lien_Judgment().__ENH_Lien_Judgment) __ENH_Lien_Judgment := B_Lien_Judgment_Local.__ENH_Lien_Judgment;
  SHARED TYPEOF(E_Lien_Judgment().__Result) __E_Lien_Judgment := E_Lien_Judgment_Filtered.__Result;
  SHARED TYPEOF(B_Person().__ENH_Person) __ENH_Person := B_Person_Local.__ENH_Person;
  SHARED TYPEOF(E_Person().__Result) __E_Person := E_Person_Filtered.__Result;
  SHARED TYPEOF(E_Person_Accident().__Result) __E_Person_Accident := E_Person_Accident_Filtered.__Result;
  SHARED TYPEOF(E_Person_Address().__Result) __E_Person_Address := E_Person_Address_Filtered.__Result;
  SHARED TYPEOF(E_Person_Bankruptcy().__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
  SHARED TYPEOF(E_Person_Drivers_License().__Result) __E_Person_Drivers_License := E_Person_Drivers_License_Filtered.__Result;
  SHARED TYPEOF(E_Person_Education().__Result) __E_Person_Education := E_Person_Education_Filtered.__Result;
  SHARED TYPEOF(E_Person_Email().__Result) __E_Person_Email := E_Person_Email_Filtered.__Result;
  SHARED TYPEOF(E_Person_Email_Phone_Address().__Result) __E_Person_Email_Phone_Address := E_Person_Email_Phone_Address_Filtered.__Result;
  SHARED TYPEOF(E_Person_Inquiry().__Result) __E_Person_Inquiry := E_Person_Inquiry_Filtered.__Result;
  SHARED TYPEOF(E_Person_Lien_Judgment().__Result) __E_Person_Lien_Judgment := E_Person_Lien_Judgment_Filtered.__Result;
  SHARED TYPEOF(E_Person_Offender().__Result) __E_Person_Offender := E_Person_Offender_Filtered.__Result;
  SHARED TYPEOF(E_Person_Offenses().__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
  SHARED TYPEOF(E_Person_Phone().__Result) __E_Person_Phone := E_Person_Phone_Filtered.__Result;
  SHARED TYPEOF(E_Person_Property().__Result) __E_Person_Property := E_Person_Property_Filtered.__Result;
  SHARED TYPEOF(E_Person_Property_Event().__Result) __E_Person_Property_Event := E_Person_Property_Event_Filtered.__Result;
  SHARED TYPEOF(E_Person_S_S_N().__Result) __E_Person_S_S_N := E_Person_S_S_N_Filtered.__Result;
  SHARED TYPEOF(E_Person_U_C_C().__Result) __E_Person_U_C_C := E_Person_U_C_C_Filtered.__Result;
  SHARED TYPEOF(E_Person_Vehicle().__Result) __E_Person_Vehicle := E_Person_Vehicle_Filtered.__Result;
  SHARED TYPEOF(E_Phone().__Result) __E_Phone := E_Phone_Filtered.__Result;
  SHARED TYPEOF(E_Phone_Inquiry().__Result) __E_Phone_Inquiry := E_Phone_Inquiry_Filtered.__Result;
  SHARED TYPEOF(B_Professional_License().__ENH_Professional_License) __ENH_Professional_License := B_Professional_License_Local.__ENH_Professional_License;
  SHARED TYPEOF(E_Professional_License().__Result) __E_Professional_License := E_Professional_License_Filtered.__Result;
  SHARED TYPEOF(E_Professional_License_Person().__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered.__Result;
  SHARED TYPEOF(E_Property().__Result) __E_Property := E_Property_Filtered.__Result;
  SHARED TYPEOF(B_Property_Event().__ENH_Property_Event) __ENH_Property_Event := B_Property_Event_Local.__ENH_Property_Event;
  SHARED TYPEOF(E_Property_Event().__Result) __E_Property_Event := E_Property_Event_Filtered.__Result;
  SHARED TYPEOF(E_Prox_Address().__Result) __E_Prox_Address := E_Prox_Address_Filtered.__Result;
  SHARED TYPEOF(E_Prox_Email().__Result) __E_Prox_Email := E_Prox_Email_Filtered.__Result;
  SHARED TYPEOF(E_Prox_Person().__Result) __E_Prox_Person := E_Prox_Person_Filtered.__Result;
  SHARED TYPEOF(E_Prox_Phone_Number().__Result) __E_Prox_Phone_Number := E_Prox_Phone_Number_Filtered.__Result;
  SHARED TYPEOF(E_Prox_T_I_N().__Result) __E_Prox_T_I_N := E_Prox_T_I_N_Filtered.__Result;
  SHARED TYPEOF(E_Prox_Utility().__Result) __E_Prox_Utility := E_Prox_Utility_Filtered.__Result;
  SHARED TYPEOF(E_S_S_N_Address().__Result) __E_S_S_N_Address := E_S_S_N_Address_Filtered.__Result;
  SHARED TYPEOF(E_S_S_N_Inquiry().__Result) __E_S_S_N_Inquiry := E_S_S_N_Inquiry_Filtered.__Result;
  SHARED TYPEOF(B_Second_Degree_Associations().__ENH_Second_Degree_Associations) __ENH_Second_Degree_Associations := B_Second_Degree_Associations_Local.__ENH_Second_Degree_Associations;
  SHARED TYPEOF(E_Second_Degree_Associations().__Result) __E_Second_Degree_Associations := E_Second_Degree_Associations_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Address().__Result) __E_Sele_Address := E_Sele_Address_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Aircraft().__Result) __E_Sele_Aircraft := E_Sele_Aircraft_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Bankruptcy().__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Email().__Result) __E_Sele_Email := E_Sele_Email_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Lien_Judgment().__Result) __E_Sele_Lien_Judgment := E_Sele_Lien_Judgment_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Person().__Result) __E_Sele_Person := E_Sele_Person_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Phone_Number().__Result) __E_Sele_Phone_Number := E_Sele_Phone_Number_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Property().__Result) __E_Sele_Property := E_Sele_Property_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Property_Event().__Result) __E_Sele_Property_Event := E_Sele_Property_Event_Filtered.__Result;
  SHARED TYPEOF(E_Sele_T_I_N().__Result) __E_Sele_T_I_N := E_Sele_T_I_N_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Tradeline().__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered.__Result;
  SHARED TYPEOF(E_Sele_U_C_C().__Result) __E_Sele_U_C_C := E_Sele_U_C_C_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Utility().__Result) __E_Sele_Utility := E_Sele_Utility_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Vehicle().__Result) __E_Sele_Vehicle := E_Sele_Vehicle_Filtered.__Result;
  SHARED TYPEOF(E_Sele_Watercraft().__Result) __E_Sele_Watercraft := E_Sele_Watercraft_Filtered.__Result;
  SHARED TYPEOF(E_Social_Security_Number().__Result) __E_Social_Security_Number := E_Social_Security_Number_Filtered.__Result;
  SHARED TYPEOF(E_T_I_N().__Result) __E_T_I_N := E_T_I_N_Filtered.__Result;
  SHARED TYPEOF(E_T_I_N_Address().__Result) __E_T_I_N_Address := E_T_I_N_Address_Filtered.__Result;
  SHARED TYPEOF(E_T_I_N_Phone_Number().__Result) __E_T_I_N_Phone_Number := E_T_I_N_Phone_Number_Filtered.__Result;
  SHARED TYPEOF(B_Tradeline().__ENH_Tradeline) __ENH_Tradeline := B_Tradeline_Local.__ENH_Tradeline;
  SHARED TYPEOF(E_Tradeline().__Result) __E_Tradeline := E_Tradeline_Filtered.__Result;
  SHARED TYPEOF(B_U_C_C().__ENH_U_C_C) __ENH_U_C_C := B_U_C_C_Local.__ENH_U_C_C;
  SHARED TYPEOF(E_U_C_C().__Result) __E_U_C_C := E_U_C_C_Filtered.__Result;
  SHARED TYPEOF(E_Utility().__Result) __E_Utility := E_Utility_Filtered.__Result;
  SHARED TYPEOF(E_Utility_Address().__Result) __E_Utility_Address := E_Utility_Address_Filtered.__Result;
  SHARED TYPEOF(E_Utility_Person().__Result) __E_Utility_Person := E_Utility_Person_Filtered.__Result;
  SHARED TYPEOF(E_Vehicle().__Result) __E_Vehicle := E_Vehicle_Filtered.__Result;
  SHARED TYPEOF(E_Watercraft().__Result) __E_Watercraft := E_Watercraft_Filtered.__Result;
  SHARED TYPEOF(E_Watercraft_Owner().__Result) __E_Watercraft_Owner := E_Watercraft_Owner_Filtered.__Result;
  SHARED TYPEOF(E_Zip_Code().__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
  SHARED TYPEOF(E_Zip_Code_Person().__Result) __E_Zip_Code_Person := E_Zip_Code_Person_Filtered.__Result;
  SHARED __EE21440379 := __E_Inquiry;
  SHARED __EE21440369 := __E_Address_Inquiry;
  SHARED __EE21440554 := __EE21440369(__NN(__EE21440369.Location_) AND __NN(__EE21440369.Inquiry_));
  SHARED __EE21440363 := __E_Address;
  SHARED __EE21440619 := __EE21440363(__T(__OP2(__EE21440363.UID,=,__CN(__PAddressUID))));
  __JC21440625(E_Address_Inquiry(__in,__cfg_Local).Layout __EE21440554, E_Address(__in,__cfg_Local).Layout __EE21440619) := __EEQP(__EE21440619.UID,__EE21440554.Location_);
  SHARED __EE21440639 := JOIN(__EE21440554,__EE21440619,__JC21440625(LEFT,RIGHT),TRANSFORM(E_Address_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC21440645(E_Inquiry(__in,__cfg_Local).Layout __EE21440379, E_Address_Inquiry(__in,__cfg_Local).Layout __EE21440639) := __EEQP(__EE21440639.Inquiry_,__EE21440379.UID);
  SHARED __EE21440666 := JOIN(__EE21440379,__EE21440639,__JC21440645(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE21440668 := __EE21440666;
  EXPORT Res0 := __UNWRAP(__EE21440668);
  SHARED __EE21440813 := __E_Phone;
  SHARED __EE21440803 := __E_Address_Phone;
  SHARED __EE21441089 := __EE21440803(__NN(__EE21440803.Location_) AND __NN(__EE21440803.Phone_Number_));
  SHARED __EE21440797 := __E_Address;
  SHARED __EE21441200 := __EE21440797(__T(__OP2(__EE21440797.UID,=,__CN(__PAddressUID))));
  __JC21441206(E_Address_Phone(__in,__cfg_Local).Layout __EE21441089, E_Address(__in,__cfg_Local).Layout __EE21441200) := __EEQP(__EE21441200.UID,__EE21441089.Location_);
  SHARED __EE21441234 := JOIN(__EE21441089,__EE21441200,__JC21441206(LEFT,RIGHT),TRANSFORM(E_Address_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC21441240(E_Phone(__in,__cfg_Local).Layout __EE21440813, E_Address_Phone(__in,__cfg_Local).Layout __EE21441234) := __EEQP(__EE21441234.Phone_Number_,__EE21440813.UID);
  SHARED __EE21441293 := JOIN(__EE21440813,__EE21441234,__JC21441240(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE21441295 := __EE21441293;
  EXPORT Res1 := __UNWRAP(__EE21441295);
  SHARED __EE21441541 := __E_Property;
  SHARED __EE21441531 := __E_Address_Property;
  SHARED __EE21441770 := __EE21441531(__NN(__EE21441531.Location_) AND __NN(__EE21441531.Prop_));
  SHARED __EE21441525 := __E_Address;
  SHARED __EE21441860 := __EE21441525(__T(__OP2(__EE21441525.UID,=,__CN(__PAddressUID))));
  __JC21441866(E_Address_Property(__in,__cfg_Local).Layout __EE21441770, E_Address(__in,__cfg_Local).Layout __EE21441860) := __EEQP(__EE21441860.UID,__EE21441770.Location_);
  SHARED __EE21441891 := JOIN(__EE21441770,__EE21441860,__JC21441866(LEFT,RIGHT),TRANSFORM(E_Address_Property(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC21441897(E_Property(__in,__cfg_Local).Layout __EE21441541, E_Address_Property(__in,__cfg_Local).Layout __EE21441891) := __EEQP(__EE21441891.Prop_,__EE21441541.UID);
  SHARED __EE21441932 := JOIN(__EE21441541,__EE21441891,__JC21441897(LEFT,RIGHT),TRANSFORM(E_Property(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE21441934 := __EE21441932;
  EXPORT Res2 := __UNWRAP(__EE21441934);
  SHARED __EE21442136 := __ENH_Property_Event;
  SHARED __EE21442125 := __E_Address_Property_Event;
  SHARED __EE21442953 := __EE21442125(__NN(__EE21442125.Location_) AND __NN(__EE21442125.Event_));
  SHARED __EE21442119 := __E_Address;
  SHARED __EE21443338 := __EE21442119(__T(__OP2(__EE21442119.UID,=,__CN(__PAddressUID))));
  __JC21443344(E_Address_Property_Event(__in,__cfg_Local).Layout __EE21442953, E_Address(__in,__cfg_Local).Layout __EE21443338) := __EEQP(__EE21443338.UID,__EE21442953.Location_);
  SHARED __EE21443369 := JOIN(__EE21442953,__EE21443338,__JC21443344(LEFT,RIGHT),TRANSFORM(E_Address_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC21443375(B_Property_Event_3(__in,__cfg_Local).__ST162275_Layout __EE21442136, E_Address_Property_Event(__in,__cfg_Local).Layout __EE21443369) := __EEQP(__EE21443369.Event_,__EE21442136.UID);
  SHARED __EE21443705 := JOIN(__EE21442136,__EE21443369,__JC21443375(LEFT,RIGHT),TRANSFORM(B_Property_Event_3(__in,__cfg_Local).__ST162275_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE21443707 := __EE21443705;
  EXPORT Res3 := __UNWRAP(__EE21443707);
  SHARED __EE21444479 := __ENH_Person;
  SHARED __EE21444468 := __E_Person_Address;
  SHARED __EE21446254 := __EE21444468(__NN(__EE21444468.Location_) AND __NN(__EE21444468.Subject_));
  SHARED __EE21444462 := __E_Address;
  SHARED __EE21447089 := __EE21444462(__T(__OP2(__EE21444462.UID,=,__CN(__PAddressUID))));
  __JC21447095(E_Person_Address(__in,__cfg_Local).Layout __EE21446254, E_Address(__in,__cfg_Local).Layout __EE21447089) := __EEQP(__EE21447089.UID,__EE21446254.Location_);
  SHARED __EE21447142 := JOIN(__EE21446254,__EE21447089,__JC21447095(LEFT,RIGHT),TRANSFORM(E_Person_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC21447148(B_Person(__in,__cfg_Local).__ST118344_Layout __EE21444479, E_Person_Address(__in,__cfg_Local).Layout __EE21447142) := __EEQP(__EE21447142.Subject_,__EE21444479.UID);
  SHARED __EE21447906 := JOIN(__EE21444479,__EE21447142,__JC21447148(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST118344_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE21447908 := __EE21447906;
  EXPORT Res4 := __UNWRAP(__EE21447908);
  SHARED __EE21449851 := __ENH_Business_Prox;
  SHARED __EE21449840 := __E_Prox_Address;
  SHARED __EE21450619 := __EE21449840(__NN(__EE21449840.Location_) AND __NN(__EE21449840.Business_Location_));
  SHARED __EE21449834 := __E_Address;
  SHARED __EE21450965 := __EE21449834(__T(__OP2(__EE21449834.UID,=,__CN(__PAddressUID))));
  __JC21450971(E_Prox_Address(__in,__cfg_Local).Layout __EE21450619, E_Address(__in,__cfg_Local).Layout __EE21450965) := __EEQP(__EE21450965.UID,__EE21450619.Location_);
  SHARED __EE21451027 := JOIN(__EE21450619,__EE21450965,__JC21450971(LEFT,RIGHT),TRANSFORM(E_Prox_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC21451033(B_Business_Prox(__in,__cfg_Local).__ST89340_Layout __EE21449851, E_Prox_Address(__in,__cfg_Local).Layout __EE21451027) := __EEQP(__EE21451027.Business_Location_,__EE21449851.UID);
  SHARED __EE21451293 := JOIN(__EE21449851,__EE21451027,__JC21451033(LEFT,RIGHT),TRANSFORM(B_Business_Prox(__in,__cfg_Local).__ST89340_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE21451295 := __EE21451293;
  EXPORT Res5 := __UNWRAP(__EE21451295);
  SHARED __EE21451998 := __ENH_Business_Sele;
  SHARED __EE21451987 := __E_Sele_Address;
  SHARED __EE21455281 := __EE21451987(__NN(__EE21451987.Location_) AND __NN(__EE21451987.Legal_));
  SHARED __EE21451981 := __E_Address;
  SHARED __EE21456846 := __EE21451981(__T(__OP2(__EE21451981.UID,=,__CN(__PAddressUID))));
  __JC21456852(E_Sele_Address(__in,__cfg_Local).Layout __EE21455281, E_Address(__in,__cfg_Local).Layout __EE21456846) := __EEQP(__EE21456846.UID,__EE21455281.Location_);
  SHARED __EE21456908 := JOIN(__EE21455281,__EE21456846,__JC21456852(LEFT,RIGHT),TRANSFORM(E_Sele_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC21456914(B_Business_Sele(__in,__cfg_Local).__ST107005_Layout __EE21451998, E_Sele_Address(__in,__cfg_Local).Layout __EE21456908) := __EEQP(__EE21456908.Legal_,__EE21451998.UID);
  SHARED __EE21458393 := JOIN(__EE21451998,__EE21456908,__JC21456914(LEFT,RIGHT),TRANSFORM(B_Business_Sele(__in,__cfg_Local).__ST107005_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE21458395 := __EE21458393;
  EXPORT Res6 := __UNWRAP(__EE21458395);
  SHARED __EE26117963 := __E_T_I_N_Address;
  SHARED __EE26118126 := __EE26117963(__NN(__EE26117963.Tax_I_D_) AND __NN(__EE26117963.Location_));
  SHARED __EE26117957 := __E_Address;
  SHARED __EE26118173 := __EE26117957(__T(__OP2(__EE26117957.UID,=,__CN(__PAddressUID))));
  __JC26118179(E_T_I_N_Address(__in,__cfg_Local).Layout __EE26118126, E_Address(__in,__cfg_Local).Layout __EE26118173) := __EEQP(__EE26118173.UID,__EE26118126.Location_);
  SHARED __EE26118194 := JOIN(__EE26118126,__EE26118173,__JC26118179(LEFT,RIGHT),TRANSFORM(E_T_I_N_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE26118204 := PROJECT(TABLE(PROJECT(__EE26118194,TRANSFORM(E_T_I_N(__in,__cfg_Local).Layout,SELF.UID := LEFT.Tax_I_D_,SELF := LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),UID},UID,MERGE),E_T_I_N(__in,__cfg_Local).Layout);
  EXPORT Res7 := __UNWRAP(__EE26118204);
  SHARED __EE26118292 := __E_Utility;
  SHARED __EE26118282 := __E_Utility_Address;
  SHARED __EE26118447 := __EE26118282(__NN(__EE26118282.Location_) AND __NN(__EE26118282.Util_));
  SHARED __EE26118276 := __E_Address;
  SHARED __EE26118502 := __EE26118276(__T(__OP2(__EE26118276.UID,=,__CN(__PAddressUID))));
  __JC26118508(E_Utility_Address(__in,__cfg_Local).Layout __EE26118447, E_Address(__in,__cfg_Local).Layout __EE26118502) := __EEQP(__EE26118502.UID,__EE26118447.Location_);
  SHARED __EE26118522 := JOIN(__EE26118447,__EE26118502,__JC26118508(LEFT,RIGHT),TRANSFORM(E_Utility_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC26118528(E_Utility(__in,__cfg_Local).Layout __EE26118292, E_Utility_Address(__in,__cfg_Local).Layout __EE26118522) := __EEQP(__EE26118522.Util_,__EE26118292.UID);
  SHARED __EE26118539 := JOIN(__EE26118292,__EE26118522,__JC26118528(LEFT,RIGHT),TRANSFORM(E_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE26118541 := __EE26118539;
  EXPORT Res8 := __UNWRAP(__EE26118541);
  SHARED __EE26118667 := __ENH_Address;
  SHARED __EE26118656 := __E_Prox_Address;
  SHARED __EE26119158 := __EE26118656(__NN(__EE26118656.Business_Location_) AND __NN(__EE26118656.Location_));
  SHARED __EE26118650 := __ENH_Business_Prox;
  SHARED __EE26119367 := __EE26118650(__T(__OP2(__EE26118650.UID,=,__CN(__PBusinessProxUID))));
  __JC26119373(E_Prox_Address(__in,__cfg_Local).Layout __EE26119158, B_Business_Prox(__in,__cfg_Local).__ST89340_Layout __EE26119367) := __EEQP(__EE26119367.UID,__EE26119158.Business_Location_);
  SHARED __EE26119429 := JOIN(__EE26119158,__EE26119367,__JC26119373(LEFT,RIGHT),TRANSFORM(E_Prox_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC26119435(B_Address_1(__in,__cfg_Local).__ST120083_Layout __EE26118667, E_Prox_Address(__in,__cfg_Local).Layout __EE26119429) := __EEQP(__EE26119429.Location_,__EE26118667.UID);
  SHARED __EE26119558 := JOIN(__EE26118667,__EE26119429,__JC26119435(LEFT,RIGHT),TRANSFORM(B_Address_1(__in,__cfg_Local).__ST120083_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE26119560 := __EE26119558;
  EXPORT Res9 := __UNWRAP(__EE26119560);
  SHARED __EE26120023 := __ENH_Person;
  SHARED __EE26120012 := __E_Prox_Person;
  SHARED __EE26121759 := __EE26120012(__NN(__EE26120012.Business_Location_) AND __NN(__EE26120012.Contact_));
  SHARED __EE26120006 := __ENH_Business_Prox;
  SHARED __EE26122575 := __EE26120006(__T(__OP2(__EE26120006.UID,=,__CN(__PBusinessProxUID))));
  __JC26122581(E_Prox_Person(__in,__cfg_Local).Layout __EE26121759, B_Business_Prox(__in,__cfg_Local).__ST89340_Layout __EE26122575) := __EEQP(__EE26122575.UID,__EE26121759.Business_Location_);
  SHARED __EE26122609 := JOIN(__EE26121759,__EE26122575,__JC26122581(LEFT,RIGHT),TRANSFORM(E_Prox_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC26122615(B_Person(__in,__cfg_Local).__ST118344_Layout __EE26120023, E_Prox_Person(__in,__cfg_Local).Layout __EE26122609) := __EEQP(__EE26122609.Contact_,__EE26120023.UID);
  SHARED __EE26123373 := JOIN(__EE26120023,__EE26122609,__JC26122615(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST118344_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE26123375 := __EE26123373;
  EXPORT Res10 := __UNWRAP(__EE26123375);
  SHARED __EE26125344 := __E_Phone;
  SHARED __EE26125334 := __E_Prox_Phone_Number;
  SHARED __EE26125641 := __EE26125334(__NN(__EE26125334.Business_Location_) AND __NN(__EE26125334.Phone_Number_));
  SHARED __EE26125328 := __ENH_Business_Prox;
  SHARED __EE26125761 := __EE26125328(__T(__OP2(__EE26125328.UID,=,__CN(__PBusinessProxUID))));
  __JC26125767(E_Prox_Phone_Number(__in,__cfg_Local).Layout __EE26125641, B_Business_Prox(__in,__cfg_Local).__ST89340_Layout __EE26125761) := __EEQP(__EE26125761.UID,__EE26125641.Business_Location_);
  SHARED __EE26125804 := JOIN(__EE26125641,__EE26125761,__JC26125767(LEFT,RIGHT),TRANSFORM(E_Prox_Phone_Number(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC26125810(E_Phone(__in,__cfg_Local).Layout __EE26125344, E_Prox_Phone_Number(__in,__cfg_Local).Layout __EE26125804) := __EEQP(__EE26125804.Phone_Number_,__EE26125344.UID);
  SHARED __EE26125863 := JOIN(__EE26125344,__EE26125804,__JC26125810(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE26125865 := __EE26125863;
  EXPORT Res11 := __UNWRAP(__EE26125865);
  SHARED __EE26126141 := __E_Prox_T_I_N;
  SHARED __EE26126302 := __EE26126141(__NN(__EE26126141.Tax_I_D_) AND __NN(__EE26126141.Business_Location_));
  SHARED __EE26126135 := __ENH_Business_Prox;
  SHARED __EE26126348 := __EE26126135(__T(__OP2(__EE26126135.UID,=,__CN(__PBusinessProxUID))));
  __JC26126354(E_Prox_T_I_N(__in,__cfg_Local).Layout __EE26126302, B_Business_Prox(__in,__cfg_Local).__ST89340_Layout __EE26126348) := __EEQP(__EE26126348.UID,__EE26126302.Business_Location_);
  SHARED __EE26126368 := JOIN(__EE26126302,__EE26126348,__JC26126354(LEFT,RIGHT),TRANSFORM(E_Prox_T_I_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE26126378 := PROJECT(TABLE(PROJECT(__EE26126368,TRANSFORM(E_T_I_N(__in,__cfg_Local).Layout,SELF.UID := LEFT.Tax_I_D_,SELF := LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),UID},UID,MERGE),E_T_I_N(__in,__cfg_Local).Layout);
  EXPORT Res12 := __UNWRAP(__EE26126378);
  SHARED __EE26126475 := __E_Utility;
  SHARED __EE26126465 := __E_Prox_Utility;
  SHARED __EE26126625 := __EE26126465(__NN(__EE26126465.Business_Location_) AND __NN(__EE26126465.Util_));
  SHARED __EE26126459 := __ENH_Business_Prox;
  SHARED __EE26126677 := __EE26126459(__T(__OP2(__EE26126459.UID,=,__CN(__PBusinessProxUID))));
  __JC26126683(E_Prox_Utility(__in,__cfg_Local).Layout __EE26126625, B_Business_Prox(__in,__cfg_Local).__ST89340_Layout __EE26126677) := __EEQP(__EE26126677.UID,__EE26126625.Business_Location_);
  SHARED __EE26126694 := JOIN(__EE26126625,__EE26126677,__JC26126683(LEFT,RIGHT),TRANSFORM(E_Prox_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC26126700(E_Utility(__in,__cfg_Local).Layout __EE26126475, E_Prox_Utility(__in,__cfg_Local).Layout __EE26126694) := __EEQP(__EE26126694.Util_,__EE26126475.UID);
  SHARED __EE26126711 := JOIN(__EE26126475,__EE26126694,__JC26126700(LEFT,RIGHT),TRANSFORM(E_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE26126713 := __EE26126711;
  EXPORT Res13 := __UNWRAP(__EE26126713);
  SHARED __EE26126870 := __E_Email;
  SHARED __EE26126860 := __E_Prox_Email;
  SHARED __EE26127089 := __EE26126860(__NN(__EE26126860.Business_Location_) AND __NN(__EE26126860.Email_));
  SHARED __EE26126854 := __ENH_Business_Prox;
  SHARED __EE26127173 := __EE26126854(__T(__OP2(__EE26126854.UID,=,__CN(__PBusinessProxUID))));
  __JC26127179(E_Prox_Email(__in,__cfg_Local).Layout __EE26127089, B_Business_Prox(__in,__cfg_Local).__ST89340_Layout __EE26127173) := __EEQP(__EE26127173.UID,__EE26127089.Business_Location_);
  SHARED __EE26127198 := JOIN(__EE26127089,__EE26127173,__JC26127179(LEFT,RIGHT),TRANSFORM(E_Prox_Email(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC26127204(E_Email(__in,__cfg_Local).Layout __EE26126870, E_Prox_Email(__in,__cfg_Local).Layout __EE26127198) := __EEQP(__EE26127198.Email_,__EE26126870.UID);
  SHARED __EE26127239 := JOIN(__EE26126870,__EE26127198,__JC26127204(LEFT,RIGHT),TRANSFORM(E_Email(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE26127241 := __EE26127239;
  EXPORT Res14 := __UNWRAP(__EE26127241);
  SHARED __EE26127460 := __ENH_Business_Sele;
  SHARED __EE26127452 := __ENH_Business_Prox;
  SHARED __EE26132091 := __EE26127452(__T(__AND(__OP2(__EE26127452.UID,=,__CN(__PBusinessProxUID)),__CN(__NN(__EE26127452.Prox_Sele_)))));
  __JC26132097(B_Business_Sele(__in,__cfg_Local).__ST107005_Layout __EE26127460, B_Business_Prox(__in,__cfg_Local).__ST89340_Layout __EE26132091) := __EEQP(__EE26132091.Prox_Sele_,__EE26127460.UID);
  SHARED __EE26133576 := JOIN(__EE26127460,__EE26132091,__JC26132097(LEFT,RIGHT),TRANSFORM(B_Business_Sele(__in,__cfg_Local).__ST107005_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE26133578 := __EE26133576;
  EXPORT Res15 := __UNWRAP(__EE26133578);
  SHARED __EE30795043 := __E_Email;
  SHARED __EE30795033 := __E_Sele_Email;
  SHARED __EE30795260 := __EE30795033(__NN(__EE30795033.Legal_) AND __NN(__EE30795033.Email_));
  SHARED __EE30795027 := __ENH_Business_Sele;
  SHARED __EE30795343 := __EE30795027(__T(__OP2(__EE30795027.UID,=,__CN(__PBusinessSeleUID))));
  __JC30795349(E_Sele_Email(__in,__cfg_Local).Layout __EE30795260, B_Business_Sele(__in,__cfg_Local).__ST107005_Layout __EE30795343) := __EEQP(__EE30795343.UID,__EE30795260.Legal_);
  SHARED __EE30795367 := JOIN(__EE30795260,__EE30795343,__JC30795349(LEFT,RIGHT),TRANSFORM(E_Sele_Email(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC30795373(E_Email(__in,__cfg_Local).Layout __EE30795043, E_Sele_Email(__in,__cfg_Local).Layout __EE30795367) := __EEQP(__EE30795367.Email_,__EE30795043.UID);
  SHARED __EE30795408 := JOIN(__EE30795043,__EE30795367,__JC30795373(LEFT,RIGHT),TRANSFORM(E_Email(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE30795410 := __EE30795408;
  EXPORT Res16 := __UNWRAP(__EE30795410);
  SHARED __EE39722724 := __ENH_Address;
  SHARED __EE39722713 := __E_Sele_Address;
  SHARED __EE39723215 := __EE39722713(__NN(__EE39722713.Legal_) AND __NN(__EE39722713.Location_));
  SHARED __EE39722707 := __ENH_Business_Sele;
  SHARED __EE39723424 := __EE39722707(__T(__OP2(__EE39722707.UID,=,__CN(__PBusinessSeleUID))));
  __JC39723430(E_Sele_Address(__in,__cfg_Local).Layout __EE39723215, B_Business_Sele(__in,__cfg_Local).__ST107005_Layout __EE39723424) := __EEQP(__EE39723424.UID,__EE39723215.Legal_);
  SHARED __EE39723486 := JOIN(__EE39723215,__EE39723424,__JC39723430(LEFT,RIGHT),TRANSFORM(E_Sele_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC39723492(B_Address_1(__in,__cfg_Local).__ST120083_Layout __EE39722724, E_Sele_Address(__in,__cfg_Local).Layout __EE39723486) := __EEQP(__EE39723486.Location_,__EE39722724.UID);
  SHARED __EE39723615 := JOIN(__EE39722724,__EE39723486,__JC39723492(LEFT,RIGHT),TRANSFORM(B_Address_1(__in,__cfg_Local).__ST120083_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE39723617 := __EE39723615;
  EXPORT Res17 := __UNWRAP(__EE39723617);
  SHARED __EE48648767 := __E_Aircraft;
  SHARED __EE48648757 := __E_Sele_Aircraft;
  SHARED __EE48648955 := __EE48648757(__NN(__EE48648757.Legal_) AND __NN(__EE48648757.Plane_));
  SHARED __EE48648751 := __ENH_Business_Sele;
  SHARED __EE48649025 := __EE48648751(__T(__OP2(__EE48648751.UID,=,__CN(__PBusinessSeleUID))));
  __JC48649031(E_Sele_Aircraft(__in,__cfg_Local).Layout __EE48648955, B_Business_Sele(__in,__cfg_Local).__ST107005_Layout __EE48649025) := __EEQP(__EE48649025.UID,__EE48648955.Legal_);
  SHARED __EE48649048 := JOIN(__EE48648955,__EE48649025,__JC48649031(LEFT,RIGHT),TRANSFORM(E_Sele_Aircraft(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC48649054(E_Aircraft(__in,__cfg_Local).Layout __EE48648767, E_Sele_Aircraft(__in,__cfg_Local).Layout __EE48649048) := __EEQP(__EE48649048.Plane_,__EE48648767.UID);
  SHARED __EE48649077 := JOIN(__EE48648767,__EE48649048,__JC48649054(LEFT,RIGHT),TRANSFORM(E_Aircraft(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE48649079 := __EE48649077;
  EXPORT Res18 := __UNWRAP(__EE48649079);
  SHARED __EE57577683 := __ENH_Bankruptcy;
  SHARED __EE57577672 := __E_Sele_Bankruptcy;
  SHARED __EE57577983 := __EE57577672(__NN(__EE57577672.Legal_) AND __NN(__EE57577672.Bankrupt_));
  SHARED __EE57577666 := __ENH_Business_Sele;
  SHARED __EE57578109 := __EE57577666(__T(__OP2(__EE57577666.UID,=,__CN(__PBusinessSeleUID))));
  __JC57578115(E_Sele_Bankruptcy(__in,__cfg_Local).Layout __EE57577983, B_Business_Sele(__in,__cfg_Local).__ST107005_Layout __EE57578109) := __EEQP(__EE57578109.UID,__EE57577983.Legal_);
  SHARED __EE57578125 := JOIN(__EE57577983,__EE57578109,__JC57578115(LEFT,RIGHT),TRANSFORM(E_Sele_Bankruptcy(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC57578131(B_Bankruptcy(__in,__cfg_Local).__ST88857_Layout __EE57577683, E_Sele_Bankruptcy(__in,__cfg_Local).Layout __EE57578125) := __EEQP(__EE57578125.Bankrupt_,__EE57577683.UID);
  SHARED __EE57578217 := JOIN(__EE57577683,__EE57578125,__JC57578131(LEFT,RIGHT),TRANSFORM(B_Bankruptcy(__in,__cfg_Local).__ST88857_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE57578219 := __EE57578217;
  EXPORT Res19 := __UNWRAP(__EE57578219);
  SHARED __EE66506911 := __ENH_Lien_Judgment;
  SHARED __EE66506900 := __E_Sele_Lien_Judgment;
  SHARED __EE66507129 := __EE66506900(__NN(__EE66506900.Sele_) AND __NN(__EE66506900.Lien_));
  SHARED __EE66506894 := __ENH_Business_Sele;
  SHARED __EE66507214 := __EE66506894(__T(__OP2(__EE66506894.UID,=,__CN(__PBusinessSeleUID))));
  __JC66507220(E_Sele_Lien_Judgment(__in,__cfg_Local).Layout __EE66507129, B_Business_Sele(__in,__cfg_Local).__ST107005_Layout __EE66507214) := __EEQP(__EE66507214.UID,__EE66507129.Sele_);
  SHARED __EE66507236 := JOIN(__EE66507129,__EE66507214,__JC66507220(LEFT,RIGHT),TRANSFORM(E_Sele_Lien_Judgment(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC66507242(B_Lien_Judgment_12(__in,__cfg_Local).__ST186387_Layout __EE66506911, E_Sele_Lien_Judgment(__in,__cfg_Local).Layout __EE66507236) := __EEQP(__EE66507236.Lien_,__EE66506911.UID);
  SHARED __EE66507281 := JOIN(__EE66506911,__EE66507236,__JC66507242(LEFT,RIGHT),TRANSFORM(B_Lien_Judgment_12(__in,__cfg_Local).__ST186387_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE66507283 := __EE66507281;
  EXPORT Res20 := __UNWRAP(__EE66507283);
  SHARED __EE75434638 := __ENH_Person;
  SHARED __EE75434627 := __E_Sele_Person;
  SHARED __EE75436374 := __EE75434627(__NN(__EE75434627.Legal_) AND __NN(__EE75434627.Contact_));
  SHARED __EE75434621 := __ENH_Business_Sele;
  SHARED __EE75437190 := __EE75434621(__T(__OP2(__EE75434621.UID,=,__CN(__PBusinessSeleUID))));
  __JC75437196(E_Sele_Person(__in,__cfg_Local).Layout __EE75436374, B_Business_Sele(__in,__cfg_Local).__ST107005_Layout __EE75437190) := __EEQP(__EE75437190.UID,__EE75436374.Legal_);
  SHARED __EE75437224 := JOIN(__EE75436374,__EE75437190,__JC75437196(LEFT,RIGHT),TRANSFORM(E_Sele_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC75437230(B_Person(__in,__cfg_Local).__ST118344_Layout __EE75434638, E_Sele_Person(__in,__cfg_Local).Layout __EE75437224) := __EEQP(__EE75437224.Contact_,__EE75434638.UID);
  SHARED __EE75437988 := JOIN(__EE75434638,__EE75437224,__JC75437230(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST118344_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE75437990 := __EE75437988;
  EXPORT Res21 := __UNWRAP(__EE75437990);
  SHARED __EE84367372 := __E_Phone;
  SHARED __EE84367362 := __E_Sele_Phone_Number;
  SHARED __EE84367669 := __EE84367362(__NN(__EE84367362.Legal_) AND __NN(__EE84367362.Phone_Number_));
  SHARED __EE84367356 := __ENH_Business_Sele;
  SHARED __EE84367789 := __EE84367356(__T(__OP2(__EE84367356.UID,=,__CN(__PBusinessSeleUID))));
  __JC84367795(E_Sele_Phone_Number(__in,__cfg_Local).Layout __EE84367669, B_Business_Sele(__in,__cfg_Local).__ST107005_Layout __EE84367789) := __EEQP(__EE84367789.UID,__EE84367669.Legal_);
  SHARED __EE84367832 := JOIN(__EE84367669,__EE84367789,__JC84367795(LEFT,RIGHT),TRANSFORM(E_Sele_Phone_Number(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC84367838(E_Phone(__in,__cfg_Local).Layout __EE84367372, E_Sele_Phone_Number(__in,__cfg_Local).Layout __EE84367832) := __EEQP(__EE84367832.Phone_Number_,__EE84367372.UID);
  SHARED __EE84367891 := JOIN(__EE84367372,__EE84367832,__JC84367838(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE84367893 := __EE84367891;
  EXPORT Res22 := __UNWRAP(__EE84367893);
  SHARED __EE93296801 := __E_Property;
  SHARED __EE93296791 := __E_Sele_Property;
  SHARED __EE93297036 := __EE93296791(__NN(__EE93296791.Legal_) AND __NN(__EE93296791.Prop_));
  SHARED __EE93296785 := __ENH_Business_Sele;
  SHARED __EE93297129 := __EE93296785(__T(__OP2(__EE93296785.UID,=,__CN(__PBusinessSeleUID))));
  __JC93297135(E_Sele_Property(__in,__cfg_Local).Layout __EE93297036, B_Business_Sele(__in,__cfg_Local).__ST107005_Layout __EE93297129) := __EEQP(__EE93297129.UID,__EE93297036.Legal_);
  SHARED __EE93297163 := JOIN(__EE93297036,__EE93297129,__JC93297135(LEFT,RIGHT),TRANSFORM(E_Sele_Property(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC93297169(E_Property(__in,__cfg_Local).Layout __EE93296801, E_Sele_Property(__in,__cfg_Local).Layout __EE93297163) := __EEQP(__EE93297163.Prop_,__EE93296801.UID);
  SHARED __EE93297204 := JOIN(__EE93296801,__EE93297163,__JC93297169(LEFT,RIGHT),TRANSFORM(E_Property(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE93297206 := __EE93297204;
  EXPORT Res23 := __UNWRAP(__EE93297206);
  SHARED __EE102228788 := __ENH_Property_Event;
  SHARED __EE102228777 := __E_Sele_Property_Event;
  SHARED __EE102229601 := __EE102228777(__NN(__EE102228777.Legal_) AND __NN(__EE102228777.Event_));
  SHARED __EE102228771 := __ENH_Business_Sele;
  SHARED __EE102229984 := __EE102228771(__T(__OP2(__EE102228771.UID,=,__CN(__PBusinessSeleUID))));
  __JC102229990(E_Sele_Property_Event(__in,__cfg_Local).Layout __EE102229601, B_Business_Sele(__in,__cfg_Local).__ST107005_Layout __EE102229984) := __EEQP(__EE102229984.UID,__EE102229601.Legal_);
  SHARED __EE102230013 := JOIN(__EE102229601,__EE102229984,__JC102229990(LEFT,RIGHT),TRANSFORM(E_Sele_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC102230019(B_Property_Event_3(__in,__cfg_Local).__ST162275_Layout __EE102228788, E_Sele_Property_Event(__in,__cfg_Local).Layout __EE102230013) := __EEQP(__EE102230013.Event_,__EE102228788.UID);
  SHARED __EE102230349 := JOIN(__EE102228788,__EE102230013,__JC102230019(LEFT,RIGHT),TRANSFORM(B_Property_Event_3(__in,__cfg_Local).__ST162275_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE102230351 := __EE102230349;
  EXPORT Res24 := __UNWRAP(__EE102230351);
  SHARED __EE111159659 := __E_Sele_T_I_N;
  SHARED __EE111159818 := __EE111159659(__NN(__EE111159659.Tax_I_D_) AND __NN(__EE111159659.Legal_));
  SHARED __EE111159653 := __ENH_Business_Sele;
  SHARED __EE111159863 := __EE111159653(__T(__OP2(__EE111159653.UID,=,__CN(__PBusinessSeleUID))));
  __JC111159869(E_Sele_T_I_N(__in,__cfg_Local).Layout __EE111159818, B_Business_Sele(__in,__cfg_Local).__ST107005_Layout __EE111159863) := __EEQP(__EE111159863.UID,__EE111159818.Legal_);
  SHARED __EE111159882 := JOIN(__EE111159818,__EE111159863,__JC111159869(LEFT,RIGHT),TRANSFORM(E_Sele_T_I_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE111159892 := PROJECT(TABLE(PROJECT(__EE111159882,TRANSFORM(E_T_I_N(__in,__cfg_Local).Layout,SELF.UID := LEFT.Tax_I_D_,SELF := LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),UID},UID,MERGE),E_T_I_N(__in,__cfg_Local).Layout);
  EXPORT Res25 := __UNWRAP(__EE111159892);
  SHARED __EE117955536 := __ENH_Tradeline;
  SHARED __EE117955525 := __E_Sele_Tradeline;
  SHARED __EE117955799 := __EE117955525(__NN(__EE117955525.Legal_) AND __NN(__EE117955525.Account_));
  SHARED __EE117955519 := __ENH_Business_Sele;
  SHARED __EE117955907 := __EE117955519(__T(__OP2(__EE117955519.UID,=,__CN(__PBusinessSeleUID))));
  __JC117955913(E_Sele_Tradeline(__in,__cfg_Local).Layout __EE117955799, B_Business_Sele(__in,__cfg_Local).__ST107005_Layout __EE117955907) := __EEQP(__EE117955907.UID,__EE117955799.Legal_);
  SHARED __EE117955920 := JOIN(__EE117955799,__EE117955907,__JC117955913(LEFT,RIGHT),TRANSFORM(E_Sele_Tradeline(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC117955926(B_Tradeline(__in,__cfg_Local).__ST119790_Layout __EE117955536, E_Sele_Tradeline(__in,__cfg_Local).Layout __EE117955920) := __EEQP(__EE117955920.Account_,__EE117955536.UID);
  SHARED __EE117955997 := JOIN(__EE117955536,__EE117955920,__JC117955926(LEFT,RIGHT),TRANSFORM(B_Tradeline(__in,__cfg_Local).__ST119790_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE117955999 := __EE117955997;
  EXPORT Res26 := __UNWRAP(__EE117955999);
  SHARED __EE126885974 := __ENH_U_C_C;
  SHARED __EE126885963 := __E_Sele_U_C_C;
  SHARED __EE126886229 := __EE126885963(__NN(__EE126885963.Legal_) AND __NN(__EE126885963.Filing_));
  SHARED __EE126885957 := __ENH_Business_Sele;
  SHARED __EE126886332 := __EE126885957(__T(__OP2(__EE126885957.UID,=,__CN(__PBusinessSeleUID))));
  __JC126886338(E_Sele_U_C_C(__in,__cfg_Local).Layout __EE126886229, B_Business_Sele(__in,__cfg_Local).__ST107005_Layout __EE126886332) := __EEQP(__EE126886332.UID,__EE126886229.Legal_);
  SHARED __EE126886353 := JOIN(__EE126886229,__EE126886332,__JC126886338(LEFT,RIGHT),TRANSFORM(E_Sele_U_C_C(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC126886359(B_U_C_C(__in,__cfg_Local).__ST119993_Layout __EE126885974, E_Sele_U_C_C(__in,__cfg_Local).Layout __EE126886353) := __EEQP(__EE126886353.Filing_,__EE126885974.UID);
  SHARED __EE126886417 := JOIN(__EE126885974,__EE126886353,__JC126886359(LEFT,RIGHT),TRANSFORM(B_U_C_C(__in,__cfg_Local).__ST119993_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE126886419 := __EE126886417;
  EXPORT Res27 := __UNWRAP(__EE126886419);
  SHARED __EE135815339 := __E_Utility;
  SHARED __EE135815329 := __E_Sele_Utility;
  SHARED __EE135815489 := __EE135815329(__NN(__EE135815329.Legal_) AND __NN(__EE135815329.Util_));
  SHARED __EE135815323 := __ENH_Business_Sele;
  SHARED __EE135815541 := __EE135815323(__T(__OP2(__EE135815323.UID,=,__CN(__PBusinessSeleUID))));
  __JC135815547(E_Sele_Utility(__in,__cfg_Local).Layout __EE135815489, B_Business_Sele(__in,__cfg_Local).__ST107005_Layout __EE135815541) := __EEQP(__EE135815541.UID,__EE135815489.Legal_);
  SHARED __EE135815558 := JOIN(__EE135815489,__EE135815541,__JC135815547(LEFT,RIGHT),TRANSFORM(E_Sele_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC135815564(E_Utility(__in,__cfg_Local).Layout __EE135815339, E_Sele_Utility(__in,__cfg_Local).Layout __EE135815558) := __EEQP(__EE135815558.Util_,__EE135815339.UID);
  SHARED __EE135815575 := JOIN(__EE135815339,__EE135815558,__JC135815564(LEFT,RIGHT),TRANSFORM(E_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE135815577 := __EE135815575;
  EXPORT Res28 := __UNWRAP(__EE135815577);
  SHARED __EE144744241 := __E_Vehicle;
  SHARED __EE144744231 := __E_Sele_Vehicle;
  SHARED __EE144744672 := __EE144744231(__NN(__EE144744231.Legal_) AND __NN(__EE144744231.Automobile_));
  SHARED __EE144744225 := __ENH_Business_Sele;
  SHARED __EE144744863 := __EE144744225(__T(__OP2(__EE144744225.UID,=,__CN(__PBusinessSeleUID))));
  __JC144744869(E_Sele_Vehicle(__in,__cfg_Local).Layout __EE144744672, B_Business_Sele(__in,__cfg_Local).__ST107005_Layout __EE144744863) := __EEQP(__EE144744863.UID,__EE144744672.Legal_);
  SHARED __EE144744919 := JOIN(__EE144744672,__EE144744863,__JC144744869(LEFT,RIGHT),TRANSFORM(E_Sele_Vehicle(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC144744925(E_Vehicle(__in,__cfg_Local).Layout __EE144744241, E_Sele_Vehicle(__in,__cfg_Local).Layout __EE144744919) := __EEQP(__EE144744919.Automobile_,__EE144744241.UID);
  SHARED __EE144745036 := JOIN(__EE144744241,__EE144744919,__JC144744925(LEFT,RIGHT),TRANSFORM(E_Vehicle(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE144745038 := __EE144745036;
  EXPORT Res29 := __UNWRAP(__EE144745038);
  SHARED __EE153675861 := __E_Watercraft;
  SHARED __EE153675851 := __E_Sele_Watercraft;
  SHARED __EE153676011 := __EE153675851(__NN(__EE153675851.Legal_) AND __NN(__EE153675851.W_Craft_));
  SHARED __EE153675845 := __ENH_Business_Sele;
  SHARED __EE153676063 := __EE153675845(__T(__OP2(__EE153675845.UID,=,__CN(__PBusinessSeleUID))));
  __JC153676069(E_Sele_Watercraft(__in,__cfg_Local).Layout __EE153676011, B_Business_Sele(__in,__cfg_Local).__ST107005_Layout __EE153676063) := __EEQP(__EE153676063.UID,__EE153676011.Legal_);
  SHARED __EE153676080 := JOIN(__EE153676011,__EE153676063,__JC153676069(LEFT,RIGHT),TRANSFORM(E_Sele_Watercraft(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC153676086(E_Watercraft(__in,__cfg_Local).Layout __EE153675861, E_Sele_Watercraft(__in,__cfg_Local).Layout __EE153676080) := __EEQP(__EE153676080.W_Craft_,__EE153675861.UID);
  SHARED __EE153676097 := JOIN(__EE153675861,__EE153676080,__JC153676086(LEFT,RIGHT),TRANSFORM(E_Watercraft(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE153676099 := __EE153676097;
  EXPORT Res30 := __UNWRAP(__EE153676099);
  SHARED __EE162603515 := __ENH_Business_Prox;
  SHARED __EE162604113 := __EE162603515(__NN(__EE162603515.Prox_Sele_));
  SHARED __EE162603508 := __ENH_Business_Sele;
  SHARED __EE162604118 := __EE162603508(__T(__OP2(__EE162603508.UID,=,__CN(__PBusinessSeleUID))));
  __JC162604124(B_Business_Prox(__in,__cfg_Local).__ST89340_Layout __EE162604113, B_Business_Sele(__in,__cfg_Local).__ST107005_Layout __EE162604118) := __EEQP(__EE162604118.UID,__EE162604113.Prox_Sele_);
  SHARED __EE162604384 := JOIN(__EE162604113,__EE162604118,__JC162604124(LEFT,RIGHT),TRANSFORM(B_Business_Prox(__in,__cfg_Local).__ST89340_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE162604386 := __EE162604384;
  EXPORT Res31 := __UNWRAP(__EE162604386);
  SHARED __EE169402210 := __ENH_Criminal_Offense;
  SHARED __EE169402199 := __E_Criminal_Details;
  SHARED __EE169402502 := __EE169402199(__NN(__EE169402199.Offender_) AND __NN(__EE169402199.Offense_));
  SHARED __EE169402193 := __E_Criminal_Offender;
  SHARED __EE169402623 := __EE169402193(__T(__OP2(__EE169402193.UID,=,__CN(__PCriminalOffenderUID))));
  __JC169402629(E_Criminal_Details(__in,__cfg_Local).Layout __EE169402502, E_Criminal_Offender(__in,__cfg_Local).Layout __EE169402623) := __EEQP(__EE169402623.UID,__EE169402502.Offender_);
  SHARED __EE169402637 := JOIN(__EE169402502,__EE169402623,__JC169402629(LEFT,RIGHT),TRANSFORM(E_Criminal_Details(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC169402643(B_Criminal_Offense(__in,__cfg_Local).__ST108406_Layout __EE169402210, E_Criminal_Details(__in,__cfg_Local).Layout __EE169402637) := __EEQP(__EE169402637.Offense_,__EE169402210.UID);
  SHARED __EE169402726 := JOIN(__EE169402210,__EE169402637,__JC169402643(LEFT,RIGHT),TRANSFORM(B_Criminal_Offense(__in,__cfg_Local).__ST108406_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE169402728 := __EE169402726;
  EXPORT Res32 := __UNWRAP(__EE169402728);
  SHARED __EE169402976 := __E_Criminal_Punishment;
  SHARED __EE169402966 := __E_Criminal_Details;
  SHARED __EE169403208 := __EE169402966(__NN(__EE169402966.Offender_) AND __NN(__EE169402966.Punishment_));
  SHARED __EE169402960 := __E_Criminal_Offender;
  SHARED __EE169403300 := __EE169402960(__T(__OP2(__EE169402960.UID,=,__CN(__PCriminalOffenderUID))));
  __JC169403306(E_Criminal_Details(__in,__cfg_Local).Layout __EE169403208, E_Criminal_Offender(__in,__cfg_Local).Layout __EE169403300) := __EEQP(__EE169403300.UID,__EE169403208.Offender_);
  SHARED __EE169403314 := JOIN(__EE169403208,__EE169403300,__JC169403306(LEFT,RIGHT),TRANSFORM(E_Criminal_Details(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC169403320(E_Criminal_Punishment(__in,__cfg_Local).Layout __EE169402976, E_Criminal_Details(__in,__cfg_Local).Layout __EE169403314) := __EEQP(__EE169403314.Punishment_,__EE169402976.UID);
  SHARED __EE169403374 := JOIN(__EE169402976,__EE169403314,__JC169403320(LEFT,RIGHT),TRANSFORM(E_Criminal_Punishment(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE169403376 := __EE169403374;
  EXPORT Res33 := __UNWRAP(__EE169403376);
  SHARED __EE169403553 := __E_First_Degree_Associations;
  SHARED __EE169403629 := __EE169403553(__NN(__EE169403553.Subject_));
  SHARED __EE169403547 := __ENH_Person;
  SHARED __EE169403634 := __EE169403547(__T(__OP2(__EE169403547.UID,=,__CN(__PPersonUID))));
  __JC169403640(E_First_Degree_Associations(__in,__cfg_Local).Layout __EE169403629, B_Person(__in,__cfg_Local).__ST118344_Layout __EE169403634) := __EEQP(__EE169403634.UID,__EE169403629.Subject_);
  SHARED __EE169403652 := JOIN(__EE169403629,__EE169403634,__JC169403640(LEFT,RIGHT),TRANSFORM(E_First_Degree_Associations(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE169403654 := __EE169403652;
  EXPORT Res34 := __UNWRAP(__EE169403654);
  SHARED __EE169405168 := __ENH_First_Degree_Relative;
  SHARED __EE169405244 := __EE169405168(__NN(__EE169405168.Subject_));
  SHARED __EE169405161 := __ENH_Person;
  SHARED __EE169405249 := __EE169405161(__T(__OP2(__EE169405161.UID,=,__CN(__PPersonUID))));
  __JC169405255(B_First_Degree_Relative(__in,__cfg_Local).__ST4275475_Layout __EE169405244, B_Person(__in,__cfg_Local).__ST118344_Layout __EE169405249) := __EEQP(__EE169405249.UID,__EE169405244.Subject_);
  SHARED __EE169405267 := JOIN(__EE169405244,__EE169405249,__JC169405255(LEFT,RIGHT),TRANSFORM(B_First_Degree_Relative(__in,__cfg_Local).__ST4275475_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE169405269 := __EE169405267;
  EXPORT Res35 := __UNWRAP(__EE169405269);
  SHARED __EE169406803 := __E_Phone;
  SHARED __EE169406793 := __E_House_Hold_Phone;
  SHARED __EE169407074 := __EE169406793(__NN(__EE169406793.Household_) AND __NN(__EE169406793.Phone_Number_));
  SHARED __EE169406787 := __E_Household;
  SHARED __EE169407183 := __EE169406787(__T(__OP2(__EE169406787.UID,=,__CN(__PHouseholdUID))));
  __JC169407189(E_House_Hold_Phone(__in,__cfg_Local).Layout __EE169407074, E_Household(__in,__cfg_Local).Layout __EE169407183) := __EEQP(__EE169407183.UID,__EE169407074.Household_);
  SHARED __EE169407215 := JOIN(__EE169407074,__EE169407183,__JC169407189(LEFT,RIGHT),TRANSFORM(E_House_Hold_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC169407221(E_Phone(__in,__cfg_Local).Layout __EE169406803, E_House_Hold_Phone(__in,__cfg_Local).Layout __EE169407215) := __EEQP(__EE169407215.Phone_Number_,__EE169406803.UID);
  SHARED __EE169407274 := JOIN(__EE169406803,__EE169407215,__JC169407221(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE169407276 := __EE169407274;
  EXPORT Res36 := __UNWRAP(__EE169407276);
  SHARED __EE169407518 := __ENH_Person;
  SHARED __EE169407507 := __E_Household_Member;
  SHARED __EE169409213 := __EE169407507(__NN(__EE169407507.Household_) AND __NN(__EE169407507.Subject_));
  SHARED __EE169407501 := __E_Household;
  SHARED __EE169410009 := __EE169407501(__T(__OP2(__EE169407501.UID,=,__CN(__PHouseholdUID))));
  __JC169410015(E_Household_Member(__in,__cfg_Local).Layout __EE169409213, E_Household(__in,__cfg_Local).Layout __EE169410009) := __EEQP(__EE169410009.UID,__EE169409213.Household_);
  SHARED __EE169410023 := JOIN(__EE169409213,__EE169410009,__JC169410015(LEFT,RIGHT),TRANSFORM(E_Household_Member(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC169410029(B_Person(__in,__cfg_Local).__ST118344_Layout __EE169407518, E_Household_Member(__in,__cfg_Local).Layout __EE169410023) := __EEQP(__EE169410023.Subject_,__EE169407518.UID);
  SHARED __EE169410787 := JOIN(__EE169407518,__EE169410023,__JC169410029(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST118344_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE169410789 := __EE169410787;
  EXPORT Res37 := __UNWRAP(__EE169410789);
  SHARED __EE169412659 := __E_Aircraft;
  SHARED __EE169412649 := __E_Aircraft_Owner;
  SHARED __EE169412832 := __EE169412649(__NN(__EE169412649.Owner_) AND __NN(__EE169412649.Plane_));
  SHARED __EE169412643 := __ENH_Person;
  SHARED __EE169412895 := __EE169412643(__T(__OP2(__EE169412643.UID,=,__CN(__PPersonUID))));
  __JC169412901(E_Aircraft_Owner(__in,__cfg_Local).Layout __EE169412832, B_Person(__in,__cfg_Local).__ST118344_Layout __EE169412895) := __EEQP(__EE169412895.UID,__EE169412832.Owner_);
  SHARED __EE169412911 := JOIN(__EE169412832,__EE169412895,__JC169412901(LEFT,RIGHT),TRANSFORM(E_Aircraft_Owner(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC169412917(E_Aircraft(__in,__cfg_Local).Layout __EE169412659, E_Aircraft_Owner(__in,__cfg_Local).Layout __EE169412911) := __EEQP(__EE169412911.Plane_,__EE169412659.UID);
  SHARED __EE169412940 := JOIN(__EE169412659,__EE169412911,__JC169412917(LEFT,RIGHT),TRANSFORM(E_Aircraft(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE169412942 := __EE169412940;
  EXPORT Res38 := __UNWRAP(__EE169412942);
  SHARED __EE169415714 := __E_Employment;
  SHARED __EE169415704 := __E_Employment_Person;
  SHARED __EE169415855 := __EE169415704(__NN(__EE169415704.Subject_) AND __NN(__EE169415704.Emp_));
  SHARED __EE169415698 := __ENH_Person;
  SHARED __EE169415903 := __EE169415698(__T(__OP2(__EE169415698.UID,=,__CN(__PPersonUID))));
  __JC169415909(E_Employment_Person(__in,__cfg_Local).Layout __EE169415855, B_Person(__in,__cfg_Local).__ST118344_Layout __EE169415903) := __EEQP(__EE169415903.UID,__EE169415855.Subject_);
  SHARED __EE169415916 := JOIN(__EE169415855,__EE169415903,__JC169415909(LEFT,RIGHT),TRANSFORM(E_Employment_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC169415922(E_Employment(__in,__cfg_Local).Layout __EE169415714, E_Employment_Person(__in,__cfg_Local).Layout __EE169415916) := __EEQP(__EE169415916.Emp_,__EE169415714.UID);
  SHARED __EE169415933 := JOIN(__EE169415714,__EE169415916,__JC169415922(LEFT,RIGHT),TRANSFORM(E_Employment(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE169415935 := __EE169415933;
  EXPORT Res39 := __UNWRAP(__EE169415935);
  SHARED __EE169418682 := __E_Household;
  SHARED __EE169418672 := __E_Household_Member;
  SHARED __EE169418815 := __EE169418672(__NN(__EE169418672.Subject_) AND __NN(__EE169418672.Household_));
  SHARED __EE169418666 := __ENH_Person;
  SHARED __EE169418859 := __EE169418666(__T(__OP2(__EE169418666.UID,=,__CN(__PPersonUID))));
  __JC169418865(E_Household_Member(__in,__cfg_Local).Layout __EE169418815, B_Person(__in,__cfg_Local).__ST118344_Layout __EE169418859) := __EEQP(__EE169418859.UID,__EE169418815.Subject_);
  SHARED __EE169418873 := JOIN(__EE169418815,__EE169418859,__JC169418865(LEFT,RIGHT),TRANSFORM(E_Household_Member(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC169418879(E_Household(__in,__cfg_Local).Layout __EE169418682, E_Household_Member(__in,__cfg_Local).Layout __EE169418873) := __EEQP(__EE169418873.Household_,__EE169418682.UID);
  SHARED __EE169418885 := JOIN(__EE169418682,__EE169418873,__JC169418879(LEFT,RIGHT),TRANSFORM(E_Household(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE169418887 := __EE169418885;
  EXPORT Res40 := __UNWRAP(__EE169418887);
  SHARED __EE169421621 := __E_Accident;
  SHARED __EE169421611 := __E_Person_Accident;
  SHARED __EE169421875 := __EE169421611(__NN(__EE169421611.Subject_) AND __NN(__EE169421611.Acc_));
  SHARED __EE169421605 := __ENH_Person;
  SHARED __EE169421979 := __EE169421605(__T(__OP2(__EE169421605.UID,=,__CN(__PPersonUID))));
  __JC169421985(E_Person_Accident(__in,__cfg_Local).Layout __EE169421875, B_Person(__in,__cfg_Local).__ST118344_Layout __EE169421979) := __EEQP(__EE169421979.UID,__EE169421875.Subject_);
  SHARED __EE169422033 := JOIN(__EE169421875,__EE169421979,__JC169421985(LEFT,RIGHT),TRANSFORM(E_Person_Accident(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC169422039(E_Accident(__in,__cfg_Local).Layout __EE169421621, E_Person_Accident(__in,__cfg_Local).Layout __EE169422033) := __EEQP(__EE169422033.Acc_,__EE169421621.UID);
  SHARED __EE169422065 := JOIN(__EE169421621,__EE169422033,__JC169422039(LEFT,RIGHT),TRANSFORM(E_Accident(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE169422067 := __EE169422065;
  EXPORT Res41 := __UNWRAP(__EE169422067);
  SHARED __EE169424968 := __ENH_Address;
  SHARED __EE169424957 := __E_Person_Address;
  SHARED __EE169425437 := __EE169424957(__NN(__EE169424957.Subject_) AND __NN(__EE169424957.Location_));
  SHARED __EE169424951 := __ENH_Person;
  SHARED __EE169425637 := __EE169424951(__T(__OP2(__EE169424951.UID,=,__CN(__PPersonUID))));
  __JC169425643(E_Person_Address(__in,__cfg_Local).Layout __EE169425437, B_Person(__in,__cfg_Local).__ST118344_Layout __EE169425637) := __EEQP(__EE169425637.UID,__EE169425437.Subject_);
  SHARED __EE169425690 := JOIN(__EE169425437,__EE169425637,__JC169425643(LEFT,RIGHT),TRANSFORM(E_Person_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC169425696(B_Address_1(__in,__cfg_Local).__ST120083_Layout __EE169424968, E_Person_Address(__in,__cfg_Local).Layout __EE169425690) := __EEQP(__EE169425690.Location_,__EE169424968.UID);
  SHARED __EE169425819 := JOIN(__EE169424968,__EE169425690,__JC169425696(LEFT,RIGHT),TRANSFORM(B_Address_1(__in,__cfg_Local).__ST120083_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE169425821 := __EE169425819;
  EXPORT Res42 := __UNWRAP(__EE169425821);
  SHARED __EE169428866 := __ENH_Bankruptcy;
  SHARED __EE169428855 := __E_Person_Bankruptcy;
  SHARED __EE169429160 := __EE169428855(__NN(__EE169428855.Subject_) AND __NN(__EE169428855.Bankrupt_));
  SHARED __EE169428849 := __ENH_Person;
  SHARED __EE169429283 := __EE169428849(__T(__OP2(__EE169428849.UID,=,__CN(__PPersonUID))));
  __JC169429289(E_Person_Bankruptcy(__in,__cfg_Local).Layout __EE169429160, B_Person(__in,__cfg_Local).__ST118344_Layout __EE169429283) := __EEQP(__EE169429283.UID,__EE169429160.Subject_);
  SHARED __EE169429296 := JOIN(__EE169429160,__EE169429283,__JC169429289(LEFT,RIGHT),TRANSFORM(E_Person_Bankruptcy(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC169429302(B_Bankruptcy(__in,__cfg_Local).__ST88857_Layout __EE169428866, E_Person_Bankruptcy(__in,__cfg_Local).Layout __EE169429296) := __EEQP(__EE169429296.Bankrupt_,__EE169428866.UID);
  SHARED __EE169429388 := JOIN(__EE169428866,__EE169429296,__JC169429302(LEFT,RIGHT),TRANSFORM(B_Bankruptcy(__in,__cfg_Local).__ST88857_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE169429390 := __EE169429388;
  EXPORT Res43 := __UNWRAP(__EE169429390);
  SHARED __EE169432282 := __E_Drivers_License;
  SHARED __EE169432272 := __E_Person_Drivers_License;
  SHARED __EE169432518 := __EE169432272(__NN(__EE169432272.Subject_) AND __NN(__EE169432272.License_));
  SHARED __EE169432266 := __ENH_Person;
  SHARED __EE169432612 := __EE169432266(__T(__OP2(__EE169432266.UID,=,__CN(__PPersonUID))));
  __JC169432618(E_Person_Drivers_License(__in,__cfg_Local).Layout __EE169432518, B_Person(__in,__cfg_Local).__ST118344_Layout __EE169432612) := __EEQP(__EE169432612.UID,__EE169432518.Subject_);
  SHARED __EE169432625 := JOIN(__EE169432518,__EE169432612,__JC169432618(LEFT,RIGHT),TRANSFORM(E_Person_Drivers_License(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC169432631(E_Drivers_License(__in,__cfg_Local).Layout __EE169432282, E_Person_Drivers_License(__in,__cfg_Local).Layout __EE169432625) := __EEQP(__EE169432625.License_,__EE169432282.UID);
  SHARED __EE169432688 := JOIN(__EE169432282,__EE169432625,__JC169432631(LEFT,RIGHT),TRANSFORM(E_Drivers_License(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE169432690 := __EE169432688;
  EXPORT Res44 := __UNWRAP(__EE169432690);
  SHARED __EE169435530 := __ENH_Education;
  SHARED __EE169435519 := __E_Person_Education;
  SHARED __EE169435718 := __EE169435519(__NN(__EE169435519.Subject_) AND __NN(__EE169435519.Edu_));
  SHARED __EE169435513 := __ENH_Person;
  SHARED __EE169435789 := __EE169435513(__T(__OP2(__EE169435513.UID,=,__CN(__PPersonUID))));
  __JC169435795(E_Person_Education(__in,__cfg_Local).Layout __EE169435718, B_Person(__in,__cfg_Local).__ST118344_Layout __EE169435789) := __EEQP(__EE169435789.UID,__EE169435718.Subject_);
  SHARED __EE169435813 := JOIN(__EE169435718,__EE169435789,__JC169435795(LEFT,RIGHT),TRANSFORM(E_Person_Education(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC169435819(B_Education_2(__in,__cfg_Local).__ST147723_Layout __EE169435530, E_Person_Education(__in,__cfg_Local).Layout __EE169435813) := __EEQP(__EE169435813.Edu_,__EE169435530.UID);
  SHARED __EE169435842 := JOIN(__EE169435530,__EE169435813,__JC169435819(LEFT,RIGHT),TRANSFORM(B_Education_2(__in,__cfg_Local).__ST147723_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE169435844 := __EE169435842;
  EXPORT Res45 := __UNWRAP(__EE169435844);
  SHARED __EE169438632 := __E_Email;
  SHARED __EE169438622 := __E_Person_Email;
  SHARED __EE169438826 := __EE169438622(__NN(__EE169438622.Subject_) AND __NN(__EE169438622.Email_));
  SHARED __EE169438616 := __ENH_Person;
  SHARED __EE169438898 := __EE169438616(__T(__OP2(__EE169438616.UID,=,__CN(__PPersonUID))));
  __JC169438904(E_Person_Email(__in,__cfg_Local).Layout __EE169438826, B_Person(__in,__cfg_Local).__ST118344_Layout __EE169438898) := __EEQP(__EE169438898.UID,__EE169438826.Subject_);
  SHARED __EE169438911 := JOIN(__EE169438826,__EE169438898,__JC169438904(LEFT,RIGHT),TRANSFORM(E_Person_Email(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC169438917(E_Email(__in,__cfg_Local).Layout __EE169438632, E_Person_Email(__in,__cfg_Local).Layout __EE169438911) := __EEQP(__EE169438911.Email_,__EE169438632.UID);
  SHARED __EE169438952 := JOIN(__EE169438632,__EE169438911,__JC169438917(LEFT,RIGHT),TRANSFORM(E_Email(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE169438954 := __EE169438952;
  EXPORT Res46 := __UNWRAP(__EE169438954);
  SHARED __EE169441744 := __E_Inquiry;
  SHARED __EE169441734 := __E_Person_Inquiry;
  SHARED __EE169441905 := __EE169441734(__NN(__EE169441734.Subject_) AND __NN(__EE169441734.Inquiry_));
  SHARED __EE169441728 := __ENH_Person;
  SHARED __EE169441963 := __EE169441728(__T(__OP2(__EE169441728.UID,=,__CN(__PPersonUID))));
  __JC169441969(E_Person_Inquiry(__in,__cfg_Local).Layout __EE169441905, B_Person(__in,__cfg_Local).__ST118344_Layout __EE169441963) := __EEQP(__EE169441963.UID,__EE169441905.Subject_);
  SHARED __EE169441976 := JOIN(__EE169441905,__EE169441963,__JC169441969(LEFT,RIGHT),TRANSFORM(E_Person_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC169441982(E_Inquiry(__in,__cfg_Local).Layout __EE169441744, E_Person_Inquiry(__in,__cfg_Local).Layout __EE169441976) := __EEQP(__EE169441976.Inquiry_,__EE169441744.UID);
  SHARED __EE169442003 := JOIN(__EE169441744,__EE169441976,__JC169441982(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE169442005 := __EE169442003;
  EXPORT Res47 := __UNWRAP(__EE169442005);
  SHARED __EE169444773 := __ENH_Lien_Judgment;
  SHARED __EE169444762 := __E_Person_Lien_Judgment;
  SHARED __EE169444985 := __EE169444762(__NN(__EE169444762.Subject_) AND __NN(__EE169444762.Lien_));
  SHARED __EE169444756 := __ENH_Person;
  SHARED __EE169445067 := __EE169444756(__T(__OP2(__EE169444756.UID,=,__CN(__PPersonUID))));
  __JC169445073(E_Person_Lien_Judgment(__in,__cfg_Local).Layout __EE169444985, B_Person(__in,__cfg_Local).__ST118344_Layout __EE169445067) := __EEQP(__EE169445067.UID,__EE169444985.Subject_);
  SHARED __EE169445086 := JOIN(__EE169444985,__EE169445067,__JC169445073(LEFT,RIGHT),TRANSFORM(E_Person_Lien_Judgment(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC169445092(B_Lien_Judgment_12(__in,__cfg_Local).__ST186387_Layout __EE169444773, E_Person_Lien_Judgment(__in,__cfg_Local).Layout __EE169445086) := __EEQP(__EE169445086.Lien_,__EE169444773.UID);
  SHARED __EE169445131 := JOIN(__EE169444773,__EE169445086,__JC169445092(LEFT,RIGHT),TRANSFORM(B_Lien_Judgment_12(__in,__cfg_Local).__ST186387_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE169445133 := __EE169445131;
  EXPORT Res48 := __UNWRAP(__EE169445133);
  SHARED __EE169447945 := __E_Criminal_Offender;
  SHARED __EE169447935 := __E_Person_Offender;
  SHARED __EE169448123 := __EE169447935(__NN(__EE169447935.Subject_) AND __NN(__EE169447935.Offender_));
  SHARED __EE169447929 := __ENH_Person;
  SHARED __EE169448188 := __EE169447929(__T(__OP2(__EE169447929.UID,=,__CN(__PPersonUID))));
  __JC169448194(E_Person_Offender(__in,__cfg_Local).Layout __EE169448123, B_Person(__in,__cfg_Local).__ST118344_Layout __EE169448188) := __EEQP(__EE169448188.UID,__EE169448123.Subject_);
  SHARED __EE169448201 := JOIN(__EE169448123,__EE169448188,__JC169448194(LEFT,RIGHT),TRANSFORM(E_Person_Offender(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC169448207(E_Criminal_Offender(__in,__cfg_Local).Layout __EE169447945, E_Person_Offender(__in,__cfg_Local).Layout __EE169448201) := __EEQP(__EE169448201.Offender_,__EE169447945.UID);
  SHARED __EE169448235 := JOIN(__EE169447945,__EE169448201,__JC169448207(LEFT,RIGHT),TRANSFORM(E_Criminal_Offender(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE169448237 := __EE169448235;
  EXPORT Res49 := __UNWRAP(__EE169448237);
  SHARED __EE169451019 := __ENH_Criminal_Offense;
  SHARED __EE169451008 := __E_Person_Offenses;
  SHARED __EE169451309 := __EE169451008(__NN(__EE169451008.Subject_) AND __NN(__EE169451008.Offense_));
  SHARED __EE169451002 := __ENH_Person;
  SHARED __EE169451429 := __EE169451002(__T(__OP2(__EE169451002.UID,=,__CN(__PPersonUID))));
  __JC169451435(E_Person_Offenses(__in,__cfg_Local).Layout __EE169451309, B_Person(__in,__cfg_Local).__ST118344_Layout __EE169451429) := __EEQP(__EE169451429.UID,__EE169451309.Subject_);
  SHARED __EE169451442 := JOIN(__EE169451309,__EE169451429,__JC169451435(LEFT,RIGHT),TRANSFORM(E_Person_Offenses(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC169451448(B_Criminal_Offense(__in,__cfg_Local).__ST108406_Layout __EE169451019, E_Person_Offenses(__in,__cfg_Local).Layout __EE169451442) := __EEQP(__EE169451442.Offense_,__EE169451019.UID);
  SHARED __EE169451531 := JOIN(__EE169451019,__EE169451442,__JC169451448(LEFT,RIGHT),TRANSFORM(B_Criminal_Offense(__in,__cfg_Local).__ST108406_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE169451533 := __EE169451531;
  EXPORT Res50 := __UNWRAP(__EE169451533);
  SHARED __EE169454419 := __E_Phone;
  SHARED __EE169454409 := __E_Person_Phone;
  SHARED __EE169454712 := __EE169454409(__NN(__EE169454409.Subject_) AND __NN(__EE169454409.Phone_Number_));
  SHARED __EE169454403 := __ENH_Person;
  SHARED __EE169454831 := __EE169454403(__T(__OP2(__EE169454403.UID,=,__CN(__PPersonUID))));
  __JC169454837(E_Person_Phone(__in,__cfg_Local).Layout __EE169454712, B_Person(__in,__cfg_Local).__ST118344_Layout __EE169454831) := __EEQP(__EE169454831.UID,__EE169454712.Subject_);
  SHARED __EE169454873 := JOIN(__EE169454712,__EE169454831,__JC169454837(LEFT,RIGHT),TRANSFORM(E_Person_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC169454879(E_Phone(__in,__cfg_Local).Layout __EE169454419, E_Person_Phone(__in,__cfg_Local).Layout __EE169454873) := __EEQP(__EE169454873.Phone_Number_,__EE169454419.UID);
  SHARED __EE169454932 := JOIN(__EE169454419,__EE169454873,__JC169454879(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE169454934 := __EE169454932;
  EXPORT Res51 := __UNWRAP(__EE169454934);
  SHARED __EE169457845 := __E_Property;
  SHARED __EE169457835 := __E_Person_Property;
  SHARED __EE169458074 := __EE169457835(__NN(__EE169457835.Subject_) AND __NN(__EE169457835.Prop_));
  SHARED __EE169457829 := __ENH_Person;
  SHARED __EE169458164 := __EE169457829(__T(__OP2(__EE169457829.UID,=,__CN(__PPersonUID))));
  __JC169458170(E_Person_Property(__in,__cfg_Local).Layout __EE169458074, B_Person(__in,__cfg_Local).__ST118344_Layout __EE169458164) := __EEQP(__EE169458164.UID,__EE169458074.Subject_);
  SHARED __EE169458195 := JOIN(__EE169458074,__EE169458164,__JC169458170(LEFT,RIGHT),TRANSFORM(E_Person_Property(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC169458201(E_Property(__in,__cfg_Local).Layout __EE169457845, E_Person_Property(__in,__cfg_Local).Layout __EE169458195) := __EEQP(__EE169458195.Prop_,__EE169457845.UID);
  SHARED __EE169458236 := JOIN(__EE169457845,__EE169458195,__JC169458201(LEFT,RIGHT),TRANSFORM(E_Property(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE169458238 := __EE169458236;
  EXPORT Res52 := __UNWRAP(__EE169458238);
  SHARED __EE169461083 := __ENH_Property_Event;
  SHARED __EE169461072 := __E_Person_Property_Event;
  SHARED __EE169461890 := __EE169461072(__NN(__EE169461072.Subject_) AND __NN(__EE169461072.Event_));
  SHARED __EE169461066 := __ENH_Person;
  SHARED __EE169462270 := __EE169461066(__T(__OP2(__EE169461066.UID,=,__CN(__PPersonUID))));
  __JC169462276(E_Person_Property_Event(__in,__cfg_Local).Layout __EE169461890, B_Person(__in,__cfg_Local).__ST118344_Layout __EE169462270) := __EEQP(__EE169462270.UID,__EE169461890.Subject_);
  SHARED __EE169462296 := JOIN(__EE169461890,__EE169462270,__JC169462276(LEFT,RIGHT),TRANSFORM(E_Person_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC169462302(B_Property_Event_3(__in,__cfg_Local).__ST162275_Layout __EE169461083, E_Person_Property_Event(__in,__cfg_Local).Layout __EE169462296) := __EEQP(__EE169462296.Event_,__EE169461083.UID);
  SHARED __EE169462632 := JOIN(__EE169461083,__EE169462296,__JC169462302(LEFT,RIGHT),TRANSFORM(B_Property_Event_3(__in,__cfg_Local).__ST162275_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE169462634 := __EE169462632;
  EXPORT Res53 := __UNWRAP(__EE169462634);
  SHARED __EE169466052 := __E_Social_Security_Number;
  SHARED __EE169466042 := __E_Person_S_S_N;
  SHARED __EE169466208 := __EE169466042(__NN(__EE169466042.Subject_) AND __NN(__EE169466042.Social_));
  SHARED __EE169466036 := __ENH_Person;
  SHARED __EE169466263 := __EE169466036(__T(__OP2(__EE169466036.UID,=,__CN(__PPersonUID))));
  __JC169466269(E_Person_S_S_N(__in,__cfg_Local).Layout __EE169466208, B_Person(__in,__cfg_Local).__ST118344_Layout __EE169466263) := __EEQP(__EE169466263.UID,__EE169466208.Subject_);
  SHARED __EE169466280 := JOIN(__EE169466208,__EE169466263,__JC169466269(LEFT,RIGHT),TRANSFORM(E_Person_S_S_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC169466286(E_Social_Security_Number(__in,__cfg_Local).Layout __EE169466052, E_Person_S_S_N(__in,__cfg_Local).Layout __EE169466280) := __EEQP(__EE169466280.Social_,__EE169466052.UID);
  SHARED __EE169466300 := JOIN(__EE169466052,__EE169466280,__JC169466286(LEFT,RIGHT),TRANSFORM(E_Social_Security_Number(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE169466302 := __EE169466300;
  EXPORT Res54 := __UNWRAP(__EE169466302);
  SHARED __EE169469068 := __ENH_U_C_C;
  SHARED __EE169469057 := __E_Person_U_C_C;
  SHARED __EE169469317 := __EE169469057(__NN(__EE169469057.Subject_) AND __NN(__EE169469057.Filing_));
  SHARED __EE169469051 := __ENH_Person;
  SHARED __EE169469417 := __EE169469051(__T(__OP2(__EE169469051.UID,=,__CN(__PPersonUID))));
  __JC169469423(E_Person_U_C_C(__in,__cfg_Local).Layout __EE169469317, B_Person(__in,__cfg_Local).__ST118344_Layout __EE169469417) := __EEQP(__EE169469417.UID,__EE169469317.Subject_);
  SHARED __EE169469435 := JOIN(__EE169469317,__EE169469417,__JC169469423(LEFT,RIGHT),TRANSFORM(E_Person_U_C_C(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC169469441(B_U_C_C(__in,__cfg_Local).__ST119993_Layout __EE169469068, E_Person_U_C_C(__in,__cfg_Local).Layout __EE169469435) := __EEQP(__EE169469435.Filing_,__EE169469068.UID);
  SHARED __EE169469499 := JOIN(__EE169469068,__EE169469435,__JC169469441(LEFT,RIGHT),TRANSFORM(B_U_C_C(__in,__cfg_Local).__ST119993_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE169469501 := __EE169469499;
  EXPORT Res55 := __UNWRAP(__EE169469501);
  SHARED __EE169472353 := __E_Vehicle;
  SHARED __EE169472343 := __E_Person_Vehicle;
  SHARED __EE169472769 := __EE169472343(__NN(__EE169472343.Subject_) AND __NN(__EE169472343.Automobile_));
  SHARED __EE169472337 := __ENH_Person;
  SHARED __EE169472953 := __EE169472337(__T(__OP2(__EE169472337.UID,=,__CN(__PPersonUID))));
  __JC169472959(E_Person_Vehicle(__in,__cfg_Local).Layout __EE169472769, B_Person(__in,__cfg_Local).__ST118344_Layout __EE169472953) := __EEQP(__EE169472953.UID,__EE169472769.Subject_);
  SHARED __EE169473002 := JOIN(__EE169472769,__EE169472953,__JC169472959(LEFT,RIGHT),TRANSFORM(E_Person_Vehicle(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC169473008(E_Vehicle(__in,__cfg_Local).Layout __EE169472353, E_Person_Vehicle(__in,__cfg_Local).Layout __EE169473002) := __EEQP(__EE169473002.Automobile_,__EE169472353.UID);
  SHARED __EE169473119 := JOIN(__EE169472353,__EE169473002,__JC169473008(LEFT,RIGHT),TRANSFORM(E_Vehicle(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE169473121 := __EE169473119;
  EXPORT Res56 := __UNWRAP(__EE169473121);
  SHARED __EE169476136 := __ENH_Professional_License;
  SHARED __EE169476125 := __E_Professional_License_Person;
  SHARED __EE169476349 := __EE169476125(__NN(__EE169476125.Subject_) AND __NN(__EE169476125.Prof_Lic_));
  SHARED __EE169476119 := __ENH_Person;
  SHARED __EE169476431 := __EE169476119(__T(__OP2(__EE169476119.UID,=,__CN(__PPersonUID))));
  __JC169476437(E_Professional_License_Person(__in,__cfg_Local).Layout __EE169476349, B_Person(__in,__cfg_Local).__ST118344_Layout __EE169476431) := __EEQP(__EE169476431.UID,__EE169476349.Subject_);
  SHARED __EE169476444 := JOIN(__EE169476349,__EE169476431,__JC169476437(LEFT,RIGHT),TRANSFORM(E_Professional_License_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC169476450(B_Professional_License_4(__in,__cfg_Local).__ST170771_Layout __EE169476136, E_Professional_License_Person(__in,__cfg_Local).Layout __EE169476444) := __EEQP(__EE169476444.Prof_Lic_,__EE169476136.UID);
  SHARED __EE169476495 := JOIN(__EE169476136,__EE169476444,__JC169476450(LEFT,RIGHT),TRANSFORM(B_Professional_License_4(__in,__cfg_Local).__ST170771_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE169476497 := __EE169476495;
  EXPORT Res57 := __UNWRAP(__EE169476497);
  SHARED __EE169479308 := __ENH_Business_Prox;
  SHARED __EE169479297 := __E_Prox_Person;
  SHARED __EE169480015 := __EE169479297(__NN(__EE169479297.Contact_) AND __NN(__EE169479297.Business_Location_));
  SHARED __EE169479291 := __ENH_Person;
  SHARED __EE169480333 := __EE169479291(__T(__OP2(__EE169479291.UID,=,__CN(__PPersonUID))));
  __JC169480339(E_Prox_Person(__in,__cfg_Local).Layout __EE169480015, B_Person(__in,__cfg_Local).__ST118344_Layout __EE169480333) := __EEQP(__EE169480333.UID,__EE169480015.Contact_);
  SHARED __EE169480367 := JOIN(__EE169480015,__EE169480333,__JC169480339(LEFT,RIGHT),TRANSFORM(E_Prox_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC169480373(B_Business_Prox(__in,__cfg_Local).__ST89340_Layout __EE169479308, E_Prox_Person(__in,__cfg_Local).Layout __EE169480367) := __EEQP(__EE169480367.Business_Location_,__EE169479308.UID);
  SHARED __EE169480633 := JOIN(__EE169479308,__EE169480367,__JC169480373(LEFT,RIGHT),TRANSFORM(B_Business_Prox(__in,__cfg_Local).__ST89340_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE169480635 := __EE169480633;
  EXPORT Res58 := __UNWRAP(__EE169480635);
  SHARED __EE169483925 := __ENH_Business_Sele;
  SHARED __EE169483914 := __E_Sele_Person;
  SHARED __EE169487147 := __EE169483914(__NN(__EE169483914.Contact_) AND __NN(__EE169483914.Legal_));
  SHARED __EE169483908 := __ENH_Person;
  SHARED __EE169488684 := __EE169483908(__T(__OP2(__EE169483908.UID,=,__CN(__PPersonUID))));
  __JC169488690(E_Sele_Person(__in,__cfg_Local).Layout __EE169487147, B_Person(__in,__cfg_Local).__ST118344_Layout __EE169488684) := __EEQP(__EE169488684.UID,__EE169487147.Contact_);
  SHARED __EE169488718 := JOIN(__EE169487147,__EE169488684,__JC169488690(LEFT,RIGHT),TRANSFORM(E_Sele_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC169488724(B_Business_Sele(__in,__cfg_Local).__ST107005_Layout __EE169483925, E_Sele_Person(__in,__cfg_Local).Layout __EE169488718) := __EEQP(__EE169488718.Legal_,__EE169483925.UID);
  SHARED __EE169490203 := JOIN(__EE169483925,__EE169488718,__JC169488724(LEFT,RIGHT),TRANSFORM(B_Business_Sele(__in,__cfg_Local).__ST107005_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE169490205 := __EE169490203;
  EXPORT Res59 := __UNWRAP(__EE169490205);
  SHARED __EE174155349 := __E_Utility;
  SHARED __EE174155339 := __E_Utility_Person;
  SHARED __EE174155490 := __EE174155339(__NN(__EE174155339.Subject_) AND __NN(__EE174155339.Util_));
  SHARED __EE174155333 := __ENH_Person;
  SHARED __EE174155538 := __EE174155333(__T(__OP2(__EE174155333.UID,=,__CN(__PPersonUID))));
  __JC174155544(E_Utility_Person(__in,__cfg_Local).Layout __EE174155490, B_Person(__in,__cfg_Local).__ST118344_Layout __EE174155538) := __EEQP(__EE174155538.UID,__EE174155490.Subject_);
  SHARED __EE174155551 := JOIN(__EE174155490,__EE174155538,__JC174155544(LEFT,RIGHT),TRANSFORM(E_Utility_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC174155557(E_Utility(__in,__cfg_Local).Layout __EE174155349, E_Utility_Person(__in,__cfg_Local).Layout __EE174155551) := __EEQP(__EE174155551.Util_,__EE174155349.UID);
  SHARED __EE174155568 := JOIN(__EE174155349,__EE174155551,__JC174155557(LEFT,RIGHT),TRANSFORM(E_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE174155570 := __EE174155568;
  EXPORT Res60 := __UNWRAP(__EE174155570);
  SHARED __EE174158317 := __E_Watercraft;
  SHARED __EE174158307 := __E_Watercraft_Owner;
  SHARED __EE174158459 := __EE174158307(__NN(__EE174158307.Owner_) AND __NN(__EE174158307.W_Craft_));
  SHARED __EE174158301 := __ENH_Person;
  SHARED __EE174158507 := __EE174158301(__T(__OP2(__EE174158301.UID,=,__CN(__PPersonUID))));
  __JC174158513(E_Watercraft_Owner(__in,__cfg_Local).Layout __EE174158459, B_Person(__in,__cfg_Local).__ST118344_Layout __EE174158507) := __EEQP(__EE174158507.UID,__EE174158459.Owner_);
  SHARED __EE174158520 := JOIN(__EE174158459,__EE174158507,__JC174158513(LEFT,RIGHT),TRANSFORM(E_Watercraft_Owner(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC174158526(E_Watercraft(__in,__cfg_Local).Layout __EE174158317, E_Watercraft_Owner(__in,__cfg_Local).Layout __EE174158520) := __EEQP(__EE174158520.W_Craft_,__EE174158317.UID);
  SHARED __EE174158537 := JOIN(__EE174158317,__EE174158520,__JC174158526(LEFT,RIGHT),TRANSFORM(E_Watercraft(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE174158539 := __EE174158537;
  EXPORT Res61 := __UNWRAP(__EE174158539);
  SHARED __EE174161281 := __E_Zip_Code;
  SHARED __EE174161271 := __E_Zip_Code_Person;
  SHARED __EE174161424 := __EE174161271(__NN(__EE174161271.Subject_) AND __NN(__EE174161271.Zip_));
  SHARED __EE174161265 := __ENH_Person;
  SHARED __EE174161473 := __EE174161265(__T(__OP2(__EE174161265.UID,=,__CN(__PPersonUID))));
  __JC174161479(E_Zip_Code_Person(__in,__cfg_Local).Layout __EE174161424, B_Person(__in,__cfg_Local).__ST118344_Layout __EE174161473) := __EEQP(__EE174161473.UID,__EE174161424.Subject_);
  SHARED __EE174161487 := JOIN(__EE174161424,__EE174161473,__JC174161479(LEFT,RIGHT),TRANSFORM(E_Zip_Code_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC174161493(E_Zip_Code(__in,__cfg_Local).Layout __EE174161281, E_Zip_Code_Person(__in,__cfg_Local).Layout __EE174161487) := __EEQP(__EE174161487.Zip_,__EE174161281.UID);
  SHARED __EE174161504 := JOIN(__EE174161281,__EE174161487,__JC174161493(LEFT,RIGHT),TRANSFORM(E_Zip_Code(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE174161506 := __EE174161504;
  EXPORT Res62 := __UNWRAP(__EE174161506);
  SHARED __EE174164246 := __E_Person_Email_Phone_Address;
  SHARED __EE174164340 := __EE174164246(__NN(__EE174164246.Subject_));
  SHARED __EE174164240 := __ENH_Person;
  SHARED __EE174164345 := __EE174164240(__T(__OP2(__EE174164240.UID,=,__CN(__PPersonUID))));
  __JC174164351(E_Person_Email_Phone_Address(__in,__cfg_Local).Layout __EE174164340, B_Person(__in,__cfg_Local).__ST118344_Layout __EE174164345) := __EEQP(__EE174164345.UID,__EE174164340.Subject_);
  SHARED __EE174164371 := JOIN(__EE174164340,__EE174164345,__JC174164351(LEFT,RIGHT),TRANSFORM(E_Person_Email_Phone_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE174164373 := __EE174164371;
  EXPORT Res63 := __UNWRAP(__EE174164373);
  SHARED __EE174165928 := __ENH_Address;
  SHARED __EE174165917 := __E_Address_Phone;
  SHARED __EE174166359 := __EE174165917(__NN(__EE174165917.Phone_Number_) AND __NN(__EE174165917.Location_));
  SHARED __EE174165911 := __E_Phone;
  SHARED __EE174166540 := __EE174165911(__T(__OP2(__EE174165911.UID,=,__CN(__PPhoneUID))));
  __JC174166546(E_Address_Phone(__in,__cfg_Local).Layout __EE174166359, E_Phone(__in,__cfg_Local).Layout __EE174166540) := __EEQP(__EE174166540.UID,__EE174166359.Phone_Number_);
  SHARED __EE174166574 := JOIN(__EE174166359,__EE174166540,__JC174166546(LEFT,RIGHT),TRANSFORM(E_Address_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC174166580(B_Address_1(__in,__cfg_Local).__ST120083_Layout __EE174165928, E_Address_Phone(__in,__cfg_Local).Layout __EE174166574) := __EEQP(__EE174166574.Location_,__EE174165928.UID);
  SHARED __EE174166703 := JOIN(__EE174165928,__EE174166574,__JC174166580(LEFT,RIGHT),TRANSFORM(B_Address_1(__in,__cfg_Local).__ST120083_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE174166705 := __EE174166703;
  EXPORT Res64 := __UNWRAP(__EE174166705);
  SHARED __EE174167068 := __ENH_Person;
  SHARED __EE174167057 := __E_Person_Phone;
  SHARED __EE174168822 := __EE174167057(__NN(__EE174167057.Phone_Number_) AND __NN(__EE174167057.Subject_));
  SHARED __EE174167051 := __E_Phone;
  SHARED __EE174169646 := __EE174167051(__T(__OP2(__EE174167051.UID,=,__CN(__PPhoneUID))));
  __JC174169652(E_Person_Phone(__in,__cfg_Local).Layout __EE174168822, E_Phone(__in,__cfg_Local).Layout __EE174169646) := __EEQP(__EE174169646.UID,__EE174168822.Phone_Number_);
  SHARED __EE174169688 := JOIN(__EE174168822,__EE174169646,__JC174169652(LEFT,RIGHT),TRANSFORM(E_Person_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC174169694(B_Person(__in,__cfg_Local).__ST118344_Layout __EE174167068, E_Person_Phone(__in,__cfg_Local).Layout __EE174169688) := __EEQP(__EE174169688.Subject_,__EE174167068.UID);
  SHARED __EE174170452 := JOIN(__EE174167068,__EE174169688,__JC174169694(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST118344_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE174170454 := __EE174170452;
  EXPORT Res65 := __UNWRAP(__EE174170454);
  SHARED __EE174172373 := __E_Inquiry;
  SHARED __EE174172363 := __E_Phone_Inquiry;
  SHARED __EE174172534 := __EE174172363(__NN(__EE174172363.Phone_Number_) AND __NN(__EE174172363.Inquiry_));
  SHARED __EE174172357 := __E_Phone;
  SHARED __EE174172592 := __EE174172357(__T(__OP2(__EE174172357.UID,=,__CN(__PPhoneUID))));
  __JC174172598(E_Phone_Inquiry(__in,__cfg_Local).Layout __EE174172534, E_Phone(__in,__cfg_Local).Layout __EE174172592) := __EEQP(__EE174172592.UID,__EE174172534.Phone_Number_);
  SHARED __EE174172605 := JOIN(__EE174172534,__EE174172592,__JC174172598(LEFT,RIGHT),TRANSFORM(E_Phone_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC174172611(E_Inquiry(__in,__cfg_Local).Layout __EE174172373, E_Phone_Inquiry(__in,__cfg_Local).Layout __EE174172605) := __EEQP(__EE174172605.Inquiry_,__EE174172373.UID);
  SHARED __EE174172632 := JOIN(__EE174172373,__EE174172605,__JC174172611(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE174172634 := __EE174172632;
  EXPORT Res66 := __UNWRAP(__EE174172634);
  SHARED __EE174172747 := __E_T_I_N_Phone_Number;
  SHARED __EE174172903 := __EE174172747(__NN(__EE174172747.Tax_I_D_) AND __NN(__EE174172747.Phone_Number_));
  SHARED __EE174172741 := __E_Phone;
  SHARED __EE174172946 := __EE174172741(__T(__OP2(__EE174172741.UID,=,__CN(__PPhoneUID))));
  __JC174172952(E_T_I_N_Phone_Number(__in,__cfg_Local).Layout __EE174172903, E_Phone(__in,__cfg_Local).Layout __EE174172946) := __EEQP(__EE174172946.UID,__EE174172903.Phone_Number_);
  SHARED __EE174172963 := JOIN(__EE174172903,__EE174172946,__JC174172952(LEFT,RIGHT),TRANSFORM(E_T_I_N_Phone_Number(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE174172973 := PROJECT(TABLE(PROJECT(__EE174172963,TRANSFORM(E_T_I_N(__in,__cfg_Local).Layout,SELF.UID := LEFT.Tax_I_D_,SELF := LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),UID},UID,MERGE),E_T_I_N(__in,__cfg_Local).Layout);
  EXPORT Res67 := __UNWRAP(__EE174172973);
  SHARED __EE174173038 := __ENH_Second_Degree_Associations;
  SHARED __EE174173114 := __EE174173038(__NN(__EE174173038.First_Degree_Association_));
  SHARED __EE174173031 := __ENH_Person;
  SHARED __EE174173119 := __EE174173031(__T(__OP2(__EE174173031.UID,=,__CN(__PPersonUID))));
  __JC174173125(E_Second_Degree_Associations(__in,__cfg_Local).Layout __EE174173114, B_Person(__in,__cfg_Local).__ST118344_Layout __EE174173119) := __EEQP(__EE174173119.UID,__EE174173114.First_Degree_Association_);
  SHARED __EE174173137 := JOIN(__EE174173114,__EE174173119,__JC174173125(LEFT,RIGHT),TRANSFORM(E_Second_Degree_Associations(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE174173139 := __EE174173137;
  EXPORT Res68 := __UNWRAP(__EE174173139);
  SHARED __EE174174705 := __ENH_Person;
  SHARED __EE174174694 := __E_Person_Property_Event;
  SHARED __EE174177124 := __EE174174694(__NN(__EE174174694.Event_) AND __NN(__EE174174694.Subject_));
  SHARED __EE174174685 := __ENH_Property_Event;
  SHARED __EE174177101 := __EE174174685(__NN(__EE174174685.Prop_));
  SHARED __EE174174678 := __E_Property;
  SHARED __EE174177932 := __EE174174678(__T(__OP2(__EE174174678.UID,=,__CN(__PPropertyUID))));
  __JC174177938(B_Property_Event_3(__in,__cfg_Local).__ST162275_Layout __EE174177101, E_Property(__in,__cfg_Local).Layout __EE174177932) := __EEQP(__EE174177932.UID,__EE174177101.Prop_);
  SHARED __EE174178268 := JOIN(__EE174177101,__EE174177932,__JC174177938(LEFT,RIGHT),TRANSFORM(B_Property_Event_3(__in,__cfg_Local).__ST162275_Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC174178274(E_Person_Property_Event(__in,__cfg_Local).Layout __EE174177124, B_Property_Event_3(__in,__cfg_Local).__ST162275_Layout __EE174178268) := __EEQP(__EE174178268.UID,__EE174177124.Event_);
  SHARED __EE174178294 := JOIN(__EE174177124,__EE174178268,__JC174178274(LEFT,RIGHT),TRANSFORM(E_Person_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC174178300(B_Person(__in,__cfg_Local).__ST118344_Layout __EE174174705, E_Person_Property_Event(__in,__cfg_Local).Layout __EE174178294) := __EEQP(__EE174178294.Subject_,__EE174174705.UID);
  SHARED __EE174179058 := JOIN(__EE174174705,__EE174178294,__JC174178300(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST118344_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE174179060 := __EE174179058;
  EXPORT Res69 := __UNWRAP(__EE174179060);
  SHARED __EE174181654 := __ENH_Business_Sele;
  SHARED __EE174181643 := __E_Sele_Property_Event;
  SHARED __EE174185565 := __EE174181643(__NN(__EE174181643.Event_) AND __NN(__EE174181643.Legal_));
  SHARED __EE174181634 := __ENH_Property_Event;
  SHARED __EE174185542 := __EE174181634(__NN(__EE174181634.Prop_));
  SHARED __EE174181627 := __E_Property;
  SHARED __EE174187097 := __EE174181627(__T(__OP2(__EE174181627.UID,=,__CN(__PPropertyUID))));
  __JC174187103(B_Property_Event_3(__in,__cfg_Local).__ST162275_Layout __EE174185542, E_Property(__in,__cfg_Local).Layout __EE174187097) := __EEQP(__EE174187097.UID,__EE174185542.Prop_);
  SHARED __EE174187433 := JOIN(__EE174185542,__EE174187097,__JC174187103(LEFT,RIGHT),TRANSFORM(B_Property_Event_3(__in,__cfg_Local).__ST162275_Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC174187439(E_Sele_Property_Event(__in,__cfg_Local).Layout __EE174185565, B_Property_Event_3(__in,__cfg_Local).__ST162275_Layout __EE174187433) := __EEQP(__EE174187433.UID,__EE174185565.Event_);
  SHARED __EE174187462 := JOIN(__EE174185565,__EE174187433,__JC174187439(LEFT,RIGHT),TRANSFORM(E_Sele_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC174187468(B_Business_Sele(__in,__cfg_Local).__ST107005_Layout __EE174181654, E_Sele_Property_Event(__in,__cfg_Local).Layout __EE174187462) := __EEQP(__EE174187462.Legal_,__EE174181654.UID);
  SHARED __EE174188947 := JOIN(__EE174181654,__EE174187462,__JC174187468(LEFT,RIGHT),TRANSFORM(B_Business_Sele(__in,__cfg_Local).__ST107005_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE174188949 := __EE174188947;
  EXPORT Res70 := __UNWRAP(__EE174188949);
  SHARED __EE178850480 := __ENH_Person;
  SHARED __EE178850469 := __E_Person_S_S_N;
  SHARED __EE178852181 := __EE178850469(__NN(__EE178850469.Social_) AND __NN(__EE178850469.Subject_));
  SHARED __EE178850463 := __E_Social_Security_Number;
  SHARED __EE178852980 := __EE178850463(__T(__OP2(__EE178850463.UID,=,__CN(__PSocialSecurityNumberUID))));
  __JC178852986(E_Person_S_S_N(__in,__cfg_Local).Layout __EE178852181, E_Social_Security_Number(__in,__cfg_Local).Layout __EE178852980) := __EEQP(__EE178852980.UID,__EE178852181.Social_);
  SHARED __EE178852997 := JOIN(__EE178852181,__EE178852980,__JC178852986(LEFT,RIGHT),TRANSFORM(E_Person_S_S_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC178853003(B_Person(__in,__cfg_Local).__ST118344_Layout __EE178850480, E_Person_S_S_N(__in,__cfg_Local).Layout __EE178852997) := __EEQP(__EE178852997.Subject_,__EE178850480.UID);
  SHARED __EE178853761 := JOIN(__EE178850480,__EE178852997,__JC178853003(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST118344_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE178853763 := __EE178853761;
  EXPORT Res71 := __UNWRAP(__EE178853763);
  SHARED __EE178855633 := __ENH_Address;
  SHARED __EE178855622 := __E_S_S_N_Address;
  SHARED __EE178856038 := __EE178855622(__NN(__EE178855622.Social_) AND __NN(__EE178855622.Location_));
  SHARED __EE178855616 := __E_Social_Security_Number;
  SHARED __EE178856207 := __EE178855616(__T(__OP2(__EE178855616.UID,=,__CN(__PSocialSecurityNumberUID))));
  __JC178856213(E_S_S_N_Address(__in,__cfg_Local).Layout __EE178856038, E_Social_Security_Number(__in,__cfg_Local).Layout __EE178856207) := __EEQP(__EE178856207.UID,__EE178856038.Social_);
  SHARED __EE178856229 := JOIN(__EE178856038,__EE178856207,__JC178856213(LEFT,RIGHT),TRANSFORM(E_S_S_N_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC178856235(B_Address_1(__in,__cfg_Local).__ST120083_Layout __EE178855633, E_S_S_N_Address(__in,__cfg_Local).Layout __EE178856229) := __EEQP(__EE178856229.Location_,__EE178855633.UID);
  SHARED __EE178856358 := JOIN(__EE178855633,__EE178856229,__JC178856235(LEFT,RIGHT),TRANSFORM(B_Address_1(__in,__cfg_Local).__ST120083_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE178856360 := __EE178856358;
  EXPORT Res72 := __UNWRAP(__EE178856360);
  SHARED __EE178856712 := __E_Inquiry;
  SHARED __EE178856702 := __E_S_S_N_Inquiry;
  SHARED __EE178856873 := __EE178856702(__NN(__EE178856702.S_S_N_) AND __NN(__EE178856702.Inquiry_));
  SHARED __EE178856696 := __E_Social_Security_Number;
  SHARED __EE178856931 := __EE178856696(__T(__OP2(__EE178856696.UID,=,__CN(__PSocialSecurityNumberUID))));
  __JC178856937(E_S_S_N_Inquiry(__in,__cfg_Local).Layout __EE178856873, E_Social_Security_Number(__in,__cfg_Local).Layout __EE178856931) := __EEQP(__EE178856931.UID,__EE178856873.S_S_N_);
  SHARED __EE178856944 := JOIN(__EE178856873,__EE178856931,__JC178856937(LEFT,RIGHT),TRANSFORM(E_S_S_N_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC178856950(E_Inquiry(__in,__cfg_Local).Layout __EE178856712, E_S_S_N_Inquiry(__in,__cfg_Local).Layout __EE178856944) := __EEQP(__EE178856944.Inquiry_,__EE178856712.UID);
  SHARED __EE178856971 := JOIN(__EE178856712,__EE178856944,__JC178856950(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE178856973 := __EE178856971;
  EXPORT Res73 := __UNWRAP(__EE178856973);
  SHARED __EE178857097 := __ENH_Address;
  SHARED __EE178857086 := __E_T_I_N_Address;
  SHARED __EE178857500 := __EE178857086(__NN(__EE178857086.Tax_I_D_) AND __NN(__EE178857086.Location_));
  SHARED __EE178857080 := __E_T_I_N;
  SHARED __EE178857668 := __EE178857080(__T(__OP2(__EE178857080.UID,=,__CN(__PTINUID))));
  __JC178857674(E_T_I_N_Address(__in,__cfg_Local).Layout __EE178857500, E_T_I_N(__in,__cfg_Local).Layout __EE178857668) := __EEQP(__EE178857668.UID,__EE178857500.Tax_I_D_);
  SHARED __EE178857689 := JOIN(__EE178857500,__EE178857668,__JC178857674(LEFT,RIGHT),TRANSFORM(E_T_I_N_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC178857695(B_Address_1(__in,__cfg_Local).__ST120083_Layout __EE178857097, E_T_I_N_Address(__in,__cfg_Local).Layout __EE178857689) := __EEQP(__EE178857689.Location_,__EE178857097.UID);
  SHARED __EE178857818 := JOIN(__EE178857097,__EE178857689,__JC178857695(LEFT,RIGHT),TRANSFORM(B_Address_1(__in,__cfg_Local).__ST120083_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE178857820 := __EE178857818;
  EXPORT Res74 := __UNWRAP(__EE178857820);
  SHARED __EE178858156 := __E_Phone;
  SHARED __EE178858146 := __E_T_I_N_Phone_Number;
  SHARED __EE178858397 := __EE178858146(__NN(__EE178858146.Tax_I_D_) AND __NN(__EE178858146.Phone_Number_));
  SHARED __EE178858140 := __E_T_I_N;
  SHARED __EE178858491 := __EE178858140(__T(__OP2(__EE178858140.UID,=,__CN(__PTINUID))));
  __JC178858497(E_T_I_N_Phone_Number(__in,__cfg_Local).Layout __EE178858397, E_T_I_N(__in,__cfg_Local).Layout __EE178858491) := __EEQP(__EE178858491.UID,__EE178858397.Tax_I_D_);
  SHARED __EE178858508 := JOIN(__EE178858397,__EE178858491,__JC178858497(LEFT,RIGHT),TRANSFORM(E_T_I_N_Phone_Number(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC178858514(E_Phone(__in,__cfg_Local).Layout __EE178858156, E_T_I_N_Phone_Number(__in,__cfg_Local).Layout __EE178858508) := __EEQP(__EE178858508.Phone_Number_,__EE178858156.UID);
  SHARED __EE178858567 := JOIN(__EE178858156,__EE178858508,__JC178858514(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE178858569 := __EE178858567;
  EXPORT Res75 := __UNWRAP(__EE178858569);
  SHARED __EE178858760 := __ENH_Person;
  SHARED __EE178858749 := __E_Zip_Code_Person;
  SHARED __EE178860455 := __EE178858749(__NN(__EE178858749.Zip_) AND __NN(__EE178858749.Subject_));
  SHARED __EE178858743 := __E_Zip_Code;
  SHARED __EE178861251 := __EE178858743(__T(__OP2(__EE178858743.UID,=,__CN(__PZipCodeUID))));
  __JC178861257(E_Zip_Code_Person(__in,__cfg_Local).Layout __EE178860455, E_Zip_Code(__in,__cfg_Local).Layout __EE178861251) := __EEQP(__EE178861251.UID,__EE178860455.Zip_);
  SHARED __EE178861265 := JOIN(__EE178860455,__EE178861251,__JC178861257(LEFT,RIGHT),TRANSFORM(E_Zip_Code_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC178861271(B_Person(__in,__cfg_Local).__ST118344_Layout __EE178858760, E_Zip_Code_Person(__in,__cfg_Local).Layout __EE178861265) := __EEQP(__EE178861265.Subject_,__EE178858760.UID);
  SHARED __EE178862029 := JOIN(__EE178858760,__EE178861265,__JC178861271(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST118344_Layout,SELF:=LEFT),SMART,KEEP(1));
  EXPORT Res76 := __UNWRAP(__EE178862029);
END;
