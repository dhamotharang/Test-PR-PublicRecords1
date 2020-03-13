//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Aircraft_Owner_1,B_Aircraft_Owner_2,B_Aircraft_Owner_3,B_Bankruptcy,B_Bankruptcy_1,B_Bankruptcy_2,B_Bankruptcy_3,B_Bankruptcy_4,B_Bankruptcy_5,B_Bankruptcy_6,B_Bankruptcy_7,B_Bankruptcy_8,B_Business_Prox,B_Business_Prox_1,B_Business_Prox_2,B_Business_Prox_3,B_Business_Prox_4,B_Business_Sele,B_Business_Sele_1,B_Business_Sele_10,B_Business_Sele_2,B_Business_Sele_3,B_Business_Sele_4,B_Business_Sele_5,B_Business_Sele_6,B_Business_Sele_7,B_Business_Sele_8,B_Business_Sele_9,B_Criminal_Offense,B_Criminal_Offense_1,B_Criminal_Offense_2,B_Criminal_Offense_3,B_Criminal_Offense_4,B_First_Degree_Relative,B_Lien_Judgment,B_Lien_Judgment_1,B_Lien_Judgment_10,B_Lien_Judgment_11,B_Lien_Judgment_2,B_Lien_Judgment_3,B_Lien_Judgment_4,B_Lien_Judgment_5,B_Lien_Judgment_6,B_Lien_Judgment_7,B_Lien_Judgment_8,B_Lien_Judgment_9,B_Person,B_Person_1,B_Person_2,B_Person_3,B_Person_4,B_Person_5,B_Person_6,B_Person_7,B_Person_Vehicle_1,B_Person_Vehicle_2,B_Person_Vehicle_3,B_Professional_License,B_Professional_License_1,B_Professional_License_2,B_Professional_License_3,B_Professional_License_4,B_Professional_License_5,B_Second_Degree_Associations,B_Sele_Lien_Judgment_11,B_Sele_Person_2,B_Sele_Person_3,B_Sele_Person_4,B_Sele_Person_5,B_Sele_Person_6,B_Sele_Tradeline_1,B_Sele_Tradeline_2,B_Sele_Tradeline_3,B_Sele_U_C_C_2,B_Sele_U_C_C_3,B_Sele_U_C_C_4,B_Sele_U_C_C_5,B_Sele_U_C_C_6,B_Sele_Vehicle_1,B_Sele_Vehicle_2,B_Sele_Vehicle_3,B_Tradeline,B_Tradeline_1,B_Tradeline_10,B_Tradeline_2,B_Tradeline_3,B_Tradeline_4,B_Tradeline_5,B_Tradeline_6,B_Tradeline_7,B_Tradeline_8,B_Tradeline_9,B_U_C_C,B_U_C_C_1,B_U_C_C_2,B_U_C_C_3,B_U_C_C_4,B_U_C_C_5,B_U_C_C_6,B_U_C_C_7,B_Watercraft_Owner_1,B_Watercraft_Owner_2,B_Watercraft_Owner_3,CFG_Compile,E_Accident,E_Address,E_Address_Inquiry,E_Address_Phone,E_Address_Property,E_Address_Property_Event,E_Aircraft,E_Aircraft_Owner,E_Bankruptcy,E_Business_Org,E_Business_Prox,E_Business_Sele,E_Business_Ult,E_Criminal_Details,E_Criminal_Offender,E_Criminal_Offense,E_Criminal_Punishment,E_Drivers_License,E_Education,E_Email,E_Employment,E_Employment_Person,E_First_Degree_Associations,E_First_Degree_Relative,E_Geo_Link,E_House_Hold_Phone,E_Household,E_Household_Member,E_Inquiry,E_Lien_Judgment,E_Person,E_Person_Accident,E_Person_Address,E_Person_Bankruptcy,E_Person_Drivers_License,E_Person_Education,E_Person_Email,E_Person_Email_Phone_Address,E_Person_Inquiry,E_Person_Lien_Judgment,E_Person_Offender,E_Person_Offenses,E_Person_Phone,E_Person_Property,E_Person_Property_Event,E_Person_S_S_N,E_Person_U_C_C,E_Person_Vehicle,E_Phone,E_Phone_Inquiry,E_Professional_License,E_Professional_License_Person,E_Property,E_Property_Event,E_Prox_Address,E_Prox_Email,E_Prox_Person,E_Prox_Phone_Number,E_Prox_T_I_N,E_Prox_Utility,E_S_S_N_Address,E_S_S_N_Inquiry,E_Second_Degree_Associations,E_Sele_Address,E_Sele_Aircraft,E_Sele_Bankruptcy,E_Sele_Email,E_Sele_Lien_Judgment,E_Sele_Person,E_Sele_Phone_Number,E_Sele_Property,E_Sele_Property_Event,E_Sele_T_I_N,E_Sele_Tradeline,E_Sele_U_C_C,E_Sele_Utility,E_Sele_Vehicle,E_Sele_Watercraft,E_Social_Security_Number,E_Surname,E_T_I_N,E_T_I_N_Address,E_T_I_N_Phone_Number,E_Tradeline,E_U_C_C,E_Utility,E_Utility_Address,E_Utility_Person,E_Vehicle,E_Watercraft,E_Watercraft_Owner,E_Zip_Code,E_Zip_Code_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT Q_Index_Build_Association(KEL.typ.kdate __PP_InpClnArchDt, UNSIGNED8 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PP_InpClnArchDt;
  END;
  SHARED E_Property_Filtered_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Property(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Address_Filtered_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Person_Filtered_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Property_Event_Filtered_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Property_Event(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,JOIN(__ds,E_Property_Filtered_5(__in,__cfg).__PostFilter,__EEQP(LEFT.Prop_,RIGHT.UID),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Business_Prox_Filtered_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Business_Prox(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Business_Sele_Filtered_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Business_Sele(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Household_Filtered_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Household(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Phone_Filtered_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Phone(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Sele_Address_Filtered_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Person_Filtered_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Contact_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Property_Event_Filtered_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Property_Event(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Property_Event_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Event_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Social_Security_Number_Filtered_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Social_Security_Number(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Zip_Code_Filtered_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Zip_Code(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Criminal_Offender_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Criminal_Offender(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Household_Member_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Household_Member(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Household_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Household_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Address_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Phone_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Phone(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Phone_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Phone_Number_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Property_Event_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Property_Event(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Property_Event_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Event_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_S_S_N_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_S_S_N(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Social_Security_Number_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Social_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Prox_Person_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Prox_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Prox_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Person_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Person(__in,__cfg))
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
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Contact_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_T_I_N_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_T_I_N(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SimpleFilter(DATASET(InLayout) __ds) := __ds(__T(__OP2(__ds.UID,=,__CN(1))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __SimpleFilter(__UsingFitler(__AsofFitler(__ds)));
  END;
  SHARED E_Zip_Code_Person_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Zip_Code_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Zip_Code_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Zip_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Address_Inquiry_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Address_Inquiry(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Address_Phone_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Address_Phone(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Phone_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Phone_Number_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Address_Property_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Address_Property(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Address_Property_Event_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Address_Property_Event(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Aircraft_Owner_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Aircraft_Owner(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Business_Prox_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Business_Prox(__in,__cfg))
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
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,JOIN(__ds,E_Sele_Address_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Prox_Sele_,RIGHT.Legal_),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,JOIN(__ds,E_Business_Prox_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Prox_Sele_,RIGHT.Prox_Sele_),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Prox_Sele_,RIGHT.UID),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Prox_Sele_,RIGHT.Legal_),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,JOIN(__ds,E_Sele_Property_Event_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Prox_Sele_,RIGHT.Legal_),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Criminal_Details_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Criminal_Details(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Criminal_Offender_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Offender_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Employment_Person_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Employment_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_First_Degree_Associations_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_First_Degree_Associations(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := JOIN(__UsingFitler(__AsofFitler(__ds)),E_Person_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,KEEP(1));
  END;
  SHARED E_House_Hold_Phone_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_House_Hold_Phone(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Household_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Household_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Household_Member_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Household_Member(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Household_,RIGHT.Household_) AND __EEQP(LEFT.Version_,RIGHT.Version_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Accident_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Accident(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Address_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Address_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Bankruptcy_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Bankruptcy(__in,__cfg))
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
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Drivers_License_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Drivers_License(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Education_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Education(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Email_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Email(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Inquiry_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Inquiry(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Lien_Judgment_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Lien_Judgment(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Offender_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Offender(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Offenses_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Offenses(__in,__cfg))
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
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Phone_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Phone(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Phone_Number_,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Property_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Property(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Property_Event_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Property_Event(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Event_,RIGHT.Event_) AND __EEQP(LEFT.L_N_Fares_I_D_,RIGHT.L_N_Fares_I_D_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_S_S_N_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_S_S_N(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Social_,RIGHT.Social_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_U_C_C_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_U_C_C(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Vehicle_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Vehicle(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Phone_Inquiry_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Phone_Inquiry(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Phone_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Phone_Number_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Professional_License_Person_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Professional_License_Person(__in,__cfg))
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
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Prox_Address_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Prox_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Prox_Email_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Prox_Email(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Prox_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Prox_Person_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Prox_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Contact_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_) AND __EEQP(LEFT.Contact_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Prox_Phone_Number_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Prox_Phone_Number(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Prox_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Prox_Utility_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Prox_Utility(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Prox_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_S_S_N_Address_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_S_S_N_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Social_Security_Number_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Social_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_S_S_N_Inquiry_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_S_S_N_Inquiry(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Social_Security_Number_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.S_S_N_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Address_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Address_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Aircraft_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Aircraft(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Bankruptcy_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Bankruptcy(__in,__cfg))
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
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Email_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Email(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Lien_Judgment_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Lien_Judgment(__in,__cfg))
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
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Sele_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Sele_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Sele_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Sele_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Sele_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Phone_Number_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Phone_Number(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Property_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Property(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Property_Event_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Property_Event(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Event_,RIGHT.Event_) AND __EEQP(LEFT.Ult_I_D_,RIGHT.Ult_I_D_) AND __EEQP(LEFT.Org_I_D_,RIGHT.Org_I_D_) AND __EEQP(LEFT.Sele_I_D_,RIGHT.Sele_I_D_) AND __EEQP(LEFT.L_N_Fares_I_D_,RIGHT.L_N_Fares_I_D_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Tradeline_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Tradeline(__in,__cfg))
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
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_U_C_C_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_U_C_C(__in,__cfg))
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
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Utility_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Utility(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Vehicle_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Vehicle(__in,__cfg))
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
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Watercraft_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Watercraft(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_T_I_N_Address_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_T_I_N_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_T_I_N_Filtered_2(__in,__cfg).InData,__EEQP(LEFT.Tax_I_D_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_T_I_N_Phone_Number_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_T_I_N_Phone_Number(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_T_I_N_Filtered_2(__in,__cfg).InData,__EEQP(LEFT.Tax_I_D_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Utility_Address_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Utility_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Utility_Person_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Utility_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Watercraft_Owner_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Watercraft_Owner(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Zip_Code_Person_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Zip_Code_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Zip_,RIGHT.Zip_) AND __EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Zip_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Accident_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Accident(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Accident_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Acc_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Address_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Address(__in,__cfg))
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
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Prox_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Location_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Location_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Location_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Address_Phone_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Location_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_S_S_N_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Location_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_T_I_N_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Location_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Aircraft_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Aircraft(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Aircraft_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Plane_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Plane_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Aircraft_Owner_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Plane_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Plane_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Aircraft_Owner_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Aircraft_Owner(__in,__cfg))
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
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Aircraft_Owner_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Plane_,RIGHT.Plane_) AND __EEQP(LEFT.Owner_,RIGHT.Owner_) AND __EEQP(LEFT.Registrant_Type_,RIGHT.Registrant_Type_) AND __EEQP(LEFT.Certificate_Issue_Date_,RIGHT.Certificate_Issue_Date_) AND __EEQP(LEFT.Certification_,RIGHT.Certification_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Plane_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Bankruptcy_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Bankruptcy(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Bankruptcy_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Bankrupt_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Bankrupt_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Bankruptcy_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Bankrupt_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Bankrupt_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Business_Prox_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Business_Prox(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Prox_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Business_Location_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Business_Location_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Business_Sele_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Business_Sele(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Criminal_Offender_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Criminal_Offender(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Offender_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Offender_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Offender_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart0(__ds),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Criminal_Offense_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Criminal_Offense(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Offenses_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Offense_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Offense_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Criminal_Details_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Offense_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Offense_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Criminal_Punishment_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Criminal_Punishment(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Criminal_Details_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Punishment_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Drivers_License_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Drivers_License(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Drivers_License_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.License_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Education_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Education(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Education_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Edu_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Email_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Email(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Prox_Email_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT._r_Email_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT._r_Email_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Email_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT._r_Email_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT._r_Email_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Email_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT._r_Email_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT._r_Email_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Employment_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Employment(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Employment_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Emp_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_First_Degree_Associations_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_First_Degree_Associations(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(DATASET(InLayout) __ds) := JOIN(__ds,E_First_Degree_Associations_Filtered_1(__in,__cfg).InData,__EEQP(LEFT.Subject_,RIGHT.First_Degree_Association_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.First_Degree_Association_),SELF:=LEFT),HASH,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_First_Degree_Associations_Filtered_1(__in,__cfg).InData,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.First_Degree_Association_,RIGHT.First_Degree_Association_) AND __EEQP(LEFT.Title_,RIGHT.Title_) AND __EEQP(LEFT.Relationship_Type_,RIGHT.Relationship_Type_) AND __EEQP(LEFT.Relationship_Confidence_,RIGHT.Relationship_Confidence_) AND __EEQP(LEFT.Relationship_Score_,RIGHT.Relationship_Score_) AND __EEQP(LEFT.Generation_,RIGHT.Generation_) AND __EEQP(LEFT.Relationship_Date_First_Seen_,RIGHT.Relationship_Date_First_Seen_) AND __EEQP(LEFT.Relationship_Date_Last_Seen_,RIGHT.Relationship_Date_Last_Seen_) AND __EEQP(LEFT.Source_,RIGHT.Source_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,KEEP(1),LEFT OUTER);
    SHARED __SimpleFilter(DATASET(__InLayoutExtended) __ds) := __ds(__ds.__Link0 OR __ds.__Link1);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := PROJECT(__SimpleFilter(__FilterPart1(__FilterPart0(__UsingFitler(__AsofFitler(__ds))))),InLayout);
  END;
  SHARED E_Household_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Household(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Household_Member_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Household_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Household_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart0(__ds),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Inquiry_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Inquiry(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Inquiry_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Inquiry_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Inquiry_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Inquiry_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Inquiry_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Inquiry_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Phone_Inquiry_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Inquiry_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Inquiry_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_S_S_N_Inquiry_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Inquiry_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Inquiry_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Lien_Judgment_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Lien_Judgment(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Lien_Judgment_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Lien_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Lien_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Lien_Judgment_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Lien_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Lien_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person(__in,__cfg))
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
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Address_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Address(__in,__cfg))
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
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Education_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Education(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Education_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Edu_,RIGHT.Edu_) AND __EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.D_I_D_,RIGHT.D_I_D_) AND __EEQP(LEFT.Process_Date_,RIGHT.Process_Date_) AND __EEQP(LEFT.Historical_Flag_,RIGHT.Historical_Flag_) AND __EEQP(LEFT.Class_,RIGHT.Class_) AND __EEQP(LEFT.College_Class_,RIGHT.College_Class_) AND __EEQP(LEFT.College_Major_,RIGHT.College_Major_) AND __EEQP(LEFT.New_College_Major_,RIGHT.New_College_Major_) AND __EEQP(LEFT.Head_Of_Household_First_Name_,RIGHT.Head_Of_Household_First_Name_) AND __EEQP(LEFT.Head_Of_Household_Gender_Code_,RIGHT.Head_Of_Household_Gender_Code_) AND __EEQP(LEFT.Head_Of_Household_Gender_,RIGHT.Head_Of_Household_Gender_) AND __EEQP(LEFT.Raw_A_I_D_,RIGHT.Raw_A_I_D_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Edu_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Email_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Email(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Email_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT._r_Email_,RIGHT._r_Email_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Email_Phone_Address_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Email_Phone_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Vehicle_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Vehicle(__in,__cfg))
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
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Vehicle_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Automobile_,RIGHT.Automobile_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Phone_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Phone(__in,__cfg))
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
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Phone_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Phone_Number_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Phone_Number_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Phone_Number_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Phone_Number_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Phone_Number_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_House_Hold_Phone_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Phone_Number_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Phone_Number_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_T_I_N_Phone_Number_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Phone_Number_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Professional_License_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Professional_License(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Professional_License_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Prof_Lic_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Property_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Property(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Property_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Prop_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Prop_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Prop_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prop_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Prop_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Prop_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Property_Event_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Property_Event(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Property_Event_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Event_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Event_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Event_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Event_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Event_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Event_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Property_Event_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Prox_Address_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Prox_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Prox_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Prox_Phone_Number_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Prox_Phone_Number(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Prox_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Phone_Number_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_) AND __EEQP(LEFT.Phone_Number_,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Prox_T_I_N_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Prox_T_I_N(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Prox_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Address_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Address(__in,__cfg))
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
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Aircraft_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Aircraft(__in,__cfg))
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
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Aircraft_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Plane_,RIGHT.Plane_) AND __EEQP(LEFT.Ult_I_D_,RIGHT.Ult_I_D_) AND __EEQP(LEFT.Org_I_D_,RIGHT.Org_I_D_) AND __EEQP(LEFT.Sele_I_D_,RIGHT.Sele_I_D_) AND __EEQP(LEFT.N_Number_,RIGHT.N_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Phone_Number_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Phone_Number(__in,__cfg))
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
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Phone_Number_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Phone_Number_,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_T_I_N_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_T_I_N(__in,__cfg))
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
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Watercraft_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Watercraft(__in,__cfg))
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
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Prox_Sele_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prox_Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Watercraft_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.W_Craft_,RIGHT.W_Craft_) AND __EEQP(LEFT.Ult_I_D_,RIGHT.Ult_I_D_) AND __EEQP(LEFT.Org_I_D_,RIGHT.Org_I_D_) AND __EEQP(LEFT.Sele_I_D_,RIGHT.Sele_I_D_) AND __EEQP(LEFT.Watercraft_Key_,RIGHT.Watercraft_Key_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Social_Security_Number_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Social_Security_Number(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Social_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Social_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart0(__ds),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_T_I_N_Address_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_T_I_N_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_T_I_N_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Tax_I_D_,RIGHT.Tax_I_D_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Tax_I_D_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_T_I_N_Phone_Number_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_T_I_N_Phone_Number(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Phone_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Phone_Number_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_T_I_N_Phone_Number_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Phone_Number_,RIGHT.Phone_Number_) AND __EEQP(LEFT.Tax_I_D_,RIGHT.Tax_I_D_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Phone_Number_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Tradeline_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Tradeline(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Tradeline_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Account_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_U_C_C_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_U_C_C(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_U_C_C_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Filing_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Filing_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_U_C_C_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Filing_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Filing_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Utility_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Utility(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Utility_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Util_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Util_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Utility_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Util_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Util_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Utility_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Util_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Util_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Utility_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Util_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Util_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Vehicle_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Vehicle(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Vehicle_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Automobile_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Automobile_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Vehicle_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Automobile_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Automobile_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Watercraft_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Watercraft(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Watercraft_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.W_Craft_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.W_Craft_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Watercraft_Owner_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.W_Craft_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.W_Craft_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Watercraft_Owner_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Watercraft_Owner(__in,__cfg))
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
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Watercraft_Owner_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.W_Craft_,RIGHT.W_Craft_) AND __EEQP(LEFT.Owner_,RIGHT.Owner_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.W_Craft_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Zip_Code_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Zip_Code(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Zip_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Zip_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart0(__ds),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Address_Inquiry_Filtered := E_Address_Inquiry_Filtered_1;
  SHARED E_Address_Phone_Filtered := E_Address_Phone_Filtered_1;
  SHARED E_Address_Property_Filtered := E_Address_Property_Filtered_1;
  SHARED E_Address_Property_Event_Filtered := E_Address_Property_Event_Filtered_1;
  SHARED E_Criminal_Details_Filtered := E_Criminal_Details_Filtered_1;
  SHARED E_Employment_Person_Filtered := E_Employment_Person_Filtered_1;
  SHARED E_First_Degree_Relative_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_First_Degree_Relative(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_House_Hold_Phone_Filtered := E_House_Hold_Phone_Filtered_1;
  SHARED E_Household_Member_Filtered := E_Household_Member_Filtered_1;
  SHARED E_Person_Accident_Filtered := E_Person_Accident_Filtered_1;
  SHARED E_Person_Bankruptcy_Filtered := E_Person_Bankruptcy_Filtered_1;
  SHARED E_Person_Drivers_License_Filtered := E_Person_Drivers_License_Filtered_1;
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
  SHARED E_S_S_N_Address_Filtered := E_S_S_N_Address_Filtered_1;
  SHARED E_S_S_N_Inquiry_Filtered := E_S_S_N_Inquiry_Filtered_1;
  SHARED E_Second_Degree_Associations_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Second_Degree_Associations(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Bankruptcy_Filtered := E_Sele_Bankruptcy_Filtered_1;
  SHARED E_Sele_Email_Filtered := E_Sele_Email_Filtered_1;
  SHARED E_Sele_Lien_Judgment_Filtered := E_Sele_Lien_Judgment_Filtered_1;
  SHARED E_Sele_Person_Filtered := E_Sele_Person_Filtered_2;
  SHARED E_Sele_Property_Filtered := E_Sele_Property_Filtered_1;
  SHARED E_Sele_Property_Event_Filtered := E_Sele_Property_Event_Filtered_1;
  SHARED E_Sele_Tradeline_Filtered := E_Sele_Tradeline_Filtered_1;
  SHARED E_Sele_U_C_C_Filtered := E_Sele_U_C_C_Filtered_1;
  SHARED E_Sele_Utility_Filtered := E_Sele_Utility_Filtered_1;
  SHARED E_Sele_Vehicle_Filtered := E_Sele_Vehicle_Filtered_1;
  SHARED E_T_I_N_Filtered := E_T_I_N_Filtered_2;
  SHARED E_Utility_Address_Filtered := E_Utility_Address_Filtered_1;
  SHARED E_Utility_Person_Filtered := E_Utility_Person_Filtered_1;
  SHARED E_Zip_Code_Person_Filtered := E_Zip_Code_Person_Filtered_1;
  SHARED B_Lien_Judgment_11_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Lien_Judgment_11(__in,__cfg))
    SHARED TYPEOF(E_Lien_Judgment(__in,__cfg).__Result) __E_Lien_Judgment := E_Lien_Judgment_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Sele_Lien_Judgment_11_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Lien_Judgment_11(__in,__cfg))
    SHARED TYPEOF(E_Sele_Lien_Judgment(__in,__cfg).__Result) __E_Sele_Lien_Judgment := E_Sele_Lien_Judgment_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Business_Sele_10_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_10(__in,__cfg))
    SHARED TYPEOF(E_Business_Sele(__in,__cfg).__Result) __E_Business_Sele := E_Business_Sele_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Lien_Judgment_11(__in,__cfg).__ENH_Lien_Judgment_11) __ENH_Lien_Judgment_11 := B_Lien_Judgment_11_Local(__in,__cfg).__ENH_Lien_Judgment_11;
    SHARED TYPEOF(B_Sele_Lien_Judgment_11(__in,__cfg).__ENH_Sele_Lien_Judgment_11) __ENH_Sele_Lien_Judgment_11 := B_Sele_Lien_Judgment_11_Local(__in,__cfg).__ENH_Sele_Lien_Judgment_11;
  END;
  SHARED B_Lien_Judgment_10_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Lien_Judgment_10(__in,__cfg))
    SHARED TYPEOF(B_Lien_Judgment_11(__in,__cfg).__ENH_Lien_Judgment_11) __ENH_Lien_Judgment_11 := B_Lien_Judgment_11_Local(__in,__cfg).__ENH_Lien_Judgment_11;
  END;
  SHARED B_Tradeline_10_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_10(__in,__cfg))
    SHARED TYPEOF(E_Tradeline(__in,__cfg).__Result) __E_Tradeline := E_Tradeline_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Business_Sele_9_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_9(__in,__cfg))
    SHARED TYPEOF(B_Business_Sele_10(__in,__cfg).__ENH_Business_Sele_10) __ENH_Business_Sele_10 := B_Business_Sele_10_Local(__in,__cfg).__ENH_Business_Sele_10;
  END;
  SHARED B_Lien_Judgment_9_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Lien_Judgment_9(__in,__cfg))
    SHARED TYPEOF(B_Lien_Judgment_10(__in,__cfg).__ENH_Lien_Judgment_10) __ENH_Lien_Judgment_10 := B_Lien_Judgment_10_Local(__in,__cfg).__ENH_Lien_Judgment_10;
  END;
  SHARED B_Tradeline_9_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_9(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_10(__in,__cfg).__ENH_Tradeline_10) __ENH_Tradeline_10 := B_Tradeline_10_Local(__in,__cfg).__ENH_Tradeline_10;
  END;
  SHARED B_Bankruptcy_8_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_8(__in,__cfg))
    SHARED TYPEOF(E_Bankruptcy(__in,__cfg).__Result) __E_Bankruptcy := E_Bankruptcy_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Business_Sele_8_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_8(__in,__cfg))
    SHARED TYPEOF(B_Business_Sele_9(__in,__cfg).__ENH_Business_Sele_9) __ENH_Business_Sele_9 := B_Business_Sele_9_Local(__in,__cfg).__ENH_Business_Sele_9;
  END;
  SHARED B_Lien_Judgment_8_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Lien_Judgment_8(__in,__cfg))
    SHARED TYPEOF(B_Lien_Judgment_9(__in,__cfg).__ENH_Lien_Judgment_9) __ENH_Lien_Judgment_9 := B_Lien_Judgment_9_Local(__in,__cfg).__ENH_Lien_Judgment_9;
  END;
  SHARED B_Tradeline_8_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_8(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_9(__in,__cfg).__ENH_Tradeline_9) __ENH_Tradeline_9 := B_Tradeline_9_Local(__in,__cfg).__ENH_Tradeline_9;
  END;
  SHARED B_Bankruptcy_7_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_7(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_8(__in,__cfg).__ENH_Bankruptcy_8) __ENH_Bankruptcy_8 := B_Bankruptcy_8_Local(__in,__cfg).__ENH_Bankruptcy_8;
  END;
  SHARED B_Business_Sele_7_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_7(__in,__cfg))
    SHARED TYPEOF(B_Business_Sele_8(__in,__cfg).__ENH_Business_Sele_8) __ENH_Business_Sele_8 := B_Business_Sele_8_Local(__in,__cfg).__ENH_Business_Sele_8;
  END;
  SHARED B_Lien_Judgment_7_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Lien_Judgment_7(__in,__cfg))
    SHARED TYPEOF(B_Lien_Judgment_8(__in,__cfg).__ENH_Lien_Judgment_8) __ENH_Lien_Judgment_8 := B_Lien_Judgment_8_Local(__in,__cfg).__ENH_Lien_Judgment_8;
  END;
  SHARED B_Person_7_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_7(__in,__cfg))
    SHARED TYPEOF(E_Person(__in,__cfg).__Result) __E_Person := E_Person_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Person_Address(__in,__cfg).__Result) __E_Person_Address := E_Person_Address_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Tradeline_7_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_7(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_8(__in,__cfg).__ENH_Tradeline_8) __ENH_Tradeline_8 := B_Tradeline_8_Local(__in,__cfg).__ENH_Tradeline_8;
  END;
  SHARED B_U_C_C_7_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_U_C_C_7(__in,__cfg))
    SHARED TYPEOF(E_U_C_C(__in,__cfg).__Result) __E_U_C_C := E_U_C_C_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Bankruptcy_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_6(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_7(__in,__cfg).__ENH_Bankruptcy_7) __ENH_Bankruptcy_7 := B_Bankruptcy_7_Local(__in,__cfg).__ENH_Bankruptcy_7;
  END;
  SHARED B_Business_Sele_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_6(__in,__cfg))
    SHARED TYPEOF(B_Business_Sele_7(__in,__cfg).__ENH_Business_Sele_7) __ENH_Business_Sele_7 := B_Business_Sele_7_Local(__in,__cfg).__ENH_Business_Sele_7;
    SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Tradeline_7(__in,__cfg).__ENH_Tradeline_7) __ENH_Tradeline_7 := B_Tradeline_7_Local(__in,__cfg).__ENH_Tradeline_7;
  END;
  SHARED B_Lien_Judgment_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Lien_Judgment_6(__in,__cfg))
    SHARED TYPEOF(B_Lien_Judgment_7(__in,__cfg).__ENH_Lien_Judgment_7) __ENH_Lien_Judgment_7 := B_Lien_Judgment_7_Local(__in,__cfg).__ENH_Lien_Judgment_7;
  END;
  SHARED B_Person_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_6(__in,__cfg))
    SHARED TYPEOF(B_Person_7(__in,__cfg).__ENH_Person_7) __ENH_Person_7 := B_Person_7_Local(__in,__cfg).__ENH_Person_7;
  END;
  SHARED B_Sele_Person_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Person_6(__in,__cfg))
    SHARED TYPEOF(E_Sele_Person(__in,__cfg).__Result) __E_Sele_Person := E_Sele_Person_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Sele_U_C_C_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_U_C_C_6(__in,__cfg))
    SHARED TYPEOF(E_Sele_U_C_C(__in,__cfg).__Result) __E_Sele_U_C_C := E_Sele_U_C_C_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Tradeline_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_6(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_7(__in,__cfg).__ENH_Tradeline_7) __ENH_Tradeline_7 := B_Tradeline_7_Local(__in,__cfg).__ENH_Tradeline_7;
  END;
  SHARED B_U_C_C_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_U_C_C_6(__in,__cfg))
    SHARED TYPEOF(B_U_C_C_7(__in,__cfg).__ENH_U_C_C_7) __ENH_U_C_C_7 := B_U_C_C_7_Local(__in,__cfg).__ENH_U_C_C_7;
  END;
  SHARED B_Bankruptcy_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_5(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_6(__in,__cfg).__ENH_Bankruptcy_6) __ENH_Bankruptcy_6 := B_Bankruptcy_6_Local(__in,__cfg).__ENH_Bankruptcy_6;
  END;
  SHARED B_Business_Sele_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_5(__in,__cfg))
    SHARED TYPEOF(B_Business_Sele_6(__in,__cfg).__ENH_Business_Sele_6) __ENH_Business_Sele_6 := B_Business_Sele_6_Local(__in,__cfg).__ENH_Business_Sele_6;
  END;
  SHARED B_Lien_Judgment_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Lien_Judgment_5(__in,__cfg))
    SHARED TYPEOF(B_Lien_Judgment_6(__in,__cfg).__ENH_Lien_Judgment_6) __ENH_Lien_Judgment_6 := B_Lien_Judgment_6_Local(__in,__cfg).__ENH_Lien_Judgment_6;
  END;
  SHARED B_Person_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_5(__in,__cfg))
    SHARED TYPEOF(B_Person_6(__in,__cfg).__ENH_Person_6) __ENH_Person_6 := B_Person_6_Local(__in,__cfg).__ENH_Person_6;
  END;
  SHARED B_Professional_License_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Professional_License_5(__in,__cfg))
    SHARED TYPEOF(E_Professional_License(__in,__cfg).__Result) __E_Professional_License := E_Professional_License_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Sele_Person_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Person_5(__in,__cfg))
    SHARED TYPEOF(B_Sele_Person_6(__in,__cfg).__ENH_Sele_Person_6) __ENH_Sele_Person_6 := B_Sele_Person_6_Local(__in,__cfg).__ENH_Sele_Person_6;
  END;
  SHARED B_Sele_U_C_C_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_U_C_C_5(__in,__cfg))
    SHARED TYPEOF(B_Sele_U_C_C_6(__in,__cfg).__ENH_Sele_U_C_C_6) __ENH_Sele_U_C_C_6 := B_Sele_U_C_C_6_Local(__in,__cfg).__ENH_Sele_U_C_C_6;
  END;
  SHARED B_Tradeline_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_5(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_6(__in,__cfg).__ENH_Tradeline_6) __ENH_Tradeline_6 := B_Tradeline_6_Local(__in,__cfg).__ENH_Tradeline_6;
  END;
  SHARED B_U_C_C_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_U_C_C_5(__in,__cfg))
    SHARED TYPEOF(B_U_C_C_6(__in,__cfg).__ENH_U_C_C_6) __ENH_U_C_C_6 := B_U_C_C_6_Local(__in,__cfg).__ENH_U_C_C_6;
  END;
  SHARED B_Bankruptcy_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_4(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_5(__in,__cfg).__ENH_Bankruptcy_5) __ENH_Bankruptcy_5 := B_Bankruptcy_5_Local(__in,__cfg).__ENH_Bankruptcy_5;
  END;
  SHARED B_Business_Prox_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Prox_4(__in,__cfg))
    SHARED TYPEOF(E_Business_Prox(__in,__cfg).__Result) __E_Business_Prox := E_Business_Prox_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Prox_Address(__in,__cfg).__Result) __E_Prox_Address := E_Prox_Address_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Business_Sele_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_4(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_5(__in,__cfg).__ENH_Bankruptcy_5) __ENH_Bankruptcy_5 := B_Bankruptcy_5_Local(__in,__cfg).__ENH_Bankruptcy_5;
    SHARED TYPEOF(B_Business_Sele_5(__in,__cfg).__ENH_Business_Sele_5) __ENH_Business_Sele_5 := B_Business_Sele_5_Local(__in,__cfg).__ENH_Business_Sele_5;
    SHARED TYPEOF(E_Sele_Address(__in,__cfg).__Result) __E_Sele_Address := E_Sele_Address_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Sele_Bankruptcy(__in,__cfg).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Sele_U_C_C_5(__in,__cfg).__ENH_Sele_U_C_C_5) __ENH_Sele_U_C_C_5 := B_Sele_U_C_C_5_Local(__in,__cfg).__ENH_Sele_U_C_C_5;
    SHARED TYPEOF(B_Tradeline_5(__in,__cfg).__ENH_Tradeline_5) __ENH_Tradeline_5 := B_Tradeline_5_Local(__in,__cfg).__ENH_Tradeline_5;
    SHARED TYPEOF(B_U_C_C_5(__in,__cfg).__ENH_U_C_C_5) __ENH_U_C_C_5 := B_U_C_C_5_Local(__in,__cfg).__ENH_U_C_C_5;
  END;
  SHARED B_Criminal_Offense_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense_4(__in,__cfg))
    SHARED TYPEOF(E_Criminal_Offense(__in,__cfg).__Result) __E_Criminal_Offense := E_Criminal_Offense_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Lien_Judgment_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Lien_Judgment_4(__in,__cfg))
    SHARED TYPEOF(B_Lien_Judgment_5(__in,__cfg).__ENH_Lien_Judgment_5) __ENH_Lien_Judgment_5 := B_Lien_Judgment_5_Local(__in,__cfg).__ENH_Lien_Judgment_5;
  END;
  SHARED B_Person_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_4(__in,__cfg))
    SHARED TYPEOF(B_Person_5(__in,__cfg).__ENH_Person_5) __ENH_Person_5 := B_Person_5_Local(__in,__cfg).__ENH_Person_5;
  END;
  SHARED B_Professional_License_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Professional_License_4(__in,__cfg))
    SHARED TYPEOF(B_Professional_License_5(__in,__cfg).__ENH_Professional_License_5) __ENH_Professional_License_5 := B_Professional_License_5_Local(__in,__cfg).__ENH_Professional_License_5;
  END;
  SHARED B_Sele_Person_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Person_4(__in,__cfg))
    SHARED TYPEOF(B_Sele_Person_5(__in,__cfg).__ENH_Sele_Person_5) __ENH_Sele_Person_5 := B_Sele_Person_5_Local(__in,__cfg).__ENH_Sele_Person_5;
  END;
  SHARED B_Sele_U_C_C_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_U_C_C_4(__in,__cfg))
    SHARED TYPEOF(B_Sele_U_C_C_5(__in,__cfg).__ENH_Sele_U_C_C_5) __ENH_Sele_U_C_C_5 := B_Sele_U_C_C_5_Local(__in,__cfg).__ENH_Sele_U_C_C_5;
  END;
  SHARED B_Tradeline_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_4(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_5(__in,__cfg).__ENH_Tradeline_5) __ENH_Tradeline_5 := B_Tradeline_5_Local(__in,__cfg).__ENH_Tradeline_5;
  END;
  SHARED B_U_C_C_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_U_C_C_4(__in,__cfg))
    SHARED TYPEOF(B_U_C_C_5(__in,__cfg).__ENH_U_C_C_5) __ENH_U_C_C_5 := B_U_C_C_5_Local(__in,__cfg).__ENH_U_C_C_5;
  END;
  SHARED B_Aircraft_Owner_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Aircraft_Owner_3(__in,__cfg))
    SHARED TYPEOF(E_Aircraft_Owner(__in,__cfg).__Result) __E_Aircraft_Owner := E_Aircraft_Owner_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Bankruptcy_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_3(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4_Local(__in,__cfg).__ENH_Bankruptcy_4;
  END;
  SHARED B_Business_Prox_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Prox_3(__in,__cfg))
    SHARED TYPEOF(B_Business_Prox_4(__in,__cfg).__ENH_Business_Prox_4) __ENH_Business_Prox_4 := B_Business_Prox_4_Local(__in,__cfg).__ENH_Business_Prox_4;
  END;
  SHARED B_Business_Sele_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_3(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4_Local(__in,__cfg).__ENH_Bankruptcy_4;
    SHARED TYPEOF(B_Business_Sele_4(__in,__cfg).__ENH_Business_Sele_4) __ENH_Business_Sele_4 := B_Business_Sele_4_Local(__in,__cfg).__ENH_Business_Sele_4;
    SHARED TYPEOF(E_Sele_Bankruptcy(__in,__cfg).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Sele_Person_4(__in,__cfg).__ENH_Sele_Person_4) __ENH_Sele_Person_4 := B_Sele_Person_4_Local(__in,__cfg).__ENH_Sele_Person_4;
    SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Sele_U_C_C_4(__in,__cfg).__ENH_Sele_U_C_C_4) __ENH_Sele_U_C_C_4 := B_Sele_U_C_C_4_Local(__in,__cfg).__ENH_Sele_U_C_C_4;
    SHARED TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local(__in,__cfg).__ENH_Tradeline_4;
    SHARED TYPEOF(B_U_C_C_4(__in,__cfg).__ENH_U_C_C_4) __ENH_U_C_C_4 := B_U_C_C_4_Local(__in,__cfg).__ENH_U_C_C_4;
  END;
  SHARED B_Criminal_Offense_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense_3(__in,__cfg))
    SHARED TYPEOF(B_Criminal_Offense_4(__in,__cfg).__ENH_Criminal_Offense_4) __ENH_Criminal_Offense_4 := B_Criminal_Offense_4_Local(__in,__cfg).__ENH_Criminal_Offense_4;
  END;
  SHARED B_Lien_Judgment_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Lien_Judgment_3(__in,__cfg))
    SHARED TYPEOF(B_Lien_Judgment_4(__in,__cfg).__ENH_Lien_Judgment_4) __ENH_Lien_Judgment_4 := B_Lien_Judgment_4_Local(__in,__cfg).__ENH_Lien_Judgment_4;
  END;
  SHARED B_Person_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_3(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4_Local(__in,__cfg).__ENH_Bankruptcy_4;
    SHARED TYPEOF(B_Person_4(__in,__cfg).__ENH_Person_4) __ENH_Person_4 := B_Person_4_Local(__in,__cfg).__ENH_Person_4;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Professional_License_4(__in,__cfg).__ENH_Professional_License_4) __ENH_Professional_License_4 := B_Professional_License_4_Local(__in,__cfg).__ENH_Professional_License_4;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Person_Vehicle_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_Vehicle_3(__in,__cfg))
    SHARED TYPEOF(E_Person_Vehicle(__in,__cfg).__Result) __E_Person_Vehicle := E_Person_Vehicle_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Professional_License_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Professional_License_3(__in,__cfg))
    SHARED TYPEOF(B_Professional_License_4(__in,__cfg).__ENH_Professional_License_4) __ENH_Professional_License_4 := B_Professional_License_4_Local(__in,__cfg).__ENH_Professional_License_4;
  END;
  SHARED B_Sele_Person_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Person_3(__in,__cfg))
    SHARED TYPEOF(B_Sele_Person_4(__in,__cfg).__ENH_Sele_Person_4) __ENH_Sele_Person_4 := B_Sele_Person_4_Local(__in,__cfg).__ENH_Sele_Person_4;
  END;
  SHARED B_Sele_Tradeline_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Tradeline_3(__in,__cfg))
    SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local(__in,__cfg).__ENH_Tradeline_4;
  END;
  SHARED B_Sele_U_C_C_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_U_C_C_3(__in,__cfg))
    SHARED TYPEOF(B_Sele_U_C_C_4(__in,__cfg).__ENH_Sele_U_C_C_4) __ENH_Sele_U_C_C_4 := B_Sele_U_C_C_4_Local(__in,__cfg).__ENH_Sele_U_C_C_4;
  END;
  SHARED B_Sele_Vehicle_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Vehicle_3(__in,__cfg))
    SHARED TYPEOF(E_Sele_Vehicle(__in,__cfg).__Result) __E_Sele_Vehicle := E_Sele_Vehicle_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Tradeline_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_3(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local(__in,__cfg).__ENH_Tradeline_4;
  END;
  SHARED B_U_C_C_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_U_C_C_3(__in,__cfg))
    SHARED TYPEOF(B_U_C_C_4(__in,__cfg).__ENH_U_C_C_4) __ENH_U_C_C_4 := B_U_C_C_4_Local(__in,__cfg).__ENH_U_C_C_4;
  END;
  SHARED B_Watercraft_Owner_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Watercraft_Owner_3(__in,__cfg))
    SHARED TYPEOF(E_Watercraft_Owner(__in,__cfg).__Result) __E_Watercraft_Owner := E_Watercraft_Owner_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Aircraft_Owner_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Aircraft_Owner_2(__in,__cfg))
    SHARED TYPEOF(B_Aircraft_Owner_3(__in,__cfg).__ENH_Aircraft_Owner_3) __ENH_Aircraft_Owner_3 := B_Aircraft_Owner_3_Local(__in,__cfg).__ENH_Aircraft_Owner_3;
  END;
  SHARED B_Bankruptcy_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_2(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_3(__in,__cfg).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local(__in,__cfg).__ENH_Bankruptcy_3;
  END;
  SHARED B_Business_Prox_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Prox_2(__in,__cfg))
    SHARED TYPEOF(B_Business_Prox_3(__in,__cfg).__ENH_Business_Prox_3) __ENH_Business_Prox_3 := B_Business_Prox_3_Local(__in,__cfg).__ENH_Business_Prox_3;
    SHARED TYPEOF(E_Prox_Phone_Number(__in,__cfg).__Result) __E_Prox_Phone_Number := E_Prox_Phone_Number_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Prox_T_I_N(__in,__cfg).__Result) __E_Prox_T_I_N := E_Prox_T_I_N_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Business_Sele_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_2(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_3(__in,__cfg).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local(__in,__cfg).__ENH_Bankruptcy_3;
    SHARED TYPEOF(B_Business_Prox_3(__in,__cfg).__ENH_Business_Prox_3) __ENH_Business_Prox_3 := B_Business_Prox_3_Local(__in,__cfg).__ENH_Business_Prox_3;
    SHARED TYPEOF(B_Business_Sele_3(__in,__cfg).__ENH_Business_Sele_3) __ENH_Business_Sele_3 := B_Business_Sele_3_Local(__in,__cfg).__ENH_Business_Sele_3;
    SHARED TYPEOF(E_Sele_Bankruptcy(__in,__cfg).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Sele_Person_3(__in,__cfg).__ENH_Sele_Person_3) __ENH_Sele_Person_3 := B_Sele_Person_3_Local(__in,__cfg).__ENH_Sele_Person_3;
    SHARED TYPEOF(E_Sele_Phone_Number(__in,__cfg).__Result) __E_Sele_Phone_Number := E_Sele_Phone_Number_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Sele_T_I_N(__in,__cfg).__Result) __E_Sele_T_I_N := E_Sele_T_I_N_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Sele_Tradeline_3(__in,__cfg).__ENH_Sele_Tradeline_3) __ENH_Sele_Tradeline_3 := B_Sele_Tradeline_3_Local(__in,__cfg).__ENH_Sele_Tradeline_3;
    SHARED TYPEOF(B_Sele_Vehicle_3(__in,__cfg).__ENH_Sele_Vehicle_3) __ENH_Sele_Vehicle_3 := B_Sele_Vehicle_3_Local(__in,__cfg).__ENH_Sele_Vehicle_3;
    SHARED TYPEOF(B_Tradeline_3(__in,__cfg).__ENH_Tradeline_3) __ENH_Tradeline_3 := B_Tradeline_3_Local(__in,__cfg).__ENH_Tradeline_3;
  END;
  SHARED B_Criminal_Offense_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense_2(__in,__cfg))
    SHARED TYPEOF(B_Criminal_Offense_3(__in,__cfg).__ENH_Criminal_Offense_3) __ENH_Criminal_Offense_3 := B_Criminal_Offense_3_Local(__in,__cfg).__ENH_Criminal_Offense_3;
  END;
  SHARED B_Lien_Judgment_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Lien_Judgment_2(__in,__cfg))
    SHARED TYPEOF(B_Lien_Judgment_3(__in,__cfg).__ENH_Lien_Judgment_3) __ENH_Lien_Judgment_3 := B_Lien_Judgment_3_Local(__in,__cfg).__ENH_Lien_Judgment_3;
  END;
  SHARED B_Person_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_2(__in,__cfg))
    SHARED TYPEOF(B_Aircraft_Owner_3(__in,__cfg).__ENH_Aircraft_Owner_3) __ENH_Aircraft_Owner_3 := B_Aircraft_Owner_3_Local(__in,__cfg).__ENH_Aircraft_Owner_3;
    SHARED TYPEOF(B_Bankruptcy_3(__in,__cfg).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local(__in,__cfg).__ENH_Bankruptcy_3;
    SHARED TYPEOF(B_Criminal_Offense_3(__in,__cfg).__ENH_Criminal_Offense_3) __ENH_Criminal_Offense_3 := B_Criminal_Offense_3_Local(__in,__cfg).__ENH_Criminal_Offense_3;
    SHARED TYPEOF(B_Person_3(__in,__cfg).__ENH_Person_3) __ENH_Person_3 := B_Person_3_Local(__in,__cfg).__ENH_Person_3;
    SHARED TYPEOF(E_Person_Address(__in,__cfg).__Result) __E_Person_Address := E_Person_Address_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Person_Vehicle_3(__in,__cfg).__ENH_Person_Vehicle_3) __ENH_Person_Vehicle_3 := B_Person_Vehicle_3_Local(__in,__cfg).__ENH_Person_Vehicle_3;
    SHARED TYPEOF(B_Professional_License_3(__in,__cfg).__ENH_Professional_License_3) __ENH_Professional_License_3 := B_Professional_License_3_Local(__in,__cfg).__ENH_Professional_License_3;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Watercraft_Owner_3(__in,__cfg).__ENH_Watercraft_Owner_3) __ENH_Watercraft_Owner_3 := B_Watercraft_Owner_3_Local(__in,__cfg).__ENH_Watercraft_Owner_3;
  END;
  SHARED B_Person_Vehicle_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_Vehicle_2(__in,__cfg))
    SHARED TYPEOF(B_Person_Vehicle_3(__in,__cfg).__ENH_Person_Vehicle_3) __ENH_Person_Vehicle_3 := B_Person_Vehicle_3_Local(__in,__cfg).__ENH_Person_Vehicle_3;
  END;
  SHARED B_Professional_License_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Professional_License_2(__in,__cfg))
    SHARED TYPEOF(B_Professional_License_3(__in,__cfg).__ENH_Professional_License_3) __ENH_Professional_License_3 := B_Professional_License_3_Local(__in,__cfg).__ENH_Professional_License_3;
  END;
  SHARED B_Sele_Person_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Person_2(__in,__cfg))
    SHARED TYPEOF(B_Sele_Person_3(__in,__cfg).__ENH_Sele_Person_3) __ENH_Sele_Person_3 := B_Sele_Person_3_Local(__in,__cfg).__ENH_Sele_Person_3;
  END;
  SHARED B_Sele_Tradeline_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Tradeline_2(__in,__cfg))
    SHARED TYPEOF(B_Sele_Tradeline_3(__in,__cfg).__ENH_Sele_Tradeline_3) __ENH_Sele_Tradeline_3 := B_Sele_Tradeline_3_Local(__in,__cfg).__ENH_Sele_Tradeline_3;
  END;
  SHARED B_Sele_U_C_C_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_U_C_C_2(__in,__cfg))
    SHARED TYPEOF(B_Sele_U_C_C_3(__in,__cfg).__ENH_Sele_U_C_C_3) __ENH_Sele_U_C_C_3 := B_Sele_U_C_C_3_Local(__in,__cfg).__ENH_Sele_U_C_C_3;
  END;
  SHARED B_Sele_Vehicle_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Vehicle_2(__in,__cfg))
    SHARED TYPEOF(B_Sele_Vehicle_3(__in,__cfg).__ENH_Sele_Vehicle_3) __ENH_Sele_Vehicle_3 := B_Sele_Vehicle_3_Local(__in,__cfg).__ENH_Sele_Vehicle_3;
  END;
  SHARED B_Tradeline_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_2(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_3(__in,__cfg).__ENH_Tradeline_3) __ENH_Tradeline_3 := B_Tradeline_3_Local(__in,__cfg).__ENH_Tradeline_3;
  END;
  SHARED B_U_C_C_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_U_C_C_2(__in,__cfg))
    SHARED TYPEOF(B_U_C_C_3(__in,__cfg).__ENH_U_C_C_3) __ENH_U_C_C_3 := B_U_C_C_3_Local(__in,__cfg).__ENH_U_C_C_3;
  END;
  SHARED B_Watercraft_Owner_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Watercraft_Owner_2(__in,__cfg))
    SHARED TYPEOF(B_Watercraft_Owner_3(__in,__cfg).__ENH_Watercraft_Owner_3) __ENH_Watercraft_Owner_3 := B_Watercraft_Owner_3_Local(__in,__cfg).__ENH_Watercraft_Owner_3;
  END;
  SHARED B_Aircraft_Owner_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Aircraft_Owner_1(__in,__cfg))
    SHARED TYPEOF(B_Aircraft_Owner_2(__in,__cfg).__ENH_Aircraft_Owner_2) __ENH_Aircraft_Owner_2 := B_Aircraft_Owner_2_Local(__in,__cfg).__ENH_Aircraft_Owner_2;
  END;
  SHARED B_Bankruptcy_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_1(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_2(__in,__cfg).__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local(__in,__cfg).__ENH_Bankruptcy_2;
  END;
  SHARED B_Business_Prox_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Prox_1(__in,__cfg))
    SHARED TYPEOF(B_Business_Prox_2(__in,__cfg).__ENH_Business_Prox_2) __ENH_Business_Prox_2 := B_Business_Prox_2_Local(__in,__cfg).__ENH_Business_Prox_2;
  END;
  SHARED B_Business_Sele_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_1(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_2(__in,__cfg).__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local(__in,__cfg).__ENH_Bankruptcy_2;
    SHARED TYPEOF(B_Business_Prox_2(__in,__cfg).__ENH_Business_Prox_2) __ENH_Business_Prox_2 := B_Business_Prox_2_Local(__in,__cfg).__ENH_Business_Prox_2;
    SHARED TYPEOF(B_Business_Sele_2(__in,__cfg).__ENH_Business_Sele_2) __ENH_Business_Sele_2 := B_Business_Sele_2_Local(__in,__cfg).__ENH_Business_Sele_2;
    SHARED TYPEOF(B_Person_2(__in,__cfg).__ENH_Person_2) __ENH_Person_2 := B_Person_2_Local(__in,__cfg).__ENH_Person_2;
    SHARED TYPEOF(E_Person_Education(__in,__cfg).__Result) __E_Person_Education := E_Person_Education_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Person_Email(__in,__cfg).__Result) __E_Person_Email := E_Person_Email_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Sele_Bankruptcy(__in,__cfg).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Sele_Person_2(__in,__cfg).__ENH_Sele_Person_2) __ENH_Sele_Person_2 := B_Sele_Person_2_Local(__in,__cfg).__ENH_Sele_Person_2;
    SHARED TYPEOF(B_Sele_Tradeline_2(__in,__cfg).__ENH_Sele_Tradeline_2) __ENH_Sele_Tradeline_2 := B_Sele_Tradeline_2_Local(__in,__cfg).__ENH_Sele_Tradeline_2;
    SHARED TYPEOF(B_Sele_U_C_C_2(__in,__cfg).__ENH_Sele_U_C_C_2) __ENH_Sele_U_C_C_2 := B_Sele_U_C_C_2_Local(__in,__cfg).__ENH_Sele_U_C_C_2;
    SHARED TYPEOF(B_Sele_Vehicle_2(__in,__cfg).__ENH_Sele_Vehicle_2) __ENH_Sele_Vehicle_2 := B_Sele_Vehicle_2_Local(__in,__cfg).__ENH_Sele_Vehicle_2;
    SHARED TYPEOF(B_Tradeline_2(__in,__cfg).__ENH_Tradeline_2) __ENH_Tradeline_2 := B_Tradeline_2_Local(__in,__cfg).__ENH_Tradeline_2;
    SHARED TYPEOF(B_U_C_C_2(__in,__cfg).__ENH_U_C_C_2) __ENH_U_C_C_2 := B_U_C_C_2_Local(__in,__cfg).__ENH_U_C_C_2;
  END;
  SHARED B_Criminal_Offense_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense_1(__in,__cfg))
    SHARED TYPEOF(B_Criminal_Offense_2(__in,__cfg).__ENH_Criminal_Offense_2) __ENH_Criminal_Offense_2 := B_Criminal_Offense_2_Local(__in,__cfg).__ENH_Criminal_Offense_2;
  END;
  SHARED B_Lien_Judgment_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Lien_Judgment_1(__in,__cfg))
    SHARED TYPEOF(B_Lien_Judgment_2(__in,__cfg).__ENH_Lien_Judgment_2) __ENH_Lien_Judgment_2 := B_Lien_Judgment_2_Local(__in,__cfg).__ENH_Lien_Judgment_2;
  END;
  SHARED B_Person_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_1(__in,__cfg))
    SHARED TYPEOF(B_Aircraft_Owner_2(__in,__cfg).__ENH_Aircraft_Owner_2) __ENH_Aircraft_Owner_2 := B_Aircraft_Owner_2_Local(__in,__cfg).__ENH_Aircraft_Owner_2;
    SHARED TYPEOF(B_Bankruptcy_2(__in,__cfg).__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local(__in,__cfg).__ENH_Bankruptcy_2;
    SHARED TYPEOF(B_Criminal_Offense_2(__in,__cfg).__ENH_Criminal_Offense_2) __ENH_Criminal_Offense_2 := B_Criminal_Offense_2_Local(__in,__cfg).__ENH_Criminal_Offense_2;
    SHARED TYPEOF(B_Person_2(__in,__cfg).__ENH_Person_2) __ENH_Person_2 := B_Person_2_Local(__in,__cfg).__ENH_Person_2;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Person_Vehicle_2(__in,__cfg).__ENH_Person_Vehicle_2) __ENH_Person_Vehicle_2 := B_Person_Vehicle_2_Local(__in,__cfg).__ENH_Person_Vehicle_2;
    SHARED TYPEOF(B_Professional_License_2(__in,__cfg).__ENH_Professional_License_2) __ENH_Professional_License_2 := B_Professional_License_2_Local(__in,__cfg).__ENH_Professional_License_2;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Watercraft_Owner_2(__in,__cfg).__ENH_Watercraft_Owner_2) __ENH_Watercraft_Owner_2 := B_Watercraft_Owner_2_Local(__in,__cfg).__ENH_Watercraft_Owner_2;
  END;
  SHARED B_Person_Vehicle_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_Vehicle_1(__in,__cfg))
    SHARED TYPEOF(B_Person_Vehicle_2(__in,__cfg).__ENH_Person_Vehicle_2) __ENH_Person_Vehicle_2 := B_Person_Vehicle_2_Local(__in,__cfg).__ENH_Person_Vehicle_2;
  END;
  SHARED B_Professional_License_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Professional_License_1(__in,__cfg))
    SHARED TYPEOF(B_Professional_License_2(__in,__cfg).__ENH_Professional_License_2) __ENH_Professional_License_2 := B_Professional_License_2_Local(__in,__cfg).__ENH_Professional_License_2;
  END;
  SHARED B_Sele_Tradeline_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Tradeline_1(__in,__cfg))
    SHARED TYPEOF(B_Sele_Tradeline_2(__in,__cfg).__ENH_Sele_Tradeline_2) __ENH_Sele_Tradeline_2 := B_Sele_Tradeline_2_Local(__in,__cfg).__ENH_Sele_Tradeline_2;
  END;
  SHARED B_Sele_Vehicle_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Vehicle_1(__in,__cfg))
    SHARED TYPEOF(B_Sele_Vehicle_2(__in,__cfg).__ENH_Sele_Vehicle_2) __ENH_Sele_Vehicle_2 := B_Sele_Vehicle_2_Local(__in,__cfg).__ENH_Sele_Vehicle_2;
  END;
  SHARED B_Tradeline_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_1(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_2(__in,__cfg).__ENH_Tradeline_2) __ENH_Tradeline_2 := B_Tradeline_2_Local(__in,__cfg).__ENH_Tradeline_2;
  END;
  SHARED B_U_C_C_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_U_C_C_1(__in,__cfg))
    SHARED TYPEOF(B_U_C_C_2(__in,__cfg).__ENH_U_C_C_2) __ENH_U_C_C_2 := B_U_C_C_2_Local(__in,__cfg).__ENH_U_C_C_2;
  END;
  SHARED B_Watercraft_Owner_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Watercraft_Owner_1(__in,__cfg))
    SHARED TYPEOF(B_Watercraft_Owner_2(__in,__cfg).__ENH_Watercraft_Owner_2) __ENH_Watercraft_Owner_2 := B_Watercraft_Owner_2_Local(__in,__cfg).__ENH_Watercraft_Owner_2;
  END;
  SHARED B_Bankruptcy_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_1(__in,__cfg).__ENH_Bankruptcy_1) __ENH_Bankruptcy_1 := B_Bankruptcy_1_Local(__in,__cfg).__ENH_Bankruptcy_1;
  END;
  SHARED B_Business_Prox_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Prox(__in,__cfg))
    SHARED TYPEOF(B_Business_Prox_1(__in,__cfg).__ENH_Business_Prox_1) __ENH_Business_Prox_1 := B_Business_Prox_1_Local(__in,__cfg).__ENH_Business_Prox_1;
  END;
  SHARED B_Business_Sele_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_1(__in,__cfg).__ENH_Bankruptcy_1) __ENH_Bankruptcy_1 := B_Bankruptcy_1_Local(__in,__cfg).__ENH_Bankruptcy_1;
    SHARED TYPEOF(B_Business_Sele_1(__in,__cfg).__ENH_Business_Sele_1) __ENH_Business_Sele_1 := B_Business_Sele_1_Local(__in,__cfg).__ENH_Business_Sele_1;
    SHARED TYPEOF(E_Sele_Aircraft(__in,__cfg).__Result) __E_Sele_Aircraft := E_Sele_Aircraft_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Sele_Bankruptcy(__in,__cfg).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Sele_Tradeline_1(__in,__cfg).__ENH_Sele_Tradeline_1) __ENH_Sele_Tradeline_1 := B_Sele_Tradeline_1_Local(__in,__cfg).__ENH_Sele_Tradeline_1;
    SHARED TYPEOF(B_Sele_Vehicle_1(__in,__cfg).__ENH_Sele_Vehicle_1) __ENH_Sele_Vehicle_1 := B_Sele_Vehicle_1_Local(__in,__cfg).__ENH_Sele_Vehicle_1;
    SHARED TYPEOF(E_Sele_Watercraft(__in,__cfg).__Result) __E_Sele_Watercraft := E_Sele_Watercraft_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Tradeline_1(__in,__cfg).__ENH_Tradeline_1) __ENH_Tradeline_1 := B_Tradeline_1_Local(__in,__cfg).__ENH_Tradeline_1;
    SHARED TYPEOF(E_Vehicle(__in,__cfg).__Result) __E_Vehicle := E_Vehicle_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Criminal_Offense_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense(__in,__cfg))
    SHARED TYPEOF(B_Criminal_Offense_1(__in,__cfg).__ENH_Criminal_Offense_1) __ENH_Criminal_Offense_1 := B_Criminal_Offense_1_Local(__in,__cfg).__ENH_Criminal_Offense_1;
  END;
  SHARED B_First_Degree_Relative_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_First_Degree_Relative(__in,__cfg))
    SHARED TYPEOF(E_First_Degree_Associations(__in,__cfg).__Result) __E_First_Degree_Associations := E_First_Degree_Associations_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Lien_Judgment_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Lien_Judgment(__in,__cfg))
    SHARED TYPEOF(B_Lien_Judgment_1(__in,__cfg).__ENH_Lien_Judgment_1) __ENH_Lien_Judgment_1 := B_Lien_Judgment_1_Local(__in,__cfg).__ENH_Lien_Judgment_1;
  END;
  SHARED B_Person_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person(__in,__cfg))
    SHARED TYPEOF(B_Aircraft_Owner_1(__in,__cfg).__ENH_Aircraft_Owner_1) __ENH_Aircraft_Owner_1 := B_Aircraft_Owner_1_Local(__in,__cfg).__ENH_Aircraft_Owner_1;
    SHARED TYPEOF(B_Bankruptcy_1(__in,__cfg).__ENH_Bankruptcy_1) __ENH_Bankruptcy_1 := B_Bankruptcy_1_Local(__in,__cfg).__ENH_Bankruptcy_1;
    SHARED TYPEOF(B_Criminal_Offense_1(__in,__cfg).__ENH_Criminal_Offense_1) __ENH_Criminal_Offense_1 := B_Criminal_Offense_1_Local(__in,__cfg).__ENH_Criminal_Offense_1;
    SHARED TYPEOF(B_Person_1(__in,__cfg).__ENH_Person_1) __ENH_Person_1 := B_Person_1_Local(__in,__cfg).__ENH_Person_1;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Person_Vehicle_1(__in,__cfg).__ENH_Person_Vehicle_1) __ENH_Person_Vehicle_1 := B_Person_Vehicle_1_Local(__in,__cfg).__ENH_Person_Vehicle_1;
    SHARED TYPEOF(B_Professional_License_1(__in,__cfg).__ENH_Professional_License_1) __ENH_Professional_License_1 := B_Professional_License_1_Local(__in,__cfg).__ENH_Professional_License_1;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Watercraft_Owner_1(__in,__cfg).__ENH_Watercraft_Owner_1) __ENH_Watercraft_Owner_1 := B_Watercraft_Owner_1_Local(__in,__cfg).__ENH_Watercraft_Owner_1;
  END;
  SHARED B_Professional_License_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Professional_License(__in,__cfg))
    SHARED TYPEOF(B_Professional_License_1(__in,__cfg).__ENH_Professional_License_1) __ENH_Professional_License_1 := B_Professional_License_1_Local(__in,__cfg).__ENH_Professional_License_1;
  END;
  SHARED B_Second_Degree_Associations_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Second_Degree_Associations(__in,__cfg))
    SHARED TYPEOF(E_First_Degree_Associations(__in,__cfg).__Result) __E_First_Degree_Associations := E_First_Degree_Associations_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Tradeline_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_1(__in,__cfg).__ENH_Tradeline_1) __ENH_Tradeline_1 := B_Tradeline_1_Local(__in,__cfg).__ENH_Tradeline_1;
  END;
  SHARED B_U_C_C_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_U_C_C(__in,__cfg))
    SHARED TYPEOF(B_U_C_C_1(__in,__cfg).__ENH_U_C_C_1) __ENH_U_C_C_1 := B_U_C_C_1_Local(__in,__cfg).__ENH_U_C_C_1;
  END;
  SHARED TYPEOF(E_Accident(__in,__cfg_Local).__Result) __E_Accident := E_Accident_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Address(__in,__cfg_Local).__Result) __E_Address := E_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Address_Inquiry(__in,__cfg_Local).__Result) __E_Address_Inquiry := E_Address_Inquiry_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Address_Phone(__in,__cfg_Local).__Result) __E_Address_Phone := E_Address_Phone_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Address_Property(__in,__cfg_Local).__Result) __E_Address_Property := E_Address_Property_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Address_Property_Event(__in,__cfg_Local).__Result) __E_Address_Property_Event := E_Address_Property_Event_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Aircraft(__in,__cfg_Local).__Result) __E_Aircraft := E_Aircraft_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Aircraft_Owner(__in,__cfg_Local).__Result) __E_Aircraft_Owner := E_Aircraft_Owner_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Bankruptcy(__in,__cfg_Local).__ENH_Bankruptcy) __ENH_Bankruptcy := B_Bankruptcy_Local(__in,__cfg_Local).__ENH_Bankruptcy;
  SHARED TYPEOF(E_Bankruptcy(__in,__cfg_Local).__Result) __E_Bankruptcy := E_Bankruptcy_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Business_Prox(__in,__cfg_Local).__ENH_Business_Prox) __ENH_Business_Prox := B_Business_Prox_Local(__in,__cfg_Local).__ENH_Business_Prox;
  SHARED TYPEOF(E_Business_Prox(__in,__cfg_Local).__Result) __E_Business_Prox := E_Business_Prox_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Business_Sele(__in,__cfg_Local).__ENH_Business_Sele) __ENH_Business_Sele := B_Business_Sele_Local(__in,__cfg_Local).__ENH_Business_Sele;
  SHARED TYPEOF(E_Business_Sele(__in,__cfg_Local).__Result) __E_Business_Sele := E_Business_Sele_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Criminal_Details(__in,__cfg_Local).__Result) __E_Criminal_Details := E_Criminal_Details_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Criminal_Offender(__in,__cfg_Local).__Result) __E_Criminal_Offender := E_Criminal_Offender_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Criminal_Offense(__in,__cfg_Local).__ENH_Criminal_Offense) __ENH_Criminal_Offense := B_Criminal_Offense_Local(__in,__cfg_Local).__ENH_Criminal_Offense;
  SHARED TYPEOF(E_Criminal_Offense(__in,__cfg_Local).__Result) __E_Criminal_Offense := E_Criminal_Offense_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Criminal_Punishment(__in,__cfg_Local).__Result) __E_Criminal_Punishment := E_Criminal_Punishment_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Drivers_License(__in,__cfg_Local).__Result) __E_Drivers_License := E_Drivers_License_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Education(__in,__cfg_Local).__Result) __E_Education := E_Education_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Email(__in,__cfg_Local).__Result) __E_Email := E_Email_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Employment(__in,__cfg_Local).__Result) __E_Employment := E_Employment_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Employment_Person(__in,__cfg_Local).__Result) __E_Employment_Person := E_Employment_Person_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_First_Degree_Associations(__in,__cfg_Local).__Result) __E_First_Degree_Associations := E_First_Degree_Associations_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_First_Degree_Relative(__in,__cfg_Local).__ENH_First_Degree_Relative) __ENH_First_Degree_Relative := B_First_Degree_Relative_Local(__in,__cfg_Local).__ENH_First_Degree_Relative;
  SHARED TYPEOF(E_First_Degree_Relative(__in,__cfg_Local).__Result) __E_First_Degree_Relative := E_First_Degree_Relative_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_House_Hold_Phone(__in,__cfg_Local).__Result) __E_House_Hold_Phone := E_House_Hold_Phone_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Household(__in,__cfg_Local).__Result) __E_Household := E_Household_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Household_Member(__in,__cfg_Local).__Result) __E_Household_Member := E_Household_Member_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Inquiry(__in,__cfg_Local).__Result) __E_Inquiry := E_Inquiry_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Lien_Judgment(__in,__cfg_Local).__ENH_Lien_Judgment) __ENH_Lien_Judgment := B_Lien_Judgment_Local(__in,__cfg_Local).__ENH_Lien_Judgment;
  SHARED TYPEOF(E_Lien_Judgment(__in,__cfg_Local).__Result) __E_Lien_Judgment := E_Lien_Judgment_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Person(__in,__cfg_Local).__ENH_Person) __ENH_Person := B_Person_Local(__in,__cfg_Local).__ENH_Person;
  SHARED TYPEOF(E_Person(__in,__cfg_Local).__Result) __E_Person := E_Person_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Accident(__in,__cfg_Local).__Result) __E_Person_Accident := E_Person_Accident_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Address(__in,__cfg_Local).__Result) __E_Person_Address := E_Person_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Drivers_License(__in,__cfg_Local).__Result) __E_Person_Drivers_License := E_Person_Drivers_License_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Education(__in,__cfg_Local).__Result) __E_Person_Education := E_Person_Education_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Email(__in,__cfg_Local).__Result) __E_Person_Email := E_Person_Email_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Email_Phone_Address(__in,__cfg_Local).__Result) __E_Person_Email_Phone_Address := E_Person_Email_Phone_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Inquiry(__in,__cfg_Local).__Result) __E_Person_Inquiry := E_Person_Inquiry_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Lien_Judgment(__in,__cfg_Local).__Result) __E_Person_Lien_Judgment := E_Person_Lien_Judgment_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Offender(__in,__cfg_Local).__Result) __E_Person_Offender := E_Person_Offender_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Offenses(__in,__cfg_Local).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Phone(__in,__cfg_Local).__Result) __E_Person_Phone := E_Person_Phone_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Property(__in,__cfg_Local).__Result) __E_Person_Property := E_Person_Property_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Property_Event(__in,__cfg_Local).__Result) __E_Person_Property_Event := E_Person_Property_Event_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_S_S_N(__in,__cfg_Local).__Result) __E_Person_S_S_N := E_Person_S_S_N_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_U_C_C(__in,__cfg_Local).__Result) __E_Person_U_C_C := E_Person_U_C_C_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Vehicle(__in,__cfg_Local).__Result) __E_Person_Vehicle := E_Person_Vehicle_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Phone(__in,__cfg_Local).__Result) __E_Phone := E_Phone_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Phone_Inquiry(__in,__cfg_Local).__Result) __E_Phone_Inquiry := E_Phone_Inquiry_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Professional_License(__in,__cfg_Local).__ENH_Professional_License) __ENH_Professional_License := B_Professional_License_Local(__in,__cfg_Local).__ENH_Professional_License;
  SHARED TYPEOF(E_Professional_License(__in,__cfg_Local).__Result) __E_Professional_License := E_Professional_License_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Professional_License_Person(__in,__cfg_Local).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Property(__in,__cfg_Local).__Result) __E_Property := E_Property_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Property_Event(__in,__cfg_Local).__Result) __E_Property_Event := E_Property_Event_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Prox_Address(__in,__cfg_Local).__Result) __E_Prox_Address := E_Prox_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Prox_Email(__in,__cfg_Local).__Result) __E_Prox_Email := E_Prox_Email_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Prox_Person(__in,__cfg_Local).__Result) __E_Prox_Person := E_Prox_Person_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Prox_Phone_Number(__in,__cfg_Local).__Result) __E_Prox_Phone_Number := E_Prox_Phone_Number_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Prox_T_I_N(__in,__cfg_Local).__Result) __E_Prox_T_I_N := E_Prox_T_I_N_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Prox_Utility(__in,__cfg_Local).__Result) __E_Prox_Utility := E_Prox_Utility_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_S_S_N_Address(__in,__cfg_Local).__Result) __E_S_S_N_Address := E_S_S_N_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_S_S_N_Inquiry(__in,__cfg_Local).__Result) __E_S_S_N_Inquiry := E_S_S_N_Inquiry_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Second_Degree_Associations(__in,__cfg_Local).__ENH_Second_Degree_Associations) __ENH_Second_Degree_Associations := B_Second_Degree_Associations_Local(__in,__cfg_Local).__ENH_Second_Degree_Associations;
  SHARED TYPEOF(E_Second_Degree_Associations(__in,__cfg_Local).__Result) __E_Second_Degree_Associations := E_Second_Degree_Associations_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Address(__in,__cfg_Local).__Result) __E_Sele_Address := E_Sele_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Aircraft(__in,__cfg_Local).__Result) __E_Sele_Aircraft := E_Sele_Aircraft_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Bankruptcy(__in,__cfg_Local).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Email(__in,__cfg_Local).__Result) __E_Sele_Email := E_Sele_Email_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Lien_Judgment(__in,__cfg_Local).__Result) __E_Sele_Lien_Judgment := E_Sele_Lien_Judgment_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Person(__in,__cfg_Local).__Result) __E_Sele_Person := E_Sele_Person_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Phone_Number(__in,__cfg_Local).__Result) __E_Sele_Phone_Number := E_Sele_Phone_Number_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Property(__in,__cfg_Local).__Result) __E_Sele_Property := E_Sele_Property_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Property_Event(__in,__cfg_Local).__Result) __E_Sele_Property_Event := E_Sele_Property_Event_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_T_I_N(__in,__cfg_Local).__Result) __E_Sele_T_I_N := E_Sele_T_I_N_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg_Local).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_U_C_C(__in,__cfg_Local).__Result) __E_Sele_U_C_C := E_Sele_U_C_C_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Utility(__in,__cfg_Local).__Result) __E_Sele_Utility := E_Sele_Utility_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Vehicle(__in,__cfg_Local).__Result) __E_Sele_Vehicle := E_Sele_Vehicle_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Watercraft(__in,__cfg_Local).__Result) __E_Sele_Watercraft := E_Sele_Watercraft_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Social_Security_Number(__in,__cfg_Local).__Result) __E_Social_Security_Number := E_Social_Security_Number_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_T_I_N(__in,__cfg_Local).__Result) __E_T_I_N := E_T_I_N_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_T_I_N_Address(__in,__cfg_Local).__Result) __E_T_I_N_Address := E_T_I_N_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_T_I_N_Phone_Number(__in,__cfg_Local).__Result) __E_T_I_N_Phone_Number := E_T_I_N_Phone_Number_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Tradeline(__in,__cfg_Local).__ENH_Tradeline) __ENH_Tradeline := B_Tradeline_Local(__in,__cfg_Local).__ENH_Tradeline;
  SHARED TYPEOF(E_Tradeline(__in,__cfg_Local).__Result) __E_Tradeline := E_Tradeline_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_U_C_C(__in,__cfg_Local).__ENH_U_C_C) __ENH_U_C_C := B_U_C_C_Local(__in,__cfg_Local).__ENH_U_C_C;
  SHARED TYPEOF(E_U_C_C(__in,__cfg_Local).__Result) __E_U_C_C := E_U_C_C_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Utility(__in,__cfg_Local).__Result) __E_Utility := E_Utility_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Utility_Address(__in,__cfg_Local).__Result) __E_Utility_Address := E_Utility_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Utility_Person(__in,__cfg_Local).__Result) __E_Utility_Person := E_Utility_Person_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Vehicle(__in,__cfg_Local).__Result) __E_Vehicle := E_Vehicle_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Watercraft(__in,__cfg_Local).__Result) __E_Watercraft := E_Watercraft_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Watercraft_Owner(__in,__cfg_Local).__Result) __E_Watercraft_Owner := E_Watercraft_Owner_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Zip_Code(__in,__cfg_Local).__Result) __E_Zip_Code := E_Zip_Code_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Zip_Code_Person(__in,__cfg_Local).__Result) __E_Zip_Code_Person := E_Zip_Code_Person_Filtered(__in,__cfg_Local).__Result;
  SHARED __EE2757528 := __E_Inquiry;
  SHARED __EE2757518 := __E_Address_Inquiry;
  SHARED __EE2757703 := __EE2757518(__NN(__EE2757518.Location_) AND __NN(__EE2757518.Inquiry_));
  SHARED __EE2757512 := __E_Address;
  SHARED __EE2757768 := __EE2757512(__T(__OP2(__EE2757512.UID,=,__CN(1))));
  __JC2757774(E_Address_Inquiry(__in,__cfg_Local).Layout __EE2757703, E_Address(__in,__cfg_Local).Layout __EE2757768) := __EEQP(__EE2757768.UID,__EE2757703.Location_);
  SHARED __EE2757788 := JOIN(__EE2757703,__EE2757768,__JC2757774(LEFT,RIGHT),TRANSFORM(E_Address_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC2757794(E_Inquiry(__in,__cfg_Local).Layout __EE2757528, E_Address_Inquiry(__in,__cfg_Local).Layout __EE2757788) := __EEQP(__EE2757788.Inquiry_,__EE2757528.UID);
  SHARED __EE2757815 := JOIN(__EE2757528,__EE2757788,__JC2757794(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE2757817 := __EE2757815;
  EXPORT Res0 := __UNWRAP(__EE2757817);
  SHARED __EE2757961 := __E_Phone;
  SHARED __EE2757951 := __E_Address_Phone;
  SHARED __EE2758237 := __EE2757951(__NN(__EE2757951.Location_) AND __NN(__EE2757951.Phone_Number_));
  SHARED __EE2757945 := __E_Address;
  SHARED __EE2758348 := __EE2757945(__T(__OP2(__EE2757945.UID,=,__CN(1))));
  __JC2758354(E_Address_Phone(__in,__cfg_Local).Layout __EE2758237, E_Address(__in,__cfg_Local).Layout __EE2758348) := __EEQP(__EE2758348.UID,__EE2758237.Location_);
  SHARED __EE2758382 := JOIN(__EE2758237,__EE2758348,__JC2758354(LEFT,RIGHT),TRANSFORM(E_Address_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC2758388(E_Phone(__in,__cfg_Local).Layout __EE2757961, E_Address_Phone(__in,__cfg_Local).Layout __EE2758382) := __EEQP(__EE2758382.Phone_Number_,__EE2757961.UID);
  SHARED __EE2758441 := JOIN(__EE2757961,__EE2758382,__JC2758388(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE2758443 := __EE2758441;
  EXPORT Res1 := __UNWRAP(__EE2758443);
  SHARED __EE2758688 := __E_Property;
  SHARED __EE2758678 := __E_Address_Property;
  SHARED __EE2758917 := __EE2758678(__NN(__EE2758678.Location_) AND __NN(__EE2758678.Prop_));
  SHARED __EE2758672 := __E_Address;
  SHARED __EE2759007 := __EE2758672(__T(__OP2(__EE2758672.UID,=,__CN(1))));
  __JC2759013(E_Address_Property(__in,__cfg_Local).Layout __EE2758917, E_Address(__in,__cfg_Local).Layout __EE2759007) := __EEQP(__EE2759007.UID,__EE2758917.Location_);
  SHARED __EE2759038 := JOIN(__EE2758917,__EE2759007,__JC2759013(LEFT,RIGHT),TRANSFORM(E_Address_Property(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC2759044(E_Property(__in,__cfg_Local).Layout __EE2758688, E_Address_Property(__in,__cfg_Local).Layout __EE2759038) := __EEQP(__EE2759038.Prop_,__EE2758688.UID);
  SHARED __EE2759079 := JOIN(__EE2758688,__EE2759038,__JC2759044(LEFT,RIGHT),TRANSFORM(E_Property(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE2759081 := __EE2759079;
  EXPORT Res2 := __UNWRAP(__EE2759081);
  SHARED __EE2759281 := __E_Property_Event;
  SHARED __EE2759271 := __E_Address_Property_Event;
  SHARED __EE2760094 := __EE2759271(__NN(__EE2759271.Location_) AND __NN(__EE2759271.Event_));
  SHARED __EE2759265 := __E_Address;
  SHARED __EE2760477 := __EE2759265(__T(__OP2(__EE2759265.UID,=,__CN(1))));
  __JC2760483(E_Address_Property_Event(__in,__cfg_Local).Layout __EE2760094, E_Address(__in,__cfg_Local).Layout __EE2760477) := __EEQP(__EE2760477.UID,__EE2760094.Location_);
  SHARED __EE2760508 := JOIN(__EE2760094,__EE2760477,__JC2760483(LEFT,RIGHT),TRANSFORM(E_Address_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC2760514(E_Property_Event(__in,__cfg_Local).Layout __EE2759281, E_Address_Property_Event(__in,__cfg_Local).Layout __EE2760508) := __EEQP(__EE2760508.Event_,__EE2759281.UID);
  SHARED __EE2760842 := JOIN(__EE2759281,__EE2760508,__JC2760514(LEFT,RIGHT),TRANSFORM(E_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE2760844 := __EE2760842;
  EXPORT Res3 := __UNWRAP(__EE2760844);
  SHARED __EE2761632 := __ENH_Person;
  SHARED __EE2761621 := __E_Person_Address;
  SHARED __EE2763273 := __EE2761621(__NN(__EE2761621.Location_) AND __NN(__EE2761621.Subject_));
  SHARED __EE2761615 := __E_Address;
  SHARED __EE2764044 := __EE2761615(__T(__OP2(__EE2761615.UID,=,__CN(1))));
  __JC2764050(E_Person_Address(__in,__cfg_Local).Layout __EE2763273, E_Address(__in,__cfg_Local).Layout __EE2764044) := __EEQP(__EE2764044.UID,__EE2763273.Location_);
  SHARED __EE2764097 := JOIN(__EE2763273,__EE2764044,__JC2764050(LEFT,RIGHT),TRANSFORM(E_Person_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC2764103(B_Person(__in,__cfg_Local).__ST99755_Layout __EE2761632, E_Person_Address(__in,__cfg_Local).Layout __EE2764097) := __EEQP(__EE2764097.Subject_,__EE2761632.UID);
  SHARED __EE2764797 := JOIN(__EE2761632,__EE2764097,__JC2764103(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST99755_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE2764799 := __EE2764797;
  EXPORT Res4 := __UNWRAP(__EE2764799);
  SHARED __EE2766568 := __ENH_Business_Prox;
  SHARED __EE2766557 := __E_Prox_Address;
  SHARED __EE2767330 := __EE2766557(__NN(__EE2766557.Location_) AND __NN(__EE2766557.Business_Location_));
  SHARED __EE2766551 := __E_Address;
  SHARED __EE2767673 := __EE2766551(__T(__OP2(__EE2766551.UID,=,__CN(1))));
  __JC2767679(E_Prox_Address(__in,__cfg_Local).Layout __EE2767330, E_Address(__in,__cfg_Local).Layout __EE2767673) := __EEQP(__EE2767673.UID,__EE2767330.Location_);
  SHARED __EE2767734 := JOIN(__EE2767330,__EE2767673,__JC2767679(LEFT,RIGHT),TRANSFORM(E_Prox_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC2767740(B_Business_Prox(__in,__cfg_Local).__ST75468_Layout __EE2766568, E_Prox_Address(__in,__cfg_Local).Layout __EE2767734) := __EEQP(__EE2767734.Business_Location_,__EE2766568.UID);
  SHARED __EE2767998 := JOIN(__EE2766568,__EE2767734,__JC2767740(LEFT,RIGHT),TRANSFORM(B_Business_Prox(__in,__cfg_Local).__ST75468_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE2768000 := __EE2767998;
  EXPORT Res5 := __UNWRAP(__EE2768000);
  SHARED __EE2768696 := __ENH_Business_Sele;
  SHARED __EE2768685 := __E_Sele_Address;
  SHARED __EE2771269 := __EE2768685(__NN(__EE2768685.Location_) AND __NN(__EE2768685.Legal_));
  SHARED __EE2768679 := __E_Address;
  SHARED __EE2772492 := __EE2768679(__T(__OP2(__EE2768679.UID,=,__CN(1))));
  __JC2772498(E_Sele_Address(__in,__cfg_Local).Layout __EE2771269, E_Address(__in,__cfg_Local).Layout __EE2772492) := __EEQP(__EE2772492.UID,__EE2771269.Location_);
  SHARED __EE2772553 := JOIN(__EE2771269,__EE2772492,__JC2772498(LEFT,RIGHT),TRANSFORM(E_Sele_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC2772559(B_Business_Sele(__in,__cfg_Local).__ST89332_Layout __EE2768696, E_Sele_Address(__in,__cfg_Local).Layout __EE2772553) := __EEQP(__EE2772553.Legal_,__EE2768696.UID);
  SHARED __EE2773697 := JOIN(__EE2768696,__EE2772553,__JC2772559(LEFT,RIGHT),TRANSFORM(B_Business_Sele(__in,__cfg_Local).__ST89332_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE2773699 := __EE2773697;
  EXPORT Res6 := __UNWRAP(__EE2773699);
  SHARED __EE2784902 := __E_T_I_N_Address;
  SHARED __EE2785063 := __EE2784902(__NN(__EE2784902.Tax_I_D_) AND __NN(__EE2784902.Location_));
  SHARED __EE2784896 := __E_Address;
  SHARED __EE2785109 := __EE2784896(__T(__OP2(__EE2784896.UID,=,__CN(1))));
  __JC2785115(E_T_I_N_Address(__in,__cfg_Local).Layout __EE2785063, E_Address(__in,__cfg_Local).Layout __EE2785109) := __EEQP(__EE2785109.UID,__EE2785063.Location_);
  SHARED __EE2785129 := JOIN(__EE2785063,__EE2785109,__JC2785115(LEFT,RIGHT),TRANSFORM(E_T_I_N_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE2785139 := PROJECT(TABLE(PROJECT(__EE2785129,TRANSFORM(E_T_I_N(__in,__cfg_Local).Layout,SELF.UID := LEFT.Tax_I_D_,SELF := LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),UID},UID,MERGE),E_T_I_N(__in,__cfg_Local).Layout);
  EXPORT Res7 := __UNWRAP(__EE2785139);
  SHARED __EE2785223 := __E_Utility;
  SHARED __EE2785213 := __E_Utility_Address;
  SHARED __EE2785378 := __EE2785213(__NN(__EE2785213.Location_) AND __NN(__EE2785213.Util_));
  SHARED __EE2785207 := __E_Address;
  SHARED __EE2785433 := __EE2785207(__T(__OP2(__EE2785207.UID,=,__CN(1))));
  __JC2785439(E_Utility_Address(__in,__cfg_Local).Layout __EE2785378, E_Address(__in,__cfg_Local).Layout __EE2785433) := __EEQP(__EE2785433.UID,__EE2785378.Location_);
  SHARED __EE2785453 := JOIN(__EE2785378,__EE2785433,__JC2785439(LEFT,RIGHT),TRANSFORM(E_Utility_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC2785459(E_Utility(__in,__cfg_Local).Layout __EE2785223, E_Utility_Address(__in,__cfg_Local).Layout __EE2785453) := __EEQP(__EE2785453.Util_,__EE2785223.UID);
  SHARED __EE2785470 := JOIN(__EE2785223,__EE2785453,__JC2785459(LEFT,RIGHT),TRANSFORM(E_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE2785472 := __EE2785470;
  EXPORT Res8 := __UNWRAP(__EE2785472);
  SHARED __EE2785597 := __E_Address;
  SHARED __EE2785587 := __E_Prox_Address;
  SHARED __EE2786080 := __EE2785587(__NN(__EE2785587.Business_Location_) AND __NN(__EE2785587.Location_));
  SHARED __EE2785581 := __ENH_Business_Prox;
  SHARED __EE2786285 := __EE2785581(__T(__OP2(__EE2785581.UID,=,__CN(1))));
  __JC2786291(E_Prox_Address(__in,__cfg_Local).Layout __EE2786080, B_Business_Prox(__in,__cfg_Local).__ST75468_Layout __EE2786285) := __EEQP(__EE2786285.UID,__EE2786080.Business_Location_);
  SHARED __EE2786346 := JOIN(__EE2786080,__EE2786285,__JC2786291(LEFT,RIGHT),TRANSFORM(E_Prox_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC2786352(E_Address(__in,__cfg_Local).Layout __EE2785597, E_Prox_Address(__in,__cfg_Local).Layout __EE2786346) := __EEQP(__EE2786346.Location_,__EE2785597.UID);
  SHARED __EE2786472 := JOIN(__EE2785597,__EE2786346,__JC2786352(LEFT,RIGHT),TRANSFORM(E_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE2786474 := __EE2786472;
  EXPORT Res9 := __UNWRAP(__EE2786474);
  SHARED __EE2786931 := __ENH_Person;
  SHARED __EE2786920 := __E_Prox_Person;
  SHARED __EE2788533 := __EE2786920(__NN(__EE2786920.Business_Location_) AND __NN(__EE2786920.Contact_));
  SHARED __EE2786914 := __ENH_Business_Prox;
  SHARED __EE2789285 := __EE2786914(__T(__OP2(__EE2786914.UID,=,__CN(1))));
  __JC2789291(E_Prox_Person(__in,__cfg_Local).Layout __EE2788533, B_Business_Prox(__in,__cfg_Local).__ST75468_Layout __EE2789285) := __EEQP(__EE2789285.UID,__EE2788533.Business_Location_);
  SHARED __EE2789319 := JOIN(__EE2788533,__EE2789285,__JC2789291(LEFT,RIGHT),TRANSFORM(E_Prox_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC2789325(B_Person(__in,__cfg_Local).__ST99755_Layout __EE2786931, E_Prox_Person(__in,__cfg_Local).Layout __EE2789319) := __EEQP(__EE2789319.Contact_,__EE2786931.UID);
  SHARED __EE2790019 := JOIN(__EE2786931,__EE2789319,__JC2789325(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST99755_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE2790021 := __EE2790019;
  EXPORT Res10 := __UNWRAP(__EE2790021);
  SHARED __EE2791817 := __E_Phone;
  SHARED __EE2791807 := __E_Prox_Phone_Number;
  SHARED __EE2792112 := __EE2791807(__NN(__EE2791807.Business_Location_) AND __NN(__EE2791807.Phone_Number_));
  SHARED __EE2791801 := __ENH_Business_Prox;
  SHARED __EE2792231 := __EE2791801(__T(__OP2(__EE2791801.UID,=,__CN(1))));
  __JC2792237(E_Prox_Phone_Number(__in,__cfg_Local).Layout __EE2792112, B_Business_Prox(__in,__cfg_Local).__ST75468_Layout __EE2792231) := __EEQP(__EE2792231.UID,__EE2792112.Business_Location_);
  SHARED __EE2792273 := JOIN(__EE2792112,__EE2792231,__JC2792237(LEFT,RIGHT),TRANSFORM(E_Prox_Phone_Number(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC2792279(E_Phone(__in,__cfg_Local).Layout __EE2791817, E_Prox_Phone_Number(__in,__cfg_Local).Layout __EE2792273) := __EEQP(__EE2792273.Phone_Number_,__EE2791817.UID);
  SHARED __EE2792332 := JOIN(__EE2791817,__EE2792273,__JC2792279(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE2792334 := __EE2792332;
  EXPORT Res11 := __UNWRAP(__EE2792334);
  SHARED __EE2792608 := __E_Prox_T_I_N;
  SHARED __EE2792767 := __EE2792608(__NN(__EE2792608.Tax_I_D_) AND __NN(__EE2792608.Business_Location_));
  SHARED __EE2792602 := __ENH_Business_Prox;
  SHARED __EE2792812 := __EE2792602(__T(__OP2(__EE2792602.UID,=,__CN(1))));
  __JC2792818(E_Prox_T_I_N(__in,__cfg_Local).Layout __EE2792767, B_Business_Prox(__in,__cfg_Local).__ST75468_Layout __EE2792812) := __EEQP(__EE2792812.UID,__EE2792767.Business_Location_);
  SHARED __EE2792831 := JOIN(__EE2792767,__EE2792812,__JC2792818(LEFT,RIGHT),TRANSFORM(E_Prox_T_I_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE2792841 := PROJECT(TABLE(PROJECT(__EE2792831,TRANSFORM(E_T_I_N(__in,__cfg_Local).Layout,SELF.UID := LEFT.Tax_I_D_,SELF := LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),UID},UID,MERGE),E_T_I_N(__in,__cfg_Local).Layout);
  EXPORT Res12 := __UNWRAP(__EE2792841);
  SHARED __EE2792936 := __E_Utility;
  SHARED __EE2792926 := __E_Prox_Utility;
  SHARED __EE2793086 := __EE2792926(__NN(__EE2792926.Business_Location_) AND __NN(__EE2792926.Util_));
  SHARED __EE2792920 := __ENH_Business_Prox;
  SHARED __EE2793138 := __EE2792920(__T(__OP2(__EE2792920.UID,=,__CN(1))));
  __JC2793144(E_Prox_Utility(__in,__cfg_Local).Layout __EE2793086, B_Business_Prox(__in,__cfg_Local).__ST75468_Layout __EE2793138) := __EEQP(__EE2793138.UID,__EE2793086.Business_Location_);
  SHARED __EE2793155 := JOIN(__EE2793086,__EE2793138,__JC2793144(LEFT,RIGHT),TRANSFORM(E_Prox_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC2793161(E_Utility(__in,__cfg_Local).Layout __EE2792936, E_Prox_Utility(__in,__cfg_Local).Layout __EE2793155) := __EEQP(__EE2793155.Util_,__EE2792936.UID);
  SHARED __EE2793172 := JOIN(__EE2792936,__EE2793155,__JC2793161(LEFT,RIGHT),TRANSFORM(E_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE2793174 := __EE2793172;
  EXPORT Res13 := __UNWRAP(__EE2793174);
  SHARED __EE2793331 := __E_Email;
  SHARED __EE2793321 := __E_Prox_Email;
  SHARED __EE2793550 := __EE2793321(__NN(__EE2793321.Business_Location_) AND __NN(__EE2793321._r_Email_));
  SHARED __EE2793315 := __ENH_Business_Prox;
  SHARED __EE2793634 := __EE2793315(__T(__OP2(__EE2793315.UID,=,__CN(1))));
  __JC2793640(E_Prox_Email(__in,__cfg_Local).Layout __EE2793550, B_Business_Prox(__in,__cfg_Local).__ST75468_Layout __EE2793634) := __EEQP(__EE2793634.UID,__EE2793550.Business_Location_);
  SHARED __EE2793659 := JOIN(__EE2793550,__EE2793634,__JC2793640(LEFT,RIGHT),TRANSFORM(E_Prox_Email(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC2793665(E_Email(__in,__cfg_Local).Layout __EE2793331, E_Prox_Email(__in,__cfg_Local).Layout __EE2793659) := __EEQP(__EE2793659._r_Email_,__EE2793331.UID);
  SHARED __EE2793700 := JOIN(__EE2793331,__EE2793659,__JC2793665(LEFT,RIGHT),TRANSFORM(E_Email(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE2793702 := __EE2793700;
  EXPORT Res14 := __UNWRAP(__EE2793702);
  SHARED __EE2793921 := __ENH_Business_Sele;
  SHARED __EE2793913 := __ENH_Business_Prox;
  SHARED __EE2797503 := __EE2793913(__T(__AND(__OP2(__EE2793913.UID,=,__CN(1)),__CN(__NN(__EE2793913.Prox_Sele_)))));
  __JC2797509(B_Business_Sele(__in,__cfg_Local).__ST89332_Layout __EE2793921, B_Business_Prox(__in,__cfg_Local).__ST75468_Layout __EE2797503) := __EEQP(__EE2797503.Prox_Sele_,__EE2793921.UID);
  SHARED __EE2798647 := JOIN(__EE2793921,__EE2797503,__JC2797509(LEFT,RIGHT),TRANSFORM(B_Business_Sele(__in,__cfg_Local).__ST89332_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE2798649 := __EE2798647;
  EXPORT Res15 := __UNWRAP(__EE2798649);
  SHARED __EE2809787 := __E_Email;
  SHARED __EE2809777 := __E_Sele_Email;
  SHARED __EE2810004 := __EE2809777(__NN(__EE2809777.Legal_) AND __NN(__EE2809777._r_Email_));
  SHARED __EE2809771 := __ENH_Business_Sele;
  SHARED __EE2810087 := __EE2809771(__T(__OP2(__EE2809771.UID,=,__CN(1))));
  __JC2810093(E_Sele_Email(__in,__cfg_Local).Layout __EE2810004, B_Business_Sele(__in,__cfg_Local).__ST89332_Layout __EE2810087) := __EEQP(__EE2810087.UID,__EE2810004.Legal_);
  SHARED __EE2810111 := JOIN(__EE2810004,__EE2810087,__JC2810093(LEFT,RIGHT),TRANSFORM(E_Sele_Email(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC2810117(E_Email(__in,__cfg_Local).Layout __EE2809787, E_Sele_Email(__in,__cfg_Local).Layout __EE2810111) := __EEQP(__EE2810111._r_Email_,__EE2809787.UID);
  SHARED __EE2810152 := JOIN(__EE2809787,__EE2810111,__JC2810117(LEFT,RIGHT),TRANSFORM(E_Email(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE2810154 := __EE2810152;
  EXPORT Res16 := __UNWRAP(__EE2810154);
  SHARED __EE2840368 := __E_Address;
  SHARED __EE2840358 := __E_Sele_Address;
  SHARED __EE2840851 := __EE2840358(__NN(__EE2840358.Legal_) AND __NN(__EE2840358.Location_));
  SHARED __EE2840352 := __ENH_Business_Sele;
  SHARED __EE2841056 := __EE2840352(__T(__OP2(__EE2840352.UID,=,__CN(1))));
  __JC2841062(E_Sele_Address(__in,__cfg_Local).Layout __EE2840851, B_Business_Sele(__in,__cfg_Local).__ST89332_Layout __EE2841056) := __EEQP(__EE2841056.UID,__EE2840851.Legal_);
  SHARED __EE2841117 := JOIN(__EE2840851,__EE2841056,__JC2841062(LEFT,RIGHT),TRANSFORM(E_Sele_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC2841123(E_Address(__in,__cfg_Local).Layout __EE2840368, E_Sele_Address(__in,__cfg_Local).Layout __EE2841117) := __EEQP(__EE2841117.Location_,__EE2840368.UID);
  SHARED __EE2841243 := JOIN(__EE2840368,__EE2841117,__JC2841123(LEFT,RIGHT),TRANSFORM(E_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE2841245 := __EE2841243;
  EXPORT Res17 := __UNWRAP(__EE2841245);
  SHARED __EE2871653 := __E_Aircraft;
  SHARED __EE2871643 := __E_Sele_Aircraft;
  SHARED __EE2871841 := __EE2871643(__NN(__EE2871643.Legal_) AND __NN(__EE2871643.Plane_));
  SHARED __EE2871637 := __ENH_Business_Sele;
  SHARED __EE2871911 := __EE2871637(__T(__OP2(__EE2871637.UID,=,__CN(1))));
  __JC2871917(E_Sele_Aircraft(__in,__cfg_Local).Layout __EE2871841, B_Business_Sele(__in,__cfg_Local).__ST89332_Layout __EE2871911) := __EEQP(__EE2871911.UID,__EE2871841.Legal_);
  SHARED __EE2871934 := JOIN(__EE2871841,__EE2871911,__JC2871917(LEFT,RIGHT),TRANSFORM(E_Sele_Aircraft(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC2871940(E_Aircraft(__in,__cfg_Local).Layout __EE2871653, E_Sele_Aircraft(__in,__cfg_Local).Layout __EE2871934) := __EEQP(__EE2871934.Plane_,__EE2871653.UID);
  SHARED __EE2871963 := JOIN(__EE2871653,__EE2871934,__JC2871940(LEFT,RIGHT),TRANSFORM(E_Aircraft(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE2871965 := __EE2871963;
  EXPORT Res18 := __UNWRAP(__EE2871965);
  SHARED __EE2902104 := __ENH_Bankruptcy;
  SHARED __EE2902093 := __E_Sele_Bankruptcy;
  SHARED __EE2902404 := __EE2902093(__NN(__EE2902093.Legal_) AND __NN(__EE2902093.Bankrupt_));
  SHARED __EE2902087 := __ENH_Business_Sele;
  SHARED __EE2902530 := __EE2902087(__T(__OP2(__EE2902087.UID,=,__CN(1))));
  __JC2902536(E_Sele_Bankruptcy(__in,__cfg_Local).Layout __EE2902404, B_Business_Sele(__in,__cfg_Local).__ST89332_Layout __EE2902530) := __EEQP(__EE2902530.UID,__EE2902404.Legal_);
  SHARED __EE2902546 := JOIN(__EE2902404,__EE2902530,__JC2902536(LEFT,RIGHT),TRANSFORM(E_Sele_Bankruptcy(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC2902552(B_Bankruptcy(__in,__cfg_Local).__ST74965_Layout __EE2902104, E_Sele_Bankruptcy(__in,__cfg_Local).Layout __EE2902546) := __EEQP(__EE2902546.Bankrupt_,__EE2902104.UID);
  SHARED __EE2902638 := JOIN(__EE2902104,__EE2902546,__JC2902552(LEFT,RIGHT),TRANSFORM(B_Bankruptcy(__in,__cfg_Local).__ST74965_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE2902640 := __EE2902638;
  EXPORT Res19 := __UNWRAP(__EE2902640);
  SHARED __EE2932967 := __ENH_Lien_Judgment;
  SHARED __EE2932956 := __E_Sele_Lien_Judgment;
  SHARED __EE2933185 := __EE2932956(__NN(__EE2932956.Sele_) AND __NN(__EE2932956.Lien_));
  SHARED __EE2932950 := __ENH_Business_Sele;
  SHARED __EE2933270 := __EE2932950(__T(__OP2(__EE2932950.UID,=,__CN(1))));
  __JC2933276(E_Sele_Lien_Judgment(__in,__cfg_Local).Layout __EE2933185, B_Business_Sele(__in,__cfg_Local).__ST89332_Layout __EE2933270) := __EEQP(__EE2933270.UID,__EE2933185.Sele_);
  SHARED __EE2933292 := JOIN(__EE2933185,__EE2933270,__JC2933276(LEFT,RIGHT),TRANSFORM(E_Sele_Lien_Judgment(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC2933298(B_Lien_Judgment_11(__in,__cfg_Local).__ST149059_Layout __EE2932967, E_Sele_Lien_Judgment(__in,__cfg_Local).Layout __EE2933292) := __EEQP(__EE2933292.Lien_,__EE2932967.UID);
  SHARED __EE2933337 := JOIN(__EE2932967,__EE2933292,__JC2933298(LEFT,RIGHT),TRANSFORM(B_Lien_Judgment_11(__in,__cfg_Local).__ST149059_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE2933339 := __EE2933337;
  EXPORT Res20 := __UNWRAP(__EE2933339);
  SHARED __EE2963510 := __ENH_Person;
  SHARED __EE2963499 := __E_Sele_Person;
  SHARED __EE2965112 := __EE2963499(__NN(__EE2963499.Legal_) AND __NN(__EE2963499.Contact_));
  SHARED __EE2963493 := __ENH_Business_Sele;
  SHARED __EE2965864 := __EE2963493(__T(__OP2(__EE2963493.UID,=,__CN(1))));
  __JC2965870(E_Sele_Person(__in,__cfg_Local).Layout __EE2965112, B_Business_Sele(__in,__cfg_Local).__ST89332_Layout __EE2965864) := __EEQP(__EE2965864.UID,__EE2965112.Legal_);
  SHARED __EE2965898 := JOIN(__EE2965112,__EE2965864,__JC2965870(LEFT,RIGHT),TRANSFORM(E_Sele_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC2965904(B_Person(__in,__cfg_Local).__ST99755_Layout __EE2963510, E_Sele_Person(__in,__cfg_Local).Layout __EE2965898) := __EEQP(__EE2965898.Contact_,__EE2963510.UID);
  SHARED __EE2966598 := JOIN(__EE2963510,__EE2965898,__JC2965904(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST99755_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE2966600 := __EE2966598;
  EXPORT Res21 := __UNWRAP(__EE2966600);
  SHARED __EE2998580 := __E_Phone;
  SHARED __EE2998570 := __E_Sele_Phone_Number;
  SHARED __EE2998875 := __EE2998570(__NN(__EE2998570.Legal_) AND __NN(__EE2998570.Phone_Number_));
  SHARED __EE2998564 := __ENH_Business_Sele;
  SHARED __EE2998994 := __EE2998564(__T(__OP2(__EE2998564.UID,=,__CN(1))));
  __JC2999000(E_Sele_Phone_Number(__in,__cfg_Local).Layout __EE2998875, B_Business_Sele(__in,__cfg_Local).__ST89332_Layout __EE2998994) := __EEQP(__EE2998994.UID,__EE2998875.Legal_);
  SHARED __EE2999036 := JOIN(__EE2998875,__EE2998994,__JC2999000(LEFT,RIGHT),TRANSFORM(E_Sele_Phone_Number(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC2999042(E_Phone(__in,__cfg_Local).Layout __EE2998580, E_Sele_Phone_Number(__in,__cfg_Local).Layout __EE2999036) := __EEQP(__EE2999036.Phone_Number_,__EE2998580.UID);
  SHARED __EE2999095 := JOIN(__EE2998580,__EE2999036,__JC2999042(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE2999097 := __EE2999095;
  EXPORT Res22 := __UNWRAP(__EE2999097);
  SHARED __EE3029371 := __E_Property;
  SHARED __EE3029361 := __E_Sele_Property;
  SHARED __EE3029606 := __EE3029361(__NN(__EE3029361.Legal_) AND __NN(__EE3029361.Prop_));
  SHARED __EE3029355 := __ENH_Business_Sele;
  SHARED __EE3029699 := __EE3029355(__T(__OP2(__EE3029355.UID,=,__CN(1))));
  __JC3029705(E_Sele_Property(__in,__cfg_Local).Layout __EE3029606, B_Business_Sele(__in,__cfg_Local).__ST89332_Layout __EE3029699) := __EEQP(__EE3029699.UID,__EE3029606.Legal_);
  SHARED __EE3029733 := JOIN(__EE3029606,__EE3029699,__JC3029705(LEFT,RIGHT),TRANSFORM(E_Sele_Property(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3029739(E_Property(__in,__cfg_Local).Layout __EE3029371, E_Sele_Property(__in,__cfg_Local).Layout __EE3029733) := __EEQP(__EE3029733.Prop_,__EE3029371.UID);
  SHARED __EE3029774 := JOIN(__EE3029371,__EE3029733,__JC3029739(LEFT,RIGHT),TRANSFORM(E_Property(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3029776 := __EE3029774;
  EXPORT Res23 := __UNWRAP(__EE3029776);
  SHARED __EE3060095 := __E_Property_Event;
  SHARED __EE3060085 := __E_Sele_Property_Event;
  SHARED __EE3060904 := __EE3060085(__NN(__EE3060085.Legal_) AND __NN(__EE3060085.Event_));
  SHARED __EE3060079 := __ENH_Business_Sele;
  SHARED __EE3061285 := __EE3060079(__T(__OP2(__EE3060079.UID,=,__CN(1))));
  __JC3061291(E_Sele_Property_Event(__in,__cfg_Local).Layout __EE3060904, B_Business_Sele(__in,__cfg_Local).__ST89332_Layout __EE3061285) := __EEQP(__EE3061285.UID,__EE3060904.Legal_);
  SHARED __EE3061314 := JOIN(__EE3060904,__EE3061285,__JC3061291(LEFT,RIGHT),TRANSFORM(E_Sele_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3061320(E_Property_Event(__in,__cfg_Local).Layout __EE3060095, E_Sele_Property_Event(__in,__cfg_Local).Layout __EE3061314) := __EEQP(__EE3061314.Event_,__EE3060095.UID);
  SHARED __EE3061648 := JOIN(__EE3060095,__EE3061314,__JC3061320(LEFT,RIGHT),TRANSFORM(E_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3061650 := __EE3061648;
  EXPORT Res24 := __UNWRAP(__EE3061650);
  SHARED __EE3092493 := __E_Sele_T_I_N;
  SHARED __EE3092650 := __EE3092493(__NN(__EE3092493.Tax_I_D_) AND __NN(__EE3092493.Legal_));
  SHARED __EE3092487 := __ENH_Business_Sele;
  SHARED __EE3092694 := __EE3092487(__T(__OP2(__EE3092487.UID,=,__CN(1))));
  __JC3092700(E_Sele_T_I_N(__in,__cfg_Local).Layout __EE3092650, B_Business_Sele(__in,__cfg_Local).__ST89332_Layout __EE3092694) := __EEQP(__EE3092694.UID,__EE3092650.Legal_);
  SHARED __EE3092712 := JOIN(__EE3092650,__EE3092694,__JC3092700(LEFT,RIGHT),TRANSFORM(E_Sele_T_I_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3092722 := PROJECT(TABLE(PROJECT(__EE3092712,TRANSFORM(E_T_I_N(__in,__cfg_Local).Layout,SELF.UID := LEFT.Tax_I_D_,SELF := LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),UID},UID,MERGE),E_T_I_N(__in,__cfg_Local).Layout);
  EXPORT Res25 := __UNWRAP(__EE3092722);
  SHARED __EE3112157 := __ENH_Tradeline;
  SHARED __EE3112146 := __E_Sele_Tradeline;
  SHARED __EE3112420 := __EE3112146(__NN(__EE3112146.Legal_) AND __NN(__EE3112146.Account_));
  SHARED __EE3112140 := __ENH_Business_Sele;
  SHARED __EE3112528 := __EE3112140(__T(__OP2(__EE3112140.UID,=,__CN(1))));
  __JC3112534(E_Sele_Tradeline(__in,__cfg_Local).Layout __EE3112420, B_Business_Sele(__in,__cfg_Local).__ST89332_Layout __EE3112528) := __EEQP(__EE3112528.UID,__EE3112420.Legal_);
  SHARED __EE3112541 := JOIN(__EE3112420,__EE3112528,__JC3112534(LEFT,RIGHT),TRANSFORM(E_Sele_Tradeline(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3112547(B_Tradeline(__in,__cfg_Local).__ST100469_Layout __EE3112157, E_Sele_Tradeline(__in,__cfg_Local).Layout __EE3112541) := __EEQP(__EE3112541.Account_,__EE3112157.UID);
  SHARED __EE3112618 := JOIN(__EE3112157,__EE3112541,__JC3112547(LEFT,RIGHT),TRANSFORM(B_Tradeline(__in,__cfg_Local).__ST100469_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3112620 := __EE3112618;
  EXPORT Res26 := __UNWRAP(__EE3112620);
  SHARED __EE3142919 := __ENH_U_C_C;
  SHARED __EE3142908 := __E_Sele_U_C_C;
  SHARED __EE3143192 := __EE3142908(__NN(__EE3142908.Legal_) AND __NN(__EE3142908.Filing_));
  SHARED __EE3142902 := __ENH_Business_Sele;
  SHARED __EE3143304 := __EE3142902(__T(__OP2(__EE3142902.UID,=,__CN(1))));
  __JC3143310(E_Sele_U_C_C(__in,__cfg_Local).Layout __EE3143192, B_Business_Sele(__in,__cfg_Local).__ST89332_Layout __EE3143304) := __EEQP(__EE3143304.UID,__EE3143192.Legal_);
  SHARED __EE3143325 := JOIN(__EE3143192,__EE3143304,__JC3143310(LEFT,RIGHT),TRANSFORM(E_Sele_U_C_C(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3143331(B_U_C_C(__in,__cfg_Local).__ST100659_Layout __EE3142919, E_Sele_U_C_C(__in,__cfg_Local).Layout __EE3143325) := __EEQP(__EE3143325.Filing_,__EE3142919.UID);
  SHARED __EE3143398 := JOIN(__EE3142919,__EE3143325,__JC3143331(LEFT,RIGHT),TRANSFORM(B_U_C_C(__in,__cfg_Local).__ST100659_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3143400 := __EE3143398;
  EXPORT Res27 := __UNWRAP(__EE3143400);
  SHARED __EE3173624 := __E_Utility;
  SHARED __EE3173614 := __E_Sele_Utility;
  SHARED __EE3173774 := __EE3173614(__NN(__EE3173614.Legal_) AND __NN(__EE3173614.Util_));
  SHARED __EE3173608 := __ENH_Business_Sele;
  SHARED __EE3173826 := __EE3173608(__T(__OP2(__EE3173608.UID,=,__CN(1))));
  __JC3173832(E_Sele_Utility(__in,__cfg_Local).Layout __EE3173774, B_Business_Sele(__in,__cfg_Local).__ST89332_Layout __EE3173826) := __EEQP(__EE3173826.UID,__EE3173774.Legal_);
  SHARED __EE3173843 := JOIN(__EE3173774,__EE3173826,__JC3173832(LEFT,RIGHT),TRANSFORM(E_Sele_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3173849(E_Utility(__in,__cfg_Local).Layout __EE3173624, E_Sele_Utility(__in,__cfg_Local).Layout __EE3173843) := __EEQP(__EE3173843.Util_,__EE3173624.UID);
  SHARED __EE3173860 := JOIN(__EE3173624,__EE3173843,__JC3173849(LEFT,RIGHT),TRANSFORM(E_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3173862 := __EE3173860;
  EXPORT Res28 := __UNWRAP(__EE3173862);
  SHARED __EE3204123 := __E_Vehicle;
  SHARED __EE3204113 := __E_Sele_Vehicle;
  SHARED __EE3204554 := __EE3204113(__NN(__EE3204113.Legal_) AND __NN(__EE3204113.Automobile_));
  SHARED __EE3204107 := __ENH_Business_Sele;
  SHARED __EE3204745 := __EE3204107(__T(__OP2(__EE3204107.UID,=,__CN(1))));
  __JC3204751(E_Sele_Vehicle(__in,__cfg_Local).Layout __EE3204554, B_Business_Sele(__in,__cfg_Local).__ST89332_Layout __EE3204745) := __EEQP(__EE3204745.UID,__EE3204554.Legal_);
  SHARED __EE3204801 := JOIN(__EE3204554,__EE3204745,__JC3204751(LEFT,RIGHT),TRANSFORM(E_Sele_Vehicle(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3204807(E_Vehicle(__in,__cfg_Local).Layout __EE3204123, E_Sele_Vehicle(__in,__cfg_Local).Layout __EE3204801) := __EEQP(__EE3204801.Automobile_,__EE3204123.UID);
  SHARED __EE3204918 := JOIN(__EE3204123,__EE3204801,__JC3204807(LEFT,RIGHT),TRANSFORM(E_Vehicle(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3204920 := __EE3204918;
  EXPORT Res29 := __UNWRAP(__EE3204920);
  SHARED __EE3235338 := __E_Watercraft;
  SHARED __EE3235328 := __E_Sele_Watercraft;
  SHARED __EE3235488 := __EE3235328(__NN(__EE3235328.Legal_) AND __NN(__EE3235328.W_Craft_));
  SHARED __EE3235322 := __ENH_Business_Sele;
  SHARED __EE3235540 := __EE3235322(__T(__OP2(__EE3235322.UID,=,__CN(1))));
  __JC3235546(E_Sele_Watercraft(__in,__cfg_Local).Layout __EE3235488, B_Business_Sele(__in,__cfg_Local).__ST89332_Layout __EE3235540) := __EEQP(__EE3235540.UID,__EE3235488.Legal_);
  SHARED __EE3235557 := JOIN(__EE3235488,__EE3235540,__JC3235546(LEFT,RIGHT),TRANSFORM(E_Sele_Watercraft(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3235563(E_Watercraft(__in,__cfg_Local).Layout __EE3235338, E_Sele_Watercraft(__in,__cfg_Local).Layout __EE3235557) := __EEQP(__EE3235557.W_Craft_,__EE3235338.UID);
  SHARED __EE3235574 := JOIN(__EE3235338,__EE3235557,__JC3235563(LEFT,RIGHT),TRANSFORM(E_Watercraft(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3235576 := __EE3235574;
  EXPORT Res30 := __UNWRAP(__EE3235576);
  SHARED __EE3265707 := __ENH_Business_Prox;
  SHARED __EE3266301 := __EE3265707(__NN(__EE3265707.Prox_Sele_));
  SHARED __EE3265700 := __ENH_Business_Sele;
  SHARED __EE3266306 := __EE3265700(__T(__OP2(__EE3265700.UID,=,__CN(1))));
  __JC3266312(B_Business_Prox(__in,__cfg_Local).__ST75468_Layout __EE3266301, B_Business_Sele(__in,__cfg_Local).__ST89332_Layout __EE3266306) := __EEQP(__EE3266306.UID,__EE3266301.Prox_Sele_);
  SHARED __EE3266570 := JOIN(__EE3266301,__EE3266306,__JC3266312(LEFT,RIGHT),TRANSFORM(B_Business_Prox(__in,__cfg_Local).__ST75468_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3266572 := __EE3266570;
  EXPORT Res31 := __UNWRAP(__EE3266572);
  SHARED __EE3286497 := __ENH_Criminal_Offense;
  SHARED __EE3286486 := __E_Criminal_Details;
  SHARED __EE3286789 := __EE3286486(__NN(__EE3286486.Offender_) AND __NN(__EE3286486.Offense_));
  SHARED __EE3286480 := __E_Criminal_Offender;
  SHARED __EE3286910 := __EE3286480(__T(__OP2(__EE3286480.UID,=,__CN(1))));
  __JC3286916(E_Criminal_Details(__in,__cfg_Local).Layout __EE3286789, E_Criminal_Offender(__in,__cfg_Local).Layout __EE3286910) := __EEQP(__EE3286910.UID,__EE3286789.Offender_);
  SHARED __EE3286924 := JOIN(__EE3286789,__EE3286910,__JC3286916(LEFT,RIGHT),TRANSFORM(E_Criminal_Details(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3286930(B_Criminal_Offense(__in,__cfg_Local).__ST90468_Layout __EE3286497, E_Criminal_Details(__in,__cfg_Local).Layout __EE3286924) := __EEQP(__EE3286924.Offense_,__EE3286497.UID);
  SHARED __EE3287013 := JOIN(__EE3286497,__EE3286924,__JC3286930(LEFT,RIGHT),TRANSFORM(B_Criminal_Offense(__in,__cfg_Local).__ST90468_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3287015 := __EE3287013;
  EXPORT Res32 := __UNWRAP(__EE3287015);
  SHARED __EE3287263 := __E_Criminal_Punishment;
  SHARED __EE3287253 := __E_Criminal_Details;
  SHARED __EE3287495 := __EE3287253(__NN(__EE3287253.Offender_) AND __NN(__EE3287253.Punishment_));
  SHARED __EE3287247 := __E_Criminal_Offender;
  SHARED __EE3287587 := __EE3287247(__T(__OP2(__EE3287247.UID,=,__CN(1))));
  __JC3287593(E_Criminal_Details(__in,__cfg_Local).Layout __EE3287495, E_Criminal_Offender(__in,__cfg_Local).Layout __EE3287587) := __EEQP(__EE3287587.UID,__EE3287495.Offender_);
  SHARED __EE3287601 := JOIN(__EE3287495,__EE3287587,__JC3287593(LEFT,RIGHT),TRANSFORM(E_Criminal_Details(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3287607(E_Criminal_Punishment(__in,__cfg_Local).Layout __EE3287263, E_Criminal_Details(__in,__cfg_Local).Layout __EE3287601) := __EEQP(__EE3287601.Punishment_,__EE3287263.UID);
  SHARED __EE3287661 := JOIN(__EE3287263,__EE3287601,__JC3287607(LEFT,RIGHT),TRANSFORM(E_Criminal_Punishment(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3287663 := __EE3287661;
  EXPORT Res33 := __UNWRAP(__EE3287663);
  SHARED __EE3287840 := __E_First_Degree_Associations;
  SHARED __EE3287916 := __EE3287840(__NN(__EE3287840.Subject_));
  SHARED __EE3287834 := __ENH_Person;
  SHARED __EE3287921 := __EE3287834(__T(__OP2(__EE3287834.UID,=,__CN(1))));
  __JC3287927(E_First_Degree_Associations(__in,__cfg_Local).Layout __EE3287916, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3287921) := __EEQP(__EE3287921.UID,__EE3287916.Subject_);
  SHARED __EE3287939 := JOIN(__EE3287916,__EE3287921,__JC3287927(LEFT,RIGHT),TRANSFORM(E_First_Degree_Associations(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3287941 := __EE3287939;
  EXPORT Res34 := __UNWRAP(__EE3287941);
  SHARED __EE3289235 := __ENH_First_Degree_Relative;
  SHARED __EE3289311 := __EE3289235(__NN(__EE3289235.Subject_));
  SHARED __EE3289228 := __ENH_Person;
  SHARED __EE3289316 := __EE3289228(__T(__OP2(__EE3289228.UID,=,__CN(1))));
  __JC3289322(E_First_Degree_Relative(__in,__cfg_Local).Layout __EE3289311, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3289316) := __EEQP(__EE3289316.UID,__EE3289311.Subject_);
  SHARED __EE3289334 := JOIN(__EE3289311,__EE3289316,__JC3289322(LEFT,RIGHT),TRANSFORM(E_First_Degree_Relative(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3289336 := __EE3289334;
  EXPORT Res35 := __UNWRAP(__EE3289336);
  SHARED __EE3290630 := __E_Phone;
  SHARED __EE3290620 := __E_House_Hold_Phone;
  SHARED __EE3290901 := __EE3290620(__NN(__EE3290620.Household_) AND __NN(__EE3290620.Phone_Number_));
  SHARED __EE3290614 := __E_Household;
  SHARED __EE3291010 := __EE3290614(__T(__OP2(__EE3290614.UID,=,__CN(1))));
  __JC3291016(E_House_Hold_Phone(__in,__cfg_Local).Layout __EE3290901, E_Household(__in,__cfg_Local).Layout __EE3291010) := __EEQP(__EE3291010.UID,__EE3290901.Household_);
  SHARED __EE3291042 := JOIN(__EE3290901,__EE3291010,__JC3291016(LEFT,RIGHT),TRANSFORM(E_House_Hold_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3291048(E_Phone(__in,__cfg_Local).Layout __EE3290630, E_House_Hold_Phone(__in,__cfg_Local).Layout __EE3291042) := __EEQP(__EE3291042.Phone_Number_,__EE3290630.UID);
  SHARED __EE3291101 := JOIN(__EE3290630,__EE3291042,__JC3291048(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3291103 := __EE3291101;
  EXPORT Res36 := __UNWRAP(__EE3291103);
  SHARED __EE3291345 := __ENH_Person;
  SHARED __EE3291334 := __E_Household_Member;
  SHARED __EE3292906 := __EE3291334(__NN(__EE3291334.Household_) AND __NN(__EE3291334.Subject_));
  SHARED __EE3291328 := __E_Household;
  SHARED __EE3293638 := __EE3291328(__T(__OP2(__EE3291328.UID,=,__CN(1))));
  __JC3293644(E_Household_Member(__in,__cfg_Local).Layout __EE3292906, E_Household(__in,__cfg_Local).Layout __EE3293638) := __EEQP(__EE3293638.UID,__EE3292906.Household_);
  SHARED __EE3293652 := JOIN(__EE3292906,__EE3293638,__JC3293644(LEFT,RIGHT),TRANSFORM(E_Household_Member(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3293658(B_Person(__in,__cfg_Local).__ST99755_Layout __EE3291345, E_Household_Member(__in,__cfg_Local).Layout __EE3293652) := __EEQP(__EE3293652.Subject_,__EE3291345.UID);
  SHARED __EE3294352 := JOIN(__EE3291345,__EE3293652,__JC3293658(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST99755_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3294354 := __EE3294352;
  EXPORT Res37 := __UNWRAP(__EE3294354);
  SHARED __EE3296051 := __E_Aircraft;
  SHARED __EE3296041 := __E_Aircraft_Owner;
  SHARED __EE3296224 := __EE3296041(__NN(__EE3296041.Owner_) AND __NN(__EE3296041.Plane_));
  SHARED __EE3296035 := __ENH_Person;
  SHARED __EE3296287 := __EE3296035(__T(__OP2(__EE3296035.UID,=,__CN(1))));
  __JC3296293(E_Aircraft_Owner(__in,__cfg_Local).Layout __EE3296224, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3296287) := __EEQP(__EE3296287.UID,__EE3296224.Owner_);
  SHARED __EE3296303 := JOIN(__EE3296224,__EE3296287,__JC3296293(LEFT,RIGHT),TRANSFORM(E_Aircraft_Owner(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3296309(E_Aircraft(__in,__cfg_Local).Layout __EE3296051, E_Aircraft_Owner(__in,__cfg_Local).Layout __EE3296303) := __EEQP(__EE3296303.Plane_,__EE3296051.UID);
  SHARED __EE3296332 := JOIN(__EE3296051,__EE3296303,__JC3296309(LEFT,RIGHT),TRANSFORM(E_Aircraft(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3296334 := __EE3296332;
  EXPORT Res38 := __UNWRAP(__EE3296334);
  SHARED __EE3298687 := __E_Employment;
  SHARED __EE3298677 := __E_Employment_Person;
  SHARED __EE3298828 := __EE3298677(__NN(__EE3298677.Subject_) AND __NN(__EE3298677.Emp_));
  SHARED __EE3298671 := __ENH_Person;
  SHARED __EE3298876 := __EE3298671(__T(__OP2(__EE3298671.UID,=,__CN(1))));
  __JC3298882(E_Employment_Person(__in,__cfg_Local).Layout __EE3298828, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3298876) := __EEQP(__EE3298876.UID,__EE3298828.Subject_);
  SHARED __EE3298889 := JOIN(__EE3298828,__EE3298876,__JC3298882(LEFT,RIGHT),TRANSFORM(E_Employment_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3298895(E_Employment(__in,__cfg_Local).Layout __EE3298687, E_Employment_Person(__in,__cfg_Local).Layout __EE3298889) := __EEQP(__EE3298889.Emp_,__EE3298687.UID);
  SHARED __EE3298906 := JOIN(__EE3298687,__EE3298889,__JC3298895(LEFT,RIGHT),TRANSFORM(E_Employment(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3298908 := __EE3298906;
  EXPORT Res39 := __UNWRAP(__EE3298908);
  SHARED __EE3301236 := __E_Household;
  SHARED __EE3301226 := __E_Household_Member;
  SHARED __EE3301369 := __EE3301226(__NN(__EE3301226.Subject_) AND __NN(__EE3301226.Household_));
  SHARED __EE3301220 := __ENH_Person;
  SHARED __EE3301413 := __EE3301220(__T(__OP2(__EE3301220.UID,=,__CN(1))));
  __JC3301419(E_Household_Member(__in,__cfg_Local).Layout __EE3301369, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3301413) := __EEQP(__EE3301413.UID,__EE3301369.Subject_);
  SHARED __EE3301427 := JOIN(__EE3301369,__EE3301413,__JC3301419(LEFT,RIGHT),TRANSFORM(E_Household_Member(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3301433(E_Household(__in,__cfg_Local).Layout __EE3301236, E_Household_Member(__in,__cfg_Local).Layout __EE3301427) := __EEQP(__EE3301427.Household_,__EE3301236.UID);
  SHARED __EE3301439 := JOIN(__EE3301236,__EE3301427,__JC3301433(LEFT,RIGHT),TRANSFORM(E_Household(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3301441 := __EE3301439;
  EXPORT Res40 := __UNWRAP(__EE3301441);
  SHARED __EE3303756 := __E_Accident;
  SHARED __EE3303746 := __E_Person_Accident;
  SHARED __EE3304010 := __EE3303746(__NN(__EE3303746.Subject_) AND __NN(__EE3303746.Acc_));
  SHARED __EE3303740 := __ENH_Person;
  SHARED __EE3304114 := __EE3303740(__T(__OP2(__EE3303740.UID,=,__CN(1))));
  __JC3304120(E_Person_Accident(__in,__cfg_Local).Layout __EE3304010, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3304114) := __EEQP(__EE3304114.UID,__EE3304010.Subject_);
  SHARED __EE3304168 := JOIN(__EE3304010,__EE3304114,__JC3304120(LEFT,RIGHT),TRANSFORM(E_Person_Accident(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3304174(E_Accident(__in,__cfg_Local).Layout __EE3303756, E_Person_Accident(__in,__cfg_Local).Layout __EE3304168) := __EEQP(__EE3304168.Acc_,__EE3303756.UID);
  SHARED __EE3304200 := JOIN(__EE3303756,__EE3304168,__JC3304174(LEFT,RIGHT),TRANSFORM(E_Accident(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3304202 := __EE3304200;
  EXPORT Res41 := __UNWRAP(__EE3304202);
  SHARED __EE3306683 := __E_Address;
  SHARED __EE3306673 := __E_Person_Address;
  SHARED __EE3307146 := __EE3306673(__NN(__EE3306673.Subject_) AND __NN(__EE3306673.Location_));
  SHARED __EE3306667 := __ENH_Person;
  SHARED __EE3307343 := __EE3306667(__T(__OP2(__EE3306667.UID,=,__CN(1))));
  __JC3307349(E_Person_Address(__in,__cfg_Local).Layout __EE3307146, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3307343) := __EEQP(__EE3307343.UID,__EE3307146.Subject_);
  SHARED __EE3307396 := JOIN(__EE3307146,__EE3307343,__JC3307349(LEFT,RIGHT),TRANSFORM(E_Person_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3307402(E_Address(__in,__cfg_Local).Layout __EE3306683, E_Person_Address(__in,__cfg_Local).Layout __EE3307396) := __EEQP(__EE3307396.Location_,__EE3306683.UID);
  SHARED __EE3307522 := JOIN(__EE3306683,__EE3307396,__JC3307402(LEFT,RIGHT),TRANSFORM(E_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3307524 := __EE3307522;
  EXPORT Res42 := __UNWRAP(__EE3307524);
  SHARED __EE3310146 := __ENH_Bankruptcy;
  SHARED __EE3310135 := __E_Person_Bankruptcy;
  SHARED __EE3310440 := __EE3310135(__NN(__EE3310135.Subject_) AND __NN(__EE3310135.Bankrupt_));
  SHARED __EE3310129 := __ENH_Person;
  SHARED __EE3310563 := __EE3310129(__T(__OP2(__EE3310129.UID,=,__CN(1))));
  __JC3310569(E_Person_Bankruptcy(__in,__cfg_Local).Layout __EE3310440, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3310563) := __EEQP(__EE3310563.UID,__EE3310440.Subject_);
  SHARED __EE3310576 := JOIN(__EE3310440,__EE3310563,__JC3310569(LEFT,RIGHT),TRANSFORM(E_Person_Bankruptcy(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3310582(B_Bankruptcy(__in,__cfg_Local).__ST74965_Layout __EE3310146, E_Person_Bankruptcy(__in,__cfg_Local).Layout __EE3310576) := __EEQP(__EE3310576.Bankrupt_,__EE3310146.UID);
  SHARED __EE3310668 := JOIN(__EE3310146,__EE3310576,__JC3310582(LEFT,RIGHT),TRANSFORM(B_Bankruptcy(__in,__cfg_Local).__ST74965_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3310670 := __EE3310668;
  EXPORT Res43 := __UNWRAP(__EE3310670);
  SHARED __EE3313143 := __E_Drivers_License;
  SHARED __EE3313133 := __E_Person_Drivers_License;
  SHARED __EE3313379 := __EE3313133(__NN(__EE3313133.Subject_) AND __NN(__EE3313133.License_));
  SHARED __EE3313127 := __ENH_Person;
  SHARED __EE3313473 := __EE3313127(__T(__OP2(__EE3313127.UID,=,__CN(1))));
  __JC3313479(E_Person_Drivers_License(__in,__cfg_Local).Layout __EE3313379, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3313473) := __EEQP(__EE3313473.UID,__EE3313379.Subject_);
  SHARED __EE3313486 := JOIN(__EE3313379,__EE3313473,__JC3313479(LEFT,RIGHT),TRANSFORM(E_Person_Drivers_License(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3313492(E_Drivers_License(__in,__cfg_Local).Layout __EE3313143, E_Person_Drivers_License(__in,__cfg_Local).Layout __EE3313486) := __EEQP(__EE3313486.License_,__EE3313143.UID);
  SHARED __EE3313549 := JOIN(__EE3313143,__EE3313486,__JC3313492(LEFT,RIGHT),TRANSFORM(E_Drivers_License(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3313551 := __EE3313549;
  EXPORT Res44 := __UNWRAP(__EE3313551);
  SHARED __EE3315971 := __E_Education;
  SHARED __EE3315961 := __E_Person_Education;
  SHARED __EE3316155 := __EE3315961(__NN(__EE3315961.Subject_) AND __NN(__EE3315961.Edu_));
  SHARED __EE3315955 := __ENH_Person;
  SHARED __EE3316224 := __EE3315955(__T(__OP2(__EE3315955.UID,=,__CN(1))));
  __JC3316230(E_Person_Education(__in,__cfg_Local).Layout __EE3316155, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3316224) := __EEQP(__EE3316224.UID,__EE3316155.Subject_);
  SHARED __EE3316248 := JOIN(__EE3316155,__EE3316224,__JC3316230(LEFT,RIGHT),TRANSFORM(E_Person_Education(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3316254(E_Education(__in,__cfg_Local).Layout __EE3315971, E_Person_Education(__in,__cfg_Local).Layout __EE3316248) := __EEQP(__EE3316248.Edu_,__EE3315971.UID);
  SHARED __EE3316275 := JOIN(__EE3315971,__EE3316248,__JC3316254(LEFT,RIGHT),TRANSFORM(E_Education(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3316277 := __EE3316275;
  EXPORT Res45 := __UNWRAP(__EE3316277);
  SHARED __EE3318642 := __E_Email;
  SHARED __EE3318632 := __E_Person_Email;
  SHARED __EE3318836 := __EE3318632(__NN(__EE3318632.Subject_) AND __NN(__EE3318632._r_Email_));
  SHARED __EE3318626 := __ENH_Person;
  SHARED __EE3318908 := __EE3318626(__T(__OP2(__EE3318626.UID,=,__CN(1))));
  __JC3318914(E_Person_Email(__in,__cfg_Local).Layout __EE3318836, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3318908) := __EEQP(__EE3318908.UID,__EE3318836.Subject_);
  SHARED __EE3318921 := JOIN(__EE3318836,__EE3318908,__JC3318914(LEFT,RIGHT),TRANSFORM(E_Person_Email(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3318927(E_Email(__in,__cfg_Local).Layout __EE3318642, E_Person_Email(__in,__cfg_Local).Layout __EE3318921) := __EEQP(__EE3318921._r_Email_,__EE3318642.UID);
  SHARED __EE3318962 := JOIN(__EE3318642,__EE3318921,__JC3318927(LEFT,RIGHT),TRANSFORM(E_Email(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3318964 := __EE3318962;
  EXPORT Res46 := __UNWRAP(__EE3318964);
  SHARED __EE3321335 := __E_Inquiry;
  SHARED __EE3321325 := __E_Person_Inquiry;
  SHARED __EE3321496 := __EE3321325(__NN(__EE3321325.Subject_) AND __NN(__EE3321325.Inquiry_));
  SHARED __EE3321319 := __ENH_Person;
  SHARED __EE3321554 := __EE3321319(__T(__OP2(__EE3321319.UID,=,__CN(1))));
  __JC3321560(E_Person_Inquiry(__in,__cfg_Local).Layout __EE3321496, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3321554) := __EEQP(__EE3321554.UID,__EE3321496.Subject_);
  SHARED __EE3321567 := JOIN(__EE3321496,__EE3321554,__JC3321560(LEFT,RIGHT),TRANSFORM(E_Person_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3321573(E_Inquiry(__in,__cfg_Local).Layout __EE3321335, E_Person_Inquiry(__in,__cfg_Local).Layout __EE3321567) := __EEQP(__EE3321567.Inquiry_,__EE3321335.UID);
  SHARED __EE3321594 := JOIN(__EE3321335,__EE3321567,__JC3321573(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3321596 := __EE3321594;
  EXPORT Res47 := __UNWRAP(__EE3321596);
  SHARED __EE3323945 := __ENH_Lien_Judgment;
  SHARED __EE3323934 := __E_Person_Lien_Judgment;
  SHARED __EE3324157 := __EE3323934(__NN(__EE3323934.Subject_) AND __NN(__EE3323934.Lien_));
  SHARED __EE3323928 := __ENH_Person;
  SHARED __EE3324239 := __EE3323928(__T(__OP2(__EE3323928.UID,=,__CN(1))));
  __JC3324245(E_Person_Lien_Judgment(__in,__cfg_Local).Layout __EE3324157, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3324239) := __EEQP(__EE3324239.UID,__EE3324157.Subject_);
  SHARED __EE3324258 := JOIN(__EE3324157,__EE3324239,__JC3324245(LEFT,RIGHT),TRANSFORM(E_Person_Lien_Judgment(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3324264(B_Lien_Judgment_11(__in,__cfg_Local).__ST149059_Layout __EE3323945, E_Person_Lien_Judgment(__in,__cfg_Local).Layout __EE3324258) := __EEQP(__EE3324258.Lien_,__EE3323945.UID);
  SHARED __EE3324303 := JOIN(__EE3323945,__EE3324258,__JC3324264(LEFT,RIGHT),TRANSFORM(B_Lien_Judgment_11(__in,__cfg_Local).__ST149059_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3324305 := __EE3324303;
  EXPORT Res48 := __UNWRAP(__EE3324305);
  SHARED __EE3326705 := __E_Criminal_Offender;
  SHARED __EE3326695 := __E_Person_Offender;
  SHARED __EE3326883 := __EE3326695(__NN(__EE3326695.Subject_) AND __NN(__EE3326695.Offender_));
  SHARED __EE3326689 := __ENH_Person;
  SHARED __EE3326948 := __EE3326689(__T(__OP2(__EE3326689.UID,=,__CN(1))));
  __JC3326954(E_Person_Offender(__in,__cfg_Local).Layout __EE3326883, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3326948) := __EEQP(__EE3326948.UID,__EE3326883.Subject_);
  SHARED __EE3326961 := JOIN(__EE3326883,__EE3326948,__JC3326954(LEFT,RIGHT),TRANSFORM(E_Person_Offender(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3326967(E_Criminal_Offender(__in,__cfg_Local).Layout __EE3326705, E_Person_Offender(__in,__cfg_Local).Layout __EE3326961) := __EEQP(__EE3326961.Offender_,__EE3326705.UID);
  SHARED __EE3326995 := JOIN(__EE3326705,__EE3326961,__JC3326967(LEFT,RIGHT),TRANSFORM(E_Criminal_Offender(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3326997 := __EE3326995;
  EXPORT Res49 := __UNWRAP(__EE3326997);
  SHARED __EE3329360 := __ENH_Criminal_Offense;
  SHARED __EE3329349 := __E_Person_Offenses;
  SHARED __EE3329650 := __EE3329349(__NN(__EE3329349.Subject_) AND __NN(__EE3329349.Offense_));
  SHARED __EE3329343 := __ENH_Person;
  SHARED __EE3329770 := __EE3329343(__T(__OP2(__EE3329343.UID,=,__CN(1))));
  __JC3329776(E_Person_Offenses(__in,__cfg_Local).Layout __EE3329650, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3329770) := __EEQP(__EE3329770.UID,__EE3329650.Subject_);
  SHARED __EE3329783 := JOIN(__EE3329650,__EE3329770,__JC3329776(LEFT,RIGHT),TRANSFORM(E_Person_Offenses(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3329789(B_Criminal_Offense(__in,__cfg_Local).__ST90468_Layout __EE3329360, E_Person_Offenses(__in,__cfg_Local).Layout __EE3329783) := __EEQP(__EE3329783.Offense_,__EE3329360.UID);
  SHARED __EE3329872 := JOIN(__EE3329360,__EE3329783,__JC3329789(LEFT,RIGHT),TRANSFORM(B_Criminal_Offense(__in,__cfg_Local).__ST90468_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3329874 := __EE3329872;
  EXPORT Res50 := __UNWRAP(__EE3329874);
  SHARED __EE3332341 := __E_Phone;
  SHARED __EE3332331 := __E_Person_Phone;
  SHARED __EE3332634 := __EE3332331(__NN(__EE3332331.Subject_) AND __NN(__EE3332331.Phone_Number_));
  SHARED __EE3332325 := __ENH_Person;
  SHARED __EE3332753 := __EE3332325(__T(__OP2(__EE3332325.UID,=,__CN(1))));
  __JC3332759(E_Person_Phone(__in,__cfg_Local).Layout __EE3332634, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3332753) := __EEQP(__EE3332753.UID,__EE3332634.Subject_);
  SHARED __EE3332795 := JOIN(__EE3332634,__EE3332753,__JC3332759(LEFT,RIGHT),TRANSFORM(E_Person_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3332801(E_Phone(__in,__cfg_Local).Layout __EE3332341, E_Person_Phone(__in,__cfg_Local).Layout __EE3332795) := __EEQP(__EE3332795.Phone_Number_,__EE3332341.UID);
  SHARED __EE3332854 := JOIN(__EE3332341,__EE3332795,__JC3332801(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3332856 := __EE3332854;
  EXPORT Res51 := __UNWRAP(__EE3332856);
  SHARED __EE3335348 := __E_Property;
  SHARED __EE3335338 := __E_Person_Property;
  SHARED __EE3335577 := __EE3335338(__NN(__EE3335338.Subject_) AND __NN(__EE3335338.Prop_));
  SHARED __EE3335332 := __ENH_Person;
  SHARED __EE3335667 := __EE3335332(__T(__OP2(__EE3335332.UID,=,__CN(1))));
  __JC3335673(E_Person_Property(__in,__cfg_Local).Layout __EE3335577, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3335667) := __EEQP(__EE3335667.UID,__EE3335577.Subject_);
  SHARED __EE3335698 := JOIN(__EE3335577,__EE3335667,__JC3335673(LEFT,RIGHT),TRANSFORM(E_Person_Property(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3335704(E_Property(__in,__cfg_Local).Layout __EE3335348, E_Person_Property(__in,__cfg_Local).Layout __EE3335698) := __EEQP(__EE3335698.Prop_,__EE3335348.UID);
  SHARED __EE3335739 := JOIN(__EE3335348,__EE3335698,__JC3335704(LEFT,RIGHT),TRANSFORM(E_Property(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3335741 := __EE3335739;
  EXPORT Res52 := __UNWRAP(__EE3335741);
  SHARED __EE3338166 := __E_Property_Event;
  SHARED __EE3338156 := __E_Person_Property_Event;
  SHARED __EE3338969 := __EE3338156(__NN(__EE3338156.Subject_) AND __NN(__EE3338156.Event_));
  SHARED __EE3338150 := __ENH_Person;
  SHARED __EE3339347 := __EE3338150(__T(__OP2(__EE3338150.UID,=,__CN(1))));
  __JC3339353(E_Person_Property_Event(__in,__cfg_Local).Layout __EE3338969, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3339347) := __EEQP(__EE3339347.UID,__EE3338969.Subject_);
  SHARED __EE3339373 := JOIN(__EE3338969,__EE3339347,__JC3339353(LEFT,RIGHT),TRANSFORM(E_Person_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3339379(E_Property_Event(__in,__cfg_Local).Layout __EE3338166, E_Person_Property_Event(__in,__cfg_Local).Layout __EE3339373) := __EEQP(__EE3339373.Event_,__EE3338166.UID);
  SHARED __EE3339707 := JOIN(__EE3338166,__EE3339373,__JC3339379(LEFT,RIGHT),TRANSFORM(E_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3339709 := __EE3339707;
  EXPORT Res53 := __UNWRAP(__EE3339709);
  SHARED __EE3342706 := __E_Social_Security_Number;
  SHARED __EE3342696 := __E_Person_S_S_N;
  SHARED __EE3342860 := __EE3342696(__NN(__EE3342696.Subject_) AND __NN(__EE3342696.Social_));
  SHARED __EE3342690 := __ENH_Person;
  SHARED __EE3342914 := __EE3342690(__T(__OP2(__EE3342690.UID,=,__CN(1))));
  __JC3342920(E_Person_S_S_N(__in,__cfg_Local).Layout __EE3342860, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3342914) := __EEQP(__EE3342914.UID,__EE3342860.Subject_);
  SHARED __EE3342930 := JOIN(__EE3342860,__EE3342914,__JC3342920(LEFT,RIGHT),TRANSFORM(E_Person_S_S_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3342936(E_Social_Security_Number(__in,__cfg_Local).Layout __EE3342706, E_Person_S_S_N(__in,__cfg_Local).Layout __EE3342930) := __EEQP(__EE3342930.Social_,__EE3342706.UID);
  SHARED __EE3342950 := JOIN(__EE3342706,__EE3342930,__JC3342936(LEFT,RIGHT),TRANSFORM(E_Social_Security_Number(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3342952 := __EE3342950;
  EXPORT Res54 := __UNWRAP(__EE3342952);
  SHARED __EE3345296 := __ENH_U_C_C;
  SHARED __EE3345285 := __E_Person_U_C_C;
  SHARED __EE3345563 := __EE3345285(__NN(__EE3345285.Subject_) AND __NN(__EE3345285.Filing_));
  SHARED __EE3345279 := __ENH_Person;
  SHARED __EE3345672 := __EE3345279(__T(__OP2(__EE3345279.UID,=,__CN(1))));
  __JC3345678(E_Person_U_C_C(__in,__cfg_Local).Layout __EE3345563, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3345672) := __EEQP(__EE3345672.UID,__EE3345563.Subject_);
  SHARED __EE3345690 := JOIN(__EE3345563,__EE3345672,__JC3345678(LEFT,RIGHT),TRANSFORM(E_Person_U_C_C(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3345696(B_U_C_C(__in,__cfg_Local).__ST100659_Layout __EE3345296, E_Person_U_C_C(__in,__cfg_Local).Layout __EE3345690) := __EEQP(__EE3345690.Filing_,__EE3345296.UID);
  SHARED __EE3345763 := JOIN(__EE3345296,__EE3345690,__JC3345696(LEFT,RIGHT),TRANSFORM(B_U_C_C(__in,__cfg_Local).__ST100659_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3345765 := __EE3345763;
  EXPORT Res55 := __UNWRAP(__EE3345765);
  SHARED __EE3348218 := __E_Vehicle;
  SHARED __EE3348208 := __E_Person_Vehicle;
  SHARED __EE3348634 := __EE3348208(__NN(__EE3348208.Subject_) AND __NN(__EE3348208.Automobile_));
  SHARED __EE3348202 := __ENH_Person;
  SHARED __EE3348818 := __EE3348202(__T(__OP2(__EE3348202.UID,=,__CN(1))));
  __JC3348824(E_Person_Vehicle(__in,__cfg_Local).Layout __EE3348634, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3348818) := __EEQP(__EE3348818.UID,__EE3348634.Subject_);
  SHARED __EE3348867 := JOIN(__EE3348634,__EE3348818,__JC3348824(LEFT,RIGHT),TRANSFORM(E_Person_Vehicle(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3348873(E_Vehicle(__in,__cfg_Local).Layout __EE3348218, E_Person_Vehicle(__in,__cfg_Local).Layout __EE3348867) := __EEQP(__EE3348867.Automobile_,__EE3348218.UID);
  SHARED __EE3348984 := JOIN(__EE3348218,__EE3348867,__JC3348873(LEFT,RIGHT),TRANSFORM(E_Vehicle(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3348986 := __EE3348984;
  EXPORT Res56 := __UNWRAP(__EE3348986);
  SHARED __EE3351582 := __ENH_Professional_License;
  SHARED __EE3351571 := __E_Professional_License_Person;
  SHARED __EE3351795 := __EE3351571(__NN(__EE3351571.Subject_) AND __NN(__EE3351571.Prof_Lic_));
  SHARED __EE3351565 := __ENH_Person;
  SHARED __EE3351877 := __EE3351565(__T(__OP2(__EE3351565.UID,=,__CN(1))));
  __JC3351883(E_Professional_License_Person(__in,__cfg_Local).Layout __EE3351795, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3351877) := __EEQP(__EE3351877.UID,__EE3351795.Subject_);
  SHARED __EE3351890 := JOIN(__EE3351795,__EE3351877,__JC3351883(LEFT,RIGHT),TRANSFORM(E_Professional_License_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3351896(B_Professional_License_4(__in,__cfg_Local).__ST140731_Layout __EE3351582, E_Professional_License_Person(__in,__cfg_Local).Layout __EE3351890) := __EEQP(__EE3351890.Prof_Lic_,__EE3351582.UID);
  SHARED __EE3351941 := JOIN(__EE3351582,__EE3351890,__JC3351896(LEFT,RIGHT),TRANSFORM(B_Professional_License_4(__in,__cfg_Local).__ST140731_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3351943 := __EE3351941;
  EXPORT Res57 := __UNWRAP(__EE3351943);
  SHARED __EE3354335 := __ENH_Business_Prox;
  SHARED __EE3354324 := __E_Prox_Person;
  SHARED __EE3355038 := __EE3354324(__NN(__EE3354324.Contact_) AND __NN(__EE3354324.Business_Location_));
  SHARED __EE3354318 := __ENH_Person;
  SHARED __EE3355354 := __EE3354318(__T(__OP2(__EE3354318.UID,=,__CN(1))));
  __JC3355360(E_Prox_Person(__in,__cfg_Local).Layout __EE3355038, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3355354) := __EEQP(__EE3355354.UID,__EE3355038.Contact_);
  SHARED __EE3355388 := JOIN(__EE3355038,__EE3355354,__JC3355360(LEFT,RIGHT),TRANSFORM(E_Prox_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3355394(B_Business_Prox(__in,__cfg_Local).__ST75468_Layout __EE3354335, E_Prox_Person(__in,__cfg_Local).Layout __EE3355388) := __EEQP(__EE3355388.Business_Location_,__EE3354335.UID);
  SHARED __EE3355652 := JOIN(__EE3354335,__EE3355388,__JC3355394(LEFT,RIGHT),TRANSFORM(B_Business_Prox(__in,__cfg_Local).__ST75468_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3355654 := __EE3355652;
  EXPORT Res58 := __UNWRAP(__EE3355654);
  SHARED __EE3358521 := __ENH_Business_Sele;
  SHARED __EE3358510 := __E_Sele_Person;
  SHARED __EE3361035 := __EE3358510(__NN(__EE3358510.Contact_) AND __NN(__EE3358510.Legal_));
  SHARED __EE3358504 := __ENH_Person;
  SHARED __EE3362231 := __EE3358504(__T(__OP2(__EE3358504.UID,=,__CN(1))));
  __JC3362237(E_Sele_Person(__in,__cfg_Local).Layout __EE3361035, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3362231) := __EEQP(__EE3362231.UID,__EE3361035.Contact_);
  SHARED __EE3362265 := JOIN(__EE3361035,__EE3362231,__JC3362237(LEFT,RIGHT),TRANSFORM(E_Sele_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3362271(B_Business_Sele(__in,__cfg_Local).__ST89332_Layout __EE3358521, E_Sele_Person(__in,__cfg_Local).Layout __EE3362265) := __EEQP(__EE3362265.Legal_,__EE3358521.UID);
  SHARED __EE3363409 := JOIN(__EE3358521,__EE3362265,__JC3362271(LEFT,RIGHT),TRANSFORM(B_Business_Sele(__in,__cfg_Local).__ST89332_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3363411 := __EE3363409;
  EXPORT Res59 := __UNWRAP(__EE3363411);
  SHARED __EE3376891 := __E_Utility;
  SHARED __EE3376881 := __E_Utility_Person;
  SHARED __EE3377032 := __EE3376881(__NN(__EE3376881.Subject_) AND __NN(__EE3376881.Util_));
  SHARED __EE3376875 := __ENH_Person;
  SHARED __EE3377080 := __EE3376875(__T(__OP2(__EE3376875.UID,=,__CN(1))));
  __JC3377086(E_Utility_Person(__in,__cfg_Local).Layout __EE3377032, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3377080) := __EEQP(__EE3377080.UID,__EE3377032.Subject_);
  SHARED __EE3377093 := JOIN(__EE3377032,__EE3377080,__JC3377086(LEFT,RIGHT),TRANSFORM(E_Utility_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3377099(E_Utility(__in,__cfg_Local).Layout __EE3376891, E_Utility_Person(__in,__cfg_Local).Layout __EE3377093) := __EEQP(__EE3377093.Util_,__EE3376891.UID);
  SHARED __EE3377110 := JOIN(__EE3376891,__EE3377093,__JC3377099(LEFT,RIGHT),TRANSFORM(E_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3377112 := __EE3377110;
  EXPORT Res60 := __UNWRAP(__EE3377112);
  SHARED __EE3379440 := __E_Watercraft;
  SHARED __EE3379430 := __E_Watercraft_Owner;
  SHARED __EE3379582 := __EE3379430(__NN(__EE3379430.Owner_) AND __NN(__EE3379430.W_Craft_));
  SHARED __EE3379424 := __ENH_Person;
  SHARED __EE3379630 := __EE3379424(__T(__OP2(__EE3379424.UID,=,__CN(1))));
  __JC3379636(E_Watercraft_Owner(__in,__cfg_Local).Layout __EE3379582, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3379630) := __EEQP(__EE3379630.UID,__EE3379582.Owner_);
  SHARED __EE3379643 := JOIN(__EE3379582,__EE3379630,__JC3379636(LEFT,RIGHT),TRANSFORM(E_Watercraft_Owner(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3379649(E_Watercraft(__in,__cfg_Local).Layout __EE3379440, E_Watercraft_Owner(__in,__cfg_Local).Layout __EE3379643) := __EEQP(__EE3379643.W_Craft_,__EE3379440.UID);
  SHARED __EE3379660 := JOIN(__EE3379440,__EE3379643,__JC3379649(LEFT,RIGHT),TRANSFORM(E_Watercraft(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3379662 := __EE3379660;
  EXPORT Res61 := __UNWRAP(__EE3379662);
  SHARED __EE3381985 := __E_Zip_Code;
  SHARED __EE3381975 := __E_Zip_Code_Person;
  SHARED __EE3382128 := __EE3381975(__NN(__EE3381975.Subject_) AND __NN(__EE3381975.Zip_));
  SHARED __EE3381969 := __ENH_Person;
  SHARED __EE3382177 := __EE3381969(__T(__OP2(__EE3381969.UID,=,__CN(1))));
  __JC3382183(E_Zip_Code_Person(__in,__cfg_Local).Layout __EE3382128, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3382177) := __EEQP(__EE3382177.UID,__EE3382128.Subject_);
  SHARED __EE3382191 := JOIN(__EE3382128,__EE3382177,__JC3382183(LEFT,RIGHT),TRANSFORM(E_Zip_Code_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3382197(E_Zip_Code(__in,__cfg_Local).Layout __EE3381985, E_Zip_Code_Person(__in,__cfg_Local).Layout __EE3382191) := __EEQP(__EE3382191.Zip_,__EE3381985.UID);
  SHARED __EE3382208 := JOIN(__EE3381985,__EE3382191,__JC3382197(LEFT,RIGHT),TRANSFORM(E_Zip_Code(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3382210 := __EE3382208;
  EXPORT Res62 := __UNWRAP(__EE3382210);
  SHARED __EE3384531 := __E_Person_Email_Phone_Address;
  SHARED __EE3384616 := __EE3384531(__NN(__EE3384531.Subject_));
  SHARED __EE3384525 := __ENH_Person;
  SHARED __EE3384621 := __EE3384525(__T(__OP2(__EE3384525.UID,=,__CN(1))));
  __JC3384627(E_Person_Email_Phone_Address(__in,__cfg_Local).Layout __EE3384616, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3384621) := __EEQP(__EE3384621.UID,__EE3384616.Subject_);
  SHARED __EE3384643 := JOIN(__EE3384616,__EE3384621,__JC3384627(LEFT,RIGHT),TRANSFORM(E_Person_Email_Phone_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3384645 := __EE3384643;
  EXPORT Res63 := __UNWRAP(__EE3384645);
  SHARED __EE3385957 := __E_Address;
  SHARED __EE3385947 := __E_Address_Phone;
  SHARED __EE3386382 := __EE3385947(__NN(__EE3385947.Phone_Number_) AND __NN(__EE3385947.Location_));
  SHARED __EE3385941 := __E_Phone;
  SHARED __EE3386560 := __EE3385941(__T(__OP2(__EE3385941.UID,=,__CN(1))));
  __JC3386566(E_Address_Phone(__in,__cfg_Local).Layout __EE3386382, E_Phone(__in,__cfg_Local).Layout __EE3386560) := __EEQP(__EE3386560.UID,__EE3386382.Phone_Number_);
  SHARED __EE3386594 := JOIN(__EE3386382,__EE3386560,__JC3386566(LEFT,RIGHT),TRANSFORM(E_Address_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3386600(E_Address(__in,__cfg_Local).Layout __EE3385957, E_Address_Phone(__in,__cfg_Local).Layout __EE3386594) := __EEQP(__EE3386594.Location_,__EE3385957.UID);
  SHARED __EE3386720 := JOIN(__EE3385957,__EE3386594,__JC3386600(LEFT,RIGHT),TRANSFORM(E_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3386722 := __EE3386720;
  EXPORT Res64 := __UNWRAP(__EE3386722);
  SHARED __EE3387081 := __ENH_Person;
  SHARED __EE3387070 := __E_Person_Phone;
  SHARED __EE3388701 := __EE3387070(__NN(__EE3387070.Phone_Number_) AND __NN(__EE3387070.Subject_));
  SHARED __EE3387064 := __E_Phone;
  SHARED __EE3389461 := __EE3387064(__T(__OP2(__EE3387064.UID,=,__CN(1))));
  __JC3389467(E_Person_Phone(__in,__cfg_Local).Layout __EE3388701, E_Phone(__in,__cfg_Local).Layout __EE3389461) := __EEQP(__EE3389461.UID,__EE3388701.Phone_Number_);
  SHARED __EE3389503 := JOIN(__EE3388701,__EE3389461,__JC3389467(LEFT,RIGHT),TRANSFORM(E_Person_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3389509(B_Person(__in,__cfg_Local).__ST99755_Layout __EE3387081, E_Person_Phone(__in,__cfg_Local).Layout __EE3389503) := __EEQP(__EE3389503.Subject_,__EE3387081.UID);
  SHARED __EE3390203 := JOIN(__EE3387081,__EE3389503,__JC3389509(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST99755_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3390205 := __EE3390203;
  EXPORT Res65 := __UNWRAP(__EE3390205);
  SHARED __EE3391951 := __E_Inquiry;
  SHARED __EE3391941 := __E_Phone_Inquiry;
  SHARED __EE3392112 := __EE3391941(__NN(__EE3391941.Phone_Number_) AND __NN(__EE3391941.Inquiry_));
  SHARED __EE3391935 := __E_Phone;
  SHARED __EE3392170 := __EE3391935(__T(__OP2(__EE3391935.UID,=,__CN(1))));
  __JC3392176(E_Phone_Inquiry(__in,__cfg_Local).Layout __EE3392112, E_Phone(__in,__cfg_Local).Layout __EE3392170) := __EEQP(__EE3392170.UID,__EE3392112.Phone_Number_);
  SHARED __EE3392183 := JOIN(__EE3392112,__EE3392170,__JC3392176(LEFT,RIGHT),TRANSFORM(E_Phone_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3392189(E_Inquiry(__in,__cfg_Local).Layout __EE3391951, E_Phone_Inquiry(__in,__cfg_Local).Layout __EE3392183) := __EEQP(__EE3392183.Inquiry_,__EE3391951.UID);
  SHARED __EE3392210 := JOIN(__EE3391951,__EE3392183,__JC3392189(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3392212 := __EE3392210;
  EXPORT Res66 := __UNWRAP(__EE3392212);
  SHARED __EE3392325 := __E_T_I_N_Phone_Number;
  SHARED __EE3392479 := __EE3392325(__NN(__EE3392325.Tax_I_D_) AND __NN(__EE3392325.Phone_Number_));
  SHARED __EE3392319 := __E_Phone;
  SHARED __EE3392521 := __EE3392319(__T(__OP2(__EE3392319.UID,=,__CN(1))));
  __JC3392527(E_T_I_N_Phone_Number(__in,__cfg_Local).Layout __EE3392479, E_Phone(__in,__cfg_Local).Layout __EE3392521) := __EEQP(__EE3392521.UID,__EE3392479.Phone_Number_);
  SHARED __EE3392537 := JOIN(__EE3392479,__EE3392521,__JC3392527(LEFT,RIGHT),TRANSFORM(E_T_I_N_Phone_Number(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3392547 := PROJECT(TABLE(PROJECT(__EE3392537,TRANSFORM(E_T_I_N(__in,__cfg_Local).Layout,SELF.UID := LEFT.Tax_I_D_,SELF := LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),UID},UID,MERGE),E_T_I_N(__in,__cfg_Local).Layout);
  EXPORT Res67 := __UNWRAP(__EE3392547);
  SHARED __EE3392609 := __ENH_Second_Degree_Associations;
  SHARED __EE3392685 := __EE3392609(__NN(__EE3392609.First_Degree_Association_));
  SHARED __EE3392602 := __ENH_Person;
  SHARED __EE3392690 := __EE3392602(__T(__OP2(__EE3392602.UID,=,__CN(1))));
  __JC3392696(E_Second_Degree_Associations(__in,__cfg_Local).Layout __EE3392685, B_Person(__in,__cfg_Local).__ST99755_Layout __EE3392690) := __EEQP(__EE3392690.UID,__EE3392685.First_Degree_Association_);
  SHARED __EE3392708 := JOIN(__EE3392685,__EE3392690,__JC3392696(LEFT,RIGHT),TRANSFORM(E_Second_Degree_Associations(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3392710 := __EE3392708;
  EXPORT Res68 := __UNWRAP(__EE3392710);
  SHARED __EE3394043 := __ENH_Person;
  SHARED __EE3394032 := __E_Person_Property_Event;
  SHARED __EE3396324 := __EE3394032(__NN(__EE3394032.Event_) AND __NN(__EE3394032.Subject_));
  SHARED __EE3394023 := __E_Property_Event;
  SHARED __EE3396301 := __EE3394023(__NN(__EE3394023.Prop_));
  SHARED __EE3394017 := __E_Property;
  SHARED __EE3397068 := __EE3394017(__T(__OP2(__EE3394017.UID,=,__CN(1))));
  __JC3397074(E_Property_Event(__in,__cfg_Local).Layout __EE3396301, E_Property(__in,__cfg_Local).Layout __EE3397068) := __EEQP(__EE3397068.UID,__EE3396301.Prop_);
  SHARED __EE3397402 := JOIN(__EE3396301,__EE3397068,__JC3397074(LEFT,RIGHT),TRANSFORM(E_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3397408(E_Person_Property_Event(__in,__cfg_Local).Layout __EE3396324, E_Property_Event(__in,__cfg_Local).Layout __EE3397402) := __EEQP(__EE3397402.UID,__EE3396324.Event_);
  SHARED __EE3397428 := JOIN(__EE3396324,__EE3397402,__JC3397408(LEFT,RIGHT),TRANSFORM(E_Person_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3397434(B_Person(__in,__cfg_Local).__ST99755_Layout __EE3394043, E_Person_Property_Event(__in,__cfg_Local).Layout __EE3397428) := __EEQP(__EE3397428.Subject_,__EE3394043.UID);
  SHARED __EE3398128 := JOIN(__EE3394043,__EE3397428,__JC3397434(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST99755_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3398130 := __EE3398128;
  EXPORT Res69 := __UNWRAP(__EE3398130);
  SHARED __EE3400540 := __ENH_Business_Sele;
  SHARED __EE3400529 := __E_Sele_Property_Event;
  SHARED __EE3403739 := __EE3400529(__NN(__EE3400529.Event_) AND __NN(__EE3400529.Legal_));
  SHARED __EE3400520 := __E_Property_Event;
  SHARED __EE3403716 := __EE3400520(__NN(__EE3400520.Prop_));
  SHARED __EE3400514 := __E_Property;
  SHARED __EE3404930 := __EE3400514(__T(__OP2(__EE3400514.UID,=,__CN(1))));
  __JC3404936(E_Property_Event(__in,__cfg_Local).Layout __EE3403716, E_Property(__in,__cfg_Local).Layout __EE3404930) := __EEQP(__EE3404930.UID,__EE3403716.Prop_);
  SHARED __EE3405264 := JOIN(__EE3403716,__EE3404930,__JC3404936(LEFT,RIGHT),TRANSFORM(E_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3405270(E_Sele_Property_Event(__in,__cfg_Local).Layout __EE3403739, E_Property_Event(__in,__cfg_Local).Layout __EE3405264) := __EEQP(__EE3405264.UID,__EE3403739.Event_);
  SHARED __EE3405293 := JOIN(__EE3403739,__EE3405264,__JC3405270(LEFT,RIGHT),TRANSFORM(E_Sele_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3405299(B_Business_Sele(__in,__cfg_Local).__ST89332_Layout __EE3400540, E_Sele_Property_Event(__in,__cfg_Local).Layout __EE3405293) := __EEQP(__EE3405293.Legal_,__EE3400540.UID);
  SHARED __EE3406437 := JOIN(__EE3400540,__EE3405293,__JC3405299(LEFT,RIGHT),TRANSFORM(B_Business_Sele(__in,__cfg_Local).__ST89332_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3406439 := __EE3406437;
  EXPORT Res70 := __UNWRAP(__EE3406439);
  SHARED __EE3418275 := __ENH_Person;
  SHARED __EE3418264 := __E_Person_S_S_N;
  SHARED __EE3419840 := __EE3418264(__NN(__EE3418264.Social_) AND __NN(__EE3418264.Subject_));
  SHARED __EE3418258 := __E_Social_Security_Number;
  SHARED __EE3420574 := __EE3418258(__T(__OP2(__EE3418258.UID,=,__CN(1))));
  __JC3420580(E_Person_S_S_N(__in,__cfg_Local).Layout __EE3419840, E_Social_Security_Number(__in,__cfg_Local).Layout __EE3420574) := __EEQP(__EE3420574.UID,__EE3419840.Social_);
  SHARED __EE3420590 := JOIN(__EE3419840,__EE3420574,__JC3420580(LEFT,RIGHT),TRANSFORM(E_Person_S_S_N(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3420596(B_Person(__in,__cfg_Local).__ST99755_Layout __EE3418275, E_Person_S_S_N(__in,__cfg_Local).Layout __EE3420590) := __EEQP(__EE3420590.Subject_,__EE3418275.UID);
  SHARED __EE3421290 := JOIN(__EE3418275,__EE3420590,__JC3420596(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST99755_Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3421292 := __EE3421290;
  EXPORT Res71 := __UNWRAP(__EE3421292);
  SHARED __EE3422986 := __E_Address;
  SHARED __EE3422976 := __E_S_S_N_Address;
  SHARED __EE3423383 := __EE3422976(__NN(__EE3422976.Social_) AND __NN(__EE3422976.Location_));
  SHARED __EE3422970 := __E_Social_Security_Number;
  SHARED __EE3423548 := __EE3422970(__T(__OP2(__EE3422970.UID,=,__CN(1))));
  __JC3423554(E_S_S_N_Address(__in,__cfg_Local).Layout __EE3423383, E_Social_Security_Number(__in,__cfg_Local).Layout __EE3423548) := __EEQP(__EE3423548.UID,__EE3423383.Social_);
  SHARED __EE3423569 := JOIN(__EE3423383,__EE3423548,__JC3423554(LEFT,RIGHT),TRANSFORM(E_S_S_N_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3423575(E_Address(__in,__cfg_Local).Layout __EE3422986, E_S_S_N_Address(__in,__cfg_Local).Layout __EE3423569) := __EEQP(__EE3423569.Location_,__EE3422986.UID);
  SHARED __EE3423695 := JOIN(__EE3422986,__EE3423569,__JC3423575(LEFT,RIGHT),TRANSFORM(E_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3423697 := __EE3423695;
  EXPORT Res72 := __UNWRAP(__EE3423697);
  SHARED __EE3424042 := __E_Inquiry;
  SHARED __EE3424032 := __E_S_S_N_Inquiry;
  SHARED __EE3424203 := __EE3424032(__NN(__EE3424032.S_S_N_) AND __NN(__EE3424032.Inquiry_));
  SHARED __EE3424026 := __E_Social_Security_Number;
  SHARED __EE3424261 := __EE3424026(__T(__OP2(__EE3424026.UID,=,__CN(1))));
  __JC3424267(E_S_S_N_Inquiry(__in,__cfg_Local).Layout __EE3424203, E_Social_Security_Number(__in,__cfg_Local).Layout __EE3424261) := __EEQP(__EE3424261.UID,__EE3424203.S_S_N_);
  SHARED __EE3424274 := JOIN(__EE3424203,__EE3424261,__JC3424267(LEFT,RIGHT),TRANSFORM(E_S_S_N_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3424280(E_Inquiry(__in,__cfg_Local).Layout __EE3424042, E_S_S_N_Inquiry(__in,__cfg_Local).Layout __EE3424274) := __EEQP(__EE3424274.Inquiry_,__EE3424042.UID);
  SHARED __EE3424301 := JOIN(__EE3424042,__EE3424274,__JC3424280(LEFT,RIGHT),TRANSFORM(E_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3424303 := __EE3424301;
  EXPORT Res73 := __UNWRAP(__EE3424303);
  SHARED __EE3424426 := __E_Address;
  SHARED __EE3424416 := __E_T_I_N_Address;
  SHARED __EE3424821 := __EE3424416(__NN(__EE3424416.Tax_I_D_) AND __NN(__EE3424416.Location_));
  SHARED __EE3424410 := __E_T_I_N;
  SHARED __EE3424985 := __EE3424410(__T(__OP2(__EE3424410.UID,=,__CN(1))));
  __JC3424991(E_T_I_N_Address(__in,__cfg_Local).Layout __EE3424821, E_T_I_N(__in,__cfg_Local).Layout __EE3424985) := __EEQP(__EE3424985.UID,__EE3424821.Tax_I_D_);
  SHARED __EE3425005 := JOIN(__EE3424821,__EE3424985,__JC3424991(LEFT,RIGHT),TRANSFORM(E_T_I_N_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3425011(E_Address(__in,__cfg_Local).Layout __EE3424426, E_T_I_N_Address(__in,__cfg_Local).Layout __EE3425005) := __EEQP(__EE3425005.Location_,__EE3424426.UID);
  SHARED __EE3425131 := JOIN(__EE3424426,__EE3425005,__JC3425011(LEFT,RIGHT),TRANSFORM(E_Address(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3425133 := __EE3425131;
  EXPORT Res74 := __UNWRAP(__EE3425133);
  SHARED __EE3425463 := __E_Phone;
  SHARED __EE3425453 := __E_T_I_N_Phone_Number;
  SHARED __EE3425702 := __EE3425453(__NN(__EE3425453.Tax_I_D_) AND __NN(__EE3425453.Phone_Number_));
  SHARED __EE3425447 := __E_T_I_N;
  SHARED __EE3425795 := __EE3425447(__T(__OP2(__EE3425447.UID,=,__CN(1))));
  __JC3425801(E_T_I_N_Phone_Number(__in,__cfg_Local).Layout __EE3425702, E_T_I_N(__in,__cfg_Local).Layout __EE3425795) := __EEQP(__EE3425795.UID,__EE3425702.Tax_I_D_);
  SHARED __EE3425811 := JOIN(__EE3425702,__EE3425795,__JC3425801(LEFT,RIGHT),TRANSFORM(E_T_I_N_Phone_Number(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3425817(E_Phone(__in,__cfg_Local).Layout __EE3425463, E_T_I_N_Phone_Number(__in,__cfg_Local).Layout __EE3425811) := __EEQP(__EE3425811.Phone_Number_,__EE3425463.UID);
  SHARED __EE3425870 := JOIN(__EE3425463,__EE3425811,__JC3425817(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __EE3425872 := __EE3425870;
  EXPORT Res75 := __UNWRAP(__EE3425872);
  SHARED __EE3426061 := __ENH_Person;
  SHARED __EE3426050 := __E_Zip_Code_Person;
  SHARED __EE3427622 := __EE3426050(__NN(__EE3426050.Zip_) AND __NN(__EE3426050.Subject_));
  SHARED __EE3426044 := __E_Zip_Code;
  SHARED __EE3428354 := __EE3426044(__T(__OP2(__EE3426044.UID,=,__CN(1))));
  __JC3428360(E_Zip_Code_Person(__in,__cfg_Local).Layout __EE3427622, E_Zip_Code(__in,__cfg_Local).Layout __EE3428354) := __EEQP(__EE3428354.UID,__EE3427622.Zip_);
  SHARED __EE3428368 := JOIN(__EE3427622,__EE3428354,__JC3428360(LEFT,RIGHT),TRANSFORM(E_Zip_Code_Person(__in,__cfg_Local).Layout,SELF:=LEFT),SMART,KEEP(1));
  __JC3428374(B_Person(__in,__cfg_Local).__ST99755_Layout __EE3426061, E_Zip_Code_Person(__in,__cfg_Local).Layout __EE3428368) := __EEQP(__EE3428368.Subject_,__EE3426061.UID);
  SHARED __EE3429068 := JOIN(__EE3426061,__EE3428368,__JC3428374(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST99755_Layout,SELF:=LEFT),SMART,KEEP(1));
  EXPORT Res76 := __UNWRAP(__EE3429068);
END;
